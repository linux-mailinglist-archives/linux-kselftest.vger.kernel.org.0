Return-Path: <linux-kselftest+bounces-10740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07A8D0E9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 22:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6533A280C22
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204F5338D;
	Mon, 27 May 2024 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PnALTHXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F468821;
	Mon, 27 May 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841913; cv=fail; b=LP2EJxNZWxyzLZhOkUuAs8XPYhnGixhIqD+mwHya6ky4kLdKR+ic7ekAxusm//Piyr3UnCIZCMCqQIlIr1yqQA7gJP9Oej/vmiNQs3aaHwdtQ/Gg3fdIuXxhbcQzrdprOQKaCkJQJgLtD6vYTwPCIzh13D5pVysxhOi8xIaAz+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841913; c=relaxed/simple;
	bh=64yQRfa+ybLe5dfP0PxMKG1dnndhJfUBkhHrY4u49RU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rAKA+3JXHKnIrJDyB+7CmLilpiQtHtidRxK1VZm2cmMK9K21o+ryuZjsDvgIKpZ+oaLdsOK3qyOeB089tUo5HZSEGK2RfhO88HNpxQk+wTodKP7EM2v+Fjlc82XpfJiCKouj6yJXDBHQ4k3mytzYeqqZBKnpKbrrzBVXu9Cw/0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PnALTHXX; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqMa0a2/aYnsE8CcbUkwjkioIF5laSFv58F9JcZAn3dbImnoA/75fVzwYl8TtGnUFY6qrBFIfciwE+t0Akar0YKGwWplNzS31afQT2irfb/mO3kOZiyotXyGj18GgLuqsxfUXLpGXO6UcUyh9fLS0cYzL2u8SVb/exJ6HQwiG+scEyqXh1sr1GIykptDSJK5x9sdtt2oFm2cj7IDc1zGi/QYGeRcW93zVRXvzL+P8dFeRf79097NLq4pqWWesS9/y3cbUach2t2TxZrefKmt4tItGqlzELuciDkJbnGZN9yf9bj7k5hHxylV5EBVjzANKjPvwhw9QePAd3z9PK95og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBOge9VCSwKlB1L9Ed7z1Ef3AN6QLqm90b1ZxiUWqLo=;
 b=IFMdn36jYyMdPvbV9bBKt9a0ziRi9LGiHnkqzEm957f0tltGJN2zZSLht0Be27UWubE1vlDY7m4pj827fwEQtPQHEwbhNtdij1aAnYiaVQnXbKTJVtlkdtxwC9W7Jv/4UCblzIYhqoeK7P21AJURLvJhdcR6OJEFQQvIDkLnuFmsrSPIJzKum1UgLYwHJMX6Gk4hKw51fot39XmQ6xY8zfeTsoddyVJk4WafPzxRkCvmuyReu7a/clSEBCcyxtjyO78iG3F0r0WiGID5INJFDMibWE2U+aCjvA4e0mV+VDh41rIihTPUjlFRs0Fhn5Wy78zLLU0151oX7lmYXd/FIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBOge9VCSwKlB1L9Ed7z1Ef3AN6QLqm90b1ZxiUWqLo=;
 b=PnALTHXX9Wkbxzjb4hzq7NAOk84cgLmyK9oIXjib3cxkSJSK0Qyxzj4d8AlhJOEEBl0yButPwgKP7krvHxm89FwkEUurQTY1BxgMKaToBylGB3QKcZ64g5c6Q5z2eU/DseuK9RLkFZlXt2PBqAm7IQNP1ym5X4I//yvOj+xsD+nFnYv6bpjm+vGAJrxZkHQ2rarbZ4t+js8aAFAXzyuJp0gyub5g81h9PuIeaTTHicxzuvJg7WTG56IRj83O41uJVX87yMmobfERzWuZy3zFXb6az1UUlbyco7lZVyj1BZRSxQNqe/px0itRMpCHXgeN05kqS1DPgan7VcF5ZjibBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 27 May
 2024 20:31:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 20:31:48 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@openvz.org>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2] selftest/timerns: fix clang build failures for abs() calls
Date: Mon, 27 May 2024 13:31:15 -0700
Message-ID: <20240527203115.215586-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 962e4bc3-b2aa-47d7-e0d1-08dc7e8c0876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUsdrt9IPfE/1OZJw4iOLDx4a5qxdM6nJxZ6QIq/ePInizVkaKyORUU78PKa?=
 =?us-ascii?Q?suLlqdPilrH1FsZIlJ2uNk2uHnO3dtwDywotExKzDSDUFLYz7g4dO4z3cmZv?=
 =?us-ascii?Q?tApQ6fxHPdub9XFltK7LPtmuzvPx1TQo38e7TY6MoKm45hyXwQab9BZP3Iqi?=
 =?us-ascii?Q?oi9hf7j75exIILAlekuDuSXDZWkmSaLp4J5PDvcecDaOeXjPY8vtFH8eFc0J?=
 =?us-ascii?Q?4UqeQXhthA5GhPm4q9fuB+Hx+4Dx5f0Ky5ROpADmCI0oNZQ74rUxz3KfI78k?=
 =?us-ascii?Q?hYkBDrYOjUB8YdJZabUTxapM/5s1sWWyYmR8vkUSClkVlUyUz7+/X0mP/5Ti?=
 =?us-ascii?Q?GFJy0juCJ5m8e94090jLYMQfDl0sxd2CLi20rJACIqTvBCk+kY78Wg0v5urC?=
 =?us-ascii?Q?7+iB/FfG/mgXx4thy5x+q7grn29Vkq3F5ScqH8DXmVGvV4JW4omzjzg3umJ1?=
 =?us-ascii?Q?WQMahpgD2phzOhOk28N0XzpYdYCe4c7VQhKG/smt+m5WtCU+uX2R6tcAud7N?=
 =?us-ascii?Q?OJW68+zUUb3uO4WFVp+woIFaU1ElrhhFGJgH3FxcYIR/j6gpvK7Lb4/xXM3G?=
 =?us-ascii?Q?hkGCxnohCUBDmCE2Uhb1f6rI5XWSsc6lQ4DjyDEOnQrcM6o4U+nZAA5ZqXzp?=
 =?us-ascii?Q?446jrvQ0oug1G2zvbZIPHWmmaQfystzcIcCPVRggVjP1umfShYB9bODq9bxw?=
 =?us-ascii?Q?7cMM7Wa2prELBGx0j+UIhzUiLpiwM+zZlYV2KlvfeJH3JlNReDmNWTixdo+z?=
 =?us-ascii?Q?YzdfgQqqegiEVART5GHYKC51pBMFfCb2MiNn6RUbMyCU5i0cGxxY3JKZwLX8?=
 =?us-ascii?Q?6TmMgxMewcpqmro+1jT2Nm9nrI/2RpWn/BK0ybbFZ/PHRK5eKZXVCdUk87dJ?=
 =?us-ascii?Q?KHltB2zpffJE32Ogyz56NIQGNuIMiJ+5KDTeRAHcZGL5M5yvcBiRH8qrANjT?=
 =?us-ascii?Q?zduUJUy/wYWL3S7bDclv18MthRnTnzgVyQBMrOypIQJGYNBHc7SEZeArBizb?=
 =?us-ascii?Q?746jWiRWtWBYLxysochUcPV+Whx5ZJwOqILsXnUmVb1DF4JjvSKw0vI3jIhq?=
 =?us-ascii?Q?jIEJwASuKdU05VomkH4H8er9sqAsXwrq/JSVElQl8e2CcVNItMaRMJiMS/th?=
 =?us-ascii?Q?x7EVaD3BihWzdGB44blaFH2sYcPV+OEY1BaQ9+OxxfLMQabXln8GXAgSSSd5?=
 =?us-ascii?Q?aP+7HrxmjwUuK7j3RyOuaTF1zAx19QTGTOjhf5f3mKEAnpyoDb5IJ7SEnJiy?=
 =?us-ascii?Q?r5vHpSbFQCXA8bsTwnWyVg4VfS0KJsdc9wfi2TwUzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1t35xGGfZ6SUX1p3nABjPSEKv9V5RRbR3E4kwc8uJtkCNe4UGvWYxQsV4ug?=
 =?us-ascii?Q?kgY8xjeLFMhY4viyv6JAGMc44eX1f7HQLT/wV2L1RMQCStitJD+yZtcfnvLU?=
 =?us-ascii?Q?MTWRKUplnGY7a1wAkpyLIMXHN90Rva0TPJKecwbt7CGDVwf9U7r4RirgRTGc?=
 =?us-ascii?Q?DgU177DKAsPPjETW9Z5ogcUlaYmJwtK1CcU8k/w8sO/uPxFrEttU0Lu8K+B2?=
 =?us-ascii?Q?2mnuQMWDJHfqOgAHUq/6GRi90H77lr8dty2/GxsW7r+Ps8eWvxeW650R+Sqi?=
 =?us-ascii?Q?iRO/QyTL4XyOmBp4ZvFyEqGq0l2C1JhOUSxZweM9eRF9wg0r9MRw6YovZeEc?=
 =?us-ascii?Q?Gj+9TWMg5mJ9VtgQozVxt15jrs+fQ9PSfu5Lph9qc/eV9ptnOXM3DmgT6MCF?=
 =?us-ascii?Q?oeMpt+m63MYvPyG/dH6tHVqJ67qbVTYpVzt/Vn1X9K1IBg+2ir9Sk3SCmguV?=
 =?us-ascii?Q?Ezfkxs+j5toDdIiSRGjd+gmOVjHVgpksNTUlmJKQ1tyTB9/0Q5JUIEeI/u6y?=
 =?us-ascii?Q?8fDIAOSxIy05nm2ijVH3uERTGFITWXHDn2Lmwc4yFHH+wrIRgZTyocRADt+W?=
 =?us-ascii?Q?otJEsSZM9UIOKt3bAO/jADDcWn9iKiTw3zfVJNgeD2PgNQ/D2MUproZesZ3X?=
 =?us-ascii?Q?XJ/dKUqhX7938B0o3ituB5JY3Bsfv7NY5/qWBJg5M29ch9TP/kY2TYhwSRrb?=
 =?us-ascii?Q?V/hc0mlGDI6eYpf3M8Rn6/n2nJR2hyZYZMVAJEqW/+QZnt934Yb2+jhb82uw?=
 =?us-ascii?Q?I+Qe7CpN4UpZ9RGs2+kt+r+Bmp/UVfXEus1SPUffy3nDKFWN08Pfr3Nyeih+?=
 =?us-ascii?Q?1q2T6dM+F8FRjaVhS0iz1txCTFyGSR2Bn+CV3q49xlGh3Tx9KJDkYjRe5qaR?=
 =?us-ascii?Q?PqMwxLEn8Aw+LfW+501RQRPbasW+TABXBu1WObhaEGdy9qec/KF3zA/DZEVX?=
 =?us-ascii?Q?NYWhPoNeeaXUoV/KFw6xBT0mcQedSNbwyoCnjk69Z+Uzljv7qFH/g1LpJvWw?=
 =?us-ascii?Q?4tt3IuGWraGLVvPOnuE9Bv5oaN05W4fMHTxYq5kWdRM+AyIVg1MB4vPXY4Lf?=
 =?us-ascii?Q?t9faEHw5pNlXMrn/NClqLkce2Nl3w0m7taJjafWUZpzIOB7ifrCXtX2j6aLO?=
 =?us-ascii?Q?/xTUClEciwQn2eop8vx9PIwqkcQRrVH2sUAHXR0jkOGJRoGBEGnoFUa9EkU2?=
 =?us-ascii?Q?n+kaCYt4ljlh7QBy3zBnu3jm6GdGb6Mt0NB/tFGPPApTr0M+r9U3TbhmSpO/?=
 =?us-ascii?Q?qmTJENTfF+OMCNDy3KkQviJ557yH0n+TB4z9QjdSq7OEANm8wWWeX3hVQPnd?=
 =?us-ascii?Q?gV5Tete+nrgEYUKmd2hoJh6pLjLyCMcO3EOaUMllebvF4tCrt3M0YBgGFNjo?=
 =?us-ascii?Q?wuC8Af4Mfx1gM5tre/ID6Ke4hc/oiUPw77UjDjxR07+hIx3PpuHi3p5iNuAO?=
 =?us-ascii?Q?24WeViIvLxciK2x98rtS313GWSIaDe/T/Uj2bCPNVmHJ0CGaDr7R1CkiZb2J?=
 =?us-ascii?Q?5/yJU+C/40VrN7IH9jE/wIHIp22HTUCiydm08QoRgpJZ1pJT2hoK57Lqp9+4?=
 =?us-ascii?Q?JP03Q1gRIPVcLz+pFkArt9W4LhRGpitiimOYF7hOGFqDpNlUCgho4nRJ+gbi?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962e4bc3-b2aa-47d7-e0d1-08dc7e8c0876
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 20:31:48.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rWoKiUZ5jdb8YUJIu0sKN/gvRad1nO5fgHXOkNzDRxbeyvQHTa713tkPtCkaiJ+f/rLOBo2EZW6Zn2zSyqhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...then clang warns about mismatches between the expected and required
integer length being supplied to abs(3).

Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
these cases.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Reviewed-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

2) Reviewed-by's added.

thanks,
John Hubbard


 tools/testing/selftests/timens/exec.c       | 6 +++---
 tools/testing/selftests/timens/timer.c      | 2 +-
 tools/testing/selftests/timens/timerfd.c    | 2 +-
 tools/testing/selftests/timens/vfork_exec.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..d12ff955de0d 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..5b939f59dfa4 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..a4196bbd6e33 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..5b8907bf451d 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -32,7 +32,7 @@ static void *tcheck(void *_args)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+		if (labs(tst.tv_sec - now->tv_sec) > 5) {
 			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
 				args->tst_name, tst.tv_sec, now->tv_sec);
 			return (void *)1UL;
@@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5)
+		if (labs(tst.tv_sec - now->tv_sec) > 5)
 			return pr_fail("%s: unexpected value: %ld (%ld)\n",
 					tst_name, tst.tv_sec, now->tv_sec);
 	}

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


