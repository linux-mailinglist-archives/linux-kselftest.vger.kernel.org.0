Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014DD3AB74E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhFQPWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQPWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 11:22:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428DC061768
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:20:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p17so11167486lfc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nxSzCxRIGKeYpvFJwHnokf+lsLXzTQKnVZehNuKBfY=;
        b=v73zJk16lVzUG7QbbkRkacwK3TUPJGuBDYnlw6a7OPjaXiFoy/Tg1SF7o+pP2VkjgQ
         GCw+WkjfIQ3l6iS90jFkDddYRWl54Fy+YMR/OLBaPnT1q7EH0oEDgCPwHFRf8oPp7gGh
         W7Ec4TAFYCyuNTidERQalF9VJ9rhnKCIZeBncU5P/7WoHZpOenVDVwlRJezyVC2NtJ6Y
         vboZ+Jh+7e1OhUpnKBfhBMPZL2co2cGDoDioEPRVmBRw4+jEILLh2FWrKa/OxCOxZ34S
         /rw7UTqce3bTc65+uzu2YO9pLXUzTgYikYTMftRKjr074dSbh8dedXtXArBgTf7VXUpm
         YOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nxSzCxRIGKeYpvFJwHnokf+lsLXzTQKnVZehNuKBfY=;
        b=a7ngNb3rnfm9lYjDcL9KO2wqatMXK/s7eHSPX1zPVjAk2OLlOB3jqaK4HFAMaR50jU
         x/OtdLSPcjUTlyVVNX0G3TSOPUXFNvUDjSQlc4DP4omo1k19XyoW0x3MG6oEp6O8e7Iy
         Y8vrTWN4cIGBN6P6Mbx/qTwgMfmSyvPWuUXQd74U07kYVZyMd8nwQGDwcC+o8peFopqW
         IQE3ObX/pPevJtBz0Ep1pegysjT2f+9WIDGk7MRrrufCADzhUGLn2yn31ayhp7DgDK7Q
         +Nmwb+Mk1d9sNEWn5Tn0BMru/d0L5MVLh41mpVi8FyKsrEJKPDRKlEtiLEsqYFKnuAqx
         tvFQ==
X-Gm-Message-State: AOAM532B6mNUH4b2U5uXJF1mnFgNE2a4YAjr2ipvpbFiljR2P3F4nLsQ
        cgwX+07ZaBCqEA2N6Ygfjk5m2WGVyGnvAfN7i0sxI+lv0F0=
X-Google-Smtp-Source: ABdhPJxKKizWi/fGNn+9wpt69Ewj2CzuOybJdiyg4e/t3EuxZUFb779j6T3WEp//mVN3Ae7BamP0hcGF5jtDYBl/+0Y=
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr4392667lfq.178.1623943239558;
 Thu, 17 Jun 2021 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrkGZzPrt0jA1iP@kroah.com>
In-Reply-To: <YMrkGZzPrt0jA1iP@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:20:27 -0500
Message-ID: <CAAdAUtik0Yw+4=4Ld-DJSokNzvdpa-tsxkqAdBCAb-C=uS0-sA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

Hi Greg,

On Thu, Jun 17, 2021 at 12:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> > +     struct kvm_stats_desc {
> > +             __u32 flags;
> > +             __s16 exponent;
> > +             __u16 size;
> > +             __u32 offset;
> > +             __u32 unused;
> > +             char name[0];
> > +     };
>
> <snip>
>
> > +The ``unused`` fields are reserved for future support for other types of
> > +statistics data, like log/linear histogram.
>
> you HAVE to set unused to 0 for now, otherwise userspace does not know
> it is unused, right?  And then, really it is "used", so why not just say
> that now?  It's tricky, but you have to get this right now otherwise you
> can never use it in the future.
>
Sure, will do that.
> > +The ``name`` field points to the name string of the statistics data. The name
>
> It is not a pointer, it is the data itself.
>
Will fix it.
> > +string starts at the end of ``struct kvm_stats_desc``.
> > +The maximum length (including trailing '\0') is indicated by ``name_size``
> > +in ``struct kvm_stats_header``.
>
> I thought we were replacing [0] arrays with [], are you sure you should
> be declaring this as [0]?  Same for all structures in this document (and
> code).
>
The reason to declare it as [0] is to have the flexibility to change the maximum
length of KVM stats name. For now, the max len is  defined as 48, which can
be read from the header. Then the userspace can get the length of descriptor by
adding sizeof(struct_kvm_stats_desc) + 48. Whenever the max len is changed
in KVM, the userspace would not have to update code to reflect that.
However, if we are OK to restrict the maximum KVM stats' length to 48
(or any other
number), we can just declear it with [] instead of [0].
> thanks,
>
> greg k-h

Thanks,
Jing
