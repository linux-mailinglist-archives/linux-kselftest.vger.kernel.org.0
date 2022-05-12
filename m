Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C1524DE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbiELNKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354187AbiELNKf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 09:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F824FD93;
        Thu, 12 May 2022 06:10:33 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CD0g8O003891;
        Thu, 12 May 2022 13:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=N1hnXC0FDq9INFuYz/hT5L4up8mN+Cq1XmVswpFragA=;
 b=jNu5zJi/77qrcV+6VrYSl+fwzsSSKNMjctAbngNgktSG+eYOBzTZ7oVbszGX9AbCH71T
 8indnpyH8p24HB7r5FBJ8OPpB7Mw4Rh+IrKw2vLdliTGi8awNs8aKCr2LPl0h/NAMDqh
 N42pJXnSS8adgW3xaqHlbreyTWpHZykTw2tJe75EJAJIvBi5ijfellVgZ+3bR9J7h72l
 FjmL6X4OM1Ny0aDx9BtuEdUKk9DytcvQ+1yvajLoiWiHXE0HTN1wHd6ET8QHjXh8iRvG
 4DQ8qvptLgDLsvwEuJqLQz3aU6p0FkTPrTtJjEY7+u/E9DjDzD+LV7TlCQKHkeFvFdgY 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12rdrb4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:10:31 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CD0n2Q004306;
        Thu, 12 May 2022 13:10:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12rdrb3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:10:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CD2qCw026819;
        Thu, 12 May 2022 13:10:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8y33a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:10:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CDAPAO33685900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 13:10:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9A6AE04D;
        Thu, 12 May 2022 13:10:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76FCEAE045;
        Thu, 12 May 2022 13:10:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 13:10:24 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 0/2] Dirtying, failing memop: don't indicate suppression
Date:   Thu, 12 May 2022 15:10:16 +0200
Message-Id: <20220512131019.2594948-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9yhOQYqblkC69cqD1vqIkRacHso7oemc
X-Proofpoint-GUID: c-J2io2kLwAAFIWBDCYgjb6GHrVjv0Pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_10,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205120061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If a memop fails due to key checked protection, after already having
written to the guest, don't indicate suppression to the guest, as that
would imply that memory wasn't modified.

This could be considered a fix to the code introducing storage key
support, however this is a bug in KVM only if we emulate an
instructions writing to an operand spanning multiple pages, which I
don't believe we do.

v2 -> v3
 * tweak commit message
 * explicitly reset the protection code to 0 on termination
 * use variable to pass termination arg
 * add documentation
 * fix magic constant in selftest

Given the changes I did not pick up the r-b's.

v1 -> v2
 * Reword commit message of patch 1

Janis Schoetterl-Glausch (2):
  KVM: s390: Don't indicate suppression on dirtying, failing memop
  KVM: s390: selftest: Test suppression indication on key prot exception

 Documentation/virt/kvm/api.rst            |  6 +++
 arch/s390/kvm/gaccess.c                   | 22 +++++++++--
 tools/testing/selftests/kvm/s390x/memop.c | 46 ++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 5 deletions(-)

Range-diff against v2:
1:  b5725a836f1a ! 1:  e1dae6522b22 KVM: s390: Don't indicate suppression on dirtying, failing memop
    @@ Commit message
         Instruction execution can end in different ways, one of which is
         suppression, which requires that the instruction execute like a no-op.
         A writing memop that spans multiple pages and fails due to key
    -    protection can modified guest memory, as a result, the likely
    -    correct ending is termination. Therefore do not indicate a
    +    protection may have modified guest memory, as a result, the likely
    +    correct ending is termination. Therefore, do not indicate a
         suppressing instruction ending in this case.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
     
    + ## Documentation/virt/kvm/api.rst ##
    +@@ Documentation/virt/kvm/api.rst: in case of KVM_S390_MEMOP_F_CHECK_ONLY), the ioctl returns a positive
    + error number indicating the type of exception. This exception is also
    + raised directly at the corresponding VCPU if the flag
    + KVM_S390_MEMOP_F_INJECT_EXCEPTION is set.
    ++On protection exceptions, unless specified otherwise, the injected
    ++translation-exception identifier (TEID) indicates suppression.
    + 
    + If the KVM_S390_MEMOP_F_SKEY_PROTECTION flag is set, storage key
    + protection is also in effect and may cause exceptions if accesses are
    + prohibited given the access key designated by "key"; the valid range is 0..15.
    + KVM_S390_MEMOP_F_SKEY_PROTECTION is available if KVM_CAP_S390_MEM_OP_EXTENSION
    + is > 0.
    ++Since the accessed memory may span multiple pages and those pages might have
    ++different storage keys, it is possible that a protection exception occurs
    ++after memory has been modified. In this case, if the exception is injected,
    ++the TEID does not indicate suppression.
    + 
    + Absolute read/write:
    + ^^^^^^^^^^^^^^^^^^^^
    +
      ## arch/s390/kvm/gaccess.c ##
     @@ arch/s390/kvm/gaccess.c: enum prot_type {
      	PROT_TYPE_IEP  = 4,
    @@ arch/s390/kvm/gaccess.c: enum prot_type {
     -static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
     -		     u8 ar, enum gacc_mode mode, enum prot_type prot)
     +static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
    -+			    enum gacc_mode mode, enum prot_type prot, bool suppress)
    ++			    enum gacc_mode mode, enum prot_type prot, bool terminate)
      {
      	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
      	struct trans_exc_code_bits *tec;
     @@ arch/s390/kvm/gaccess.c: static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
    - 
    - 	switch (code) {
    - 	case PGM_PROTECTION:
    --		switch (prot) {
    --		case PROT_TYPE_IEP:
    --			tec->b61 = 1;
    --			fallthrough;
    --		case PROT_TYPE_LA:
    --			tec->b56 = 1;
    --			break;
    --		case PROT_TYPE_KEYC:
    --			tec->b60 = 1;
    --			break;
    --		case PROT_TYPE_ALC:
    --			tec->b60 = 1;
    --			fallthrough;
    --		case PROT_TYPE_DAT:
    --			tec->b61 = 1;
    --			break;
    -+		if (suppress) {
    -+			switch (prot) {
    -+			case PROT_TYPE_IEP:
    -+				tec->b61 = 1;
    -+				fallthrough;
    -+			case PROT_TYPE_LA:
    -+				tec->b56 = 1;
    -+				break;
    -+			case PROT_TYPE_KEYC:
    -+				tec->b60 = 1;
    -+				break;
    -+			case PROT_TYPE_ALC:
    -+				tec->b60 = 1;
    -+				fallthrough;
    -+			case PROT_TYPE_DAT:
    -+				tec->b61 = 1;
    -+				break;
    -+			}
    + 			tec->b61 = 1;
    + 			break;
      		}
    ++		if (terminate) {
    ++			tec->b56 = 0;
    ++			tec->b60 = 0;
    ++			tec->b61 = 0;
    ++		}
      		fallthrough;
      	case PGM_ASCE_TYPE:
    + 	case PGM_PAGE_TRANSLATION:
     @@ arch/s390/kvm/gaccess.c: static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
      	return code;
      }
    @@ arch/s390/kvm/gaccess.c: static int trans_exc(struct kvm_vcpu *vcpu, int code, u
     +static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
     +		     enum gacc_mode mode, enum prot_type prot)
     +{
    -+	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, true);
    ++	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, false);
     +}
     +
      static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
      			 unsigned long ga, u8 ar, enum gacc_mode mode)
      {
     @@ arch/s390/kvm/gaccess.c: int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
    + 		data += fragment_len;
      		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
      	}
    - 	if (rc > 0)
    +-	if (rc > 0)
     -		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
    -+		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot,
    -+				      (mode != GACC_STORE) || (idx == 0));
    ++	if (rc > 0) {
    ++		bool terminate = (mode == GACC_STORE) && (idx > 0);
    ++
    ++		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot, terminate);
    ++	}
      out_unlock:
      	if (need_ipte_lock)
      		ipte_unlock(vcpu);
2:  434d96c63cb5 ! 2:  d3a152fe6aec KVM: s390: selftest: Test suppression indication on key prot exception
    @@ Commit message
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
    +@@
    + #include <string.h>
    + #include <sys/ioctl.h>
    + 
    ++#include <linux/bits.h>
    ++
    + #include "test_util.h"
    + #include "kvm_util.h"
    + 
     @@ tools/testing/selftests/kvm/s390x/memop.c: static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
      #define SIDA_OFFSET(o) ._sida_offset = 1, .sida_offset = (o)
      #define AR(a) ._ar = 1, .ar = (a)
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key(void)
     +	struct test_default t = test_default_init(guest_error_key);
     +	uint64_t prefix;
     +	uint64_t teid;
    ++	uint64_t teid_mask = BIT(63 - 56) | BIT(63 - 60) | BIT(63 - 61);
     +	uint64_t psw[2];
     +
     +	HOST_SYNC(t.vcpu, STAGE_INITED);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key(void)
     +	HOST_SYNC(t.vcpu, STAGE_IDLED);
     +	MOP(t.vm, ABSOLUTE, READ, &teid, sizeof(teid), GADDR(prefix + 168));
     +	/* Bits 56, 60, 61 form a code, 0 being the only one allowing for termination */
    -+	ASSERT_EQ(teid & 0x4c, 0);
    ++	ASSERT_EQ(teid & teid_mask, 0);
     +
     +	kvm_vm_free(t.kvm_vm);
     +}

base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.32.0

