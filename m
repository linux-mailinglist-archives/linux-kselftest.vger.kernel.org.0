Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC28AFA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfHMGMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfHMGM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68sM0010867;
        Tue, 13 Aug 2019 06:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=XQCN31heGj0fx7iiZojr/ruGjvl/p/j3e97NBhsXhJ4=;
 b=Hh5QxY6oi4DhiIPJ94kk53OFSbFbraE7zsVJEFTCxJO8rt8AXjCqA2KTyWyUGjzB6WXA
 zZDJjGk53FDT3N27xLaGM8A4Khycl96/dZJD4n9Ju9zEwmwZDT9Xyp7j2zylN1CavrgX
 lqXzVJzEiSikgYf0SAqrEo5zemw2MaWAI9KwBzfG50SBRMdMTLuNjWSXr0hWy1dEYj8j
 BiIod3M6WAAw0G99ArhzvNHSzWO0B6mvB0v2g0gL6gLHvErMXTAxSg12AqGBXi7Lodj0
 fB+Ai1xgho8B1knHCd3ZI635InhUTgHK/1c8qEOEMVIj1aZ1V32Wfz5adNNTVENhtchg 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=XQCN31heGj0fx7iiZojr/ruGjvl/p/j3e97NBhsXhJ4=;
 b=IGJKk4EZ/+fm1qA7ajNbNJKALRXXJIHrIT8J3xdTfeXfqmhdA+5UzIg6P+IyX57b81x7
 4Y1uZ2Zf45QhdpAqXWGCuEpFUKsRkW/pBFaY19lFPPGDeDRc9AY/kz0OsuepBgBz+jTv
 1H76K34VkPA5tZHeLTKwRiv8LpgNh8NKbCHTNVjIrC+Fc50F1tsiVO2wf67kvKK4GCTd
 agDuynlJpl6xpbZX5aAb69Ys2ve/cvJhtCd9VOsfatc8ILfpGmxvCSp8WWbbwOQwKR4W
 32asHbzwRU5Vu2Mt/hwqjlCtjBWKl6adJ/XeaSDoZyOFF7ROKsii88U1Xde9xRvMOH1k JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbtc171-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:12:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68auX050030;
        Tue, 13 Aug 2019 06:12:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u9k1w4239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:12:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6C3Hg026964;
        Tue, 13 Aug 2019 06:12:03 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:12:03 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 19/19] Documentation/dev-tools: Add index entry for KTF documentation
Date:   Tue, 13 Aug 2019 08:09:34 +0200
Message-Id: <a4367b69bbfde842ca5bda21a5b07b601a703df0.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 Documentation/dev-tools/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index b0522a4..f155205 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -24,6 +24,7 @@ whole; patches welcome!
    gdb-kernel-debugging
    kgdb
    kselftest
+   ktf/index
 
 
 .. only::  subproject and html
-- 
git-series 0.9.1
