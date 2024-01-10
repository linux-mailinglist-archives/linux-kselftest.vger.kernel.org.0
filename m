Return-Path: <linux-kselftest+bounces-2802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2DD829C63
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 15:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788D9282018
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F04BA8F;
	Wed, 10 Jan 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ovzfm/B9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCA4B5D7;
	Wed, 10 Jan 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG4SGr1bjZJeYd9r2/++fIZMDQSKGei8DHOZDZP/9LeNmKWdCJTURbBBAxLqk2S+1sfoO2qC13zlncDLHSvgI07yVeNMMyI5Yk5WShQd20ZUEFZd3eBGgYkEVWMH1KCftxsdv00qF9u/TCkLKpruejSs+/mrq8W4TBYmWikCZXF72ShgJf15p4QlTH9LBtK00Ok8gpR/mFmaJJeYfP30afcXJ5jZLTvOrgcytZ+Xo9+7EeYqgPaSsDeK+/pUwCgx4aI/q0fpkFTTmgb2UiEBIrfKCGhjU7FMgZ24/iW2N/DNq5L7mkhzwMM+1Foyf2WhNX/lFArkES/37hAbm3n7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16bJhOQfoaU47XDSc05Pn24zykRUPgBrAC5tZ803QX8=;
 b=fGlGhnWXKfoOS5VIh6ZiKk1763fWfGERfHVqago4xW2Yh8pnW8Zi6/e0HRppXEVyS1YhpfVTqaZo1Qc4LSqZrEqfkCxm2yVHtraMfs3RUj5JnDQIrCvnx5gAmJUpYGBLAa+CurNNgzZi2ztxuD2EmZwMS3pAwerYXaYYFohfCBgSq+EEYxzeDfoH0qKrMM2iXveJ9ObMNaMiKniMPFfylYqiwM0v6tVpmuVAPRJoUYH23c52CP0BEj13tMbwrajLg8v6gLUzfX59KbKAXeYDwcFB7+XXhfmdIDBH3LZEpLb47n5uBhmLgHP/bR1Xo4KzdOOD7G1bd2cfc6pPNU/aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16bJhOQfoaU47XDSc05Pn24zykRUPgBrAC5tZ803QX8=;
 b=ovzfm/B9YsGmDN5aC/fjlmEw/rWdAJD2uMjpjJGwGMIlSlr+0e2DTko0pY4WbW8C7b1zskM1lWP0FaniYwxTnck6JspUgYcCPhL1DUiSCvUrRyQh3D15g5hqbzQ78NYCkscQYUYa/wC+u1dSmO85+0UIxzdsSsmT7ZrhMSn+8lCHOezXqkL6HENH0svryOvzzicKbKE8JDW03GeGZwkHNTTEL9tTMTARB9nGspoVzs5j5zSxR8ZzA2lrguoZx8DHYy1F4xpcZdZCdTgdNnmnF+m7MrQrcALmShHczuGFWSRKLLW4rRfm/rycyW3yjr6ZpzxkzzujW6Lx890n7O0rqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:16:20 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 14:16:20 +0000
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
Subject: [PATCH net 2/2] selftests: forwarding: Remove executable bits from lib.sh
Date: Wed, 10 Jan 2024 09:14:36 -0500
Message-ID: <20240110141436.157419-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110141436.157419-1-bpoirier@nvidia.com>
References: <20240110141436.157419-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: fc22fba5-fab4-494a-9d5f-08dc11e6b79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AFltlM1rJXMBZeZywveiUxSAX7A576fvn8JEmRBco6UVd0zCZltnYmM7qPojR8dOJERyAxr+U6Qb9bwJeh9W2cakv3MxkVZLTcBrodPnVookexrsLF6xkktgpxGqMgppSMGUD/U50VHTOa5XyqGtZDBb165H5JEAWyq3NBvFwnSfwR2mp/U4loCTO5rXUtDw5+lpFPTHLe5CgpNpqHVEOa6szlawNFSKTRXyI9+sSpb3UVJhjizDsrlEjXxRsdaUu0AGo0Gj2nVoWGgmTIXvZDWZwTgNOBLzdBR/m1LU2+aE9IrlVOtiEg91uxBKVj5Sx77gQ6A6z/hW+hmt2PTy27XbksLeyrPAQmLt0WYt8Y3QRe12JSjc8+Cjn7f6Gg+u2VLIM80KUoZIeM0Js7+R8bMloMyJZC5kZwJcpsTXsIrDKcZwd3f4rK+ZE0LrZ0pqaGjINZX1VYLduXfVJ/BMlSiCxeWGzfnJkb4HEsC9Fegy1/hvNzvTx9D7gZYRWuRN+o+oLJdBnmu6CtAcVdP5hiXYo2YZL84rANxh9pjE2peRBc7NrjH7erZFOHAxI3/+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(478600001)(2616005)(26005)(6506007)(6486002)(6512007)(6666004)(38100700002)(36756003)(86362001)(4744005)(5660300002)(2906002)(83380400001)(41300700001)(7416002)(4326008)(66556008)(66946007)(6916009)(8676002)(316002)(54906003)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1r0ECqhK3xnR0wBkQ4Zl+wls3Fl5xi+JOE4gXRqYA28mQFHNpVYBXKr+ELp?=
 =?us-ascii?Q?DacPpf0RSR8LYMESj41jsJmsZZTB0qXiOO0nnB/XE0cbbOUzFmzlzfrgR7lW?=
 =?us-ascii?Q?L2Tbmxf68fhGRexT0o9W/I5FGyx2vJKNDINA8Wor8I0lWTjyG3ySYNNNs9q0?=
 =?us-ascii?Q?/D7qGECC+NQhkRO8tu+4Set7Vwd6S9mRqIyp65VKW6yjWgmJ1LnDqCf6haWJ?=
 =?us-ascii?Q?uqQHR+bhEabpYTw4MAQUhiX18f72NyH/dYf5pjW2b183YBeqYV7Qahd1Mka2?=
 =?us-ascii?Q?lf0qpjzYnVHeMgiEASRBiFahWspjedCgxBXMuPGXtifEyJDjLZvGWay7HPO1?=
 =?us-ascii?Q?wWVB6TMOvVl4hO9qzj6GemqD0eabjszcEnjVnq4pDw2SSb2CIrVvoMya7Iap?=
 =?us-ascii?Q?jmXPh5QQ2yz03hb8/7scWYEX7DsSOEzaPRvNOAYyJQqmlwdOS7UydufYIBhl?=
 =?us-ascii?Q?ROL3d8NUvJiG9MJ5graK+ScUZX/H0fiqK9HpK5zXKC3fU7Opu8wDRq70A1/q?=
 =?us-ascii?Q?qw4rnud5H0zETLRSJGWbY7RGTSkNdgplDFKiWBzsCyjZojCilZKfCE+YcSjv?=
 =?us-ascii?Q?TsJ7UJpKK3gG18dEJOg2sb7cCB5pCQYXM9CbGVWvWfWMJuGcRVHkIDtWLJjb?=
 =?us-ascii?Q?OZ/bBEhyjPGU3nwTr6tAQYusBCYk1hJi4kXefYpWvFXNtv8naXFGFGlY43FI?=
 =?us-ascii?Q?Ku2EYr0hqVdUEcwt05aHuh82AE2gcYKovPatdoeWvmdqX9WJTANQNg2KZkca?=
 =?us-ascii?Q?N9Ej3ZhGLa+0gx8HyKAAHtM/N/WUiko2994IPQmhH23ZiVV6TVbBmD0XZRTo?=
 =?us-ascii?Q?d447D2SGezeG8pkhNRP9fr5AeMYF9bjIk+Whp3aAfwT67wC44d4HM1Q+9V/d?=
 =?us-ascii?Q?oKkHNEs//OfGDbbEdM+55T4yz7/JTsDq9mL7jqO8RYqbs4pqDRBDcP/NoyQO?=
 =?us-ascii?Q?Imd8iWS53GcoBx+JOzFRKfH/l98UZW5bu6lXwKkCiN3WucYnDpvVkmQqyCrH?=
 =?us-ascii?Q?J84YFyuOkfErc0uxo6rXwGeTs8lBr/xq1EjvtE+Ocn+teonAz+Umyuop1Oi2?=
 =?us-ascii?Q?USbI9sZB3ZK1JNQlA3xFvP/TxtQ0zG5vlGujVX2q57lGsfYFx9Ngqhu4+oqR?=
 =?us-ascii?Q?nAECmSqIvuFjFoQIJShspe4MW8vR8OEUTd4r4RhTcRLfDvqRPNkZmYN0Gsbx?=
 =?us-ascii?Q?XJuXgMvtsBdB22DfOyLhJAxG/wjtuPhc7WwwXyLkAWliwJMx4L2q1DxSdeBS?=
 =?us-ascii?Q?CxLMchSW6+7xxXIvc2uNZV38qq5LfKyw90CjmsM3HuACXBl3zKnN15BBLgdK?=
 =?us-ascii?Q?MqQDFNlhEvbiz5XDdoR6+61yspfVt8kSvt/b7nGMKdy4Z+p4H40LAYuMrF7P?=
 =?us-ascii?Q?ZiBXL2zo6WsH4tXBXDL7B4d7sGh9EiHP/GaaGlzbMzI1HpEiUtPVIStUARH8?=
 =?us-ascii?Q?LDdBtEitUvVDzadOM/u2twlbbJTcPmxwx0hCI/YApP+u8KKqGbGbTk0F9u6r?=
 =?us-ascii?Q?1kLf51NFLosMkOJhwEz1KmhbPlw+wpt9dJ5BjLLVzLMhhNhX+lXHaGVTiVas?=
 =?us-ascii?Q?WTMK5T1BwDaVyDwLz/zspc1O3v22GSc7g2F0xYx4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc22fba5-fab4-494a-9d5f-08dc11e6b79a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:16:20.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxmypZOLNW0oN4EbdMfsFb/JuejoaKftTl61E/dnnU16kTJZjBIcmFrV11ys2D2CabAK36U8/bzhzAc8OQrOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

The lib.sh script is meant to be sourced from other scripts, not executed
directly. Therefore, remove the executable bits from lib.sh's permissions.

Fixes: fe32dffdcd33 ("selftests: forwarding: add TCPDUMP_EXTRA_FLAGS to lib.sh")
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
old mode 100755
new mode 100644
-- 
2.43.0


