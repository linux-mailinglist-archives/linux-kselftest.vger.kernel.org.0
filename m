Return-Path: <linux-kselftest+bounces-16551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC0962A77
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FA01C23617
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE519D08C;
	Wed, 28 Aug 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="R3fZy8Q1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E514EC4A
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855937; cv=fail; b=H0cQG1Tjih+z1sqoIh8epX7e8bTXB/un1VcLdigJtOrvrxAZqJK68eITv67DINa10Ao1BSfL2thdBehRlvuBDPh8roWewhytl7Bp8kh0fL2oLOSw5BMmg54AeJV26meIfeMD7B7dlLvZBauE8qPOXzbzVJMtvIrFhzxisSCkeEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855937; c=relaxed/simple;
	bh=sZWndxy+fR72rWOjdySgf/o3B/hjDTUcUi/2009WOTc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQTPTiZepBzSfOSPJL7L4+NAvF6AoqDpILZLktmNl/kIpjTlTLVPfPDXRsrEM89k55J/6+r7MuS8Ix7aSLFnr/HKuw5/HCVFPe6/gHdw0n+Knn4AoDannZHopvVTItDubU7Q7eTQknQ3idM7BaGTC1LNaSaE4H5l4pizUDxy5iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=R3fZy8Q1; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soCxYmXjJYq7wKR/393/Zsy4f0c8adQZoBv2Hw4beIQ6eohOgilSD6j3jNMgThxBCSyG2MabAgA/e1TgT5O7mgbzrfKDDBXWwlcimfxA7oadWyUG5P+P1z9y8jk8D8xZMuFpcfiYJDIzNasBz9BmaMw+uDQNfAvwT57ln0kKwWPXzn1A9PB+TGe0Zqyb78ltpH2Wla4tnG6CiVm2wWPPKOPnteNSSeVgtE7eZ27DOwlp0gtzFJUty9RCWAZwS306uWjvStE2dDTA9GIWAYUw+C4Nhy85khCdduQbbheZVr16ujRbRH7RP+STWwMCZDnAPEGvoiWWOTANNutrpr+IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZWndxy+fR72rWOjdySgf/o3B/hjDTUcUi/2009WOTc=;
 b=tQTnAMxSWu5huaKrU1KEQMwwqGj5J7HytdcqDzCx+2wuKlSxjekMk1RGkKV0cq5OZA8RK2Y3PD0O5KOWagNNUCVq5Pm61mdElG5YjXys4mSH7nXUiaTV8AELLXPW+cFuxSW4Ft5EmnEw5p4O95+yKGf14wonofLo/iHCZWoA4PZDIMxAc2aLs6MwxXJEFppA5QrCQoXXCuTgOLeslzA9dK09/JFmtGKk/CEpakeUH1KDPG64NvUi7gA3pxSS68wu7SBHm4TM+K2OZ0eWCbFq4YRFwGDvifCPuqf/1XHpdKJBtfkVkjiPE5GR51MMOgX2h5fjNF5S1X/twS0S2UwgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZWndxy+fR72rWOjdySgf/o3B/hjDTUcUi/2009WOTc=;
 b=R3fZy8Q1Q8IrXSXkGphXuYhYgmtQSS46kAJTPgCTMgrFMMJ6qaaRhjB5qXAWKyAWS9VWm0lTNVIEfeFpoo+aphPKi5HzMMWtTY74ZknPc1xq2dgr6K9J5BVPCwF2Lq5ieKETM4x9of5AJjpjEpaJAVQAI1EbFy22/ASvIlaSVU8rYlBsHxCcPjq4Stkd+CHriFueDWl2l4wZ8IJZky+yxjDWlVljH4+jKS74AwMJ7DwH8qcov0M2HUnGqY1cambMB+TrBYoT3hzzWznag0YrFm/GACFmQDoPnq3IJww0wLebYd9SgMF5P3c4kWfPMulGvo6S4Ow8EG+14/thl0SVUA==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DB9PR07MB9073.eurprd07.prod.outlook.com (2603:10a6:10:3da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 14:38:52 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 14:38:51 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "xry111@xry111.site" <xry111@xry111.site>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH] selftests/vDSO: open code basic chacha instead of linking
 to libsodium
Thread-Topic: [PATCH] selftests/vDSO: open code basic chacha instead of
 linking to libsodium
Thread-Index: AQHa+VHuSYKNnbWYZUCFB58il9vOE7I8vVuA
Date: Wed, 28 Aug 2024 14:38:51 +0000
Message-ID: <64761aa8-123b-4eeb-890a-855d0a0f8755@cs-soprasteria.com>
References: <20240828135510.3414909-1-Jason@zx2c4.com>
In-Reply-To: <20240828135510.3414909-1-Jason@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DB9PR07MB9073:EE_
x-ms-office365-filtering-correlation-id: 11a7bb71-e995-4410-04bb-08dcc76f22bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG9VbW5Mb0pHaDUvVWVSek02dVJEUzVtc1hUSWtYaHh6dUo0N3pwdDZnS0FC?=
 =?utf-8?B?SWVuL1I5MjJJMUZJdEZlV0tLa0J2anlGY2pnYjRIQXRnUnNhUFhhYW4zbncz?=
 =?utf-8?B?dzRJUUxER2pmRGtMT2RjQjQreWphOXBpY1hmUExJa0ZSOXFEVml4RVp2ZGNv?=
 =?utf-8?B?K2xpT2VTS2ZSUDZieXNldEtkTXpnbTV3MnY0dlF1bHJTUk5MRXB6VUhrSTVr?=
 =?utf-8?B?cTgyNWczRnNIejFkMytMTTNvL3owRlJPTUZ2aldhQWNncnphSHQ0N3dpZ2hN?=
 =?utf-8?B?RklETHR3S2x1R1RneGRlcWswZEFXUGZQOTlSV2Z4YlhOTFROcVhPbHN6WWxN?=
 =?utf-8?B?L2p3b3BaeDNuVk90dCtjVGFkdGxRUHlwbEpnYmp3M29hN1VGNVFxb0hZWGhQ?=
 =?utf-8?B?LzNHRktSQjcwTEx3RzJJRlhFQlFGbEhKOWpkMGE4QVVXVmxGSHdhUUgyNW12?=
 =?utf-8?B?Z0ZQdjdJVE1ER0hsaUZEejBDVGxhTlBkSjdYNXhLVXcxUmIxVTN0c3N4cTVs?=
 =?utf-8?B?OWYyUElSamt2MGdZOHR1RTVlZDZCWVdtSnpjMmE0RmhMZjJ3bkdwSGhGdk0z?=
 =?utf-8?B?OEpjQWJ3QkhwOXg2b1pEYmJxR243bUpRSlZLLzNUMU5ISzY3cTQrOUd2UEEx?=
 =?utf-8?B?R0hJL3JValg3bTZxSjVPeTUzV0VSUWtock5RdjBwRFFyT25lMTVIUm1qRkxm?=
 =?utf-8?B?alpYNjlNNlJKZXJtckRBMURRV3RScXpjTElMNWFLQWx2KzBudTNBVWZ1RCs4?=
 =?utf-8?B?bTVkOUsrK3dwR2dWRHpiVFdvV01wWHpNSmZ4Sm1tMGFtc3dURGMxOG9tVDhE?=
 =?utf-8?B?eTA5YkJUZElqQ3dkOUQ4dFM0NTFQRkxRS2dHTjdoWmVzV2FtMkljRGZZM3B6?=
 =?utf-8?B?RWFGdUFhbkh4RVhubVdWeVVaaHZHVXFEakVsSE0yc0xaQ1U4cjBCekx4TGJU?=
 =?utf-8?B?UGhsRTlZbFFIcnNIUVROcndPR1lObkVrbmZUTm1VWTFYMHFaRk1XMXgzR29i?=
 =?utf-8?B?S2d2OWhLaHNBR1RWakFCVWVSN2ZBaHhMVU1qbmFLY1FicjBENkozVllvQ01z?=
 =?utf-8?B?TUNGa0x3bHdVRS9qUnhKdmVtVHFrd2N5SmZwekhhL2tGRzNrUlJzWUpXSGVu?=
 =?utf-8?B?MmRKYXQrNk1INW1ndExjblhjWS9jVzlwNmZpa3p2NXB1T3JNNkR0NWkwcjdJ?=
 =?utf-8?B?SUFZWENQZlRBQXRTNFdhMmFjYWw4T0l5Nm5PWUdGMDVUVCt5Q3N3QVI4MlAz?=
 =?utf-8?B?WkhPUjNVY0Q2ZzBFaHVUbUNTRlBjRHgvVVFocUNEcHhmSHp3LzFqMTkrbTFM?=
 =?utf-8?B?S25zTWZHUkhNK0t1UUhFVU5ZYzhvN1pFYW1XUTR2OGxVU09YOHBDTklzb1Jk?=
 =?utf-8?B?cXZVcnEyZzBHM2ZTSklpMlFkS0Z2OUUwUHRZekszWk8yblNsSUxLclJQQjFS?=
 =?utf-8?B?T0xTN3ZIa1BXUmJwbG45T2JRRlpFSHJKdC8yVTFXY0svcXkwMEp3Mzgrcm1C?=
 =?utf-8?B?STluRU5XZEZpY0hMK3p6ck5Fa0J0UGR6TWtaMWczbm5qZ3Y5QlJqUHFBWVYv?=
 =?utf-8?B?MFVDVTRlVWxHcFpTdEFYSkVsdER1S3p0Y0RrYVBQZVF4T3g3RjlYbjRnN2lx?=
 =?utf-8?B?L0wrbzdYK1hGTFZCa0ZmdHFlY1A2alBOQkg0VlMzanBMZFJyYk9ib3g2ZnBt?=
 =?utf-8?B?UmZSRTRGQ0tabVNUakFzMVlwODQ0UUlZeTYrWHlSMDNJckcrWjFIVXJ2OTZQ?=
 =?utf-8?B?S3BTNytkVlIvWmVOVFNCRW1FeWQ4ek04MHpTNnBCeUdwZzBielpzeE1DMmJP?=
 =?utf-8?B?SjB1VWRYZEpNWEhmWi9oV1o0YjNtS3kyQTZ2TVczd21VaFdEa1V6b2xiRWZm?=
 =?utf-8?B?bTYwWU5RSWtwYXZXdEIzWTB5cnhERWpmbVh6MUowWkF5K2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3NKREwyNzBNZFQ5TmoxNlFBMlNUYkJOQU1JTjYyUUduRHVNOEdaQm9RaHZn?=
 =?utf-8?B?RkExZkxGZUhyamFFWmxuYW50aTFhT2pDd0x3VUN6eXdsSDhleHFCVUdpSEhM?=
 =?utf-8?B?MmxUOHhpU3plVVRLM2FSejl3eEJ3NWY2bURQNzVMa2ZwTXpraVlrRkRiMUVp?=
 =?utf-8?B?S0ZYQ0Qwcmw0OUJIeG5nalZmd1VrODRNRWxpWms4MS83OVFCV21SNUlLSjNP?=
 =?utf-8?B?TGRsSm1pZXBLZWhoYjRRU3NNdDZqR29BS0lxRTBPeFEvNFRBTEUzZG5nRFRC?=
 =?utf-8?B?c2sweFBZQ21nOUlBVyttVlNhVzRYMklta24wU0hES3kwUUVNY1RhZFhXcyts?=
 =?utf-8?B?NWtSc29KNEQzZjRMM1J4NzJ2QzM3aEljNWJpbWhodkhEMnU5eExoVVZKeFdI?=
 =?utf-8?B?Nm5EMkZNb2VtSGpQQVhmN3lRemgzYndDU0drWjZwdVkvNjU0RHJ0VU80SGlV?=
 =?utf-8?B?QVBlanVVQVdhT0M2ZzR0VS9BTEtvN1VydktabWdzSDhxVVpkSjIySUZyeTQw?=
 =?utf-8?B?Qkt3WWJmaUxaL2V3Y1REWGUwMTl3TCtuakRQYzlqSVBMRzhUMDE0TmJTcHZM?=
 =?utf-8?B?dXRWN1NETE5acU53SFZlaXJkNlRUenFhUm1sSVFIdG5sNTNCcTlsMnhWRzVp?=
 =?utf-8?B?RUxuQW5HKzcrVHZTK0M3b1hQQyt4a2xwSHFOQ0NtZVQvUmIvYUZDQU1VbnQ1?=
 =?utf-8?B?L1ZjOUIwbjZ6UVJCeGhldURuTXE0R0dlcEtPWEx0U3JBSE02ckhBbHExMjV4?=
 =?utf-8?B?N1ZXVi9UVVFmYlpYL2FCZHRrM09Ua3l5YzBLWlJkdkxZbzNZelZna0diNHRY?=
 =?utf-8?B?NS9DRElRbGJzekRYQXdCT2dIbmZhcXk3NzROOEdJSjd3bytCVEFkY1lZZXRr?=
 =?utf-8?B?TnF0WkdWWFZKVXppRzg2WFJObUJZdDZMTTVTZHFwbHBJcHk3Mkt1dlhGS2FQ?=
 =?utf-8?B?MGwwaFVCL1puZFVWU3h0QXZXUUJKei9TRHdMVVpLVkR6eXdVZWlIQ3AwWVo1?=
 =?utf-8?B?eGY1bHJ5MkZ2T0xWc0lqMjR1d3J0QkpreHdNeE9qNllMWnFjR1pUNi84NzE4?=
 =?utf-8?B?b3VLWnhZcEVTcXdBVGdEbHFGR0ZxK2xEZzFHYlAxZTlOVWYzWEphUWx4dWpr?=
 =?utf-8?B?T0NCYkl3VGJ1TWhtZXhHU3dFVEJMeTBrNnJaSENReHVXTnVTM1NvMVFPZHdx?=
 =?utf-8?B?MnQveFFRNGt4blplWFdTVll2a2xMMnEzUEh1VURkUFJCdU1pcytxeFM1QmhV?=
 =?utf-8?B?MFM5TGt1c3IzMFFoNXhpZ1M0bEg5R0NyMStEQ093OUJJVDVXdmFmeTNHdDRF?=
 =?utf-8?B?UnBFcE1DZTJSNHFQZnVtRG9XSVZpdE9kZEZwSHRKTVJWTHdRK2J5Ulg2Ny9u?=
 =?utf-8?B?NGtQQkU1NkR4K3ljSG12K0pZT3prMXBoWWlHekU2RFdaMDVZaFpYalhHNE94?=
 =?utf-8?B?aE1xTXgyeEZvY3pRWEZ5TktBV3RJU2REeDVEdld2Q2pTb1Z1aFVMVVJtdGNR?=
 =?utf-8?B?NXVIOUxOMHZUL1pyQ0pFaVVlS0ZrMVY0REkrVXpNZVVjaG5oRTFDZGx6THBN?=
 =?utf-8?B?ajh6S2I1T0dNalBhK2o2T3AyYVBvOUQzS2tqVENOdXFqeldHdUVicGpBRWU5?=
 =?utf-8?B?MjRCakYxUUE1MXZDS3hiSXJxYTZMdklaVTlUQmJXb3pKS3gwZjFlYW50eC96?=
 =?utf-8?B?OFo2dE9MR0VmeE1UbitXcW1iMlpXTXI1UjZBMjFQZ0ljb2VSb21wczNwbXFF?=
 =?utf-8?B?K29NaENKWVBmSUFERjY5aXJyVWxQRDRFR3pjVE1yV0tqS2tKdDJXeExzT1Q5?=
 =?utf-8?B?UFpjZ2dXTUZMVVRSWVpVRjVMUENFaTRubHlubDVzWXN1dUNiQTZkc05Ka2tP?=
 =?utf-8?B?OVpWTU5HclpaY0pILzR5cFlsK1BxRVlpTXBzZURFejhVNUVhMTNkQm9FQUFR?=
 =?utf-8?B?R0czd3ZGaElkU3dLdUZUeXBhQUloODl3L0hXd0ZoQXdoSWcrOC9EVUxpRnFO?=
 =?utf-8?B?azRYZWtCdmw1QWIzZHN6aTBJQ3YvSmczeERzdjJacUlKVS9JY3VUckE2Ukly?=
 =?utf-8?B?REJ5bWQxeTZPMmxBZGxIbFlKeGJjU3ZlTVEvcUhNeVNBL2JHbTBmc3NWQnlT?=
 =?utf-8?B?MGFHQzJTbW03VDlndU1tM0ZpSE9udVE5OXo5Z2p2UFAxYWtaT0dETkZzQmZW?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE4F4B8F60DE54EBEE0DC74236C8931@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a7bb71-e995-4410-04bb-08dcc76f22bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 14:38:51.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Vx+/zXAksoddA+6kHPFRS7ZJzO//hMt5c37lc8yf6qs0Fgn853i1lBPK1FuecFGErVKYyctXSq3YxupgBFip16fWHeWnpPWUy7cBuj9+sUYqBnZ2egZjRU3NHjbmdkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9073
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB9PR07MB9073.eurprd07.prod.outlook.com

SGkgSmFzb24sDQoNCkxlIDI4LzA4LzIwMjQgw6AgMTU6NTUsIEphc29uIEEuIERvbmVuZmVsZCBh
IMOpY3JpdMKgOg0KPiBMaW5raW5nIHRvIGxpYnNvZGl1bSBtYWtlcyBidWlsZGluZyB0aGlzIHRl
c3QgYW5ub3lpbmcgaW4gY3Jvc3MNCj4gY29tcGlsYXRpb24gZW52aXJvbm1lbnRzIGFuZCBpcyBq
dXN0IHdheSB0b28gbXVjaC4gU2luY2UgdGhpcyBpcyBqdXN0IGENCj4gYmFzaWMgY29ycmVjdG5l
c3MgdGVzdCwgc2ltcGx5IG9wZW4gY29kZSBhIHNpbXBsZSwgdW5vcHRpbWl6ZWQsIGR1bWINCj4g
Y2hhY2hhLCByYXRoZXIgdGhhbiBsaW5raW5nIHRvIGxpYnNvZGl1bS4NCg0KSXQgZG9lc24ndCB3
b3JrLg0KDQpXb3JrcyB3aXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdlOg0KDQpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2hhY2hhLmMgDQpiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2NoYWNoYS5jDQppbmRleCAzYTVhMDhk
ODU3Y2YuLjc0NDM2NTdhYTdkYSAxMDA2NDQNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3ZEU08vdmRzb190ZXN0X2NoYWNoYS5jDQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92
RFNPL3Zkc29fdGVzdF9jaGFjaGEuYw0KQEAgLTgsNiArOCw3IEBADQogICNpbmNsdWRlIDxzdHJp
bmcuaD4NCiAgI2luY2x1ZGUgPHN0ZGludC5oPg0KICAjaW5jbHVkZSA8c3RkYm9vbC5oPg0KKyNp
bmNsdWRlIDxlbmRpYW4uaD4NCiAgI2luY2x1ZGUgIi4uL2tzZWxmdGVzdC5oIg0KDQogIHN0YXRp
YyB1aW50MzJfdCByb2wzMih1aW50MzJfdCB3b3JkLCB1bnNpZ25lZCBpbnQgc2hpZnQpDQpAQCAt
MTksNyArMjAsOCBAQCBzdGF0aWMgdm9pZCByZWZlcmVuY2VfY2hhY2hhMjBfYmxvY2tzKHVpbnQ4
X3QgDQoqZHN0X2J5dGVzLCBjb25zdCB1aW50MzJfdCAqa2V5LCBzDQogIHsNCiAgCXVpbnQzMl90
IHNbMTZdID0gew0KICAJCTB4NjE3MDc4NjVVLCAweDMzMjA2NDZlVSwgMHg3OTYyMmQzMlUsIDB4
NmIyMDY1NzRVLA0KLQkJa2V5WzBdLCBrZXlbMV0sIGtleVsyXSwga2V5WzNdLCBrZXlbNF0sIGtl
eVs1XSwga2V5WzZdLCBrZXlbN10NCisJCWxlMzJ0b2goa2V5WzBdKSwgbGUzMnRvaChrZXlbMV0p
LCBsZTMydG9oKGtleVsyXSksIGxlMzJ0b2goa2V5WzNdKSwNCisJCWxlMzJ0b2goa2V5WzRdKSwg
bGUzMnRvaChrZXlbNV0pLCBsZTMydG9oKGtleVs2XSksIGxlMzJ0b2goa2V5WzddKQ0KICAJfTsN
Cg0KICAJd2hpbGUgKG5ibG9ja3MtLSkgew0KDQoNCkNocmlzdG9waGUNCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IC0tLQ0KPiAg
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vTWFrZWZpbGUgICAgICAgICB8ICA3ICstLQ0K
PiAgIC4uLi90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fdGVzdF9jaGFjaGEuYyB8IDQ2ICsr
KysrKysrKysrKysrKysrKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdkRTTy9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vTWFrZWZpbGUN
Cj4gaW5kZXggMTNhNjI2ZWY2NGY3Li45M2M1MGE0NjI4NTggMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vTWFrZWZpbGUNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvdkRTTy9NYWtlZmlsZQ0KPiBAQCAtMSw4ICsxLDYgQEANCj4gICAjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICAgdW5hbWVfTSA6PSAkKHNoZWxsIHVuYW1lIC1t
IDI+L2Rldi9udWxsIHx8IGVjaG8gbm90KQ0KPiAgIEFSQ0ggPz0gJChzaGVsbCBlY2hvICQodW5h
bWVfTSkgfCBzZWQgLWUgcy9pLjg2L3g4Ni8gLWUgcy94ODZfNjQveDg2LykNCj4gLVNPRElVTV9M
SUJTIDo9ICQoc2hlbGwgcGtnLWNvbmZpZyAtLWxpYnMgbGlic29kaXVtIDI+L2Rldi9udWxsKQ0K
PiAtU09ESVVNX0NGTEFHUyA6PSAkKHNoZWxsIHBrZy1jb25maWcgLS1jZmxhZ3MgbGlic29kaXVt
IDI+L2Rldi9udWxsKQ0KPiAgIA0KPiAgIFRFU1RfR0VOX1BST0dTIDo9IHZkc29fdGVzdF9nZXR0
aW1lb2ZkYXkNCj4gICBURVNUX0dFTl9QUk9HUyArPSB2ZHNvX3Rlc3RfZ2V0Y3B1DQo+IEBAIC0x
NCwxMCArMTIsOCBAQCBlbmRpZg0KPiAgIFRFU1RfR0VOX1BST0dTICs9IHZkc29fdGVzdF9jb3Jy
ZWN0bmVzcw0KPiAgIGlmZXEgKCQodW5hbWVfTSkseDg2XzY0KQ0KPiAgIFRFU1RfR0VOX1BST0dT
ICs9IHZkc29fdGVzdF9nZXRyYW5kb20NCj4gLWlmbmVxICgkKFNPRElVTV9MSUJTKSwpDQo+ICAg
VEVTVF9HRU5fUFJPR1MgKz0gdmRzb190ZXN0X2NoYWNoYQ0KPiAgIGVuZGlmDQo+IC1lbmRpZg0K
PiAgIA0KPiAgIENGTEFHUyA6PSAtc3RkPWdudTk5DQo+ICAgDQo+IEBAIC00Myw4ICszOSw3IEBA
ICQoT1VUUFVUKS92ZHNvX3Rlc3RfZ2V0cmFuZG9tOiBDRkxBR1MgKz0gLWlzeXN0ZW0gJCh0b3Bf
c3JjZGlyKS90b29scy9pbmNsdWRlIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC1pc3lzdGVtICQodG9wX3NyY2RpcikvaW5jbHVkZS91YXBpDQo+ICAgDQo+
ICAgJChPVVRQVVQpL3Zkc29fdGVzdF9jaGFjaGE6ICQodG9wX3NyY2RpcikvdG9vbHMvYXJjaC8k
KEFSQ0gpL3Zkc28vdmdldHJhbmRvbS1jaGFjaGEuUw0KPiAtJChPVVRQVVQpL3Zkc29fdGVzdF9j
aGFjaGE6IExETElCUyArPSAkKFNPRElVTV9MSUJTKQ0KPiAgICQoT1VUUFVUKS92ZHNvX3Rlc3Rf
Y2hhY2hhOiBDRkxBR1MgKz0gLWlkaXJhZnRlciAkKHRvcF9zcmNkaXIpL3Rvb2xzL2luY2x1ZGUg
XA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLWlkaXJhZnRlciAk
KHRvcF9zcmNkaXIpL2FyY2gvJChBUkNIKS9pbmNsdWRlIFwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC1pZGlyYWZ0ZXIgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIFwN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLURfX0FTU0VNQkxZX18g
LVdhLC0tbm9leGVjc3RhY2sgJChTT0RJVU1fQ0ZMQUdTKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtRF9fQVNTRU1CTFlfXyAtV2EsLS1ub2V4ZWNzdGFjaw0KPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2hhY2hh
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fdGVzdF9jaGFjaGEuYw0KPiBp
bmRleCBjYTU2MzlkMDI5NjkuLjAxOWU4ZmJkZjU3MCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2hhY2hhLmMNCj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2hhY2hhLmMNCj4gQEAgLTMsNyArMyw2IEBA
DQo+ICAgICogQ29weXJpZ2h0IChDKSAyMDIyLTIwMjQgSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNv
bkB6eDJjNC5jb20+LiBBbGwgUmlnaHRzIFJlc2VydmVkLg0KPiAgICAqLw0KPiAgIA0KPiAtI2lu
Y2x1ZGUgPHNvZGl1bS9jcnlwdG9fc3RyZWFtX2NoYWNoYTIwLmg+DQo+ICAgI2luY2x1ZGUgPHN5
cy9yYW5kb20uaD4NCj4gICAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+ICAgI2luY2x1ZGUgPHN0ZGlu
dC5oPg0KPiBAQCAtMTQsNiArMTMsNDkgQEAgdHlwZWRlZiB1aW50OF90IHU4Ow0KPiAgIHR5cGVk
ZWYgdWludDMyX3QgdTMyOw0KPiAgIHR5cGVkZWYgdWludDY0X3QgdTY0Ow0KPiAgICNpbmNsdWRl
IDx2ZHNvL2dldHJhbmRvbS5oPg0KPiArI2luY2x1ZGUgPHRvb2xzL2xlX2J5dGVzaGlmdC5oPg0K
PiArDQo+ICtzdGF0aWMgdTMyIHJvbDMyKHUzMiB3b3JkLCB1bnNpZ25lZCBpbnQgc2hpZnQpDQo+
ICt7DQo+ICsJcmV0dXJuICh3b3JkIDw8IChzaGlmdCAmIDMxKSkgfCAod29yZCA+PiAoKC1zaGlm
dCkgJiAzMSkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCByZWZlcmVuY2VfY2hhY2hhMjBf
YmxvY2tzKHU4ICpkc3RfYnl0ZXMsIGNvbnN0IHUzMiAqa2V5LCBzaXplX3QgbmJsb2NrcykNCj4g
K3sNCj4gKwl1MzIgc1sxNl0gPSB7DQo+ICsJCTB4NjE3MDc4NjVVLCAweDMzMjA2NDZlVSwgMHg3
OTYyMmQzMlUsIDB4NmIyMDY1NzRVLA0KPiArCQlrZXlbMF0sIGtleVsxXSwga2V5WzJdLCBrZXlb
M10sIGtleVs0XSwga2V5WzVdLCBrZXlbNl0sIGtleVs3XQ0KPiArCX07DQo+ICsNCj4gKwl3aGls
ZSAobmJsb2Nrcy0tKSB7DQo+ICsJCXUzMiB4WzE2XTsNCj4gKwkJbWVtY3B5KHgsIHMsIHNpemVv
Zih4KSk7DQo+ICsJCWZvciAodW5zaWduZWQgaW50IHIgPSAwOyByIDwgMjA7IHIgKz0gMikgew0K
PiArCQkjZGVmaW5lIFFSKGEsIGIsIGMsIGQpICggXA0KPiArCQkJeFthXSArPSB4W2JdLCBcDQo+
ICsJCQl4W2RdID0gcm9sMzIoeFtkXSBeIHhbYV0sIDE2KSwgXA0KPiArCQkJeFtjXSArPSB4W2Rd
LCBcDQo+ICsJCQl4W2JdID0gcm9sMzIoeFtiXSBeIHhbY10sIDEyKSwgXA0KPiArCQkJeFthXSAr
PSB4W2JdLCBcDQo+ICsJCQl4W2RdID0gcm9sMzIoeFtkXSBeIHhbYV0sIDgpLCBcDQo+ICsJCQl4
W2NdICs9IHhbZF0sIFwNCj4gKwkJCXhbYl0gPSByb2wzMih4W2JdIF4geFtjXSwgNykpDQo+ICsN
Cj4gKwkJCVFSKDAsIDQsIDgsIDEyKTsNCj4gKwkJCVFSKDEsIDUsIDksIDEzKTsNCj4gKwkJCVFS
KDIsIDYsIDEwLCAxNCk7DQo+ICsJCQlRUigzLCA3LCAxMSwgMTUpOw0KPiArCQkJUVIoMCwgNSwg
MTAsIDE1KTsNCj4gKwkJCVFSKDEsIDYsIDExLCAxMik7DQo+ICsJCQlRUigyLCA3LCA4LCAxMyk7
DQo+ICsJCQlRUigzLCA0LCA5LCAxNCk7DQo+ICsJCX0NCj4gKwkJZm9yICh1bnNpZ25lZCBpbnQg
aSA9IDA7IGkgPCAxNjsgKytpLCBkc3RfYnl0ZXMgKz0gc2l6ZW9mKHUzMikpDQo+ICsJCQlwdXRf
dW5hbGlnbmVkX2xlMzIoeFtpXSArIHNbaV0sIGRzdF9ieXRlcyk7DQo+ICsJCWlmICghKytzWzEy
XSkNCj4gKwkJCSsrc1sxM107DQo+ICsJfQ0KPiArfQ0KPiAgIA0KPiAgIGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pDQo+ICAgew0KPiBAQCAtMzEsNyArNzMsNyBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgIAkJCXByaW50ZigiZ2V0cmFuZG9tKCkgZmFpbGVk
IVxuIik7DQo+ICAgCQkJcmV0dXJuIEtTRlRfU0tJUDsNCj4gICAJCX0NCj4gLQkJY3J5cHRvX3N0
cmVhbV9jaGFjaGEyMChvdXRwdXQxLCBzaXplb2Yob3V0cHV0MSksIG5vbmNlLCAodWludDhfdCAq
KWtleSk7DQo+ICsJCXJlZmVyZW5jZV9jaGFjaGEyMF9ibG9ja3Mob3V0cHV0MSwga2V5LCBCTE9D
S1MpOw0KPiAgIAkJZm9yICh1bnNpZ25lZCBpbnQgc3BsaXQgPSAwOyBzcGxpdCA8IEJMT0NLUzsg
KytzcGxpdCkgew0KPiAgIAkJCW1lbXNldChvdXRwdXQyLCAnWCcsIHNpemVvZihvdXRwdXQyKSk7
DQo+ICAgCQkJbWVtc2V0KGNvdW50ZXIsIDAsIHNpemVvZihjb3VudGVyKSk7DQo=

