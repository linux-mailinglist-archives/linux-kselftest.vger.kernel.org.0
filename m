Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767A42753A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIWItf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 04:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIWIte (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 04:49:34 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2694B206BE;
        Wed, 23 Sep 2020 08:49:32 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:49:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH 6/6] kselftest/arm64: Check mte tagged user address in
 kernel
Message-ID: <20200923084930.GB13434@gaia>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
 <20200901092719.9918-7-amit.kachhap@arm.com>
 <20200922104123.GF15643@gaia>
 <d390f84d-8cd9-8646-3dab-19f62512ee21@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d390f84d-8cd9-8646-3dab-19f62512ee21@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 23, 2020 at 12:36:59PM +0530, Amit Kachhap wrote:
> On 9/22/20 4:11 PM, Catalin Marinas wrote:
> > On Tue, Sep 01, 2020 at 02:57:19PM +0530, Amit Daniel Kachhap wrote:
> > > +static int check_usermem_access_fault(int mem_type, int mode, int mapping)
> > > +{
> > > +	int fd, ret, i, err;
> > > +	char val = 'A';
> > > +	size_t len, read_len;
> > > +	void *ptr, *ptr_next;
> > > +	bool fault;
> > > +
> > > +	len = 2 * page_sz;
> > > +	err = KSFT_FAIL;
> > > +	/*
> > > +	 * Accessing user memory in kernel with invalid tag should fault in sync
> > > +	 * mode but may not fault in async mode as per the implemented MTE
> > > +	 * support in Arm64 kernel.
> > > +	 */
> > > +	if (mode == MTE_ASYNC_ERR)
> > > +		fault = false;
> > > +	else
> > > +		fault = true;
> > > +	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
> > > +	fd = create_temp_file();
> > > +	if (fd == -1)
> > > +		return KSFT_FAIL;
> > > +	for (i = 0; i < len; i++)
> > > +		write(fd, &val, sizeof(val));
> > > +	lseek(fd, 0, 0);
> > > +	ptr = mte_allocate_memory(len, mem_type, mapping, true);
> > > +	if (check_allocated_memory(ptr, len, mem_type, true) != KSFT_PASS) {
> > > +		close(fd);
> > > +		return KSFT_FAIL;
> > > +	}
> > > +	mte_initialize_current_context(mode, (uintptr_t)ptr, len);
> > > +	/* Copy from file into buffer with valid tag */
> > > +	read_len = read(fd, ptr, len);
> > > +	ret = errno;
> > 
> > My reading of the man page is that errno is set only if read() returns
> > -1.
> 
> Yes. The checks should be optimized here.

It's not about optimisation but correctness. The errno man page states
that errno is only relevant if the syscall returns -1. So it may
potentially hold a stale value (e.g. EFAULT) in case of read() success
but the check below fails anyway:

> > > +	mte_wait_after_trig();
> > > +	if ((cur_mte_cxt.fault_valid == true) || ret == EFAULT || read_len < len)
> > > +		goto usermem_acc_err;

-- 
Catalin
