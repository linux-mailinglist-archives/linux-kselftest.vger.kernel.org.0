Return-Path: <linux-kselftest+bounces-44181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADCC14BAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610FD4FD489
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0224E3314A4;
	Tue, 28 Oct 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n3UVXJto"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0D330B3B;
	Tue, 28 Oct 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656270; cv=none; b=LC3pW1/26pgdx9Dv+3rucFfJKfrN+cl4kTlVPIzpA/2d1e0eySSzR3cTFWrdMnLHS9SXp5FOv8SA1sYoVY8/gV+2duqJbbJYvWc1NkFSqcz11jOtxVumoYcoof97CDzV/m5kiCUpvyCjlRt9f5JBxW/pGCK7xSwhZyA6KXoAwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656270; c=relaxed/simple;
	bh=c0lVYLey1J54j8+LzkyiF7aV7X/OiaCcAORzUDvclqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC1IthX56FW2XKawmshsblc9oXpoyWNbvQagOIp31CqPHDuCWRYChXUQOga93cPD3asBuky92qJ0/l4bLF3fCsXDNeZDbhjbN3ST37tfN1RMZGTZBLS7moMpXGDMMXUoWBkjQeCiYoXl7y81Ior1fct3wLCB8HL5WOdsacHREvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n3UVXJto; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDY6g015469;
	Tue, 28 Oct 2025 12:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=warw8
	LcEpdVD1yZ6NqTjeOLsG3Gxja9LpBG0FJuLtoo=; b=n3UVXJtoKRP1tgQaroxsp
	ZijJICAMc+P7SwJrE/bU8PTrqitCz2BWkGQS1ajOESlsN/1Bp75CDl4vva265YDm
	qmkKfEsJht0txhlacPcnheOfrSr0nhMv+dfT3ZQYmo8gRTEuYaYRh8AcXi/JsVt+
	JKfE9Kxn1Sx6Kf50NvDYlOfMdklRTLdmyYQ7zz2eG7tqigJhqXm3zuvCqTlDHxwi
	z+Rjn0uZQaY5fZ8k0LZmS+O0MWzA9qPH3xxEk8xfWYavq0OGiYxISIpfjVrAJ6Eh
	20hKPnTVyXXuZ66ekmn7udZdfClBbCqbudRKUIquQoSVu6mw7iKEbCeSK4+kBpLK
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4yp5pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBslZc009120;
	Tue, 28 Oct 2025 12:57:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0fcxcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:20 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SCvCUw017359;
	Tue, 28 Oct 2025 12:57:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a0n0fcx93-3;
	Tue, 28 Oct 2025 12:57:19 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: bpf@vger.kernel.org
Cc: alan.maguire@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next 2/2] selftests/bpf: Add test for bpftool map ID printing
Date: Tue, 28 Oct 2025 05:57:03 -0700
Message-ID: <20251028125705.3586552-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
References: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfXx5KHZTgsI3sh
 Ysi24Y1RM6CA/KQ4aNIxmfZB5h99QvcO4kol0Owj8okFK1bWeqz1gWFc7M0CfsklqhzHRpmKtrp
 vxxJ7NEcwJCCAP3q94tPDNmcVD2CK2vEv2HD62Uunx/ASXxIB1WO7Pm6FJOgM3Ow0rwEOnv4cuW
 MSRYgt4Y+BFri5n460HxEK8sFT8jo+rZCWYdNv/GbnvhGIXCvSCUziM0UbSPzGSButvT85jZgPM
 +bM9Vkfcw3O64h01DAcU4mzTJwI+mKaA79pJ0FASWSSKuLcJKzbavIXiyUeYgkg4p+mPgcOIHFJ
 MpXZWvO30wV3Dwj488thFKewNMjoisos3rQi7chObqjOWf0Wh5tQzjvx3esPk3uogArC3vogikN
 S3kb4lqAN60rIbtvogXrx/mq8ey/dOMkF31dGOhOPblYlVhKDkQ=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=6900bdb1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zZ8rhmji2bsAaRzR-ewA:9 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: xCGF6xnaL5i6aiMdNhkkeDs-L6C7a6YQ
X-Proofpoint-GUID: xCGF6xnaL5i6aiMdNhkkeDs-L6C7a6YQ

Add selftest to check if Map ID is printed on successful creation in
both plain text and json formats.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 .../testing/selftests/bpf/test_bpftool_map.sh | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
index 515b1df0501e..013a64e96cbf 100755
--- a/tools/testing/selftests/bpf/test_bpftool_map.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
@@ -361,6 +361,40 @@ test_map_access_with_btf_list() {
 	fi
 }
 
+# Function to test map ID printing
+# Parameters:
+#   $1: bpftool path
+#   $2: BPF_DIR
+test_map_id_printing() {
+	local bpftool_path="$1"
+	local bpf_dir="$2"
+	local test_map_name="test_map_id"
+	local test_map_path="$bpf_dir/$test_map_name"
+
+	local output
+	output=$("$bpftool_path" map create "$test_map_path" type hash key 4 \
+		value 8 entries 128 name "$test_map_name")
+	if echo "$output" | grep -q "Map successfully created with ID:"; then
+		echo "PASS: Map ID printed in plain text output."
+	else
+		echo "FAIL: Map ID not printed in plain text output."
+		exit 1
+	fi
+
+	rm -f "$test_map_path"
+
+	output=$("$bpftool_path" map create "$test_map_path" type hash key 4 \
+		value 8 entries 128 name "$test_map_name" --json)
+	if echo "$output" | jq -e 'has("id")' >/dev/null 2>&1; then
+		echo "PASS: Map ID printed in JSON output."
+	else
+		echo "FAIL: Map ID not printed in JSON output."
+		exit 1
+	fi
+
+	rm -f "$test_map_path"
+}
+
 set -eu
 
 trap cleanup_skip EXIT
@@ -395,4 +429,6 @@ test_map_creation_and_map_of_maps "$BPFTOOL_PATH" "$BPF_DIR"
 
 test_map_access_with_btf_list "$BPFTOOL_PATH"
 
+test_map_id_printing "$BPFTOOL_PATH" "$BPF_DIR"
+
 exit 0
-- 
2.50.1


