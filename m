Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106486AFCAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCHB7u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 20:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHB7t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 20:59:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2EA9BA40
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 17:59:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a137-20020a25ca8f000000b0091b90b20cd9so16079706ybg.6
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 17:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678240787;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMnkKJBSeJLIJWJ63dxJ2l/pcjlqG3hWFQL9cnDzY4k=;
        b=UYWeE57l4lIGpWifAsQVo5d4uLP7r1X7sI2k/QIXPtpXHWrBkeh86kl8tJubGv0ngo
         IlngOFBEcq4XZCUWvy5J2OFgykjp9rggBEBhpUgmv6JOl5yd6pTfo1gtTF6JcIO8JoJv
         CLm1u+9+ePTKgtLkd2pH2gJEwGFejqBxzpicjaRDp/tmEjgVw/awy4mjGJty879zeb7L
         Ojj+7Fhvf48yYY7IMaM6T3iRDmIVUikq7smmJClANesZrp+iEcUwRwIF7H47IT++LYsF
         Pd9IdtFFH0f502mumYnDSoUVrWT/yXEd8faAYJZ+f8f/WVu42UnADf3swEElAG8nTx50
         SSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678240787;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMnkKJBSeJLIJWJ63dxJ2l/pcjlqG3hWFQL9cnDzY4k=;
        b=WTPsHO9cglHIiiXuw5CcOksedciUMxOw2mzhpRpW1nd+IeNMFHRQoHB37ss2tIXzhe
         bN6uMVzBnVirZQOFvEVSMC+9TPA2bJeyVPTbGNDO5AtEtG/3AREjriAjGlZXLlW2aLUQ
         k5uaJEWAWRw3ymHv2jtL0WNbwT14yOqFZsroqpb43k5W49FcxHFIJrl24tjAQWT3mfxb
         uLuaukPlNJteJQnN2dkIu9VaZIrXwo+ejZDaD8XTlCsv//Yxnipnja9d6oYHQo+9CJKV
         uUCn1cb44uSepAYV0pBfUsSLsqf+CyU0rL/VJBEZRC5+7SHONWfdDxYbAvWSkpAfJGl2
         KIdg==
X-Gm-Message-State: AO0yUKWYcgyBKgHPx3zQaIHMzStgBnudIvfwOYRsoBjPsE+iMbt83ZBT
        LRsHtjsL12lH4RCUFkXB9/EoKIti/7zWq2FPqg==
X-Google-Smtp-Source: AK7set/EIDJEOoLPfCQrOfHA40erUROtaCAKW+YJw9riwDSqJtHig8reP7/n1hpcpiTk1c2LVzoimPxr4reSCiEgLQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:524:b0:a4e:4575:f3f0 with
 SMTP id y4-20020a056902052400b00a4e4575f3f0mr7886927ybs.11.1678240787650;
 Tue, 07 Mar 2023 17:59:47 -0800 (PST)
Date:   Wed, 08 Mar 2023 01:59:46 +0000
In-Reply-To: <20230307021809.GA2143916@chaop.bj.intel.com> (message from Chao
 Peng on Tue, 7 Mar 2023 10:18:09 +0800)
Mime-Version: 1.0
Message-ID: <diqz356guhnx.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     vannapurve@google.com, seanjc@google.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, diviness@google.com,
        maz@kernel.org, dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com, bgardon@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

>> [...]

>> Chao, I'll work on

>> + Running conversion tests for non-overlapping GPA ranges of
>>    same/different memslots from multiple vcpus
>> + Deleting memslots with restricted memfd while guests are being
>>    executed
>> + Installing multiple memslots with ranges within the same restricted
>>    mem files

>> this week.

> Thanks Ackerley. Looks good to me.

> BTW, for whom may have interest, below are the testcases I added:
> https://github.com/chao-p/linux/commit/24dd1257d5c93acb8c8cc6c76c51cf6869970f8a
> https://github.com/chao-p/linux/commit/39a872ef09d539ce0c953451152eb05276b87018
> https://github.com/chao-p/linux/commit/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d

> Chao

Hi Chao,

While I was working on the selftests I noticed that this could perhaps
be improved:

https://github.com/chao-p/linux/blob/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d/virt/kvm/kvm_main.c#L1035

We should use a temporary variable to hold the result of fget(fd).

As it is now, if the user provides any invalide fd, like -1,
slot->restrictedmem.file would be overwritten and lost.

We cannot update slot->restrictedmem.file until after the
file_is_restrictedmem() check.

For now there isn't a big problem because kvm_restrictedmem_bind() is
only called on a new struct kvm_memory_slot, but I think this should be
changed in case the function is used elsewhere in future.

Ackerley
