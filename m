Return-Path: <linux-kselftest+bounces-49279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325FD39626
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F6D130768AC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05A33B97F;
	Sun, 18 Jan 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XV+xOMSU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020076.outbound.protection.outlook.com [52.101.229.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60533987A;
	Sun, 18 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744527; cv=fail; b=mwVHURO6ooVbe8y5L/raXl5nlGwYf83MtQ4g61CCqT16+EeuIm9dXuEfqEyNU+l7IUfeYJcsqr2n7C+MRLVrRa345a5jxPApBtVtb2L9ulH+Y+v0xSbmgC+SXb2GSA364A5bCkEe3ghxniuWk6/rOobHm4mksCroA38SyrJ5zvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744527; c=relaxed/simple;
	bh=ptEkiguE30cAc+dA8r0kK9F3SNAx5uW4xXucSTzted4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pijmab1qCoQBOPd91WkhLaNHgh63jfn2946/Om8zv5Y7uv2jHRUjT5N7wLlRU0Lw5ck5JQH09c96qwDYFMP8IFM1sXEfnLGhan2f/qVRuzi4VCr308++TwUogPdrcYlbJBAyeZRbI+uKRHV0xkqIjGrH5LZ2EeGKT9Eb0/V5b10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XV+xOMSU; arc=fail smtp.client-ip=52.101.229.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtnIiqHUngsSUhj/QWfk8jeDc34X9/rEy2llFWEe3tCE2+Eovi3mz0tEkI3xb+Wzlv0ldYFwXc1eoToBSvPa5R0llFLjEK8oPlLcJ/Ir8FLbSKQGUYb/xOni805bi9WPhSbXbn+mjkKHGI9XWcMfyZQrLhyfG50LlfVQh8P43nXg1F9OCnv5drJC3RAf6R8f4Akh8dRfc79BwSllI+nKqbK7pLqKqDVCNUMNLAAlduNUcgnhlWz/R2DTWGy/RElepae8xvGNJACm6H9ErsqxrkIcPmI+M6N6Eh79pOFwbzA0UM6ei931B8NRe/MNVWJTrxq/RI0c5z147yqEIIxP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7nQz2U8e8YtSht/Yh6qbw6d/tWpqYajGnDsJGGdX4s=;
 b=S2e9z5gJeJv/hnkGZ0zgQoKvWFYQVj7W3zbpgkN0L+etL3A04JlrB2hFn149aWfrNAqP+nm9eVBAz1G064ovowvBGOOYhTeQ+e7ieXjFO+HiEA6xVbF81pEQ0Sr5Shk7Yw/8p+Yq+xAlcDg4qQri0+ToxL3DvDlvYQRj9FI1B91PyjJ310rieRSgrNGf850N13wFaStIveJB/i7xwQ613gREQY3nzD4hvpteRyK+pU4e4TBDg0Bt7PtnF/dlT2oiSgVdKk9ej7tT/kaJ2foJTSzY1MSGl54JryCqaV7GNDuqo65haA2t124dvnO9/ADM98g8MANFA+qGMbm+KeEueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7nQz2U8e8YtSht/Yh6qbw6d/tWpqYajGnDsJGGdX4s=;
 b=XV+xOMSUvWZ6f6NJv3pAycE6kLYP+Vl3etzLzBvOlmfIpEKrrOCIvp2fNr+FCxkb8I/cz+qsDqtQVOufyRZ/silaUWka9cfpN7sPF7qIUKHlmu6qDX/WA+usfjK7M4N1VWqbJSmgkScdu8ufrjVBRb/H5t3lkgIrGVP3ZZZMJ5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:02 +0000
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
Subject: [RFC PATCH v4 13/38] PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
Date: Sun, 18 Jan 2026 22:54:15 +0900
Message-ID: <20260118135440.1958279-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f7efc4-5fd5-4c5e-b1e5-08de56992d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCqLUIyHFuLT2VmVyda+uMlFJffjO+05wiccw/daXgs2sG+PuidzsVI/CtRS?=
 =?us-ascii?Q?4fIW0Na5hsq49VEapwH00mqcAYuqgz3Db/neAtnKnhqq7NbzMZCcsm+bhzZ/?=
 =?us-ascii?Q?0S2ynl44AS8zBgVeLTfI8+6K/SrkeWtGdMk73mKkwXt59d3t25vcjyRdbD0u?=
 =?us-ascii?Q?xdqVWhvqX1GiaPPv3Vak0HxnZ9+CTioixs1S0noSO59fN4f0iDCtCHc8fHol?=
 =?us-ascii?Q?beQYM9EjfUAmxbY1vSR78bh+9aKZIlOjDu0ewd4UOk1WCJgkQFRjqg+XnFGS?=
 =?us-ascii?Q?mSoiZxyD4Agg6qB9IiTXoHg2WnJzqBfB6JAcoRsGGBlGYM9FvLc1MMQ/AREj?=
 =?us-ascii?Q?hu9A0uYHNqzpI5805y0M9fYEn2Yyd+ZpBaikXnvKHqZn5DfZI4UcT+/rQEh+?=
 =?us-ascii?Q?RfjgrvQEr9hozSitp3gv6L+5lpZCbr/YCYjjM2ZTREylRq4shSgBz6noKS+h?=
 =?us-ascii?Q?db5so+KKXQaqC+kYR+7UX2umEUsDpW0S1ty/I+XO3XJ6QQYHTt3ktfG8H8f9?=
 =?us-ascii?Q?hB5zLwRsK2L1SCg/H86KshAYUU5BpJUFJBbkQJyevJfzLtciSKUb9jSqiBnH?=
 =?us-ascii?Q?e95oJu5uN4xhOyZTJhnJpcggycmBMAlnrhVQSsZHm1gK/2hfLJA2Iq7o/Odq?=
 =?us-ascii?Q?vyMeHgmHBfmy1wR220f9n6HT7KcDQ4N3RWMnU1XZqBohcM7biFgbPIHD+214?=
 =?us-ascii?Q?lxLCsNChxaS+PSpmmmrH3kw1EuE81mVgLHMQNHUxXSahIaT9HhUVPhtqQ/G3?=
 =?us-ascii?Q?Xf/r6Tcz5CnSfE4ZPOU5TaGcXjxC3VuqXEE9TFRNevWief3Z498dI0opD2ft?=
 =?us-ascii?Q?s/WmkTYUDqmTszYrAmIVv3paEzOmLkB8ahCod1LYHvenj27GRy7jWRJ9htPH?=
 =?us-ascii?Q?FT8iGTEUA/ek4Mks9SRI3khjMzE9y+fRiFsX9vKAEj+pDxG0hLmO2KxEtOE3?=
 =?us-ascii?Q?3lLjDce+39oN8tiLjbJ7ZwllcLoVkHcDlHV4fs3JjwXoJZvfs0fBtlTeRvgp?=
 =?us-ascii?Q?6r9ma8WiXeJ0J5Q8MJR1oS4MY5Zk09XIH9imJwawYbuLnqS+hHM4bs8dDRnx?=
 =?us-ascii?Q?IsvadK0F18ldcWPj8rAPHeZu7rPRr0DIOxAeIQbxM9KGWCO6fIEV5vPgwYuj?=
 =?us-ascii?Q?/JYLSF8sw+k6457O0vWvBJa4jLQVu6LJhp6qUJzKzL3WccqAMGsMQQMMkPp3?=
 =?us-ascii?Q?mlnsBcX2PqN04RSspCbznjb6DQb2TyMvJOWmM1uJJoNrcxydfbbizGXswCIK?=
 =?us-ascii?Q?GUyYYJs5XXcE5jyKTPRksm8nf81EvGmnconvPuR0piIELKqvddgWK5gWqtsW?=
 =?us-ascii?Q?hspaTntgBcwqZUSClVpooXJOLk6Jh0WSnpwJ1YPoNGDrF3ukISxTb5wDGJp8?=
 =?us-ascii?Q?YdNnXpKVENviPc/nvuDq/hC05ChUCIm0v3D/sbcdJRkgLfJkIW4eeH4bYlHp?=
 =?us-ascii?Q?rQsZkaXFp7MZbiAcx6zg6bBYIMblHh6L760p/pYj626TsKQ9ygV7+N8gfOe/?=
 =?us-ascii?Q?IooM8As+W76zIYaVAIjiTyKW0xc33UkODhbbKF30p4xlFV9q1MB9498n5thJ?=
 =?us-ascii?Q?Lhij48vGM3yZ/vFnEps61kJKQkO+LUEGOIuEGUek+E9yw2lDPKXxEQKuuskc?=
 =?us-ascii?Q?mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZtCSZZu7ElrTmuPuD1drqSuv+/67h7bsnYXcmRLoCmZpOxRsvZZ0LUOUrz3?=
 =?us-ascii?Q?2bs/eh9fKSvfRxmhO9412FQkQyGMuHv4stB2W2hMyPKMtHNLaarxDYlG1O30?=
 =?us-ascii?Q?UNaKxuyC/9Du0upzfoLR8cYSjvjIlpPqPTthM2DM6SVMVk3I1z0myK6J0ZM5?=
 =?us-ascii?Q?GHnPFgrBt2Wo/VLyL1rt+AuZ6HWnGYhfAEPORa9G3I2c912Rpr7c7bEhbHgd?=
 =?us-ascii?Q?FSrfm9YH45vMZ+tZNyxeZx40nvKIazc3e9paqj5BrrgXqqBNy0QJEBpz0VQZ?=
 =?us-ascii?Q?K4yftdBkxx54YJKTKcQpstt0BKZ6QugrOiwq6jdEbE8gXCdS4Zrbr0xJGooX?=
 =?us-ascii?Q?3kjIVC59Wlv71mXaPDz5pz3zRfZyZjX+CnAcPGCFe7TkDLYh8pdIMwl2o8rS?=
 =?us-ascii?Q?CCiTBuWQRb5mV6VhP6D682ot0zQC5OZU+WXr4hcjGprxXiqieYN/h5nk9mUw?=
 =?us-ascii?Q?NGlBnYfS3kk1E9KXP98dYWuEM0NDD7zwnnkgp9a8Qr12TTTXWV3GOpmIeRIn?=
 =?us-ascii?Q?LOJh8GcJtOGt/L9/Zn8dtKGaprODHCEmpNVWCCl1/o1lV2I2ZO5s04uIw/PP?=
 =?us-ascii?Q?WX6573B14Zp5D4A1GCXIvAnbbHEYvbJZ4lrxf89x1ZDRiCfI6mm0qVKoZRgg?=
 =?us-ascii?Q?KCQ2Q4cOBWjLN1O5hbUXsvbvYedMZfaUEFQhLzjMgGHpaXKAn2nSwJs/sgmO?=
 =?us-ascii?Q?ZTFXpfCgKf8b8jvyRi3MyncRmx2sLSAfXorm6Ryn8lEMMZ54lcVKDAmGwUwh?=
 =?us-ascii?Q?xRXuCZEeRmxurV4NZrAtTsJ7HybXKKi0IAfsuddStXXQDL3GHgjgcjFTRs20?=
 =?us-ascii?Q?KomBZg9HOnQWoptCVXMdMXRgC4xNzH8f6dLQ9i1Sy0MR1BwMaZhoWjHo5+CM?=
 =?us-ascii?Q?SdOG8bUXQt9moazyTaWlCWZmHI2EYiAQeUuZ2pxUD1gOuCWnXIk7cdBVZjKR?=
 =?us-ascii?Q?2O5o+zEQ1n3ZbIYXuCeTiFm8VzQTsAxXEXbejRCk6KQRdA1A2nso1rXrMwm8?=
 =?us-ascii?Q?hKpllvsCKdlqhKgExf+V8V7SNLm6G6Ot0zxlpjJwaQfAUg+Sy2RoAsU1pNn/?=
 =?us-ascii?Q?FOXeCcDEkXlyWNOMj9iMlyjhKJpNOfkUOmUw6LBqyZcNsAHkaajaES5bpsZA?=
 =?us-ascii?Q?fCGQYkydrlzomfYiOMskFqJDMhyTwVwxsV2qMualKRkcYN+xIl5zAgom0oec?=
 =?us-ascii?Q?1Z0aczeOy1RxitVB2S+wWeZ9zOdZT2vhU7hSX6aW+1uuIF6fbpqP3oFXs4X6?=
 =?us-ascii?Q?U9LyiToauj5TTyVw+GExnlUvuPAmtuJCv5QvrlpWqsRRO2cUHe5d2yISraRn?=
 =?us-ascii?Q?Bc/u2z/HOvmMULGLObQAsQa7LBzB1LZpfVx2hCSdWCNLZz4qZo0cbsZJQl4M?=
 =?us-ascii?Q?M/ZDKjE17mElcxZ/UmNKa4dAuGEDI6TwzfttNe1kVJkZf/E1XXvsx4qPbC7u?=
 =?us-ascii?Q?JesRQ7NxzAPyTnI4uLrrq1w5Qu/ECPQSGaLeH7OgVQqVIE4WafYKHvY6rbJZ?=
 =?us-ascii?Q?r14E2VqrrP6DkZxoX0g04bhFfK8bhHS3KcrfvQqxH1jS/9ULUceX55eEO8dP?=
 =?us-ascii?Q?z+qAYeX9ywF5pZ7E/n09Vt9mmK/VmeAa+HLbcUOMuyX+djGvV4YVERBVvrU+?=
 =?us-ascii?Q?rbH/kCL/utU44D9EcsY3DlYyrzfn/vgAJxBWTNcdUkOQ8iVOjvSoo05Rwe21?=
 =?us-ascii?Q?QpeH9f52npfOTobDpal/ffSUUEJYEDMbnyxkEnBXGTXQyt9xj7NiDXidtMBO?=
 =?us-ascii?Q?lMA4xlb8oABxSCu7UFm9nBzo8ROhIb2I5k9oby9O5uiRiMQyqty4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f7efc4-5fd5-4c5e-b1e5-08de56992d7e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:02.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsXj88Y80hQ/YHaR01LIRjs59NRoYOTXq+7y1c+SbkLZyxIUcHuDitbbrhkQz6TktG8+Zy25DZJLCbl0mBDa+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

pci-epf-vntb can pack multiple memory windows into a single BAR using
mwN_offset. With the NTB core gaining support for programming multiple
translation ranges for a window, the EPF needs to provide the per-BAR
subrange layout to the endpoint controller (EPC).

Implement .mw_set_trans_ranges() for pci-epf-vntb. Track subranges for
each BAR and pass them to pci_epc_set_bar() so EPC drivers can select an
appropriate inbound mapping mode (e.g. Address Match mode on DesignWare
controllers) when subrange mappings are required.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 183 +++++++++++++++++-
 1 file changed, 175 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 39e784e21236..98128c2c5079 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -42,6 +42,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 
 #include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
@@ -144,6 +145,10 @@ struct epf_ntb {
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
+	/* Cache for subrange mapping */
+	struct ntb_mw_subrange *mw_subrange[MAX_MW];
+	unsigned int num_subrange[MAX_MW];
+
 	struct epf_ntb_ctrl *reg;
 
 	u32 *epf_db;
@@ -736,6 +741,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
+		ntb->epf->bar[barno].num_submap = 0;
 
 		ret = pci_epc_set_bar(ntb->epf->epc,
 				      ntb->epf->func_no,
@@ -1405,28 +1411,188 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 	return 0;
 }
 
-static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
-		dma_addr_t addr, resource_size_t size)
+struct vntb_mw_order {
+	u64 off;
+	unsigned int mw;
+};
+
+static int vntb_cmp_mw_order(const void *a, const void *b)
+{
+	const struct vntb_mw_order *ma = a;
+	const struct vntb_mw_order *mb = b;
+
+	if (ma->off < mb->off)
+		return -1;
+	if (ma->off > mb->off)
+		return 1;
+	return 0;
+}
+
+static int vntb_epf_mw_set_trans_ranges(struct ntb_dev *ndev, int pidx, int idx,
+					unsigned int num_ranges,
+					const struct ntb_mw_subrange *ranges)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf_bar_submap *submap;
+	struct vntb_mw_order mws[MAX_MW];
 	struct pci_epf_bar *epf_bar;
+	struct ntb_mw_subrange *r;
 	enum pci_barno barno;
+	struct device *dev, *epf_dev;
+	unsigned int total_ranges = 0;
+	unsigned int mw_cnt = 0;
+	unsigned int cur = 0;
+	u64 expected_off = 0;
+	unsigned int i, j;
 	int ret;
+
+	dev = &ntb->ntb->dev;
+	epf_dev = &ntb->epf->dev;
+	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	epf_bar = &ntb->epf->bar[barno];
+	epf_bar->barno = barno;
+
+	r = devm_kmemdup(epf_dev, ranges, num_ranges * sizeof(*ranges), GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	if (ntb->mw_subrange[idx])
+		devm_kfree(epf_dev, ntb->mw_subrange[idx]);
+
+	ntb->mw_subrange[idx] = r;
+	ntb->num_subrange[idx] = num_ranges;
+
+	/* Defer pci_epc_set_bar() until all MWs in this BAR have range info. */
+	for (i = 0; i < MAX_MW; i++) {
+		enum pci_barno bar = ntb->epf_ntb_bar[BAR_MW1 + i];
+
+		if (bar != barno)
+			continue;
+		if (!ntb->num_subrange[i])
+			return 0;
+
+		mws[mw_cnt].mw = i;
+		mws[mw_cnt].off = ntb->mws_offset[i];
+		mw_cnt++;
+	}
+
+	sort(mws, mw_cnt, sizeof(mws[0]), vntb_cmp_mw_order, NULL);
+
+	/* BAR submap must cover the whole BAR with no holes. */
+	for (i = 0; i < mw_cnt; i++) {
+		unsigned int mw = mws[i].mw;
+		u64 sum = 0;
+
+		if (mws[i].off != expected_off) {
+			dev_err(dev,
+				"BAR%d: hole/overlap at %#llx (MW%d@%#llx)\n",
+				barno, expected_off, mw + 1, mws[i].off);
+			return -EINVAL;
+		}
+
+		total_ranges += ntb->num_subrange[mw];
+		for (j = 0; j < ntb->num_subrange[mw]; j++)
+			sum += ntb->mw_subrange[mw][j].size;
+
+		if (sum != ntb->mws_size[mw]) {
+			dev_err(dev,
+				"MW%d: ranges size %#llx != window size %#llx\n",
+				mw + 1, sum, ntb->mws_size[mw]);
+			return -EINVAL;
+		}
+		expected_off += ntb->mws_size[mw];
+	}
+
+	submap = devm_krealloc_array(epf_dev, epf_bar->submap, total_ranges,
+				     sizeof(*submap), GFP_KERNEL);
+	if (!submap)
+		return -ENOMEM;
+
+	epf_bar->submap = submap;
+	epf_bar->num_submap = total_ranges;
+	dev_dbg(dev, "Requesting BAR%d layout (#. of subranges is %u):\n",
+		barno, total_ranges);
+
+	for (i = 0; i < mw_cnt; i++) {
+		unsigned int mw = mws[i].mw;
+
+		dev_dbg(dev, "- MW%d\n", 1 + mw);
+		for (j = 0; j < ntb->num_subrange[mw]; j++) {
+			dev_dbg(dev, "  - addr/size = %#llx/%#llx\n",
+				ntb->mw_subrange[mw][j].addr,
+				ntb->mw_subrange[mw][j].size);
+			submap[cur].phys_addr = ntb->mw_subrange[mw][j].addr;
+			submap[cur].size = ntb->mw_subrange[mw][j].size;
+			cur++;
+		}
+	}
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, epf_bar);
+	if (ret)
+		dev_err(dev, "BAR%d: failed to program mappings for MW%d: %d\n",
+			barno, idx + 1, ret);
+
+	return ret;
+}
+
+static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
+				 dma_addr_t addr, resource_size_t size)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf_bar *epf_bar;
+	resource_size_t bar_size;
+	enum pci_barno barno;
 	struct device *dev;
+	unsigned int i;
+	int ret;
 
 	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
-	epf_bar->size = size;
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
-	if (ret) {
-		dev_err(dev, "failure set mw trans\n");
-		return ret;
+	bar_size = epf_bar->size;
+	if (!bar_size || !size)
+		return -EINVAL;
+
+	if (size != ntb->mws_size[idx])
+		return -EINVAL;
+
+	/*
+	 * Even if the caller intends to map the entire MW, the MW might
+	 * actually be just a part of the BAR. In that case, redirect the
+	 * handling to vntb_epf_mw_set_trans_ranges().
+	 */
+	if (size < bar_size) {
+		struct ntb_mw_subrange r = {
+			.addr = addr,
+			.size = size,
+		};
+		return vntb_epf_mw_set_trans_ranges(ndev, pidx, idx, 1, &r);
 	}
-	return 0;
+
+	/* Drop any stale cache for the BAR. */
+	for (i = 0; i < MAX_MW; i++) {
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] != barno)
+			continue;
+		devm_kfree(&ntb->epf->dev, ntb->mw_subrange[i]);
+		ntb->mw_subrange[i] = NULL;
+		ntb->num_subrange[i] = 0;
+	}
+
+	/* Not use subrange mapping. If it's used in the past, clear it off. */
+	devm_kfree(&ntb->epf->dev, epf_bar->submap);
+	epf_bar->submap = NULL;
+	epf_bar->num_submap = 0;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, epf_bar);
+	if (ret)
+		dev_err(dev, "failure set mw trans\n");
+
+	return ret;
 }
 
 static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
@@ -1590,6 +1756,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
+	.mw_set_trans_ranges	= vntb_epf_mw_set_trans_ranges,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
 	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
 	.link_enable		= vntb_epf_link_enable,
-- 
2.51.0


