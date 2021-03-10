Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2E33326E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 01:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhCJAbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 19:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhCJAap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 19:30:45 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FDAC061760
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Mar 2021 16:30:45 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id s13so11568520ilp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Mar 2021 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HYwIHVMurXa3R6as3OvUxWmJFUBMLjiRzzhIiiKP4ME=;
        b=KlgzRB+CEZgxcFGOn//lNka3ixGNj1ZMzKq7WAvbwDFq3xRkgAS3kYK/JIV4nIxm/u
         1FfbdecWvmBbdiWVheE3wUNE32IOWAGMhu8MeFMpPUxkNG6Ic6IXrOYz15juiE5W+eN/
         UwufP8xnomHHhYJZizlFxCzJtMQMPP3AGyXKTMDhs5E9C0vskRVTcj7UvkXA1PH14ykl
         ft27CoJWrjGy2SvqG2c1AGionh3n73Ki0G54VqY7GeECtpHBPlD1in+kzQ+UDi+3daXg
         fS/ssqaH/09kuWnDkSliepIZRP1LHJvuV+kQD5aXzLq5vN3FattwTAMNMi+qTW2bJSmf
         Tddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HYwIHVMurXa3R6as3OvUxWmJFUBMLjiRzzhIiiKP4ME=;
        b=VeK1nGsaAQs+AgqgkCcJRf/OPc5GPpIbbXZL6vuY/dmJECbLnf8UxpOo/SRPoUem18
         KztJ9Ht6Dcw69+Emtx7GGcYeOnbzWd1ipw2sls5xmuvbu2Hcg5bMKvvViXqoJouh15eR
         3GgxqsPXiuVY9TeTmeaHhaA3wadrdnXwRgQRzB6NoIoj71Sw+6NIUoFrziTdW+da1Lb2
         YFTHZnzgkP00O/ncSZxro8TOBFmJa4tj/3TajF52QA1qMrcIFQZkqH6MmVyqnhRMqNPG
         sxnJ4Hl48W3ucAkrQ0hBQQQFLpEw7hI26uCxf1k9oCCHiPl2nRhjDzjqhXz92+iSemma
         aeng==
X-Gm-Message-State: AOAM530gcZuRg42QzG+3+CdBLqlHyByrNJTfgZCZPavlx565pRV6QqTO
        fW++5FiwZMPTsWemOmRSJINWdoLFAmBd+Ockxw==
X-Google-Smtp-Source: ABdhPJza+jn+PY8flshTTgOAKq9hoAYgUHER9XS+P4s7skBsrShHEuKgzkWZTeYGcckPt9nBzOg82EPVRau5TPgGJA==
X-Received: from jingzhangos.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:513])
 (user=jingzhangos job=sendgmr) by 2002:a6b:6f14:: with SMTP id
 k20mr642440ioc.52.1615336245163; Tue, 09 Mar 2021 16:30:45 -0800 (PST)
Date:   Wed, 10 Mar 2021 00:30:23 +0000
In-Reply-To: <20210310003024.2026253-1-jingzhangos@google.com>
Message-Id: <20210310003024.2026253-4-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics in
 binary format
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Three ioctl commands are added to support binary form statistics data
retrieval. KVM_STATS_GET_INFO, KVM_STATS_GET_NAMES, KVM_STATS_GET_DATA.
KVM_CAP_STATS_BINARY_FORM indicates the capability.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 virt/kvm/kvm_main.c | 115 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..87dd62516c8b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3464,6 +3464,51 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
 		break;
 	}
+	case KVM_STATS_GET_INFO: {
+		struct kvm_stats_info stats_info;
+
+		r = -EFAULT;
+		stats_info.num_stats = VCPU_STAT_COUNT;
+		if (copy_to_user(argp, &stats_info, sizeof(stats_info)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_STATS_GET_NAMES: {
+		struct kvm_stats_names stats_names;
+
+		r = -EFAULT;
+		if (copy_from_user(&stats_names, argp, sizeof(stats_names)))
+			goto out;
+		r = -EINVAL;
+		if (stats_names.size < VCPU_STAT_COUNT * KVM_STATS_NAME_LEN)
+			goto out;
+
+		r = -EFAULT;
+		if (copy_to_user(argp + sizeof(stats_names),
+				kvm_vcpu_stat_strings,
+				VCPU_STAT_COUNT * KVM_STATS_NAME_LEN))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_STATS_GET_DATA: {
+		struct kvm_stats_data stats_data;
+
+		r = -EFAULT;
+		if (copy_from_user(&stats_data, argp, sizeof(stats_data)))
+			goto out;
+		r = -EINVAL;
+		if (stats_data.size < sizeof(vcpu->stat))
+			goto out;
+
+		r = -EFAULT;
+		argp += sizeof(stats_data);
+		if (copy_to_user(argp, &vcpu->stat, sizeof(vcpu->stat)))
+			goto out;
+		r = 0;
+		break;
+	}
 	default:
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
@@ -3695,6 +3740,7 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_CHECK_EXTENSION_VM:
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
+	case KVM_CAP_STATS_BINARY_FORM:
 		return 1;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -3825,6 +3871,40 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 	}
 }
 
+static long kvm_vm_ioctl_stats_get_data(struct kvm *kvm, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct kvm_vcpu *vcpu;
+	struct kvm_stats_data stats_data;
+	u64 *data = NULL, *pdata;
+	int i, j, ret = 0;
+	size_t dsize = (VM_STAT_COUNT + VCPU_STAT_COUNT) * sizeof(*data);
+
+
+	if (copy_from_user(&stats_data, argp, sizeof(stats_data)))
+		return -EFAULT;
+	if (stats_data.size < dsize)
+		return -EINVAL;
+	data = kzalloc(dsize, GFP_KERNEL_ACCOUNT);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < VM_STAT_COUNT; i++)
+		*(data + i) = *((ulong *)&kvm->stat + i);
+
+	kvm_for_each_vcpu(j, vcpu, kvm) {
+		pdata = data + VM_STAT_COUNT;
+		for (i = 0; i < VCPU_STAT_COUNT; i++, pdata++)
+			*pdata += *((u64 *)&vcpu->stat + i);
+	}
+
+	if (copy_to_user(argp + sizeof(stats_data), data, dsize))
+		ret = -EFAULT;
+
+	kfree(data);
+	return ret;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4001,6 +4081,41 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_STATS_GET_INFO: {
+		struct kvm_stats_info stats_info;
+
+		r = -EFAULT;
+		stats_info.num_stats = VM_STAT_COUNT + VCPU_STAT_COUNT;
+		if (copy_to_user(argp, &stats_info, sizeof(stats_info)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_STATS_GET_NAMES: {
+		struct kvm_stats_names stats_names;
+
+		r = -EFAULT;
+		if (copy_from_user(&stats_names, argp, sizeof(stats_names)))
+			goto out;
+		r = -EINVAL;
+		if (stats_names.size <
+			(VM_STAT_COUNT + VCPU_STAT_COUNT) * KVM_STATS_NAME_LEN)
+			goto out;
+		r = -EFAULT;
+		argp += sizeof(stats_names);
+		if (copy_to_user(argp, kvm_vm_stat_strings,
+				VM_STAT_COUNT * KVM_STATS_NAME_LEN))
+			goto out;
+		argp += VM_STAT_COUNT * KVM_STATS_NAME_LEN;
+		if (copy_to_user(argp, kvm_vcpu_stat_strings,
+				VCPU_STAT_COUNT * KVM_STATS_NAME_LEN))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_STATS_GET_DATA:
+		r =  kvm_vm_ioctl_stats_get_data(kvm, arg);
+		break;
 	case KVM_CHECK_EXTENSION:
 		r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
 		break;
-- 
2.30.1.766.gb4fecdf3b7-goog

