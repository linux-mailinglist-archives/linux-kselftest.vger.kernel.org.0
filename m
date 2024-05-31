Return-Path: <linux-kselftest+bounces-11059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C78D6A7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3721283F4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302417F500;
	Fri, 31 May 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hn4hLScS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CC17E476;
	Fri, 31 May 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186089; cv=fail; b=kK46iGMhmu+hcVo1/8WYBj/xvtki+VS/sJMl0aPeXg9bRCbh79ONPV9bM0pYnvjFKDXhZCpG8IfRNzYKoJTz0oLGpArkqWyf+kYGF5p7A1JNHQAw+CIHbIblIrRmtI+AIiNCyqRA0rtAYgc6ORnc3y5Gjm+i6snARIZ9Hkspn/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186089; c=relaxed/simple;
	bh=fnKwsaeT0ejOGAAnIPnBudk52Tx6bc1pC9YRS8hMyPI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EtQyLmhVB5QNWW0oK3DaiOlE28Nqi5FKGGlWqXoc9i5rFGAtmt2EDdKRgKsF+//1DLesga7AorNSBlT7yAiYJhPGWUAyVfSZWGqebfkXvV0lMtpTYzw+YMKxfhO7U7QcPy/CA5bRngh2AMjI12bTsUuE6hbssnM81xCAFfWM8KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hn4hLScS; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyZBvzMj46E+BO4891lP23p2Z+tkaXTphj+1WUPIYjY9ICr4aVEHu6rj6fY2LgoL6VxbfW1SI3F4RilojGThXyTlQbpep28FecYlyHzuOURhc1p8pZNaTZXvud6RytcwieshO1nMp5BKosCgg/h+BM9A8RKGUO5nJDM9rc1NGTkscTMOpcLELr4Q5Mejrm3Hac+Dzix9srOsEoATw/S5ZPiFLTtDHfQ8TasA4B2RzJ4Q83Eg0H1cOL2XOccB4xnL4cSN0UZKOGDTbEuNbY15ZXhNmZnMQTO2qkSWNtXiMI6xNbhAHUxGl2E5ZTgUL2tSS5DxIjY31jnqGhOLblju2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY4XQZcgdc7SQccFCfmOuaKTM5mqN+QvdRbAJSXB9IM=;
 b=dQMRMHFUJNHpNga3YfWsOhTRL2HhsjLqhxNbhfzpuRMyNeZ0pkx9ZVopx/92BDPXF1k/8cW9arXgG2R+gsGMLFu+9pnbc3I8Xpdlc6Y+T1Niawqv8t0VuYlXiFJBHvpC6M5dY1fQJuJG3XiS4UMjIbcTm/UleVR9dGsbReuH8N8HWM0cxnHx+8ao71VuAHdURbeUYlu2tnL+J/+zOKSyT8gHu+db9jiYBsbjEBuTW1KKKE/WQ2rCUURhU/rkU9AkQ79rS7KlnPEMPzTc8rabip9dYXUzxa1ObAJh1UpyAcL3SXquxVAlKOJEJ36S1vbLSshba/Dct0APbcgDbzW3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY4XQZcgdc7SQccFCfmOuaKTM5mqN+QvdRbAJSXB9IM=;
 b=Hn4hLScSSbPBCCzIHLW1MsgT+KZQS7meqNRvWIoYI92AE5mvC8+VPDWlvMEoFzFF2Og3zkUQflWEfFVipSAzSAi2emSsJQVP0VoyqDEtV88+wtho9AxCL71KmKHElv2OQkju1bvg4w8s+fpmu23iVrIbbdSKcbFgUY1slMHoKiHfB6mxAnLJKfzpjeVDzGI3i4jwdGhFimXKBJYEkcAKPD4SWUvbJvC9fFFTCQXMG1gist0uMQB8jMyPY2vgMY+RVIc5jpAJa26ptl7hJ/AEwm0s9i52duHFNdpNOKSTTT67wV5b5CGWYRpw6THRAPAet6z9BDXafIIzqBFqHLs30w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 31 May
 2024 20:07:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 20:07:57 +0000
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
Subject: [PATCH v3 0/3] selftests/futex: clang-inspired fixes
Date: Fri, 31 May 2024 13:07:52 -0700
Message-ID: <20240531200755.128749-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b51932-d517-4ec2-4720-08dc81ad5d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IA27PB8Nq7x3J/IspEkq/aDmZY+eehLlhqoTG9mJpifKyG5jL++S4QfWdwN7?=
 =?us-ascii?Q?N92eAUDPR9P2ds0YVRWCSgMI0yd7y9syq1nnNJIjXqYTswbycZ/feJtqPlkB?=
 =?us-ascii?Q?JEuK7cxsOT+12l/COBYZPFChwS8bLIRJ22svFRkPgSmGM2n+CT18XduLdOLw?=
 =?us-ascii?Q?Ccc0aWJwAswG+8tsocqJJpXi+cK3h4L6aTWubxAlNwIcQWjz/qVVAstHgPwY?=
 =?us-ascii?Q?JJ1m2iI1g6Jh+WlsoMtb8rRPAP1Xg9iHeWlhQebLDPwevVV+76d2USSLdnUw?=
 =?us-ascii?Q?mfHyN2/CiFyls0sKuKZzNbLvN+kCapilDb1m3kbZTX/rDlFfU1KGUefjjP9r?=
 =?us-ascii?Q?AW1duXfrJKgSESSFRI97BKKPunhvd3ifJ5dh/A/w7eWHnxbVzyO37lvfJvTG?=
 =?us-ascii?Q?Gmi30JvvSukv28kmsm7RMu1EOZKBIBz60yVgAigfEBrpZmWkslXWu0r+9n1h?=
 =?us-ascii?Q?FCfzlR7ArZuLx57xwyslFoj57lnTnB0gxOW8/hUvUxKUkWl+SFJ1LfUM0kdp?=
 =?us-ascii?Q?kM3CyuTipnihlhWmRua1e1vmafW078f4bowXbXR7IlNZHTCWctWRIsJ+qo+o?=
 =?us-ascii?Q?c/3a351tszNXAXWW4+uNpizxTXpq5gLxvOA7v22BBCCsf1S1RbAB2BCUYDEu?=
 =?us-ascii?Q?Lsw+LaZbBTSMH6uZTOY9U+1ZJ56XyBIXyjWAAnIgWwMUB9P1znv8TL9aYoJ8?=
 =?us-ascii?Q?xaHzLTQwSNPg7bgm1JvKMCc/UXpRxWlapx6tszkddAbuKyxlWX+59rN1YEnR?=
 =?us-ascii?Q?ubu8RyFPSAU2YF72WzYH70s6fL08lY76aIG0sHYf70h+oQn/09WyxG3WTGat?=
 =?us-ascii?Q?bE+i3WqO1vJhrS1fwTAiYl6prSRuNfKZCQbm7mjQZdonJzHFpXosu1HtVsnk?=
 =?us-ascii?Q?2COw81bo1t+ZxjTozDauK5lMYUTcB23euw9l0FLoIQWTrNEUJY+078BwTnqg?=
 =?us-ascii?Q?+sGCMYCwIuyzoBCaCRfjfv2gocHrfCoVZogoga2ndpP+NWFIraHZMauxsxgt?=
 =?us-ascii?Q?MhGoUwzwPv3wDr1AB9IlqYS8+n/XIcsTGvu+5P0rNeQmLhxxo9XrMq1p9M2K?=
 =?us-ascii?Q?BNq5Y0N5pykNCShQpd1iQH+bhxyT/OECPW8JSACNCMuDGGrAX67VGneAnHub?=
 =?us-ascii?Q?RwK1X7/DBnzzPN8i+gW/MUCLnLdlCwCitUHHqShVrPdcMw/c/p1NQFD5QFu7?=
 =?us-ascii?Q?UG+1qvaBv55NRYM/q/hapcU3K6eWlPwsRLIzQJuXyjNTsMTJqhCUFUEBltwr?=
 =?us-ascii?Q?785Np4a4d2JpS8ABH/gQv5IZ8NHpCejTlXbFbQ6Kaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jSOE7cPlCUEIcxE8EVhaar5FBZxaynIIO9ebOGkVLj82byn2GEt5ZT79Xkj5?=
 =?us-ascii?Q?TbLInq/zw8yiZJIUVx7zFvH/gAOhEG0Qg6EbBGVTF3ZjV/r7nv/usaFicbp0?=
 =?us-ascii?Q?rU+QsG2q5qdLqETdHyuO2YmqjZlynlLK0M+s4hHtrK4ijtVJTYE30kfu+3vO?=
 =?us-ascii?Q?NU79cWytl+di/1idzMxDfi/skzYM1yKtZQNAi2zMEa1ZTqDx6w3xyHcewzM+?=
 =?us-ascii?Q?uFE1wdBkEZ/k3bzVE4ONA1exoDe8zEdmc4q5+qHPjoV0TDyeHK35qYql6RSu?=
 =?us-ascii?Q?io3lk6zk1Oon2/4HPZW+v3c5cbEPZ/Veu8yxJ9j8rrCE/YNzfZdatyNhS9Bi?=
 =?us-ascii?Q?zXFy039gqIEqFITlgvhNFM6vK5U/DSEvNT2Ai3azCAqYRJzQ6911RYwK6iD9?=
 =?us-ascii?Q?sKRQXt5mzjAxUqVfBOwjFaa6omQVxF+73Y0kl1dkErAPlIy+8uETruGt1cEO?=
 =?us-ascii?Q?f/+wQX8Q4m/CZ+41T1cbzJQw1YBaAVVEquTLPfSocq2h/D+vmtVgsQMhHKkc?=
 =?us-ascii?Q?Q4vLmuoIZ73MU/QkDcjnWTS7v5AlINZN7N76w1LCItdcQZ/NuMsZYLIvc7GL?=
 =?us-ascii?Q?pHRCexxjRlDttHOiKHTCJfXQjq8QkKvOqUJVEn1B+1cPBaHxU76H70D5zQNc?=
 =?us-ascii?Q?m3DtT8k2wV6HEsjxuwMXVMbPOrJN9SKNLx8aMfRZK5lKmO+1xJ9GTmskcW3r?=
 =?us-ascii?Q?YQiZy8PTlTXfyAWTV5fQH4YYIlg9SGmEVtkxlGSULooNs0OGhfXxNJY+atOb?=
 =?us-ascii?Q?X6irXqKG2N81y/3Yyd9pR7WcG0NXEFSVBrtzcK5dM1OX9yM1FHDreF5gRHfc?=
 =?us-ascii?Q?PGHuWTrrc5AwIWtePISYNddFhBHa+pfm6uV4DNWjpM7B3vbJ0xcpXDfWbQKB?=
 =?us-ascii?Q?YOsnSpywEd6u7CKI6lWN9ztFn2uhUYjjvOFV+8++phSWzw86KyZPfotd4Ev3?=
 =?us-ascii?Q?pjK0t3WZGDaFjka9p3o8GlzzgzTqlbNlieLixRz8RT5l3KTskYF8FotRg3q7?=
 =?us-ascii?Q?AbB/KLAoSxun6sCRw6D9V0lD4F67iGfbB+TltTdmWCPJVmBw8TX32sXW26pl?=
 =?us-ascii?Q?IXScPsBKYRuVbKY8thefTaSX3qA87Rcl6mEqkDosqc0T6RYQfY6RH7FWHUzw?=
 =?us-ascii?Q?t/HZbX3cDxnCK8pBXaFbDwkT/z6au+EmYdtn6iQAthBd+K7soT/+GCB1k9Lu?=
 =?us-ascii?Q?h3CQSjrEBYU2ZzF8gl2WbhjOUSzdrfiYHpOcLyAgJMBtp4eObZC2dCikI7D/?=
 =?us-ascii?Q?nfB2dME7br6mXk7D56t6rKcE7SiIf6mSSizyABxVdpe8UBnMAYWFbnlexOwZ?=
 =?us-ascii?Q?vlI1+/urOfMM9Oamnc13BlazgN6dtF9fB1UAFuZrWQf8VBmqmXD+//N+IeAj?=
 =?us-ascii?Q?EdSbFqd+S5iVAcGuNikmyIZW1p+QtOWYBj8r0xGoxOdXVfAs4jAItra2u5Nb?=
 =?us-ascii?Q?HpbcCZ2duqImsSOCdNwKVwEPyo5z3lkW3z3tbbzz0/sLRRSLW3njdczGK4aa?=
 =?us-ascii?Q?jOiDpY1pIMVpZYL0xcHdfj4mHHPuIojO8yVXkklEIml92T5jPYLX50Elj0rY?=
 =?us-ascii?Q?05JPacDWul776Bk5IRW9/PKHawUpNFveuPp0iL10?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b51932-d517-4ec2-4720-08dc81ad5d0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:07:57.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzIMnTg9r4HKFWXu3eDXTq7voxBpf+iCtTvX/MIFpLLMnDDc2nSNnP7x/GBYtMBs0sXa++gOm9ZVZaQd8yVEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985

Hi,

Here's a few fixes that are part of my effort to get all selftests
building cleanly under clang. Plus one that I noticed by inspection.

Changes since v2:

1) Added a sentence to the .PHONY patch, to show that it is removing
   duplicate code.

2) Added the actual clang warning output to the commit description.

Changes since the first version:

1) Rebased onto Linux 6.10-rc1
2) Added Reviewed-by's.

...and it turns out that all three patches are still required, on -rc1,
in order to get a clean clang build.

Enjoy!

thanks,
John Hubbard

John Hubbard (3):
  selftests/futex: don't redefine .PHONY targets (all, clean)
  selftests/futex: don't pass a const char* to asprintf(3)
  selftests/futex: pass _GNU_SOURCE without a value to the compiler

 tools/testing/selftests/futex/Makefile                      | 2 --
 tools/testing/selftests/futex/functional/Makefile           | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)


base-commit: b050496579632f86ee1ef7e7501906db579f3457
-- 
2.45.1


