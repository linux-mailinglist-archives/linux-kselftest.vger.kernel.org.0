Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2E6983BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBOSqI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 13:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBOSqH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 13:46:07 -0500
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFE3CE39;
        Wed, 15 Feb 2023 10:45:29 -0800 (PST)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1pSMlf-000305-3p; Wed, 15 Feb 2023 19:44:35 +0100
Message-ID: <f3c1ea27-ba90-171b-a336-8da86ec98900@maciej.szmigiero.name>
Date:   Wed, 15 Feb 2023 19:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     erdemaktas@google.com, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, isaku.yamahata@intel.com, sagis@google.com,
        afranji@google.com, runanwang@google.com, shuah@kernel.org,
        drjones@redhat.com, maz@kernel.org, bgardon@google.com,
        jmattson@google.com, dmatlack@google.com, peterx@redhat.com,
        oupton@google.com, ricarkol@google.com, yang.zhong@intel.com,
        wei.w.wang@intel.com, xiaoyao.li@intel.com, pgonda@google.com,
        marcorr@google.com, eesposit@redhat.com, borntraeger@de.ibm.com,
        eric.auger@redhat.com, wangyanan55@huawei.com,
        aaronlewis@google.com, vkuznets@redhat.com, pshier@google.com,
        axelrasmussen@google.com, zhenzhong.duan@intel.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
References: <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com>
Content-Language: en-US, pl-PL
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
In-Reply-To: <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.02.2023 01:50, Ackerley Tng wrote:
> 
>> On Mon, Jan 23, 2023, Erdem Aktas wrote:
>> > On Mon, Jan 23, 2023 at 10:53 AM Sean Christopherson <seanjc@google.com> wrote:
>> > >
>> > > On Mon, Jan 23, 2023, Maciej S. Szmigiero wrote:
>> > > > On 23.01.2023 19:30, Erdem Aktas wrote:
>> > > > > On Fri, Jan 20, 2023 at 4:28 PM Sean Christopherson <seanjc@google.com> wrote:
>> > > > > >
>> > > > > > On Sat, Jan 21, 2023, Ackerley Tng wrote:
>> > > > > > > Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
>> > > > > > > assuming the stack is aligned:
>> > > > > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
>> > > > > > > results in a #GP in guests.
>> > > > > > >
>> > > > > > > Adding this compiler flag will generate an alternate prologue and
>> > > > > > > epilogue to realign the runtime stack, which makes selftest code
>> > > > > > > slower and bigger, but this is okay since we do not need selftest code
>> > > > > > > to be extremely performant.
>> > > > > >
>> > > > > > Huh, I had completely forgotten that this is why SSE is problematic.  I ran into
>> > > > > > this with the base UPM selftests and just disabled SSE.  /facepalm.
>> > > > > >
>> > > > > > We should figure out exactly what is causing a misaligned stack.  As you've noted,
>> > > > > > the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm misreading vm_arch_vcpu_add(),
>> > > > > > the starting stack should be page aligned, which means something is causing the
>> > > > > > stack to become unaligned at runtime.  I'd rather hunt down that something than
>> > > > > > paper over it by having the compiler force realignment.
>> > > > >
>> > > > > Is not it due to the 32bit execution part of the guest code at boot
>> > > > > time. Any push/pop of 32bit registers might make it a 16-byte
>> > > > > unaligned stack.
>> > > >
>> > > > 32-bit stack needs to be 16-byte aligned, too (at function call boundaries) -
>> > > > see [1] chapter 2.2.2 "The Stack Frame"
>> > >
>> > > And this showing up in the non-TDX selftests rules that out as the sole problem;
>> > > the selftests stuff 64-bit mode, i.e. don't have 32-bit boot code.
>> >
>> > Thanks Maciej and Sean for the clarification. I was suspecting the
>> > hand-coded assembly part that we have for TDX tests but  it being
>> > happening in the non-TDX selftests disproves it.
> 
>> Not necessarily, it could be both.  Goofs in the handcoded assembly and PEBKAC
>> on my end :-)
> 
> I figured it out!
> 
> GCC assumes that the stack is 16-byte aligned **before** the call
> instruction. Since call pushes rip to the stack, GCC will compile code
> assuming that on entrance to the function, the stack is -8 from a
> 16-byte aligned address.
> 
> Since for TDs we do a ljmp to guest code, providing a function's
> address, the stack was not modified by a call instruction pushing rip to
> the stack, so the stack is 16-byte aligned when the guest code starts
> running, instead of 16-byte aligned -8 that GCC expects.
> 
> For VMs, we set rip to a function pointer, and the VM starts running
> with a 16-byte algined stack too.
> 
> To fix this, I propose that in vm_arch_vcpu_add(), we align the
> allocated stack address and then subtract 8 from that:
> 

Note that if this code is ever used to launch a vCPU with 32-bit entry
point it will need to subtract 4 bytes instead of 8 bytes.

I think it would be worthwhile to at least place a comment mentioning
this near the stack aligning expression so nobody misses this fact.

Thanks,
Maciej

