Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA376747A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjG1SWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjG1SVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:47 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22432449E;
        Fri, 28 Jul 2023 11:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK+MaAOySfGSCciXUTt1JLQOPNbFNsLlG5fmWdQqam0xbslQ8egftyEKs4/6DlKTahE4DT31HqQWl+FnjEg7iqzh8ietR6LrSXxuJ1a04ZBWkOWQMc/nJwj2VsN7eutIPp/NMUjkkdylTTqaWGpNfYp+uZDvyDliR5oXmMXDreGywuCrNDdwEL+v9W7H1KzVTwE2qrfIcqXDCSpmI4ZdzGpG6XJTaGpwgpiBO9C5oYT0V9Bp946VY+ZBjlLagVnFLc3M80FbB9fwZ1muVDZJdBmkisW3ZPNMVYeGoA55gnIJxR+ZYqcAvzHC4RV/r5qNzuZM7ubmHrNbaGzHKhmB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD4e/LRWicfReGBTq2PmuuNab6VTlR+NonQSH7Pjua4=;
 b=iWFvEeMiri/Sgg2f42bl9B/Jk0JN3ywmmbNJdn0Yr0WlANeFoggHFhoqoPxAghjQLQRtkkxtvpj9XEMd9b4jZKTShFYUDqhz2TrGyVCaV65dMpBSGlKHv56lNC38b988MV9GREem/vnFU7qM9jZVNMxhc+LHzZej+GGVoIfWqmsG6QqOkTV7tlLrZWrvmslMOW7Uyi8W6DWwNaHFBfkQH55bJtt7B5+Hy2ZEu82Aw4OP9Nz07Ngjz3v60JFVuLOvP3qkJqZEsc6EKIyGBe0SKL6gPZq86Q0jxF19qSe9RjdSQDNNxzVEPiR6BkAvgRxuVbeGNK5Aog40cVQvUA0LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD4e/LRWicfReGBTq2PmuuNab6VTlR+NonQSH7Pjua4=;
 b=PtQBvSxG3QPb6XlUjGkieI2ZD8EfdqDRAtn9RUyABNGfoBhL1xEPeCJsljBCGt3okwAx7ZiZLTkqURJGW8ooUPrXrgIdWmpjpLlV51llhn4XCM2sv7qgJ1j/yfK7kjS0xWbcC8bM17o81geZBYVPKvoQmZgeXyErBgFJ/fivWs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by CH3PR05MB10004.namprd05.prod.outlook.com (2603:10b6:610:123::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:27 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:27 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 10/10] test: ftrace: Fix kprobe test for eventfs
Date:   Fri, 28 Jul 2023 23:50:52 +0530
Message-Id: <1690568452-46553-11-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690568452-46553-1-git-send-email-akaher@vmware.com>
References: <1690568452-46553-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|CH3PR05MB10004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c23c12e-33f0-4f27-995b-08db8f97754d
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Cx0OD1gnshYb+MH28H6wbcb0IOB2gW6ZJmYg/ssTouclIvuv+25T90VLhq1IJDXarkjUdJ1vqEgqZc7gNCzbUDV7jqXCC2iXjFRkhE7GEgCBXHWhHQvs9tNJ6V1xSWxE5X0A7L7E9onvkTw9WfqDsde4lNHq1IgyX5jmVj01jN99L1doXLjcmyTtlWSJTvfLt/uzulVkq1wlw63wt7VhSEXIlU367LhrJWHPJ3KmFXF+KM7gU0L5WKo9cwu0cvwNMl1lxhB6I6O3UVIkDp6k0Mxe0vShB3/PVqPGYZ5muef5TdOVgteSaI3fXdfmCdKu0WOppFCLD3o6HydTeOrAKWpokmX9p8tfqLSx5qzU7OgBc3XTgbfb/1fwoSOMIPUB5RDrviG5fZsXMN/AU5piWwel3XVhobYw0KfBjO6F0wzZ7qr7wqWvw7VoqpeSVqd+dhuA9I/oQiRmgk2s0Cm/kSpE6Su9URUImSmowb2LOskC6ldvRJNFPFBVPRiaQusn1i5VUmO7W2xKEZJchn2bIKtQ4mvPpspxdrGWdtMm6nqHHYK+WnNhp1yeuPT/By9kpTK/V9J9uyPXoltprM6LZZovouNtgk/ZsvCSCxxbs051slFjHC1xaG5qdIs9swTQWgsxKfELasNBhKYuhIT7i0CL4rjVY80//FCGS8KYvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(83380400001)(66476007)(4326008)(316002)(6486002)(52116002)(6512007)(38350700002)(478600001)(38100700002)(66556008)(2616005)(8936002)(8676002)(66946007)(41300700001)(5660300002)(186003)(6506007)(107886003)(6666004)(26005)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fm6cEnzwFEGTRRo5xfjGZxwESvYZ5snQhqfeLnT2YJhztqv9V/Ab4d2FhnlA?=
 =?us-ascii?Q?TaNl3B1ZFdOtn/mSLNESGTQOn2h1ZKLiMrwJzeEDgjKCvmpL/Oiy+eDzMcKE?=
 =?us-ascii?Q?xaVeMyfc1IXowJNj/7XhcFoUpjnLijYnJFLQzPokKeKUHv04r+fDUvxzLfto?=
 =?us-ascii?Q?+pL1QmDN+1+TL6m3gN+YfPF54IPrvPC3BxX7dvoGIdwJa1RZwZpAKx03IMOE?=
 =?us-ascii?Q?2YPBs5HFbkv5z3KEh2sx9hj+y3GZGUtz5NUhM4ii8Djy1LoywkDZFCnofGCL?=
 =?us-ascii?Q?o2X57Y+qrgadeIuR4MsWOxgl/JITaMCfPkNDidMGjtp2jm7kjgrkFVnQcq9n?=
 =?us-ascii?Q?vG4c2TomV1Upr0nj2fBFu34Zi1QANxcUC/d3C95x4d0ECvIahYbOL2v0LrOI?=
 =?us-ascii?Q?OQDdIj0XxN9GP+G0zeyp1HuegrI6/5V3Cl8oQWI4bfUGlKdaepxtdHQm0Nkn?=
 =?us-ascii?Q?hC8exhnOkhjueKUlZu3Nm6i+A20cvDmG0hocnY4vBNQzgIqXqcTuyGBNfuou?=
 =?us-ascii?Q?wDMcFntU/d7IfWe4PaHenW7kzeYxK6I8RZR4tIAVuD84Cocia+EWanUaN9AR?=
 =?us-ascii?Q?LA9335bomqcyZvVH53765w05n3/CPau5/CrOny3vJRbUV7gAfqeyifSwxb6D?=
 =?us-ascii?Q?fYWTFyzfUGs0YUXt6o65z+cswbywg3EzORcvUsjSZrLUcJAxuzmlhlpRhcQN?=
 =?us-ascii?Q?HNpy5WM7ep9vWK4rBUEE7sX6lbQjZFb3Q7TSOe9vOEuicFulscpvRSZ3CAVG?=
 =?us-ascii?Q?JLrMbo1aAZ5ctxN/Pcv09ct7ao96A/Oufj6G/ezfORqLkk/urnpmK1AEnVEd?=
 =?us-ascii?Q?/ZemNsbeL6DYLM7LVlPiGG116baKwVS5P8EgxJXSF9a4IfdMrihzp516VZT7?=
 =?us-ascii?Q?lcZsXzlteTj/s81/aTBbhb/JG9U8Z0/B47zA8icdPOyfBwHka0u65XR5vU2g?=
 =?us-ascii?Q?vvCt2WwcBV+cCNAQEbjBXfuXTu7vHKn+M4UxPDxjKfrV8U1hMgqMgfnw8KVy?=
 =?us-ascii?Q?ziHwcqnlKX4dF1i4qdZ/AYtTpN2DKMYSjJ9i/LgN2+B/FX+R0FOHwMEvhQdW?=
 =?us-ascii?Q?Gnz8/ymzRylosgnL8xZ8XfHEZuImOdqdFjWn+JvA1jfSvkvCdW8elN3rJKAP?=
 =?us-ascii?Q?BJ2WsADsJNOC4hql2mAJc4VCmCV7ebNW1dqCN7KN6SdOqmcLCSuADOKHKL+P?=
 =?us-ascii?Q?+HEK3D7Z9I2U7w4eUiCxTNLhr3aQsfxPpWuMRqFIkyWKJs5auNMJW5MfNmdU?=
 =?us-ascii?Q?pNA81y5HI81MiFrOzbtaxTX+x5sW0YrK0nV+EDHZT5nv9alOHzsoi4ADYbCK?=
 =?us-ascii?Q?e5+WTXTs4PgJA9RPeur2elb7t+bAN7vyyJ2yVDqRzcn+rS8foBnMce40Y+qx?=
 =?us-ascii?Q?K64Ba+Z9/NyNydSGiumIdaqs9hrWozGvs7f1AufqMF0kgdYNPh74mKwq1PVa?=
 =?us-ascii?Q?JBU+heMM7ipHEDIyLDGll1xQa68T87ZW8nfEKsMo5vNTFHb90CA4n5E+ANwK?=
 =?us-ascii?Q?0PermoapTDQouiWbzRhND5UWJWxqFZMqu34C+giyAd+lRS6NYw5y2r2oyVlT?=
 =?us-ascii?Q?38xqSV7eDupA6JBCOwYtNoEJvsR2iwyrr/qwnIWS?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c23c12e-33f0-4f27-995b-08db8f97754d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:27.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5klzU3tdRr96XM8Oj63Z/4njnIlRFeMsHwAGYSmmwiYu2EpcZwx4nFiRtuyOo7vPJH3TnzmE2umBDLZn0td/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kprobe_args_char.tc, kprobe_args_string.tc has validation check
for tracefs_create_dir, for eventfs it should be eventfs_create_dir.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc   | 9 +++++++--
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 285b4770efad..ff7499eb98d6 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -34,14 +34,19 @@ mips*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
+if grep -q eventfs_add_dir available_filter_functions; then
+  DIR_NAME="eventfs_add_dir"
+else
+  DIR_NAME="tracefs_create_dir"
+fi
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t'" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a4f8e7c53c1f..a202b2ea4baf 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -37,14 +37,19 @@ loongarch*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
+if grep -q eventfs_add_dir available_filter_functions; then
+  DIR_NAME="eventfs_add_dir"
+else
+  DIR_NAME="tracefs_create_dir"
+fi
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
-- 
2.39.0

