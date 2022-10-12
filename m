Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68665FCC74
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJLU40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJLU4Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4D52442;
        Wed, 12 Oct 2022 13:56:23 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKTKje000746;
        Wed, 12 Oct 2022 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=k4UMvHvRDWSxsi04ivbQr3mS8jwKk1ZlyDwG8UrNMjQ=;
 b=TPX/aAMoxZXBg5iq9sRoWtSgKmYO9dUEW5UlCWY6f5dh/kwKC8pbed4P9yTpwLtIb/n6
 8OSiO0uzONog6Ww8f5vcT7BtLfTtexb4CEnKnvsiDy85rlUdo62cBcGYRtDZRgxrw855
 YGonY6dab2kiURkreCaP+jq5R4xC2r1lx6RV34Kft7zOY554BiVMAOJ31RfbxYfjQtm6
 5n7itaGflHukMH66Q9+o0JOGwQ5dhLICKSQlX9vgK0BSEddhnnXpw/sIRO55LHxdc4Kh
 YNmU9Uv1gHHh1EcPCwfK3n8+jHbO1PhqzEE0vgdIjzvNlQUKIT4mZ6Nbu/7OdM+pDrF8 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k64npgkjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:19 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CKU1Bp004390;
        Wed, 12 Oct 2022 20:56:18 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k64npgkj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKsERC030564;
        Wed, 12 Oct 2022 20:56:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3k30u94xx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKuB322753224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C69DD52050;
        Wed, 12 Oct 2022 20:56:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 53F675204F;
        Wed, 12 Oct 2022 20:56:11 +0000 (GMT)
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
Subject: [PATCH v2 0/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Wed, 12 Oct 2022 22:56:00 +0200
Message-Id: <20221012205609.2811294-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _d5Ea63GoI-zWm0jzRdjJPTvHSccRuQh
X-Proofpoint-ORIG-GUID: n4_vvOciVxAVP8lPo5K3AaJE1B9THS1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120129
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

v1 -> v2
 * get rid of xrk instruction for cmpxchg byte and short implementation
 * pass old parameter via pointer instead of in mem_op struct
 * indicate failure of cmpxchg due to wrong old value by special return
   code
 * picked up R-b's (thanks Thomas)

Janis Schoetterl-Glausch (9):
  s390/uaccess: Add storage key checked cmpxchg access to user space
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Add cmpxchg tests
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test

 Documentation/virt/kvm/api.rst            |  21 +-
 include/uapi/linux/kvm.h                  |   5 +
 arch/s390/include/asm/uaccess.h           | 189 ++++++
 arch/s390/kvm/gaccess.h                   |   4 +
 arch/s390/kvm/gaccess.c                   |  57 ++
 arch/s390/kvm/kvm-s390.c                  |  35 +-
 tools/testing/selftests/kvm/s390x/memop.c | 674 +++++++++++++++++-----
 7 files changed, 833 insertions(+), 152 deletions(-)

Range-diff against v1:
 1:  7b4392170faa !  1:  58adf2b7688a s390/uaccess: Add storage key checked cmpxchg access to user space
    @@ arch/s390/include/asm/uaccess.h: do {									\
     +						    unsigned __int128 *old_p,
     +						    unsigned __int128 new, u8 access_key)
     +{
    -+	u32 shift, mask, old_word, new_word, align_mask, tmp, diff;
    ++	u32 shift, mask, old_word, new_word, align_mask, tmp;
     +	u64 aligned;
     +	int ret = -EFAULT;
     +
    @@ arch/s390/include/asm/uaccess.h: do {									\
     +		new_word = ((u8)new) << shift;
     +		break;
     +	}
    ++	tmp = old_word; /* don't modify *old_p on fault */
     +	asm volatile(
     +		       "spka	0(%[access_key])\n"
     +		"	sacf	256\n"
     +		"0:	l	%[tmp],%[aligned]\n"
    -+		"1:	nr	%[tmp],%[hole_mask]\n"
    ++		"1:	nr	%[tmp],%[mask]\n"
    ++		"	xilf	%[mask],0xffffffff\n"
     +		"	or	%[new_word],%[tmp]\n"
    -+		"	or	%[old_word],%[tmp]\n"
    -+		"	lr	%[tmp],%[old_word]\n"
    -+		"2:	cs	%[tmp],%[new_word],%[aligned]\n"
    -+		"3:	jnl	4f\n"
    -+		"	xrk	%[diff],%[tmp],%[old_word]\n"
    -+		"	nr	%[diff],%[hole_mask]\n"
    -+		"	xr	%[new_word],%[diff]\n"
    -+		"	xr	%[old_word],%[diff]\n"
    -+		"	xrk	%[diff],%[tmp],%[old_word]\n"
    ++		"	or	%[tmp],%[old_word]\n"
    ++		"2:	lr	%[old_word],%[tmp]\n"
    ++		"3:	cs	%[tmp],%[new_word],%[aligned]\n"
    ++		"4:	jnl	5f\n"
    ++		/* We'll restore old_word before the cs, use reg for the diff */
    ++		"	xr	%[old_word],%[tmp]\n"
    ++		/* Apply diff assuming only bits outside target byte(s) changed */
    ++		"	xr	%[new_word],%[old_word]\n"
    ++		/* If prior assumption false we exit loop, so not an issue */
    ++		"	nr	%[old_word],%[mask]\n"
     +		"	jz	2b\n"
    -+		"4:	ipm	%[ret]\n"
    ++		"5:	ipm	%[ret]\n"
     +		"	srl	%[ret],28\n"
    -+		"5:	sacf	768\n"
    ++		"6:	sacf	768\n"
     +		"	spka	%[default_key]\n"
    -+		EX_TABLE(0b, 5b) EX_TABLE(1b, 5b)
    -+		EX_TABLE(2b, 5b) EX_TABLE(3b, 5b)
    ++		EX_TABLE(0b, 6b) EX_TABLE(1b, 6b)
    ++		EX_TABLE(3b, 6b) EX_TABLE(4b, 6b)
     +		: [old_word] "+&d" (old_word),
     +		  [new_word] "+&d" (new_word),
    -+		  [tmp] "=&d" (tmp),
    ++		  [tmp] "+&d" (tmp),
     +		  [aligned] "+Q" (*(u32 *)aligned),
    -+		  [diff] "=&d" (diff),
     +		  [ret] "+d" (ret)
     +		: [access_key] "a" (access_key << 4),
    -+		  [hole_mask] "d" (~mask),
    ++		  [mask] "d" (~mask),
     +		  [default_key] "J" (PAGE_DEFAULT_KEY)
     +		: "cc"
     +	);
    @@ arch/s390/include/asm/uaccess.h: do {									\
     + * cmpxchg_user_key_size() - cmpxchg with user space target, honoring storage keys
     + * @size: Size of the value being cmpxchg'ed, one of 1,2,4,8,16.
     + * @address: User space address of value to compare to *@old_p and exchange with
    -+ *           *@new. Must be aligned to @size.
    ++ *           @new. Must be aligned to @size.
     + * @old_p: Pointer to old value. Interpreted as a @size byte integer and compared
     + *         to the content pointed to by @address in order to determine if the
     + *         exchange occurs. The value read from @address is written back to *@old_p.
 2:  80e3fda3d2af !  2:  c6731b0063ab KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ Commit message
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
     
      ## include/uapi/linux/kvm.h ##
    -@@ include/uapi/linux/kvm.h: struct kvm_translation {
    - struct kvm_s390_mem_op {
    - 	/* in */
    - 	__u64 gaddr;		/* the guest address */
    -+	/* in & out */
    - 	__u64 flags;		/* flags */
    -+	/* in */
    - 	__u32 size;		/* amount of bytes */
    - 	__u32 op;		/* type of operation */
    - 	__u64 buf;		/* buffer in userspace */
     @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
      		struct {
      			__u8 ar;	/* the access register number */
      			__u8 key;	/* access key, ignored if flag unset */
    -+			/* in & out */
    -+			__u64 old[2];	/* ignored if flag unset */
    ++			__u8 pad1[6];	/* ignored */
    ++			__u64 old_p;	/* ignored if flag unset */
      		};
      		__u32 sida_offset; /* offset into the sida */
      		__u8 reserved[32]; /* ignored */
    @@ include/uapi/linux/kvm.h: struct kvm_s390_mem_op {
      #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
      #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
     +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
    ++/* Non program exception return codes (pgm codes are 16 bit) */
    ++#define KVM_S390_MEMOP_R_NO_XCHG		((1 << 16) + 0)
      
      /* for KVM_INTERRUPT */
      struct kvm_interrupt {
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	if (kvm_is_error_hva(hva))
     +		return PGM_ADDRESSING;
     +	/*
    -+	 * Check if it's a ro memslot, even tho that can't occur (they're unsupported).
    ++	 * Check if it's a read-only memslot, even though that cannot occur
    ++	 * since those are unsupported.
     +	 * Don't try to actually handle that case.
     +	 */
     +	if (!writable)
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	ret = cmpxchg_user_key_size(len, (void __user *)hva, old_p, new, access_key);
     +	mark_page_dirty_in_slot(kvm, slot, gfn);
     +	/*
    -+	 * Assume that the fault is caused by key protection, the alternative
    -+	 * is that the user page is write protected.
    ++	 * Assume that the fault is caused by protection, either key protection
    ++	 * or user page write protection.
     +	 */
     +	if (ret == -EFAULT)
     +		ret = PGM_PROTECTION;
    @@ arch/s390/kvm/kvm-s390.c: int kvm_vm_ioctl_check_extension(struct kvm *kvm, long
      		r = MEM_OP_MAX_SIZE;
      		break;
     +	case KVM_CAP_S390_MEM_OP_EXTENSION:
    ++		/*
    ++		 * Flag bits indicating which extensions are supported.
    ++		 * The first extension doesn't use a flag, but pretend it does,
    ++		 * this way that can be changed in the future.
    ++		 */
     +		r = 0x3;
     +		break;
      	case KVM_CAP_NR_VCPUS:
      	case KVM_CAP_MAX_VCPUS:
      	case KVM_CAP_MAX_VCPU_ID:
     @@ arch/s390/kvm/kvm-s390.c: static bool access_key_invalid(u8 access_key)
    - 	return access_key > 0xf;
    - }
    - 
    --static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    -+static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop, bool *modified)
    + static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
      {
      	void __user *uaddr = (void __user *)mop->buf;
    -+	unsigned __int128 old;
    ++	void __user *old_p = (void __user *)mop->old_p;
     +	union {
     +		unsigned __int128 quad;
     +		char raw[sizeof(unsigned __int128)];
    -+	} new = { .quad = 0 };
    ++	} old = { .quad = 0}, new = { .quad = 0 };
    ++	unsigned int off_in_quad = sizeof(unsigned __int128) - mop->size;
      	u64 supported_flags;
      	void *tmpbuf = NULL;
      	int r, srcu_idx;
      
    -+	*modified = false;
      	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
     -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
     +			  | KVM_S390_MEMOP_F_CHECK_ONLY
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
     +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
     +		if (mop->size > sizeof(new))
     +			return -EINVAL;
    -+		if (copy_from_user(&new.raw[sizeof(new) - mop->size], uaddr, mop->size))
    ++		/* off_in_quad has been validated */
    ++		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
    ++			return -EFAULT;
    ++		if (copy_from_user(&old.raw[off_in_quad], old_p, mop->size))
     +			return -EFAULT;
    -+		memcpy(&old, mop->old, sizeof(old));
     +	}
      	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
      		tmpbuf = vmalloc(mop->size);
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
      			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
     +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
     +			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
    -+						       &old, new.quad, mop->key);
    -+			if (!r) {
    -+				mop->flags &= ~KVM_S390_MEMOP_F_CMPXCHG;
    -+			} else if (r == 1) {
    -+				memcpy(mop->old, &old, sizeof(old));
    -+				r = 0;
    ++						       &old.quad, new.quad, mop->key);
    ++			if (r == 1) {
    ++				r = KVM_S390_MEMOP_R_NO_XCHG;
    ++				if (copy_to_user(old_p, &old.raw[off_in_quad], mop->size))
    ++					r = -EFAULT;
     +			}
    -+			*modified = true;
      		} else {
      			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
      				r = -EFAULT;
    -@@ arch/s390/kvm/kvm-s390.c: long kvm_arch_vm_ioctl(struct file *filp,
    - 	}
    - 	case KVM_S390_MEM_OP: {
    - 		struct kvm_s390_mem_op mem_op;
    -+		bool modified;
    - 
    --		if (copy_from_user(&mem_op, argp, sizeof(mem_op)) == 0)
    --			r = kvm_s390_vm_mem_op(kvm, &mem_op);
    --		else
    -+		r = copy_from_user(&mem_op, argp, sizeof(mem_op));
    -+		if (r) {
    - 			r = -EFAULT;
    -+			break;
    -+		}
    -+		r = kvm_s390_vm_mem_op(kvm, &mem_op, &modified);
    -+		if (r)
    -+			break;
    -+		if (modified) {
    -+			r = copy_to_user(argp, &mem_op, sizeof(mem_op));
    -+			if (r) {
    -+				r = -EFAULT;
    -+				break;
    -+			}
    -+		}
    - 		break;
    - 	}
    - 	case KVM_S390_ZPCI_OP: {
 3:  cf036cd58aff <  -:  ------------ Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
 -:  ------------ >  3:  6cb32b244899 Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
 4:  e1d25110a983 !  4:  5f1217ad9d31 KVM: s390: selftest: memop: Pass mop_desc via pointer
    @@ Commit message
         The struct is quite large, so this seems nicer.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
 5:  e02924290577 =  5:  86a15b53846a KVM: s390: selftest: memop: Replace macros by functions
 7:  de6ac5a125e2 !  6:  49e67d7559de KVM: s390: selftest: memop: Add cmpxchg tests
    @@ tools/testing/selftests/kvm/s390x/memop.c: static struct kvm_s390_mem_op ksmo_fr
      	}
     +	if (desc->old) {
     +		ksmo.flags |= KVM_S390_MEMOP_F_CMPXCHG;
    -+		switch (ksmo.size) {
    -+		case 1:
    -+			ksmo.old[1] = *(uint8_t *)desc->old;
    -+			break;
    -+		case 2:
    -+			ksmo.old[1] = *(uint16_t *)desc->old;
    -+			break;
    -+		case 4:
    -+			ksmo.old[1] = *(uint32_t *)desc->old;
    -+			break;
    -+		case 8:
    -+			ksmo.old[1] = *(uint64_t *)desc->old;
    -+			break;
    -+		case 16:
    -+			memcpy(ksmo.old, desc->old, sizeof(ksmo.old));
    -+			break;
    -+		}
    ++		ksmo.old_p = (uint64_t)desc->old;
     +	}
      	if (desc->_ar)
      		ksmo.ar = desc->ar;
      	else
    -@@ tools/testing/selftests/kvm/s390x/memop.c: static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
    - 	return ksmo;
    - }
    - 
    -+static void cmpxchg_write_back(struct kvm_s390_mem_op *ksmo, struct mop_desc *desc)
    -+{
    -+	if (desc->old) {
    -+		switch (ksmo->size) {
    -+		case 1:
    -+			*(uint8_t *)desc->old = ksmo->old[1];
    -+			break;
    -+		case 2:
    -+			*(uint16_t *)desc->old = ksmo->old[1];
    -+			break;
    -+		case 4:
    -+			*(uint32_t *)desc->old = ksmo->old[1];
    -+			break;
    -+		case 8:
    -+			*(uint64_t *)desc->old = ksmo->old[1];
    -+			break;
    -+		case 16:
    -+			memcpy(desc->old, ksmo->old, sizeof(ksmo->old));
    -+			break;
    -+		}
    -+	}
    -+	if (desc->cmpxchg_success)
    -+		*desc->cmpxchg_success = !(ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG);
    -+}
    -+
    - struct test_info {
    - 	struct kvm_vm *vm;
    - 	struct kvm_vcpu *vcpu;
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vcpu *vcpu, const struct kvm_s390_mem_op *ksm
      		printf("ABSOLUTE, WRITE, ");
      		break;
      	}
     -	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
     -	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
    -+	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old[0]=%llu, old[1]=%llu",
    ++	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old_p=%llx",
     +	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key,
    -+	       ksmo->old[0], ksmo->old[1]);
    ++	       ksmo->old_p);
      	if (ksmo->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
      		printf(", CHECK_ONLY");
      	if (ksmo->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION)
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void print_memop(struct kvm_vc
      }
      
     -static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
    -+static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
    -+			struct mop_desc *desc)
    ++static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
    ++			   struct mop_desc *desc)
      {
      	struct kvm_vcpu *vcpu = info.vcpu;
      
    -@@ tools/testing/selftests/kvm/s390x/memop.c: static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
    - 		vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
    + 	if (!vcpu)
    +-		vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
    ++		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
      	else
    - 		vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
    -+	cmpxchg_write_back(ksmo, desc);
    +-		vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
    ++		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
      }
      
     -static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
    -+static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
    -+			   struct mop_desc *desc)
    ++static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
    ++			struct mop_desc *desc)
      {
    - 	struct kvm_vcpu *vcpu = info.vcpu;
    +-	struct kvm_vcpu *vcpu = info.vcpu;
     +	int r;
    ++
    ++	r = err_memop_ioctl(info, ksmo, desc);
    ++	if (ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG) {
    ++		if (desc->cmpxchg_success)
    ++			*desc->cmpxchg_success = !r;
    ++		if (r == KVM_S390_MEMOP_R_NO_XCHG)
    ++			r = 0;
    ++	}
    ++	TEST_ASSERT(!r, __KVM_IOCTL_ERROR("KVM_S390_MEM_OP", r));
      
    - 	if (!vcpu)
    +-	if (!vcpu)
     -		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
    -+		r = __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
    - 	else
    +-	else
     -		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
    -+		r = __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
    -+	cmpxchg_write_back(ksmo, desc);
    -+	return r;
      }
      
      #define MEMOP(err, info_p, mop_target_p, access_mode_p, buf_p, size_p, ...)	\
 6:  f4ce20cd7eff =  7:  faad9cf03ea6 KVM: s390: selftest: memop: Add bad address test
 8:  0bad86fd6183 !  8:  8070036aa89a KVM: s390: selftest: memop: Fix typo
    @@ Metadata
      ## Commit message ##
         KVM: s390: selftest: memop: Fix typo
     
    +    "acceeded" isn't a word, should be "exceeded".
    +
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key_fetch_prot_override_enabled(void)
 9:  7a1e9cb79bbb =  9:  18c423e4e3ad KVM: s390: selftest: memop: Fix wrong address being used in test

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.34.1

