Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD41FA148
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgFOUSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 16:18:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:37178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUSG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 16:18:06 -0400
IronPort-SDR: +j69V2XXin4o6DQYgRoImEYIWWuDDn3p7U5/c+82VLLB6FLMfkXKiqaopbbJxM7BcGe7UUcmEv
 VhUCLm1nb3Dg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:18:05 -0700
IronPort-SDR: 7UGogxNsF5wX7XX/7pmqGbq6uruuIb+aUdmRHpRdQG1RzTUi+jc9MYje1Q/vT/miaEn7JZq3sj
 YC1frf1vW+xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="298643381"
Received: from ifaivilx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.251])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2020 13:17:54 -0700
Date:   Mon, 15 Jun 2020 23:17:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v32 19/21] selftests/x86: Add a selftest for SGX
Message-ID: <20200615201754.GD5416@linux.intel.com>
References: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
 <20200601075218.65618-20-jarkko.sakkinen@linux.intel.com>
 <20200603220634.GB25606@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603220634.GB25606@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 03, 2020 at 03:06:34PM -0700, Sean Christopherson wrote:
> On Mon, Jun 01, 2020 at 10:52:16AM +0300, Jarkko Sakkinen wrote:
> > Add a selftest for SGX. It is a trivial test where a simple enclave
> > copies one 64-bit word of memory between two memory locations.
> 
> ...
> 
> > --- /dev/null
> > +++ b/tools/testing/selftests/sgx/Makefile
> > @@ -0,0 +1,53 @@
> > +top_srcdir = ../../../..
> > +
> > +include ../lib.mk
> > +
> > +.PHONY: all clean
> > +
> > +CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
> > +			    ../x86/trivial_64bit_program.c)
> > +
> > +ifndef OBJCOPY
> > +OBJCOPY := $(CROSS_COMPILE)objcopy
> > +endif
> > +
> > +INCLUDES := -I$(top_srcdir)/tools/include
> > +HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
> 
> There's a pending pull request for 5.8[1] that includes a patch that turns
> off automatic READ_IMPLIES_EXEC for x86_64[2].  Assuming that gets pulled
> for 5.8, we should drop noexecstack to verify/ensure that the workaround is
> no longer needed to avoid conflicts with the EPCM permissions.
> 
> [1] https://lkml.kernel.org/r/20200603213452.GG19667@zn.tnic
> [2] https://lkml.kernel.org/r/20200327064820.12602-4-keescook@chromium.org

If the check is removed from encl.c, then this needs to be taken into
account in backporting.

/Jarkko
