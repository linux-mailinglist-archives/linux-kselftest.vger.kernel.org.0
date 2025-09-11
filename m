Return-Path: <linux-kselftest+bounces-41259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADF6B53ABD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AACA5867B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BD35FC30;
	Thu, 11 Sep 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJN2yrJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280841A8F;
	Thu, 11 Sep 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613147; cv=none; b=PzRSWdse6doLSbUYuYQp/lzDZCbcqXvg88xaoxqORasMRxZltDq5S7UvrscYDRJ28OV15BLZlYmv2cd0YPz/X6Raxq12eHR72Sp56up6A4KZ9v6/cuMsPTmOGtkTBWIRre2ew/eJx+YCPmKO9OQhYfLhDHaEZ20FUAAvbxxOypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613147; c=relaxed/simple;
	bh=yiVzhP66FRxZjaT0DhCT6bNf9GogM28b2uxcetaShLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwWC7CYRBSz+fyAbFuwbgOuT4e5ijAbLzoaV3d2JzFKlxT/ce/pk3RbTS9ZrFiho4N3haLyQ0q0WrAsTT63k7n+MiI/rHw1K6vMSsxPvEaCggZXD0SbAnmgOQX+w6CRwd2S/YcL2BQfR7mEXyqrY1OmRFmqnSrqGLAVORyVJy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJN2yrJK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBnab018888;
	Thu, 11 Sep 2025 17:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=qUgCNSGgO46u8u1CFIfEJHqcT1J2v
	v/TFx+uniOQs44=; b=bJN2yrJK5NM1TQWU1Vl7psuKSzgDFuTVNl14RRh9q0IOs
	7Aukazw3JJcngMMM4F6+NTJOAIWe6zxyvtYr4j19SkIRrfExehIkqXQfWkx27TF3
	VLIBDRlzd0akN/Tf03JCLXCBVmForxPDKvr8kz0ZQG6H4wVvpMK/nBDmleuOJfpS
	qlhc9yV7FfxoRU+eYUYm5No+16UGfA9Wj5j4lKyBDJxxEcdWtl/hPC/DX1ec9QSC
	FJni+SoAVA+833FwWSpo6JZaSqqtMMh/iv/cfIIF3gBYfgWksRmbk55ejpTIRKj4
	6OPWknJFpmoWslQUNWoTBHrSzvTr8RlEBUHjtfu3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgxtdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:52:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHhopB032942;
	Thu, 11 Sep 2025 17:52:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddracw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:52:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58BHqHCX031675;
	Thu, 11 Sep 2025 17:52:17 GMT
Received: from thromatk-ol10.osdevelopmeniad.oraclevcn.com (thromatk-ol10.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bddraaw-1;
	Thu, 11 Sep 2025 17:52:17 +0000
From: Tom Hromatka <tom.hromatka@oracle.com>
To: tom.hromatka@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, corbet@lwn.net,
        shuah@kernel.org, brauner@kernel.org
Subject: [PATCH v2 0/1] seccomp: Add SECCOMP_CLONE_FILTER operation
Date: Thu, 11 Sep 2025 17:50:32 +0000
Message-ID: <20250911175215.147938-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=822 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110159
X-Proofpoint-ORIG-GUID: MM7ADpIb2R4unnZt9tAtArrh_GLDmXXs
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c30c52 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=54fhvZ_YZLLdI873iscA:9
X-Proofpoint-GUID: MM7ADpIb2R4unnZt9tAtArrh_GLDmXXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX7itMZsPA++FU
 BCXTTO/xnzNLuYuu9jMt/WYKFpGDZ+AMMMTVIUdxIQl7WEWUbBk0lbFfnFF3HlhoDZV2tvsnJPI
 iDpO46qdRlWudvBNWbndwW/KBusIPjlpO76eMYbnSZVu8DjwvybhcsChW2ywcbanEbX04cAzW6T
 otBrCB7ns096rtKUizmgDFLp1To9knWMcIaCIzX+O/fqPUcxa/FMzrte9I7nS8+75mnXpPcqo6b
 9dlT6VbICDebxmL5f8iE+vkWY6ijvvJK3Icb0e2z8anv8GJN+eV5ucX+SJRXGsuYYn0f1Dx3lI+
 Uh+IazzU+7NuVGis5Okg1riS9Oc11JlQP7NP4KRLqzsWLaNmZqqKm1R7lLLw/pHkCimmk5v7lG+
 Xqpfvvq5

Add an operation, SECCOMP_CLONE_FILTER, that can copy the seccomp
filters from another process to the current process.

Changes from v1 to v2:
* Fixed locking issues.  Thanks Al, Alexei, and Kees :)
* Allow filters to be cloned if CAP_SYS_ADMIN or no new privs
  is set
  * I initially had only CAP_SYS_ADMIN, but I can't think of a
    way no new privs is harmful here, so I added it. Thanks, Kees
* Switch to passing in pidfd directly rather than a pointer to a
  pidfd
  * This more closely aligns with other pidfd syscalls
* Fixed warning in the sample code reported by the test robot
* Various cleanups and improvements in the selftest

Note that I left in the restriction that the target process
has no seccomp filters already loaded.  I could see this
limitation being removed in a later patchset, but there are
requests for this feature at present.

Finally, I re-ran the performance numbers and updated the patch
with the latest numbers.  The locking changes significantly sped
up the clone operation, and it's now ~1900x faster than the
current method.

Tom Hromatka (1):
  seccomp: Add SECCOMP_CLONE_FILTER operation

 .../userspace-api/seccomp_filter.rst          |  10 ++
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              |  48 ++++++
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   2 +-
 samples/seccomp/clone-filter.c                | 150 ++++++++++++++++++
 tools/include/uapi/linux/seccomp.h            |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 114 +++++++++++++
 8 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 samples/seccomp/clone-filter.c

-- 
2.47.3


