Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6437230A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhECWh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 18:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECWh6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 18:37:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3DE61208;
        Mon,  3 May 2021 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620081424;
        bh=VmWSfADQetC3TgPVzlYh/EnoLCaaymJ111Jp5fZ0ZE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXISMs4t/u0VAJHE11vmDsML8XIBsyHzbUA6YQOzjpOO+EMEs9VV6lsjm32ke+tV1
         QiO9yWXal56C0yBZk42Ynfr8h9xeb1up2oJz6NLfB5I5w+5meiqmmVN1Slfw+d1Dfp
         odTR3OmtSCNvUNUL8IkQtzPn//dgPRDQms+2lCS6gc+4wCP++Xrn6z+2CcM7cwvp0T
         9bsbS+vvuyy59TLg08zdY5pQVrG0OnyAMNlh0D3ypbCbArnkvWjjI/1Cxy/QqiLTWm
         xF9RZyPnhKtOV/CuBvfb1M1+UyLQNX2haAfA/QRyGOe64x/9TpCfSTh/yVpSkb7psX
         AMANAmdFvqF/A==
Date:   Tue, 4 May 2021 01:37:01 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH 0/1] SGX self test fails
Message-ID: <YJB7DZHDeNujIY+F@kernel.org>
References: <20210429183952.22797-1-tim.gardner@canonical.com>
 <c0725600-0a00-31dd-2ec3-20d4a86b33c5@intel.com>
 <YJAZjP2k6Aff7wgk@kernel.org>
 <6645d579-57f9-7adf-8a3d-f4fb2316b324@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6645d579-57f9-7adf-8a3d-f4fb2316b324@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 03, 2021 at 09:39:05AM -0700, Dave Hansen wrote:
> On 5/3/21 8:41 AM, Jarkko Sakkinen wrote:
> >> $ ls -l /dev/sgx_enclave
> >> crw------- 1 dave dave 10, 125 Apr 28 11:32 /dev/sgx_enclave
> >> $ ./test_sgx
> >> 0x0000000000000000 0x0000000000002000 0x03
> >> 0x0000000000002000 0x0000000000001000 0x05
> >> 0x0000000000003000 0x0000000000003000 0x03
> >> SUCCESS
> >>
> >> *But*, is that OK?  Should we be happily creating a PROT_EXEC mapping on
> >> a ugo-x file?  Why were we respecting noexec on the filesystem but not
> >> ugo-x on the file?
> > Yeah, this supports my earlier response:
> > 
> > "EPERM  The prot argument asks for PROT_EXEC but the mapped area
> >  belongs to a file on a filesystem that was mounted no-exec."
> > https://man7.org/linux/man-pages/man2/mmap.2.html
> > 
> > I guess the right model is to think just as "anonymous memory"
> > with equivalent access control semantics after succesfully
> > opened for read and write.
> 
> I guess I'll answer my own question: The "x" bit on file permissions
> really only controls the ability for the file to be execve()'d, but has
> no bearing on the ability for an executable *mapping* to be created.
> This is existing VFS behavior and is not specific to SGX.

Yeah, that's nicely put it into one sentence :-)

> I think I'll just send a patch to pull that warning out.

/Jarkko
