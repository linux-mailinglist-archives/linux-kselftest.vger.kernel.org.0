Return-Path: <linux-kselftest+bounces-49278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D2D3961B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DB663067DCC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32E33AD9C;
	Sun, 18 Jan 2026 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PkS02Dwz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DE3358B7;
	Sun, 18 Jan 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744523; cv=fail; b=CiLWwVQMz2KjeilGWgxHZOhKjBynBwl9mjbjLV4VM24888SsA0Mfv+PdEnYsZW4iVo/e0o58660dppQO2XDXztqI1q7n8Qk5Y0pCt100Ma9NVmxPhaF/qZHeRPGysE8eSc7KwjyXQ99Z5LPBERlNusUUyYw3KRMyinZTunzFpQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744523; c=relaxed/simple;
	bh=aloQvjQOWlNcnCZ7ZamoSnLyuSFezDKjxdHc1OpmOzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRs/GobyiDXoj0ds4mLAd+W31NDjETidT23v/oQO+f7HYEh9Wgv1Z7Dn+trpsKq+KdDUkAeVylRjAF1w6LSAt0KH9FuE22nfc3+nr6Wuk0Ac8x0fcHRtjMJ+tFb/iz5J2ECH6AZrq3RX16kqtO9J4hOnvy2kNgETB2o82wnZ4B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PkS02Dwz; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeKUDsPw/3yy+OY7CcuDYxkBRZZWjOwFONyoOnPgBo3moCWjK1H8sk9JdQwHBYD551CMepXL5QNgp0Q/M2GfdzT9jF8AVd8MqCPy4jIAgQFqGttPWI2mNNOgM+cKxBzrnt5KeJJWehleB4ze0OKtWjoChe9OIMuv+6PAGr4qZ+7xCku5ye7kUubSRIkyH82nxTLzdfQjry9+qd3ctZxj+1KZWXr3hs0VgeenbjNLueGJqFBKH76S3AhzE3WztVfYDF1LCxSRASGRJKYJyLtpHHGji/kyRjjLALPs4AlxlgLVDs9zr7MIJ41JrVLZRcptNw1Pr+J/BPobwMjgse9tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JCRz0+Ku36HUG2Q8xlNjkeq8zScPBCasvd3Xu84CmQ=;
 b=iIDggWvE3Oa1SiAJPQ2FX4MNw+5MXUEuwDTdxfNk6Z2NY8MbEJXvwEh6KQqX4etiqB05O/W8rhAkITl3UcBLFIDNAAvuyoEAQfbiARp6ynLchhTzND6+2ehkfCgGsiRVhuI2elUHNcT8PwxVq+OuhLiNq4JrMqsaX+SEt0BNORQU111Sx37kQBLr62lqJZ5eqdbhWmQ0+O5eLZ2v8h0i2oYv+1dHmzEHUojb9Ot4YBicnfZ7zXsJKJ0o4iXBuxSPDhgb0tYRpAlpN8yr0Xl0zKSrVV5IpxFFbzpyL2jeed1KKSCo0DuD5g9VcHjNJheFCtlcjgFwNklZP0tiMhIzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JCRz0+Ku36HUG2Q8xlNjkeq8zScPBCasvd3Xu84CmQ=;
 b=PkS02Dwzob3AP/kHp45YJJUS3xa3QdtslMguHEzELTzm+dCPI4aVjceKkXlqb6kXH6KxYfVeOY/obf52+UGN1Lc2q47uJj7iFtlSPXYLHjkCSAbSVY3Zhg5kKodDa+/RyHMblZdlreTTn3yhXD8UE+iJOeLMEZ+x+2jXJCQFQQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:00 +0000
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
Subject: [RFC PATCH v4 10/38] NTB: core: Add .get_private_data() to ntb_dev_ops
Date: Sun, 18 Jan 2026 22:54:12 +0900
Message-ID: <20260118135440.1958279-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: ce270233-052f-4aa5-92b7-08de56992c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PglOhTUwOFAPD/mdpqMpetQfQIRNvcDcwL0R9r8UTRaPspDWP27RPG87w7xZ?=
 =?us-ascii?Q?WM5WBtiNuA9ZvZZWp34+JnzGqBzANKU0DlYb5xtUTdwI3bK3jEUBtfJw5r3g?=
 =?us-ascii?Q?10VmHmnQR8JkMjwI+Vw6KLC8oiTYHzbrhLbOViSf23s06Idqn+JaofQqNM9M?=
 =?us-ascii?Q?clVx4g7m75tdvatzynkzMsC/nN2XRV18PjN+0eJf/lIVMaG77pOAdkX6ZvuI?=
 =?us-ascii?Q?x7gHxDHxDgz9oKDGqu16WY5F4iuWw6XR0SLfVwUWXVHjOKTyrZEhGWE6ja6X?=
 =?us-ascii?Q?NqUYbVjNRPOy1IviQhuB/AeX5Rv5Nk5RqT3ywLi7oVIgw3IdFnpy+GexPWZU?=
 =?us-ascii?Q?T6oSFkyaFOCpdwcOu3oihvPtwFxTw5FEETQ/9hQqi+u70iAE3BymqRMokG7E?=
 =?us-ascii?Q?pCH25r8oE8iucVLL9clNSBW3rG5kZAQN8BLqa+mZVG4aexC6Oq3hcrtJAgc+?=
 =?us-ascii?Q?5wdFQgDedbYM2iWaGCRSr4QqzexVXr/+RFU8B40HW9UnPr5vcOABxQIg0ZcG?=
 =?us-ascii?Q?u8NDxXPzAJFArQTgzYnrkVD+I4anYL5oT3S6/A0kf5SdznddByUYVoF1a8Nf?=
 =?us-ascii?Q?dVPBHkZ0oipy6x8EYYHxNONjG1MJxEA9xemiaOU9qAbIIXnPlYwfHfrXS9j0?=
 =?us-ascii?Q?J20TaQYCHKfkzRHHZITucdH0dZz1R9f+LQugKOkyylQwxUaNttieaLZCfajj?=
 =?us-ascii?Q?Mcl7sDodqdpyBiIXol46O6jAQ1KjMgznP0RsKtGcId9Ovd2yZmGM4e/x/RxN?=
 =?us-ascii?Q?t3O0zhKzkRqM9MHNVm5q0UHhFkiCzAxKoNSUmLZXvJyrg7HCBa7jU+J8iZ3J?=
 =?us-ascii?Q?vurvFOrsWmRG4XUpLbVgN4nWKxBMJJzgTM9jrdRQYciYetZ/JxP4hkhhdGvv?=
 =?us-ascii?Q?YyEyGf4MmamWDk9ehz5ng6izvKV86xrObYkH2G+qGS7mBQzFTrCdYDdV+PlP?=
 =?us-ascii?Q?buH5UCXbyjTtMvwMhuiSOA60U9qnlQp8NHRwFHN/dJrgAZBdM5COxxdmNwSx?=
 =?us-ascii?Q?3oV2LCMucXHp6BA9xLMvAjFONKuWHkHFnKNcmDdPnDa9MXFnzqIsQkQkDPjU?=
 =?us-ascii?Q?daTF/IkpgJ+6zyUMi68k/LjVzYgSh/TYllHAsBLk4guWsf5fVyrDSA7ZprWW?=
 =?us-ascii?Q?YWkE710GlNiX9y5CZKKPrTy/Pfy4f48KR7hT8FlIrn0yfq0aJ9+wHRcuUJQv?=
 =?us-ascii?Q?ahRHofMeYkvBd4UTNAlS1oSmsBR/W9hW7eZ/TJHXUSKSvLUTFM5FGdqapTsp?=
 =?us-ascii?Q?j0K4sWIWQA/x7AT47vAwiyeaQTS17a+NEnJktZY+bkCpTKhYQIeV6UQZ9pCg?=
 =?us-ascii?Q?d0eRvrN/Tq4nmX+UeMTArbhHVkdnC0Ipccifooh7E7HG7stbAqs0qeUEXo+d?=
 =?us-ascii?Q?5Yj5grn850Vg5ybfvZXYrEphCdnZE97Cti3x24TFcJOe3ZgD8uKNWf9sR/q/?=
 =?us-ascii?Q?z6v2ROVxVW+XaorgkysOZ48PsPdWxsq9TBlG66gRTJyEVQ115885Fs44wJgQ?=
 =?us-ascii?Q?IvfI6hsOAxF3Bvt+j09gSfkVofzivE3ABzJsWx6v8sAVO5Y0YJ/8LGKum4jZ?=
 =?us-ascii?Q?TwMQyn4p1U7Mz8W/NUq3P87J+Q6uDedeK2owXH0JuTDgPDpbJTg9NSAapa2S?=
 =?us-ascii?Q?4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/6fIJrkZrnjl3I6flY3mQProdgGYVOdxbiBWQ+zYzCvUrK2b1OCAl4iye2+?=
 =?us-ascii?Q?Oxb3LOgthkDHmmdXdl9gowRNCrOIuu9wIbtFIbGpDFZ7whJv0a9iZWnOe3n7?=
 =?us-ascii?Q?cVQ/W5GlW/L1gfCvERYT/zetJkWVP/U52vFepqcqwSWIaNx5aWxuO06snpe5?=
 =?us-ascii?Q?D9543yf1jHBDkMOABUJDShXIJbTJvcFHku7CvyO7EBjnxo0z2bhWCL05ci1r?=
 =?us-ascii?Q?1O8+y4HTXHBlZleDAXsJxxcH8l7LQmad64qlmJ1OKwSFcZa7HH2Wja1HJLok?=
 =?us-ascii?Q?m36Qpr49/hOzn4Yx+uVDdAJjzMh3hkKdr0J/NzUjNJ+Hy08sQ4TgHQ3Y/ETI?=
 =?us-ascii?Q?R3uyOirDRlqkNSoXfPj7cV9w9MpPAlX7vmJ0DWDdWcQkuhmlC9uboRe6nD9k?=
 =?us-ascii?Q?XSAXkp5mMV3u++hJmqsUBSXvD9EODzVizwQOAYgDBtvG4lFceTn1SkWdJcBa?=
 =?us-ascii?Q?IhzQK4075S2pcwNfZtSTRbiu1FNUXyZO+TdIvGAYTeufWqLwjrQNJUkNcg68?=
 =?us-ascii?Q?sx8PF/+k+bfOokjaRQOFKujXI4R+6GQJCvKEYCLOnL417NKSpC//DUw/DpoP?=
 =?us-ascii?Q?8d1mPf2fi9tLSOkZT7x0d80+yRFN2Of19QY8x9oeUzobVhcHQf4ZMOIczt1x?=
 =?us-ascii?Q?/sVrTh+aeqaj1Uqp7qhs7rdADQIcSSjeP9U+3zmiUsOCSM9QmRHEc5l5wJhB?=
 =?us-ascii?Q?blHMtDdFkKgNU8xfenOXKHw2dlRX8QBNWO0rIXlTuGXywukHdtM9vaVl++Wf?=
 =?us-ascii?Q?3PeXBpHwcXNt4OuOzEb3N/TFks9oNUnUI6ttewQfTW3GEuVsmFj2+ugOjatA?=
 =?us-ascii?Q?OvU9jWXAOAz0ReoVmJu+WbaTl7RIdPA5O8FMzQKqU7f0pcC10IodLBP9Isa/?=
 =?us-ascii?Q?pzrF3xtrl1AYsMtzHO+lZ3Nz2iUD6IwjGy2VZ4myg/QCcX1tUf8VRd0/9Yr2?=
 =?us-ascii?Q?mA4+7QOd41I3I0R+CGcV1DlUw0zyvbbGAkSpAEfJeJFPA5x1pRPFMItIyobH?=
 =?us-ascii?Q?uofXERYiE5YI2Vb9BXk3Kn9aQ7iREqDj5Fue4VHym1yw0ocLmTG9qVuYLKRY?=
 =?us-ascii?Q?62Iz0gbcAomLEVjWZNl+2gadyWboSJGYaLz51Yx3BlQECziiz3+WerCYf0up?=
 =?us-ascii?Q?nq/zkhuqe82jDmAxuW6RD7qHngL9iamC2FsIFlaDxD0QjHbqxdZbOFn55bS5?=
 =?us-ascii?Q?/jD+bwQ9PuXSuFZ4+vyr5YfWdKuFGBFqwwmIqsigCPRyZswO2a6Qz2z2FSJ8?=
 =?us-ascii?Q?yA3LfoyGxI8r9ddQw0ChvXuQ0bdO41cYQ266A9GjaNW7e1kGlpuX43NEbxFA?=
 =?us-ascii?Q?Ly+wYcB0rLju9xeKQLw+0Bxmg6bA2Ly96VqUaAAzzaH5AlUl65mjldJIzN6B?=
 =?us-ascii?Q?CY6DM01LaXy5iqiyz1jpUbCIWoyWwgkanMKeVtKuKopnq0fiThPsbjO4mugS?=
 =?us-ascii?Q?EnxMCZLwkHY7ax9jQ02F02w4UyYoDmHK3pYY3PnSeJzeQj3GDGcwwk6Q4UrB?=
 =?us-ascii?Q?epZcdPm20TBZZ9BO61I9mn3vrTkCLcvb3YhzSAkmgytGLO5zgK1FrdRQ4vdP?=
 =?us-ascii?Q?yLmLHqKD6b2Usvyx6TZXf5MWMKBZ98jHWGW8n39EIWHm+FmWrtku8cKKvK+5?=
 =?us-ascii?Q?GMCwxXQ4G0MC6xkzDKyJ8lhwOcvARCmj2Nn24eg5wcJhGx3NvXDIO2lkKdhc?=
 =?us-ascii?Q?jjapODmsr6lw2Ju0CfBIsCMYdK/ddxDF+lbg8mJslxf3meLbQ8UNTXCTVVHy?=
 =?us-ascii?Q?X2ysAXjNJnRnC98DyrEhOW7VgctFf+snRfef8yrmqHtNwKtXKZz1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ce270233-052f-4aa5-92b7-08de56992c1e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:00.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovVYxck9mRYzTdpghjvZSdbvcUmfxInK6FoogSkvh+XiZp70rHc8ajlLrUSAt/cMImsHBpLbUbAXbz8537RPbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Add an optional get_private_data() callback to retrieve a private data
specific to the underlying hardware driver, e.g. pci_epc device
associated with the NTB implementation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 84908753f446..aa888219732a 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -262,6 +262,7 @@ struct ntb_mw_subrange {
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_private_data:	See ntb_get_private_data().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -338,6 +339,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	void *(*get_private_data)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -401,6 +403,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* Miscellaneous optional callbacks */
+		/* ops->get_private_data			&& */
 		1;
 }
 
@@ -1609,6 +1614,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_private_data() - get private data specific to the hardware driver
+ * @ntb:	NTB device context.
+ *
+ * Retrieve private data specific to the hardware driver.
+ *
+ * Return: Pointer to the private data if available, or %NULL otherwise.
+ */
+static inline void *ntb_get_private_data(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_private_data)
+		return NULL;
+	return ntb->ops->get_private_data(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.51.0


