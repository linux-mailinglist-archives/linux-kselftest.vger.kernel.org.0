Return-Path: <linux-kselftest+bounces-33805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9DEAC422F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639A11884FA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860418B47D;
	Mon, 26 May 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IInbJKBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C433991;
	Mon, 26 May 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272608; cv=none; b=FTUk2fZ8DbWWloIg8XZgCpo0SpnsRf03vbFOk8H2QWBG6WHV2syB/F+7xRn55kq8F3YYej9okagUF9UlRnjkS0Q8oySis5SxO6gCOCO5cMRvVTYiTszzXGVhR0V5b7QpYwNXVFfEv2a62U18CpOHhNOy1Z5GQs3MP6qCCPRHGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272608; c=relaxed/simple;
	bh=5zGyar15BAha63jrL1gRTW6pt5Nkf8aEXoiv/ujCouw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+37x79ypEoA3E669f2I49v+mnsgWn5o65FEYUlSCYKjsSkf0JuA9N6VnMCJN7awMicVuQBjjK5+BoBUDBXGStqY87Sswe/3B/8ar3sVvVjNvmWlNv9cE/ABHAl0vmNWUG3fzSAGk8gVTUMuwSsNIekovA4zdXhfHloYVlvaUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IInbJKBJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8tv0w001007;
	Mon, 26 May 2025 15:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=d0RgDuiFWdp7TccO4EmCvBzMLDBNY
	Cs6WqadtvY6liw=; b=IInbJKBJuiocOWs64zNn7Y3UWy793ds5O2ZUbdd9atpCD
	mmJM/dUegi4RUqwXQfDFFfSuvhxC9Qr7a/7PAEMisBvEwNu6tA/FvoLX/4m98WPA
	WYBcMpMxDJeY6AyEgRnLAPCrYWb22u1/hg2UV53rWR2+4+7sjduAmMVQNgeLH8V4
	y/QO21v5HY1tvuHQQUevFjswaL49+JAhOvpTV46QRRgLUd/CsgLwulhByoofVYBo
	QviAmsiHhZtdFmrwBSTYZfTHNioSMS0MVtbITFzdG6WLKgzIXsoyp3IGYep1V0uF
	pRuyRT9vfMVxr2tqQmpaHH06enRhKLRQvSwMGQRMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tshaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 15:16:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEgxKZ007367;
	Mon, 26 May 2025 15:16:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j84v5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 15:16:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54QFGctb030072;
	Mon, 26 May 2025 15:16:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4j84v5a-1;
	Mon, 26 May 2025 15:16:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH RESEND] selftests: nettest: Fix typo in log and error messages for clarity
Date: Mon, 26 May 2025 08:16:27 -0700
Message-ID: <20250526151636.1485230-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260130
X-Proofpoint-GUID: dncyt1cErtYSCGMjezJOOE15QkGDJq_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEzMCBTYWx0ZWRfXy8kYMymhMwOc /cV0E5BM6fOdKEJZvRHb3BTw3Htw9ecpY/x64W3zdaxOGqaDMdQ5BXsu0bgGbjOK/JDfreY9Avb 3XfVGzNC6qXGDeqZYB8A4NHUyUJrokli4Xbwnex3R9zcANmP0Z4ygdsqnjYcvyGTFtD2hqFWq/H
 p/kEKv8pTSfSrW4Z5azGydUVq+GLPRNvZNwZBaOeDMKMsMGhB6XGgbM5+sR7m/5pitN5xoLcdA7 7NUMqOJxEk8Br/GvEWwjiq086qKZs5nqADjUlZaiRavzPT5sa5cF/dqaOEYHeHnTHxQHGflkmza PIuRybF85QlbW4ME6DMPhX4LCqYJ45RgY8H4hQwYUPWsNWWhime4PhJT7BoPnXEfnP54T4aCtIj
 8pX5ns4ZweDLzZDWt2331JVkzih0BldqMyNigxEzYQj9UM46YZfmxSjOzo9x1LhnlGMC3Wye
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=683485d8 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=9X4DUQxQdoZdu0pZ4wIA:9
X-Proofpoint-ORIG-GUID: dncyt1cErtYSCGMjezJOOE15QkGDJq_6

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
Resending: Previous email used incorrect address for David S. Miller
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


