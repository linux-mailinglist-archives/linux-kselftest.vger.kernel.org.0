Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4738B549
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhETRjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhETRjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 13:39:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B30C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 10:38:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so20753077ljn.13
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KJHwo5DFTJDJh5/ETsiJlMijOucPzPMRkTWyXtbuxY=;
        b=wO4L8MIE1binC+mFg/7H9NjtTCxF+zJ4HFX4XenruCFL3GI6KEQ/lDQKg5Kj3tIPMn
         Zf1o69rzK40i8Xwg3i04qKIi0JmX7yTWjtbFOGGAdAauEwSfeH4B0cztMa+3nSHhfewS
         EwDVsIc/b1/8/Ib4O5ygYTSVqxJQpEEV32jyO1qv9Ps3SgD7xQ1R8bx2UpdeIyMZaUlp
         dZDNvIiqydoyUZckDB3c3fo9WbvJaSfituNN1tPtbdw/Ubx/xnPimpoq6PHJUTM+E0y3
         xaT98tYCynKq2IKBR/CDYz740Nu9RHHr5o8t0znilb2xj6JvOGdKMjmVYMJPVhHGuLqD
         v1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KJHwo5DFTJDJh5/ETsiJlMijOucPzPMRkTWyXtbuxY=;
        b=M/9pfJFqT7uhbb8F+E5SsXd62dDcY0EiaunG4zaR+oWKjWuKeO8cYJLcUulHDevJHU
         yV1RHsIa7vu5ZzdtGtgiKbyOjItyu//LdID7BV7Fc/Da/ZKsmQ1UM+q5tkiI+Hlw9jF5
         oUxEctU//bNcwr3bzMT+i2rjwSeIhuu/9xMahwjfz3/e9RniEbhV7GXRLhPRv931nHeQ
         QopUfKAmQxKZ040xVO0eUjECaIGZwamnrLdQ+Z0h4JuB/PorKxgWN00VNmlvHzwsf/1m
         +HJk6a7b+QfwlJ/Jb+sXCeQfoeBcYzKF4sbI4pBNTs67QTrQlqByMhA3Dr6nNVl/rxNy
         dWnQ==
X-Gm-Message-State: AOAM5317qi+7ttYRAwtYgoLtbHeowy6I65gfCY4gvOGyLnBfyxyhgJ4Y
        BwALTboQndRGY7gsfW3hyU/G6SiZwiI55ejXhossXw==
X-Google-Smtp-Source: ABdhPJx03I9FjSeGRFVDGeg60Qw/8Vcmt8IOje+hdoZedN+snS+fzs3mIE4B3D2Mvw8UcOK/jOY7WqwPYxzmV/Gyrh0=
X-Received: by 2002:a2e:9c48:: with SMTP id t8mr3600658ljj.394.1621532291613;
 Thu, 20 May 2021 10:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com> <YKXj3gHvUoLnojzB@google.com>
In-Reply-To: <YKXj3gHvUoLnojzB@google.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 20 May 2021 12:37:59 -0500
Message-ID: <CAAdAUtieAd6kvrXBNXc1TfO84ZxQ4xM30Z_G5F9CoT2gxeGrLA@mail.gmail.com>
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

On Wed, May 19, 2021 at 11:21 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Mon, May 17, 2021 at 02:53:12PM +0000, Jing Zhang wrote:
> > Provides a file descriptor per VM to read VM stats info/data.
> > Provides a file descriptor per vCPU to read vCPU stats info/data.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arch/arm64/kvm/guest.c    |  26 +++++
> >  arch/mips/kvm/mips.c      |  52 +++++++++
> >  arch/powerpc/kvm/book3s.c |  52 +++++++++
> >  arch/powerpc/kvm/booke.c  |  45 ++++++++
> >  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
> >  arch/x86/kvm/x86.c        |  53 +++++++++
> >  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
> >  include/uapi/linux/kvm.h  |  50 +++++++++
> >  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
> >  9 files changed, 745 insertions(+)
> >
>
> > +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> > +                           size_t size, loff_t *offset)
> > +{
> > +     char id[KVM_STATS_ID_MAXLEN];
> > +     struct kvm_vcpu *vcpu = file->private_data;
> > +     ssize_t copylen, len, remain = size;
> > +     size_t size_header, size_desc, size_stats;
> > +     loff_t pos = *offset;
> > +     char __user *dest = user_buffer;
> > +     void *src;
>
> Nit. Better to do pointer arithmetic on a "char *".  Note that gcc and
> clang will do the expected thing.
>
> > +
> > +     snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> > +                     task_pid_nr(current), vcpu->vcpu_id);
> > +     size_header = sizeof(kvm_vcpu_stats_header);
> > +     size_desc =
> > +             kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> > +     size_stats = sizeof(vcpu->stat);
> > +
> > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > +     len = min(len, remain);
> > +     if (len <= 0)
> > +             return 0;
> > +     remain = len;
>
> If 'desc_offset' is not right after the header, then the 'len'
> calculation is missing the gap into account. For example, assuming there
> is a gap of 0x1000000 between the header and the descriptors:
>
>         desc_offset = sizeof(id) + size_header + 0x1000000
>
> and the user calls the ioctl with enough space for the whole file,
> including the gap:
>
>         *offset = 0
>         size = sizeof(id) + size_header + size_desc + size_stats + 0x1000000
>
> then 'remain' gets the wrong size:
>
>         remain = sizeof(id) + size_header + size_desc + size_stats
>
> and ... (more below)
>
> > +
> > +     /* Copy kvm vcpu stats header id string */
> > +     copylen = sizeof(id) - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)id + pos;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vcpu stats header */
> > +     copylen = sizeof(id) + size_header - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)&kvm_vcpu_stats_header;
> > +             src += pos - sizeof(id);
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vcpu stats descriptors */
> > +     copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;
>
> This would be the state at this point:
>
>         pos     = sizeof(id) + size_header
>         copylen = sizeof(id) + size_header + 0x1000000 + size_desc - (sizeof(id) + size_header)
>                 = 0x1000000 + size_desc
>         remain  = size_desc + size_stats
>
> > +     copylen = min(copylen, remain);
>
>         copylen = size_desc + size_stats
>
> which is not enough to copy the descriptors (and the data).
>
> > +     if (copylen > 0) {
> > +             src = (void *)&kvm_vcpu_stats_desc;
> > +             src += pos - kvm_vcpu_stats_header.desc_offset;
>
> Moreover, src also needs to take the gap into account.
>
>         src     = &kvm_vcpu_stats_desc + (sizeof(id) + size_header) - (sizeof(id) + size_header + 0x1000000)
>                 = &kvm_vcpu_stats_desc - 0x1000000
>
> Otherwise, src ends up pointing at the wrong place.
>
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vcpu stats values */
> > +     copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;
>
> The same problem occurs here. There is a potential gap before
> data_offset that needs to be taken into account for src and len.
>
> Would it be possible to just ensure that there is no gap? maybe even
> remove data_offset and desc_offset and always place them adjacent, and
> have the descriptors right after the header.
>
I guess I didn't make it clear about the offset fields in the header block.
We don't create any gap here. In this implementation, kernel knows that
descriptor block is right after header block and data block is right after
descriptor block.
The reason we have offset fields for descriptor block and data block is
for flexibility and future potential extension. e.g. we might add another
block between header block and descriptor block in the future for some
other metadata information.
I think we are good here.
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)&vcpu->stat;
> > +             src += pos - kvm_vcpu_stats_header.data_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     *offset = pos;
> > +     return len;
> > +}
> > +
> >
>
>
>
> > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > +                           size_t size, loff_t *offset)
> > +{
>
> Consider moving the common code between kvm_vcpu_stats_read and this one
> into some function that takes pointers to header, desc, and data. Unless
> there is something vcpu or vm specific besides that.
>
Will do that, thanks.
> > +     char id[KVM_STATS_ID_MAXLEN];
> > +     struct kvm *kvm = file->private_data;
> > +     ssize_t copylen, len, remain = size;
> > +     size_t size_header, size_desc, size_stats;
> > +     loff_t pos = *offset;
> > +     char __user *dest = user_buffer;
> > +     void *src;
> > +
> > +     snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> > +     size_header = sizeof(kvm_vm_stats_header);
> > +     size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> > +     size_stats = sizeof(kvm->stat);
> > +
> > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > +     len = min(len, remain);
> > +     if (len <= 0)
> > +             return 0;
> > +     remain = len;
> > +
> > +     /* Copy kvm vm stats header id string */
> > +     copylen = sizeof(id) - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)id + pos;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vm stats header */
> > +     copylen = sizeof(id) + size_header - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)&kvm_vm_stats_header;
> > +             src += pos - sizeof(id);
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vm stats descriptors */
> > +     copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)&kvm_vm_stats_desc;
> > +             src += pos - kvm_vm_stats_header.desc_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm vm stats values */
> > +     copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)&kvm->stat;
> > +             src += pos - kvm_vm_stats_header.data_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     *offset = pos;
> > +     return len;
> > +}
> > +
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
