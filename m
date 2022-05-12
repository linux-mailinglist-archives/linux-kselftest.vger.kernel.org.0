Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6516A524F60
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354973AbiELOE3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 10:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354972AbiELOE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 10:04:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC11EEE1B;
        Thu, 12 May 2022 07:04:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so10450019ejb.8;
        Thu, 12 May 2022 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fs8s4x4j/+asSW1i8f2Pukqgr0Ir/tJgvdWyY3yoq3U=;
        b=SUG5R4mvQVZygGuRddCDO8dZQacyk07/cAZawwDbBHFiIcz+Eh01oOdFt+8NMsiteQ
         s8AlWxu2/skdBIc9am1jSyRtORyb1BuvlFo2plpzUHEsxv9da1HNExENjJ/0t+nOi9bO
         k6oU2HkXL/cV0mXaW/mfigdUplLND8VcIPAZZRcd10cHVVgLxpSC20yq2GqMhOEn4o3v
         BX8j64LjIRumUuIVBipI3tL8S6DVa+sbn4U3DSEKiGesq+9Htf13sK9idkEcXbPWJtoW
         pmum4BbxGst/QvpAJs+YLlKzd9hKoO2n+ygfnHiEf87Cm4zp15vme9Bvbc6JHtHUcLB8
         yScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fs8s4x4j/+asSW1i8f2Pukqgr0Ir/tJgvdWyY3yoq3U=;
        b=v4B3HHwlk9jnnCSMeZzI1PxJB6prSWalTvvucWTXhx+NZ1PbGCi41eDOQWYYEH0O+3
         muOEYrZEVquXOOjvDXr+YsfSAaqZQJRZaxePEZHel8j4i8tA6aO4IkFHyXIaHj0cJ9W4
         28be8uzT1XAahhlfBeARCdaypq7rl6NKnXK2vAvT6p4tNhQkA/St14A7NR5hGRh9uYHB
         SabIQYkJz30ql5GC917Acr3flgypcku2CDRsX173gT7kGQRqn6/LthrojbCCsbiRG/yE
         DrdNaI/2DBJBPvqv8aDmTlh6yK6Wfvt4BAIga4uV5t4jWiawAb0tIIiOCusVsAyq0Pyp
         ArjA==
X-Gm-Message-State: AOAM531Z2Pg69vJsy5zCPsP3LGyejYQK8occa6UXxI3e3xO1VdLvgfM8
        le6fTlZM6RoH0xjheWHlQ9U=
X-Google-Smtp-Source: ABdhPJyt50qyYPCyD03r3/AJ3OUGuB2lb9Kyp65SglIgNSyfP293qaN/xBFVKFZfLgIbEagAjedBOw==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr63430ejc.53.1652364264897;
        Thu, 12 May 2022 07:04:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r10-20020a508d8a000000b00428bb4c952bsm2609603edh.31.2022.05.12.07.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:04:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <0d4e0b40-a2b3-789f-3adb-9da30c61403f@redhat.com>
Date:   Thu, 12 May 2022 16:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests: kvm: replace ternary operator with min()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Cc:     zhengkui_guo@outlook.com
References: <20220511120621.36956-1-guozhengkui@vivo.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220511120621.36956-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/11/22 14:05, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> 
> tools/testing/selftests/kvm/lib/s390x/ucall.c:25:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/x86_64/ucall.c:27:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/riscv/ucall.c:56:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:82:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:55:20-21: WARNING
> opportunity for min()
> 
> min() is defined in tools/include/linux/kernel.h.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   tools/testing/selftests/kvm/lib/aarch64/ucall.c | 4 ++--
>   tools/testing/selftests/kvm/lib/riscv/ucall.c   | 2 +-
>   tools/testing/selftests/kvm/lib/s390x/ucall.c   | 2 +-
>   tools/testing/selftests/kvm/lib/x86_64/ucall.c  | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> index e0b0164e9af8..00be3ef195ca 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> @@ -52,7 +52,7 @@ void ucall_init(struct kvm_vm *vm, void *arg)
>   	 * lower and won't match physical addresses.
>   	 */
>   	bits = vm->va_bits - 1;
> -	bits = vm->pa_bits < bits ? vm->pa_bits : bits;
> +	bits = min(vm->pa_bits, bits);
>   	end = 1ul << bits;
>   	start = end * 5 / 8;
>   	step = end / 16;
> @@ -79,7 +79,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>   	va_list va;
>   	int i;
>   
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>   
>   	va_start(va, nargs);
>   	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> index 9e42d8248fa6..34f16fe70ce8 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -53,7 +53,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>   	va_list va;
>   	int i;
>   
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>   
>   	va_start(va, nargs);
>   	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> index 9d3b0f15249a..665267c1135d 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> @@ -22,7 +22,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>   	va_list va;
>   	int i;
>   
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>   
>   	va_start(va, nargs);
>   	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> index a3489973e290..2ea31a0ebe30 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> @@ -24,7 +24,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>   	va_list va;
>   	int i;
>   
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>   
>   	va_start(va, nargs);
>   	for (i = 0; i < nargs; ++i)

Queued, thanks.

Paolo
