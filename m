Return-Path: <linux-kselftest+bounces-20374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE59A9E8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 11:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25804283807
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C52154C19;
	Tue, 22 Oct 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IrLX2Ehm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IrLX2Ehm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462212D75C
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589519; cv=fail; b=odtvcLT8+egQfjkEkfmljUVsWu6fJvN2NCLPCbS1jaE6UOuDiQq7CCLngmJzeC3tQ4pDF319jwNz5FZYtaJZ7fmwl89vUDuldZr09LxNjF/KN8r3QwUYIE2Ibe4tOeFsQx8uYrx+dho0WHr2zX4eNY5JdVRK7DssUW9NBklEuUQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589519; c=relaxed/simple;
	bh=qsJPpHaAVbcfUfmn3CDFbP9TSwxGzFOqjBUd4+l4j+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=VM50m0GuJL/Re+Zq/vsQJ3uMelGXNG7QXmZPMEImFfVlq6nn/hIrZKRpDTWALjB27veikla+c4O7nqfx+LXF24ExLivEW5v4EaOwg/yZnCvfXM45cKhKDo4dv00anSCAjr7yLxMvko1VRSf323l+Yj1UJ2PNEBRBu7ko86Pge64=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IrLX2Ehm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IrLX2Ehm; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qnsbsMpOhuceJxishgvho6XoL98WmsjRV8Ez3GIsQNRkUzjdjejyVJcpNUbC2J35KgPBDbZcR6jVvE+9TrF8Anin4mN5idBkmu/A9X/7S6a8xL/dMqwoU/R6IUhGkvnWMy2FusMsAkkm4rKSBfKJhoYh4YfHp3aTs/ZLhkqtY1/9me7VEEaD1qLDqJqQu4wObFSdNuyD8q2fZEJwVbN4FrqvSjVZXpGnds9EN4EO/ZGAnxsENGaLUMRe17m+uJYcs6eZkZlmXecHM94elwHrPJCuvA8nBQziCCFmdsxCS3ncSjpw+jvW4ctB9SnKFjmUvANUpR0HkK/g6LVsy2M2+w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J96RkePMsVXa6XjQvzAZj8HYqWPh4WFwRSMURW46QPM=;
 b=LsuOa7uMT1MseAcZjg8M5Iw9yMl5x7SrVTigDAKrWLKK015jZmNKM/b7sGRSfrUazFeFZhHVHJ4W8k1fteuGOv64MyIc+KAOGMBHTjtCjw7ofQXGbTB/qvvkxXEgdzxDo/eIGcGk3tnHhy9si1g3lQytfC96r/FJRx9vn6huVFHNmT/+vPH6IvNsXrVPTAn+HkQCstdn/mec7Lfb5/g1NHMXXgSec/UI1ffe05WKPYmx32R4D10b8AAkZXZn89wm/1mpCiN+35tk8ie8Ddi8AeKBYyRfnDj/gpWtJoESQt/8IGn1+wRLGAkwJR8TRwv82vJsHdW7Pc1mT2jr0Z14mg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J96RkePMsVXa6XjQvzAZj8HYqWPh4WFwRSMURW46QPM=;
 b=IrLX2EhmCMAUQ5cM8rY6yUQbmoLTrKBtdTFcvqfEfnibN7zwGDu96UMg0mI3M1PC+OZfBIelfTpNGJ5S6cRM6FOv05aNVqIVcQ84tGz05FZWF2bWbja8c46gtpqXiK/KSyq/JrBO4Msf50Pa9CT3fhvTPMe74T6WJcIY51+un5Y=
Received: from PR3P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::17)
 by VE1PR08MB5647.eurprd08.prod.outlook.com (2603:10a6:800:1b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 09:31:47 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:102:54:cafe::58) by PR3P191CA0012.outlook.office365.com
 (2603:10a6:102:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 09:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.2 via
 Frontend Transport; Tue, 22 Oct 2024 09:31:47 +0000
Received: ("Tessian outbound cd6aa7fa963a:v473"); Tue, 22 Oct 2024 09:31:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 568229b76c6d1f21
X-TessianGatewayMetadata: wNeQCUiCDGEU5a/SQ8KKcHknxaqaU7b6cMOS8k0TiuYBGwOK5etbnMJIVnKYJn0yfqvZgmOfGKFD2+2qRxPSCnwntSd2jJCRdEnATR7PNlZ+yf+f7b6sS2HSTyfip79OpKqLkL5/rQKRkcFEjelq1g==
X-CR-MTA-TID: 64aa7808
Received: from L5ad488967953.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E1DDC1EC-A1B6-403C-B436-7D61756FA3A6.1;
	Tue, 22 Oct 2024 09:31:35 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5ad488967953.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Oct 2024 09:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7ioqr6hWvuUvIzx7rfHRLjJR7tEsSE7XqiAalWo43m5/EoaNT4obVnypBns1/QQa+kYavTOsuyF1EpN+YpNmfTMDUGXda+k5fMlguRXCtANeusEdZafGBsug3C5akJiW+ajdiEmujLix1cnS/O0k+0t/DiCt3+Md2CtqpqQ9gic3uIhBl5DFS0O61jAspzTs/l6zW5CqwZObbk2NIboVyoRaf4NGI9led/1HAwS4uA2EBJD0qXr+49v1j1GsfQ5ybfDZYb6VGFL7myhmMcKiiEOHvMFHIZ6Ekj/Ilz/GP6t4ZrJDZvGNLYVna9hbockJEDFrmlgVqPurYSTMlFs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J96RkePMsVXa6XjQvzAZj8HYqWPh4WFwRSMURW46QPM=;
 b=GNwVhtClN/M+aTJg1UYgJS/aCojb0BwfiegQ9yPqMKKfCbrXmw1R/hm2pT8VDI3RDK7gtkCCvu7if/mOLolIdLbM0Op3J1YT3CbKf2rWlxHTkJIL58igS2yWuY+v0tV/4QJ3n3KACocsZQ+8YVRE8erqaILcmD2PGC+LrjyQNO4JFOcWwuKeidEA/XElCrS5m8LIh5LSQcJvqmzIniFw6ggYgzA3A++oFWwiBectolqt70p2hBWUTr5KFjTamsRHq1+o6qgDO+Qw52CqMfXRIkg1AvBc/a8WpHmNvj5oX5osOxbts+4zu7RGip/3AbzTakMOiRpUUH2qRD2+qR5izw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J96RkePMsVXa6XjQvzAZj8HYqWPh4WFwRSMURW46QPM=;
 b=IrLX2EhmCMAUQ5cM8rY6yUQbmoLTrKBtdTFcvqfEfnibN7zwGDu96UMg0mI3M1PC+OZfBIelfTpNGJ5S6cRM6FOv05aNVqIVcQ84tGz05FZWF2bWbja8c46gtpqXiK/KSyq/JrBO4Msf50Pa9CT3fhvTPMe74T6WJcIY51+un5Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB3PR08MB8843.eurprd08.prod.outlook.com (2603:10a6:10:438::17)
 by AS8PR08MB9244.eurprd08.prod.outlook.com (2603:10a6:20b:5a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 09:31:30 +0000
Received: from DB3PR08MB8843.eurprd08.prod.outlook.com
 ([fe80::ded7:e58f:42ef:17fa]) by DB3PR08MB8843.eurprd08.prod.outlook.com
 ([fe80::ded7:e58f:42ef:17fa%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:31:30 +0000
From: Pierre Langlois <pierre.langlois@arm.com>
To: Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  Anshuman Khandual
 <Anshuman.Khandual@arm.com>,  "aruna.ramakrishna@oracle.com"
 <aruna.ramakrishna@oracle.com>,  "broonie@kernel.org"
 <broonie@kernel.org>,  Catalin Marinas <Catalin.Marinas@arm.com>,
  "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
  "jeffxu@chromium.org" <jeffxu@chromium.org>,  Joey Gouly
 <Joey.Gouly@arm.com>,  "shuah@kernel.org" <shuah@kernel.org>,
  "will@kernel.org" <will@kernel.org>,  "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>,  "x86@kernel.org" <x86@kernel.org>,
 =?utf-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, nd@arm.com
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
In-Reply-To: <ZxZXnM9vUj+tex/z@e133380.arm.com> (Dave Martin's message of
	"Mon, 21 Oct 2024 14:31:08 +0100")
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
	<ZxEx5aXPX2mHngoB@e133380.arm.com>
	<627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
	<ZxZXnM9vUj+tex/z@e133380.arm.com>
Date: Tue, 22 Oct 2024 10:31:26 +0100
Message-ID: <87plns8owh.fsf@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To DB3PR08MB8843.eurprd08.prod.outlook.com
 (2603:10a6:10:438::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB3PR08MB8843:EE_|AS8PR08MB9244:EE_|AM4PEPF00025F98:EE_|VE1PR08MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a354c63-7e10-4a97-f47c-08dcf27c59b8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?640KjULdWFDHS36VL+DpLjN2N8FLIpkHlhfsW7ufQ9K7M9oQL7hYsFAbuzGY?=
 =?us-ascii?Q?DkHh6f7QNgayNyNI+qsQ5rpmr8nGVhRfVqexOy2lcC+pVNHigSwQe342h896?=
 =?us-ascii?Q?wm49seZFL53p2wjTmMMuUafUyT0exWYvsjWavO6r5TFV7HXzO7MMwcUcHixD?=
 =?us-ascii?Q?oXQ3L70iDQOtf6Dkx74+90oiWnnYDHXsN+8tzRzdXBhCpd20vKB+faSZC7nS?=
 =?us-ascii?Q?ettxSOPPsGKahOCS+NHOKm00ib6k/sBzi66PMxtLmevRQ0QAdeJWFyKkA7c5?=
 =?us-ascii?Q?C7FSlhEY6Ftrwm8YWjQ5z/uc6mbUXQ824pJCm6U8c7Hwdnn8MH8S9zmcVO8P?=
 =?us-ascii?Q?+nf5OHlyGi8NViyOZiSrSLT+nOG5WkViwPPph1ZukLaw6C7FehRlKQGshVJO?=
 =?us-ascii?Q?FRtoeFxCKvDUdETX4LV6SpfO/vUn28CjO6azJlSaVVsj3l3GVz3IkaLRlLMD?=
 =?us-ascii?Q?DlVFzPBhRFdPx3lTKA5qoo2HXGQnYbvl4tp90l9y+nvTz0dcvqsiaHTdyuSb?=
 =?us-ascii?Q?VRiP8mn7WR8KmhewBUY2j0Uokzn8doThvroiGeke1NqK4HfAIUNYILehUBr2?=
 =?us-ascii?Q?yKq/HFGWqg/EMq/23KKyQcQYJjiuRogdJZI/aCIZdEovNm1RUU2I+CnrlL2d?=
 =?us-ascii?Q?TGG/S9Rlnk8a7h2VxC4rbm99GP86aZ7wZP8v6/5F9Bmsxd0Y56ENM6vjUgmK?=
 =?us-ascii?Q?lGXSfoozuFq7Qfh4vSt1Lru3ZRhA4mtBbcNaBwlJT+mmgAchgSgq3/3EHn+T?=
 =?us-ascii?Q?mRKhOT5AqTCua0rWbBnWtqAbPY2ZtkZVZllOKC0S7uXxEyKYxZ47nPuwWmoJ?=
 =?us-ascii?Q?KqodI47PSOd4WpmOFQJK+z1rS1g4OGLkvt/gkuG1I8K1KXdDibNQz3llevBD?=
 =?us-ascii?Q?JseSnC0MUsuDAjlgNLUJ7Iq67wqLHY9LpJHd1qD9SbEW5l75tpFOuGxkjCk8?=
 =?us-ascii?Q?cbyY/D41f7pPD9yP+WG21LqsML/flG3DulIM8M11ufddQHRe+THEdvAeGi0I?=
 =?us-ascii?Q?CX2V3bzzUnAj9n9SaOZ3q0Bc1N+5Anucwu/Q9uQ1z7NgDH7Watw+fGBAVABq?=
 =?us-ascii?Q?spPZE0Uods1UzFTiMSFfQGkT8QtQmJaHIN5Gx8xVYpKjI9yHRbNuiiJdLzMM?=
 =?us-ascii?Q?+YmG6NyHrMR0UZWmloLCgyp5Gw8jLRW2h6QcZzXjHvilZpH2Erq9aJmaDhQv?=
 =?us-ascii?Q?zfDcAGeHOejSPMTC5lIYRrRBUF07uFsHMSsaCKmj2W7DD3+5gSz/xiwTJ1km?=
 =?us-ascii?Q?obYLgrjjnlu+jhDA7whvT/meLKhQRCsfTaJ9I5LD0w=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR08MB8843.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9244
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:438::17];domain=DB3PR08MB8843.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e26e3822-5a92-4b6b-32d3-08dcf27c4f3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtciIawB3QM8ms10Rsn6bI/gIuR+UrUyL4GGSvAXCScCZ4NIWoFabGo3t7lk?=
 =?us-ascii?Q?aXkEPNQbPUWcjMaYLq1uhJ0nhH9yeUKmYOx47MqW3sgIKZCkKZ18geLcPdr8?=
 =?us-ascii?Q?bNMBWwJ2JgFbhCGcZTxGRIa8cvb1W3LGAa2cCCrmV5+44BqCyjvHLT4baKbA?=
 =?us-ascii?Q?4de93Ed9OJyG6OAaI4upG8xAWURixaTk3H0hgy7FmxqIPxDVlL1W+XcksWRz?=
 =?us-ascii?Q?UaxMCgtIKLFGWD5OplFFYevxoQIsuU3Vjo+O8xcaVVZoTA97CIb7+lT/ppXm?=
 =?us-ascii?Q?ltUXgmHfEMovZhDgaSLeMxdh624arDtDyifTYKdcfhHlljIpwph143qRj5qT?=
 =?us-ascii?Q?WohqEMdPbFZMri299O3gBJci52PwVnth6Es2U1/UgEB7Wtcy0PJxfi7b2Rv2?=
 =?us-ascii?Q?Z2CfQ4dbs/wD8STXqep4eU6w6q+NEUvOP5y5xCvLiBWGKp0ZB+cH2PEF2G5G?=
 =?us-ascii?Q?/nMArQveF6/NNcmxJlUzRczjInQjOIRCt6IlWVDkrzScI9HNPl/KCq0BPm+p?=
 =?us-ascii?Q?trHuA/7cZeEVYuu7Kz4hja9yIFoQoQNPjyqs5npCx7eZdqmvjgU5X5PWkKtO?=
 =?us-ascii?Q?MzPpSTYyMYRjT9RKMkxrocWPAiWu6MfN4WEaU46xUWX+PEorGvV6k6Qd936C?=
 =?us-ascii?Q?wDKMUOpqhiS8of+P31hC8V70CyolRz7z/pNRLQSjWckWDAXYxErrkoRwFop6?=
 =?us-ascii?Q?fmizFktSBZ8gO65wvTyzdQhBq+SD8MN7qBQ91SjGyADZRgqUCCD9MK3tzXqH?=
 =?us-ascii?Q?pb64igFoHTpRvI0xdGrvAqxo/gY1ZPQ+UyNkYvE6ogj1ariIjCb1YVwGEftH?=
 =?us-ascii?Q?hphCf1brKFdVAuu+u8id/pFe3x85VPJbbRC1iBf7I1MAh38Hg2FY18r5ptlo?=
 =?us-ascii?Q?so+26jzE8mcbIqOwQLgiPqRhlLFluYlzUqa0BQwipB7HSaymPzOVTsm72vWd?=
 =?us-ascii?Q?fv+8Crm8tmoPqo1+InEn7+LozJ/IAZR09vcqBmUSS+lx28A7UDMnFn7daQKE?=
 =?us-ascii?Q?jvUADWjwV+rrqO3gcsfrFpNH0GIivzHiG6tKofhUh28WXkSbDawI9xYVh4rV?=
 =?us-ascii?Q?/n7uaTkUehAtJ02rG0239iZsv22cE7y271DpUUJEh18p5Fvi0teTeVweV7Z8?=
 =?us-ascii?Q?0ZYFPrL1nX2SkzaiPYCfTg8hu8XTWXIcRjX+No0PD/cLH0TWmahEpqZmph0C?=
 =?us-ascii?Q?WL0uRt3sFD6ucgUjfSpx6STZ1v5ABtAZyrWfEWoEzZCBNPjPycZ68qdhVhYd?=
 =?us-ascii?Q?VjkqFIbTOdXEzEbhE2D5aXJeXIk4Z6dgPq4T7Plh2RKuAjQUwbWH97Z0CA3v?=
 =?us-ascii?Q?DaUB2FcX0gCa47ZHRVUlbxavigxeJKTTk/jIJGw6Onu0xog8EiqTUMZLOSC7?=
 =?us-ascii?Q?Xp5243A=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:31:47.4302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a354c63-7e10-4a97-f47c-08dcf27c59b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5647

Dave Martin <Dave.Martin@arm.com> writes:

> On Mon, Oct 21, 2024 at 12:06:25PM +0200, Kevin Brodsky wrote:
>> On 17/10/2024 17:48, Dave Martin wrote:
>> > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
>> >> This series is a follow-up to Joey's Permission Overlay Extension (POE)
>> >> series [1] that recently landed on mainline. The goal is to improve the
>> >> way we handle the register that governs which pkeys/POIndex are
>> >> accessible (POR_EL0) during signal delivery. As things stand, we may
>> >> unexpectedly fail to write the signal frame on the stack because POR_EL0
>> >> is not reset before the uaccess operations. See patch 3 for more details
>> >> and the main changes this series brings.
>> >>
>> >> A similar series landed recently for x86/MPK [2]; the present series
>> >> aims at aligning arm64 with x86. Worth noting: once the signal frame is
>> >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
>> >> only. This means that a program that sets up an alternate signal stack
>> >> with a non-zero pkey will need some assembly trampoline to set POR_EL0
>> >> before invoking the real signal handler, as discussed here [3].
>> > This feels a bit bogus (though it's anyway orthogonal to this series).
>> 
>> I'm not very fond of this either. However I believe this is the correct
>> first step: bring arm64 in line with x86. Removing all restrictions
>> before uaccess and then setting POR_EL0 to POR_EL0_INIT enables
>> userspace to use any pkey for the alternate signal stack without an ABI
>> change, albeit not in a very comfortable way (if the pkey is not 0).
>
> I see: we try not to prevent userspace from using whatever pkey it
> likes for the alternate signal stack, but we are only permissive for
> the bare minimum operations that userspace can't possibly control for
> itself (i.e., writing the signal frame).
>
> This whole thing feels a bit of a botch, though.
>
> Do we know of anyone actually using a sigaltstack with a pkey other
> than 0?  Why the urgency?  Code relying on an asm shim on x86 is
> already nonportable, unless I've misunderstood something, so simply
> turning on arm64 pkeys support in the kernel and libc shouldn't break
> anything today?  (At least, nothing that wasn't asking to be broken.)

As far as I know, Chrome plans on using a sigaltstack with a non-zero
pkey as part of the V8 CFI and W^X work [0][1][2]. IIUC that was is part
of the motivation for the x86 change. I don't know if it's urgent
though.

I added Stephen on CC who might be able to comment on the current state
of things in Chrome. I don't think the code that uses a pkey on a
sigaltstack is upstream yet.

[0]: https://v8.dev/blog/control-flow-integrity#signal-frame-corruption
[1]: https://lore.kernel.org/lkml/CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com/
[2]: https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo

>
>> 
>> > Really, we want some way for userspace to tell the kernel what
>> > permissions to use for the alternate signal stack and signal handler
>> > using it, and then honour that request consistently (just as we try to
>> > do for the main stack today).
>> >
>> > ss_flags is mostly unused... I wonder whether we could add something in
>> > there?  Or add a sigaltstack2()?
>> 
>> Yes, this would be sensible as a second step (backwards-compatible
>> extension). Exactly how that API would look like is not trivial though:
>> is the pkey implicitly derived from the pointer provided to
>> sigaltstack()? Is there a need to specify another pkey for code, or do
>> we just assume that the signal handler is only using code with pkey 0?
>> (Not a concern on x86 as MPK doesn't restrict execution.) Would be very
>> interested to hear opinions on this.

I hadn't considered setting a non-zero pkey for code, but it sounds
appealing.

The general goal, IIUC, is for signal handlers to run in an isolated
"context" using pkeys, in order to mitigate against an attacker trying
to corrupt the CPU state on the stack from another thread. Then use this
as a way to bypass any CFI mitigation, by setting an arbitrary PC and
registers.

So sigaltstack+pkey helps with isolating the stack. Then it's up to the
programmer to carefully write the signal handler code so it only uses
pkey-tagged data that other threads cannot corrupt in order to trick the
signal handler into writing to its own stack.

In this context, using a non-default pkey for code might be useful, in
order to differentiate between "valid" signal handlers and other
functions. It could help fend against an attacker being able to use
sigaction as a whole-function gadget to install any function as a signal
hander. Basically mitigating going from a limited CFI bypass to an
arbitrary CFI bypass.

That being said, regarding the kernel API, it might be possible to do
the above with this patch. We'd be using the proposed "assembly
prologues" that sets POR_EL0 as the first thing then continues to the
real signal handler. But if we can avoid those and directly ask the
kernel what POR_EL0 should be set to, it'd be simpler (and maybe safer).

>> 
>> Kevin
>
> I would vote for specifying the pkey (or, if feasible, PKRU or
> modifications to it) in some bits of ss_flags, or in an additional
> flags argument to sigaltstack2().
>
> Memory with a non-zero pkey cannot be used 100% portably, period, and
> having non-RW(X) permissions on pkey 0 at any time is also not
> portable, period.  So I'm not sure that having libc magically guess
> what userspace's pkeys policy is supposed to be based on racily digging
> metadata out of /proc/self/maps or a cache of it etc. would be such a
> good idea.
>
> There are other ways to approach (or not approach) this though --
> I would be interested to hear what other people think too...

Thinking about this, I'm not sure about tying this API to sigaltstack,
as this is about configuring the POR_EL0 register, which may control
more than the stack.

I actually have a concrete example of this in V8. There's a
SetDefaultPermissionsForSignalHandler [3] function that needs to be
called first thing on signal handlers to configure access to an
allocated non-zero key.  This is independent from having a pkey-tagged
sigaltstack or not, but I suppose later on it will need to be replaced
with assembly when the stack is no-longer accessible.

[3]: https://source.chromium.org/chromium/chromium/src/+/main:v8/include/v8-platform.h;l=665;drc=0abf23ec2a1bb475b1555790fdc72ef630a43c2a;bpv=1;bpt=1

Doing this via sigaction as Catalin suggested makes sense to me, but I'm
unsure how we express how POR_EL0 needs to be set solely using SA_*
flags. Are we able to add a new architecture-specific payload to
sigaction, or would that resort in a new syscall like sigaction2?

As an alternative, I was wondering if this would warrant a new syscall
like sigaltstack, but for CPU state.

Thanks,
Pierre

