Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2234F3AD51E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhFRW3c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 18:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhFRW3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 18:29:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A60AC06175F
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cj11-20020a056214056bb029026a99960c7aso1366053qvb.22
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OA+JdIquUOVcL/l8QewS/+IzKG93A6pr9TNQuQAgEfw=;
        b=hIRLz+6Zgs7A3X4lM/Jp/zMEc06UAnyy4/DRB7iM2LP8l3lTDWwj0lTR23ZnOAOjIt
         +8vU0yIx0XHGx/RQJzRr4NA3ptsFAG0jm6Krt7CRuxqcAt6Tz4dv7ApA36kV8+rQMK81
         5E3PSbaHw1dWaczKmJfQIBT7EFBaUUk0KppAzeTqGyFuRTJwJb7jesgOD7JrxQ5J6nQr
         YfXpT/cKmt+sh94cHA6GbTfmAlbIFfZAa9libpF1qyjNI7V6n/AgCdpjP5A1CgckCH+q
         oblVUXDVWSZEHfFBt3qxhhHrB6Y4uK+s4DT9vjGz6a8C3GmcRBEPse+Z63/Ca5hQPM3z
         OXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OA+JdIquUOVcL/l8QewS/+IzKG93A6pr9TNQuQAgEfw=;
        b=aZqsgI1N59NeoLsvHa60P1xhZ84dWccxCbj4sBWodMP9seAnuDG0g/ictorD8eFu+m
         FLzz5WCKc4NoJT6CukIHGDMdf5S5/4jPPIbF867RWLCfqH5d6I5UbOXkv00q2rTiHV9i
         uflX7fQevre6DcHo6hQilwkaraHCn/5ZRL3HJly0mtU7PQXe1MLYulIbwcQSNYjhZB+R
         m1arfPrtajwIyPsv1PhlhTIskeiVRCaEonp/v5J9Yx4n3wMpYkU+mEbo0pCpKCJgJtCz
         q2KB0P+QYedf2B5jhcB/9yVkJAU9nVXGqCTpiHIEpN+Yk+RLmziWLbMHENN2EsincTEm
         f/nw==
X-Gm-Message-State: AOAM532GKIAnjyvRmxYKsoduhDb6NZ8HJ02sNSxhUhFyF0eh3VapBUgg
        tFtFDm/031RfPodb1GtUoDjyAvTwV+Iw+Y53pg==
X-Google-Smtp-Source: ABdhPJziHRaegNqaGrPpMtfw89jDozVTZxzI6xQ16fOQCFL1WD/l+D18PTKai6NrGHKXgUhaHCSSBZxRvDmKkr8rww==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:ad4:55eb:: with SMTP id
 bu11mr8098250qvb.2.1624055240676; Fri, 18 Jun 2021 15:27:20 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:27:07 +0000
In-Reply-To: <20210618222709.1858088-1-jingzhangos@google.com>
Message-Id: <20210618222709.1858088-6-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v12 5/7] KVM: stats: Add documentation for binary statistics interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new API provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
The statistics descriptors are defined by KVM in kernel and can be
by userspace to discover VM/VCPU statistics during the one-time setup
stage.
The statistics data itself could be read out by userspace telemetry
periodically without any extra parsing or setup effort.
There are a few existed interface protocols and definitions, but no
one can fulfil all the requirements this interface implemented as
below:
1. During high frequency periodic stats reading, there should be no
   extra efforts except the stats data read itself.
2. Support stats annotation, like type (cumulative, instantaneous,
   peak, histogram, etc) and unit (counter, time, size, cycles, etc).
3. The stats data reading should be free of lock/synchronization. We
   don't care about the consistency between all the stats data. All
   stats data can not be read out at exactly the same time. We really
   care about the change or trend of the stats data. The lock-free
   solution is not just for efficiency and scalability, also for the
   stats data accuracy and usability. For example, in the situation
   that all the stats data readings are protected by a global lock,
   if one VCPU died somehow with that lock held, then all stats data
   reading would be blocked, then we have no way from stats data that
   which VCPU has died.
4. The stats data reading workload can be handed over to other
   unprivileged process.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 Documentation/virt/kvm/api.rst | 198 ++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e328caa35d6c..289ea7be696a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5034,7 +5034,6 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
-
 4.131 KVM_GET_SREGS2
 ------------------
 
@@ -5081,6 +5080,195 @@ Writes special registers into the vcpu.
 See KVM_GET_SREGS2 for the data structures.
 This ioctl (when supported) replaces the KVM_SET_SREGS.
 
+4.133 KVM_GET_STATS_FD
+----------------------
+
+:Capability: KVM_CAP_STATS_BINARY_FD
+:Architectures: all
+:Type: vm ioctl, vcpu ioctl
+:Parameters: none
+:Returns: statistics file descriptor on success, < 0 on error
+
+Errors:
+
+  ======     ======================================================
+  ENOMEM     if the fd could not be created due to lack of memory
+  EMFILE     if the number of opened files exceeds the limit
+  ======     ======================================================
+
+The file descriptor can be used to read VM/vCPU statistics data in binary
+format. Please be aware that it is not guaranteed that the four blocks are
+adjacent, that's why offset fields are included in the Header. But the
+order of the four blocks are guaranteed and there is no overlap between any
+two blocks.
+And all four blocks are aligned with 64 bits in the file.
+The file data is organized into three blocks as below:
++-------------+
+|   Header    |
++-------------+
++-------------+
+|  id string  |
++-------------+
++-------------+
+| Descriptors |
++-------------+
++-------------+
+| Stats Data  |
++-------------+
+
+The Header block is always at the start of the file. It is only needed to be
+read one time for the lifetime of the file descriptor.
+It is in the form of ``struct kvm_stats_header`` as below::
+
+	struct kvm_stats_header {
+                __u32 flags;
+		__u32 name_size;
+		__u32 num_desc;
+                __u32 id_offset;
+		__u32 desc_offset;
+		__u32 data_offset;
+	};
+
+The ``flags`` field is not used at the moment. It is always read as 0.
+
+The ``name_size`` field is the size (in byte) of the statistics name string
+(including trailing '\0') appended to the end of every statistics descriptor.
+It also is the size of id string block.
+
+The ``num_desc`` field is the number of statistics.
+
+The ``id_offset`` field is the offset of the id string from the start of the
+file indicated by the file descriptor. It is a multiple of 8.
+
+The ``desc_offset`` field is the offset of the Descriptors block from the start
+of the file indicated by the file descriptor. It is a multiple of 8.
+
+The ``data_offset`` field is the offset of the Stats Data block from the start
+of the file indicated by the file descriptor. It is a multiple of 8.
+
+The id string is a '\0' terminated string which identifies the corresponding
+KVM statistics. For VM statistics, it is in the form of "kvm-{kvm pid}", like
+"kvm-12345". For VCPU statistics, it is in the form of
+"kvm-{kvm pid}/vcpu-{vcpu id}", like "kvm-12345/vcpu-12".
+The size of id string block is indicated by the ``name_size`` field in Header.
+
+The Descriptors block is only needed to be read once for the lifetime of the
+file descriptor. It is an array of ``struct kvm_stats_desc`` as shown in
+below code block::
+
+	#define KVM_STATS_TYPE_SHIFT		0
+	#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
+	#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
+	#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
+        #define KVM_STATS_TYPE_PEAK		(0x2 << KVM_STATS_TYPE_SHIFT)
+        #define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_PEAK
+
+	#define KVM_STATS_UNIT_SHIFT		4
+	#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
+
+	#define KVM_STATS_BASE_SHIFT		8
+	#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
+	#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
+	#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
+	#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
+
+	struct kvm_stats_desc {
+		__u32 flags;
+		__s16 exponent;
+		__u16 size;
+		__u32 offset;
+		__u32 unused;
+		char name[];
+	};
+
+The ``flags`` field contains the type and unit of the statistics data described
+by this descriptor. Its endianness is CPU native.
+The following flags are supported:
+
+Bits 0-3 of ``flags`` encode the type:
+  * ``KVM_STATS_TYPE_CUMULATIVE``
+    The statistics data is cumulative. The value of data can only be increased.
+    Most of the counters used in KVM are of this type.
+    The corresponding ``size`` field for this type is always 1.
+    All cumulative statistics data are read/write.
+  * ``KVM_STATS_TYPE_INSTANT``
+    The statistics data is instantaneous. Its value can be increased or
+    decreased. This type is usually used as a measurement of some resources,
+    like the number of dirty pages, the number of large pages, etc.
+    All instant statistics are read only.
+    The corresponding ``size`` field for this type is always 1.
+  * ``KVM_STATS_TYPE_PEAK``
+    The statistics data is peak, which is used as read/write instant statistics.
+    The corresponding ``size`` field for this type is always 1.
+
+Bits 4-7 of ``flags`` encode the unit:
+  * ``KVM_STATS_UNIT_NONE``
+    There is no unit for the value of statistics data. This usually means that
+    the value is a simple counter of an event.
+  * ``KVM_STATS_UNIT_BYTES``
+    It indicates that the statistics data is used to measure memory size, in the
+    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
+    determined by the ``exponent`` field in the descriptor. The
+    ``KVM_STATS_BASE_POW2`` flag is valid in this case. The unit of the data is
+    determined by ``pow(2, exponent)``. For example, if value is 10,
+    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
+    can get the statistics data in the unit of Byte by
+    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
+    10 * 1024 * 1024 Bytes.
+  * ``KVM_STATS_UNIT_SECONDS``
+    It indicates that the statistics data is used to measure time/latency, in
+    the unit of nanosecond, microsecond, millisecond and second. The unit of the
+    data is determined by the ``exponent`` field in the descriptor. The
+    ``KVM_STATS_BASE_POW10`` flag is valid in this case. The unit of the data
+    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
+    ``exponent`` is -6, which means the unit of statistics data is microsecond,
+    we can get the statistics data in the unit of second by
+    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
+  * ``KVM_STATS_UNIT_CYCLES``
+    It indicates that the statistics data is used to measure CPU clock cycles.
+    The ``KVM_STATS_BASE_POW10`` flag is valid in this case. For example, if
+    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
+    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
+
+Bits 8-11 of ``flags`` encode the base:
+  * ``KVM_STATS_BASE_POW10``
+    The scale is based on power of 10. It is used for measurement of time and
+    CPU clock cycles.
+  * ``KVM_STATS_BASE_POW2``
+    The scale is based on power of 2. It is used for measurement of memory size.
+
+The ``exponent`` field is the scale of corresponding statistics data. For
+example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
+``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
+unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
+If the unit is ``KVM_STATS_UNIT_SECONDS``, the base is ``KVM_STATS_BASE_POW10``,
+the ``exponent`` is -6, then we know that the real unit of the statistics data
+is microsecond a.k.a 1 second * pow(10, -6) = 1 microsecond.
+
+The ``size`` field is the number of values of this statistics data. Its
+value is usually 1 for most of simple statistics. 1 means it contains an
+unsigned 64bit data.
+
+The ``offset`` field is the offset from the start of Data Block to the start of
+the corresponding statistics data.
+
+The ``unused`` fields are reserved for future support for other types of
+statistics data, like log/linear histogram. Its current value is always 0.
+
+The ``name`` field is the name string of the statistics data. The name string
+starts at the end of ``struct kvm_stats_desc``.
+The maximum length (including trailing '\0') is indicated by ``name_size``
+in ``struct kvm_stats_header``.
+
+The Stats Data block contains an array of statistics data whose type is __u64.
+It would be read out by userspace periodically.
+The order of data value in Stats Data block is the same as the order of
+descriptors in Descriptors block.
 
 5. The kvm_run structure
 ========================
@@ -6969,3 +7157,11 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
 of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
 the hypercalls whose corresponding bit is in the argument, and return
 ENOSYS for the others.
+
+8.35 KVM_CAP_STATS_BINARY_FD
+----------------------------
+
+:Architectures: all
+
+This capability indicates the feature that userspace can create get a file
+descriptor for every VM and VCPU to read statistics data in binary format.
-- 
2.32.0.288.g62a8d224e6-goog

