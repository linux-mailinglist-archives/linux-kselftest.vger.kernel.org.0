Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345106ACC5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCFSWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCFSWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 13:22:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DC472B26
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 10:21:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536d63d17dbso111749737b3.22
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678126886;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iEqL1sRXXUUipU89KopP3jfSXVAkpl87qkI08UTI3E=;
        b=oB0wnaSJtwX+0lcCU9DW4qu6SjJ1JI0DguqXoY3vPHGGujQ02oQLJq+hUSkQBgFjlC
         ddIDOXyB9pt59N553ad71OzTXCkY66CF8gALlRKze+iiXAuTJ38OyJid5bcu49Hr6uIt
         z+vy068vZGYiAm98THcBOSWUFJusrdIItAov1xCL7WeliApGopYhxftgFerMJM622gaV
         EodhmpnC78AULzLQndudO1kW3Qb+DfcX0PtHI0Pj8Q4i2TF1luzXwZun8hQE8KY6/+n1
         BGfxFfbLImCOnhkKhQZhgHt6Dj8sbH8dlxX1Eaohr6+flF8nrofYhzRdUKJTQVywWPsj
         8UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126886;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iEqL1sRXXUUipU89KopP3jfSXVAkpl87qkI08UTI3E=;
        b=VRF2zzNa2EHv8hWDcckPhDZ0PNihoZIXU1Qp4dSz6wM4dtTMKgyCImfyFpO63QTk1l
         OXiYXD+XXv01Jr5cW6XFf0mkux2xy4aVEFRzn9dWeuwHtJ/BP3C4qRXcvBFk+MXIfXsL
         S2M5aZkMIXJouC+UvIFV7yatdhZLnhuSI0nV3MpPZbBx9fWnZliXdhlM/dAPXWfvPG+y
         g1aNtVsSye9cvXTWCSiL6b11/pCDwPKlhNNSQUgToDtcrO6b4HPRWlbnx549LsjmQn10
         p+OzC1eO3coQOTHFa8Q3TknDwKKuXh45K3Uzjfwr1cleNdC99M971Go7+eMIuewBNenG
         iXcw==
X-Gm-Message-State: AO0yUKUaNCnshH93wJHX8pU9WSwRDqcGadwoQKdFNEZ/k9Y9FbyzY1hj
        OEB77w+4g5JZLl3gsN1PhrgGPYI+Niy1s9KRsA==
X-Google-Smtp-Source: AK7set9VjUIQRKUfKhl5EAU+AC5+yYORLd3u85S1Godj8ayXMTQd2dJ73n9uq3LQ+12XZzFslj/aPvyghSFUNeCo+g==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:145:b0:afd:2ef2:33c2 with
 SMTP id p5-20020a056902014500b00afd2ef233c2mr4905957ybh.2.1678126886154; Mon,
 06 Mar 2023 10:21:26 -0800 (PST)
Date:   Mon, 06 Mar 2023 18:21:24 +0000
In-Reply-To: <20230222025019.GA1628054@chaop.bj.intel.com> (message from Chao
 Peng on Wed, 22 Feb 2023 10:50:19 +0800)
Mime-Version: 1.0
Message-ID: <diqzlek9spuj.fsf@ackerleytng-cloudtop.c.googlers.com>
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

> On Fri, Feb 10, 2023 at 11:59:23AM -0800, Vishal Annapurve wrote:
>> On Tue, Jan 17, 2023 at 7:11 PM Vishal Annapurve <vannapurve@google.com>  
>> wrote:
>> >
>> > ...

>> > > Last question, do you have a list of testcases that you  
>> consider "required" for
>> > > UPM?  My off-the-cuff list of selftests I want to have before  
>> merging UPM is pretty
>> > > short at this point:
>> > >
>> > >   - Negative testing of the memslot changes, e.g. bad alignment, bad  
>> fd,
>> > >     illegal memslot updates, etc.
>> > >   - Negative testing of restrictedmem, e.g. various combinations of  
>> overlapping
>> > >     bindings of a single restrictedmem instance.
>> > >   - Access vs. conversion stress, e.g. accessing a region in the  
>> guest while it's
>> > >     concurrently converted by the host, maybe with fancy guest code  
>> to try and
>> > >     detect TLB or ordering bugs?
>> >
>> > List of testcases that I was tracking (covered by the current
>> > selftests) as required:
>> > 1) Ensure private memory contents are not accessible to host userspace
>> > using the HVA
>> > 2) Ensure shared memory contents are visible/accessible from both host
>> > userspace and the guest
>> > 3) Ensure 1 and 2 holds across explicit memory conversions
>> > 4) Exercise memory conversions with mixed shared/private memory pages
>> > in a huge page to catch issues like [2]
>> > 5) Ensure that explicit memory conversions don't affect nearby GPA  
>> ranges
>> >
>> > Test Cases that will be covered by TDX/SNP selftests (in addition to
>> > above scenarios):
>> > 6) Ensure 1 and 2 holds across implicit memory conversions
>> > 7) Ensure that implicit memory conversions don't affect nearby GPA  
>> ranges
>> >
>> > Additional testcases possible:
>> > 8) Running conversion tests for non-overlapping GPA ranges of
>> > same/different memslots from multiple vcpus
>> >
>> > [1] -  
>> https://github.com/sean-jc/linux/commit/7e536bf3c45c623425bc84e8a96634efc3a619ed
>> > [2] -  
>> https://lore.kernel.org/linux-mm/CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com/

>> List of additional testcases that could help increase basic coverage
>> (including what sean mentioned earlier):
>> 1) restrictedmem functionality testing
>>      - read/write/mmap should not work
>>      - fstat/fallocate should work as expected
>> 2) restrictedmem registration/modification testing with:
>>      - bad alignment, bad fd, modifying properties of existing memslot
>>      - Installing multiple memslots with ranges within the same
>> restricted mem files
>>      - deleting memslots with restricted memfd while guests are being  
>> executed

> In case you havn't started, I will work on 1) and 2) for the following
> days. As a start, I will first add restrictedmem tests (without KVM) then
> move to new memslots related tests.

> Chao

>> 3) Runtime restricted mem testing:
>>      - Access vs conversion testing from multiple vcpus
>>      - conversion and access to non-overlapping ranges from multiple vcpus

>> Regards,
>> Vishal

Chao, I'll work on

+ Running conversion tests for non-overlapping GPA ranges of
   same/different memslots from multiple vcpus
+ Deleting memslots with restricted memfd while guests are being
   executed
+ Installing multiple memslots with ranges within the same restricted
   mem files

this week.
