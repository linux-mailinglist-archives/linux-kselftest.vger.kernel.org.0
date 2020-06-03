Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE21ED865
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFCWGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jun 2020 18:06:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:12488 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgFCWGf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jun 2020 18:06:35 -0400
IronPort-SDR: W3QnxCBGQoxmAkSbifnW+HiPjZawpZKIBAyW8gEay5Ztc7lXDgqte0kiX5Z7g5/BF8d1vodLil
 NfxBm8YOFqaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 15:06:34 -0700
IronPort-SDR: sMphcVLs37uOLYmlTfp+8NPSIpJYLQu68VOHDtkqz+XcScbYO/tn6kCUhKuQLNyyIXwMhHqTK6
 AcT8FVIxruAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="258147584"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2020 15:06:34 -0700
Date:   Wed, 3 Jun 2020 15:06:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20200603220634.GB25606@linux.intel.com>
References: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
 <20200601075218.65618-20-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601075218.65618-20-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 01, 2020 at 10:52:16AM +0300, Jarkko Sakkinen wrote:
> Add a selftest for SGX. It is a trivial test where a simple enclave
> copies one 64-bit word of memory between two memory locations.

...

> --- /dev/null
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -0,0 +1,53 @@
> +top_srcdir = ../../../..
> +
> +include ../lib.mk
> +
> +.PHONY: all clean
> +
> +CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
> +			    ../x86/trivial_64bit_program.c)
> +
> +ifndef OBJCOPY
> +OBJCOPY := $(CROSS_COMPILE)objcopy
> +endif
> +
> +INCLUDES := -I$(top_srcdir)/tools/include
> +HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack

There's a pending pull request for 5.8[1] that includes a patch that turns
off automatic READ_IMPLIES_EXEC for x86_64[2].  Assuming that gets pulled
for 5.8, we should drop noexecstack to verify/ensure that the workaround is
no longer needed to avoid conflicts with the EPCM permissions.

[1] https://lkml.kernel.org/r/20200603213452.GG19667@zn.tnic
[2] https://lkml.kernel.org/r/20200327064820.12602-4-keescook@chromium.org
