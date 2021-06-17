Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED593AAB9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 08:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQGHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 02:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQGHO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 02:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC0B361241;
        Thu, 17 Jun 2021 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623909907;
        bh=kjP9+T+FmEwuicRXDVHEk8Z4tkoS0foRxBhRhF9EAqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IA8d5JaiFMvog9SZe7/L871QLI+SQWNyMXLymWGi3ojDYyeU3RoBRDZSMY3cJkeOO
         WIg9KihxcaCD0QN4jZhXOB0sFCDIeS9HeWJL7bjZY1sA2LBdtH2DzctLBv1/hhGOjQ
         b0qwQ03b10MYLb7x1u/SQg8jB1u2z11fol2fq2nE=
Date:   Thu, 17 Jun 2021 08:05:03 +0200
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
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMrmDwfmBPdZqLjC@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617044146.2667540-4-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
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
> +		char id[0];
> +	};

So you have no idea the size of the whole header when reading it?  That
feels odd, are you sure it's not needed?

> +The ``id`` field is identification for the corresponding KVM statistics. For
> +VM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> +"kvm-12345/vcpu-12".

Why do you have "name_size" but not "id_size"?

And is this a \0 terminated string?  If so, please state it here.

And what is the max size of this string?

And again, should it be [], not [0]?

Will the header be padded out to any specific byte boundry
(4/8/32/whatever) before the other headers?

> +
> +The ``name_size`` field is the size (byte) of the statistics name string

s/byte/in bytes/

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
> +		char name[0];
> +	};
> +
> +The ``flags`` field contains the type and unit of the statistics data described
> +by this descriptor. The following flags are supported:
> +
> +Bits 0-3 of ``flags`` encode the type:
> +  * ``KVM_STATS_TYPE_CUMULATIVE``
> +    The statistics data is cumulative. The value of data can only be increased.
> +    Most of the counters used in KVM are of this type.
> +    The corresponding ``count`` field for this type is always 1.
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
> +Bits 8-11 of ``flags`` encode the base:
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

Might also want to show a negative example here for exponent, like you
show above for time.


> +
> +The ``size`` field is the number of values (u64) of this statistics data. Its
> +value is usually 1 for most of simple statistics.

What does "u64" mean here?

thanks,

greg k-h
