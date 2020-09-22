Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC6273FC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIVKl3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 06:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIVKl2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 06:41:28 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08CC52073A;
        Tue, 22 Sep 2020 10:41:26 +0000 (UTC)
Date:   Tue, 22 Sep 2020 11:41:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH 6/6] kselftest/arm64: Check mte tagged user address in
 kernel
Message-ID: <20200922104123.GF15643@gaia>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
 <20200901092719.9918-7-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901092719.9918-7-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 02:57:19PM +0530, Amit Daniel Kachhap wrote:
> Add a testcase to check that user address with valid/invalid
> mte tag works in kernel mode. This test verifies the kernel API's
> __arch_copy_from_user/__arch_copy_to_user works by considering
> if the user pointer has valid/invalid allocation tags.
> 
> In MTE sync mode a SIGSEV fault is generated if a user memory
> with invalid tag is accessed in kernel. In async mode no such
> fault occurs.

We don't generate a SIGSEGV for faults in the uaccess routines. The
kernel simply returns less copied bytes than what was requested or -1
and setting errno.

BTW, Qemu has a bug and it reports the wrong exception class (lower
DABT) for a tag check fault while in the uaccess routines, leading to
kernel panic (bad mode in synchronous abort handler).

> +static int check_usermem_access_fault(int mem_type, int mode, int mapping)
> +{
> +	int fd, ret, i, err;
> +	char val = 'A';
> +	size_t len, read_len;
> +	void *ptr, *ptr_next;
> +	bool fault;
> +
> +	len = 2 * page_sz;
> +	err = KSFT_FAIL;
> +	/*
> +	 * Accessing user memory in kernel with invalid tag should fault in sync
> +	 * mode but may not fault in async mode as per the implemented MTE
> +	 * support in Arm64 kernel.
> +	 */
> +	if (mode == MTE_ASYNC_ERR)
> +		fault = false;
> +	else
> +		fault = true;
> +	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
> +	fd = create_temp_file();
> +	if (fd == -1)
> +		return KSFT_FAIL;
> +	for (i = 0; i < len; i++)
> +		write(fd, &val, sizeof(val));
> +	lseek(fd, 0, 0);
> +	ptr = mte_allocate_memory(len, mem_type, mapping, true);
> +	if (check_allocated_memory(ptr, len, mem_type, true) != KSFT_PASS) {
> +		close(fd);
> +		return KSFT_FAIL;
> +	}
> +	mte_initialize_current_context(mode, (uintptr_t)ptr, len);
> +	/* Copy from file into buffer with valid tag */
> +	read_len = read(fd, ptr, len);
> +	ret = errno;

My reading of the man page is that errno is set only if read() returns
-1.

> +	mte_wait_after_trig();
> +	if ((cur_mte_cxt.fault_valid == true) || ret == EFAULT || read_len < len)
> +		goto usermem_acc_err;
> +	/* Verify same pattern is read */
> +	for (i = 0; i < len; i++)
> +		if (*(char *)(ptr + i) != val)
> +			break;
> +	if (i < len)
> +		goto usermem_acc_err;
> +
> +	/* Tag the next half of memory with different value */
> +	ptr_next = (void *)((unsigned long)ptr + page_sz);
> +	ptr_next = mte_insert_tags(ptr_next, page_sz);
> +	if (!ptr_next)
> +		goto usermem_acc_err;
> +	lseek(fd, 0, 0);
> +	/* Copy from file into buffer with invalid tag */
> +	read_len = read(fd, ptr, len);
> +	ret = errno;
> +	mte_wait_after_trig();
> +	if ((fault == true) &&

Nitpick: just use "if (fault &&), it's a bool already.

> +	    (cur_mte_cxt.fault_valid == true || ret == EFAULT || read_len < len)) {
> +		err = KSFT_PASS;
> +	} else if ((fault == false) &&
> +		   (cur_mte_cxt.fault_valid == false && read_len == len)) {

Same here, !fault, !cur_mte_cxt.fault_valid.

-- 
Catalin
