Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B350F133B61
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 06:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgAHFqv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 00:46:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgAHFqv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 00:46:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0085few2090356;
        Wed, 8 Jan 2020 05:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=zS4z0v/EVz6a7/+RUPyIOd1+zQwhAhY4eZ6Wuv/yqHg=;
 b=A6QIdrqD71iKwdbNZTn/oxu+hSHfzAoDHTgP1KhUt2TYJL9JabzMNhuBhW3CeSKvpVXg
 sZ+OetV0ZpBTffw2+dBqjoj9jgHKPuvHorNwlMbQHLtKNiN7NwVx/DCWJKdEnOV+hQog
 qCSCc8T7CoCKqPw39VEDo40sMJ7tgTRLaDvbkIEYZJ5+HLkB6tBu81L/3N5caK1PVxVq
 6gGoAEi9BwonDPAdcJM/ieqFk+DnBSWEMcNKUBHAuUx4jm+47kDq8q8QCUTakPy2GcFR
 VDD+7AMa77IiBzqfVPxIypLQr+Oi5JFCPf8r8OjlItmcvq9nR/Ed7uYO8+WnyCVhpbar Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbqskvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 05:46:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0085fSBW030628;
        Wed, 8 Jan 2020 05:46:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xcjvetgb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 05:46:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0085kbRj015837;
        Wed, 8 Jan 2020 05:46:37 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 21:46:37 -0800
Date:   Wed, 8 Jan 2020 08:46:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shuah Khan <shuah@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests: Uninitialized variable in
 test_cgcore_proc_migration()
Message-ID: <20200108054629.jtq36feyhxsfhf6u@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080049
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "c_threads" variable is used in the error handling code before it
has been initialized

Fixes: 11318989c381 ("selftests: cgroup: Add task migration tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/cgroup/test_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2b..e19ce940cd6a 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -369,7 +369,7 @@ static void *dummy_thread_fn(void *arg)
 static int test_cgcore_proc_migration(const char *root)
 {
 	int ret = KSFT_FAIL;
-	int t, c_threads, n_threads = 13;
+	int t, c_threads = 0, n_threads = 13;
 	char *src = NULL, *dst = NULL;
 	pthread_t threads[n_threads];
 
-- 
2.11.0

