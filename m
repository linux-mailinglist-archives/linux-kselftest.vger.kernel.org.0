Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB9678772
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 21:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAWUS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 15:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjAWUSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 15:18:23 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 12:18:20 PST
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141B34C27;
        Mon, 23 Jan 2023 12:18:20 -0800 (PST)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1pK1ta-0001xF-1N; Mon, 23 Jan 2023 19:50:18 +0100
Message-ID: <99a36eed-e4e5-60ec-0f88-a33d1842a0d6@maciej.szmigiero.name>
Date:   Mon, 23 Jan 2023 19:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
To:     Erdem Aktas <erdemaktas@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20230121001542.2472357-1-ackerleytng@google.com>
 <20230121001542.2472357-9-ackerleytng@google.com>
 <Y8sxjppvEnm4IBWG@google.com>
 <CAAYXXYy7=ZTCZ1LQ3_Sy39ju_xG5++dTrxi+DKGcbpJ5VJ3OuQ@mail.gmail.com>
Content-Language: en-US, pl-PL
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <CAAYXXYy7=ZTCZ1LQ3_Sy39ju_xG5++dTrxi+DKGcbpJ5VJ3OuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23.01.2023 19:30, Erdem Aktas wrote:
> On Fri, Jan 20, 2023 at 4:28 PM Sean Christopherson <seanjc@google.com> wrote:
>>
>> On Sat, Jan 21, 2023, Ackerley Tng wrote:
>>> Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
>>> assuming the stack is aligned:
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
>>> results in a #GP in guests.
>>>
>>> Adding this compiler flag will generate an alternate prologue and
>>> epilogue to realign the runtime stack, which makes selftest code
>>> slower and bigger, but this is okay since we do not need selftest code
>>> to be extremely performant.
>>
>> Huh, I had completely forgotten that this is why SSE is problematic.  I ran into
>> this with the base UPM selftests and just disabled SSE.  /facepalm.
>>
>> We should figure out exactly what is causing a misaligned stack.  As you've noted,
>> the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm misreading vm_arch_vcpu_add(),
>> the starting stack should be page aligned, which means something is causing the
>> stack to become unaligned at runtime.  I'd rather hunt down that something than
>> paper over it by having the compiler force realignment.
> 
> Is not it due to the 32bit execution part of the guest code at boot
> time. Any push/pop of 32bit registers might make it a 16-byte
> unaligned stack.

32-bit stack needs to be 16-byte aligned, too (at function call boundaries) -
see [1] chapter 2.2.2 "The Stack Frame"

Thanks,
Maciej

[1]: https://www.uclibc.org/docs/psABI-i386.pdf

