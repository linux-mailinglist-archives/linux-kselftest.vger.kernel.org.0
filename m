Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476794952CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbiATRCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 12:02:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233190AbiATRCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 12:02:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KGkai0024347;
        Thu, 20 Jan 2022 17:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ctZuzhBM6CJQJJu4zT2LTPEcoV/54KLWJ/wAADHyD90=;
 b=WTw+YCPc0CqPR6Eez1gTZ25CKOhNb1FwaSI2I7ZYQAQMuF8NnibtQbAmFTZyAq8Q9/AH
 EOMQke1nVdyZRbvDxh3YM6VLLVtzhRgf7Qfu9AgsWHO0AhKsvY5E1T9Lc19qzyaDcLZD
 dEaROfO6XcYpGxZT+8UHWRVJ3wl4zeT0e93R5TfdUAEKdBXAjiGJfnyp9QP1VDlRZbLO
 qH7k1cv780j5QXLiqnu7IWJcKmKN/czUu1IJVKZynfCmiwvAhseCImxFfbyzQC0KPnIh
 1l0z/rF8qVykZurdtzct4+lIA3HrV99ARbimozE0O5wbfht+ouvnIbnmB84G1mhsXa38 Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqbja0asj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:57 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20KGl7lt032446;
        Thu, 20 Jan 2022 17:01:57 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqbja0as7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:57 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KGvoBE010775;
        Thu, 20 Jan 2022 17:01:56 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3dknwdcnt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KH1qJo29950212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 17:01:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478F7BE05D;
        Thu, 20 Jan 2022 17:01:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2DD4BE074;
        Thu, 20 Jan 2022 17:01:49 +0000 (GMT)
Received: from farosas.linux.ibm.com.com (unknown [9.211.115.36])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 17:01:49 +0000 (GMT)
From:   Fabiano Rosas <farosas@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        pbonzini@redhat.com, shuah@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, aik@ozlabs.ru, paulus@samba.org
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Stop returning internal values to userspace
Date:   Thu, 20 Jan 2022 14:01:08 -0300
Message-Id: <20220120170109.948681-2-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120170109.948681-1-farosas@linux.ibm.com>
References: <20220120170109.948681-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EvoWya2S7OOq35IBsMfc8vt60KEbx008
X-Proofpoint-ORIG-GUID: olFM72OHF7mgt-G0PZ3JfZDJvwOPcGfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200088
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Our kvm_arch_vcpu_ioctl_run currently returns the RESUME_HOST values
to userspace, against the API of the KVM_RUN ioctl which returns 0 on
success.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
This was noticed while enabling the kvm selftests for powerpc. There's
an assert at the _vcpu_run function when we return a value different
from the expected.
---
 arch/powerpc/kvm/powerpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2ad0ccd202d5..50414fb2a5ea 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1841,6 +1841,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_ALTIVEC
 out:
 #endif
+
+	/*
+	 * We're already returning to userspace, don't pass the
+	 * RESUME_HOST flags along.
+	 */
+	if (r > 0)
+		r = 0;
+
 	vcpu_put(vcpu);
 	return r;
 }
-- 
2.34.1

