Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5BD68C3B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBFQqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBFQqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9AE2884C;
        Mon,  6 Feb 2023 08:46:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Gica3005603;
        Mon, 6 Feb 2023 16:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6NdrlTZq1TkhiY++JumGSzZ6iU21UAbCSZ0w4zWNujY=;
 b=dW9m6pVNfGAe7ut+Iw+gISI7PCoqg9Cxmfok+i3B5sg46tzQ8YUe04TfBB0JyDiNofgk
 Io9oFQOgAipfozgaVWnxw0hDcktDEsP+miZyFBq87sf66Fw9LPL8lxaHpsq5ywsKcDB1
 omw4aM0dhjKJqZW2IaIF+dGdNQZ9S0Uudy7hTzhpt2So+WPwJJ/mqWeeSiYbXY3qcM2W
 m66Oo8cey4gH1+miV9QDdWrEi4+n/XTc/c5yqkM85ErjvE/KyBwbA3vC8aH5mMEu75kD
 yfoE+TA0qCUf9IV8KUSZNHCX80SXcPpllcTSVWYegfdPzBUbi8RO/eCbwkcB5bHiym7S +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk59w03ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:11 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Gidvm005719;
        Mon, 6 Feb 2023 16:46:11 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk59w03bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:11 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316Bn9B1000395;
        Mon, 6 Feb 2023 16:46:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06hv12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk4hF49611188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C9E220043;
        Mon,  6 Feb 2023 16:46:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2DD720040;
        Mon,  6 Feb 2023 16:46:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:03 +0000 (GMT)
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
Subject: [PATCH v7 00/14] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Mon,  6 Feb 2023 17:45:48 +0100
Message-Id: <20230206164602.138068-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _1ACa1j9IgQIT3daz_Lx5p8BFPg-UKmf
X-Proofpoint-ORIG-GUID: mSDp9q443iozmCNnBNpq8BKcxiPCjnHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
operation. For now, support this operation for absolute accesses only.

This operation can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Also contains some fixes/changes for the memop selftest independent of
the cmpxchg changes.

v6 -> v7
 * cast to __user pointers in cmpxchg_guest_abs_with_key
 * dropped function for allocating buffer for mem_op
 * use goto if CHECK_ONLY in mem_op refactoring
 * changed assert message in bad address test
 * picked up R-b's (thanks Thomas & Janosch)
 * fix nits, fix typos, improve commit descriptions

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
  KVM: s390: Move common code of mem_op functions into function
  KVM: s390: Dispatch to implementing function at top level of vm mem_op
  KVM: s390: Refactor absolute vm mem_op function
  KVM: s390: Refactor vcpu mem_op function
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Add cmpxchg tests

 Documentation/virt/kvm/api.rst            |  29 +-
 include/uapi/linux/kvm.h                  |   8 +
 arch/s390/kvm/gaccess.h                   |   3 +
 arch/s390/kvm/gaccess.c                   | 109 ++++
 arch/s390/kvm/kvm-s390.c                  | 221 ++++---
 tools/testing/selftests/kvm/s390x/memop.c | 675 +++++++++++++++++-----
 6 files changed, 809 insertions(+), 236 deletions(-)

Range-diff against v6:
 1:  512e1a3e0ae5 !  1:  fb51df0930d8 KVM: s390: selftest: memop: Pass mop_desc via pointer
    @@ Commit message
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
 2:  47328ea64f80 !  2:  6f09b06574f0 KVM: s390: selftest: memop: Replace macros by functions
    @@ Commit message
         KVM: s390: selftest: memop: Replace macros by functions
     
         Replace the DEFAULT_* test helpers by functions, as they don't
    -    need the exta flexibility.
    +    need the extra flexibility.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Acked-by: Janosch Frank <frankja@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
 3:  224fe37eeec7 !  3:  108c1af396fe KVM: s390: selftest: memop: Move testlist into main
    @@ Commit message
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
 4:  f622d3413cf0 !  4:  4bcad9b4bf9d KVM: s390: selftest: memop: Add bad address test
    @@ Metadata
      ## Commit message ##
         KVM: s390: selftest: memop: Add bad address test
     
    -    Add test that tries to access, instead of CHECK_ONLY.
    +    Add a test that tries a real write to a bad address.
    +    The existing CHECK_ONLY test doesn't cover all paths.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void _test_errors_common(struc
      	/* Bad guest address: */
      	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL), CHECK_ONLY);
     -	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
    -+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address");
    ++	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address with CHECK_ONLY");
     +	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL));
    -+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address");
    ++	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address on write");
      
      	/* Bad host address: */
      	rv = ERR_MOP(info, target, WRITE, 0, size, GADDR_V(mem1));
 5:  431f191a8a57 =  5:  7af4c710045c KVM: s390: selftest: memop: Fix typo
 6:  3122187435fb =  6:  2ab1854f3959 KVM: s390: selftest: memop: Fix wrong address being used in test
 7:  401f51f3ef55 !  7:  980644e1ce74 KVM: s390: selftest: memop: Fix integer literal
    @@ Commit message
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Fixes: 1bb873495a9e ("KVM: s390: selftests: Add more copy memop tests")
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void guest_copy_key_fetch_prot_override(void)
 8:  185e5cd33df6 !  8:  a9930caadf5e KVM: s390: Move common code of mem_op functions into functions
    @@ Metadata
     Author: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
     
      ## Commit message ##
    -    KVM: s390: Move common code of mem_op functions into functions
    +    KVM: s390: Move common code of mem_op functions into function
     
         The vcpu and vm mem_op ioctl implementations share some functionality.
    -    Move argument checking and buffer allocation into functions and call
    -    them from both implementations.
    -    This allows code reuse in case of additional future mem_op operations.
    +    Move argument checking into a function and call it from both
    +    implementations. This allows code reuse in case of additional future
    +    mem_op operations.
     
         Suggested-by: Janosch Frank <frankja@linux.ibm.com>
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_handle_pv(struct kvm *kvm, struct
     +		mop->key = 0;
     +	}
     +	return 0;
    -+}
    -+
    -+static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
    -+{
    -+	void *buf;
    -+
    -+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
    -+		return NULL;
    -+	buf = vmalloc(mop->size);
    -+	if (!buf)
    -+		return ERR_PTR(-ENOMEM);
    -+	return buf;
      }
      
      static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
     -	} else {
     -		mop->key = 0;
     -	}
    --	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    --		tmpbuf = vmalloc(mop->size);
    --		if (!tmpbuf)
    --			return -ENOMEM;
    --	}
    -+	tmpbuf = mem_op_alloc_buf(mop);
    -+	if (IS_ERR(tmpbuf))
    -+		return PTR_ERR(tmpbuf);
    - 
    - 	srcu_idx = srcu_read_lock(&kvm->srcu);
    - 
    + 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    + 		tmpbuf = vmalloc(mop->size);
    + 		if (!tmpbuf)
     @@ arch/s390/kvm/kvm-s390.c: static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
      {
      	void __user *uaddr = (void __user *)mop->buf;
    @@ arch/s390/kvm/kvm-s390.c: static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu
     -	} else {
     -		mop->key = 0;
     -	}
    --	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    --		tmpbuf = vmalloc(mop->size);
    --		if (!tmpbuf)
    --			return -ENOMEM;
    --	}
    -+	tmpbuf = mem_op_alloc_buf(mop);
    -+	if (IS_ERR(tmpbuf))
    -+		return PTR_ERR(tmpbuf);
    - 
    - 	switch (mop->op) {
    - 	case KVM_S390_MEMOP_LOGICAL_READ:
    + 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    + 		tmpbuf = vmalloc(mop->size);
    + 		if (!tmpbuf)
 9:  d7c8b94cb351 !  9:  2715c1ceabdb KVM: s390: Dispatch to implementing function at top level of vm mem_op
    @@ Commit message
     
         Suggested-by: Janosch Frank <frankja@linux.ibm.com>
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## arch/s390/kvm/kvm-s390.c ##
    -@@ arch/s390/kvm/kvm-s390.c: static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
    - 	return buf;
    +@@ arch/s390/kvm/kvm-s390.c: static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_fla
    + 	return 0;
      }
      
     -static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
     -	 */
     -	if (kvm_s390_pv_get_handle(kvm))
     -		return -EINVAL;
    - 	tmpbuf = mem_op_alloc_buf(mop);
    - 	if (IS_ERR(tmpbuf))
    - 		return PTR_ERR(tmpbuf);
    + 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
    + 		tmpbuf = vmalloc(mop->size);
    + 		if (!tmpbuf)
     @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
      		}
      		break;
10:  8acb425a9e93 ! 10:  91f4e887f311 KVM: s390: Refactor absolute vm mem_op function
    @@ Commit message
     
         Suggested-by: Janosch Frank <frankja@linux.ibm.com>
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## arch/s390/kvm/kvm-s390.c ##
    -@@ arch/s390/kvm/kvm-s390.c: static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
    +@@ arch/s390/kvm/kvm-s390.c: static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_fla
      static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
      {
      	void __user *uaddr = (void __user *)mop->buf;
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, str
     -			}
     -		}
     -		break;
    --	}
    ++	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;
    ++	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
    ++		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);
    ++		goto out_unlock;
    + 	}
     -	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
     -		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
     -			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, str
     -			}
     -			r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
     -						      mop->size, GACC_STORE, mop->key);
    -+	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;
    -+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
    -+		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);
    -+	} else if (acc_mode == GACC_FETCH) {
    ++	if (acc_mode == GACC_FETCH) {
     +		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
     +					      mop->size, GACC_FETCH, mop->key);
     +		if (r)
11:  f62dfb06ea55 ! 11:  d16ac0db04c7 KVM: s390: Refactor absolute vcpu mem_op function
    @@ Metadata
     Author: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
     
      ## Commit message ##
    -    KVM: s390: Refactor absolute vcpu mem_op function
    +    KVM: s390: Refactor vcpu mem_op function
     
         Remove code duplication with regards to the CHECK_ONLY flag.
         Decrease the number of indents.
    @@ arch/s390/kvm/kvm-s390.c: static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu
      	int r;
      
     @@ arch/s390/kvm/kvm-s390.c: static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
    - 	if (IS_ERR(tmpbuf))
    - 		return PTR_ERR(tmpbuf);
    + 			return -ENOMEM;
    + 	}
      
     -	switch (mop->op) {
     -	case KVM_S390_MEMOP_LOGICAL_READ:
    @@ arch/s390/kvm/kvm-s390.c: static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu
     +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
     +		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
     +				    acc_mode, mop->key);
    -+	} else if (acc_mode == GACC_FETCH) {
    ++		goto out_inject;
    ++	}
    ++	if (acc_mode == GACC_FETCH) {
      		r = read_guest_with_key(vcpu, mop->gaddr, mop->ar, tmpbuf,
      					mop->size, mop->key);
     -		if (r == 0) {
12:  2199327cb484 ! 12:  afec9544eec4 KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ Commit message
         Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
         op. For now, support this op for absolute accesses only.
     
    -    This op can be use, for example, to set the device-state-change
    +    This op can be used, for example, to set the device-state-change
         indicator and the adapter-local-summary indicator atomically.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + * Honors storage keys.
     + *
     + * Return: * 0: successful exchange
    -+ *         * a program interruption code indicating the reason cmpxchg could
    -+ *           not be attempted
    ++ *         * >0: a program interruption code indicating the reason cmpxchg could
    ++ *               not be attempted
     + *         * -EINVAL: address misaligned or len not power of two
     + *         * -EAGAIN: transient failure (len 1 or 2)
     + *         * -EOPNOTSUPP: read-only memslot (should never occur)
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +			       __uint128_t *old_addr, __uint128_t new,
     +			       u8 access_key, bool *success)
     +{
    -+	gfn_t gfn = gpa >> PAGE_SHIFT;
    ++	gfn_t gfn = gpa_to_gfn(gpa);
     +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
     +	bool writable;
     +	hva_t hva;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		return -EOPNOTSUPP;
     +
     +	hva += offset_in_page(gpa);
    ++	/*
    ++	 * The cmpxchg_user_key macro depends on the type of "old", so we need
    ++	 * a case for each valid length and get some code duplication as long
    ++	 * as we don't introduce a new macro.
    ++	 */
     +	switch (len) {
     +	case 1: {
     +		u8 old;
     +
    -+		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
    ++		ret = cmpxchg_user_key((u8 __user *)hva, &old, *old_addr, new, access_key);
     +		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	case 2: {
     +		u16 old;
     +
    -+		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
    ++		ret = cmpxchg_user_key((u16 __user *)hva, &old, *old_addr, new, access_key);
     +		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	case 4: {
     +		u32 old;
     +
    -+		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
    ++		ret = cmpxchg_user_key((u32 __user *)hva, &old, *old_addr, new, access_key);
     +		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	case 8: {
     +		u64 old;
     +
    -+		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
    ++		ret = cmpxchg_user_key((u64 __user *)hva, &old, *old_addr, new, access_key);
     +		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	case 16: {
     +		__uint128_t old;
     +
    -+		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
    ++		ret = cmpxchg_user_key((__uint128_t __user *)hva, &old, *old_addr, new, access_key);
     +		*success = !ret && old == *old_addr;
     +		*old_addr = old;
     +		break;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +	default:
     +		return -EINVAL;
     +	}
    -+	mark_page_dirty_in_slot(kvm, slot, gfn);
    ++	if (*success)
    ++		mark_page_dirty_in_slot(kvm, slot, gfn);
     +	/*
     +	 * Assume that the fault is caused by protection, either key protection
     +	 * or user page write protection.
13:  05d7682a90ba = 13:  2c006a4015c0 Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
14:  993293dcdf13 = 14:  ac16991fbe27 KVM: s390: selftest: memop: Add cmpxchg tests

base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
prerequisite-patch-id: 02346a556c2af3340683322ef71816f813599c21
prerequisite-patch-id: 770ae375220957f1db8eb2657bf2fb7868a501af
prerequisite-patch-id: fba46548bd1b60742eed8669a15cadad3c5ec19c
prerequisite-patch-id: 8df365bc587d8768618759d77e3a6806bc36130d
prerequisite-patch-id: 0fc74ea6b8342b1dd69b034be308647d47d31746
prerequisite-patch-id: c5cdc3ce7cdffc18c5e56abfb657c84141fb623a
prerequisite-patch-id: 837715a7a75d9175027343d727c98a398b927c9b
prerequisite-patch-id: 6ccea6ff976ae44347f266d7a9e19e09a2ae9063
-- 
2.37.2

