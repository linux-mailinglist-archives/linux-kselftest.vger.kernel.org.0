Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC304361BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJUMhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 08:37:45 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:37758
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhJUMhp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 08:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+lgdYpcL61s4wlV+dWOmbSaGvhQGakLa2sGEYUAZPiH5PgYRGb6sXBRRpMlhD4Vf0S5y7uUqXKxP3CnIq5J7CLDJ1ySM31KGFRr+4l8E6QEVb6k1zdbi7zW8swx/lfq6DeIjNfX2yZv3BbQsn7L3iCCeICGBOGxJymQt6u2xY2qHhku97BBvrQwcl+IplHVbjNrngN7iomx1cXh4Bms1dRg1RtdybATv2S3Y9l3pKyUPNMYtej6aYC60pW/VSiGSeYuGChE8ZO/WtDhoQO2vE/PUw3h1JVviOKPCs3as9Qu9C1rCvp1JmnbNDkYLRt8q7HPcYKvx21iE6tsmlpPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hqe39zCCZywYr8XLxF6+Tbp1aTmzVX0iqo1z3vYufk=;
 b=bpfApcawhL9hZu6PvxPrdDhmVbDQ08+YQutbw584pExAQIDPjSJKYH7nubzFLZN8xIxZtZuAKXlVpenaXd+AFCtCSksIOpbSW6AUR1j/GzI8E3Od8n2rLWAIlzaOje5ZhOdo4kbSZF+h83NViT3hYDA+nPsudZ7tcTZvlbg16ZEAfBop9lTsyOBReI6lS8l63VBoKROzNM+Nufiq6AcpHZSvRNCwW069s6ovaAlnP7o4UfQjwBOXSW86+pvDqj8c929biyZp5JoW0dGP55DrVHbmmcsNo3VvuM68/0FHy5EF5RvrcaL7jhD6e02poVuX65izqeeAM0QKkCnv621EzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hqe39zCCZywYr8XLxF6+Tbp1aTmzVX0iqo1z3vYufk=;
 b=J7PxOduijybYM8LzXQmKPVyUWnLuCfw0eON5/aWIeylq05BFh5RAjzcC9i1aRMenqIakoUMJTRRtxK9x0pQc0HcvpIHcNsKsexesbb8w5GK3pPtqroyX3a38UvEDgK6/5JXzQN9osLQaJaCzkiuOK/FhnoUuFxzd9GXTQzJpKMg=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3046.apcprd06.prod.outlook.com (2603:1096:4:6d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Thu, 21 Oct 2021 12:35:26 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 12:35:26 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] selftests: vm: Remove duplicated include in hugepage-mremap
Date:   Thu, 21 Oct 2021 08:29:44 -0400
Message-Id: <20211021122944.8857-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:d0::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HKAPR04CA0005.apcprd04.prod.outlook.com (2603:1096:203:d0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Thu, 21 Oct 2021 12:35:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749b3e10-8708-43c8-02d0-08d9948f4209
X-MS-TrafficTypeDiagnostic: SG2PR06MB3046:
X-Microsoft-Antispam-PRVS: <SG2PR06MB304688F172FBDB5A73EB5A26ABBF9@SG2PR06MB3046.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFhqd8dTArR8BlbWdzPoiMjANjT3Gz6WQZMAOwgYbWLOyXHv6iqySHaAOY+F9gxsySP7ce66N8O4UP9J58TEl1U72bXvKVKrKLILwtHdY3KdZI+tvPypcwLP3w27U3PZfSsHMmCih/L1mhFGKhUvVmnhN+jveIGiKYBxnHu6uq8WkMCX8Y9L/eX6vhD8h/yCiJGph59u+pKvBwnr5ANHsgi+sPbn/PcS67Z4Ume8rpkuAXfl+oqFQbeg6FHuyZgkSBTvdxJD2C3ZMGuI0B5pBAUSUtiWXrntBNzgVpVRSp+AVtS6gU/hf2QQiHDeDmd1h88jVtjF6Zkm2BVed5Y0Dsd+eeUfNTxoHJYEbaleGvnn2gzo2SYSNdWQzQIJWVWiPD0u33KWH/U1gpzYxk2RchrvhuiByDUcaEhdFNCLtkwofJI/GXZk5dBhiGlZoC8ygQPkDeiay6JEquZF5U39FZ1lHqdP2K4+Sfg+/6/qu7EKycbp6yISiccndxCr7PMDmUCcMQ7zUVfcJqbhBcz+CDym3mXZmfOEU2AE98KJG0FKEjmD53wQy9t7wr9PdzKgocDzTkkgEWp9slPLP1Sk3Om+7czizA7hK2UVBEHjGx4Ir0LQcCAxXWaIrcZovFY0jrwwtQAigNug/Yu0CDuzy7P9uj5Snfquc/LwT+rmeqSWTTHH44pWeyBvfX3TbG1kdqsuBZyVs6JHlsChqrcYfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(66556008)(66476007)(6512007)(508600001)(66946007)(107886003)(38100700002)(2616005)(4326008)(38350700002)(6666004)(1076003)(6506007)(6486002)(26005)(110136005)(52116002)(186003)(86362001)(4744005)(956004)(36756003)(8676002)(316002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30WA/ywxCAOj5bB+rRBls+mZ3Hw9ZdruvWZJ9Bs/p9fLiehVa4LueXzEvyQw?=
 =?us-ascii?Q?q+2ZHvadYHb2rLVRfc4mn2rugc0rVwF76qqI3zZwL6PeGXqK35GeiOBPbgGK?=
 =?us-ascii?Q?iDaLyqYV/oQq8S22MR4rnDPgpm1IIbImrSy5xb6elziWOkE1IkxNp9AkyVKo?=
 =?us-ascii?Q?WVrgeXRvXs59fsGlmreh6tpjPpTVnsv2YR8z6gIUAeuWHkMjFLj2hHUDoArx?=
 =?us-ascii?Q?bjz8ypyzGpAdzxFIIi5o6JbXjUUc/lAYi+SaStrvXLVjDVh4oNqU2O+knEY4?=
 =?us-ascii?Q?PzDoQ3LmoTz7LzwgE64OiEC7pM1GkJg7BkM1kvK3JIZ0t9zQe3F97C/KjfeC?=
 =?us-ascii?Q?dikvZ1sgn6WpwB5Plx68+VM3k7oIQ0/bRUOldic7iBnkb4QqoA9vutEXCTFU?=
 =?us-ascii?Q?0oKtfNHGges51LyurjJ7FS6MmS/DpDjCqe1E4StE/GB2VLE9LJx7ej+XVmTJ?=
 =?us-ascii?Q?C7sPb7IgXG3BgTEiJR0NnWvUW52KcnvDQApPmVXo0qNeLJjhiI7rqHgjEV6X?=
 =?us-ascii?Q?5K5+HUVoM7lzT9AtHlpz5rzYkR6RnYccoeJQNKA1TwTYZ1KLrkxrF87ZvZVq?=
 =?us-ascii?Q?NxQOGHx0mxxaGEOqOG6rrbo4ayFqpWSb5A80u7aZfcHbFhJhIy6uAytQg/KP?=
 =?us-ascii?Q?uoDW7XgbOS2rYvXEmyMAMVy5wOq6KZNb4axNay1rpZwfT+WOYk5iRX/E/agE?=
 =?us-ascii?Q?XoXiVIG9uj0MFThwywgpY/q0KnW7s3vY5+1pYdSEjG5qsY6A1jL84dThGhVY?=
 =?us-ascii?Q?Ct78gu2a0aISna/aE0pgD93ddaU5F2TCrnpubYKuF05xTN6AyBnxI8K2lmiy?=
 =?us-ascii?Q?ZoYp1dtC0SnDHZE51r/sQ0Co0T6p4EQYEDQ2TWHFJgq2DVrBGw7Itf0OWVWw?=
 =?us-ascii?Q?EEDk4ViFaW//10InMm6KQF+uELLHxpHfvXb4aKkDn7UWdO5BoB6g5hmROsuP?=
 =?us-ascii?Q?lHFmZ1AEjyiQm5YYlBZBIWLd2zPe/Mwb8h0MFMiOwfVv3r8CF03MfAb4fNrC?=
 =?us-ascii?Q?Sm0aPmKDroyWnGLXluqF5+wdZ596cjAboxhQkTXqLJLgyShvXoDASkj17yOu?=
 =?us-ascii?Q?I5xKf7FIrKUivBJ2HWkS1HISY9917xh82g4hvg2vm3M0JJy8f9ugONjO91Uq?=
 =?us-ascii?Q?3D0YwqN8+xL4wZzrA0W2FcdNBWuFPhw0zCtQPp8hy0JmRX5KhRSRykcyfgxL?=
 =?us-ascii?Q?Mtnig/uSZRzN9V3RohcImxMHVhsUvqrVLR0RsuXXYZ8yxUjr4Pulj8GZUNXP?=
 =?us-ascii?Q?lDEn32LWvD5DnPsmCVah+RyAp6lsHkpEuCRXmMf7IfRau/3YmgM+IwFhBO6x?=
 =?us-ascii?Q?K7Ib/fLeeZy403XEbITRZiG9zG4p/JAYZ/PaCVM5rqnKpM5LlpQufDu5wpLa?=
 =?us-ascii?Q?nuACrKjKt4N3Zdq6gdq8bQtGNBYUB5ECMGdzpKqiz16giQaF3TUCHMcOUFaK?=
 =?us-ascii?Q?zPhc5g6rkwQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749b3e10-8708-43c8-02d0-08d9948f4209
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 12:35:26.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11126903@vivo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3046
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix following checkinclude.pl warning:
./tools/testing/selftests/vm/hugepage-mremap.c: fcntl.h is included
more than once.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 8bc117b12f78..257df94697a5 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -12,7 +12,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/mman.h>
-#include <fcntl.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
 #include <sys/syscall.h> /* Definition of SYS_* constants */
-- 
2.20.1

