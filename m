Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5418727521D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIWHHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 03:07:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIWHHL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 03:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B6F113E;
        Wed, 23 Sep 2020 00:07:10 -0700 (PDT)
Received: from [10.57.14.157] (unknown [10.57.14.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265D63F70D;
        Wed, 23 Sep 2020 00:07:07 -0700 (PDT)
Subject: Re: [PATCH 6/6] kselftest/arm64: Check mte tagged user address in
 kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
 <20200901092719.9918-7-amit.kachhap@arm.com> <20200922104123.GF15643@gaia>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <d390f84d-8cd9-8646-3dab-19f62512ee21@arm.com>
Date:   Wed, 23 Sep 2020 12:36:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200922104123.GF15643@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/22/20 4:11 PM, Catalin Marinas wrote:
> On Tue, Sep 01, 2020 at 02:57:19PM +0530, Amit Daniel Kachhap wrote:
>> Add a testcase to check that user address with valid/invalid
>> mte tag works in kernel mode. This test verifies the kernel API's
>> __arch_copy_from_user/__arch_copy_to_user works by considering
>> if the user pointer has valid/invalid allocation tags.
>>
>> In MTE sync mode a SIGSEV fault is generated if a user memory
>> with invalid tag is accessed in kernel. In async mode no such
>> fault occurs.
> 
> We don't generate a SIGSEGV for faults in the uaccess routines. The
> kernel simply returns less copied bytes than what was requested or -1
> and setting errno.

ok. I will update in the next iteration.
> 
> BTW, Qemu has a bug and it reports the wrong exception class (lower
> DABT) for a tag check fault while in the uaccess routines, leading to
> kernel panic (bad mode in synchronous abort handler).

Yes I am also seeing this.
> 
>> +static int check_usermem_access_fault(int mem_type, int mode, int mapping)
>> +{
>> +	int fd, ret, i, err;
>> +	char val = 'A';
>> +	size_t len, read_len;
>> +	void *ptr, *ptr_next;
>> +	bool fault;
>> +
>> +	len = 2 * page_sz;
>> +	err = KSFT_FAIL;
>> +	/*
>> +	 * Accessing user memory in kernel with invalid tag should fault in sync
>> +	 * mode but may not fault in async mode as per the implemented MTE
>> +	 * support in Arm64 kernel.
>> +	 */
>> +	if (mode == MTE_ASYNC_ERR)
>> +		fault = false;
>> +	else
>> +		fault = true;
>> +	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
>> +	fd = create_temp_file();
>> +	if (fd == -1)
>> +		return KSFT_FAIL;
>> +	for (i = 0; i < len; i++)
>> +		write(fd, &val, sizeof(val));
>> +	lseek(fd, 0, 0);
>> +	ptr = mte_allocate_memory(len, mem_type, mapping, true);
>> +	if (check_allocated_memory(ptr, len, mem_type, true) != KSFT_PASS) {
>> +		close(fd);
>> +		return KSFT_FAIL;
>> +	}
>> +	mte_initialize_current_context(mode, (uintptr_t)ptr, len);
>> +	/* Copy from file into buffer with valid tag */
>> +	read_len = read(fd, ptr, len);
>> +	ret = errno;
> 
> My reading of the man page is that errno is set only if read() returns
> -1.

Yes. The checks should be optimized here.
> 
>> +	mte_wait_after_trig();
>> +	if ((cur_mte_cxt.fault_valid == true) || ret == EFAULT || read_len < len)
>> +		goto usermem_acc_err;
>> +	/* Verify same pattern is read */
>> +	for (i = 0; i < len; i++)
>> +		if (*(char *)(ptr + i) != val)
>> +			break;
>> +	if (i < len)
>> +		goto usermem_acc_err;
>> +
>> +	/* Tag the next half of memory with different value */
>> +	ptr_next = (void *)((unsigned long)ptr + page_sz);
>> +	ptr_next = mte_insert_tags(ptr_next, page_sz);
>> +	if (!ptr_next)
>> +		goto usermem_acc_err;
>> +	lseek(fd, 0, 0);
>> +	/* Copy from file into buffer with invalid tag */
>> +	read_len = read(fd, ptr, len);
>> +	ret = errno;
>> +	mte_wait_after_trig();
>> +	if ((fault == true) &&
> 
> Nitpick: just use "if (fault &&), it's a bool already.

ok.
> 
>> +	    (cur_mte_cxt.fault_valid == true || ret == EFAULT || read_len < len)) {
>> +		err = KSFT_PASS;
>> +	} else if ((fault == false) &&
>> +		   (cur_mte_cxt.fault_valid == false && read_len == len)) {
> 
> Same here, !fault, !cur_mte_cxt.fault_valid.

ok.
> 
