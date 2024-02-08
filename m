Return-Path: <linux-kselftest+bounces-4349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49A84E47A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED06287DCA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A957CF3E;
	Thu,  8 Feb 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVugriYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650D6BFA7;
	Thu,  8 Feb 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407778; cv=fail; b=Dbny8KQSLgjbG82ZPGHlDNZlQuASpQVwkF9cV7UOcwmLHPB4YYsW65dm+A/GhT8GnY/ljJEvC5iWpLJgPWDYsSL3M6parU9OUue6TVcp2E61L102Bn+agi/Hg9GOcbmDkk43ooOgwslzh9tGoCls3YnBnbH/2hSYFfnAgVgAFJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407778; c=relaxed/simple;
	bh=fcHT7ubPdl2z9jEE2JKMsalDG0RY+Q85F9jp8Qg5S/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAuzGVGJspia2sXuFw38s5K5mPyzuyXtatl5YX+s8S1Vr9qEOiGMFV5HPbt6E9wM3t5gT4ZWnqdrmoK1jCXuf8iLOsjPduIhfHn0OavHwA4iS4lzivnX1uwaB2BXXB1bNJZFKwkRk6cvq5cYXVEoVnAyLShfNa+LWC6EHW6+1xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVugriYa; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arcxrUqOmgMhsrcXpWGaJ15xa/QUfsIMavXSvI7/ZoVeQRA05Rw5Ev/5iPgFbdAZqhFFytAzzu+YwpRL7suuJjA8rCf85GYKHR6FEfK6kAct8Oufg32ZaLSUeKnniPYIQDhyby1CgQbgAYk/2n5HsFIird+MHHpYxrrXmmlAQpaihGZNm4sYxWs0ryz6WmGH7bmS1WxN8wR/3znLu2UGL+wHGcrXVS3g7qyYHW3G2pyHJaRmmIB97WOUFknjUVUWhQa/tVhDZ1L35u4lIrSCKN+M+dM1QD14kCszQkI/DhNxT8GTHMf5v/LEJ7NBiWFf9zdyFXcf1gNSVfANd8y0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5E6b9VrMwyQTyXT/ILeOXcHOiQytZM0O4B2NdaYp40=;
 b=htx5PdRatBRS0484PJyPy2orSOucfFhKQMDZYMcjbe+p29ApYfbiAzm6aGM+/og1CYWMsQhWKxzBKYzEvs6rEXby3c8TZk5U6BP2UUH0TLKTjaphnzz/VcUjFXt6ORd3jFIXzmvGvIChR0Nmsgw9zrvpp8URlsaTDWEGs0Kfk5LmO7oMSDcjr4EIJ+MSLHEC9ZYEnxDrrdCHkS3J3AcKGZ3lMasmnLQcXGzTxuo9TkNgX5ZxZgq/Ck61ZDOy/Bin1npJ7E2r9+5FFzRJ9BUc2KbcCYTbJTSXe+1cjOJSJ1ynvsqdtEcgWmIXHWlbjThQAq5L+yPRektX7Sg5DWNOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5E6b9VrMwyQTyXT/ILeOXcHOiQytZM0O4B2NdaYp40=;
 b=QVugriYaFB0t4mEplKSX5dCMQXV9BEq3g7uYfXTzw5lKf1pUfabdrwMbgkOtJ6AdhlhRdFZoWGzVMYMXNbjiSQOgBhblXazoH3P+2uetNPsAKFAFoe5sg33N9msHOaowQBP9EnegVc8qj5tKIHNiJolBl2HVPVpT4pQ54L03383P+nzQk1KqYZmZcfCJcDgACWuUaFmPdwqEBTRF2qdoz8BW7/6EdQq2S5LrUNhF7hL4NT2T0O7oFgw6DWYb1rleTTVdEK/4vnTUzP9T3XyhIJphThpK74JCoyWhuirCkO9LYEMdukuzbAwNh/PMGQECAcbs10M7tX7WOe3r4zVRFA==
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 15:56:12 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d4) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 15:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 15:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 07:55:57 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 07:55:54 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<razor@blackwall.org>, <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 0/4] selftests: forwarding: Various fixes
Date: Thu, 8 Feb 2024 17:55:25 +0200
Message-ID: <20240208155529.1199729-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: d1647fa9-22b0-48bf-e484-08dc28be7900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxlO0K29VMPG0zeai4DcT1kax39qT/j9kerYCOPYlhLBJfM1wUeof3UCgyXS5ZslO475HwlcmtM5rn0LGcqzhT9F4uuw/SIzUdNKakiOthThG6ixQNy0i+KhTqm8MwO/y6eVcjy9mLMRc8OH2V12lla+fzy/zxWCY0ZblQ31hQfgr2w1yDttQsD7zDJqz4UxF/ByC5O4PQg32z/mQ5B0qk8foYCB9dVyamTngFVGwdUdXOehVv2PACsBYwRFve1XTulRKzAOdy29KWKq+Kt9UqYCbAESRRt1+qMya5IKX50EsaPsCktMDONrXc94TjM6R+61mYeEip4AF5f6+lsCpLCg0S/rCBosea7F933IBlHSebeXVXO4wvASYnSSYf1+fUrG1GaLX5Qo6nS4RJLAUGPFaeTPWT/sOw/8EunVSI4027fA7Ujp/f1ybUFoSlKdNQ7+IShpSWro8RuIsC/d+94b3LJ/Mf5jGgQ3TG7QXnqkWOOesTl5gHLEG9ElABfR7drup0tlWa4OhgnyNjD1UICwXus3zqtRRdMX/9LCkGRQj3FKRB4mSinA1JV0PImI4HvWvmTk153SmWk1ZK5rxgJvnE9hYmiY7wz45+gpyaA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230273577357003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(478600001)(316002)(86362001)(16526019)(83380400001)(82740400003)(2616005)(26005)(426003)(7636003)(2906002)(356005)(107886003)(1076003)(70586007)(6666004)(8936002)(4326008)(4744005)(5660300002)(8676002)(54906003)(70206006)(336012)(110136005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:56:11.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1647fa9-22b0-48bf-e484-08dc28be7900
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

Fix various problems in the forwarding selftests so that they will pass
in the netdev CI instead of being ignored. See commit messages for
details.

Ido Schimmel (4):
  selftests: forwarding: Fix layer 2 miss test flakiness
  selftests: forwarding: Fix bridge MDB test flakiness
  selftests: forwarding: Suppress grep warnings
  selftests: forwarding: Fix bridge locked port test flakiness

 .../selftests/net/forwarding/bridge_locked_port.sh |  4 ++--
 .../testing/selftests/net/forwarding/bridge_mdb.sh | 14 +++++++++-----
 .../selftests/net/forwarding/tc_flower_l2_miss.sh  |  8 ++++++--
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.43.0


