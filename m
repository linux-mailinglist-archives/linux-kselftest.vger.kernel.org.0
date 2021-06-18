Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156153ACBA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhFRNFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhFRNFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 09:05:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC1C06175F
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 06:03:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c11so13925533ljd.6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEclsuEWMpJAtZre1q7afze1RnKMopUqEN3Jq0eFLJo=;
        b=vWbKHgBItt8O7lINA7KgYjqeNkMrhXk8Vo4/mwzHt+XzDHF8TwoTLudfyISLKu6e4E
         crEoUad+aXxFkZUoUzykuOPLXpriwUyBVa9xD/29tvlKgKsc5veLSdSs0P8uStI83p6J
         IOpxlJyoPzpIyURxXbWjcWr7jsnP6TrgAuFYCQuahJJpg/9IjrJXQVaGo6+I35vTmLQW
         2hHg/yrkx6UZ8hw+T45mpqVwes2HiyNqHTDc9ltDAtxIZ2oThwvBodTxWmAlYDJZ39oe
         zQ0v1ar5jAXbN2cs6bmCH09I7Amcqg8oZDxc1oLafArpZfJzE/dmGXxUQRHSEt4uGj35
         EDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEclsuEWMpJAtZre1q7afze1RnKMopUqEN3Jq0eFLJo=;
        b=piOi3YEFmP+Rd0faI+HgklSYwIFpocHnpZTNtRDPxhPkIF3PUQHNVfqGa39RDqqhiC
         HVHGjgz6TsvbRmLgvcX2KaC0UbT1skGCd9FeD49BSbFuq8IGcH02IC/QzffqJUQGluRf
         8kMcpmjNQbI6LrtM4xSC9VwhlZ6OOwB+0whChXAh67ONK6UOKQq63VbMbetZftqj7Z4W
         rOuakaptoP1s+VFsJSztUWmQY3Cfc6gB/A+ZF3Q1fRsbaKtivLu9x+o8QWY6g7Va1nM8
         4S+vp73HF1VGjqlf79ut5ZSsF3WCnG9bfueePibkopRd15cXAsgqVNzuLSZFwrqk1W9P
         UjvQ==
X-Gm-Message-State: AOAM532mnWF4SdYV3s0xigYrUvpw6PzII12sPWj78pQnH4FE9btLBK48
        FI7V2+kuhrRxtYJArBVGO8ocG7QQUIgbJ4ImmnzJHw==
X-Google-Smtp-Source: ABdhPJwYJQdcIEytkrMx0Wz3wvyodJYH5zp4XXjs8/9Vx6hj1aP7xcJZkVdJWvuJ4nqyknxb0IdsL0leVGFcKnX9GTM=
X-Received: by 2002:a05:651c:150a:: with SMTP id e10mr9521276ljf.215.1624021379799;
 Fri, 18 Jun 2021 06:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com> <YMxEqvKyGnZinMOS@kroah.com>
 <f2616b8e-0cf8-570f-4bd3-7ef5cbcb37b0@gnu.org> <YMxYC8syYRBhbBAq@kroah.com>
In-Reply-To: <YMxYC8syYRBhbBAq@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 18 Jun 2021 08:02:48 -0500
Message-ID: <CAAdAUticeB2Rr8g5eywPvHGGYfsXV=mNA4mNbd4thAae9zbXWA@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats data
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <bonzini@gnu.org>, KVM <kvm@vger.kernel.org>,
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

On Fri, Jun 18, 2021 at 3:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 18, 2021 at 10:02:57AM +0200, Paolo Bonzini wrote:
> > On 18/06/21 09:00, Greg KH wrote:
> > > > +struct kvm_stats_header {
> > > > + __u32 name_size;
> > > > + __u32 count;
> > > > + __u32 desc_offset;
> > > > + __u32 data_offset;
> > > > + char id[];
> > > > +};
> > >
> > > You mentioned before that the size of this really is the size of the
> > > structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?
> > >
> > > If so, why not put that value explicitly in:
> > >     char id[THE_REST_OF_THE_HEADER_SPACE];
> > >
> > > As this is not a variable header size at all, and you can not change it
> > > going forward, so the variable length array here feels disingenuous.
> >
> > It can change; the header goes up to desc_offset.  Let's rename desc_offset
> > to header_size.
>
> "Traditionally" the first field of a variable length structure like this
> has the size.  So maybe this needs to be:
>
> struct kvm_stats_header {
>         __u32 header_size;
>         __u32 name_size;
>         __u32 num_desc;
>         __u32 desc_offset;
>         __u32 data_offset;
>         char id[];
> };
>
> I just guessed at what "count" is as I do not remember at the moment,
> but obviously "count" wasn't descriptive :)
>
> Wait, what is "name_size" here for?
>
> > > > +struct kvm_stats_desc {
> > > > + __u32 flags;
> > > > + __s16 exponent;
> > > > + __u16 size;
> > > > + __u32 offset;
> > > > + __u32 unused;
> > > > + char name[];
> > > > +};
> > >
> > > What is the max length of name?
> >
> > It's name_size in the header.
>
> So it's specified in the _previous_ header?  That feels wrong, shouldn't
> this descriptor define what is in it?
>
> I'm not trying to nit-pick here, I'm actually confused now.  Structures
> that contain "headers" should have in those headers at least two things:
>         - declare the size of themselves if they are variable length
>         - declare offsets to other structures
>
> Don't put a size in this header for the size of a later structure,
> that's just extra complexity that is not needed.
>
> Think of this as a stream of bytes across the wire like a hardware
> descriptor.  We have loads of experience dealing with this with
> protocols like USB and Greybus and PCI and the like.  Let's learn from
> those experiences and not try to mess things up where we don't need to
> :)
>
>
The name_size in the header is necessary for userspace to discover the
length of a descriptor of a KVM statistics, since the size of name[] in every
descriptor could be different (increased) in future versions.
One thing worth mentioning is that, for every file content, there is only one
header, but many descriptors, that's why it makes sense to have the size of
name[] in the header instead of in the descriptor. We don't want every
descriptor contain the same duplicated information.
> >
> > > Why aren't these structures defined here in kerneldoc so that we can
> > > understand them better?  Putting them in a .rst file guarantees they
> > > will get out of sync, and you can always directly import the kerneldoc
> > > into the .rst file.
> >
> > This is a problem in general with Documentation/virt/kvm/api.rst.  The file
> > is organized to match the kerneldoc structs to the ioctl that they are used
> > for, and sometimes a ioctl includes different structs for each architecture.
> >
> > It is probably possible to do it using :identifiers: and/or :doc:, but it
> > would require running scripts/kernel-doc on the uAPI headers dozens of
> > times.  That is quite expensive at 0.3s each run, but that's what you get
> > with Perl (gcc -fsyntax-only is 20 times faster).
>
> Is that what v4l and drm do today?  That's still safer and more
> "obvious" than trying to keep two different files in sync which, as I
> well know, almost impossible to do well over the _years_ in which you
> will have to maintain these files.
>
> Let's make it easier for everyone, put it only in one place and if
> people want to see the documentation, they can generate it (it's
> auto-generated on kernel.org anyway), no need to worry about multiple
> passes or not.
>
> thanks,
>
> greg k-h
