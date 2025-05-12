Return-Path: <linux-kselftest+bounces-32845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C5AB3556
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCDD8620AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD57E26980C;
	Mon, 12 May 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="A4/TC4dU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8D268FF1;
	Mon, 12 May 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047203; cv=fail; b=k0sVjGbr5BMBLegHc5ReHS/KFDGxiRGgfI5msZdIkASPP87iDkn8hyDPFairBcRc7p7Ejtnrua1eXHfRbOrnnqESYuJiNszt7pPPOJRwaQqj2K49noiTxRqMHVMVnvMzwdPzQflI4+EC7s0fhz0BKM8zgKgngPJnh08U1TXAqzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047203; c=relaxed/simple;
	bh=44/beeK+cAMEd0TdL3j3RbuMftwoy5PchCGZAJO9dm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tf4pO0L7SSJLMaLtKqwr7/SgHDqUzlQMhETADxr/C1A09Q8xZ1eLBng9lw0rHoYtbldJesC5np/6wFz/rSGkQmzkSu9XF+eI/IpVAU9bmvzhiynAhdP+2gOjyjEgpABQh0HhwDxaAfwzAE2Ru6xTMW3wpK4wXWuLOmZ9Y3HCYl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=A4/TC4dU; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2g1OuF9jFyEK4wGfE+mb4S2WwdsqcHOHwkZp2FjihksAqNNJQ7p1w30qf+fZqf+L9DqiNdcWPXSYYnnys9aUqXU6JcMYJ69dS4kIFnKfGMD3q7e+INCgq5zsh6r3cZI9dwg0IZtDAAHjWUczKzUE6X8fJcATr0Ikm+9AgFF8zTebSmov6WJD5TI82Jo5r4RyX1ChbkGcA4PwSVRTI1XQN7i/A2oowhDR6K7b5AxoAuXADofD9nzFD5PE/Pz9J7LZXnQHXNPKzn5Kc8jpuDS5y3YRS3p/YLYFFmt1geXefLvmjc/6pYxuKZlycvT+b3nP/lAQHibhgycfo86cEzw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cA+TyiNhqZOY1xxKE1PB6wcfsc0wR6rTmxNZEOwG04=;
 b=OV48M0s1N9/gSVHJ/EX8tgN4l0CjmJkDKY18/ZrD2RXZMmpDztay+ijrJuhcJK9dxofAk5tz2QUUVXGOD40IeaGo6vlqxsEmFXaYMM70nKVuoM6My1GjsAlJXCuKkh+MzxwS9UumIS9panI0iFT0Ey2+IlXcZntqCvBnGa/Zth9Bh3QQkLRRvzcYekO+FiaPXJrvlQYft26gOi8yNJRlGlIZBxiXah9MZ8aLtOpX8mRcsPjSPJoLtYSHl9CXrGqdy0vzV0sUWFEuxb+Uld2bq1SdGAL29FVHNYl/BmpNv/yaDlk9YhIyhNQmKYNtdBzJWKiFAmtVr1UnKFBs12WYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cA+TyiNhqZOY1xxKE1PB6wcfsc0wR6rTmxNZEOwG04=;
 b=A4/TC4dUZZWiH3r2a0v+jw70w7m9+AT9QmVlrQfnF3GH0Bl1IgIgYQlNN4AGa0vkFEN/EcdsViFbtUMe9Spuj9zJNLhe+sAvyK2dBeKdf875TEcXD+ivetTGAA28Rmqngl5KewuglWigFKyE6HXKU+58mqCCizz/dmqsctB51k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:14 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:14 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	seanjc@google.com,
	darren@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH v2 1/9] KVM: arm64: nv: selftests: Add support to run guest code in vEL2.
Date: Mon, 12 May 2025 03:52:43 -0700
Message-ID: <20250512105251.577874-2-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:930:6::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b770f6a-ff6f-4814-16b7-08dd914331c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfKAySUHSCzX/M7u/H0KpeNty9lO0ssbhIdWwPfa9OtSYJg/BOXmKIe3KZIc?=
 =?us-ascii?Q?AhHCyjcUSC+0CYLDqRWZBiSGcDM4nrr3RitJLncs36tAvezUUMIlQu5Web26?=
 =?us-ascii?Q?QdF3ddoTyGtUeqolwmaB+tXQoJfY9UP7vlgVaax3T01ylD8c8CuoKvchGrCv?=
 =?us-ascii?Q?zMQJ6L9mI7N0EbYADsTjCVpYwEvxk8YqoU7xNq1bU1+BryUFw9yCwDdUeLXR?=
 =?us-ascii?Q?mqB2VbqZw6Dh4PoNIcGqF24PD1U44nrNbKwPVzUIFXw2RN+oVTgJzui46ctk?=
 =?us-ascii?Q?Sv30motC6ukismakYEDbwEeBfAUB0LD4lp4JZUsWco2cUS4kdJKI9/WytCgZ?=
 =?us-ascii?Q?4Kco7uBz3yc6zZLdj4AB24eM7DQxZTVGabwBNKMMK86VRHcI3EzcX7elmkzx?=
 =?us-ascii?Q?7YrxaMXes7C38XFP8kG+9fiGaonDv8fzXTnvIXD0HwwrPJxTBTTffjt/pESK?=
 =?us-ascii?Q?yATU5nOYrkqzc5AjgeCrfl+f1HVYplJhFKKXAa1WzpVltyfghwtyl8tZBFcb?=
 =?us-ascii?Q?+ohVxu3EREKftCgi1fpeu9XCV0Gf4x0Df+HVKxJHI/a6xx6mQrOaBXMymK15?=
 =?us-ascii?Q?3/zbY9LWM6Ob1pJELLrkrOthQxMjuMNruu0QFYGuGsR/iJ2pVwNc5ZJbm9O7?=
 =?us-ascii?Q?GsrfWEZ3xVSKBTIajngZj22uZGGvnR7zyTGnhqhvD83jrcMummp2i2kXvPfi?=
 =?us-ascii?Q?z1q14PKczsIifzazUzUwJqKp9DGcAyc2WrABBwqmR+ZRTm7BXCSAUGRS5jlk?=
 =?us-ascii?Q?WMLPuQTP/Zi8q8jl+OGTnAw8tsAnlYAYoXWX/yPW+YKgWxMmVo4GfsMbfITf?=
 =?us-ascii?Q?XIptid9/I0usXg8FU3tIrjutLxc8kZOpbgL6/S1wHSmsIdSWy5RKcDql9tAv?=
 =?us-ascii?Q?ejXVqRlhz8/pL0IMMt4enJbeLqEGyI8AHcYr+R+kRd8XC7Rl+N9Vyg8WJZfl?=
 =?us-ascii?Q?BI73T0fBOt737Etp36tHT0xxAPQeMVCUydU00hjOVgQ7aNstUVxElthNIMBm?=
 =?us-ascii?Q?TI/H51fk1gJfkAFmBWFOXBUntrovCs7e5mRZDZZ4mtuuTVfLI0Roxf2DZPPZ?=
 =?us-ascii?Q?2vPR/vhmBYWVPVsLfr/nlFX8kEncgkSxMF9mKiiTUBdckXNOIofthjNUTXni?=
 =?us-ascii?Q?0EL9GGtEbRl+TMVCUZe3epw1N/U7JsPuKtbKg9oBYDt2cLTbg2oM4uO5brKh?=
 =?us-ascii?Q?LzA0gQ16TAb2zJpmVojsqvJvRsWc3zJFXhOHooQgQupx5RHP84NHcAb8Q1NO?=
 =?us-ascii?Q?sxdNvRm7br4U+W5X8rZIzbAoiq4/vjIAGZZXWQPafiWypKgvQ1mp64r91zml?=
 =?us-ascii?Q?Wkfne5fTKyC96tADzhif7FenDgia7VR3zlKW6PoQjaJ5gPF/HQUcz0HaXO5/?=
 =?us-ascii?Q?euajJZEhLAJmaBf024S+uZi463Ae/Jxu0Hci5/npbaVvGSzlI9LOuZWbAi32?=
 =?us-ascii?Q?jh9M4iL0it10ECwAPzJQcXKfNtZxnmGqctPQpsEdUWEGw4WI6AdfPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GcJfN5hBNtD/M5wKIi338vf5IopdqInogsFKOwz0LANgngqsF5lOOvU/yPs?=
 =?us-ascii?Q?soWFczG7r9nhIazupF2nXCDxF7261aEDx82UpYnFKO3GbDgPVik7Qa6ZWWTz?=
 =?us-ascii?Q?onqE6rJoH3+RhtzZ5jlCKjrB/Es45PuCllVCTHtdc2tcEBLJCl8boGtHyLuK?=
 =?us-ascii?Q?ZLU+JJaPFZ1rYGzY8MR/NSb0kTTk5vZOUaXL/dSHOI0Q/BuFnaXnDvu5xuAk?=
 =?us-ascii?Q?SAjWh91andRPJ1oUgnZRarc0T/033KGx5RRi9mBsWujKAxMGh9zNW6q9ZD9E?=
 =?us-ascii?Q?3co0iZn43AB74hg9Q/lKmSh3bg0rVId4uCOyYtlHzp7iMrB0Pgvb/4nVJhFQ?=
 =?us-ascii?Q?d1sQwo+0zHMarnZgO3Osuq/YisaKINCGM4GuE79WipLF6lnztq0MyfgOkb4V?=
 =?us-ascii?Q?naIVoB3OGguqMe/T+HTX+jKF1pTf7fsPhm6xfm8Zsknx1+qCZlpno066UtuU?=
 =?us-ascii?Q?qGnfKwllunn5sG7NXWvVlmHiwDS6wJABSbIHoX0Vsvwyz4czZvDOm5//JnCp?=
 =?us-ascii?Q?wnDU4EXHlsuVZZX9qc+Zsf/XdYD9gwECeU+rcGbkg4mpugGJnhVnZVX8k9/J?=
 =?us-ascii?Q?vQbLZGHO4LYtlT3O2oPLr+0mzrlJ0JiYJPZVa7BV7suE+UNjff5HA84y3iof?=
 =?us-ascii?Q?WrEiRrCFSydu3D4BnVkS4LCcJp+P2Iacvn+b9CgwcnRfI3XIK2+L5NYqVjuB?=
 =?us-ascii?Q?dSMeTDLty1H/Trtgr+rHmYZpm4l6Gu2uY7VPZ0XdU5zcIdOESss5T/qLHBFR?=
 =?us-ascii?Q?OUqzJ2nEXA/vgrz4gM1TxSx/yZPbYOqj5YN7Wc2ji0UZ6KtWUBbfdn/t8e+U?=
 =?us-ascii?Q?j2Wg27zmpA6z3TpLzoPd99pYr1d5y3IteV32lCMqbGgmH/QnVpWM6W3dABqh?=
 =?us-ascii?Q?t0Bv6ViSKOiTCXjxWVRVVgcMbHcqZyJFDDGmGBoSJgV5hWng+K2ItoSzJ5Fo?=
 =?us-ascii?Q?tI6Qww4psudyr6wZaVYNKlefYu9R0650xLtNHj48Njl8bO0vgzj7V1ZPIeJv?=
 =?us-ascii?Q?q79mraIqFnTDFq549rFIINXvBvieLFvlgGrMIiDhJW6t/ybUBVaOABuN4v7K?=
 =?us-ascii?Q?sCWi/XR+tEarrr+HYcPs67/GAtQlKkx4HBuxztzkzqYCqgNk7FViY/CB5mK6?=
 =?us-ascii?Q?Nt62j0J/RQ90v6tyuUnnxkIGLFgXzQ5vSWxhmjinI0OIOwJoPktdx1X9W3NI?=
 =?us-ascii?Q?VEV1h5NS+AFRm2PNv2xq+8aA4mjeztHquDFmpMmcXi9KniMgnTzYO5miakyA?=
 =?us-ascii?Q?pCZmD/Rei20IthXz8Dn6VbZSxV0BJW3ydn88rHII1rFMDwmG+FOysG51Wo24?=
 =?us-ascii?Q?sKfYwLc7CYdFUxi9M+n17y3c63CPOZOf9DJgVvNOynOdNZOwPxvBVDcZGkXe?=
 =?us-ascii?Q?jFSf9VsoMlRX8Mz3oFirrTQNCjppNwdJ0nnU0HvY3ghHa6snztz52b21biiI?=
 =?us-ascii?Q?lZGE13Yw3JcziFA4khCdjjt7Bd6Jv/cuyo/d73UhUMAkvK967PdNX5jU87a6?=
 =?us-ascii?Q?tmGTy+dswKu919uADVrKS/04Fy6Z0wBtqLN5oSYj91llQos/cvdKzIEkiWHT?=
 =?us-ascii?Q?ik0pxG/g6Gimdchi5bZU7uf76ApEmFsyZOR3Hgp+oMslrw8EdcSF+L9WEXKk?=
 =?us-ascii?Q?UrB4g5l7IkswYztClXyXVMeRKily3aqcLO2qJjVbhF9L?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b770f6a-ff6f-4814-16b7-08dd914331c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:14.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y//xWy0uG3OAfJziDIu0OAmeNdw5CadarKEZodkqRygmZ8OpO49O2KNmYPDhAKihhboIUprQkCDvJfFUZ6JRT4ehG5j9692DUKOOxizd97gR8sX2kLGGw8wYX871jhrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

This patch adds required changes to vcpu init to run a guest code
in vEL2 context and also adds NV specific helper functions.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  2 +
 .../kvm/include/arm64/kvm_util_arch.h         |  3 +
 .../selftests/kvm/include/arm64/nv_util.h     | 45 ++++++++++++++
 .../selftests/kvm/include/arm64/vgic.h        |  1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +
 tools/testing/selftests/kvm/lib/arm64/nv.c    | 46 ++++++++++++++
 .../selftests/kvm/lib/arm64/processor.c       | 61 ++++++++++++++-----
 tools/testing/selftests/kvm/lib/arm64/vgic.c  |  8 +++
 8 files changed, 155 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/arm64/nv.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f773f8f99249..3348f729d3b2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -37,6 +37,7 @@ LIBKVM_arm64 += lib/arm64/processor.c
 LIBKVM_arm64 += lib/arm64/spinlock.c
 LIBKVM_arm64 += lib/arm64/ucall.c
 LIBKVM_arm64 += lib/arm64/vgic.c
+LIBKVM_arm64 += lib/arm64/nv.c
 
 LIBKVM_s390 += lib/s390/diag318_test_handler.c
 LIBKVM_s390 += lib/s390/processor.c
@@ -155,6 +156,7 @@ TEST_GEN_PROGS_arm64 += arm64/vgic_irq
 TEST_GEN_PROGS_arm64 += arm64/vgic_lpi_stress
 TEST_GEN_PROGS_arm64 += arm64/vpmu_counter_access
 TEST_GEN_PROGS_arm64 += arm64/no-vgic-v3
+TEST_GEN_PROGS_arm64 += arm64/nv_guest_hypervisor
 TEST_GEN_PROGS_arm64 += access_tracking_perf_test
 TEST_GEN_PROGS_arm64 += arch_timer
 TEST_GEN_PROGS_arm64 += coalesced_io_test
diff --git a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
index e43a57d99b56..ab5279c24413 100644
--- a/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/arm64/kvm_util_arch.h
@@ -2,6 +2,9 @@
 #ifndef SELFTEST_KVM_UTIL_ARCH_H
 #define SELFTEST_KVM_UTIL_ARCH_H
 
+#define CurrentEL_EL1		(1 << 2)
+#define CurrentEL_EL2		(2 << 2)
+
 struct kvm_vm_arch {};
 
 #endif  // SELFTEST_KVM_UTIL_ARCH_H
diff --git a/tools/testing/selftests/kvm/include/arm64/nv_util.h b/tools/testing/selftests/kvm/include/arm64/nv_util.h
new file mode 100644
index 000000000000..622a17c9d142
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/arm64/nv_util.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Ampere Computing
+ */
+#ifndef SELFTEST_NV_UTIL_H
+#define SELFTEST_NV_UTIL_H
+
+#include <linux/bitmap.h>
+#include <vgic.h>
+
+#define HCR_NV2		(UL(1) << 45)
+#define HCR_AT		(UL(1) << 44)
+#define HCR_NV		(UL(1) << 42)
+#define HCR_E2H		(UL(1) << 34)
+#define HCR_TTLB        (UL(1) << 25)
+
+/* Enable NV2 and guest in VHE mode */
+#define HCR_EL2_NV_EANBLE (HCR_E2H | HCR_NV | HCR_NV2 | HCR_AT | HCR_TTLB)
+
+struct kvm_vm *nv_vm_create_with_vcpus_gic(uint32_t nr_vcpus,
+		struct kvm_vcpu **vcpus, int *gic_fd, void *guest_code);
+
+struct kvm_vm *__nv_vm_create_with_vcpus_gic(struct vm_shape shape,
+		uint32_t nr_vcpus, struct kvm_vcpu **vcpus,
+		uint64_t extra_mem_pages, int *gic_fd, void *guest_code);
+
+/* NV helpers */
+static inline void init_vcpu_nested(struct kvm_vcpu_init *init)
+{
+	init->features[0] |= (1 << KVM_ARM_VCPU_HAS_EL2);
+}
+
+static inline bool kvm_arm_vcpu_has_el2(struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+
+	return test_bit(KVM_ARM_VCPU_HAS_EL2, &features);
+}
+
+static inline bool is_vcpu_nested(struct kvm_vcpu *vcpu)
+{
+	return vcpu->nested;
+}
+
+#endif /* SELFTEST_NV_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/arm64/vgic.h b/tools/testing/selftests/kvm/include/arm64/vgic.h
index c481d0c00a5d..46142fa36199 100644
--- a/tools/testing/selftests/kvm/include/arm64/vgic.h
+++ b/tools/testing/selftests/kvm/include/arm64/vgic.h
@@ -17,6 +17,7 @@
 	index)
 
 int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs);
+void vgic_v3_close(int gic_fd);
 
 #define VGIC_MAX_RESERVED	1023
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..9b26b9124dc3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -65,6 +65,9 @@ struct kvm_vcpu {
 	struct kvm_dirty_gfn *dirty_gfns;
 	uint32_t fetch_index;
 	uint32_t dirty_gfns_count;
+#ifdef __aarch64__
+	bool nested;
+#endif
 };
 
 struct userspace_mem_regions {
diff --git a/tools/testing/selftests/kvm/lib/arm64/nv.c b/tools/testing/selftests/kvm/lib/arm64/nv.c
new file mode 100644
index 000000000000..e930808a7ed4
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/arm64/nv.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ampere Computing LLC
+ */
+
+#include <linux/compiler.h>
+#include <assert.h>
+
+#include "guest_modes.h"
+#include "kvm_util.h"
+#include "nv_util.h"
+#include "processor.h"
+
+struct kvm_vm *__nv_vm_create_with_vcpus_gic(struct vm_shape shape, uint32_t nr_vcpus,
+		struct kvm_vcpu **vcpus, uint64_t extra_mem_pages, int *gic_fd, void *guest_code)
+{
+	struct kvm_vcpu_init init;
+	struct kvm_vm *vm;
+	int i;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
+
+	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
+	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
+	init_vcpu_nested(&init);
+
+	for (i = 0; i < nr_vcpus; ++i) {
+		vcpus[i] = aarch64_vcpu_add(vm, i, &init, guest_code);
+		__TEST_REQUIRE(is_vcpu_nested(vcpus[i]), "Failed to Enable NV");
+	}
+
+	/* vgic is not created, If gic_fd argument is NULL */
+	if (gic_fd) {
+		*gic_fd = vgic_v3_setup(vm, nr_vcpus, 64);
+		__TEST_REQUIRE(*gic_fd >= 0, "Failed to create vgic-v3");
+	}
+
+	return vm;
+}
+
+struct kvm_vm *nv_vm_create_with_vcpus_gic(uint32_t nr_vcpus,
+		struct kvm_vcpu **vcpus, int *gic_fd, void *guest_code)
+{
+	return __nv_vm_create_with_vcpus_gic(VM_SHAPE_DEFAULT,
+				nr_vcpus, vcpus, 0, gic_fd, guest_code);
+}
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 7ba3aa3755f3..6e759981bf9e 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -10,6 +10,7 @@
 
 #include "guest_modes.h"
 #include "kvm_util.h"
+#include "nv_util.h"
 #include "processor.h"
 #include "ucall_common.h"
 
@@ -258,14 +259,49 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
+static void aarch64_vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t sctlr_el1,
+			uint64_t tcr_el1, uint64_t ttbr0_el1)
+{
+	uint64_t fpen;
+
+	/*
+	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
+	 * registers, which the variable argument list macros do.
+	 */
+	fpen = 3 << 20;
+
+	if (is_vcpu_nested(vcpu)) {
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPTR_EL2), fpen);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL2), sctlr_el1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL2), tcr_el1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL2), DEFAULT_MAIR_EL1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL2), ttbr0_el1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2), HCR_EL2_NV_EANBLE);
+	} else {
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), fpen);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), ttbr0_el1);
+
+	}
+
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
+}
+
 void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
 	struct kvm_vm *vm = vcpu->vm;
 	uint64_t sctlr_el1, tcr_el1, ttbr0_el1;
 
-	if (!init)
+	if (!init) {
 		init = &default_init;
+	} else {
+		/* Is this vcpu a Guest-Hypersior */
+		if (kvm_arm_vcpu_has_el2(init))
+			vcpu->nested = true;
+	}
 
 	if (init->target == -1) {
 		struct kvm_vcpu_init preferred;
@@ -275,12 +311,6 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 
 	vcpu_ioctl(vcpu, KVM_ARM_VCPU_INIT, init);
 
-	/*
-	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
-	 * registers, which the variable argument list macros do.
-	 */
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), 3 << 20);
-
 	sctlr_el1 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1));
 	tcr_el1 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1));
 
@@ -349,11 +379,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 	if (use_lpa2_pte_format(vm))
 		tcr_el1 |= (1ul << 59) /* DS */;
 
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), ttbr0_el1);
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
+	aarch64_vcpu_set_reg(vcpu, sctlr_el1, tcr_el1, ttbr0_el1);
 }
 
 void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
@@ -387,7 +413,11 @@ static struct kvm_vcpu *__aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 
 	aarch64_vcpu_setup(vcpu, init);
 
-	vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
+	if (is_vcpu_nested(vcpu))
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SP_EL2), stack_vaddr + stack_size);
+	else
+		vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
+
 	return vcpu;
 }
 
@@ -457,7 +487,10 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 {
 	extern char vectors;
 
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
+	if (is_vcpu_nested(vcpu))
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL2), (uint64_t)&vectors);
+	else
+		vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
 }
 
 void route_exception(struct ex_regs *regs, int vector)
diff --git a/tools/testing/selftests/kvm/lib/arm64/vgic.c b/tools/testing/selftests/kvm/lib/arm64/vgic.c
index 4427f43f73ea..67822b803d0f 100644
--- a/tools/testing/selftests/kvm/lib/arm64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/arm64/vgic.c
@@ -79,6 +79,14 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs)
 	return gic_fd;
 }
 
+void  vgic_v3_close(int gic_fd)
+{
+	if (gic_fd < 0)
+		return;
+
+	close(gic_fd);
+}
+
 /* should only work for level sensitive interrupts */
 int _kvm_irq_set_level_info(int gic_fd, uint32_t intid, int level)
 {
-- 
2.48.1


