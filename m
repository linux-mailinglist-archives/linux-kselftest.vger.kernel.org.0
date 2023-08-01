Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75F76B2D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjHALOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjHALOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 07:14:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022C199E;
        Tue,  1 Aug 2023 04:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq87Fw6nCjFtZtXKyppCvfsi4j6dXbugAelv6GXn2ymgDLK85r1fb6kS68aBwBCtsmDp8cmttHdj683V05nA/ULrEef3NczuG1SffDDhCL10Bf01ATGX5yMHO3Jdi1IkY9/x8rv0wI60W21k4LhvAf/KmmP31eJMjWGp5WC/s7uvkcneJ64qgo+7MONoGpPljXiEssH7WRhR9ZDPS22BfT2aWWi5WkIuU/+farp+WMhCyfEYgbcVe2D5eGAJfF8KAkdhIv4/R6ugSA6pr8i+1/6anIgfgiHK8zPqlWpCafRq0DyGQxV2HAnMPwtp5pP0TTSZCCWWyoE98bPn4VhuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih8cbF0ocipxxybG8OgGoCBYdITTbNiw0nhiXUWpKcQ=;
 b=Qpgm+szSfF0eWuBTcjwBR8ZebeiO1Y1rE0zvQGwNpbyPKffLuSjO7EIjIgwgL1TSjuScTp9IzuHjIJfqQPoQcEzr0wI5Ir8gqdz4kRGQMrabpzgxq0MnVLtc5SyjC59G8HwactaifOzbCEbvpDTP3R4D2JzIIIFX22QnoznjC8nEgUS0+0lNEMLIX8WhwGFWDsk8jGnHaHvlhV7h4LwqSOpXkR6gDfS2uBbZmQRdvd4G/8+D4xixS2VE51KnXRDX33sNK8njMuVvOsTQVHZXsNPwxWJjtEjXwWkzRDlr5b2iQ9Qu8EBjSeKNc+aN38Rab3r375g4W1RpmlnfLzdLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih8cbF0ocipxxybG8OgGoCBYdITTbNiw0nhiXUWpKcQ=;
 b=MKyQ2i5AEO4wxhxlt5wqdWX3+f0KN4CIbiP/kuu5GbEDDfycemG9V/t0toHYQWB5COwXXBuZqPWi0/PFze0iz/1nHMoNLxs3BJrj75ggJOQnQA0xREVIXUHELos4TJoWlVl8KnPCYquW2bzPdOUo1rJtu/wI8Fw4aC7Ndsaezq7uoa7UAxJO9lTNKTyCuQ5KJeZvQWvz2dfDZxk+k5UywWwSMtEyS0MAPh5O9BtYOSLhg1uxpVLex1sZcqd/RP/CgGB2E0KHbPZCd/HexIK+28iN2B+fkUda6Jqhvgiu7OhBGJosGQXeFzCdIuhDlFztkHtnHzVvD5WOhsGoefQvsA==
Received: from DM6PR14CA0058.namprd14.prod.outlook.com (2603:10b6:5:18f::35)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 11:10:23 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::e) by DM6PR14CA0058.outlook.office365.com
 (2603:10b6:5:18f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 11:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 11:10:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 04:10:09 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 04:10:05 -0700
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Ido Schimmel <idosch@idosch.org>
CC:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        <petrm@nvidia.com>, <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Tue, 1 Aug 2023 13:08:06 +0200
In-Reply-To: <ZMYXABUN9OzfN5D3@shredder>
Message-ID: <875y5zf27p.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dc132f-6d7d-4146-09a0-08db927fe6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Haf8D5qJkWDXGqAdj8VhRirwUU5pBhbJGv/H9RjkqQ0ssuNgcBvwxOz1viRM3tx+9j3feVG0sQN676hx4xF7PKp6vhSpevI6YUb+ERD14x8wN+TB5AR6EBpIm08BoNnWt2n3OJvGyUMn4Qq+mHOO2syBcPE+/uWtRC7odI6h2uDORv7zL8CiOx2i0syFSGWrDMpSO9JWzWx7pkfsJKqiYkPZj5rEwcCN57BdqPSRn7v4e/oZU6ufO1QmO6MLayl/GWnALTeSPAWLw3Cj8wnvGTHv39EZ10CxvNKoBonvtn8yHaKyP6P6ma51BLKKOa0ObyQiTh58YzwOndc7d+TOqAf5nvs5SngxYGdC5OaHG4LxdDMekANW+nxHL8rVYwPgyvCPYPGCRwmGuCf2fEF02+ACRQg2AdIJ2LfWuuJilwlAXM+wXtLKs3oV+7KPy8E320vuS8/X9XPc/bjI8lcd2Uvg0ENWB9JRji2oPWg2d/PanW2eZazvpxYhUOvJQ8rvDXzgYy+5W+vxLVCv7P329EU8kyTce11SnHejNFdz2XhD1Fs1QJEh0R2c1Q0TA0nDVdILgxKWDZysIU9UcCzLuzCg+ww6kwngOM0QNjVVqVcVcFLA0J5o1ms9olQ1Hbkg1tWrxMULM2Mu991B+hhXWEP/evE5tp1CL2mXf+AIDPrbDltl36PRjYA6oE+9NceBkyYvPbtCYs8PcPTOONid51FR9nnQAHZ6yHXJd9/zU51k+hky6+6iLtxbrkWHMOks
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2616005)(5660300002)(426003)(8936002)(16526019)(336012)(8676002)(53546011)(186003)(36860700001)(47076005)(7416002)(83380400001)(316002)(26005)(4326008)(478600001)(41300700001)(54906003)(70206006)(70586007)(6916009)(86362001)(40480700001)(40460700003)(36756003)(2906002)(82740400003)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 11:10:23.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dc132f-6d7d-4146-09a0-08db927fe6d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Ido Schimmel <idosch@idosch.org> writes:

> On Thu, Jul 27, 2023 at 09:26:03PM +0200, Mirsad Todorovac wrote:
>> not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1
>
> Petr, please take a look. Probably need to make the filters more
> specific. The failure is:
>
> # TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
> # 	Expected to capture 10 packets, got 14.

Yeah, this reproduces easily on my laptop. The switches are somehow much
more quiet and do not really hit the issue.

Mirsad, can you please try this patch? It fixes the issue for me.

From 77461c209eb0067dca7fdf4431a907b2a1ce8c6a Mon Sep 17 00:00:00 2001
Message-ID: <77461c209eb0067dca7fdf4431a907b2a1ce8c6a.1690887929.git.petrm@nvidia.com>
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 1 Aug 2023 12:57:53 +0200
Subject: [PATCH net-next] selftests: mirror_gre_changes: Tighten up the TTL
 test match
To: <netdev@vger.kernel.org>

This test verifies whether the encapsulated packets have the correct
configured TTL. It does so by sending ICMP packets through the test
topology and mirroring them to a gretap netdevice. On a busy host
however, more than just the test ICMP packets may end up flowing
through the topology, get mirrored, and counted. This leads to
potential spurious failures as the test observes much more mirrored
packets than the sent test packets, and assumes a bug.

Fix this by tightening up the mirror action match. Change it from
matchall to a flower classifier matching on ICMP packets specifically.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index aff88f78e339..5ea9d63915f7 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -72,7 +72,8 @@ test_span_gre_ttl()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev \
+		"prot ip flower $tcflags ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower skip_hw ip_ttl 50 action pass
 
-- 
2.41.0
