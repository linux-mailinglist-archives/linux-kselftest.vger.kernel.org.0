Return-Path: <linux-kselftest+bounces-3647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D659383E6C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079151C2305E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78495A7BD;
	Fri, 26 Jan 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYA3yBJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6F57338;
	Fri, 26 Jan 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311318; cv=fail; b=gpL2e31oGy4RXbZgvSqTNq0US+n76yUPJdBpQfD+4785Tk1XSWHkMAq8iYQKIootKYJK+tdoHKh8GcSGqnCQ1O9GsHvJtbdu7wwIOIkSRfp1NhYOTmjlVtPfBsAo4jIV9edIp0kxwJcGySYfsbXMPJxhYrPZMOCf77EgkpFJqms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311318; c=relaxed/simple;
	bh=iPofBwSM3JN2Nr8qQY4sOCKNM1HlpXihm5Zkv3lhJCE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=trEAAW7jLSnNipDIqG7ryIZKW9M8fPVa9bFPk3m037Ajh44PFCYUBbXrRRseMKH1q+u5625LyI+L9ce3LuKekMlzN5QhKWsaV3O9/8XHnIrsjH2FOPywpgK05KQFzIdO0lfi/APJRgMmH5o96z0F1sO+QLv15Yw0IfdbMb7xFZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYA3yBJw; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIamzfuVy3i33GJlSfQ9I6uzo3tekCrPAbvYwi3lkkXpgMuaCTTN2EmHi92mWaJ039+93LOaK/XJMJY7a+wpctca5Huw/BQyYObXG6/iVePjJV1lk01hVfkyTC4OjH5i8xsxaCLi2AYtU9jIH7NyysVc29hLuwhGdYLfERxCI8vJm5dMvEutQW0IkhIjo/RGTr7ZDssO1ecSX0Fz2iuQfZYQZ+VZhD1Yrm2Jwb7zGNarHYM1o7Wkgkh9XMqxPSvjg7CAyjoKWuETCUwMonufzb3HMmvD1up53BaOEWh7gYyie5giGsTzjLbevr/WAcxgmVZLpJHchTWsonSBCg6N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0W1gU0pO3zMCpJ9mIM1VPDQQYBd/KwY/nWZjRYPP+0=;
 b=GhgQddaMG8/7y/BB9mbXEAMDxKPfzt4RXNGFeDkcDeo8EgqCs9cIvD1TnKL1g/kwczmNeU9QpYVWn+CMdlLD0o5gMAsy4eUQER28tSx/IUM7B3xRh/aa/cHub2Derc58HcllgOXeg3yomLmDfIwWucpbiUQNb8muwFaUqCu2fBwF9o6A0Bj3OreRbJvri0FXrOQH+x+taJO1FjTqFq0R0B8DpRQXtpyEx4Kgcy/8C2HkwFCzv8eeSsEH9LxDFpAW+2aJYD6M3M4Cb2OZg6c6KyUDOHqJS3WTN2vz4NwsKX1rJ4tr5Qt4lZJUKU7I2BJQX+DCC8b/RzpwIJOB4yJKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0W1gU0pO3zMCpJ9mIM1VPDQQYBd/KwY/nWZjRYPP+0=;
 b=RYA3yBJwnOWwFI2MMBty32WqSTgk9dHPJNqse1W6Prwvvp1GyYahHEOJb3BT2QszmWbE001juh/PG0IMy/owDoO9MxVAliXY7bB01/Z0I9wHku3MZYUfh+XwGuoIOZhtxUXLHXBj99PtIH2ERyodImmNtzRI7Kp3jjnV1JswlfAXb53mzFZnD6LPRoSxda8APrXKV4fZuGHwr7TvbMkIqUvgWMnIfoPQx12YxaH1QlqTU9FgbZp7pHnD4jd349kN4tQmt/oUDts9yJecT/Z5qaZNgkTD3EMwcn2ss+VnKhM0czNDqYYO/HtCdapuBIi6j0X9l/1eQOZ77gXZvCa9JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:21:53 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:21:53 +0000
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
Subject: [PATCH net-next v2 0/6] selftests: Add TEST_INCLUDES directive and adjust tests to use it
Date: Fri, 26 Jan 2024 18:21:17 -0500
Message-ID: <20240126232123.769784-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::14) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 018120d0-7a34-44db-adcc-08dc1ec5949f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gAk6kgPlh5zfzBQQkS+yi5hS3BN7NSve96/RfcrUnk9L9eBomt4WXY8InUXD9dF+b80MSTN8hy80NxK1XSudJR10vBjs8oAGl+osZ+6Mp2a2oUFSIaOEA52ekA50KzL2qgcA9FwdaNC7mmG6v8N+kRETJU/RNmTl4e2bCfZVbL+az+K6D6vEEFNQNmd2TOwY/m6l10cWtyzGmtDf545i3WeESzycImEtGVdIqsGGsL3YJEVJP2HzkDkgWzwosQJFjye5bUp6nOytvobOPZ+2f1OhybGpwZZsxr++cFGwmtfC0GxjwB91z2H0nKTV8hCj7fCOsnXgl9xhy9GmdLSTY2kn0Wv6/qwIkbXCHh9Y6zvwtfbn6UbgU3dXGVa3Zwyw6NanwblUYSn88j77mWDZnl9RXWJvAnhmfH+bNuOLcucR3C0MPSMSLeI/ct5o2lQotA662pwikmYW4xKutTRX7/7NXzLiGWuaQEUFkHwpYPhUfzCbpVEis2x/579O2/zgfhJYYywGLBKGIzLTiu/kZ6Y1LXlA6DNb9p5QpD1gEaQCc1Bxx2wo9pVS4TjQnqBXmioLz1aREJHf8lAf7JbYGhmwcFn2adY1Ise7Y2V+XJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(966005)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXVtlFAOMAsdCRdhq1ukCZMlGBM5t/iTlbeLGMngX5JVN1LF/DpKbOwK3QEs?=
 =?us-ascii?Q?5JxoGo7osXtsnQ1AhtlkCp1257CdKaKa7c+G0S2G7Q4SF81K/sbHv4+cXAm8?=
 =?us-ascii?Q?IosHgHs0eEaTGK9Xg/h5IC0iFLmtBcMgSHARr+wCA1lSQSdy9fTkXSgFo/08?=
 =?us-ascii?Q?XtSQSdTgmQyf8rqbDgntdUI4CP7kVwtYn5Pk5PDBW/IbmGeJ40OLg5yEOHJm?=
 =?us-ascii?Q?iBKFTbbv3FzeIlp+LKdqrY3b+gf5vALQrlun8CzdRDAAf3StZSDh/klRY9OB?=
 =?us-ascii?Q?l9np9MmpkSQf7gD/f+PQrnIFPhSjbi/gida6zYiGsFrEHMhboYvkNAJzXrT0?=
 =?us-ascii?Q?9RLpRXVIrLCbvzrPobG6l90JUsNiVG95B4msAU/n+r0KxgWT4xUEcwqHj+sN?=
 =?us-ascii?Q?vxaz9n1cwn+4CaxHfPHIceGlltLxyhK/ji/FstILpkWrBQNpm8smVaoE/vT+?=
 =?us-ascii?Q?4/UHm1g/KszAkDGL1eMEZdj2LMmSlHiclO9pua9h5ksXU0QeIT7/GKx4nt50?=
 =?us-ascii?Q?PjCAk1Ow2XqrDGtdlJ/gHm3mF2MGuq92s4SzBB2enRL+FrktE0n0jecj8EDo?=
 =?us-ascii?Q?hToNoJLa5Lid7t5OUOU/AYpVSKYk1Z/3+SK8BA0akJOBhoIEDRASAeKIM5Lo?=
 =?us-ascii?Q?/hB61p/xO5rUYA6BijjpqpKXAk4dFtDSkroCY9XK5309KEGi4b6/FGsUq27F?=
 =?us-ascii?Q?QXIPR1Buc8F/UCMtCcTf6dDaejxDj/kR3O9cIP23VMpA1n0TBgNWvMLbF/+v?=
 =?us-ascii?Q?nxsUB9x7idK4G2od7bexpjEMXnBM/6v5ShjRdojq6BW3Aa0vVbIf89qq1Sgp?=
 =?us-ascii?Q?UbyLkbqE0wkqQqxNLwIcbjvyWfDeqdde8FSAl4ieP2+zsroc4sJPArpwiiM0?=
 =?us-ascii?Q?kxvL7KcVOmLekgLiJjYIhgDHUXXML4A3EzjmTv4rHMlnJX+OKockwPWeF5Us?=
 =?us-ascii?Q?59ekGadmECpEJKXfl3X7HuC+JOY5C4Ipfltw0NpVBxUPkpvly1zuVKhlQwdG?=
 =?us-ascii?Q?jcFmzzn+X6DGEGQ69B2A4aa0kPNxn5lWK/wp33Pzkhxg2zw3RE6pTLeO3c/P?=
 =?us-ascii?Q?qlp65mRFiiyrGurs1ogeYnhbmmu6ycOE+vSRwvDH5Zg5FdW2/Fvp9c+lCZmo?=
 =?us-ascii?Q?cGpWdY9TxdwhuiRtZf30HqXZqr8dD8Gls2lNEJPQ2tUPbqlAk5xyoGanksNv?=
 =?us-ascii?Q?8Sd6l+UVEYKoyfhNvMJ4liW6C8To8E6VzQLyNCwCpYmbEIOBdbstNVqkJxnB?=
 =?us-ascii?Q?TA6d9OvNs+putQXTKqzp6n1SBAazEpvg6gZu+L0dFV+a+XzW1RDm+xomhrr5?=
 =?us-ascii?Q?MVmFvGoGqSHGqz9pF20cj6xUNw/UxQ/oJe0iBkda2H+QSPg3RmqLLNXd6Xlb?=
 =?us-ascii?Q?T8jLxiGYqryDOzSE4Bo6x8SNS86Wf1qSxTVO4chmnUuhUakjKt4PUahaobBC?=
 =?us-ascii?Q?OqUh+jH4kR9SDI7ELjSpdX9ie+9gtOf7Go+dBzD0rbxHrQb9H5ibfCJYZuSC?=
 =?us-ascii?Q?mlNxk/uK8ExtlbZNt4gKASWA3K4ZVC7MaEMBd1BBaa0DUlRdgm5xPDpIIBnF?=
 =?us-ascii?Q?jXbuEiFBW7gOM7OsHoDv1FIAwigkfTPND6T7NxV+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018120d0-7a34-44db-adcc-08dc1ec5949f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:21:53.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIXusSttfFJgGIhTYB4zb9LF628yxtOc4m+At/spiHkgK7ps7Y+sEBL0l5ZYA3wV/gv5wLnngjdimVRukz+nJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

After commit 25ae948b4478 ("selftests/net: add lib.sh") but before commit
2114e83381d3 ("selftests: forwarding: Avoid failures to source
net/lib.sh"), some net selftests encountered errors when they were being
exported and run. This was because the new net/lib.sh was not exported
along with the tests. The errors were crudely avoided by duplicating some
content between net/lib.sh and net/forwarding/lib.sh in 2114e83381d3.

In order to restore the sourcing of net/lib.sh from net/forwarding/lib.sh
and remove the duplicated content, this series introduces a new selftests
Makefile variable to list extra files to export from other directories and
makes use of it to avoid reintroducing the errors mentioned above.

v2:
* "selftests: Introduce Makefile variable to list shared bash scripts"
Fix rst syntax in Documentation/dev-tools/kselftest.rst (Jakub Kicinski)

v1:
* "selftests: Introduce Makefile variable to list shared bash scripts"
Changed TEST_INCLUDES to take relative paths, like other TEST_* variables.
Paths are adjusted accordingly in the subsequent patches. (Vladimir Oltean)

* selftests: bonding: Change script interpreter
  selftests: forwarding: Remove executable bits from lib.sh
Removed from this series, submitted separately.

Since commit 2114e83381d3 ("selftests: forwarding: Avoid failures to source
net/lib.sh") resolved the test errors, this version of the series is
focused on removing the duplication that was added in that commit. Directly
rebasing the series would reintroduce the problems that 2114e83381d3
avoided before fixing them again. In order to prevent such breakage partway
through the series, patches are reordered and content changed slightly but
there is no diff at the end compared with the simple rebasing approach. I
have dropped most review tags on account of this reordering.

RFC:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/

Link: https://lore.kernel.org/netdev/ZXu7dGj7F9Ng8iIX@Laptop-X1/

Benjamin Poirier (5):
  selftests: Introduce Makefile variable to list shared bash scripts
  selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
  selftests: team: Add shared library scripts to TEST_INCLUDES
  selftests: dsa: Replace test symlinks by wrapper script
  selftests: forwarding: Redefine relative_path variable

Petr Machata (1):
  selftests: forwarding: Remove duplicated lib.sh content

 Documentation/dev-tools/kselftest.rst         | 12 ++++++
 tools/testing/selftests/Makefile              |  7 +++-
 .../selftests/drivers/net/bonding/Makefile    |  7 +++-
 .../net/bonding/bond-eth-type-change.sh       |  2 +-
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  2 +-
 .../drivers/net/bonding/dev_addr_lists.sh     |  2 +-
 .../net/bonding/mode-1-recovery-updelay.sh    |  2 +-
 .../net/bonding/mode-2-recovery-updelay.sh    |  2 +-
 .../drivers/net/bonding/net_forwarding_lib.sh |  1 -
 .../selftests/drivers/net/dsa/Makefile        | 18 ++++++++-
 .../drivers/net/dsa/bridge_locked_port.sh     |  2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh   |  2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh   |  2 +-
 .../drivers/net/dsa/bridge_vlan_aware.sh      |  2 +-
 .../drivers/net/dsa/bridge_vlan_mcast.sh      |  2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh    |  2 +-
 .../testing/selftests/drivers/net/dsa/lib.sh  |  1 -
 .../drivers/net/dsa/local_termination.sh      |  2 +-
 .../drivers/net/dsa/no_forwarding.sh          |  2 +-
 .../net/dsa/run_net_forwarding_test.sh        |  9 +++++
 .../selftests/drivers/net/dsa/tc_actions.sh   |  2 +-
 .../selftests/drivers/net/dsa/tc_common.sh    |  1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh |  2 +-
 .../selftests/drivers/net/team/Makefile       |  7 ++--
 .../drivers/net/team/dev_addr_lists.sh        |  4 +-
 .../selftests/drivers/net/team/lag_lib.sh     |  1 -
 .../drivers/net/team/net_forwarding_lib.sh    |  1 -
 tools/testing/selftests/lib.mk                | 19 ++++++++++
 .../testing/selftests/net/forwarding/Makefile |  3 ++
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++----------------
 .../net/forwarding/mirror_gre_lib.sh          |  2 +-
 .../net/forwarding/mirror_gre_topo_lib.sh     |  2 +-
 32 files changed, 98 insertions(+), 64 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh

-- 
2.43.0


