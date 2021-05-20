Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538F38B7C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhETTsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhETTsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 15:48:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F984C0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 12:46:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so26228554lft.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CoNBU6S+QMKlmES2bhHvQHlgfmNmuwQ2e+CyUIRdpY=;
        b=tgDnvxI1eMTQHE2YH0Yhoqgf/oTEYx85ecLpE455RjCwvhIGF24sICQiSUrE8rac2j
         Q06ws3HwP+UATSHKZt62RjDiXBOWmJnMfnP6S0getzXyupOg72piqwUwWuNrIOMyQb7C
         pOuJOtAn+ZO5xuHl1Nd5mHSrN8xdo4xlVD/KfIJmVZ25UlzaBRPiqlisE2adc8nDioRP
         roHZqb9nqK7eS6R9Hny8D47BpAfwjDkuwNyYEMcQscIUbrhJ4lontbaDPPk4K6vzXew8
         TsaOiNins2NsIcjj+Pjf5n5dJgdbWGxuyZUIsg7iodsATjtLFFgV25QPay5nBjWE5EX6
         rykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CoNBU6S+QMKlmES2bhHvQHlgfmNmuwQ2e+CyUIRdpY=;
        b=Cu6z96NPqBvTNNCiiLN2YwKOZq16h9mqtRA7dz7yG2xpGHRaMgXfmhO4X1bGdJpzRg
         LGkSKsDcr9JJ6wEvbEVrcHcsJVj5hl2b5W6u+vUpakwVAFevOsd6K3BBj2I7Sv5EM56k
         4EeIMYRM5VDaC8AmmwLNM8XLfZjWx2jP++vc34vlFXrmUBWp0p95HlJlcusPU+vYx3aP
         rrqN8b6oOtsuL0WqEQcoZbx4M6VoaRFu57Ls4RQ0ZFg+YuOex8MFPIstCkMqdQSaQXOz
         MIW3lfryfRYBSxI1v3DWDaeETK6pBKBf39GxbcJiji3c72Y+b34ypvpKMU7Ud/m0U1QE
         IxEA==
X-Gm-Message-State: AOAM532t4CteZs18G2638zb5NBHFcq8FWfFxrTLZBcnrk+vD8FwD5S/Y
        7Rrd7hfLgpM/8WGMVO09xzLMarnBUY6Co5HpUQAQ9A==
X-Google-Smtp-Source: ABdhPJyVR5rOr2nFM9vGn5skactc9OJCshxa2H6D2diM8RAZqpQ74XqjZQ2VlRY5yK/SMUeZN+ByvQhTFuaIIlIY0PU=
X-Received: by 2002:a05:6512:3a88:: with SMTP id q8mr4334156lfu.106.1621540013172;
 Thu, 20 May 2021 12:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com> <YKXj3gHvUoLnojzB@google.com>
 <CAAdAUtieAd6kvrXBNXc1TfO84ZxQ4xM30Z_G5F9CoT2gxeGrLA@mail.gmail.com> <YKaxYZYQRp0/9f+A@google.com>
In-Reply-To: <YKaxYZYQRp0/9f+A@google.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 20 May 2021 14:46:41 -0500
Message-ID: <CAAdAUtiZxw9_qQ4eszsxSQmmL7j46LRhixL5zYttcOzL0da42Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] KVM: stats: Add fd-based API to read binary stats data
To:     Ricardo Koller <ricarkol@google.com>
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ricardo,

On Thu, May 20, 2021 at 1:58 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Thu, May 20, 2021 at 12:37:59PM -0500, Jing Zhang wrote:
> > Hi Ricardo,
> >
> > On Wed, May 19, 2021 at 11:21 PM Ricardo Koller <ricarkol@google.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 02:53:12PM +0000, Jing Zhang wrote:
> > > > Provides a file descriptor per VM to read VM stats info/data.
> > > > Provides a file descriptor per vCPU to read vCPU stats info/data.
> > > >
> > > > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > > > ---
> > > >  arch/arm64/kvm/guest.c    |  26 +++++
> > > >  arch/mips/kvm/mips.c      |  52 +++++++++
> > > >  arch/powerpc/kvm/book3s.c |  52 +++++++++
> > > >  arch/powerpc/kvm/booke.c  |  45 ++++++++
> > > >  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
> > > >  arch/x86/kvm/x86.c        |  53 +++++++++
> > > >  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
> > > >  include/uapi/linux/kvm.h  |  50 +++++++++
> > > >  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
> > > >  9 files changed, 745 insertions(+)
> > > >
> > >
> > > > +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> > > > +                           size_t size, loff_t *offset)
> > > > +{
> > > > +     char id[KVM_STATS_ID_MAXLEN];
> > > > +     struct kvm_vcpu *vcpu = file->private_data;
> > > > +     ssize_t copylen, len, remain = size;
> > > > +     size_t size_header, size_desc, size_stats;
> > > > +     loff_t pos = *offset;
> > > > +     char __user *dest = user_buffer;
> > > > +     void *src;
> > >
> > > Nit. Better to do pointer arithmetic on a "char *".  Note that gcc and
> > > clang will do the expected thing.
> > >
> > > > +
> > > > +     snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> > > > +                     task_pid_nr(current), vcpu->vcpu_id);
> > > > +     size_header = sizeof(kvm_vcpu_stats_header);
> > > > +     size_desc =
> > > > +             kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > > +     size_stats = sizeof(vcpu->stat);
> > > > +
> > > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > > +     len = min(len, remain);
> > > > +     if (len <= 0)
> > > > +             return 0;
> > > > +     remain = len;
> > >
> > > If 'desc_offset' is not right after the header, then the 'len'
> > > calculation is missing the gap into account. For example, assuming there
> > > is a gap of 0x1000000 between the header and the descriptors:
> > >
> > >         desc_offset = sizeof(id) + size_header + 0x1000000
> > >
> > > and the user calls the ioctl with enough space for the whole file,
> > > including the gap:
> > >
> > >         *offset = 0
> > >         size = sizeof(id) + size_header + size_desc + size_stats + 0x1000000
> > >
> > > then 'remain' gets the wrong size:
> > >
> > >         remain = sizeof(id) + size_header + size_desc + size_stats
> > >
> > > and ... (more below)
> > >
> > > > +
> > > > +     /* Copy kvm vcpu stats header id string */
> > > > +     copylen = sizeof(id) - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)id + pos;
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vcpu stats header */
> > > > +     copylen = sizeof(id) + size_header - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&kvm_vcpu_stats_header;
> > > > +             src += pos - sizeof(id);
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vcpu stats descriptors */
> > > > +     copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;
> > >
> > > This would be the state at this point:
> > >
> > >         pos     = sizeof(id) + size_header
> > >         copylen = sizeof(id) + size_header + 0x1000000 + size_desc - (sizeof(id) + size_header)
> > >                 = 0x1000000 + size_desc
> > >         remain  = size_desc + size_stats
> > >
> > > > +     copylen = min(copylen, remain);
> > >
> > >         copylen = size_desc + size_stats
> > >
> > > which is not enough to copy the descriptors (and the data).
> > >
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&kvm_vcpu_stats_desc;
> > > > +             src += pos - kvm_vcpu_stats_header.desc_offset;
> > >
> > > Moreover, src also needs to take the gap into account.
> > >
> > >         src     = &kvm_vcpu_stats_desc + (sizeof(id) + size_header) - (sizeof(id) + size_header + 0x1000000)
> > >                 = &kvm_vcpu_stats_desc - 0x1000000
> > >
> > > Otherwise, src ends up pointing at the wrong place.
> > >
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vcpu stats values */
> > > > +     copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;
> > >
> > > The same problem occurs here. There is a potential gap before
> > > data_offset that needs to be taken into account for src and len.
> > >
> > > Would it be possible to just ensure that there is no gap? maybe even
> > > remove data_offset and desc_offset and always place them adjacent, and
> > > have the descriptors right after the header.
> > >
> > I guess I didn't make it clear about the offset fields in the header block.
> > We don't create any gap here. In this implementation, kernel knows that
> > descriptor block is right after header block and data block is right after
> > descriptor block.
> > The reason we have offset fields for descriptor block and data block is
> > for flexibility and future potential extension. e.g. we might add another
> > block between header block and descriptor block in the future for some
> > other metadata information.
> > I think we are good here.
>
> Hi Jing,
>
> I realize they are adjacent right now, as the function wouldn't work if
> they weren't. My comment was more about code maintenance, what happens
> if the layout changes. This function depends on an asumption about a
> layout defined somewhere else. For example,
>
>         copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
>
> makes an assumption about desc_offset being set to:
>
>         .desc_offset = sizeof(struct kvm_stats_header),
>
> and if desc_offset is not exactly that, then the function doesn't
> explicitely fail and instead does unexpected things (probably undetected
> by tests).
>
> I think the solution is to just check the assumptions. Either an assert
> or just bail out with a warning:
>
>         /* This function currently depends on the following layout. */
>         if (kvm_vm_stats_header.desc_offset != sizeof(struct kvm_stats_header) ||
>                         kvm_vm_stats_header.data_offset != sizeof(struct kvm_stats_header) +
>                         sizeof(kvm_vm_stats_desc)) {
>                 warning(...);
>                 return 0;
>         }
>
I understand your concern. But whenever layout changes, the read function needs
to be updated anyway. The read function is actually the place to cook
the data layout
of the anonymous file. If the vm/vcpu stats header has an incorrect
offset value that is
defined in the read function, the test will complain about wrong stats
descriptor field
values usually.
Anyway, I will add more sanity tests in the selftest to cover the
potential risks.
Thanks.
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&vcpu->stat;
> > > > +             src += pos - kvm_vcpu_stats_header.data_offset;
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +
> > > > +     *offset = pos;
> > > > +     return len;
> > > > +}
> > > > +
> > > >
> > >
> > >
> > >
> > > > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > > > +                           size_t size, loff_t *offset)
> > > > +{
> > >
> > > Consider moving the common code between kvm_vcpu_stats_read and this one
> > > into some function that takes pointers to header, desc, and data. Unless
> > > there is something vcpu or vm specific besides that.
> > >
> > Will do that, thanks.
> > > > +     char id[KVM_STATS_ID_MAXLEN];
> > > > +     struct kvm *kvm = file->private_data;
> > > > +     ssize_t copylen, len, remain = size;
> > > > +     size_t size_header, size_desc, size_stats;
> > > > +     loff_t pos = *offset;
> > > > +     char __user *dest = user_buffer;
> > > > +     void *src;
> > > > +
> > > > +     snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> > > > +     size_header = sizeof(kvm_vm_stats_header);
> > > > +     size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > > +     size_stats = sizeof(kvm->stat);
> > > > +
> > > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > > +     len = min(len, remain);
> > > > +     if (len <= 0)
> > > > +             return 0;
> > > > +     remain = len;
> > > > +
> > > > +     /* Copy kvm vm stats header id string */
> > > > +     copylen = sizeof(id) - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)id + pos;
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vm stats header */
> > > > +     copylen = sizeof(id) + size_header - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&kvm_vm_stats_header;
> > > > +             src += pos - sizeof(id);
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vm stats descriptors */
> > > > +     copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&kvm_vm_stats_desc;
> > > > +             src += pos - kvm_vm_stats_header.desc_offset;
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +     /* Copy kvm vm stats values */
> > > > +     copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> > > > +     copylen = min(copylen, remain);
> > > > +     if (copylen > 0) {
> > > > +             src = (void *)&kvm->stat;
> > > > +             src += pos - kvm_vm_stats_header.data_offset;
> > > > +             if (copy_to_user(dest, src, copylen))
> > > > +                     return -EFAULT;
> > > > +             remain -= copylen;
> > > > +             pos += copylen;
> > > > +             dest += copylen;
> > > > +     }
> > > > +
> > > > +     *offset = pos;
> > > > +     return len;
> > > > +}
> > > > +
> > > > --
> > > > 2.31.1.751.gd2f1c929bd-goog
> > > >
> > > > _______________________________________________
> > > > kvmarm mailing list
> > > > kvmarm@lists.cs.columbia.edu
> > > > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

Jing
