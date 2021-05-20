Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3A38B669
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhETTAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhETTAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 15:00:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D93C0613CE
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 11:58:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 10so13074326pfl.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0A+QquNDvthzJU4CTMhzbh4bqMXah229fKEf3KnQReo=;
        b=e7uecoaOt554AMJy6aLoq6wMfpjPyY2EdoPB8pYpqF7REsIHmRQBGJfJ/T5RipLzcG
         yo2OfFjax4a3AuBi6NJR4ASoR5wBMjTVS9CzHgInL4tGjTDEdHUfI6hfBp+PKcZ/SI0K
         NOszArRKtuk1yQK/oOtDzMqVfL1b7LeK0Yj6IGTrqMEM+iZGlJtT3oZQqzn+7iO7kRqR
         rUuvl4Y7oduQb/6DcunkRbwa+UQVZa+uJBADOfUOPwK0Dlg8Zt9e6Gzl15y1IGWCI7nH
         QF/xbLaZqhzGRyfJn+gnghAzlWsfO8URqdwBGcEJhJ8fvIPSKvK2bauDoa68QOm3IKHS
         eiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0A+QquNDvthzJU4CTMhzbh4bqMXah229fKEf3KnQReo=;
        b=BCt6RsE2zmyEWeO/t42AFW5JJ4doUD/1fN7igScL8LELwgbx7rlBXD7HmVSaLH94EY
         ZZVB7PS1hdFOA2eO1WjfBzA8l9MNr2iifPT6G0RVrxbcbV4ItVdeLkMxXgyURvaO40PV
         5hqdN4s3kAVklzdGl3Rb9ujTsYX7LfEYzIQnkGh3oJObg/E1yD6WHDQUik2A4g1aWNTz
         3W/kvPJqdjwHUQRXrjjkldcOIojG+VhsTPClhwoR5w1f87Pv+KUFnf87M9yyRZEcfXJS
         J4O18kGqQSfrIfiAGtH04dPqpoUZVUlPTVubXkELfuRGfbNKSw1aLyLdQREq5W4F4+DG
         PzJg==
X-Gm-Message-State: AOAM5330SM6t88WjpMwyPK2WWfwspA5ACvApsAQucbphW+hEvSm9yH5k
        eStC7p23rq5zvTpbODgmzRzS/g==
X-Google-Smtp-Source: ABdhPJxf1s6FAmGuj1RGTiAj8PYxYOYF9O3ojLXe8DiaG0w386PgPdKrVI9vkrxu/iKlJkEeCjiAQw==
X-Received: by 2002:aa7:8c4d:0:b029:2de:708c:ac4f with SMTP id e13-20020aa78c4d0000b02902de708cac4fmr5868933pfd.51.1621537125232;
        Thu, 20 May 2021 11:58:45 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id t14sm2357287pfg.168.2021.05.20.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:58:44 -0700 (PDT)
Date:   Thu, 20 May 2021 11:58:41 -0700
From:   Ricardo Koller <ricarkol@google.com>
To:     Jing Zhang <jingzhangos@google.com>
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
Subject: Re: [PATCH v5 2/4] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <YKaxYZYQRp0/9f+A@google.com>
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com>
 <YKXj3gHvUoLnojzB@google.com>
 <CAAdAUtieAd6kvrXBNXc1TfO84ZxQ4xM30Z_G5F9CoT2gxeGrLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAdAUtieAd6kvrXBNXc1TfO84ZxQ4xM30Z_G5F9CoT2gxeGrLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 20, 2021 at 12:37:59PM -0500, Jing Zhang wrote:
> Hi Ricardo,
> 
> On Wed, May 19, 2021 at 11:21 PM Ricardo Koller <ricarkol@google.com> wrote:
> >
> > On Mon, May 17, 2021 at 02:53:12PM +0000, Jing Zhang wrote:
> > > Provides a file descriptor per VM to read VM stats info/data.
> > > Provides a file descriptor per vCPU to read vCPU stats info/data.
> > >
> > > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > > ---
> > >  arch/arm64/kvm/guest.c    |  26 +++++
> > >  arch/mips/kvm/mips.c      |  52 +++++++++
> > >  arch/powerpc/kvm/book3s.c |  52 +++++++++
> > >  arch/powerpc/kvm/booke.c  |  45 ++++++++
> > >  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
> > >  arch/x86/kvm/x86.c        |  53 +++++++++
> > >  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
> > >  include/uapi/linux/kvm.h  |  50 +++++++++
> > >  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
> > >  9 files changed, 745 insertions(+)
> > >
> >
> > > +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> > > +                           size_t size, loff_t *offset)
> > > +{
> > > +     char id[KVM_STATS_ID_MAXLEN];
> > > +     struct kvm_vcpu *vcpu = file->private_data;
> > > +     ssize_t copylen, len, remain = size;
> > > +     size_t size_header, size_desc, size_stats;
> > > +     loff_t pos = *offset;
> > > +     char __user *dest = user_buffer;
> > > +     void *src;
> >
> > Nit. Better to do pointer arithmetic on a "char *".  Note that gcc and
> > clang will do the expected thing.
> >
> > > +
> > > +     snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> > > +                     task_pid_nr(current), vcpu->vcpu_id);
> > > +     size_header = sizeof(kvm_vcpu_stats_header);
> > > +     size_desc =
> > > +             kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > +     size_stats = sizeof(vcpu->stat);
> > > +
> > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > +     len = min(len, remain);
> > > +     if (len <= 0)
> > > +             return 0;
> > > +     remain = len;
> >
> > If 'desc_offset' is not right after the header, then the 'len'
> > calculation is missing the gap into account. For example, assuming there
> > is a gap of 0x1000000 between the header and the descriptors:
> >
> >         desc_offset = sizeof(id) + size_header + 0x1000000
> >
> > and the user calls the ioctl with enough space for the whole file,
> > including the gap:
> >
> >         *offset = 0
> >         size = sizeof(id) + size_header + size_desc + size_stats + 0x1000000
> >
> > then 'remain' gets the wrong size:
> >
> >         remain = sizeof(id) + size_header + size_desc + size_stats
> >
> > and ... (more below)
> >
> > > +
> > > +     /* Copy kvm vcpu stats header id string */
> > > +     copylen = sizeof(id) - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)id + pos;
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vcpu stats header */
> > > +     copylen = sizeof(id) + size_header - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)&kvm_vcpu_stats_header;
> > > +             src += pos - sizeof(id);
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vcpu stats descriptors */
> > > +     copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;
> >
> > This would be the state at this point:
> >
> >         pos     = sizeof(id) + size_header
> >         copylen = sizeof(id) + size_header + 0x1000000 + size_desc - (sizeof(id) + size_header)
> >                 = 0x1000000 + size_desc
> >         remain  = size_desc + size_stats
> >
> > > +     copylen = min(copylen, remain);
> >
> >         copylen = size_desc + size_stats
> >
> > which is not enough to copy the descriptors (and the data).
> >
> > > +     if (copylen > 0) {
> > > +             src = (void *)&kvm_vcpu_stats_desc;
> > > +             src += pos - kvm_vcpu_stats_header.desc_offset;
> >
> > Moreover, src also needs to take the gap into account.
> >
> >         src     = &kvm_vcpu_stats_desc + (sizeof(id) + size_header) - (sizeof(id) + size_header + 0x1000000)
> >                 = &kvm_vcpu_stats_desc - 0x1000000
> >
> > Otherwise, src ends up pointing at the wrong place.
> >
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vcpu stats values */
> > > +     copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;
> >
> > The same problem occurs here. There is a potential gap before
> > data_offset that needs to be taken into account for src and len.
> >
> > Would it be possible to just ensure that there is no gap? maybe even
> > remove data_offset and desc_offset and always place them adjacent, and
> > have the descriptors right after the header.
> >
> I guess I didn't make it clear about the offset fields in the header block.
> We don't create any gap here. In this implementation, kernel knows that
> descriptor block is right after header block and data block is right after
> descriptor block.
> The reason we have offset fields for descriptor block and data block is
> for flexibility and future potential extension. e.g. we might add another
> block between header block and descriptor block in the future for some
> other metadata information.
> I think we are good here.

Hi Jing,

I realize they are adjacent right now, as the function wouldn't work if
they weren't. My comment was more about code maintenance, what happens
if the layout changes. This function depends on an asumption about a
layout defined somewhere else. For example,

	copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;

makes an assumption about desc_offset being set to:

	.desc_offset = sizeof(struct kvm_stats_header),

and if desc_offset is not exactly that, then the function doesn't
explicitely fail and instead does unexpected things (probably undetected
by tests).

I think the solution is to just check the assumptions. Either an assert
or just bail out with a warning:

	/* This function currently depends on the following layout. */
	if (kvm_vm_stats_header.desc_offset != sizeof(struct kvm_stats_header) ||
			kvm_vm_stats_header.data_offset != sizeof(struct kvm_stats_header) +
			sizeof(kvm_vm_stats_desc)) {
		warning(...);
		return 0;
	}

> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)&vcpu->stat;
> > > +             src += pos - kvm_vcpu_stats_header.data_offset;
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +
> > > +     *offset = pos;
> > > +     return len;
> > > +}
> > > +
> > >
> >
> >
> >
> > > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > > +                           size_t size, loff_t *offset)
> > > +{
> >
> > Consider moving the common code between kvm_vcpu_stats_read and this one
> > into some function that takes pointers to header, desc, and data. Unless
> > there is something vcpu or vm specific besides that.
> >
> Will do that, thanks.
> > > +     char id[KVM_STATS_ID_MAXLEN];
> > > +     struct kvm *kvm = file->private_data;
> > > +     ssize_t copylen, len, remain = size;
> > > +     size_t size_header, size_desc, size_stats;
> > > +     loff_t pos = *offset;
> > > +     char __user *dest = user_buffer;
> > > +     void *src;
> > > +
> > > +     snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> > > +     size_header = sizeof(kvm_vm_stats_header);
> > > +     size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > +     size_stats = sizeof(kvm->stat);
> > > +
> > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > +     len = min(len, remain);
> > > +     if (len <= 0)
> > > +             return 0;
> > > +     remain = len;
> > > +
> > > +     /* Copy kvm vm stats header id string */
> > > +     copylen = sizeof(id) - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)id + pos;
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vm stats header */
> > > +     copylen = sizeof(id) + size_header - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)&kvm_vm_stats_header;
> > > +             src += pos - sizeof(id);
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vm stats descriptors */
> > > +     copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)&kvm_vm_stats_desc;
> > > +             src += pos - kvm_vm_stats_header.desc_offset;
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +     /* Copy kvm vm stats values */
> > > +     copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> > > +     copylen = min(copylen, remain);
> > > +     if (copylen > 0) {
> > > +             src = (void *)&kvm->stat;
> > > +             src += pos - kvm_vm_stats_header.data_offset;
> > > +             if (copy_to_user(dest, src, copylen))
> > > +                     return -EFAULT;
> > > +             remain -= copylen;
> > > +             pos += copylen;
> > > +             dest += copylen;
> > > +     }
> > > +
> > > +     *offset = pos;
> > > +     return len;
> > > +}
> > > +
> > > --
> > > 2.31.1.751.gd2f1c929bd-goog
> > >
> > > _______________________________________________
> > > kvmarm mailing list
> > > kvmarm@lists.cs.columbia.edu
> > > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
