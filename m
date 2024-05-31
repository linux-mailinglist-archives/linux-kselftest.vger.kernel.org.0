Return-Path: <linux-kselftest+bounces-11058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412588D6A7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E1D1C20B60
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0C17F4EC;
	Fri, 31 May 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YARHF+WK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35217E465;
	Fri, 31 May 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186088; cv=fail; b=BEMIuMygvr07mvwbMPqnKflbMCXTRXTp0pmlGVZbJxAMVdxHQurKwHAqTlv8bVAbbVfmdm5I71jrGzjFdWCU/O889nmL2yn/tHBLrzQEtrryecM6OmzJCAc2m59YQYjgBwFbEU24pJnctyjlUmDq/ygXp0OX4NFynRHkDGZTSv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186088; c=relaxed/simple;
	bh=lyrdU9ywPV6tQblRjHQpbjKpx0OqtvVmhYvFxRDitw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNmYoLxNKstqBNu5v86ZMUYrRf0H3lEc3/wAK9Vl86QfJDzatZa99rYa5Bu2J2KPi1lfUHjQOnHvOm1TNuMBUgE6fAJQJ+Gs8rRQjK4Ko6JP2YvEunJMN4xdhf/2UVN4hfIMnQUyU7+4n7ksqyfaeezqX54BDUwRjW/TmaeQY1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YARHF+WK; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqQtzuin7yHAgHd3/0yXAAVPF90Tw0jVGtLh8KVCGcXGqjRaAFn2B67B+7Ot22q4AYhcJeF1R8pqkkgfvwOSjLotvrR7vLyBL5FPlmNzQbUFTANDMpRCrbm0cxySuO5uFI3YOrC8mEpcxMmNQe2KEe3KizcuOq1av2bqw20hbSgwGcaODofTHwL30n8e0Qg9u+buTlap9HlTFGdsrp2qS+QDv1Pb8wrjs6MIohXj27TlvLTBzHparqUM7Q0XEQ1iLF03hm5e4eDK4VojUm+9bgq4ZkoQPTm0JuBuyTDHVfLhaPsTGqEspnJGhvreuS0inqUuJSqBj4QsnINR3JcILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJoxXBNzAu3/ZxgJhtTMelWsXD27WupqI8v837F8y+U=;
 b=ZQueBP7SPCj0sByQvwpJBFQd1KSoQhZhlHVOZRbpHwXmKUSGnL9WEk6f/FLw5L6ZQ+qE+dHII/HrntNRfEEGYsI539PLFVGk9cweTX9bQK68aCOvi68EM/BM/D0f0ZYFiIq7dCqCMF99DwYDpUHXC3Oj4VgmtZM6ZqdYBPF0iVUq+00OyGwVkXA7OXrWJMSjNBIlh+P0r//AoHbr0TRfiWG62B9A7l4S15eo1JWKKWd8FJsdYyJfUrsytBPlXT+QWJoJKm41gphCZNhriW1kvCgDCZXT5Jgl+dZvATZuvBnArUQLVa6btm3Vf/2L+d6qcozaaUGxWbyeBTxqDagIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJoxXBNzAu3/ZxgJhtTMelWsXD27WupqI8v837F8y+U=;
 b=YARHF+WKLGM2KgyJktS/2MrEiYZ8eePa5RUGKQBidwUcVqsmDCZRFtS95PGNQV3Al+3bGOOVbZsbPKNU+Cotxie7Ndzmz9qbrriVJNOiLJ1VhSYsvsP/BxY7y7/t3JE6PImy6Jhd0JRR48yEV30t4+ctVkAvizFl/5AonvbZkeegwTOV9haLb1yGR9Z+YpNQVh6gDfYuYEXfLW+U3/ZtEd0UjmM53E3/gqfOa1ym/sxnJPFePOpH/+TIxF/LaKuVmgvyQurQvo8XixteHDYtc7ZAF+EKMo5gl8r4OJDojzfim/k/vztLM3xqqyv5Jxt/S3/d+MMxxO4HavGlg1Xp6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 20:08:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 20:08:01 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 2/3] selftests/futex: don't pass a const char* to asprintf(3)
Date: Fri, 31 May 2024 13:07:54 -0700
Message-ID: <20240531200755.128749-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531200755.128749-1-jhubbard@nvidia.com>
References: <20240531200755.128749-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 25abace0-c4fa-47f9-f76f-08dc81ad5f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUmLS/nyXtCYPQQ5WH5s+07fXIEyD0Th33l8/Ins8F5JnJSdUvvgGZkL+B4Z?=
 =?us-ascii?Q?f4+Ep3e3oM2ZlngO5e7fd0WdCrv0ey3DVhGsqj40NB7maLFeAxuksPKIPVZk?=
 =?us-ascii?Q?70GazZx3f/RRH/MTygWDzcOUGOyXv5peWJi5pWFywWjnzABhAlOo/MKfFA13?=
 =?us-ascii?Q?FBaOkmM63QeaN22VpgP/IECVzhnjS1Si/eaolaPj1NzNcN9HuknGIxqh8PPq?=
 =?us-ascii?Q?otVU+opjfRc0CQaHKIpepiTpAJA7omD/IwlinB5z68hAIaCfZQKNMnmysZwI?=
 =?us-ascii?Q?Qb+AfgkgVKxSpEJ82Mefi2eNEplgeJn7ulTqk1mbhGpwJvxiWCIjuBqzyfwl?=
 =?us-ascii?Q?h8fhmvFOirR3VJOhPkOSqHryORTPP0NRc0Os8twe/7Uqi4Y079jRO0XOiT9H?=
 =?us-ascii?Q?f3gT2qpRl4+VQlR7H6HcEiG1hdCpM79bmL8q4MVkFYW4KHjTPMRxPtwh0lmg?=
 =?us-ascii?Q?+Axfxv/+KEDdhVy0h77cWbJNlaYPwSzGuwo4OUm2Wqqi9ayRGj9RLjvZo5qk?=
 =?us-ascii?Q?ELqlDxWZ+c04xSpi5R+rq4s9acyK6iZ5qAeElb48Z4udXlH+1gY+Cx73VGYA?=
 =?us-ascii?Q?rtJgFGmvb1WVJOAF7UhiFMZIsjEkxCP1xtMG02wbUhJGM7PZb5q7CxgIxM4t?=
 =?us-ascii?Q?IgWhmN1qo6PNLpHLJXxVwgtua028krFhPsEX2sREx3QuC9rYymbvtlxg3NKk?=
 =?us-ascii?Q?5UcHfGiuOTk8ACZe2116Czz74nPYEacelWqdf/DKF2nxohvkPHizUMJgJaU8?=
 =?us-ascii?Q?ZQqei2REs42+mnrVdx7LpGaq4YZLAkhR5gh7VQNz6CzA+OtEeDnhdTji4UTm?=
 =?us-ascii?Q?4TfHRFJff7K4qyIL1teKqFYb/b+oAgLbhTiCnifgUfsXEys+fpUr7olT1JDB?=
 =?us-ascii?Q?7Ww6qzqNLiuPZegVcFiuQMsCpaP9mF52tzR4jHynzYj7EJOuqatO37Mhzbm/?=
 =?us-ascii?Q?r+Q1vDjpnEIWpt/anENTnX8nQ0dtOqqhbhjv12vTrtGermbeVgCKxpcGYkKR?=
 =?us-ascii?Q?KF7fmg7+Q73fmtY/B3FTyleZUtXF34rSGjVS3LuZq9ZRNsfhE83WdVMkhsTI?=
 =?us-ascii?Q?5qnyyMPE0GL6KwHjOMlDhp6okvwryPjPlzdz0k/hLcVwOKb1LedXBtAKsFtH?=
 =?us-ascii?Q?6dEpnaUhyP19QSetmXkOYkoFzCbCfwHtU1c4z+ueAAKbigvA8PyGAoeD2qTq?=
 =?us-ascii?Q?mr6NHCMz49LKwe3GVAQxTD2ifYLDEASalq1C+qsqzzHZ5ZRqvLsSkUJFkvVA?=
 =?us-ascii?Q?/cTx6R9cTdkcEcGQYwo302DQvbK4T7VpkeMrSB19jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLSKu0ryYG0Aa7MgQwB2f0U+/V3Fop1Rsr3SSz22Vjew1LzzLF2A3SL6Y+9u?=
 =?us-ascii?Q?hkFx80m4e7vw7zAkTlHtmjPo74ocfp6OWYyF9FWuJwkRmuwVhUy6YbaLE31a?=
 =?us-ascii?Q?XXoTLmEcZGEZx5v0ALKOANqsN82+YlukeqGprnV+DaSXCTC2zPT6peWRCa5g?=
 =?us-ascii?Q?3Jc2q7RFGAwNlFD/RxXNjdw32T2jmubFIuJdQeEID8nNmN8huY4WlYgTbPbK?=
 =?us-ascii?Q?4H2rZwzf4/o+Sec2vTjeX08RXpS7VLmmhg0EcUOPuJJbaQXvZ0G40tBgQxRf?=
 =?us-ascii?Q?0EwMpBpzvaPsQ4lBpSb5i10cTQKS5bSopmivDRXsIKBkmyt+rsXVlub3aUBE?=
 =?us-ascii?Q?dVcsgUIXnd2iu5fs37DE53gUXMKqshldMQ8oVdeZVuRdbNd+SDiWG1fp7KQ8?=
 =?us-ascii?Q?HqV2xywvPXhjkXnhycX43bv88scxj53Gtbqk1EWAqCkctJj86Gkn013AeZW5?=
 =?us-ascii?Q?Q9X264VpIEln11hIvrmxZAtiPFuZ8FzJpADCx9jhKhuUU80/EomYsYFndAOp?=
 =?us-ascii?Q?vHD/gBPfDKcpe+0rysfSFu+GdECerthn63AeEfB5R3ApxoAYCVLS08lAxJvc?=
 =?us-ascii?Q?UertAhLxSD1KLkY098R4fnDIsGPS369tNV1iqQJWd5X7n/RJWbcLQLdQfQV5?=
 =?us-ascii?Q?yQCkagdOMOjev0+d8Fcu3C3SkcmtHG206lafeQ4xd5rj77sI4Ah9EI+2yqdI?=
 =?us-ascii?Q?2bTmKmetP5WTFZ4+qsdfAwFHmK6Q3MJlkwk1Fl4lXwBxcHYL+ktzjlFXcsPt?=
 =?us-ascii?Q?4btZbA9vmO3IVM49Efm59feko6AUr5OJpmEivBblWOzJ4Vlb+HubAfyNu8Wm?=
 =?us-ascii?Q?fPm4GyOJPWstBxjTUkmddgdnxZ/6Z9pnbwX/+d6618JYBhH4lZIrdVcMjOoR?=
 =?us-ascii?Q?UX415IJJrK3jymX04Yhrl9o9hpSuE/COuSYTqBHRSVwyJ6kfMNP6LNhccyJZ?=
 =?us-ascii?Q?qMWiq7gg4NnzV1tIxur4jB/eYiQNf6ppM1bxEAtYq+8xXZw/p+jxXTsbfeKT?=
 =?us-ascii?Q?Gd2wrx3waVR5HlAzDA7+sw8j1DdC0rF0j+5FkGwr0ncvbiPsoErUsl+M7LRZ?=
 =?us-ascii?Q?FNibAT6c073hcYkXxsE7b1i3feopi75KqAGP/OtoYzj959wBMD/BqGvsc96+?=
 =?us-ascii?Q?Tuy84SHG506Q9pukMphld0L4Zuu3mJADpIVWWwKuud6ahJpliY44GmQyIoN/?=
 =?us-ascii?Q?P4efS5vowjLPMk98StJlKfKWk666J2y9irdWKZLwqix9RUuN/arOvtZcXIZk?=
 =?us-ascii?Q?HQzNWprx1FvwFH5fk/cnQN161y6tS2F6i9EjW2NZ5T76MgC+7qAUZyqWJp0I?=
 =?us-ascii?Q?CsBOIz3tcSOvFrYx7KZiO8pZbWCfE0paBDN0F1WrXBykSpmrI/MPjYAFaR7U?=
 =?us-ascii?Q?6ved11aBe/2Bns6gmkfU7qk2Urkj86C5cFxzBHE1loSKGuqkTrH3lqu2DeK6?=
 =?us-ascii?Q?rYCm54Hx/6//jYpuMtBIBVSpPGGEyCI6T76N7EHj0Jsbncq1LAa4OaQfEeoO?=
 =?us-ascii?Q?nyU5VnYRQdHFgjTg3VHiw8iI3PsQcCaq7kOhMfSmqEwssr3zboeUYSrJHa+w?=
 =?us-ascii?Q?8FImdlxbTyYPIFnJ8YZPkPYt/85zbXWWbGQ1Iv0q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25abace0-c4fa-47f9-f76f-08dc81ad5f4f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:08:00.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyGXHVkiLc0Y2OEzE5pYKh5cIJNV0BBknrupVB/3HPsJb8qgaIGfmnzWP8bZ4EXmjMqBfHTptkLlhG9jT7eg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang issues this warning:

futex_requeue_pi.c:403:17: warning: passing 'const char **' to parameter
of type 'char **' discards qualifiers in nested pointer types
[-Wincompatible-pointer-types-discards-qualifiers]

This warning fires because test_name is passed into asprintf(3), which
then changes it.

Fix this by simply removing the const qualifier. This is a local
automatic variable in a very short function, so there is not much need
to use the compiler to enforce const-ness at this scope.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: f17d8a87ecb5 ("selftests: fuxex: Report a unique test name per run of futex_requeue_pi")
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..215c6cb539b4 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -360,7 +360,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 
 int main(int argc, char *argv[])
 {
-	const char *test_name;
+	char *test_name;
 	int c, ret;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
-- 
2.45.1


