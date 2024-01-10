Return-Path: <linux-kselftest+bounces-2801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF4829C62
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7741F292D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6624B5D4;
	Wed, 10 Jan 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jc0ZX+zq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4984B5CE;
	Wed, 10 Jan 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0uFQcmsoR17y3eFt+hGyQpjfcfpu4AOmrqClmsjNqNunkmOZQ2GIMynCg5Z5viNsqtZtsJkrmWEAysweNNPB6tsAaHk9lFYSgcCSdQXszGK5GIiu/768DfU484N6isk2JD2QZMF/Ch9JAcF42q+xq1X7ksAE8vsUliyArhBm0Kf1icggFUFsYIr0FLFbz/mKC3VgDQo7J1zqd9/AfLdDfGmXSBQSDXV1Oc/tYlT4jGFHzfkJo/riEwasWnZadZzLMJsjn7rqGRSNXKG8COiB9/qKEY4l4F2rHcTVyARy50qXU5JDCsbjGGO2ghRVjJzfShargFLtX3NDgRdY2NAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crsgrvP230gqXiD5LYfYxtY1sdIaD5i6UExCS89pY0w=;
 b=GVsmmuXQDx7pCfm9SGiorly+hAuctBETOVK/hx9QeUWpeFRd07Gxf/Jw8zh7cK5Mt7vvZ1dQ03lJiFgjRESRU0UMRy0I5vjTXGjEBu1nEUZd5LCDmgiwCoZw80BjP+3UPqnn5UpXC7fgNYu8eRRNErVoJfmeKO3WGS8UB/dOqnbMpoMUQbqJBRajb+QTVUJErjekpDoU4/xcpel2OV3SiHYLnwyFNiGbFekneulyiKGyv03KAIS3TZ2xC3Bx6NssJN2t7E58rdHYJ76gZ53rt67ptpKUVWUMW9HA6dTf4ZqeDiYBMKop6ZxTN7ICe/qpNkR5Dnt7fbXEW0rdzwVPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crsgrvP230gqXiD5LYfYxtY1sdIaD5i6UExCS89pY0w=;
 b=jc0ZX+zqiXC55c+SaaLh36J6UrSZS/UY8enfRwLzLbcA1xORkBBa0ZbG+VoBaFmKRoHmt6SSlW90vIMIQhSwxEftaObPaYWTF3yT9O+Urr7Lx2XL0upuGPrqeyNd7ePvMhJiDZRllMYXtW9QiVy2XMi4iNgXoSI9rsOqiHworgVbkVLpprKtajLHRsvm/5/txGPWKk9zLYgRZem16CbaDBgfj/Uds0u8ZNYFJ69c3dPPDXg65Yegy9VoqEIZ1y8W/o6/GFPGEMGIz+EU2+Eugs8gcwyrJmKVkPozqpy4CIkhMsehz8umwhjhHG0mz5dhs3XcWXCDLXM3t/b/Gsbh3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:16:16 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 14:16:15 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Joachim Wiberg <troglobit@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] selftests: bonding: Change script interpreter
Date: Wed, 10 Jan 2024 09:14:35 -0500
Message-ID: <20240110141436.157419-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110141436.157419-1-bpoirier@nvidia.com>
References: <20240110141436.157419-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: fe892b48-ab35-455d-b932-08dc11e6b50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fV1R8U6jpj0e7I/UCqM5BQfS8cJgtoaD6z7UyDZdd5Sts5vxa6ZlwxkvM+r1YP2q9OkU4VYhsgkqzzRVSnl/BEch5wQytAmuXmodbRlSYJzdkjH8yP/YahEpll7iCaU4CCncmMTDdZF43WQLJLGnHQav2W9UIo7kNEe+KbRqtdMZufTM9E0IqZnaoAawfOgaUnUv7woX39Us174Fnhbq2Sv+lpiCOzB7bLG/KVnXTy8x4lAYvrc9yRDF9JZSDgR2vQcDm9UqZIhKdXMnT+pvjJ3f2bCUyIkm4lSsmLBzePm9rZHe9lsthHrLDlh7unzlRCSEmEF78J/Bdy6w9/jtzyZb36FOLEIC2hdrkP1Tfz8Vs187VxN8RuPGj4YHSfIQtb0XZ97ltJi1m1jHf+uPmTfbgmE7ixKwY8411a7prINCRkTujf+iK7qqUIy1Uh7FWthkUm6PZTNfHaVVJfFgmIAsMcPoQvCO8KFV+86MkjJaSUXwpE1vyWoVyc/4pMf++acwYfVym/TiNnpnxtjwSR/M03nO/DWfrzWn3I+oDT4wYqqHuN1Q5q1KYdcAahux
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(478600001)(2616005)(26005)(6506007)(6486002)(6512007)(6666004)(38100700002)(36756003)(86362001)(5660300002)(2906002)(83380400001)(41300700001)(7416002)(4326008)(66556008)(66946007)(6916009)(8676002)(316002)(54906003)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Qf1KvzoC0AmQKjOxMTVwr/yyvs7vz1rTDdMSecRVShB54K6ElSze0DWEHx3?=
 =?us-ascii?Q?mNy9hBu8AH5XaLwnnq5zaYVl4pnB+jDs6PCOTwTFIHmfKcNVL41fvYtQil2e?=
 =?us-ascii?Q?mTQvYX15RQQVfgcWug2bDiIrXMDcr+uBuVQzoNbgIVQqxJVE7nSw0w/UICSF?=
 =?us-ascii?Q?zDAxAW5DhyM44XLfZFUMjK/X1bXrkIQK58fs5ppwF4oLvMrBk6dWCEd3RTS/?=
 =?us-ascii?Q?jNA8F4wtBnP1v75xh0Ibo+UoSxq/PfL8lMLI9sIyGPh2t9N+8E44NhtkwzmN?=
 =?us-ascii?Q?hSODncCRqEix3RZeMQa2kBBrgiee7EHTZSOpvIWa+sxjDhaukeuEyPjnhnkw?=
 =?us-ascii?Q?e9EBYvRpKf9OP2HC7sx7DZWXPG9fv/ofCMgqIteL6WOs6pMX7rLUv09se8DB?=
 =?us-ascii?Q?W/CFHUlPAUXipBTSqm/clPkshApngM4rZpaAGkYrIPNTGsmUbrUMT3ipIBvW?=
 =?us-ascii?Q?QayRptUK0TRpRxR3lSCdQEabOMfwGiMCWgvU7p7RmSotyouX1/v8vpIvDHzW?=
 =?us-ascii?Q?0vE0H7TGmz/jPvEXs1Fg4uhXmLHODARw2Fnzbu453c8KvbA3FgIBZ7AuM7Xe?=
 =?us-ascii?Q?6DVChCYonvU07c4i5Hh34BwereGYJYoVLqSuIiLLoOk6h7RzpBxL9SPxKk9L?=
 =?us-ascii?Q?w1b4UC6RjcI8LzLK/PhzCIAsVMk7oBZt5cc12afU89r+FvMMT/6dod/ULIje?=
 =?us-ascii?Q?baxfzbSgrYzzuCzFkH0hyRQXYxtyCoHfWTYfkt8XBOzuJ35hQ01R7QW0lnus?=
 =?us-ascii?Q?/CoGX8z6DdABnQ1rsonVe6pZAqhmHKp82faAb3JUTf4RPw5/ORA7GSUx6hgg?=
 =?us-ascii?Q?nS/edBD6aG5Nf9bhQ2rjeVI1rS2MqXiv8fkgx1Cd/nJRNvFrp8ALiGHHH6s3?=
 =?us-ascii?Q?Er2VtbmsWByuNuJnIgvfMBNpNXddpaCnw5jwNJFWNg21j9W3bBHW4ek7h90E?=
 =?us-ascii?Q?2XHHLedlKfEzdp4dpKDEuLSIErIapQWEUelcGV+czVLaDO56LK73jbk4qviv?=
 =?us-ascii?Q?p2sduQka45t5zxpQv73b06PgWcJe45e2zq2moZWbTZt54NoaNlFeiGvyqpcd?=
 =?us-ascii?Q?mc0aKxn5fTgcFHwv4cE4GeHqXROBRpEvm7N48T7QfqGWPxZitRJ0ex+bqWZK?=
 =?us-ascii?Q?GqC7iih7zOV8UvUg2iRPG1jo9Tj0pdXBQ0jCu0YxNFVE/JQnD69zzxUxFm84?=
 =?us-ascii?Q?1oXzcv9TqGghibQPgR/zlE7u7GtmNgQQPgccFcoatW7LaACx84CT4B93T1dy?=
 =?us-ascii?Q?T31a3kcA4YChjjTAIkd3ScbXFv9OsvD848xTtfdIPhjmN4gLehmPdCpXio/f?=
 =?us-ascii?Q?nNvX/bBFB9/KKByP1LvFTMqPQvzVZmMN8DDaFrA31gcJNx8NQfqTmuXTjf54?=
 =?us-ascii?Q?93fD1qkwPRFhhlTRXLTSm4gNCj1kWlg2YtoRaN47kdOnXio/ZWnJvDMqnttz?=
 =?us-ascii?Q?hUf4kaYFJTBi6HhdgkPvP58Sqe1jx086BSXQRW/nxbJUYo4aSG2prLoz8TlH?=
 =?us-ascii?Q?TFfBYKjsp6KhvpH2jrs3hwg7NliSzMbncQog7oAAgE4iTmL82i0DHa+Jz5Lx?=
 =?us-ascii?Q?Gc+CN11xf1S7ZHYn5vHtr5z20j/eXM2RGUDi7wP+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe892b48-ab35-455d-b932-08dc11e6b50f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:16:15.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la1+IKN0k55ZuW/odOuesxs0AXyJU7ZRFYQFHG29azxwMYIHzERSK5EoVzb9HST9Vu/AiechcKhsBFTF6heaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

The tests changed by this patch, as well as the scripts they source, use
features which are not part of POSIX sh (ex. 'source' and 'local'). As a
result, these tests fail when /bin/sh is dash such as on Debian. Change the
interpreter to bash so that these tests can run successfully.

Fixes: d43eff0b85ae ("selftests: bonding: up/down delay w/ slave link flapping")
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../selftests/drivers/net/bonding/mode-1-recovery-updelay.sh    | 2 +-
 .../selftests/drivers/net/bonding/mode-2-recovery-updelay.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
index ad4c845a4ac7..b76bf5030952 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Regression Test:
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
index 2330d37453f9..8c2619002147 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Regression Test:
-- 
2.43.0


