Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18D937182D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhECPl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 11:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhECPl4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 11:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23B961159;
        Mon,  3 May 2021 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620056463;
        bh=h5qmhx+5ZVl78XWAQLNoSqoyVBg9I1Ilhgksiu+zPpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaTbWj4SLwG75jsCexmUqAGQ2vuj9dYXLYj0IwM4kCP28a0K9r0fGEBdTr8O0vplg
         lHjfSUBEUtvwfDW9vmZzR8Lmms1iRkS7izV/FJrthzXFwSmiVAtQPnJABjMLlx4I+L
         qfeJl/d6E+LZ8YuFKQosOwpCy1y/sT5IjWueBYPZzaVnAlZnkvoSnT/z5p+/uqQAvr
         Xgt3VFZTm7KeKfBwpwTpbmb0Nwa6cKSSPlq1EwOqDG/UlJfJPPNnaCF6AFM5OiSgCu
         jZuhYr3eHKzkoV/23MfhsEm8xDSqwU0WMtt9kfN/0rImIDrWrqTBZUmgRsmNRj40K3
         A3Tujwm16NCUQ==
Date:   Mon, 3 May 2021 18:41:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH 0/1] SGX self test fails
Message-ID: <YJAZjP2k6Aff7wgk@kernel.org>
References: <20210429183952.22797-1-tim.gardner@canonical.com>
 <c0725600-0a00-31dd-2ec3-20d4a86b33c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0725600-0a00-31dd-2ec3-20d4a86b33c5@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 29, 2021 at 11:55:23AM -0700, Dave Hansen wrote:
> On 4/29/21 11:39 AM, Tim Gardner wrote:
> > I'm just starting my learning curve on SGX, so I don't know if I've missed
> > some setup for the SGX device entries. After looking at arch/x86/kernel/cpu/sgx/driver.c
> > I see that there is no mode value for either sgx_dev_enclave or sgx_dev_provision.
> > 
> > With this patch I can get the SGX self test to complete:
> > 
> > sudo ./test_sgx
> > Warning: no execute permissions on device file /dev/sgx_enclave
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > SUCCESS
> > 
> > Is the warning even necessary ?
> 
> Dang, I just added that warning.  I thought it was necessary, but I
> guess not:
> 
> $ ls -l /dev/sgx_enclave
> crw------- 1 dave dave 10, 125 Apr 28 11:32 /dev/sgx_enclave
> $ ./test_sgx
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> SUCCESS
> 
> *But*, is that OK?  Should we be happily creating a PROT_EXEC mapping on
> a ugo-x file?  Why were we respecting noexec on the filesystem but not
> ugo-x on the file?

Yeah, this supports my earlier response:

"EPERM  The prot argument asks for PROT_EXEC but the mapped area
 belongs to a file on a filesystem that was mounted no-exec."
https://man7.org/linux/man-pages/man2/mmap.2.html

I guess the right model is to think just as "anonymous memory"
with equivalent access control semantics after succesfully
opened for read and write.

BTW, this is good material for the man page :-)

/Jarkko
