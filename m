Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630D67BE63
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjAYV0l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjAYV0f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E946145;
        Wed, 25 Jan 2023 13:26:32 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLdLf031868;
        Wed, 25 Jan 2023 21:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gOStSGNUbsVR2OabZuZFKcOzhfE/Eehy8AAv4ui5Dc0=;
 b=cmRVMRiHmjTdDBQPACIYuZYTh6dYks5IHW1H/VvBVkfi3T0oIHZmNH2Nu+zQmE6cRbrX
 TawDx9NnDN2sIRxKNBfaAs8uWCzhE99BOije8vL+TSbSqCGJ4FgUzSx2WAk5N9zNsprZ
 UkQ4dmqdAREOTB+6NnsLrVeUBM8xokrC6rtndjJloc5YgW41/5uV4eDdUialZ2XLbKcm
 CrbDLdbuIBxf8nk/jAQecJnk+o7L9ywIRgef0NPD8kAMaXxlteEZWaZviAWpbnpv9xNh
 OBPO5Oq3KlEohhxgSUcM4fq/D1HmuevGDrlt8cv4JwoE/powWGU92isaF1OsjhHri+FV zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd40ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:24 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PLQOwK013347;
        Wed, 25 Jan 2023 21:26:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd40hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFpksR026714;
        Wed, 25 Jan 2023 21:26:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6dmaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQHA123003428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22A42004B;
        Wed, 25 Jan 2023 21:26:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 983D620043;
        Wed, 25 Jan 2023 21:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:16 +0000 (GMT)
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
Subject: [PATCH v6 00/14] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Wed, 25 Jan 2023 22:25:54 +0100
Message-Id: <20230125212608.1860251-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sgSVheK_YzRHjsmJKAgKb6u87iqQBKSp
X-Proofpoint-ORIG-GUID: m4AEZ-n6GenYyUqygkJJM6xipWk9Jhnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250187
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
operation. For now, support this operation for absolute accesses only.

This operation can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Also contains some fixes/changes for the memop selftest independent of
the cmpxchg changes.

v5 -> v6
 * move memop selftest fixes/refactoring to front of series so they can
   be picked independently from the rest
 * use op instead of flag to indicate cmpxchg
 * no longer indicate success of cmpxchg to user space, which can infer
   it by observing a change in the old value instead
 * refactor functions implementing the ioctl
 * adjust documentation (drop R-b)
 * adjust selftest
 * rebase

v4 -> v5
 * refuse cmpxchg if not write (thanks Thomas)
 * minor doc changes (thanks Claudio)
 * picked up R-b's (thanks Thomas & Claudio)
 * memop selftest fixes
 * rebased

v3 -> v4
 * no functional change intended
 * rework documentation a bit
 * name extension cap cmpxchg bit
 * picked up R-b (thanks Thomas)
 * various changes (rename variable, comments, ...) see range-diff below

v2 -> v3
 * rebase onto the wip/cmpxchg_user_key branch in the s390 kernel repo
 * use __uint128_t instead of unsigned __int128
 * put moving of testlist into main into separate patch
 * pick up R-b's (thanks Nico)

v1 -> v2
 * get rid of xrk instruction for cmpxchg byte and short implementation
 * pass old parameter via pointer instead of in mem_op struct
 * indicate failure of cmpxchg due to wrong old value by special return
   code
 * picked up R-b's (thanks Thomas)


Janis Schoetterl-Glausch (14):
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Move testlist into main
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test
  KVM: s390: selftest: memop: Fix integer literal
  KVM: s390: Move common code of mem_op functions into functions
  KVM: s390: Dispatch to implementing function at top level of vm mem_op
  KVM: s390: Refactor absolute vm mem_op function
  KVM: s390: Refactor absolute vcpu mem_op function
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Add cmpxchg tests

 Documentation/virt/kvm/api.rst            |  29 +-
 include/uapi/linux/kvm.h                  |   8 +
 arch/s390/kvm/gaccess.h                   |   3 +
 arch/s390/kvm/gaccess.c                   | 103 ++++
 arch/s390/kvm/kvm-s390.c                  | 249 ++++----
 tools/testing/selftests/kvm/s390x/memop.c | 675 +++++++++++++++++-----
 6 files changed, 819 insertions(+), 248 deletions(-)

Range-diff against v5:
 3:  94c1165ae24a =  1:  512e1a3e0ae5 KVM: s390: selftest: memop: Pass mop_desc via pointer
 4:  027c87eee0ac =  2:  47328ea64f80 KVM: s390: selftest: memop: Replace macros by functions
 5:  16ac410ecc0f =  3:  224fe37eeec7 KVM: s390: selftest: memop: Move testlist into main
 7:  2d6776733e64 =  4:  f622d3413cf0 KVM: s390: selftest: memop: Add bad address test
 8:  8c49eafd2881 =  5:  431f191a8a57 KVM: s390: selftest: memop: Fix typo
 9:  0af907110b34 =  6:  3122187435fb KVM: s390: selftest: memop: Fix wrong address being used in test
10:  886c80b2bdce =  7:  401f51f3ef55 KVM: s390: selftest: memop: Fix integer literal
 -:  ------------ >  8:  df09794e0794 KVM: s390: Move common code of mem_op functions into functions
 -:  ------------ >  9:  5cbae63357ed KVM: s390: Dispatch to implementing function at top level of vm mem_op
 -:  ------------ > 10:  76ba77b63a26 KVM: s390: Refactor absolute vm mem_op function
 -:  ------------ > 11:  c848e772e22a KVM: s390: Refactor absolute vcpu mem_op function
 1:  6adc166ee141 ! 12:  6ccb200ad85c KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ Commit message
         and writes to the guest, however, it has no way of performing atomic,
         key checked, accesses to the guest.
         Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
    -    mode. For now, support this mode for absolute accesses only.
    +    op. For now, support this op for absolute accesses only.
     
    -    This mode can be use, for example, to set the device-state-change
    +    This op can be use, for example, to set the device-state-change
         indicator and the adapter-local-summary indicator atomically.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
      			__u8 ar;	/* the access register number */
      			__u8 key;	/* access key, ignored if flag unset */
     +			__u8 pad1[6];	/* ignored */
    -+			__u64 old_addr;	/* ignored if flag unset */
    ++			__u64 old_addr;	/* ignored if cmpxchg flag unset */
      		};
      		__u32 sida_offset; /* offset into the sida */
      		__u8 reserved[32]; /* ignored */
     @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
    + #define KVM_S390_MEMOP_SIDA_WRITE	3
    + #define KVM_S390_MEMOP_ABSOLUTE_READ	4
    + #define KVM_S390_MEMOP_ABSOLUTE_WRITE	5
    ++#define KVM_S390_MEMOP_ABSOLUTE_CMPXCHG	6
    ++
    + /* flags for kvm_s390_mem_op->flags */
      #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
      #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
      #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
    -+#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
    -+/* flags specifying extension support */
    -+#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
    -+/* Non program exception return codes (pgm codes are 16 bit) */
    -+#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
      
    ++/* flags specifying extension support via KVM_CAP_S390_MEM_OP_EXTENSION */
    ++#define KVM_S390_MEMOP_EXTENSION_CAP_BASE	(1 << 0)
    ++#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG	(1 << 1)
    ++
      /* for KVM_INTERRUPT */
      struct kvm_interrupt {
    + 	/* in */
     
      ## arch/s390/kvm/gaccess.h ##
     @@ arch/s390/kvm/gaccess.h: int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
      int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
      		      void *data, unsigned long len, enum gacc_mode mode);
      
    -+int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
    -+			       __uint128_t *old, __uint128_t new, u8 access_key);
    ++int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len, __uint128_t *old,
    ++			       __uint128_t new, u8 access_key, bool *success);
     +
      /**
       * write_guest_with_key - copy data from kernel space to guest space
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + * @gpa: Absolute guest address of the location to be changed.
     + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
     + *       non power of two will result in failure.
    -+ * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
    -+ *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
    -+ *         contains the value at @gpa before the attempt to exchange the value.
    ++ * @old_addr: Pointer to old value. If the location at @gpa contains this value,
    ++ *            the exchange will succeed. After calling cmpxchg_guest_abs_with_key()
    ++ *            *@old_addr contains the value at @gpa before the attempt to
    ++ *            exchange the value.
     + * @new: The value to place at @gpa.
     + * @access_key: The access key to use for the guest access.
    ++ * @success: output value indicating if an exchange occurred.
     + *
     + * Atomically exchange the value at @gpa by @new, if it contains *@old.
     + * Honors storage keys.
     + *
     + * Return: * 0: successful exchange
    -+ *         * 1: exchange unsuccessful
     + *         * a program interruption code indicating the reason cmpxchg could
     + *           not be attempted
     + *         * -EINVAL: address misaligned or len not power of two
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + */
     +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
     +			       __uint128_t *old_addr, __uint128_t new,
    -+			       u8 access_key)
    ++			       u8 access_key, bool *success)
     +{
     +	gfn_t gfn = gpa >> PAGE_SHIFT;
     +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		u8 old;
     +
     +		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_addr;
    ++		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
     +	}
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		u16 old;
     +
     +		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_addr;
    ++		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
     +	}
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		u32 old;
     +
     +		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_addr;
    ++		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
     +	}
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		u64 old;
     +
     +		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_addr;
    ++		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
     +	}
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		__uint128_t old;
     +
     +		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_addr;
    ++		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
     +	}
    @@ arch/s390/kvm/kvm-s390.c: int kvm_vm_ioctl_check_extension(struct kvm *kvm, long
     +	case KVM_CAP_S390_MEM_OP_EXTENSION:
     +		/*
     +		 * Flag bits indicating which extensions are supported.
    -+		 * The first extension doesn't use a flag, but pretend it does,
    -+		 * this way that can be changed in the future.
    ++		 * If r > 0, the base extension must also be supported/indicated,
    ++		 * in order to maintain backwards compatibility.
     +		 */
    -+		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
    ++		r = KVM_S390_MEMOP_EXTENSION_CAP_BASE |
    ++		    KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG;
     +		break;
      	case KVM_CAP_NR_VCPUS:
      	case KVM_CAP_MAX_VCPUS:
      	case KVM_CAP_MAX_VCPU_ID:
    -@@ arch/s390/kvm/kvm-s390.c: static bool access_key_invalid(u8 access_key)
    - static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    - {
    - 	void __user *uaddr = (void __user *)mop->buf;
    +@@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    + 	return r;
    + }
    + 
    ++static int kvm_s390_vm_mem_op_cmpxchg(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    ++{
    ++	void __user *uaddr = (void __user *)mop->buf;
     +	void __user *old_addr = (void __user *)mop->old_addr;
     +	union {
     +		__uint128_t quad;
     +		char raw[sizeof(__uint128_t)];
     +	} old = { .quad = 0}, new = { .quad = 0 };
     +	unsigned int off_in_quad = sizeof(new) - mop->size;
    - 	u64 supported_flags;
    - 	void *tmpbuf = NULL;
    - 	int r, srcu_idx;
    - 
    - 	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
    --			  | KVM_S390_MEMOP_F_CHECK_ONLY;
    -+			  | KVM_S390_MEMOP_F_CHECK_ONLY
    -+			  | KVM_S390_MEMOP_F_CMPXCHG;
    - 	if (mop->flags & ~supported_flags || !mop->size)
    - 		return -EINVAL;
    - 	if (mop->size > MEM_OP_MAX_SIZE)
    -@@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    - 	} else {
    - 		mop->key = 0;
    - 	}
    -+	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
    -+		/*
    -+		 * This validates off_in_quad. Checking that size is a power
    -+		 * of two is not necessary, as cmpxchg_guest_abs_with_key
    -+		 * takes care of that
    -+		 */
    -+		if (mop->size > sizeof(new))
    -+			return -EINVAL;
    -+		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
    -+			return -EINVAL;
    -+		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
    -+			return -EFAULT;
    -+		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
    -+			return -EFAULT;
    ++	int r, srcu_idx;
    ++	bool success;
    ++
    ++	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION);
    ++	if (r)
    ++		return r;
    ++	/*
    ++	 * This validates off_in_quad. Checking that size is a power
    ++	 * of two is not necessary, as cmpxchg_guest_abs_with_key
    ++	 * takes care of that
    ++	 */
    ++	if (mop->size > sizeof(new))
    ++		return -EINVAL;
    ++	if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
    ++		return -EFAULT;
    ++	if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
    ++		return -EFAULT;
    ++
    ++	srcu_idx = srcu_read_lock(&kvm->srcu);
    ++
    ++	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
    ++		r = PGM_ADDRESSING;
    ++		goto out_unlock;
     +	}
    - 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    - 		tmpbuf = vmalloc(mop->size);
    - 		if (!tmpbuf)
    ++
    ++	r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size, &old.quad,
    ++				       new.quad, mop->key, &success);
    ++	if (!success && copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
    ++		r = -EFAULT;
    ++
    ++out_unlock:
    ++	srcu_read_unlock(&kvm->srcu, srcu_idx);
    ++	return r;
    ++}
    ++
    + static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    + {
    + 	/*
     @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    - 	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
    - 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
    - 			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
    -+		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
    -+			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
    -+						       &old.quad, new.quad, mop->key);
    -+			if (r == 1) {
    -+				r = KVM_S390_MEMOP_R_NO_XCHG;
    -+				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
    -+					r = -EFAULT;
    -+			}
    - 		} else {
    - 			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
    - 				r = -EFAULT;
    + 	case KVM_S390_MEMOP_ABSOLUTE_READ:
    + 	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
    + 		return kvm_s390_vm_mem_op_abs(kvm, mop);
    ++	case KVM_S390_MEMOP_ABSOLUTE_CMPXCHG:
    ++		return kvm_s390_vm_mem_op_cmpxchg(kvm, mop);
    + 	default:
    + 		return -EINVAL;
    + 	}
 2:  fce9a063ab70 ! 13:  4d983d179903 Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
    @@ Commit message
         checked) cmpxchg operations on guest memory.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    -    Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
     
      ## Documentation/virt/kvm/api.rst ##
     @@ Documentation/virt/kvm/api.rst: The fields in each entry are defined as follows:
    @@ Documentation/virt/kvm/api.rst: Parameters are specified via the following struc
      		};
      		__u32 sida_offset; /* offset into the sida */
      		__u8 reserved[32]; /* ignored */
    -@@ Documentation/virt/kvm/api.rst: Absolute accesses are permitted for non-protected guests only.
    - Supported flags:
    +@@ Documentation/virt/kvm/api.rst: Possible operations are:
    +   * ``KVM_S390_MEMOP_ABSOLUTE_WRITE``
    +   * ``KVM_S390_MEMOP_SIDA_READ``
    +   * ``KVM_S390_MEMOP_SIDA_WRITE``
    ++  * ``KVM_S390_MEMOP_ABSOLUTE_CMPXCHG``
    + 
    + Logical read/write:
    + ^^^^^^^^^^^^^^^^^^^
    +@@ Documentation/virt/kvm/api.rst: the checks required for storage key protection as one operation (as opposed to
    + user space getting the storage keys, performing the checks, and accessing
    + memory thereafter, which could lead to a delay between check and access).
    + Absolute accesses are permitted for the VM ioctl if KVM_CAP_S390_MEM_OP_EXTENSION
    +-is > 0.
    ++has the KVM_S390_MEMOP_EXTENSION_CAP_BASE bit set.
    + Currently absolute accesses are not permitted for VCPU ioctls.
    + Absolute accesses are permitted for non-protected guests only.
    + 
    +@@ Documentation/virt/kvm/api.rst: Supported flags:
        * ``KVM_S390_MEMOP_F_CHECK_ONLY``
        * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
    -+  * ``KVM_S390_MEMOP_F_CMPXCHG``
    -+
    + 
    +-The semantics of the flags are as for logical accesses.
     +The semantics of the flags common with logical accesses are as for logical
     +accesses.
     +
    -+For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if
    -+KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
    -+In this case, instead of doing an unconditional write, the access occurs
    -+only if the target location contains the value pointed to by "old_addr".
    ++Absolute cmpxchg:
    ++^^^^^^^^^^^^^^^^^
    ++
    ++Perform cmpxchg on absolute guest memory. Intended for use with the
    ++KVM_S390_MEMOP_F_SKEY_PROTECTION flag.
    ++Instead of doing an unconditional write, the access occurs only if the target
    ++location contains the value pointed to by "old_addr".
     +This is performed as an atomic cmpxchg with the length specified by the "size"
     +parameter. "size" must be a power of two up to and including 16.
     +If the exchange did not take place because the target value doesn't match the
    -+old value, KVM_S390_MEMOP_R_NO_XCHG is returned.
    -+In this case the value "old_addr" points to is replaced by the target value.
    - 
    --The semantics of the flags are as for logical accesses.
    ++old value, the value "old_addr" points to is replaced by the target value.
    ++User space can tell if an exchange took place by checking if this replacement
    ++occurred. The cmpxchg op is permitted for the VM ioctl if
    ++KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
    ++
    ++Supported flags:
    ++  * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
      
      SIDA read/write:
      ^^^^^^^^^^^^^^^^
 6:  214281b6eb96 ! 14:  5250be3dd58b KVM: s390: selftest: memop: Add cmpxchg tests
    @@ tools/testing/selftests/kvm/s390x/memop.c
      
      #include <linux/bits.h>
      
    +@@ tools/testing/selftests/kvm/s390x/memop.c: enum mop_target {
    + enum mop_access_mode {
    + 	READ,
    + 	WRITE,
    ++	CMPXCHG,
    + };
    + 
    + struct mop_desc {
     @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
      	enum mop_access_mode mode;
      	void *buf;
      	uint32_t sida_offset;
     +	void *old;
    ++	uint8_t old_value[16];
     +	bool *cmpxchg_success;
      	uint8_t ar;
      	uint8_t key;
      };
    + 
    + const uint8_t NO_KEY = 0xff;
    + 
    +-static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
    ++static struct kvm_s390_mem_op ksmo_from_desc(struct mop_desc *desc)
    + {
    + 	struct kvm_s390_mem_op ksmo = {
    + 		.gaddr = (uintptr_t)desc->gaddr,
     @@ tools/testing/selftests/kvm/s390x/memop.c: static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
    - 		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
    - 		ksmo.key = desc->key;
    - 	}
    -+	if (desc->old) {
    -+		ksmo.flags |= KVM_S390_MEMOP_F_CMPXCHG;
    -+		ksmo.old_addr = (uint64_t)desc->old;
    -+	}
    - 	if (desc->_ar)
    - 		ksmo.ar = desc->ar;
    - 	else
    + 			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_READ;
    + 		if (desc->mode == WRITE)
    + 			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_WRITE;
    ++		if (desc->mode == CMPXCHG) {
    ++			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_CMPXCHG;
    ++			ksmo.old_addr = (uint64_t)desc->old;
    ++			memcpy(desc->old_value, desc->old, desc->size);
    ++		}
    + 		break;
    + 	case INVALID:
    + 		ksmo.op = -1;
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vcpu *vcpu, const struct kvm_s390_mem_op *ksm
    + 	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
      		printf("ABSOLUTE, WRITE, ");
      		break;
    ++	case KVM_S390_MEMOP_ABSOLUTE_CMPXCHG:
    ++		printf("ABSOLUTE, CMPXCHG, ");
    ++		break;
      	}
     -	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
     -	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vc
      	if (ksmo->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
      		printf(", CHECK_ONLY");
      	if (ksmo->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION)
    - 		printf(", INJECT_EXCEPTION");
    - 	if (ksmo->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION)
    - 		printf(", SKEY_PROTECTION");
    -+	if (ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG)
    -+		printf(", CMPXCHG");
    +@@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vcpu *vcpu, const struct kvm_s390_mem_op *ksm
      	puts(")");
      }
      
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vc
     +	int r;
     +
     +	r = err_memop_ioctl(info, ksmo, desc);
    -+	if (ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG) {
    -+		if (desc->cmpxchg_success)
    -+			*desc->cmpxchg_success = !r;
    -+		if (r == KVM_S390_MEMOP_R_NO_XCHG)
    -+			r = 0;
    ++	if (ksmo->op == KVM_S390_MEMOP_ABSOLUTE_CMPXCHG) {
    ++		if (desc->cmpxchg_success) {
    ++			int diff = memcmp(desc->old_value, desc->old, desc->size);
    ++			*desc->cmpxchg_success = !diff;
    ++		}
     +	}
     +	TEST_ASSERT(!r, __KVM_IOCTL_ERROR("KVM_S390_MEM_OP", r));
      
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void default_read(struct test_
     +			default_write_read(test->vcpu, test->vcpu, LOGICAL, 16, NO_KEY);
     +
     +			memcpy(&old, mem1, 16);
    -+			CHECK_N_DO(MOP, test->vm, ABSOLUTE, WRITE, new + offset,
    -+				   size, GADDR_V(mem1 + offset),
    -+				   CMPXCHG_OLD(old + offset),
    -+				   CMPXCHG_SUCCESS(&succ), KEY(key));
    ++			MOP(test->vm, ABSOLUTE, CMPXCHG, new + offset,
    ++			    size, GADDR_V(mem1 + offset),
    ++			    CMPXCHG_OLD(old + offset),
    ++			    CMPXCHG_SUCCESS(&succ), KEY(key));
     +			HOST_SYNC(test->vcpu, STAGE_COPIED);
     +			MOP(test->vm, ABSOLUTE, READ, mem2, 16, GADDR_V(mem2));
     +			TEST_ASSERT(succ, "exchange of values should succeed");
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void default_read(struct test_
     +			memcpy(&old, mem1, 16);
     +			new[offset]++;
     +			old[offset]++;
    -+			CHECK_N_DO(MOP, test->vm, ABSOLUTE, WRITE, new + offset,
    -+				   size, GADDR_V(mem1 + offset),
    -+				   CMPXCHG_OLD(old + offset),
    -+				   CMPXCHG_SUCCESS(&succ), KEY(key));
    ++			MOP(test->vm, ABSOLUTE, CMPXCHG, new + offset,
    ++			    size, GADDR_V(mem1 + offset),
    ++			    CMPXCHG_OLD(old + offset),
    ++			    CMPXCHG_SUCCESS(&succ), KEY(key));
     +			HOST_SYNC(test->vcpu, STAGE_COPIED);
     +			MOP(test->vm, ABSOLUTE, READ, mem2, 16, GADDR_V(mem2));
     +			TEST_ASSERT(!succ, "exchange of values should not succeed");
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +		do {
     +			old = 0;
     +			new = 1;
    -+			MOP(t.vm, ABSOLUTE, WRITE, &new,
    ++			MOP(t.vm, ABSOLUTE, CMPXCHG, &new,
     +			    sizeof(new), GADDR_V(mem1),
     +			    CMPXCHG_OLD(&old),
     +			    CMPXCHG_SUCCESS(&success), KEY(1));
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +			choose_block(false, i + j, &size, &offset);
     +			do {
     +				new = permutate_bits(false, i + j, size, old);
    -+				MOP(t.vm, ABSOLUTE, WRITE, quad_to_char(&new, size),
    ++				MOP(t.vm, ABSOLUTE, CMPXCHG, quad_to_char(&new, size),
     +				    size, GADDR_V(mem2 + offset),
     +				    CMPXCHG_OLD(quad_to_char(&old, size)),
     +				    CMPXCHG_SUCCESS(&success), KEY(1));
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key(void)
     +	for (i = 1; i <= 16; i *= 2) {
     +		__uint128_t old = 0;
     +
    -+		CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem2, i, GADDR_V(mem2),
    -+			   CMPXCHG_OLD(&old), KEY(2));
    ++		ERR_PROT_MOP(t.vm, ABSOLUTE, CMPXCHG, mem2, i, GADDR_V(mem2),
    ++			     CMPXCHG_OLD(&old), KEY(2));
     +	}
     +
     +	kvm_vm_free(t.kvm_vm);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     +			power *= 2;
     +			continue;
     +		}
    -+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR_V(mem1),
    ++		rv = ERR_MOP(t.vm, ABSOLUTE, CMPXCHG, mem1, i, GADDR_V(mem1),
     +			     CMPXCHG_OLD(&old));
     +		TEST_ASSERT(rv == -1 && errno == EINVAL,
     +			    "ioctl allows bad size for cmpxchg");
     +	}
     +	for (i = 1; i <= 16; i *= 2) {
    -+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR((void *)~0xfffUL),
    ++		rv = ERR_MOP(t.vm, ABSOLUTE, CMPXCHG, mem1, i, GADDR((void *)~0xfffUL),
     +			     CMPXCHG_OLD(&old));
     +		TEST_ASSERT(rv > 0, "ioctl allows bad guest address for cmpxchg");
    -+		rv = ERR_MOP(t.vm, ABSOLUTE, READ, mem1, i, GADDR_V(mem1),
    -+			     CMPXCHG_OLD(&old));
    -+		TEST_ASSERT(rv == -1 && errno == EINVAL,
    -+			    "ioctl allows read cmpxchg call");
     +	}
     +	for (i = 2; i <= 16; i *= 2) {
    -+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR_V(mem1 + 1),
    ++		rv = ERR_MOP(t.vm, ABSOLUTE, CMPXCHG, mem1, i, GADDR_V(mem1 + 1),
     +			     CMPXCHG_OLD(&old));
     +		TEST_ASSERT(rv == -1 && errno == EINVAL,
     +			    "ioctl allows bad alignment for cmpxchg");
-- 
2.34.1

