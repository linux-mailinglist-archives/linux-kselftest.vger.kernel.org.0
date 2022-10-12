Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7265FCC94
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJLU4e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJLU4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FDB1114B;
        Wed, 12 Oct 2022 13:56:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CJg8li007083;
        Wed, 12 Oct 2022 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gTtx3phMno7COIb1Bpo5byilL0Q3wqLfHVvbPu9s6xc=;
 b=SppOgFgGfhPCNQ75SEvYo1ZHyCNZLrz1d49JCy1Mqj90OMdo3XOl+6Dfy9WFpYQ1gp4w
 6miqBJq0FXQiSu5G5xEhuLkSkdaPJORIplFE/va7BG54JbCwjqt/TU7FoVmVooyom4V2
 0v/2NjggK1ObTF9Ip6gnYtu3w3ojNUR+FZGI2w6ljUHVi/X2Vb6PsXooo9zHsduLpwki
 2VU3Ek8B9ixXRgZTSEK17dBqJkjCyZVhxVK/VFvzYa3FK3WWToLFx93JHj3X7n9dVdcs
 3lH3WP1PSn6NGJDb5Nn4dCtab85RIEakfjTy/hDw5uVSoNjeByv1Cyal/Jl4W0Wp5dz4 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62cp4q0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CKuIJl002608;
        Wed, 12 Oct 2022 20:56:18 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62cp4q0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKrDxZ031290;
        Wed, 12 Oct 2022 20:56:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3k30u9cx8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKuC0565995242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B63D95204E;
        Wed, 12 Oct 2022 20:56:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 459135204F;
        Wed, 12 Oct 2022 20:56:12 +0000 (GMT)
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
Subject: [PATCH v2 2/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Wed, 12 Oct 2022 22:56:02 +0200
Message-Id: <20221012205609.2811294-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012205609.2811294-1-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qeeVIt_ZRwzXZtumieoyGcsXxwhNL8si
X-Proofpoint-ORIG-GUID: AmAt_0EzISgYrttkgy2NSDSLKm2ObVLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_10,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120131
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
 include/uapi/linux/kvm.h |  5 ++++
 arch/s390/kvm/gaccess.h  |  4 +++
 arch/s390/kvm/gaccess.c  | 57 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c | 35 ++++++++++++++++++++++--
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index eed0315a77a6..b28ef88eff41 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_p;	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -604,6 +606,9 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
 #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
+#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
+/* Non program exception return codes (pgm codes are 16 bit) */
+#define KVM_S390_MEMOP_R_NO_XCHG		((1 << 16) + 0)
 
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 9408d6cc8e2c..a1cb66ae0995 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -206,6 +206,10 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode);
 
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
+			       unsigned __int128 *old,
+			       unsigned __int128 new, u8 access_key);
+
 /**
  * write_guest_with_key - copy data from kernel space to guest space
  * @vcpu: virtual cpu
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0243b6e38d36..d51cbae4f228 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1161,6 +1161,63 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 	return rc;
 }
 
+/**
+ * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
+ * @kvm: Virtual machine instance.
+ * @gpa: Absolute guest address of the location to be changed.
+ * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
+ *       non power of two will result in failure.
+ * @old_p: Pointer to old value. If the location at @gpa contains this value, the
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
+ */
+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
+			       unsigned __int128 *old_p, unsigned __int128 new,
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
+	ret = cmpxchg_user_key_size(len, (void __user *)hva, old_p, new, access_key);
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
index b7ef0b71014d..88f0b83229f6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -576,7 +576,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_VCPU_RESETS:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_S390_DIAG318:
-	case KVM_CAP_S390_MEM_OP_EXTENSION:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -590,6 +589,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
+	case KVM_CAP_S390_MEM_OP_EXTENSION:
+		/*
+		 * Flag bits indicating which extensions are supported.
+		 * The first extension doesn't use a flag, but pretend it does,
+		 * this way that can be changed in the future.
+		 */
+		r = 0x3;
+		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 	case KVM_CAP_MAX_VCPU_ID:
@@ -2714,12 +2721,19 @@ static bool access_key_invalid(u8 access_key)
 static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	void __user *old_p = (void __user *)mop->old_p;
+	union {
+		unsigned __int128 quad;
+		char raw[sizeof(unsigned __int128)];
+	} old = { .quad = 0}, new = { .quad = 0 };
+	unsigned int off_in_quad = sizeof(unsigned __int128) - mop->size;
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
@@ -2741,6 +2755,15 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	} else {
 		mop->key = 0;
 	}
+	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+		if (mop->size > sizeof(new))
+			return -EINVAL;
+		/* off_in_quad has been validated */
+		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
+			return -EFAULT;
+		if (copy_from_user(&old.raw[off_in_quad], old_p, mop->size))
+			return -EFAULT;
+	}
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -2771,6 +2794,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
+		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
+						       &old.quad, new.quad, mop->key);
+			if (r == 1) {
+				r = KVM_S390_MEMOP_R_NO_XCHG;
+				if (copy_to_user(old_p, &old.raw[off_in_quad], mop->size))
+					r = -EFAULT;
+			}
 		} else {
 			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
 				r = -EFAULT;
-- 
2.34.1

