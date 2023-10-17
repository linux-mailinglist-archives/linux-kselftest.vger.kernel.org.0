Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC47CCA0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjJQRoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQRoB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 13:44:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309D90
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:43:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9307034a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697564637; x=1698169437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=V69Xhb726C1trycCyqT0BVZ/VbZtodxVgPxcxatNYs+Il+6UQ3mDlsIjiHG2VjRb7J
         exHIlcKNTXrO2AF3lJ7Td8WXe7Dj0Orib5Byh/GBigmNOKd8jZb3h/+P7HeW+8rFBeTd
         DE+4S7uphZuNqdFmgzB4ta82fJsdh+LbMpn6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564637; x=1698169437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=cPdZaR6NAqzjsMEHafZ3HFnbozpHBnvKTja0Th8nTBZrQCcv3UNFrQuy5oxNa9Mq0M
         44fZRvIRscYLzs7IRoVkfyKiQznsoLLd3PcsOedKig1GK+2RK8FQA5Rgpn6JEDqMAr5a
         y8eHZ5aay8bGb/+K/1f7JXOH9hxLTNIWAHQCnpCF52XsHtiOOo9nmGCbInBeXyZeoPXa
         9v60p7Od2m7KBI2syj3RklDraldUR0ju1cvdNFj7O6nC1tKlE6YwmrLA79OFsiHncBs8
         2prFULll66gdnb8/qPjK8CjESLYOW+vZC56BJ6V27lVqaR+hcEnOWFwQ1xLrno/p5TOP
         aDJQ==
X-Gm-Message-State: AOJu0Yz+CNj7oESQ+AkefxSDGBd6BkARp95gRAb7qD47iGw5XjwjUz0E
        f/h6K2WSG+RGObXTEvPlVrXFR6XiG6D4WyfM7QGv8ZGA
X-Google-Smtp-Source: AGHT+IGQZZBQLWevyb/AtUhWuSHBbeO34UiSNfRDpEjJyqMc39xBzQCuMxCMGg5Q0YBK0CqzwKe6TQ==
X-Received: by 2002:a50:c303:0:b0:53e:7fe:b856 with SMTP id a3-20020a50c303000000b0053e07feb856mr2435191edb.15.1697564637144;
        Tue, 17 Oct 2023 10:43:57 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b005333922efb0sm1548681edv.78.2023.10.17.10.43.56
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:43:56 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so5581405a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:43:56 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:9bd:8cfd:e588 with SMTP id
 bu6-20020a170907930600b009bd8cfde588mr2685824ejc.27.1697564636390; Tue, 17
 Oct 2023 10:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
 <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
In-Reply-To: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 10:43:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 Oct 2023 at 10:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, there is only two kinds of sealing that makes sense:
>
>  - you cannot change the permissions of some area
>
>  - you cannot unmap an area

Actually, I guess at least theoretically, there could be three different things:

 - you cannot move an area

although I do think that maybe just saying "you cannot unmap" might
also include "you cannot move".

But I guess it depends on whether you feel it's the virtual _address_
you are protecting, or whether it's the concept of mapping something.

I personally think that from a security perspective, what you want to
protect is a particular address. That implies that "seal from
unmapping" would thus also include "you can't move this area
elsewhere".

But at least conceptually, splitting "unmap" and "move" apart might
make some sense. I would like to hear a practical reason for it,
though.

Without that practical reason, I think the only two sane sealing operations are:

 - SEAL_MUNMAP: "don't allow this mapping address to go away"

   IOW no unmap, no shrinking, no moving mremap

 - SEAL_MPROTECT: "don't allow any mapping permission changes"

Again, that permission case might end up being "don't allow
_additional_ permissions" and "don't allow taking permissions away".
Or it could be split by operation (ie "don't allow permission changes
to writability / readability / executability respectively").

I suspect there isn't a real-life example of splitting the
SEAL_MPROTECT (the same way I doubt there's a real-life example for
splitting the UNMAP into "unmap vs move"), so unless there is some
real reason, I'd keep the sealing minimal and to just those two flags.

We could always add more flags later, if there is a real use case
(IOW, if we start with "don't allow any permission changes", we could
add a flag later that just says "don't allow writability changes").

               Linus
