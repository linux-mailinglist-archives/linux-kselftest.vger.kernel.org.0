Return-Path: <linux-kselftest+bounces-49273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264ED395D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AAAD3009AB7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD43337686;
	Sun, 18 Jan 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bYBWNLmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F008334C34;
	Sun, 18 Jan 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744516; cv=fail; b=kheZlAmOq8cLPOTqXFT2g1Dn91GLaLYZWYQZtO5KxR8E5euVfG+6nmjvxWn2ox0gSYFOmT9vT+FhoSdf4rvz7WbIAQo2pAVzGYYni8pA+S1nOlUmJLSP2xT11uvvwwZqPyUz3eaIaobMBTpZuOLnXeWlYTz09jZuIWYqNHFTCVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744516; c=relaxed/simple;
	bh=cLAViSjhao4QvjW/zPzAXev/FWT8MW049AIrZB5rn3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=janjYRhn8vaZi7j4uIsoBZG2fSdVuyA4Vc3GtmA/fdD//oKjPFY/9y49zeALTsddri2nw5B4AaFoX+NT1bHmUWcYiXyfRC6fPZ7ACsLrga4AOLrFM1d+KOQ1S9YORTPMZcNMTXhunte3iEjp2XaECb+AxCrFNOMKGfe5eGmIr3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bYBWNLmn; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDUo46QEpzierYgcs893UQE0Eyig61BR0PCNWZP5iT4bTxi81QCDUjCms9b0VrZ2A7dK8+d6DfbnHe2IboAXioJiTKSiNzKJstEsfF3hWSxA2U+YEjtbOVsCow5Gcol7aWz/jJORkPyzNASzbI068silYVqo7DTcuVMCfdR0keXGDBkc7mZAxX2JjIhJtHMuvL27MiHsSURXAZfs7bSPiA+3Ez2jkqdJm9eQ5IHCLaL6Z7qio30TEtWHIVWK/lguWlrEgNDNIhv/O0KtpaDD4jFXgHH+4S6L67rK9IMvlSuKjlWJzj69CiogsKBmpqnFWT5aXBjdRU8tOUrv0ofTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+67+cYoMVE0Yg2nOZH8eOjKF2/2Yp9GhBnnurvRKWqg=;
 b=KtyF23uFlDTb8xkHddzPEpMrOlj4+UDoO1ep/UrrhRvlfjW4+5y9yRawJfmL3pRYQh0/YEtzRJG37gP62Zz9joqETejbhRVpzeSxrf2sb0e95vNjQiwakIM8QdnCUB1SAZLlweCW3ko8eeslua0ErcQrwJ4IqHOqf0SnzcWfbXMZFuGQCx9a/agdNrmpRANEsfGKPAoHgM+OwCkAkovcK+U4xmM4Jw/BGyGDzQ07QfLECXhXKdjHosoYUMt46wZe6Ix6bwUVbtFkIrJZGy0A9MBhSiNxXwDDYhtser/JTJa4+KPvvGuLAwagF5NwMkctTRd1sminUWwPqH66dZ/lMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+67+cYoMVE0Yg2nOZH8eOjKF2/2Yp9GhBnnurvRKWqg=;
 b=bYBWNLmnydtgJlp9wWNVB1KzRxae4BfaqvYJLlmxVUsvoVdZYLqHfNQCNW5+rFUZrVKfXbhznC1XTvtrkmBwLa17Jl+0cOiN7mOoVnNKQN567cgN3y32dUk4Mx/++HcMrvNuFo3MxMpmeyUb/k3U6qpg1vVK1d3ew5Dx+kTGngo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:58 +0000
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
Subject: [RFC PATCH v4 08/38] NTB: epf: Provide db_vector_count/db_vector_mask callbacks
Date: Sun, 18 Jan 2026 22:54:10 +0900
Message-ID: <20260118135440.1958279-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:405::22)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffe6ebe-881c-4a48-f988-08de56992b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mhejKgg1mwXaG/rPwv3ekA/Po1O2rq07FalHlGYtP84KEE0VJaDW8otpzs4?=
 =?us-ascii?Q?7Cpqb3gCIPGl/IL7mfpEIFJ/u6Ao/hszijdvlDg7wR8YPF/9MoaZWNMop3le?=
 =?us-ascii?Q?qm+0QNKX9Hdgoo/Wh8I0Gt4FrWJOzK5mupjB5lYLC3Za1jYMJvRyNuPS84ud?=
 =?us-ascii?Q?1xUTWSf4jL95nWEMnwPskaXqCwd72XIMu2S6GcvqtQjJyUDIG+aL5/M5UcS8?=
 =?us-ascii?Q?LZcJkK9ClKqDONvLFJw8sb5DH7gC1A2zrFpvMpvuC6VX7VnLpsJ2Fzrl7WEu?=
 =?us-ascii?Q?e4kW33OSfwz/K+vGr+SCOYNG5940fWlYkt9/GqVBABuOtQhfie50AEP25jZ+?=
 =?us-ascii?Q?fiomi3rBDi6YrR+/x32L6EJvmDMPRI2rHPWa7jFXHcTEdSerx3Wup2NhrdKJ?=
 =?us-ascii?Q?B+smkC8edgL1dqDXiZ3019E3WDYe/B31vHFmaeo1U2JHZ3pxI2lpvAgIO1lq?=
 =?us-ascii?Q?d1/K5Yq/LNvN+SVMRbujY2PSkxCBXkE1aCV+bjiXyVpbnkNE5fFbTtdRZiEA?=
 =?us-ascii?Q?GHfJroaaMUOofAzJqDxyCKTaLhuElB7QA7VDzdPc+TemlUt6pbldizTLDFU4?=
 =?us-ascii?Q?QliT0ZNCP36+VhWV+B6GlRqYP23OXVZnR6vl1bgQpTqKW9i8yIZr+bxDRWWO?=
 =?us-ascii?Q?qOUWoqZtS44ckjBHAQ+efCVnfd3OxiT7+z+nxAIds3+1+7nT+XW2osg7UN1a?=
 =?us-ascii?Q?BXhsnD5VxL7Z1dV7j44prjHwBwSavLhmb0S7ltkgqX6Mw8E7BRLzLzp2YNSE?=
 =?us-ascii?Q?2t/EbUjJ0cxVIVa2aVO/LkxPshWHRQaZC7ixR/GGGr9HFNmMc/7KnqrEImrf?=
 =?us-ascii?Q?/g8jivVJeB3E4SDY213VtX09Gnb2UxjybXMe3BH8gkUiHwcWxcDqHMBUFwDP?=
 =?us-ascii?Q?8LNGtGEtxQ5Hc3n2AcI624yPhYLmmoGeWd1NSfiduSITs05IWcNRRbz43KfO?=
 =?us-ascii?Q?n+9fTgp7SfnBowuXI5GXM3Z+BT4hGg3+DtPNBHLivLZXhqM3LUCJxhG8CPYZ?=
 =?us-ascii?Q?En21O2xRMnJDqTY5nbLTxRKwPh69qAPmFnBERkbeyjuIRvD/3bcIBOAXbiKf?=
 =?us-ascii?Q?gy/SnApCd+NmvL1sWWvjXcLuV7CetW7qEVv2wjD7n2p1uPLLmqxdRKJKVVgg?=
 =?us-ascii?Q?TY1RmDPfjETHIqtUwNGWfoKuvh6U6PdgoDirdX/SUDUIGI8tdvypNQA73tEO?=
 =?us-ascii?Q?kso2TQGFlRBBeSfVcZ6HEPsxfo+n5VuBSgUUxVGSt+XGLPlTdksZNSIQSI+1?=
 =?us-ascii?Q?p7S1ZvOnqI3bkKZ4/dX3LhX+4pMg1l5P9TgKOiiZsWFlMIwoOGyKJT5Bpgqn?=
 =?us-ascii?Q?bdOqtn8SrpLFtG3RGpXi3UzgvdM6janeUv7dUqZCHR7ic02pOFVLGAhLbzgV?=
 =?us-ascii?Q?PrGyMCzQtP/42h2xE6ehHy4EPdMQb/uiaBzD4bWHbCNHGhYTBmhODoK35ozw?=
 =?us-ascii?Q?rWdm/qDGOe4EY73skpJqV7oc9NMXe3wK4Rkw7Cblado2RRkfq3WQzGrtmHQp?=
 =?us-ascii?Q?j+6SMrJ2tB8RbHmirJXpG6t15JntZ4z+J3NeueTbO67af4G5YScFzj5E3y7i?=
 =?us-ascii?Q?4D1/aTRk9OJMGfx28j1LSezkZ391wxiXIauT3RQrYFMoqHzVBz7Fh7lKvbR8?=
 =?us-ascii?Q?yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iiEp8MbtmD/6kwYu6+9RzafVtGOrFRa/IB9kn36aBFNJUhQ/fMyyeqAd2ItZ?=
 =?us-ascii?Q?9tppN7AHM1FmXEnku2SqNosMBemvU701Bux//n/i/2yGp6i9QcLHimxlsk4l?=
 =?us-ascii?Q?EMfxX+ldiBQ5BfUIcr2b3EJlh+0dYQvCj35+CMqGrEpcdVO5t9fMsBRk6U7K?=
 =?us-ascii?Q?wk4e+kDBTmO37jqT6s0b5CVa2zTD9FfdmvIQ5v61xZqYJyG/YBhH9qcw723S?=
 =?us-ascii?Q?OyxbQZsgXO4E3hDLe4BcBArFC6NHF/iORGF1M1fLFXKRwtS16Sdrv1hFo4vj?=
 =?us-ascii?Q?6jLcD3EAeG5k8DQ/ey0vs4gOc/dSqiY4BI8f1X4Prf6b441NslsNExqj0/hR?=
 =?us-ascii?Q?YM5iHMRzHVMHnlbEW564Nc9KSrGG8fdVE+eBIBuZm6GdOy/6o6H8GrF9JQAI?=
 =?us-ascii?Q?nnPaQ545JhzI3pcH8aUPAyoR61Cd6lI0ImsPF56q1wi6VJc5mCeXRDl81Dk8?=
 =?us-ascii?Q?u3VSdtAguKL3+6DEzqsgchUaN+sbD8TgExDsPZNhAX92jPnLiUPVay+wqwPO?=
 =?us-ascii?Q?KxREoJi/wQkZL5myQAJjdXkPsojKQPUENgJ6MVj06tTZlVGrx7u8TxaT/VkV?=
 =?us-ascii?Q?GfDYK8KIKkzrYSYlmIT4yYDSze+4L6fqi0+3Dab9X/TTS/iuGRLuhARy4Klt?=
 =?us-ascii?Q?q/E5XQIRtw57RroQ70PSeV9fBvVShnJA9N3eaGNum6VpLCY8xyn9Xx3UioVl?=
 =?us-ascii?Q?/+ROPouOWaw3RTzkpI0yszKmXIbCb9yEEzvghQJjbaKrAz04YKvAd8cjfFUh?=
 =?us-ascii?Q?HwylWXRlv1FjR3QdAfliTlN3YdF8u4BBGdemAUUkVP+fjMqnRXAzJbeHU3TV?=
 =?us-ascii?Q?VtQHWuskNoLE0ZbMv5pHONAVAkRLg0bqowmHJeNI4smJyaOuxDCQsoeHNuW+?=
 =?us-ascii?Q?ILn+X2YX8FK6EVLMsK80bcghArfHo0C57ysuJ3AhnEqXQcXogmOs75V19A9r?=
 =?us-ascii?Q?4dZgUMUGH4L7sQh8vKw6iabju1BOj6fztvYhMBXMgkTsVp/ZCAUBQ/JYs43I?=
 =?us-ascii?Q?rl6BCQ01KjR/eFqIC6O93AElEV5YQZErYj341jIfHe1vBViDCoNnXsRs+zs6?=
 =?us-ascii?Q?ZgU9Fwl8cU9GRf+YffZwznJJcUtLWeBX1uVDyBbZqWdRFc89v6lbmq3yFuZI?=
 =?us-ascii?Q?tPbJQq/4phRTBpvZOrFlQDV3Hp+TVgm+9HHHRN8qHky9BS8fJ/UwwpmtZ/o/?=
 =?us-ascii?Q?IgZNBpESKCWQjKNhB6OmXPk5SMHnETirzl3r8ccYYoglkoog4cxEtxOzrR2/?=
 =?us-ascii?Q?0fT6AqAetetrB+VaTgZcRedYKvLlkC9z/zMtQsKXsVoNhOPBTmiocsIBBbS1?=
 =?us-ascii?Q?w+M+OGdZSKJso8s18U92uYWu9fG/n6l3iYmw4ZgrwwIQI7aV8f6cL1oBQApm?=
 =?us-ascii?Q?FZ6TPWbQJxcHUI3BvWq6Kb7OAIRTXCrNarIYe/f6jtHmLw3Y7e7IXv2LThdv?=
 =?us-ascii?Q?ifeSfwq1Q/Vt1Ms09QgReMXu3mdjQt7ZvR+6+ZduaIJAUiv3OdxjxDwClzyi?=
 =?us-ascii?Q?DV2rNMevI88bdbUDEFEaUHUIctWEzEAXFhDV+MPbrG5vSIn87wf6xcasx+9+?=
 =?us-ascii?Q?0q/GIXmVmv0hIsSdvffPQ2b9nMUzKDRvlQcVVKsr13Z+S6QePsepi3PN5+Ve?=
 =?us-ascii?Q?8QUJ1G73OpHoYAlusNt8X2yCXBO69eE5NMIkpVRvm68RsxR2EKk9fKr+FXZ6?=
 =?us-ascii?Q?93NzrVbMNLmGgClIPzaiDIYNas6vHT0ulmMfvdZgaJ7b5Q4ZBbkFxy4tvpw1?=
 =?us-ascii?Q?9RLF1S+BKFJnZdB4kGg8hPw0y9MddU2X/8f0acakqATGbgwi2WmI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffe6ebe-881c-4a48-f988-08de56992b24
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:58.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlXc9cbXgKcFa77yzk61ynrcjtZi8P4lVBzRth7lZ3vBnL1f8JpW18Zx8akqLMJENE38kU7RGbNy7keStfBEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Provide db_vector_count() and db_vector_mask() implementations for both
ntb_hw_epf and pci-epf-vntb so that ntb_transport can map MSI vectors to
doorbell bits. Without them, the upper layer cannot identify which
doorbell vector fired and ends up scheduling rxc_db_work() for all queue
pairs, resulting in a thundering-herd effect when multiple queue pairs
(QPs) are enabled.

With this change, .peer_db_set() must honor the db_bits mask and raise
all requested doorbell interrupts, so update those implementations
accordingly.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 47 ++++++++++++-------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 41 +++++++++++++---
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index dbb5bebe63a5..c37ede4063dc 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -381,7 +381,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		}
 	}
 
-	ndev->db_count = irq;
+	ndev->db_count = irq - 1;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
@@ -415,6 +415,22 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return ndev->db_valid_mask & BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -507,26 +523,21 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 interrupt_num = ffs(db_bits) + 1;
-	struct device *dev = ndev->dev;
+	u32 interrupt_num;
 	u32 db_entry_size;
 	u32 db_offset;
 	u32 db_data;
-
-	if (interrupt_num >= ndev->db_count) {
-		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
-			interrupt_num, ndev->db_count);
-		return -EINVAL;
-	}
+	unsigned long i;
 
 	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
 
-	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
-	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
-
-	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
-	       db_offset);
-
+	for_each_set_bit(i, (unsigned long *)&db_bits, ndev->db_count) {
+		interrupt_num = i + 1;
+		db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
+		db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+		writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
+		       db_offset);
+	}
 	return 0;
 }
 
@@ -556,6 +567,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
@@ -607,8 +620,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
-			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 4927faa28255..39e784e21236 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1384,6 +1384,22 @@ static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -1487,20 +1503,29 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	u8 func_no, vfunc_no;
-	int ret;
+	u64 failed = 0;
+	unsigned long i;
 
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
+	for_each_set_bit(i, (unsigned long *)&db_bits, ntb->db_count) {
+		/*
+		 * DB bit i is MSI interrupt (i + 2).
+		 * Vector 0 is used for link events and MSI vectors are
+		 * 1-based for pci_epc_raise_irq().
+		 */
+		if (pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
+				      PCI_IRQ_MSI, i + 2))
+			failed |= BIT_ULL(i);
+	}
+	if (failed)
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ (%#llx)\n",
+			failed);
 
-	return ret;
+	return failed ? -EIO : 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1561,6 +1586,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.spad_count		= vntb_epf_spad_count,
 	.peer_mw_count		= vntb_epf_peer_mw_count,
 	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_vector_count	= vntb_epf_db_vector_count,
+	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
-- 
2.51.0


