Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3C3AB7D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhFQPrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhFQPrc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 11:47:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724FC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:45:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r5so11310261lfr.5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PIz2TaIUWVoaOhj01hoKWnDrlEbbHPMNsId5QQRgVk=;
        b=kK7POj3fWrdNp5TQ/g3C2HbiICwLbyWBlPreXKzcvrqAPYwo5KHxj2hz6zacIzW48g
         aAWKreLHCRCbzUPm74najsUXpLcac7bKdwfZcU3+QELkdEs02W87bAh8ZDdJ0ka66EBM
         XhXC61cC8GQ3WfftVjVDmxCfwTULCyLu13yZbkj1sxOpMHcMTJtyBcLE3IiuZSfj9QyL
         Zk7V0jrjqDgnT7mYuNxBqUJeicHd+u95kjqFE02S8z9QeF4aA6DC0xkfwpcBrQnEBwRZ
         reOQeIQnwupuCMmH5Pw6Sb3KO0sR5qRGw13cHIT4bOp209Yifcx7flqwWpyurqPIE8Dg
         A1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PIz2TaIUWVoaOhj01hoKWnDrlEbbHPMNsId5QQRgVk=;
        b=apU3wXHvcOfSADI7W/BdjkrFEAwUjKGembLvUxEUcMSQsM1kNsG+9M/BGslTICyX8c
         SArffcEYuBYCXfuKHIw2X/adQFMQo5h7rVGZQ/GeTVjSUuLx5Wuvg+5oLu433zgLR3bp
         1dR/Pxe5Ktvs2h726iLiy1EYm064+IARQng27tl8ZN/2UNmi12Amm6nG+2ebqbIADmke
         gIMHyJOfPLgwOEPpu3zIlB+1t9+LtqXDoQY86ykAIkbk7CO34CAvA8+m3jmf69rZvD+y
         8lV7IE7vw27+r2MJxs4NsfLV2mzfzrQ29X13vhddd7e08tVex+go+ro8YHXEXMinb07e
         CAxQ==
X-Gm-Message-State: AOAM530QT0SyiXqNoBNnVTRt7isbX9Yx84xrKeAIFiPGFOQn/intD1mu
        PjAjyNTAgm1iw3cxDospLjL3WUqmAzmymDTFdjgkVw==
X-Google-Smtp-Source: ABdhPJwP8tw7uaKfFVnTtgmhBu0Z34sOJoaN3DTP50XOdwnYzL4tcVKakB1bGY53u3B1KUyAsBU0zeV3DiONBmuXTbk=
X-Received: by 2002:a19:7601:: with SMTP id c1mr4591175lff.106.1623944722534;
 Thu, 17 Jun 2021 08:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrkGZzPrt0jA1iP@kroah.com>
 <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
In-Reply-To: <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:45:10 -0500
Message-ID: <CAAdAUtiAEp-+MydpamzysT4aAXvu9tvhOY0YecnQkGkWp6pJWA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
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

On Thu, Jun 17, 2021 at 6:32 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/06/21 07:56, Greg KH wrote:
> > On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> >> +    struct kvm_stats_desc {
> >> +            __u32 flags;
> >> +            __s16 exponent;
> >> +            __u16 size;
> >> +            __u32 offset;
> >> +            __u32 unused;
> >> +            char name[0];
> >> +    };
> >
> > <snip>
> >
> >> +The ``unused`` fields are reserved for future support for other types of
> >> +statistics data, like log/linear histogram.
> >
> > you HAVE to set unused to 0 for now, otherwise userspace does not know
> > it is unused, right?
>
> Jing, I think you planned to use it with other flags that are unused for
> now?  But please do check that it's zero in the testcase.
>
Yes, it was planned for future use (to support stats type of histogram).
Will add check in testcase and clarify it in doc.
> > It is not a pointer, it is the data itself.
> >
> >> +string starts at the end of ``struct kvm_stats_desc``.
> >> +The maximum length (including trailing '\0') is indicated by ``name_size``
> >> +in ``struct kvm_stats_header``.
> >
> > I thought we were replacing [0] arrays with [], are you sure you should
> > be declaring this as [0]?  Same for all structures in this document (and
> > code).
>
> In C code [0] is a bit more flexible than [].  I think in this
> particular case [] won't work due to how the structures are declared.
> In the documentation [] is certainly clearer.
>
> Paolo
>

Thanks,
Jing
