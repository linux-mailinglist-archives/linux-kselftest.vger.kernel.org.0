Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF043AB7C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhFQPok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhFQPoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 11:44:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BADC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:42:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j2so11271875lfg.9
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA9TZaqOl3zy1dJIWszjf8FGUKT8ntsayRnFvsMmeKE=;
        b=rjGGx3hDJcU8YgExYPvnRbDmEiwqIoA9VdAEle1149lM7CLqEmmZ5IGx5C6v2xN+BK
         erAId3gLrIx3qvunWhwnAkobhgz7xQLbphUZnztf54+GCy7Rt9jJnsQ4GTCIxooMQ6Nh
         ypsifEZBI7FXjvlJpbG15frf50E6gOgOxPY59sppGE5Gm3EVOP58JfTBQFuDrNsThg4g
         pW9dY09XQK2DWc9As8xzDId9FTmLnsz2UlZubPkc0QCrvBCN+9v6DMkPxvgT1sLw2hcx
         nQ6ahn5n70P/Vnyg/uULHRQf/KKgKU03kAOJCg30VCluDTMdCeu/RDCuXgsbWPpmgNDS
         NGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA9TZaqOl3zy1dJIWszjf8FGUKT8ntsayRnFvsMmeKE=;
        b=iBJavSeGRWVPeO6mLnEAYN3McP1oVzyDvYUK6RDjfnGwICSYGHB0C7ro+qMmn6h7Wv
         EbJBoUpQ13QroeDczYZtZNY1lezrzCMU7kSgRxWZkEPV3dOjpAtU9tsbtvABQjG6nKa8
         Zh/pSM63T1nxiBzbUBe888p9td1E1yIQYxMj/rh9PsWXrrZxchwozaYhy5YrF6z0n0VC
         15gJqVh+yX8//xbXTdrfv0gLFzek2rG7yNVpywDeS8GBOLflatYnKbnLqMyQPO5Ei9hs
         03TZGyRRQ4Fpg7GD/AM6YK4i/QoBgh1OkIpubm64xuVtyxoZt81Ga4+RPZUnkUogJdO5
         mLQg==
X-Gm-Message-State: AOAM532KtbOBZzy75kJEFIlBx/4TzKuYtj+9HRfJK+TQ3yYXxFi51gXr
        xHZ/nGHnY/Eh/Z5FePkMrvSAl6XKltByRnYfhg+uNg==
X-Google-Smtp-Source: ABdhPJxIgtHTYijVD1CpTmwKu7GF1JsNiAyO8otRBPAhPiGuR1/vRj2f9gVDMVv2mwH8Qtqe0siOJfwZGA+WbyKt0Rk=
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr4638106lfe.407.1623944549075;
 Thu, 17 Jun 2021 08:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com> <YMr4rArKvj3obDEM@kroah.com>
 <CAAdAUtiiQ0304vWR3Zm2XUKz374W4LY3=qdrFZCsQ27VkqMn9A@mail.gmail.com> <5ae75b1b-4cba-d06f-625b-35b42f11ac03@redhat.com>
In-Reply-To: <5ae75b1b-4cba-d06f-625b-35b42f11ac03@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:42:17 -0500
Message-ID: <CAAdAUtigLr+n_d+XZ3FUUXSSb7PmSFNY5+XKATQp2r0s4xiY8A@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats data
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 10:29 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/06/21 16:56, Jing Zhang wrote:
> > Actually, it is really not easy to separate this change into two patches even by
> > following Paolo's suggestion. And it would be a surprise to userspace to see
> > only VM stats, no VCPU stats.
>
> That does not matter.  Having two or three patches is useful because it
> makes review easier; they will never appear separately in a release.
>
> Paolo
>
Cool, then I'll separate them.

Thanks,
Jing
