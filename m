Return-Path: <linux-kselftest+bounces-49422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC2D3B8D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F25302356E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B82F7440;
	Mon, 19 Jan 2026 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mOE0uRNM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D0500960;
	Mon, 19 Jan 2026 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855666; cv=fail; b=dcbEcG2OCcVetMdupD6h1TAvw6fwwnOoUlWoIRk3mAxB5NXoVZH8dIk1SMRt4BzSqcyKGOzr2C2zl9JA82RaW7xrsdWEBNl79d1PgoK940My6GgWeMZVaZg/bbZj91XGlwPhybtPVap7QdO0/rHccACfxlyOty1TXHh7z0ik/pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855666; c=relaxed/simple;
	bh=/jZ+VFo8ubBvgHshFOb/XvlHwsYrLXZgTnauK0NIFtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INONEltwJo+mQD60cDMS9HK3wgTiXaX5YZtGai7B/7d0Abg/yyYig48pVeEgYjVEDLbfxn689eHiZ33r1DRp+E7U9eFuiYGZiF+aQpXG51dYpk4oY4+rJ9VgJsZsY+MXPrqk2EoQxLMrMtd24K06dVKrNJzkIk/bv3/4ztHvn8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mOE0uRNM; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTGRo+nVqmEvPFpNCpxfoVzeg9NvcytM+CJm19IyOaZECso0w/g2F8pYnqOSkvHq0vWdNTocHKN1jwj9UuR7ikHSal9uj7g76AX43mnHx+OQNmeC8XbiVSkbgJL9DIDp/b1suKizQnnCMQPxm2R86rAsP+kRLODa5sIIHFWZwN4bId1ac2rdKU6/Uh/d5M7BfwPd7LxECkUslYr35x+AAPU+r463cWYWGMzlOvbjtVian8peCFemi82DhmzqY5IHGr7W45+d/sCqIhg7C0bzq4tRVDebsLbvgjDj8VjkDfZqLPZZIeqkWk35FRaj52hwZ1lWKYV1kPDBBEX5AeI6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY5LKv4oCUhPexRPBkdD49RmNhecKYm84Hd+ebGpZPI=;
 b=PW69/F78O66cO30KsxjLbO/eUtEw8+WAhw//V5YYiBvvn59Jeh2qzTw9x26N9nRUFE/ZfEGm/nt71TwzN16yDRpWGvDsFeYRMYTBaXTI2UkRkf+J1XSKr/pNLgxB3kbk1QW5ea1GdcOQVr0KuDxkltzpH+OnhWS7BV26X/eLOeBg9phkYv4bZusOC+HwR7pNBll9Wf93jUa3VPhkTNV82lZEKMF8XQYuE296owI974i63DoPtGV7VTQdvQRANUMk9N8jvpXkpZirWRPZWuH2N2v6eg1Ek3Khmf2GmkrGLyiHwWlFxr85f0Ctt+w5PXVI1nJqGI2RWxXT4KNuMdHpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY5LKv4oCUhPexRPBkdD49RmNhecKYm84Hd+ebGpZPI=;
 b=mOE0uRNM8BX8o6RljBPW4NJjKNgLmgdFxUbjXldWW3uklnucgbfJ4WIQwYmHex2D0fHI/dloQPaoL247MDSatgkH6M8C5aPqo5O4fo0+PSquu+KN7MtBfiSK9o2vU24Zoi36qoP+nosHGatLGC8a6vE5Ph1KIEMLwDA7x+ZI0/x2sSc6s9VwBXNU07xywupc2Hy5q0zRPVQg6mTkghXQqRABfSACJJkxAaTrz69sqo0sq6g6Uql99EwqRXgKGxNpG1ouzt2FrigJmPgw+ci7BoNKIA0Plz6HirV8qndwrFDjUzPpW0Wm6mcVbWQ7geOBFOaH5qgA6oPG/GhrmHrx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AS4PR04MB9575.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:47:40 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:47:40 +0000
Date: Mon, 19 Jan 2026 15:47:27 -0500
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
Subject: Re: [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote
 eDMA-backed mode
Message-ID: <aW6YX0A0Ogc6KLF5@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-37-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-37-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AS4PR04MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 30baabf8-90b1-42e0-163f-08de579bfc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014|7053199007|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x1offhixC2MWJhC2XP3b7VPAB0z3b/E9056cIWsMmyVRaFM1cSy0QBKpmUk4?=
 =?us-ascii?Q?wZEKpeymMHiJXakjeLnddMVVOCY87D02g6M4nGbFmWgQ/jMELeQRsUmJFgv8?=
 =?us-ascii?Q?/1RqV5cX1A1EW7qtmeBwJ0To5BGfXk3wJXC/5u33c4VN3CtEToJgyiPQqogS?=
 =?us-ascii?Q?klaYyCmGccIeToXAJJNH68G5fa2GJ7GBX+kZMrH+eyPXaUmZpHKJud0E0sy1?=
 =?us-ascii?Q?FR7Q2UU/v/SJHsjZmomASV4pSuKYfFlQaeJr0SIttazS1Aw0Arp+MmW/l2ED?=
 =?us-ascii?Q?RkxwhsDPAjtFbXNVOOeR+RJJUpzWdsd0KtTF4fxKd0a1nRp6P5eWV481bzWu?=
 =?us-ascii?Q?tSw4EgsVapQKTl5OkD2G069vWrQH0Mmdl4n2nJetJUWPPbQAp8x2P7mfsrTz?=
 =?us-ascii?Q?of/CloZbq+XRSq7MYHkADrMaIAneGB3bTPhsAl7ws03A1gh29xNd/1eco6l0?=
 =?us-ascii?Q?vAcAIfju7t3/hOR9s54NGIpWvm75tJGjE5ZoYghZHbO6NgblsuMkww+w9upP?=
 =?us-ascii?Q?qmVSy/HbN40ElrTD3vyTbk6hPoO+6owHumnkI691ixUQUcikpLb+m2QgGPXU?=
 =?us-ascii?Q?AyK0gjg6nGrvKsWAn/QXwNESZjdWy9zKpPmgJQdGsw24+10EANuHt45DzR/5?=
 =?us-ascii?Q?jT3S29arxvW+fG1HZVSyij00bRClMSVUGUe1Li6NKZyB2d33XmnKcg1OrbKb?=
 =?us-ascii?Q?8EPz91HGOU1nSVEJ8/SJSrQsAB/PqKIchW3EKSGGoFqzsFyInby63Qwbue6q?=
 =?us-ascii?Q?sWPIJ8QRRmXgwYcO82dUBsmrnP72qdnBwyYQtA/n6ABrs4duvuFHNQoI0Sm7?=
 =?us-ascii?Q?V4ruyyOYUFsLise9BGoc7kBsjjR/VvW2yqBKfaCbm33Ewp8QWN7UCzhPVNWI?=
 =?us-ascii?Q?oPune2sdBRiAoUT2FUUFmf0JXwZP0SzkK/g38YguSkVZt1Yy1eriQuWFVwig?=
 =?us-ascii?Q?sEQu2wqQPyk7RtiGeKE51HUzz/taHv94+qLK6pRwwPz8IqlQvIMDiP/pC8tP?=
 =?us-ascii?Q?47sBTZ9PcXZx4+Z/WzfxbJYMmrrVyRCpjCtXOfYofxqmcrQJanYB5E/RfxkG?=
 =?us-ascii?Q?WIT4lQIQV4eDyTKGq6nnpWDU5tLFtDHluHBOZnqURE9PL2EkfgTUb8q1vgGF?=
 =?us-ascii?Q?lsvGx7jLGGoMWLjddK+1GsSWOlLoWkdshtiKk1ATjb5I6M4iASf6g/qG94uL?=
 =?us-ascii?Q?mzEWuhpjueRGQnchXDI0XOKhPFWzkZJtEz/jzsXbidwVMCCU3+1gvFG2q5gx?=
 =?us-ascii?Q?REmWOdWcFCaebqNWVQkyOK8xUX3Y731Bdt6ba2XWCuUswEzZgsbqDS2eur5a?=
 =?us-ascii?Q?q91NlAfvxMJCtGXxjOcd80AThew2herZkWOxp5ljQohKKBAP7pY9PF5powom?=
 =?us-ascii?Q?aZhZ1j5Olgt3cqKh/j7d210rvIb7EpLGkM5Vi8akq93s5ud+/RGElc90h36g?=
 =?us-ascii?Q?w9V6gP3rRY5NJh4TBXubiUISfQZkL+qwJU+IvAhts820kq3rLl9/ES/vfTfj?=
 =?us-ascii?Q?9UAHAqq74f9UqRjCyfVrdkBByXS4L86v0KrJMy0esTTgMGJ2jiPDyJsOGAGW?=
 =?us-ascii?Q?Lq3eKXtCobY0FabPQ465FDE/aAOB2xP7HH5YZVxQAo1hv9T/L9uurIUu/lGw?=
 =?us-ascii?Q?wnkGvH8b5TzFV0yjQaQH/7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WttgAbA9WTWxmem0OD9EGRyFlmQTzEcZeRXEdZZ8vWPW8D/zIk8JcsvN7w13?=
 =?us-ascii?Q?PdiVckYTRaJ1Z1PotUeALscWHeUQYqTvkDr5+vxljKOjF8dC2RkuSpDlxRA2?=
 =?us-ascii?Q?tfOz50NknU6F9SsI/U3w1sQOUnS1qaODHCiU1n5uRtrOV2pFYAV1gb31tSy/?=
 =?us-ascii?Q?VeZt+HVRFYqv9gXHE7DjunMi7YeU9MKQ2x8jo7dVrt0hyyDw2M1HIQs3gz4r?=
 =?us-ascii?Q?RZ+VGyDntrgZ4OXpllOrbqn8czJXJTiz4ygZtfbJpE/DSCuaevVO84Sop6dX?=
 =?us-ascii?Q?RNFant8hCBH4Kw1qCDvDsXqOJ14ksBWqZa6YGnQNAI5QxZRjtndVntY01E1B?=
 =?us-ascii?Q?jpjjR38fABICXyrYtOg04Xzc9oMsIDYJsV8PIC9rOaqYK0rar15xHcR0bWgG?=
 =?us-ascii?Q?U3ni9r+oIUVBu9DCDKvS5czBGoBgp+mXEcYpHy+23B6VkhQksEn0R8lsstZo?=
 =?us-ascii?Q?L8Ga3xJHlQa3vZf5ey53uSezvmhO+bIz3sdrbA1a5HBAQZoEJ6gbDFhZ1MjV?=
 =?us-ascii?Q?p40bdyai/FlsScCcGhA40OgIfRwOScpb7j8te2WuWB2MQgWWEOudAww1wd39?=
 =?us-ascii?Q?fGknjGFbXjI7sERTqGL5Xo3wuHUujakCoT/ATZY+gHHozbgR1RbCjgF/NNKa?=
 =?us-ascii?Q?8EbrbBDCnLe3dybGxDZA+hQimFst3Wx63eGcsV+UJBZOLn+IgLwXoslOPLDN?=
 =?us-ascii?Q?ajseZue6rb2a8nX9h1Nub9hLCxQ2d97k5UWf2FlXY3svJyIPNiJMD3dPm8zv?=
 =?us-ascii?Q?cM5FbpEnvBb6B8qwKx3gaNi2z2o7dudRL9arLjhnqkoa3dRgRve/BO3TQLBb?=
 =?us-ascii?Q?4SIFFxGm0IApTqrDzk2Q9HTbVTfkpkK0d+OfUbk1PnXywYxWU8CiwTCXuCO1?=
 =?us-ascii?Q?dd6ozVGTrF9si7NBGODyWL7olAArhmJPDjWsKcLAD2GWBC/4aUZTNEV4ILbL?=
 =?us-ascii?Q?hnUtywVDLj1iqv6U1IiEY7mwcelk9IOZynHM+KQlNJyav9BZfuL2AFMfweT8?=
 =?us-ascii?Q?ZZLtQLBjjJbWCK0D8li40fnDBPxIuJ+rLImK9ZUozbW+Bmas1TNUAdoGBQgz?=
 =?us-ascii?Q?d9QdEJ1hoiHRuAktMdgOW8pB1rsKMoQXb8OhjBxWt3htgtMJtGeStEIyhYGN?=
 =?us-ascii?Q?1n5a30+LmHPL0sh8cPRKlkyCHOHfOdCsbA08EQOKGuDXt9GrjCp+DF1KDwTT?=
 =?us-ascii?Q?IJbizqlB6WGTKkHi2XuzM/o1oxeLNUbTh8mrDhQLQyzEt9fLtk2dbEuRNSyu?=
 =?us-ascii?Q?P/ZfWgnCh5XNFhaVUoiJKliFPzP5odT3jnWuQ71MXr7fMYRomEekepYz+nB9?=
 =?us-ascii?Q?tkXh1XYfx5rW6CMjz/EhTu7k/mvH7IpXpL4UZyedRk5Uk+WePnYAtDwmMi4y?=
 =?us-ascii?Q?+ktNcgmMwGWzeV2O5hHFAKWLI8LKfLZsNEfi6F2lnqbfnR62h8SFkUMSKKTy?=
 =?us-ascii?Q?jG8IBgvlsiPecLB+vr5l3tB5B9hYbDaWyJQMIWxSh+IHxZygt/InSwgmJGsh?=
 =?us-ascii?Q?x295dT4yVr5aBoNMjVuPKqclAcUz9wPipIYYOnHwKqTIuXnqNjRc+qz3Aiiu?=
 =?us-ascii?Q?RfHQxozI9yMUtqWaG0MQUiCl6i5wur2IFC2F4Nw4uF3l99B+kRZrvRmEQPrK?=
 =?us-ascii?Q?gPb7r3eBRwVJvj45Bd29xDuItakNLIN7U3TW1iL2OVhL+gUGdJL7eOpQ2hme?=
 =?us-ascii?Q?7tDjxhhH7PojxW3hyelU/fDkpG+hqj96Ebk/w92ZX7OnltaJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30baabf8-90b1-42e0-163f-08de579bfc93
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:47:40.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/RWVp3El61cUgEA18AS7GUGIJbGHykIYucS0LEwm8L+0jXS4PfzHcqIdM/QCJHyjh9A7ajMoIfFv1nl23Xntw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9575

On Sun, Jan 18, 2026 at 10:54:38PM +0900, Koichiro Den wrote:
> Some DesignWare-based endpoints integrate an eDMA engine that can be
> programmed by the host via MMIO. The upcoming NTB transport remote-eDMA
> backend relies on this capability, but there is currently no upstream
> test coverage for the end-to-end control and data path.
>
> Extend pci-epf-test with an optional remote eDMA test backend (built when
> CONFIG_DW_EDMA is enabled).
>
> - Reserve a spare BAR and expose a small 'pcitest_edma_info' header at
>   BAR offset 0. The header carries a magic/version and describes the
>   endpoint eDMA register window, per-direction linked-list (LL)
>   locations and an endpoint test buffer.
> - Map the eDMA registers and LL locations into that BAR using BAR
>   subrange mappings (address-match inbound iATU).
>
> To run this extra testing, two new endpoint commands are added:
>   * COMMAND_REMOTE_EDMA_SETUP
>   * COMMAND_REMOTE_EDMA_CHECKSUM
>
> When the former command is received, the endpoint prepares for the
> remote eDMA transfer. The CHECKSUM command is useful for Host-to-EP
> transfer testing, as the endpoint side is not expected to receive the
> DMA completion interrupt directly. Instead, the host asks the endpoint
> to compute a CRC32 over the transferred data.
>
> This backend is exercised by the host-side pci_endpoint_test driver via a
> new UAPI flag.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 477 ++++++++++++++++++

This patch should be combined into your submap patches, which is one user
of submap.

Frank

>  1 file changed, 477 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e560c3becebb..eea10bddcd2a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/slab.h>
> @@ -33,6 +34,8 @@
>  #define COMMAND_COPY			BIT(5)
>  #define COMMAND_ENABLE_DOORBELL		BIT(6)
>  #define COMMAND_DISABLE_DOORBELL	BIT(7)
> +#define COMMAND_REMOTE_EDMA_SETUP	BIT(8)
> +#define COMMAND_REMOTE_EDMA_CHECKSUM	BIT(9)
>
>  #define STATUS_READ_SUCCESS		BIT(0)
>  #define STATUS_READ_FAIL		BIT(1)
> @@ -48,6 +51,10 @@
>  #define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
>  #define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
>  #define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> +#define STATUS_REMOTE_EDMA_SETUP_SUCCESS	BIT(14)
> +#define STATUS_REMOTE_EDMA_SETUP_FAIL		BIT(15)
> +#define STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS	BIT(16)
> +#define STATUS_REMOTE_EDMA_CHECKSUM_FAIL	BIT(17)
>
>  #define FLAG_USE_DMA			BIT(0)
>
> @@ -77,6 +84,9 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +
> +	/* For extended tests that rely on vendor-specific features */
> +	void *data;
>  };
>
>  struct pci_epf_test_reg {
> @@ -117,6 +127,454 @@ static enum pci_barno pci_epf_test_next_free_bar(struct pci_epf_test *epf_test)
>  	return bar;
>  }
>
> +#if IS_REACHABLE(CONFIG_DW_EDMA)
> +#include <linux/dma/edma.h>
> +
> +#define PCITEST_EDMA_INFO_MAGIC		0x414d4445U /* 'EDMA' */
> +#define PCITEST_EDMA_INFO_VERSION	0x00010000U
> +#define PCITEST_EDMA_TEST_BUF_SIZE	(1024 * 1024)
> +
> +struct pci_epf_test_edma {
> +	/* Remote eDMA test resources */
> +	bool			enabled;
> +	enum pci_barno		bar;
> +	void			*info;
> +	size_t			total_size;
> +	void			*test_buf;
> +	dma_addr_t		test_buf_phys;
> +	size_t			test_buf_size;
> +
> +	/* DW eDMA specifics */
> +	phys_addr_t		reg_phys;
> +	size_t			reg_submap_sz;
> +	unsigned long		reg_iova;
> +	size_t			reg_iova_sz;
> +	phys_addr_t		ll_rd_phys;
> +	size_t			ll_rd_sz_aligned;
> +	phys_addr_t		ll_wr_phys;
> +	size_t			ll_wr_sz_aligned;
> +};
> +
> +struct pcitest_edma_info {
> +	__le32 magic;
> +	__le32 version;
> +
> +	__le32 reg_off;
> +	__le32 reg_size;
> +
> +	__le64 ll_rd_phys;
> +	__le32 ll_rd_off;
> +	__le32 ll_rd_size;
> +
> +	__le64 ll_wr_phys;
> +	__le32 ll_wr_off;
> +	__le32 ll_wr_size;
> +
> +	__le64 test_buf_phys;
> +	__le32 test_buf_size;
> +};
> +
> +static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
> +					 enum pci_barno barno)
> +{
> +	struct pci_epf_test_edma *edma = test->data;
> +
> +	if (!edma)
> +		return false;
> +
> +	return barno == edma->bar;
> +}
> +
> +static void pci_epf_test_clear_submaps(struct pci_epf_bar *bar)
> +{
> +	kfree(bar->submap);
> +	bar->submap = NULL;
> +	bar->num_submap = 0;
> +}
> +
> +static int pci_epf_test_add_submap(struct pci_epf_bar *bar, phys_addr_t phys,
> +				   size_t size)
> +{
> +	struct pci_epf_bar_submap *submap, *new;
> +
> +	new = krealloc_array(bar->submap, bar->num_submap + 1, sizeof(*new),
> +			     GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	bar->submap = new;
> +	submap = &bar->submap[bar->num_submap];
> +	submap->phys_addr = phys;
> +	submap->size = size;
> +	bar->num_submap++;
> +
> +	return 0;
> +}
> +
> +static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
> +{
> +	struct pci_epf_test_edma *edma = test->data;
> +	struct pci_epf *epf = test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = epc->dev.parent;
> +	struct iommu_domain *dom;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +
> +	if (!edma)
> +		return;
> +
> +	barno = edma->bar;
> +	if (barno == NO_BAR)
> +		return;
> +
> +	bar = &epf->bar[barno];
> +
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (dom && edma->reg_iova_sz) {
> +		iommu_unmap(dom, edma->reg_iova, edma->reg_iova_sz);
> +		edma->reg_iova = 0;
> +		edma->reg_iova_sz = 0;
> +	}
> +
> +	if (edma->test_buf) {
> +		dma_free_coherent(dev, edma->test_buf_size,
> +				  edma->test_buf,
> +				  edma->test_buf_phys);
> +		edma->test_buf = NULL;
> +		edma->test_buf_phys = 0;
> +		edma->test_buf_size = 0;
> +	}
> +
> +	if (edma->info) {
> +		pci_epf_free_space(epf, edma->info, barno, PRIMARY_INTERFACE);
> +		edma->info = NULL;
> +	}
> +
> +	pci_epf_test_clear_submaps(bar);
> +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, bar);
> +
> +	edma->bar = NO_BAR;
> +	edma->enabled = false;
> +}
> +
> +static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
> +{
> +	const struct pci_epc_features *epc_features = test->epc_features;
> +	struct pci_epf_test_edma *edma;
> +	struct pci_epf *epf = test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct pcitest_edma_info *info;
> +	struct device *dev = epc->dev.parent;
> +	struct dw_edma_region region;
> +	struct iommu_domain *dom;
> +	size_t reg_sz_aligned, ll_rd_sz_aligned, ll_wr_sz_aligned;
> +	phys_addr_t phys, ll_rd_phys, ll_wr_phys;
> +	size_t ll_rd_size, ll_wr_size;
> +	resource_size_t reg_size;
> +	unsigned long iova;
> +	size_t off, size;
> +	int ret;
> +
> +	if (!test->dma_chan_tx || !test->dma_chan_rx)
> +		return -ENODEV;
> +
> +	edma = devm_kzalloc(&epf->dev, sizeof(*edma), GFP_KERNEL);
> +	if (!edma)
> +		return -ENOMEM;
> +	test->data = edma;
> +
> +	edma->bar = pci_epf_test_next_free_bar(test);
> +	if (edma->bar == NO_BAR) {
> +		dev_err(&epf->dev, "No spare BAR for remote eDMA (remote eDMA disabled)\n");
> +		ret = -ENOSPC;
> +		goto err;
> +	}
> +
> +	ret = dw_edma_get_reg_window(epc, &edma->reg_phys, &reg_size);
> +	if (ret) {
> +		dev_err(dev, "failed to get edma reg window: %d\n", ret);
> +		goto err;
> +	}
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (dom) {
> +		phys = edma->reg_phys & PAGE_MASK;
> +		size = PAGE_ALIGN(reg_size + edma->reg_phys - phys);
> +		iova = phys;
> +
> +		ret = iommu_map(dom, iova, phys, size,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO,
> +				GFP_KERNEL);
> +		if (ret) {
> +			dev_err(dev, "failed to direct map eDMA reg: %d\n", ret);
> +			goto err;
> +		}
> +		edma->reg_iova = iova;
> +		edma->reg_iova_sz = size;
> +	}
> +
> +	/* Get LL location addresses and sizes */
> +	ret = dw_edma_chan_get_ll_region(test->dma_chan_rx, &region);
> +	if (ret) {
> +		dev_err(dev, "failed to get edma ll region for rx: %d\n", ret);
> +		goto err;
> +	}
> +	ll_rd_phys = region.paddr;
> +	ll_rd_size = region.sz;
> +
> +	ret = dw_edma_chan_get_ll_region(test->dma_chan_tx, &region);
> +	if (ret) {
> +		dev_err(dev, "failed to get edma ll region for tx: %d\n", ret);
> +		goto err;
> +	}
> +	ll_wr_phys = region.paddr;
> +	ll_wr_size = region.sz;
> +
> +	edma->test_buf_size = PCITEST_EDMA_TEST_BUF_SIZE;
> +	edma->test_buf = dma_alloc_coherent(dev, edma->test_buf_size,
> +					    &edma->test_buf_phys, GFP_KERNEL);
> +	if (!edma->test_buf) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	reg_sz_aligned = PAGE_ALIGN(reg_size);
> +	ll_rd_sz_aligned = PAGE_ALIGN(ll_rd_size);
> +	ll_wr_sz_aligned = PAGE_ALIGN(ll_wr_size);
> +	edma->total_size = PAGE_SIZE + reg_sz_aligned + ll_rd_sz_aligned +
> +			   ll_wr_sz_aligned;
> +	size = roundup_pow_of_two(edma->total_size);
> +
> +	info = pci_epf_alloc_space(epf, size, edma->bar,
> +				   epc_features, PRIMARY_INTERFACE);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	memset(info, 0, size);
> +
> +	off = PAGE_SIZE;
> +	info->magic = cpu_to_le32(PCITEST_EDMA_INFO_MAGIC);
> +	info->version = cpu_to_le32(PCITEST_EDMA_INFO_VERSION);
> +
> +	info->reg_off = cpu_to_le32(off);
> +	info->reg_size = cpu_to_le32(reg_size);
> +	off += reg_sz_aligned;
> +
> +	info->ll_rd_phys = cpu_to_le64(ll_rd_phys);
> +	info->ll_rd_off = cpu_to_le32(off);
> +	info->ll_rd_size = cpu_to_le32(ll_rd_size);
> +	off += ll_rd_sz_aligned;
> +
> +	info->ll_wr_phys = cpu_to_le64(ll_wr_phys);
> +	info->ll_wr_off = cpu_to_le32(off);
> +	info->ll_wr_size = cpu_to_le32(ll_wr_size);
> +	off += ll_wr_sz_aligned;
> +
> +	info->test_buf_phys = cpu_to_le64(edma->test_buf_phys);
> +	info->test_buf_size = cpu_to_le32(edma->test_buf_size);
> +
> +	edma->info = info;
> +	edma->reg_submap_sz = reg_sz_aligned;
> +	edma->ll_rd_phys = ll_rd_phys;
> +	edma->ll_wr_phys = ll_wr_phys;
> +	edma->ll_rd_sz_aligned = ll_rd_sz_aligned;
> +	edma->ll_wr_sz_aligned = ll_wr_sz_aligned;
> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> +			      &epf->bar[edma->bar]);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed to init BAR%d for remote eDMA: %d\n",
> +			edma->bar, ret);
> +		goto err;
> +	}
> +	dev_info(dev, "BAR%d initialized for remote eDMA\n", edma->bar);
> +
> +	return 0;
> +
> +err:
> +	pci_epf_test_clean_remote_edma(test);
> +	devm_kfree(&epf->dev, edma);
> +	test->data = NULL;
> +	return ret;
> +}
> +
> +static int pci_epf_test_map_remote_edma(struct pci_epf_test *test)
> +{
> +	struct pci_epf_test_edma *edma = test->data;
> +	struct pcitest_edma_info *info;
> +	struct pci_epf *epf = test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +	struct device *dev = epc->dev.parent;
> +	int ret;
> +
> +	if (!edma)
> +		return -ENODEV;
> +
> +	info = edma->info;
> +	barno = edma->bar;
> +
> +	if (barno == NO_BAR)
> +		return -ENOSPC;
> +	if (!info || !edma->test_buf)
> +		return -ENODEV;
> +
> +	bar = &epf->bar[barno];
> +	pci_epf_test_clear_submaps(bar);
> +
> +	ret = pci_epf_test_add_submap(bar, bar->phys_addr, PAGE_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_epf_test_add_submap(bar, edma->reg_phys, edma->reg_submap_sz);
> +	if (ret)
> +		goto err_submap;
> +
> +	ret = pci_epf_test_add_submap(bar, edma->ll_rd_phys,
> +				      edma->ll_rd_sz_aligned);
> +	if (ret)
> +		goto err_submap;
> +
> +	ret = pci_epf_test_add_submap(bar, edma->ll_wr_phys,
> +				      edma->ll_wr_sz_aligned);
> +	if (ret)
> +		goto err_submap;
> +
> +	if (bar->size > edma->total_size) {
> +		ret = pci_epf_test_add_submap(bar, 0,
> +					      bar->size - edma->total_size);
> +		if (ret)
> +			goto err_submap;
> +	}
> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> +	if (ret) {
> +		dev_err(dev, "failed to map BAR%d: %d\n", barno, ret);
> +		goto err_submap;
> +	}
> +
> +	/*
> +	 * Endpoint-local interrupts must be ignored even if the host fails to
> +	 * mask them.
> +	 */
> +	ret = dw_edma_chan_irq_config(test->dma_chan_tx, DW_EDMA_CH_IRQ_REMOTE);
> +	if (ret) {
> +		dev_err(dev, "failed to set irq mode for tx channel: %d\n",
> +			ret);
> +		goto err_bar;
> +	}
> +	ret = dw_edma_chan_irq_config(test->dma_chan_rx, DW_EDMA_CH_IRQ_REMOTE);
> +	if (ret) {
> +		dev_err(dev, "failed to set irq mode for rx channel: %d\n",
> +			ret);
> +		goto err_bar;
> +	}
> +
> +	return 0;
> +err_bar:
> +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[barno]);
> +err_submap:
> +	pci_epf_test_clear_submaps(bar);
> +	return ret;
> +}
> +
> +static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
> +					   struct pci_epf_test_reg *reg)
> +{
> +	struct pci_epf_test_edma *edma = epf_test->data;
> +	size_t size = le32_to_cpu(reg->size);
> +	void *buf;
> +	int ret;
> +
> +	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
> +		reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
> +		return;
> +	}
> +
> +	buf = edma->test_buf;
> +
> +	if (!edma->enabled) {
> +		/* NB. Currently DW eDMA is the only supported backend */
> +		ret = pci_epf_test_map_remote_edma(epf_test);
> +		if (ret) {
> +			WRITE_ONCE(reg->status,
> +				   cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL));
> +			return;
> +		}
> +		edma->enabled = true;
> +	}
> +
> +	/* Populate the test buffer with random data */
> +	get_random_bytes(buf, size);
> +	reg->checksum = cpu_to_le32(crc32_le(~0, buf, size));
> +
> +	WRITE_ONCE(reg->status, cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_SUCCESS));
> +}
> +
> +static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
> +					      struct pci_epf_test_reg *reg)
> +{
> +	struct pci_epf_test_edma *edma = epf_test->data;
> +	u32 status = le32_to_cpu(reg->status);
> +	size_t size;
> +	void *addr;
> +	u32 crc32;
> +
> +	size = le32_to_cpu(reg->size);
> +	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
> +		status |= STATUS_REMOTE_EDMA_CHECKSUM_FAIL;
> +		reg->status = cpu_to_le32(status);
> +		return;
> +	}
> +
> +	addr = edma->test_buf;
> +	crc32 = crc32_le(~0, addr, size);
> +	status |= STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS;
> +
> +	reg->checksum = cpu_to_le32(crc32);
> +	reg->status = cpu_to_le32(status);
> +}
> +
> +static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
> +{
> +	dw_edma_chan_irq_config(chan, DW_EDMA_CH_IRQ_DEFAULT);
> +}
> +#else
> +static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
> +					 enum pci_barno barno)
> +{
> +	return false;
> +}
> +
> +static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
> +{
> +}
> +
> +static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
> +					   struct pci_epf_test_reg *reg)
> +{
> +	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
> +}
> +
> +static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
> +					      struct pci_epf_test_reg *reg)
> +{
> +	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_CHECKSUM_FAIL);
> +}
> +
> +static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
> +{
> +}
> +#endif
> +
>  static void pci_epf_test_dma_callback(void *param)
>  {
>  	struct pci_epf_test *epf_test = param;
> @@ -168,6 +626,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		return -EINVAL;
>  	}
>
> +	pci_epf_test_reset_dma_chan(chan);
> +
>  	if (epf_test->dma_private) {
>  		sconf.direction = dir;
>  		if (dir == DMA_MEM_TO_DEV)
> @@ -870,6 +1330,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		pci_epf_test_disable_doorbell(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
> +	case COMMAND_REMOTE_EDMA_SETUP:
> +		pci_epf_test_remote_edma_setup(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
> +	case COMMAND_REMOTE_EDMA_CHECKSUM:
> +		pci_epf_test_remote_edma_checksum(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
>  	default:
>  		dev_err(dev, "Invalid command 0x%x\n", command);
>  		break;
> @@ -961,6 +1429,10 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  	if (ret)
>  		epf_test->dma_supported = false;
>
> +	ret = pci_epf_test_init_remote_edma(epf_test);
> +	if (ret && ret != -EOPNOTSUPP)
> +		dev_warn(dev, "Remote eDMA setup failed\n");
> +
>  	if (epf->vfunc_no <= 1) {
>  		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
>  		if (ret) {
> @@ -1007,6 +1479,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>
>  	cancel_delayed_work_sync(&epf_test->cmd_handler);
> +	pci_epf_test_clean_remote_edma(epf_test);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	pci_epf_test_clear_bar(epf);
>  }
> @@ -1076,6 +1549,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (bar == test_reg_bar)
>  			continue;
>
> +		if (pci_epf_test_bar_is_reserved(epf_test, bar))
> +			continue;
> +
>  		if (epc_features->bar[bar].type == BAR_FIXED)
>  			test_reg_size = epc_features->bar[bar].fixed_size;
>  		else
> @@ -1146,6 +1622,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>
>  	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	if (epc->init_complete) {
> +		pci_epf_test_clean_remote_edma(epf_test);
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);
>  	}
> --
> 2.51.0
>

