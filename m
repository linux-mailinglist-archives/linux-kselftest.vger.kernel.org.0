Return-Path: <linux-kselftest+bounces-35022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F3ADA154
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2647170514
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98218262FF9;
	Sun, 15 Jun 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFN6H3KJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564A1BC3F;
	Sun, 15 Jun 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977330; cv=none; b=g7Wo0VpCAlwKolGcDUpwWKUIU1aipOnK2nxqEFZdi7J1bRHtAmKOfAlF+unLFasunGyeQdgr4xX184VISdhwnuvMALgO3TN2d7ee7TN7Q3yhR7oWL6LMCreI5+O+RTA2dyt22zRTEA0XHvlfSM1bpvN6sAurfiQcfqAPQcPaCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977330; c=relaxed/simple;
	bh=/COxccsWVBzdJxzmwc97AIX8XiROPX0ALkZZ4v+t7Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgGEV45vaZXVS2wQzrieRuGXrj2NtalHnGaFDK1OVNWvVjaHzbA0YmPrFeT5cge0JJaYWae7pVYCARSY5uVX3mcdGtRJhtRgDjZIAXEl7APgTk0UKtJE6MXVntPJStGjPhBZ2KvZ155LByz+SvoNmg7hSpzB1Y5XO0QBnb2AVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFN6H3KJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55F6XYvn013505;
	Sun, 15 Jun 2025 08:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kRzPo9BfSat22K7EbkWSZRQfJUqlD
	XqFsAlOoFuVsCw=; b=bFN6H3KJ99V6oOIHV19vYf9FC9OaG3MVbhs0pSwAdUiKN
	yrQAADFA3cmD5LFN4qW4pGo2GcISmhYxQbssOdIL9Zhkz8/CtmP6EozWToYx4197
	5OVuhjARvzIC9mtRqhJMwii+iqUlRBSJwSGGRxjJAgPmVMyifIkgxZGmpcDaTXCJ
	gEFaPfuR2/CjuF4p2RE46pqF0AlG9FXsjLcp7zWyuwoSgzW93X4e9Hi6Zt35ra7N
	Irj/AHgWh6kGBmMg62fQw8GSoa8bM/sqhuqq/WutIb+ulh2Vw2+hIw4WJWNpRVfh
	zLAolb/S3JdWqv4B3rX5o3AvDobZf1WNPG862AeVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd103e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 08:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55F60Dar032783;
	Sun, 15 Jun 2025 08:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6y6vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 08:48:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55F8mR6i022800;
	Sun, 15 Jun 2025 08:48:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6y6vk-1;
	Sun, 15 Jun 2025 08:48:27 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v2] selftests: nettest: Fix typo in log and error messages for clarity
Date: Sun, 15 Jun 2025 01:48:12 -0700
Message-ID: <20250615084822.1344759-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506150064
X-Proofpoint-GUID: GHNco0k6xPDRIbBuknuglYQ0WW3FzgH-
X-Proofpoint-ORIG-GUID: GHNco0k6xPDRIbBuknuglYQ0WW3FzgH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDA2NCBTYWx0ZWRfX1xyvzJ3qW1xD g2Xqldec6ulzmy7IJU9yMZQisoCGubtYrVuB2mGKyRE9ER/AYZx+C3cQDSL1F0G6lq1zd7FpUda gBxUsRNZm0PED7B+mj7593EYx17S4S8y2koSplIdHVdBiaKhGTnks/AIt0+6+n0eUApZCiljsGZ
 av9f2pmoHyOnYLT7gzX2gowYp8zhXipTFL4EYu5IENWKSB1/Z9D/V77F8e74c4uh16HGNRsY8O4 3gmxjwGxxKLGnkP9hflQ/Hf1+lZ2Lza/FxQW+/3YrGsxQ28L/Nqb5D+0yGx4Hxb/0APl+Hy0+q+ ZtkrVGmbYqRsec5DbRrhM3LPnHZQBQuaID5XHLwU9YhIIuo7rQrjeWLbed4lsxIE44vx29z6s4n
 81mSQkEStMyn0T436Ft7fgyNvvh8oASQ8pMTNUIxp8GX9XZbPd+c9AiBkqrpYrJI0IxBrC7l
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=684e88dd b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=yiuC5uV9oDzSQypOcXUA:9

This patch corrects several logging and error message in nettest.c:
- Corrects function name in log messages "setsockopt" -> "getsockopt".
- Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
- Replaces misleading error text ("Invalid port") with the correct
  description ("Invalid prefix length").
- remove Redundant wording like "status from status" and clarifies
  context in IPC error messages.

These changes improve readability and aid in debugging test output.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 ->v2
remove extra space
---
 tools/testing/selftests/net/nettest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index cd8a58097448..1f5227f3d64d 100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -385,7 +385,7 @@ static int get_bind_to_device(int sd, char *name, size_t len)
 	name[0] = '\0';
 	rc = getsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, name, &optlen);
 	if (rc < 0)
-		log_err_errno("setsockopt(SO_BINDTODEVICE)");
+		log_err_errno("getsockopt(SO_BINDTODEVICE)");
 
 	return rc;
 }
@@ -535,7 +535,7 @@ static int set_freebind(int sd, int version)
 		break;
 	case AF_INET6:
 		if (setsockopt(sd, SOL_IPV6, IPV6_FREEBIND, &one, sizeof(one))) {
-			log_err_errno("setsockopt(IPV6_FREEBIND");
+			log_err_errno("setsockopt(IPV6_FREEBIND)");
 			rc = -1;
 		}
 		break;
@@ -812,7 +812,7 @@ static int convert_addr(struct sock_args *args, const char *_str,
 			sep++;
 			if (str_to_uint(sep, 1, pfx_len_max,
 					&args->prefix_len) != 0) {
-				fprintf(stderr, "Invalid port\n");
+				fprintf(stderr, "Invalid prefix length\n");
 				return 1;
 			}
 		} else {
@@ -1272,7 +1272,7 @@ static int msg_loop(int client, int sd, void *addr, socklen_t alen,
 		}
 	}
 
-	nfds = interactive ? MAX(fileno(stdin), sd)  + 1 : sd + 1;
+	nfds = interactive ? MAX(fileno(stdin), sd) + 1 : sd + 1;
 	while (1) {
 		FD_ZERO(&rfds);
 		FD_SET(sd, &rfds);
@@ -1492,7 +1492,7 @@ static int lsock_init(struct sock_args *args)
 	sd = socket(args->version, args->type, args->protocol);
 	if (sd < 0) {
 		log_err_errno("Error opening socket");
-		return  -1;
+		return -1;
 	}
 
 	if (set_reuseaddr(sd) != 0)
@@ -1912,7 +1912,7 @@ static int ipc_parent(int cpid, int fd, struct sock_args *args)
 	 * waiting to be told when to continue
 	 */
 	if (read(fd, &buf, sizeof(buf)) <= 0) {
-		log_err_errno("Failed to read IPC status from status");
+		log_err_errno("Failed to read IPC status from pipe");
 		return 1;
 	}
 	if (!buf) {
-- 
2.47.1


