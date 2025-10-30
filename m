Return-Path: <linux-kselftest+bounces-44455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1466C22604
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C19D3BAD8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC74335563;
	Thu, 30 Oct 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KRTX4m5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741832AEF5;
	Thu, 30 Oct 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858446; cv=none; b=pbsBkJMPUhrR4Go9OypMLB+4rlD63nBTq4WDjGhpQVRsdcd2M8uz9U/pFoQXtAFHKT0QewX2RI++4B8s/OKBMsfUaOtM+MZQ+2jC1B8vU1NyjBAXHptKZaBuPiDiiguysmMTJA2dM9FkCaoirIMDwqiTZeYbBIQ9t/QL5qwLmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858446; c=relaxed/simple;
	bh=O5iqwR+7Tqq1o5FWPLux+IYdzLNzKi2zQMLKnnoE+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMoZNXAy0lMl8UhK8LVGISm7/f3GoHtvpdSHo8Xb5si2IdLMfhihwoTH9rQ3P8lBdFRnmjl3RM55HKUbvo7k8LY+vHjI8uzZXPNMaGlx3x+JO1tbnvINkS05QD/hM9zCI63E+T7u9FTT/+eXV5S/XeP8nMI1v7qhnHti1n6wOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KRTX4m5Z; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKnq55009381;
	Thu, 30 Oct 2025 21:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qU2Ff
	vP1Ti4yCWDwM2u8rZpUpBIvl6IiYrgpaAHbcZk=; b=KRTX4m5ZFF2E60w9nIJv/
	sRLx73EhOgrMdDRUJqsiTShmeGJz83OFlCq9q6L/pAtgY64f6E6grz1l8SZNlbEg
	Y+El9lutboolds9B/gI93IjpkdwM+iaIfUcaEWKuadZXME3iBERR+Vk1xl1AguNA
	nJbRjOxMh2HUSIn0fBo/OKpVoDwWkER+1q2Qqge7al2MnCEzxL0IzP353rvFXVk1
	YsvzVOnJNQ13+T9vei5wwwfbNk7UlB580CGoMxVvcUHBr51GL/Nu0sDBeFQG/BXb
	JPu4kSvGKaJHGoE4Fc99KKi3C2BR7L3tVZH5ZMGAh1gNo+jagSiZavJlzkUGF+p3
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4f5m01v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJqO2V034017;
	Thu, 30 Oct 2025 21:07:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edwy0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59UL70pS007669;
	Thu, 30 Oct 2025 21:07:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a34edwxup-2;
	Thu, 30 Oct 2025 21:07:03 +0000
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
Subject: [PATCH v2 1/2] bpftool: Print map ID upon creation and support JSON output
Date: Thu, 30 Oct 2025 14:06:52 -0700
Message-ID: <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9I3JoP73uloj8K6HlqIaYTP2tz_FzwUM
X-Proofpoint-GUID: 9I3JoP73uloj8K6HlqIaYTP2tz_FzwUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE3MSBTYWx0ZWRfX5aOZF9aequ8z
 SJ7iVtxgJLp8/aF1W7OGwBZr9IdDnpF1cWC1Zh5PiQH+Cgx3UleOPqQeT7DPrJX/joO1uEez5/p
 olp3yg6l8S1Asgpj8zn24n2Kr29Ekjg+awqf+a0P36SviGbbHi7ti71Cmx0uvRqw3Bd7tjfAY73
 RnqS0OSTT9m0e3ROQBguAcOUCz79AxTauhiZ7GOmn479AxC++zLPDKczkH/8xGgSGKHzPTXRdn3
 0KiJB8wd4Kl7T3w63JcwPs9F60oothcZT1oTBRlp58RHCrUoPwX3jY9gUhvFjGlfousy7UDjolY
 wqHZevK2oSb4+RlPeGO4Vz0YEom/l5lBhargGgvhEUrJw47HtM9s2t98Cqqyrv/OBhsC0N2OuL8
 zD5gggeoMPv9gZ6ULPTsnmws9UmU96+ySMDuRCApD4/Mj3Krc/k=
X-Authority-Analysis: v=2.4 cv=DpRbOW/+ c=1 sm=1 tr=0 ts=6903d379 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=cOsdffsr8CBnL9XL-nkA:9 cc=ntf awl=host:13657

It is useful to print map ID on successful creation.

JSON case:
$ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
{"id":12}

Generic case:
$ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
Map successfully created with ID: 15

Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..80c96b33b553 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
 	LIBBPF_OPTS(bpf_map_create_opts, attr);
 	enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
 	__u32 key_size = 0, value_size = 0, max_entries = 0;
+	struct bpf_map_info map_info = {};
+	__u32 map_info_len = sizeof(map_info);
 	const char *map_name = NULL;
 	const char *pinfile;
 	int err = -1, fd;
@@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
 	}
 
 	err = do_pin_fd(fd, pinfile);
-	close(fd);
 	if (err)
-		goto exit;
+		goto close_fd;
 
-	if (json_output)
-		jsonw_null(json_wtr);
+	err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	if (err) {
+		p_err("Failed to fetch map info: %s\n", strerror(errno));
+		goto close_fd;
+	}
 
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_int_field(json_wtr, "id", map_info.id);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("Map successfully created with ID: %u\n", map_info.id);
+	}
+close_fd:
+	close(fd);
 exit:
 	if (attr.inner_map_fd > 0)
 		close(attr.inner_map_fd);
-- 
2.50.1


