Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01CA3AA2D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 20:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFPSGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhFPSGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 14:06:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27480C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 11:04:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j2so5741371lfg.9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QL+p+jTvyBCoLxHGaGA1zRf3kZytampV5ZR7Ur3gf3U=;
        b=fc72JuPUMioH4fKcNp+iPSBFNFwPDf9vgPJdUSG3pw+STeGrnlJ9Ykw74FPB2eMydA
         Sqz9/CE4otVTzoV3HvOTnxoTeIPshc58RynzPKMqktwF+8M37v22nUpbn2fUK4p80EA/
         u+jDv0yLybYMqBYCsGGy1+uAjdoOYIPiVI+GMwvC8MVkrgIbkzWddLjLMtwjfV7JUFlx
         tMRPD64MsgNUMHxn1FEeM87Wj3TDYYrkOaoTd9AAiTHYZ7yBM0mQ9RRNy99pEcalkMNO
         bgUfYhJ4wiiU1aq2mWNaQr4ASs7AcbLZbwp/pDFZNTInyx4sL7X4HU1iZ2JHMIh3xvXt
         NHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QL+p+jTvyBCoLxHGaGA1zRf3kZytampV5ZR7Ur3gf3U=;
        b=CDXCds17y/z4tV2gKH+I9c9iPKlwN8mwYBmAkfxEaV9wcJG57Pttxn/sLbWczpI+/b
         LgWYACG3yPfYaGKoGIVBzAqiEn66q45JY/vjJXD3LfppM+iZhpXWYA+k5BrCDgPIhEoj
         kxmvwXToX6W5Kutkz6XSTpxsXil6yYlkhkcX1ikITXp9XNe99fWkRj9oSfT05AZlUJaw
         Td0A/wfNAIkVWolYjPL6Rvs4xMKFTv5egnvGWLJqaFMC6mmrtRKPvIGSltNSH+Z9fNoO
         dOAx1f7bsnx9Mm8lYrVtiv34J4Ha3k79w5ofXyMbkX7n4YiXl6Pgp+hmeUvaea3NbE0u
         xKEQ==
X-Gm-Message-State: AOAM531URASQ3OXG/ClVNwuMwD4xTcB1GTrGahQvLUivjGYaB9mztTUx
        1EYaLwRJltun7JsLHtdnX4JR75Lvi8CZMNfFSgvjAw==
X-Google-Smtp-Source: ABdhPJy4bQ7Jt4JKRNwI4lBCx0kB2MjipwAUemjUdaMvVbQnSwyfIs30xmfWtPQ46Uafcxy5ggZv35nXlECeV1DCBO4=
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr713703lfg.536.1623866679050;
 Wed, 16 Jun 2021 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <20210614212155.1670777-3-jingzhangos@google.com> <60b0d569-e484-f424-722b-eb7ba415e19b@redhat.com>
In-Reply-To: <60b0d569-e484-f424-722b-eb7ba415e19b@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Wed, 16 Jun 2021 13:04:28 -0500
Message-ID: <CAAdAUthShFyjhsdAPVhUSf78QsiBCfD1rbcJXhFZ5BsQG2f4Mg@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] KVM: stats: Add fd-based API to read binary stats data
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
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 16, 2021 at 12:12 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/06/21 23:21, Jing Zhang wrote:
> > +     /* Copy kvm stats values */
> > +     copylen = header->header.data_offset + size_stats - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = stats + pos - header->header.data_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
>
> Hi Jing,
>
> this code is causing usercopy warnings because the statistics are not
> part of the vcpu slab's usercopy region.  You need to move struct
> kvm_vcpu_stat next to struct kvm_vcpu_arch, and adjust the call to
> kmem_cache_create_usercopy in kvm_init.
>
> Can you post a new version of the series, and while you are at it
> explain the rationale for binary stats in the commit message for this
> patch?  This should include:
>
> - the problem statement (e.g. frequency of the accesses)
>
> - what are the benefits compared to debugfs
>
> - why the schema is included in the file descriptor as well
>
> You can probably find a lot or all of the information in my emails from
> the last couple days, but you might also have other breadcrumbs from
> Google's internal implementation of binary stats.
>
> Thanks,
>
> Paolo
>
Hi Paolo

Will fix the usercopy warnings, add more explanations and post another version.
And thanks for all the information in your emails.

Jing
