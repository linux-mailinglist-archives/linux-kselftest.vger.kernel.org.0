Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56496790C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 07:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjAXGSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 01:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXGSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 01:18:45 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4130E98;
        Mon, 23 Jan 2023 22:18:41 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30O6G6Kk2637243
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 22:16:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30O6G6Kk2637243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674540968;
        bh=XH58Wca77uh7IXdxF4TdaMGV0Z0CqzpSfbHHO9L64g8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ll9wKs6zudIiHj1aifzzdajB6Af6+Zw6Z2OzuCT0o4621+OBeOdD3DgaGj2K5rWEG
         lozu0JsZF4T4vcZ6ONJdBsIUbzU+z0PQuLlmSW41wc7zLSpRIsQp7mowKXJrb14drQ
         /4ChkFGcHsGJTY6HQtSS4fNdGuc+vcnvarZMP3HHfE+sB16qHyKgmCSaXosmwOdFdD
         02AL7ipXOwLsECVWCHvjFTcFfmoAKGgqXp2YrmYspmIoOUx9pIH1upWYZJDGCzXCPL
         v25bsfD1uhXzbFc/bVG94tysGJtodmt9l71iDZ53/vfjDD3w/neoMaGtqwybAfGC2X
         jnS1yHQ+eP6Qg==
Message-ID: <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
Date:   Mon, 23 Jan 2023 22:16:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v2 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/23/23 18:27, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Test that:
> 
>   - "syscall" in a FRED system doesn't clobber %rcx and %r11.
>   - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> 
> Test them out with a trivial system call like __NR_getppid and friends
> which are extremely likely to return with SYSRET on an IDT system; check
> that it returns a nonnegative value and then save the result.
> 

"Nonnegative" here should be "valid"; it is an implementation detail 
that the error value is -1.

However, you are not checking that you don't get a mix of REGS_SAVED and 
REGS_SYSRET, which is a major part of the point.

	-hpa


