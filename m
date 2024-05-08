Return-Path: <linux-kselftest+bounces-9736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E298C0593
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA8F1C20BE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C4130AF2;
	Wed,  8 May 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AVUL8OJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88ED12BF23;
	Wed,  8 May 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199815; cv=fail; b=G8jiuTAsyDY+FOFhgbTAKepXzWaaI2uAe8JOUXkua+geO+a8sNrbBl+VV3lQC1hrm51h3yQ0L1voAxHqVs/Nsf33vtK/aNsPB22QBC0m4LYGAhYk6IYFZmfsKkz2uswGyvNl2VgN/hdQsZjcn9pqYuxLo//ZWMnVtYnHDfooGCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199815; c=relaxed/simple;
	bh=g18jf6mDe6maXJwix5Caq+5bTlKc220C+1E+5KrHQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SE7r8623vRtsFafUQTmM82tnkrkEbHMM8uq3OPfRWRcWehTNx1DfbmxwYL4tGbZgbMEzJIQcnL5AWsFLrVXkatgr/E0YyWkMsaVvUL37L/Yk0zjdA+B+SqxMRR/+qEmHqg02tRB+jvBvvZxPLlfy9rFMYnhc07m/y8yaGPe5k84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AVUL8OJ/; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1eMUo24afk6hdi1y7Xom8zmAO5DijQ4LJJOPnvkDfb5WNsqCrQ5ULpvFi/nLwpge0nhe2IvXBTVUHMXl9wWNSQw0l54/KxWrOutzPIi2EUnNLK3SUGmRwm4fF099cpn+UX2Id/AURpsz/HqBxQI4Txm89hvdnidAHs8z1e8d8mLMhZQ6dNMA8D4VgMNQd23aSM20HLDwM4CVqbJDXif+wfCQKiJNiBq0VxsWGg1/SnhNvQxlvf19+J49PEmee6cSxAJcOUWY1cn4ZTIcLYOYcvus4b5TtHWHh3fMLyPgj30z2DKiQqUcLMSCyp4fTEe/1qrsYRYTR/LFeS9ry3Ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tld99iQLIM7pNI9h1kZAo6dvDHu4FH7cUzxTr9Muf5A=;
 b=fd48O9waf+yvmsx9HcH8/IVc7TCZcXwOVzlkDU9CB5kO2GqmcQfjLmtXR5p6MjdskS9PTpZgvYQ8oMuTTUFodMNVOmVkCLFA1PsD4UfQdyVIePJXMQ+pm0/idbA6F3B8IuqXjYsnwtiURBthxHcV2K/fxNyVar/3xXxrZ94Rs1ejSfTOM1CyarTP1+cExwBVDHVZBjx35zkevjyrfC2T6WWjI+P1ODGBMBRuATHPXUsRkO7lcwdlFy66zlpR7XZOJ0X/8Fz2cNiMmB5mdTEKp+Ar+4j1aWkcZmoT7C4ldDIdvgGeM7gxdNe5J3I29K9LQGxWjHf65q2CJvbJdqOVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tld99iQLIM7pNI9h1kZAo6dvDHu4FH7cUzxTr9Muf5A=;
 b=AVUL8OJ/U4kehxkZTIaEYfysAGFn9QRFW+N5rLfBrKbOOor8TtAcifrscUkl9G86eIost4MfqEM0wvgv1F0bwsIX01CwL743zuEjLCaa6UtZY0k3GbmNkAqlV7xf3ZGDB2I0Cu/+rdWppWbCsC6wAdwaDg38g+4iyeCPUjN/OjYYweZQMAaK/bthS2loLURV+RUGp+k/oln8HQg7a2OkcZ1mrsBMVeSxglGwf1gVIdkpKE2+JEiF7GqjJiX9zvIrDTxI8PO1C7Pd2i2X1plhMl5XXRhKTDBEHtgXno55h4nq01mxecF9GDLomUY1oQ5zmtnHzHxT7osKoVuY/cuo1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 20:23:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 20:23:25 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/netfilter: formally SKIP() two cases of setup failure
Date: Wed,  8 May 2024 13:23:22 -0700
Message-ID: <20240508202322.275565-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b80253-b170-492d-07a1-08dc6f9cb6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZrGTogOrvHBMia9Stl7tz5+MVeSTRojQnG55hFJ62vo6vfMUHbmylhg+UmVt?=
 =?us-ascii?Q?ARSerdEOKgCN2ErScU3e85fcI8iyFBiPie1NjWhKgva+oIu9vDggSpZEpxuS?=
 =?us-ascii?Q?IR8gUTNcKNlBjSsNUoaDM1cIfL+GkMB47mssFOeF68tPkMoGhsYv1ypQ2mc1?=
 =?us-ascii?Q?5XYNeml3hqpsmgt1qEK9zhMkP//rxq0+3KDV1oQXOIvxgPN+0RAF4z54AbvQ?=
 =?us-ascii?Q?kSQfRgTmPTLqpsOrH25liqcmriBoP22xWyO82uPESYc9Vjb74KQB5krfRXTS?=
 =?us-ascii?Q?5G5+gi8Yju/ptJEIxzujjzRXrNS8nJpu/QzHc6Gfe1jhBuVorxXqri5DJSK7?=
 =?us-ascii?Q?CrIF5z6PY4P+NDrNiAdY6gmm2peoPP/lzowgc8iFSuUKxC/AN0IHGI541eVZ?=
 =?us-ascii?Q?+MjHgAJIp3QOQ9E0otUHylBbtkl51uLxZ83xqb5aOtbicnnLDEO0zDoyT4cm?=
 =?us-ascii?Q?aSifezYzs8zcJAtm4h0/Bn7hohEiVRmGDGQOCYglgL9BCZs7AIMKe1OO0pwy?=
 =?us-ascii?Q?S9KSPwf55lyaQA6ZBqTkTl85ijXD2VjOupHbdjgbyblHWDvnlyxlOAhNMx4V?=
 =?us-ascii?Q?Kjrh6WHkBtplnkghjlqMUCB0HRmYY0ZwUblBesC1oy1R3Vj56JwxYeHEpbc4?=
 =?us-ascii?Q?ba8iTNuoHnN3E+Qw0XamIssCiIgetAEy/zcfpHkA/DordbleHG1Kx4WnD37u?=
 =?us-ascii?Q?FXWk/1Oj16xMvbRBcpuTSDpXWQSgKz8WorREMjm5zhtCdQCQ+iojdKrgmUVH?=
 =?us-ascii?Q?nE6rt9gr6eMLbw2Q09QO6rQ+rHMzHUioWQsiaQ8AzgZsg91A8eut3hMf+tVB?=
 =?us-ascii?Q?fb2SSqWGEhHiDr4WiTeGwFoExnSPBDxvI/TSTnjXswo3mIXNIifVbLqidBMY?=
 =?us-ascii?Q?PBs2fEXeX6cHoW9h5VvsgN42/CuAVmkzRuNyi5+rFd6RyAVdt1waGfrCIvAC?=
 =?us-ascii?Q?0ASGjSXaf8SPxcX4DgmONpiJAbFCvTW5j6+JKwuZmFDK52jXMhfbUcYV1Vp7?=
 =?us-ascii?Q?zsJwofqAYv5+9iuH8VzJY5Pw7cogdgtGT2v+ePWftCVn7YR3ou7aLZawdBW4?=
 =?us-ascii?Q?pM9mLUBaPMsjxwCXL1VoAmtfXhvlh0qTUbPcRJjER3wX8PgWDn7meXRtLDj1?=
 =?us-ascii?Q?7ZX66C40mrzFZj8tm51GArFj+YI0iyYMZDkwSTjHkfjtF0lFk3l1J5BfaOIY?=
 =?us-ascii?Q?2PL/URI236x4HCmY5mwNdKWnByAMEBBQ8tKrXPfm/aHk/iiFq50x+paYueMl?=
 =?us-ascii?Q?c8M/PL64vamvrWiimnB695/dHkki73csSAGPitfHOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIBhhIPV16boendiENVWLWgqyZYuHfscwV9agpgs/J2p36gE6UHB7zbjid6y?=
 =?us-ascii?Q?eDCDXnfDcl4f3W5bN6P3ze7zwbbEpH7/jXaxB2KxHtEihSrMBhIvlv3BJ9y6?=
 =?us-ascii?Q?ON325OIbHg1mzV+ETNiSsY2Drg2sYlfpCkpUBvT93c6kbZrPmJvsTRDzpwZ5?=
 =?us-ascii?Q?MXZIrv9BKYGZ4z2RL8384h4kSvW8MqSvgQkipzdcaedbm/f6JM6jTZwYoMmK?=
 =?us-ascii?Q?QuiwlZ+T3R/rzFd41TOKmkmyRR+hML/ooiSxLd7H008S6iCwDgRc7kONMjxd?=
 =?us-ascii?Q?bAi89C96HGx03S0lCk1kOrRg0ICzdMbfuUIvdKQQHDjduhvxrLX07QJz4511?=
 =?us-ascii?Q?Lcr44blB9L8UyGY0y/Cl3cmk2gKAzPgU73Ak+Fw0uvu1yET/CXoPSuoq7JyL?=
 =?us-ascii?Q?L3BO2D6QlGbi7Y61XZVDpEXNQ6WUtVHI7S9VV/FeH1cVKc8BUkmnQ8al1VoF?=
 =?us-ascii?Q?kfpl054lTQ8QsrzIlR5lClTL9mFVB1Z1rRrvmIYPYnkZ8/ujqYfTFGI6cAo5?=
 =?us-ascii?Q?N5N9CtSVmXdHu17MtTFapBOsyMCY+b4sGL5p44Ymf0bHvp2vwEQzIhZZZ3fh?=
 =?us-ascii?Q?+qMHJWCArxIurKe5SUJ8QZ8wh8JRd17z4ZOrGhJfo3fcAdzJVKmRHKhGQ7Pc?=
 =?us-ascii?Q?QEeEJNh5cMU2eJgplcdhtreW6GSiufBGWnmaVdt691yJD8EkAidLr0DaFoYv?=
 =?us-ascii?Q?aYZaTBQglBQ9PpuSBv36BE6nZcRv0ANrGhUQqlFQwv3k9gbFF8GLb46CnjWR?=
 =?us-ascii?Q?JxegHu9QZ6qlZjvdaKJQmKGHV9igH4PFty1uo2i9x0B/maEtEBypHIKcHUg+?=
 =?us-ascii?Q?BNM0QEVWe2XmYLZd6TM9xIBQ2u+WQ2LF0vd3C/9WlW9LFuDm312zxGXyRiwB?=
 =?us-ascii?Q?fDHIzT9SHbgLswqkbIvVbl5t1RcyvvQd82k/WNaLfYdKFcVxaxi7n0EMiIQF?=
 =?us-ascii?Q?A1wQXAmKM78AkkxLBcUOzvDixl9FfJjU1Mbs1Dbpx/KzEak6sfP9CLwldwmv?=
 =?us-ascii?Q?oPyORQ/vCWFhjXoc2jkn9ndWika04yddexV1p+jtoEIXAF/mLDz2pbX2Cn/w?=
 =?us-ascii?Q?fqyHdemAKTv8rXHzwjbqNw0rPYQjDEUBKQLgk6rBCsognO8mbV/HEWlMxB2v?=
 =?us-ascii?Q?LeK5OkbDZJFh+VCrHco+B9e06HGf/0icyACjHiWxIvFq2JQa6UFufCKOkgvm?=
 =?us-ascii?Q?UcDiu6wMoSiEx/tacUDSGMEhMOLAMtVbFS8Ga+x8u4fKfQt1J2A1pG/rGHwP?=
 =?us-ascii?Q?rAyt3S5l/kYJDhdJpUI1s1MAZ3vPgPZxUtz0sEYTsYzkBn5vWnaFjvPFIb7q?=
 =?us-ascii?Q?gr8vyOCNAsh5VYBJmHSZm5PpFS7MoB1T9efczsvaFYmx78c6WdIb5jugq4EC?=
 =?us-ascii?Q?Ra0a699xo+v5YlOHP+o0ITj+bMlam/iLjFPb9uMplK7duGGrkbuk+JdnRq2R?=
 =?us-ascii?Q?Z5jD+60zDlyG3UeFk1rfVrkidfOVZhqWmjMgUpMyOD0MHiBmGLxGxT61hAO/?=
 =?us-ascii?Q?+e1RSVM+lTc+ncy/kB8EUCmWaueQL7iwcEvNyDAjwBksETU0NuofJgOF6n0Z?=
 =?us-ascii?Q?/FwaWDXHszhyc72n1gnKkweL/d1RGYx8asuawMIw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b80253-b170-492d-07a1-08dc6f9cb6b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:23:25.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zII8W7hTieDqEZPnbjA83CLLuQBvnOQ5ExS704en6947hjPXLSo7sjWGJG84bHSKU14NncyvHR+cwsGckxJJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

If mnl_socket_open() or mnl_socket_bind() fails, it's generally due to
not having the user space parts fully installed and configured
correctly. This was previously ignored and reported as a test PASS, but
what really happened is that the tests were being skipped. This led to
generating inaccurate TAP output (I've omitted the leading '#'
character):

   Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Fix this by using kselftest's SKIP() macro. The new output on the same
misconfigured system shows:

    Totals: pass:0 fail:0 xfail:0 xpass:0 skip:3 error:0

This was briefly discussed already with Felix Huettner [1].

[1] https://lore.kernel.org/all/edca87be-d8a7-4c62-b9c1-f9b3f5752595@nvidia.com/

Cc: Felix Huettner <felix.huettner@mail.schwarz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/netfilter/conntrack_dump_flush.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index e9df4ae14e16..4a73afad4de4 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -317,12 +317,12 @@ FIXTURE_SETUP(conntrack_dump_flush)
 	self->sock = mnl_socket_open(NETLINK_NETFILTER);
 	if (!self->sock) {
 		perror("mnl_socket_open");
-		exit(EXIT_FAILURE);
+		SKIP(exit(EXIT_FAILURE), "mnl_socket_open() failed");
 	}
 
 	if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
 		perror("mnl_socket_bind");
-		exit(EXIT_FAILURE);
+		SKIP(exit(EXIT_FAILURE), "mnl_socket_bind() failed");
 	}
 
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);

base-commit: 45db3ab70092637967967bfd8e6144017638563c
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 9db2d20be98dc44731d8605a3da64ff118d2546d
prerequisite-patch-id: 72413b9b47d66666f20967a664470199892fe282
-- 
2.45.0


