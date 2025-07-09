Return-Path: <linux-kselftest+bounces-36829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC708AFEC7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A824A2179
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90B2E54A6;
	Wed,  9 Jul 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ll5bvQaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A92293B5A;
	Wed,  9 Jul 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072377; cv=fail; b=MmzkEBUp34qwQa78T96YTcRTGyPBBAfvdickwrKHFAWaexqBfNOEolilequWwC/ewiVE7s/g7ixxlQ95+HcBjRiKtaQsJ6ObQ1uRqtcPT1ynZwIkrQUkcnb47lWQHcu01vl6y9WQIkxbALRIBtUI8WjQK37KAW3wZar00N7IRok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072377; c=relaxed/simple;
	bh=bjvNJOLq70ErX48FiPARYd2gIS5MBDqyBj1tKu4N9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAMh7h4Gn8nl0bb7kEjwRJFyVjVJxnlm+5FXei0sbf+SzjR9Cs3DvpChwnxSTm8AtXBSx/SoBacl9PMlTngny/GG8ujr8MrECmM5w4G5FLYjkf9KtkvjvcEbjT45VYpH+WEcPQH4UP2VtA7xUthlh6n4VeJ/uOZ6XJZwPVixHDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ll5bvQaN; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doUkkP8Ulu+AngyQLTubx8f8cOqjMChTrL20YtqCR0V/IsktvUl0+Nhmlk9F4B9Fx9mM9XtdQs454dIs1SNwAmApMM2Bp1Eac1UYuFACP+t+ljO8qB32bi3dUXsbn5xAj5AvuPI4cIck+gm+/Tfs3Y2a3cILoWZ9rWq8JN1aGv5o4JA6XcEwoFrkYB8SUhKtELnCSdpS8l7TeIDpDroLFSP38A0oeeBZj7kie/8FGKBzUzJY1JMfTQH7MFJt8sDOMpbI2ZD5zqgu7WxSiG+EFJ9vzjr6j+2JkvtEikVznWgm9H7jA+1Wu5eBTz+4L3x37k/CNMbZqA/BM815wSRpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3AEPTaq6IFG+7M+vtp2y2lsvAnrd0IZ2rsNH9EKaM0=;
 b=eEFThcFU1egEoEdmmjPkKb3zUg0xkxchKiLm60FKJ40UHKCnglSNwUrHcGeseL2+GXHDP3g6wlowJMlt3XnsGzpki+IJ3ZLbTwZCCnC1VikRZnMVXkJCaDZDaZf6UVXSJOtVPJxi3yVy0ozH7Kn5b6uVp6oWMlJSNvUlh4/+nuSGe0dZKnUYVg0aevK9HgdJTlK5YNnaAVOQauCZzng1zAuta60POEdYGZkGcn6GtAHZzsjJvVD/OGKkcS7uCTLXq/7sxSMlTkvp/V3PLwLxXHaUQOLVrKCF/40/FhGdGB1PWc42+/swCNmFtq8hfHRPAjFi3oOd+RyPs/zeqAyEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3AEPTaq6IFG+7M+vtp2y2lsvAnrd0IZ2rsNH9EKaM0=;
 b=ll5bvQaNftF34D24WiqYTCruY9dUGsCuz/jToLS61z4TOR1XsyWwAaReY9bzJ+U2SaaDX9/WxIZ9hUTr1kM5D92g5s7LcqxUV2G1s+7e/C0MJM4LbicZeEM1o0PFrzC5OhT4/LhQLYydDvECA+7adHVhyP9k/vTIsJf47R7MrMjcmBG/tG3v/Vqq140XUGgWRInzdYgEvWmfTDPlNjyj1xy8Xuwpwr3dTJDncV+yuFeeaIJhOnJRybogsi8M2AwIRL2BM+UuMP1CqAulahKmhLM42ZsQcdIG+jCZybDIN+nZJlB0GwWfrWaNew46R4bybpUcAwsYmMXb09PSHnBrzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 9 Jul
 2025 14:46:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:46:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
 david@redhat.com, gkwang@linx-info.com, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, p1ucky0923@gmail.com,
 ryncsn@gmail.com, shuah@kernel.org, sj@kernel.org, vbabka@suse.cz,
 zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Wed, 09 Jul 2025 10:46:07 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
In-Reply-To: <20250709123224.6593-1-lianux.mm@gmail.com>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a732a1-f99c-412b-c7f7-08ddbef7583f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsO/0/NueL2PAh+OZnrmF5us0cJIFw9sOLz9ZvXtjv/9peyFP23jrLU8RnL+?=
 =?us-ascii?Q?19Tx7JU9B1FpDbTnn/Bfno1wrCokSnr0cI2xFwRs+oBMmCdVZ6Zcm6bzNycs?=
 =?us-ascii?Q?bCwIpI3ttb9X0MezTDP1n0N7tj3k5oYOLitbIO8pq+HPg1wlVulFaLCJmfND?=
 =?us-ascii?Q?j/I63z+JI/yJRvhV03LGSVAJ9cDJvBwjHbWeVveNUMt8oFuH1eJRrXCV/wO6?=
 =?us-ascii?Q?Mrf2pQU7zk/w/SWPcv+jsCBduNIx0FFY11oPeehNi5al2B5YbjlTs0AujGyk?=
 =?us-ascii?Q?V/UIU43EBj1k8OxbN+UVWijXBBxwQ9vXd8sBnxe6Cn3VtdVqzOwQ45ApOrlk?=
 =?us-ascii?Q?Ay0m72F07iqo9rFpiatJubfd7/0n5ozb/gGuPMU6pOcJJfTlBSVvcvDfWjPx?=
 =?us-ascii?Q?nrXSX8X/D2oZ8j+mbnv7c8I73hlr0S+vJBa7rhinCq8f3AdjHl6WmJYV+AwC?=
 =?us-ascii?Q?X3mPdwNwmKFLWAbH2N2YskPT9RwpdkwQKNhO0Trbit1uiK1sqGd3L/dVhgRl?=
 =?us-ascii?Q?lXAEsHlBiQJLVUdEAoF5MR0vjK3hwHjasoG1LaVg5j0vPzvrB6Yiklj/466H?=
 =?us-ascii?Q?TPxexuXFdasjFxXcg2kgYv+geGPd8fwirSUIrQ5yNHobXU3M7OHNGMSWYjto?=
 =?us-ascii?Q?xtlXnuOPimGM+fcm7SyKhHI3BjcY/IjAp0mxznLaE0cYePUw6XsR8HEZ0vhD?=
 =?us-ascii?Q?4pGsho7EXv0pxsCrfqp6FNh7yg+HXHFjPhae5F2Fj77tNvnThKet4IYtB+V8?=
 =?us-ascii?Q?m0SQU7id3Y78rLs9nv4bRLgaGf36EfLS8VyonICfQFsenHm/mWDPgz7olv/5?=
 =?us-ascii?Q?ih1wad/wOhktMqti3pCpQG8l+yyvjva8HGmCtaqdAShYYS+Ny6RC0qHcDxuJ?=
 =?us-ascii?Q?EkLFSiiufFSQztMIaYSZ/ZmIkV7PXbOpfmv7XbpGqW/iFvCg/QEmJAe1xJkZ?=
 =?us-ascii?Q?dTkF9Xa/vT5R9bjQviwpGtsNytLK0JFNB5a7LJl4C7rIrQkkSguS5b9ZeP52?=
 =?us-ascii?Q?yNFakoGrDyV31d6moHIOJkdeWXK//mFO2TTcH2JlvWmqEEV9ZHGA+wrIwc21?=
 =?us-ascii?Q?b/eFajGBzigdWlzHj0f8WSlUQYx22uEQzskXmo+6tUM2oM82HF/lMcAZ7REY?=
 =?us-ascii?Q?pMQhSPK/eGR24gsNWu0UBjsWBcDwzW9Xer3sege9F1fGirb3tl3iZVbwJonE?=
 =?us-ascii?Q?TIhTD1uzpEeiy8NWAR4HJm0oDQiifJKAhUx05ywOL6LRIyN3N+w1SgBzsKyY?=
 =?us-ascii?Q?9b69SJBxf7pJp4wJ5stDiRDggZp7/YB3PDB9NUpaGzAObJNl5t4e+s+NcU0J?=
 =?us-ascii?Q?FzLeG5XKU9Req45EUDsS8hHMZAkXfdQK38APl2C/tcKDcOdUHNgET234AjRk?=
 =?us-ascii?Q?xD9e98t6aE3ignrLUqEEaSnsTLGUK/uge7n6+PypTuDGFsoe9ZlGYbYAac9S?=
 =?us-ascii?Q?zDvamvyhQdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4ThbpHX0y4N4DBQWtuHKSAt0YXmFVjIogKDqWAxFb7fOQ5stK00cBzwYxL8?=
 =?us-ascii?Q?wSAhfA3nu1gzxdjWRaNHVEH4fkymQZjZRZ3SPKQM/9bKkQV4+/ydaulzu420?=
 =?us-ascii?Q?/To0oc5DXQDMXGcbM7neVkllhLdIIqAPNgZzts4G+3dnGm3yiat2It4mwMzx?=
 =?us-ascii?Q?YcSdPaieL38QHqkAy2hFP3JfdbxLLqRNkQv16u2B84Nw43FenVPSgGUMWq6c?=
 =?us-ascii?Q?glFv3QgcLATOW7t1XhsZo8Tq/T5yZuxW+latq4eEHDvQOPrkoZMH6TmHjEZU?=
 =?us-ascii?Q?kBHkDfRubSnZzLtW7yp9pRHmqVbQXmqMHsF25WO+iPnLL+LnWlxarYANSexB?=
 =?us-ascii?Q?HY1GGRm3fdwAo1U4dCgCmxqF8MHPgol9W7MVCGWe5E28wK5GU6+HwqeUzPyR?=
 =?us-ascii?Q?ST32eD1cMw6bKQKq3k49tf2PWTsJW8KeC8mJkcnVmoHY/zido6PFiHjsOZyk?=
 =?us-ascii?Q?QqF6MgBg7mrlGBLKauK7N3HzW9ZvCFFaCi2JYcXRVWWmLRMYrnx1ZVYrnWDb?=
 =?us-ascii?Q?AVKXkA0nqBiGTUs7Aszst5w9TsEWY6NxcSpPI9IT+kMjEJ0/moaQPtSO/yxy?=
 =?us-ascii?Q?Eu3JjcJKAbFfUdIIH4j8n42B+OgKbGOLKUGX4ESdLifbGlz02NEwb4V+ZM13?=
 =?us-ascii?Q?hGqlTY2rOTYbxZTf1BqNezia2D9nGJDwRcVYjozWnGq5Wxz5cJCiB2lyLTTv?=
 =?us-ascii?Q?U1QTBYKlhsHq5LqOBx37JAIsfXe3DYMBvhwnM3eKvAjTbqza19q125Z6OSqT?=
 =?us-ascii?Q?4PsXwiAFmAZy+6ag9XdZzvU4jSLOXNM6IjZfiokzN4ZRlsgwjtJtXkZVH3Vc?=
 =?us-ascii?Q?x8S3X4y4f/AB6A2uwoXDOIpqhlbX4+XTNFRwLhPbDf3vo5AXuf4Wf6blfARe?=
 =?us-ascii?Q?WzevCHCu1Kgsq3WAwCdIsvz7yOV4n57xosEmHUJ6v0o47KFT18ddu80iW5ln?=
 =?us-ascii?Q?feLbzD1qMTkOLiGzmJi+OdP8Y+1gAf1HfTAH6R1heBW5PXPeJLZlFF2orYyL?=
 =?us-ascii?Q?L5F7c3hNq8rfQKilWKaE4GTD/we3gH/stjAk4e57MZ7DHcOnMLpYJlm8RWw9?=
 =?us-ascii?Q?d1bGW6Pyoi2DOwNUzjMPQ9ruRFfEtQJhSteMvnSio1H6ydyMUKBRgln8DQHZ?=
 =?us-ascii?Q?RE2xz69F6kgv8Siq2uC9SNCHW/jGSi4Az6WesfzyKQMjSWnbDK8N7ouvtVHC?=
 =?us-ascii?Q?1jtI94mkDF6R2gPqInwfzhpDJh1vIz72kMIfv620Vut16UFqRHiDKxzPh1Jv?=
 =?us-ascii?Q?9GP8WOb62Ax3HIvbF++/8tqdxd/fCGaLe2GnZwhybIvjnjfrHwzAbZ8gFTXC?=
 =?us-ascii?Q?XO5m8ZmgzU4x2TUo5zmJ6JD11rMto7MNLANSxWZeQUpXOjgzS/+uWoyrA+/l?=
 =?us-ascii?Q?VIHcMRmnjCobQ1ylL6bdAVvtbzkMz0FMUzirOSom+KMmOAC82A2fTJXCl0qF?=
 =?us-ascii?Q?7I7zbqPyddst7b8WnIZ/H6ueGwgVeQjnnQjc9VOcIfhT8/4oLeHIZNxP+dAC?=
 =?us-ascii?Q?Q8BmCU9XzOg33Ub+nymrcXDZ/Gbub+ncYq1rd8TpNu9X4gcNneMK2RFMMmdJ?=
 =?us-ascii?Q?a2P+SvWntJndaIaB8RkCvB3Q0WZ8Fe76XfXfeWUA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a732a1-f99c-412b-c7f7-08ddbef7583f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:46:10.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFgw6ra134NtRlACPfkoCzijbeg2QiGkKqJte44aru4qJ35QvCvLQCaVop/whjRg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

On 9 Jul 2025, at 8:32, wang lian wrote:

> Hi Zi Yan,
> Thanks for testing the patch and reporting this build failure.
> I don't have an arm64 environment readily available for testing, so I
> appreciate you catching this. I suspect this is caused by missing or
> older userspace headers in the cross-compilation toolchain.

Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
should not rely on userspace headers, otherwise we cannot test
latest kernel changes.

> I will try to fix this in the next version. If the problem persists, a
> good solution would be to manually define the syscall wrapper to avoid
> the dependency on <sys/pidfd.h>.

Based on what I see in other mm tests, the following patch fixes my
compilation issue.

diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/se=
lftests/mm/process_madv.c
index 3d26105b4781..8bf11433d6e6 100644
--- a/tools/testing/selftests/mm/process_madv.c
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -10,13 +10,14 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <sched.h>
-#include <sys/pidfd.h>
+#include <linux/pidfd.h>
+#include <linux/uio.h>
 #include "vm_util.h"

-#include "../pidfd/pidfd.h"

 FIXTURE(process_madvise)
 {
@@ -240,7 +241,7 @@ TEST_F(process_madvise, remote_collapse)
 	close(pipe_info[0]);
 	child_pid =3D info.pid;

-	pidfd =3D pidfd_open(child_pid, 0);
+	pidfd =3D syscall(__NR_pidfd_open, child_pid, 0);
 	ASSERT_GE(pidfd, 0);

 	/* Baseline Check from Parent's perspective */
@@ -312,7 +313,7 @@ TEST_F(process_madvise, invalid_pidfd)
 	if (child_pid =3D=3D 0)
 		exit(0);

-	pidfd =3D pidfd_open(child_pid, 0);
+	pidfd =3D syscall(__NR_pidfd_open, child_pid, 0);
 	ASSERT_GE(pidfd, 0);

 	/* Wait for the child to ensure it has terminated. */


Best Regards,
Yan, Zi

