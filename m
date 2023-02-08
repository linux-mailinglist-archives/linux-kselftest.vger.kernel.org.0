Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97E768F11E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBHOsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBHOsj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 09:48:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9F7AB3;
        Wed,  8 Feb 2023 06:48:38 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Ehlgw028660;
        Wed, 8 Feb 2023 14:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ICeFENhisv8WoXowshIf2/IPNIx8rmtewQQ52ecU1EQ=;
 b=c3btpvxbOu9ah1fcU/OhxC8pBC7WYk+53cVy8mJUy0g5eFIIgARTAnq2szUubFAtEayD
 BdnMr3ZhxJg6BOwiLT/I8UL3eXuayvWHcElIPxfSAS8RTqJlmJDOBn/O0fkCFj4aaiI8
 YJ3fWBws9nN+MtWIKmaN4RbcaKp+k9v2PmH6IKc0waC7aYFjIxbU7g9+N/G63c8exUJ8
 +qtKfSWuaFV0qGzZkDeHgfm92YjhrJeSdCzKcskU1/ixfWkknfwVDIOwhzhE3pFgysS+
 ghsh85/59OYVHk3dcVtzeIkqdnl/pEbTd41298Fg48pywdBDlwLxC0DKM9f2+HLAbR6U bg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmdrmg3vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 14:48:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318CAvZv007449;
        Wed, 8 Feb 2023 14:48:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06ujpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 14:48:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318EmSHZ25690464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 14:48:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D065920040;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88B502005A;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/2] KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
Date:   Wed,  8 Feb 2023 15:48:26 +0100
Message-Id: <20230208144827.131300-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208144827.131300-1-nrb@linux.ibm.com>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MddtpfhFg4JC35cSAh6RJnVFjpaKY7GR
X-Proofpoint-ORIG-GUID: MddtpfhFg4JC35cSAh6RJnVFjpaKY7GR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_06,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=711 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KVM_S390_GET_CMMA_BITS ioctl may return incorrect values when userspace
specifies a start_gfn outside of memslots.

This can occur when a VM has multiple memslots with a hole in between:

+-----+----------+--------+--------+
| ... | Slot N-1 | <hole> | Slot N |
+-----+----------+--------+--------+
      ^          ^        ^        ^
      |          |        |        |
GFN   A          A+B      |        |
                          A+B+C    |
			           A+B+C+D

When userspace specifies a GFN in [A+B, A+B+C), it would expect to get the
CMMA values of the first dirty page in Slot N. However, userspace may get a
start_gfn of A+B+C+D with a count of 0, hence completely skipping over any
dirty pages in slot N.

The error is in kvm_s390_next_dirty_cmma(), which assumes
gfn_to_memslot_approx() will return the memslot _below_ the specified GFN
when the specified GFN lies outside a memslot. In reality it may return
either the memslot below or above the specified GFN.

When a memslot above the specified GFN is returned this happens:

- ofs is calculated, but since the memslot's base_gfn is larger than the
  specified cur_gfn, ofs will underflow to a huge number.
- ofs is passed to find_next_bit(). Since ofs will exceed the memslot's
  number of pages, the number of pages in the memslot is returned,
  completely skipping over all bits in the memslot userspace would be
  interested in.

Fix this by resetting ofs to zero when a memslot _above_ cur_gfn is
returned (cur_gfn < ms->base_gfn).

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4890e04b210..a171a66681b4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2158,6 +2158,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
 		ms = container_of(mnode, struct kvm_memory_slot, gfn_node[slots->node_idx]);
 		ofs = 0;
 	}
+
+	if (cur_gfn < ms->base_gfn)
+		ofs = 0;
+
 	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
 	while (ofs >= ms->npages && (mnode = rb_next(mnode))) {
 		ms = container_of(mnode, struct kvm_memory_slot, gfn_node[slots->node_idx]);
-- 
2.39.1

