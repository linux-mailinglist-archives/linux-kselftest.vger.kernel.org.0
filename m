Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A373C180801
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 20:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCJT3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 15:29:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:21692 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCJT3o (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 15:29:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 12:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="353693892"
Received: from hhuan26-mobl1.amr.corp.intel.com ([10.254.76.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2020 12:29:41 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        "Dr. Greg" <greg@enjellic.com>
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
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
 <20200306053210.GA16297@wind.enjellic.com>
Date:   Tue, 10 Mar 2020 14:29:41 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.0g923rgpwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
In-Reply-To: <20200306053210.GA16297@wind.enjellic.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 05 Mar 2020 23:32:10 -0600, Dr. Greg <greg@enjellic.com> wrote:

> On Wed, Mar 04, 2020 at 01:36:01AM +0200, Jarkko Sakkinen wrote:
>
> Good evening, I hope the end of the week is going well for everyone.
>
>> Add a selftest for SGX. It is a trivial test where a simple enclave
>> copies one 64-bit word of memory between two memory locations given
>> to the enclave as arguments. Use ENCLS[EENTER] to invoke the
>> enclave.
>
> Just as a clarification, are you testing the new driver against signed
> production class enclaves in .so format that also include metadata
> layout directives or is the driver just getting tested against the two
> page toy enclave that copies a word of memory from one memory location
> to another?
>

We (Intel SGX SDK/PSW team) tested this driver for enclaves in .so format  
with metadata. Our 2.8 release supports v24 and 2.9 supports v25+. Both  
production signed and debug signed enclaves worked.

*Note* we did make some code changes in our runtime for v24+, mainly  
dealing with src & EPC page alignment for EADD, open one fd per enclave,  
use -z noexecstack linker option, etc. You can see the changes on GitHub.

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
We did not see any issue loading QE in our tests. Please directly email me  
on this test if you have specific questions.

> When we ported our runtime loader to the new driver ABI we kept things
> simple and add only a single page at a time in order to replicate the
> behavior of the old driver.
>
> Secondly, we were wondering what distribution you are building the
> self-tests with?  Initial indications are that the selftest signing
> utility doesn't build properly with OpenSSL 1.1.1.
>
> Have a good day.
>
> Dr. Greg
>
> As always,
> Dr. Greg Wettstein, Ph.D, Worker
> IDfusion, LLC               SGX secured infrastructure and
> 4206 N. 19th Ave.           autonomously self-defensive platforms.
> Fargo, ND  58102
> PH: 701-281-1686            EMAIL: greg@idfusion.net
> ------------------------------------------------------------------------------
> "Don't worry about people stealing your ideas.  If your ideas are any
>  good, you'll have to ram them down people's throats."
>                                 -- Howard Aiken


-- 
Using Opera's mail client: http://www.opera.com/mail/
