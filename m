Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94E92B89A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 02:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKSBgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 20:36:51 -0500
Received: from wind.enjellic.com ([76.10.64.91]:32916 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgKSBgu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 20:36:50 -0500
X-Greylist: delayed 1823 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 20:36:50 EST
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 0AJ15ZD9019428;
        Wed, 18 Nov 2020 19:05:35 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 0AJ15XOG019427;
        Wed, 18 Nov 2020 19:05:33 -0600
Date:   Wed, 18 Nov 2020 19:05:33 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-sgx@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201119010533.GA19402@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20201117223630.17355-1-jarkko@kernel.org> <20201118171900.GJ7472@zn.tnic> <20201118175850.GA42022@kernel.org> <20201118180450.GL7472@zn.tnic> <20201118213755.GA62979@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118213755.GA62979@kernel.org>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 18 Nov 2020 19:05:36 -0600 (CST)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 11:37:55PM +0200, Jarkko Sakkinen wrote:

Good evening, I hope the week is going well for everyone.

> On Wed, Nov 18, 2020 at 07:04:50PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 18, 2020 at 07:58:50PM +0200, Jarkko Sakkinen wrote:
> > > Duh, I sent the fix for the selftest before seeing this.
> > 
> > All, good - your static key fix is queued now too. The only thing that's
> > needs work now is the anon inode thing but that can come later.

> Just checking that I got this right: you want me to port my anon
> inode changes from March to be applied on top of tip and send them?

Given this issue, I would submit that you also need to consider the
patch that I sent over the weekend that unconditionally blocks
mmap/mprotect on an initialized enclave.

The issue with a noexec /dev filesystem goes on to confirm that the
page permission callback architecture, while certainly elegant, won't
work given the current architecture of the driver and the SGX hardware
itself.

The stashed page permissions are derived from the enclave permissions
set by the enclave author.  To be useful for the JIT model that Andy
described, the 'maximal' permissions would need to include WX.

Setting these types of permissions is problematic, not only from the
perspective of a noexec filesystem, which will presumably get fixed by
the anonymous inode, but it also triggers the very LSM issues that
started the re-design of all this a year ago.

> /Jarkko

Have a good evening.

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Opportunity is missed by most people because it is dressed in overalls
 and looks like work."
                                -- Thomas Edison
