Return-Path: <linux-kselftest+bounces-23711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959E9F9DDD
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 02:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A3316A381
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276271747;
	Sat, 21 Dec 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZmkicZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FEA59;
	Sat, 21 Dec 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734746190; cv=fail; b=dOXVCtxupA+lzFojRkLASzk0Bm9fC12hKRg4Yfoiel69JVRFVhgca5F9J3ztz+hndLSg09hdOCqdLv0Lnp9l34F+wr02AHcl8SYF4UyuZW9szcmFYccTAy9er+i+AGAfo9G9AfgiAwCzWb7pTmoWo9gKsYhTmpMLR9InD6JV76g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734746190; c=relaxed/simple;
	bh=yofM1aFB8KoEomjQn3u5CKDKeB5tGp9sRFQKID6u5KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhFq7D5RgLRGzvFZVEwuRSj2WU1n2csepXIcQarqLzQmoLkx5RngiBDyBhb6LDpsozTvKK/lEdArrYzH0cCrAi9MXz+pa0x0Rj62wokOmZ1pQYHaq+YmCKun3gOlPCKw/Ubj62JALLqHaB/EzgiclWDQTd88RaviMv1J4FIx4X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UZmkicZK; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKKGf6wEVTZY/8rdoBPyzrttBbxOklPn3tV2DYUQCbspY0nPMHs9GjDhjjdd7antk8VaKZqvzbbnEH11sWJ+M51voKElV6LYbomwKTOZPUQ9L3HETfSaj1jURMXf1pgwmAesacUfFNMppLm976OGEH+s/4nps69+gI3UedjpWK9AnnWQI19dfQAgp3r1vBD0u6VfTx6mSO4asJxDSj6Y/giajnLAlOyB3zX2CaLo9RqGv2+B8zTCK6UdFfDW/3n0b/m4z/EL42Y6R0ZVvv1wd5xg5VjobnPJnauvwY5AA8nRXDXkdAp9ZJ56TBnfRO80vlb2Kebop+XghXLDkzPFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0zPN+zDEIh8QGiUIlheRkUjYakt90ONNATSDHsgogY=;
 b=REein9RHNvvSrAgeZ2TKnSqQWjcFY/cK3TrdcemHgJJL3g7M+6xOAxFUCKK3UKJeujBEzutLUjGSwIjixTC8NXkT7uapWQYqUMKFrJWA2L6bVVp0/sx2V4wIkLpZdKmhLmUm/YGAV2T15v6kLIiHBsfKo2agQ+YGqrK+C7LQ/du2jmYFNzfmxws1LRoYbVhIQD2aVdY/cdlGHJ/ntaHE/33VAEWu4Cr5+nYZAJWA30n+ST05TI3Ecxy9pN79t/zDspkWmB5t3wIeDnISNb/s9/XWOfxkcH07NuUello3/JmQUz9HxnN7ZrSKxx5LnfAdg74ECNOtXIE0jLJOLX35sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0zPN+zDEIh8QGiUIlheRkUjYakt90ONNATSDHsgogY=;
 b=UZmkicZKAr6wiFnBzbSTdRzP+XeQ3I5gOPKHjez/CeyK9r4gqMS5ZDXDbKDYNAYzW7zvWCaje6qtlk1k42fvgqVnxJutvB+nV5xmxu2xNvkwNd7U50k73cUnzu1WHdxmsW/a7CsxuUDKYUjlvZ6gs2ufFWu7BLSjGyZftaJvF+84wwqIU356xQnjxLJBZcvYF3hUiYbbqMlnDs+GTDonKszIWvqTE7ZdEY5NnIWs2SgKyzrfC7E/+BnGMWF26rwtKuhFcZ5VAWenlf4lHp8h+1MJ4Jln22fsvWH/1jISjc7byyhmULI/ZqsvuJ6VhvL4vyBo/Fj3tUjeySq3yq1pKQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Sat, 21 Dec
 2024 01:56:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Sat, 21 Dec 2024
 01:56:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"mykolal@fb.com" <mykolal@fb.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Thread-Topic: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Thread-Index: AQHbUsKbt+d4ByGi+UO0J+Wtft+nMbLvTeoAgACjCeA=
Date: Sat, 21 Dec 2024 01:56:21 +0000
Message-ID:
 <PAXPR04MB8510820FA25DA47C6A7781F388002@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241220091806.1856223-1-wei.fang@nxp.com>
 <Z2WXAqNY4s+OKZbB@lizhi-Precision-Tower-5810>
In-Reply-To: <Z2WXAqNY4s+OKZbB@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: 80987cad-3d8d-48b6-413b-08dd2162aac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FEs7IxRaNAwIJIN/Fj8qHFnj3iNmJLPcE97cvAHGExqU2brLhXFIbaOusv+Y?=
 =?us-ascii?Q?MlITNdiEkjFvNoLZ9QclMq5sXzK+8GNqJYeFKcMxppRnQlCo/zQLjonFShxa?=
 =?us-ascii?Q?091zUOXwudblyloCMsZJ83aFfUfvaRHoI20LLfAd26Puu95EQbnQlP+ugU1U?=
 =?us-ascii?Q?e8+0uXHW+5DSN60LDI5IpKSg0VzgsTIBjxd5+mpWJn1uB6LVAjiif1Z6C6mj?=
 =?us-ascii?Q?gos5lsoMZcGW8KHSdgoRylAR9WrQ1VMdyu762QgGVXZF1te+sNRpPCY717Yx?=
 =?us-ascii?Q?+mFWDe0KwV6PSzbeLVWHgll8bWLU/0j5c699SzuWvSVy1F5YeVIzF9By+Jhy?=
 =?us-ascii?Q?PqQ15PogHa8xMAxWpAVcyP3EpSuZJJk0rxoJeLF6uuDOekadHL0dI4W/N3MX?=
 =?us-ascii?Q?eTjpeAwTkthbd/PamPC4F1bCde1PNo0JNTEzUZkDtlqXEOpcD/nrx6OLW2wz?=
 =?us-ascii?Q?jum3+qwMQYppVHJ9KzBf4rlGVtOyRcyffdb9u/2qXOWS27rwZwNthTTdaFuE?=
 =?us-ascii?Q?cnPuCuX4w5m6QvKGh90CIO/nYwuWYfIeabSt9xG+C+4MciEZfG6GMTKKBssG?=
 =?us-ascii?Q?RmjU1iCXasMAu5Lgob85vRb+ZAX8z4+sqfr0p4cXyOnVe95hOgcTOqWfOneA?=
 =?us-ascii?Q?oL6vPsnAaptgfpTByqUe0Dqci02utLRd5POX5P+zRfsn8Xb77aGOHhXOsucs?=
 =?us-ascii?Q?LchC1UACmwno4MVtIOK9rVzLCSL9kmQemJ8/U0fPOIuDc27zjtGYzrM6tAgr?=
 =?us-ascii?Q?8Q/slWsYEF/2DGHkp01Q7YhBePrn/ml5sSvug9JPsghgB8GPNeXQxqTzp9qT?=
 =?us-ascii?Q?c1PaPdgvFhVvx7F2+3gle1mbiorxN0UKErWLKtStIvCp3irmY22QeVBvxkAK?=
 =?us-ascii?Q?Me2VDqyQ9/ptmfhVi4NT0N7ujVoi5Blc/JkerUTrANyBotZJTYYDxL9OCBD4?=
 =?us-ascii?Q?Aw8o/EUCuDqGsdzXyzF34oAPWTPpOcVhSE4KaS8U5KzAvzbTkOjSHYiAIW9J?=
 =?us-ascii?Q?juyUTz3l2Fjqv5WnR1yHI44EpqJBvXuL7cxMDRBM1QRvGUse/w5U4NOK2N0V?=
 =?us-ascii?Q?HSVWsB9yJDvAEe7hqi3Hu8Ys7j9dgT4vMd7zmQZ+E3I1+MQDD705YUfdZx+T?=
 =?us-ascii?Q?K6eaYRcm35zMWBGuyHAZVJRZ5RFoisxFWc0IQJ+zXWz288YLGX9gJZXAovOc?=
 =?us-ascii?Q?qR0Lm4EDQhL+oRLIo9b13+yRYc+2DwWRISWJf+cjYAsDlgpfHY17OIW/vEzM?=
 =?us-ascii?Q?rl4u3INpN8Jh1/GMTo/+0eElxquAY/gDzLiX8S/HA5IcL1/QsvAHp9h99G1j?=
 =?us-ascii?Q?IFlZ/Ve6m6zt6RG4qsc3eMIFPTKq5Vx6y0EEVRddALq3a4tSTWK02/wzUrJl?=
 =?us-ascii?Q?S50VEzdw9WvK8Pp0PeC6/JiCFZU3/ENrHXlm9snip7gNoIw0lZilcqZtl28M?=
 =?us-ascii?Q?Gxare2xsEJBlnrhU3rHHpaErRpEJoTHh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4BhipF7H1OyiW/3PNA3lkW4QwFOHSv7+Bu8BLJNfADkJqpIx0dHIxpV9y4VW?=
 =?us-ascii?Q?kf5QaFgOHpFDsZ5qO7+3nyKdox5QJ5s3xslGBy7nCefIFJqw3T7XVGgIRGEA?=
 =?us-ascii?Q?QVu2uX5Ftr75fY53M3HqJHNt1AKDkRORtWr/ZQ06Va6VeYKKObg4TcLZO2In?=
 =?us-ascii?Q?vOdWf23V5Te58E6bAFIBlvEPmSZIY3V7+dT32UKQeOJ6W1VIyGCr8+QqVdKe?=
 =?us-ascii?Q?UIKuzN66g39lnqxuNFYoBHF0fykogxNUfxf2NxF6MOlU20Xvlz0ECK0ji97z?=
 =?us-ascii?Q?loJsF8BjBTTIAeBBen3Bg1pfU6m7VM/gP9zDDDuiF3jk95APhJckJVk1Hhgm?=
 =?us-ascii?Q?F0/ICwRo4d9Aq16DX0oTlcPUgxYdURxKOAiJMPp+gnFvBgY0XoCwZY473i+d?=
 =?us-ascii?Q?4JDA20SiFIm5rezrAA55rA+ZtXXWEr92HVT0eg9SuPFi44bNRuX3rjG3Kdoz?=
 =?us-ascii?Q?qMRKKgsZjSkSKptscVLSQLgoE1IWqNeULjcTLe2CIfihm+CzUw9lO326N1MU?=
 =?us-ascii?Q?2qOdolx2is/Ub8l+StaM1ZL8lL+qkzvoV+YojNIMsKdOHqGmXRlcJD4vc3B+?=
 =?us-ascii?Q?q3wTvwWxY4Mas/KoLRCA3MCSZVO42sK3cWYIO+XjSuprNGRyHAE+876ZftrN?=
 =?us-ascii?Q?R5Ba9KskMDsdF/FbdUkiSHWYPy+gJvgFo7mQ7cwDLDEtuYy6g7KDg3BoSK05?=
 =?us-ascii?Q?g3Dvv35jBE6aWk8JujPjRq5yyPWSQNZcP3VD8sBxcIkSGPssD1wkQFRPAMQY?=
 =?us-ascii?Q?KCj5sLuTrO/TUQcgigBubc5HF6rPgeBRa9Dm2TRHHYVK4tiFs+GHwFmmnEOL?=
 =?us-ascii?Q?groUndUrZEW66VZvzi6NftxFaDEUmB8sOpYBDz0MrR3tPaELvcc+vRJDPQPY?=
 =?us-ascii?Q?VsN3UldmBKuJAyuNgJjzZiCHs1gFpnlDwlI6SEDal9FtJ4uoz2XCa2vHa1nq?=
 =?us-ascii?Q?/gQC1S/BSR9YpfrQhR+VeZ9SBFCeZm0eU3tgQFSOIRE6UR1fKr3dpjXThCA2?=
 =?us-ascii?Q?zQg/j5IjhmukOfRly6VONmYJg19dQssTEqmcAnHAjU8CnjPxMmq39Bva8Zdw?=
 =?us-ascii?Q?q9Kjip6S6snqitIxA+PXJOo1vx0r9J0WM9Fzv5mf2LhKvF6cnMONVnDkkgUg?=
 =?us-ascii?Q?TQ3YtvS0I3vUuGn80QkyM+KQf/rSY47Cj3IngU+0XkTRP+yCrHRgrsKUyPOa?=
 =?us-ascii?Q?a6IBt7Mw31iv/dsVJP7JqoKjwhHvrESceLbIzAyRnAxMyUCzRWkamxZUxSvS?=
 =?us-ascii?Q?E35UcLA5dmb+puosRvrFLXDfN+ezKHhMnEepJPNP+p6HpKwl8fukJ+VkQdjW?=
 =?us-ascii?Q?RSrJCrsKTphrfsooRTxlIwQYfXuhI0FKpj/HUkoxd/AvzwRqeyvvrEFZ/ZoK?=
 =?us-ascii?Q?DYulc9KURLrhHrBngfRYsqsU97syspA+kKxIUcpBGjSvJzgiY5CoD8EFv5hd?=
 =?us-ascii?Q?yG8ZMiECGvw+EUByQcOTHPbQiC7vL5D0h7kYL96OWzfY34dZQuXDeUWHfCh3?=
 =?us-ascii?Q?tCjCPrIwoRTDXnIaHHYrM0umK3/SVOz8JOcUwt1LhFmm9Z7IIHzRCjl2UD6f?=
 =?us-ascii?Q?t8fBJK9icVucWvgQaGE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80987cad-3d8d-48b6-413b-08dd2162aac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2024 01:56:21.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWc3rd6F+YYLqN5HCNMGa8/NY38oy4ZOmHMsMshFeLbXzx0jhAZpZTIFHo0asJxxrR1cKNjaRY2Tq6RptR2sJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

> On Fri, Dec 20, 2024 at 05:18:06PM +0800, Wei Fang wrote:
> > The Tx metadata test has been broken since the commit d5e726d9143c
> ("xsk:
> > Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len").
>=20
> Nit:
>=20
> Fixes tag already include this information.
>=20
> The Tx metadata test has been broken becasue
> XDP_UMEM_TX_METADATA_LEN flag is not set ....
>=20
> > Because
> > this change requires XDP_UMEM_TX_METADATA_LEN flag to be set,
> > otherwise xsk_buff_pool::tx_metadata_len will be initialized to 0,
> > which means that the driver cannot get Tx metadata and cannot execute
> > AF_XDP Tx metadata hooks.
> >
> > Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to
> actuate
> > tx_metadata_len")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 6f9956eed797..ad6c08dfd6c8 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u=
32
> queue_id)
> >  		.fill_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> >  		.comp_size =3D XSK_RING_CONS__DEFAULT_NUM_DESCS,
> >  		.frame_size =3D XSK_UMEM__DEFAULT_FRAME_SIZE,
> > -		.flags =3D XSK_UMEM__DEFAULT_FLAGS,
> > +		.flags =3D XDP_UMEM_TX_METADATA_LEN,
>=20
> look like "XSK_UMEM__DEFAULT_FLAGS | XDP_UMEM_TX_METADATA_LEN"
>=20
> You clean other flags, does it what you what?
>=20

XSK_UMEM__DEFAULT_FLAGS is 0, so no need anymore. The same patch
had been applied to bpf-next tree [1], so please ignore this one.

[1] https://lore.kernel.org/bpf/20241205044258.3155799-1-yoong.siang.song@i=
ntel.com/#t

>=20
> >  		.tx_metadata_len =3D sizeof(struct xsk_tx_metadata),
> >  	};
> >  	__u32 idx =3D 0;
> > --
> > 2.34.1
> >

