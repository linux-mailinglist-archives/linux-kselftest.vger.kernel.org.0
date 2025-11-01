Return-Path: <linux-kselftest+bounces-44612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B6C28671
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 20:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBA3BB13F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF222874F5;
	Sat,  1 Nov 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C12T8dnB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C525785A;
	Sat,  1 Nov 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025666; cv=none; b=RqwZ+kayDZWcOBsaCtt60oYcHRODE5A7p5EkKHXszY8C65E6NqeXyICrD75e89koaWV06RkuKu1m7ryZ10MKTgdR4Ax6u4RvNPJgS23vL4wXM088e6bWbxEqUiDalyhekSMg1/sMAR2TpP8HI6JJGb9VvlV9EsG+XL6KIVcBdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025666; c=relaxed/simple;
	bh=ATIB+cMOvk/elSfW7kGC67rB1pjl3bZOvnpGvx3zQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6xEBflD5e7AWQhe4RaQv+rOzk85ItSz9VOnt6K2O9QRElOWs+4L8IekK8rO3TvDs8L0RGq9YO2JaGJqVCg8ivwSDV7wbdaaisGeCXXS5ZGlhsp7SwHL0JSaRHvMHaHBsWmTlt5/7J2qWIBS4vv+B2XgfGlpntdYRfK/FlwVVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C12T8dnB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Iip8J007154;
	Sat, 1 Nov 2025 19:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8TWIh
	saRoCIE2YapklH9tx/aFi0K4z9f6m2joa7szis=; b=C12T8dnBjnsQ1T8uethsm
	BA1Plioijr2CO95gn9o3LXY5CJV3GbXit3eTzeirNyn/YYtombsWe7wUEbNo9Hqk
	7ra9mlVnI/dGvy+VUS9WIbxiM0rwbsbN5kt4VM8rZiPs/kbI43W4aGHf2VOl854q
	CfXTiaDYA9XKNULo3ChkkffRndHXCYZTN1qc318EL+GrUeZHM3bjey4PHps/nsVj
	kFCOEt6KkCzjI9VRS+8nU39hOOK+0Xl+eBHkCR+IW0A2N4pHOjB5KkfQeGiich6u
	FXSK8Ru/F5sMYOzQlX8mJSMDshZPAjcdDOIsW6RgW0/tiMRbyXoSJ3ccYlUgD8vj
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qre01ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1HaBd1021076;
	Sat, 1 Nov 2025 19:34:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6s25p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1JY0Gi007914;
	Sat, 1 Nov 2025 19:34:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6s24r-2;
	Sat, 01 Nov 2025 19:34:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: bpf@vger.kernel.org
Cc: alan.maguire@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/2] bpftool: Print map ID upon creation and support JSON output
Date: Sat,  1 Nov 2025 12:33:54 -0700
Message-ID: <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: Eq8QbOvO5rNNgnfVg8gKNZ52jdWld5L5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2MSBTYWx0ZWRfX/+JkroJITk1d
 9uoLprI+lse2M5ghqbO47URBPQqi0yenLbLd9edVSpvSPDysodHa4gBjNO0ENmp5w4R0ysyqxqR
 SsVv1fMcBGtw3tOjiRxFsiGK3/ta3e3tlF7HjKYUCN1VEUDvDqBEUV9Ic1RhqvncM9MrVnIwLIj
 yjnG7slArfLcAiSYzlmb5sPzAjfKo8J+bQVcjSh+dW+i+7wxaj0VfDdlX5+THH1rPAl5o+rP410
 7XWYyB10recwPor1sgAgz+p5HLLXBKBmjK10GUF7dgiSJj74RkdNUgFM0OpLeCXUlp9vr3IAKZx
 97fbttkcspRhFS2+Wn7acD0ILwtaZ1jemEDZBOqOWGj3wnw7MZrHROrzFhzlVFL4ok6YHBGXO/G
 Wx0+tCN3yVnagqRT1PT50oaxz8do8Q==
X-Proofpoint-GUID: Eq8QbOvO5rNNgnfVg8gKNZ52jdWld5L5
X-Authority-Analysis: v=2.4 cv=AMtU3n5w c=1 sm=1 tr=0 ts=690660ac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=cOsdffsr8CBnL9XL-nkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

It is useful to print map ID on successful creation.

JSON case:
$ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
{"id":12}

Generic case:
$ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
Map successfully created with ID: 15

Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
---
 tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..f32ae5476d76 100644
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
+		p_err("Failed to fetch map info: %s", strerror(errno));
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


