Return-Path: <linux-kselftest+bounces-49293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9FAD396D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7AB30B02B3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77773350A1B;
	Sun, 18 Jan 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Hjzj4TOT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAE34253B;
	Sun, 18 Jan 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744555; cv=fail; b=rbLmt3DW1pHGnn2FOKAUpBzW6xCWetTQ/zLKzQhnHoixE9n40gfRHJ+Yrs+Rt9Ju2DbP3Pbfy8dFPTtrPVFvRK3z+S7VmD85ureN4uww1WRSwmxn3bPlz9xYMQ4EfZpN03wlijqdxLpAcCa3yDVbowtmbnVG8I7ViYRs4hbky+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744555; c=relaxed/simple;
	bh=/1OXLMEl0+xEGADqX4N+3aFF3M9YFod1lihNvIzYdlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5v7Mc/oXfBG/+EEXpykaXMF4Y6tV6XLIdAEMSVC78ZgEvtFuvX3IIoUidk2t05Ip3EAgRzmBjyrTNJhfu39QGPlh4EGa/Rw2sRBo/hnoE/uym1uZx9BGpoH2ReeufPV8m1ouhst32FdQAjZEchahgatRtvUapWieWEnfGo4xp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Hjzj4TOT; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igAHC1k9oSMHTYmT/sGsjYeM7aLmZZ3aTMZJNFxcSU+Rqq7h1XG23Qn2K8k52E58RkOVAzpwBlS1+j8SiauK/Y+RNvZ/e+Nv7WBlVtteOZ9u6DppJadXL9mtfXzWwVFkzKxXldLyUff1pFyA7D/bqGbJlcmOPzS8ajGx2q8zcU+Y0X5q9dmL48nL78CH0qkC/CzmsfDR91mX/RDmKedUvPjoLAs2jdSpMsPBLkHf3yeqfLwvao2024PnVN8eb0YRmz+pNtwTCD/aiMueonpJsACjGObWxQHh37jQ5lVr6D3HEPkRfz0Uv4DOkaKAtMPA/Q68visTvqX26NHpbh/qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP2NFmFhezNJzOBBHMSBbmnhldv6+xAK3DW3wXhut7w=;
 b=RtytRD5BmeEDTj0+Kkp9pnVCdVaQEahVGXAZEcrHSU6eB0RoT+4sOgD1vM2AgWKZxcLP3cBlxMuo1s6JHlAMmJ/9S5HxHrS8hc/taNX5JTS4xpqO89yrGB8mI64NljjHgELMc/jKRylhnxjPlphobweGv/qFvjzNp7Uy5Y8RphH+pZ+zez9UlNxpcLR/JUaTqDnCHacnRywsb9i73AKRAYCs/V5PT38YtR79vxa8rH6xC/QOQAQ4zkzZ2OOVIMWB3Yi3Ib259OPsQpTJYbmLtrIRr3xgHapgDpn7AjME9cV7lff2yLWOB+FhQwSV9+t0aUXjxxXo48DcTw/3ouhf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP2NFmFhezNJzOBBHMSBbmnhldv6+xAK3DW3wXhut7w=;
 b=Hjzj4TOTpHBz2R0DbeFicn8k78pFsJntYkM2KKXG8hBPmGxUqXsJ3SsFWogpAEImIZdXxZ9kB7BrvVnV1fYNcdGtCf7at+dQNGEqBZ+atfTaGbWKyeLpeM49uvUXIAXItE4CRvW0sKeteehmx0FRL/SIJ08c+6dcgj9Hac6bAiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:46 +0000
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
Subject: [RFC PATCH v4 30/38] arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
Date: Sun, 18 Jan 2026 22:54:32 +0900
Message-ID: <20260118135440.1958279-31-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f125d38-3c57-4ee3-6dfd-08de569935ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PlU01bIsNAp206Y+FOvadpDMU1gSCvXvO/pYk9Yn0iW1dkXj5Rt/uTc7gliR?=
 =?us-ascii?Q?4MW5pSdfMWUXmpdDtRwJrUnTzBRo67G4Agq+HWB3UdlVfg+b1d/Kh+SWuIi+?=
 =?us-ascii?Q?Mgp/vZ7DqiY7+rngr/ttUFwzq3oYkuB/yzwKxjP6oU+GiSUosIR5/jM7+3qC?=
 =?us-ascii?Q?76U556qvb4EL0NR9PGnln7t/ClOu1PriRJGAYESALo+84GxIdpfrU3/vFBsB?=
 =?us-ascii?Q?tYwk2CA9UVPG9tzHDlkXvcbqvL+eMC0q/tsnGEgSl64K222eeRUEhYLVCnZe?=
 =?us-ascii?Q?DwmXfmUCNbEZDp31o6iM9uV0LThho89LJpd7csMVnW3SHIZVoWGjzbXbXavH?=
 =?us-ascii?Q?TackNj/a5lMDKElcxrhF1ei6aomAJ3pfbsXviewDpD2XQJ3DM5C6WWoW24g1?=
 =?us-ascii?Q?HjO23BtOhI65Q0uDddgywwnGNKULMc+3eDpyKlYo4wjc9MGnir3hn0bTwg61?=
 =?us-ascii?Q?iI9fFMNuyY9VOPOiAf91z6aAdL8GUF/n7c+EGihs/F0+2acIR3P3LBnqbtWG?=
 =?us-ascii?Q?eDhOYCiBMWjoDQPHk+eLlSnf9qT5uf8tv4ZxrdXszLuHc98pc7JK73+mDVut?=
 =?us-ascii?Q?fUGR5wRcoVBNU/nVxqIwRI4fWQLNLSpS6fWXD2839LNtnWufq8ZD0v0OOHra?=
 =?us-ascii?Q?g5wkiHFK9jyd/Kc07f6pc1/dSoOopy3yL7aayZ0E+0sPrZ+cC1rURGqX1Bql?=
 =?us-ascii?Q?uUwXzoeWvMunFOL2CGnKZlCkR18fKSHUzXKX0ZVYBChEKR9b6VAtfPRUG7to?=
 =?us-ascii?Q?rhueB5+MMzCSRBNKSmq2Uq41zlL4fMQW4UwTBT6vBjCtDNa6VBksRweaC9+/?=
 =?us-ascii?Q?SsK/W3KeSLTsGpoK8+RTPMyv4ejPQNCTrbOKXM+o7ob90kfrvSxCsbVA+/Df?=
 =?us-ascii?Q?rnk1KaCUv5XuPZqB1xz63+j/c68ens8Le1RN3+zzbpN31eGWU3RV0ROAESUD?=
 =?us-ascii?Q?5PSupGd026+Ghgvt03fZU9dpQuZFT5he//Ru1lcKBL95g/9YHipH8X+8mOAK?=
 =?us-ascii?Q?cFnaJJ/u2Fi5qL4nXXz3PZiUcayZdFDVmH1u8ylzmPOmK+dLLbNLHAvXGUZc?=
 =?us-ascii?Q?JmXELiQnAJ2KSAHMNZHL1vmDNLBmBAivSVoWJX7ZpdZW/hlDGg3yYUs8ld/r?=
 =?us-ascii?Q?96EAXu3M//uV1tHM5xncu+UJVzL4Pnj76kf6l5wS+KJ3WT4L47Uy9W9hZ9yH?=
 =?us-ascii?Q?iKcufTWvfW/Td2N3O+JSDajZWXIhwydlj9nQxOH49RNTAfHL295wMd/cAtdP?=
 =?us-ascii?Q?Lo42Jl1OdizA201J2p66N3WRQHoxTnMpTKvtCikQR+pc05tNeakVVFZsbk5Y?=
 =?us-ascii?Q?nS77JhYhwTODgiEMbZxYTvOJDPXTHeSYo83fAxHg2Uk+u1NOlZtw+RZKCflz?=
 =?us-ascii?Q?+MqEoA5IxoLGQ9bcNqXPb9kv0lT8D7wkHnH9+XNkvtWpFsK1PJeTUu5z3IrU?=
 =?us-ascii?Q?SIhLWmayaJdhm5S0M0RddPcXRQnkozuBX9lvE4cP2Flkl53Wc4POQcvfzNl2?=
 =?us-ascii?Q?kD7A/mAaVDkI3q8QddD9RPlJuXYnCILgKDKI94yfvet/5nPpajTJ2xtl1KZe?=
 =?us-ascii?Q?U+QREz6nGjD3MmSgu72uNG+SVIjvh8TJ99s+PMgiLt4fh4ZszM+bkzU/JZ2s?=
 =?us-ascii?Q?iA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOFxw9CGWutXdYLPTlIGCS+QgdOtM5Ps0GfLa/gIp7AsXE6L1VKXDTmWHJ6w?=
 =?us-ascii?Q?VO5QdC/jUSE1F43TIZXbZaRW38CVs3evwgeKvJh3e9LvKAl0BDHVKgve26py?=
 =?us-ascii?Q?RPxfb93qp158SOfccjp67Zei9YgmH+X6VQFsXFJTu5SnzLdigldPcsOrVFkv?=
 =?us-ascii?Q?3ZXJf2ugkN1kV6yZvEJTMqxz2cFvsXSTYUfADKKgE7Cj0eXNfP+yUidt3wil?=
 =?us-ascii?Q?2dz36n//F3mqO47PP7rHzEjDRjyf3i0ZlsWT6e6v4ot/P8noCDLv4lPnMb+V?=
 =?us-ascii?Q?lhvdXRkgNDYIk+avn6pLXxCHK+cpM1JQRIGBTcg56+Y5F0qJgIgybdMoTB+Z?=
 =?us-ascii?Q?/UxziIg4u+UxeGTx98ohQv1zgOiJLeKLy/+EK6JFnXybf2w2/AKs26vPlDgD?=
 =?us-ascii?Q?tOHrvNrK/DMUI1//4his0halPk8odtF/vS3kkNtt5+AYqH1+5E43v41YMGK7?=
 =?us-ascii?Q?5qP+34MHAYB7sRzAAuDsEnw/7vCvlVBTJurjZjv8/HfbEH+x5XkiWWDAqDdu?=
 =?us-ascii?Q?jgH/aGzlMOAU2TOKeMhBG0LqeHU0kYetN3AbmwXT3zueV5p5dgSZYtfeIgTN?=
 =?us-ascii?Q?1pScRwIAZod1wEhTg2ZLTVQroZNFU5IXeoeA8/uruZYEpdlIzV0TwBN91qQh?=
 =?us-ascii?Q?ZL4c9Pv4JW6qIZwhi+013UrcU1o+u5gSnvdJsR1NTOAWKp7P9lmthBT6SQkb?=
 =?us-ascii?Q?K8j+HisEJsHIWfwCUJO29Y7EuSxFGsudr76DNr2j+mZ+mC5FoGmT/9Ky5JTk?=
 =?us-ascii?Q?/FHEcEVbY5Zhl/J1rKtWQGADn6Qob5dbSUfgm2cOvJwlUMlWX+vdwq0CEunU?=
 =?us-ascii?Q?VySZXaYyouLr4hV3gDTIdSG8viqZjBpWX7A4MbXQXLweEk6s9WQMIMoufll1?=
 =?us-ascii?Q?Fnt8xj4268xALZokxElmeLhY3jOh3P5bRMFXR0Kh1yucWfW2VDZf4GlOXCwg?=
 =?us-ascii?Q?JGbuVm4NJ5mtkOetxm4o3p9x3TwqW+afDz4K4xBGFLXTobq6SdP9buFt9O1p?=
 =?us-ascii?Q?3lUdYmpJZbmpdhW3lKxv0tn4rXe3jrkqfn4+USQTl+u+pEqxEtLyIFzv85uB?=
 =?us-ascii?Q?PhHBUEXrgGUp+8oXgaYDhQMDcYd8qHAo5X4AL8xmDIpF0pQKVCDLd4obevuX?=
 =?us-ascii?Q?YwAuaQHR9/xdB3rCsFfchKu5U6DewZwHDmN18emILxc5d7z/YMQaXq3KsB//?=
 =?us-ascii?Q?NpnX5mQwB85F2TRZM+kxP94cfj0lKTBDgm6jNSVtmyKoaQBIOvHnvKG858AO?=
 =?us-ascii?Q?jU1dt4XBX2bcszwtNq0DwEFTqCV6ooxZshgE8OK0/5luHeKaddiVEVhiFst3?=
 =?us-ascii?Q?tmxlyURfkjMEsWeRvyjOZvbLIuzGeEDfXmV6zJfRoYZb2LrdOC0bp9G9rKLF?=
 =?us-ascii?Q?IX77hpAe2vGMSZqMF078SWwmORa4v22i3AAvnIsRnrIjy7s6ay/NMMi90L3C?=
 =?us-ascii?Q?WW3dn3139EhKrs7lM2N0fH7NR+f3k+hFzAgej7PKnDItoNZx4Q1XyPv6qP/u?=
 =?us-ascii?Q?6RfzS4v1ibpZoJPQsraEGYl6bzuj1Z1wydrZG0bnmDgizVM/Ze4Rms2xmrs0?=
 =?us-ascii?Q?F+jzbuJ67+3wI6w6bSoOzGEBSm4uk8un22YJzSg0k0Ql9QWMDhu7XZcodGG+?=
 =?us-ascii?Q?2nRAbmMwP0EyhMTc54GQMsNsS8Cpp+C+4BHUHagj2L1198z/J45zYoDf5HpF?=
 =?us-ascii?Q?FRlvpwl2zdyx9WOCF7cNodz6P7P7Drv6KZ0kmOkTnkz/coPJmTn8L/osmRrb?=
 =?us-ascii?Q?xLsaJi1QdKvlP9MepxvpX3AgYpGajuJ+wmMtm+G664oHBMNf6q8s?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f125d38-3c57-4ee3-6dfd-08de569935ef
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:16.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbDbNljZso+16ZBH6MUHCXofm+Ts+7vaK7NpBNncekkBRVkpi5tEjT/PEqAlWMrlEe3tuFhzwZVfiVhhwZVeoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Add dedicated DTs for the Spider CPU+BreakOut boards when used in PCIe
RC/EP mode with DW PCIe eDMA based NTB transport.

 * r8a779f0-spider-rc.dts describes the board in RC mode.

   It reserves 4 MiB of IOVA starting at 0xfe000000, which on this SoC
   is the ECAM/Config aperture of the PCIe host bridge. In stress
   testing with the remote eDMA, allowing generic DMA mappings to occupy
   this range led to immediate instability. The exact mechanism is under
   investigation, but reserving the range avoids the issue in practice.

 * r8a779f0-spider-ep.dts describes the board in EP mode.

   The RC interface is disabled and the EP interface is enabled. IPMMU
   usage matches the RC case.

The base r8a779f0-spider.dts is intentionally left unchanged and
continues to describe the default RC-only board configuration.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   | 37 +++++++++++++
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   | 52 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 1fab1b50f20e..e8d312be515b 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak-panel-aa104xd12.dtb
 dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
 
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-ep.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-rc.dtb
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f4-s4sk.dtb
 
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
new file mode 100644
index 000000000000..6753f8497d0d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe EP mode with DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	status = "disabled";
+};
+
+&pciec0_ep {
+	iommus = <&ipmmu_hc 32>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
new file mode 100644
index 000000000000..c7112862e1e1
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe RC mode with remote DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Reserve 4 MiB of IOVA starting at 0xfe000000. Allowing DMA
+		 * writes whose DAR (destination IOVA) falls numerically inside
+		 * the ECAM/config window has been observed to trigger
+		 * controller misbehavior.
+		 */
+		pciec0_iova_resv: pcie-iova-resv {
+			iommu-addresses = <&pciec0 0x0 0xfe000000 0x0 0x00400000>;
+		};
+	};
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	iommus = <&ipmmu_hc 32>;
+	iommu-map = <0 &ipmmu_hc 32 1>;
+	iommu-map-mask = <0>;
+
+	memory-region = <&pciec0_iova_resv>;
+};
-- 
2.51.0


