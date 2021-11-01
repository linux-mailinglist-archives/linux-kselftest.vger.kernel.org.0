Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B87441F87
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhKARrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhKARra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 13:47:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC25C061766
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Nov 2021 10:44:57 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j75so18763541ybj.6
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Nov 2021 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQ6siRywOjbV4IU70GIWXbdJs7RhMmkbN5QW6jS9pb4=;
        b=Ai6GsO8fZzOL1OMi2wZJDrN49HYzmeiktfpXN4iIrk3IuRy0Kdnltpe7mYgLR3iukz
         iiFO3hNRFLIvtwkJo9wMpEopuqrf6vRqkF/lsGeewSbTk0a0rSAeUN0ze+wv56QzCtLt
         SYSsEE9rxBBuPdSUMVuq2iwXQWymsxN/nORbuQtHm3zwVybakhGjrVKQa9/RDSPHioSn
         XDdEU6mFynzoL+JP1CfQi7z0F7QeAg/yn0rLocwQk4hhdISAzf2ihIui8vklt/TH0lvh
         e4j2P+JulU6lTgzTUnR91TE46HoLBCcIP1gCjH1lVKdCKU+1JadWSjuPISJfM34xBuXS
         jcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQ6siRywOjbV4IU70GIWXbdJs7RhMmkbN5QW6jS9pb4=;
        b=nrnl508Xw2fh3NxrAD6OdANMHSye0Pt7XitiDOlX/DcJ298uu4Fn7wqepWSkS1Jx37
         lybYfQjNsLG9y2Cdi4uwt+ausLMKYbBQ2j+Ty+VdNg3P5jce1u8nBHVh8tDes3t+5tjD
         PThmdtfszmPbkQALi7QKt05OEGthjE1BgZF7nvAjO1k11jYGH4D+9k7HBNO4AMA00Xtv
         /Azs+xB/Snf1stFdlKhO53daYSLaP1eB+OwXMC9BpByNJZ2L64jn0ArGwW5L88wVSal8
         167Jcd8Y/DK1XJCOONQs5CYLe82WanTKFfyFjX8ZPje7w2EXMpIm+pc5LIWcFNZQbDRz
         qtLQ==
X-Gm-Message-State: AOAM530UmHRXAHsqcDNOxSO4YvkToptQWETZZoGStiS7oxTDXbrv7pQE
        7HhgonZ7F2y5eSneIPrazEXmuNzXN4FairoHdUwYKg==
X-Google-Smtp-Source: ABdhPJza5BtmSB67tbjUlNOP3OKzukhq2aCN5qJ6BSYvDoIp0SIYfhYjSWmseE8hq+w7kur+r3Mmc4nFqLhndPbppXw=
X-Received: by 2002:a25:c244:: with SMTP id s65mr35042546ybf.30.1635788695616;
 Mon, 01 Nov 2021 10:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-3-michael.roth@amd.com>
 <CAL715W+-H7ZSQZeZmAbbJNGKaZCNqf4VdLismivxux=gerFuDw@mail.gmail.com>
 <20211021033723.tfnhazbnlz4z5czl@amd.com> <CAL715W+kJpnx5Jax2-vtFRDNrQFsc6+YT+q5ZkWbBM7gFVKjkg@mail.gmail.com>
In-Reply-To: <CAL715W+kJpnx5Jax2-vtFRDNrQFsc6+YT+q5ZkWbBM7gFVKjkg@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 1 Nov 2021 10:44:44 -0700
Message-ID: <CAL715WK2q0yfLJ-7AQ5stY5h6NfC7PXO7kunHmw=Rp_JMt7CVQ@mail.gmail.com>
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
To:     Michael Roth <Michael.Roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 8:48 AM Mingwei Zhang <mizhang@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 8:46 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> > > > +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> > > > +                             uint8_t enc_bit)
> > > > +{
> > > > +       vm->memcrypt.enabled = true;
> > > > +       vm->memcrypt.enc_by_default = enc_by_default;
> > > > +       vm->memcrypt.has_enc_bit = has_enc_bit;
> > > > +       vm->memcrypt.enc_bit = enc_bit;
> > > > +}
> > > > +
> > > > +struct sparsebit *
> > > > +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> > > > +                          uint64_t *size)
> > > > +{
> > > > +       struct userspace_mem_region *region;
> > > > +       struct sparsebit *encrypted_phy_pages;
> > > > +
> > > > +       if (!vm->memcrypt.enabled)
> > > > +               return NULL;
> > > > +
> > > > +       region = memslot2region(vm, slot);
> > > > +       if (!region)
> > > > +               return NULL;
> > > > +
> > > > +       encrypted_phy_pages = sparsebit_alloc();
> > > > +       sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
> > >
> > > Do we have to make a copy for the sparsebit? Why not just return the
> > > pointer? By looking at your subsequent patches, I find that this data
> > > structure seems to be just read-only?
> >
> > Yes, it's only intended to be used for read access. But I'll if I can
> > enforce that without the need to use a copy.
> >
>
> Understood. Thanks for the clarification. Yeah, I think both making a
> copy and returning a const pointer should work. I will leave that to
> you then.
>
> Thanks.
> -Mingwei

Reviewed-by: Mingwei Zhang <mizhang@google.com>

Thanks.
-Mingwei
