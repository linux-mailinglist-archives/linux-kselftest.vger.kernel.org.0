Return-Path: <linux-kselftest+bounces-3461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC683AF12
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767611C20977
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5567E766;
	Wed, 24 Jan 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YutR+70b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155E42A93;
	Wed, 24 Jan 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115827; cv=fail; b=MfZ86xOX0AZf0jUNv3IBQPQ00uEnCIsD1MoirvEXm/9M6YROjNvkZJQvR4F4mKbKtCSUdkKGf89gQYdlfVcqyL3+BVXdlp5oFCo9tSDNEH++soV53whiYB64WfeCpI65pYQyhtRmOjUYkxHKMzVNS0UMKPeV6IBUubx/MTZzjc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115827; c=relaxed/simple;
	bh=YSQhDJykU47Owc6qfhe1aVsTLaFEYEGR0vpmqBkes9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/dggkbkUg5kdqyzRT5p9D9FVrjXTq6YhyUE+4QkRkez3zhM6mFQcmBBxl41UoWGuizNaUD9Q77M4xUuvylodjRXaMLqjRxIw5ZVzyvL/8p36kchYegi1n4/7s1/DRaX/JD+5/xZ5/N6CovBvbrAaB60SAOzpAY1O5a69QYBEDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YutR+70b; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFkxY7yDS1IeDIl5ryj9NJu+eJo5sAJG/awGPrEd2UH+DYxKoaUauxDU9ZB5yGzN2oDwyOn/bsQ5rTGQQnGz2ILlBloclW25O/JfzpdzJ7Zk9fGMIX2J1iF9EVczN2G0rkiNjs65eT5Bb3JCycAV39PIPtBLqSE+28rZIhFeahLp/GJ1CyYfpC6UtM8LTv7kDhZjoX0wKeOaijTQ75+9JdeTBws7wGkuq1NqVX9qg/8LkHEiOshWkfSMTkVhrsvhJXw6PpJYnfsQZEVFhgtPfU+TWU74recha/6Knz61zUEolzQ5xq+OX4e27gLhpZxAJE2psgqnidPT4tHt8e3GXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IUOox1IeoJ8tugTQ4s5DY7/8kWj6L/sephbyGHdHuA=;
 b=Ruhb09TWAO1m7DxvtxMRgLZgP/6+PsVBjxPEcH5hmuZRbBW9pEjqw6vMTm/tWfDyNJr6dNk9wgtp2oWW4QAz4wPEu2PpI9eqjXERLGShiDVIsdAkVQD4e3hLUTulN2cxIQMgQGP5ggUsuv1pyunQwQBc85IkkFBSezpcAtNgQfGzbl+ZE4cmWg/W1VEXujlSa4r6pyYsLwueO6WugJtvjEPZAN0Ruop2B04Vx00hyMO0VBJRyzxpCv+4dKFKuIIOB7YxTETUGwm229Xz+k/PtKnfKuA7pMg6QrHtw9RhxsITZwPuZEJTp31TzDu1gIB3iKeu7UQc9VPPRaEEiQ/s2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IUOox1IeoJ8tugTQ4s5DY7/8kWj6L/sephbyGHdHuA=;
 b=YutR+70bnoc1RXj2WIbOB5/Sz8CT1QplhKaad50eZiUMcH5gdEQB1S0WVDIN0qFhHlTntfJHCcBHRJbfhqlTDwZiMP7Rl+x2JiArhH0x9N80e5I0vezeY2/zEorVLORfqMwemq8MQXkccpgabDNOqgEDcmkUqmFfI1Q6BnYt5nGnZA0G9pDQjxYdnxJMDJiNAkM7IwyCH7uusP3veahAeCUCj9+ynvHKN02k2eg9mRcxJTBugdeXAmCIln2yvnHObdbG59O/LThuQITfLgzdBXNWZ7gtQH17d7UMKtCpWXhusRelDZ296+kqwOFGyE+T0tSaunolcJ3g77S1uTsKJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:47 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:45 +0000
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
Subject: [PATCH net-next 1/6] selftests: Introduce Makefile variable to list shared bash scripts
Date: Wed, 24 Jan 2024 12:02:17 -0500
Message-ID: <20240124170222.261664-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::44) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f01260-ba35-44bf-a252-08dc1cfe48f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uKTV0awXoRqXQF7YbJ1XikWZTIgNkm8QiKSLckRHeGKZ4nXjFLPnWqroY3raKR+rSM6U0OFUzXB3MYjMSAdBHn72s8toS9E8165J8WEwwxgt30kRK6hl/EHok9ndaxq/DJdpVYMWcZR/HWJwgQWO1uqHzjjQK/DXr9gO/eS+dx8oOe1uu+pNNymquxxUzpZaisCRweW1in/H1q37yzDE7fLFjuMw+3uvHkrAl0A9B4ieuuYNctzhIxujvFr6thpXWH8tzO9O1IaXuXfM0VVQfvclIEGcOuiiigHf1ZqWza8BEbm0NWPeJxA1Pi2vPLkGK8DeRFlsL+FxcFF4x0bYk1MjRl386k/mIlI7Xo+bEte3gPRum8QYmrT6LE1BtyreIQal4QTPpjQJuF08YTPtAkZG9MfTpgEdJkUZES+2z6KFZE193T+bHya7m0kAPKz0smcg5CeyQpOvxUr+4s8EblcTf+IdG9ViyrfG7NGoeGuk4eK90tlE8U5UMsATrLTrqwE1tSw1O6WAmGpjS7Y1ndXJpnq30GEztG2r4688pAiiOuBPS0qxgTJNfLLFHWg7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TyNqFH8giMzvpZmUaaoiVzC+A6TcvzBN1Bji+OeN7oCJHVau3rrCo2f69iB?=
 =?us-ascii?Q?Ef9uXjZhLE6h7d8pfL8ycaGfr7Ak7B9uvlMLLUkn1o0PsqZxajVtJ4N3dlLS?=
 =?us-ascii?Q?bEeP9gAMvhK9ApwLbg+Xcvx7CPEuUgJIX5iNl//QCyQ9upFVnSRf6Ur/afyL?=
 =?us-ascii?Q?kQ+bKceDbLxEf8KF6lIkHJfV92d6QfbikaJhiMTA0qu9h1WA0TpnwIPIV3nf?=
 =?us-ascii?Q?ueuaCjtT/oCPsXGoSWwRDtOULYQmHX29BHiW7VFwE8JsJzBR9ShGdTYvYnzt?=
 =?us-ascii?Q?A4PqgUVT1fYdFJlHUWuNQwrvdXHGH1hnqvpHoG5CpbhDuxzUiTPT/QnOnPK6?=
 =?us-ascii?Q?oaT8cFt2act5uAHWUzemidd/xtLF5lhJWU9Ynke0U+TDQn7vcKwkt4KEeG+W?=
 =?us-ascii?Q?ficoI8lpySakLFve6ObnLGBvvdkujsSBBV5UUKwlieFbMNyisnUCGBXGoRbe?=
 =?us-ascii?Q?XxYUmeErsicf4HeOtS9zZdfjN0wqh1JXiBOch1IPZ7M2EOhBHEKz9Heh6Z2G?=
 =?us-ascii?Q?uVm99rsZIRmgDJm6JBKuULaC+ZzSAk/6Pu6iZArcS3YE8ikC+m5DZZQfMK0X?=
 =?us-ascii?Q?UCjXXvrTjZDV2PnzyRsY/7qPWYwTksIrZ1sj9zcQalgzIPu5AfWG2Cn7Ezif?=
 =?us-ascii?Q?NePBDWLXHPWkFRd9D6GBhylJNCBPBM8Zk430Qrca1bIHVqB5h9tAZP1j2UfZ?=
 =?us-ascii?Q?6oGB+WK0UTMS4mR4kXqYy46AU3CkRQ4nnhPgfHS5korqclJtbQiWSOsPCHnL?=
 =?us-ascii?Q?WJlV9WIs5EmseNb0EkWM9caLbmHQKiC01xF6G/g9W86T/RH1GY/JbLrBEIIK?=
 =?us-ascii?Q?NNEC6PQkQNEoInN6irfT3njqAu90rCU8t1t5ZEWuyprgV7RreKDQYP5mLAER?=
 =?us-ascii?Q?XpMMj1LFDLsIQXX2fHRSb+qdwoMQzYB1J6OMeWn9DPKpRKYt1OBhQCxfVqF8?=
 =?us-ascii?Q?diHNVoh0zKJnDI4ZRGsmWCRch07tQ98qJJLMvsAO00VTRmN62ugym93bTc2c?=
 =?us-ascii?Q?EglooBkqflDtm5uRfceF5BH4sDnt+Nmcrnzxybt/tHdnlLuQwWPdhmRRVJN/?=
 =?us-ascii?Q?omIfsdV4iQXfbyCzZMhP65lnfqEeO19eVPWDhCGj9jEVIwV9FfqvrUx1V0O1?=
 =?us-ascii?Q?NpLRFM4WU5ks46oZx2UkWbMKtbwzY8/u0PCoKM8p7DI4QtTOqnnbjYCcJUr+?=
 =?us-ascii?Q?2SCZKovEIFsioHT7NWmjfxzbbIUEF8Cwn97zT9ZngIdmRs6Vhg835uWCJisI?=
 =?us-ascii?Q?nircGfELjUVpgI+xfxn8k0KqLtqIqH6ZXbKj2bO6iHMbS/imwxxY1iYrhyFO?=
 =?us-ascii?Q?5uKShNkBR8UrnB4mLgRYWQlPcybLrlJkQ1jRqXkK/G8EFdAquciYrd9HjwCw?=
 =?us-ascii?Q?+F7/S0oqNzkfjWYk3C1HzVXUQIEy/a8UWDUibikbJRQHb/ELJtDeAIxznrGx?=
 =?us-ascii?Q?lI1ir6FVSdhFBiYackxHd0ruDMJDzuYopCaUi8DzKZx0uYigqOS2kAwFWmL7?=
 =?us-ascii?Q?d3d9Tbw23A5exm6wFIzX+EQIIf7C8jmKGCDX2IQaaJdDPQRi6r/GJvfxHmMk?=
 =?us-ascii?Q?DbsPdBELgphI2NHqCgTsKQuOtLhHLwTyfWvXUxIh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f01260-ba35-44bf-a252-08dc1cfe48f4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:45.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8OVHDAG0/Ffe25ix/CH4JcPa7MMuhqdG9JXEfAzH0cQkYOWY09vlsW2XTiV6t7ozCKxhkuAyO2tDF9l6Him2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

Some tests written in bash source other files in a parent directory. For
example, drivers/net/bonding/dev_addr_lists.sh sources
net/forwarding/lib.sh. If a subset of tests is exported and run outside the
source tree (for example by using `make -C tools/testing/selftests gen_tar
TARGETS="drivers/net/bonding"`), these other files must be made available
as well.

Commit ae108c48b5d2 ("selftests: net: Fix cross-tree inclusion of scripts")
addressed this problem by symlinking and copying the sourced files but this
only works for direct dependencies. Commit 25ae948b4478 ("selftests/net:
add lib.sh") changed net/forwarding/lib.sh to source net/lib.sh. As a
result, that latter file must be included as well when the former is
exported. This was not handled and was reverted in commit 2114e83381d3
("selftests: forwarding: Avoid failures to source net/lib.sh"). In order to
allow reinstating the inclusion of net/lib.sh from net/forwarding/lib.sh,
add a mechanism to list dependent files in a new Makefile variable and
export them. This allows sourcing those files using the same expression
whether tests are run in-tree or exported.

Dependencies are not resolved recursively so transitive dependencies must
be listed in TEST_INCLUDES. For example, if net/forwarding/lib.sh sources
net/lib.sh; the Makefile related to a test that sources
net/forwarding/lib.sh from a parent directory must list:
TEST_INCLUDES := \
	../../../net/forwarding/lib.sh \
	../../../net/lib.sh

v1 (from RFC):
* changed TEST_INCLUDES to take relative paths, like other TEST_* variables
  (Vladimir Oltean)
* preserved common "$(MAKE) OUTPUT=... -C ... target" ordering in Makefile
  (Petr Machata)

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Documentation/dev-tools/kselftest.rst | 10 ++++++++++
 tools/testing/selftests/Makefile      |  7 ++++++-
 tools/testing/selftests/lib.mk        | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ab376b316c36..470cc7913647 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -255,9 +255,19 @@ Contributing new tests (details)
 
    TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
    executable which is not tested by default.
+
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
+   TEST_INCLUDES is similar to TEST_FILES, it lists files which should be
+   included when exporting or installing the tests, with the following
+   differences:
+   * symlinks to files in other directories are preserved
+   * the part of paths below tools/testing/selftests/ is preserved when copying
+     the files to the output directory
+   TEST_INCLUDES is meant to list dependencies located in other directories of
+   the selftests hierarchy.
+
  * First use the headers inside the kernel source and/or git repo, and then the
    system headers.  Headers for the kernel release as opposed to headers
    installed by the distro on the system should be the primary focus to be able
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15b6a111c3be..082db6b68060 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -191,6 +191,8 @@ run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
+				SRC_PATH=$(shell readlink -e $$(pwd)) \
+				OBJ_PATH=$(BUILD)                   \
 				O=$(abs_objtree);		    \
 	done;
 
@@ -241,7 +243,10 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
+				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
+				SRC_PATH=$(shell readlink -e $$(pwd)) \
+				OBJ_PATH=$(INSTALL_PATH) \
 				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index aa646e0661f3..087fee22dd53 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -69,11 +69,29 @@ define RUN_TESTS
 	run_many $(1)
 endef
 
+define INSTALL_INCLUDES
+	$(if $(TEST_INCLUDES), \
+		relative_files=""; \
+		for entry in $(TEST_INCLUDES); do \
+			entry_dir=$$(readlink -e "$$(dirname "$$entry")"); \
+			entry_name=$$(basename "$$entry"); \
+			relative_dir=$${entry_dir#"$$SRC_PATH"/}; \
+			if [ "$$relative_dir" = "$$entry_dir" ]; then \
+				echo "Error: TEST_INCLUDES entry \"$$entry\" not located inside selftests directory ($$SRC_PATH)" >&2; \
+				exit 1; \
+			fi; \
+			relative_files="$$relative_files $$relative_dir/$$entry_name"; \
+		done; \
+		cd $(SRC_PATH) && rsync -aR $$relative_files $(OBJ_PATH)/ \
+	)
+endef
+
 run_tests: all
 ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
+	@$(INSTALL_INCLUDES)
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
 				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
@@ -103,6 +121,7 @@ endef
 install: all
 ifdef INSTALL_PATH
 	$(INSTALL_RULE)
+	$(INSTALL_INCLUDES)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
-- 
2.43.0


