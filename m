Return-Path: <linux-kselftest+bounces-3648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD683E6CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799F71F2AB1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84165B5C1;
	Fri, 26 Jan 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuU+KCLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8A5A7BE;
	Fri, 26 Jan 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311320; cv=fail; b=VzJqNwxc8I9GRTHLllwSoe6PUrIknHwLHY+3ds++CZUaI9miatQ60EgLx4sVlBRRbLgQYoFrL7IUUZVEhTmagHYDVG8z9bcgu8f1IN+YV5oQgMHLFsLsMRaAhwcu0zhfZd4Z7uTRa2cS0agnVAgJZgybvG5+KQg/iZ1ZJYfL6fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311320; c=relaxed/simple;
	bh=ean8ZPumufKAKWyiTXjb7GosxMoDuU3csCT8BV4qIkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2MmR3VIJISAYqYoOuL0923mcJcqb4xci0XdggjR0AyPwHNmo53eDP2q+VamLCMo2l4xqOKuzi7EOkmXt9nbXpRnjoydQjDiZi6tSsNV0SAy7Knnh2XSKaB/zTMmcjnXAUlijqSzDeWrz5wxljs2k9/aLsvZGin9Som9JBDlJ6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuU+KCLd; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af5yt392jAP4Fyk/gExwoGPJpJ8XHvK66IX2Y0nJ4oNZlWtc7nDM9mDp4gWmFtGerBKw+Gq6pmXUkELNeusDN0WWLh7sEgcNxob+hoyA+wlFOxyPKENwp9FXRnBxUbpVsg+viPvO/FImMgVDh3MvJzWvq6uiC0lQxcLuQ5X+UoN8eCDZ0WP807jv6M6bNTy2BAfK1gT8NIyBf0Li4e1nauPgW3/5+KP8AB/ed8AD4f+nJH2mq55b3FWmbvakCm2/+dHdO7vqmlY9Xgzq5Iq8f/yrvxWUgs410oA5cxoRxvCY2Oqe90qoLW50YA4wkiQOiUqQDB8QqkBO4kMIjOxw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=284jL1MHzGAxL4g540ueighZGY8tnaCgztobRTLK4Ik=;
 b=PI0kQ9HG2powiX2fYhvX1MlPIJLFI9gYjM28BjZDziAJiHxEZRz4gSofr+aqzNS572OCy0xBIe7A4bKywRySlRSGvTxVo7Wln65xBKpkV02/3iVxnAVWHKkEWfbQ5o41zwwqhBESAQr9Pxkm2HxU8iO6XGHpJ/KxmL/S5P3V9wIDsw9012tZZbMxyuNH/Ym0OziWVQYHu9TR4g70YPMLjoVhW+FAg3tWEdAVFhpQvAmowQp4FNQlPvVJHl3HuFqZWBaSt1mpGV6Nu3sLs40b3wk9fwbxtsG8I/BYBBLHleuvv7R4c5y3XhbX/dcCsRfcSaksUcccAkrZXpl//wyZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=284jL1MHzGAxL4g540ueighZGY8tnaCgztobRTLK4Ik=;
 b=QuU+KCLdixS7xe488kkJQUAKKU38L/2IGS3H0R8ahs8pX5+J7oaP0QStmyfbzxRBhbJPcJHbgTJQuH4GXD7XMQeXYuDCUr6vZ3YW4F28mOFT+zSLeYXX0VRwwhMrLgcVTmhirYrcjiwBslSgsmp+lBmK/zxKRgrUWE85kRoUNrXDtFBeAsUv3EGSsdymRUyfyVapMzvKq1+eA/ASCh/MBPgpm85HabDsssnrekqO+TSyUMRXtb54sBeSYhmyyr2bneuTWhkFcEOsV2rgdi3qfhZjxtsJyZwKx5XSJwPiZvrvEwJKakp1ugODwkNQFtF0oL0e/los53/ny/KeGmgy4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:21:55 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:21:55 +0000
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
Subject: [PATCH net-next v2 1/6] selftests: Introduce Makefile variable to list shared bash scripts
Date: Fri, 26 Jan 2024 18:21:18 -0500
Message-ID: <20240126232123.769784-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 618f66ab-93b0-4aca-98ae-08dc1ec595cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YIJ7MVOt5zy/mgeJlC6o6dvE1tsWDxpbI73ZvET7V/b5hWVqiA7QKkQBsXVWmgOEkVIt+y9JAalIuCqQ6C736lCYIXnVUMT8a/vL8z2C1QrWUW+6ONxblLnoo2OiWJP97ISGWjYiYQpuWdXlzbP6i3LdUdHXGojEw11CZqfd1lFp90odahaee0zlbpQucWWTlxOg8UZjon3VdRxYkoKmJ8mCQpJtsLFTB6ilGCcdZrZKXz9q53yY490zNOmZSRWWziMSrYWtlAQ0GcVurCTk4cYWGvMMi0Mx1JKFQGhNQmOlrDJd3aMAXJHgLTrjmeYni7nsR0AbtH+mTzfH0vQ4GsNy/65l/5UK9Zd1Z8fC3bH8EAcyLv8phgLVytQKZlnYSbrxLb+hYWwLcs1plzkl/B+87iQcp0mU8Mi0UcZ8kchKc4uxT7CaoYoslfhB7gE0jw06Q0oZ4uIiw5tAdHqJ2XQLAMZefokIQDS5nzQq69Hm8GwscRAO5boGEsqDd90SofYf2EeHRXDzV9v8kYDVmQT4Aklkhj4E4k0uXRWz3qd2bMufhOQ48uhADICsDEMu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTnizaxXIU4U3XyOSgGyhdoEE26dDz7Knhc8DjHneOpmUZxqkFaIzc3iaslg?=
 =?us-ascii?Q?JJsChdCfTxRxPHjTqldMIRPlq4dn/JStfq8kPzCxNXiFm2ro8Mqb+UmLU2Sp?=
 =?us-ascii?Q?RnsLeYHqT0FsugoC9oiW5kECntUYrIpvS0N9ZjPGTGNZcq13dLzZYQrmClpr?=
 =?us-ascii?Q?ZIFUUK3N5KSe3rF29qadnG4OY/R/VHyyJQTsJGj4weenzKnqd0FnAkvauVxy?=
 =?us-ascii?Q?quSOQU0la+bPzdlv246D07E4H+farW5JzU87KJz3TyL2oJaGNgn82+N2+ddh?=
 =?us-ascii?Q?4ysfby8hF+pPtFOSetBDq7nvnAHAvwJLqCd5DRmZu4xe0LaF8QbMf6Xnmvy/?=
 =?us-ascii?Q?6MAQ3yMtkV8Z3Zy1SWzoWsHgYSXiGXF/YRsBxq0uNrg0mZlivNDn+V+L1SG2?=
 =?us-ascii?Q?bFZLMOBT/9Lx3q79dXvyaZh9jXxFYGM5gqaWMl1Sdgk9N3lDj6ZRpYzrtmNy?=
 =?us-ascii?Q?w+OhfoOW3wI3EH+Rq7df9xf0JTivfavgiAmPgDwaQYmywjx9VQmtRfIondEN?=
 =?us-ascii?Q?Ojc9Mg9jLDp+yPlymKGo1f2VBwK+4N/e6RZ6cbsrtzdc8Ju8Q6WgQnlExuT3?=
 =?us-ascii?Q?auE/8SRzr9tR/tvkf8XqnKBhmF81VQ+c6jgxiSAw9Q+JvAywSbWzuhh5Xdlj?=
 =?us-ascii?Q?ly0pnr/Yt7vaqiYDDP5wfLIXvSCWswHzYDSYHnPe/IZgL3jf7ypK1fgkmOJQ?=
 =?us-ascii?Q?IkWdt6+mSorov5AEQqc2IHbBWgaSpwXajil5ip7djtfddSN5zo/u/ZxUBN+L?=
 =?us-ascii?Q?btvFMrC674ZC1pEvexy+E6sNAeO+iBc5xQ6pbZ7bR82ZYPVQn2oIigx9mYkV?=
 =?us-ascii?Q?GEku6Be5N7Aw2RAVDyW41qplMN3ZTElbAQFHXtsuzdZ6RpOKDmsSNXrGIl+H?=
 =?us-ascii?Q?upQyen6upiysbVsZkiqjriwdC/AYQXA4YkzvMvDNP3pmldWKcKoEvrMYUcYn?=
 =?us-ascii?Q?+sv+NyCfSr/ZQtqcyM7H1lgvcz36U9lvRWXsfU0R3116XZCp9PqPsrl5Gc+t?=
 =?us-ascii?Q?jjJlOSlSlBRyK2jjeAddHLWmEpkh/1zNbw5FLrtWx5mTfz/1dEhhdqTDEcp0?=
 =?us-ascii?Q?/v54kK6bpZMB5BSwjLCIZ2tc8DKtiFbqkZUVBQOSMGjgETa4RWiF4foikNBc?=
 =?us-ascii?Q?B2GiKDC/Ja7KEKHt1D5P06T9opTcS/ll614mYyoaA8rt3T3jgOsuRZMZzUIw?=
 =?us-ascii?Q?P8cZNsXXicATJChNfqSmHUQGm3nrIeZJVA99EPv3VIH0kk2eRyXOIv17GejZ?=
 =?us-ascii?Q?FiPc1XMgt1YMgpeW/m7GKccPw1FR8qgnOL0YohVbI7S9Udq6r7VXlc/nPGEm?=
 =?us-ascii?Q?o0NMzDiAEBhm6HqEIaTcoRRjWVoUFG+MkQ9GtcIxHYF+gokYU0sCS/FdI4L+?=
 =?us-ascii?Q?bZP8fazKz2UM6Kx9Pdr86hPV4DhVhpp4NxHBINml8A2xZloamHWoQJuW8lwg?=
 =?us-ascii?Q?rLNn7E42wHfAUcEc3l/9nOIebq+QMqv9AGQM9Nntjo8ejAEWxR3CZn7KBpEu?=
 =?us-ascii?Q?VPU0o4Yy5MccmN6qZWL+mOqk61+a6hhr57diU1G8m9FhZBY5obgSB9vU8NQ1?=
 =?us-ascii?Q?3Ne+dozednvjmdNout+D+hMVHtdkY1id6vdgfwx6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618f66ab-93b0-4aca-98ae-08dc1ec595cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:21:55.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy4hif3QiZiGnFH0r2pr7OvyD2pXHF0FiAyV3DyUlr2YxVgYOCeiQY6/8bBZnh/ixA5uOicPcDXnCdBM2rIUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

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

v2:
Fix rst syntax in Documentation/dev-tools/kselftest.rst (Jakub Kicinski)

v1 (from RFC):
* changed TEST_INCLUDES to take relative paths, like other TEST_* variables
  (Vladimir Oltean)
* preserved common "$(MAKE) OUTPUT=... -C ... target" ordering in Makefile
  (Petr Machata)

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Documentation/dev-tools/kselftest.rst | 12 ++++++++++++
 tools/testing/selftests/Makefile      |  7 ++++++-
 tools/testing/selftests/lib.mk        | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ab376b316c36..522214c7b43b 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -255,9 +255,21 @@ Contributing new tests (details)
 
    TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
    executable which is not tested by default.
+
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
+   TEST_INCLUDES is similar to TEST_FILES, it lists files which should be
+   included when exporting or installing the tests, with the following
+   differences:
+
+    * symlinks to files in other directories are preserved
+    * the part of paths below tools/testing/selftests/ is preserved when
+      copying the files to the output directory
+
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


