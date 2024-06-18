Return-Path: <linux-kselftest+bounces-12111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A690C1CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B7B28364D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673C1A29A;
	Tue, 18 Jun 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9xKDle2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C88814;
	Tue, 18 Jun 2024 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677473; cv=fail; b=cOwq8vM0XeYL4X2JqUR1gxg/YUgT8Q7zqJ7iVf3Gbv3ZinyQAYYiLVct5TuLhbRC/89SBTE6aPQhNlZjMG3XK75pCw0NmTE1q8p8ufhmmrmn1T+dCRj901E9Hnbt4++dRT7HKiM7Wt5tXDTd6OqwY+ld4Swu2fRQc65cvN9P3hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677473; c=relaxed/simple;
	bh=cNF9CXXUYV0qZOLocWhG/Apnw36wWKQiCKITyJvEJBs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EeX/W+rY1hSDaPWezDtAm3y2WEqL7mAqsE7xn2vUC2ewuiTuHPIEVRnRg7RMtHhQEv5U1qu0s7731iy+vcoQQ8CRLDVQUTdceNXi2FHpkRBz72+WoR8UagmFhU+C+abpLSDMGadi2PPO2egPu9qWFo+8JqP4gMTz/5e7w8dibnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9xKDle2; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcVxMwklDpxt0szYaFz7aH2UKNp53LI7Nlt/p0oEqjT4zeoZwXfeAb+KueZiYygDNLHzjy0yfC46oEwP0TuXLMprV9pY3t672atqDtI2C6mIgRQ+3VheVAbEs51YDA1ucpNCdVFj6/nF/C+zXdiX1l+Kqsb8cnoK8pqwxFC7UiXPo0HoN64MWITPuwxMrTifx/ddsTyLlnE0tx2CopPMgwMqcutEB0/6ho72LkEEjIFCa/hianjB+L54mXU8T7i0KO0nNCWKgPjiE+rOTMT/usF+6qv0/Cw2/11AAPRVz4jU90HI/VWeu/q9+jMyrNu83vGY7FDIM0L3XO2F0Q408g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4j1D6rq2Xt95UVQa6PobPnR+SkOGU7xEeKCeFMfgkE=;
 b=fdZTWkRPDyK+SQniKULGwr9OadJcMARyjzmj45pzm0s7Gw/WrSsjWuOWcskiHFh+/VO3gAGBOPggxyo8EOQDEpgXX7Gc9DaGkp7LrWRDiHdaQpjQ5PB5xHej+lJ0W1s3MmXxLnPrvGL9w9ViXLmvBPI7IaV0LFyOs8GVRv/d/y/g5wWuP58xvft/gBlHCTtR4QUleWKeONgV1djDTDmDS0MBhtlhrvbXFf0H2yZczopnOZgu7usVPyHHVDGFGaT0d2A8nScQ/S8LdZBRAAEwZPSCi72A0QAnM+2i3hZoWMj/OwayRYPC1BN0UkcM3nkz/lfmEhhcJNjmjvGD89FxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4j1D6rq2Xt95UVQa6PobPnR+SkOGU7xEeKCeFMfgkE=;
 b=a9xKDle2xY7ccCbIAYS6SCdYwOzG+DIIoGeplR90Dy/mdWfN2hBzK/czCPZJzunQjFUTgDIJtEQwUbMJui08pviojtn18D7Z4YluroWmSIej1XK68OiR7iZcfcjoG3KVmp0/xp4KGogLHoE42bySamysy41qylWPvFHKmE8L+h1IAP2PV8ULCYG5aByvidcnLbTNxR8C4UElqumXM+UqgIeBUpX6v1H8JzHQa/1Y6oL5u/yEqhzi3Mc4DF3Xp9+0lwc7izxeY5wQe0/12xda8Z5JzIG5hq0ZJc3IyQ9k0ynzTPnznScevGWFo2xJt8q3nD9BSR2M4nMN+Ox559xUyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:24 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:24 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/6] cleanups, fixes, and progress towards avoiding "make headers"
Date: Mon, 17 Jun 2024 19:24:16 -0700
Message-ID: <20240618022422.804305-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 964ab3fa-bdca-41d7-8baf-08dc8f3dc517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvGcXlz9chvgfhAWrUYabWOhY/8lwl5wmlE8aGq9tqyOBTiwT0m8MVyRoraB?=
 =?us-ascii?Q?3plmNZpjMV2nmDA7k3SjvBK9yWkDwTPS3y3mvdMNH+E0ALnoyh9mIM4zIcqJ?=
 =?us-ascii?Q?x0ZJHVJWJEv2slRVFfwKVSRPPEjtDGNIyNLQTeI+IeYiIrDoiVjp8JUNJQBu?=
 =?us-ascii?Q?lrGpO5c8YniFn/zuRiJKGZDZLfNgPltXiOL6NxEZM3UOHx95f292Sq2NaM7L?=
 =?us-ascii?Q?my5LoGN4jXFD1NC2pvuYDbT4nVTe/Zn7O4xe1SYyCOQindHpUuF8URAYG2cY?=
 =?us-ascii?Q?RMOdnyRIGD+x52ungcfvSZqwEChP7wTuORRuLpJvE9DYO1jGiE0/ImTQ7gtI?=
 =?us-ascii?Q?FSHCQVwyjBam4mC6tg+olWwi6MgYvzDtuZ/NdWGQ6j1X/Px8bVMrUVBXTBEp?=
 =?us-ascii?Q?2tGz43Aa2a0/JVv5ZFpvXD8qqjauF/wjepTj0HvDi4KOt+UExQygKYxG7xGS?=
 =?us-ascii?Q?mEcV13dzWKedMvxQ8sHxSr22HX6eTJdaKBB5KJDpnFlmdbXoN3p4ijh8Ml12?=
 =?us-ascii?Q?r3UC+/pUKhjksqO51oXkpX6MNswXMB5ZqUjl+5bI/Fa1+4GPubX3DDG6icO/?=
 =?us-ascii?Q?17/IcXN1IMQ/k37F/mmrJDDf/O6CyAH3+BwJdvdDa0K+fBlmPJFkydl53Wiv?=
 =?us-ascii?Q?25bqhoYUPdofs7ZiQMGa89b9Qcc96FDtW7jn/x+ODKOcDWWyzh2ffPVo0nTc?=
 =?us-ascii?Q?3vRnDm3aGf0+WcHxFrZqJRtYX5GaqOwuDn2GJrSl5pYBfd5viJKSoO82bQLo?=
 =?us-ascii?Q?XPw36HD0UYqSRjFKVVYDz/oOnF9Ig0OOycaEnYLsGy4dsyHS/OK/x3AaWkdc?=
 =?us-ascii?Q?bsb8MzamuVOl72HykeUV5jHcU+IPE5s/UwlqdABgdK+SvFFIblqVMrzOQ4sP?=
 =?us-ascii?Q?pzKPcHNEXesnTmLIkmaAf960l+HZPmQaDt2+n9K0e5lNPg/yVKurYBUzYy7h?=
 =?us-ascii?Q?vMksfBvJtk+lFoiIiIkRYtINDTSVVQVe6oWpPe40Y+rOuwV1XCb89ZX1HGTO?=
 =?us-ascii?Q?DiYyYF5rh5FDsmq90Rj7/NkgDlMK6aWUC3/xhefCsLAEk+l8a/sChWWgK9z9?=
 =?us-ascii?Q?2ceCXKTp8A2+BNoNDEX3x5GeGo0q6R6ApXCNHE0ceIlz/uPFVNO6yImImNXp?=
 =?us-ascii?Q?7BLflrxq9eIC4iD4LaBilKlSuMeJM84NitpFjuw+t6GJt2uItqDBqwU5Rgfu?=
 =?us-ascii?Q?KbsyYGFDcX5QgqCvIiOzJjt/IWDC61fQLjP5FDds9GgPWApnZkr0+85ENoi0?=
 =?us-ascii?Q?89x/7G+XlXDx9iPaCtOOXxm4Z6yvIEKoRVEGbT081hiSZZWX2lK063xwTvOT?=
 =?us-ascii?Q?a3jIwsIQ+AtvRq52oT+5ISuP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/12DT/UPqHaY1CjPitA7UXDyDRisVvUs+DTu/t6FXfxs02MsEB8QuTGTwAey?=
 =?us-ascii?Q?XlUhsk6jlwHr1eY2HUC5DsdI7hP74DFpqMUDfCnddZ9MQYl9ejlmRDjUD8/Q?=
 =?us-ascii?Q?DkcXHcmI7P5g6vWCM8m8uWkGScpsStArm+H2QX1+ZbL9PDaxCOosD5nltUhe?=
 =?us-ascii?Q?/cry4uVf6ayIMkHC9WCIFpJ2EzmLAt/AWFjxIt1LAGxN4923E5Wa9iwvq72b?=
 =?us-ascii?Q?E2vbjEgTRUdpT0OSIVKzgFyWoHjryjpgXbd+SBKpGeZgXghygBh4A14tvx6Z?=
 =?us-ascii?Q?pYzYSfY5PbAYPnh90TwxDjs1KVpGDsmSjm2HJvx4ZfnQz4LewTAT3YsMeyKD?=
 =?us-ascii?Q?BlJw2Rt7P6CDCcNLXe2FScDa3/tOxbHu2mXhfJ77LiBXCiJvOQ+qFyb9ld3g?=
 =?us-ascii?Q?YRuHh61DYT6Yw2elSFgWg0GOZ0K/ruNhK8ii6xLUJWwOL1b5kZwNKy8FMcOP?=
 =?us-ascii?Q?kSjryn97vBm8JG3C8yOponQPwiiYPBDNValOUZDjq5AAeU50x9gTKg+6Bz8P?=
 =?us-ascii?Q?dUXpUuqetwkwkO1Ui9SjJi/WThEaHJIxNri3PkdgRjEvmaBQlYOPLrMiXrlO?=
 =?us-ascii?Q?qLKAoArfCo0mH95FUYU8eaU6Dg+gcHQCCAmwo97me90GIXW9adT81vz1MThM?=
 =?us-ascii?Q?wED1QcoUYIb25+aAWrmEdG2izPwoQMFjQVrZwwOq7ZGoCa/a08kXn76UKxg0?=
 =?us-ascii?Q?zCqwlziCekbdmJvFTyY8grhUq+PNnhC7sKhy/nlH4ztIIL4SjAso9oobI9S8?=
 =?us-ascii?Q?2Bf2CsEZXjRMzQYFlP1fHZK6KTBLMGqv7H7iY/2YVlx0D50AfkKVgTw/lMdZ?=
 =?us-ascii?Q?VzWbmbVS861nFFtl77bA/4lzT4lRZxymWgQmDakzqIaCHl++5WIpBo/XQvhD?=
 =?us-ascii?Q?N2/dnHKKeN44LCDrzur8b6LHyeZ/BadmnnF4LqYit6PaweGJU8H8DKHCPYYn?=
 =?us-ascii?Q?MnvxzOzN1kzRF7x9R9+LMgcdT1X63xNK446QVYFdhqy34avARfDbcoR9IOkX?=
 =?us-ascii?Q?1SXqcLhz2kpwVApJtC5ttwUw1/sJzl7fWJEZp6GorEb/U7fg2zAwl+wthdPa?=
 =?us-ascii?Q?kAXIosdH/47C7ZjY2TJEypa4yfqtdcflgVfN3NW/iOaYHpPnS4hR5tp5XZrq?=
 =?us-ascii?Q?O41q65L2bff5gFQF+GHQBZA++iAKa+t0d24wYIY96OdjqK7hB5IFlnJS6iE4?=
 =?us-ascii?Q?dTlHASEPMPlveP1XlfsyL1RUB2Pw5OeikrkSzzTfFSucj2md1Ole6e/iUDn1?=
 =?us-ascii?Q?z6zQcTK1ZJCuN+asnp8ITUuhW3Y+eYHQOIbZGB1xb8luZNeLNXL3Yx9csmfV?=
 =?us-ascii?Q?Jz77IiojBf+qIdQ4FIoeSbsDYNvRKJmxS1GNL4uzeumNXFI4ZBqrj+O+rCfU?=
 =?us-ascii?Q?FuoUuZLpGgS+BMTJPRHdWobONyJjRftPjrBv1IL40nh2L3ODatK7gJWvvXAB?=
 =?us-ascii?Q?r2ToZt3azovX8wJAcvjI3gFkk5h2ahvWjQG+I4lN4uIK+x4r4+thQD1lOsu+?=
 =?us-ascii?Q?muuo+djccLYukcpNjOsg2nnhKOqXYLNH1cF6/ZZkn0lthAomQYqv9JK5nigD?=
 =?us-ascii?Q?sDT5WsdiolFLYRWiOa9qvnorpKlUJ5ZDNM3f7cE/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964ab3fa-bdca-41d7-8baf-08dc8f3dc517
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:24.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTaYY8rehLUcwoxqdCyb0FVSfwxPYpeka01NrltItnIkUCfB5k0jsNRQQQqy+gBlgwIBrgOuiRaKULsCjo7Ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

Changes since v2:

a) After some disussion with David Hildenbrand, simplified the "fix
missing __NR_mseal" patch down to just two lines of diff, after all.

b) Improved the "kvm, mdwe fixes to avoid requiring "make headers""
patch by taking a snapshot of the prctl.h, instead of manually creating
defines. Thanks also to David Hildenbrand for that.

c) Fixed up the final patch to use asm-generic/unistd.h.

d) Added acks.

e) Rebased onto 6.10-rc4+ (today's top of tree).

Changes since v1:

Jeff Xu, I apologize for this churn: I was forced to drop your
Reviewed-by and Tested-by tags from 2 of the 3 mseal patches, because
the __NR_mseal fix is completely different now.

a) Reworked the mseal fix to use the kernel's in-tree unistd*.h files,
instead of hacking in a __NR_mseal definition directly. (Thanks to David
Hildenbrand for pointing out that this needed to be done.)

b) Fixed the subject line of the kvm and mdwe patch.

c) Reordered the patches so as to group the mseal changes together.

d) ADDED an additional patch, 6/6, to remove various __NR_xx items and
checks from the mm selftests.

Cover letter, updated for v2:

Eventually, once the build succeeds on a sufficiently old distro, the
idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
after that, from selftests/lib.mk and all of the other selftest builds.

For now, this series merely achieves a clean build of selftests/mm on a
not-so-old distro: Ubuntu 23.04. In other words, after this series is
applied, it is possible to delete $(KHDR_INCLUDES) from
selftests/mm/Makefile and the build will still succeed.

1. Add tools/uapi/asm/unistd_[32|x32|64].h files, which include
definitions of __NR_mseal, and include them (indirectly) from the files
that use __NR_mseal. The new files are copied from ./usr/include/asm,
which is how we have agreed to do this sort of thing, see [1].

2. Add fs.h, similarly created: it was copied directly from a snapshot
of ./usr/include/linux/fs.h after running "make headers".

3. Add a few selected prctl.h values that the ksm and mdwe tests require.

4. Factor out some common code from mseal_test.c and seal_elf.c, into a
new mseal_helpers.h file.

5. Remove local __NR_* definitions and checks.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

John Hubbard (6):
  selftests/mm: mseal, self_elf: fix missing __NR_mseal
  selftests/mm: mseal, self_elf: factor out test macros and other
    duplicated items
  selftests/mm: mseal, self_elf: rename TEST_END_CHECK to
    REPORT_TEST_PASS
  selftests/mm: fix vm_util.c build failures: add snapshot of fs.h
  selftests/mm: kvm, mdwe fixes to avoid requiring "make headers"
  selftests/mm: remove local __NR_* definitions

 tools/include/uapi/linux/fs.h                 | 392 ++++++++++++++++++
 tools/include/uapi/linux/prctl.h              | 331 +++++++++++++++
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 .../selftests/mm/ksm_functional_tests.c       |   8 +-
 tools/testing/selftests/mm/memfd_secret.c     |  14 +-
 tools/testing/selftests/mm/mkdirty.c          |   8 +-
 tools/testing/selftests/mm/mlock2.h           |   1 +
 tools/testing/selftests/mm/mseal_helpers.h    |  41 ++
 tools/testing/selftests/mm/mseal_test.c       | 143 +++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |   2 +-
 tools/testing/selftests/mm/protection_keys.c  |   2 +-
 tools/testing/selftests/mm/seal_elf.c         |  37 +-
 tools/testing/selftests/mm/uffd-common.c      |   4 -
 tools/testing/selftests/mm/uffd-stress.c      |  16 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  |  14 +-
 15 files changed, 824 insertions(+), 191 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/include/uapi/linux/prctl.h
 create mode 100644 tools/testing/selftests/mm/mseal_helpers.h


base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2


