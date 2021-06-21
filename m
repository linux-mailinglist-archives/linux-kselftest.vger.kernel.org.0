Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE23AF8E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jun 2021 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFUXAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhFUXAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 19:00:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBBC06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 15:58:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c11so27448322ljd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVsPgvw6YZtv9/khL7FcPl2CChAbrBHIUpUhwR9h/bo=;
        b=FH/W93ij16UB6P9ZMApoTm7j34Ngovg2YUq2ckZGJNfgdblozN5ZKntY1V1rAlrbQx
         Tv1JUz3kheA+LeiAPkeTfLPb9vDUeteRtWoadPqdUAgOZlXHhEzrWHXXtWgFNk3CHH2P
         g106EMc0MFE8EJskX/yuN+K+5HgTaQ5rsYYju0Qvkoe0Zgc8IwPMO1OEXrewgqCsl4iv
         Qg6UhttuCVW7bBt9xwFnSYV5J4t45YoyMo/CCtoCdTL5P3Ub6OzzR1mrOPh0AT4v24pF
         XOJebkOxiDFZF/3FudatA/mH3B1DORbChBvU1XNg8hUXadTURzA2NYudPGR7gVPNvDWZ
         7pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVsPgvw6YZtv9/khL7FcPl2CChAbrBHIUpUhwR9h/bo=;
        b=TyvHfC6o7yXir68grdljj8xvsJw6oeO6k01V3UVTDyssclON11FJcEqXSfWaVANscy
         3N0AcoY4lOKTnRfhhwiXhvvAhou3X3XHW9rIKBgWDdVDo8akqE/LiwrZmZ3F3ghx3CnP
         cp8FU9e/iK8IPhjRy2EFir97Bs5oIDIxn8u6EXVauHTitUo5FVgSm/lI3VDEbwe6BBD1
         kBKrvYo3bP0eROwj3ARqlyafAPNVg2s6HT5fSx9r1NrV+AkWcN/KYEwXmcceSSrkcxc/
         u3qHD5b18PMFyEMmdrurYaNMllfZx2zQ8CqxVTdc+BZKKt8p/JwkyKiKtftvOReIVQeK
         cvyA==
X-Gm-Message-State: AOAM530ig80IsmQnmDb5EmDkBXa9YL/MFoAqJX5lcovqQumoFI+14FFP
        +3eP5MtWbcvywwGylZvHlhDFzQu3f5+k97370lQhGQ==
X-Google-Smtp-Source: ABdhPJzOJs9NgUC9ZiKXYdc7xSvz2B+wmeDG/p0spXP3KgLdL4+SFKbUTkdrgy+jkG55hkyBhNUiglU1Rb6f6QzRog0=
X-Received: by 2002:a05:651c:150a:: with SMTP id e10mr455097ljf.215.1624316299083;
 Mon, 21 Jun 2021 15:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
 <20210618222709.1858088-3-jingzhangos@google.com> <0cde024e-a234-9a10-5157-d17ba423939e@redhat.com>
 <CAAdAUtiL6DwJDWLLmUqct6B6n7Zaa2DyPhpwKZKb=cpRH+8+vQ@mail.gmail.com> <aa1d0bd9-55cf-161a-5af9-f5abde807353@redhat.com>
In-Reply-To: <aa1d0bd9-55cf-161a-5af9-f5abde807353@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 21 Jun 2021 17:58:08 -0500
Message-ID: <CAAdAUti1MreOnAXtA+jBEaq+AixmqvBEByi9G4EgDpfu63spHA@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] KVM: stats: Add fd-based API to read binary stats data
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

On Mon, Jun 21, 2021 at 5:45 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/06/21 19:46, Jing Zhang wrote:
> >> const struct kvm_stats_header kvm_vm_stats_header = {
> >>          .name_size = KVM_STATS_NAME_SIZE,
> >>          .num_desc = num_desc,
> > The problem is how we calculate the number of descriptors, which needs the
> > size of the descriptor array for each architecture.
> > Define another global variable to export the size of descriptor array?
>
> Pass it as an argument?
The num_desc can only be initialized in the same file that defines the
descriptor array.
Looks like we have to have a global variable to save that. The
solution would be similar
to have a statically defined header for each arch.
So, keep the header structure for each arch?
>
> Paolo
>
