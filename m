Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C6749420
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjGFDXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 23:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFDXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 23:23:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CEC1BC3;
        Wed,  5 Jul 2023 20:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZeeqz2PUf2wXo5MdcMz1TUIzG38Nry1oEZSjMRe3CIgfzaOl3gQNfkp3/ep4zjn1O2SAg4dkqw34a+Q4T/wvRzOvxQXDcbpq3sPKAqLK+oTi+7D/76PfgOxHmd2OyPG64J1bGARglH+UlQMxr/7IJqu4HhiXyvCdsEmiH1Fv2KR2eoXGDmjr7GrClKHaa1AJdM78Wpjx+FdlyQqBua7XkYN2xjLX6pk4qG+GrZvrR6Zy5vvUja22fwvFUkL5S5+XZ2JHbGL0FAwSlei/nPbcvVd41whfbn0ezDe0AhhPjRUEo3r1NYl9a0hPZEl0/nq88bW3gz7TQ++79vb+G7f0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fXqMAuGgWsWpMHc6eR6GFeNoMEn5c4MVLl7rQGKEes=;
 b=BZ13Ytok6qeeoUmmSBhvdnGFpFudN/gf4pfVWjmao/ft7zcTRW9YIWjRy3OsEJD27XoqFl7SwkE714HodNFY9gqw1NY210xIEYR0eX5nd+ztbkH97AH/PllIlmjX22oT9vCJ2DGurLFlSKd6tp6+X42Gvg81LOOxBzk6mQYVXySie+E37zWWX+B4sarfXnUpHXzj/vQKO+g5JKI5NdQwDpek2si84yPEPXEEEWNwwtikiRhawuQ1sEh1nuWkcQQx1Z96emaCoJAQxiPa3DZprsExtbVC73fhsJUeGP3jG82ZdVGqACxxWe7Z//IoUndUv6SGdct6T4BLAKgtebJOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fXqMAuGgWsWpMHc6eR6GFeNoMEn5c4MVLl7rQGKEes=;
 b=fEwtc8GRpXYRFVLVFv1vD5oH4czlOM4Te7fVZHodKfSzjSWc1cekyjiKiZIg3diRNQuN8n00SGV2JV44ezaIKBFm5tw8PtmBRe/tKfC1FWKlvWF9K/n8Y4X6MZG5KuGATx/731egHtsYvnZ2grPltIgWtQH8pc4SN1RqTNOP1k4dfI0cu8nlOJxThowelnQpq1hSHCp6jNxzVHb6G9UM6cyBxZxZCoKRBcTfUhecwm5cUy5vWlEiRX7b/ZySfjJWfMCRyLOfw0xENGjWQ1rlcv/llD3mOlWcvwExhiLmGmxkpxymfSfUqo2RzjhXsOK15E3+gf+brDTURlAuwPhhYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4483.apcprd06.prod.outlook.com (2603:1096:820:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:23:09 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:23:09 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TIMEKEEPING, CLOCKSOURCE CORE,
        NTP, ALARMTIMER),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] tools: timers: fix freq average calculation
Date:   Thu,  6 Jul 2023 11:22:57 +0800
Message-Id: <20230706032257.1662-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::20) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: b0254a2b-32fa-4f8b-ab20-08db7dd05270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkRtRsETtO7wG++sO4xgryMc7bPHZgJYB2VDOtAIJ2A32G8qrZloYFFxQUOSS/pYwCN9bhEre67NFdIwCy+xEk3Ldto36BtEeAISXdv6pfZjSPmrqKgoF6w3Y5kvpSgxSEyTbB27WB9Nt2QGFK2fVHmJ7yO4/tZT6QZR3YYQz4femQXEZZlsz74JjmrH0Nj5889IiBCxLZoIbJEvDYURiIdUbaY7Z/ZTID1YKcmeW3RZyWesn9M7t/+Z472CdDru+HBEcTFwbnYet8EGyErfM6DoVfjeqxe8Rodb2uG+NoYEF17RDAcn9Lo1PgpwBr02xkhOLN43qQItgVAEa+dX3MGh4sDnQrf5Q32QDbCB1AUFtddt88Fmox+sHi0Akp2awoObluMDrpyDToEDh15Bp3FJxU0WSFDe1TT6iGMR1J1tfzRf0hL5tBpoPAKS812guU6Q4OFFIJP2mWJxlaWPWBzb4QJiotvTlp+E3SaQrHrAoqmekipdtZntFWoUFVNlabeQJkfMZvf8Z/jM1wtbbD5bOrEksJphofax92N+zKa5heDFnJL0QU+5EgofBYNRKq53asOFaXb3SGiZv5LI/9ABdgAUyH0aMykKhSRtjM1RUxdNeJ6vjEFcjFOFw27k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(66476007)(4326008)(66556008)(2616005)(38350700002)(107886003)(86362001)(186003)(1076003)(6506007)(26005)(83380400001)(38100700002)(66946007)(52116002)(6666004)(6512007)(478600001)(6486002)(110136005)(36756003)(41300700001)(4744005)(8936002)(8676002)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+c33Wy5dlXaWooo77HIjZXyqSkHzGTqjTtl/esI0wxBSVtCVhcX9eK67BWi1?=
 =?us-ascii?Q?d15j7Sr6yWHCzYzLoPpu6y9E40xOYA/JqMm3XMInMTG/RqKi75PY9zxXAJjC?=
 =?us-ascii?Q?7Txb3s7C8hGJQJFpxvUgOkMUZgYhb2HofJEk6UTIbwXZrMDpteJqUbQ/1ied?=
 =?us-ascii?Q?XdzsKNLsVtNlUjA6OmKNd3VUWRMDN+MNYeDhOYVOxvOtHtNtKIeS1DndHGop?=
 =?us-ascii?Q?LfPS0DZVmQduwP2rXMxUIGHeFNK30VmAgi8jvHbm5QfmYFV4d/AL7pXGbFiA?=
 =?us-ascii?Q?eGlXTvSUucRSJ+GS+v6o1Wx5DDOJv+yTPVVE3RtUFrgMTLJLJYPJTw7bYttU?=
 =?us-ascii?Q?svf0UerEexIlrpLl7Bh14EfT33cKCGy/V9N3y4VEhT2eXP0DDw0eMbZS8Il2?=
 =?us-ascii?Q?ZapjBif6h1e6yTZs08ymqSHE9f//U/frJq0yRJv6KWqhb13cLFTkzSOhd3Dl?=
 =?us-ascii?Q?0WlUa+A9IiBK1mBhddPRBlu1k8d444Z8ta5N4T5iXmMWYa7+IB/euu8H0uOV?=
 =?us-ascii?Q?HrZ4QaPkdTW9N3GHHucqLN6qAJ8QMV46JU7KmPqgKwoD4vXttgatQFeM+FIQ?=
 =?us-ascii?Q?mSieC1L8jax2cGryq9/MeD9qcvsXLw64Sjl+uvVz4ZqD4kk80pD7DKtTWAHo?=
 =?us-ascii?Q?wr69z4Sdu7qKe29/VCuBpH1ihWZ/c8KvukPGHn/MTrwYfaLqjL04F3cOsS1p?=
 =?us-ascii?Q?lQLdng25Wcwq4voFBkR5NvnC2Ev+BA/DyeRyeqI/0oE5hK7adTQGhXgkpha6?=
 =?us-ascii?Q?7kAlDm9TwvM0z5Zy5a1Fi0qEwMEStRCoBYMpwhrIy0AN2HxWnqCzkVUiqXgP?=
 =?us-ascii?Q?RCJcMxG4v/MJtpJ/gGPje/DnZHfnYCDzXxuYuK0v5TwO9vpSzHTC2k9WBW19?=
 =?us-ascii?Q?HPcuqDy+cuwwyJ2LyIXk9aCY7t+pAISOxLwEuRKe9CxeyzLIFSpQHxGdhHJD?=
 =?us-ascii?Q?QwhJMRYR1oXPy2BbCHB2KleVPbHrsB5L/fT2DMkjfpqXJLS9RTfJz0ZJTlk+?=
 =?us-ascii?Q?fzykEb/YW37Jd0HwmXjUUs59JL9J+IHQGntV3W38k3u6FFcPBrU2agn9GVh7?=
 =?us-ascii?Q?95PPiKy71pE3TvJumiL7LoiKLCT1OhR6YwFKeXWXHMJ5/BrAQ1gCMH+zD9Qb?=
 =?us-ascii?Q?0TyOdkT+kNEppcKdGS0fDgVQG0QEzxjT0EdOhMZ/ew+uun3vuFwSiNCmL1Ve?=
 =?us-ascii?Q?NXA7gZ+f/7ldqP9yNzou3afiCFoP8Uviadi5GM+Q7mO8MxP5h/vg2Jvuv0X9?=
 =?us-ascii?Q?iB4FxIcaF1jOJmELTycUDdYHhXVWVT4Dwrx+2pU5B+5kJ7mYyMJH6tVcNMzk?=
 =?us-ascii?Q?WUkzRkSXasdFej9yLb0KIjir823e4asyCHY94Zmd/AIyZsTezGEKNGWjHr9w?=
 =?us-ascii?Q?0xGVMdYfJM3oMAYN2TmmsobuiEPnfS9a553WpiiNNM8y+zQB64CJ1XKlXF8N?=
 =?us-ascii?Q?LRSgYgNpSXf9H6QlD8tiaIVxUEF9e+uFG5QoB0lrULwbSHfuCqlTFQHwHca3?=
 =?us-ascii?Q?zmUyksvR63PdxBO65Zfz6TKxfTQJCgTGgoEJxeH1CbgBSutVz+Vv609SDNDT?=
 =?us-ascii?Q?mKZ8gxQ64G03EiNLc0vfJEZZVySDslHtv2aVHXu7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0254a2b-32fa-4f8b-ab20-08db7dd05270
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:23:09.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Micx05XX1kn3VBFt5Zm5+pKQ/wiG0JZfgpOrrQXW4QOgEvP2ZtEOQa4oVuzFqVO6CWgqUdGpFdB185MqFgmjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Delete a duplicate assignment from this function implementation.
The note means ppm is average of the two actual freq samples.
But ppm have a duplicate assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 tools/testing/selftests/timers/raw_skew.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 5beceeed0..6eba203f9 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -129,8 +129,7 @@ int main(int argc, char **argv)
 	printf("%lld.%i(est)", eppm/1000, abs((int)(eppm%1000)));
 
 	/* Avg the two actual freq samples adjtimex gave us */
-	ppm = (tx1.freq + tx2.freq) * 1000 / 2;
-	ppm = (long long)tx1.freq * 1000;
+	ppm = (long long)(tx1.freq + tx2.freq) * 1000 / 2;
 	ppm = shift_right(ppm, 16);
 	printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
 
-- 
2.39.0

