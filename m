Return-Path: <linux-kselftest+bounces-3465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F283AF20
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C405B2901A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64687F7DD;
	Wed, 24 Jan 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ctIx2PVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EB7F7CA;
	Wed, 24 Jan 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115842; cv=fail; b=BhLsP+aPtEfvBrdoJHZoXuDCuLic40qowVGYChz72tKv5vU7TTmoi9a/uOuyqn6hHL8Sd0PQq9bt6psNzlLdrDkiT4dX/6oA3ASVaOPB+f0Uj0mzy6z3fWGBxHCDdsZ0YAA9lCZ9yOn0QdDS38ecwM2rfYNsQrSDRtm3E08vxdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115842; c=relaxed/simple;
	bh=MXYcopAOAcGd9XoG3HOdytzR9tD8ot43sB4qf8mJ0dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j590HxCoJSZKfYsanER1Omsk3WL7M/TMX2KOrPmsaQ3RMzJ2gkEluGT5ll27/EocqQ4BI9bNRyT1wdVRH3x0QXdbIs6iokQnOlshSxMabD/GzZKZX3yaKq0Hj7lgvS7fJDqp6/4LuIiLnBxJk7dvWRCyMTVhb1gx49lKAt02RpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ctIx2PVB; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhqQERvBPgi94Ywi4lPdz9KMfQLASl3BmiaxI68QQxzVYPpNcB+qUipLyL5HsvKbJEvJrUujm/NssavRgKXhJaO0fG2td7wjUG4PAntK2IPTPip/2wpoiuVAV6Xc6o3sg9P66ZpVu+4J41b2OFmQaUZ+WgEyeVyQ9xAKE/CoN4HHbiH0/FsrenETlPGyeq21P95o865ONgUr31id37AAzcOI3epHZqlgZdJz6fyGtgnueKFcdnLn+FlvVwPymvIAQRd5fa76iGZpojkFqwtgI5iMUIdI4tKSSy7Et4EK8f9GTGmdzxg+VF2t915QIkDi2aZx7EMG0udoyOrUxVu7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88nCtg3EmJgWMImNXLFTCuuQs10ypVAq5YprtByVasY=;
 b=VBCoQHA/l46MIL4Un/fa3dwtolD12/hIlzfgeo04adgyFJcYh7c/XrlLAblK4IpuRqzs5O1gFnpir1vj4Ng5BIhQyS3o2r6flLe0zrnuvglyrAo2WPGHgXdniyDBuBvocJ8Jjol0ClIRSSPDo2I5mRzVAI2ginSdls33KEaCmr9KrtWt7d9oWg2hSdZf36s/EhmK/I6ibeXfSGOu2QsASMfEBs/WCV3vT6CjJme8jDCWJ4so1d3qEj0Cs0ISmA4OsGQxV0aOHEBmiO8BoRbx1XOaNCukOr68f0t4VQjeY62hwKKZ3jaCNenoqGvbr5ZYy6y3q4gH6eHc+eJ1K8TvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88nCtg3EmJgWMImNXLFTCuuQs10ypVAq5YprtByVasY=;
 b=ctIx2PVBmNUxbYgg2LUcKKNS5f9ZQzXOZQkInJbku1WbrRZQGUSHfgkyVgCoYhizzQ1jcbbyRMFUJkRYDTMODyHYnQvQF3wXcbBVDNMDkNVN8dPZBVmCFU7PdUOcF5KN1Ppu5YQPfiHLfbNPMMBJByUNTHopePUgzo5OajEBkJGJj4Nyqx/XiaWUSKIoyvmedPhN60IhIEdNzWF5RA6+ThaGN081tLfgJHksW9moHxPvLb2kbVu4QXW9yOV3hXasAz6Bw1ZW/YytUAZ/bnClxhu/cEE8JlFgq6lG8KixH1gwLQEookrBaNw00c08TE3v7KRFo0bdxsChw9C2Knqf6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:51 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:51 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 5/6] selftests: forwarding: Redefine relative_path variable
Date: Wed, 24 Jan 2024 12:02:21 -0500
Message-ID: <20240124170222.261664-6-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b87f8f-e5ac-4698-a497-08dc1cfe4cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	quQX//S1LnmUQycxcz5EFk3SeRh0PZp8UVSsz57Kh3itquzvSCylpgC3tECTZ6+0O5LmpUOrTtziCP9dwLplPwKunpyLZNm2BBgkeqGVE0iTAzyKFSVQMiyh/WwPnY4PGEZ+J8K3PE86mrybmxDBu3J3sRi9pP26nGqt+LghehJ3Oe3bTKEiOtu2VaKsuB9IVaEheIF78EXjGBcGcdxZDujRDnjmezXOsO9VRzzazoUROx7jmiJciIWP0nr1ZN8sny0k5xbZ1+SOpipUxCJEVlRvPGFBs2tqyxMBvAOGY/lcFy55dp4ICF3CAwwWjATzwFxFk9fU8wqjtPugzugHa+xtFQC7k2UaT5qcN94IG7KYKY7nykV0VxO28UfhLnnRGP/l2WxaUxF9lcTouLOb00rAgnoLBTvQySG8pDPE+4d6SNQW3Sg0Z1zGlPnrZseayQqwkZ1qdbZXjxi4OZUumltQlOR/Xe6OGv+FNJ1lbPSKk3nQ+NqYNnrjFxBFkxtoH1XXx9IcQk3Kl0qllUS8Mrp5zc9wQkMB6OTxsBY9fglctmmqT0nVCffYvekBydt0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOFVHxNVaDWZOdtMMDpYgTyYTsgOZAFLqb32Pvn3QB2fKD3+rHl5EC8spxIR?=
 =?us-ascii?Q?lqcNbrd0GTa55fq8vi/ZOvwOuONA5Qup9C23RdgphDS6ShvIiVrwJoICgKtd?=
 =?us-ascii?Q?MQykrxFm1JaZ4EKSyHxpctg/DUzZiNHm/sY9b/B/ASHVovku2NdT+hp1NcRg?=
 =?us-ascii?Q?2btpQL+cNkr+LeZggudgh7U0lpscQ5ZEYF3RSxuJnrFM/4qw0fTfJty4e5Ni?=
 =?us-ascii?Q?bae8KDt9jhenfiqIGnj2/LDPK5TqiY3Gebo8iDJCCWA8dt8LPrn2Wm169nC3?=
 =?us-ascii?Q?mf51Yil5UmB/kOlim514Kd6thyeYj/b6LFs+/nx22BtpQIty29rDTLrpa9aR?=
 =?us-ascii?Q?C0AkFsOZ07t72gXwn4wrWmlP5PHAGiFMJ1vzDdJSqliIaos9VR1tMeXarNEp?=
 =?us-ascii?Q?0IA34g294Wf0bonukc5VnTcLdME1oM8/AaoeaLkp86MQ1h+jis7t8IpejlTy?=
 =?us-ascii?Q?+YFe4TSJE/4CEx1N3QTqjmldemsr9jYCYCQKega3bVm1jUvyV6yHRFdGrphp?=
 =?us-ascii?Q?Y1nfDpBXIQXJQBsuFHOuY6FtTVtQSy01lX4igV3pldGCxg3veZw09N097Xgq?=
 =?us-ascii?Q?4LEytIQB5oCIJRjcR+0Kzy1aldPrn5zYFZSuTVPU0+T8itwndo6yE/8JRDvA?=
 =?us-ascii?Q?gcskhYG5tsZZCha8ia1y8cqZIgBNl4jQpx/2PPkAXxozT4fgKL3ngBv9ogw9?=
 =?us-ascii?Q?cettWyJhQMlDkRjWhj5kcKbc4En4qbwvG90gIfMjEIIY100eby3KJAxgMvyg?=
 =?us-ascii?Q?8uLQMpEDdqA7GChb0bz3dwjK4FFPfTG1ld9zkQmhAsECZ56XTnNy0ld93wLD?=
 =?us-ascii?Q?Mrq1AKe3LQqs1mFEBzWWtrrGotwXiG0Lh5FYWqqY3it7g82EAJVbw6SWlo9M?=
 =?us-ascii?Q?0czJ+xabxRuNiUVgoP/yU8CEfUDBFgfgaSdK6KtrPCnlP64yW5N24POQ0Gq3?=
 =?us-ascii?Q?boe18pSdAmsAIF76zCWGPa02R3dnVQrg9ceAzkqMHNBOT2Jv9DG45n/mWe7u?=
 =?us-ascii?Q?/HtC8BJkfCs+nmtpDIDaI2v/qYive4/gOBi2zQaTVHy14a+AsRPcd5lzspdL?=
 =?us-ascii?Q?mFsx6uC84yTlknrXy6iTAVeyAGMcUxw3yBblcIxZ2rWqeqeNA4JhsISYt+zh?=
 =?us-ascii?Q?Wb7SvHaUrWvIO7F6iffBYUrfBSHFVw5/GMdeWkS/b0PutI74ILIjLScQ+/c4?=
 =?us-ascii?Q?+NjiXvqiNzWMg4OXxqL2rMxDL+n0tskw6KjymxXJAlWuCTZ/0PamPN5vpNSI?=
 =?us-ascii?Q?EaCbH3dajecdasnLFMm2YcO6sPv3o72BscKQY9u4wfE+0ddA7o/d1ihSJ9XE?=
 =?us-ascii?Q?YifRfFod9X7n+O6g3dm5i2ua4tLdn2ZG2aNW55xl9OVZnaa4hgeC2DuS3qlf?=
 =?us-ascii?Q?fKlnSgSN5iCt9GP0fbrQZTl3SB2p0xbCvLO7NWc0/1Au3/OD0MtkyLXdTBOJ?=
 =?us-ascii?Q?zP9rpim6Cbmy5jss4AZn7gX1EIwJMrXNvh5anBls+Fk6Vzcux1VPfaxDWisx?=
 =?us-ascii?Q?u6OC6KRjDRgZKhAj30vNcj7LUX6xpnxCR/DCcIbzQXuXiQPNKPCRmPteyVa0?=
 =?us-ascii?Q?gMjx4bOGbv3GMBm//7y0GQ2xphzPg2+t6hreDbRj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b87f8f-e5ac-4698-a497-08dc1cfe4cac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:51.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u0rrdNjOqBz8miURDK/JKEem/KT1gd9AOhMT0V9KKGLtjKcU/GGuLfOpi0BBhoyKMyjEThzsJc6w8hPnDFT1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

The following code which is part of lib.sh:
relative_path="${BASH_SOURCE%/*}"
if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
       relative_path="."
fi

reimplements functionality that is part of `dirname`:
$ dirname ""
.

To avoid this duplication, replace "relative_path" by "net_forwarding_dir",
a new variable defined using dirname.

Furthermore, to avoid the potential confusion about what "relative_path" is
about (cwd, test script directory or test library directory), define
"net_forwarding_dir" as the absolute path to net/forwarding/.

Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh            | 9 +++------
 tools/testing/selftests/net/forwarding/mirror_gre_lib.sh | 2 +-
 .../selftests/net/forwarding/mirror_gre_topo_lib.sh      | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8a61464ab6eb..cf0ba4bfe50d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -29,13 +29,10 @@ STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
 TROUTE6=${TROUTE6:=traceroute6}
 
-relative_path="${BASH_SOURCE%/*}"
-if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
-	relative_path="."
-fi
+net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-if [[ -f $relative_path/forwarding.config ]]; then
-	source "$relative_path/forwarding.config"
+if [[ -f $net_forwarding_dir/forwarding.config ]]; then
+	source "$net_forwarding_dir/forwarding.config"
 fi
 
 # Kselftest framework requirement - SKIP code is 4.
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index fac486178ef7..0c36546e131e 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-source "$relative_path/mirror_lib.sh"
+source "$net_forwarding_dir/mirror_lib.sh"
 
 quick_test_span_gre_dir_ips()
 {
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
index 39c03e2867f4..6e615fffa4ef 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
@@ -33,7 +33,7 @@
 #   |                                                                         |
 #   +-------------------------------------------------------------------------+
 
-source "$relative_path/mirror_topo_lib.sh"
+source "$net_forwarding_dir/mirror_topo_lib.sh"
 
 mirror_gre_topo_h3_create()
 {
-- 
2.43.0


