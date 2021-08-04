Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A93E0960
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 22:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhHDUaT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbhHDUaT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 16:30:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD4C0613D5
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Aug 2021 13:30:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so10512819pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Aug 2021 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ay2VkZp1QSgjgUuaKlnv5Qoem62OrDMpCDFTC9mEKKs=;
        b=h7uefQRXljacHpvf0siGwYGLJf0aZg9wL7lcZZD8SAP8NjZ/OatK0tjPjxlwXe7IMK
         7xlwDJ96zOb5RrRMABauPXT1M/okb7U1zyItTZ4Qvh9n+DzioYOhUbOveIWEqhahz1oF
         WzK7+e+VBfH+31jV+jd76JPm2uM3+y24jwTti6Hs+LAhbLSlPQd7EbC3/aCstk6R19Xw
         q1IMZV8pNKwyIHlKt/fr0tSbGMYktdvBSycYWVNIAENTj39hF5VkmONe29adwj35Zezd
         NG070KRGEFXwBno8lVsOlGDUqHcxynthQu6Y/1kZxqPcG2jQwGHUu5XEr8J79OHlbOqt
         Px1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ay2VkZp1QSgjgUuaKlnv5Qoem62OrDMpCDFTC9mEKKs=;
        b=dwQxtdt5TR+ZfzhX93Ff+FAeVVcFR7yogvX89V7J38I9bK7Y3M8kQF1mbCFwIJTgao
         0iUVGwYdKIiXzyS9qEut4rfDOulur/XmLc3Ry8dCjlO3UcsF8kwNpXng1rF5oKyHQPME
         9voqFma0fN3LzU0xLe8hJiEGpHXA/gf9rvdu/DIpBST0eqo01LXefVgdx1PYKyzH2UR/
         /n71eqWp17IcPHMQg2kIhwswwbBn8ZGxeaNtRW2g2WkMfaG5xdGqBeSzERWTgMG8ajHy
         45kH+a+mUxSmt7YR1aKub0gsTO3rjDQ/vPRkloCpkcuOo3dSzQZqXLp65833KDQSPuBA
         BnMg==
X-Gm-Message-State: AOAM533r0nlV/TxJ8RSsDl6gRNzogjSLlqhq5DjxBKh7K+I/CEeR6vV+
        x2VxYKPt6Cox1A0fpkV4XIbPDAgCULj8Yp+R0AeJEg==
X-Google-Smtp-Source: ABdhPJy/uPKrEp0nPLVvxOUcb/sdhHBtDi1SSscb0nok7vJYVZmxgN45gHrXgDwd/ykefzZ6jcQJRES2Sk1Ld1I48jc=
X-Received: by 2002:a17:90a:1208:: with SMTP id f8mr11602671pja.73.1628109005619;
 Wed, 04 Aug 2021 13:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com> <e1651746-aa46-31e7-e1c0-99f3faaf1586@intel.com>
 <ede70f11e713ee0140c0e684c3d46b3aa1176e5e.camel@redhat.com>
 <42a812a9-7f17-2a26-d289-1f921408a469@intel.com> <c82a3abe00d387985ac806c8ff062cc29e192bbd.camel@redhat.com>
In-Reply-To: <c82a3abe00d387985ac806c8ff062cc29e192bbd.camel@redhat.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Wed, 4 Aug 2021 13:29:54 -0700
Message-ID: <CAAYXXYx_CFKBhFjqfz_wyh6bPPbWpTPCDfGmmLGqiugvfqA3Dg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, linux-kselftest@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thank you all for all that great feedback! I will include them in my v2.

On Wed, Aug 4, 2021 at 7:46 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> > > > Can we pass KVM_X86_LEGACY_VM (whatever name when it's upstreamed)
> > > > instead of 0?
> > >
I was originally thinking of doing this but Sean has suggested that we
should use 0 to make it  arch-agnostic for creating default VMs.
+Sean Christopherson : What do you think?

>
> KVM_X86_NORMAL_VM is a very good name IMHO as well.
> Thanks!

Sounds good to me.

> For example:
>
> struct vm_options {
>         enum vm_guest_mode mode;
>         uint64_t phy_pages;
>         int perm;
>         int type;
> };
>
> struct kvm_vm *vm_create(const struct vm_options *options)
> {
>         ...
> }
>

I liked this idea, I will see if I can include it in my v2.

Thank you so much again.
-Erdem
