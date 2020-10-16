Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B4290639
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 15:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407829AbgJPNX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 09:23:29 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com ([40.107.21.91]:50656
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407819AbgJPNX3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 09:23:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9OIt/PYwIUQbs/XirQ/F/KcorIDeS4zeVokHeAzlXShZ7l+PsQmJRGEX6PKO5tQPW8dHHoYiCYmfdVmv44Fj6EdpRL/nlvFq5vnABtFqVGWtMCKjKbl1IT9u9SgiCj+YkmqZkmrjSMcoU8pHsGroMmtcl6uCWSrTyouDzDFN0DG9fER5uE8FE4dxtY/iOZ6xJw0+/77k4Hck2KFWe8wjgwilXGOGeenug7larp/VzC9zw7zoDNVCJsMZP31MXQnymBGMDDIcCQMTFDL8fnKjVLoF6NQT+Xc9t0PUgYXAkqbzc/yJuMa93JeI4SLUqrOCmLhzmLvwjtH2CzNPerQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k69WgFdPUxj/YEU81hZbDk/tG6uQP8mlHN+OYzpP+qI=;
 b=ca8ZoarHaQteexYvgkx+bVMkme2XqaquTgt2N+M6vi7nonmtZqdhw554SMhnL0tNNz2fFGGhw4tceRXnbD/No7H4Ctko5lYKj2Iifj+pD5uNd4thiFNAMOkU9gjSyCGKxBA+9yqyc3bsaOg2UI9vwHAn8ZbHFsEMyJ5vCbbaq50hV0oXYg+XI4rh7lXu6dQ8dcM/KHh64w+ygHS3FsfZqvbYG+bDqrEPUTLSDFPzMZp66YEoL9tYMn2jCEijGdAElQwD7J1Yo4twAvJr2AC68KRIUCeJZ9t+fLLi+CjFvQJ1UIyBtCk+fwvnYoidWj5Htj9vhOyf7LUusyZOj82PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k69WgFdPUxj/YEU81hZbDk/tG6uQP8mlHN+OYzpP+qI=;
 b=n0ZuhOHQ6tYJ+0HzqfIRsLIiw0gA7SfxQIZ0Bw0AFY9TJh7PwF0KIycya7+BSEU8kWsc4uAnKd50AaicfHHoq3/dNMbe/P6ZpoNN9FRTpfI/8y9Ys/zVVnQ/1VZueCD/4PYl3zAufxe2twLkSZi2Bt/iZbNFN7GZlQjs+PbjEvk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2891.eurprd07.prod.outlook.com (2603:10a6:3:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7; Fri, 16 Oct 2020 13:23:25 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3477.019; Fri, 16 Oct 2020
 13:23:25 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH] selftests: intel_pstate: ftime() is deprecated
Date:   Fri, 16 Oct 2020 16:22:44 +0300
Message-Id: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.2.26]
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.26) by CH2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:610:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Fri, 16 Oct 2020 13:23:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 917eedc1-9111-4ceb-fca9-08d871d6a946
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB28919F3F3810FBA16C941B11B4030@HE1PR0701MB2891.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bq4BX06K9oJJR/fWm7Gn2ZzGNxf8g5X46LQRIJHCrwCaIy/oluVozuyKDN+lndiymN5yYZke3s6qzSIYQibc2gBxo0CBNEs2Ze4ZsFJv04t3KlRUxgNaSrifSGLMMciZs3EQGC1iL4spWyiJfnQFHwS+FQZQhoyNnYxLnSWt8wZ3QzwbvwoAcMAoIUQK4A7Lcyo2k7VrKdpBfPiUSXX+8neFmNcqRgmVAabi4RGmPUe3kQFX5/kzz4ns9ydzr+3HeTVaHKccwA6UsYZOD/ZdO6R129kvzGPS86wFqYU2oauiQDGDwcx3FG/qli8Yh69ItQvax4ICB7Rm3/QL/va3DaSCu5EoEV06IS2rKOWEjTcOZmRJfsvLFvSJmfv/7Fb8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(4326008)(6916009)(186003)(6666004)(316002)(2616005)(8936002)(956004)(36756003)(66946007)(8676002)(86362001)(5660300002)(6486002)(103116003)(478600001)(6512007)(107886003)(52116002)(2906002)(66476007)(66556008)(6506007)(1076003)(16526019)(34490700002)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: GsEwy6m+bkiuza4UAqQJuXlpuPRkfEwG1mzILSbTLj6BiBmd0cCS+fI6CtGTh/iMdGpba+NfrnrtwRN8IprsfUiTCX0x3LJWA0ATxGnuvgBAxex5xfR7g+cC0wd61ZOErdF7M2bDWV966axCUoBF3GZ5Afd0tsQp/Bby86mR/sohIiBc+GT10eC8UZm6aCBsq8S+BwS+xMkbCNcDJiwPV5eRMA/FuB/7Cze8V4G3dtXkP+8a5rH2N5tKPIkHJH69aZIo75DDP6NqZ4R+TffTgjDTr3f3IEIVMQuWCs4n0jL3lR1eFzZdj2pq4rUm9H7SFCd0hlg41UVgjIOf+q1obnrU0VuVQ5tBtYZSELDTQhutAOjN2iAIbmbgZnTmKE1d68gP4QN8tK3OwlVXJW967cHYeCrcX1YlpJiDx44n6y6QZn9DoEWCU9FsaWFFutixQvywp5vUL+FlfzXNd8F6Mx6Oy6uVVOhv8bYhqSxTkvTM0ES0sqV0lzMXI/Pf900NZUGAG8f6RK7pmQtTHXjYgg0dD/zXKrP6H9tmdvN5gUoyZznaht6f2g+A/ZcxUe/LeULxdji+eQ/lDFC/0XlOn5b0s/Gp6+HD0GtvRZELYBbmbnJP8CCY+V96nZeDger2ZkOzSsk+EAmkyYnJNfoJjw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917eedc1-9111-4ceb-fca9-08d871d6a946
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 13:23:25.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q82/HGDqZqIpG7UJD2+VSGogk0uDmg6P1p5OL4BV6Z26+SieY4v4IDxoTAkKV0LsoxjNJgfWA980nPfbXmSRktJWeCjrxm5JaegWI5J2G/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2891
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
 tools/testing/selftests/intel_pstate/aperf.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index f6cd03a87493..eea9dbab459b 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -10,6 +10,7 @@
 #include <sched.h>
 #include <errno.h>
 #include <string.h>
+#include <time.h>
 #include "../kselftest.h"
 
 void usage(char *name) {
@@ -22,7 +23,7 @@ int main(int argc, char **argv) {
 	long long tsc, old_tsc, new_tsc;
 	long long aperf, old_aperf, new_aperf;
 	long long mperf, old_mperf, new_mperf;
-	struct timeb before, after;
+	struct timespec before, after;
 	long long int start, finish, total;
 	cpu_set_t cpuset;
 
@@ -55,7 +56,10 @@ int main(int argc, char **argv) {
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
@@ -64,7 +68,10 @@ int main(int argc, char **argv) {
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
@@ -73,8 +80,8 @@ int main(int argc, char **argv) {
 	aperf = new_aperf-old_aperf;
 	mperf = new_mperf-old_mperf;
 
-	start = before.time*1000 + before.millitm;
-	finish = after.time*1000 + after.millitm;
+	start = before.tv_sec*1000 + before.tv_nsec/1000000L;
+	finish = after.tv_sec*1000 + after.tv_nsec/1000000L;
 	total = finish - start;
 
 	printf("runTime: %4.2f\n", 1.0*total/1000);
-- 
2.26.2

