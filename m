Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D3717B689
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCFGEb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 01:04:31 -0500
Received: from wind.enjellic.com ([76.10.64.91]:59360 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgCFGEa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 01:04:30 -0500
X-Greylist: delayed 1912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 01:04:30 EST
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 0265WBpF016522;
        Thu, 5 Mar 2020 23:32:11 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 0265WAUZ016521;
        Thu, 5 Mar 2020 23:32:10 -0600
Date:   Thu, 5 Mar 2020 23:32:10 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20200306053210.GA16297@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 05 Mar 2020 23:32:12 -0600 (CST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 01:36:01AM +0200, Jarkko Sakkinen wrote:

Good evening, I hope the end of the week is going well for everyone.

> Add a selftest for SGX. It is a trivial test where a simple enclave
> copies one 64-bit word of memory between two memory locations given
> to the enclave as arguments. Use ENCLS[EENTER] to invoke the
> enclave.

Just as a clarification, are you testing the new driver against signed
production class enclaves in .so format that also include metadata
layout directives or is the driver just getting tested against the two
page toy enclave that copies a word of memory from one memory location
to another?

Our PSW/runtime is currently failing to initialize production class
enclaves secondary to a return value of -4 from the ENCLU[EINIT]
instruction, which means the measurement of the loaded enclave has
failed to match the value in the signature structure.

The same enclave loads fine with the out of kernel driver.  Our
diagnostics tell us we are feeding identical page streams and
permissions to the page add ioctl's of both drivers.  The identity
modulus signature of the signing key for the enclave is being written
to the launch control registers.

We see the same behavior from both our unit test enclaves and the
Quoting Enclave from the Intel SGX runtime.

When we ported our runtime loader to the new driver ABI we kept things
simple and add only a single page at a time in order to replicate the
behavior of the old driver.

Secondly, we were wondering what distribution you are building the
self-tests with?  Initial indications are that the selftest signing
utility doesn't build properly with OpenSSL 1.1.1.

Have a good day.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker
IDfusion, LLC               SGX secured infrastructure and
4206 N. 19th Ave.           autonomously self-defensive platforms.
Fargo, ND  58102
PH: 701-281-1686            EMAIL: greg@idfusion.net
------------------------------------------------------------------------------
"Don't worry about people stealing your ideas.  If your ideas are any
 good, you'll have to ram them down people's throats."
                                -- Howard Aiken
