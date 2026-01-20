Return-Path: <linux-kselftest+bounces-49444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F8D3C1AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 072F1465A45
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856F3D6470;
	Tue, 20 Jan 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDYp3Zw7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1673D5230;
	Tue, 20 Jan 2026 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896039; cv=none; b=RJLxtCzy32nNP0/0EU08D7aB5wNJgBV+BIL+5F+REVRjgPnmkSq4uyppetUOWDmTNVQM0bP1+1vgsy46eFAzwXW3fLljuS0PJfdq7M1hBcn535uFTxfz8jr+lVIUAJDnt6LH15H8f4bUsY6VfoaO59qJ5Xkkijh8rjtnNsTHCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896039; c=relaxed/simple;
	bh=1BpiAO6En/jtpQOE+dC7Tg2QW0+HtWYldLaVCIEvqgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLQJV7Wc5GUYw5HkJO8z53IqxVCJvzncYK0GowaOEIOO2evEbZupWdc3uSBnXGjo186AQhfiteEUKuY+SN1mu93u97yfasZ6EVdXSvmcM3KDJHYz1/72PXhmwAt6dtj4/vVNJe8gCURXe4u/t4WMgtz4jRuM0aLpR16EbxyauE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDYp3Zw7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K72Hq61409561;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/sXdEQhGDuM
	5Ob89uOTfFDqTejm49y27DLriFbpLyQ4=; b=YDYp3Zw77XBVrFHHY3XM02/AGwg
	tBLMsyXj1bJwj8dhdgAt13kRxLy8ZpwAxakTssVhBifCyPsEqEKw6a+ty+JZVGyc
	fAaY4bVIHS862w6gggGORm0jQ3XLHtv3Mix/YfoFyJQKKLUB+573c7ksQZ2e2IWj
	qk7Kk0gO7EDzBc3qeKd9wK4tdiMEeUsCM7fm/1g1ij9943Ei68gq05fnxA6778p8
	e2yirXkz+3Nc2q2VhniOSbmfCJgLKH3g+OPGzcDq39n0vKxP38jQ5s0rSaD4mwIh
	w7dTPGnqGZlQvI0JDuc3ivT2Gtz+e7Yn06PRs91IBb+BMz4RzggdI2KfrnQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2r59y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Gwb007949;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80H7q008018;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Hlc008009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id EF7E1255D5; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH 27/27] RISC-V: KVM: selftests: Add nested virt CSRs to get-reg-list test
Date: Tue, 20 Jan 2026 13:30:13 +0530
Message-ID: <20260120080013.2153519-28-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX7HNXrwS6Yfba
 KDLHVaEh797rdOWjnBSl4PJLXRULYKIfdIFEYV+FyV+dPyPra49+UuHpwInc0YYOczCyR0iaKZ8
 z99jsHJVGNeU164ucUPBdTxUeiswQnQOcC9/fNBJz6s8Dec0Yj3lRxwtoXYA0AqCOAJX4YS1knY
 2TU0KHdAfw55nth9jwhDUzOYqVJJUqZ3asATQwyNpTqbC5Jb0DZ3NbPQRlrzu/r+99e3ZkSxsRt
 XtXJhHxbWgWpsD1JIdr6r7y8HqKEkXT0FZm6A8r2SKcfhWvg9Y7rClXPskbtBDDeoz5qF5EGRPk
 nHuXD2ur0t6LaPjRR+9hERBO6MwzD61FSs/ISELrc+sbeRFXup2fevUy0sUWAUiuQ7EU73S2WvZ
 VNu31IOn7YjSk4q2H/18QrCs4zfkSZ6tiZIJxBb/eJTEWuR4+4nzw1njphdy/+F7p/IL6fi3xiN
 lrtQK5/VdU9hdwPNssg==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Klld_iMMGfk6YvHcOo4A:9
X-Proofpoint-GUID: biHzhtzQ_Ju2UqrzE0RCDij9uOoGvsEL
X-Proofpoint-ORIG-GUID: biHzhtzQ_Ju2UqrzE0RCDij9uOoGvsEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The KVM RISC-V allows Guest/VM nested vitualization CSRs to be
accessed via ONE_REG so add this to get-reg-list test.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 53af7a453327..88dc08c611cd 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -327,6 +327,8 @@ static const char *core_id_to_str(const char *prefix, __u64 id)
 	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
 #define RISCV_CSR_SMSTATEEN(csr) \
 	"KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
+#define RISCV_CSR_HEXT(csr) \
+	"KVM_REG_RISCV_CSR_HEXT | KVM_REG_RISCV_CSR_REG(" #csr ")"
 
 static const char *general_csr_id_to_str(__u64 reg_off)
 {
@@ -394,6 +396,56 @@ static const char *smstateen_csr_id_to_str(__u64 reg_off)
 	return NULL;
 }
 
+static const char *hext_csr_id_to_str(__u64 reg_off)
+{
+	/* reg_off is the offset into struct kvm_riscv_hext_csr */
+	switch (reg_off) {
+	case KVM_REG_RISCV_CSR_HEXT_REG(hstatus):
+		return RISCV_CSR_HEXT(hstatus);
+	case KVM_REG_RISCV_CSR_HEXT_REG(hedeleg):
+		return RISCV_CSR_HEXT(hedeleg);
+	case KVM_REG_RISCV_CSR_HEXT_REG(hideleg):
+		return RISCV_CSR_HEXT(hideleg);
+	case KVM_REG_RISCV_CSR_HEXT_REG(hvip):
+		return RISCV_CSR_HEXT(hvip);
+	case KVM_REG_RISCV_CSR_HEXT_REG(hcounteren):
+		return RISCV_CSR_HEXT(hcounteren);
+	case KVM_REG_RISCV_CSR_HEXT_REG(htimedelta):
+		return RISCV_CSR_HEXT(htimedelta);
+	case KVM_REG_RISCV_CSR_HEXT_REG(htimedeltah):
+		return RISCV_CSR_HEXT(htimedeltah);
+	case KVM_REG_RISCV_CSR_HEXT_REG(htval):
+		return RISCV_CSR_HEXT(htval);
+	case KVM_REG_RISCV_CSR_HEXT_REG(htinst):
+		return RISCV_CSR_HEXT(htinst);
+	case KVM_REG_RISCV_CSR_HEXT_REG(henvcfg):
+		return RISCV_CSR_HEXT(henvcfg);
+	case KVM_REG_RISCV_CSR_HEXT_REG(henvcfgh):
+		return RISCV_CSR_HEXT(henvcfgh);
+	case KVM_REG_RISCV_CSR_HEXT_REG(hgatp):
+		return RISCV_CSR_HEXT(hgatp);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vsstatus):
+		return RISCV_CSR_HEXT(vsstatus);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vsie):
+		return RISCV_CSR_HEXT(vsie);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vstvec):
+		return RISCV_CSR_HEXT(vstvec);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vsscratch):
+		return RISCV_CSR_HEXT(vsscratch);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vsepc):
+		return RISCV_CSR_HEXT(vsepc);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vscause):
+		return RISCV_CSR_HEXT(vscause);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vstval):
+		return RISCV_CSR_HEXT(vstval);
+	case KVM_REG_RISCV_CSR_HEXT_REG(vsatp):
+		return RISCV_CSR_HEXT(vsatp);
+	}
+
+	TEST_FAIL("Unknown h-extension csr reg: 0x%llx", reg_off);
+	return NULL;
+}
+
 static const char *csr_id_to_str(const char *prefix, __u64 id)
 {
 	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CSR);
@@ -410,6 +462,8 @@ static const char *csr_id_to_str(const char *prefix, __u64 id)
 		return aia_csr_id_to_str(reg_off);
 	case KVM_REG_RISCV_CSR_SMSTATEEN:
 		return smstateen_csr_id_to_str(reg_off);
+	case KVM_REG_RISCV_CSR_HEXT:
+		return hext_csr_id_to_str(reg_off);
 	}
 
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
@@ -941,6 +995,51 @@ static __u64 smstateen_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN,
 };
 
+static __u64 h_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hstatus),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hedeleg),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hideleg),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hvip),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hcounteren),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(htimedelta),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(htimedeltah),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(htval),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(htinst),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(henvcfg),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(henvcfgh),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(hgatp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vsstatus),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vsie),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vstvec),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vsscratch),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vsepc),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vscause),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vstval),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_HEXT |
+	KVM_REG_RISCV_CSR_HEXT_REG(vsatp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE |
+	KVM_RISCV_ISA_EXT_H,
+};
+
 static __u64 fp_f_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[0]),
 	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[1]),
@@ -1079,6 +1178,8 @@ static __u64 vector_regs[] = {
 	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
 #define SUBLIST_SMSTATEEN \
 	{"smstateen", .feature = KVM_RISCV_ISA_EXT_SMSTATEEN, .regs = smstateen_regs, .regs_n = ARRAY_SIZE(smstateen_regs),}
+#define SUBLIST_H \
+	{"h", .feature = KVM_RISCV_ISA_EXT_H, .regs = h_regs, .regs_n = ARRAY_SIZE(h_regs),}
 #define SUBLIST_FP_F \
 	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
 		.regs_n = ARRAY_SIZE(fp_f_regs),}
@@ -1160,7 +1261,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
-KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
+KVM_ISA_EXT_SUBLIST_CONFIG(h, H);
 KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
-- 
2.43.0


