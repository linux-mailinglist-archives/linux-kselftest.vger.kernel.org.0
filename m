Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12295390BEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhEYWIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhEYWII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 18:08:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE49EC061760
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 15:06:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i22so48122733lfl.10
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh99vg719jEXz7oeQrlMJYD7UmoB+o+hwezzj4i30GA=;
        b=d8xfgCoTP157xI8/Rf0oGs5byG/v/tKpY/rz4TYQPubOyI5+8WHljGslwOQkEU5fpC
         V/6amuuYTclDo1SIzSgX8hn4JekfQbJMGwfrTh5YbBR/+kxDGjLTxfuGi00j2c16hOnh
         RbXCI76QP2TVURE6ndbYWD9BxJLrf+kuKXaaoDVJ+kht0hDeaJwM+OXe7ddK6ULpIlM5
         i7A3S6+KGYd4MPyC2UD9H77Bu2jXuykh8jzXd1COHQjkunneJHPgxMCE58ads145dGPl
         QvP6uS5SGYVKwsysb0VUyvGn9euoXymTkjs5S0qx+bMXpWtVOX8I8uev/lYyVUOUH0N5
         SKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh99vg719jEXz7oeQrlMJYD7UmoB+o+hwezzj4i30GA=;
        b=QBJH5HQWiuoK+Y7EseZGTyDts9FQpi8udr1Gi4LkVih+Ej7yymSu8pLkVpUsmMMqYe
         EPSpkhhpUkABpGdsa7tSF9aKZyXxWHwTe5/gXf2OVLH7pRjb4S8G071uAYfo0EVs2oD0
         yJJVg88rcrgXSsootXB6gnNRtGnvAM65RiMCTm9cuv7oLGraah9DA5Z/aBQIEWiNPiwb
         BxUtc2Ey4dWqMQRKIlH7A8L8wHsMakg17gIWtLIiTGFEpQmwlqkYdYuhkga3QoeD5kdK
         nDCaLf4Bvcn2ID4wqXYfhFxj0MUKUk+DhdX3wYOzyTuz9shrs8gyGqcPOuu8inO1mmql
         +ckg==
X-Gm-Message-State: AOAM531r/JEj14Hucf4zit7FN6w/uVUKQuDgjmarItaLAv2EL/xiL/OV
        +uFfSlV+IwUxWUM+af5jGw3O4/cVtaOp+Bpz9FWnKw==
X-Google-Smtp-Source: ABdhPJwPmLdtX1U3kdr10R66PSq7akG8i47uhoXZILuWIJzDsqI1sMbwDg0i6in67WGXhGjU+ZpF19B7p+Fbrg72xUM=
X-Received: by 2002:ac2:5149:: with SMTP id q9mr15796526lfd.46.1621980395705;
 Tue, 25 May 2021 15:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210524151828.4113777-1-jingzhangos@google.com> <20210524151828.4113777-4-jingzhangos@google.com>
In-Reply-To: <20210524151828.4113777-4-jingzhangos@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 25 May 2021 15:06:09 -0700
Message-ID: <CALzav=f2YS3F1XTn9SV5cMxhrc-vhBH10jAtKWnCu3D-OnHGSA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] KVM: stats: Add documentation for statistics data
 binary interface
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 24, 2021 at 8:18 AM Jing Zhang <jingzhangos@google.com> wrote:
>
> Update KVM API documentation for binary statistics.
>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  Documentation/virt/kvm/api.rst | 179 +++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..5cedddd579b2 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,6 +5034,177 @@ see KVM_XEN_VCPU_SET_ATTR above.
>  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>  with the KVM_XEN_VCPU_GET_ATTR ioctl.
>
> +4.130 KVM_STATS_GETFD
> +---------------------
> +
> +:Capability: KVM_CAP_STATS_BINARY_FD
> +:Architectures: all
> +:Type: vm ioctl, vcpu ioctl
> +:Parameters: none
> +:Returns: statistics file descriptor on success, < 0 on error
> +
> +Errors:
> +
> +  ======     ======================================================
> +  ENOMEM     if the fd could not be created due to lack of memory
> +  EMFILE     if the number of opened files exceeds the limit
> +  ======     ======================================================
> +
> +The file descriptor can be used to read VM/vCPU statistics data in binary
> +format. The file data is organized into three blocks as below:
> ++-------------+
> +|   Header    |
> ++-------------+
> +| Descriptors |
> ++-------------+
> +| Stats Data  |
> ++-------------+
> +
> +The Header block is always at the start of the file. It is only needed to be
> +read one time after a VM boot.

nit: "after a VM boot" is not exactly right. If a VM reboots,
userspace does not need to re-read the header. Perhaps change this to
"for the lifetime of the file descriptor"?

> +It is in the form of ``struct kvm_stats_header`` as below::
> +
> +       #define KVM_STATS_ID_MAXLEN             64
> +
> +       struct kvm_stats_header {
> +               char id[KVM_STATS_ID_MAXLEN];
> +               __u32 name_size;
> +               __u32 count;
> +               __u32 desc_offset;
> +               __u32 data_offset;
> +       };
> +
> +The ``id`` field is identification for the corresponding KVM statistics. For
> +VM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> +"kvm-12345/vcpu-12".
> +
> +The ``name_size`` field is the size (byte) of the statistics name string
> +(including trailing '\0') appended to the end of every statistics descriptor.
> +
> +The ``count`` field is the number of statistics.
> +
> +The ``desc_offset`` field is the offset of the Descriptors block from the start
> +of the file indicated by the file descriptor.
> +
> +The ``data_offset`` field is the offset of the Stats Data block from the start
> +of the file indicated by the file descriptor.
> +
> +The Descriptors block is only needed to be read once after a VM boot. It is

Ditto here.

> +an array of ``struct kvm_stats_desc`` as shown in below code block::
> +
> +       #define KVM_STATS_TYPE_SHIFT            0
> +       #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> +
> +       #define KVM_STATS_UNIT_SHIFT            4
> +       #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> +
> +       #define KVM_STATS_BASE_SHIFT            8
> +       #define KVM_STATS_BASE_MASK             (0xF << KVM_STATS_BASE_SHIFT)
> +       #define KVM_STATS_BASE_POW10            (0x0 << KVM_STATS_BASE_SHIFT)
> +       #define KVM_STATS_BASE_POW2             (0x1 << KVM_STATS_BASE_SHIFT)
> +       #define KVM_STATS_BASE_MAX              KVM_STATS_BASE_POW2
> +
> +       struct kvm_stats_desc {
> +               __u32 flags;
> +               __s16 exponent;
> +               __u16 size;
> +               __u32 unused1;
> +               __u32 unused2;
> +               char name[0];
> +       };
> +
> +The ``flags`` field contains the type and unit of the statistics data described
> +by this descriptor. The following flags are supported:
> +
> +Bits 0-3 of ``flags`` encode the type:
> +  * ``KVM_STATS_TYPE_CUMULATIVE``
> +    The statistics data is cumulative. The value of data can only be increased.
> +    Most of the counters used in KVM are of this type.
> +    The corresponding ``count`` filed for this type is always 1.
> +  * ``KVM_STATS_TYPE_INSTANT``
> +    The statistics data is instantaneous. Its value can be increased or
> +    decreased. This type is usually used as a measurement of some resources,
> +    like the number of dirty pages, the number of large pages, etc.
> +    The corresponding ``count`` field for this type is always 1.
> +
> +Bits 4-7 of ``flags`` encode the unit:
> +  * ``KVM_STATS_UNIT_NONE``
> +    There is no unit for the value of statistics data. This usually means that
> +    the value is a simple counter of an event.
> +  * ``KVM_STATS_UNIT_BYTES``
> +    It indicates that the statistics data is used to measure memory size, in the
> +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> +    determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_BASE_POW2`` flag is valid in this case. The unit of the data is
> +    determined by ``pow(2, exponent)``. For example, if value is 10,
> +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> +    can get the statistics data in the unit of Byte by
> +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> +    10 * 1024 * 1024 Bytes.
> +  * ``KVM_STATS_UNIT_SECONDS``
> +    It indicates that the statistics data is used to measure time/latency, in
> +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> +    data is determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_BASE_POW10`` flag is valid in this case. The unit of the data
> +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> +    we can get the statistics data in the unit of second by
> +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> +  * ``KVM_STATS_UNIT_CYCLES``
> +    It indicates that the statistics data is used to measure CPU clock cycles.
> +    The ``KVM_STATS_BASE_POW10`` flag is valid in this case. For example, if
> +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> +
> +Bits 7-11 of ``flags`` encode the base:
> +  * ``KVM_STATS_BASE_POW10``
> +    The scale is based on power of 10. It is used for measurement of time and
> +    CPU clock cycles.
> +  * ``KVM_STATS_BASE_POW2``
> +    The scale is based on power of 2. It is used for measurement of memory size.
> +
> +The ``exponent`` field is the scale of corresponding statistics data. For
> +example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
> +``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
> +unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
> +
> +The ``size`` field is the number of values of this statistics data. It is in the
> +unit of ``unsigned long`` for VM or ``__u64`` for VCPU.
> +
> +The ``unused1`` and ``unused2`` fields are reserved for future
> +support for other types of statistics data, like log/linear histogram.
> +
> +The ``name`` field points to the name string of the statistics data. The name
> +string starts at the end of ``struct kvm_stats_desc``.
> +The maximum length (including trailing '\0') is indicated by ``name_size``
> +in ``struct kvm_stats_header``.
> +
> +The Stats Data block contains an array of data values of type ``struct
> +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
> +user space periodically to pull statistics data.
> +The order of data value in Stats Data block is the same as the order of
> +descriptors in Descriptors block.
> +  * Statistics data for VM::
> +
> +       struct kvm_vm_stats_data {
> +               unsigned long value[0];
> +       };
> +
> +  * Statistics data for VCPU::
> +
> +       struct kvm_vcpu_stats_data {
> +               __u64 value[0];
> +       };
> +
>  5. The kvm_run structure
>  ========================
>
> @@ -6891,3 +7062,11 @@ This capability is always enabled.
>  This capability indicates that the KVM virtual PTP service is
>  supported in the host. A VMM can check whether the service is
>  available to the guest on migration.
> +
> +8.33 KVM_CAP_STATS_BINARY_FD
> +----------------------------
> +
> +:Architectures: all
> +
> +This capability indicates the feature that user space can create get a file
> +descriptor for every VM and VCPU to read statistics data in binary format.
> --
> 2.31.1.818.g46aad6cb9e-goog
>
