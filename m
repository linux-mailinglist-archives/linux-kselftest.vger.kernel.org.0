Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B311A664D3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjAJU1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjAJU0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21B50E42;
        Tue, 10 Jan 2023 12:26:46 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJg7Pv018415;
        Tue, 10 Jan 2023 20:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gilVsgHY50Koq0FUZYD7/cY+Q5JzP7e6TtMunJl80LE=;
 b=qvTJYtDqsA2vRIt0fX9gW+oe0AWBNdX1iSeEBDjas+ldV2PI2Fwy1YA/ommQlXVQYSHu
 NnQlGK7B+fyfNDQR7sBycByTqKkow7z4AbCzOefsdQu5coVed2t3/m+BLvoavZIy5cXb
 5M/m7r8PYAMuUYCsKUxMxUHXTNmu6flcLZ3KDRDB/4072WQyxnwdhTpw/AiKY5a5cpIb
 yaYzHRCXX1GBjQm1Mg4N/FOowu0oN1d0sl3HxoyO/3uq/IvjxDgvKv2DeP25j8j5FP7S
 GItw8R9DZSVjEtr1fUokrNal3/c2MQzRw6Sr8Eb6zfUvHy+EZMMAKPLTirbNoerDm8ev Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1edd8yg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:42 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AJgHfn018853;
        Tue, 10 Jan 2023 20:26:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1edd8yfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIuAgp000570;
        Tue, 10 Jan 2023 20:26:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6ndgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQZv946399846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94DAF20043;
        Tue, 10 Jan 2023 20:26:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D40720040;
        Tue, 10 Jan 2023 20:26:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:34 +0000 (GMT)
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
Subject: [PATCH v5 00/10] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Tue, 10 Jan 2023 21:26:22 +0100
Message-Id: <20230110202632.2533978-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w1M_610gOfPUo9PgvRP2UVsXslIbmKTd
X-Proofpoint-GUID: r_AibupwR09-BgOJZew9gkciPBKVdHJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
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
mode. For now, support this mode for absolute accesses only.

This mode can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Also contains some fixes/changes for the memop selftest independent of
the cmpxchg changes.

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

Janis Schoetterl-Glausch (10):
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Move testlist into main
  KVM: s390: selftest: memop: Add cmpxchg tests
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test
  KVM: s390: selftest: memop: Fix integer literal

 Documentation/virt/kvm/api.rst            |  20 +-
 include/uapi/linux/kvm.h                  |   7 +
 arch/s390/kvm/gaccess.h                   |   3 +
 arch/s390/kvm/gaccess.c                   | 102 ++++
 arch/s390/kvm/kvm-s390.c                  |  41 +-
 tools/testing/selftests/kvm/s390x/memop.c | 675 +++++++++++++++++-----
 6 files changed, 696 insertions(+), 152 deletions(-)

Range-diff against v4:
 1:  75a20d2e27f2 !  1:  6adc166ee141 KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ arch/s390/kvm/kvm-s390.c: static int kvm_s390_vm_mem_op(struct kvm *kvm, struct
     +		 */
     +		if (mop->size > sizeof(new))
     +			return -EINVAL;
    ++		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
    ++			return -EINVAL;
     +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
     +			return -EFAULT;
     +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
 2:  5c5ad96a4c81 !  2:  fce9a063ab70 Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
    @@ Commit message
         checked) cmpxchg operations on guest memory.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
     
      ## Documentation/virt/kvm/api.rst ##
     @@ Documentation/virt/kvm/api.rst: The fields in each entry are defined as follows:
    @@ Documentation/virt/kvm/api.rst: The fields in each entry are defined as follows:
      :Returns: = 0 on success,
                < 0 on generic error (e.g. -EFAULT or -ENOMEM),
     -          > 0 if an exception occurred while walking the page tables
    -+          16 bit program exception code if the access causes such an exception
    -+          other code > 0xffff with special meaning
    ++          16 bit program exception code if the access causes such an exception,
    ++          other code > 0xffff with special meaning.
      
      Read or write data from/to the VM's memory.
      The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
 3:  9cbcb313d91d =  3:  94c1165ae24a KVM: s390: selftest: memop: Pass mop_desc via pointer
 4:  21d98b9deaae !  4:  027c87eee0ac KVM: s390: selftest: memop: Replace macros by functions
    @@ Commit message
         need the exta flexibility.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
 5:  866fcd7fbc97 !  5:  16ac410ecc0f KVM: s390: selftest: memop: Move testlist into main
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
      {
      	int extension_cap, idx;
      
    -+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
      	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
     +	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
      
    --	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
    +-	ksft_print_header();
     +	struct testdef {
     +		const char *name;
     +		void (*test)(void);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     +		},
     +	};
      
    - 	ksft_print_header();
    --
    ++	ksft_print_header();
      	ksft_set_plan(ARRAY_SIZE(testlist));
      
     -	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     -			ksft_test_result_skip("%s - extension level %d not supported\n",
     -					      testlist[idx].name,
     -					      testlist[idx].extension);
    -+			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x\n)",
    ++			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x)\n",
     +					      testlist[idx].name, extension_cap);
      		}
      	}
 6:  c3e473677786 !  6:  214281b6eb96 KVM: s390: selftest: memop: Add cmpxchg tests
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     +		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR((void *)~0xfffUL),
     +			     CMPXCHG_OLD(&old));
     +		TEST_ASSERT(rv > 0, "ioctl allows bad guest address for cmpxchg");
    ++		rv = ERR_MOP(t.vm, ABSOLUTE, READ, mem1, i, GADDR_V(mem1),
    ++			     CMPXCHG_OLD(&old));
    ++		TEST_ASSERT(rv == -1 && errno == EINVAL,
    ++			    "ioctl allows read cmpxchg call");
     +	}
     +	for (i = 2; i <= 16; i *= 2) {
     +		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR_V(mem1 + 1),
 7:  90288760656e =  7:  2d6776733e64 KVM: s390: selftest: memop: Add bad address test
 8:  e3d4b9b2ba61 =  8:  8c49eafd2881 KVM: s390: selftest: memop: Fix typo
 9:  13fedd6e3d9e =  9:  0af907110b34 KVM: s390: selftest: memop: Fix wrong address being used in test
 -:  ------------ > 10:  886c80b2bdce KVM: s390: selftest: memop: Fix integer literal
-- 
2.34.1

