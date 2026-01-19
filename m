Return-Path: <linux-kselftest+bounces-49412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0942D3B7F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 489CD3004CC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381E2EA172;
	Mon, 19 Jan 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kgsQUGfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4A23FC54;
	Mon, 19 Jan 2026 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853240; cv=fail; b=YnMVk4yK2/wLRm7EHd5kpqp8/NP5SCdm1kOlGIxQ667LGiURYJTFp52DTp46N83aGi0K9HoQVdsLVMC6NF3YEhXmXNBELhB0oykWHtDVGg5N93uoqWR084qKC1hZ+KlSrPPjz4E2HuSS7W9ksMO919eMGJPB4FnehdLmZ4xEWR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853240; c=relaxed/simple;
	bh=gEEVvoxODt88IZAXjgorSlJ2pLHumnh6XfHZRUXqQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LwjiKkzQDdVVgQW710oFzd0IOVoJYyj2rh7RY9LCM+cINrIKMsjX8wbmgX4Gv4CRpAhHqj0/0bijMXRaPz6YKW4IgDq+LNSBbHOB2Ujc7aSwL0PEP+anTd0xl0JixV+0KJUeCDpHtFv4R/xdMwAYYGEipOplEqcZ1ggr2si1onI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kgsQUGfe; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufqlBYed1cIQZ8TAYGrD7V0FnWXLanZJFm3yqe93ISYbeKiWmpE8O3z2ODXHmwflfmyOZod9MUv9f/lBIPeni7lJ6bHTjoGNPjpoiW6poh19ggs3oSMk/WoBr481yFFFhcTNjVH4k0neNRBQUfiel3uJ6NhRIfd3U07Zg15PZLn5T6NjQFle+wnJk3phYXs1gXvKAvcrDuGYkPf+v8qzrKUEnaIqGbCn4Z1p733PmBpoYSgCZKDaKv2EbhKes8P67cPVnsvXI+qfPN/fCkKUf1vAa8Avb6iNH6TLskXqaW3TN2rpGGr8MykOSIV6caNxEWeLjK5Xp83CpQxwUZ3fZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5iZM7ZwlW8KzeqWRuKBuIGx4edAHlzWuwuEyn4chPs=;
 b=gYfbgPRLxOBkLIJKeZrwtycHkbd4GY5/Y52p3qBZL/FRbU9FKfkp/knCav+U3s+kXacSPTxg+jxl/Wgn0e1cJXPi+ojh0kvdmFKu1xQiISGtRY3mEhYg70aZPFbcWpM6L6jIQaov4u5b0a9xLjp6iAX+l2LWv7UQQKcPohROFZxVnerbxXuxQFcbGyFgiuFcNw28szLMu/8qy/W3C2ATtloTwON0Fcu3jLHX4J/wkR7KLDDIEazLFrE8hlWJ2V+ca57Gyjcj1nEStJK4Y/JIOcMNlyNFS7dTy/vYzQaD+7G32KeAnY3W/98QmV/JhFlN5ODU7nwe9QO9lFmdwyfnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5iZM7ZwlW8KzeqWRuKBuIGx4edAHlzWuwuEyn4chPs=;
 b=kgsQUGfeenijNbMmHBGQTDuOauK0/NVLOMcDn6SBCnANlskuVkOKm9886ihKHmiIQj1FGjXbtmxxT2d9xwKb/r7KyWkKcEm6XESCoc0YpnEYIzni6hbUTg8KEDsiI+1RVLTNNsdA98Rj5TucscmaY5PXPUKmFaFZYidOcdIjSFYb6WmiFHZTp7INLWDuEHFElAT+SZ4nxQs+47xmplSRcwn08af4XNwZ+MdzA67CKhLCf5YJmRZQHvHJeShQmiURFYipVzp4px6lF2uJa20ygWq5+daYSyRyRYVohwRDAnswxvKfxmAPzw0sk9wBwEAZWiAOM0deEb7DFbJ1fK7WOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:07:15 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:07:15 +0000
Date: Mon, 19 Jan 2026 15:07:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 09/38] NTB: core: Add mw_set_trans_ranges() for
 subrange programming
Message-ID: <aW6O57I1ALfLe6JK@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-10-den@valinux.co.jp>
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dd5b5f-4eae-4aa8-d8b5-08de5796574c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6LeaZxwBvGSITlz7XE1fLMdtlmI4lsrWQv2otmFlU1lZ/FazkrJnGLkrfuo/?=
 =?us-ascii?Q?dadRzvG/wwofQQ2gmXzD83Yr+RvChiyrncB0qr0xfkZ7MNWJSxKl48B1ojwZ?=
 =?us-ascii?Q?LBwv63cjDgviYmFUYuPijGyU1rPTpT5NHQWuvAnF14gdT8JaFxw4wNWQTHhG?=
 =?us-ascii?Q?KsAqXcprgTDgfGKSj7PaabisOMyq9mOKpPb9iZVdaN+b9+fcy+ayBagWomTx?=
 =?us-ascii?Q?/XUEfj86vmj2NUjbWqKbJlRKxjCESaOZhvNlBHdfKPBOcHCPbo9VHg961r06?=
 =?us-ascii?Q?A4n7yaBKW0JfdzQdgtFUsMmEy67lCxpAd0HvRlNtMLEPSpD74WxRqaNF8giY?=
 =?us-ascii?Q?O7CU5uME1cAk3wDncYWzCMyTJa6EW67UjFotVBENmgZPvY9i90GxN1Q8MgmD?=
 =?us-ascii?Q?SYFgABVx4mEzBq2gYLSeUW4GqQ73YkqwFSqwwW1MqU5D/wLFi/8+rO9Q7ah4?=
 =?us-ascii?Q?OLU/u//DcsMHIdYPq7AF9n0PwtQR78HoI/ihiCfjxnkSoAsau6m4DkLykga1?=
 =?us-ascii?Q?GeqUay+lyhn2rLJK4EJWzX98l2C49QQbhOdhf8CeFOVGI8LROJxgLuki8m3Z?=
 =?us-ascii?Q?3oNMlFkHJFKWG7S9AXMx14slRfqLuQXay9zp6zf55QvpS1kPg4EXULrBAn8I?=
 =?us-ascii?Q?b/prc9yJ65AHWFN9YT8rtfM4Myj5nfrg9pus5ofTXilOVs6KVuFDSHqIsnFd?=
 =?us-ascii?Q?p3VXS1ZPpXBooFwXIi5jeUL/hoPf79OKuSFMSE9N90De3cEXvZPSmvA84JSZ?=
 =?us-ascii?Q?vseO0b8ycxzBBIU0RREOwGxjm+HAK04SLjD90wlIybgjYSJm7Y3TcDGIXl0Y?=
 =?us-ascii?Q?B8yzjv6utwNIlE0iycpR53I7KTkby2/QlmbNYnrsN9hfTuc7opEB0Lep2xKv?=
 =?us-ascii?Q?xUSO4f2/uRGN5eD12TxHpix5aeLyIT2Lj6hLKFN0MUAmrRaCgOvgT8laGB63?=
 =?us-ascii?Q?G6dTWlffh46hRtVCpKKVnNqE3NReBwz1xZVmXB3FKMbeEIvc5UVBYMSFa58R?=
 =?us-ascii?Q?/zadmoEDvYzPSlCGS1X2iz6aHt67UBoUAsBq8EuKUAg24ZhZfvFtc0MbvLYT?=
 =?us-ascii?Q?F14qmneWMACWpVnsdPgduhvykXULbySNHGu3Z0KUavrmR09mwOFVmE6IN3Yu?=
 =?us-ascii?Q?eiNNEOccThWhlPUqbEfkje/5gqOMpbLf3LepCZuvqV/oD1/LEHWkfuTeXZI4?=
 =?us-ascii?Q?Vq8jX7QizMfPhuXjSQiWPRjLB9HkhKuPxZQ0YSG8NEPXbg0JFSmicelYbSon?=
 =?us-ascii?Q?q0OHfbVFAOFhCL3/567OAYZnR6OgmTNa3wHpTK/FcNBVqwE61f2TYee5NWJp?=
 =?us-ascii?Q?wJWfkAUZdXxeC/ILVBAYq/UvHGJ50lqoAnceRpv96vQUruO4ezwYgbgOVkqO?=
 =?us-ascii?Q?mVxYl40fMV2b9A7ikZTf4uAS9WMNmGwBL9M8hKotAhBhINbcQDPbqfS8egLh?=
 =?us-ascii?Q?A3k1O12lOE8+K33SYuriAFTIxIf7a4EVwvnGYKHE8LCWspPn3GmzCbCNf2Ge?=
 =?us-ascii?Q?Yq/FBfBCfujr8xI0+M42TKeEf52KKI1u/MpTL7G4raensFAlw4M9nJ3m3v+N?=
 =?us-ascii?Q?rlI623Tzp9wxiZoYB5wnaka9ReklHEjoEe1cL9M3AN3zTUFa8IN88WqaCssU?=
 =?us-ascii?Q?ghv09LVHJYPyiWM/ng/x6AY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a38GZrZOMkEXYF5px8gnvnZCb6e5Uc+p6O2TZ5Xgeo84Bnop3N2oQt6hw5YO?=
 =?us-ascii?Q?SqCZ+ps67N2KVxooIjtyLNnBt1WSWKk6fiWzwFpBb0VrAYwKxnjNIoUoYR7G?=
 =?us-ascii?Q?vKOsrlVF3X92Jo8Ph8rkx/A9luB7FBq6EQJ9DOJjTWL2D1afzowOui62Hgz+?=
 =?us-ascii?Q?Eq98spXN7eXX6CFZcVfUO/+v1VLm2yU7J2hQhtxtDqWVzTaQOZS9bo62lEvE?=
 =?us-ascii?Q?O4j/7G58nSDTRqb/kY2tCeKiorzNpQ0gUMhmzpaUDyk/qQ/okKPDXQPmPpZp?=
 =?us-ascii?Q?QnvdrlywB2+KwsfVbp3cPvU3t77xTsk+U0vXgyXq+TKVqQkAPjM2c39/SFB/?=
 =?us-ascii?Q?6zc8x+OcrxpeUGt4r3aF/EMOdxFydYsoPH0iVfzB9wQDxmnMDWIblXLKc0LC?=
 =?us-ascii?Q?KMM3F6PtN5spmEKUK0I+eAKFz4j0T1PpsddNmbdkwZ2SJunAp4gW/8pZ7Po0?=
 =?us-ascii?Q?3DGYyAVzBvM26q1mu90e/YtdlLICHqrFB6dLLlFyZ5eldhW9iFbCpHcgEyIf?=
 =?us-ascii?Q?QZmiz86zvcsNqDmpZO7259ke8kMmmgxdFM8N9OXU6j1tR4qdDbJ2Fker4FXJ?=
 =?us-ascii?Q?VlwnU/vaA7hlAvE8VaJjj0GsOzG2BGPLHIBwGaCj5qd2qIdz9FrqiyIhwUlI?=
 =?us-ascii?Q?76hV2GMyBBPJxkRTXPnaN/HGu7XnXrVJR5LQKSBw8z/3sC78Wl7oSIDL4XCV?=
 =?us-ascii?Q?hoTxjOiQtf7NBYhY9WwgncpVyuXA9EwnNjUepU652gMVJOhekwSlnuz0A1Yo?=
 =?us-ascii?Q?jJMsb0A9WS5h+DmEqmeP59JDJiQLCcjhe3n9wPFj9vKV8vzLfLC6QGXHLxSy?=
 =?us-ascii?Q?H9KlOP7vwdDpqw5hYq4j4BM7DnYHtJo0c+ynEZcJq4iEFqHir1bu5nW2Zq3b?=
 =?us-ascii?Q?D8T2BOTsSfJR0p08Cp6FUENB8RnMOH1rOhY4b4WBohydaDklRG0+bD12eCyV?=
 =?us-ascii?Q?XBN4Ojd/yX2MNQNISs8bRSX/VCZ72d2Mj4kxzwa8X3VFVykYqUI12CyYzIT5?=
 =?us-ascii?Q?neFOze4mYQ1/W0JOYeU+wf4/D/NK/CKb3GSXu+czlRQdQcyO207ZA4bZ4+7t?=
 =?us-ascii?Q?vC/F1UklpZfRYbO5jS1nCQkEgh9r4kSnbSI5LHatJ9fHACubsmybCa6r4Ds8?=
 =?us-ascii?Q?1BM/VttW2rDRhei8Sd/wSc2ag+yQUenFLCQUZsx50sn+mWcDYIkcm/7y4Ilk?=
 =?us-ascii?Q?CiG838FKCEexXNs17H0fC0RHVgUgBWCZ3v9hqpHEAspY7l0pA1ChhVEW5HvQ?=
 =?us-ascii?Q?UXOz7/vcYTVq1+js0Cr15YWSll4ipkZAigV/G66G9iJXiUwhnopEomXUz6Ty?=
 =?us-ascii?Q?gCNiYmlSCu7OQ94rk5gLSWmXfSGZFSxQPxTA9Vl4h7HDCMnBWzGkBKX+qjqw?=
 =?us-ascii?Q?tSKQMgv/ao/Z7CxICmdisDKwFVUCYdZOUAvwj6EIdaU2tlhn0n6gLflmvq/n?=
 =?us-ascii?Q?tu604IzyRQ5h6F1Wu2lwcCKPkye34SPXoo+Oo4oMzx1RiFxJpLpnCB7WIr3i?=
 =?us-ascii?Q?7auZd9UT2BCueWHA/J3+HZ1425mNWUn64uRpkyebsH2p+jfkMKhHemC1soCl?=
 =?us-ascii?Q?X7pypFWd281w1aAv/6M3dbIks5Y0xJYtnMEqCJSl9baOyIRGooPNwpeOyDTd?=
 =?us-ascii?Q?SuoXLifRlhuTTUoIyyXwlGqbrWrhQIdrSkztp5uCm72evaQLDF0scVFHbkiO?=
 =?us-ascii?Q?MQmzdvABy7fbm3DmGZOKgoOfzlAmgjHbfZLZy20npYqmydL0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dd5b5f-4eae-4aa8-d8b5-08de5796574c
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:07:15.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px7F5w/0HGyizAKmQGw8p693gpExPvpGm9OC8IASXsuzcTgIG8M4VF06cNneIdq0AXIMiQbwt3En7qNSjsrY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234

On Sun, Jan 18, 2026 at 10:54:11PM +0900, Koichiro Den wrote:
> At the BAR level, multiple MWs may be packed into a single BAR. In
> addition, a single MW may itself be subdivided into multiple address
> subranges, each of which can be mapped independently by the underlying
> NTB hardware.
>
> Introduce an optional ntb_dev_ops callback, .mw_set_trans_ranges(), to
> describe and program such layouts explicitly. The helper allows an NTB
> driver to provide, for each MW, a list of contiguous subranges that
> together cover the MW address space.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  include/linux/ntb.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 8ff9d663096b..84908753f446 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -206,6 +206,11 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>  		1;
>  }
>
> +struct ntb_mw_subrange {
> +	dma_addr_t	addr;
> +	resource_size_t	size;
> +};
> +
>  /**
>   * struct ntb_dev_ops - ntb device operations
>   * @port_number:	See ntb_port_number().
> @@ -218,6 +223,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @mw_count:		See ntb_mw_count().
>   * @mw_get_align:	See ntb_mw_get_align().
>   * @mw_set_trans:	See ntb_mw_set_trans().
> + * @mw_set_trans_ranges:See ntb_mw_set_trans_ranges().
>   * @mw_clear_trans:	See ntb_mw_clear_trans().
>   * @peer_mw_count:	See ntb_peer_mw_count().
>   * @peer_mw_get_addr:	See ntb_peer_mw_get_addr().
> @@ -276,6 +282,9 @@ struct ntb_dev_ops {
>  			    resource_size_t *size_max);
>  	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
>  			    dma_addr_t addr, resource_size_t size);
> +	int (*mw_set_trans_ranges)(struct ntb_dev *ntb, int pidx, int widx,
> +				   unsigned int num_ranges,
> +				   const struct ntb_mw_subrange *ranges);
>  	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
>  	int (*peer_mw_count)(struct ntb_dev *ntb);
>  	int (*peer_mw_get_addr)(struct ntb_dev *ntb, int widx,
> @@ -350,6 +359,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		ops->mw_get_align			&&
>  		(ops->mw_set_trans			||
>  		 ops->peer_mw_set_trans)		&&
> +		/* ops->mw_set_trans_ranges		&& */
>  		/* ops->mw_clear_trans			&& */
>  		ops->peer_mw_count			&&
>  		ops->peer_mw_get_addr			&&
> @@ -860,6 +870,42 @@ static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size);
>  }
>
> +/**
> + * ntb_mw_set_trans_ranges() - set the translations of an inbound memory
> + *                             window, composed of multiple subranges.
> + * @ntb:	NTB device context.
> + * @pidx:	Port index of peer device.
> + * @widx:	Memory window index.
> + * @num_ranges:	The number of ranges described by @ranges array.
> + * @ranges:	Array of subranges. The subranges are interpreted in ascending
> + *		window offset order (i.e. ranges[0] maps the first part of the MW,
> + *		ranges[1] the next part, ...).
> + *
> + * Return: Zero on success, otherwise an error number. If the driver does
> + *         not implement the callback, return -EOPNOTSUPP.
> + */
> +static inline int ntb_mw_set_trans_ranges(struct ntb_dev *ntb, int pidx, int widx,
> +					  unsigned int num_ranges,
> +					  const struct ntb_mw_subrange *ranges)
> +{
> +	if (!num_ranges || !ranges)
> +		return -EINVAL;
> +
> +	if (ntb->ops->mw_set_trans_ranges)
> +		return ntb->ops->mw_set_trans_ranges(ntb, pidx, widx,
> +						     num_ranges, ranges);
> +
> +	/*
> +	 * Fallback for drivers that only support the legacy single-range
> +	 * translation API.
> +	 */
> +	if (num_ranges == 1)
> +		return ntb_mw_set_trans(ntb, pidx, widx,
> +					ranges[0].addr, ranges[0].size);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  /**
>   * ntb_mw_clear_trans() - clear the translation address of an inbound memory
>   *                        window
> --
> 2.51.0
>

