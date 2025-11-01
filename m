Return-Path: <linux-kselftest+bounces-44614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B7C28686
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 20:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D47D421A61
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20505298CB7;
	Sat,  1 Nov 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ir6BRqpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73526296BB7;
	Sat,  1 Nov 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025671; cv=none; b=sgvlBfxzakDgKevkTREbbSzxiUUi6Vnm43HUXF35NXlr2BxsKu0IaUdbqLNmqoOnVX7x1Niw5WUvjXpoV7IRiRpxBtTmjKx7gOdLuqQwWS4LA3QMCp2g8r0WVjh3k6/H3vrSHAkoJDUTD8TqnOjJ2GlRK1KIwCdxv82qs+nRo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025671; c=relaxed/simple;
	bh=9q6vCz/5bPhsdaBKqGHSicsAwhDjoOHGYrh2mAOw+kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAJpqG/SSMmZjTC/etb9JD6lRP8K7CZAF8LIrNEfivGMUuejpZnzRST94dEArLudpFAb0sLZ59PKYXZnApr4pNawgrBlLfnXVAeJkx9GpFUMwOEcNLFtFw+H5N83bKMujWbkZScpwdseBUZw9X1HG1fyedEe1v+eu+uWKGhFjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ir6BRqpi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1JVhov006631;
	Sat, 1 Nov 2025 19:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Dc9F5frfU26RSb9GNsKNqcQjAhpyN
	/KoW+lW1Wj6Lxc=; b=Ir6BRqpifKKQeZJ+jhWM0gqsTcMMsgo1MQvR0bRqbdzsE
	sbqxpdmz9roydbF+OM/OkbBCWOhmqE1k892SX7zoAsmPqie9IT/tq8NCkyDaACMp
	59dOmTeEZsc3YbAQljU7Pq40iszUEaDgHGm4Bgjt0G5wlaak93RXulgpQ96sLUj7
	ArItluvLCPNL9LAkSgV9fxz+rxNFWyYNUwyC3rI5XabO+/yFTVZpz/ASVB9xFLEg
	x3r5R90sR4j6pVPKNVZqgg73VGIfCM/AvdwwaX5nvyoltJk0rzQn6+K/VWpIWMn/
	Ae6aeae0gJwiei40GilxnScDE4NGTLrIHwkb/5XHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5rdgr023-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1HhnGD020948;
	Sat, 1 Nov 2025 19:34:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6s24y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:34:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1JY0Gg007914;
	Sat, 1 Nov 2025 19:34:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6s24r-1;
	Sat, 01 Nov 2025 19:34:00 +0000
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
Subject: [PATCH v3 0/2] Print map ID on successful creation
Date: Sat,  1 Nov 2025 12:33:53 -0700
Message-ID: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-11-01_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010168
X-Proofpoint-GUID: l-wTHLNXJ9g4ByYukzg-xBHhiJzgJx2y
X-Proofpoint-ORIG-GUID: l-wTHLNXJ9g4ByYukzg-xBHhiJzgJx2y
X-Authority-Analysis: v=2.4 cv=DoJbOW/+ c=1 sm=1 tr=0 ts=690660aa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=a9B3Gpd4lODhp7-wpV4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2OCBTYWx0ZWRfX4gvUmblxf5Y1
 HaItr4o4bHjD6FB7ZLnOpG/nScdfzfotA0VdLrZmR/lwHyD0cP7CTUQeH+ztB6zhWPYlQfp1VvT
 rYZfuktF7x1z22E5JsiS8rtxRkeMF99KiCG5IF7Y0rXoR4Xa44yQjz81W4ogjDkSI+KNPwrA2sV
 ZO5nH9JwhwZbWz0LuJ5dZVErsDecCDqURu7v2jpJO5Gkd9JYfOnoIt6hfR3j8TWfZwo/OeI+oQI
 K3y9KdmgSU1lw2BkGvLr9jzzO7mN3F83ha/mnkxWVzCSoeW9V+8fViFDda3ZdkNzRetQ3KtbU/G
 c7Zgx2eLn6W83vfofbw/eJJG3qA3VrxF/tvpRpHb47Bz+eTumV5wATcPGf/8mTTz37tF8R1kDRc
 GKpVieuREuh/99B+8xIlHDQKrDKjFQ==

Hi all,

I have tried looking at an issue from the bpftool repository:
https://github.com/libbpf/bpftool/issues/121 and this patch series
tries to add that enhancement.

Summary: Currently when a map creation is successful there is no message
on the terminal, printing IDs on successful creation of maps can help
notify the user and can be used in CI/CD.

The first patch adds the logic for printing and the second patch adds a
simple selftest for the same.

Thank you very much.

V1 --> V2: PATCH 1 updated [Thanks Yonghong for suggesting better way of
error handling with a new label for close(fd); instead of calling
multiple times]

V2 --> V3: Thanks to Quentin.
	PATCH1: drop \n in p_err statement
	PATCH2: Remove messages in cases of successful ID printing. Also
	remove message with a "FAIL:" prefix to make it more consistent.

Regards,
Harshit


Harshit Mogalapalli (2):
  bpftool: Print map ID upon creation and support JSON output
  selftests/bpf: Add test for bpftool map ID printing

 tools/bpf/bpftool/map.c                       | 21 +++++++++---
 .../testing/selftests/bpf/test_bpftool_map.sh | 32 +++++++++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.50.1


