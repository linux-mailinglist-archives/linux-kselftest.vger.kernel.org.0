Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E45F1466
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiI3VIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiI3VIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 17:08:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2D1B2D04;
        Fri, 30 Sep 2022 14:08:07 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKMMCj020649;
        Fri, 30 Sep 2022 21:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oL/jMRzWJqB8HnTxw6JV7c68DH1KEVA/51jak+/DO+U=;
 b=AlusyyFQpyUDRgQbXackbsgyUMKbyWAtXfn2Pz+8OyCVAUWMlTPMoL50DvxVIzfCq9HH
 jUYDM4bYbnIPeltfb/nx7YYzihYwQoGTnCpGFl/NLesvbtTr7NdPbcmRUB/SnjEHhlSC
 fklvy7MEDA+oX/cwdgi4gWZwEGIoSLcvgXgmQY/Ow7YYv8icOc4ayDNryllUXLbyYGMH
 9+G2H78gETBbDoFUdcrgL3I63UJmBfHbLJjhdPuie405/dYfKXcOK6AhvD4AC6JeRamN
 WoH4cQio+ebSnumI2e5heH6knCCDrqbx41KpBHEg3v7vZjF4iOeli3kRwy0He8+iJJqk SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7eeryyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:02 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UKppi3021168;
        Fri, 30 Sep 2022 21:08:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7eeryxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UL5rql005080;
        Fri, 30 Sep 2022 21:08:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9gkq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UL7v9R4457140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:07:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FA2BA405B;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1472A405C;
        Fri, 30 Sep 2022 21:07:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 21:07:56 +0000 (GMT)
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
Subject: [PATCH v1 2/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Fri, 30 Sep 2022 23:07:44 +0200
Message-Id: <20220930210751.225873-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930210751.225873-1-scgl@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SqxX7nuWhwXY8SQUuw2wbeb630EIreYv
X-Proofpoint-ORIG-GUID: uBmjYecOX-hPYP4dN9MlGjCMmUKU5O6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300131
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


The return value of MEM_OP is:
  0 on success,
  < 0 on generic error (e.g. -EFAULT or -ENOMEM),
  > 0 if an exception occurred while walking the page tables
A cmpxchg failing because the old value doesn't match is neither an
error nor an exception, so the question is how best to signal that
condition. This is not strictly necessary since user space can compare
the value of old after the MEM_OP with the value it set. If they're
different the cmpxchg failed. It might be a better user interface if
there is an easier way to see if the cmpxchg failed.
This patch sets the cmpxchg flag bit to 0 on a successful cmpxchg.
This way you can compare against a constant instead of the old old
value.
This has the disadvantage of being a bit weird, other suggestions
welcome.


 include/uapi/linux/kvm.h |  5 ++++
 arch/s390/kvm/gaccess.h  |  4 +++
 arch/s390/kvm/gaccess.c  | 56 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c | 50 ++++++++++++++++++++++++++++++-----
 4 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index eed0315a77a6..b856705f3f6b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -580,7 +580,9 @@ struct kvm_translation {
 struct kvm_s390_mem_op {
 	/* in */
 	__u64 gaddr;		/* the guest address */
+	/* in & out */
 	__u64 flags;		/* flags */
+	/* in */
 	__u32 size;		/* amount of bytes */
 	__u32 op;		/* type of operation */
 	__u64 buf;		/* buffer in userspace */
@@ -588,6 +590,8 @@ struct kvm_s390_mem_op {
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			/* in & out */
+			__u64 old[2];	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -604,6 +608,7 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
 #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
+#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
 
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
index 0243b6e38d36..c0e490ecc372 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1161,6 +1161,62 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
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
+	 * Check if it's a ro memslot, even tho that can't occur (they're unsupported).
+	 * Don't try to actually handle that case.
+	 */
+	if (!writable)
+		return -EOPNOTSUPP;
+
+	hva += offset_in_page(gpa);
+	ret = cmpxchg_user_key_size(len, (void __user *)hva, old_p, new, access_key);
+	mark_page_dirty_in_slot(kvm, slot, gfn);
+	/*
+	 * Assume that the fault is caused by key protection, the alternative
+	 * is that the user page is write protected.
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
index b7ef0b71014d..d594d1318d2a 100644
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
@@ -590,6 +589,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
+	case KVM_CAP_S390_MEM_OP_EXTENSION:
+		r = 0x3;
+		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 	case KVM_CAP_MAX_VCPU_ID:
@@ -2711,15 +2713,22 @@ static bool access_key_invalid(u8 access_key)
 	return access_key > 0xf;
 }
 
-static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
+static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop, bool *modified)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	unsigned __int128 old;
+	union {
+		unsigned __int128 quad;
+		char raw[sizeof(unsigned __int128)];
+	} new = { .quad = 0 };
 	u64 supported_flags;
 	void *tmpbuf = NULL;
 	int r, srcu_idx;
 
+	*modified = false;
 	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
-			  | KVM_S390_MEMOP_F_CHECK_ONLY;
+			  | KVM_S390_MEMOP_F_CHECK_ONLY
+			  | KVM_S390_MEMOP_F_CMPXCHG;
 	if (mop->flags & ~supported_flags || !mop->size)
 		return -EINVAL;
 	if (mop->size > MEM_OP_MAX_SIZE)
@@ -2741,6 +2750,13 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	} else {
 		mop->key = 0;
 	}
+	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+		if (mop->size > sizeof(new))
+			return -EINVAL;
+		if (copy_from_user(&new.raw[sizeof(new) - mop->size], uaddr, mop->size))
+			return -EFAULT;
+		memcpy(&old, mop->old, sizeof(old));
+	}
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -2771,6 +2787,16 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
+		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
+						       &old, new.quad, mop->key);
+			if (!r) {
+				mop->flags &= ~KVM_S390_MEMOP_F_CMPXCHG;
+			} else if (r == 1) {
+				memcpy(mop->old, &old, sizeof(old));
+				r = 0;
+			}
+			*modified = true;
 		} else {
 			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
 				r = -EFAULT;
@@ -2918,11 +2944,23 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 	case KVM_S390_MEM_OP: {
 		struct kvm_s390_mem_op mem_op;
+		bool modified;
 
-		if (copy_from_user(&mem_op, argp, sizeof(mem_op)) == 0)
-			r = kvm_s390_vm_mem_op(kvm, &mem_op);
-		else
+		r = copy_from_user(&mem_op, argp, sizeof(mem_op));
+		if (r) {
 			r = -EFAULT;
+			break;
+		}
+		r = kvm_s390_vm_mem_op(kvm, &mem_op, &modified);
+		if (r)
+			break;
+		if (modified) {
+			r = copy_to_user(argp, &mem_op, sizeof(mem_op));
+			if (r) {
+				r = -EFAULT;
+				break;
+			}
+		}
 		break;
 	}
 	case KVM_S390_ZPCI_OP: {
-- 
2.34.1

