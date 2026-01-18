Return-Path: <linux-kselftest+bounces-49299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38615D396A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CA9830CFA95
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865A3587B4;
	Sun, 18 Jan 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MTGlmtY7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6535503D;
	Sun, 18 Jan 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744560; cv=fail; b=jkiqdQosjmqW0c8LKrs4xPPwNqR1Rp9vsFjOesa3+DjAEtmzEXHd4SIsoeHxjDrLwAFCkfg5jjDF+yHDH7NIa/UciN7EfNmFEH31gKW+xC7mwMCQxkNyzfyf5s+yIzWiC5rfzr2Grp+EysHDZ+DxRZBeMm4RuGBPn6HRu+Nm5X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744560; c=relaxed/simple;
	bh=YVdnHgukbTjGy9ZuSEPmcJdnE9Pxh8RckKZoie4rV04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XC49/QDRvchPVgIyx9PwrLzNL1KlNKGeAkwurQl7fSZD+ei7eZBZz7k6YRDU0GP9zBrNSX5/qEKor4zGVgzlqxoHhxv1MF2JzKw55FeMQS0ZnmkXeFoQ8icFda2XgYrq6MGH6AcmJrKtajqVMb2txi1E+Kf90odlhTwhtZ7qJMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MTGlmtY7; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN3HkOBLhYW3eQWs0+WMW2nT7wIl9TUI4pbPoBCVl62c7oxUz8zr1TUxNLEDcy+QwcC3RqtAoeoVNv3JdbDkgf3H84hiCYdX6ojsbdtgtTxh8Z+jcmruRTlvjRggmrfQxNMK/+VQIHyLU13PhB/dHnfEDFpkVLXZrsTBoTRh3UupnBelZje7FGz3xFIMqNEu2Dkpayk0oZrd6Sxc1AqBcoW5buhuqc8OBVLyTL1uM6/8ciU8iGftVEPI2KH5udAmWFZ4LAR5uJEePOv4eZMrFjSIZkBkrHCstvBLmcXdVzgp0LpZqr9ysYAU/4N3dzc76uj+9JXfi2Nic1FCBGYpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr5TAntOe1KqTU8CWEh2fbZ9UrqenNIZnJpcr9cLzYI=;
 b=Xshni+Dqczo4YmXt7qidTLOSW26FfvgRPhQzkgfLlNdFZvWUeF0vTQd8686+wH3bQg4Oq0667tzOsyEBaRwvxmP9JqYslQ644y5KocpKDvUyS8Oc8YBFwZjN5mMQpk7qXVwGvYWlmiLG0Ryjq5V5VR1YhLVKtsiWxYVO3x4kbk4/eTsJLQajsbD/VhQAQ87zQq1DqXk2IUad1KJVHH1Z0EWmJ4qUYP/SjNPwCiHGTVUOw0gOGtjvJyQ+hCUI99DXoU4e64olAeRgk5fydP5g0+9SUiYM4U07xWTZBp5xiXtzOPA9PtDnyOXv2S+S50Mxhjf3Xb5viOvJs0LsbeH3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr5TAntOe1KqTU8CWEh2fbZ9UrqenNIZnJpcr9cLzYI=;
 b=MTGlmtY7SMd2CLu7TVcTLwJsEacJSq/gGb3hLXN9BcRsSYwfDG3wuKy44bfXQyWdzwBzz4FA+80DiDmG3BoAEzZUroW27H8GYim4QWzxrs/Gh5tLY7rMSjkRuOS/jY56LYOU5SCYPcl6m0xZ3ujxz8WtpLCKKvmkglV7vviTilc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:48 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
Date: Sun, 18 Jan 2026 22:54:37 +0900
Message-ID: <20260118135440.1958279-36-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: da920d95-4ef7-4bac-20eb-08de5699385b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r6+RQcTHLBlreemx55TOdwbpWc45ipr7r5X6ePi8nMcHSnx2zGXls9m7lRV+?=
 =?us-ascii?Q?RQArVyJJhdfwFwGurQEK0Hrc8ZxeRrTy+A6RJ0CU56tqoYNX/85QmX67LFJ7?=
 =?us-ascii?Q?JAeuHaiB98R+q65GlgHpzcZIlVhxYqDCtYskmT3wNcGhVg2ERk2x0rIcdnA2?=
 =?us-ascii?Q?yaKu/dxoHWLSwSo2vijNk1wczJeHYCtfyZ/jhw1Nt1ycxrZ2M2es9YJV4ZQb?=
 =?us-ascii?Q?bdfGbdkhQrwzcRZ3tGPzzDrKYRH8xejNeZJ7H/RrJ6NM1zuklpmNhe5E5fSH?=
 =?us-ascii?Q?LWBsr9BfND3IbgRHyv6HidyFxT/slbPo0inz7vKi8v2a4QBRfYBxwSWjvqxZ?=
 =?us-ascii?Q?XT4khZK2KkhtVR5Rzdayo24LGsLjfj+cs6/nnfm8Tc1C3CqgVJQGqA2G7w+Z?=
 =?us-ascii?Q?WhqspQRRqkyC3kWaPLaKKk6U/PFW1KEl3eHlwY/8QUTEHkkUiYIw4fjoUNIq?=
 =?us-ascii?Q?0kd9G3mjouPJnCZAgnRhzHSCHR7XFbyIumST5dg+E4X0hmh5Ot64eKx01yln?=
 =?us-ascii?Q?U1QXxK5tsn32hh/8DfDneSW8oe+WjBSS6mpg2isxwSBtb4Z2PUuHzRKLyb0Z?=
 =?us-ascii?Q?MiRsMSAjCEEQbJ0cWHhZpzytYHvX4XrFZpabamZ75N91ZpRYo7r3kT9xbBQs?=
 =?us-ascii?Q?S0u9sYTFpxi53k63x4X225svP5r3TeCXwluUVek3f0FUREn+yygDv4iPWFKt?=
 =?us-ascii?Q?HUgRwdpuFbxOWqjY3BboaIWjVfZvvjEr24S7roAztQ4jjHQEPNcGd37Go0hR?=
 =?us-ascii?Q?BkhgYzauxA957D/3fMZIibtsVd3JP1cekuGLb/iB4nOnYjlgf0z0SYOK37SQ?=
 =?us-ascii?Q?7/W7JF/uvSQFF5pxvEYQrWXOKN5Pbriw5ejGjiGAG4SIQjHX5MGu3i8QgOfC?=
 =?us-ascii?Q?iP59nKPJgiXbLhnXWYF+3dJQe7wAyRCl18E9mT7jYMNjGp9JCnzOg5untaly?=
 =?us-ascii?Q?a6A6fWGqCfI/9agbUpnrvsgRQO1jF1ux3vBm4XcLGoLWPdSLoId9VxwrVLAC?=
 =?us-ascii?Q?h5dNH82Ok7nk6UY7JclKJF9FgdE0l8emWB6178G0zevOJKYySwr8B87BI4Kw?=
 =?us-ascii?Q?Xwi4w31Xc9yds40OVdZkoirfXJ3PKJ69XnBJjmBCFReGfRCP5YabOhl7DZ4M?=
 =?us-ascii?Q?SDhh41SQxf9oDn5W5+OBrOAXhLtETHSuxaOc/SUXAZ32qQpFJbiPXTfqEz6a?=
 =?us-ascii?Q?3gAoxdeXS5YNJcu7z20LE93SDjfsA9aDyLZPOlx9Xcr8QMEc6SvfLCiLoCae?=
 =?us-ascii?Q?yMIFea3r7uBpy65jye27iY2nmCXjx6WhhP2A9L9uLTukIPo9wMLhZHLAIl5D?=
 =?us-ascii?Q?M0SksnR2gBTji+2j27rO0g0Wtt+rRxCw5eHW/hKoc6hZDUoADXXjjvwUpf31?=
 =?us-ascii?Q?6hoS4Bbz7LxX7UxcCxAiogLNWbV9OOcNqRmpNiyqE1WkuVENwMuNosDbCWri?=
 =?us-ascii?Q?LiLaIccyKFOQo2lwx7J4OWahzauBKpxh9pQ978rQAzsdNWYzo2+QdR1Ty9eU?=
 =?us-ascii?Q?IORt0h0Tpj0mQCbLiJHp8FB72wDbdce4YN5H6ouYB60rVamKP5JnRhVGJ8IR?=
 =?us-ascii?Q?UzDhXiWwgY/RjBES0W3XaWvN8NXGhawRoGwD7bukO0WgH5vLOUjxV0fVuDTM?=
 =?us-ascii?Q?0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsMgRYpmOUbP9uJd7jT3yvXWgfMammIwrGG9C7QwNlAu5GuQJxcXJB7LtLeI?=
 =?us-ascii?Q?7xrnrZd8kYLDglXpZbMUZcXxZCOQ9SG4AxLgIAo8jV+Vyc5TjvQIvv9XXUfj?=
 =?us-ascii?Q?NSHOLb5uEHgf5yUtKys3HeRUl1lD38mRtmvb6xh7CnWB9430j4KNEB/Sqf1h?=
 =?us-ascii?Q?T6+Ym9OroWh9yjanX1/nfu5R6tMq77i5UvopIy0WjvYu1CIXi62dkxuMT8Rg?=
 =?us-ascii?Q?yM+pxC7UgRoMSZnbmOAJy/gwxZeEY2UEj7x45N8/6OaorWorHHNjUtbEL3YO?=
 =?us-ascii?Q?GDhFU4g6cfCoKeBGuLXCL+LobeFYcWZc97Q/gTWdbFkaI02MilwKKuZM5qc6?=
 =?us-ascii?Q?/qpDl/fZ+4DT2GzDAuv0/h9GML3z6ktS1fm+a3383nH31i7PV2D0VAQ9JC1q?=
 =?us-ascii?Q?KyReI/048DWu6XiI3QOhmOTiLW38WbGo5tu2Md728jSZO1E6te1fsw6/pAjs?=
 =?us-ascii?Q?3uBJAyl+zoV5d/Bn6J56xqatoWxSjRZMByvzJSqtBPloKaQO80Jsvdk3NSXh?=
 =?us-ascii?Q?ZttnVYVtXYzIbQ8cwzpUvEcZMPmaUonZtf7gMKSZDUhUuBOoIq5Dag7g/oGj?=
 =?us-ascii?Q?ch1mzSHnkN9+1Gdzr7KvWa29/A5DakVYlU9lgSOR6Wntn2NHpxfPu5rTZCQj?=
 =?us-ascii?Q?vQviuQ3qBKjQ2C7A2/QpWJxfeq2Dwnv6C+UTV1LbByQ15T+Z1bRtv6CKz/bN?=
 =?us-ascii?Q?Aqel8H+K9ZfI5KmXXRAdHIE5VP1OSO/ToYnAiA+J29UyX8UAbWeSUHG8H1On?=
 =?us-ascii?Q?wWX3lK+I6Y1xCDqO7JvkeoOnAEZHGCN4Q2oyopJowVEYJ5rOvoHmO7Rec7vo?=
 =?us-ascii?Q?EVbWKyxx9l4Yi4+L6CzEzgoM6r+FW6PWtZh6VK7pPE6qUNn1Hdvm14pcwMT4?=
 =?us-ascii?Q?zzrktl3G8Gyi0AIpHHv/f5uJ1m5b4HhvyjdF9GRg96OKNgHJihRkU8Bx2rTz?=
 =?us-ascii?Q?bZtUU36P1imrig6t1Fuk36vrCI6hsNVwKsIR13jT/G/ECuUPHkRs6nWRhCHo?=
 =?us-ascii?Q?qoJX+1Vd5RzQayfniCIbTDHyok4129moaAS40aLsw12To+ZGxbJxpOpjghY+?=
 =?us-ascii?Q?3OGZl7x+7lm4j5eIaUseCmcCj5MIPykPuXamVwK4v8PlU1SRUbjse8RS2aeI?=
 =?us-ascii?Q?u14ewMheKMrPZHUvnw+cEHFTTIx0hIp4ZzhzbH3cDMBMxL2MmvLCJWtj2xlO?=
 =?us-ascii?Q?F2uryeTf1FvY6XZHDcULT4bjcuHBi6x41sbecdGOZp9J+pfM4Y9pKP9XrLCg?=
 =?us-ascii?Q?kmYIpcQv3eMzyj86Sjzk4+vNSXYqPK8vBxrjH+BcdFHyQyQm3OtXRyV4UcJZ?=
 =?us-ascii?Q?TDrSxXFRuiSA5toFJ+H7djBb0vKmgStSKKpVz+jjx3JJVOjlE3kFssft4JNc?=
 =?us-ascii?Q?qAOw4cSOXCWyxmz1+42N4yLRXVyN6XS8OhdM1IcwRWSavH1N3AWA09yTji6x?=
 =?us-ascii?Q?dYNno9kw7JsF8asaV7+e5gIacw61kjgx3ILq93V7JnNB9FvtHEvUaA11I/z1?=
 =?us-ascii?Q?BoZpVtlazsRO00fltl2ACUWogfARe0uW74v4yF4FKQVfltGUwL1HbD1bCF9N?=
 =?us-ascii?Q?LKmnMJ/qZnOX9bJ7g1azLB8tNc/AiI/1cpA8nnDZEyN8eL/9pwPWD3P/2ibo?=
 =?us-ascii?Q?L+Iya3Q3q4avj8rKsur45WvhiQkEPN16KQMPQPj4Ux5NeqQ3X0HJwCQ2L0vk?=
 =?us-ascii?Q?espxPEROXYLCMEQEY30HE8ROkMZ12jDJJRYZzSKTK3BtwioJmJSf3CYZxsTF?=
 =?us-ascii?Q?272qBm6Rc49rwO93eyXCiSvI29MdTMOd12t5/jhmYOyIZu8Y8ydf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da920d95-4ef7-4bac-20eb-08de5699385b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:20.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOBetW6Mh5hubHH2kIpqrWdZS6aMf8G8ky/v6m3kknfDOitnmNv66B5Tm4XY7Lu9Bl1frpkM8atOIWPmt9bWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Introduce pci_epf_test_next_free_bar(), a small helper that wraps
pci_epc_get_next_free_bar() and tracks the next starting BAR number.
Use it for selecting the test register BAR and the doorbell BAR.

An upcoming extension needs to reserve an additional BAR, and this
helper will help keep the code compact with the selection logic
being centralized.

No functional change intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6ecbc2c2ff36..e560c3becebb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -64,6 +64,7 @@ struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	enum pci_barno		next_free_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
@@ -104,6 +105,18 @@ static struct pci_epf_header test_header = {
 
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
+static enum pci_barno pci_epf_test_next_free_bar(struct pci_epf_test *epf_test)
+{
+	enum pci_barno bar;
+
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+					epf_test->next_free_bar);
+	if (bar != NO_BAR)
+		epf_test->next_free_bar = bar + 1;
+
+	return bar;
+}
+
 static void pci_epf_test_dma_callback(void *param)
 {
 	struct pci_epf_test *epf_test = param;
@@ -721,7 +734,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 		goto set_status_err;
 
 	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	bar = pci_epf_test_next_free_bar(epf_test);
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
@@ -1110,13 +1123,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		dev_err(&epf->dev, "epc_features not implemented\n");
 		return -EOPNOTSUPP;
 	}
+	epf_test->epc_features = epc_features;
+	epf_test->next_free_bar = BAR_0;
 
-	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+	test_reg_bar = pci_epf_test_next_free_bar(epf_test);
 	if (test_reg_bar < 0)
 		return -EINVAL;
 
 	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->epc_features = epc_features;
 
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
-- 
2.51.0


