Return-Path: <linux-kselftest+bounces-3149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1083091E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941831C21954
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3D21366;
	Wed, 17 Jan 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IZakDPCg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82421118;
	Wed, 17 Jan 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503944; cv=fail; b=kA0URNCYObDmGflWSC7K+GYtva1JWOxLCISLrWJMwkGCjP8F/UKo6Qu5K3b35abBQYmvvyfxKdFkrUr8pKtE3iLUHMp+EvkxxIu3aQJbIproRgX1Lem+cYx2+hPwIqqc0KOuvhh3BaatxLDarh58UtKDJQ25kOGkHSVq5gMZccY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503944; c=relaxed/simple;
	bh=WMfjTjMwL7H27ofDAeTjbVZ2XAF6ytriF06T28C3WRg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=q/o99Cz5T6zXmTvXTEGCT1bJvwa7eDAKnWstydAfPBHUFBGSDCK1R02oWSRGtkhCB2zGZpsfZ9vfPtl1vGnirRG/BxYkhl+2CCvFZtcY+uWG/A+UoXOtnF1k64z4ka+mXQdwwgLoehnb64WeisEGsjLFALGUQG6gxzm42HnuvXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZakDPCg; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EptxNnyrJpTNsITCdNEr22B8DjoRJFbPtT/tPCYNZsYHwFzbv0b7VXKhAr/7OfXPIzGjfg+AxklGNJJmsu8PXTZ/gJWJ2yBNZFDUE6XKz2cz+zqR4C1mFaWDtZDRmDkjHdnzHbknrbPpUvadlcxe7/Lj+SFlNSiaTNSdk26yUfz1ybqDcsOwm7ryqaa0xoHi7Q6MEelV0AvRWfdgANQIQKlpCTv31fNXnC5qPrqpif2nLpG/vvN1AmIwMRmVyY91AhQRDFZmzzIlR1DOBbisGrx8N0qBeLrzkhliR0fCxlMAxil1VL6UfdhsqtGKep7jy8dMCLz1+JHROTyaYKLDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT+lDRneeybLpA8vH/YNgOJ3I7raKjOsdrzyZ1BPKJI=;
 b=jdSUBpJm1+Y2AuefVEFCSxtuwNlZoPIC09mJl+ONZDQavfekJtlSbivYNyUAs+EvWnnAe8O7eY6VAvfSivUItaUFANDMvY+gU2UgL6CEYHxTEFEz1J3tJPA92MXRZtlPsdyhRnJynj2Eyd4GVD12xcbmv+VpO5OfJdEkePNOB39mr/dlQRuJhHQAt6JjCXmslSbY64U511ueTo5iEg1AI+Qh7OFID9ZmTXLwsAAaILtcPpvWwBOnbixFxwI2M1rbc5vNKBY0N22/d8w7EOm3S2RQLcjM1aoFty57aZllw3WRZpFhovEvvIHYo+2wHErG15NLnuqsv2W2RjGbuV7Udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT+lDRneeybLpA8vH/YNgOJ3I7raKjOsdrzyZ1BPKJI=;
 b=IZakDPCguvwCCcgPkK0kx0UTHXALXpyGW+H0cJCpMbVwHyF85F0kIuUXSuH/qehHRScl6HP2cNDvqQAlnY6K/7wtMnfbJhfsPBOTrbat/hMbtg8a+38S1U0q0w4n/GSuKwXvuSozsCNndBY0fhtnlOxDT7V0A+ucwZNfbHgc3PCeTgIRVSfoPQQvL1A2huVWL+iP7u8Ep/xrf7U3dMUb5UTjUNNRPcmH1YoozTo1znHzhDCYbARjotJZYU7kFv+wSXilDkpCvtA5Kl+ye0b09jMjNb5g3qoVVBxhaWX8NQZrE9cukvO6cPT6uESnrrCXU3HNrw8Qvpf708iDS3T+2w==
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:05:39 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:05:15 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:05:10 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net 5/6] selftests: mlxsw: qos_pfc: Remove wrong description
Date: Wed, 17 Jan 2024 16:04:20 +0100
Message-ID: <0087e2d416aff7e444d15f7c2958fc1d438dc27e.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db216f5-27e3-4b0d-ea98-08dc176dc34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XfJPiae3KyTeu8rYRSFeqQbmq0tqPluQswGsGb//yUS0NCk7fcyBfBGgbXsbMfhsIVTZspF/47+/87oWXSxy9AddVynOJlu8b/HK1yzkuEa57pyzrMy3qCj5BBcq6uiY4ikb5kDmLumWIQfN8k6bF5OT4ZmKabTAx8AKczmHYvbc8n+wbXPuqjFh+J8YbKuwbU5lARQSCwToPuk4nsoSGhMESC26HCNZy9w2GFEoia/fwc0F5yWjB2QQL5mjC/6P81+hK9fFLvMxZSEGB+Zcus+z6iUcyJj7o32mziAP4qS3f0PooPW4SXAKo7Mo1RWNkG17QCyEmnXxLMRrpLP35YTcflpM+S4tBa8NssTy/upjnBQqdOhweWGH+1MBN5lh/rQzVskCjM3aqbca342Oom/54gfNBhPg1jSmbyfN/3oOVpiJs4q+pevh6CBIHOu2nLVPbZH8Nz4s2VHniUg7OOQAv8HzCbEnfwXIyHWUTxhRMJsRRhfHOz9KQa1s7mkIKU+PGJgDNH7gpgtDcWQ+gmT8PLxCNrt81J9qjsy/vzxlaJP+l8RdvrKzzfxNW1GvEts7JHDS5B0PauohCHlUsFj+UTfCdiqJyW3uUG3sBUkcA2qPLzuDh98f5mXcu/2K3nreddUeQ0z1YwklTL7sEw0hMHuFm5lGtGhzWBggbDej3W63Xhkd8Wwp70x0FsK/ZJly3KZUESq+UvwKTpborVU5Bh5JEzbGWO2H3Ocw9RHQeLjaKEAMyiHtfem6Mzy7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(41300700001)(82740400003)(47076005)(83380400001)(36860700001)(36756003)(86362001)(356005)(7636003)(110136005)(70586007)(316002)(54906003)(8936002)(2906002)(4326008)(8676002)(5660300002)(16526019)(2616005)(336012)(426003)(26005)(70206006)(478600001)(6666004)(40460700003)(40480700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:37.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db216f5-27e3-4b0d-ea98-08dc176dc34d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

From: Amit Cohen <amcohen@nvidia.com>

In the diagram of the topology, $swp3 and $swp4 are described as 1Gbps
ports. This is wrong information, the test does not configure such speed.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: bfa804784e32 ("selftests: mlxsw: Add a PFC test")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
index 42ce602d8d49..49bef76083b8 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
@@ -40,7 +40,6 @@
 # |   + $swp1          $swp3 +                    + $swp4                     |
 # |   | iPOOL1        iPOOL0 |                    | iPOOL2                    |
 # |   | ePOOL4        ePOOL5 |                    | ePOOL4                    |
-# |   |                1Gbps |                    | 1Gbps                     |
 # |   |        PFC:enabled=1 |                    | PFC:enabled=1             |
 # | +-|----------------------|-+                +-|------------------------+  |
 # | | + $swp1.111  $swp3.111 + |                | + $swp4.111              |  |
-- 
2.42.0


