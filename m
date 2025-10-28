Return-Path: <linux-kselftest+bounces-44179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BAC14B9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129431B23713
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41239330300;
	Tue, 28 Oct 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hD0BYqaB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BA32D0CE;
	Tue, 28 Oct 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656261; cv=none; b=pfo8LsqpI5PyRThojGPJP60Wc+yXo/vGbeBEa/K98WktoMFYsh5UK/88zJyx1iRcTYDb7aqdLj22nZcbeITjnWSe6ci/cGdywLUhLQllbw0a+jbeUzbxsrvIYSIBk06XtTyDkHAiZ4bZYe743jn3BqIDJX8oe89Me/H45DZhmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656261; c=relaxed/simple;
	bh=gsmcNbNURitO6q56ccvvEmt+1Z4kuwmFkP4C51xT8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iovgt9BWX+0gWpw1quGKRmHMf0KEjRV9Mrc/vZc0L1IL1fJHoknrENsVZpxYo6MJaCl5KBldUMSoT1qWOq/F9FUMluvRtNtazvy7vyhowSQQElkPlDabntrtJsuIFoNMcvvx+84tnGvBq/QO25hnT2w5Ho9AfYuvWSfzfAaDtag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hD0BYqaB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDkSA000814;
	Tue, 28 Oct 2025 12:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mb/y7
	FEzNycOvYSrVsJVWjpIYgTXGaDeMrsO3utUP3M=; b=hD0BYqaB77LyEYRQLIeYF
	w0fW88Pi0yMkSZ38VcW5LMBoDV2P+sdPbQcWwFKWMKFfAndF/78GOBq8/KIXYzSV
	gTASHyZNf+XUogIIis4q6OTvGSlPM/at24vCaFxtAqhGDUKJgXbVo9Xz24iIyIuI
	AmbcezzuqjYmh6ufRfBiAl6NQq7jONGPcICDnXUGWty0SBkETGOtbWD3DgmT45sR
	l88KCgQ2Xx9zzI2BLCmTMPlp2EhFyCgZVrvAm5TYF2ianjLHyFOkzvOHVszfWmmi
	dDhACaGh1WZkPIZApC6rxHv8MSZ18q30ou7ZCnq3NOjbEuvZX+/oIJL6Q8IlCbC4
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22x6ucyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SAjHie009317;
	Tue, 28 Oct 2025 12:57:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0fcxbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SCvCUu017359;
	Tue, 28 Oct 2025 12:57:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a0n0fcx93-2;
	Tue, 28 Oct 2025 12:57:15 +0000
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
Subject: [RFC bpf-next 1/2] bpftool: Print map ID upon creation and support JSON output
Date: Tue, 28 Oct 2025 05:57:02 -0700
Message-ID: <20251028125705.3586552-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX95N11HEns04B
 6NodjEh95VpK1iGQtPc3zVFacGMl7PVwZd2hoBnhymrqnTXU5RHhdLLuYcU019SZhrwMdzNN/x5
 MBJTvAaDOvs2uoVFtAJJTwl42dowXFF9K0KRcGaXqAOnvIXXzWXqYJXbWMINP+st8fvm0IfrUSc
 DGv/PDwVXgZMCzD/9Gk4P+NSyQau9t5cofMOZWPCtp7hFERdE6PFD/fo5/697wbgpSYmkhJj/0S
 82oCzacXXvep04bsHSEXQad2P3S6e55IxRlUAJ0NPohP+SQ07wMe1iIQXmBCSq5dbh+MED2TVeR
 rH9JZvsyRczvAt5PzarOhcON4PqVKrexB5kS+4TdvQCBpDBNTcMNfecA9fyQXvJhlk0aLqs03lQ
 WZQWRs4NLYNKoLCWtmyRNxbRc5Zjf0fSmfORM5IQoSdD3+ZRkpo=
X-Proofpoint-GUID: CYzt4iSB5hcuy8UoTZtI9zKVjbTQXwXq
X-Proofpoint-ORIG-GUID: CYzt4iSB5hcuy8UoTZtI9zKVjbTQXwXq
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6900bdad b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=Al0WAx8ni899RPj6ES4A:9 cc=ntf awl=host:12123

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
 tools/bpf/bpftool/map.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..b6580f25361d 100644
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
@@ -1353,13 +1355,27 @@ static int do_create(int argc, char **argv)
 	}
 
 	err = do_pin_fd(fd, pinfile);
-	close(fd);
-	if (err)
+	if (err) {
+		close(fd);
 		goto exit;
+	}
 
-	if (json_output)
-		jsonw_null(json_wtr);
+	err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	if (err) {
+		p_err("Failed to fetch map info: %s\n", strerror(errno));
+		close(fd);
+		goto exit;
+	}
 
+	close(fd);
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_int_field(json_wtr, "id", map_info.id);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("Map successfully created with ID: %u\n", map_info.id);
+	}
 exit:
 	if (attr.inner_map_fd > 0)
 		close(attr.inner_map_fd);
-- 
2.50.1


