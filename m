Return-Path: <linux-kselftest+bounces-48378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB0CFC1A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 06:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330F530AC76E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 05:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C626E165;
	Wed,  7 Jan 2026 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgpjCCZY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZS1McJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8426ED28
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764359; cv=none; b=rhcUvy49CVbRNvOwZWt8Me4u9JfCux2VwQVL3+A6uSfAM4yRqXAeHMKXwHQ/lIdF2PFAa/Jnb56F/sQT1sQ/8LaDi691vduGr1MOJGGR+SGHF4ARwUSr9/mU92T96uJFQxe/WZl53xKnf26nahsgWcv3b3T8hPqP28ELEeF4Hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764359; c=relaxed/simple;
	bh=dS/1XwuM3soE4zMznpdoY9Pcwg3cH7gIQnm86dDsTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNSwwWMro4DQ+zLnmEAn6OUa08gWjMl15mxRVKQpgTyCRe3TVwz89Fb8Luvlj1nOm2c+3jnVDzWJBDixg9OF2ZknFJVoaQ/jcJs0+UcYbT1ZBDJ9YLOUhVcqzCbDdPG4Em3Q7Bg4q1s3vK08vcGAgnY6diQdOPmBTFxYPfHcpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lgpjCCZY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZS1McJy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6074KcTZ4090856
	for <linux-kselftest@vger.kernel.org>; Wed, 7 Jan 2026 05:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nAF4cmlQB74fEG5mGg5TgnQuCtp9YvyxuRe
	TZpZX3Rc=; b=lgpjCCZY8d3JmcgYSiQ+SqgGMznI4E+U2Jye7xLB+aYkg9QWA0j
	ECXaG6Bhk94vHg43D9mMkA84tFWdrhPizg0PPAW+XkqFSnhNABg89S68UIuldEMd
	egPmVz5B/LozxRlDCyPEAsh5DqXvfycMoewnWq+XOzbNvFM7aM7oK9s7odYX280x
	Kw2N5FLxRDijWy6+jmijh/UMzGy0GMVA5etpgowBYfI8hbJ88eqiobu/bwFwRhM+
	Oc2NoIQPZx9rjiH6mvK0W91UFCljg4Py30JYZwAnZS8/pwyBejD4LMKL6Tms6tlA
	Hk24zt4ZBiydARsxie0h0xLQWilQQhAK7Fw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgyunb7bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 05:39:15 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-11f3b5411c7so4924929c88.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 21:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767764354; x=1768369154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAF4cmlQB74fEG5mGg5TgnQuCtp9YvyxuReTZpZX3Rc=;
        b=fZS1McJylUt/OPJv+3RcHye8Orwkh8ymN/yEbCW7czTCpDH85zyM76g2lwQ25PMeLV
         XFVSpbZy7XzzHB9PpOalMU+HusZU5a+AUnCXStxkea+3BhO23Dh7ZXtJMfV1XKWFhc6v
         LlloVPwaGL1Ba52XpH4Pox+wz0pEPBrEENzrWHY8SlxEAGyyEgwTNhhcsMiHXtwEqkeR
         //iaCHDHkjAobG0cXTjyz4XgJ4psY1uS+g0zE4YbAvUQVMa9h4H1ckClIHPZ7BD32z7M
         sVehqqNsTKYK6mISgi/gLyZY4pwyWGDCGF8LeGk+z8v/KWq6scLdQHdPjY7Toh4tAnyp
         20Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767764354; x=1768369154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAF4cmlQB74fEG5mGg5TgnQuCtp9YvyxuReTZpZX3Rc=;
        b=VsHKWZVMNaO4U2ucf8nDSUXEQHounMRj9xbskqVFkk4EbwZHtuzerLgATPWlFSrX7P
         lWmkzF1QVBlTY6/bc28e53AoMaNtMIEpkD2/rFgJRiXoWulKnrgATi4arfhoIO7EV0xG
         8aJl7lbiM6UuzQp0srZC2MlVRNYJci9ew9LXF4N3dLrg0EEuJsasvXozftAwB2+8OsTk
         bbmPnKt9EumwzoR/5ZzBWYMUXq+0EmLWRT75PkFqjpfuvcZn5FooCdiEUru3QRJceyfd
         X+Do5mHFjXdnyIb67DXQzXoUyMVxYnpMSCvxCMUKs+LwgCdZwJsqNgJt0QhbsqxpmOgi
         ssWg==
X-Forwarded-Encrypted: i=1; AJvYcCXCXv9vgZ9xNwepCeD9CdVVwGJTSkExnCuuZtuCro+WdhThXTcIbUEcccIDIIX8AnHGmUC2BFgfgJI4N3KHrMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoJ29MHS9TDZpDwzuPL65LySixY0Xbm/V12BqN6cFUELZkiLd
	CobpSDHFZck39WLq28jAMclb6H7VfSPzSIVIBVAVpXewQFWjeY1fLBR5kJhtEUL4d//Imk3Dy+q
	1LDuxWfptVoSEVjy9ZYT2cPJzMsIJcvY10nLWrqrUyCvXsZ06mDZLlX4b4wm0Z0huenROk68=
X-Gm-Gg: AY/fxX7zOy3fSzfkhOjzP/ML1Z24YelJSvFOh1n6fnTLAW8ptOz6fDQZWhUDETlfntI
	oMAwkdp5MDPoQ2WS5wZWC1uPVzmPAnY797MzJdJ3fNIuOTAcKrC9eCdUTEExsRBU9uiiaZf/EYQ
	bd6Du76Wb4SCqZuWN0hgWABr6sY1n8FvF0rEtkFJ0vCwyCvQNdx25iBGX4zJlLk0I2PBkpKFJst
	x/slBNhBZsIz5HEY23+pku+jKvAhduo77n49b6W9E8w0XRdC04Ap8gEULq4NU/kzlJ999sW1bRN
	UWendlb7PGNQuqyiDfpfA3hUQDpBPARSKzI4RRRTGhY2XDMURmedhb5lpgVdBPOLQBgSiHq7A3S
	7rmVVImlBp/N/bXaEYVvom0CMYqZsE9reWI/46tBe+rExsYaeDPkbFcQ=
X-Received: by 2002:a05:7022:440b:b0:11f:2c69:3e with SMTP id a92af1059eb24-121f8ab67dcmr1318365c88.6.1767764353995;
        Tue, 06 Jan 2026 21:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ4EiGgfSX4Rs6euarnnkwl4nNgaFxGA2YWd9xO1Jenw2cQpcKoyKhKpEXWv2Xw0QZL3aIiw==
X-Received: by 2002:a05:7022:440b:b0:11f:2c69:3e with SMTP id a92af1059eb24-121f8ab67dcmr1318346c88.6.1767764353340;
        Tue, 06 Jan 2026 21:39:13 -0800 (PST)
Received: from hu-liuxin-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm8685251c88.4.2026.01.06.21.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 21:39:12 -0800 (PST)
From: Xin Liu <xin.liu@oss.qualcomm.com>
To: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xin.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        jie.gan@oss.qualcomm.com
Subject: [PATCH] selftests: kvm: add boundary tests for kvm_create_max_vcpus
Date: Tue,  6 Jan 2026 21:39:09 -0800
Message-ID: <20260107053912.516913-1-xin.liu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0MyBTYWx0ZWRfX7G3c07mb3Zp0
 xN8RVWg7YuMtOndk+bS0pkopamoiF8HiONvAMigdZ+lk3knO/NQl/x2B0UcrqJOqEn+YaUyPCas
 HLJqGrW76Z2Rih/R68tB5lj0hKYST5bBLZ96L7A9d4Za1eDf6SB6hJNewFU9UoRiirGBo22P17W
 XbLjynKsjkd0sDky/q8kV/MKZ4qGnJVLoXNiIBQwdTOwghr0AH2cMAus+V4m6B9NoSzavw9V/fD
 K52lMT8kMYfiSySHRDrzEOixYi4je3Dwpb0exwlr4QH0/sWcmL5DO+I4u8+nsUon1F/iUI5MUwS
 JJczvZ8tuwUYq4U0OLnoanLWQBSXIWtvwaECGETZsvPij7yl/GjSslSeIq4xThradYbOwtNT3mO
 LzQfHVG0EujffTDzJGE2JfXwUlGFtU4Lgo/b+PujRteclrtdqOIYtge77WCoXSVRWmfAkOf+UY8
 KeYZLzeumTgiXBWFF9w==
X-Authority-Analysis: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=695df183 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uMqdHpgDjcpMDGccECEA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: L-9DZD08sRvGJYjWcED-H3xRUd_VKIAb
X-Proofpoint-ORIG-GUID: L-9DZD08sRvGJYjWcED-H3xRUd_VKIAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070043

1.Allocate extra vCPUs beyond max count, assert creation failure.
2.Create vCPU with ID over max ID, assert creation failure.

These tests cover function boundary scenarios, ensuring correct
behavior on vCPU count/ID overlimit.

Signed-off-by: Xin Liu <xin.liu@oss.qualcomm.com>
---
 .../testing/selftests/kvm/kvm_create_max_vcpus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..42c88c249192 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -17,10 +17,10 @@
 #include "asm/kvm.h"
 #include "linux/kvm.h"
 
-void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
+void test_vcpu_creation(int first_vcpu_id, int num_vcpus, int kvm_max_vcpu_id)
 {
 	struct kvm_vm *vm;
-	int i;
+	int i, fd;
 
 	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
 		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
@@ -31,6 +31,14 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 		/* This asserts that the vCPU was created. */
 		__vm_vcpu_add(vm, i);
 
+	fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)(first_vcpu_id + num_vcpus));
+	TEST_ASSERT(fd < 0,
+		"Expected failure when exceeding KVM_MAX_VCPUS, but got fd=%d", fd);
+
+	fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)kvm_max_vcpu_id);
+	TEST_ASSERT(fd < 0,
+		"Expected failure when exceeding KVM_MAX_VCPU_ID, but got fd=%d", fd);
+
 	kvm_vm_free(vm);
 }
 
@@ -56,11 +64,11 @@ int main(int argc, char *argv[])
 		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);
 
-	test_vcpu_creation(0, kvm_max_vcpus);
+	test_vcpu_creation(0, kvm_max_vcpus, kvm_max_vcpu_id);
 
 	if (kvm_max_vcpu_id > kvm_max_vcpus)
 		test_vcpu_creation(
-			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);
+			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus, kvm_max_vcpu_id);
 
 	return 0;
 }
-- 
2.43.0


