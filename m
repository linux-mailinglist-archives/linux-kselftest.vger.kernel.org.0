Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59B258BDF8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiHGWeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiHGWdk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A0BE16;
        Sun,  7 Aug 2022 15:22:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277J42kj011175;
        Sun, 7 Aug 2022 22:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=87e7sJRRIb8E/f8Ay+qjZ/+l6W6enZHvFRdYgHOQ2+k=;
 b=JdB+r6vB1wIEUYI/NnA6i8TJTK3qwhwkpnRGYcwhqjuKCWL5jpeDe67VogBRhOzyjPoL
 gTGIWRvjgQHeW+ZYOboX50D4f5AIApkL+R+GOv3vs66F61ThhKsC363StSzwmn0mp63G
 qEJxAUpe6D116adrlJBDlk8YJ1jDUGK6yErp251MB+JekSzWA6txyuRNhb3osyP8VvjJ
 fc8brLro7nHIChxJHJGhIvxUhJ5WoFvLH/eAHdez8VregNxURnc2fAVqYT4aUAl3rEAH
 +/nCdO9ybfeynqrvvD9m7PmXXrdGMoYhPbUaSYqvVSwpNET/T/qfIR/d1vECXERdlL+t HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsg69j0d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277D0o4A035674;
        Sun, 7 Aug 2022 22:21:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser15gwb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbUErCieMJT21jWM60WlPVQFjl4zjngRDe1JRuzFj2zmC4qYWiSGkVWtrkpd44FGF6T9VOfxD153KEYzwZs8RWl6fmeLQXgvJWk5DAJf2gVLvWkTeM2A98yPFdbtjVtb0Jz9bBk4UVHXuHQpKgUEbcMAf2S7UnBSz4ipGjor8k7vNj5/rFAVrUd2i3OF2q4RWRMda2FvL+0S1bpAj+FdxIpmOcoq7jWx+X89fEF5+qUIomNnYjXhvWhe1XFD6H0cuyWswwGzOdn+yTTHu3G8i+I1qxy4+8w4XE3h8NNP79ddOPpXZmJHNSy5sSuIfgqKGsI6vy1jjk94lNFuhDIk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87e7sJRRIb8E/f8Ay+qjZ/+l6W6enZHvFRdYgHOQ2+k=;
 b=EvnN+iNI10oe/WLdfHQhJ7WVMhtDMgVzDjP0EKFwq+QA1oKp/oT1qj/av3KwQNxJ9c9sA3RNpIKmCoiI4K2pVoBcqBSGaTUZtW6gERspoXWQAos0JVAMmSlRMpcG0qD4+8u0FPwn8v88229sApqXRBv4hhob98YqegaWfq3O0vaIP6GXpRdubKbSYcq3Bdw1QZ3BQjcAzi/BIlflBKV6klYdqNiBM53IMyWACTwKjjHNZ2IdA3Gb++ZNDtOi/mE3kUiCOnNvUPY7Gs5lOU9RM7/e+z5YbTIsYQN7JR7wDfYyCtQEX0R8vU2d/ofaTSMJT7E1fJRmK52lS6dHUOMQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87e7sJRRIb8E/f8Ay+qjZ/+l6W6enZHvFRdYgHOQ2+k=;
 b=FBcnlt7aqSvHZg4wnWwduXbLOOv7jbj0zA703L2G3neCTeGHm4/jJtTzSnQl3oVqbP3V/Mb9/n0YIKf9H6HgomIEWdpPwxP8h81wBDaF2nu8wncQbarxIjuQu53mYqb4NDelkqktFWT0fCtMc6eOodzMucBFda1blnP/N3yY54k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR1001MB2381.namprd10.prod.outlook.com (2603:10b6:301:30::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Sun, 7 Aug
 2022 22:21:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5504.020; Sun, 7 Aug 2022
 22:21:51 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC tracing 3/4] selftests/ftrace: add test coverage for filter predicates
Date:   Sun,  7 Aug 2022 23:21:22 +0100
Message-Id: <1659910883-18223-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
References: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b13b59f-ff40-44dd-1f03-08da78c339ea
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4FKP30YxyTlcb55LYrdxtzHBJjd19gkECpGDKLfe3feJzSCe3Bv6J9K8Nb6zoHoVxznQCmiJF1FB0lLM8sTbDVT2eOdBkloJmO45V5ejT71nUjK23gMxJVLeQFc/YYA2zJ32zVeef7ZmXqEney6V6Y+u1HXmM3WKf2ltLF2HUWQvDR/REP8mHY2DDdnV6zBqtfyDgdxy4WoM04nl02lzJy82iNR+3U7MrfTGPMzbegcIo5YpSHKeNE4n3056HXhktTX/Sl0EGou+MEdg5SUF35l76T4G1T6CcTUiEa/SCky5b/tn91Vxu7wtQgjo0x64+ia8eFUEPQElmWXVVRFDd4m3fhtFBY9WgcyW4GjQNvfPmrrl7GlgpBDuThU7sDPK22SS9JX2N6p1n3qqKvAjskfXRHEoQd39GyZcaMkaI70cnZiHUP0mu+8dxImiMq/aE9EPQT9YAqKhmWnCfeF9kWny/7MTCzGZ6j3Ya2hgUzRbkPahQ/Vl0QY1E3ZgXEPd3nV1YvavO5Hofdmw6WDNddk9OSfzPGHQfMmh8eHC9V5PgKFXaSFsFVSf3ZQHnXHAvjWGLfn8NzvvTpMJMvYUSTqnJBuQzuZ0dPc9cHX9iAN6CGpfV89ddUZ9g5sP9ebPyWB5y4vth4Yk4/+8l6I1Q1kbWrO1LZYJwQuVQaKN96/D3n3UMsZyoDm+Jlc7b0mXDcPLJWdzjDCfp7wGc1PRQBEdEl/yL0VDV8DT+wRwzXa2pxtzDa1wQshBSYd/mKY2Jduth/0sgkz9gnystyd1jwXxNKCJMGlu4MhRfv9Dag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(186003)(52116002)(107886003)(478600001)(86362001)(6512007)(26005)(41300700001)(83380400001)(6506007)(2616005)(6666004)(2906002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(4326008)(8936002)(44832011)(5660300002)(316002)(6916009)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEVSS+8STCQ/h2cRBA8wqHnlpFNhoZ66pNj3yD3c/Y8AWmzyr0PTeWAwlS3u?=
 =?us-ascii?Q?vd2onU4s6vdMDzuN2eGdnn807jFeiDDYADfroetL0cgIbnCXxDhsK2BXRBxt?=
 =?us-ascii?Q?7VgDH16z6niYFBTazd1RTNYB8jn2kt7QqafLHB7wHe1NL5MCQ93a4yT1tTFq?=
 =?us-ascii?Q?7sFXVZfBTb/2crI4gelshlI2PDEq8IIrShxDtT+VID+kDnDLMJzKBT52QncW?=
 =?us-ascii?Q?D0G6arLxvktYAewp42WCvefoYqRUnE+OgH0dm7eucN4+yqWPqMEETzJ/qxdx?=
 =?us-ascii?Q?B4fLP+Kgv8j1koxXc/bdfOA6sAdSYmsf4Zl4+c9r70YbQ9jpa6mUbkjp5Z5c?=
 =?us-ascii?Q?7BPuCkEMkBneny/sPIrA3NGxjilm1roU6hSihcQX59R5c0zbeJ9TCw+3UiTQ?=
 =?us-ascii?Q?APYb/wXh2gAsQgHpQ4mifCaph15WjnAL5tnF1PpADl0FPFpBcqzhBYbS9G1S?=
 =?us-ascii?Q?8lbOUJnWtga/3Zv99jelmlaT9PR6+Dpc5WZNLa8RbGEx9Z5qccKbqWV5lNRd?=
 =?us-ascii?Q?5poNCugugJfKq135SetuWSD6fKOM/VkyR8ciKmy7m8kYrCbQVx9XLHH8FxTr?=
 =?us-ascii?Q?C4cSnD2N4JM5yQcN4F8NyuiTWaEzUSRtONJ+6MHFhuCvj/m8Dufg6zjZ9gXr?=
 =?us-ascii?Q?DsH/JaGbQMQluxKOsLDwd+JFBj5GEhXXdKvx12sNkuFSr7Tp/EJnFBA52zEV?=
 =?us-ascii?Q?haBt6Df+CUeiY6UMKuDIvAI+O58ipnKRegKx5Ovq7yKi0d4zl9zjOytv4h7y?=
 =?us-ascii?Q?+UbqNRn3WRMUJ5MjGb41ZVYnNC/eoKiRE36ZoYfDKMQSoIj+VbIvwoZ6P4yJ?=
 =?us-ascii?Q?nCk8L7amiKq8aZJkOaVbyp+pCJZ4l3CtVbFTP4Ksx8uM4mmI73+UBnm8Ab5b?=
 =?us-ascii?Q?2Lef4l62LoM6dmmr+wp1PxuB3vi2xbPM9vCpOwV4yi6PqrBf6rj+JOHcqLho?=
 =?us-ascii?Q?hqPnmdG5e+ehDsqFAGicGSNF8t5WhM+WiQTjQP+JSi5zQjb397OfgZSmmnIR?=
 =?us-ascii?Q?9XZdJW/3I042twLPyYLkjNvJzjzqJr0c29K5B3wAu8WyNJ7Nx1DAEz6X6/CW?=
 =?us-ascii?Q?GBb8WW2iutrZeqOUkHB02dgty8jYh2JgWcG8ymUtC9qJBEIMIZ+m5AsbfB/R?=
 =?us-ascii?Q?uxPZRLzJX+29nYRLHPif5KRhUcDjimzZDe2CWDIiQZ7w0bPq4ckT5Ph4qjvG?=
 =?us-ascii?Q?CeNCz6x5/lCVXHi0ZW9O8/VhEVp7L8Ny5H86MqW6t26DLpUbKAgayfsa47lk?=
 =?us-ascii?Q?7L8lOa9zqlTxHPUnylhL5SofAeheGzYb+1CTTpDnSNAzuRmwsOEAWGSnxTsp?=
 =?us-ascii?Q?k7r8LCd7EQiElFjnpQ8rCJAXzE9mLS5PtJuazYYTzDPSKqR1anQDr9RvvD4C?=
 =?us-ascii?Q?jigl42pZw1yqI8KoKAjku36yF/Xx5sxFNt4S09NItjrSSq7W2rXqfQsWQ07K?=
 =?us-ascii?Q?hcJoTgeOr1hHFWeXy20aUvXmn6/QgP0Fryr0uAdQhvATcEfm1CR627H45gis?=
 =?us-ascii?Q?ed5/J00aiFPF0kJnaxoIRbVX5/vRnj9+2wBEHFt2aHFdPw8BPCocMjVGNEsK?=
 =?us-ascii?Q?Ge90Gmxvb/1BpqlcNDudb/9F+Y1uZVthdtpq75wV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b13b59f-ff40-44dd-1f03-08da78c339ea
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 22:21:51.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA+tTrJ2UvTr0IZE6n4ZMKcXD/zq8diXnsOovS1in6hi2QpsA7fZHEh2KJmaqT/oLAxgZMzr8AOja4sVMTyoNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_15,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208070119
X-Proofpoint-ORIG-GUID: t4Wv3UF-H_jqePAKFWyHCJyT01XAWEI5
X-Proofpoint-GUID: t4Wv3UF-H_jqePAKFWyHCJyT01XAWEI5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add tests verifying filter predicates work for 1/2/4/8/16 byte values
and strings; use predicates at event and subsystem level.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/filter.tc b/tools/testing/selftests/ftrace/test.d/event/filter.tc
new file mode 100644
index 000000000000..396383519f84
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/filter.tc
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event tracing - enable filter predicates
+# requires: set_event events/sched
+# flags:
+
+do_reset() {
+    echo 0 > ${event}/enable
+    echo 0 > ${event}/filter
+    clear_trace
+}
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+# verify filter predicates at trace event/subsys level for
+# - string (prev_comm)
+# - 1-byte value (common_flags)
+# - 2-byte value (common_type)
+# - 4-byte value (next_pid)
+# - 8-byte value (prev_state)
+
+for event in events/sched/sched_switch events/sched
+do
+    for filter in	"prev_comm == 'ping'"	\
+	    		"common_flags != 0"	\
+			"common_type >= 0"	\
+	    		"next_pid > 0"		\
+			"prev_state != 0"
+    do
+        echo "$filter" > ${event}/filter
+        echo 1 > ${event}/enable
+        yield
+        count=`grep sched_switch trace|wc -l`
+        if [ $count -lt 1 ]; then
+            fail "at least one $event should be recorded for '$filter'"
+        fi
+        do_reset
+    done
+done
+
+# verify '==', '!=' filter predicates for 16-byte array at event/subsys
+# level
+
+LOCALHOST="-6 ::1"
+for event in events/fib6/fib6_table_lookup events/fib6 ; do
+    for filter in "dst == 0x00000000000000000000000000000001" \
+	          "src != 0x00000000000000000000000000000001"
+    do
+	echo "$filter" > ${event}/filter
+	echo 1 > ${event}/enable
+	yield
+	count=`grep fib6_table_lookup trace|wc -l`
+        if [ $count -lt 1 ]; then
+            fail "at least one $event should be recorded for '$filter'"
+        fi
+        do_reset
+    done
+done
+exit 0
-- 
2.31.1

