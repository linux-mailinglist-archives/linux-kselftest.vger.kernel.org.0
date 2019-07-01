Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE0299BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 16:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfEXOGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 10:06:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403926AbfEXOGe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 10:06:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OE2aEh122395
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 10:06:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2spf7j0nbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 10:06:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 24 May 2019 15:06:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 15:06:25 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OE6O5437683430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 14:06:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F2D6A4060;
        Fri, 24 May 2019 14:06:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89287A4066;
        Fri, 24 May 2019 14:06:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 May 2019 14:06:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 42969E0268; Fri, 24 May 2019 16:06:24 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        linux-kselftest@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: [PATCH] KVM: s390: fix memory slot handling for KVM_SET_USER_MEMORY_REGION
Date:   Fri, 24 May 2019 16:06:23 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052414-0020-0000-0000-00000340081F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052414-0021-0000-0000-00002192F7F1
Message-Id: <20190524140623.104033-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=615 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240095
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftests exposed a problem in the s390 handling for memory slots.
Right now we only do proper memory slot handling for creation of new
memory slots. Neither MOVE, nor DELETION are handled properly. Let us
implement those.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 871d2e99b156..6ec0685ab2c7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4525,21 +4525,28 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
-	int rc;
+	int rc = 0;
 
-	/* If the basics of the memslot do not change, we do not want
-	 * to update the gmap. Every update causes several unnecessary
-	 * segment translation exceptions. This is usually handled just
-	 * fine by the normal fault handler + gmap, but it will also
-	 * cause faults on the prefix page of running guest CPUs.
-	 */
-	if (old->userspace_addr == mem->userspace_addr &&
-	    old->base_gfn * PAGE_SIZE == mem->guest_phys_addr &&
-	    old->npages * PAGE_SIZE == mem->memory_size)
-		return;
-
-	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
-		mem->guest_phys_addr, mem->memory_size);
+	switch (change) {
+	case KVM_MR_DELETE:
+		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
+					old->npages * PAGE_SIZE);
+		break;
+	case KVM_MR_MOVE:
+		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
+					old->npages * PAGE_SIZE);
+		if (rc)
+			break;
+		/* FALLTHROUGH */
+	case KVM_MR_CREATE:
+		rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
+				      mem->guest_phys_addr, mem->memory_size);
+		break;
+	case KVM_MR_FLAGS_ONLY:
+		break;
+	default:
+		WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
+	}
 	if (rc)
 		pr_warn("failed to commit memory region\n");
 	return;
-- 
2.21.0

