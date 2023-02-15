Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97706987B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBOWUC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 17:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBOWUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 17:20:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A525941
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Feb 2023 14:20:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r17-20020a258291000000b008ee1c76c25dso17543ybk.11
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Feb 2023 14:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tackwuG/F1uUw2shSdLvOMCubtb7BVNrkS5j3Rmqig=;
        b=BiIVTKo+oRsRYs5PGNGGxSWSBS81pUEDiLPLdFaEfuhAnAwjoxRKyrPx2VEeDif1lF
         AWB2m3YdWAcwZuextaFaUcN0nj8+QsEWHdILIsy9FWiWit3TcRPNISNeFXdYmsqj+ItU
         sT8LsAqp9Zgpbm414EBsVhL7xMLV4WX+XXwMvrRVzKLcUVBiYfSNyZ2Pxnvs8EHQSCsk
         oXM+3bp20psx6qGMu44tmz6tr9ejspgADydz5JASRCIYfA7X3+keyVGSFJfYVqD4/jXH
         z4qKGzO2nnoDRDpAe0jWqyjUaXvPnANxMZRf0Gk0cGgTGg0xkd9x/CGltwrOyNu+qBfa
         S0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tackwuG/F1uUw2shSdLvOMCubtb7BVNrkS5j3Rmqig=;
        b=YFw4EhFyN3WG5wg6QHY2RdV+jr0D+MBpJYvRY5FIjJ5u5xu2sUeYqn472mOwFn+yi+
         VlQ3Ki2V5a6d4NSnDIcAhdXZCUnLdeLzbI0ccOmblzBwpTK2tZX6XGBkf770kZxp8Dre
         VBj0hs5ga6veqMiKmWdbJDDj4RCPp2Lk/1LzeQoJgD7rOhyiMFW0/9isK+LBJcC4nEev
         ZylfKGm5+US3awi9La89zmQRtuyX5Ovb/DZKfU5cdtvwUrJH8FGVmhU6wK8hixOsxTA1
         5NSX05MjW/Ez4r2HS3Ib2fshZr5jX2sOf6AUDQWk5HjkAUmsNwq4mKRbAU1up1/rH5/p
         c+LQ==
X-Gm-Message-State: AO0yUKVcATHoiGnwMxcqZE6rcLH3/1s/7gN0UsC+viDrmDETtUT5TFgY
        OsFy7GW9Pvo0nTZaDeGMF6rJJ6sLRv0=
X-Google-Smtp-Source: AK7set9Cwqj8GnWWxS2ZBp7B1pGPPs7Hgmdno6XbhLtsks0q4RGqhP0n2QnyiauxLaOJJPpgxSmDeqkG6Ew=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:138c:b0:855:fdcb:446d with SMTP id
 x12-20020a056902138c00b00855fdcb446dmr3ybu.6.1676499599509; Wed, 15 Feb 2023
 14:19:59 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:19:58 -0800
In-Reply-To: <f3c1ea27-ba90-171b-a336-8da86ec98900@maciej.szmigiero.name>
Mime-Version: 1.0
References: <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com> <f3c1ea27-ba90-171b-a336-8da86ec98900@maciej.szmigiero.name>
Message-ID: <Y+1ajq5PiGgq1q9Q@google.com>
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Ackerley Tng <ackerleytng@google.com>, erdemaktas@google.com,
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023, Maciej S. Szmigiero wrote:
> On 15.02.2023 01:50, Ackerley Tng wrote:
> > To fix this, I propose that in vm_arch_vcpu_add(), we align the
> > allocated stack address and then subtract 8 from that:
> 
> Note that if this code is ever used to launch a vCPU with 32-bit entry
> point it will need to subtract 4 bytes instead of 8 bytes.
> 
> I think it would be worthwhile to at least place a comment mentioning
> this near the stack aligning expression so nobody misses this fact.

Heh, I've no objection to a comment, though this really is the tip of the iceberg
if we want to add 32-bit guest support in selftests.
