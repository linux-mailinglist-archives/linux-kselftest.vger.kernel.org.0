Return-Path: <linux-kselftest+bounces-11457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F1900F2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F651F22173
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E4847A;
	Sat,  8 Jun 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a8BsrJk/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77A6AB8;
	Sat,  8 Jun 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812631; cv=fail; b=Erb/FjoNh5QHde0PexVtpDW5qKfzWOoWvMUZiKQc/i5+asqrUOqZdVm3N1eC2agR0uTTx9reL7mMr9oN03Vt3/FJM5AMB2t6zyaUmMO+W83rlkcHkSkLMJSVfJwTgLPd9B98bS5qCotqUJmOR4MWRt09bBzYYLo9KYqmeB14Gpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812631; c=relaxed/simple;
	bh=0VxzAmdBTUInOc0Sc2cQqEnlt7MOQJK8+EPrCzg95dU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GB7iU4slggRemY/GXGp0WiA5Tssi4TZqK0ridAV9stUp0bjMv1trctwiKq8/zX+ILlQ1lzDwgIyfm28LlRBVGUa9qoYHw2AM1zvgtHsS2D/Hx1Y83sWDmC8kA0w78ihnSSAxaLESM4mFhXIQGOLcI5aRIi4djbhsU63DctjYFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a8BsrJk/; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3oysspJxGmHYs9amR25tXah3Xlxo2x+IM6/mopNzp7dg7su6b5yWZDL7URJ5FdZ/OcVBO75L+Do3nGbgWgVMyueYhYsig6x0l8q6jUFewlrzkEQVGqsRZL8pnTUTG7mQsYE/C+4A9sKC7k2ugtmfVx2mnjI6iNXgYgOHlsdvnzDjdHVHY9SunjR+bzzoq6SCnLhmzsppxarQiUbLCtrDNKGtSizJtKcsPwKX9Lqkom3fd0TV5YSoMqi6+A0bdl2k3QyYdjJSuPhEz1Kf/lU1DlZmMWAOZR0anRcdJlMRUpLmSbAFDEu4imwvjANQ+rHYt5VUg7/ASV6mQv0aBF2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVDnhOwlI/39VMZ3bsvgpIHu8ZZKgMSA5+3+OPHxcoY=;
 b=XfpuqRkaed8UzTNaSi5Rx3S7m+NqJ9A/EOW24ys/uit4jYi5644zeBa2BrhF0mCsLKU/+5foh7juvez5FTfqwzet7MhYJC5Xm5n0lfFTaQt1ooMRqm+COqF/EbOGblK6zSaYUc5092JUIhvPvpge9DT1Hxce+pkQtODfYSBoBxpjJFXYXVH7l00dPI6ydmwHRwaXMzxnV9D0KOAv+VeWWvWWuVXogfnGNyCW/2bjuIxI3jUjBqwgh9OTkxsjqSXi8s4XSxKr0a4iGn4SP9rGZUxecKOHh2a6p0d2SxBD4xmKp3UPuOPVSdv14eDjOQ11favaoNp1BDk+tWzDQIf92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVDnhOwlI/39VMZ3bsvgpIHu8ZZKgMSA5+3+OPHxcoY=;
 b=a8BsrJk/M5FcQ+e9+lPZgMT9pUjjgMs71l/j68IOrmKcT/PW2Tmegn87OGDEOS//0oAeWA8xX8LNyunKiuOQu6zwecA+B0r7+TPkhF/EGqhpGTSZO236BCazlt9D6ka2vB/Zl2ByIxk5z+ZO92u6cb86cPrGCdjUl/QAz9GZMwOWkINEyIutHcXBw+5BbGGHOEUeGpKuS/F8mKavOmvr6ylTzg84rYTmwqNZ9T1J891f5q0D/OWxrsYcsDn7sH3OtSfsENY9yP8VJoHa5Xx1a+k30wHW2oRsjfBFad7g5xklZlBbudfTC1TgMDoVD0aoU8jSGGbcfWLqD9lTBMHw2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 02:10:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 02:10:25 +0000
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
Subject: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
Date: Fri,  7 Jun 2024 19:10:18 -0700
Message-ID: <20240608021023.176027-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: ede95936-ae5b-4b19-71ec-08dc876028e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvwTEObELXB2IkuN6c6GZpRTAuaM9ewNx5HdKYlx395+JDPnsy9iPuY4F2hF?=
 =?us-ascii?Q?pmf6CE1d0xH3tHiBk0Kn/m2XuRIIieGGXERCCfhUFuG9uGoUpsu2iR9m5EIq?=
 =?us-ascii?Q?uCAfugDRKcO6GrN355/LLDPkNt/KnjouGY2wx0jMqurq6XIY0cQ/00UBP4Fg?=
 =?us-ascii?Q?/21bso4C5PbNmpzuNsOSNaX6X7OsejhZe/jMLXY0D+9lquZcJEXiHmFvLN8e?=
 =?us-ascii?Q?hcsa5HF9GnkbAxn0bq046kQGeCfKIJT6cAxwgySirYZYYqzFpUy2DkQJZ2wS?=
 =?us-ascii?Q?0on/UkW74DejWGBaOvN81N60MxOWlpON4jmBAYXt2NfNsz1ChqEVH+lp0kap?=
 =?us-ascii?Q?ZwNvZV0o3uwqZULjudORautxnqjSkQvYcK36pFhUAf/spGy58SXCvsZzDwUk?=
 =?us-ascii?Q?VNOuVorCpq/Di1iqB3FzvmaD/rM1wq9jk45jwLptFtaUfdVYJDkoTzh5jBG6?=
 =?us-ascii?Q?6XRz2laldHsS/ZmNFUS67osQJMBujV/wj04nicJziDQgf6S1CDrTEfxJ4cqu?=
 =?us-ascii?Q?G8j30KZBDzVPjEFjZWegco95eT0q0yW/u60/sA4RF1YIxlSNkWJprlZex9jL?=
 =?us-ascii?Q?P7E+s+/8mqbzRy1PGSAmLc9CqXl3DSebr4Gxr/nh7uFJbapmH4/q4xcsw8ow?=
 =?us-ascii?Q?CnzV3riNV0SiOy+PsZAkU/GsLhBU4KEf6TtsJpu4PeKiAw5jvsIN3gIIrnMw?=
 =?us-ascii?Q?HvxN7rKmnEwFb3kxCy/o/AgKEXsO0ibplA6JqHIVrO/lwzuzuARkYEm+0YT7?=
 =?us-ascii?Q?d0BbTtSTiy29B2kjTcf50jh6IOuz6SfqYwlvg4i8fuOVzodbBtreHpPBubxz?=
 =?us-ascii?Q?gclPix4yPiOnu0VxptuZqKoSbhmu6evuXkmA6QCuGDvgZd4sFDP+cZ9pYh/0?=
 =?us-ascii?Q?QqJOxm1yIhHrMLHWuSaABmFjFsiXo+tns1Viy6rA/ag/1rcLw00DK9+Knuxx?=
 =?us-ascii?Q?PgNkiZnfAtcIjCyqwJTjgGqaTI2Gh+Vht6aOC/WAahVLw8txxIxgrsyDZ6CM?=
 =?us-ascii?Q?evFxOaQTObtp0FaD6YOkRlzAliK7609efDP8a3aaab6P8JGQltOKiPdSfg4o?=
 =?us-ascii?Q?eeE7dw7sUCrspplrYsi2u6+ECaiKYlTy5XIiSZVEqGGjpaRERHwDHkTCh383?=
 =?us-ascii?Q?uvoA5pywlQpk4lCu2dyBVt4DwdyY24ZRAEsbw44Y+ZKIE5KrecpqDEuU+VHH?=
 =?us-ascii?Q?qnbyrLeaXEn6OLOMVE2X8mP1cqGt9at2fYIazIfdyrNY/0b8K1KRrbGCVUbU?=
 =?us-ascii?Q?7bLDLPMJVAcu6N0FpjEqpQcIDgJ7UK8XpnMQcUsEhndwCHCR7GsJ4AwnjNGj?=
 =?us-ascii?Q?yuydcFAlTu5CBYQhCcVDbkgQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+H/d5y/KF60qGPWZNBlRSzUZSLnzh+AynK2jS1XCeB1cqrDyNBtLgI5xO4Xb?=
 =?us-ascii?Q?+h5ZghzWE9HH+qpl084akGH6sQnfljm8OPvF2Iqh+yofRqJh9kp4RhzukLDf?=
 =?us-ascii?Q?fF04wbyafi7rGwEVE+6TyALOdcBsgzgOAk4XjGvmnwL1F/Dm0kGDNZc9xu19?=
 =?us-ascii?Q?NcXunhoQMmFqC7cBJG8LSnYCy3/YxNYQ8Ej+TKPSM1f3nwIrrNluHki6oEai?=
 =?us-ascii?Q?G1TqoK2wNKx5ACXBFxMCapsVKkCyXuDE/F76B6kaHlXsXyuyPJzC524lJY8f?=
 =?us-ascii?Q?+sptbXHRxY8LPBE3wp6yfCx4s09wGveVS/AcYMDB/EPoYhSGlXrFZWXTqJ5r?=
 =?us-ascii?Q?5e8INo79b2+LAGvPqQ2CPxAv4jTl2I/bFEVxit7wZCaB04ITxwlfrB4LvwsF?=
 =?us-ascii?Q?UCV8+PEpVBfK/MzGAnERZkhtry9UTaWNIOX4Q/tZeu27tMWcvjwKuKecYmYs?=
 =?us-ascii?Q?H+XSuEjgXVjm3/ssB4/icTCdUJ/DsuJ3LUg1zOPFQnNBoXpx0IxkaMON4pPV?=
 =?us-ascii?Q?VYODBdvOkE8dJ7K5bl3LZ/nCnFb18xSra2EN0TQv+psonW2mUrsSSRuFvydn?=
 =?us-ascii?Q?e7GSDTE8bxakCb6NKB96ZGi7S4Gk3X6XIs+wuQGgASoxMWd94bCXjQY9KvO2?=
 =?us-ascii?Q?lEpEvdHEqbEDoRRx8yuKwTjOV0pdg7ftQaNbTAlThb9RcV5We9+gKXGsGszm?=
 =?us-ascii?Q?qDbUR7s6xmtWOWHOZQ1z0QPCNvfDisUlpid5Xxz2epf+Kr5NMjwsrZaIC00M?=
 =?us-ascii?Q?yRg9E5BejqOOAadA4j+L4RkO6i0Lhn40WBYO7GiqMZnpJdj/lhFIB2uWPvgs?=
 =?us-ascii?Q?PBajKTGF7shzUASEMmfRA2rQKQZHtSUZYI6UHvMxH0mTMaPYT7O0WVAHJPhD?=
 =?us-ascii?Q?AQo80aOWfyRkzCZ0HuX7SBOze0su1snurQEbdj7I7o1vlJ2/ZobSTAQH264D?=
 =?us-ascii?Q?9ZBlcce6+zeEh2yAlxLhBXvno45JIPfxfP+2Ve6PPyoR25d7M62nWnp03Whb?=
 =?us-ascii?Q?m4kfed4rJnm11pCQiCzxmHt8svKb1FtJfGimhbx91OoQw1CPQwxJkOt2fLd0?=
 =?us-ascii?Q?HHPgztIdLP5r2eG9deXS9BAPAAWRIEOZZAxonC0nexCNTMUHzMy2leXz54Hg?=
 =?us-ascii?Q?IWrufG5MyIdAhqDoYj9Ri02EXYIxgx0v2BrMRyc6pJ8CtsSlK/th0JmXlef0?=
 =?us-ascii?Q?XJyBOWqdZmR6OYxNPvIPjYYK0I72SrlCQzHMZsx9L6rSswAlV6XrpuIBhAiz?=
 =?us-ascii?Q?d+ttnTv+eKB6J0vLggaZPXmw08y1OJJ4XVJyM+Gj7QxaUQWI/UHFbkTaY4jb?=
 =?us-ascii?Q?sG9wf+bNqIPY1jsdWC36ML2BWmprYTjEN/SetrbY9x+y+f2Xz5IvXmHiGz9m?=
 =?us-ascii?Q?emuGHUxmGcFxVZxMu3f0SXB7/2snGTraMICT1q/EHYSg8xevfSE56Sr13mpl?=
 =?us-ascii?Q?Egv+WkyHfGpViDmRk3xo0SSvHIQKcdudV/jaGw4KeS/lBBT9ojvyA0cXHMoz?=
 =?us-ascii?Q?jesSi7kJspyLMmcow0rnX1bMvq7/lU/dsmyErKEAzNJrbkzImA/ywaOfEF1f?=
 =?us-ascii?Q?/7Grjacu86okfURuIewvRXKwO9RZHAsPrupRjgnQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede95936-ae5b-4b19-71ec-08dc876028e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:10:25.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwxFW/WDfMtc6EXPlaV2sPRJRwxBXyQ3ILci3jpSSvV/v9WwLSerV1tmFuwEfFQrarrbBxjxUtDjo7yjsL5xVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Eventually, once the build succeeds on a sufficiently old distro, the
idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
after that, from selftests/lib.mk and all of the other selftest builds.

For now, this series merely achieves a clean build of selftests/mm on a
not-so-old distro: Ubuntu 23.04:

1. Add __NR_mseal.

2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
after running "make headers". This is how we have agreed to do this sort
of thing, see [1].

3. Add a few selected prctl.h values that the ksm and mdwe tests require.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

John Hubbard (5):
  selftests/mm: mseal, self_elf: fix missing __NR_mseal
  selftests/mm: fix vm_util.c build failures: add snapshot of fs.h
  mm/selftests: kvm, mdwe fixes to avoid requiring "make headers"
  selftests/mm: mseal, self_elf: factor out test macros and other
    duplicated items
  selftests/mm: mseal, self_elf: rename TEST_END_CHECK to
    REPORT_TEST_PASS

 tools/include/uapi/linux/fs.h              | 392 +++++++++++++++++++++
 tools/testing/selftests/mm/mdwe_test.c     |   1 +
 tools/testing/selftests/mm/mseal_helpers.h |  45 +++
 tools/testing/selftests/mm/mseal_test.c    | 141 +++-----
 tools/testing/selftests/mm/seal_elf.c      |  35 +-
 tools/testing/selftests/mm/vm_util.h       |  15 +
 6 files changed, 502 insertions(+), 127 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/testing/selftests/mm/mseal_helpers.h


base-commit: 8a92980606e3585d72d510a03b59906e96755b8a
-- 
2.45.2


