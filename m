Return-Path: <linux-kselftest+bounces-16064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EC95B7B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5FA1C23812
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A71CDFDD;
	Thu, 22 Aug 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGYfcJ4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97F1CBEA2;
	Thu, 22 Aug 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334753; cv=fail; b=Oo2XtkXh9tihMrt0ln/fmcjFn2OT28xjYi7fKNDQVQ0GhIjvSQbePGPcZeoz0ebadSFdWfEpnT/kQCC+VAYNxY6EC7PsfFsW/fpBjZL/wbb5mzpI8PgABLefaiACapurT7ajnBnqf3nz4HEI716GDkpdz+fUaS6IQvgrhmY4Nqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334753; c=relaxed/simple;
	bh=iDfrIeITZwXslhuF2LkeD0V7UlT6mb2V4MExpuFx8f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwvPKYPX5w1wpOa9CF0Fh/McunJWYgUwp0+W/roXrQ31dnOY9y3/63j+Wg8+BUDgqwgAS6u1ddktw9gYg7dKzr9qBuSEQItpAqkzO1Z1tiHw7nhC8r+iPungiyPcrTeMe7+RL8+Yosb4EeYjLYRvffclKCj3f3j4722KzlCttOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGYfcJ4x; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/6A1N9r9g11CBrt3Vukdn053m3MLa1yEZ/i2KwLRauFd3Vau2poJMVCeKyizBBy2F9/fa/zGAa5SthBi9eAwdYqYf/bvSHda80Djpj5jenda84GaGqPkV8TiQVKZ434+Av38kFToKJC3Hh3+os/oaQIUKz0cU4YYL+94LqqGaxrp09IhIId6eb5pfFT+Dbz5P2Mwba3gv+pmKGgyzT/wrkroz1z+NYrw3VAUhXWWO/l8qb1woH/+dz+P2F0Anxf/vexR9RPUHFxNsgNNCgAimlzmQUWxXTlGRIhI+iekTmxtsa1lzWvoPt6MlrbeoNnu2/9KNpFr8O1f2kStRXrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USSkfRQNhMHyu7LzOzT+qdIz/P3FNXa52nXJAI62yuE=;
 b=pOt4rxkdUtMZKP9iSdXq5IAUnJElB/LAO649wWy+2a5KxsG34ZgV/2APt2ww1Ys3p2JqU2Ps+V4kzgKzs5wV0yN3iAtPz9wYAeuXgURJ2gb3haL+8F68YH0WIYEYstWL22gdjE+McX+nwnX8RdNonAL45d7a8D3Ds2oSvL47cC/xPCd4hyVXOJm+Fn23I5p6TZYpP3ZRpfWGTYfMQe/i1U/HOwpjW0wRuOZ0j1r11N9se3us8knutZHR3uCmTNhK6H06qB1uzE8Wskh/SOrsFMhqynhLSLT6klGNNZ+pu5NDUVIquf6R8bCu5fj5aOMXHsnb/iTi6NgIn65DsgVD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USSkfRQNhMHyu7LzOzT+qdIz/P3FNXa52nXJAI62yuE=;
 b=RGYfcJ4xUi74Fe7AVzHU4dygD7SNdy+KoTfr8AgDFBC3iN5nPr8L5fyeUcCHLWr5mbv0S/NNVRperhGLLM6Xy3ehQyPUiQWqY1LqhaothTIt/zEC5tP3wyBdvRIHX36AbmWO8Ck7oCAvr0vJcUizZFEDgceoicqVtoNKc3EoYQ0AMtu9eP6w81ayjBilbO4cfj1bz/qcYVvD/2LTapq612lCzpNR2iyuL5y3ZWWh0LulOd7lUorp71cQlLhngZ7TClAiNyV9c6179oj+B46wY1iRrYKvbfm5BxUcNedbAod09vhVbDbIbTMVJqsUlillTkrQIbBEOqYea71cONYsgw==
Received: from BN9PR03CA0355.namprd03.prod.outlook.com (2603:10b6:408:f6::30)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:52:27 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::34) by BN9PR03CA0355.outlook.office365.com
 (2603:10b6:408:f6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:13 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce deferred commands
Date: Thu, 22 Aug 2024 15:49:40 +0200
Message-ID: <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724324945.git.petrm@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: dd08990a-ba6f-4adc-73d8-08dcc2b1a851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIshSyeF3mOb83xQH0YMZzorNqWZUpRe8mDYrOB/ugsBNf6rhpE2m2HJ88Pf?=
 =?us-ascii?Q?/ZhzLd3zYUtlrLmx08U4LN+2qX8vkIvQpRUXMmUb01i613U2ljZRs1iorVkm?=
 =?us-ascii?Q?EYYl5VNxILuL6MeOdZdA8zhz4BULRGHILcUwS05tjoU31DRroCJBtuhNEbB6?=
 =?us-ascii?Q?LGljTiASgCkimzhofTRmzxOHej5AGcLNkkyfA5X+IlfBXtccC810VIIouHCv?=
 =?us-ascii?Q?wZcE18OtdkzS3jjB5meH6PxyZj5rvaJSonSaLDDLi7XYIz9E3wmtZUZsDyib?=
 =?us-ascii?Q?WoGJqFpaHQkXpp6x7w/GKqP4Z6CVsdAiX3pA0gLVu/6hLusFZp/f6FT29zaS?=
 =?us-ascii?Q?V3NqwvXaIZyRQbnaFpIPMyq21nMi+QQiavsyR3bNa08b5aIWolyrlsgUepcM?=
 =?us-ascii?Q?mMtRv0aobqfGBXPwjUzz5yP/F8TnFKm0VzyZkXy+yy1Vyn0i2gkBbLSPow61?=
 =?us-ascii?Q?KC11l5IWtKa+yHR5bMA4vUU+okehFn3miLdxq9cQ/sSWLcQxxVtM/+Ongj4W?=
 =?us-ascii?Q?8Hp3T6uW59GhK1pRb7LMgTNkZ5P5NpaguSVQCbtn5lDEz7tfDF2yGIb/CRSE?=
 =?us-ascii?Q?ZaskE/HqbDIwMEWTs8E9diFbkIpOV7S57N60BBDXNztXfhEL+zv4BfLglQ5g?=
 =?us-ascii?Q?bqsDYuWhnvzN/zBw/U50kl1G+mvKdcbaaGV/s8NEq43aDHg7Gh3F1bg1eJCq?=
 =?us-ascii?Q?A0Yy2L1aAoxG4xC6+XUEiSnSOn5eZAFtwjcs1M19h8OYLVLB4AUgoOk1W4eu?=
 =?us-ascii?Q?g7YmKj0hf5dSjyxHjx9uV2J6g4XtrRts0/HDVrrQ/dmdMp5poJyjFnQ0cdOC?=
 =?us-ascii?Q?30vTDBTup+GlIkngfEXWgtHNfwkPUlb+gKpS9SERkw6y6/++ek7IcNcyVDrD?=
 =?us-ascii?Q?HYZuxmh7W4a5V5k6n7wOwXLk9VyMPfdg/OId7+Kw4WDY854B7U73oWgHIzKZ?=
 =?us-ascii?Q?XPkdXrOJcaOLsgb+Gt7ZqsZeb97TaZB5Mxl0uKBOolUC+eG1t8m0XXwcVxlQ?=
 =?us-ascii?Q?m0IBIJUxXNRvrblvWy7V3PaLm18flMNFKCvHhm3AmLNIdFcpsSxT0EXUKsuD?=
 =?us-ascii?Q?6areKl3+TXfgUPde9xQ19X5q9CmJtcJzLpASxyuONXbsANzfmN+QAZy358Xq?=
 =?us-ascii?Q?OhrEmVQvTohKEHKy1gt9mvBHtAn560SeWCHzyAF0DQa8NJVoMZD4NHleVW/c?=
 =?us-ascii?Q?rP7ztfzaMRauCHHtU2pI4RMzidq/MNEJfWHl8ktGKaE17OON0t+EOZktItw4?=
 =?us-ascii?Q?UZaOzf53W3ApqvjLbDlJO3DqIwgkPrmXO91CZrZpdS1kWC0WUP6ib6yyNTag?=
 =?us-ascii?Q?WkNf85MP+FMqGBUkzm0V6QP1/bW5+UBEt3C5ppUewp9OyD0UKtpGxBSlAE3n?=
 =?us-ascii?Q?yvPRr2anyAD2SvzUiWFv6aRAD9Voln2gzdh9UP5YE/xikCmLI66I6111OgQS?=
 =?us-ascii?Q?Vd3sj3YoF4gQIdUKKNrjhnuf1xzc9doU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:26.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd08990a-ba6f-4adc-73d8-08dcc2b1a851
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
cleanup with defer()"), a defer helper was added to Python selftests.
The idea is to keep cleanup commands close to their dirtying counterparts,
thereby making it more transparent what is cleaning up what, making it
harder to miss a cleanup, and make the whole cleanup business exception
safe. All these benefits are applicable to bash as well, exception safety
can be interpreted in terms of safety vs. a SIGINT.

This patch therefore introduces a framework of several helpers that serve
to schedule cleanups in bash selftests:

- defer_scope_push(), defer_scope_pop(): Deferred statements can be batched
  together in scopes. When a scope is popped, the deferred commands
  schoduled in that scope are executed in the order opposite to order of
  their scheduling.

- defer(): Schedules a defer to the most recently pushed scope (or the
  default scope if none was pushed.)

- defer_scopes_cleanup(): Pops any unpopped scopes, including the default
  one. The selftests that use defer should run this in their cleanup
  function. This is important to get cleanups of interrupted scripts.

  Consistent use of defers however obviates the need for a separate cleanup
  function -- everything is just taken care of in defers. So this patch
  actually introduces a cleanup() helper in the forwarding lib.sh, which
  calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
  obviously still free to override the function.

- defer_scoped_fn(): Sometimes a function would like to introduce a new
  defer scope, then run whatever it is that it wants to run, and then pop
  the scope to run the deferred cleanups. The helper defer_scoped_fn() can
  be used to derive from one function its wrapper that pushes a defer scope
  before the function is called, and pops it after it returns.

The following patches will convert several selftests to this new framework.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 67f38dd1f36b..21cd6a2e3344 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1369,6 +1369,12 @@ tests_run()
 	done
 }
 
+cleanup()
+{
+	pre_cleanup
+	defer_scopes_cleanup
+}
+
 multipath_eval()
 {
 	local desc="$1"
@@ -1423,6 +1429,83 @@ in_ns()
 	EOF
 }
 
+# map[(defer_scope,cleanup_id) -> cleanup_command]
+declare -A DEFERS
+# map[defer_scope -> # cleanup_commands]
+declare -a NDEFERS=(0)
+DEFER_SCOPE=0
+
+defer_scope_push()
+{
+	((DEFER_SCOPE++))
+	NDEFERS[${DEFER_SCOPE}]=0
+}
+
+defer_scope_pop()
+{
+	local defer_key
+	local defer_ix
+
+	for ((defer_ix=${NDEFERS[${DEFER_SCOPE}]}; defer_ix-->0; )); do
+		defer_key=${DEFER_SCOPE},$defer_ix
+		${DEFERS[$defer_key]}
+		unset DEFERS[$defer_key]
+	done
+
+	NDEFERS[${DEFER_SCOPE}]=0
+	((DEFER_SCOPE--))
+}
+
+defer()
+{
+	local defer_key=${DEFER_SCOPE},${NDEFERS[${DEFER_SCOPE}]}
+	local defer="$@"
+
+	DEFERS[$defer_key]="$defer"
+	NDEFERS[${DEFER_SCOPE}]=$((${NDEFERS[${DEFER_SCOPE}]} + 1))
+}
+
+defer_scopes_cleanup()
+{
+	while ((DEFER_SCOPE >= 0)); do
+		defer_scope_pop
+	done
+}
+
+defer_scoped_fn()
+{
+	local name=$1; shift;
+	local mangle=__defer_scoped__
+
+	declare -f $name >/dev/null
+	if (($?)); then
+		echo "Cannot make non-existent function '$name' defer-scoped" \
+			> /dev/stderr
+		exit 1
+	fi
+
+	declare -f $mangle$name
+	if ((! $?)); then
+		echo "The function '$name' appears to already be defer-scoped" \
+			> /dev/stderr
+		exit 1
+	fi
+
+	eval "$mangle$(declare -f $name)"
+	local body="
+		$name() {
+			local ret;
+			defer_scope_push;
+			$mangle$name \"\$@\";
+			ret=\$?;
+			defer_scope_pop;
+			return \$ret;
+		}
+	"
+	unset $name
+	eval "$body"
+}
+
 ##############################################################################
 # Tests
 
-- 
2.45.0


