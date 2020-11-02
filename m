Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7C2A256B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKBHkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 02:40:25 -0500
Received: from mail-eopbgr70100.outbound.protection.outlook.com ([40.107.7.100]:58958
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbgKBHkZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 02:40:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAi+EWJASt1aBkKzskBkgkYbsQz+1GeWQI1i2Y9mp7JywDqUjCkLO54d9V+dBkmjLbHJoMqmt4ZbifRMwWatx2v3CRbV1z6Uo23JWCxAe5Xnf7DaZJWJ+65ADBsUZmObtASH7gkkpK14Vi6A0P+bUDESL4tDQeiMM5Uh7C5Rct79T8Zdrri5KoTNmiwHxeX/HcU6rvA3/15w2iy5lSHeLgN0UsEnhq1joh5L3h7RymprVbMlJ5O1Q0KDsfkKJPrKhYDpxZg/sMGSNvmGBL6/eO4aYGQNIkVf0xuOL80j0DXMNtYJNEqHnRPnWFt9viBHyMYlZmTaCIHDZ0vP+iQ1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv+ikban164/cTUTdPWnsywOInxZB3+H687f+fJKXT8=;
 b=ZPmc83UVpsKLydZnotTsnJ/rSVaNXLDPh819N3ifsA0AboCUzyFlWMibH0tIC7YrXFyCdmRDZnPj+1Yie5AyMlWkQ9Z6MZ0/czSo8yBXeGxWxp3relzzY6tF00mYzP+IRPbTgghHQsLbDK9tdiD0ty6UU6+pFK1jJhG58ByFMAHaSFTQdTmYIKo6QufO7YbGry18nMPHY+GbozPrlroN56XDCEZvD6dskleY7se9OSB4H3Q1CPLPsToizP8N4lxtcVlCQRRlK/6n5NkYHwuE3ZgC8QbGIaghfUdm/QDThNVRHcIx8sTSfoWcnEk/YqCrMy1yBBBqBHGi3cvjVcv9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv+ikban164/cTUTdPWnsywOInxZB3+H687f+fJKXT8=;
 b=jt5HvQh0pBsOEd12hJckAhd7MsiJ20X6zCIsZ48CA/KJseRtAu2ajpuJsVH0H2fS0pPFn0N3LjYqALfl6Vor35VpkbbkvMc1PG7DkJBtwFmOHrTunIGuiyyFG+wZsJkFBAJj/FgLFoEiSqMMalBHj3e30g7ZHNk8TBZycYToHI8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0702MB3769.eurprd07.prod.outlook.com (2603:10a6:7:83::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.15; Mon, 2 Nov 2020 07:40:21 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3499.029; Mon, 2 Nov 2020
 07:40:21 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: intel_pstate: ftime() is deprecated
Date:   Mon,  2 Nov 2020 09:39:18 +0200
Message-Id: <20201102073919.327395-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.2.7]
X-ClientProxiedBy: MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::31) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.7) by MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 07:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36bd0cfc-f9fc-429c-f5b6-08d87f028d61
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3769C3B3406AE5D39A8E96E0B4100@HE1PR0702MB3769.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY0pRaWRDeExK7CCrBMlwMC5iCvwespfP9gymIsKY3vgV3JMIIbhHsvJoegoQInWxwCKFO6nhJXl6Op1l8P4EKiAZihItG/ux+bodahmES8HYMiy4r/gSAuwXPXdv52BfUzDFwGHQd9MKtNnQkxJ88D4D4GYpGUTfLdtyE75vy+ruWWQ3sI5z8PyU7SU7E+s8tFVeiUV4idm5sTLw2JNK7LIIRD5EK+5QOma4c+1cSxmhzi6c7Pd20B/+93SujbEeaz7hwQTssD9rAr6isB4J13CQIOvsDtEI4JztLZW/pOcpDXQTJl1ayHINNLeriZRG02lmxIadfpG4tK136qv0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(4326008)(316002)(5660300002)(83380400001)(6916009)(6506007)(52116002)(66946007)(16526019)(26005)(103116003)(186003)(66476007)(6512007)(2906002)(66556008)(8676002)(8936002)(1076003)(36756003)(2616005)(478600001)(86362001)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NWUPsQVzqkRLeaogDTDl75Av7DbDoEQXqRQcQwUvpbT6Hj6+cfS2EF6Gv6N+ElyVQgr7o6kCmMXwkmh0VjVE0HUZ3ZuzvzEyj2pPKj9T5jKLSYOMP8DuVh4XHsmr0vtYYihR7ocKABx6atJm9iUdpcsSzVFLAOypXOVxr8EzGCzED8Zfvc52QV02xV1pk3UyJeZs6MajIy6VvOB1ngie44J2nKOgme33JIM6I7MmBstK+xYNssimW5Ozaug0nQP7q4w11zUx/7KdQk3x8SV1wVmseUwUTGYq4qrno9l7huqc0qwLQTdRErqXKigPLx/wjnjPcTJXnLHn+sTM256/eLKDxogMcXOZyRqd0ZO5qLZodOZ5g1kjPo8h1uvmqgr2VSwWjLmHGkKE+5j0U6aqk5uFYNqvqoRp9yegE16rtZgmNlSnoAOV3zmMhx7i5W5NL4l9/K0YkLF1yPKhxW67Y8L2OHi8NUhll56B+hCu0gFPijsFtCeI0dNTx0h8rLysiZQE2x7SAbsYmUP9Tf9gBNtuDCKDN1QVYNUsaxcqe/UIcx2aHjMflJUTdcmRMmkOGnpUvYXgDP+4UkmYqH4PYdqeDZhTnrgVHlCqBlMqoMmkED4RLbTk4y/hpNLQ5270LOy3cYKuM6BcC1U9K22+0g==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bd0cfc-f9fc-429c-f5b6-08d87f028d61
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 07:40:21.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIjpH5U1Yawplts0AdqFYV9KhjbjFg7DNyGhBybKf1YEU3MPiw78YfGz/Uj7bP6PaYUa0+A/6Dy4yJN+RF8fjDdyFD9yeA3PB0HjjZtu/dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3769
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use clock_gettime() instead of deprecated ftime().

  aperf.c: In function ‘main’:
  aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-declarations]
     58 |  ftime(&before);
        |  ^~~~~
  In file included from aperf.c:9:
  /usr/include/sys/timeb.h:39:12: note: declared here
     39 | extern int ftime (struct timeb *__timebuf)
        |            ^~~~~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/intel_pstate/aperf.c | 22 ++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

v2: define and use NSEC_PER_MSEC and MSEC_PER_SEC

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index f6cd03a87493..a8acf3996973 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -10,8 +10,12 @@
 #include <sched.h>
 #include <errno.h>
 #include <string.h>
+#include <time.h>
 #include "../kselftest.h"
 
+#define MSEC_PER_SEC	1000L
+#define NSEC_PER_MSEC	1000000L
+
 void usage(char *name) {
 	printf ("Usage: %s cpunum\n", name);
 }
@@ -22,7 +26,7 @@ int main(int argc, char **argv) {
 	long long tsc, old_tsc, new_tsc;
 	long long aperf, old_aperf, new_aperf;
 	long long mperf, old_mperf, new_mperf;
-	struct timeb before, after;
+	struct timespec before, after;
 	long long int start, finish, total;
 	cpu_set_t cpuset;
 
@@ -55,7 +59,10 @@ int main(int argc, char **argv) {
 		return 1;
 	}
 
-	ftime(&before);
+	if (clock_gettime(CLOCK_MONOTONIC, &before) < 0) {
+		perror("clock_gettime");
+		return 1;
+	}
 	pread(fd, &old_tsc,  sizeof(old_tsc), 0x10);
 	pread(fd, &old_aperf,  sizeof(old_mperf), 0xe7);
 	pread(fd, &old_mperf,  sizeof(old_aperf), 0xe8);
@@ -64,7 +71,10 @@ int main(int argc, char **argv) {
 		sqrt(i);
 	}
 
-	ftime(&after);
+	if (clock_gettime(CLOCK_MONOTONIC, &after) < 0) {
+		perror("clock_gettime");
+		return 1;
+	}
 	pread(fd, &new_tsc,  sizeof(new_tsc), 0x10);
 	pread(fd, &new_aperf,  sizeof(new_mperf), 0xe7);
 	pread(fd, &new_mperf,  sizeof(new_aperf), 0xe8);
@@ -73,11 +83,11 @@ int main(int argc, char **argv) {
 	aperf = new_aperf-old_aperf;
 	mperf = new_mperf-old_mperf;
 
-	start = before.time*1000 + before.millitm;
-	finish = after.time*1000 + after.millitm;
+	start = before.tv_sec*MSEC_PER_SEC + before.tv_nsec/NSEC_PER_MSEC;
+	finish = after.tv_sec*MSEC_PER_SEC + after.tv_nsec/NSEC_PER_MSEC;
 	total = finish - start;
 
-	printf("runTime: %4.2f\n", 1.0*total/1000);
+	printf("runTime: %4.2f\n", 1.0*total/MSEC_PER_SEC);
 	printf("freq: %7.0f\n", tsc / (1.0*aperf / (1.0 * mperf)) / total);
 	return 0;
 }
-- 
2.26.2

