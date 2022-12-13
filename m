Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1A64BA40
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiLMQy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiLMQyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 11:54:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9222506;
        Tue, 13 Dec 2022 08:54:24 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDG8Cx6001488;
        Tue, 13 Dec 2022 16:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uYbNnacH5lmc5jaRX4SiQlNoA8kgRcdSx5AnqrVSjjk=;
 b=ZGi7zyGG5UuGsIwxNNA/dRZeN20hPj7oBDWqGvGGB483wKeNuvhKz7hQXXUc5D6KGnHS
 Gh/azjT8i707T27rjS3lDETDGerqF6xin1juPT0AEwosCOTOJ7os0fh/JC3PPKTiL8/I
 9r04PwHcKBDBdfMQyVejggZYX1zAXL/SE33Si2UC9wGYqa77T/VYUjJH7tlD1ZjcQv9P
 jDwwo8kyfbVXrwtU07KFDGR8762wljWUhFrSOiO6Z9tPODudBVVqNYiKmMqsb8shR6zD
 jpd/sP4xxfVnvGj6Di9w5oH8kqWb4c0Mro4IR5CLlRMcFjD2q9fSlkND+dUp5Hi37EL/ 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mevn6hcsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:20 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDG8C8L001461;
        Tue, 13 Dec 2022 16:54:19 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mevn6hcs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDCaWug017931;
        Tue, 13 Dec 2022 16:54:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mchr638c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDGsCtX45613560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 16:54:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB92C20043;
        Tue, 13 Dec 2022 16:54:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903A320049;
        Tue, 13 Dec 2022 16:54:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 16:54:12 +0000 (GMT)
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
Subject: [PATCH v4 0/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Tue, 13 Dec 2022 17:53:56 +0100
Message-Id: <20221213165405.2953539-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hsUjVFZSVZDJIb1SW908IcauYR211q6v
X-Proofpoint-ORIG-GUID: kVzESV7UgpwCaj3zPRtpLeawmUty_gNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130147
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

Also contains some fixes/changes for the memop selftest independent of
the cmpxchg changes.

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

Janis Schoetterl-Glausch (9):
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Move testlist into main
  KVM: s390: selftest: memop: Add cmpxchg tests
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test

 Documentation/virt/kvm/api.rst            |  20 +-
 include/uapi/linux/kvm.h                  |   7 +
 arch/s390/kvm/gaccess.h                   |   3 +
 arch/s390/kvm/gaccess.c                   | 102 ++++
 arch/s390/kvm/kvm-s390.c                  |  39 +-
 tools/testing/selftests/kvm/s390x/memop.c | 670 +++++++++++++++++-----
 6 files changed, 689 insertions(+), 152 deletions(-)

Range-diff against v3:
 1:  ebb86a0c90a2 !  1:  75a20d2e27f2 KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
      			__u8 ar;	/* the access register number */
      			__u8 key;	/* access key, ignored if flag unset */
     +			__u8 pad1[6];	/* ignored */
    -+			__u64 old_p;	/* ignored if flag unset */
    ++			__u64 old_addr;	/* ignored if flag unset */
      		};
      		__u32 sida_offset; /* offset into the sida */
      		__u8 reserved[32]; /* ignored */
    @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
      #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
      #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
     +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
    ++/* flags specifying extension support */
    ++#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
     +/* Non program exception return codes (pgm codes are 16 bit) */
    -+#define KVM_S390_MEMOP_R_NO_XCHG		((1 << 16) + 0)
    ++#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
      
      /* for KVM_INTERRUPT */
      struct kvm_interrupt {
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + * @gpa: Absolute guest address of the location to be changed.
     + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
     + *       non power of two will result in failure.
    -+ * @old_p: Pointer to old value. If the location at @gpa contains this value, the
    ++ * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
     + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
     + *         contains the value at @gpa before the attempt to exchange the value.
     + * @new: The value to place at @gpa.
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + *           not be attempted
     + *         * -EINVAL: address misaligned or len not power of two
     + *         * -EAGAIN: transient failure (len 1 or 2)
    ++ *         * -EOPNOTSUPP: read-only memslot (should never occur)
     + */
     +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
    -+			       __uint128_t *old_p, __uint128_t new,
    ++			       __uint128_t *old_addr, __uint128_t new,
     +			       u8 access_key)
     +{
     +	gfn_t gfn = gpa >> PAGE_SHIFT;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	case 1: {
     +		u8 old;
     +
    -+		ret = cmpxchg_user_key((u8 *)hva, &old, *old_p, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_p;
    -+		*old_p = old;
    ++		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_addr;
    ++		*old_addr = old;
     +		break;
     +	}
     +	case 2: {
     +		u16 old;
     +
    -+		ret = cmpxchg_user_key((u16 *)hva, &old, *old_p, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_p;
    -+		*old_p = old;
    ++		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_addr;
    ++		*old_addr = old;
     +		break;
     +	}
     +	case 4: {
     +		u32 old;
     +
    -+		ret = cmpxchg_user_key((u32 *)hva, &old, *old_p, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_p;
    -+		*old_p = old;
    ++		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_addr;
    ++		*old_addr = old;
     +		break;
     +	}
     +	case 8: {
     +		u64 old;
     +
    -+		ret = cmpxchg_user_key((u64 *)hva, &old, *old_p, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_p;
    -+		*old_p = old;
    ++		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_addr;
    ++		*old_addr = old;
     +		break;
     +	}
     +	case 16: {
     +		__uint128_t old;
     +
    -+		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_p, new, access_key);
    -+		ret = ret < 0 ? ret : old != *old_p;
    -+		*old_p = old;
    ++		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_addr;
    ++		*old_addr = old;
     +		break;
     +	}
     +	default:
    @@ arch/s390/kvm/kvm-s390.c: int kvm_vm_ioctl_check_extension(struct kvm *kvm, long
     +		 * The first extension doesn't use a flag, but pretend it does,
     +		 * this way that can be changed in the future.
     +		 */
    -+		r = 0x3;
    ++		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
     +		break;
      	case KVM_CAP_NR_VCPUS:
      	case KVM_CAP_MAX_VCPUS:
    @@ arch/s390/kvm/kvm-s390.c: static bool access_key_invalid(u8 access_key)
      static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
      {
      	void __user *uaddr = (void __user *)mop->buf;
    -+	void __user *old_p = (void __user *)mop->old_p;
    ++	void __user *old_addr = (void __user *)mop->old_addr;
     +	union {
     +		__uint128_t quad;
     +		char raw[sizeof(__uint128_t)];
     +	} old = { .quad = 0}, new = { .quad = 0 };
    -+	unsigned int off_in_quad = sizeof(__uint128_t) - mop->size;
    ++	unsigned int off_in_quad = sizeof(new) - mop->size;
      	u64 supported_flags;
      	void *tmpbuf = NULL;
      	int r, srcu_idx;
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
      		mop->key = 0;
      	}
     +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
    ++		/*
    ++		 * This validates off_in_quad. Checking that size is a power
    ++		 * of two is not necessary, as cmpxchg_guest_abs_with_key
    ++		 * takes care of that
    ++		 */
     +		if (mop->size > sizeof(new))
     +			return -EINVAL;
    -+		/* off_in_quad has been validated */
     +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
     +			return -EFAULT;
    -+		if (copy_from_user(&old.raw[off_in_quad], old_p, mop->size))
    ++		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
     +			return -EFAULT;
     +	}
      	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
     +						       &old.quad, new.quad, mop->key);
     +			if (r == 1) {
     +				r = KVM_S390_MEMOP_R_NO_XCHG;
    -+				if (copy_to_user(old_p, &old.raw[off_in_quad], mop->size))
    ++				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
     +					r = -EFAULT;
     +			}
      		} else {
 2:  0cb750e8d182 !  2:  5c5ad96a4c81 Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
    @@ Documentation/virt/kvm/api.rst: The fields in each entry are defined as follows:
                < 0 on generic error (e.g. -EFAULT or -ENOMEM),
     -          > 0 if an exception occurred while walking the page tables
     +          16 bit program exception code if the access causes such an exception
    -+          other code > maximum 16 bit value with special meaning
    ++          other code > 0xffff with special meaning
      
      Read or write data from/to the VM's memory.
      The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
    @@ Documentation/virt/kvm/api.rst: Parameters are specified via the following struc
      			__u8 ar;	/* the access register number */
      			__u8 key;	/* access key, ignored if flag unset */
     +			__u8 pad1[6];	/* ignored */
    -+			__u64 old_p;	/* ignored if flag unset */
    ++			__u64 old_addr;	/* ignored if flag unset */
      		};
      		__u32 sida_offset; /* offset into the sida */
      		__u8 reserved[32]; /* ignored */
    @@ Documentation/virt/kvm/api.rst: Absolute accesses are permitted for non-protecte
        * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
     +  * ``KVM_S390_MEMOP_F_CMPXCHG``
     +
    -+The semantics of the flags common with logical acesses are as for logical
    ++The semantics of the flags common with logical accesses are as for logical
     +accesses.
     +
    -+For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
    -+In this case, instead of doing an unconditional write, the access occurs only
    -+if the target location contains the "size" byte long value pointed to by
    -+"old_p". This is performed as an atomic cmpxchg. "size" must be a power of two
    -+up to and including 16.
    -+The value at the target location is written to the location "old_p" points to.
    ++For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if
    ++KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
    ++In this case, instead of doing an unconditional write, the access occurs
    ++only if the target location contains the value pointed to by "old_addr".
    ++This is performed as an atomic cmpxchg with the length specified by the "size"
    ++parameter. "size" must be a power of two up to and including 16.
     +If the exchange did not take place because the target value doesn't match the
    -+old value KVM_S390_MEMOP_R_NO_XCHG is returned.
    -+The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
    -+has bit 1 (i.e. bit with value 2) set.
    ++old value, KVM_S390_MEMOP_R_NO_XCHG is returned.
    ++In this case the value "old_addr" points to is replaced by the target value.
      
     -The semantics of the flags are as for logical accesses.
      
 3:  ecd3f9d6bc9f =  3:  9cbcb313d91d KVM: s390: selftest: memop: Pass mop_desc via pointer
 4:  3b7124d69a90 =  4:  21d98b9deaae KVM: s390: selftest: memop: Replace macros by functions
 5:  c380623abd0d !  5:  866fcd7fbc97 KVM: s390: selftest: memop: Move testlist into main
    @@ Commit message
         certain bits are set in the memop extension capability.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
 6:  f4491194821a !  6:  c3e473677786 KVM: s390: selftest: memop: Add cmpxchg tests
    @@ tools/testing/selftests/kvm/s390x/memop.c: static struct kvm_s390_mem_op ksmo_fr
      	}
     +	if (desc->old) {
     +		ksmo.flags |= KVM_S390_MEMOP_F_CMPXCHG;
    -+		ksmo.old_p = (uint64_t)desc->old;
    ++		ksmo.old_addr = (uint64_t)desc->old;
     +	}
      	if (desc->_ar)
      		ksmo.ar = desc->ar;
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vc
      	}
     -	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
     -	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
    -+	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old_p=%llx",
    ++	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old_addr=%llx",
     +	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key,
    -+	       ksmo->old_p);
    ++	       ksmo->old_addr);
      	if (ksmo->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
      		printf(", CHECK_ONLY");
      	if (ksmo->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION)
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	}
     +}
     +
    -+static bool _cmpxchg(int size, void *target, __uint128_t *old_p, __uint128_t new)
    ++static bool _cmpxchg(int size, void *target, __uint128_t *old_addr, __uint128_t new)
     +{
     +	bool ret;
     +
     +	switch (size) {
     +	case 4: {
    -+			uint32_t old = *old_p;
    ++			uint32_t old = *old_addr;
     +
     +			asm volatile ("cs %[old],%[new],%[address]"
     +			    : [old] "+d" (old),
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +			    : [new] "d" ((uint32_t)new)
     +			    : "cc"
     +			);
    -+			ret = old == (uint32_t)*old_p;
    -+			*old_p = old;
    ++			ret = old == (uint32_t)*old_addr;
    ++			*old_addr = old;
     +			return ret;
     +		}
     +	case 8: {
    -+			uint64_t old = *old_p;
    ++			uint64_t old = *old_addr;
     +
     +			asm volatile ("csg %[old],%[new],%[address]"
     +			    : [old] "+d" (old),
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +			    : [new] "d" ((uint64_t)new)
     +			    : "cc"
     +			);
    -+			ret = old == (uint64_t)*old_p;
    -+			*old_p = old;
    ++			ret = old == (uint64_t)*old_addr;
    ++			*old_addr = old;
     +			return ret;
     +		}
     +	case 16: {
    -+			__uint128_t old = *old_p;
    ++			__uint128_t old = *old_addr;
     +
     +			asm volatile ("cdsg %[old],%[new],%[address]"
     +			    : [old] "+d" (old),
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +			    : [new] "d" (new)
     +			    : "cc"
     +			);
    -+			ret = old == *old_p;
    -+			*old_p = old;
    ++			ret = old == *old_addr;
    ++			*old_addr = old;
     +			return ret;
     +		}
     +	}
 7:  8009dd0fb795 =  7:  90288760656e KVM: s390: selftest: memop: Add bad address test
 8:  cd1c47941014 =  8:  e3d4b9b2ba61 KVM: s390: selftest: memop: Fix typo
 9:  41b08e886566 =  9:  13fedd6e3d9e KVM: s390: selftest: memop: Fix wrong address being used in test

base-commit: 739ad2e4e15b585a0eaf98b7bdee62b2dd9588c9
-- 
2.34.1

