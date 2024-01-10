Return-Path: <linux-kselftest+bounces-2800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF8829C60
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC71F29327
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC854A99C;
	Wed, 10 Jan 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wj/+sI2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097B4A992;
	Wed, 10 Jan 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFN3+m0sKCT8i20dpkIQdiWi8CclxWQVw5bIeIuqG62zxtSEifqPtWmsVSeeP5fKmjrqsxkQr/kywAEBEglgSUkSO1zbK0VxNd5pubraZymxAZeJibDjWogz4jSWnW40UB9PzlMn7CqQA2L2GcJ/LP1lcD0lzacQDIXx/9IHeT66w77Q3f4oX3ORTo6JV8NhYHW6ScBGhkxorBgIkaAWen3zI7M/bDQrI+7z/c74Kz3MsyDoeB3tiri3n4zPjO6YQ01N3Q07F5TwTwWKA+H+0I48JVY+rwMIlcbg7Fg5Ck3ixc9CYaEmVcfCEenexwwIm2oNXZoac2DBTsPqQfb6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzo0Ii0DchEfj23DqVfSnIdR1+2ySXsJCoaJbre7xPs=;
 b=loyC3FRz0N9tBluwq6EhPP302EFbZWv6+pxdmBHsI2y7evPyniUiZV+ocNdW1NTOy1g0BGNad2KKkBJmhybrzn3Ar0yF3oZ1O7emy6W00uqoDm6GJgKTWnxPDo00AEBZKRqnSZo5jCcFaNPFhIzE2suQ8AGHRTZ2nZulrx41ZPmMzgSxh27OZxCD8RNhRpvZBzNVLmv9C9I2vMt7qFTP0iPNek6DtU8iK5W6tpRBd4RQ87owfQTDKfoAs/LZd+WolGLE918BMzqCIhjW1BXpGS18OxyRl7hRrIK4BFwTUWUsnXgPjhuI+qlngS7DQLGGV5dJimeDQs/6RcgqaMe5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzo0Ii0DchEfj23DqVfSnIdR1+2ySXsJCoaJbre7xPs=;
 b=Wj/+sI2dwQxIE9Hs0xeiL52deaI5o0tiof5AEgxy4QyXwZXqL+Fz+RvDHVpAeo65Fr/azgVsIe1nvOpBm+vQSgLXOjXGgxVSJBlnpz4GX3UdEDMdv8bWF7Yu2Veow0FAp3mE1z62C263aFm+vE5wTA6s+i+rzuGuJaCAvTfvN+r2KeGlsTmJWLytWRII4oWkDxJwOF9E/0+eFCsldsUDagkkvZYTu0NYs+1XgJX88id14L6W6NF6ge71eg1UlcWwddoNZsydmxzaV2qvNUkozW/nSpD7fkBfff9975pYQ/ZU10NBLFenJKQsLnYJ/2tZiDCWZUDyg2BR36OvehHznA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:16:11 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 14:16:11 +0000
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
Subject: [PATCH net 0/2] selftests: net: Small fixes
Date: Wed, 10 Jan 2024 09:14:34 -0500
Message-ID: <20240110141436.157419-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb04de3-9b2c-4b1d-740d-08dc11e6b263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4y3S1x6TwuvtVRH7DaBbwpxgwfYy0u1EXrRj6dGiOVkctclw5i4gbC6tgjhwEBhpb+dqmHxQZlqp+NfGrl4Bro61brXPUs4ZnEFEU3q0JJNb32R+tMBwIPimsysxpBGZwfY+FzOniv3VtErJQjbBh2La/A2OcXz9OZfQmnVaE1Tci7fTbn+zANEIMadm0tl60ddVQ0W3goWBQhod5iWZx+t4jby5TtfGgO3W2CADsfHD0T95mcQtwIZ4yT9penRYAl+2Cr//o3vQA2jEYCJoOTFGgMiZNGXD+0ZW8IalOqkG8LO+qIIuDNtXjYuxaSEIP+05hX+z4JpnR/6PxixhMDqKycJRm81Dwxp0XNsMiTMDhZlztysW4at1cw3HTueYiGNHb8fG1YjvT/cFpWuT+aRB6IFzsb/s302yaWvvfs4/bbipmc04LEvNOr+Etvf4Ulz2NZh+oB2vp9MAjEGtOg4IV2Biq4bi2Ngoo4iQOwfiK7kgjoMiYPgrntWrT4qHVfQlAwK5uMonkUWs4KG4XoNCjzg+PeaqUN0fSbeFMxU83BTqvZkXiY2qswIJBIFkfAlVqclZ0N+wLdM25izLRRnCriBv9F3d7nsfYj9hv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(478600001)(2616005)(26005)(6506007)(6486002)(6512007)(6666004)(966005)(38100700002)(36756003)(86362001)(4744005)(5660300002)(2906002)(83380400001)(41300700001)(7416002)(4326008)(66556008)(66946007)(6916009)(8676002)(316002)(54906003)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USIGYfXuqNTjxB2f7cxe9CWX2z/nxCNHlPZATQ78/Tv1Yr6maaxuc7Ndueqb?=
 =?us-ascii?Q?9rS71TVKz7Rrlq6TirPEPJkb1lNZAuPDIsNuT05aPn0ajBpDDuZIj9ghjYYK?=
 =?us-ascii?Q?8RwzShCB6kn1+KEoyJcESxNz93dEN3vq9fl4GqNXhVHln0Ke3PWaEmwbRngI?=
 =?us-ascii?Q?3VDcGu5JSnub7GeH6oLQs2q5bIv5bKpLaAFSLFMIhTm2Ns1zlFsd+6DpSZ9b?=
 =?us-ascii?Q?cI5yceeVFfDDAuVod2RmV7LoENsB99F4E/zzG7ighNc/ik639Iskh7uy3vDd?=
 =?us-ascii?Q?IlnmCSf1jQGi0Krl1uOdlqRJBevUZRGUvMwzEHeg1VFtvTGADsH7gJelF6Ws?=
 =?us-ascii?Q?MaJsbNQUn6D2WGEdvkHryA5/DJJUUf+LIlUkhNCzFD8+7epD6XK6crJyL5vo?=
 =?us-ascii?Q?OhOv1qNu4aDq6Id1M5FebKLZC5/FVGGZDHx0HR7KtG0ZBKG5DzSzyolKSwJn?=
 =?us-ascii?Q?4E8DnCGIjFhyM6FPiOXGGmVN2+yevLUc/gIagVtBm/N1gzWngrks8sTGK3PN?=
 =?us-ascii?Q?PtkL6MvoBulnQ4gsa3FoyCWWE+5xebxLYpR6AfVSPdQpfWfCSG6CRlewjt9y?=
 =?us-ascii?Q?DbcmhKSxQ0LXo84pNHENZ7sZ9pi8wT6Ks2lvYfWZn8bgecNfOOK+dMpfl9yC?=
 =?us-ascii?Q?skzgtuFqgqBEBTWRePEa7QYflvinM/b9S4GBzr8S54DSFJ9XrKHhSkaE0Ava?=
 =?us-ascii?Q?qXFQdn4HS/FMfjQoYwUf2YHEZ57KsGD/z6phCY01Ql++lrmAKm8gYV+Oxg7z?=
 =?us-ascii?Q?Ttdjfkd6q1+q4A8l6vPgmvOjsqtwujxijrYKSRUXmjHMyR3KVBPQf27p1yHZ?=
 =?us-ascii?Q?pdWpWPtvD2J2WJVgm+9wZ2cSwWRC6cYRYs3QTX9mFqARgFHSXjFuwam0VKWr?=
 =?us-ascii?Q?/wFXE3F69uUJHCUPO4aEPG9nXIRKfZs3kQWHrEk/69THFdFSXtLu1s8Y021m?=
 =?us-ascii?Q?8DiTKTVK7PyCbW16Pyx4elqD4B4UcvWJy8hLqtTtFH76m2EIlyHN+9BV0fzd?=
 =?us-ascii?Q?kQeGOn/QNDHydvPSIqaXcr7ghe40tupvPFa6hm0n5Hux9o4GMjv3iYVkVShp?=
 =?us-ascii?Q?1FnCHG43uZUPYUgcdpJKhftkq/23G0E51GQDGwDQm+VV3ItuyB2QFLNMcHyi?=
 =?us-ascii?Q?1cbNRji2MXvhSqHUlZSn00r7/YRLbOYxFq+S80UKstM9fIXZ7xFlJfuxz2lG?=
 =?us-ascii?Q?iEUUf5PCFMXuSBQg0nfLKhhDsbQLnpY6torkdu/a0QAmTAg/jCbR3nCXzVOV?=
 =?us-ascii?Q?8eHWGoT2S7m02/LGeqaQNUsnID9/Fd269B+eVDAtbcHvnBBv8XkC3X4SWK7K?=
 =?us-ascii?Q?qnBJQWLVXkAMJQSey138MDyKm33YvaLyat+dNWIkwNKIBpOoAOCPYzYKTVRN?=
 =?us-ascii?Q?0iJGpTDjv1mVyRbRA6F/5PheN2DGUxqS5RXP7YCD5imTSw6WD8hoUu7TS+bo?=
 =?us-ascii?Q?+0RezsKzIkacJXrRB2Eeg8/bn00HuI7gXZCjymxBkGoHipaapPJlyeyDvmQB?=
 =?us-ascii?Q?27I/PepQsn6Jr10AvlTqXHEg/18n4PHc6Oq0VHZNm6au5RiDPfkbOkk1HGRB?=
 =?us-ascii?Q?QXwUJD42C+OrnMDSLwCPYUnbrIhbxeeIk7P7mL4S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb04de3-9b2c-4b1d-740d-08dc11e6b263
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:16:11.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5epI9hHAWAtLEfoOoykpyMctiwGOB6enAIQabNNZXx4o8bVWVqWMZ71QPMVwO+jPN88zQA0h1t7djF9wuZmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

From: Benjamin Poirier <benjamin.poirier@gmail.com>

Two small fixes for net selftests.

These patches were carved out of the following RFC series:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/

I'm planning to send the rest of the series to net-next after it opens up.

Benjamin Poirier (2):
  selftests: bonding: Change script interpreter
  selftests: forwarding: Remove executable bits from lib.sh

 .../selftests/drivers/net/bonding/mode-1-recovery-updelay.sh    | 2 +-
 .../selftests/drivers/net/bonding/mode-2-recovery-updelay.sh    | 2 +-
 tools/testing/selftests/net/forwarding/lib.sh                   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh

-- 
2.43.0


