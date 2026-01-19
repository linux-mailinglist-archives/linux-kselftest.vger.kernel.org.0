Return-Path: <linux-kselftest+bounces-49418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E3D3B898
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4843B3049C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45AC2F547D;
	Mon, 19 Jan 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShhpSEFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE322F0C78;
	Mon, 19 Jan 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855026; cv=fail; b=bSF77FN9DFJ8WKcJ3971CR/DfdawkTBFqebY5az/Z/wX2Bn1QxFVV1TSYEc9jshthepnLCHNf7BqftLB/OJe7scf8jP1XWjX6gVbzY2gmUgl4P9tDdxZAff02exdO9M0rwaogmLeUmV3Wu7W7aMi6DazvHVb855Qs9fzH5KDMPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855026; c=relaxed/simple;
	bh=4ipjRBh1uGeOF9jwelhx26LIj6UPpIS5gjZBlJpYCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VKS951kCqXfE66cThkyXjaDo9UCPMqAA0hfJFXb81EzDoVmtGhpTEra8142fXpLgvUaCzUc3knROJWo1ppH8Gyf02lsqiTUxO121lEr4O99rX9Q7/Ckcl0Wxua8NuUqwKeRctGuutjvJNmhHr5uYI6bpPZXpBsASh4jEnzRG0eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ShhpSEFD; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItrdSXYWQKUPq1zLxUo9Mm9s5tJCW59TfF4XE6YdKPFpy5PteUmbpTFJoTFPZEYnWuJI+rQTj7glRrLMnXdVaxaLMPeB2YITwa5hId/qA2J6ypPZ9BcB009XM6JX9iuOH7oX+HkssiN5imLinYL67pGiPv/kU8uvmJC/pKlTiInwzN1WeBu8VhRQuyKB5rWI4w6uP344wt1FNjpcxZY+uVRwKdBRX0Jq3oxJ88ZX7jrCuTRb9qGRan8USaE7T7qiRK4VephSItS6sq9ip/Tps0qC8uNvQc4W83mL54EiNJAQfgUZV1Zu+Cns3fT3h+InhCtBiZSAM7czibtiYwoaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GakIVYSId7WA9JIolpGCmAJo0T1uYhm00venmuF49FA=;
 b=eKCE6rTnjm3qaZjL2kj9XvLx9OdMp4NgpwZJX+E7Q/CJg8lSF/wjtPhsEEXCZi4nXzkuAGrzCS1/NS3ly/QPPzBT2D0at0oV7ZK9qKSE6MX65H+ZdD1SGoDkobzaCHXma6URoiBDIYjEYIch9OYHXX8LskycM/MmqjKfAilo/MhubVgb3sO0mHLpjF39UJq6gA4wsxG3Ad2j2aD5Hetl2N+qgVG/OiZ3Z6X8HvSwhzGuGni+GknbKd9hYxZmeaUNc3VsFC6GX80mcIrex+UBuQ4QAiz6izOqAwxaFnljJkWSUAVBJn908By9SyjS23NIBQ1b/fh3IrVcLVDcSv5gFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GakIVYSId7WA9JIolpGCmAJo0T1uYhm00venmuF49FA=;
 b=ShhpSEFDJiMYAxgoze//kLqk5uUHrA8Va2YqKik+YfV/+JDBj6A2XixxOBmQmsPBPg0O8JcLbmoV9iGSOPE5fCl3bJIjrPjg2COL4YHrvPepdniUnhXQp1rU5FLF1eKWWc+PrXeLidUIhGEEbVFPtv+epOXiHqcgrtCwMsmJCBRngUYkg/ZZH/5sFxfsGi+Bf0E7n6s+K6q0TNDoDvfiDSx0RLf4uBEHUGv30fGWFQZ+sP+0r85v2WvAHZmXAuZzVEpEzYW42YCVvv1e/2vSHlMhjlJOg02/PWUGNu39P9HEsahCKF+lUrnqyO4ahn0Nvd9kj2RMSz+te/xinYSp/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by DU2PR04MB8614.eurprd04.prod.outlook.com (2603:10a6:10:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:36:59 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:36:59 +0000
Date: Mon, 19 Jan 2026 15:36:47 -0500
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
Subject: Re: [RFC PATCH v4 16/38] NTB: ntb_transport: Move TX memory window
 setup into setup_qp_mw()
Message-ID: <aW6V36kWrXE3X017@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-17-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-17-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::22) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|DU2PR04MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5a366b-5973-4bd2-8bba-08de579a7e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8g19yC/BuezBmBdSgqLFIgvy5VHEqNLId1MNfNF9AI74nWqA0CUEgeu6k1BT?=
 =?us-ascii?Q?ohi7owxcbG3zE62ecOXi9SM9LnmIrS1jY4NrIvQmARHX804dhzWcH6Dj7uY5?=
 =?us-ascii?Q?9iNrNh8F9P7D3fYfabK37gFQDaMUXZ2Pcbra3yTFxskrbfFMomrJQFFiwfZO?=
 =?us-ascii?Q?7quYy7RPMZIRO/XZQALlEFid41BtofO+aUpiu+WirxX3HdDzLc5Mpt/XCCT3?=
 =?us-ascii?Q?Ghyx7XhNshHRbGTjR6cjIUnqV6hQ+1fYWCQ1Hb9JmpM8A2ZKvOQyLCQEbhLm?=
 =?us-ascii?Q?h48tlD9r28HRSSDYUCoEm/z0VqaaZrCb+9UO9jwXo3Qerwfez77Pk5Bu25zK?=
 =?us-ascii?Q?Sia+YAbAq6ZiOZL8Xzxd0JnGAbJ2JCNIjRG1A9hAEWu8ORGeWfeop2F9vOCm?=
 =?us-ascii?Q?owp4FhzAlKNqEoCUi6y7XnooaTGZ3cs1zMFiUCvZu0KAf1QWXX1pyZpeL+HF?=
 =?us-ascii?Q?X7BOqyIOjf1luQKdt2Ndlu7WTNQrukwUKCfdOWCY6MIoz1gITQcgxc9t0uxt?=
 =?us-ascii?Q?HJNkvja3ar1rbNphrU66RwC6HpCMh+2lPQaBcC/2vcnpjpxmM1svXQPPyuA0?=
 =?us-ascii?Q?zh/+NKnohp5PoTZacu5XUjowT1oDLTl+m+ByhNGGMEfQxoPHt+B2YFqjRpoW?=
 =?us-ascii?Q?4Nh2zNx7FklpLLP13/kp3guSnAHVu0oQsc1FQ3HErk9jmCeFIeSLWV/uFoea?=
 =?us-ascii?Q?fYU0wKYlkSrdyiJyhTXDPQD/Sv9QATg7b0CSSPGNoUMy9KnneQVEf2CdObfC?=
 =?us-ascii?Q?aCYt0lXkKAzfHXXcRGxNnWzbICwDI5caNbEAQ/kRl+uX4yq12+qebrrDz2HE?=
 =?us-ascii?Q?/1vrIA7o1TUD5mQp18znnjPFvvcs3CMt1NQMcK1OFTP/XQ2e1CFsIf0SgJfd?=
 =?us-ascii?Q?7QFV9E+476ejtB2F/S/rmbLtl+jkoui0Pg3Cd0ymZQWyG4gydT9ATYRjY3uS?=
 =?us-ascii?Q?6d6aqKmeHiR3CaJ9N5bsm02V6F/MwI4NPhpNsTootrZtfkBT80c+1O0EHrLN?=
 =?us-ascii?Q?iX+QRwduol6NBTVk3BAzwwLuP+9hfXeWHaZ9Sst1/LxQGd9VrEfoDcnpgHmW?=
 =?us-ascii?Q?/v1WHyk52xuG2L3WaOeIzfkkho0XELhmhrsP+lQCKp2ctrE5DhmC/MGu9Ji8?=
 =?us-ascii?Q?l1Xl482hVBs9ag/3inV3BqfFUJ4aBhVnn7m0M/KQflpdg4prBXP9kg9+QTxD?=
 =?us-ascii?Q?BhYPFVNmO+/kzsCGcAkemIiy3zAwuw5BzEXPFUalmrG6pOlxZnd2xVr7tt/k?=
 =?us-ascii?Q?hsl8uyf9gQIu9wcllTIk7YFzwqn7EfUiDuca6JfsnPSnA8OjCGHXiBqfFjqt?=
 =?us-ascii?Q?cfiqHKmwf3ji9gn/6s71i3sanqr1UIw57vMplf60xAzF9ETR88E+g90f5m2U?=
 =?us-ascii?Q?FhQtrqHRpldOAfgqr/RWI6PLIEV67qgYJIdMFmtELuiARLLA3oI/QIdMhm5n?=
 =?us-ascii?Q?LGTa2q/fWd39cBtcvm+BdOhrGlwNjoUxW2fAkG0QvBqqv9eykmxgRMpyJmVu?=
 =?us-ascii?Q?HH6opQSKRpMb4BL3jMGJY7R1tUa8k91jsV0QavwcA351go4HEZK2VRNxz8sY?=
 =?us-ascii?Q?jPHLD8zdjaQjJUdiUC7p8YW7OggWDbp8gLksAZzKQFq0TBhZvk9WbClxSVJw?=
 =?us-ascii?Q?boy9zazEiV8W7t+Ja2cX1IA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?In6JiEQAi8UF6pWANhPC0q7qxQhCsXfeFKnArfe4smmnq92YrBFpW9SVRQqh?=
 =?us-ascii?Q?2GTLg7KriyalO3k9XIlvsvOrYgryiWElkzYDxiiMN5hc+bTIAtQN3AEf1lys?=
 =?us-ascii?Q?ltYPUJtUDsLOEAzBRohQTWQCgHAhU6uHh04gI0AxCgJggy2Tl0isxwtxFIZQ?=
 =?us-ascii?Q?TI1SUs2+zj/kmArKSH5ilJqpGQvikoVdE5ThqX2p+iaBU+SalhGg8+uMenS8?=
 =?us-ascii?Q?r9gJJ9lSMqeexRqafPqW6PuApgXrpUE5BB+xGrEkGmfMKFWT4TlGBMTgWoxr?=
 =?us-ascii?Q?8mB6lWVKi9dZXQxVvugC3a0bt+T8C9F5I2fJ2E4AB2dRLlfEV2+QocBifA+0?=
 =?us-ascii?Q?PJD5QSkDYVsS8UbutYdgGALMTJVgMgiS6RLd1F4fsTeHltY1+n1cCmuP4BnP?=
 =?us-ascii?Q?7zVGlCXqMHEWB0yQNG504B4GJklP9mhj3rqsY/yjfsktiwatj2GN1XW6AThc?=
 =?us-ascii?Q?uwH9c4mYAOwnwZGXKYevnsDbRmlBSPLK05LG00BTHDtLekuVjfVDVkHNg1k/?=
 =?us-ascii?Q?uO2gRyKztmwyMHOP6acI5lD02RWo9zqXNhhMUeKVFdmQliR/rOe/RNFAj571?=
 =?us-ascii?Q?UN1kaT9+PX4meyTnqsqTbmukikR8s70PKTikCq9nfNc4P96duZwloxNmjPfO?=
 =?us-ascii?Q?FR9Of53ZLbX3c9dcwkvb5nv38wPs7kmVUEwQ7pfaQNu44hY3KNjQbRUBYbYO?=
 =?us-ascii?Q?5A0MBi1O1DHYUXy3KJyvLnHt7ye/xlaz1V6V47WFOf67/fNva/zSyhW4d8Nr?=
 =?us-ascii?Q?5t2jH0w4QgIO1ouBY5Y/xoKg1Oot1JPlJEmIA3PyIv8OpHyfXVbhnBnLMFUd?=
 =?us-ascii?Q?4RszW+AtOjiyYjtLiXlrX0Z0iVKjQ3P16cqxQOPse6dCPk2ft0dOje/aKe2R?=
 =?us-ascii?Q?L7vAkxq+Z6D+OMQ4oppOskRJ6g84bDnwVHgCc08RaQwCmY3mdFSYf+EYWjTq?=
 =?us-ascii?Q?mrorErHMPDlNmDKLH2xrLj+If4ixR8JOO8Yu7Ebzr2RzH3PsKTyp/MHgu2qL?=
 =?us-ascii?Q?BT31DQWZpGmBJKOMtG5gySmFYjbOECM9RVLSI09fLq/wgwVZUfkSoQU8ghlU?=
 =?us-ascii?Q?FUIfB4t3M/FvgWHxsNOF4g01OIKB19rnmC3N7OdBjQOYnSUKVcZGf/c+2fJ/?=
 =?us-ascii?Q?VMYJVR4v6lJPTkwuRQIaW5ClJvNiz2XXB4Jgb7e0iFS68q5pOhQHtNJOjHvd?=
 =?us-ascii?Q?oCKiWWHwP5/+IYk8PwRB2qGPncczLGhq3cNBi+yQP4PhwuBby7tHqQwQt2j7?=
 =?us-ascii?Q?vJBqu7/OvFMI5AyFvkuqVAWMVx7r8SecPCCjPt//W0qwuIMoLSG93M6j8y2j?=
 =?us-ascii?Q?jnhcQL9Sz+px/+pp9EK360VEmlkv71JutlEr1r8BmcTOYIU48JWO0yCYc74C?=
 =?us-ascii?Q?C7KUcPxo1QHB64RCHI37Sl0HYyha8I3TLZtJCRd2l9R5783VSOU8QW/kMBZd?=
 =?us-ascii?Q?x34QyFiOmiEAT1vAxJq3a7X5X5uATanOnAVnAd9/yODMDrcLZZNlbCltiXRy?=
 =?us-ascii?Q?tKtjzFBZHSA2md7x3ACnCe08jEqkD0UwupaCNQ/lNcjdo1UkjxvALE1gjLMW?=
 =?us-ascii?Q?v+Y+CoTdS/X7KIvLxbhbnaHmNEM34I64gkIvCZ2yxTZbB2NympbspnREBy9V?=
 =?us-ascii?Q?/h0uuHYpXLM7pn4lSMjVsxwgdNK7Tokst9ZsII2SWGV0STdStnNtqSA2TAEF?=
 =?us-ascii?Q?fq/JfDB1I5Zu1l2qoLy6vov6bhwgmyxK7GLs5JbNkGDV8Vo1SsDc9pidW7Vn?=
 =?us-ascii?Q?qBLWV1MeKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5a366b-5973-4bd2-8bba-08de579a7e44
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:36:58.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rosdgRG8lNdqf3N8DyHTqWvAofPqXdP0QBba/gr+2WE0vxS/hwHe6kZBbhRJKTn9Zoe3NcGXOtqzHkpPxzQXeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8614

On Sun, Jan 18, 2026 at 10:54:18PM +0900, Koichiro Den wrote:
> Historically both TX and RX have assumed the same per-QP MW slice
> (tx_max_entry == remote rx_max_entry), while those are calculated
> separately in different places (pre and post the link-up negotiation
> point). This has been safe because nt->link_is_up is never set to true
> unless the pre-determined qp_count are the same among them, and qp_count
> is typically limited to nt->mw_count, which should be carefully
> configured by admin.
>
> However, setup_qp_mw can actually split mw and handle multi-qps in one
> MW properly, so qp_count needs not to be limited by nt->mw_count. Once
> we relax the limitation, pre-determined qp_count can differ among host
> side and endpoint, and link-up negotiation can easily fail.
>
> Move the TX MW configuration (per-QP offset and size) into
> ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
> centralized in a single helper. ntb_transport_init_queue() now deals
> only with per-QP software state, not with MW layout.
>
> This keeps the previous behavior, while preparing for relaxing the
> qp_count limitation and improving readability.
>
> No functional change is intended.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 76 ++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index d5a544bf8fd6..57a21f2daac6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -569,7 +569,10 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	struct ntb_transport_mw *mw;
>  	struct ntb_dev *ndev = nt->ndev;
>  	struct ntb_queue_entry *entry;
> -	unsigned int rx_size, num_qps_mw;
> +	phys_addr_t mw_base;
> +	resource_size_t mw_size;
> +	unsigned int rx_size, tx_size, num_qps_mw;
> +	u64 qp_offset;
>  	unsigned int mw_num, mw_count, qp_count;
>  	unsigned int i;
>  	int node;
> @@ -588,13 +591,38 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	else
>  		num_qps_mw = qp_count / mw_count;
>
> -	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
> -	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
> -	rx_size -= sizeof(struct ntb_rx_info);
> +	mw_base = nt->mw_vec[mw_num].phys_addr;
> +	mw_size = nt->mw_vec[mw_num].phys_size;
> +
> +	if (mw_size > mw->xlat_size)
> +		mw_size = mw->xlat_size;

old code have not check this.

Frank
> +	if (max_mw_size && mw_size > max_mw_size)
> +		mw_size = max_mw_size;
> +
> +	tx_size = (unsigned int)mw_size / num_qps_mw;
> +	qp_offset = tx_size * (qp_num / mw_count);
> +
> +	qp->rx_buff = mw->virt_addr + qp_offset;
> +
> +	qp->tx_mw_size = tx_size;
> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> +	if (!qp->tx_mw)
> +		return -EINVAL;
> +
> +	qp->tx_mw_phys = mw_base + qp_offset;
> +	if (!qp->tx_mw_phys)
> +		return -EINVAL;
>
> +	rx_size = tx_size;
> +	rx_size -= sizeof(struct ntb_rx_info);
>  	qp->remote_rx_info = qp->rx_buff + rx_size;
>
> +	tx_size -= sizeof(struct ntb_rx_info);
> +	qp->rx_info = qp->tx_mw + tx_size;
> +
>  	/* Due to housekeeping, there must be atleast 2 buffs */
> +	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> +	qp->tx_max_entry = tx_size / qp->tx_max_frame;
>  	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
>  	qp->rx_max_entry = rx_size / qp->rx_max_frame;
>  	qp->rx_index = 0;
> @@ -1132,16 +1160,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  				    unsigned int qp_num)
>  {
>  	struct ntb_transport_qp *qp;
> -	phys_addr_t mw_base;
> -	resource_size_t mw_size;
> -	unsigned int num_qps_mw, tx_size;
> -	unsigned int mw_num, mw_count, qp_count;
> -	u64 qp_offset;
> -
> -	mw_count = nt->mw_count;
> -	qp_count = nt->qp_count;
> -
> -	mw_num = QP_TO_MW(nt, qp_num);
>
>  	qp = &nt->qp_vec[qp_num];
>  	qp->qp_num = qp_num;
> @@ -1151,36 +1169,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->event_handler = NULL;
>  	ntb_qp_link_context_reset(qp);
>
> -	if (mw_num < qp_count % mw_count)
> -		num_qps_mw = qp_count / mw_count + 1;
> -	else
> -		num_qps_mw = qp_count / mw_count;
> -
> -	mw_base = nt->mw_vec[mw_num].phys_addr;
> -	mw_size = nt->mw_vec[mw_num].phys_size;
> -
> -	if (max_mw_size && mw_size > max_mw_size)
> -		mw_size = max_mw_size;
> -
> -	tx_size = (unsigned int)mw_size / num_qps_mw;
> -	qp_offset = tx_size * (qp_num / mw_count);
> -
> -	qp->tx_mw_size = tx_size;
> -	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> -	if (!qp->tx_mw)
> -		return -EINVAL;
> -
> -	qp->tx_mw_phys = mw_base + qp_offset;
> -	if (!qp->tx_mw_phys)
> -		return -EINVAL;
> -
> -	tx_size -= sizeof(struct ntb_rx_info);
> -	qp->rx_info = qp->tx_mw + tx_size;
> -
> -	/* Due to housekeeping, there must be atleast 2 buffs */
> -	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> -	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> -
>  	if (nt->debugfs_node_dir) {
>  		char debugfs_name[8];
>
> --
> 2.51.0
>

