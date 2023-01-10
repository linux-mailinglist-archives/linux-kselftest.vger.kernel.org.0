Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAF664D4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjAJU1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjAJU0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A23392E2;
        Tue, 10 Jan 2023 12:26:52 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJuD6M006411;
        Tue, 10 Jan 2023 20:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xb4P44QZDiAfDjrktyagOIErzbkQ1tMq64kf/5m05l0=;
 b=jgwM/jQMnfxgeMVqkt5r7+bVj5B8rAPm9m6rljjAIT2Qhh8XbTABJSelWw71Z7q4M7aE
 P09aXOuT6QP4/kpbpw1ED9s6ISJYhU8dJsPTDk/2tUpZ3XgkYVfm+dzG3sF8JmTJ0uX3
 83GWtFZylhwSehTmZqM++d/lSmK64NP1pBegVkQUwJi1MV5Haq1J8FhvssU5Mx2yvxEP
 WeXwc8ARngqebDkw5XsJrrUpP+9BwaYxx7MRFqBfSYI2OcwGrBH0wtYGVK1KOjT5wOWb
 oHYXh6DDDcnfCpodi7Yh1amk+ds1ictpKZ1wLXc4bxNtC6ek/AKahUpRgNOqWDRTsWea XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1em68mwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:42 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AJuMv9006723;
        Tue, 10 Jan 2023 20:26:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1em68mw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJd7wT001087;
        Tue, 10 Jan 2023 20:26:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6ndgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQa3j43057532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E92020040;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A28EB20049;
        Tue, 10 Jan 2023 20:26:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:35 +0000 (GMT)
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
Subject: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Tue, 10 Jan 2023 21:26:23 +0100
Message-Id: <20230110202632.2533978-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YIAfJ9cUIAPHVce8UVXHJHCMZPiwc8wO
X-Proofpoint-ORIG-GUID: _IvJcIk8ai9zr4v8hhRTW3kA9SJ3IRlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User space can use the MEM_OP ioctl to make storage key checked reads
and writes to the guest, however, it has no way of performing atomic,
key checked, accesses to the guest.
Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
mode. For now, support this mode for absolute accesses only.

This mode can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 include/uapi/linux/kvm.h |   7 +++
 arch/s390/kvm/gaccess.h  |   3 ++
 arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
 4 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 55155e262646..452f43c1cc34 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_addr;	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
 #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
+#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
+/* flags specifying extension support */
+#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
+/* Non program exception return codes (pgm codes are 16 bit) */
+#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
 
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 9408d6cc8e2c..92a3b9fb31ec 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode);
 
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
+			       __uint128_t *old, __uint128_t new, u8 access_key);
+
 /**
  * write_guest_with_key - copy data from kernel space to guest space
  * @vcpu: virtual cpu
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0243b6e38d36..6165e761a637 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 	return rc;
 }
 
+/**
+ * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
+ * @kvm: Virtual machine instance.
+ * @gpa: Absolute guest address of the location to be changed.
+ * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
+ *       non power of two will result in failure.
+ * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
+ *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
+ *         contains the value at @gpa before the attempt to exchange the value.
+ * @new: The value to place at @gpa.
+ * @access_key: The access key to use for the guest access.
+ *
+ * Atomically exchange the value at @gpa by @new, if it contains *@old.
+ * Honors storage keys.
+ *
+ * Return: * 0: successful exchange
+ *         * 1: exchange unsuccessful
+ *         * a program interruption code indicating the reason cmpxchg could
+ *           not be attempted
+ *         * -EINVAL: address misaligned or len not power of two
+ *         * -EAGAIN: transient failure (len 1 or 2)
+ *         * -EOPNOTSUPP: read-only memslot (should never occur)
+ */
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
+			       __uint128_t *old_addr, __uint128_t new,
+			       u8 access_key)
+{
+	gfn_t gfn = gpa >> PAGE_SHIFT;
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
+	switch (len) {
+	case 1: {
+		u8 old;
+
+		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
+		ret = ret < 0 ? ret : old != *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 2: {
+		u16 old;
+
+		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
+		ret = ret < 0 ? ret : old != *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 4: {
+		u32 old;
+
+		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
+		ret = ret < 0 ? ret : old != *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 8: {
+		u64 old;
+
+		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
+		ret = ret < 0 ? ret : old != *old_addr;
+		*old_addr = old;
+		break;
+	}
+	case 16: {
+		__uint128_t old;
+
+		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
+		ret = ret < 0 ? ret : old != *old_addr;
+		*old_addr = old;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	mark_page_dirty_in_slot(kvm, slot, gfn);
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
index e4890e04b210..56f4f6ddd5bb 100644
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
@@ -598,6 +597,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
+	case KVM_CAP_S390_MEM_OP_EXTENSION:
+		/*
+		 * Flag bits indicating which extensions are supported.
+		 * The first extension doesn't use a flag, but pretend it does,
+		 * this way that can be changed in the future.
+		 */
+		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
+		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 	case KVM_CAP_MAX_VCPU_ID:
@@ -2772,12 +2779,19 @@ static bool access_key_invalid(u8 access_key)
 static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	void __user *old_addr = (void __user *)mop->old_addr;
+	union {
+		__uint128_t quad;
+		char raw[sizeof(__uint128_t)];
+	} old = { .quad = 0}, new = { .quad = 0 };
+	unsigned int off_in_quad = sizeof(new) - mop->size;
 	u64 supported_flags;
 	void *tmpbuf = NULL;
 	int r, srcu_idx;
 
 	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
-			  | KVM_S390_MEMOP_F_CHECK_ONLY;
+			  | KVM_S390_MEMOP_F_CHECK_ONLY
+			  | KVM_S390_MEMOP_F_CMPXCHG;
 	if (mop->flags & ~supported_flags || !mop->size)
 		return -EINVAL;
 	if (mop->size > MEM_OP_MAX_SIZE)
@@ -2799,6 +2813,21 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	} else {
 		mop->key = 0;
 	}
+	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+		/*
+		 * This validates off_in_quad. Checking that size is a power
+		 * of two is not necessary, as cmpxchg_guest_abs_with_key
+		 * takes care of that
+		 */
+		if (mop->size > sizeof(new))
+			return -EINVAL;
+		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
+			return -EINVAL;
+		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
+			return -EFAULT;
+		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
+			return -EFAULT;
+	}
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -2829,6 +2858,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
+		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
+						       &old.quad, new.quad, mop->key);
+			if (r == 1) {
+				r = KVM_S390_MEMOP_R_NO_XCHG;
+				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
+					r = -EFAULT;
+			}
 		} else {
 			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
 				r = -EFAULT;
-- 
2.34.1

