Return-Path: <linux-kselftest+bounces-49310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0403BD39849
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40671300B827
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48123EABB;
	Sun, 18 Jan 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdWCMZV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D91FBCA7;
	Sun, 18 Jan 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755965; cv=fail; b=NeAqqu5jOGGHKQ8EpnsYuLXyNZm97yCVuPxxUPU4Dxk+LpXdanlNL5MBq7YB25JpsZBCb+mmxi3LyH3cJ+DnGNnUcuOYmHEW4YWne4VrIZYyq/+Z7NTugjdVT1NiWmXY/5tTEx+KowI0EUXwcVv5/gPfHIFuhobruZHUOj7lmUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755965; c=relaxed/simple;
	bh=zXQcwql6ATi8dcCXyKxOOW7Nf9pVMcQ56cCkmxFv6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQCNqF/F5i/dFAo0DxaQU6mZwvfpopPWI8ogoy3uYuOJjZjm0QdikkNUZSnDvJWr4k38uwJrl15x3fwi2sLfIQlKXpdE9DO5/8OFpgtSvapFqjywLCuZtTMHmwNCXX96pgBfK2dlawOEo8Z4oLjF8axqvaWUifidICMy5ztJqK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdWCMZV9; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsOeIEVjiMUkNhcQ2PUiOasEix7U6MaMpP2jlvCm5WWCsCCZG4K36z1ehrS2zzJg+5KVoX1sZpRjOWyzTYXh/GOoJTMq/BHARVK0FdjIj5vUhOa0iKjf3Rcq83lmYjSUikErRGFEoiQzbIZOf+BS+IofQFkeUB0+TaEbr7mpHFhUXTVWbN4TvDU6g4vrsdnaONrPxJBMvBckH/e1EQgXS36AbFXKGfnfqSV4Bti7n+bEtPN2176Jy6E1JmUI/Pjt9UkIePA7aDxLXeC6WwrlO0awRhy1ZqPf0N0tOHbVaNBAcutoIg4ie1QQFJn61hMftTb6Hczu50i3zQYWap5K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsqWmCo273fOm/omFvQdKZAdFvB1NzgJ/lyWKg/ymgk=;
 b=chWGMWOltnq1xjUuid7uxSAceXJO8Sfr8848jrzOoBcXYxSutl6wdV6j+QAGsslnHfOEmZmsgjYjun9qYU0FTHjjHYWhiFAZSV792KHT3ara4x0LG/wgFVGlsSrMlx6gOHdS92MWnuZBz6Op2Y52SfGt13c2bo8l/zLGUHtPYAAqTmY3g3R4pyvxZ+B74F0Wdd/0egDInXoyvnMA4OeStASzKJJfY7SADmNJ3iUDYDLaF4MS2vcbSmM0hXzq3UZ2EsQp2f3OZ23OPBtCHwIL3l38ILncb3iqai0cfrQOsSSKPoImpt/+rGeqY1QPRxiY+BVDlNVRrj0LLbQz2VHvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsqWmCo273fOm/omFvQdKZAdFvB1NzgJ/lyWKg/ymgk=;
 b=XdWCMZV9bRceycq4wWR6Gy1qobPMnn0MGACsoO3iIm7grx4vWRL4MSeQuXVbsWGBjBsnOugS+i0ALkEenWEXfxdwqBJ2+VBQxydqzZPg+MFKNeDL5GjnxEDqF1un3+eLttC5YjPyHMmTIU+DsSVEhOZ7o2lxgtYV57Rv0pEXW22Blrh6ONXyuC5RUNZdO9E56kj58/jlUwsUMdr3NPqtjQ9AiNvEDU5VKSQHq+KIpFgwRZ4CGs4EEiE8u8m1iECG5muTgU69icxXGsvWcze+THLFj0ne8OP5pu64pnt6TkTKFm6p9TJ88f/T7Ns4zmRMQN4agRe7AcO55NPY1eD2kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM0PR04MB11932.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 17:06:00 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.006; Sun, 18 Jan 2026
 17:06:00 +0000
Date: Sun, 18 Jan 2026 12:05:47 -0500
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
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-6-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM0PR04MB11932:EE_
X-MS-Office365-Filtering-Correlation-Id: 36623560-a3c5-42d7-bffb-08de56b3dae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aSXxhZLW6zbkMJs0LOMmgLosL0nVrgLdmPYBINDSZRkXkOYOFrJIL7Qg5o4U?=
 =?us-ascii?Q?3c7dC2VFSC+S7P6j8QeRzXAU/cnF0PUrAze/A3qNjE7gJoqqj4QvH8zCBVaG?=
 =?us-ascii?Q?RNVEglvRavmfZqGYhJFMaiRoUMBRzL14e7EHrBlRbkWlDMc6VJo8Mq5ksbRz?=
 =?us-ascii?Q?iQInzzpXEtiLlK+q3wCUiLeSuULXy8GGWyvhPjHeos7gC7MMJaGWIdOn0HNF?=
 =?us-ascii?Q?DzgnImqYdhxLRqXb5kkPxQgK3CDe38FUgNnjWvpN3QmRu7I9i17CyXtIhWuK?=
 =?us-ascii?Q?IO/FG8dJEl7rAJbj5pqWrOhYVN2FvE3ap5z/D1fPhGaJmBfcCIg0UGl81fiW?=
 =?us-ascii?Q?p9kAKNIFtZWDF8npqOviCIaTPkTiLU+D5qgv3m0hKGH9UpzNoaGYe0f7c6Mk?=
 =?us-ascii?Q?psQzKCNXZFRsdJLd0knP7eJA23Z4ThqU+phzsey6HZKZLlPmNlzYPLD1mD0h?=
 =?us-ascii?Q?4f/ljbKhBX5QKZ4j5oXpwxUmJVCeBold9D+ov2YnOmgrbJla81mRw2U3tqFu?=
 =?us-ascii?Q?jX9dhI2rz3XcLWjLf+coOVIGCcYavOUA7bRvJfFT26YrC15yzMIcWhn2w5LB?=
 =?us-ascii?Q?G4q9yJfiaI0MkNYd5zunOkrIalx4G9vzmdnWfmkzg7hhbrDaeUGXBE97PMNM?=
 =?us-ascii?Q?/uXOTts6fUutP8KInfBZC+a2sJtxJ4L0XY3owfRjGIYEkOiPj+HuiasXJk1o?=
 =?us-ascii?Q?V3R4KSip57AMOhvJNwUx5LpV/TEA4VY0fwEJE+LgTO5Gz/MKejQFN8CGw7fe?=
 =?us-ascii?Q?RkRaWJSSykwEchtY9Bp/TdRqCObfV+LA0JA223BU/q4mbmgY6Kzub+6fCHH0?=
 =?us-ascii?Q?2YxJDkzGryXchDxRaGjTEyzgjQI1UYCZb80nyeMx+gyr5U13OfD8TEGbNubi?=
 =?us-ascii?Q?6dBFlUBcxLLYcGf2WRKghWNximHBQSr/2QfoVSlG81/O7au0jaEz6WsCV+ua?=
 =?us-ascii?Q?hjwWrScvTFfdfakcd/e5iRPQFFzOqaI6UrxTIbIj0IFGG6HmDWZFyU7iVcoI?=
 =?us-ascii?Q?/RNr5+qwdQlnpuJOizoWLFjF06Peb/KM3840hUmPG1EbXZnEk19f+EQKrpkF?=
 =?us-ascii?Q?dNahPlv5Tq0rMtztCAK3qOE5sSKUbAJ6C8f1oloop1qoT736Bbf/nv/MdgS+?=
 =?us-ascii?Q?RaMMB46G/6AVPKwC/Xr5tuqkdmYCmZbW6xy/SNKaSvq6WQn9dkvk26M90eG9?=
 =?us-ascii?Q?aRr+JRIxSYvNUAhG42jIQ5cBI6qyM6G2xglJi6yJm8dYxWQqI/AK/vIQKQfY?=
 =?us-ascii?Q?TbFipslQJuB5OShaPjls0cpqCy0guSob+4ryGgmjhboQqhQ4HR4jvdp7CjR5?=
 =?us-ascii?Q?aT6GsKtQrRVvf/iIZPYksR4pEDuPafaYAKpo4mZ+O7tShIJNPqvSdbSROb5s?=
 =?us-ascii?Q?Ra0Pec32681OVxXgKHtUHUXV+l48fzVy8gh/Xwdtg75gfQ2+B/VMY07K+w/Z?=
 =?us-ascii?Q?R/PDguq/NzDbj8XyN0nrJkpwU6LNOXJ34Qs1CVpfa+hAhx4wCGvl4mev0mNB?=
 =?us-ascii?Q?CtbdGW79Ao/OaeLHFSLnxtNhygWJZMmvOFGLqV7OiwY7or3pjf/kh3vafqVH?=
 =?us-ascii?Q?L5Z8+n1shGbdaMgD+Dt5XLo1poo9YsBAU5qoAznlg4zWQ8XgZU1GCMlpfp40?=
 =?us-ascii?Q?SKD4QO5YAhbLOHsPy2qEv3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9U8owrwWS738VnS2acLwYCW2lzSihNUpng2lYn9B4ShramrVPGSoKrGCg3WT?=
 =?us-ascii?Q?fsz1lZt2NvXKOvLBMKpA9kmQvNueKAkiUrdZoyvyKfYHNWjRGDFsQa6oNoWv?=
 =?us-ascii?Q?/PzrJWG83KAEkDD1yTr+KZwZNNFiM7aISPeEw5VSQi5fej9S6MPlAv1mzLAR?=
 =?us-ascii?Q?bUzJOoH5pKix3/X75Wg0uXVlvnnftzV5xC9RTSg+JmKSAKfbnk/d0+ooW+wV?=
 =?us-ascii?Q?2D6w3f3585veh3PwYPJ/g+yOPiaWx8Zt34NvRRP0JzGpDGcrMEXNgTRgPvtI?=
 =?us-ascii?Q?ZLZ7fdp0EzlNGjEsihn2Wtdjp7k6dZO9H3iTlF8Dj4ahhK298g0UvpGqQqLU?=
 =?us-ascii?Q?mLeTINSYHqlstEsKvlu99cP32nJ1XL4nZbYa8iYviym1rLrj99Be3hgsbZCg?=
 =?us-ascii?Q?upa4rmHZW/wVFktw95lYz7e8z+FmzbIG2A1O5yIAinCcFMRidWHW8YW7uPmM?=
 =?us-ascii?Q?FV3lf6VNaTgOGo93EcxtrftLnRQ1t6sBL7PkNHuUtFDiBtebAGqMuA9JnNDK?=
 =?us-ascii?Q?uhwkyOS0Q0RYYpq8CyZNh2nAuN3ilt1Oei7D2AsLbLXXCAUkCwCwXxfIpVAX?=
 =?us-ascii?Q?hqrBBoWMCBldwq61BaBXOjpXkBDFVQkp1m/jJj6aGR4ndXJOvcjbLU/xwZOX?=
 =?us-ascii?Q?hAkmQbGOeJqvOmy1l7AjgG9il8lognyy/EK5zEzHp2gLQGnjBhE0jzK3sYZJ?=
 =?us-ascii?Q?SjR22xCv+c6uMHQ/1Zj6GTx5YnWCP7d1uGQUvaRsDE6aj7U6Uxw+QE47WfMO?=
 =?us-ascii?Q?bweeslh0sh0caaZggiOOjwZh1LSxOBNjc+pic21MMnLAS1KRHMdjYo3owuMX?=
 =?us-ascii?Q?CCZ72An5xQ6N9BcYbhLpGYco5c3PHUUzaDim1jVCA3IMieDQgwIUDfwgwmts?=
 =?us-ascii?Q?NPKm1TS0YbBqLVbFfvWhwcSn4kSJZHNL7FyA6owlLOlrOt55ruchHJYBxFLI?=
 =?us-ascii?Q?kWZr4kVT/3JLUhBeuns7LG8ASXg/+k/E4RS4qBsmT1dXZBm9HdTspwx61W5k?=
 =?us-ascii?Q?PcbKevy5y1+Ulzu6WvdPE9TYVIEd9wB8inaSySK+DXEFIRFvGI2+vAySt6mZ?=
 =?us-ascii?Q?xQHzbbVRLE2+oWGlnaWPZGNSKafwVP8aslY+Z4oyPheCZbzPdYLqmwvcJ5/v?=
 =?us-ascii?Q?xq/rmtRG2E4vSoyznFuixILKr91h3qc6k02Pn8yNFyOl0D+y+rqFGvL8eTTP?=
 =?us-ascii?Q?4a5scyzefLxrk5W5FKfz1Tg2IC/IxkromMe9fpTI/nkk0A/XzcBr1MxkOzS3?=
 =?us-ascii?Q?AyvFtsxdL9iFUmT+NJwhc3/Uu23uT8i4Iqg6XAWFhhL+mUG5E5weNZz5BDry?=
 =?us-ascii?Q?BmCZkFrzW9VDXVoM/EhQM5JJf63cy6BYrpBVEWKaFFRiAAGx2VPTTXOqEy68?=
 =?us-ascii?Q?28SdNoq2Ow2QwuQOJjLB/OAu0S9rG7YwWubQrwsM7R7CAkgOgdWkLSgduW4p?=
 =?us-ascii?Q?40m7rxYz1+bi9JOdeFY02cXLgSOrdJmvBQTr20q4PoqMVVcmKl3IUQ0Xb6j+?=
 =?us-ascii?Q?cgJ/tD6iyB7xDgvNrVOty6btMoFyUhdBFmrsdVOrIMEW+yVF9BYZZFpz5MIb?=
 =?us-ascii?Q?ESz2Ufg2rO91nC/rDdvyHBcYPt/Zj5z2MeOE+H5BxUxy1s81R/VDCuIBhj9v?=
 =?us-ascii?Q?7cy9BFx5/is0PkgX8A/a9KBBFbSH9o0X0FQsrgCPY8PPOgcWSmoH/Ukq7qQF?=
 =?us-ascii?Q?8IRSYQy6kUri8fix/9r+VYZ6X/A1UEOoE+9+YqfouEiaoLoRGPUabz5jRlKl?=
 =?us-ascii?Q?hhHGfO/5tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36623560-a3c5-42d7-bffb-08de56b3dae7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 17:06:00.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoKFWC+skoOAj7VDkV0ZtxEwCkuWO+/e4tCZnP5Wg/RdNRSExT21Hicy2p0ioJLWpopREoAr6mZQ5KdIhlcPSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11932

On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> A remote eDMA provider may need to expose the linked-list (LL) memory
> region that was configured by platform glue (typically at boot), so the
> peer (host) can map it and operate the remote view of the controller.
>
> Export dw_edma_chan_get_ll_region() to return the LL region associated
> with a given dma_chan.

This informaiton passed from dwc epc driver. Is it possible to get it from
EPC driver.

Frank
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
>  include/linux/dma/edma.h           | 14 ++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
>
> +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> +			       struct dw_edma_region *region)
> +{
> +	struct dw_edma_chip *chip;
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan || !region || !dchan->device)
> +		return -ENODEV;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (!chan)
> +		return -ENODEV;
> +
> +	chip = chan->dw->chip;
> +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +
> +	if (chan->dir == EDMA_DIR_WRITE)
> +		*region = chip->ll_region_wr[chan->id];
> +	else
> +		*region = chip->ll_region_rd[chan->id];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3c538246de07..c9ec426e27ec 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
>  int dw_edma_chan_register_notify(struct dma_chan *chan,
>  				 void (*cb)(struct dma_chan *chan, void *user),
>  				 void *user);
> +
> +/**
> + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> + * @chan: the target DMA channel
> + * @region: output parameter returning the corresponding LL region
> + */
> +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> +			       struct dw_edma_region *region);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> +					     struct dw_edma_region *region)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  struct pci_epc;
> --
> 2.51.0
>

