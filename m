Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B2177B77
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgCCQDc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 11:03:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgCCQDb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 11:03:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Fs9OZ165169;
        Tue, 3 Mar 2020 16:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=mhifvgYvFG9SQGr24bsa0VTvq4k/UtMxi0xav7PMSD4=;
 b=Qlljubb2cPKZK0SV3JQBg/3fhm36xvZOkp8DXUFGZZzYGLxaitySLu1xVdJU3uxEaJIa
 NYRN/w/wG7L59DxXkh2FgxpnDAGFFEOWl+Fz1lR/n0dWeRC89iPdlHIESSPpNt1DFrpN
 tyLrrPn+8YsrU9DM1wcJCH1niZY9x6Lu8spPR7LH1gbZZWiRVou6lvFSOsFzeU/87vi4
 KwBN7bZ+CLY0E6kVhHcIFjJfzAykkgimauVaHdtOkEDhwo5p+lUe13/GN7c5v3v3Ed4m
 VLXwm8KmSWs7q7fldLpgZE7edM0TD2HA6HgsIrtz37l5NphnSsdVsYChXcjTiKKCPmJ+ dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqr7ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 16:03:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023G2Vfc139732;
        Tue, 3 Mar 2020 16:03:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1p4rk9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 16:03:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023G3N1A007489;
        Tue, 3 Mar 2020 16:03:23 GMT
Received: from dhcp-10-175-165-222.vpn.oracle.com (/10.175.165.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 16:03:22 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, trishalfonso@google.com,
        skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC PATCH kunit-next 0/2] kunit: extend kunit resources API
Date:   Tue,  3 Mar 2020 16:02:39 +0000
Message-Id: <1583251361-12748-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=490 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=547 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030113
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

Alan Maguire (2):
  kunit: generalize kunit_resource API beyond allocated resources
  kunit: add support for named resources

 include/kunit/test.h      | 145 ++++++++++++++++++++++------
 lib/kunit/kunit-test.c    | 103 ++++++++++++++++----
 lib/kunit/string-stream.c |  14 ++-
 lib/kunit/test.c          | 234 +++++++++++++++++++++++++++++++++-------------
 4 files changed, 375 insertions(+), 121 deletions(-)

-- 
1.8.3.1

