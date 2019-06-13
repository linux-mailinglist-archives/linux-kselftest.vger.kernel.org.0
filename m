Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868B9444EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392600AbfFMQkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 12:40:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfFMHAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 03:00:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D6xHRu024210;
        Thu, 13 Jun 2019 07:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=HWozqqcp/Blla7YkQ0XS6n2TRrp0GniU7ZKMsnbPK8A=;
 b=kADCSkyizcWvoL+XnNHHj7MkMAp0bHVJrX0tiAJI3Pv6/l3KEpYxWmiSJr32D5qWbhVQ
 f5VIqjC2A4A60o63syLAqF8i42QYwvwrRC2KorK5MLfV21yTSipyAcqPHXRgPF58Eb7a
 0UNEByz5cpMC5/0gMurnHYBqxr/UJra/DuNGiZ4eFRDH/YQuu38kGztRwaycIwaJw45O
 zImic6Ooyxj1pQYi1yIaBIdRcy1TD19bGOcIxL4ErkCniPuDMaaLJFhQ/tAUq2dSiSDf
 ixkO/UVAnr1Y6Dvz4S20LOoKXx9KS4AJsTYKPjQ2uHeFd9N6g5w6mk8HxL1xliES4p9f NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nqyj5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 07:00:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D6xMcJ012723;
        Thu, 13 Jun 2019 07:00:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t024vbrar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 07:00:31 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5D70UbZ012610;
        Thu, 13 Jun 2019 07:00:30 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 00:00:29 -0700
Date:   Thu, 13 Jun 2019 10:00:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests/bpf: signedness bug in enable_all_controllers()
Message-ID: <20190613070021.GG16334@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130056
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "len" variable needs to be signed for the error handling to work
properly.

Fixes: 596092ef8bea ("selftests/bpf: enable all available cgroup v2 controllers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 0d89f0396be4..e95c33e333a4 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -47,7 +47,7 @@ int enable_all_controllers(char *cgroup_path)
 	char buf[PATH_MAX];
 	char *c, *c2;
 	int fd, cfd;
-	size_t len;
+	ssize_t len;
 
 	snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
 	fd = open(path, O_RDONLY);
-- 
2.20.1

