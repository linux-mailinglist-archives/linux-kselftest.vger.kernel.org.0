Return-Path: <linux-kselftest+bounces-49425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361DD3BAC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 23:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C7A33033732
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD52FDC4D;
	Mon, 19 Jan 2026 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FBi/7Tx3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FBi/7Tx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6C2FC881;
	Mon, 19 Jan 2026 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861236; cv=fail; b=ZjqqSwbisymdoJ5DX9W+EJMeXcVGY4LGcfLBWHrT4xIhQ+nGK3kuLcpV9qOD+YQrUNlEs41m5IVuJ3VBH3mnZSiAfSc7DZ+OsXlOTpJW8zG9H6lCclKAFxABhcBCbTMs/E/u0VFTgY9YIqmd+BSRIYgkTC22PHxxDtWi4jRSOpc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861236; c=relaxed/simple;
	bh=3T1aBMiCtvDA0PpV3V3OFtA+bIj0iz871a75ZJK5S5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQBagUEcjeAvcVhMPSl8GM4AM7ZR9gHAYVRol1wbYUGbUCsqpAy7FTz8xyrjMeTJSUo2ZCWtYbsdpL7QmUVioFjrYDVbDZFoma6L/UMAFL1R6SFkelGFlDfnAQaSb8vD4LY9DzS/e8ornp+5MCW/qhdFdJ9VSKKEU60OOZ9VhXo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FBi/7Tx3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FBi/7Tx3; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M2j6PF+NVW9oR9pOol895X+JgxvuL6ljcX5RAXmLOKxEaSfXFsSLoZB8BEp5gK8BiD09IYhuksZ/4iirzS2Q2Vex9RtIbBLNmG80in265ns6+F0KPhsW2mmPLoFjWLRUJqr1UQC4q408brc5OJWzBmqkjTkA5w2ap+sGl+kpZQ+K1r3h0w+m968wNN9GSMiUlcAhZk0SrZOt64MaQO5eDTJuDjfTF/ZdCz1YqueMIlEjoGFeYUoM6ANFixFt+6RaM474Ox0bKnjM1hyekqhOdDawvsAvuXbxr2LcWJTN5/aRW8xvYmbcQAZLOzT8307KUlyejjVCVMQS/cUNWNcp1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KA+3fu8I5gYBJyyZisTeaGj0xhTVYQI+TVW+ktPpgg=;
 b=AatauQCXs0O77UlKL9Fh1Wwny071jHKEVuvyxIlSaXQfaHXZbEpyQhJLYtOnaPNlgibUSnxDvne69xPZn5iE4y5Q/KdXtGY/TUmK7TgT/0HSum9VGP/GyxLrvyKdN3NCfQVNN/pU2O097Gh506K2mna5AQJX/kiRFkV20xMv0IFeGQzEU7VNEQlF40yElMQnuJG9db50J8WXTSVhuEpgnAnaxPWgTeUJqy0bD+5FpIpgS3KRjgxQBlQaF9kWvRWnb8mFLENJsmQP+OwQObPgkqzqOUpW4bwtogxVETeOksDRl9vmoY1244ysVZe928Hpku645jrCoMPEgTbnJZCykQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KA+3fu8I5gYBJyyZisTeaGj0xhTVYQI+TVW+ktPpgg=;
 b=FBi/7Tx3yEPjeVYpaAL7tc3dHc0QaqJhrefbRfOiB6sPiZMcJRlSMMN/OGbSy1yw/Eb9pnhi9A7P/9A0aA9QJoZs3VDqpqC0eEw645eb01VXVT20yZ9V+IjouuebKTTN7UTrkoKiWUm7FXPRTTvFA7SQsdCJKxncl5NSR7s7sbY=
Received: from DB9PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:10:1d9::9)
 by AM8PR08MB5809.eurprd08.prod.outlook.com (2603:10a6:20b:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 22:20:30 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::f2) by DB9PR02CA0004.outlook.office365.com
 (2603:10a6:10:1d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 22:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 22:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlx45XKzvMOCPHr1X4o1hd+3bQlNOs9j19wKX7kw/zea0AKHPl2TqHntV1Rg8NZ2yYCnScekQEoeJl6HVs1b8tMDyxjnERNwa9Ym6c6Gwh2aluI9RKdeOAaOpaITBRhF1AN/YAshxqrUVs4d5G6/B6UCZKhezYVq7YF+pc+D3OR8oO0AErNIDzpoNTmxKKuBrNiM1xaTbjVOJXO4dqnZj2JDK8FgFSKoBCGev88CVc/Il5LHGk+Nrj/JQYAWoFCaikZj4fz2yXoV5glbVIK+tH542R8T5q197sR7/AA4AhOGGNsTujjS8OBgqBOBwaoEq3X5g8+QxiTVJN2FRUETAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KA+3fu8I5gYBJyyZisTeaGj0xhTVYQI+TVW+ktPpgg=;
 b=AVZ4AoLJxaLfHb1KiKeZVRnWrMjZxV/Do2dF77aLjVVw7FW9/jeXtbuUhjtcgnM3l4QB+Slbti40482Wv4lZoc1wnRVdiwLgaOWENz+vV8fEWUJQwQIvxGJ7NB38LfLycEYw1buXLaoDD+7K/0VBQI9L0topUKcXGZYcMidNKOGd11r5ii1bpV/em4kz+at8BfXoSuPv250j0UIiaeOySJv9firklJ2dp83coRf1jOV1qTCDw3mrLlkFIYrEt+K1Pseh1XGa2+Waw4+EvY0voRA4DEBONX8vNy0NPliDCb4wHbCBBB00Pn4xmPQYE85HB4rnuMTH7KI9k5mgWpwz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KA+3fu8I5gYBJyyZisTeaGj0xhTVYQI+TVW+ktPpgg=;
 b=FBi/7Tx3yEPjeVYpaAL7tc3dHc0QaqJhrefbRfOiB6sPiZMcJRlSMMN/OGbSy1yw/Eb9pnhi9A7P/9A0aA9QJoZs3VDqpqC0eEw645eb01VXVT20yZ9V+IjouuebKTTN7UTrkoKiWUm7FXPRTTvFA7SQsdCJKxncl5NSR7s7sbY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAXPR08MB6687.eurprd08.prod.outlook.com
 (2603:10a6:102:132::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:19:27 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 22:19:27 +0000
Date: Mon, 19 Jan 2026 22:19:24 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, maz@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 5/9] arm64: futex: refactor futex atomic
 operation
Message-ID: <aW6t7EzWLig2AN3g@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-6-yeoreum.yun@arm.com>
 <aW5UXFz-TykfkGpV@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5UXFz-TykfkGpV@willie-the-truck>
X-ClientProxiedBy: LO4P123CA0486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAXPR08MB6687:EE_|DB1PEPF000509EE:EE_|AM8PR08MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8c0296-f646-484d-b963-08de57a8f468
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?QNX82MsdUy2pn9ZmYLwu0CiqjHcJ3BN/S8cEBsi06rEHd1MZARv3Hg21uWgY?=
 =?us-ascii?Q?rJsh4qAl1ghHpB8yL0yEo65LDiJquXqnInJ6kWe4NUZ1ILeIuFuqZ8Fj8NNA?=
 =?us-ascii?Q?RLGTRcsp652q7pmvlrTvdP1pSKq19glCUf+YANu3dhjeVo33PMHVIXUVE8Ss?=
 =?us-ascii?Q?fk0E40/XkdUueALlVuNG2go97oYin9t3MjsFy4+QilWxfY/I8ViqE11ZPI2W?=
 =?us-ascii?Q?iETvL9FKwM8DvKNYmyCB/aSb85OBESKUtva1eESOyOgSapCMQ7xgIRxPplgg?=
 =?us-ascii?Q?e8QxR1T1oiylnRiFtEDJ6vrVNlUMEG3xRv6vXlcaOLA/OquNvYqcTnglgkkt?=
 =?us-ascii?Q?7myHTEWDp6ThgqkoTAMbWamiDyu2KngQ57H3gm6wOo65E76cc1GXfrRAIR5L?=
 =?us-ascii?Q?K2Ezt3kVtyPiABEy5s/LJUOxHsKlr9QfYz6SKN/77uXYUR/jdcUZeyKLiSG+?=
 =?us-ascii?Q?bpt6Tgvv+sqGFOoSqMoutzMUdwpHV0ueeH58OkQ6n9EvIrRVdW/Bpi4OC7J5?=
 =?us-ascii?Q?0znjCmhP0GbDSs6TM8HcHI7DJmQNbC7nwFQMzXu3/SteBCf3dV1qZ6U//SQJ?=
 =?us-ascii?Q?MRgVRg1wSLvrpB+hqPYzvCC9yW1ZCnbc0R1im+D9+ttr4FiKC2TifXVttaFw?=
 =?us-ascii?Q?XMrtfuJoHjb6hdpaqPugjYkUzl6zoe1x3r4g1hBErEb/laqINDZcl8ukQBBM?=
 =?us-ascii?Q?5H/JBEeghNniDHuOgwfPfmQD+jOaC4kg7NSoLLGU3xjCovAwK9wB8UTYTIja?=
 =?us-ascii?Q?FHNCUmFIl4EBW92BumrNu2Qf8R4cxeMTx6Gry8pvnmFE7wXa0qKJ7MGafuiq?=
 =?us-ascii?Q?D/8OltXROP6Fzxv8tEmkwp+htkDur/XyBYqX8uobVtRlgy5OGEkmND0KrIDu?=
 =?us-ascii?Q?T6oXmxIZ6A5Z2dS8kuzKuNpmW52rV3chJBEhvghGgdRzvvpfTSrGnEQLYobm?=
 =?us-ascii?Q?4PvbZ1Lzni5JWjgmuUJb1GM3gPAQRFYFILmope90cQ9JuBngUe7zOcP2rmyx?=
 =?us-ascii?Q?Rt++7Ub7vys6xqYWWV9xxOs5obBAm4sccSCsbL7KUK04BMxCbzBZidLh+kz4?=
 =?us-ascii?Q?Gh6m0w0RIvfu+HoVfbZB66pDOCeCmvhBlDE/dqblVDd77/g5EI8goedZ59D+?=
 =?us-ascii?Q?Lc4T7rWgrB75rM7NixoYC5HNqXjPJo1jdEtmMNK9inJxCtpRDgPYhgisbdBi?=
 =?us-ascii?Q?3iJr4XtpZ3JXbA7p3OXSg/oJxHz/guQEw7cZzoO5u0kv7gjkCSpClK5rpMG1?=
 =?us-ascii?Q?aU6gZWuZS62IiaUI/6SxxxjeCAuNb0eS5ihrFt+V7OigpFOKOck1f3KC+j/0?=
 =?us-ascii?Q?3XSwp7Hyv+fe5FsivMMgQXkgIyjLtgSar2LO/tv/JrbBFTiHpU2+Z7qjS0vI?=
 =?us-ascii?Q?sWt+lSkh4KfmwhyF+18mMODPKx495lozaT+2OEUSU+6YjLF3CgJ5jKPgt5fN?=
 =?us-ascii?Q?HCV/3tKYA+PkFdUA9LPjhxt/0mun03O9r1gEtpuQPLV7ycI0fFM1C9VKY7pD?=
 =?us-ascii?Q?cKclTCH3gE04T/uxFEvFxwvjh8jxn5op4AzIL6+Bt8F//3pQqLaFAMLjiQjg?=
 =?us-ascii?Q?6NKV/DcVRUJQkkRjLEo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6687
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8017bab8-28f8-4244-b6ec-08de57a8cf02
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|7416014|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yC9PW3vLOLN25rCrtPwbZbrwrWyBv/ScLdA3uF+Lf8YEDUmjBgxtHxi7HIxC?=
 =?us-ascii?Q?6V8W1tR6fbV7uZYzQrSg/0AnY9kl9ISMWf+SsgMsqJhpelftkl+5EL9+QFYr?=
 =?us-ascii?Q?fuGW1ZOd+9fuTvxr4vnHGPNENb/XxphWAALcALrl0zBuTP4sO+0vaBZmk04X?=
 =?us-ascii?Q?al9fWKlxcqOGTG+YKa6SoH3o4SndV4OnJ5U9b4PCV2vuj2+QSk+R+ei7SA0Z?=
 =?us-ascii?Q?PrKpwlZznaL7DYcd55JFcV/vWpGsGYMIAbu+lK2EOYipvBWtXkv78U7uFUdi?=
 =?us-ascii?Q?lU4WUbrWgCSdwv+wFnDllWihs1qsmZ4Yy+IHU+5edzF9Du0IS5d+hXHhIad1?=
 =?us-ascii?Q?TfM5aej6pPa/g0pL1/v9HI97jrbOH9rLdFhZqV9fcQPCG85G7SQpf0RNqG/Z?=
 =?us-ascii?Q?NxVDawDv3U1KydFl4CFAGqU1lBTOkpc0Icm+IsnDMmm69ZUjLDVjAPBdkgtS?=
 =?us-ascii?Q?VZ3knU8mIasj9o1brleq380JN2I+IdblwNs78rnCbroLiSLa+hfskcAmMOJA?=
 =?us-ascii?Q?3YJsWdroMKZmSv085TZo6QpGvQj28ifflTxF//mSvvV2iWkLGxLIVIM3QcRG?=
 =?us-ascii?Q?tOmFGat3VoI0S9STFUwWUuDB0iCzvi/slaCyi0mb6gLcUe1dFJDtiHOKfUlh?=
 =?us-ascii?Q?XCeuMXJUiBJNlxGs98FsEzwKNSTGqOvYKgQYmUSq+rtBhL8t+SrTTvYllDVx?=
 =?us-ascii?Q?DE/O6ryLT4QOj9vLhZeVe/4ml3JrAQG0Z4T26+BbliU5EWz+Iydy4indUhda?=
 =?us-ascii?Q?64xZGwOdU29r0hG77pm27+IRh6AzO5odFWllACt1a9IxFZEnyOpd9/6RtyRm?=
 =?us-ascii?Q?kLGsv4ex22xwMtm2+xSnuBN1Ya0sTOmzg624V9R7C2tlzBGxhadHa5GTWxeV?=
 =?us-ascii?Q?4o1YZ5HPUy6zzwV7Bvr26TQ/oPEDEp+Gauzt/GnSsqNc9JdZJl2S++jlZw8r?=
 =?us-ascii?Q?kbF74KvBzBQSzD8jdsrchdlQ87gmb2uA2uOxCyTkfgAbxG+c+EEBcqvM1Ul/?=
 =?us-ascii?Q?XE6utg9P9/+rGLHB31K+QR6syrBmxygq+F8O2lXMLIJd6l21Qy2rWQoBqW8u?=
 =?us-ascii?Q?1mL6LGroGaOWu/ajiXTs50HKOiBPPC3gFjQptC1WYvNzlCzjvgmLqJ9xLAb0?=
 =?us-ascii?Q?lca0ElTb7e47rQnUnGaeZz28t5emfW2aEFPfZCRIpCQl7M6VVuoeZgy3fHI1?=
 =?us-ascii?Q?s+8nF30P24+ajQkzvqNdkhPjcENa0z7VOSM6haMOQbubd/BQe1qEyKP7oRm1?=
 =?us-ascii?Q?EcN5yyg/R6W5M359kDc8Tq/NktDrZipdOGiu0uba85DKiSypZpA3/kQkV5+4?=
 =?us-ascii?Q?udldNe8LDKw9DUqVK66NRAlwIRvx+TaYcUKFjNreHzwOxDtz+SsJYIFPldiO?=
 =?us-ascii?Q?M1xE/AgS2gMFf6ThDDCFQ1hLdZUp4rnh74NDQ9SlZ/TWr3/CpvsAe0s8/edt?=
 =?us-ascii?Q?9aN6lTRuj8Q4yOvm1tt4S5lUFVRR/3TGXuC9IjwlivzbaTJB7X+BG2I59QSZ?=
 =?us-ascii?Q?8N7RgmmIl73fXmh1lXzaqFgMUdB/MncZJFPbr6gMGzj0aazy7fe7fha8ckKZ?=
 =?us-ascii?Q?K36x5aDO9Brt/CGyNZyUVN4k2cTGENl4vkbP32eQgrHUZlFTp5jDoY8RkJPB?=
 =?us-ascii?Q?wIxU+J5CDNbGDOXC4NQ1ZODP3Q5JgbAMXYtt+07WrIm9A+bNTUN9Ulz9jzcd?=
 =?us-ascii?Q?2gGGhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(7416014)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:20:29.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8c0296-f646-484d-b963-08de57a8f468
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5809

Hi Will,

> On Sun, Dec 14, 2025 at 11:22:44AM +0000, Yeoreum Yun wrote:
> > Refactor futex atomic operations using ll/sc method with
> > clearing PSTATE.PAN to prepare to apply FEAT_LSUI on them.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/futex.h | 128 +++++++++++++++++++++------------
> >  1 file changed, 82 insertions(+), 46 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> > index bc06691d2062..f8cb674bdb3f 100644
> > --- a/arch/arm64/include/asm/futex.h
> > +++ b/arch/arm64/include/asm/futex.h
> > @@ -7,17 +7,21 @@
> >
> >  #include <linux/futex.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/stringify.h>
> >
> >  #include <asm/errno.h>
> >
> >  #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
> >
> > -#define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
> > -do {									\
> > +#define LLSC_FUTEX_ATOMIC_OP(op, insn)					\
> > +static __always_inline int						\
> > +__llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
> > +{									\
> >  	unsigned int loops = FUTEX_MAX_LOOPS;				\
> > +	int ret, oldval, tmp;						\
> >  									\
> >  	uaccess_enable_privileged();					\
> > -	asm volatile(							\
> > +	asm volatile("// __llsc_futex_atomic_" #op "\n"			\
> >  "	prfm	pstl1strm, %2\n"					\
> >  "1:	ldxr	%w1, %2\n"						\
> >  	insn "\n"							\
> > @@ -35,45 +39,103 @@ do {									\
> >  	: "r" (oparg), "Ir" (-EAGAIN)					\
> >  	: "memory");							\
> >  	uaccess_disable_privileged();					\
> > -} while (0)
> > +									\
> > +	if (!ret)							\
> > +		*oval = oldval;						\
> > +									\
> > +	return ret;							\
> > +}
> > +
> > +LLSC_FUTEX_ATOMIC_OP(add, "add	%w3, %w1, %w5")
> > +LLSC_FUTEX_ATOMIC_OP(or,  "orr	%w3, %w1, %w5")
> > +LLSC_FUTEX_ATOMIC_OP(and, "and	%w3, %w1, %w5")
> > +LLSC_FUTEX_ATOMIC_OP(eor, "eor	%w3, %w1, %w5")
> > +LLSC_FUTEX_ATOMIC_OP(set, "mov	%w3, %w5")
>
> Since you're reworking this code, how about we take the opportunity to
> use named arguments instead of the numbers?

Okay. Let me try this.


--
Sincerely,
Yeoreum Yun

