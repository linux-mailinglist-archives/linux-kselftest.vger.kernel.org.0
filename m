Return-Path: <linux-kselftest+bounces-49478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1DD3C446
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 609276C7CEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6F3D6477;
	Tue, 20 Jan 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PC3ysTaq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PC3ysTaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371227F75F;
	Tue, 20 Jan 2026 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901628; cv=fail; b=iedUxuBhgQkXT/akbCvhc8OLO9d47w1DI6YNfLExdksEM9jeSZ4tx8ubOo0z99pZoW6qmoXTNsDhSVwAIZU0M7IcI6o5P0sEfQ1YGBCk3ZyVpkGs3AnT+bh8ZADuZEvhuBjFqUF8bLR2mgsUkK85bCm6s5/oKf9QfmGPzfyvJgo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901628; c=relaxed/simple;
	bh=Tu/MrR/4bS2gIhrMk/YWEq/jBVHLO6VzaHTgqDjAnzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgl29fickcaquVo0kMx6u/gBpnSHxHg42QNE5LZIf8DKP20nQ9uZbCyWDjvi2ouGmnCv4zm8frwRJUIg8f9chlmuHvVuvuhMFzyPNtXQY/3n5/oT9mKsZPSny0fSHV1zelLXO6yx9YX9Bt6K8gvqanbUIOtCcxLQkaI+DvViR8c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PC3ysTaq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PC3ysTaq; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tmwwY+T3Fo1rvnYxv0UvuP1VbW7MLQT6tEZ43AqAIXPyhUI2/wCmqucXUPYg0gmHuv3ZhbJNj/xcuyalVlE/2o10FVJEtFcAgkbrQFn5O1TJI89y6qegEOhQNXh50vWi6g0UI8wAfU3ip+uH+Hp1P0Qin5o4kThjswYEqBoB9JIzTVB9r4L4y92A98YrQ0b02Ji0uIESEedo5NCQbXVAOAY4ha//VjKXnSu+aKtoUl4gVxBnhdttNDUnqafHeiUr3AkEc8iSR2ECesJfFmjq9ndkEgDkwDRkldcaGYZYhdHDan+WzpDTnRZ+vRInKK0Z43YP+zWZU1D9RcweEe5Qww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu/MrR/4bS2gIhrMk/YWEq/jBVHLO6VzaHTgqDjAnzQ=;
 b=n8hhVBy52/Jsgf1i+kBvt1Q6k1FRANOtl2OKcFthDYkIXc1A0gWFsvw7zvg8S6CiCCZ87tWDaS9R8JIhw1D1OcOlL3K8bXzLipdKLoEiYfhnGcoGE3YcgB1d+sUvhbbrtcUYnCikubAw9+2ZOXaVKvXwIbw4f8F/EbGg/wG10Z2QDEzTYlgCTNrZnWofNJ6RYJPPdUGbf1xYaabzfl3nw9E95d/GMpa7PyfO1aEGJlgXVwJk8GTIxkqRAJgDkse9EXGqi/YotOFvUxDAAjRWfmFjwjjSAeFH1QzwTuXYHfynLof/L0Saz2xAJW/BDI1t+Ba5re7f33Wmeh4ic3z05w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu/MrR/4bS2gIhrMk/YWEq/jBVHLO6VzaHTgqDjAnzQ=;
 b=PC3ysTaqMa9iqr1UCr+mm5lFT6/Fe0W2ZVNeodaUnN0vEyzeTAE2wBHw8v+paulfzchCyFJ5Bv8odz/Ci5oB+ZTFK1YQRTpn7zaDrWlHEw7DOkXzMjKuHAc59pLKBfrcj7NQ63YUxD4Kq2TtXHVrvsCgvsnkQ8tnDNEeTR/jWBc=
Received: from CWLP265CA0267.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::15)
 by GV2PR08MB11280.eurprd08.prod.outlook.com (2603:10a6:150:2f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 09:33:40 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::3d) by CWLP265CA0267.outlook.office365.com
 (2603:10a6:401:5c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 09:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 09:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVUfepTYOWhmNbLnjujJWrilcj2mLtFZlwzy9dhfKKJf4fVHi08zSPx0FqwO6XgBnwNE5MBgmdmAs5xnswB68JD520x9RWW7TeDZik+4iavfxuuhw3FY8iP1NI/mgmkGrbjsuSugjOlZfXwDdH+yJ2IyAqiuORKF0qPdP8fOGc/ygmcvvaUvOrpiDG8T9d1XJf0X+6EWGj9kWyAi5sSUWWV5irvgKPdl8S+xoTdbhareFni2mYsHgtmTiSJ8tj7XAqZp25V5t1PRBjUu5SkZJ2V4q5ZlOD5JYZKgAt0IgHCGkUMePKICBe3WW3c2XWBddg1C6Z138u4upQMs8efQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu/MrR/4bS2gIhrMk/YWEq/jBVHLO6VzaHTgqDjAnzQ=;
 b=kNrOEWVopZLxtD0/NgYXIh0TMJDyyKmHZOtzR0l46UOGA7IXw88osL/Ym5jgykAgCyrMXd21WUaWvZnJkJqiUsJInq0kSRC/A7qdqDlWzErdZPIsWij22BAf+Rhvy3sgoOTnGerKY3I3mlOcKZ80QaZCltW0y9qrFBk/hY8brFopZpCtggxbHbf/+/LTuF+q2hMekcncryeItExS5t4c1BTxD2b5K0/Rus/l1RiRPUGtsybp3gaTov5+E4DUI0Ui0myDp2J9xnFHd2S05BbJrQJKI6usfxYF3Th6UPfZ3qhPVCu2X1FEIkZOCfQ+bC6dmoUnUF5snoO2iaaLFGvhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu/MrR/4bS2gIhrMk/YWEq/jBVHLO6VzaHTgqDjAnzQ=;
 b=PC3ysTaqMa9iqr1UCr+mm5lFT6/Fe0W2ZVNeodaUnN0vEyzeTAE2wBHw8v+paulfzchCyFJ5Bv8odz/Ci5oB+ZTFK1YQRTpn7zaDrWlHEw7DOkXzMjKuHAc59pLKBfrcj7NQ63YUxD4Kq2TtXHVrvsCgvsnkQ8tnDNEeTR/jWBc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB11419.eurprd08.prod.outlook.com
 (2603:10a6:150:2b0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:32:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:32:33 +0000
Date: Tue, 20 Jan 2026 09:32:30 +0000
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
Message-ID: <aW9Lrm2+oc4xWv9j@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-10-yeoreum.yun@arm.com>
 <86ms3knl6s.wl-maz@kernel.org>
 <aT/bNLQyKcrAZ6Fb@e129823.arm.com>
 <aW5O714hfl7DCl04@willie-the-truck>
 <aW6w6+B21NbUuszA@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6w6+B21NbUuszA@e129823.arm.com>
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB11419:EE_|AM3PEPF0000A798:EE_|GV2PR08MB11280:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c99c2ab-ae8a-41cf-ba2b-08de5806fe5b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lZZve2jv7Eq6OwSiWxWPYoHlev5q70g8pXWQvhIKpZ9az3K9vwbjt3mc8l7H?=
 =?us-ascii?Q?daMugdR+GusFqFWWr0P4j5oF0dfdokfSMAMTUWb16tmetCOjMk/lclQeQMPT?=
 =?us-ascii?Q?OIxxWZHCc7/m6b2CPHqJt8xft9WSRGWYYcTp+Y2cirScBpxMMhZTva6XJaVb?=
 =?us-ascii?Q?Om99Qg52r6RBVAC88Ou0iUvfyhFwU5U5AoqVoih+wfmUE1WKgTeJyRI/up+i?=
 =?us-ascii?Q?UR6cSDL2VyJsz0r/kRhIL3wfU1S2hEkn7fnScu5Ptdh9rZ/cXQP+ByddN8Qj?=
 =?us-ascii?Q?1yFuGfk8wQLXbLvgtcZnxIkBmloG37ryiLE36MSQJMKzfKepbOJpizwhrw5y?=
 =?us-ascii?Q?NbJtznGRuaa8gpxgP5kP2aESxp6GNki0zJPhFSTBOrMp+GFCyKrK+cRPKTrN?=
 =?us-ascii?Q?FKJxVnIbd0LM7ofSUe/BnB1rfjZGS8kwgwOON/N7JO8HLY3g1zjo+6eLJoOK?=
 =?us-ascii?Q?+LFAciQI1mlo1eiu3kx34Hahrv8I8w1GGPB7FHuDtL58UMM3w36GDb85alqQ?=
 =?us-ascii?Q?Q3gA8WiVzQ5nl0gbAy9Mmm6aSalBMtZUucTDhQaWBQV2qzS7oX2PuYNySBdc?=
 =?us-ascii?Q?hjc5Z3ImTHvHL8GUWc/AZC4BmGl3Wdo+WqFPebf878VGYPg1PLMUKATDhfpC?=
 =?us-ascii?Q?xk7b82iRnlm6202G+7xyGiqn6EgoL595XRQ2FBlvoO4oRzXoZQ+hUpjevYwC?=
 =?us-ascii?Q?enOXi/bXOVj9AOTZLes1rHptX8rxYvA7KG9nrDoZRxSnQ35wZKeGTWfGH1b/?=
 =?us-ascii?Q?r64r8Qh4Kmko3I7ehkuYhhLMK3toOeDGBCaoZ/wDQHAJGbg5oXRE+w+dVzv/?=
 =?us-ascii?Q?qkBPAINeKQpnnqGgvxVMt31qRb7CON1xyp+MeuIQ4z57m5Ay+T+TVSL6UpKP?=
 =?us-ascii?Q?Ejt2YjnkFkbd+Jb6kcTBAA2K3HVbGZ8XpmVbzJBXFT+oBcyWonNKHhA5zSoN?=
 =?us-ascii?Q?6D7GdGKMMbeYYDAkrFkEg0nvT0Bna0u7jaTdCsS4J0jXw9T0jBTcm74p7tjv?=
 =?us-ascii?Q?43HMqrn7Y5RXW12KwXvr03xiD9BXGdM3rNMA65EbcRdKEYNGPhJgOiPEGy0p?=
 =?us-ascii?Q?awTU08BXvaH/kuFZLcEdmogustYZYOm0S8DiDVYowlbiqJkrMpJuF1U2FYmf?=
 =?us-ascii?Q?C8l8DFmSVvVg1l6REJC3OIl3yK8vDjBeFKEvnDdM9GQye1cmWHEks43ZpjBi?=
 =?us-ascii?Q?PjkFpnRhFfK2PU9LCc/ypfaPihV8WqVewUt48hY9B9cZnbLboguEQ+y8OgBT?=
 =?us-ascii?Q?PaaM2DQNqpTUOF+biELzrui/sEgmYoaU614rYumwjZ11me2Wj19U1XjJMncU?=
 =?us-ascii?Q?SdUhfpAte0P32PrHVjeJPVgqNWsTnEX1/f5QTdPOIKtMTBYcWSsTJ4hdaYFJ?=
 =?us-ascii?Q?SsdDU9zXNBY9FdTC97G9qW99tXXvt5fZ8svDEY4kRmhoQZuqVVgdaUEHaarn?=
 =?us-ascii?Q?nRNl/uOGmPB8z7Zn4bE5qWUaFoRmsaoPCK8FMwAGKS3CR8GjsGQE85QHn5TK?=
 =?us-ascii?Q?+fn75rQpfAzFnP2nWDIqgaiWaUbACaZt3BBgLFQ3n+ckQmhwEI/GdhA64ZIU?=
 =?us-ascii?Q?R1q7OzktlLXFxCbwmkg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11419
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2d11101f-cb03-4f8a-df54-08de5806d6fe
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|14060799003|82310400026|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6UQs5Fxb2Iy3MKyxlNSAbl9AAHMQQ+YDjzpETzscjrSgT82j1qAZV2r9gMn?=
 =?us-ascii?Q?18yHMnstIqcoXbuJbdmW5gT0pE+FEJk9uwr2ip6rIEPr+LUkvvz4c+ABjVtN?=
 =?us-ascii?Q?wffCefAKighVfvlK3PpEp7fJhylXSkFpjYAejB0OMb5dlrNNEImFTq3edVe0?=
 =?us-ascii?Q?zWBJPursE37JDTbQM/lfag2/mh0duLyj3pyGt9JHrX/hyhztbGkhGeTqtOc3?=
 =?us-ascii?Q?IOXRnIyOCGzsVnOt/uGGG37SrO0Tr9aL/f81p86YgJZgW6k9l8f5wjDDkZ0K?=
 =?us-ascii?Q?2dzB6NnDLEd9p/tHuwTJcYfmNJC5AjlyfQg7YUmuAptz2MA13lkMPmEQ9yUj?=
 =?us-ascii?Q?d6XoZ9ayUbRCz2edcpSyOZLnroLaIAVqjDK9MaHtiXWJ/AIoyenQ6jtudwuQ?=
 =?us-ascii?Q?912F4lCaD4Ihg716PQ3iW4ZLKjA37jT+wiD0fyj/YhaajPgwouEfdA/vyRlW?=
 =?us-ascii?Q?f0s/84q77QYHZMjpMZMjSF6I8eILG53KPRdLj3I0xtSFobc6Gzy3gKjp6yxV?=
 =?us-ascii?Q?KzGCY1XUmaAesjcbhleEOL875i6dIHvhnGy7muXMaMEZEUGjkCQkgmD8R6Rp?=
 =?us-ascii?Q?hQMACgtPCoPJ2hUApEbB/A83pPcBbBFC+X07Z0fMGjg3O3vd/czrL/berwK0?=
 =?us-ascii?Q?kAxJyIJ6XT6r5ZVmepA6ec/1ELZlT9nziKPNQKahYGl0UxKyKU4sNJsyjy1D?=
 =?us-ascii?Q?/dywP5Jgq7dBQTI7t/LiDirC2R//k2d/Xzs4RDlnQ7dloTBqa2XKY7tK33xG?=
 =?us-ascii?Q?XifZ6EEYjVfI8tDghvVkqY8gCXX0hk7vjWIobaMXQXOhCNloLBEg+nofXAYQ?=
 =?us-ascii?Q?qaWiUQIC75j/PQ4bIdbO01gcX0xAJvjuJKGx9eC+5R2JG2h3fcCE8b07myHs?=
 =?us-ascii?Q?Rhbs/4QJXw4F1TgNP8Cr2wm/g2G8OM9HMQ70eRqg7xJo+CLUa4xjfQ2VU8WR?=
 =?us-ascii?Q?MOnVR6TRjOTRlnO5cs30hhdrcNX96qVuFWSnJR49HXebqQFVMhtKIipEnqQY?=
 =?us-ascii?Q?7hfbSs2N1/kQXd/tD70Qg88RUE4guo6pEjbSgguqjtloCPZCzeu2Jt6OocLM?=
 =?us-ascii?Q?8cEGYzHEltwk4m8B64bmRYaXW4sFkNNyTccadhgqb0esnBMjhp35h33lt9WD?=
 =?us-ascii?Q?lvkIBTR39yY39ASojzDd7NWAJuYx0ttCpxdl3/GdBgofsV+qT/D2nZOL7Rzi?=
 =?us-ascii?Q?sJn/36iNIKO/bnZSI4okZQerEW3SsGGKQl5qYPIgIK4LCJs0jMwbrsU/SBFU?=
 =?us-ascii?Q?kLiGZu+r9rUyottYVViS3qSVeCMGRg3F+1Td7WIfjNXyMZztzmRd9qg2Bd0G?=
 =?us-ascii?Q?B/XEqU3WEKgOMhJXwcjcJijlMA1adLNAucmvdC/hIjarF4TPyEHAQ7t9/+Pu?=
 =?us-ascii?Q?VjkEc8Zdx84Df0u2DnsLE+3Etiv0r+j6ArYHWNUK0cxi+qnFWXgKm+zzIIM/?=
 =?us-ascii?Q?WE0FbhGLY2icbPuxxjpsenwq/hRWvn/6xlp1uxmlTKOgKuM4SwAY0U8lRc8O?=
 =?us-ascii?Q?PlVzmJD91k7bG6qqdNibEsy29n/SwX7hhg0yr5NtJeBr+teNa1ROYS/J1Km0?=
 =?us-ascii?Q?G9NYJj9fOeCqHPWgsBNNEFooZMDw9vY+DrVn0j/xufIq41NGpYm7kQlgzrkA?=
 =?us-ascii?Q?XQb3upEeqeXC1HQjX1zHnOad/MFE4CKCpAY1qZjfmbFFt9fX++C9vMech6oS?=
 =?us-ascii?Q?KUtPKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:33:39.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c99c2ab-ae8a-41cf-ba2b-08de5806fe5b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11280

Hi,
> Hi Will,
>
> > On Mon, Dec 15, 2025 at 09:56:04AM +0000, Yeoreum Yun wrote:
> > > Hi,
> > >
> > > > On Sun, 14 Dec 2025 11:22:48 +0000,
> > > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > > >
> > > > > Apply the FEAT_LSUI instruction to emulate the deprecated swpX
> > > > > instruction, so that toggling of the PSTATE.PAN bit can be removed when
> > > > > LSUI-related instructions are used.
> > > > >
> > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > >
> > > > It really begs the question: what are the odds of ever seeing a CPU
> > > > that implements both LSUI and AArch32?
> > > >
> > > > This seems extremely unlikely to me.
> > >
> > > Well, I'm not sure how many CPU will have
> > > both ID_AA64PFR0_EL1.EL0 bit as 0b0010 and FEAT_LSUI
> > > (except FVP currently) -- at least the CPU what I saw,
> > > most of them set ID_AA64PFR0_EL1.EL0 as 0b0010.
> >
> > Just to make sure I understand you, you're saying that you have seen
> > a real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?
> >
> > > If you this seems useless, I don't have any strong comments
> > > whether drop patches related to deprecated swp instruction parts
> > > (patch 8-9 only) or not.
> > > (But, I hope to pass this decision to maintaining perspective...)
> >
> > I think it depends on whether or not the hardware exists. Marc thinks
> > that it's extremely unlikely whereas you appear to have seen some (but
> > please confirm).
> >
>
> What I meant was not a 32-bit CPU with LSUI, but a CPU that supports
> 32-bit EL0 compatibility (i.e. ID_AA64PFR0_EL1.EL0 = 0b0010).
> My point was that if CPUs implementing LSUI do appear, most of them will likely
> continue to support the existing 32-bit EL0 compatibility that
> the majority of current CPUs already have.
>
> For that reason, I think it also makes sense to apply LSUI to SWPx emulation.
> That said, since there are currently no real CPUs that actually implement LSUI,
> it is hard to say that this is particularly useful right now.
> I do not have a strong opinion on whether this patch should be applied or
> dropped at this point.
> Personally, given that most CPUs released so far support 32-bit compatibility,
> I expect that future CPUs with LSUI will also retain 32-bit compatibility.
> However, it is difficult to say with certainty which approach
> is correct at this time.
>
> I would therefore like to defer the final decision on this to the maintainers
>
> Am I missing something?

Ah, the Marc view was right. So I think the changes for swpX could be
droppable.

Thanks.

--
Sincerely,
Yeoreum Yun

