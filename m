Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1287A679050
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 06:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAXFtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 00:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjAXFtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 00:49:02 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793253C294;
        Mon, 23 Jan 2023 21:48:14 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30O5j52V2628757
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 21:45:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30O5j52V2628757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674539111;
        bh=1PBmtzTOvoQB1NIFT9gzjuVDOXpEJFnIM/BFNCdi4UA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FgKFvQgQuXtAEPMUNy7oaizi2x7WHXMtfVem1W87yPbrEwnT1A+cqjLuf+cS9I3XK
         87mL7vIlCRR82Tafi/DJGcQEP+5sF+S/viv9woS004+wfWm6rcHrZw7/g6JuouxamY
         8x0Ss1WVbdVHH/4oI5yT/SYbd5OghFXF7ICEUrQHMbODrlocpOtHrg9YPk9Uipbdbv
         bcIND06el5Py3JD52lvTpzZagAkruMCOFMrBKymZyJBbernDEGSlDKHKHV/eSNSy+v
         DTLh4wANulqbQdTN8hyUx/e4d5nTsBpIEmRYOwJy6e8xaQKPA6oTsVIvMBlI9N+Eff
         ukFIJIIvGbnmg==
Message-ID: <ea9dbc3c-0148-ecf1-d68f-2fcd1d026c36@zytor.com>
Date:   Mon, 23 Jan 2023 21:44:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v2 1/2] selftests/x86: sysret_rip: Handle syscall in a
 FRED system
Content-Language: en-US
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
 <20230124022729.596997-2-ammarfaizi2@gnuweeb.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230124022729.596997-2-ammarfaizi2@gnuweeb.org>
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
> The current selftest asserts %r11 == %rflags after the 'syscall'
> returns to user. Such an assertion doesn't apply to a FRED system
> because in a FRED system the 'syscall' instruction does not set
> %r11=%rflags and %rcx=%rip.
> 
> Handle the FRED case. Now, test that:
> 
>    - "syscall" in a FRED system doesn't clobber %rcx and %r11.
>    - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> 
> The 'raise()' function from libc can't be used to control those
> registers. Therefore, create a syscall wrapper in inline Assembly to
> fully control them.
> 
> Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to noncanonical addresses")
> Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
> Reported-by: Xin Li <xin3.li@intel.com>
> Co-developed-by: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> 
> Need hpa's sign off.
> 

For both patches:

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

