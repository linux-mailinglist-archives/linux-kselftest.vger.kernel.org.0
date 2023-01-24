Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795667A485
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjAXVCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 16:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXVCm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 16:02:42 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672141B6B;
        Tue, 24 Jan 2023 13:02:39 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30OKxS182864905
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 24 Jan 2023 12:59:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30OKxS182864905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674593970;
        bh=9DoeK4pzKCZ3oaVq5FOrw6uKFJ44twkQ98xAmRhBhKE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ePbJFTc0iGeSoXi2dUxZBxD7tYcuZnLph7f5toU8zeVvCxLnEiVMWPmNyqUs6qpxc
         gc93d23/ifog6fq+BYPcZQs6I1dJtP6i5dNpW1zrmKyDpFRtkg+8xNh1mUzQdrUJN7
         /YLxM3sPU+WF3dcfnQVTvWNxtRsR8coafLnRNuPgjz4ze8dbDf/9oNUjfRDNNO0r39
         BJd5aosDQPCp+CEMjtN7QsvUGOQP/ae+TqW3XDD6EtymLb3Xp6OPNw/9cpDwMwa131
         tOYpFtzEYvmwKNEA6TG1XyymYaQzYfng+1voObl+lAbOWIvg10IIzkz4Jw+URsxSIW
         Aj0SkIlbRuZpw==
Message-ID: <48072ce2-e28d-9267-1f8e-3c76682fb782@zytor.com>
Date:   Tue, 24 Jan 2023 12:59:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v3 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
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
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
 <20230124100926.637335-3-ammarfaizi2@gnuweeb.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230124100926.637335-3-ammarfaizi2@gnuweeb.org>
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



On 1/24/23 02:09, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Test that:
> 
>   - "syscall" in a FRED system doesn't clobber %rcx and %r11.
>   - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> 
> Test them out with a trivial system call like __NR_getppid and friends
> which are extremely likely to return with SYSRET on an IDT system.
> 
> Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
> Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Add to the description that the purpose of this is to ensure that 
various system calls are *consistent*, as per the comment immediately 
below your code.

	-hpa

