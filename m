Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1D1EF5FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFELBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 07:01:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54398 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgFELBE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 07:01:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055AwGRb161927;
        Fri, 5 Jun 2020 11:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=dmqsTnpEMgvgWaF01TZp1obHH5FHCkwtMSTp+ECkeJw=;
 b=yieOJsHOmtFiDu5GpR2Lc6WmKnrXM/Hn0FVOBlUrZxeYaHy0vWGL4J0wZCgosqE9PfZc
 kiRxN75Lsw/hxUhoFYP7FHJ64RQQwD4a8Is23ZFFrEFDrxUQP17Ir80vdbozi0VYUl1j
 uvJ4JUAab7IGGBWIfRnKSRhBEU7dIDoD7sTDoPjfH3gZ1+E0A631qlh7S2o0c1qvGy3V
 EJWizOidaSMoU7pK4jl+To0yFij8NYVnhEBx8hVWDiKG+h5l3NuEDHzYIsCIJeEyFle+
 xBhOcSsGXxXkhnQsw6iakcRQYZ5eLam+fzolK7+T8Nn5IMQbhhf/iUa6DD0HTGEL7cLu KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31f92629uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 11:00:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055AxRiC016464;
        Fri, 5 Jun 2020 11:00:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31f92skt9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 11:00:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055B0tAu029723;
        Fri, 5 Jun 2020 11:00:55 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 04:00:55 -0700
Date:   Fri, 5 Jun 2020 14:00:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: selftests: delete some dead code
Message-ID: <20200605110048.GB978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050084
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "uffd_delay" variable is unsigned so it's always going to be >= 0.

Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 360cd3ea4cd67..4eb79621434e6 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -615,8 +615,6 @@ int main(int argc, char *argv[])
 			break;
 		case 'd':
 			uffd_delay = strtoul(optarg, NULL, 0);
-			TEST_ASSERT(uffd_delay >= 0,
-				    "A negative UFFD delay is not supported.");
 			break;
 		case 'b':
 			vcpu_memory_bytes = parse_size(optarg);
-- 
2.26.2

