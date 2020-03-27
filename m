Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017DB19576D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 13:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0Mpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 08:45:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Mpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RChH00171249;
        Fri, 27 Mar 2020 12:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=MgkCaoDaA5YnVO6nCPkdNH0cYdXW3AT1v3OF33BFz0s=;
 b=FVkpAm/9dEPCQiCXpvU/X09Xm6i/pHmVryDsN/dBWQhoRrSix0m2y6D7sD5VkHTWCIsU
 aAgfCwK2xpEAIvKW9XuASc9Xc0bZ5Z0rnayWYjK2ym1/iWK9lvmGLIRrqNaqXXfWooYJ
 ZCrCUVMBfRehrszJBSk1PGLAHqLN91vZW1Ppa9OwsDjLwD0ZTTSVZKEmGRb+fxq/8wUZ
 mIRwsbx5tGd0uPqsG76nysAyG/3FeUZscJuTZis0MGW0GIVcWV03iuJdHTGA6SUV1SoJ
 Y7TctUIhXBTYNFtwx8fd7ex5O1OYD+JkHeNocWCF5gzUDhoVyh+30aYjh3VXtXhluR6b nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 301459aw66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 12:45:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RCgi8x071907;
        Fri, 27 Mar 2020 12:45:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yxw4vsejq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 12:45:48 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02RCjltY005403;
        Fri, 27 Mar 2020 12:45:47 GMT
Received: from localhost.uk.oracle.com (/10.175.186.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 05:45:46 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, shuah@kernel.org,
        trishalfonso@google.com, linux-kselftest@vger.kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 kunit-next 0/2] kunit: extend kunit resources API
Date:   Fri, 27 Mar 2020 12:45:20 +0000
Message-Id: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=991 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270117
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A recent RFC patch set [1] suggests some additional functionality
may be needed around kunit resources.  It seems to require

1. support for resources without allocation
2. support for lookup of such resources
3. support for access to resources across multiple kernel threads

The proposed changes here are designed to address these needs.
The idea is we first generalize the API to support adding
resources with static data; then from there we support named
resources.  The latter support is needed because if we are
in a different thread context and only have the "struct kunit *"
to work with, we need a way to identify a resource in lookup.

[1] https://lkml.org/lkml/2020/2/26/1286

Changes since v2:
 - moved a few functions relating to resource retrieval in patches
   1 and 2 into include/kunit/test.h and defined as "static inline";
   this allows built-in consumers to use these functions when KUnit
   is built as a module

Changes since v1:
 - reformatted longer parameter lists to have one parameter per-line
   (Brendan, patch 1)
 - fixed phrasing in various comments to clarify allocation of memory
   and added comment to kunit resource tests to clarify why
   kunit_put_resource() is used there (Brendan, patch 1)
 - changed #define to static inline function (Brendan, patch 2)
 - simplified kunit_add_named_resource() to use more of existing
   code for non-named resource (Brendan, patch 2)

Alan Maguire (2):
  kunit: generalize kunit_resource API beyond allocated resources
  kunit: add support for named resources

 include/kunit/test.h      | 211 +++++++++++++++++++++++++++++++++++++++-------
 lib/kunit/kunit-test.c    | 111 +++++++++++++++++++-----
 lib/kunit/string-stream.c |  14 ++-
 lib/kunit/test.c          | 172 ++++++++++++++++++++++---------------
 4 files changed, 382 insertions(+), 126 deletions(-)

-- 
1.8.3.1

