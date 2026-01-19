Return-Path: <linux-kselftest+bounces-49427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC09D3BAF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42C3D30060C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55002F616E;
	Mon, 19 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VbnkoyZ2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VbnkoyZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC22550D5;
	Mon, 19 Jan 2026 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862007; cv=fail; b=rFrDC03PeVFXiCTTrOP4yFg8vAZYBo3f62zMK8FMUF0oSY216J+6v61rdDuWcL4R5IIgeq+Iv6utk3T3GjJCkuRI0453F1gfNmZ0Cjyx6uncQcAkIJO7GEBQW/ZWABs/2atr6LRxp8I3JF7T5cepBL+ny6K5NiWrCtLLPGRuO7I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862007; c=relaxed/simple;
	bh=6w7JHsMMaDwjhcDLxhKAh5ROor25JsuI07VVGuXZGm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxqURQ4RFabx3uxGb4VgbkNdjv2nHjSXwiMtfBPa65ANjP8uUhE/uY27xWhPc0hMY6OoUF1AmH+kWYTRd6OkWlj88V+YNbMtuVvJKH/mHVEgm5E6g1VQ5tQkdaP/g/khqUHjgXvrt5nTLKoGAS3WzzxHCtMjI8nkH99i0pTLNLo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VbnkoyZ2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VbnkoyZ2; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=odNLrCCWFi9xNJtGQbBtVqAkn/W+/jhQYG/Eh3Bnik7DBcNPlcAxc7LRb0WMz2taEvASSZyr+t/J9+AUAEZU6avs6/gFM6hS0/SKdmkMzZGib52Jf/38ANAbrNzDTMgh7fhM4fCWA5Z8c3kinQSx8V4CiPO0bTaZz2/zFMkPBKn0PtlTVe+ssMbqc1R+24jEaeUDtxIXJmyToKkNPQH0hVzQ5fESyBneXG9DH7bWchilmj0Blit5qwmJwD0Um9JYs/YEay4BD6NfERIkNSLoRNgU/8cOYHN+BPvlQlqPUJ7wo8mdw0vcsb5y7JM5CF3uF+rP2a5XyAsNquFUIEqS/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w7JHsMMaDwjhcDLxhKAh5ROor25JsuI07VVGuXZGm4=;
 b=B3skOy0YE3GzsKp2Zrym4Aa9wFAD5DIqgnJurAjkCId+ykM5/IkpZxx/mQul7chJ3sRgI4wkTa+kGEI7+HrjdWsTlYnVLR1sCmupQeLEXXXkXknL0ZKRB00ye8G1SP5LujkfabZGJQ2f0j9J+f+Q0z8T1agaZIX1g0i5en/9XDzcUt7Brdmjx/1dhUyNd1P5JE63oBVP3eIY6LNWRZRl85egrXAKAYkfISZCtz37N6V/Ns5jwIHZydfNLjuBJPEUKKIIQtEBejkG7+UkkE1PEnoiwZ/rw1dytXgvbwW8GPyj+fILw8TqyH+MUsZY7s5Gluz/+FgnOk/qhK7hyrnXjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w7JHsMMaDwjhcDLxhKAh5ROor25JsuI07VVGuXZGm4=;
 b=VbnkoyZ2sJ6PjQy7N0grw31MlDjHgKahMjF31xp3gv1VM3cfHEwZEThAm7DfbDx48qLTqy5ej3Gr9A/vntzgz+/orFa6AFMeT0LmdfbJ8WuyBdCqTHloVu0saTH9DAxYbz33DShrfFxgDFIZyueQv+ySTmNmOgMpaz2oycIuZE0=
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by AS8PR08MB7942.eurprd08.prod.outlook.com
 (2603:10a6:20b:53a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:33:21 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::da) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 22:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 22:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJoy6VnYtjnRm8onT9rWvMA5sd6ncx6lq7lUrASQgpPLxxTCKC9yf5FQwizT/eWZM7YqDhTk4621FVYkFQcwC9PBGyIDXazSkHhvbxJiWH9KZ5FcyGy+J9Ntt4+1f7K7oF2c11kE0R/uPtXyLL6EJWNa5vAOCJGw4HAppXSHg29YjLLHaX4/5M/4DvQuCq/HCwQLMpFn7SaHfOl75hEGbGY4cwejcGqeTGoXAw7j/Hl1qXeOz4HFKsLoxE8AqRgmsPYbVoylgwlsDOSMAnzvnMaYefJkbUckdJLqzFhqj2oQApYTD6VrJqCHnH+aJLRsqHNRBPjeGSoDx6/1BPqu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w7JHsMMaDwjhcDLxhKAh5ROor25JsuI07VVGuXZGm4=;
 b=sEGPTygts2oYWI3vu6C5iZo5xABmNoAoyrXQAWHbVG87Ol5gxsDLeGvSlWaFg4eN2RIb8NcS3U6Tj+jFMaXj1lBFZrpzFawxRKjsqoSBOtYvpH3GmzpvuOOGqqaA2LDY4y2OUsowl+00F6RUcS48yTktY6cp1arm/yA0WVsIiqqmHEfS2JtyyjIXmWbgbM4Nuzl5a/vlSkWTGE6mE8zGrk3OtPFz1m2BV+7BxM6GMZDnObNsM5KqQWrmcMKAvY/focUkAkibJ2cnCa29K+zIrdDkM2H0D2QW/oYRXjRgEJVyQwvhegjsfDSZPxeltHLVAop33A5JzRfrurQ4zBWvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w7JHsMMaDwjhcDLxhKAh5ROor25JsuI07VVGuXZGm4=;
 b=VbnkoyZ2sJ6PjQy7N0grw31MlDjHgKahMjF31xp3gv1VM3cfHEwZEThAm7DfbDx48qLTqy5ej3Gr9A/vntzgz+/orFa6AFMeT0LmdfbJ8WuyBdCqTHloVu0saTH9DAxYbz33DShrfFxgDFIZyueQv+ySTmNmOgMpaz2oycIuZE0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB8365.eurprd08.prod.outlook.com
 (2603:10a6:150:bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:32:14 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 22:32:14 +0000
Date: Mon, 19 Jan 2026 22:32:11 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, catalin.marinas@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 9/9] arm64: armv8_deprecated: apply FEAT_LSUI
 for swpX emulation.
Message-ID: <aW6w6+B21NbUuszA@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-10-yeoreum.yun@arm.com>
 <86ms3knl6s.wl-maz@kernel.org>
 <aT/bNLQyKcrAZ6Fb@e129823.arm.com>
 <aW5O714hfl7DCl04@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5O714hfl7DCl04@willie-the-truck>
X-ClientProxiedBy: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB8365:EE_|DB5PEPF00014B9C:EE_|AS8PR08MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: a9863143-3882-4c40-5834-08de57aabfe2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?pE2XD2lzNWeZH069oKrRCW6ZGYWbiCVFkJbPMVJr/Ik33p1WZktQ14nA3tLE?=
 =?us-ascii?Q?2chLQfUt+iE0j6gMhh0xEUhD6vHAcpF1FSR4P6gvs0shnhd+o6m5KlFAkQVs?=
 =?us-ascii?Q?774TSmCvlNFfZBSFt0aBAiqRZ8N+bBko9pWl5GuB8RLeGm07hri/RlWriwzZ?=
 =?us-ascii?Q?YdEGUC0Dacetw3VLJV4RC5Zp+6/0Mhgbm+yIG+nWhky65DJkNgXRg/q5b116?=
 =?us-ascii?Q?o9FT/5zfEdeP1aI77A4hpADfkfWHyqQyyKgSAmd/zavi5G3ccRrx+D0czFpp?=
 =?us-ascii?Q?0Hh2vBkHHXqhAwV5FD4CaBgWU4Jjq9+Ub3UuHYq+AkeMrr9jStsGqWQszKOG?=
 =?us-ascii?Q?QCE//beeu8S/b/SoGYCAkOsgaHmFFG+ymj5Akk/7pmuTmZUr9ZzKooR0INxk?=
 =?us-ascii?Q?U1/hew69elTHqweCDx3d5zZo/5waEEdgwepBHfOP+PhA0Lf70uoNAYLF7tLE?=
 =?us-ascii?Q?xOfloAvk23X7koTKz+JmKUFPTHd7P7j2MrLgS8OJVOaD164U7cTy1Ww1vai0?=
 =?us-ascii?Q?X1LAFemNlDvNo3AI/+lHH4zz0HnNrsL3wkwS4FJjrvcjf8YE73asfBkAI/ve?=
 =?us-ascii?Q?88SD+WpC2XkorerY8nMkCqrb1hBb6q6fm6U3Ct0SkLUxwbJChljzN1vPQF3i?=
 =?us-ascii?Q?XHHEdbDpJD1aKoZ27UyqpZLyIkmtKMpY0nQDsGvbK+V2++gaxcwoR5vNilYt?=
 =?us-ascii?Q?4vxX9QcCKC8mZ5N1vr7WkSxV2r+5P6zYPJlcVN25wZKEckPyNE+uumShaYWO?=
 =?us-ascii?Q?xKsJQBHx+Yuw7bX72Fu8cOnt1GKDrJktU8oN+zhQNOhe320J42mM2EiWrkub?=
 =?us-ascii?Q?wtS/DBumYcGLf/IKM5ePFYRHCUIexuc3ckH+dNRhqDEpF2oCCfoXfhhajPI5?=
 =?us-ascii?Q?lbNZC2dj9+xboHCsGi+UDcwwkBHmXyCOXNdzGp9yRDrrCpbEw+fTfBJd7IfE?=
 =?us-ascii?Q?EMes9n1E546uNyLdXh00l5/XzmRop5YeiXHxXBg6kJodzUZ0DoUtgJcxh6ST?=
 =?us-ascii?Q?0BbjUqmRrt7TGAYHs8bMx+/+ywCUIn0C1IJ38cpjz/0PLRhIGO7ww2eq1Z2g?=
 =?us-ascii?Q?FIvJqSl2CXEeWEl7p7eF87npLzqwSfSeCsX/ZKmVeIH0FhawuklJ5FrkHEYl?=
 =?us-ascii?Q?ehFGfvUvIsl4lHiRIOPX1UwhFBiV9/gLi+TsWamDCILWvA9y6HZkVrmM/YQT?=
 =?us-ascii?Q?QgBpbNydIFEjL+FFjfVyT4JsYaaCTKPuy2tzJ5hGKHiTT5kgChfJa3DXXHMB?=
 =?us-ascii?Q?QduNPhx3JkxcXzPG68KetDnE4FPzgr6JxW+tT6TOMnDN504Y98qo2Dily/2R?=
 =?us-ascii?Q?9rWMvmXz1Tjv29Kya4LHKlmI9AnviZfmvAlpyx2G3MYrgJZFNaFROSP+q2s1?=
 =?us-ascii?Q?M2sslX8qWcAMgvcUv7lWuSem1MGEgHDV97NbGK1I4TPHv50woE7+XcYY8BQC?=
 =?us-ascii?Q?7k/TLotXQn8zubI981FewvVwNFY7wz4c51oCuw0bLYlCEJJ6Km041KiuwH2i?=
 =?us-ascii?Q?W08Cc0f4nqGXrLIqq6XGaSJdPhErlpCmZXAitVCWh+hknfdNbC8JUaMcZP3u?=
 =?us-ascii?Q?kJ8kc8CoTXUJpaeaDd8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8365
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9bbf514d-69cf-4034-798e-08de57aa986d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|7416014|376014|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNcE/BwbqkmM6S+3NU0hcO7drbyLFeZf+r604vTnFpYy0GUVU/epqmssYOAX?=
 =?us-ascii?Q?LcAsxqwSHKlM5n2nxC1yMfp6UMwPOqit+rGfr18g+f0/UFT7eXUzK480euYT?=
 =?us-ascii?Q?c6+sfRTdUxM63j6jY6j3Z+Jh7rfaLFpDtaCaWbTKGESu5M7UW86gNURK2J8+?=
 =?us-ascii?Q?Fl4ZYeMElBpzGOLKdvOCAeIMHCg5qqx1HXm7dt18V279xeKWwZkh/AjjEi7O?=
 =?us-ascii?Q?K3P/aK5V/b7dagAA/giD1qXtsGrNCp5fTo5BX+WtCVqyjQOnJb9z/rQ3TH+F?=
 =?us-ascii?Q?RmRs5Y2+9vf94G+vvsLxnbSTZVQJ0kgEOYEO7ZnxoUwYlNSAPNXdsn45A3Sw?=
 =?us-ascii?Q?3v+vZL4b4P4V90HlZPilNagFl4060UVY9oq7AFPOJCrRlkO7pWdxkEdvJ7tL?=
 =?us-ascii?Q?iYX0CJbFYHRiO3OT/z/353pZ4HTqxmqDzk73Abwy7syEkFfVNAlKqmUTgXMb?=
 =?us-ascii?Q?GTcF3LIzK3vdgi1vAnQ8dNWGqh3NPfkE1bpJWwDUZ0jVnVvyPJGBwukiuM6l?=
 =?us-ascii?Q?sc54gNgFu0QWhRYYutyO5LEAFwPxwd3iruxH8Fabe/C2rMoK0Pyadp2xPia5?=
 =?us-ascii?Q?1/pp/k9mtZwX3GRZsd9upOOtyAy/maetKhW0ZX/l9IAjF+k+157bKF/3lTgj?=
 =?us-ascii?Q?0Fp+2sjbdM6QmrSDi8XMN4Lll28AW6aSZSj968zAqRn5lPTOiQZSNMsOoqic?=
 =?us-ascii?Q?62OmlZDyhVJgTgvJriN9EjI8muyzFyV8tU8+vgEHKMwYdwkYKjR1VhfYWozK?=
 =?us-ascii?Q?PnUyH3lXvHaUtHUrwi2hT8Kiz1Y6Q52MGRniVbnvtB8aICEEdhd1+y6Qgnqs?=
 =?us-ascii?Q?Y1GN7z+WA7+KmAvfg5KWcBkUbckoUo5NSb7AGELMU98KqIraQSBftah71ITr?=
 =?us-ascii?Q?GeTHB68htRCkxOPdA4W2Te84KgtVKYWjupikKFpOrVyYlPtLBF99uLL2OcWu?=
 =?us-ascii?Q?kC7jUnzS/FeOewMudxo/jf6897ZdBuYa2z1sq2/Wc3roVDjby6T5Tt4aJSU8?=
 =?us-ascii?Q?RQ/vpQSMZF6OSDpI71zeXdxoJYEBvUD5OcYfBX7Q66cIfgiXGEihMfvfc/+/?=
 =?us-ascii?Q?2gWQGtldr1STTA2HZ7glngFGv5/tXQxkhnku1u1Zp5m/psIyH814bWRIp2no?=
 =?us-ascii?Q?39jl4To+XjzVvo52HCkdpFdZX0BNRE0dssy3c5sIDBLdVZ+fEOvGnBcMk4fu?=
 =?us-ascii?Q?j4cVGPUvhKzrj87I9FsK22XnmFINJZ2yE4Sp3oyCvbK2Cm9dO+7KUghNUIGD?=
 =?us-ascii?Q?0sxgL4ps6PdNas05TFG8KOUELPbvlNoXKleufeZNu5oxxyJ/uXEzSM7ZjxgB?=
 =?us-ascii?Q?GLpRKvhY2Bv/ddfHuXZ1hruuTanb+Ha2bLSL5jZ84HhU+VDm2vEaFHUi+Wj1?=
 =?us-ascii?Q?RcZe5BEvnmmZ9vbr3wEk7Ql+deMVUefXDGILB44ClsOYZR7WdGMwsngso875?=
 =?us-ascii?Q?JY2GfgfYu7uCR7lUQ6v+nfFp+eHaOwNCr1rscnVaB3GR1OBlrw7UAi9i0Yuq?=
 =?us-ascii?Q?xKsqSZgnXQKSJE9zEiOMLoVWQQScbM4tLgyFN+uYMyp6w0n5JH30WjT4HXEj?=
 =?us-ascii?Q?YSeu8a77KknSKXka+kpOuyJafQvP3dxVPQS6PYZ/9QouYCw6p8a8DxUxoy5r?=
 =?us-ascii?Q?JrHymnLojVCH2pM+vhzs7wX2O6fcVpI+XBNjJH0c7g8gKnw+OJQ16wEzh6Pe?=
 =?us-ascii?Q?mFFa7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(7416014)(376014)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:33:20.7503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9863143-3882-4c40-5834-08de57aabfe2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7942

Hi Will,

> On Mon, Dec 15, 2025 at 09:56:04AM +0000, Yeoreum Yun wrote:
> > Hi,
> >
> > > On Sun, 14 Dec 2025 11:22:48 +0000,
> > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > >
> > > > Apply the FEAT_LSUI instruction to emulate the deprecated swpX
> > > > instruction, so that toggling of the PSTATE.PAN bit can be removed when
> > > > LSUI-related instructions are used.
> > > >
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > >
> > > It really begs the question: what are the odds of ever seeing a CPU
> > > that implements both LSUI and AArch32?
> > >
> > > This seems extremely unlikely to me.
> >
> > Well, I'm not sure how many CPU will have
> > both ID_AA64PFR0_EL1.EL0 bit as 0b0010 and FEAT_LSUI
> > (except FVP currently) -- at least the CPU what I saw,
> > most of them set ID_AA64PFR0_EL1.EL0 as 0b0010.
>
> Just to make sure I understand you, you're saying that you have seen
> a real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?
>
> > If you this seems useless, I don't have any strong comments
> > whether drop patches related to deprecated swp instruction parts
> > (patch 8-9 only) or not.
> > (But, I hope to pass this decision to maintaining perspective...)
>
> I think it depends on whether or not the hardware exists. Marc thinks
> that it's extremely unlikely whereas you appear to have seen some (but
> please confirm).
>

What I meant was not a 32-bit CPU with LSUI, but a CPU that supports
32-bit EL0 compatibility (i.e. ID_AA64PFR0_EL1.EL0 = 0b0010).
My point was that if CPUs implementing LSUI do appear, most of them will likely
continue to support the existing 32-bit EL0 compatibility that
the majority of current CPUs already have.

For that reason, I think it also makes sense to apply LSUI to SWPx emulation.
That said, since there are currently no real CPUs that actually implement LSUI,
it is hard to say that this is particularly useful right now.
I do not have a strong opinion on whether this patch should be applied or
dropped at this point.
Personally, given that most CPUs released so far support 32-bit compatibility,
I expect that future CPUs with LSUI will also retain 32-bit compatibility.
However, it is difficult to say with certainty which approach
is correct at this time.

I would therefore like to defer the final decision on this to the maintainers

Am I missing something?

--
Sincerely,
Yeoreum Yun

