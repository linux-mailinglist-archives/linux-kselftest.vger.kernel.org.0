Return-Path: <linux-kselftest+bounces-3653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05683E6E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669B3B24AAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE960276;
	Fri, 26 Jan 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suieaG9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEC60241;
	Fri, 26 Jan 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311331; cv=fail; b=eCySS44BPqDopQaOVclUcAytucj0pPbPRBrjGzDEpvHLHE38VUli7PiBnA0UqpkR4I3HbHaqh2MvV0/uX+DYAJcAtgb3awcEf5/zoM39/+an46kCktkf4YDZ4c89IfpaCeUgsImjt2RmPK36FtHfI6Ka7jQ7gm69RNXKZ61H9Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311331; c=relaxed/simple;
	bh=g5aBH5hFKQQvOMjQuCu3h2MmLjLr/+qf/d0uLMFduig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKXIE7Z45NOBZ1rN37RawUH2Lc4IP/kVL+/FCNk1VW+ohwvH3qg1/PV8hINpikhAqGKrqdCYcAb+k8JObM3bJcqvMiJEpk1XE4xPdJGa/XrxtJhcmA9OL81TIf3qACNuxpXyW0awt0XbceQyCn8J1jf1VzAk9b+ravt4HGR9LrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suieaG9a; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCfCYhvcqOop2BxkNFp5D6WDgT8V9jxe/XyEnhrNwdo3TzyPwROlIUYbeL6iTM40gxd9VyYLLfh+bRQCdyloJ4RvJLalXhvDcIlPmf0lOrMoaS8EJPr3k6Yp5hZxFkhgEMtlKhLYmWJv7m6V+DEXhJFMXuVoDQ3nMfm+ErVDIowXIlZIW411dgAr9me7DFjwgzHMDc1nkH0cXhhg8O4jbFBIPnQypOqE1xJPb0aBn/t0Ry42/Gn56/qRhL1HEYVeLZhgmQgmGokY3s/c9FGrY1pLJ+2ICWylDQ12VZ5GAh8zFEW+pLyEwbGueV9JldwwHiH4KZWAUOxkRISadhEX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DISkww5q5Q5Qs0faa82TuIbhInr+b5qgszbXjqsab4=;
 b=hSG3VMnJA+YsqqtgSq6nhmNj/UmDikDWqSi4RcZRBQYiGFoNTNuJCL+w+wrzYdwNVcVuRbtzRwA8cEvhzMb7eSYBdl9dORxMyPWvLQhsA9QM0JUthHf+nxY6K0ubgFiGEKHqCt9hqICLx4PuWQBAplnV0oc+D625kaJJuFhzizqvaQfQ8oz3GzPS/azVYE4So+h9mdnkyoqgzntaakF107OEE3TbwBdICFbqgGZDR//EhyRVWa6VRQn8g493bqj1IMS5uLNKJqT+UbFtYfXa5QKodCnp1ebSgWaHNjG5D6H6UsNxf3YdGEWj9HUEbEXKKBYe842Yo1rHg/qUEFUelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DISkww5q5Q5Qs0faa82TuIbhInr+b5qgszbXjqsab4=;
 b=suieaG9a8tcDgdsCUFnW8NUWOn+JLGtQJvqpYs7EsgBcHpTp415VeMvgtkZ65BP5sg4t4zD2WjheUI6IRrguXuRIliGvju05bn37nzkXpSmuHmy9tOSxEDas43Vv6OHe1nZ7JyD1Pt9yLN7W8HXlExNHEnOMr+zRoDjGXF13QAD3Rx+FFU0gCZuauHx+Pn/pCP4H0o7i+3W0vqE8NRq6+ZGrieDnBeW5NoQ5BoOuzBMHjOGoIUk+bGUlrvQ2Kp3LRyeTNPpLLEkdWChww1T/rYO0J0g5Fzr7i6e85fVgYcE4+aEAn0FCvv04nSPSRHek6JcQ+DTe+zyTWkpphTFlXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:22:06 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:22:06 +0000
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
Subject: [PATCH net-next v2 6/6] selftests: forwarding: Remove duplicated lib.sh content
Date: Fri, 26 Jan 2024 18:21:23 -0500
Message-ID: <20240126232123.769784-7-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::14) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: ee389869-c715-47f9-2b1e-08dc1ec59caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HhmkSJCkQbL+hBe/ggutGkDbvDnn9Z2K7rq6TtvMLCz4Cxl8Rpbaeu9gjVjBofw6X421t+erZJ8DPrhbPXDt7UYiLh0mF/iUXgopoInV+KAFxBqeZfNTPGjposEWubkbtBbnGurVxcZCVfDlhHRrvPtDsOzTFGuF1zbAQLj2MuXvF6kv6lx3eq/2XZZQfwkve6iWx8uL3pNDkMO3MN3VReGG1vUmy6X3yd2HWNpPdSeaO2NKZXlO9wDxB1uPx0vki5pInS6Xsu2p/OIr0zIMovfwLAb6YFJyxco1lL6wMrKdDp4Z57UVumS2fb/SoQDIeBEP7vfjshVBN4/ThUIKsaPNqfAFVeToR0ScYZGNGajbdIvuoDz68UmpxcV9t2HZq/Y8uU4VoXBqcfO+1B5QJgCyA2kw4szVPYyq3mMFEhT+Yb6OiQGMxQSnTUVJSQOzqdFt5U2qwL0Y4SToqdPpZnGBRAx31zOGzQszSccNLZ4WivnbEw7Hz08M3knLQ5m1LndqJa7MqeQZN5wAL+UI/WMZ39sNw4ELtMyQRPlhwSOK0xucBKTJCVHq5E5/gbIi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFqjkJuqtXeXIOQ7TJvq8z83bBXQFu5D0cfynU1UHfKuwTRAu/tBqVrczF5l?=
 =?us-ascii?Q?/ArTUYNTGKZ2B9ftyU0WwCQMeBbwjrB/h1tbcLlO87wrSDQMK34GOL7jbV0I?=
 =?us-ascii?Q?oepxKDNiiLd6Zs3247/7YfSfj2IVdepNUdA/eZSUHvqbaL66ImJOalaI6FKL?=
 =?us-ascii?Q?QR1Uq2XvcMOCWEPELZYolOKqQoMGHW1ILLQ5qYIAUofJN8N2+DPz68f5NoMH?=
 =?us-ascii?Q?+VypHeMcZSJTP3tvGvpNcbjr0RBWx/t/yIjT73BvSMwXiQ0N9VzAlGwkyb0q?=
 =?us-ascii?Q?0r5bpbTStB14TQwWgmTnJJ99J1CNxmEOrM1Nhibp/zxUfoGV/qGcKazCiZFX?=
 =?us-ascii?Q?v0q03aefc9B3i7xh0dzY1+7NU3CodD4KzJyybJXFNjcdNMuQkCpizdmXkO75?=
 =?us-ascii?Q?bFZbQza3fwAmUisNEpCtZYyl8CQSzBuBO2+PL+s/dCyAEEJVg88mweep6dlo?=
 =?us-ascii?Q?YPKngIuOinlyIRqF73Q6D2Mx5Tw9WVVaOqT6KKj+TrFS7MC2Z6qlhB+dEpdb?=
 =?us-ascii?Q?BG37CAcGUvOswnjmKmu4+QJ89oDai9sd0J8jGniUqH8nH3wXG4M20yv/IriI?=
 =?us-ascii?Q?7AHyQ//aFtnsh8udXuH+P6NIdJf+MSDSMFfClGJPbTtslSVSeY/Qnxg536uW?=
 =?us-ascii?Q?MI/XQAqw4TCxIlZmEhGsWe0IQrsdZoU8WIO6DGy6rQMMhuvm43rQggssber1?=
 =?us-ascii?Q?dH0yJMBmQWZjD2G3v6Xr3idHvcP0LOJCZq/4lnWTO+68sR+2CXNuPmWIWCKb?=
 =?us-ascii?Q?Umk/72rfX5z3A7gpLRoWW67HA+2Vr7vvULLpfo+PtQGLbrw8cu0Zjg1CPejd?=
 =?us-ascii?Q?laCGwc/IBotAnqiuLVYeIGyGzXxElPMmPmP6WhbANPBA6rbx/ncp1KZ7Well?=
 =?us-ascii?Q?uyw0KM3F3TPd1Isnvl1Tv2ktGbQquf9ieAdlVbO3/ewOsXEk+K8JnlyvHeTu?=
 =?us-ascii?Q?O031Mpbm12F8JBOhnzatmp3I0b7TB1/n/mDHxXUijbNYpgxPLDY4wWSHHxmK?=
 =?us-ascii?Q?FrOdije9mj4wnMKGGU3JyzaAc+ktrxlDATo0izq5/PwT7eJwZ5KwxtuC+C8M?=
 =?us-ascii?Q?Bu2ZBSKWYvHiHyJev5es8+Tmi3qnhuxpvOPj5SCu3yQ3ojZP1TvTGR6lr2xx?=
 =?us-ascii?Q?LGd+xkwnDg2oRLrJJLPiLggb56umFX5H6oMwol5xyr1nJOIXwQk0+4aJTlBJ?=
 =?us-ascii?Q?89q3dMH+uNxgQaMV3RbfnLtv2B8xexnwV8KcmMsO8MNyYzv1hz8zGBzk8wDC?=
 =?us-ascii?Q?r+5yCpAqq4VQWjminOI8KzwDF7hnilpOpwDVlneG2DTU7AVR398zejVhViQi?=
 =?us-ascii?Q?BZp7YDxNI9IdiUwbMyBUyB9V3/Ws16NzDGl2kWGulv77dHARIhGxE95VL9KY?=
 =?us-ascii?Q?vYkfBZ/c5cQzPSSz8zQBS3zPuiEaJWDMElWZGg5UCLxe2GgpnbbMbAXkRQmO?=
 =?us-ascii?Q?BSLhLNBLxOI0/dJUXif3DRvU0FV8caJohyUM60ggM5lI+VUL/DpDLUKR5+oB?=
 =?us-ascii?Q?Kx0qzVvTX4R1tEmaDiOtmiWMgEn2bqJlRoNd5/TYas7TQw5wz1hYu5MuMMR7?=
 =?us-ascii?Q?IXvPO/md8VvWTgorq0Sq3na7yHrws2Qdq7kZIFeu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee389869-c715-47f9-2b1e-08dc1ec59caa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:22:06.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCeErgk+DyWvPVJ0QcUDLCPO4WlLMjTzvCGwhat0X6uGEhR6XZEv4BIkLSWsF9huz1+QTzHVcdkjpK7Y8SPxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

From: Petr Machata <petrm@nvidia.com>

commit 25ae948b4478 ("selftests/net: add lib.sh") added net/lib.sh to
contain code shared by tests under net/ and net/forwarding/. However, this
caused issues with selftests from directories other than net/forwarding/,
in particular those under drivers/net/. Those issues were avoided in a
simple way by duplicating some content in commit 2114e83381d3 ("selftests:
forwarding: Avoid failures to source net/lib.sh").

In order to remove the duplicated content, restore the inclusion of
net/lib.sh from net/forwarding/lib.sh but with the following changes:

* net/lib.sh is imported through the net_forwarding_dir path
The original expression "source ../lib.sh" would look for lib.sh in the
directory above the script file's one, which did not work for tests under
drivers/net/.

* net/lib.sh is added to TEST_INCLUDES
Since net/forwarding/lib.sh now sources net/lib.sh, both of those files
must be exported along with tests which source net/forwarding/lib.sh.

Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  3 ++-
 .../selftests/drivers/net/dsa/Makefile        |  3 ++-
 .../selftests/drivers/net/team/Makefile       |  3 ++-
 .../testing/selftests/net/forwarding/Makefile |  3 +++
 tools/testing/selftests/net/forwarding/lib.sh | 26 +------------------
 5 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 1e10a1f06faf..03a089165d3f 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -18,6 +18,7 @@ TEST_FILES := \
 	bond_topo_3d1c.sh
 
 TEST_INCLUDES := \
-	../../../net/forwarding/lib.sh
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index 83da1d721017..cd6817fe5be6 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -26,6 +26,7 @@ TEST_INCLUDES := \
 	../../../net/forwarding/local_termination.sh \
 	../../../net/forwarding/no_forwarding.sh \
 	../../../net/forwarding/tc_actions.sh \
-	../../../net/forwarding/tc_common.sh
+	../../../net/forwarding/tc_common.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 708bdfce37f5..2d5a76d99181 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := dev_addr_lists.sh
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
-	../../../net/forwarding/lib.sh
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 452693514be4..1fba2717738d 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -129,4 +129,7 @@ TEST_PROGS_EXTENDED := devlink_lib.sh \
 	sch_tbf_etsprio.sh \
 	tc_common.sh
 
+TEST_INCLUDES := \
+	../lib.sh
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cf0ba4bfe50d..a7ecfc8cae98 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -35,31 +35,7 @@ if [[ -f $net_forwarding_dir/forwarding.config ]]; then
 	source "$net_forwarding_dir/forwarding.config"
 fi
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-busywait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s%3N)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-	done
-}
+source "$net_forwarding_dir/../lib.sh"
 
 ##############################################################################
 # Sanity checks
-- 
2.43.0


