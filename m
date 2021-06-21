Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF63AF231
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFURpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhFURpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 13:45:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622ABC061756
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 10:42:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so12987120lfv.12
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfK/SVz4it+B5UPXi3JJjfN4xS2rz4IlLdh/dhi7P/A=;
        b=pywx1GKnLV8rMPGg0yESPQxjjJELUUA6eFGxQfp1SLreFtlNjvMnVkBKCsMTmOd55H
         L2Ov1NYXG6PlckYJH8Gw//+mcOBRMDwUXKZ+OXAi5Nyj1KRLWBLsJCtqGFb1mQ50QAep
         +66Iks8s9xqkwilngZ/CjQPCJsYngQFefHmEiKXBRFcuGdGgcDy7nbwnYmWpFSIzb8JM
         Cjf5+S39y3LrfjOsEEnW09/kn8GvhArY29GOk3d0VywwjXhx383+3K6zA3KOodjnfkQi
         8CQsP6Ze09t1BHzCBmmEOfUrgWwOaLawqHrTy11NMe7lYNZNHRIg3ZSNWKHZDD1fW8kp
         ZZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfK/SVz4it+B5UPXi3JJjfN4xS2rz4IlLdh/dhi7P/A=;
        b=VNACJx1KjcaqwNq5LdNwOb1Wi6VYjgDQeo5l/6WfJC01jKRgIyEPjDFQmjvKJEhuch
         9N5s97s1VHPLa1fIimlM5xU4StHheStu3gabLHl3BA6f67uSBRaGOCtrjnw85ygFt4oz
         iqvwCiyIPuVdL9WeGsKP9t97UYVE949iuO934/NrFE6EPVuGE1SR0PztW69WGGfZgGhk
         GrDgZcvIY5XpfJ83AAd5ZB/cqp3eDCmjfFLL6WYdVg0K31oE9ef/d00zprYGG8JHYLxz
         BF9d/8pby8UwW478RWd/qP+sQaKMOkTJc6JrXDa+RQu8obZKC1cyLzkgEYWEGWHawzod
         Oolg==
X-Gm-Message-State: AOAM530xLlpSfvDJ5wLQ6h8NMq5vfB7RtZUY2fwTty4qnm0JFyj+F6OS
        dk/NIyJhkCUoSiVGgEL2Q7hPnUul0cEm6TVJFUm/dQ==
X-Google-Smtp-Source: ABdhPJze+ab86EoUTOPQeCvTUOFZdayN8Zdi+mpGgTYzSXakq0/1emu/tNIwi9+QdEI2rk/c2bFMigguUMCYbOuXxYw=
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr15161030lfu.473.1624297364420;
 Mon, 21 Jun 2021 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
 <20210618222709.1858088-5-jingzhangos@google.com> <d8bb52e6-3d1c-7008-388f-699f1a872e80@redhat.com>
In-Reply-To: <d8bb52e6-3d1c-7008-388f-699f1a872e80@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 21 Jun 2021 12:42:33 -0500
Message-ID: <CAAdAUtiC68ViKRH=1_N9VPzNszZHUN5Yc0GNXJ3BFL+8=tz0Gw@mail.gmail.com>
Subject: Re: [PATCH v12 4/7] KVM: stats: Support binary stats retrieval for a VCPU
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 21, 2021 at 11:46 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/21 00:27, Jing Zhang wrote:
> > +     struct kvm_vcpu_stat stat;
> >       struct kvm_dirty_ring dirty_ring;
> > +     char stats_id[KVM_STATS_NAME_SIZE];
>
> I think stats_id needs to be part of the usercopy region too.
>
> You can also use
>
> offsetofend(struct kvm_vcpu, stats_id) - offsetof(struct kvm_vcpu, arch)
>
> to compute the size.
Sure! Will do.
>
> Paolo
>

Thanks,
Jing
