Return-Path: <linux-kselftest+bounces-44180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB7C14BC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83A95603FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BA330326;
	Tue, 28 Oct 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fzY7PG95"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06C32D0CE;
	Tue, 28 Oct 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656268; cv=none; b=Bi98E/5fRNcB7WfSJ9/ZkIHXjnQI/aZW/8zXGPhYJChy71MP5As2UfB5owVpeNKGpIJyrZjEjgT3T5s+YjQzCFhOJm0liL4rALe/Cjvsi5Z3vVg6df+aJChRm3BZ0iDrB2DjuGnv3lKNdwMWZDuGOpld1Qab6m8djEmQDWoWqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656268; c=relaxed/simple;
	bh=TDkhGfvbFIsuApYl7W1PbBCVLsRu1y8MNTpUcv5nRhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eS1P3HIcegyk4t9vMLGS173l0me+8JOqCeuLMUloNjx7J7y5a0QZEtqmN/fy3951Z1cU0biR3NhDjkc4LPqI5l932B7epy4IXwGJ9EAXXom/cFYaiUlNlrCTveid+zo1oDTmpUB4Vqg93yH63apntTQ7x8K/iCsPBMlOLpifbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fzY7PG95; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDfpI022540;
	Tue, 28 Oct 2025 12:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8WvFoOZGbWMBytz2CIESUyWMLaVfr
	pK/d4NX1umlAeo=; b=fzY7PG95TDMM8U9KWcpZrEZC922s3gQUMPzz2n79xAQHE
	oTAgzTtvxlBHEc4hfq2ZCR82kLcK6rQtrYkMUfk9d0OGFfO49lPpm4SFUefmmPV0
	TxvEeE5h/qiuKsq1q08alDZANQJ3weaDDaScNGVO9ag7Hd5zzDQo0Jk5jvb4KAy3
	n+HKPAoDU7U3NgocXe9eAbOkrmSFj8PU91LEz/4jUU8EBVRH8lTzviTwiaVPUcEk
	BLjdc7OZ8QKC4L/KA0I4SOhagzDIygKl/Jv6M5YNcQT2zwpfsShyVASg8Q6Mw5tQ
	shafDZTNa3Wd+1BdgNbC/1ssQHGrOneCgjZh6dE8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232uuj5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SCfc3w009121;
	Tue, 28 Oct 2025 12:57:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0fcxa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:57:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SCvCUs017359;
	Tue, 28 Oct 2025 12:57:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a0n0fcx93-1;
	Tue, 28 Oct 2025 12:57:12 +0000
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
Subject: [RFC bpf-next 0/2] Print map ID on successful creation
Date: Tue, 28 Oct 2025 05:57:01 -0700
Message-ID: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX7iMsTv2silQs
 X+9QAz61nHIfFsR2c66WP7WYMq8GKJp+rVrcDnQudU1FGAgGVKg/bJ0ZxQKwYbP+o0Vh38U77hZ
 nE6l4h5aBDHIynvBOxOADnLSHHbL+J5hkGoCswitSx+2Hr6dB+UHFOsriMD/DccOXVuWlRsHPc4
 ddemrWqovr0OAVsH8CJUaoGiGQWeLrGVK5g/tgDr9M3x6E+epj3Iiv32IXb+AUBLIOhAO+nWzhq
 cLX4aV9lbkeuBhhXpX0sogkMc3+2Ig+9ru0gXkSNFYRDvDa1VM6mDgperq3F3/tBg1aGGRUyXoH
 Q5DHpBHZcmRC18uLF+6s/HMf6QPDuBXffX8DhwLhDv1n2yZFL9cFrsPb1yQT7DVQ3LCbTZ4HiI6
 tgHx4XIY9bW09uiwIvOKua/JnyIY+XDOaIvBXoAfXi9NM90KJL4=
X-Proofpoint-GUID: l-39kVYDrBr_mk6SEUkbGeqJhJ1RbdW-
X-Proofpoint-ORIG-GUID: l-39kVYDrBr_mk6SEUkbGeqJhJ1RbdW-
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=6900bdaa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=KPTBQGuBHABK1rYve-oA:9 cc=ntf awl=host:12123

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

Regards,
Harshit

Harshit Mogalapalli (2):
  bpftool: Print map ID upon creation and support JSON output
  selftests/bpf: Add test for bpftool map ID printing

 tools/bpf/bpftool/map.c                       | 24 +++++++++++---
 .../testing/selftests/bpf/test_bpftool_map.sh | 32 +++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.50.1


