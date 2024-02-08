Return-Path: <linux-kselftest+bounces-4352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF984E481
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C891F21E2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAE7D3E5;
	Thu,  8 Feb 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9koFhJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251B7D3E6;
	Thu,  8 Feb 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407788; cv=fail; b=K87sj61q1uh2ozn7wq6pGKlcqj8QQfRR494iDuaApKza73ZzVXcj82j7U7L541V7dDHIS3v7j3+jvU9pbexkGy2J6kJj1jye9TKyFrkzwE5WjA0u/Lkawn+wN7mD8E8wfEYx9SAvtIxSTF+2yF7qt3w1cVhpGW7izDODpwwMUnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407788; c=relaxed/simple;
	bh=RthFTu2/y5ad94yHCkOgPbM4VnUPiUP7kNRF3dW8PFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7Ntw6iBuoGcoIKvya9pBaXa0nr/zDgx7sGTn3Vovi/HLvL9Djseq3mezY3kdztZODXHhPtvtHdO5NXHlIEw+8LYPK/szr1c2u8LG86XMtKNr5I0uN+ep0wek1nTJ5c1SJvffe/TRhwVsd5irFphibV7y/e7awhO68GHtfHIpKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9koFhJF; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNHi+1EACrwJDhaowuv0zzqo2ovKhaqfvX7BXhQaRzj/V7V5efeVBIf5jlhCAm42W/khshPo8ei1Ud+V8cqVy9DRYJ7okl7qlta2sxTYnsUpyh3VGTj9Van17C4gnG1KO8iYjw3/RKKtCWrKw4ZEyK6LtD6oBrYTOghzJqZLLw1TEs2vI+6qGKCRa5oQTguIuuSh6pAW6/5KupwUow4/jKsXP7FoVS63z626v4KTDRq4yDuMecU8YscgJmwLhAk0gNgSeZlIjnoBOg0a5eWywLQFH/ZSbKYEfWDg4kZwamS3IjnmpjRIiavOjqn3VJ8MBMe2frMeOdMcLgdy3NZXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po3QyrtoWh2IxlD8OGx2MIsaqLZITTIA/vfivYAexrs=;
 b=A+kDWpUqs3It7QQ76nIeDnduoXSChRR1T5jY2Y0VpS4kmS9rAT0hEWxq8+u7+WFdsmM37dIxje0nIa8yyA6vyLWcvg5a9+uf3xmaLlXLvROKbEC5oYcOCKA8Bw/dEOU/qXRPTIkejwm5VWkkOXHFdrDvMOO2tVbL/dcrlTyhFDy8Ravb96YCspg1puajnUCs+Tyf671FUIUqTg0KQYIzXr29AsEQUmtGKv2Ct/pRd0OFLSKNgjnfPacDnYB0MOSMqw4euX/V6iJZSvXGVmp2/yi3FpW4lGDvWqMpEu+5KZJTp+vu2SaF/jyuyq+4mzf2zD1vte/jXqH2e2wEfxNAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po3QyrtoWh2IxlD8OGx2MIsaqLZITTIA/vfivYAexrs=;
 b=k9koFhJF4sNzFTetd7VIYuQDAFhaUhCigCkN7I46VjP6SkgXDOBnAYVGfEjGfXrYqn09ZbKg6BCAQnCM5wUqCSNRlsAXw5uxvJa2wFMydjxh6KklAAdDh04iLNSR7NvvxUk7qBosxHJUC8ZtVDBDbieH89Yy00n48wcM8sbhUrmoG/B1UgJipg8l44WfkEtItzFcOTg2kKwuZKAgWbUj6pDrNGQBqeRgWDgarkcoRnr6Q0KpaEnKwJ+OqvTfFMGysgQniyIl2guUg3ZgjqYCVT8crhF/XmkoOSOwzh3uiDlM/Ba4ERnsVE5tdID0DIVEkQd8vslfwXgMo/revklybg==
Received: from CH0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:b0::13)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 15:56:23 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::8f) by CH0PR03CA0008.outlook.office365.com
 (2603:10b6:610:b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 15:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 15:56:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 07:56:06 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 07:56:03 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<razor@blackwall.org>, <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 3/4] selftests: forwarding: Suppress grep warnings
Date: Thu, 8 Feb 2024 17:55:28 +0200
Message-ID: <20240208155529.1199729-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
References: <20240208155529.1199729-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b96f60-2fab-4315-410a-08dc28be7fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nI4yAYTA5UG7uhoQiR5iXjEkEOs8mZ/aYWtQgQCvf2XlHm3I80/UmLfR1+g8yXomESFUUI1X5m40gVQCJDrzU/f+Qck5aEikQF435+WeGkW+KZDljs7xTc5Oss8O4n+vz6FNcBL/9df4iI5mtNSP2zXzn33bxGDUIZieAqJGK1zxg32sU+1BXFEaADzpXoEkANtn5EwI3XPV0RzL1MTBlgDJMwvwUEjoXHpYzKxBnvE5YXBonzC/inI2NsNek/iTlhRaVD5rBNXewOvkt2oHSgoXBViQ1vXMt2KmEkl+GDZB9RMGHxA06q05fEXYWG0FRoaYOiu/ASGqO1661fHY7ToAqjfjAO7yXKya+NgmhmIGqSqlsYb8QwyFzA4wcLeCE2Eize0qX5Yhf0MeJzzmFCkcRmph9BdLfen5t1GLZQia7HwiWRfdYzc0lmTTfTpuNVe+ZxTxfbujHfDwf7FvdXwXteInAkdSi1GYAExF8R4XLu7Nj871pHn6qmn9eCmaLE68C0hKP1NMdX7cJCVu9PVloXJPuRIfiY9gsqQoRkJfHOChCRjfaO1AmsPWNQ4PU6UTijrxKxJzZFJs5HeZpJbcBxRFZrPWwhS6/trQtas=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(336012)(16526019)(6666004)(356005)(1076003)(82740400003)(2616005)(83380400001)(107886003)(7636003)(26005)(478600001)(41300700001)(426003)(70206006)(316002)(8936002)(2906002)(54906003)(5660300002)(8676002)(110136005)(4326008)(70586007)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:56:23.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b96f60-2fab-4315-410a-08dc28be7fc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

Suppress the following grep warnings:

[...]
INFO: # Port group entries configuration tests - (*, G)
TEST: Common port group entries configuration tests (IPv4 (*, G))   [ OK ]
TEST: Common port group entries configuration tests (IPv6 (*, G))   [ OK ]
grep: warning: stray \ before /
grep: warning: stray \ before /
grep: warning: stray \ before /
TEST: IPv4 (*, G) port group entries configuration tests            [ OK ]
grep: warning: stray \ before /
grep: warning: stray \ before /
grep: warning: stray \ before /
TEST: IPv6 (*, G) port group entries configuration tests            [ OK ]
[...]

They do not fail the test, but do clutter the output.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index f94bfb6f45ec..d9d587454d20 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -329,7 +329,7 @@ __cfg_test_port_ip_star_g()
 
 	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_err $? "(*, G) \"permanent\" entry has a pending group timer"
-	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "/0.00"
 	check_err $? "\"permanent\" source entry has a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -346,7 +346,7 @@ __cfg_test_port_ip_star_g()
 
 	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_fail $? "(*, G) EXCLUDE entry does not have a pending group timer"
-	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "/0.00"
 	check_err $? "\"blocked\" source entry has a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -363,7 +363,7 @@ __cfg_test_port_ip_star_g()
 
 	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_err $? "(*, G) INCLUDE entry has a pending group timer"
-	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "/0.00"
 	check_fail $? "Source entry does not have a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
-- 
2.43.0


