Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7377719645
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjFAJCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjFAJCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:02:17 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69BF192;
        Thu,  1 Jun 2023 02:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW9rSuoVZzQ56h1txT6VWGrd6OW89vz4ypTBxmWqA7c48jSZBKKJSYo5ExOYEMnqQgLQw5YXN69gdrnVmKYIQLRGRS7UIiI6GeQZWsmBcVS+kGlrefgz39CS1/jdwJIrVGh3ZQPt1MociHszbLS2QhrcG1fR5O+EL5t9R2fUQS1jwxfpbsh2XsbPuBqSSl4dch8TM/sxjSoYyNv+91Z+/XZsXWm7lh3zoiRyARvxN1rp99dCfFobpC+gGT/bKDj0gwfp3FkUGkU1rKvOaaKm9Anzw0iCsY5iyR1MoW1EPxxz0dk2liHpZhnk9GVGcp3qfNIRuk1mo7LIe9Kl014vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9bnRNg1BLztg/RndOvyjdrwv2dOtmc68BkZNs0p/m8=;
 b=FQgYYjhmT1a5zXp8Vk+pxe/JXwWshZAj9rCLMTDLCd97Vkn2xdDRqlSILXUCEcJ8pDhfQeothu08zyeu470NKSbJFBS3LJXISfNb0z+SPTsQ1d4lUXN/eNU+9VxNTRv1R3s61SbrC6uoCRp+uAqz49WnJVAlAmUNX/uw847heo8WIkC727UMpsdo432qbInaAs5WxTCuPzEYEZ6vhGs3DRapLfXnX5jxQkcA5/6nWBQj8h++ia3osU5+2yOVz+K+t0C96VTPAu7pfozcucYQVkt2atBYnQ90dWuwXnmO4wPeqocJ1okwMEMInEGsm1ZHLGPyjHEYbxEvkaHXt4oQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9bnRNg1BLztg/RndOvyjdrwv2dOtmc68BkZNs0p/m8=;
 b=ivdUw5iNXO8DxA6oOuPXrCb6TjF1qXqNSM+I79/dEAH/0yB/+QspgRuU1Q3lLJShDMPOM38D2HBCtKSYZUGwkQWZQj2u/bx16keqxtAyJV0dHxHgTB8iC1YHNRxYgpjusotsOhCpQyeEwMe9SJlDHlkE/AIOEfRNfyXOhPu7Hsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:15 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:15 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 10/10] test: ftrace: fix kprobe test for eventfs
Date:   Thu,  1 Jun 2023 14:30:13 +0530
Message-Id: <1685610013-33478-11-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb13d27-3ef1-46b9-b132-08db627ec141
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7EsGjq3XoPnkYQxI5OpWWVVTCUGxXVXPdauEY10ptvfMm0C66ypqIUA9c4aCGNN+vAeNTkaLx311PEH5xL8lEZG4eLWPmKwruyT3NOWsnXjilfIJLe1YsTfxruWJKbqEF6hVkJ7aj1y67jR9/ug8DjoCGwoCG6qSqXbKd6d2TWOLN5QFaj3AWP81aFlqicwtkhA9T9vT7/Jr58qn/aWsgUci1ZEIr+UbnPKbb6OmhSfHniOnxiDIjnxy43fXp85uvgT6cVs7T+ySNFWisrdHcXZtWqvWRvtIy6qkCSLoVHIZYb3X45wnFoki1ofv1+5dPbwcCFVBuq1NKEAPJJnBWimHa5mqjh4FM45CXl37GHpmPackBigvRj5bM/KTCz3K60muufMQqbFXjIdLNgkS8hQIzPVC1qy8hV6YQ57S/cOurx0F5bg/GP1fvYv2nYX4SBceuztbYfOJJ3CsqinmJKN0NZMgUYs19uhDyyEQDXFqMRR0/8KVkW6QbeHOJnGe7FmZvDPFrooNR2Jn9jwSzeywMIXNM17spCb0nR0CvuT+Q+0fJub4S1Bwdq7X+SpdGrfMJHhrxLtlq7Zzr2qd8RV/zhaYk33zvAAsb7+cR3QWiCUKalF7YLCqhIIiWLo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/t9ccRGjdmE27Jrlrw7K0DkVhVg+KFMZgiplvlxVX6jw63sQPxeHsaChyitm?=
 =?us-ascii?Q?srMiiZK8yrFB+Lnb9OmpB5UDB4PP4ASIPEc658g+HsYGXIw3GRBOJbN51nQz?=
 =?us-ascii?Q?Zb5BiqM5xUzHP1Pwj5gp1c5wcaPGsqeHcKiOyRyVYITVyRDvvIv/UVdeTwDA?=
 =?us-ascii?Q?H2k9EaPennUK4kaxE4gYlFgIzZcB1EkzBwY1LYT/g8vDFEAGvRCQHGc1roBP?=
 =?us-ascii?Q?I2VvjXmePxnT4rZVgl97vsKbLoEVEVJI+MLlnKF+v517vEMbMsLo+pYPzS7k?=
 =?us-ascii?Q?4MbttEqN2sCZ2xERGM/TZOj5mjAdznm6z4sX8ZcMihZN9NnoyRd1KCkRKsHi?=
 =?us-ascii?Q?0oqTX562jqWbY33AmGV/r5pbIS8wEvt6v3/fMZV5+ld8lfQ7QQ2JC5SX9x7v?=
 =?us-ascii?Q?IdtI3vVrd2B//KdpOSyx55in5K21jf71O+KWoe/cucqE5vBKtiZNt8L73wGC?=
 =?us-ascii?Q?q77bLJ+9tI09K13WiKMYR7fXaQHqcwT4IBQ4G/PCLOg+OmKLln5rJyHQf/u3?=
 =?us-ascii?Q?OIb3lIwgFVIX20MAc8IoTArOmkeNpXMqFhPLI4siP9sT25K13GEy1G6fajAI?=
 =?us-ascii?Q?3pFVGKUpHucZUxZ0mU8yfIAxmZjbAbBE7Mb0xUNQJeU4IaiG2q2wO7qWSTtn?=
 =?us-ascii?Q?G5Ej2ZpCyMBORAFnV2n5VHup4qHncntn+tNPhKZyNWtbwBOWcIESxu30iUK6?=
 =?us-ascii?Q?yLsExoqXQuP2zfrNJcxeIrLzBvnFgDRNa7B7crvk8hmu+gYzbGHDye8ug6pd?=
 =?us-ascii?Q?G/PNJO98uj7dpxl/3mDyJOffevlTSMxaJA0z2HzHO5yUg1quPKoLHff+f06Z?=
 =?us-ascii?Q?9ZqAkDWZ4JXynu93QdSsvRJ+zsqIrd8C6IADpMGRau6u6nEEJdl6b1pCTkBT?=
 =?us-ascii?Q?Od9EgpmeAis5tetM7i+aKMsPuS/dOhy3JmmRUV2DxK+K/pASn8u6dFRVAKCt?=
 =?us-ascii?Q?rqqjHCip+b/Y0NgKhxagdcG0vXpdZ/EOZW2RK8BeVmeZ7h9wR6eoXWvT1X3Z?=
 =?us-ascii?Q?jqzf117KN7AGo4BdOulVzvEXr3vRw3BheL22/Wbb/EDa8ZuEpg8koAQ5o1/4?=
 =?us-ascii?Q?xS17O+BSMHkF7X8L5Bx26d5zfsB2/VWiik73UqGFtz1m2x8BW1TZxnPOeFx7?=
 =?us-ascii?Q?5spPYDXaQf4hen7fbpXBh+Au3u7mgJMEeiI4RnjugvxpAtdfjS6IHEI+CNAY?=
 =?us-ascii?Q?C1WHRQ2iReIROCRnO5N8wsQE4FrMoAuUBRqO7dnB5PEVrkXSEMTzhwdWO1OV?=
 =?us-ascii?Q?JyLauGB/WvTUbLRGYjBOBpPm2goY1qqheeFl9GZDzc6aR8JHdwy+C5uaSH5k?=
 =?us-ascii?Q?gLdCKH6IyQyZVKpX9ckAgRHwW6XN/LI1hMPkspvg0RdZz+X0edhOiT7G0X51?=
 =?us-ascii?Q?idxos9HUwAE0BDXScniR4sk9Ws9sv3ka0d4MhP+zGGBSrjKsz3WfXG3nW7jS?=
 =?us-ascii?Q?VW56HjrvvBZniPiyl1v370Athm6N33DY3dO3vUs4ordMQMBPSlDguPhdZLoN?=
 =?us-ascii?Q?uAKB5BkUD5IvrzMQ0hz7AZzmLs/No4mTuLj0QkZRGjxQ57lA/lTuWaGum1dW?=
 =?us-ascii?Q?owde0/8T+AbCC7kI4HUHrqbJJLiMpb90o6agqgyK?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb13d27-3ef1-46b9-b132-08db627ec141
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:15.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSaCirSIiqjd5eMB5T+b+dkaluRY2BMpjRFRQUAIGemE8LPMzC3rPu4rEQZFJsJJNZebdRcqiwmOOId1bGEGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 285b4770e..523cfb645 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -34,14 +34,14 @@ mips*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t'" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a4f8e7c53..b9f8c3f8b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -37,14 +37,14 @@ loongarch*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
-- 
2.40.0

