Return-Path: <linux-kselftest+bounces-49269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA20D395C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C622D30274E9
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D2335543;
	Sun, 18 Jan 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V7/Qfzpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273C333446;
	Sun, 18 Jan 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744511; cv=fail; b=lzR3xcMcJQjQx8JEyXp8pfySJutV03N9zp+wiLzdcUoZR2sVjypQxAbFvZaSdT8sXh/UbVCPO5yXLlDmLLJg+XGc090O9bgIugY7OhaPhSt0IZqXgQdYZfcz7yJTbB7EMIQ4ZNul+nug1bzcH61TWncubo8F2SB4lrn4gwMTtWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744511; c=relaxed/simple;
	bh=b1K8f+FMvWvyKaEwtDwI041WJZhofscubDyK1pCjKWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G82+tQs3dQcsNvHJ0KnhGthj9Ffby36sl8UlybQmFnKRkAeO5a/mAdbO++t8sBneHPy4x0RvsLmO0Etnmcl5z83RUHueAp/CJ607xlExqs4jlHOucigLTkLZbBKJ9Mkrgufo3diEplasgtGIblULbRcIBOMnrRs6VfayJORwbGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V7/Qfzpb; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VynX5c1UFzuPuGHwmXtA6baaMFPitSElIhXLmheuzqnok8dV90LLcbrtiv6MPMeoEJlDWaPj8EXSz5mUqK+amLn2kIU89fmZHK1VB8eiztyRzw5dX6rDOjuTUIR/jI1XXChBlGqZh0ups/wkUuqv+aR3dxzWgoIwxwPZQ8btSuFuZjAaURaBpHtfYs8gn8OHhdsXUn55FQobYTXZJ88b+z1h95bsyqZ60KoGkLuOIjlVvOmZGDAnOQVD5EVWTr8D8IY+KcTXg1opWiArqRRn3vAHJyc7TBZZ3kQ+vxm/OBpnlIV5pYdJm7xnC6dximbxZfmnKJGSb+FiB7Dg8HQ3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObZcERkw/MjdNVvN5gPzrfGDocZ6MdRczoTNp/+qqr0=;
 b=xX7aIj8of3XP1YCBl3VQCt4iaVr+0AawJbI1xq1xvOjEO+vczMe1ldsvkHRD/z9xKG2Ia317EgoiwaSL0YBdZbpZ//tBkcYV4qn0Qv+AKbKT8l/C28zMwUc+Ww0vRrt1+MjIjBzkPGqKrcseVvvxL7a+bvm803JTgmkLg9XGlf3qSw6ovJqB3I6YsvtYbcR8Uo/NsXfEI4373a9Lh6Qn4SQlJStn7lTMvIxp0OLcO0uYUK6rhJKPPyhhPWcXkPdNnFkV+5XqNZK1F1Qv5e1rk/XPmPCOp5iUPQ73Y+6yPolOlv14Yqo3cwJowbsrT4y6hGLePXuEesDA6iBBLq3c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObZcERkw/MjdNVvN5gPzrfGDocZ6MdRczoTNp/+qqr0=;
 b=V7/Qfzpbk9xCUdLrhehfmHUEw7D+AXprAmHfI3vIQ7Am31MEQ5E2Fem1lbwPPi6D8AfSuBOAwPLKH0HptFKEvIAHw5db/EHMh0ZU6x+A+JgPFzxkUBz9BJeL0ZR2IzijMbfx/Iyoz8sQDVRYSI9/RXH5qVZnh8dvpAuf5SqkHl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:56 +0000
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
Subject: [RFC PATCH v4 06/38] NTB: epf: Add mwN_offset support and config region versioning
Date: Sun, 18 Jan 2026 22:54:08 +0900
Message-ID: <20260118135440.1958279-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: d22ad279-bc36-461a-fe06-08de569929fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FGdxc4ub5LJCHmpaAnbBFeOq7dREexz+0ttfAWTuLkLcVecwHmkv8KtF82G?=
 =?us-ascii?Q?J2whHSSViY1W0CNr9m4XX2GVJzgGT4ZO+q691YADfHXoxSi/Cg37EaU8cWWi?=
 =?us-ascii?Q?IQXHlvB/0HSlU+tdzief5Vxdz3ZdmmjnkOgAr8N8BOqYnwjKpZuKEcwew1On?=
 =?us-ascii?Q?6FbPqE5SQyHyaabccRp2nbLmDnKqpP0DhHmK+Gbhy7wDpGhtGpAcLpO0rSAs?=
 =?us-ascii?Q?3LSOoKklDviFP6d3xkBlDiBIavkTIk1XGeOunofxp0TO6AfEY+1I/1lRLMMr?=
 =?us-ascii?Q?aN56plQJMQ/SwDEWE/xNNn7Yr2QMizk8Ooh7BJ28OKctykPlPCXA/+fJc9KG?=
 =?us-ascii?Q?f4SfU8C0UhOStz1i0rltIdIclafq1SWa7KB3MMvBDY0vCOlNEOsCLUOvUf94?=
 =?us-ascii?Q?WErddQc7A4j+q9lpynDXoEu+y0+D9GUi+PNbMMdvvt/PE/Q8oWOCR7UVdYI+?=
 =?us-ascii?Q?dHZ0KswwE7Ie8HFF5EOfSa1AXzHB2Q4H9ZZvDZ1/PwnzzboBQJ9/yaWNYI17?=
 =?us-ascii?Q?IcnZwcZrxrQlavsoFJoFzUQvXzDqcZNAR2Yfnz/JTOJsPOwThqTQy5O+3Nqe?=
 =?us-ascii?Q?h6kQ86gLn4qXu4jLT/Va1uIHkJdinx/baLtnCzP07sfcGWBlx0gB2tSb9SVz?=
 =?us-ascii?Q?GBicFOIEPjovCJtktrUKJpoz8fk+dfxBrr2UnuYYmHVqZ4aL1OvkuAuJtekb?=
 =?us-ascii?Q?1jS7TypPL8I0U99tPEW+8MuuTEbXWH2GZM9gPxMfnReE6A35eLa/YPiIa06h?=
 =?us-ascii?Q?yy9GI4ibGfln2Vc7hjLa2TfSvmHZsIY5Ra6zPokRa38RABx3eahVVkTBqIsW?=
 =?us-ascii?Q?ehW/vBEhX0D8/XfZjyZVrPfQm+KdnZJ8XV6E1vs+gH3OL+M4Q70BZfFj+TBv?=
 =?us-ascii?Q?UOqN1PysmujDNf63araCuLTih5Z0ts1c3c3r0+V2T+40xQQD0o4RH6OldHUm?=
 =?us-ascii?Q?Yg9Akew6NdFDvnRO7E7fcutZBFAv47hpMd1SaCKC8NI0+4zxERWNpZHpb/rA?=
 =?us-ascii?Q?MtS823dd7xv89AggtIyVPGdBqjun4pYSbuLiZn09Elj2S2lBnFO9DWcDSRYd?=
 =?us-ascii?Q?sMgiZg7H7gn6c4cTSE4DuVEr+Iw+0AdDaQcJcEhr3OAdF3SzCJ8aH8KITJ3m?=
 =?us-ascii?Q?PzIWO+SleNc0FrZ0pQH2XT/xVylBaq4SjpCJ4PHotwXyBIy0Ys1LHuZ9dEi5?=
 =?us-ascii?Q?PAC+THRbLF2brlZ1lY09gbS1Uf0xTyaRJkyvPzhahzGDhyQ6O7Yh+OS4FMrC?=
 =?us-ascii?Q?KtmZN9K2bCKo9rKhcbk4xhTTh9DqKcKehyS2ufEJ7OchNhcXDVtUpBOBFKr2?=
 =?us-ascii?Q?lazaQUtMdqD7cdGaEd1iR5d6ApTbPA2aqMyDrKkOjPLELid5tQb4gJ+IfN2n?=
 =?us-ascii?Q?rMKovlrbDg5zll0j8Ey3XOHG5vzEsTT9lZ4Q6VcsZbYFblSoOx3fQ6khfMcc?=
 =?us-ascii?Q?ftSbebyyzLraczr3Kw+SE9WZBP3Tkn6Nu1tZBvCmi1gPjEmq7N/ZOiV9L+uM?=
 =?us-ascii?Q?7W0GrfiPvDoBrAcuRym3FugzQJ7hOZkOW1s1n09hAgCnP0OcCShpfIeDVMMQ?=
 =?us-ascii?Q?JjQMOZVTZCiVeWUqi95ge52LW0Yj13GiK1gX34shOwIiLtLA52qWuli4yky5?=
 =?us-ascii?Q?EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBWFTVmq978tkUfb/r1U9OCdoZBUv9ZV1EEZUHXNCLmYaDQCjBliJ+Uu9Byd?=
 =?us-ascii?Q?caAXeHnSYYGPBnxfnkcjg5jrC3CVJj84TlkQasbh6yQHk4Vm3DoF1YC3hADN?=
 =?us-ascii?Q?ZkswmE+JR0zkXgdgSsKxEhYEREH2vHa0o8HWIe1oXLnqFcNj3Gv1giqOzjbO?=
 =?us-ascii?Q?r7XO5jU1opa87/qeuRUWogB8rfEfeIdnveEuJ62bT5AC3woNJu4OQ05IOsJR?=
 =?us-ascii?Q?HPcjnVVT0XcJ2vK1fB0KlXYtSJaKlGtCbSjJ/h4+hooLQeUIk0E32QrHPMvi?=
 =?us-ascii?Q?dgjDVgR2qndIjRJMdVIIrP0Bp7FfGnrmy1Uc1Wo3P6r5XWVBj9xhPhTu1EWm?=
 =?us-ascii?Q?M5cv+TIfjgRikkEmZRFiRXNOCknIbJw8+ELz6BQWszZeC3KtgTE3fXJxgAN2?=
 =?us-ascii?Q?Dq6Q2MWNe+dqrH4aFIvW5Gb4mhWMDLgSiTZtIQFTVlfngjsHfqdxo/757nhS?=
 =?us-ascii?Q?ISYU8+BFhjbzdBvBkuHMKlPxpaCRmAELz/MCIDYVG6AbojVdq7IEnuenO8hB?=
 =?us-ascii?Q?SzMZG32MjyQIch3B7tO+liQ6imBUpBkXZv1hAAjqOFdAvtPpivK5e8WDvwNh?=
 =?us-ascii?Q?GA7jaELjnShYumEdxLJDZYX0q7bNBGmLvf8Oq4gDi5Z0iXnFyfQ0lq49CRXl?=
 =?us-ascii?Q?+EcC2REyEliJTDYDA+uNsTR5xWhptyuPF7JnPEzyCv4LC0118zJskQpAf6hV?=
 =?us-ascii?Q?EmiIj7VFxjrl0LBqLbTnUf9trno1tCvgjLYQWjCSI7pFH4hdBsCCKIKEopbd?=
 =?us-ascii?Q?kLQ0luMXCT5CWPCijmlUekxbgg2c3SPBiAQMw3CAb+u3MP3MfIn94RnpSNvu?=
 =?us-ascii?Q?k91ElAW/UcdHAFnF6RTHWm1u+Hlte64MIhT3mQ3sMg4XEza98Nd0RDJo5Tv3?=
 =?us-ascii?Q?CBCNYvm0nMwDzCE0maKOMCrH6xBV9+goOAI0+T3p0RBU95i4hDIctFwV77sM?=
 =?us-ascii?Q?QhhLy7IRuCLZg86qURn+Rf/lVz6ULv8VrP5MtizfW1RQEXDjVxrRv8RK4VVu?=
 =?us-ascii?Q?O8GQr3dF5oN9razv9or5BosbxdLqEt6eI4Yv6jw+VRCd2XoWcbAfDEhcHRtQ?=
 =?us-ascii?Q?f5+Ns9v4+wF3Z9fPGIaglugSl4J388Kb3YHY/b5L4doFaW8XPautRU0zn8iw?=
 =?us-ascii?Q?CFFZ28XFMhSOlJaRder1d2NFFCWTUPV7GDHVtt6kwi08eg5MbuniczXFzkqU?=
 =?us-ascii?Q?/X2ZlYXAgVMYMdMrQg+jJ/21hySohLwh0Aab+chO/anhreJV1aAr7NAHFjRc?=
 =?us-ascii?Q?xnr9+NuyzMTkzZKzv8q46qArGjHvEecwYqPvm5znyn6NF9Lkq+rKE11VNfek?=
 =?us-ascii?Q?XF37GeF63hoCVuhXBoHPbfc3FtE2U2mYbLItiQhbE2hEQhIcgp2PVOQEoMih?=
 =?us-ascii?Q?+IC9nshyuzmCJSogSh+oP4E9iLNBNt74PnYJKiG3E653xQBgnaxwKw0Krhr+?=
 =?us-ascii?Q?hAiwYIsY9HZtekpQ0JR1nDkoLcl9fqNSi+raxdq9hU+AzDXqkOf/4effXF0t?=
 =?us-ascii?Q?e+0P97vWk0HWHE7QBKbj4N7/+Tc3MP0bZ2XVuFVqfnpLAsm4HYYkgwL0MpSq?=
 =?us-ascii?Q?aR1Gqg8DFnMVRBC1ciP64s9FZrx9CckTPQTYdKhvnlgXIUUpryyyGkB3naVa?=
 =?us-ascii?Q?JpjYvMQfqJHAexh2jkDC6U4DzK+aHdy4Q4nHrz3Aqr2JiQw6pkZ2wAi0cw9M?=
 =?us-ascii?Q?PwYozw+7fy/8SG4anQEmggRLVVPFn0IAsfsxn6PFhKh/pu6Xd4ogO7aEo7Lq?=
 =?us-ascii?Q?mkCELETEy03hEzcanqpc/hbDA4b0V49nLifNEPfIwt+PpIQfw86T?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d22ad279-bc36-461a-fe06-08de569929fb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:56.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9XKnCbk4juZkJbtBTJ4L5y9v51vry/yNk2NJQcYGuRD0/RSe9eTSYPaki9f1EvkQOfs7WRwQkao1dJK8m6sZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Introduce new mwN_offset configfs attributes to specify memory window
offsets. This enables mapping multiple windows into a single BAR at
arbitrary offsets, improving layout flexibility.

Extend the control register region and add a 32-bit config version
field. Reuse the unused NTB_EPF_TOPOLOGY offset (0x0C) for a version
field. The endpoint function driver writes 1 (NTB_EPF_CTRL_VERSION_V1),
and ntb_hw_epf reads it at probe time and refuses to bind to unknown
versions.

Compatibility matrix:

            | EP v1 | EP legacy
  ----------+-------+----------
  RC v1     | v1    | legacy
  RC legacy | ? (*) | legacy

(*) An unpatched (legacy) RC may misinterpret the paired EP's intention
    and program MW layout incorrectly when offsets are used.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  60 +++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 136 ++++++++++++++++--
 2 files changed, 176 insertions(+), 20 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 9935da48a52e..4b3fa996219a 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -30,18 +30,27 @@
 #define NTB_EPF_LINK_STATUS	0x0A
 #define LINK_STATUS_UP		BIT(0)
 
-#define NTB_EPF_TOPOLOGY	0x0C
+/*
+ * Legacy unused NTB_EPF_TOPOLOGY (0x0c) is repurposed as a control version
+ * field
+ */
+#define NTB_EPF_CTRL_VERSION	0x0C
 #define NTB_EPF_LOWER_ADDR	0x10
 #define NTB_EPF_UPPER_ADDR	0x14
 #define NTB_EPF_LOWER_SIZE	0x18
 #define NTB_EPF_UPPER_SIZE	0x1C
 #define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
+#define NTB_EPF_MW1_OFFSET	0x24 /* used by legacy (version=0) only */
 #define NTB_EPF_SPAD_OFFSET	0x28
 #define NTB_EPF_SPAD_COUNT	0x2C
 #define NTB_EPF_DB_ENTRY_SIZE	0x30
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+#define NTB_EPF_MW_OFFSET(n)	(0x134 + (n) * 4)
+#define NTB_EPF_MW_SIZE(n)	(0x144 + (n) * 4)
+
+#define NTB_EPF_CTRL_VERSION_LEGACY	0
+#define NTB_EPF_CTRL_VERSION_V1		1
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
@@ -451,11 +460,22 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t bar_sz;
+	u32 offset, sz, ver;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
+	if (ver == NTB_EPF_CTRL_VERSION_LEGACY) {
+		/* Legacy layout: only MW1 offset exists, and there is no MW_SIZE[] */
+		if (idx == 0)
+			offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+		else
+			offset = 0;
+		sz = 0;
+	} else {
+		offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
+		sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
+	}
 
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
@@ -464,8 +484,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+	if (size) {
+		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
+		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
+			   : (bar_sz > offset ? bar_sz - offset : 0);
+	}
 
 	return 0;
 }
@@ -547,6 +570,25 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
 	ndev->ntb.ops = &ntb_epf_ops;
 }
 
+static int ntb_epf_check_version(struct ntb_epf_dev *ndev)
+{
+	struct device *dev = ndev->dev;
+	u32 ver;
+
+	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
+
+	switch (ver) {
+	case NTB_EPF_CTRL_VERSION_LEGACY:
+	case NTB_EPF_CTRL_VERSION_V1:
+		break;
+	default:
+		dev_err(dev, "Unsupported NTB EPF version %u\n", ver);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
@@ -696,6 +738,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
+	ret = ntb_epf_check_version(ndev);
+	if (ret)
+		return ret;
+
 	ret = ntb_epf_init_dev(ndev);
 	if (ret) {
 		dev_err(dev, "Failed to init device\n");
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c08d349db350..4927faa28255 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,6 +39,7 @@
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -61,6 +62,7 @@ static struct workqueue_struct *kpcintb_workqueue;
 
 #define LINK_STATUS_UP			BIT(0)
 
+#define CTRL_VERSION			1
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
@@ -107,7 +109,7 @@ struct epf_ntb_ctrl {
 	u32 argument;
 	u16 command_status;
 	u16 link_status;
-	u32 topology;
+	u32 version;
 	u64 addr;
 	u64 size;
 	u32 num_mws;
@@ -117,6 +119,8 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	u32 mw_offset[MAX_MW];
+	u32 mw_size[MAX_MW];
 } __packed;
 
 struct epf_ntb {
@@ -128,6 +132,7 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
+	u64 mws_offset[MAX_MW];
 	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
@@ -460,10 +465,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ntb->reg = base;
 
 	ctrl = ntb->reg;
+	ctrl->version = CTRL_VERSION;
 	ctrl->spad_offset = ctrl_size;
 
 	ctrl->spad_count = spad_count;
 	ctrl->num_mws = ntb->num_mws;
+	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
+	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
 	ntb->spad_size = spad_size;
 
 	ctrl->db_entry_size = sizeof(u32);
@@ -695,15 +703,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	struct device *dev = &ntb->epf->dev;
+	u64 bar_ends[BAR_5 + 1] = { 0 };
+	unsigned long bars_used = 0;
+	enum pci_barno barno;
+	u64 off, size, end;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		off = ntb->mws_offset[i];
+		size = ntb->mws_size[i];
+		end = off + size;
+		if (end > bar_ends[barno])
+			bar_ends[barno] = end;
+		bars_used |= BIT(barno);
+	}
+
+	for (barno = BAR_0; barno <= BAR_5; barno++) {
+		if (!(bars_used & BIT(barno)))
+			continue;
+		if (bar_ends[barno] < SZ_4K)
+			size = SZ_4K;
+		else
+			size = roundup_pow_of_two(bar_ends[barno]);
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -719,8 +743,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+			goto err_set_bar;
 		}
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mws_size[i];
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
@@ -729,19 +757,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			goto err_alloc_mem;
 		}
 	}
 
+	for (i = 0; i < ntb->num_mws; i++) {
+		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
+		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
+	}
+
 	return ret;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
-	epf_ntb_mw_bar_clear(ntb, i);
+	while (--i >= 0)
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+err_set_bar:
+	while (--barno >= BAR_0)
+		if (bars_used & BIT(barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+
 	return ret;
 }
 
@@ -1034,6 +1074,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_MW_OFF_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%llu\n", ntb->mws_offset[idx]);		\
+}
+
+#define EPF_NTB_MW_OFF_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_offset[idx] = val;					\
+									\
+	return len;							\
+}
+
 #define EPF_NTB_BAR_R(_name, _id)					\
 	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
 					      char *page)		\
@@ -1104,6 +1198,14 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_MW_OFF_R(mw1_offset)
+EPF_NTB_MW_OFF_W(mw1_offset)
+EPF_NTB_MW_OFF_R(mw2_offset)
+EPF_NTB_MW_OFF_W(mw2_offset)
+EPF_NTB_MW_OFF_R(mw3_offset)
+EPF_NTB_MW_OFF_W(mw3_offset)
+EPF_NTB_MW_OFF_R(mw4_offset)
+EPF_NTB_MW_OFF_W(mw4_offset)
 EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_R(db_bar, BAR_DB)
@@ -1124,6 +1226,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, mw1_offset);
+CONFIGFS_ATTR(epf_ntb_, mw2_offset);
+CONFIGFS_ATTR(epf_ntb_, mw3_offset);
+CONFIGFS_ATTR(epf_ntb_, mw4_offset);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
@@ -1142,6 +1248,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
 	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_mw1_offset,
+	&epf_ntb_attr_mw2_offset,
+	&epf_ntb_attr_mw3_offset,
+	&epf_ntb_attr_mw4_offset,
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
-- 
2.51.0


