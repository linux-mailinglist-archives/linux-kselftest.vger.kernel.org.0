Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299CB3AC472
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFRHEV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 03:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbhFRHEV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 03:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE746100A;
        Fri, 18 Jun 2021 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623999732;
        bh=lPwhwKYjLCuBb8iHU8Fh4mII4hR3kacqcXifOpUboVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pd4DtYq3djICAHUOSGQlUqCHGrPLaz23j7yHmMvA9IlMEFXXRx5TcHYpUNnHS+cZZ
         e7k1Q3mzozRQaz8RD5qRcWMEBdzePEi3+EUkbh7Nd/z6fcmVdiDgihCW3nyPzogDR0
         2b10gOywi6w5pc+tS/hdE6hw/4+bnU2P58rz9in0=
Date:   Fri, 18 Jun 2021 09:02:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
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
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v11 5/7] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMxE8pUrbQkwlpbD@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-6-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618044819.3690166-6-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 04:48:17AM +0000, Jing Zhang wrote:
> This new API provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.
> It is meant to provide a lightweight, flexible, scalable and efficient
> lock-free solution for user space telemetry applications to pull the
> statistics data periodically for large scale systems. The pulling
> frequency could be as high as a few times per second.
> The statistics descriptors are defined by KVM in kernel and can be
> by userspace to discover VM/VCPU statistics during the one-time setup
> stage.
> The statistics data itself could be read out by userspace telemetry
> periodically without any extra parsing or setup effort.
> There are a few existed interface protocols and definitions, but no
> one can fulfil all the requirements this interface implemented as
> below:
> 1. During high frequency periodic stats reading, there should be no
>    extra efforts except the stats data read itself.
> 2. Support stats annotation, like type (cumulative, instantaneous,
>    peak, histogram, etc) and unit (counter, time, size, cycles, etc).
> 3. The stats data reading should be free of lock/synchronization. We
>    don't care about the consistency between all the stats data. All
>    stats data can not be read out at exactly the same time. We really
>    care about the change or trend of the stats data. The lock-free
>    solution is not just for efficiency and scalability, also for the
>    stats data accuracy and usability. For example, in the situation
>    that all the stats data readings are protected by a global lock,
>    if one VCPU died somehow with that lock held, then all stats data
>    reading would be blocked, then we have no way from stats data that
>    which VCPU has died.
> 4. The stats data reading workload can be handed over to other
>    unprivileged process.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 176 ++++++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e328caa35d6c..7ca1c8d190c0 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,7 +5034,6 @@ see KVM_XEN_VCPU_SET_ATTR above.
>  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>  with the KVM_XEN_VCPU_GET_ATTR ioctl.
>  
> -
>  4.131 KVM_GET_SREGS2
>  ------------------
>  
> @@ -5081,6 +5080,173 @@ Writes special registers into the vcpu.
>  See KVM_GET_SREGS2 for the data structures.
>  This ioctl (when supported) replaces the KVM_SET_SREGS.
>  
> +4.133 KVM_GET_STATS_FD
> +----------------------
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
> +read one time for the lifetime of the file descriptor.
> +It is in the form of ``struct kvm_stats_header`` as below::
> +
> +	#define KVM_STATS_ID_MAXLEN		64
> +
> +	struct kvm_stats_header {
> +		__u32 name_size;
> +		__u32 count;
> +		__u32 desc_offset;
> +		__u32 data_offset;
> +		char id[];
> +	};
> +
> +The ``id`` field is a '\0' terminated string which identifies the corresponding
> +KVM statistics. For VM statistics, it is in the form of "kvm-{kvm pid}", like
> +"kvm-12345". For VCPU statistics, it is in the form of
> +"kvm-{kvm pid}/vcpu-{vcpu id}", like "kvm-12345/vcpu-12".
> +
> +The ``name_size`` field is the size (in byte) of the statistics name string
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
> +The Descriptors block is only needed to be read once for the lifetime of the
> +file descriptor. It is an array of ``struct kvm_stats_desc`` as shown in
> +below code block::
> +
> +	#define KVM_STATS_TYPE_SHIFT		0
> +	#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
> +
> +	#define KVM_STATS_UNIT_SHIFT		4
> +	#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
> +
> +	#define KVM_STATS_BASE_SHIFT		8
> +	#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
> +
> +	struct kvm_stats_desc {
> +		__u32 flags;
> +		__s16 exponent;
> +		__u16 size;
> +		__u32 offset;
> +		__u32 unused;
> +		char name[];
> +	};

As I mention in another patch, this should be sucked in directly from
the .h file in kerneldoc format, so that everything stays in sync.  I
bet almost this whole file can be put into the .h file, look at how drm
and v4l2 does this in a way that you only have to write the above one
time, not try to keep it in sync in two different places.

thanks,

greg k-h
