Return-Path: <linux-kselftest+bounces-45114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CEEC40B40
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CCB1895A5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149531B805;
	Fri,  7 Nov 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jErWXv4G";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jErWXv4G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76128312F;
	Fri,  7 Nov 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531070; cv=fail; b=X5VM/KXL+NCSZzYQQdElUemsHRQZY1oDTdyTw87+bUHWYF6ZIQYstR8JmWHVxzeDt3kl/lb6BnGTqzjEzExZzaIYfPNhQgkIRe/4La4CHVJsSKc8u+1OpcYjsAos8iLL2EHm/KKeYAUxB0Ctu/HPqXTmqvZSz9JeFx6maaprj+c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531070; c=relaxed/simple;
	bh=IKrH7to0oY0kkPyg06IaLnBJegsmiiKUsa4OPuXeor8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9/dtJPRmsVsmrTcPyY0lQpU76cJZ5zZNIDYuckVxUk7WdvDBiF6iAxo2kRnF8jJVSA9MGXGT7mhIFOO8V7ts4XHuvsoikfBum1x14/0AQVFTm3y75go4eCPOWpoBmBm+t+GOg8OUyDqezCgRU3hkSZGkILAsH9e15NDKHlOj2c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jErWXv4G; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jErWXv4G; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HSh8koFcw0AYW/c3yMqE8HaOdy8RkW/6NAgee7TrhseD7gXBbc4QSyY8QPIAE3GhwRNWijxQCjnILtMINmDDntZ5UILEh801Ajkty/tqW17RFKs7mLxw4wy3ENjdUNcAyJNAaOVwiMwVf6iDScw+ag8jUqfWyTiW7HA6FIenDo+YweLFTyhrmbEnfjMtY9zQxVsehSLUUIrcTIvDTK49oop53yLCnXyJpeCNFk6MeiVIov/Z1fepiY8CxzC2Gj93CpcFNl4uBJly2rOpDldWZ4oWzVlDrI0QOXlAA5fVS/1qjkLVDrh8xuc1q4PuiAKxcLNoPQnCDICWuyDSMkV/sQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKrH7to0oY0kkPyg06IaLnBJegsmiiKUsa4OPuXeor8=;
 b=FP75BBydGwB+RxeZfcpspO5oPGEw8AHmxp/ZZyulE2GV06vM0eSWCrgWJL1M8YdtuoN39NvHi/LVJKB+cW4fLGiroLeEuBN8BOi0/iKZUffwFBWI/kN/KJn4l7zk1E8fJx9pkFyGNWEH+FE1nehsQ36Rmqo34uDslpmS4hUbIWym5gXM8eSz9yOLam4caHPur0BOzd8k09uck4pAUCpVf7+EbgENIDxWPMLV2OINljnldVWTvBSoNKirJn2NAhBZv4/SC1uEve/e5qwuCVI1eV5Nc4cZQj9NS6W9SVaKT8V1yAsopicYmuXas8frYSPEKX0JTXUyDiKhXUV3pAgGWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=arndb.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKrH7to0oY0kkPyg06IaLnBJegsmiiKUsa4OPuXeor8=;
 b=jErWXv4G2jb6Fs+6jBtenZ0O9irbNuDiPDJbHhzW5heiNbACP9gqrnCZrkNVmDOiQ5bkVWXgSZFZCxcWBMQbkcwk8qmylpu98iM6IRTF5OWhf9Fa5n2vDd9dGC6w581O/f8ca3PAClRfvB42UaT0VO35YpLYASo1vEbHd9iKJ3o=
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by VE1PR08MB5632.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:57:41 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::c0) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 15:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Fri, 7 Nov 2025 15:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrHzIoV+DjWFYBRJRehg5LOu4N4D/5j2vklhOgOPZCCzvDCL5DmV5ZgOTz4CC9LMLr+QDaIuZITgYa+enotE3MgqIYvpEqBf761mQcdn7yIZOawTr05Wif0kud9oNGYWEnvd1i66VZitIzH7Qkk13boP/UM/uKw3nksPQpTyjxAPpgiVV0/Q33diF1Wlz5BJsQtR79TfLW1hg8X2XVohJpn2VlD2KBNKNAipGDRUVWH4t5oGSQ0fDy5MO6oYST6vFvD+FeJlenc9+dp51aoyEYIImVw08PtET2uxCaPe4FLLCz9jtn+LZbxNvXgvH8c2OOkDqy0cI8EQhGAnID7GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKrH7to0oY0kkPyg06IaLnBJegsmiiKUsa4OPuXeor8=;
 b=D4XDfUhnu67O4pmXx366aj2e9WBShMiefFoVUAaSAxJrez5z3bIJ1xaJ7DF/mR+/8kRvOIHcG98t6CUuFAtjVOvrbncYwdKwFtf7NvcSvpZ4FmwVSPHxewtHJ53qO/coaqxZ34j1uRsbDMlKOU3ztpp5Fp1fbv0osVe7mTqwHQZqtlzZtuxCfwzNx5xTTZZfz5mepFr2l61c3L3nYHXtwD8QOa4brXMVEc/mEMfvkWfafHMUdF3pSUYZSCNja21JiSlYDF1FWFe4ZRV4h7gUekUtjgpYavuuXmLPKNUozN1LNC2Ugl9O03Hy9smEqcDGyR8IPCXloXoU71esDk1wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKrH7to0oY0kkPyg06IaLnBJegsmiiKUsa4OPuXeor8=;
 b=jErWXv4G2jb6Fs+6jBtenZ0O9irbNuDiPDJbHhzW5heiNbACP9gqrnCZrkNVmDOiQ5bkVWXgSZFZCxcWBMQbkcwk8qmylpu98iM6IRTF5OWhf9Fa5n2vDd9dGC6w581O/f8ca3PAClRfvB42UaT0VO35YpLYASo1vEbHd9iKJ3o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB10035.eurprd08.prod.outlook.com
 (2603:10a6:20b:64a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:57:07 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:57:07 +0000
Date: Fri, 7 Nov 2025 15:57:03 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, miko.lenczewski@arm.com,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for
 swpX emulation.
Message-ID: <aQ4WzxQl+aVJcBaL@e129823.arm.com>
References: <20251106094023.1371246-1-yeoreum.yun@arm.com>
 <20251106094023.1371246-10-yeoreum.yun@arm.com>
 <9fffb30d-fc9c-4e2e-94d2-c724e81ae3ac@app.fastmail.com>
 <aQ3/35146HkAqM+I@e129823.arm.com>
 <a9f4eb49-b06e-4941-a75a-df39f5d3d735@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f4eb49-b06e-4941-a75a-df39f5d3d735@app.fastmail.com>
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB10035:EE_|DU2PEPF00028D0B:EE_|VE1PR08MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: efd13ccd-4d17-4ec9-1d40-08de1e1660a7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?PokT5LqmEU+Qc51TXVKBhCi8/FgEEoTwXxmxELFUeUQhn5HLxrmGf06o3BJr?=
 =?us-ascii?Q?CCGKjSlwiZwcwWhf07SXtVJZoD/aqDsmnDrWbUENd1MzbbF0Ozmawgh2JYgr?=
 =?us-ascii?Q?8VLQ3vsNyXDdYKyF+0ZgDNvqLuc1L9LIqPt5Ee4MgjLVhC3YLg1mA194mQ8y?=
 =?us-ascii?Q?uymAy27K7XuT9OTb9DZbD/HKkW1MJh4Ztdm2KNqst1h/rOeyj3YfueZzHxkM?=
 =?us-ascii?Q?KHdPhOYQNlHxw+oBKYkDnQ/vsTLndV9UyHBl5S/fW5wlM1yWKg5mdpWPgEM0?=
 =?us-ascii?Q?Fs/uwoWllxQv/qpyEWJakg7kuvxGuMP5FCMNQC0FqYMVUPMwRYI/65OblCYH?=
 =?us-ascii?Q?6HCt2e3mgY6FS1Jg25NxqxRywMfIplFmlrJcaT2HR9GfbC5YxkW78BuK7lys?=
 =?us-ascii?Q?Q17YCkNq/BDkNssi4e33qbrIKDmAQkxrn+FkUu8RNqH2spX7Cu7hM4RNS0yE?=
 =?us-ascii?Q?C3ugzRLr/y3XxkrTBUZwh7q4/hdmZTz1sOg5v4duTUTUbhg5uNrD/ImwsxRV?=
 =?us-ascii?Q?VfNJO+j4t4CQk1fHHAYAwslG37asFccMKBleu1gcC6jm/61Q5/NzcSi/62S9?=
 =?us-ascii?Q?EPLAnN+J2CcDpAU86m2RBtm2zJFmA6Qaa0QPhAt4vGPycplzT7KM4nwR4hyl?=
 =?us-ascii?Q?OtpcctwbZGeqtYgXCM7F1Z9XLSsiM9iHg569N8OwmFtZnQyDNqrN3zBJEbeH?=
 =?us-ascii?Q?37vnXh/k5T+dRRCEqG6b2xAURv4yi+0DoDF2+07T8yhCM8/xkX18dGj9Mslh?=
 =?us-ascii?Q?f04Lpz4aO5pkcBt3nqytgmkVGDNZRJPDY/cNKw7y9yzMFEa0fHzWQ/o/Kfqr?=
 =?us-ascii?Q?VcXhfkgbXC/kW361QM9Pb3Vi07t/KBr58GwG0soKZg16+ioPsIjJCKL7iJU4?=
 =?us-ascii?Q?rUbQrdnlT5yVUC+YzVkOaA+kJFiyu7AbadWD2m7B4yh8PDTqXh39GC5UerKh?=
 =?us-ascii?Q?+pSYZcBYew8/CWgopa7IPwCuXoYz7ANBlaaHz8+7kpMGNYJ1VJ0qg/84GupT?=
 =?us-ascii?Q?7Gcj28X52JBeYcgebMioJBlTDZFghSwZDscvR8a5L8prTAfZHbpScGTQ1tFF?=
 =?us-ascii?Q?PRgp/kWtocecGxdV0wAiTDj4prL9KtDPNf2oSyIY+wx8A1+JhZiQ8tCjL6se?=
 =?us-ascii?Q?rXE66l7P9344P6FKu14ZGrH1vdqQ6Cr1It0VAjzr9ycXVo2x/Ik8h0gTiA+W?=
 =?us-ascii?Q?04gt92fUji4El7bneJowWFCnd3sRVxnFXAsu0YGH+DXUQaG3tWZOsn+Frm9n?=
 =?us-ascii?Q?MEbcaOOUJvTq9CjbAtrRD0i5HiDU8nggmbv3/USsjnNxivM1da+Olc9Bfsvi?=
 =?us-ascii?Q?EN98TasgcDIY4jFv8lDIgAv3d7F1vausW/suXKlx/hyGQj9ZxtWXZDHMpzJc?=
 =?us-ascii?Q?Dzuv02wyj10FMH5aWQz68XY19IueZ3zRT2+tBboGkvsmwcBZ8PiHx0JmG9d6?=
 =?us-ascii?Q?CZAJDLPszua4S0aBVjEkNMv5EwRALJ7x?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10035
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5bc242c5-98d6-4c54-64b4-08de1e164d3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|7416014|376014|14060799003|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBqEZSU75KcnuXXcieOEMFNvsozPWM6JZM7jf0+J1KOIzhQr0OOCmt7rJaX/?=
 =?us-ascii?Q?3/1iBh/spMRU+z3vsQRKcbadgMDtDXke5MlAogqm7izGOmsT5/PUngOlNCpM?=
 =?us-ascii?Q?s34p3Nr3dYgDC8ViFq1FRCwmmR07zcDYFuyhaq0SGb6aQhZ1Ooaj0PZYA8Uq?=
 =?us-ascii?Q?Rl0QdAEFbLR5qDJ/U46YUytkvaNawlW1aVda7A69HhPREhONcc4gsBGyy/vB?=
 =?us-ascii?Q?oacJYuLIzO3OBLRkJK0tuyAbU4npA3U4QDUC2C6R2z4V7gTouTeSO+ybrsGi?=
 =?us-ascii?Q?KiCYZSxvtMAvOHZGUCPZQcXb8jOt6wYkATWHJ+fs1y/RU/SQ331I5goWPicO?=
 =?us-ascii?Q?+IV2AAag/fuZN4XAL0G5xhvzvX1V3hunp+ykZWQYYzdUW8dCFV+thMxAHsrP?=
 =?us-ascii?Q?JeVfsmYuroXXgQVyCsEGHfZzS1HGOR3+SjmP5qCXfHQCqrt/llPJTH5+jM7N?=
 =?us-ascii?Q?Fa5nOH0USZkRd4V1+fo7ER6BJ6rIqWPQizCw9favdmQg9fUBJ5y5T8mIwEZU?=
 =?us-ascii?Q?gllOMSg+Dmhc7EFIjggaOv5c4p9ErvgjsVKaVgQBSwfjhlDI5U40pL9Nzfr7?=
 =?us-ascii?Q?CIGbSJ714aJ2OoHKyNRnz6ecv1FZoXU4OnPV054xEcooNY6seDcUSTUh2J4L?=
 =?us-ascii?Q?S+KPrboT8R1PbdAsjVaEnUaBxTrcbCzt7Md1TS1TVfxxvR9WcGGz78moWyBa?=
 =?us-ascii?Q?0kQiC07zGEyzij7Yw5PJ8TXPbegvhelLQ+xpXNji/Sh2ePdpR8JrmiAYjkfo?=
 =?us-ascii?Q?E3f0eSir0pKRMhBqgtMyfZt7F6wAh3vaGRt8XE8lpR8js02OzzGDLvckAjym?=
 =?us-ascii?Q?dfzzVkS0t+IgtrMVVmj27CQjFoaffI8+P9Iiugo7jryOV9CFU42cMaS10y8t?=
 =?us-ascii?Q?rkPtmn0Rj6gPxbgWzUgySKe2ftmxcFClsdyPSjNsdyDaGO29skIvHjvSO1Cp?=
 =?us-ascii?Q?xIyi932jlqnFTwDdCdj7iia91KFd8U4J6+FgySdLHkgCRVKQnKHtrVujsdj8?=
 =?us-ascii?Q?chTwqMspwP+Dc3iCwOJ/yhzImv3bol2ZP+4rT4xrVYFP1YnwWpHsk201pMZZ?=
 =?us-ascii?Q?XN0xAjniTAhLQZ3pr8Z/hd1kGvHDkWnk6rDqqqHHun8UjOzoPC61odexx5+O?=
 =?us-ascii?Q?GmqJXQrHLSd9PTulKhWos4ZvInejYdwFGdklPJeGEHzuGQLATNhu/LbQdEm1?=
 =?us-ascii?Q?CdqH9HlXzRnXqSHXNx+sHQZTig5JVTn1R6EZ4yX6kXJLk+Fyr9tybI0CC7+2?=
 =?us-ascii?Q?ivnI+2wajzb1RM9oJcrwqfW5SeZO8Pv0vSkfsUGyfCNlcSV5GPnBfnwlSMr9?=
 =?us-ascii?Q?VfkeBbxea3NVL0HuCMsIJ/LhhNZB31ZnZvo4w+nFhQ+YEQoRlNE1Z9Thz+Cw?=
 =?us-ascii?Q?ten4R9/9g1+uFSjopVEXQI70M26g5e5E5ojRR8BhKDl6Yd986ulvHhX5aJdo?=
 =?us-ascii?Q?hVmeQ/26+dizBnlL4kYIj3pPU6RvEWnq7JXStq7bLmrVIFRic4tw36IiFx26?=
 =?us-ascii?Q?zZFB8+RmB57lCJg+dlE+jo9tNkAEhCXWloUlr6J3Q3Y4IwyK96Tkpslg/6dt?=
 =?us-ascii?Q?KhQ+1bCBF+ARBYg20ew=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(7416014)(376014)(14060799003)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:57:39.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd13ccd-4d17-4ec9-1d40-08de1e1660a7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5632

Hi Arnd,

> >> > apply FEAT_LSUI instruction to emulate deprecated swpX instruction.
> >>
> >> Can you explain in the changrelog why you do this?
> >>
> >> In particular, is this a performance optimization or is this required
> >> for correctness in some scenario?
> >
> > I think the main purpose using for this is to "remove the toggling the
> > PSTATE.PAN" bit. so that remove some *potential* problem which can
> > happen when PAN bit is cleared.
>
> Ok, I see. This should definitely be part of the commit
> log for the patch in addition to the cover letter.

Thanks. I'll add detail in next spin after receving other comments.

[...]

--
Sincerely,
Yeoreum Yun

