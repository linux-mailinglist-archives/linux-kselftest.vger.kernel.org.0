Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7336F800
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhD3Jh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 05:37:57 -0400
Received: from wind.enjellic.com ([76.10.64.91]:47766 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3Jh5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 05:37:57 -0400
X-Greylist: delayed 667 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2021 05:37:56 EDT
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 13U9PdY5006270;
        Fri, 30 Apr 2021 04:25:39 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 13U9PcEj006269;
        Fri, 30 Apr 2021 04:25:38 -0500
Date:   Fri, 30 Apr 2021 04:25:38 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH 0/1] SGX self test fails
Message-ID: <20210430092538.GA5887@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20210429183952.22797-1-tim.gardner@canonical.com> <c0725600-0a00-31dd-2ec3-20d4a86b33c5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0725600-0a00-31dd-2ec3-20d4a86b33c5@intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 30 Apr 2021 04:25:39 -0500 (CDT)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 29, 2021 at 11:55:23AM -0700, Dave Hansen wrote:

Good morning, I hope the end of the week is going well for everyone.

> On 4/29/21 11:39 AM, Tim Gardner wrote:
> > I'm just starting my learning curve on SGX, so I don't know if
> > I've missed some setup for the SGX device entries. After looking
> > at arch/x86/kernel/cpu/sgx/driver.c I see that there is no mode
> > value for either sgx_dev_enclave or sgx_dev_provision.
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

Because no one placed any explicit executable mode bit checks on the
inode that is underlying the character device file in
arch/x86/kernel/cpu/sgx/driver.c:sgx_open() and the controls on
executable virtual memory are implemented in the mm/mmap.c:do_mmap()
path when the mmap system call is executed.

The notion of using discretionary access controls, and arguably MAC's,
since the true identity of a file is its inode label, to gate
executable permissions by a user on the contents of a file are a
function of the exec* system calls.

The notion of whether or not it is 'OK' to not allow system
administrators the ability to control SGX usage with file level exec
privileges would seem to be more philosophical then practical.  The
SGX device node does not represent an executable entity, it represents
a gateway to the right to create and then populate anonymous
executable memory.

From the standpoint of current systems administration practice, the
notion and need for executable bits being important on device nodes is
foreign, and violates the concept of least surprise.  As we have
already seen with the issue of noexec on /dev, the historical notion
of security has been that executable files should not be allowed in
the /dev heirarchy.

With that mindset, the notion of gating SGX permissions with only the
write bit on the character device would seem to make conceptual sense.
It does, however, limit the utility of using the bprm* LSM hooks to
implement whatever LSM controls over SGX that are envisioned for the
future.

At the risk of fanning dormant embers into flame, the relevance of all
of this needs to be considered in a future that will include Enclave
Dynamic Memory Management (EDMM).  At that point in time, access to
the SGX device node, gated through either discretionary or mandatory
access controls, means that an eligible entity will have unrestricted
rights to load completely anonymous, in fact cryptographically
anonymous, text into memory and execute it.

The utility of anything but yes/no decisions needs to be made with
that concept in mind.

To avoid the risk of being classified as a blatherer, I will return to
my work on maintaining support for cryptographic access controls on
all of this... :-)

Best wishes for a pleasant spring weekend to everyone.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Everything should be made as simple as possible, but not simpler."
                                -- Albert Einstein
