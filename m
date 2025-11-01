Return-Path: <linux-kselftest+bounces-44613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82701C28677
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B97189E5E4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4A28C860;
	Sat,  1 Nov 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXd5UAmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051C288C25;
	Sat,  1 Nov 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025668; cv=none; b=e2n+LLshNsnIDbtyR4xuRQyA2k+NBCQB32iKs3pXo6qhDF8e6T8/vzUIcCuAFdmDKwdU9FLpw5QWHM8ACbJYCaYfF341UxpHJ6Y2lTBDRjZFVy2HgncTY+pmd2mSIbY8K77fAhgYz4yvEDOaHVx44kfN42ozWb2hPflV/4HMRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025668; c=relaxed/simple;
	bh=+2DQeon6j9mTMYJK8OATLAYZm3wQvRAOPPkBzHYky3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZQi53d3BhZLJOtGDF5vNynG525Q3EEv1k0onkYJka/DMqyNCfMUpYST7e+jCDM19768WxPmY9km1lTAXSmKoB2FERbF1DSbFVHKT/2FJHWZRTsCvzjAv9OJbXjg6y/0ZE03/R4mer7sn1ryud/6v4+N6qxiRnAO3uw5anL5kJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXd5UAmX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1JU2lP004657;
	Sat, 1 Nov 2025 19:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KrvkO
	2IKd9SwvBGQEWCgmWIfW7DssO96nFyUoB/6uUs=; b=aXd5UAmXO249L5BVr2YXX
	lInHVX/Nt/XCfJz4HrqCA4hJWamaYvfS8oXK4OZ3es+qAwVp/HKPwgMNpzAcEz7o
	zekfu9wwFKMJmrCCtwInolR4+zwu3kMbInVmHYeCn+Q6xREAe30a5VDA16AG1Z2M
	ImzCMGfk/N6T2b39ZNC8GCeL/SMWBKKrsOtasinOZlNOXdKcQI4I2lwmHxPtp5uo
	2ny9BGbAUsWB7sLtl13Oh0pHQWbuSgSt+nOC3MFsCy8WiJsyzCZi1QrfIayaKTAX
	a3Hy/0R0tF8ndle/9l3PBATF1uk9K1o2NDKN2kY0AoM+5h0uNtJzt5uq7c4w0+cH
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5rdgr029-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Gevin020910;
	Sat, 1 Nov 2025 19:34:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6s26h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1JY0Gk007914;
	Sat, 1 Nov 2025 19:34:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6s24r-3;
	Sat, 01 Nov 2025 19:34:04 +0000
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
Subject: [PATCH v3 2/2] selftests/bpf: Add test for bpftool map ID printing
Date: Sat,  1 Nov 2025 12:33:55 -0700
Message-ID: <20251101193357.111186-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010168
X-Proofpoint-GUID: JPhcnXOkRQd1HFM52tCKxeZMdfEX3FHK
X-Proofpoint-ORIG-GUID: JPhcnXOkRQd1HFM52tCKxeZMdfEX3FHK
X-Authority-Analysis: v=2.4 cv=DoJbOW/+ c=1 sm=1 tr=0 ts=690660ae cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zZ8rhmji2bsAaRzR-ewA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2OCBTYWx0ZWRfXw/GaT5TC1qtj
 jmj8Ajma87A7MEQVisxUm1V6FQIZMP5Q72SAY0sbKTFP0nUzdsdGCG7g76Qt/Zk17YBXhXqrezN
 AASmktaNHgqd1oBXNV9+LB1c+2LSrT28Yg3YHBW5lz28QBsPIFt5AJW8Epz8xuCsWS+XAK38RFi
 dYzDgPP42UYKauCHGeAou9zHsQFqsn7R+86qcfXE5hdSuDpUlrtjCfauAO03z8Fvh8QXlm3g6Q+
 gmPXBIRGJfxNZhgAwlZDi9Nb0SO7Zf7cPUASoMWKKn/3AdT2Ld+7Q9zLzFSgQmp7rwsBwN5LRV7
 VuxoL0+E98/qZsceK/E1xO9V+gRAkihjZl+YffJjEU5SMChhHhcESj8/ImgxlZlGsDO1j+49Nue
 GARsrUBOK70b9KN3X1c3bUfj4wY3Yw==

Add selftest to check if Map ID is printed on successful creation in
both plain text and json formats.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2-->v3: Removes printing for success cases following the pattern used
in this script. Also remove "FAIL:" prefix for consistency. [ Thanks to
Quentin for the suggestion]
---
 .../testing/selftests/bpf/test_bpftool_map.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
index 515b1df0501e..d65866497c1b 100755
--- a/tools/testing/selftests/bpf/test_bpftool_map.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
@@ -361,6 +361,36 @@ test_map_access_with_btf_list() {
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
+	if ! echo "$output" | grep -q "Map successfully created with ID:"; then
+		echo "Map ID not printed in plain text output."
+		exit 1
+	fi
+
+	rm -f "$test_map_path"
+
+	output=$("$bpftool_path" map create "$test_map_path" type hash key 4 \
+		value 8 entries 128 name "$test_map_name" --json)
+	if ! echo "$output" | jq -e 'has("id")' >/dev/null 2>&1; then
+		echo "Map ID not printed in JSON output."
+		exit 1
+	fi
+
+	rm -f "$test_map_path"
+}
+
 set -eu
 
 trap cleanup_skip EXIT
@@ -395,4 +425,6 @@ test_map_creation_and_map_of_maps "$BPFTOOL_PATH" "$BPF_DIR"
 
 test_map_access_with_btf_list "$BPFTOOL_PATH"
 
+test_map_id_printing "$BPFTOOL_PATH" "$BPF_DIR"
+
 exit 0
-- 
2.50.1


