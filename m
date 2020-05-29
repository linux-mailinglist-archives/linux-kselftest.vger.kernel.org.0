Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8401E8A56
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgE2Vqk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 17:46:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE2Vqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 17:46:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TLbtK5004146;
        Fri, 29 May 2020 21:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=u5x9D0t4tZz+1cMYmC9qV2MbmC6jm9OFvlDRzwpEAJ0=;
 b=Yvq9yZByXssUUAK9+XEwjin2JPS+2qwRuy2omBhf0BErZH2leyfvVg6v8lcYSlEXIqgX
 3+M2HBQoCErUH4JO/QdHPYir8stCUVPJYd4rJYcrSJKrg4kvKhHJWYkde4r5Q3j+FQij
 zlJo9ELK7KFWBSStZ3vMaCav/HZg/e1Fhizw68GdKiWQhNvwYXKSN5TrxbVeyaEA8jx6
 NQQbZypOyrNrgzXHYwoSDSGkroU7wwj8njDgEF5hw7llEaYWm4XySaM050NfYVxOnGJm
 O3fz2XGMmLOTjTlATGU7K6taLvHdEqnKV5SWOXqD12NVKc/6l2Jmte8QINUmhAZKUgKP Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 316u8rcmbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 21:46:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TLXA9p091790;
        Fri, 29 May 2020 21:46:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 317ddv06nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 21:46:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TLkXui020880;
        Fri, 29 May 2020 21:46:33 GMT
Received: from localhost.uk.oracle.com (/10.175.189.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 14:46:32 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org
Cc:     davidgow@google.com, trishalfonso@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 kunit-next 0/2] kunit: extend kunit resources API
Date:   Fri, 29 May 2020 22:46:19 +0100
Message-Id: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290155
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

Changes since v3:
- removed unused "init" field from "struct kunit_resources" (Brendan)

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

Alan Maguire (2):
  kunit: generalize kunit_resource API beyond allocated resources
  kunit: add support for named resources

 include/kunit/test.h      | 210 +++++++++++++++++++++++++++++++++++++++-------
 lib/kunit/kunit-test.c    | 111 +++++++++++++++++++-----
 lib/kunit/string-stream.c |  14 ++--
 lib/kunit/test.c          | 171 ++++++++++++++++++++++---------------
 4 files changed, 380 insertions(+), 126 deletions(-)

-- 
1.8.3.1

