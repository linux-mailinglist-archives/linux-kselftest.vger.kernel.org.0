Return-Path: <linux-kselftest+bounces-13151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1C926D7A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF7E1F23636
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F5168DE;
	Thu,  4 Jul 2024 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQJPO66o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973A107A0;
	Thu,  4 Jul 2024 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060415; cv=fail; b=LnxkaTlj+de2EBe0Etc/LQnIwkBFLz7nf36KE74i3F3Y6b6nwY3dEM9GlUmrbG71Vax7st0l8NDi0iYMXuyUHyNnnTAV/ASDk9/kXrfLUcoGXBjIWGMYc4TueaVE8pIoKOUpUoN1IeSLzzb848tJkT1fuxHq3f/rXRriNLAMntg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060415; c=relaxed/simple;
	bh=2gDqUuSFGi+DSTHAyraYg6F4ARq6z2cbnZ1TDNNEllY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qLu4i581jQhm0n4jjX3LRT8lezy/jcP9JeAzS1OAuJTTvHaumfXruGMSU/+81FIZXkwoR9jY6RMnckW/fBTYg5BiUrN0dcMz1PeZBbXeOceuvqCxawbN6SD78r2bXQ0cOgv1BtbuF9yRBoNdocf1+bZVZ34BN6iJDDF4szzZFcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQJPO66o; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqiF+k1IwBIQ0ZXcYz9qzXFZiJqJWFCiSz1eewmGdU+JHnyYW/6aZgo30gXcq8pIE2wvJLevEF4lXxtNzmdjRC6KJiekwskhR2dCcClYb8RpcU1mAUyiurPQnM8KXK92fZFhGGa+IVgenoSjhFH01h1clyW9o1R1gOjyewLZPa0zXN7pVRHNO31paDkPPY7Z/MJDtdm5f1WwaLfAcZ9YuHf5y5dZIg2UTSLVqRuniaclJaKU3p8r37lXuUVAvzNt/MiGa1YmbPt90keCh0RgBO1OtF5/ngZJMcUWt05GxV0mTMiUmAKH2aWy0GVg3YYnJ7CHqA9hTBrklQWrYYFXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIYjvfy9FXv/BvF61FO8Vh9KGl2CIXN+CED6z6N5xCg=;
 b=EXs6YwIswGASYO2ntghRTs9JAEPhUKb+LDs6ofzEQAS8mnBF+D81bKCnF6SL/Khke99SSJ4oxA0utTzi39kVH4IvCCVWIcARcRgBqgHC1pzluD5ZFBxCI+9SGuOZMOiiExXUdmFnvNT7ijct328hKtMj80J8HRgSD2KDw7oMud9H92dwpr4EoZjo33kvtrdKBK9WpvmNPrZD8SGKGf2+zGM96fYNhlFcQUp7P9t/Scdrmwyf+RIQO62f8u4Yiw9CmxuBB5CFPSRvmIZu2OlvZeDquaVEzfiJZ/wO2AbiW0jNzHGQ86e71zXoOV8/GfOW4IeZLtKBgu4/3OGheOucgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIYjvfy9FXv/BvF61FO8Vh9KGl2CIXN+CED6z6N5xCg=;
 b=AQJPO66ovpLi7hQmjU80esZWvPVfVnMBzskkWWGDaYSxXGOXQNcJ95HtLY8blyMvq4pyHfF+1mP21hS5GE8sqqwkDebrnIWCuFM2XOd8c+yWUOuA/ua5WoLpp/cOH9W+kVTDNjoQACjjziBkORf3s0/wUnPRb7gJ9U0/+IG7FEwm1BqFfLlhI+rENqkKF36Fouu+fHMMVhCywzq39aTCr+QnRVXx7Kh7vc34K3L2wPY6nLycmat24En7KqX8X+zy5QEd3y8ULbFa5kCQT/gDNOTFYYnxu3MrEaP3yeMLSaku4PMFycALhMVArLrYMo+6DjdgcFgN5UlV+QdITfjo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 02:33:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:33:25 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/3] selftests/vDSO: fix clang build errors, and Makefile cleanup
Date: Wed,  3 Jul 2024 19:33:21 -0700
Message-ID: <20240704023324.83564-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccc3539-e4ad-4110-1d6a-08dc9bd1ae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VkPhHVPbmpS+yfk6IO0qKLkpb93laLY8hA9y4fh+xFK4VqU82nn/mb1stlGf?=
 =?us-ascii?Q?n3ExMEMGaDWiEc17vRTTTthQ+fkiJ7I6o1LYg4U//8CEXpWQb8OPxGGcf61b?=
 =?us-ascii?Q?vXk5okZhe/Dlac9E9H54vp1cbunfItyqn5DqRTjQ4w5OwVvrad/TQ/47Y/nt?=
 =?us-ascii?Q?7f7f6Piyx6RGuLBN79Snjy3qhfCR9gKB1/6xVcmbpfHMF3j1aTSz0KM8ljcE?=
 =?us-ascii?Q?2ZnjwxxpzUE1wYTwYYQmNtTDmjgD+v4dXTSRcnZkVrJawTsSSHfSpk5/YDWb?=
 =?us-ascii?Q?L9pADqaaE8KJAsdmrTVL1iUq3+h37Tqwj6LshXE9bH1bhePk9jJZqBfAhpHT?=
 =?us-ascii?Q?TTSVyI8CA1vbZHdmhxrTkp2yYSZrdCHWvfIi8uUeHGLaGEq0uylXuFLllf2Y?=
 =?us-ascii?Q?xr82kxP8Mx6xvtvnq7Kp9spA1CipBf7GETW0bzMW/6XOZCuLkT3oFREaMDXJ?=
 =?us-ascii?Q?vwsmg8iRbXqIBO2pB6XPKphv9gvfrbm1sD+DY6z7lR4Pds0sUSmH/81eeKbA?=
 =?us-ascii?Q?9k0snyBZvTNnGk6Bamao7dVAh40Lb8itO5FODuRJtCx3BAM2ytFaSuEZbCTG?=
 =?us-ascii?Q?6dyPtDN+MbS84CpGylFyUGzRNHqprzXcBCbB6CmylLvxSmBIPtkYDtstuwuP?=
 =?us-ascii?Q?Dy6Fr/ZR3nOEvTz6KT52+tjfXIoxY+x5KE7+EDBW8bJnecbQenKoENjfeqQS?=
 =?us-ascii?Q?NQrxqygkOkgqP3f//fHQ/hLfOMAe+zDQeYzgCHmTVPMCmaqAjX3qXeS7s7gq?=
 =?us-ascii?Q?4i/UDqnv4sxPwRuSzGkZ1d+n23kP63q8MADa5wcQLsfKXSDCoPc5Vyeg5F6E?=
 =?us-ascii?Q?Hjdf4siv2dFvduMFneINZrxDAtWCrAATYok0eA6jjE63JB8R4veNpbjEvxp/?=
 =?us-ascii?Q?AwV3sqEmYw+F+oPOK3C7NZCxcWLLrbTuT/GjHcIp94xSc8XpAHgDcEbPtaVU?=
 =?us-ascii?Q?kKWCWmIW4rt34WTwD00+qQ9VpZbETgKdZv626ptxxi1TyOzm/8CT+giL46cM?=
 =?us-ascii?Q?2LBl0kACay85dO9/MJI1x2EpYb+MWZfm1ZKZI4dNRxeg6vSq8C63A3ihy/yv?=
 =?us-ascii?Q?3b7svp5Qw2atV7EhPMU554JuCTQ3lr2W3wl47OqoQPcge5Ba0sh9KqAlFjjk?=
 =?us-ascii?Q?ZTRPhuFVoOPdcJEoozzldNV4ivsK1ky/6t0kBH8MKLoIejeHsSq2A+sAk4oM?=
 =?us-ascii?Q?A1MgDVdXGlErIJFswJJurLwwXJwXCg5F9VfWv0JrbUhFQ/OHZ1435wcYoEhu?=
 =?us-ascii?Q?Z9QgWUcMMt4XIT0yYG8y1nYah5dH2W/PxenlW8QWM37XEyi2tPEsHvKfg3U6?=
 =?us-ascii?Q?Ge5R6p0V9owYTWufaGCWbbjgzpaFRG75UFF9KoJb3Y2Jvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+g3VPCpEwhDFuqnEWtE68JRgM2ZPVB+HEFvknhKxicP03mw5mKvI53Ni0eF?=
 =?us-ascii?Q?kKCIeP4kus6UFajCSaIxNWUGi1es2EhlI5flpHC6/MQQVG+yOXa4reWjVDCs?=
 =?us-ascii?Q?P4YzzmMDBBx65BmTAE6hKlWHlLcm8/mFjiHTY3ccSkfpWSQ9ts2CrE9+r3zH?=
 =?us-ascii?Q?OxqDhRHMPAIK5oZ0Mms/rXo0pr4JQqDr7ythWpmwtZCKysTByj44LYn8SlLG?=
 =?us-ascii?Q?lTZVSN/4xzaHpYp5s4NWYIJrYFMi0QCVmgGMEQhJvn5KMI74BV71vmJW0QM+?=
 =?us-ascii?Q?RTihjsTOi7aELR/yvyydSH6T+Y1Ryec89Ctk9Anb3Zlcbf9+NzHZegn4SzQO?=
 =?us-ascii?Q?FOMSjFknO3aWSl6KoAm3sL4AbOaIKu/qY48qFNUb1fYeNB87HmbMea+DR+Kl?=
 =?us-ascii?Q?0gBQMc5kCJyloq8q1TOaeLK3MT1MpM05yuIOYgfZvZ4d96SkiDEjhnfB+Fgx?=
 =?us-ascii?Q?wWStg5XRMARsER+rTZNoi8szgWqrv0PyYYtiwHiuJVAMqCg+U24TT3Og32U+?=
 =?us-ascii?Q?Nn4QApbv9W9huqxOLEkHg1idwqQ3dp8lC8zaDW4iSVI+WD06l+usj7GFFDr+?=
 =?us-ascii?Q?54FRUJJvbPLBX9p+X99KHe3SoMRQYHQCr8JBLGc1w4j8eUkoxFCFl7omw0YF?=
 =?us-ascii?Q?7JGe9w7BzWvkf7WXRPETini2v2iqZh4LX4AjZqJUr8cRMvNJNM/z0xyivUt2?=
 =?us-ascii?Q?82oxoPzGN1ZKXOOYXC6uhLb+g1en36r9wbQ/gGg5MaX5DuKSkFqvYcE5b1Lp?=
 =?us-ascii?Q?HGGJX25T/go9BpfB9ggI8QB43nBgLEPntotIgOMBmi6wJF8Qnf2nPyfCyNd/?=
 =?us-ascii?Q?gxdpsCzWdw04Bx409LUWsSDtYp0sKMtmlzCyndXSvkyDFQbFcZv53vnPU5KR?=
 =?us-ascii?Q?67lmwYQ4hZ2Y3g1oJgEYA8oNlEb0LnDKX9NpR5fI4iR6chRa8usKj37FMpos?=
 =?us-ascii?Q?p8aS4UdpMnUBU+hk0HXrK+WaPiNyGMCqN5aIkm+hACmX9PVDfiK+8e6CACRQ?=
 =?us-ascii?Q?CX2+KhtNEOQxYE413zGfDUvPb1AJsO76dZGy548+OqPaBkmOdDGV16HIwFxR?=
 =?us-ascii?Q?GjQhaGk9dEQwTv5mb8LNvYh+zkOx8PeiU/GxfV8e5V1YfOPo/FsHKyUWrVzl?=
 =?us-ascii?Q?AtDHDLGRDokJDG56pwBGDcfheBl0dCbMa2W1wo8jyG+7ZgfzwDD+DLGmAIsg?=
 =?us-ascii?Q?MiwAkMmNJd9KbE8ydE3fLZBob+PPNfKmOl02778V6NHontdDUkOI1Yt0tRvo?=
 =?us-ascii?Q?TGeeYWh1d7dqoG8DbGLYjaHs7YjezsrWBu1pzJMzBfTOi8FPlSZ5Udvs6zbG?=
 =?us-ascii?Q?xHtjbBEAdxLvbken7IJNpnghFRWIEtm9GEYgD4yrb5qhdBms9XgozLdLJoxw?=
 =?us-ascii?Q?59JlPxXk77bouykatc1SLcREwhEXGMhPqby1LVQxGm6Fd2u6+zcJc8ZnFoNZ?=
 =?us-ascii?Q?0YocTu4+gpMl4Lk8/XeNvtRaxb9p1r/lCdAkdpwzhNOQWX7+mmvkV/YMStsJ?=
 =?us-ascii?Q?ZLtoSZSc0IIm8m4ZEoEefYAsfJS1Ti0OYdvVgQqfxz8ixqNPwgFb5m+yrKDu?=
 =?us-ascii?Q?H4OBds9PAif6NpV+78uwil5W7Fg4iz7XZt1Kbhzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc3539-e4ad-4110-1d6a-08dc9bd1ae47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:33:25.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmoct2ZcvRu2O1nsA3dbhfdSubVSos2qV9LJvgXFCXzRkdxKJnzvIA8GTH1acdcuESs+d88+FPsJ6BixpZKcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

Hi,

This is basically a resend, with a rebase onto today's latest Linux
main, in order to show that the patches are still relevant and correct.

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

John Hubbard (3):
  selftests/vDSO: fix clang build errors and warnings
  selftests/mm: remove partially duplicated "all:" target in Makefile
  selftests/vDSO: remove duplicate compiler invocations from Makefile

 tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
 tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
 .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
 3 files changed, 39 insertions(+), 24 deletions(-)


base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52
-- 
2.45.2


