Return-Path: <linux-kselftest+bounces-44456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1EC22613
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AB3BAED4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1B33554D;
	Thu, 30 Oct 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OsmlvFso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999C32E13F;
	Thu, 30 Oct 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858452; cv=none; b=Xx+Jw3x9pnccBmSseworYwmd0kJWcQ09fDJBxmxutHjlrs/Hk8vEYc5jDHIEq5OPw8hWnMXPqfFo6qxPxRsaov0Rqd8uTz56lVFcLPmqDGd+nEmSHlXU19wvfT28CAlmj8GPn41ikqrfBrV66FRW4PxcYppsBcid8CQz5MRd4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858452; c=relaxed/simple;
	bh=c0lVYLey1J54j8+LzkyiF7aV7X/OiaCcAORzUDvclqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk2LQOigiBDCgVB6bfiHwUP2h1dh4WfXOS159/3IuvawHtiRb+Njh4ti3yDriwRSQHio36XhVIpgQnIXOS//Ppwh6K9WBkbuSLFjiTplLa6kfb8ZNL/ezSZEmszBYEQQmqzse6z4fQLWErUXwFg0VMZ1Gb4X1DwvqXFa3JjsCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OsmlvFso; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKV2Pt009976;
	Thu, 30 Oct 2025 21:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=warw8
	LcEpdVD1yZ6NqTjeOLsG3Gxja9LpBG0FJuLtoo=; b=OsmlvFso9HKrTTYjL4h3T
	QLdXiPTFmwLXnDkqVG+zcoYlMutTLLwJ83kHZy6zFjUtGzb5+6NxTYBJPqEXHboZ
	Vyb0vAS2bU1vQ67N6vaxB45zumW/DX6SaTsuozTDhWlxShnmK5ezgAPpiouUYNpH
	ctpXT3HYmzDLaAmoQTj6F65hiu3jCmNnpccmkmjqkzI69X4xp4f8O4K8L8AsNdVT
	2/JSwHUlbMEv8yYQIgNAg61WUEUHgJFEfwxviI7ihOmL0gV2Pp8F9TH0cD9yCs4B
	kX6/iz1H7sCDI4J0sLrcu9clAlvNIWye8fhSqpVE7PY8JXXp+Tr4iP4cuc9nNqcU
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4d6q0c4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJpW0C033995;
	Thu, 30 Oct 2025 21:07:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edwy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59UL70pU007669;
	Thu, 30 Oct 2025 21:07:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a34edwxup-3;
	Thu, 30 Oct 2025 21:07:06 +0000
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
Subject: [PATCH v2 2/2] selftests/bpf: Add test for bpftool map ID printing
Date: Thu, 30 Oct 2025 14:06:53 -0700
Message-ID: <20251030210655.3938262-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfXwCnPsVT77xOJ
 CkNhLAHkJT96HMmEmxA+vfLV4++CZl2wVBHtQHr04SfPLbdglCvtaevUrfnrPZSUmy+GwS6iTwJ
 ajOikvNYQlNG3f3/ztROSajbEw6tMkhtSf6siyVmnXdtYpodkrwEeGNQ2o0oLgx7pIoIArtS8a3
 cZlzmIndiUXxXw8pzITjlJdhSADlcErqVuhr5p+D1OlOh+PdUKvK3GqhGm3KWugV3P+HUhKI03N
 /3ia4BkvXdJP2zmCpyp+hJkZ4K8y/121ewjD3cq37syYnecaWZYxxt31+JbfoQglSOUFBJ2yzqB
 CTC1Cx0K3ayf65gSv7g5wSlifeIC6SZTZmgU6xXsDV6e/ud6DiwC8M4JSL5tSyB2cYnTvxSkBBg
 HjUiGzTNCLOeqEF2vnA9ItLXW9jUWfE8gVeRB4yfSv6w8AQAIY8=
X-Proofpoint-GUID: ZteDhwy0O0AjBuXcp3zBcf_EpExXnfoI
X-Authority-Analysis: v=2.4 cv=bLob4f+Z c=1 sm=1 tr=0 ts=6903d37c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zZ8rhmji2bsAaRzR-ewA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: ZteDhwy0O0AjBuXcp3zBcf_EpExXnfoI

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


