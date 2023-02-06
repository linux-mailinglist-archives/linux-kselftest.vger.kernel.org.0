Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531B68C3BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjBFQqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjBFQqX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6228D1F;
        Mon,  6 Feb 2023 08:46:20 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GiWvO011116;
        Mon, 6 Feb 2023 16:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QPD1MrXyBQd+lcXepALqVN2kSoT8JOuhbgmb2MZE3GA=;
 b=BJh12km44+qkNw5M2bpEYum99hT0dqGfnxTNROraVaHsXRxZNybvf3SMzFqrO3V7GZsh
 6uW74biti7d6vafMVNYjXa1Z8O18znHyIZlj/0UlbL7SuBlZHxQXhKPB5mqkrcPKeMNB
 bphFIB8fQszajQSfRmDDdzl0fpl7QijY8PKHTyW07uPr07jFgwlMcP8eZqqL47DMViEW
 aj1MrFiI6dVXv2EMvir5g0QE6uMIoC49KCMw7ZoeaWQaiX06+nZF7rcoyIYarByFZ8lq
 MDmH6XbbQF+prKuJJRG0X6l2dsXdW0mzokpg3vMh1umKMDzjClLRpPY5QJqtxEOyDuwP iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgpa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:17 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GiWBs011125;
        Mon, 6 Feb 2023 16:46:16 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgp8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:16 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31644LwA010414;
        Mon, 6 Feb 2023 16:46:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nhf06sv6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316GkADt25756076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C55820043;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B2072004B;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v7 12/14] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Mon,  6 Feb 2023 17:46:00 +0100
Message-Id: <20230206164602.138068-13-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2QsV-yUFnBU4W5SFSusT005pUIrJDE9f
X-Proofpoint-ORIG-GUID: mUVznMEM9T28b2oEjNIM9HZX2aLV8Bhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User space can use the MEM_OP ioctl to make storage key checked reads
and writes to the guest, however, it has no way of performing atomic,
key checked, accesses to the guest.
Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
op. For now, support this op for absolute accesses only.

This op can be used, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 include/uapi/linux/kvm.h |   8 +++
 arch/s390/kvm/gaccess.h  |   3 ++
 arch/s390/kvm/gaccess.c  | 109 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c |  56 +++++++++++++++++++-
 4 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 55155e262646..d2f30463c133 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_addr;	/* ignored if cmpxchg flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -595,11 +597,17 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_SIDA_WRITE	3
 #define KVM_S390_MEMOP_ABSOLUTE_READ	4
 #define KVM_S390_MEMOP_ABSOLUTE_WRITE	5
+#define KVM_S390_MEMOP_ABSOLUTE_CMPXCHG	6
+
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
 #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
 
+/* flags specifying extension support via KVM_CAP_S390_MEM_OP_EXTENSION */
+#define KVM_S390_MEMOP_EXTENSION_CAP_BASE	(1 << 0)
+#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG	(1 << 1)
+
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
 	/* in */
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 9408d6cc8e2c..b320d12aa049 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode);
 
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len, __uint128_t *old,
+			       __uint128_t new, u8 access_key, bool *success);
+
 /**
  * write_guest_with_key - copy data from kernel space to guest space
  * @vcpu: virtual cpu
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0243b6e38d36..3eb85f254881 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1161,6 +1161,115 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 	return rc;
 }
 
+/**
+ * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
+ * @kvm: Virtual machine instance.
+ * @gpa: Absolute guest address of the location to be changed.
+ * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
+ *       non power of two will result in failure.
+ * @old_addr: Pointer to old value. If the location at @gpa contains this value,
+ *            the exchange will succeed. After calling cmpxchg_guest_abs_with_key()
+ *            *@old_addr contains the value at @gpa before the attempt to
+ *            exchange the value.
+ * @new: The value to place at @gpa.
+ * @access_key: The access key to use for the guest access.
+ * @success: output value indicating if an exchange occurred.
+ *
+ * Atomically exchange the value at @gpa by @new, if it contains *@old.
+ * Honors storage keys.
+ *
+ * Return: * 0: successful exchange
+ *         * >0: a program interruption code indicating the reason cmpxchg could
+ *               not be attempted
+ *         * -EINVAL: address misaligned or len not power of two
+ *         * -EAGAIN: transient failure (len 1 or 2)
+ *         * -EOPNOTSUPP: read-only memslot (should never occur)
+ */
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
+			       __uint128_t *old_addr, __uint128_t new,
+			       u8 access_key, bool *success)
+{
+	gfn_t gfn = gpa_to_gfn(gpa);
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	bool writable;
+	hva_t hva;
+	int ret;
+
+	if (!IS_ALIGNED(gpa, len))
+		return -EINVAL;
+
+	hva = gfn_to_hva_memslot_prot(slot, gfn, &writable);
+	if (kvm_is_error_hva(hva))
+		return PGM_ADDRESSING;
+	/*
+	 * Check if it's a read-only memslot, even though that cannot occur
+	 * since those are unsupported.
+	 * Don't try to actually handle that case.
+	 */
+	if (!writable)
+		return -EOPNOTSUPP;
+
+	hva += offset_in_page(gpa);
+	/*
+	 * The cmpxchg_user_key macro depends on the type of "old", so we need
+	 * a case for each valid length and get some code duplication as long
+	 * as we don't introduce a new macro.
+	 */
+	switch (len) {
+	case 1: {
+		u8 old;
+
+		ret = cmpxchg_user_key((u8 __user *)hva, &old, *old_addr, new, access_key);
+		*success = !ret && old == *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 2: {
+		u16 old;
+
+		ret = cmpxchg_user_key((u16 __user *)hva, &old, *old_addr, new, access_key);
+		*success = !ret && old == *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 4: {
+		u32 old;
+
+		ret = cmpxchg_user_key((u32 __user *)hva, &old, *old_addr, new, access_key);
+		*success = !ret && old == *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 8: {
+		u64 old;
+
+		ret = cmpxchg_user_key((u64 __user *)hva, &old, *old_addr, new, access_key);
+		*success = !ret && old == *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 16: {
+		__uint128_t old;
+
+		ret = cmpxchg_user_key((__uint128_t __user *)hva, &old, *old_addr, new, access_key);
+		*success = !ret && old == *old_addr;
+		*old_addr = old;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	if (*success)
+		mark_page_dirty_in_slot(kvm, slot, gfn);
+	/*
+	 * Assume that the fault is caused by protection, either key protection
+	 * or user page write protection.
+	 */
+	if (ret == -EFAULT)
+		ret = PGM_PROTECTION;
+	return ret;
+}
+
 /**
  * guest_translate_address_with_key - translate guest logical into guest absolute address
  * @vcpu: virtual cpu
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8a74b7b62ecf..5b77269e6536 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -584,7 +584,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_VCPU_RESETS:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_S390_DIAG318:
-	case KVM_CAP_S390_MEM_OP_EXTENSION:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -598,6 +597,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
+	case KVM_CAP_S390_MEM_OP_EXTENSION:
+		/*
+		 * Flag bits indicating which extensions are supported.
+		 * If r > 0, the base extension must also be supported/indicated,
+		 * in order to maintain backwards compatibility.
+		 */
+		r = KVM_S390_MEMOP_EXTENSION_CAP_BASE |
+		    KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG;
+		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 	case KVM_CAP_MAX_VCPU_ID:
@@ -2832,6 +2840,50 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	return r;
 }
 
+static int kvm_s390_vm_mem_op_cmpxchg(struct kvm *kvm, struct kvm_s390_mem_op *mop)
+{
+	void __user *uaddr = (void __user *)mop->buf;
+	void __user *old_addr = (void __user *)mop->old_addr;
+	union {
+		__uint128_t quad;
+		char raw[sizeof(__uint128_t)];
+	} old = { .quad = 0}, new = { .quad = 0 };
+	unsigned int off_in_quad = sizeof(new) - mop->size;
+	int r, srcu_idx;
+	bool success;
+
+	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION);
+	if (r)
+		return r;
+	/*
+	 * This validates off_in_quad. Checking that size is a power
+	 * of two is not necessary, as cmpxchg_guest_abs_with_key
+	 * takes care of that
+	 */
+	if (mop->size > sizeof(new))
+		return -EINVAL;
+	if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
+		return -EFAULT;
+	if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
+		return -EFAULT;
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+
+	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
+		r = PGM_ADDRESSING;
+		goto out_unlock;
+	}
+
+	r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size, &old.quad,
+				       new.quad, mop->key, &success);
+	if (!success && copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
+		r = -EFAULT;
+
+out_unlock:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return r;
+}
+
 static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	/*
@@ -2850,6 +2902,8 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	case KVM_S390_MEMOP_ABSOLUTE_READ:
 	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
 		return kvm_s390_vm_mem_op_abs(kvm, mop);
+	case KVM_S390_MEMOP_ABSOLUTE_CMPXCHG:
+		return kvm_s390_vm_mem_op_cmpxchg(kvm, mop);
 	default:
 		return -EINVAL;
 	}
-- 
2.37.2

