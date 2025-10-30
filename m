Return-Path: <linux-kselftest+bounces-44454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35892C225FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E79F3B41BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABA334C10;
	Thu, 30 Oct 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZGmfUq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61932E13F;
	Thu, 30 Oct 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858444; cv=none; b=J7OmAAUmOy4VQeNn3EDOYXgaT5HcAC1KFGBw1I3EO+LTZRZRLPywOSlG6FeJ0hb2hA97FMyGSqLnwFfrTHhnD3VbRpQCBHGpHbR157MY5SJF6kg3/0D+d+NnyNt3kVjseco1yXBN1bTANeFCVvDvfOaUjQERIF7LkbJqIOwBC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858444; c=relaxed/simple;
	bh=kT2dgaMgSaNxLq5KdqDZBsjB8CFnLTznotuXsPb0j3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=No1PAQGX25bvBZww0YdBZ5pP0uu7Xlvt/AedSyjIUF4dATcXtJxQ2jh8oTAOTIM7YL+N0yAfJ2O6t0jCOc+yr9LX7dZWa31WsSOy6Az/IOhC53/3UHEWbGGkVNUuelli/EN5ZVY1GIBXztFjooLgk8qUWFVn6X8H3Ja1xxWSWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZGmfUq3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKV1G8014541;
	Thu, 30 Oct 2025 21:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=s8y53QO3VsXFNJp9v5+fXBd9E/DV9
	ru5dgyq02ZxPGs=; b=AZGmfUq3D5DxC8CZlQP+cm+QSfyNX/WEba1npYoFk2UIm
	F0brJuWhgC8g9ycKq3WDHJJ9hzMu5lWDa6fy4zc52A23frnepM/lwBhjTmcZ7Dhc
	RpzFSjR/petKUUkQfNOdJOz9bWZPzcmTuaBRbB6PefuprfBQ7HX9sXUoUg+ZOLls
	P+enzDN2nyFLNY1ilFb3Qf5MxzzSpjQkrgiAVNJOoPjlSiSTb6Ln8JyRzskuOKfi
	7QFwuSMh4qQ44ix/JLqGAHMmT4Cy/drZZZx1bUP+uy8SV9Jb3ACCZzbrn8397lkI
	QqKI2CTtlLokK15xx8YExEP6RHl/CJP2WergZBBBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4dsfr8sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UK4Ixd034169;
	Thu, 30 Oct 2025 21:07:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edwxwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:07:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59UL70pQ007669;
	Thu, 30 Oct 2025 21:07:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a34edwxup-1;
	Thu, 30 Oct 2025 21:07:00 +0000
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
Subject: [PATCH v2 0/2] Print map ID on successful creation
Date: Thu, 30 Oct 2025 14:06:51 -0700
Message-ID: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1OSBTYWx0ZWRfXzAvVDrnvvaPP
 s6KGVwd5RYAygoqd2/epSJpXTHPD68HWJUiTzKJvGaxpUC2yRSRRBqAWc4JkOinBJJxiepUnvQD
 XOqzW+TB/paLYyT0rKm5oTZ8Y/rb86Asnt+6W1HH8VTZGwTv/ffe4NZ3D/AyhAaSkqfW1zrRHjd
 yIhxJ7qo165YE2brMiaeAiNu2TFMFOiBXzgZQVJrSFW4cnm+iL1ODUOSmicI3ulAqiCB8sLEbBg
 fxzfXiad1X/pNwfgSrv+iY7LtZUbjvWGiKJidsCr9Nt3hXDiD32fmq/VXQJzAhylLg922UiMPoR
 VC6WQrXGFmSALO7n1V5EF39UrnXzXRbX7gsbjUUGkhEwDGfb+GJEudeOB4SdvwB3mlr0KgPulvn
 MjJ4LSr7DBeLVHQvfgt7lMJO/NxVIvAf6Be+cTkxFsMpECDQv+A=
X-Proofpoint-GUID: NNl9NYJeWuKSsPTo0Oqx8DZFXRERJaUx
X-Authority-Analysis: v=2.4 cv=P803RyAu c=1 sm=1 tr=0 ts=6903d376 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=RiccOCReYIhFNcxSR9kA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: NNl9NYJeWuKSsPTo0Oqx8DZFXRERJaUx

Hi all,

I have tried looking at an issue from the bpftool repository:
https://github.com/libbpf/bpftool/issues/121 and this RFC tries to add
that enhancement.

Summary: Currently when a map creation is successful there is no message
on the terminal, printing IDs on successful creation of maps can help
notify the user and can be used in CI/CD.

The first patch adds the logic for printing and the second patch adds a
simple selftest for the same.

The github issue is not fully solved with these two patches, as there
are other bpf objects that might need similar additions. Would
appreciate any inputs on this.

Thank you very much.

V1 --> V2: PATCH 1 updated [Thanks Yonghong for suggesting better way of
error handling with a new label for close(fd); instead of calling
multiple times]

Regards,
Harshit

Harshit Mogalapalli (2):
  bpftool: Print map ID upon creation and support JSON output
  selftests/bpf: Add test for bpftool map ID printing

 tools/bpf/bpftool/map.c                       | 21 ++++++++---
 .../testing/selftests/bpf/test_bpftool_map.sh | 36 +++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.50.1


