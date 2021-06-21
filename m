Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8D3AF244
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFURtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhFURtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 13:49:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BAC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 10:46:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a11so18518490lfg.11
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMJXegssnqpONPLczONIAO8+jgmEKTYKlSdaRff4HUA=;
        b=bNnoexmihOl1CcryhmVv36Rjanlk/iMAQl9bFfd16w6MuIODaXTieL65lPs2H7bZqv
         f4O/tDRcz3FqQQQHU2/x2rEqppsTSRBVDIcu34r6zucvqCEGlw7ds3oDBKxxxd9U3EsL
         2uYRLNUwZ0cRhWENyKTyDpB/KmIUvLAZr8XAid4Q9hSdSFw3/scA7J2S3Kj1NIWtou6Q
         W3DlJBdFka6CzOO2Rk1prqJgmgxeF0x4EwoFNqgNwBklgsMCSt7W/OWl/rvlLreJaSrL
         CN1sbpdr5mYRX+7OaFrBeBrpgv76v9WvPMsA4Y8e5GMCkTOTc0MY/N5AmptXL4pRTLqa
         YU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMJXegssnqpONPLczONIAO8+jgmEKTYKlSdaRff4HUA=;
        b=IDrs+Hpb12dHljX7hqgHdMG+U/pmyVr/Fm1uugGQEXZ01FxkpsHcNQbma8pcscg1fM
         Xk1YxRpkXgrdVNOBIl5yIog1OC03K8xBz976tXN7pKBkrkiXA49gPoO+9q5SSzJIcNOL
         i8Op7XufFbCuq8Zm/uAb/aAlAt0IncM/5dOupIw+/plZ79Cf/KYNUdbl37yK+zPwXYr4
         VFyXX3wxbPRsPVo/m9ylJfmCbSgM6mi66U5SAWXH0D2sDU2JsWBz8nSm0rktMU2E/ify
         tzZy0/xCRoD4xv/DxBgleVn4kqzhvvEgiQQWFL9ZP4JeXOv4g8i9iKcsXdW9V9TyrDLH
         QApA==
X-Gm-Message-State: AOAM531LTPcA2XAHXYPwCxUQc8Y+6T+HGxHFmJ1FpOqewoKJlZikvHyx
        A74eOb0iUwNCcYm8PhDkhVrA3X0ha6BkubmiTry8iw==
X-Google-Smtp-Source: ABdhPJw5v74BJ4gFYne3uXqh8PwWAuCMlEwFfkqB3Kiz6G0K+WI5o4O+lwaJJg7O9+CNG6Qd/LAnulE6vGeoMEPuXcs=
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr6455431lfe.106.1624297617286;
 Mon, 21 Jun 2021 10:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
 <20210618222709.1858088-3-jingzhangos@google.com> <0cde024e-a234-9a10-5157-d17ba423939e@redhat.com>
In-Reply-To: <0cde024e-a234-9a10-5157-d17ba423939e@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 21 Jun 2021 12:46:46 -0500
Message-ID: <CAAdAUtiL6DwJDWLLmUqct6B6n7Zaa2DyPhpwKZKb=cpRH+8+vQ@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 11:54 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/21 00:27, Jing Zhang wrote:
> > +/**
> > + * kvm_stats_read() - Common vm/vcpu stats read function to userspace.
>
> Common function to read from the binary statistics file descriptor.
>
> > + * @id: identification string of the stats
> > + * @header: stats header for a vm or a vcpu
> > + * @desc: start address of an array of stats descriptors for a vm or a vcpu
> > + * @stats: start address of stats data block for a vm or a vcpu
> > + * @size_stats: the size of stats data block pointed by @stats
> > + * @user_buffer: start address of userspace buffer
> > + * @size: requested read size from userspace
> > + * @offset: the start position from which the content will be read for the
> > + *          corresponding vm or vcp file descriptor
> > + *
> > + * The file content of a vm/vcpu file descriptor is now defined as below:
> > + * +-------------+
> > + * |   Header    |
> > + * +-------------+
> > + * |  id string  |
> > + * +-------------+
> > + * | Descriptors |
> > + * +-------------+
> > + * | Stats Data  |
> > + * +-------------+
> > + * Although this function allows userspace to read any amount of data (as long
> > + * as in the limit) from any position, the typical usage would follow below
> > + * steps:
> > + * 1. Read header from offset 0. Get the offset of descriptors and stats data
> > + *    and some other necessary information. This is a one-time work for the
> > + *    lifecycle of the corresponding vm/vcpu stats fd.
> > + * 2. Read id string from its offset. This is a one-time work for the lifecycle
> > + *    of the corresponding vm/vcpu stats fd.
> > + * 3. Read descriptors from its offset and discover all the stats by parsing
> > + *    descriptors. This is a one-time work for the lifecycle of the
> > + *    corresponding vm/vcpu stats fd.
> > + * 4. Periodically read stats data from its offset using pread.
> > + *
> > + * Return: the number of bytes that has been successfully read
> > + */
> > +ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
> > +                    const struct _kvm_stats_desc *desc,
> > +                    void *stats, size_t size_stats,
> > +                    char __user *user_buffer, size_t size, loff_t *offset)
>
>
> You can replace the header argument with just the number of descriptors,
> and then construct the header in the "if" statement below that copies it
> to userspace:
>
> const struct kvm_stats_header kvm_vm_stats_header = {
>         .name_size = KVM_STATS_NAME_SIZE,
>         .num_desc = num_desc,
The problem is how we calculate the number of descriptors, which needs the
size of the descriptor array for each architecture.
Define another global variable to export the size of descriptor array?
>         .id_offset = size_header,
>         .desc_offset = size_header + KVM_STATS_NAME_SIZE,
>         .data_offset = size_header + KVM_STATS_NAME_SIZE +
>                        size_desc,
> };
>
> Of course size_header can be assigned with sizeof (struct kvm_stats_header).
>
> This removes the definition of the header in each architecture.
>
> Paolo
>
> > +{
> > +     ssize_t len;
> > +     ssize_t copylen;
> > +     ssize_t remain = size;
> > +     size_t size_desc;
> > +     size_t size_header;
> > +     void *src;
> > +     loff_t pos = *offset;
> > +     char __user *dest = user_buffer;
> > +
> > +     size_header = sizeof(*header);
> > +     size_desc = header->num_desc * sizeof(*desc);
> > +
> > +     len = KVM_STATS_NAME_SIZE + size_header + size_desc + size_stats - pos;
> > +     len = min(len, remain);
> > +     if (len <= 0)
> > +             return 0;
> > +     remain = len;
> > +
> > +     /*
> > +      * Copy kvm stats header.
> > +      * The header is the first block of content userspace usually read out.
> > +      * The pos is 0 and the copylen and remain would be the size of header.
> > +      * The copy of the header would be skipped if offset is larger than the
> > +      * size of header. That usually happens when userspace reads stats
> > +      * descriptors and stats data.
> > +      */
> > +     copylen = size_header - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)header + pos;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     /*
> > +      * Copy kvm stats header id string.
> > +      * The id string is unique for every vm/vcpu, which is stored in kvm
> > +      * and kvm_vcpu structure.
> > +      * The id string is part of the stat header from the perspective of
> > +      * userspace, it is usually read out together with previous constant
> > +      * header part and could be skipped for later descriptors and stats
> > +      * data readings.
> > +      */
> > +     copylen = size_header + KVM_STATS_NAME_SIZE - pos;
>
> Should use header->id_offset instead of size_header here and in the
> computation of src.
>
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = id + pos - size_header;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     /*
> > +      * Copy kvm stats descriptors.
> > +      * The descriptors copy would be skipped in the typical case that
> > +      * userspace periodically read stats data, since the pos would be
> > +      * greater than the end address of descriptors
> > +      * (header->header.desc_offset + size_desc) causing copylen <= 0.
> > +      */
> > +     copylen = header->desc_offset + size_desc - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)desc + pos - header->desc_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     /* Copy kvm stats values */
> > +     copylen = header->data_offset + size_stats - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = stats + pos - header->data_offset;
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
>
Thanks,
Jing
