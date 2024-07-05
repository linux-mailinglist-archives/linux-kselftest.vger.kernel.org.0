Return-Path: <linux-kselftest+bounces-13250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25920928DF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E043B212A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142D16D9DA;
	Fri,  5 Jul 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxB9/dJ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1413AD13;
	Fri,  5 Jul 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209468; cv=fail; b=OMQ3yQBcG37E7KAnJWSfeGRjN+qRJeIYui21TwzhPp6nAWDH4GKxl3oiDnaIvTPZYfFJ4sdFVqUYR0twrMIrKhxuCuOCrThParBRJA2z+zq0HxD1yjGE6cXuuDEVDOrQ7jenyLajrZa+5eFrsD9pq2nv17mNKu2SO8S94kFH+Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209468; c=relaxed/simple;
	bh=YKYrYdLd1Tc5maJbU1heVzC/qCMVguedQBjheagDxOc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HnSpvFnBW7i/fN4uy8OpvxZUfHDQFY6jdsPyNIJ0pyiP5ibaohzxlFRdNjyWqJPzGmJvF59Jl52nc09rVg7VD2JCaI8YgSle7Co327LTth63hSglSSmsGXas2nC0T3dTIOkGIE+o44fe+y+UP9QNA+MQz7obwWtI9bc6NxG7QOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxB9/dJ+; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqidsdoZIZfphc1SspoSikB+v6MdgMUZy/lul3WQu8x/65vVmuSVeA/sdCcaImV60BAPOtBZ8FF2yPkuOCEBuJq/8W9U5cdpcrDCGsbiWB/n72ptKtgGpbw++lOGibi2TAp8uJjSCCiHhJZE0144rKZYKeKO6bvuVr8SIDVqbEp7UwY0GSFx1kLWP96rlSeCP7tk3mj5hipI6yvgR4uFblQADyj9JNzBcYofDx4hU/iIh+rusSEXwfNIdRnFz/4B4jBkOxRTrfszrSj6sYLE38HIlEHjDPnZNllKUkY/ptdrdOYYU3W/1HLpL/9xBP2i4F77R3ad0t98ZPMhACAN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XSYZHF2jX8XlS5lAJGbZua8vsxWUcBdVRnRRdH/+1g=;
 b=ItNYpvEGxLN4Vmran3m1k3c4qVljFljL4DsmodZuTSh35Or8UEUJbkd0sNC/1/QPc+dVSdmtddG8YJh/hDmD1waeC2gKcyLquKUGjQ6arAoEJzJ3rtF2LZ5NPZ0edjxo1+Mo5Q/cLpQnTahMqurIeY0o5/JoSPz9yEj13HVozE+lNG4Tmz0Tx8g5JrjQ/xhF7a/yJolwPOOo8TAUDaHCkqLtCe7hEZMiAbMFyyhiMWtIXuib6CaOC1TN+gBId5hQYiHl25jN7kFwuUBSyDlkot7EsXtlR5i0eRXKjaN0kxvNS4GDrBAFdlgK6QBtFmWYQYuWpDPngGSBw6y8OsvVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XSYZHF2jX8XlS5lAJGbZua8vsxWUcBdVRnRRdH/+1g=;
 b=VxB9/dJ+/kPKa0M0fVWbaJzS+lbkZx5DhQ2VknAKQWHTcfKnGMvH4gi8ErcBuOLft53eQDj90Wxo8E24Kd6ZbbmL9xjLi9VSWeXgwb+UriFNuTLZGoedAOhmqM1wOrMS9plo82Lk2JQgpqBKwY2A7MrSjDSH+sWkTH4rf1orWYnmBs/FInrfCWdsGJpGGsUZ7drc086DY1MJIuhPIA8moKXwmeUl2spyBPC6juxIfbCGfP3MkgeL0dOdOe9ZUbJiEr5HI3aQv41PAElK/1ys7QLpyat1Y+VbbQvB6dFvxspQRogmo1jfDnyCDxNZgqGiBjrItQV/s3y1/1A2vTsqhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 19:57:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 19:57:42 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 0/3] selftests/vDSO: fix clang build errors, and Makefile cleanup
Date: Fri,  5 Jul 2024 09:57:33 -1000
Message-Id: <20240705195736.34039-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: e97a3552-9d29-40ac-8fce-08dc9d2cbb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nxFExc83jMQnWadkrZfP0dtXjd9a97E+zHUdrM3Nv9k4twOW/Gv5f5sjN3zr?=
 =?us-ascii?Q?KF7+W5DwAC1EP00FWIvsBZNkzhMhAZFyWq6C/Mn/qm3kLDZzcwGnidmayS3H?=
 =?us-ascii?Q?9DoIjfEVySol+tre9Hf3TUhnhzo1YBB8/pCRAF/0M3rLMGv3OEOnhwielIrQ?=
 =?us-ascii?Q?Ti5RA1D0HArwc1t2FC9TC0IazLybb68ZNxrrSROjb/kvyGfB1GawRCnHLOA7?=
 =?us-ascii?Q?h1W+5QCcI+ZovyMOZ9SdrUTrVgb4oRt3bSVOXeU5qPvhWGplDONMOXiO1kT1?=
 =?us-ascii?Q?dmdgLJWoRcdAaMXGEuLDATFuPblcTOW4bPEasYhObH1gdGmU2ed94kaimTUR?=
 =?us-ascii?Q?mbXZiFkPNVXPetzXAi2Oi5U0Q5cWIfdBMlSugA+lviBFzuSWUTttE89sGk1b?=
 =?us-ascii?Q?qmWnneK0B6IWDSbg9ZlVtIw5ZvW4vbjMhcwjjMm3ISXPUtEsbb2Bn4xQU8j1?=
 =?us-ascii?Q?gZqgZpa5KHFRfDYuMunMsZXubMgzBri3mDhkKqe4ce18VjeHlP8d7uX2qKJA?=
 =?us-ascii?Q?i0vMSlM2th6sCW+oD0lv0qUhymebfVxaDsuh2zYlzimCaxx+hSvqk7+fu60U?=
 =?us-ascii?Q?uunfIn8rJ5HbLRkNyEPnU03iYuBlTQlKhaG4/GomSPlaRozb9u+cQKVBeSy0?=
 =?us-ascii?Q?xDvDxjxVaJl3CTurQbOyyTYk95kyaBSoywkvFNc1X5kPjpRVOiMuw7OTRL/7?=
 =?us-ascii?Q?TKyrLPDpr36esrer7VzNuqmz2xdXyV9uV9jGNajtG8Giqh+PkYl7HW3RwJQe?=
 =?us-ascii?Q?11/SYwoBaBpwezjVLTB64+wwDH2EyF1D22z///ia6YFci52mjdviMmsteQvi?=
 =?us-ascii?Q?8J+V2+ab3Aycp9mLHktHZutsc8wdD8nD/3ikRumsBkrxhiOV7ixulKvVYJwM?=
 =?us-ascii?Q?bsVqLjipFxtZ/YExUQBMLMto7yi3fL8LgETkeVrWliUtL+EAhXW4rSjQzvHM?=
 =?us-ascii?Q?tMjV4tzkMTbUobSelcqpWg/9Hp2memJoktFLYmOELwNuFSXGgpmiauaGnV8L?=
 =?us-ascii?Q?8yCWLUtGiPFCECA007w/1tVNFb4kzBa7c6TBv6iFPBBRESt9ccWsEwrkJYIr?=
 =?us-ascii?Q?+Kcs6AsYt5FkC/LDXMPkTTI5mGvFKUluMHNHz05u6iCzOcgDJiuw9uuVBGTH?=
 =?us-ascii?Q?/7J5jg8RhMS46xj03ms7M7flTo0MOj1oUj+frMZknxn42rfdwGtkZjvpOf1i?=
 =?us-ascii?Q?amGfY9yMd1fh+kBbXLEWQT9zGMmRnwWUYd1bEY9QoDgQ0po5T30QNBeQt+vL?=
 =?us-ascii?Q?IGP8fA/H+DtkR3NeBJ3CImekCpaA3D2u8/F3pPGEzrrWYbzBQMUekj3pkDMo?=
 =?us-ascii?Q?LOAfZ+41lGTbLtIjchmy+eQFHPZ5wHNh4wzr5jB/aak2SQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBFlzTdKjs2yWLwDL09OzUaB+U/CrKISNuPAp+nYDVVbg6Ccc/OsgVOGyaPT?=
 =?us-ascii?Q?m8SMpBR9VSUvecW5i1SDk2u5A1IR2EQvvREUaQ0p/o3+4rwfb9hrM8DJZPv/?=
 =?us-ascii?Q?G3GdUOKy9V+I+TCA2jE9uOJlWmB7LF3WzNvxcWlc+b8J5r2erjCeOw0LcEUs?=
 =?us-ascii?Q?6iVq7OYybLEhFfVV+yqtiBRGYh/XLY2QT8UFKyy2pYPhXQ/FlIMNSn6EtMaR?=
 =?us-ascii?Q?UXDKTecEI8WRGoF/RkmeXuQ4jmX+AXnU3MLF71McF96O89hTBh3XQiQYf49T?=
 =?us-ascii?Q?M+rD4bu7KoZObZCMkgKQRdvsDY6cox2d3i/LUNQFOXCFSoYlHdB8r8HW8Wa3?=
 =?us-ascii?Q?pNxY4+aZiZ3n9iHR8qPwLt/f5tPaw6YYd8ZS/fLmocLBG8BAoaC437sAYcTQ?=
 =?us-ascii?Q?5hWGjckTAWookKAdusxeJXU7H+HmsSiScstemDEoo2jJLpWA60DA8sCdfWQe?=
 =?us-ascii?Q?kBvc9v7xl76JrvsevrRe+kT2gNlep2zUlsYUfDQaAMUV+1G+f2s/XujbqrnB?=
 =?us-ascii?Q?F91+f6WRDwC1mkDL1YlrOWWL3WAFsfmeBIHGVVtPCk8xmRgsMMMr5l29VloL?=
 =?us-ascii?Q?9PVME4wWFDFGQOhJCqJDFfK+cALPmGpVOTyY2aQO2bGd03D/om7adWVFzVZm?=
 =?us-ascii?Q?YUsJbHWu0MT2GVoTAq/z5zJvLYed4UTaMBIBy4QnyTzr2Bxrjx6MJwixHR1y?=
 =?us-ascii?Q?xHE3gt/41isPRDLqtMR5NcwvmptcMdBalgVPN+MCccjAsv9Bsvz6itnHE69X?=
 =?us-ascii?Q?DF3Cpr+4T86Fd9sc2HTQB5dRBb3oBUiHwZjUGac1dFLQ+kDZa/sIAn74cRee?=
 =?us-ascii?Q?ttd9062E4fgqwBV2VlbpKeWDVp/SiGm5GIhaDkNePwpSQ8cjn3TxJ7Lvaann?=
 =?us-ascii?Q?B3Ds5q2N8RzjjZ/1125SFauhqsFn6m9c/jFIolk59Vn3DKyC4M/HnPBTpPiD?=
 =?us-ascii?Q?FCjpeMVWeDr/YtnKKdc9nw4FlE44zXWSVC1H3RwBNY7tjgkfTygz6awC74rh?=
 =?us-ascii?Q?MIpmumS8w3ciORNeXlSG844LovHosr3cS6AZzKBdBV5zuMkZjX2V4RjJzjJg?=
 =?us-ascii?Q?GQ/BF9QC5HiDbGU92Fo8+G2D7GzcsNHOwklB0lw/L2Vdzs7iqAhtcxbNvNQ8?=
 =?us-ascii?Q?G7o2DCAcOMiO1vPdToDZ/nJYBpToBtdt8pbeuwWl1XA88c4nn/sUX50lRtU2?=
 =?us-ascii?Q?88USV5ua+sP3CU/8lSSRsLquRL1JioXfxhWVcQntVb9EccTlkMLhe6FVI74+?=
 =?us-ascii?Q?i2A1kLkcJeTAlyxvzYLZ6y517apoM8w4S96VF8EqrqaDU9Istcz2Aq7S/Edl?=
 =?us-ascii?Q?i7gfj0g2j3VU4wteNkQuzETHWzJtXvNUpLamD1xwNbA00hvYbM23CIGHZ/bs?=
 =?us-ascii?Q?hJdR757AJ5brOLR0xrFj3lKT7Lt2Z4V9rFEi2W8CPlaLVNIEkMug+/R/yexV?=
 =?us-ascii?Q?oByydd5E9iAZ/yZQvvLVMdwY66BMo9muHOk5OdzyRFqAoptm3kcA1IGuaL3t?=
 =?us-ascii?Q?9UfdPxmMatirxOgo/wVN4a8QTB9tqgAhATotu/MShxtNI82qCB9RSZm54u70?=
 =?us-ascii?Q?CM8ByMGxl9Fleafxf+XtMrfYJipC1TjujbnHgHKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97a3552-9d29-40ac-8fce-08dc9d2cbb5a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:57:42.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbbILeTu9dk95c53vE8oBwtEt4jbEQZbT78l62gdBWX8iqzFAWmxCMe/q3vD16yIADqWyf4/rIjzu4kfORnT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

Hi Shuah,

These are for 6.10, as we just discussed.

Changes since v4:

1) Subject line on patch #2/3: s/mm/vDSO/

2) Added Muhammad's review tag.

Changes since v3:

1. Rebased onto Linux 6.10-rc6+.

Cover letter for v3:

Jason A. Donenfeld, I've added you because I ended up looking through
your latest "implement getrandom() in vDSO" series [1], which also
touches this Makefile, so just a heads up about upcoming (minor) merge
conflicts.

Changes since v2:

1. Added two patches, both of which apply solely to the Makefile.
These provide a smaller, cleaner, and more accurate Makefile.

2. Added Reviewed-by and Tested-by tags for the original patch, which
fixes all of the clang errors and warnings for this selftest.

3. Removed an obsolete blurb from the commit description of the original
patch, now that Valentin Obst LLVM build fix has been merged.

thanks,
John Hubbard
NVIDIA

John Hubbard (3):
  selftests/vDSO: fix clang build errors and warnings
  selftests/vDSO: remove partially duplicated "all:" target in Makefile
  selftests/vDSO: remove duplicate compiler invocations from Makefile

 tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
 tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
 .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
 3 files changed, 39 insertions(+), 24 deletions(-)


base-commit: d270dd21bee023ab627f34cfb77a9b89a688492a
-- 
2.40.1


