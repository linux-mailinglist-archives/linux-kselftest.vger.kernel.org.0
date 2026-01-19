Return-Path: <linux-kselftest+bounces-49416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F254BD3B84D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EEF23004C95
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8F2F0C6E;
	Mon, 19 Jan 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iok0Au4Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26692E228C;
	Mon, 19 Jan 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854470; cv=fail; b=iAtqrwXkPfv5p4CHsIvbmMyDEe2MQ2XVV/4Wf7tfo94GhxSbptTlSd71u2uvHxZwrzwBr6iGUgs4exCTEnyaeVUZGI0uDHeZF6KFaGAthbm2u74LnOKFeenC+AOBVS6Bcq/HirgqKIgNSgb9DS10+3sWJ6aI9q0b+hCvx1iNZ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854470; c=relaxed/simple;
	bh=Rc0i9IKrnlSBysdS/3S7qT3Xnv3Gb14osyNsU6giYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgX1QZoKLyPxkuGiVYjEdKkosrpA+7kQXJ4xqxPAeOd92hLLAXFoVzkKm9e7kd4J+NJlOyl/ssP/B6ve3rGqNA0m10SzXDzqlfkbg90iLPOjULMPszwpozlVwRdGcLpxKDi3JUMPYS7CJ8Rw8MpHPQK62zDgGqVjQj/AfUgH88Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iok0Au4Z; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fviGNDl8e2nBN8ErjkjBXRjzJ94hr9W9crViT3aWaf4BbtF25QxOqcdqvqrbXsfykHaJ+jmnt7PcGU3uJaGBFkSD+z5ciInsr94rdJ6cSkNO7Q79mn7k/QYo5O0QqaFal03guVQkUpW2eRTo08vYC3en0qpak2K8yZD9hxBCLpnGFOnBo3aaF9K6iiNtVR9+C6vNx409/OiL6p8ue6JXdWSBR1aTuRqb+FGFS3lMvkQMBRNnCo8fFfSxrX+75O37OID0Z69kDPaBWzksBRjKu+4aYZolK1UeKeQ+Mgtgs9quLnTbCeMbCVjl4gjh2ofz8v2DKBG0H9Jnv3NNQZKtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO7sXq1qVC6mndShnxa+VOnzZPfsgIjNYp7XzRMldMY=;
 b=EDAXfUyjChLF1/JI7f3xhXr7DDhs5KA/Iti9tf86BhP72mjYRsxEwipy6PDlLs9vtgasmXQXKR2Vgyt67gekWOoyujtGYZw3SygrvDTr3D4dgAfnBDd2T6rS8T1/b8P/vtFPRFb4wEDTH+eMphFovcS4YkM2bfJHJvLomRMmWxb1SdkcA0AJQPXv1WIgMvUwQQ/RaCwDfOhqlLKO3F3ihAJVxyMaU4dFggDDRXOI5/5AmRf0Bzjt+MfY2/Ku8HmM3K49QPYcOLCemY0cbY5fLDVneKhB3H0dPwJNUxmn0bdMLRjMnA/Ao4jY9wAG2z7DcW1v/hTQ4DZcTkZfIEJJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO7sXq1qVC6mndShnxa+VOnzZPfsgIjNYp7XzRMldMY=;
 b=iok0Au4ZvDMAX7eyXRzqVv9rMGM+Kh3MrPQdQY0JQmgMPJHWKYucWq0sb7x2JU8Fsaw+rD+lF0zMUYByYbxAA+QMKeJ2uO9XEUVt2RY2uiOWbDDO56m5BIjA3go+/dgquPy6jcskJUIdPfrNVzjn1go6kxLpvzzmIZcGwnvcY53M3cVr8B7WXm48izGImLsVq8VrCmnX17DfHW8uf5+BNXe0jLQEDAkmpUsDLuKOTqpjQpKkwl292pEzjEc3Ers8mMoLNqFEKjRiZyj4kEI4b9HrOdke2WXCS5RbvQnWHgYDqZ5lbkoziW5SH/Nn/twaULD37kQUmyNEs0zKQC8Xwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:27:44 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:27:44 +0000
Date: Mon, 19 Jan 2026 15:27:30 -0500
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
Subject: Re: [RFC PATCH v4 14/38] PCI: endpoint: pci-epf-vntb: Implement
 .get_private_data() callback
Message-ID: <aW6TstKUDLn8gPD4@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-15-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-15-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: eac473d2-49f7-40ea-9e1c-08de579933d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvbqLSq1/3qRNzpPVS6EVPnkWuAzn3OSj4Ap7Pyo143wdOO1yjUcpjf5uPxm?=
 =?us-ascii?Q?ZDU8yM+2/sFXJ953sAfjqSBIha/x1mmDz+SkSZWAgtcaeGRn3MPBwZSZ6ZO4?=
 =?us-ascii?Q?KeYX0Vt4SW9SfQAoSvx62U2hERsjhcNr4tqbIse4jtp9HRH4eyjoO2i8Mkdp?=
 =?us-ascii?Q?lzUt0b4/7mXY0URw9vDZdeWH3BLGgIZmH41f1zwY/bM58sMC9+qzCgDs0NAs?=
 =?us-ascii?Q?UC1hHBNKGO5BOX4Ggg8lLJhSlEVp2VEhkS6KBh1s75G5PxCAI5wk5CmzgUPg?=
 =?us-ascii?Q?U68+8lXYro7MEGHNnFIvBTOXnccFXCjOL7E2HRVZeMd+QZvM7qsacSOCStBc?=
 =?us-ascii?Q?Qxg7SQV9R1miPlLcoVb9FKEorNDKt6exNyO8jP/yPmOuvgh/TAL+yPymkSf9?=
 =?us-ascii?Q?xm2Rab0trxiMgDb00ZEdtCJfnsPe9262b5XB/JneP8nGZQZkMCzIuV8TPEML?=
 =?us-ascii?Q?W3mtndwIVSKzt1MZSarq2SFLslBkfPWHOhaFknmO6jiC1fauFbfJ0RS1BBLE?=
 =?us-ascii?Q?08D7eZuV4RT5vdGIpZA/78khdemsFwChKF/7mn0P9WrtkE9zjZxBMzS58DjZ?=
 =?us-ascii?Q?axNskrnte3ZeQUdkpdSBvK3yCPSBsgm91owWYSsznlUZXbH6nZM6h7OOgsei?=
 =?us-ascii?Q?OocteMQBZmshwRRDr2kaMBpZ8a9vC86GQKrGZfOZuS83CLYgAf6DR+xQcnPk?=
 =?us-ascii?Q?tNk5+Yz2189gUJzMPxHn1fTQEHCB/2ee+d+vJjdM55l/LfDxVjVFhME3TrjY?=
 =?us-ascii?Q?2ipQK2I0uhWs1spygyTBFsOtlHBvAd5kuBdXJdJQ11JS4gB0LKgrnFaX3RQ2?=
 =?us-ascii?Q?/jSBn1cSksaOXpIf+pwcaaCPoFPFXO3xB2osLZtThyMzJm44jIzTxTIlA7MI?=
 =?us-ascii?Q?XvPOBkkY25uz/y7WHQqnej61cJW379D7ZI9+cSQ6fQhC+MjjgDFW3DtQOpYD?=
 =?us-ascii?Q?zsNZsV/zmGjfQH6QB15XbXhyKb6M6gfC7fNiAbxOvrvtdRjhdlxSKx42CuOp?=
 =?us-ascii?Q?kSDOBi2QThXZApBf2d065bs/B/6Puhw6dkiLsnf6HsTiRSkDtYNEBlSr2haD?=
 =?us-ascii?Q?KtQNrhUhDi/rnxgWYHk5KDU0xz0Q2KrTvS3exCx74DTqHWitlDh0/I1UWgY7?=
 =?us-ascii?Q?AN/zGdeq6LBw4dxeBlsGksLUUBTYD/2xOv5ejTDSRcZd7wP2igHOiXOwwHme?=
 =?us-ascii?Q?OsHzNTh6sJQGgzzrH45tNyqW8nYYhhsucV8kpz/NLIh9SEwo3DOndFRJnKqq?=
 =?us-ascii?Q?bJAWhtywQrk1WFjIOCMlfWsdL9wUO/OxfInE0TzlPOq7/QivCxPL2dkYarkq?=
 =?us-ascii?Q?V1qSSy6S9O9VmTYAL5dYFQXi9JGHQjSiVWafCTW7a2QYZZ7ZYR8Op0kBvIQZ?=
 =?us-ascii?Q?+mvISzlf9AyXH8B537i1NiwxLz54dWRTmMDBls45BcmusGVAgyNUZ/K5Cp6e?=
 =?us-ascii?Q?oETKPW4IgcGXc5SLdGNzkXnf2yiTgNVv+QPfnMNryoeoRWga0gIpgQUwgu3Y?=
 =?us-ascii?Q?qLsz2DzRiV/jgPp/LcJ5bUek9GT1i2DLgWVN6CFg6GriejvHy/hs1y5a6wBV?=
 =?us-ascii?Q?Mv2Nwl3DapngQSIUCCdnA3g3tijjE81sPgjLjnAk8UO+caoWejNmM1QE2Bee?=
 =?us-ascii?Q?b2hmjX+fi+KS9lkdaE3fWNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXp3ZSbfbbTzwAX0bl4IGZ3W08AAUu4qEf0J5ZytDdnDguR6+n+bqBgHV2w1?=
 =?us-ascii?Q?fEncv303tB6pGtM91ccW1GAUDt3K20Dz2aM1u3co2WJV9vRYk0hXuFR5iSjj?=
 =?us-ascii?Q?czQFcLw/rjk8WhqnVzi00euTaEy2TS8mzWdYzdemmqbO/A6u4tEVXqASzmKF?=
 =?us-ascii?Q?Q5t5ocQb3Cd+TdsJd8gmdHcoBwS/BxvgK7sNmX7WHjZPOHDjDQwOBaonSX9z?=
 =?us-ascii?Q?S05KwU2Oi3b2z7+2FjQJGCLUELd431jPhp0/jcO7zzm2t9ApzQwnlXiZ8ZCK?=
 =?us-ascii?Q?BePyoyguuNY+vALjxbRfZNGcQCqcl2iTDiELhPjQ5vjcmXjnYX36xElMi2CT?=
 =?us-ascii?Q?d7RMIiYz57zTMp+jLgCFO7akgFsbDPz3FSkfz/k5UEuAcs0nEr90YHLAFnzo?=
 =?us-ascii?Q?O1HLhkXOzr7H7TZgsxvPNVaWzLmNTQ3sWj9Bnk++ThHYggLHUGB/GZ3NqGrZ?=
 =?us-ascii?Q?BGaKu77eNpTaBG4289x+JMyL41jQ5jQrQIQVN1UKypNpSBQ8LTc3HPtm+v4b?=
 =?us-ascii?Q?z9NXaVl52KCyk9GJvXZTtLcGTMxL10LkParWzYZIX/XdT827+fWY2BwgcfSO?=
 =?us-ascii?Q?rEna/4yvmcPElcGzO9AWuQqlGUaWw/arn001KHaCU9Y5cRUMPDy9zVnRQOyV?=
 =?us-ascii?Q?Bt3bC/eXcLeXC+1lZvA6N02lnz+wC7Ok7QBOHQ/no+pcAi2aXY7bPAYamBg1?=
 =?us-ascii?Q?8kzDtubZ9sceYb2BX1orJQliKFdsmcC3JltkNz+Y2Fdcwr5Nx57x2amTZqgD?=
 =?us-ascii?Q?4u3FH4oxDxmeOlXwqKjJ5stVPsxFyjhJwgBvMYsfL9S2U0drjTSlavFL6ZNW?=
 =?us-ascii?Q?2qz+oNuLtA0+3gsjTSWZ0QuM+SD3RmohXe1u9eAiKHQYKVm98e4jIeUI3rvT?=
 =?us-ascii?Q?iIMeyQ/eYSr9oLeZHm4hYAUqf57+C0F1RPdFlCca9FLdiM9g5UCdaDj81YdI?=
 =?us-ascii?Q?G3bzM32J1jSWmvpK5mMMtCVTcv4yXI08spyOxvUfOHWFPlWarBbEySbgDvp2?=
 =?us-ascii?Q?hlItgOnZmeJ8Gjugbi//GFPRrI82aEzxkCgZMm2KSpkHtUIWV1DOWDjR0kCt?=
 =?us-ascii?Q?eVN0Oy77FrNBziRTBIuYPtwJIVJKmrUG8ae6Q1EqDAjIA015wMJmI1VXTtqb?=
 =?us-ascii?Q?7i13u/1Yqw8DnbUn3gBReXYbJ9HMX7jMiiIaxudX0y162/+9xyiXd5stU+GJ?=
 =?us-ascii?Q?P7jD1s9yujPGUZbJHcfp7/Qpa3W7pIIV4v/CkDplHE4/uGPDTlWzcrp/CxAq?=
 =?us-ascii?Q?m/69HZ+dg0FBmY5uHbLMdv/CwfqWymPBtIgFBo0YFLmndTtVA9F2/eHZhnDd?=
 =?us-ascii?Q?RPYREsuUy4GOcATWK3kPl3AQ8gJec5eohYGFoNxl2jXXrBbIC8gouR3Pti8u?=
 =?us-ascii?Q?YB/FXS47MBeTHbmd0Zz8YqOkfIYnEXxd7NMlkg7vI8wRsLit0ISstD9cp3ME?=
 =?us-ascii?Q?PmCdfQ6zitFjBPYzs85+n18Ctxk5H728aQQerrx0PoqV8VIP5ELI4EwBDuWv?=
 =?us-ascii?Q?hQegCYZ5BebL936Gnt+I3g+W2wsJjOy+alpunvI4+MmahnjOQv78F82hxnNV?=
 =?us-ascii?Q?OES7+5CFOSR+TbrqiTTI7Qe83IkFdByEoXx4DOEYGIsiVA7bLcNpxLwGeTGV?=
 =?us-ascii?Q?76/DTKAZy0mtIjL6ij76eGtNuG+8t0V7xlAR+QhjrbEJyU/ywDeXtYEh6Cmq?=
 =?us-ascii?Q?c0NpX0VOGfhSrsmJXRJR+3D9nQjxEHPXrGVMzm5gi/GXz0KI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac473d2-49f7-40ea-9e1c-08de579933d5
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:27:44.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gZOb8/3Wo7+y57P0EulzNqKhwyNgGUbobdXUX1Nr1Z9pR+qyYzN8i2kBa31vvH52TP8dibkN0RNX4lqA5BEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175

On Sun, Jan 18, 2026 at 10:54:16PM +0900, Koichiro Den wrote:
> Implement the new get_private_data() operation for the EPF vNTB driver
> to expose its associated EPC device to NTB subsystems.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 98128c2c5079..9fbc27000f77 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1747,6 +1747,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
>  	return 0;
>  }
>
> +static void *vntb_epf_get_private_data(struct ntb_dev *ndev)
> +{
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +
> +	if (!ntb || !ntb->epf)
> +		return NULL;
> +	return ntb->epf->epc;
> +}
> +
>  static const struct ntb_dev_ops vntb_epf_ops = {
>  	.mw_count		= vntb_epf_mw_count,
>  	.spad_count		= vntb_epf_spad_count,
> @@ -1771,6 +1780,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.db_clear_mask		= vntb_epf_db_clear_mask,
>  	.db_clear		= vntb_epf_db_clear,
>  	.link_disable		= vntb_epf_link_disable,
> +	.get_private_data	= vntb_epf_get_private_data,
>  };
>
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> --
> 2.51.0
>

