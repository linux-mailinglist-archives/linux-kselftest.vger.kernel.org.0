Return-Path: <linux-kselftest+bounces-3847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D56284416D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1A91F25130
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2A8287C;
	Wed, 31 Jan 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTwKmQYX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BB82863;
	Wed, 31 Jan 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710205; cv=fail; b=C3Dibj1iFmMy+4rkRJg/1sQ3baT4GF0VDnH1eyWBsw8ldXOi6tDTw6hugsCnRhpR6xmN0+LxvVe8jE91z74IYrtyR6/aQQPkouD4XisOvY0HWJPIDSijokAyR8uQw5UTtubdBlA4VQid558em1kL8wjuhVhNVsbwTph3t0gNJOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710205; c=relaxed/simple;
	bh=2ZVQcdMgyRPVGNjM3PoR6NaFccFIm4UAtYVHFBhjdaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDuIljAPBIHZIaVYdYPwlSeDFqN5w3N1oodeVwOJRf4pGbcsA2xWtpxp9UHcLnA6lEkHhLsQkxtRuFpA34rg18Yj/aAe3xP4zNknoP30qXrfoJJACHe/n6xR2j/dYxdtBX9z3q9PMcRYcQJotXqJVzg4AmZJPckqcsHf1KbUAjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTwKmQYX; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbw69Usj0XkWqQotKQy+vN7TY2m0WMhH0CMpsPPcMaBw0AhH29uo22c8bMfzhYpRvMWz9uxUdAnI6oqmAU8/2S3NS5lTZMFCjKVSjy7kidN+6Mk986CBemLNNAb1JXQ/rIZhhlAg8HXbHK4XlyC6mgF+W/BdfDMIdVt6NulR2KQLQ8SFr6SybtJb7kWkLl5X0ZHSffivEZ5RXQCw/viX926b+om+h4grjJ2V8g98jslgbHlX2nSdyJSVdQN5JDJYSKUnWdN6htx/ARdD3GA0nW1pha8pKM4TvbrMx4/ITR7FPZ5gKxIOCb+o4oAkB0XJAUXKo5lFluMjIuMXwMck6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzRlmLcSmMATE5Pr5MZiXehHxDTLWblavDRNN9g0Tcc=;
 b=gqi6C347t6ls55XD3vdzW4X4DZDdV1oHGQuTBo1E/FG8a1P/HSeKdJhk2L7ZoqOKwLjsESsFKqohVNS+1n+Pc4KOvi0XZypahi/+pJBF7Qg7oGeXwtSUYTfD6Zz7iKg2AzpX8Tke8usW19ZKX/TrkgcbeHQqEYuhWB8pGHwpVKQ9D1NLr9QwxO2IhpZYJ9Bhp7+b1Ul0g+beMRiWf3O/3qT85C1mFev2jP7CU59G36SYk9i5EEgv1/6+vzVvpZ2bvpP9GEbWrdv6rKOcEyHbPyDrGjoUMhqEdbN2oqc4CHWeai/4pjYymAyB2bNWAeWG9mkvI52xGl1safsymosqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzRlmLcSmMATE5Pr5MZiXehHxDTLWblavDRNN9g0Tcc=;
 b=WTwKmQYXglfCfBvoeBDVRwzkg5kwCXwv5sU3J3Z7Paxr54E9fU4go6Tlref1jTsM/JmKyCEAtP1hjRJ3N34An7Omb9KWhlbBW1RAsMdBHNBDEnkvP+FQRJShej+0P1ZNeew+1VKxa1giSAlEbIQdkVcEIhopFoibZs6CSkmFNzjz1nE8syc2Brx5YsIASXpTIBVJJZl/IPRYkWUQs+hrrXQIsb10aDM5SerAsIbMmRrXWhaQ4qj12v4LHffA/akG0254QYEHamRF99pF6bXpVnGd9LcH0VN+TTkCcqM51axe1E+NQ8mINpxm5knVl/x3ziloFaCqqE6fWABV7JqttQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:10:00 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:10:00 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Coco Li <lixiaoyan@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/5] selftests: net: Remove executable bits from library scripts
Date: Wed, 31 Jan 2024 09:08:46 -0500
Message-ID: <20240131140848.360618-4-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::30) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: e74968b3-1df0-4282-f7e8-08dc22664fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	plHX6upXRyE+wBLl2nqbh19lGjyAKpzbdb4IIq781KezTmNVaqjoWieImwCFO2VG29BVADTAnwb2KN5LY1NsOuD9fIx+5TIoVbw4T9ZXYgQlKVhBquuXLuX9JxghA/jA4Nu2xXE3JnhleE1FVByeCFRaPH+GXTT8DPtouHlJkMjpxG9XmZjfIzhiU37MjAqSQFrZdNvGqRzr0gYgyxKQ7KRCU57J1BobGWHLtqMl7gwcUpbwWo8czS70RyqbwzozoT7SYR5dw4gsV2fniILNkGaTTgyOQZue9StdzRNlold+1kcij+1JKocw3BEL6U8bZMUHFzw4SHFqNmD3zQPwlNYofTl8n7extpaTNPHohmbeuDxKF22VYi6j/5V8TMR72EDwUBhx+8osptDIaQebR/LePZG5sgQWBx6XqK2vd9jvdPhhDagIX7J4iSnXXTD/F1BvaFLFikROSaLE0XMhZHS9e9yP0F/4nYsyE7+OpYvfH4+F9BaEh8hartW46xycXSA+jmu7OldOxbh4DUyWV7j+xv7tX4JIA/vi6riqqaRRI5Dr9kbnX4SCzWZhDMAA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFTiW5kH/YcDABIXDZNdLvAMhI8J8nxLg4rvlTSlfKTfaG+CHdKrOVdq/199?=
 =?us-ascii?Q?dzFnDgUWuYdeJnJaNdTCnIEt2rS/LmVepYbwN6mnFEXaiJzPowMtVbppxLA+?=
 =?us-ascii?Q?aUlCQOZ/j/L1F7Xc/RpxGKJBbnvNPq7cd5f6KrC5V/l02bPU90zmM2Ei8Qks?=
 =?us-ascii?Q?IC4Sd6NUdVmdI6eVpayXXULHzu7M8jd8u0Psr/t34GPI0KiXdfNb1DV0NtrF?=
 =?us-ascii?Q?NKkWzoFVTx6H4mD68FTl3AraJxUYKI0R5GhSoEI6JjeXxXgHOBNtpquyAzIY?=
 =?us-ascii?Q?u+1hUzebmfMK1kIHieUYpr91MIvxk3Vm/PBira7DQvkQX7K3AcY8HAbVv4Kf?=
 =?us-ascii?Q?CmJdp98Pme/bgazXXQJdAVlztbtfGKejrg5IlJ2it9m1DH8dk3Cov5RZw21v?=
 =?us-ascii?Q?pQMWgvkJDt5+jktJIXj2P7DxFPfCkUcPS+KtMpW+a5Ta8fg9in1jR/cxfiVd?=
 =?us-ascii?Q?XDgfRq+IpeJggd/eQqxaJYkG92YodBeqThPhp4LjnlAbTWJErzJweDzI70Vs?=
 =?us-ascii?Q?XVdmZhhy2M/7cDT3wp3z+3p58TC+Alqpfw37bDWK4CnqpZuZp/GjeWD2wJbf?=
 =?us-ascii?Q?DPBp/cO0XJ+NWGjG1xCN70CSvqE+EE8habL/3OqTjzB/eaPZSTkd9eezTllZ?=
 =?us-ascii?Q?0dt9KS+IcBn96lXh+Ihd4cUHP2zRe0lSiMT6cVj5IcLdhkHXswJQPV/S/T+w?=
 =?us-ascii?Q?NrP7c6o+OrR9tqNhnuEYsMELu0JAy5AmAUQcWyMmBQnDeqCjDFf92vSxtpNW?=
 =?us-ascii?Q?oXSa4j/1v0YP52TygudJWHZsADc6ms54LJuD9PRqoz/v8/TOG23NCbbv9PjL?=
 =?us-ascii?Q?kaYavJvjSwGKa6VqY9Y8ciwMGRdTmS7KrXSmdAov5L+qET4QBBl3OPu9RJnL?=
 =?us-ascii?Q?WqcK/7ZVYlxH/VFQjPScykYPwXAVNbyVg5/lc3lCMtxGSP1kGLEZaDDevoqi?=
 =?us-ascii?Q?PezqgAagj2v/UJiDNkfAECtr+bbGyqLjmIbOaAMLqi+WvhE9fW7E3VWUMHFT?=
 =?us-ascii?Q?dM0ri+ClyKOFf7jVIV45mWGl7yDLxTm+QjUJO+UG+8wV8n0J3EJFOV0oeDYZ?=
 =?us-ascii?Q?mFFrHMS1C3b5wdQTmVeUWv7OlfFGg/goJNOed2ClBX8hw3yUlYGPNHVYOVa3?=
 =?us-ascii?Q?buBUp+VhneVkxoVl30558v+MZ+JhAxlzSAd03GTfWUFW4guTRtk9lI4H0BsT?=
 =?us-ascii?Q?wV9O/PT0SHuzawzBivpJaUWL3QZiy3n1+tRGtDmuEhYgdQlBGbj1Io4XXwDS?=
 =?us-ascii?Q?ZcUUfmx2lDlb6tpPvoD51Km2U7EkoZw9n+btr+hr/LZ+iCAq2uN/4MjihKtZ?=
 =?us-ascii?Q?kHHee34tJ+F2py0J275x/955g0nvej+rRahXU9eLZQxYfTduYQMgTF8+yAUe?=
 =?us-ascii?Q?ZuhFvmCLFSbY2JdDSr2A2x02T4lITLJR1AloFj1A9DlVy6PnCx/DlA7NVrxk?=
 =?us-ascii?Q?dyELIg2Et+SjvdE5qlsy0lZ5eba+lsp7KpX1SErvHsS/carCdQI1evXSwQYa?=
 =?us-ascii?Q?ODzDEx3d0n2FDOY0V5wn5Z6GZVj9HHgaIvlGuFSBDNLRde1ZUXnIIn1YnaKd?=
 =?us-ascii?Q?lt0xs46iFYJOaRgUA/RH8sYmCRjrb19dFTt/RmxJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74968b3-1df0-4282-f7e8-08dc22664fd2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:10:00.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFVlFC38k9uchNHWiKYQps+SLtTSgE6tsxqjBdRhgQSEB+s2HLDED9BVuLI/LSZS8fzeJDs24dwEuY2eyazWGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

setup_loopback.sh and net_helper.sh are meant to be sourced from other
scripts, not executed directly. Therefore, remove the executable bits from
those files' permissions.

This change is similar to commit 49078c1b80b6 ("selftests: forwarding:
Remove executable bits from lib.sh")

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/net_helper.sh     | 0
 tools/testing/selftests/net/setup_loopback.sh | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/net_helper.sh
 mode change 100755 => 100644 tools/testing/selftests/net/setup_loopback.sh

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
old mode 100755
new mode 100644
diff --git a/tools/testing/selftests/net/setup_loopback.sh b/tools/testing/selftests/net/setup_loopback.sh
old mode 100755
new mode 100644
-- 
2.43.0


