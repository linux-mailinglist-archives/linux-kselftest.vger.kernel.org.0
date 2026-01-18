Return-Path: <linux-kselftest+bounces-49286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC55D39644
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E601307D820
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8033EAFE;
	Sun, 18 Jan 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="minxXdIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020076.outbound.protection.outlook.com [52.101.229.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658133B6DC;
	Sun, 18 Jan 2026 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744535; cv=fail; b=UFwBx3y7wpeOqCHeKbz4IZ0EuB/e40Maw8vYcxK2qVpDsRgkXRz23/qrD7eC7esHVJIw7bOAZ1P4FJf06PlBYIjk49fTJ855szFhPZZxqE01yJ5uWX/yS8QyPIwox18lB+qCMR667Kjp7YnjBZjFUiYgEisMvnH+EZ7Z4KO8fnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744535; c=relaxed/simple;
	bh=z18ROQcMPJgBSVybHegTyWysddPi51yJ0p2FxgN9e9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLliopCL2HEbW54oL41YzydH18wjh9kizy7wcd6Q7OPQzo70RiCQS8S/EoWnztkCgE6Mkyqj1qrhArJxGKsJTjHdOb7HQcPTP4JDBIFP8VB1IQxt9SkxHJ8mK2KKIljd6HSP8rwEyCtUdFJqH1mwh4geBjlYY3Ijy2VYb1eXowc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=minxXdIg; arc=fail smtp.client-ip=52.101.229.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULKo0Es90/JugZfJCXHN4HEVIaEle6uMO5GOjWU+hhMz01FIKmeMkwbQbmsKEbLYKFysQAFu5TCLZsKrFCE224n6ExcmI2t3ctBbGVOAHmYe8RdcFuUt25i+kAQBAgWDeAEXjKtjnywhY2e1gnXGOqWC+7SlfzmivZpmYv2Md4089DofhYPFH2e6iVCscktYFiRk7NZ5BlkXqr2LaVjAX0zOmeooJ9yq6qRqW7+1FeVAzwOXYso5oOXKnma7VrKL9LXKqjA0GjLATBPc92oj9KDW3460nmmhmtBQawVha/SAH+tVfqOxmQh/Lreo1ZSKvtkQXUvA9EUc+Xuvs3v6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQKqqZbY3T2anGF07KqSQ40hMeW75pJ/JL+74TG32WM=;
 b=kGbbAJZYtcRrz5IPuiEiVQmqDk5fAh+VUdxhn/5ExukJ6Q3hxD9hN+xPcpVsay2cUH4oyXTMAtVYFcxXkokH+QiwGA7zQvEWR/UAl1OXBz0ltJE0k4ZyLZI+X0uuxxk4e8t0uctguFGCVhd8vRFfzDDq3jNQ3ynir/flV9rRad9xTEkopFFzYYQCJQ3KLoHX36g1Ny83xX8cO/+XQNbie3xb3Ruzo8Lx9qswPoZqHbDF7abAyAWERy25O+GKVgrym7nUaw7i9slYkhM9w/eCTceVPoNyIx1lhpjbboQu2KhKO+XlETU1NbwHG5oM7K2HJ4WetwI9NkZNWNh4HG9U/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQKqqZbY3T2anGF07KqSQ40hMeW75pJ/JL+74TG32WM=;
 b=minxXdIg5SMxozxzpDHrxK3yJRwbD/fAiFCDJfEDun22a9cYDsTKkHbfMherFFXLxOG9/Kd+BK3kGQWgDGh7tuU3ay+fxM2nXNOUsvOtwIuaTribz4z4twxE1rKz3j3pwk/Q13z6ir4i9R28sEZrpN59f2CAOvi4c2tQ2lK068A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:05 +0000
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
Subject: [RFC PATCH v4 16/38] NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
Date: Sun, 18 Jan 2026 22:54:18 +0900
Message-ID: <20260118135440.1958279-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3d93ba-a5a9-4cf6-dbfe-08de56992f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAqm7Wn6Mj9hFDuuWDdrywJRIQcSYOTV0MDSJRibcinphnwsltPcg3QPfYY/?=
 =?us-ascii?Q?Y7IkTtQekn9Wt+VRI2ifwepGtoKzDg4fiNTaAl1TilMCfuU2cvbEslxATBkc?=
 =?us-ascii?Q?CqoFAo9cRywMXhMwnO62WqhJeFhnxuQWvNRKg+6rAw0T+j/5/HUk5p6CvLBR?=
 =?us-ascii?Q?tC/WdqArI3VjH39Q0/dm72/RV58y1wEqPhbWsj4Xj7gp2M5OU4EtKib21K67?=
 =?us-ascii?Q?xICvTxvnrSZC+6oazFr3XzzDDUB8wXa48Gug0DxuH/dIeoWhP6fYLgp1rqXy?=
 =?us-ascii?Q?J3IvKpgh9eEy9mmfWPZAsijNVVeG4p5hSpobIv9TXD+qWJTWzWbsL3ar2pIA?=
 =?us-ascii?Q?/hI1Fpu4fC1KcaI8M1Dl8HklyxsW0GhUSjtMA9n4feFtzKUsHm+GXB06dPet?=
 =?us-ascii?Q?wGVCkw9PvuwEabOzF/urgFAOBOlxC1RMlGphKfJ8nRoGnZM3N32OB9zJ6D/L?=
 =?us-ascii?Q?y08351BwIT2AYKD8YX9yr5ONh9SM9K2ii2Wxv+3f7fWAv3FWEqXCYN9NIcMM?=
 =?us-ascii?Q?2xzi3nseYoM39XpRvp6Nh9SoHTidu1YH8o9amyrUcHjabfAi8JQm6GvfMmDL?=
 =?us-ascii?Q?/1FzBVQWClMfTVfJlpXX+4mZTr6SJ/egxYtO0bc4DwlwRldCBfrhJuWYg0Bb?=
 =?us-ascii?Q?2G0cS3DEfQajz1y1P7G9SyXsApzZ8UcCtRAylJzAQYz9/ehFJ9xflZ3aI1mO?=
 =?us-ascii?Q?S5mVjd0mspym5b3U125tIGjtkd+e/FrvHcdHEFBsIkw6iZ13GeW2HTR2RmsV?=
 =?us-ascii?Q?ytz1vIqWEL3VadWXWa+fHAcRJysUSre5D/61OdKlAbyZFkN35FJurQkpjMCm?=
 =?us-ascii?Q?QFzmcBu4pVL0msoc8iLFK4OQMTRNdMiBy4tljIxUT54QjcnPdqCo8FS09o5X?=
 =?us-ascii?Q?ujGzHkPsXhkDdfnerhuSORidAnSrzvlIGTYLId4rqol+QjMYn1llfkIkB+vN?=
 =?us-ascii?Q?y7YvcFNTw+klMB8AmrGOmvuK7HPRPcAw68DuGWqD+bKGfSZJmNhgXQUfG7W9?=
 =?us-ascii?Q?alzAgGP1Q2nTuOMPke3/C036SM3DORd3emTBrK9q83WSao8XfWy/xr4daPzb?=
 =?us-ascii?Q?dWvU0DRPiOqd4wMCkMLiRo3ZTfS8SJR1igZgofYxqWKsYMeLT90jGyJlrWmP?=
 =?us-ascii?Q?TI+6LCW312CVweVy5SBgk1gDoI75rVFchH0/USlrXZ9emrpa7lmxCxlvukZd?=
 =?us-ascii?Q?fzdMbLUhn0Lq3X1jIA9IznzOkL3Xkp7ISZ+YovSXjX0ylDJgu1nxcTg0FvbC?=
 =?us-ascii?Q?ge3MAacDiirdQilAyBh3zJIXtnqdgC2KHWNjFm7DQt9tOFlN4E1saQCDgiTq?=
 =?us-ascii?Q?7lfu5W3BM+k+bb7XBlcQt3PFMLsJD5PoFV+CYPZ6cQyCLq9wJLUq1A+RC3GB?=
 =?us-ascii?Q?khn/vwI/RLwr55zNgel569mG3m74zxAuThojV1shBIA7CQtAn6fEDbT6re9S?=
 =?us-ascii?Q?Vn5c4Fs78SqnQewYAuyBtgE3iyNeevj3bBjWOMuphuy21te0w4ZWIFm09XEi?=
 =?us-ascii?Q?5nd2UDTiAXHL/Pbgrcr03LlTJaNVJfIHiIVgB5CI2iKO2P/m4kOdtqLxcYNp?=
 =?us-ascii?Q?kEeNxE0zi2M0bHAJPp6caKrdegRQ2wsJwC/6ZDjv7VckEk66ZhLidL7mSmQZ?=
 =?us-ascii?Q?8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/u6KbYV02A8cAtMVi6Oi+7wTG0UDD3sCQZ55UWmEWayupz5xqkT+o5BgpC8?=
 =?us-ascii?Q?KM/49sy+gurUi0FdvI8J2FYmCeBlqqScxTJ+BCcPIGktG/mHIJtDd6yKdmwI?=
 =?us-ascii?Q?Jm9BPWLkJNmXmvMPDFWJcCyPYR61SVnbxCsWNyQvniw5as4Xtqc5yFR18XSK?=
 =?us-ascii?Q?UYSwatLEfqVuzZ6Crf8ZZNtZIp7qXx4kJW0P5rb8JiA3e7IhHq7RXLt7RGJp?=
 =?us-ascii?Q?XKu2iYlDEhpZvG71Af3bWM/4fmaLaUw8MbEM0Vc+GLU2h3lfTOwdLmt7v1Ll?=
 =?us-ascii?Q?Qvai+avoxyJkUebeKBofSaI10728yvnpOYC7tjPL5M1QUr1XwcyoSh+c3CIj?=
 =?us-ascii?Q?0F1Nb+tF/uFNrHn5uiWbMVBJ897UL/H4LmV4/xpIXSDIz4MuZ8zh6oUqJ47h?=
 =?us-ascii?Q?hRqyu3ISOkO6xckwdQfnA0/r18L5PmrQ4Bejfq4F/bKGn6WXQtR3i/J1QYv7?=
 =?us-ascii?Q?me0OChyy0YoCDXqCKYhEhYqNjKj9PLkcqWkhBRlIpngG0kAQ5d3yQ8th3aaO?=
 =?us-ascii?Q?LcTCm9l9tIpPdoWVhMNIXNjatSGTRqh26PHJHywfKXdYGYLObNPsyt+0+DYI?=
 =?us-ascii?Q?6LtMKxWjMK6S/ZtY9/QaS6xLV40Fp5bVd3XYLM9nwU5DoP5OdzGEjCYEpG+p?=
 =?us-ascii?Q?yHtKyv0Sy+IdjZJOIllBT6piIDhhSksO7Rz+DoLNcIpqqM2Q+4XsXT1GdgGM?=
 =?us-ascii?Q?nio7rmV3F3Qf2GqPeaYn/J4zf6m8GcWejV1290q4/jRmH9txvrfEbODx/T1u?=
 =?us-ascii?Q?5Xe8Hks/J6GtQsTt6ENG0XIW86F6pc8/IhOK7vKWSwY68hRzMK1gaTHckDwW?=
 =?us-ascii?Q?c5xDd4iiidTd2wKDZ3X4APQf3r29boCZaO4a18q1tZ2DsNzf/8A6Z+LL20Bq?=
 =?us-ascii?Q?ZaBOCS871B8Ve3YDamc/nfvk1S3Sb5OfKzr08BQB1lwQMc0uoR8KKL70TlP5?=
 =?us-ascii?Q?XoO3dbgMq3Xp8LkmaFzoHCH4B/kTn1J59aR36pg9A2kc/jwuYt3b9fHehZ8m?=
 =?us-ascii?Q?2BrLuiXEb5KSEMYjDiA1nsPkLYIuTnNhpGGUJV6AeGXK92ioGsuKAAmAybWu?=
 =?us-ascii?Q?/FbarTbAqlY99JHbMniWQA6diqoLiAPn617avXrCQdx/IJpYTGK559Wkk/+t?=
 =?us-ascii?Q?7P46HwjeG3xW2vKKRwxsLIByTHrG4goVTpdcp9MpDg8Emf/9snWvSjxztOon?=
 =?us-ascii?Q?//+p9+vW32ngEL0AFJtDUQX4UJs9YOfEjFAla3ofTOrCAfzrnsP46LOpiNhb?=
 =?us-ascii?Q?wYWo7H5Onx1SXSky7TqgPxy1FC3RFehDBbTiqn/TPFOJOJUz0wk258pl/VFe?=
 =?us-ascii?Q?v/7W6vYSuizQxtXcGjnwVbo6XWBZYHMQFqr67EksfoeY4352OlL5OPow6bqe?=
 =?us-ascii?Q?ST5U+bJuim4tiePVK6L5EYszYHS11WONmn2B1ZubyFyuZGuizu5GybI7FiV+?=
 =?us-ascii?Q?lmMFm3xEyLFEUe3HwJ6t45Mp4FOHOVkB+itTVFTuW3IEITRKT40j+X4cRIRh?=
 =?us-ascii?Q?lJmM2n42KREvyjrvxNeRobsqNaTNpzYgxZ26Ia2P2tkjrP+JsWl60HQN4xaT?=
 =?us-ascii?Q?kc7skWhYCDne/lotiEbWXaCufhTHdIFeDmBAudKgH/JWDia5KOYbdxFwb3xI?=
 =?us-ascii?Q?r0sKQ+OVP4+IJyCqXu8wkLtPlG28zAoP+6WX9YWrG1DN3pLKbd27mAUgt0WK?=
 =?us-ascii?Q?yRRSHUcgESBxpTGDbYDHxImyEPvh/kXIRWESzSJ7h1OoGrrMGuj3cwhomy2q?=
 =?us-ascii?Q?WLONwf+PBqeHyFQ5zigzzJmWHXQeC700z3e1o+HYecsoBAeUFr1L?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3d93ba-a5a9-4cf6-dbfe-08de56992f03
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:05.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl6nq/1bH5BarsY6i2vXVGz4awMr+CGbbuyWW80Yw1pE807cyHSZweUlL25wFs1KOmkkaUAOI7axbaejF+41iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Historically both TX and RX have assumed the same per-QP MW slice
(tx_max_entry == remote rx_max_entry), while those are calculated
separately in different places (pre and post the link-up negotiation
point). This has been safe because nt->link_is_up is never set to true
unless the pre-determined qp_count are the same among them, and qp_count
is typically limited to nt->mw_count, which should be carefully
configured by admin.

However, setup_qp_mw can actually split mw and handle multi-qps in one
MW properly, so qp_count needs not to be limited by nt->mw_count. Once
we relax the limitation, pre-determined qp_count can differ among host
side and endpoint, and link-up negotiation can easily fail.

Move the TX MW configuration (per-QP offset and size) into
ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
centralized in a single helper. ntb_transport_init_queue() now deals
only with per-QP software state, not with MW layout.

This keeps the previous behavior, while preparing for relaxing the
qp_count limitation and improving readability.

No functional change is intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 76 ++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d5a544bf8fd6..57a21f2daac6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -569,7 +569,10 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	struct ntb_transport_mw *mw;
 	struct ntb_dev *ndev = nt->ndev;
 	struct ntb_queue_entry *entry;
-	unsigned int rx_size, num_qps_mw;
+	phys_addr_t mw_base;
+	resource_size_t mw_size;
+	unsigned int rx_size, tx_size, num_qps_mw;
+	u64 qp_offset;
 	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
 	int node;
@@ -588,13 +591,38 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	else
 		num_qps_mw = qp_count / mw_count;
 
-	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
-	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
-	rx_size -= sizeof(struct ntb_rx_info);
+	mw_base = nt->mw_vec[mw_num].phys_addr;
+	mw_size = nt->mw_vec[mw_num].phys_size;
+
+	if (mw_size > mw->xlat_size)
+		mw_size = mw->xlat_size;
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
+	tx_size = (unsigned int)mw_size / num_qps_mw;
+	qp_offset = tx_size * (qp_num / mw_count);
+
+	qp->rx_buff = mw->virt_addr + qp_offset;
+
+	qp->tx_mw_size = tx_size;
+	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
+	if (!qp->tx_mw)
+		return -EINVAL;
+
+	qp->tx_mw_phys = mw_base + qp_offset;
+	if (!qp->tx_mw_phys)
+		return -EINVAL;
 
+	rx_size = tx_size;
+	rx_size -= sizeof(struct ntb_rx_info);
 	qp->remote_rx_info = qp->rx_buff + rx_size;
 
+	tx_size -= sizeof(struct ntb_rx_info);
+	qp->rx_info = qp->tx_mw + tx_size;
+
 	/* Due to housekeeping, there must be atleast 2 buffs */
+	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
+	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
@@ -1132,16 +1160,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
-	phys_addr_t mw_base;
-	resource_size_t mw_size;
-	unsigned int num_qps_mw, tx_size;
-	unsigned int mw_num, mw_count, qp_count;
-	u64 qp_offset;
-
-	mw_count = nt->mw_count;
-	qp_count = nt->qp_count;
-
-	mw_num = QP_TO_MW(nt, qp_num);
 
 	qp = &nt->qp_vec[qp_num];
 	qp->qp_num = qp_num;
@@ -1151,36 +1169,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->event_handler = NULL;
 	ntb_qp_link_context_reset(qp);
 
-	if (mw_num < qp_count % mw_count)
-		num_qps_mw = qp_count / mw_count + 1;
-	else
-		num_qps_mw = qp_count / mw_count;
-
-	mw_base = nt->mw_vec[mw_num].phys_addr;
-	mw_size = nt->mw_vec[mw_num].phys_size;
-
-	if (max_mw_size && mw_size > max_mw_size)
-		mw_size = max_mw_size;
-
-	tx_size = (unsigned int)mw_size / num_qps_mw;
-	qp_offset = tx_size * (qp_num / mw_count);
-
-	qp->tx_mw_size = tx_size;
-	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
-	if (!qp->tx_mw)
-		return -EINVAL;
-
-	qp->tx_mw_phys = mw_base + qp_offset;
-	if (!qp->tx_mw_phys)
-		return -EINVAL;
-
-	tx_size -= sizeof(struct ntb_rx_info);
-	qp->rx_info = qp->tx_mw + tx_size;
-
-	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
-	qp->tx_max_entry = tx_size / qp->tx_max_frame;
-
 	if (nt->debugfs_node_dir) {
 		char debugfs_name[8];
 
-- 
2.51.0


