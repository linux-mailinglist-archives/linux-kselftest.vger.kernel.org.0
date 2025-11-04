Return-Path: <linux-kselftest+bounces-44703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45CC30A7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43793A5194
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403B2DE200;
	Tue,  4 Nov 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fC7/jnbW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fC7/jnbW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AD2D23A4;
	Tue,  4 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254129; cv=fail; b=Acnsi1Y7+lvrxl7fc9gOi2Dwr0VYlhszE2pTu3qfQcK1gz7secfyVToyk1fNbvOMAeTLAwV6dgdFx/p2dM/4xf5B1yl4SMmRfIw/KMn9nGyVCetNSmRUFt7VmgvQbTwuiIU87CsR9gbEz6lxsZD8x2lkp3XDdMqQULlXf3yuRFU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254129; c=relaxed/simple;
	bh=hfouFb+aTE28WN+aaT7zaePoZXCTFUXdIqo0X27pGlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U+f3p+fUDZT0221EwS4ihEUa99BZleXD/C0bnqZbOg1YEFgM22XejKpx9jEgZos22sQWi4Jp0PxxwSrG6Dr47l3BFgdJCVP+0euag039n9bV83l5wNx3Jfxl8G50/kNTgdsYmREoO+8Rldz5a0hf5jIuYjU/s0dMj8nXDm7tyWU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fC7/jnbW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fC7/jnbW; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=J4cSkn98MRCPH5zSORcQL0kapV5qQ3enzQ8EvjikS1A4o55nF2zbkXhprk1izHtNGADVfaNJHcQFJc+PIg/fI/rc59XtPfmDNEdL5qn8f3HPd59TZ841MdRNsMBiPIKzErvwGdtq3cOlvtKRKo07HRh5cUOqAkm6ZkWv0YqN9TG9U+4RJzmwyZKrP3e0+qb51hY7O43uV+BKWIgaYA2dbw5vz6OuD6pyZyetjU/bQiCdujAiMzjf1pLKfVeGKeFam62ky7iTWnSLOXQJtnoZ55DzIQIFCAl4nzFuAgAbkODnTzenor6F1ie5kVG8Q1SnrTezXiKOmVbpMNeT4iLaBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXy2CRqCac3jD0M2IrWU04RYob9IQpJ9VZm1Fo2H63s=;
 b=ByH2LXyVEpoPRwTOkmB3+arNSBhbREbxfzWxbLkxpCnuBTMnHobcZUJI057oKGXgx2uMYbb4inR4RBTT3EynzvHWjtqGqdpK1CLNauJpvqftXBHbQVa0IL4TrQRI44TWPH4Yd+kHIjRAd4taeZ+8QlwYhIzYAP0iX8AWUxqYA0Wk6zRMaME3Os8ZTYj1O8m2Q8r6Y6Hz9ashzihHp1hG1+WKWVYTbnYSJC3Qhvv7KiOHuerQHzfcmwOgzr7VQTtFyIF6G+WskUmcHp8yKccXpYxh4mzXwg/+awoWtOs2nepnhRW1keNSmKnnffoMJEJ2dGfAK8VePItgcbKKEj7YvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXy2CRqCac3jD0M2IrWU04RYob9IQpJ9VZm1Fo2H63s=;
 b=fC7/jnbWh3bAJO0R5eEmRA7kCTeTfXNUOjUpoS6JGvsp+X+uLM7m+x1qTqYInbyYvIujq011TmEWO9Gimah2j3h41z5CA51XgIAdqLdkso4PhLXdSyWHMVYlF8x6jJ+LH3DHYbCy1jKMXfIxSiFFEj+jQwSqZakc8X+sd74wnl0=
Received: from DUZPR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::15) by VE1PR08MB5709.eurprd08.prod.outlook.com
 (2603:10a6:800:1a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 11:02:02 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::ff) by DUZPR01CA0148.outlook.office365.com
 (2603:10a6:10:4bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 11:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6 via
 Frontend Transport; Tue, 4 Nov 2025 11:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU7c282mWOSLrF5SMEM0ULjGtNx+CGNT8ScIbE38jM2Jd4aG/qV6AYu9e8ZcbaESob6gUuIrNmbR2+2hTCd7hj5G/86Bn2KqftNkho6dGP1yyciA0gJhYiudQwCys5mRzdrnXDXOiZNnpQMJoVpEFTAXpGiyMTeOiROT8XfH4pgz+XgGWyzqqinHWumLhmNB7YO2PBIZ4fJdEdzqgWUkE82wchifFkFhTb0UrC7fjVQX5v/tl57nqkSP93SsuLZlKLGNcQIoahBFC/OIYidwd/gwh96LNJ2ByXf/blMVPruJo6d70h+e1/Wu5BhEebgdDYcv/1YothAPytt198S7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXy2CRqCac3jD0M2IrWU04RYob9IQpJ9VZm1Fo2H63s=;
 b=JxSoeYjrBtZr4h8Uf5fryJLB3xKulvo0FrtxlHE4KRxY/LEwrozPVgkin1IHCcZDZPAHM65wYlGdGx2uhLPRmUs3ncxi11xpEl0LxTTmZEnvJFN6mfmSwMDOblw6ZBlnl0lMSRUjdJkN2FZgHbCz9rek9jRLGSY5Qc32p1QOtcyY0Ny9Sx5oolHw78rdfT8NTd81E+ZOu/VKf+77yEYbWegTN+bQD4VhL7QAzkfKyFIIeOKamZNQ7tXV/nhsG1lQqNS7r+H03hDuEmZzerb8ZnEbjVQB92SE/H15hg+xQvACQ6EQ68eubVykllRVnvCmzPErj/29MxgieBsJC7UFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXy2CRqCac3jD0M2IrWU04RYob9IQpJ9VZm1Fo2H63s=;
 b=fC7/jnbWh3bAJO0R5eEmRA7kCTeTfXNUOjUpoS6JGvsp+X+uLM7m+x1qTqYInbyYvIujq011TmEWO9Gimah2j3h41z5CA51XgIAdqLdkso4PhLXdSyWHMVYlF8x6jJ+LH3DHYbCy1jKMXfIxSiFFEj+jQwSqZakc8X+sd74wnl0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB9712.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 11:01:25 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 11:01:25 +0000
Date: Tue, 4 Nov 2025 11:01:22 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	broonie@kernel.org, oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for
 swpX emulation.
Message-ID: <aQndAnoFClKOSer2@e129823.arm.com>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
 <20251103163224.818353-10-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103163224.818353-10-yeoreum.yun@arm.com>
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB9712:EE_|DU6PEPF0000A7E4:EE_|VE1PR08MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b122e83-27cc-422b-2072-08de1b9194c7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MTdJUGxlZVhqcmhwVUt1a0FEVCtwWjkrVjIyTVhRZEVVaTlOV3hTL1R1cjQ0?=
 =?utf-8?B?TFFONHBvdlFPSnpiWDQ4QklqSmFpMzhvL1AyWDQwVFlhUHhmOVZtTnI5S21M?=
 =?utf-8?B?OGk0TlNoNjBGSDg3enA5d2pBNFFXUFJyREVJTVVMRjcyNXZTbGVqbStIYk1Y?=
 =?utf-8?B?SUp3T1RJbFV2QWRtWTM2aE5BQ2FVSUVmOWpoSU80Y3FXeWJoSEFtWWR3RU8z?=
 =?utf-8?B?MEQ3M05wRkxsc3p2eFl5Y3VEdUVYSlJ5Z2ZEQXI5MjVhM2p0QmdDWENVNnEr?=
 =?utf-8?B?UVJLSEdqQzBVZEpXYllNeC9uMU1mdVYzNGVjOGc2bm5sQ2FneVRuUU4wL2Va?=
 =?utf-8?B?bjkrbWdFYkZKZ011a0c2WnVXdlpqYUVvSGt6Nk1hdVpJK1VvaEE4b0d0emN2?=
 =?utf-8?B?TGxCbHdDRG03clRzNHJlMGxDK2Ryck1ycmZNUkdOeDcxeEJzRVh0bjROQ3pP?=
 =?utf-8?B?NXJjU3doSWJRL0cyUWxmL0J2VGg3cVUzbkJJclJROGYwZWs1UVlwU21KWHRq?=
 =?utf-8?B?azI2TGFvOHhqL0IwYWFWUHFPWVFZR0Q5WTBPOFRsVzdPck5ZQ1B4dXl0aVVW?=
 =?utf-8?B?Tm11VGZ4TlVWOWdlWmZFd3dvN1NINXpzZzUveDczVnRuTWIwbVV0cUdLRWh5?=
 =?utf-8?B?THlYQXlVY29GNVcwSzFmMXdkRDBhM042VmpKRmVHZHpHNHJ2N0txQnVwSjFx?=
 =?utf-8?B?SStDUUpuM1k0TC9yY2lJODRYTlgvZVA2V3hNNGFRWGhFYW93bktyL3MvQXgv?=
 =?utf-8?B?cldLT2h6MFJVSjZ5aUJPT01ieHZmeWVxNklQMGhlckhtditRQ3FzU21EdEE5?=
 =?utf-8?B?NExCQWZ2cmJmUUVkRlJvaDd1c3lUelhMT1IxTG8vVUlSclA0c25zbWF5TE1O?=
 =?utf-8?B?WlFxSThJeDZOSW4vZjdCMnh2b3RIZ0s0RHFSNkxMMTVPYnZqTitVdmJ6M0Rz?=
 =?utf-8?B?Rlo4ZExiK1ZjeGYvZVY2WHFCU1Jva21qbG9MZFkrNC9DOTBPbzJDa2RzaTht?=
 =?utf-8?B?c3dpaGRuNjU1dUIwdWNnNDlCaHdsWkJQWkUyMW9Sbkxib0MrN3k2aG1BcVNw?=
 =?utf-8?B?RUFESFJZMXphSkNRT0lHV2tjcS9leFNnSlZGRlExbGZKNzUvRnp2UVdsRFdy?=
 =?utf-8?B?MEVHVnZ0QUhnSlJBSTM5TldIYzcveGx5VmNiemdUb3BGNXladTN2Z0k2Z0lq?=
 =?utf-8?B?ZkNCVlQyZzJLRWxaNjYyN1JmOUQ2Zk9wbnYxZ2NGWXFTMFQzRm1uZjFENjBW?=
 =?utf-8?B?WGJVSEw4R1ZtNUpZc3I5d3g4ancvQWpyZHFIY2xoNHdSMUtQSHhsT3NqVTU1?=
 =?utf-8?B?aEVEcUFIUlkza29XbkJnckg2SGduVU5DZTdha3c5L0o1NTViRUxQWkNHOGVk?=
 =?utf-8?B?bXNCK21xRVV5SGxHeXpOd0R3eXp2WUdzY3pOZTRJQWsrRStXYnlCaWRsOFdG?=
 =?utf-8?B?eFp2bW1zNXNEWldtOVk5WVhlR2lORlN0UnYxYmgvSDVhd1VxZjBlUUdqUFQr?=
 =?utf-8?B?SmEwZVJDeno1U0ZkOTFEend1Rjk2WU9nclF1MzNPMkhPKzJaOFJQTEtFMG1Y?=
 =?utf-8?B?WGlqVkFoY0wyQlZ2Y2ljZnMzVlZ1bExRTHpieXk5dVNaK2JrT3R0RmkwQlpM?=
 =?utf-8?B?ejlKUTIvQVU4cUFqY1pxeWhvZmVxZnJ2R05SNlZQTWMzcWU5cGVpREZMTHo1?=
 =?utf-8?B?MFJ1c0dWemQwemtpWnBaSjZKNGR0Y3krdHAxS0VpZVA3SFJsL3BqVk5xQVVL?=
 =?utf-8?B?WjNieG1VNVQ2VHA3MkNPbC96ODl6cnBhemZRamxEK1VVRTlmTEF0Q2tsMXo4?=
 =?utf-8?B?by95eHE3alBxNVdnZmVOM0ttclBpUmNIZTdEN2lrakJ5OER0Ujg3d1ZDOXh1?=
 =?utf-8?B?T2lZUk1JWXlyWHJRcEVnb2tDVGhRR0lNbFp0VXRXd3BtUG02bnFxSEkwRnpz?=
 =?utf-8?B?SG41RjNZQkVhS0x1RERQWnAvdStGYnRQa2RrcjlYa09CYkY5SkpMKzNxU2pO?=
 =?utf-8?Q?05o8t8b06rR5q6UP9Ld1h5T789reJg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9712
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5109c535-0e27-4070-c5e7-08de1b917f30
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|14060799003|1800799024|82310400026|36860700013|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUU0WDNaMk9mYTZBelBxdFR4cFRnWVpnU1dmMWFtaTdYVnNWdHUvZUg1aU5M?=
 =?utf-8?B?T2s0QTVlNFpZZDV2TG1LbzEweE5XZEw0M1MySWg4dVBaVVllNnkxWXJ5Q292?=
 =?utf-8?B?L2RseFRQNHdDc1NCRGc5dStXbUpOYnZ0Y29MN0t3bll3NWlmK1hhZVJWQzlW?=
 =?utf-8?B?cGJ4d1lFZkprQVN1Yzh1L1FYTWZ5TGU1TFdoRXhsRDZMZ1JtZ3JFUElkNFdq?=
 =?utf-8?B?UENwcGIzb1ZhSWg3aXJpZ2cvb1UxT1VMYTFjN0FFMkRvcXd3N2xKU0ZOdmhR?=
 =?utf-8?B?d0sxZm5hN0IrTCtIbHFnMHZQMnZEMlJxWDdla1E0bElGVUJ6bThvcm1sQ3Vy?=
 =?utf-8?B?cFBLUUR6SHlLbm1jU1JRdWxTTkxiZVVjYlppakRpN3RLbGRnaEhqNVB2UXdz?=
 =?utf-8?B?VVFhbnNQOGRCMDhwODlOVS9HVzIxQ2F6czhmZDNPbCt1NlN2VnFIZVdNdzQ5?=
 =?utf-8?B?S1BxdzJxd0pXNFhSU3NsSGE5eEFVb1NYTFJyMFptbTlVeit4eHB2OC9kUzBP?=
 =?utf-8?B?c3RaeW0rUUVQNno3eENhbXcyK3Q4VTVaUmtSaWlKWks2UWliQnNIcDhGaDZL?=
 =?utf-8?B?SXlLQXArcVlOMXVoQ1JOTlhtMEN3NXA3OWw2Qmd2U0JpSFJYMWd5aDBZY0Nl?=
 =?utf-8?B?Si9IVVhoUkV0SGF6N1lCVzJ4L29tdVEwWS84NzlTWnJLZ1R3UmtUekFlMnBI?=
 =?utf-8?B?UjQ4NlIrYUIxaXlYb1dZTWdIUTZUNjd1UllqOVNOKzkzMzdmYjhmVHY5THJR?=
 =?utf-8?B?Z2F6TGNoUi9JeFp4YWlaeFh4NmVUMEY1ZGl3R0M3Z3FHRXBnNDJteHJ1MUM3?=
 =?utf-8?B?STB6cnZVSzcxVDNBUStMbXlHS2pRdW1YWDZCa0pIcHBIa0wrckYza2k0V1VH?=
 =?utf-8?B?YmxsQjUxU0NFRFM3ZjljejZ4MVZUcnBlQXAzdWZSOXUyMWpuZkRyLytOM1U1?=
 =?utf-8?B?Y1ZRU2I4ZWZxVFFxY0lvNmZpUVhpT1JiOHduVkl6YVM5VEhhdktxamZUam9o?=
 =?utf-8?B?emFkWFFPc3hFWjU5M2Q0NkpVK2RYUnlUMEhNYk1YT293dGd5dlordzBWa2ND?=
 =?utf-8?B?NVoyQmc4TExKZDZibFduR3RUTlgxVUlVMkx6Ny9IWWpPeEs4UUc3MmUyR0hk?=
 =?utf-8?B?SEU0aTVMYnRLVWVtejJBcWVtYW9pY01BL1cxYmU2MTNwcFk3YTBxL0w3ZXFi?=
 =?utf-8?B?N0ZkMmtuWE1TL1doQnBJOXdkeVNheWdRT2dYbnEwYnhXRVVsR21Dd05NaHhV?=
 =?utf-8?B?d3RmbTVBc24zV1AzaUhkRlc4WC9QblpZVlUySTFOVTdaT0xSRW05T1E3U1RK?=
 =?utf-8?B?UnhFUjZKcWlWMVNuRGRTcFQ3cmxZRnBwNDZEVjlGQTdDcEswOWpUUWFUZHBz?=
 =?utf-8?B?VWdOK0FDc1oyTWp0QVF4VSthbFlZMnJQY0tYRlhrTGoyOUs0bEVhOGV4RHZP?=
 =?utf-8?B?dlJvSzlqRE9iZEhIVEZJUCszYU14eTVuZUVBc1h6TmEzYkpDKzRpOWNWeSta?=
 =?utf-8?B?QjIvaUNZUG5veUJkZHRYV2xiOWVmTG9Fcyt6dkVpZ0piaXI4bkZUR0RENzg0?=
 =?utf-8?B?dWhVckltVkkyV3owNFlQWnd3OUh6Z1BURk9wcXFLendpSnV5SjhYVS9nc003?=
 =?utf-8?B?L09RcFRybUdWd3BqT0RjcGt2amkxeFQ0bzNOMHY5WUY0NXFYRUZqNHRIYklE?=
 =?utf-8?B?T28yQ3VqVUZPTXZCT0RvM1RpeURGanZtd3pLVmxiZ0xaYUMzTjZwQUlhZmhX?=
 =?utf-8?B?QXdyOHhCWGVqUzN0Z3k2c3A2blg2RFpwWVhXWVdSWURQbHdiUElML3BjdUNQ?=
 =?utf-8?B?clhLSW1WL0VzYnJjNDBNYitPRUVmTkg2cVR6TXBMSUxGTGlqMG1PVXhoVUNj?=
 =?utf-8?B?QkFBeHdmdFQxemdSZXdVRWFzV3BuakFDb1BQVmh2Z2QxYlhyQ3QxNFFUVHdh?=
 =?utf-8?B?N3lNZ29ncXBUS2wySE9tNUQyeVV6L0ExMkZ4clBma3dZQkhZMXMxOEp1cHZv?=
 =?utf-8?B?eHQzTDdrRXI2TkhHTUF1Sk9seXlHL1VEenFSTU5ISjR3WitFa08vQlJScmtR?=
 =?utf-8?B?Y1BYaGdWaWZnKzIvOTVtaDB4empacndKalR2RkpsbTZYWDFYWkRWby9ONGIr?=
 =?utf-8?Q?lLPqbQxfrXbQy6kEItsvA/OSe?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:02:01.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b122e83-27cc-422b-2072-08de1b9194c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5709

[...]

> +static __always_inline int
> +__lsui_user_swpb_asm(unsigned int *data, unsigned int addr)
> +{
> +	unsigned char idx;
> +	int err;
> +	unsigned int addr_al;
> +	union {
> +		unsigned int var;
> +		unsigned char raw[4];
> +	} data_al;
> +
> +	idx = addr & (sizeof(unsigned int) - 1);
> +	addr_al = ALIGN_DOWN(addr, sizeof(unsigned int));
> +
> +	if (get_user(data_al.var, (unsigned int *)(unsigned long)addr_al))
> +		return -EFAULT;
> +
> +	data_al.raw[idx] = *data;
> +
> +	err = __lsui_user_swp_asm(&data_al.var, addr_al);

I found that using swpt for swpb can cause a race condition
when each CPU accesses its own dedicated byte memory region in 4 bytes.
So, unless there are any comments,
I’ll rework it with a cast in the next version.

> +	if (!err)
> +		*data = data_al.raw[idx];
> +
> +	return err;
> +}
> +#endif /* CONFIG_AS_HAS_LSUI */

Thanks.

--
Sincerely,
Yeoreum Yun

