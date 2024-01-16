Return-Path: <linux-kselftest+bounces-3082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578C82F1CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610A7B2296E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE11C2B2;
	Tue, 16 Jan 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/5uPw6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E81BF53;
	Tue, 16 Jan 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW5TbgOtmNWrcz31a5FYNKCx52Te61nz82Se3gKWnuOC7Xp5/W+OtgePMWqbYDi4QWh2lqVVziZ04QFpoQrvQBhnulqHGlGymD0rCpf0eHIzdLaKoJwcKwbKhh+17nVPzUgWYNgLWftXPmUD9RVhdQcrmcZAi0MEZD5L4uJtc8zGRpCxuJx8R8izgrUvSxu246/YUikFq+cGPJpG+PCjxje9cwnv/5JtFnILbaoDb1t2iZ/0ZMsqRaZL0Y+XMXtXXW+SFTlpbDdjYuoWK3xmN+O1ryvZhnD3PaQqVI9u4Ok4EujdY0Ou7lSpWSXhQtjDaiCodoWLDT6Ybs3QXqFN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMqNo4dHqCnPuvxC3FWN8LNGrePVHYlLqEijTILJ5LY=;
 b=BP0UE1spB9a0CI8yTGARjjwM5sAkRfZ6OWSZR7JCqRMlCIR9FK+AP6FlqTp9IscvXhMbSR3tg9Y5jH84ikHY5la8X2onXa7fVk0HyTGpgcPlAJD8CHX2/clqRoZUKbTqLQLcRMJlooLCN1sxVvv8r59TLiGl2z4Cs0Xka+fM1c/HeXCMuDp5jvdSs7h62TjCl7afE2ExBixkc+itw/WB/LoDU/GF3lm8fCrNP7RWoyO9waZxLKp8Lkj5M/wi88AGE6rNM/16JKjT4Se1Aq0mCh0xO0Tkq08MScZ3LCv3TDig7GQr/Eq+RlFoMgDsbRZ5Fl0SWFRA2cYNsiWAaq8YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMqNo4dHqCnPuvxC3FWN8LNGrePVHYlLqEijTILJ5LY=;
 b=S/5uPw6VbntvvTV7VHZWPwdIE+wEQHTgoacMxPa0iKCOa+YhExtEI2iHGLVzA+p9XgEA8rz9k+GwpSz4bm2yTKo8yTMicuqfti/HCSBe5pdfvQ3o1AjrhHxfme8RY2ZNFrx9lyJm2lk+BjK+NdvjoItRcl9NGZP33Ltr+HlOeO0kIqlMUuQtHZqv0z94UBxIsq12ekHT7v2AZVipSRnl/O/Ya3lWRWX3vx2QpS8z6ZhmqiLV9Xt/OnFU2PEgmWQf+mEVrYnWxrYbyacAaD0/ieEF+1kShm+Vdhh7kkinaIHzldXEIs4fH8IkIFGncvvM5CNXsML/RIh8o99H6tq3Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 15:49:55 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 15:49:54 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: bonding: Add more missing config options
Date: Tue, 16 Jan 2024 10:49:26 -0500
Message-ID: <20240116154926.202164-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: e97e3d4b-71a1-4cc8-d4d2-08dc16aac86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hv0NfpHGTnx0Jhy81ytSgMA7GauTTGP5FNybx3NN8tOgU2sa8Z58+H4PC5JLGag0sf5oqpsTsr8IIwR7tlRzhXNPQCv7pi3hId40mbPx/icvYGNjDDWdTpI3J0JOMZbvJNfDOF1zNm8aucQzT1wMtGl9hRDJI+RK2iqC24IuuAJJdm+RQAI8Rr48ulF9m092kkjc8SL2wbZPzh5DLagNXY55gNRIK97N8HVAeNjQIXvQxxKO1hdrakwQzYUIV4v1ZIiT7gw0Uq0gGHfFfSeyLAUE2MIqXjp2trff+i0YcwfrebvSZLz6qsZR/F8JZ0E0WqtarNx2aLiXP2W42bDriGrCzsiehuWZ6jwN3rduGEPDNyJjOPP2xzwF8bt2b0biVR5NbXbbmcEjut1yeJ9FQ4qniYqeKVuqaIDQFkljsDn0j8Sq9d4SZUeoTZJKrX8QYRbv7xmrpir4UMI3+r/IE/WHU2wTIhfJM18CFzkmL637vmZbyO/XgYAJqMQ5A9t87BP4EikDjUXiW37QSpCMIbAZQDw/rHtwG24CbSE2xXaK0jOW6hJwprqkCZ2W2RhC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(5660300002)(7416002)(8676002)(38100700002)(66556008)(6916009)(66476007)(8936002)(54906003)(66946007)(316002)(6486002)(86362001)(6512007)(478600001)(6506007)(2616005)(41300700001)(6666004)(2906002)(1076003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZW4zOH0zlmk0jcO70R9d+TFTajhA76LRERbil+UiMH+gOAxie7MLfx+ZmlMA?=
 =?us-ascii?Q?Tl89RjbGH2NkP1W9U9r8VtlCkFlWjHP1HOsD1lTMgFRbmyl7xH3bY+huclAd?=
 =?us-ascii?Q?TlGH3Jl8A4OHCToMooGjgakMwhFlwxg2EnKJX+UL7N2yerE5EvXyL0BiGapM?=
 =?us-ascii?Q?OZjmq1ipHjsoZFGDMV1n7vkBZfv11ig7LV+rFYwykof325pSshzRUwEkX0yn?=
 =?us-ascii?Q?xKtRuOx3PJXCHgHLoyyZb9Pe27ZyvgT4WErRaGGdUQBa8/D1+Fo8g23tIFHI?=
 =?us-ascii?Q?Mgd2ityrd/CYYea9M8w0s7JXngluyr6RA/VROutK6Mq8IFMKiB870P06wL61?=
 =?us-ascii?Q?ByMmr7eeJNQXq/Mme5IiVro8Om9kdk69qYSs2MUug+c9gICxVm8irLSeobzo?=
 =?us-ascii?Q?qihHj+tDK+KuRya1wK4JEaFGDjnc4nkU/EvE9wOK+4ZgE3h7QzEdxktDqBP7?=
 =?us-ascii?Q?Xrar16NWHKqjBEu7kUZKqqpSKZybAVmwuEWEf3NzvyCX7QPg/EUPJteKg89K?=
 =?us-ascii?Q?M+0gjicex8NqT14URBKc8xX04FsYxAnfuMryultNB0NbKE3E0cTCOtMsVgjs?=
 =?us-ascii?Q?b7OFcBc+glCxk6LnOP1dY9nDdrkcdYz/M8FQgATUKNImzi8MuGq+qtnc86Ba?=
 =?us-ascii?Q?jQM3OfdylbZqKpq4mmbuGFVU24/0oVu2N2UzdKXemHQ8N2Nxr7aAREJPFP5i?=
 =?us-ascii?Q?7b9I0A+C+jGIaYXNr1VODDDZJR5YL1q0yQ0R6GpdOWHsPMXfE0eY5ja1UcWK?=
 =?us-ascii?Q?SPujlv08wS0xv7l69N0AUDKqHsKOyaf7RmO25lfuNndFfohwYKXO7MpCWN/S?=
 =?us-ascii?Q?oGH6Y2z6befWsj2Vnx5UF47Txy7kO3npxuVXVWS/eYZABPiFg9zvo09JTXHu?=
 =?us-ascii?Q?FZn3b7WnXRiEruJWnwUnwxKZwtSbON4/nKKygZoXp418VH5+JB6fauwKEtVk?=
 =?us-ascii?Q?/OS8jdRR7lVXMe6ee+cjipPyXV9ATToXmCfFZQOS2p8v7fWL9/lcV/tdLtht?=
 =?us-ascii?Q?S7StbrAt9uZofKVabl9VaTpGH9/IFGiah4lE2uAP/Gl4H3O8kjizrumlqTqM?=
 =?us-ascii?Q?6ivq9pj/Y+hnqLGahqR0ZTlbfgyHeXbyhJ+dHxmVvg2t+TGoUBahaQgIhjxF?=
 =?us-ascii?Q?tbd7619p5c6WK18KUuMUdJB4hahz341f6U7eFygStgVCMl5if2ajFZuz61Pi?=
 =?us-ascii?Q?xrkBTgmwr3tAtNnA2baH5byFhYqSrsrlmTsACoLQA5e9vDBDX9lXB9yOpoUr?=
 =?us-ascii?Q?o9Kqq2pn+m6yYeiL/8gRtVbCfHEiBHA6pgEIPAViomVJ9Nhe0On9qxKk9ukg?=
 =?us-ascii?Q?Ve6lMDrChyPUcWaa3I0aQdenL/b6oq2YuoYNMOze5q1jN+xDBKIc/9g21sdr?=
 =?us-ascii?Q?JOm1j8SAdJmnyMRW9r8aSxW7E6SyyHSpHip84WQXaM38+zleRoM9Qn3aoCd6?=
 =?us-ascii?Q?bCQMKFHr7TCVhIycX9udeIWrFrx/Szi3auR+aXOJfnqefKI45zh1efl0y2R4?=
 =?us-ascii?Q?kpF2MdW4ajJL0+ExKUSS6wXgHG3Zep7o8999Wy8juIJcnmCZlljqd7COmZC3?=
 =?us-ascii?Q?oQkQ4YG4CL/TL+WNC9RvCiS6U9zVaya2SgH6vUOs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97e3d4b-71a1-4cc8-d4d2-08dc16aac86e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 15:49:54.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcxvTFDjOnOKQwz3XiTC7S2256v8NzzUkD7KkhhTrD6dN8ufNZ15HF3jMAyqXKLaBb5+IhAqqnVFj/LegBCOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

As a followup to commit 03fb8565c880 ("selftests: bonding: add missing
build configs"), add more networking-specific config options which are
needed for bonding tests.

For testing, I used the minimal config generated by virtme-ng and I added
the options in the config file. All bonding tests passed.

Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management") # for ipv6
Fixes: 6cbe791c0f4e ("kselftest: bonding: add num_grat_arp test") # for tc options
Fixes: 222c94ec0ad4 ("selftests: bonding: add tests for ether type changes") # for nlmon
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/bonding/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index f85b16fc5128..899d7fb6ea8e 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,5 +1,10 @@
 CONFIG_BONDING=y
 CONFIG_BRIDGE=y
 CONFIG_DUMMY=y
+CONFIG_IPV6=y
 CONFIG_MACVLAN=y
+CONFIG_NET_ACT_GACT=y
+CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_SCH_INGRESS=y
+CONFIG_NLMON=y
 CONFIG_VETH=y
-- 
2.43.0


