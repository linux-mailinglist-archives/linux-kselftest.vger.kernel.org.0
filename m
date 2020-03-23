Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1324F18FB02
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCWRLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 13:11:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCWRLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 13:11:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NHAGRO039472;
        Mon, 23 Mar 2020 17:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=YCzgLbBZj5k8qIFVeAOYpztQF0I1eiKCR70BTCEJVNE=;
 b=eZwZ4T6tF9kC32ji6w2JL764gaCFR9QBe2h5/+r1cHA5ibPrQvp8PwfeE/h2TVR2d41N
 hYFiO93OF7+i7c4BeDAia4STVYRUPUs4nF9wGTX2TOZnJWBM159Zq9MAawg/kkt7cUsY
 95KPE/RltGhKxq2Nxy52wL4C4ERPtKx7KXJDL5tRTeWUv7R8g4MwldF6qRtNc+y5RE2h
 dId9jFdZ4MNBZ0yo27JofFdX/pT8Qn01QMlw4vsdOmFqbqNFMc9CEULHWdMVkXuQV3Xr
 87t0oNL4Toy6u0SW+b6D9cFxozIDpsBx5kXOy62+TmSYvYPRdyJvOKa1RocMHYzh2vFe Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yx8abvu34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 17:11:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NGvVds067395;
        Mon, 23 Mar 2020 17:10:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yxw914qf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 17:10:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02NHAwOA009796;
        Mon, 23 Mar 2020 17:10:58 GMT
Received: from localhost.uk.oracle.com (/10.175.192.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 10:10:57 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, shuah@kernel.org,
        trishalfonso@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 kunit-next 0/2] kunit: extend kunit resources API
Date:   Mon, 23 Mar 2020 17:10:41 +0000
Message-Id: <1584983443-27456-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=891 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=955
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230090
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

 include/kunit/test.h      | 159 +++++++++++++++++++++++++++-------
 lib/kunit/kunit-test.c    | 111 +++++++++++++++++++-----
 lib/kunit/string-stream.c |  14 ++-
 lib/kunit/test.c          | 211 ++++++++++++++++++++++++++++++++--------------
 4 files changed, 371 insertions(+), 124 deletions(-)

-- 
1.8.3.1

