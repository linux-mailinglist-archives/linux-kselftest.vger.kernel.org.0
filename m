Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997A5A35D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiH0I1Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0I1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 04:27:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5305A5C45;
        Sat, 27 Aug 2022 01:27:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so4583052edc.11;
        Sat, 27 Aug 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=db6wHPl1NoBxSkqFEqmoNM4w13Oy0TZZkviyKHiod6c=;
        b=UEYLobTe2AZYd65vehbSh24XDhaWFDZNCGL1gdVQxc452u7u2Q4Y0f66RZocX0c5TR
         DdJwU7CRlQgFC6BGI+qrfrE8odV1ul43ApbvWCBwVJ+CO5ykyfdKL69XWCEz4AxBVoPc
         Fw9/BZpE/pwvSNqV+U8bI4UFaXmNWqGWUpCFIcgHDmb/R5YJHvw+l1Nl4PI62pOc0Mlu
         G6Xxx2tmIx2MgPkjxhb9Qr8ZtxLsw5z8IGCfxtj4gjhzdE7BqdYB4NS6TbXn8rmeHOgA
         wuLPmYOYHGXF2RHYZcgbY4nK+iZs8S8bbVCuzl21nt3v+hkpld1DBAXs+elsDk4x4Ohv
         QRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=db6wHPl1NoBxSkqFEqmoNM4w13Oy0TZZkviyKHiod6c=;
        b=E4s2TfDpp7rRteYRFYRQ1zF9senJSzOH7NjijCc4GnaQ4C0Q2yY5B08FPLLhRh8LkI
         DsaSQIoDe1Svv0TtRc/tY17tOAfrDbDQMaeWcRa8DV28yugNvhWlneekcjG3taBv1337
         hiJdcWSRT0Jt9X0Bn0luXru8dzNOMCu31beASejJqWBHAN0gKkxuFIOi8RjPu7u4brpc
         fTIp9Q5/F4ZLkSnFBVJdrVOVDPaGH6mDuP0ZgAnILqm8XfPFKlz3yq5+zO/wGypHgR8y
         wpzEVYg93p4Xawa8Ksnoxr2ljqv/Q5FiTeLzH4iJUUuiTKDgDX3pYXT+nzaoVYqf5POl
         i/jA==
X-Gm-Message-State: ACgBeo3fJ2AhkeSEVr8edb1GxsWgBdGWN4/4te4too66nb+CiWbntbkr
        v5LT9QW1d4TU/ZLmA1gr4+Q=
X-Google-Smtp-Source: AA6agR7k4MkhXbRXPVNIpqB7niZw9Vuq4+jhvWLePL+17JoEYc9ENHX7DdgLIO1WI1Mrtg/N6ODRPw==
X-Received: by 2002:a05:6402:71a:b0:447:ebb2:18f2 with SMTP id w26-20020a056402071a00b00447ebb218f2mr4862760edx.408.1661588831315;
        Sat, 27 Aug 2022 01:27:11 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id m18-20020a056402511200b0043d5ead65a6sm2485422edd.84.2022.08.27.01.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 01:27:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <79cc1418-2448-6a80-e4b8-2041f94c419e@redhat.com>
Date:   Sat, 27 Aug 2022 10:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        corbet@lwn.net, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, dmatlack@google.com, bgardon@google.com,
        ricarkol@google.com, zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com> <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
 <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
 <YwTc++Lz6lh3aR4F@xz-m1.local> <87bksawz0w.wl-maz@kernel.org>
 <YwVEoM1pj2MPCELp@xz-m1.local> <878rnewpaw.wl-maz@kernel.org>
 <9e7cb09c-82c5-9492-bccd-5511f5bede26@redhat.com>
 <8735djvwbu.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <8735djvwbu.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/22 17:49, Marc Zyngier wrote:
>> Agreed, but that's a problem for userspace to solve.  If userspace
>> wants to reset the fields in different CPUs, it has to synchronize
>> with its own invoking of the ioctl.
> 
> userspace has no choice. It cannot order on its own the reads that the
> kernel will do to *other* rings.

Those reads will never see KVM_DIRTY_GFN_F_RESET in the flags however, 
if userspace has never interacted with the ring.  So there will be 
exactly one read on those rings, and there's nothing to reorder.

If that's too tricky and you want to add a load-acquire I have no 
objection though.  It also helps avoiding read-read reordering between 
one entry's flags to the next one's, so it's a good idea to have it anyway.

>> The main reason why I preferred a global KVM_RESET_DIRTY_RINGS ioctl
>> was because it takes kvm->slots_lock so the execution would be
>> serialized anyway.  Turning slots_lock into an rwsem would be even
>> worse because it also takes kvm->mmu_lock (since slots_lock is a
>> mutex, at least two concurrent invocations won't clash with each other
>> on the mmu_lock).
> 
> Whatever the reason, the behaviour should be identical on all
> architectures. As is is, it only really works on x86, and I contend
> this is a bug that needs fixing.
> 
> Thankfully, this can be done at zero cost for x86, and at that of a
> set of load-acquires on other architectures.

Yes, the global-ness of the API is orthogonal to the memory ordering 
issue.  I just wanted to explain why a per-vCPU API probably isn't going 
to work great.

Paolo
