Return-Path: <linux-kselftest+bounces-33799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B55AC41B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E093BA176
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421A212B18;
	Mon, 26 May 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sTqS0WMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AB211A2A;
	Mon, 26 May 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270869; cv=none; b=UgawEyB9L2gqqFWXWPGO9tuCOmaEG4CnfJFIzyDMUZkpCwVhPvg/Gn/9gph4fKesRanEDBZhr/PqY8YJqbqHFmbdm3roM/Wi8j1jflcILYWv/lxUYKkDXe6dZp1r2AkB5H7x7kSgFAEavJxYhVitkZBYTCILrrJnw8Z6yIwZjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270869; c=relaxed/simple;
	bh=/d2q2+ybdDcoWjDhaEyMP/HPI7aeq2l6SVEQGCr9WPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6WEty1ea6ml55V5yYt61NQrJc+nm+iIiFlrGe8RbhlHDueHpG2MyP8YGFrucG3RlTD6FYBoHV7ruorUp219KTmT+A5UNDF/oMDXIm1xiTnuwx+PjKQ+zsda7onp1v8HHVnPFmYxWUTpfLQ3wanjQoRG0WmJQKgqtrwK7Wj2unU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sTqS0WMZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8uIGP010994;
	Mon, 26 May 2025 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=bRX6T2Oi34tK2U3V0BzEFIzB+sbVD
	fg9vFDZDCWgZF4=; b=sTqS0WMZPGA+VIBufhgmjyeKH1T7Rl6LBxSzeo4hVpP/T
	uV+20Sqw2LSfCsPz/Ev1MTVVJsRqdgVkZsueYP8RZSm/AMx1SN9xUUEyxyg1TvFy
	0YgTq1bcLiFszkmBjVCuKKmELoPolmH6fdKZ/wk9MjEZJsetArC+QpFr5DEBKZb1
	0b6qoN6AlfmqZLXq3n6LN7gzzFBPXvRDopvv8J8DtbFSFhlN90SgIZ1OeNOL9xr6
	3ZXiq3uu6kGmZckssR418gSrfD1xc7CEiWnXDa/tThuYvHfjZz56m+7hLQMcgM4c
	7OO2/gIFfC7HU7buK9O52WTN2PsvKQl6wMSuP35Uw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s1h7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:47:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDdofU023148;
	Mon, 26 May 2025 14:47:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7v79k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:47:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54QElcYl040639;
	Mon, 26 May 2025 14:47:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4j7v798-1;
	Mon, 26 May 2025 14:47:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: davem@davemloft.ne, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] selftests: nettest: Fix typo in log and error messages for clarity
Date: Mon, 26 May 2025 07:47:23 -0700
Message-ID: <20250526144735.1484545-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNSBTYWx0ZWRfX/X1Y375yFHtZ 7qEGdMClqKYznAALervWyVBZ1rR4j/Q8Lb4Z0KhjJJNAeuieQh7hbgM7YwcifqLBKgFLuRqFH6d LdXatHZihcLF8ZKkum3wOj1phsBnod92+7M31GGpeZE8AfE6ba4dERjWxbT3l9shJOj6SBUZIQ1
 xmtTwLnE+GjwM/FP8r8XozHTYS9OGs1cmioQrUzGjMDLOt/swcXQ1Cg9r3JaKP1OtzFu5v9YqJo VbbxzJRVbFbMx9ecHz106Kg4v61H46UXLkeq8TFJ+Mm6YUEDhs95rssvH7bxUyPi7yy9yfeQ+1Q HYRjDHGkT9oLm4ZVEm4edseJMvpa7XialhNwYq7tQDebaLIQQSE8Xo47/INookM7gdi/pjhsrh3
 3OFPosKAhMTMUiROq5rBg8KQEeYu0kF7WSVJ/HdDT+ZIEBlAoiUo9Iy+sxjtAg3R9QMVnonn
X-Proofpoint-GUID: x5SUmlykWc0y0ZPffVdlABWz48YVD9FB
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68347f0b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=9X4DUQxQdoZdu0pZ4wIA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: x5SUmlykWc0y0ZPffVdlABWz48YVD9FB

This patch corrects several logging and error message typos in nettest.c:
- Corrects function name in log messages "setsockopt" -> "getsockopt".
- Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
- Replaces misleading error text ("Invalid port") with the correct
  description ("Invalid prefix length").
- remove Redundant wording like "status from status" and clarifies
  context in IPC error messages.

These changes improve readability and aid in debugging test output.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 tools/testing/selftests/net/nettest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index cd8a58097448..250189309e69 100644
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


