Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3262617C5DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 20:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFTEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 14:04:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:25085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFTEW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 14:04:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 11:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="275645693"
Received: from wbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.27.142])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 11:04:17 -0800
Date:   Fri, 6 Mar 2020 21:04:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
Message-ID: <20200306190416.GG7472@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
 <20200306053210.GA16297@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306053210.GA16297@wind.enjellic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 05, 2020 at 11:32:10PM -0600, Dr. Greg wrote:
> On Wed, Mar 04, 2020 at 01:36:01AM +0200, Jarkko Sakkinen wrote:
> 
> Good evening, I hope the end of the week is going well for everyone.
> 
> > Add a selftest for SGX. It is a trivial test where a simple enclave
> > copies one 64-bit word of memory between two memory locations given
> > to the enclave as arguments. Use ENCLS[EENTER] to invoke the
> > enclave.
> 
> Just as a clarification, are you testing the new driver against signed
> production class enclaves in .so format that also include metadata
> layout directives or is the driver just getting tested against the two
> page toy enclave that copies a word of memory from one memory location
> to another?

That is the kind of role kselftests to smoke stuff. Obviously it will
be refined over time but to do a "hello world" from scratch as an
enclave was already quite a big effort.

> Our PSW/runtime is currently failing to initialize production class
> enclaves secondary to a return value of -4 from the ENCLU[EINIT]
> instruction, which means the measurement of the loaded enclave has
> failed to match the value in the signature structure.
> 
> The same enclave loads fine with the out of kernel driver.  Our
> diagnostics tell us we are feeding identical page streams and
> permissions to the page add ioctl's of both drivers.  The identity
> modulus signature of the signing key for the enclave is being written
> to the launch control registers.
> 
> We see the same behavior from both our unit test enclaves and the
> Quoting Enclave from the Intel SGX runtime.
> 
> When we ported our runtime loader to the new driver ABI we kept things
> simple and add only a single page at a time in order to replicate the
> behavior of the old driver.
> 
> Secondly, we were wondering what distribution you are building the
> self-tests with?  Initial indications are that the selftest signing
> utility doesn't build properly with OpenSSL 1.1.1.

I don't use a distribution. I just build user space with BuildRoot
when I test a kernel.

Do you have a build log available to look at?

/Jarkko
