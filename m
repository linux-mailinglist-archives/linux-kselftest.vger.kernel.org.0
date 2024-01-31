Return-Path: <linux-kselftest+bounces-3849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EF844170
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6331F22AF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C982889;
	Wed, 31 Jan 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g81h2uHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE780C1B;
	Wed, 31 Jan 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710212; cv=fail; b=rI7hzYxg4o6L3qz7aeFz2RkHRjuXYMzZYY4W60ykIIb1MujqADV5iJE7Pwxz0q+wyYHEslSncM/AUB0bPxuAtlTICCn/X+6ZHe6n9fJlbYkmjW+PfcO6kPiBdiD1W+gkFcviFFg7GonyAcudjyAv1kXh8hG4vhI9AIqJ/QzNNdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710212; c=relaxed/simple;
	bh=KyUs65USKot+qyFftIzPhKQMXl8Y41bXCpVkCq4eDOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRs1O1sKbTCuLswuFpI/i/mzcsRdgIiNwJRvuJAhgpPG2CCrn4iv9llQWPIBE40BemY1EI0ACCF82Nh6oBn0kb/b7t/qNZHpwpjBG29kTyV2dSy3vGmPxmdS+/W3fNiicE8gFKlCgArbX8SOSZRvRJcmfESid4QIvdwC9N/tnTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g81h2uHn; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYesSaUS2CJX5ldwHcTxFWuEzjz31tM0f0Ysc1aABfUypvTpMGxjawIp9AATZbEYN8iCemfj1fBgiRJhQ+CznheXz5HqQIbqannBV8z36rB6z2w2D/qK3ggulmhxLbbAh3jn1VD++49/CtmTdsKlMbdnWXB/PmJN+QcGfYk1zmYvzWE8aH5k0q6AQ609Knw2HxkehJ3CB2a2rjwzYTDB9lTefau1HkoCq2oYuQICC2k+H5pPCp64M/RwFe3V9Uud4PHtrO+OAaF94SSWknAJlzKboV97+0yDHuHP/KfKVZq360EStzkYdc+AHW6IUcz8cXhc8myUb5/KcUtM/Eby+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BsBDEZy/QBGg+PkqJLgeT4xZ9+tVr77AVeybrbYyls=;
 b=KU8+uVHtZE5qRyNvrGWlj/us8DXDf8ehnDqJ/5MOiHyn5txmkbbYeDc8eLyVXKIrjolXnFTs9VK5zyeklK3Uhenjz1K9b7KnnzMg2s/dPvWRw4Mtr+OZ6zImy4GuRabxistx/VHSpCxDQdCDJ5y4hEOxAzZLGJnF5pW1jmVlIQM74KA6iTz8obURg2i6c+QvwLLG5xKQFFFOLYQUB6JFT4l50olrT9ZAwIApMpHFRCy8pTgfiAXuoZIAyI4tluUr0O9XVbej+DqWDor8x2MksW/9JFemJ2icUV3ZSq2kTGUP3E+aMNo3EuL/bEsQwCbKhhVWqL3FgXdRsgzG9yV3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BsBDEZy/QBGg+PkqJLgeT4xZ9+tVr77AVeybrbYyls=;
 b=g81h2uHnbbWF1ZP+1Cgc4gG5AkZdzpxYmlfNn8dq3xCE6b9hp6HMhqgSYA5+ewRCk6aYr9drse0dhlzp2BRPkGL4sESF6Uhn+qMC8u0VFEeoZHXXW9Li93xwypujHbcqBXyC4XUOs2Ft4USU9IfE7rHOuFgEkbO7vljrk2VMCyfmSS0hLZRueNPQ2QA7wZAOG4HGOTKCnotsS6GRL045pTrpevQixl1LCmbZLDKgIqPzWzlaVL0EeXDLp1NRYwwxtjk9wF9W9znI7QcMCI9zhQuGVga2FVPbzrmW/b2jQK+waklh+eytDdnA4yjkxN07L+CCY6ZfrWSGDxM0grKQ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:10:01 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:10:01 +0000
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
Subject: [PATCH net 4/5] selftests: net: List helper scripts in TEST_FILES Makefile variable
Date: Wed, 31 Jan 2024 09:08:47 -0500
Message-ID: <20240131140848.360618-5-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::13) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5d75d2-587d-43d8-e4bf-08dc226650b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApeEZK7bqFQzKmuq3MrMiDRQOsfbC9J+QyaZUNY4GXj9FhHVrPfBVxUOkmqsOdYXpKSIZup+akGUtJZIioo4+Rd6f3HaTstwqnM/sO2futH8Z6ObcmiT/I8PRQuqelHby51xxisnVaPN3TC7PdX+e8iu01S2//xBDukP+bR4ZpDO393NMTGntsYVqguiY+1Sak5Uuf9KcOVH8oQ5XoB5qp56qXXdhR9E2zD3C3DjWAiZmdadW983Q8kTstfyV0cKHB92koqfnCLKqvBopc63++RTYVBNYAbC/kHbjb/XumwuiMD1AW4Yoymdv76H8HzxhMa60MfUaSZROkjDp8SIMWR9XUjkrDhq4X8Ku+nyIFrSblwTtPXNQf/kHf1OGRBbJ17l8vGGfUSGMkz+RQWED17Il0+Is6xQGqlAdeZL5bdjBnb3uzx+Oxcw6auB+BcBdXQH4GXVg9LboKVtfc7fD/OJTdkYje8TKPcBrJ5EwM3wcC2mEjzyaUnJzKIqEP3F0vTwj5gebCmdqkeRWx/CNQ8VYn4YzDJKmwPVv9Mg72+8bPqBtnZwmTbsg0gWDrEB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56ZZv5TlueF83Q+OLAelUagDQ36jnSFJUk4BvCI9J3vMONVq/sK23LmiyWOW?=
 =?us-ascii?Q?Hfl1iH0FyV6HJvX6B+Zfp7W2I4kPDOvoXcbLysCQVlzDQnyO+dWRK/fptNKf?=
 =?us-ascii?Q?msHfV3QlEWKRig/Nv6nALON0nvWRqNLNrWKxWLQ3CsarQGWTW7yMuYYSQ9kt?=
 =?us-ascii?Q?s1WUVMAL46jJnEy+BL7ndszM0jzeRcxWzCQB3oI8p9rpwHwFWethHgRYur6y?=
 =?us-ascii?Q?Ze3Kw+wqsOOqOk+1mPuEEOHhNz7zBO84cgHtdh/QcYxvQ/UPsaMCa62ThRzC?=
 =?us-ascii?Q?/r08Dxj4dc8dI6FbYqLJ7/bw3yAiSQbWKIGPkP/BRn+xeUKDiOzik6oRgMf5?=
 =?us-ascii?Q?J4hPS8cJU469IMFhHM5lJdTA6gTHhi/VwMo0aPOr90NPaliullkZy/acQf3q?=
 =?us-ascii?Q?WQDKBQbSjscQ49k7UR8KiH5esp7wrmdcdpwS7fJ2jGucxcpHvsJhDwNMVq/j?=
 =?us-ascii?Q?5/KD5/kfbfamFG4/LqwEtSHUqRNehzUOcx7kMxUV31/75dZttv1lKgYUtWfB?=
 =?us-ascii?Q?je8VfFwrtElcd8Ri5wFUA7Sbus3op6SFDvKS74CYIbV7L783+cOSoCdWJeuR?=
 =?us-ascii?Q?MqEe4lxDDIGtvdmFiInMV4tAL3kyGzwktpOl+68c5++0/zV6BgmSqIXGHYOc?=
 =?us-ascii?Q?ayOAVAcs8Aovsx5CwSUKqOATLcGxne8SJbmsWwwGp0O25sX/5oYwVSokUHt/?=
 =?us-ascii?Q?otpDyv5PjZu3oq6TJZ3p8usb/7hJkDFNzRUokKdgsk4sJBaRE06OSFTwhoPb?=
 =?us-ascii?Q?HWwQFCVVOv2OEOG/eTcq7c4bGwz1ThlIgmq+bjjDw1hvbxW0HTrErpW9wQZK?=
 =?us-ascii?Q?WFEWEPiXKLObb3w7IFhytdwIcrIrjhA4CEz7Xn83NMwFKASpYupLKgjytXFC?=
 =?us-ascii?Q?Sbs8WLl5dDIlQof2SQREZhlMVpqx8LoAFMQex5x+PCXqNH2uJLA9StRDuo1S?=
 =?us-ascii?Q?E3QsEEYAlTEozZ28lWc9nfhV8OssUSvhUqsqVTbOcPaN98r/GDibM5HiRR1M?=
 =?us-ascii?Q?GrKjE6osWQrUnOl3fT2/uCVcvdEs5F2w+yCZHgfsnpjV3d743EinxosUtoxv?=
 =?us-ascii?Q?8wAGLeqcBq5Dl9qk7iJj0yLDBwIlokmuPqICj45SaiqbF4YMQlRrO5tNte+7?=
 =?us-ascii?Q?BNZJSd+BIwGFa6NpJP+g4gbOd4TaMqtt6MutAUzVmEsIGR0yrNtYY8hw1LFw?=
 =?us-ascii?Q?S5DSaTok7uEB+Q+xFx9tsWFJvl2YHdrPc0AgXbYaPullwatkjRsiK/cBezgy?=
 =?us-ascii?Q?UzUUeFe1N+uQGHqMRny5JVRI/cjbfCG0EuQJGr9i11hhpMPw3kVkMS+KavLo?=
 =?us-ascii?Q?EqkZT5ypoy7Zl66WmdntRunvn8zRZDqgNR+ubHlfTjC2Xn3cuQcZugRIFp0R?=
 =?us-ascii?Q?mm4NU7KenwVHJ4hNkl/VcsU6emgGkhE5Eb4kWHI6+2DVuyF8IVJO6eK9zvyW?=
 =?us-ascii?Q?EWMaRIQMnlLejRh2940wbE4VcmGNxJmgCwsl5aEz9gsms6IG5jrYs50Ixjk9?=
 =?us-ascii?Q?yZbZffSrLO14tr0r4RnogBgm5GgJHWfXof5k9N1eifzdQFMn5wRjHMIrJavo?=
 =?us-ascii?Q?j2gdUdqTI8M6nf1lK5ldtSRR9llQH7qfRvpJfOb0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d75d2-587d-43d8-e4bf-08dc226650b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:10:01.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNvWjMbtjRkvTob0lDixG0S/GRrVpFtG7hHVjxeJlio6bU1Bb/aHhxGaBZscermTXUePSomoHxaJWDPIYNW+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Some scripts are not tests themselves; they contain utility functions used
by other tests. According to Documentation/dev-tools/kselftest.rst, such
files should be listed in TEST_FILES. Move those utility scripts to
TEST_FILES.

Fixes: 1751eb42ddb5 ("selftests: net: use TEST_PROGS_EXTENDED")
Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Fixes: b99ac1841147 ("kselftests/net: add missed setup_loopback.sh/setup_veth.sh to Makefile")
Fixes: f5173fe3e13b ("selftests: net: included needed helper in the install targets")
Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 48c6f93b8149..211753756bde 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,9 +53,7 @@ TEST_PROGS += bind_bhash.sh
 TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
-TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
-TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh lib.sh
-TEST_PROGS_EXTENDED += net_helper.sh
+TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
@@ -97,6 +95,7 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 
 TEST_FILES := settings
+TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
 include ../lib.mk
 
-- 
2.43.0


