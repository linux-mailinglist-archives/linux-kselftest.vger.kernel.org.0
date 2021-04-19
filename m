Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484953643A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 15:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbhDSNVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbhDSNUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 09:20:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB0C061366
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Apr 2021 06:18:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f41so32523063lfv.8
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Apr 2021 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ICjc9fLtNV7Ru7mKiGaY8uOB3WqgEhqKpsTcAMCMfWA=;
        b=Eevn823c7q6BC2k/R5sZssPrJ4uwmX4bc93DPEPTQDdJaY9WiAalUqWZiIVD9qgZIV
         Wd62N/V74AQhCqEuRzTn6yBYKH+3elcvMagbbbyMmRKb9vdVS1Q3E8tvgu2vH/eeGdQz
         y1BfACzUOPrYOBv6UtBgLoI3ZrYP9pW/ZPdIdcPIBXdPBEU/lkxBuFDIU+rlvkpGdm77
         mtSzkkNLi4qGCVgtdU9lNoXChuVSeKt3ehqBgD51KhCAtTnEngD4Smb54ny97KWiX8r1
         zqg4RE+a4mOyzn9CxdIpsVokvbZoz40eH8HNUTMyoBz3o7dck1qBZvuqfMYgHXx/e2+G
         JfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ICjc9fLtNV7Ru7mKiGaY8uOB3WqgEhqKpsTcAMCMfWA=;
        b=oaDYNpiV50dg9Wa/eokXcRMC8p12DyZKjQUroi1Zbtkb+Yjhw6O3kBS/5nvzDiytoj
         jBDIZkfyx76gm3g9CbADWcv+GCcLBqwN8crgUZ15MzqM5OEsButTVh7WrRu5S/92n+zl
         OK0ymd3sVBupsOHgkHcSJ2oTo8wWNb1B5EG2UaALfk/OyDW8W1m2/inxFI3nfZ7Y4128
         Po5I8VO7lGTgvuhvWpYmhrUwn8He4mOjP7zcYuPY1ORSig+yuZ+dpEu1NVaEOSf+98+7
         GObZzIrs90/QCzSO41Ogu6ij5cafox7ClnPuTxpvSmt2vR6ysQLsnedRLz51SVarsqII
         xaLw==
X-Gm-Message-State: AOAM531MYD8gdj9FaqIqecEaXFIYQXpvB1uUJpNI+cYfIqMoXDSODS3v
        O4938J4k26YhCDKhvcDkd5sci0ewwF9DwOrghrL3NA==
X-Google-Smtp-Source: ABdhPJyu1mtgIp2YR+7X8iN5Ds69+pZ/OZJfwc24L5jIIlOaw2bZwEG+DjSjUTzdthDCgSQvyhWmnYXfxsnz7zZRkMo=
X-Received: by 2002:a19:700a:: with SMTP id h10mr4841975lfc.178.1618838331770;
 Mon, 19 Apr 2021 06:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210415151741.1607806-1-jingzhangos@google.com>
 <20210415151741.1607806-4-jingzhangos@google.com> <3d985605-a2ad-b25e-328c-c37cb4ef1794@arm.com>
In-Reply-To: <3d985605-a2ad-b25e-328c-c37cb4ef1794@arm.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 19 Apr 2021 08:18:39 -0500
Message-ID: <CAAdAUtiNJGRa=TKynxKVGQA4W-L63j1ZaL-QYS6jDoMgrSVrMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: stats: Add documentation for statistics data
 binary interface
To:     Yoan Picchi <yoan.picchi@arm.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yoan,

On Mon, Apr 19, 2021 at 5:46 AM Yoan Picchi <yoan.picchi@arm.com> wrote:
>
> Hello Jing, and thanks for the patches. Just two small nitpicks.
>
> On 15/04/2021 16:17, Jing Zhang wrote:
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >   Documentation/virt/kvm/api.rst | 169 ++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 169 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index 2c4253718881..6474c31a4436 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -4941,6 +4941,167 @@ see KVM_XEN_VCPU_SET_ATTR above.
> >   The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
> >   with the KVM_XEN_VCPU_GET_ATTR ioctl.
> >
> > +4.131 KVM_STATS_GETFD
> > +---------------------
> > +
> > +:Capability: KVM_CAP_STATS_BINARY_FD
> > +:Architectures: all
> > +:Type: vm ioctl, vcpu ioctl
> > +:Parameters: none
> > +:Returns: statistics file descriptor on success, < 0 on error
> > +
> > +Errors:
> > +
> > +  =3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  ENOMEM     if the fd could not be created due to lack of memory
> > +  EMFILE     if the number of opened files exceeds the limit
> > +  =3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The file descriptor can be used to read VM/vCPU statistics data in bin=
ary
> > +format. The file data is organized into three blocks as below:
> > ++-------------+
> > +|   Header    |
> > ++-------------+
> > +| Descriptors |
> > ++-------------+
> > +| Stats Data  |
> > ++-------------+
> > +
> > +The Header block is always at the start of the file. It is only needed=
 to be
> > +read one time after a system boot.
> > +It is in the form of ``struct kvm_stats_header`` as below::
> > +
> > +     #define KVM_STATS_ID_MAXLEN                     64
>
>
> Removing one tab would align the 64 with the defines below, though it
> might be a tad close to the id field. I'm not sure which is best but
> I'll still mention it.
Sure, will align it with following defines.
>
>
> > +     struct kvm_stats_header {
> > +             char id[KVM_STATS_ID_MAXLEN];
> > +             __u32 name_size;
> > +             __u32 count;
> > +             __u32 desc_offset;
> > +             __u32 data_offset;
> > +     };
> > +
> > +The ``id`` field is identification for the corresponding KVM statistic=
s. For
> > +KVM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345"=
. For
> > +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", =
like
> > +"kvm-12345/vcpu-12".
> > +
> > +The ``name_size`` field is the size (byte) of the statistics name stri=
ng
> > +(including trailing '\0') appended to the end of every statistics desc=
riptor.
> > +
> > +The ``count`` field is the number of statistics.
> > +
> > +The ``desc_offset`` field is the offset of the Descriptors block from =
the start
> > +of the file indicated by the file descriptor.
> > +
> > +The ``data_offset`` field is the offset of the Stats Data block from t=
he start
> > +of the file indicated by the file descriptor.
> > +
> > +The Descriptors block is only needed to be read once after a system bo=
ot. It is
> > +an array of ``struct kvm_stats_desc`` as below::
> > +
> > +     #define KVM_STATS_TYPE_SHIFT            0
> > +     #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SH=
IFT)
> > +     #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SH=
IFT)
> > +     #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SH=
IFT)
> > +     #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> > +
> > +     #define KVM_STATS_UNIT_SHIFT            4
> > +     #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SH=
IFT)
> > +     #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SH=
IFT)
> > +     #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SH=
IFT)
> > +     #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SH=
IFT)
> > +     #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SH=
IFT)
> > +     #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> > +
> > +     #define KVM_STATS_SCALE_SHIFT           8
> > +     #define KVM_STATS_SCALE_MASK            (0xF << KVM_STATS_SCALE_S=
HIFT)
> > +     #define KVM_STATS_SCALE_POW10           (0x0 << KVM_STATS_SCALE_S=
HIFT)
> > +     #define KVM_STATS_SCALE_POW2            (0x1 << KVM_STATS_SCALE_S=
HIFT)
> > +     #define KVM_STATS_SCALE_MAX             KVM_STATS_SCALE_POW2
> > +     struct kvm_stats_desc {
> > +             __u32 flags;
> > +             __s16 exponent;
> > +             __u16 size;
> > +             __u32 unused1;
> > +             __u32 unused2;
> > +             __u8 name[0];
> > +     };
>
>
> Maybe add a new line between the define and the struct ? And do that as
> well in the code ?
Thanks. Will add a blank line before both structs.
>
>
> > +
> > +The ``flags`` field contains the type and unit of the statistics data =
described
> > +by this descriptor. The following flags are supported:
> > +  * ``KVM_STATS_TYPE_CUMULATIVE``
> > +    The statistics data is cumulative. The value of data can only be i=
ncreased.
> > +    Most of the counters used in KVM are of this type.
> > +    The corresponding ``count`` filed for this type is always 1.
> > +  * ``KVM_STATS_TYPE_INSTANT``
> > +    The statistics data is instantaneous. Its value can be increased o=
r
> > +    decreased. This type is usually used as a measurement of some reso=
urces,
> > +    like the number of dirty pages, the number of large pages, etc.
> > +    The corresponding ``count`` field for this type is always 1.
> > +  * ``KVM_STATS_UNIT_NONE``
> > +    There is no unit for the value of statistics data. This usually me=
ans that
> > +    the value is a simple counter of an event.
> > +  * ``KVM_STATS_UNIT_BYTES``
> > +    It indicates that the statistics data is used to measure memory si=
ze, in the
> > +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> > +    determined by the ``exponent`` field in the descriptor. The
> > +    ``KVM_STATS_SCALE_POW2`` flag is valid in this case. The unit of t=
he data is
> > +    determined by ``pow(2, exponent)``. For example, if value is 10,
> > +    ``exponent`` is 20, which means the unit of statistics data is MiB=
yte, we
> > +    can get the statistics data in the unit of Byte by
> > +    ``value * pow(2, exponent) =3D 10 * pow(2, 20) =3D 10 MiByte`` whi=
ch is
> > +    10 * 1024 * 1024 Bytes.
> > +  * ``KVM_STATS_UNIT_SECONDS``
> > +    It indicates that the statistics data is used to measure time/late=
ncy, in
> > +    the unit of nanosecond, microsecond, millisecond and second. The u=
nit of the
> > +    data is determined by the ``exponent`` field in the descriptor. Th=
e
> > +    ``KVM_STATS_SCALE_POW10`` flag is valid in this case. The unit of =
the data
> > +    is determined by ``pow(10, exponent)``. For example, if value is 2=
000000,
> > +    ``exponent`` is -6, which means the unit of statistics data is mic=
rosecond,
> > +    we can get the statistics data in the unit of second by
> > +    ``value * pow(10, exponent) =3D 2000000 * pow(10, -6) =3D 2 second=
s``.
> > +  * ``KVM_STATS_UNIT_CYCLES``
> > +    It indicates that the statistics data is used to measure CPU clock=
 cycles.
> > +    The ``KVM_STATS_SCALE_POW10`` flag is valid in this case. For exam=
ple, if
> > +    value is 200, ``exponent`` is 4, we can get the number of CPU cloc=
k cycles
> > +    by ``value * pow(10, exponent) =3D 200 * pow(10, 4) =3D 2000000``.
> > +
> > +The ``exponent`` field is the scale of corresponding statistics data. =
It has two
> > +values as follows:
> > +  * ``KVM_STATS_SCALE_POW10``
> > +    The scale is based on power of 10. It is used for measurement of t=
ime and
> > +    CPU clock cycles.
> > +  * ``KVM_STATS_SCALE_POW2``
> > +    The scale is based on power of 2. It is used for measurement of me=
mory size.
> > +
> > +The ``size`` field is the number of values of this statistics data. It=
 is in the
> > +unit of ``unsigned long`` for VCPU or ``__u64`` for VM.
> > +
> > +The ``unused1`` and ``unused2`` fields are reserved for future
> > +support for other types of statistics data, like log/linear histogram.
> > +
> > +The ``name`` field points to the name string of the statistics data. T=
he name
> > +string starts at the end of ``struct kvm_stats_desc``.
> > +The maximum length (including trailing '\0') is indicated by ``name_si=
ze``
> > +in ``struct kvm_stats_header``.
> > +
> > +The Stats Data block contains an array of data values of type ``struct
> > +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be rea=
d by
> > +user space periodically to pull statistics data.
> > +The order of data value in Stats Data block is the same as the order o=
f
> > +descriptors in Descriptors block.
> > +  * Statistics data for VM::
> > +
> > +     struct kvm_vm_stats_data {
> > +             unsigned long value[0];
> > +     };
> > +
> > +  * Statistics data for VCPU::
> > +
> > +     struct kvm_vcpu_stats_data {
> > +             __u64 value[0];
> > +     };
> > +
> >   5. The kvm_run structure
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > @@ -6740,3 +6901,11 @@ vcpu_info is set.
> >   The KVM_XEN_HVM_CONFIG_RUNSTATE flag indicates that the runstate-rela=
ted
> >   features KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR/_CURRENT/_DATA/_ADJUST =
are
> >   supported by the KVM_XEN_VCPU_SET_ATTR/KVM_XEN_VCPU_GET_ATTR ioctls.
> > +
> > +8.31 KVM_CAP_STATS_BINARY_FD
> > +----------------------------
> > +
> > +:Architectures: all
> > +
> > +This capability indicates the feature that user space can create get a=
 file
> > +descriptor for every VM and VCPU to read statistics data in binary for=
mat.
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
