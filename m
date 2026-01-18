Return-Path: <linux-kselftest+bounces-49301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E55D39703
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70AC3080470
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E455359702;
	Sun, 18 Jan 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r7TkEiAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05250356A3F;
	Sun, 18 Jan 2026 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744563; cv=fail; b=Pg0L6wwMezAOQOdxfsLsH27wIapZJgiLxAlEKkTWyDzQ8h5FOEpDXMK2ebeKayNKhAwe7orZc3tHIS2zB6zhP34vhi0l+ULxg5W3iAxONDPdb5Azkh3os0hw5HFkiYHTrn+hZI+9GDot6KwBqjxOeUkBGlaVa2A6uPi2R+8VKYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744563; c=relaxed/simple;
	bh=PliObw7ITt9wZG5z9s0riRCW6osMpW6/LUn1A8rxark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D35lN42YkoRYfLePS3VSW7mO+oJdf327hNcPgtvzeXPbT4klvUsTIG8BFvHfsdG2kuZ+WRO4Lto0qqOaCY05nDrcEsoD4j/J+4pBeZFz32jldb0hqEecjc+L73CJEbNhYZrLQKkCex1PUHn8icSgiwqk1f+kHr3K69hH2Ab0fv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r7TkEiAA; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf9FLu2/HNf0Inu4k2b1ByYr1lMo3VB1EF+GjIl4SF9CV6cJWvy27ESfNz9OH2IYSCx70vhT48ZvbbrhibXDpqkRA+duTAFv93FBOucgXsskdH3Fxg07VOG1F93RDkrllLHRR7GyLncE6Yx0DistBIb0opINTc4inpUEy2dpc3iO9sPKCMoGT1TZxjBMRvQauAopWElC6edRH0sG8n4+B8+I/sCTa2CyGWFJWvoyNxJnoVuxl3vZkSbNQh6TPb2g9TtCUB1FnADRetxFv3esQdGrcyGOAMPhOPmOo8Ct1j5q1NRvSlvaxbnlSwOQB6UF6nbxrsoM6lJIDZQikTd16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwEohNI2VgVjRtwolgshdET/NuOPsD/aCuM1nzBIp+Q=;
 b=RIPlSwdUcDYeS4wUBRSU4T9XmHOgQZWiDVTpbszcpqKF7F8CKl4qhRcLUTzjf8KKmBlC/ffrNeh5+Jyq9gULq8Ej3IWOunyZc2veIUl5Ru3/vLWhrdnfCzApwcV/stWscxZ/RDNiNkHlq98KEuCUm4Gj7lciWNvL2du5JJeS3Dv6z+Te5U3PgskMjbjMexPzFol0WGX1t0bEtjvA6Uw2PeaNBonoN37R7PIiH7p6qxj2xSLSBTSdNCIBw1Ao10DEoq2h0hn8Nx5G7U3MHOOfzUwMEUFE9kJjUpyIwgvijKUpc4Njl6huLChXEFevQBVYpTDClAvj79X0lMAcyO82SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwEohNI2VgVjRtwolgshdET/NuOPsD/aCuM1nzBIp+Q=;
 b=r7TkEiAADYdl9g1SM/BAxAiLcFfrUscThrO2xXouHNUG+O3chqax3jpaNtqvzljGjMGiUQB7yLlOIa13hp69Bja5VQdJ6LGIE/e6oCt+41NlfNqNh8xDaeuy4pITT7nex3lXU13T17pA3edT+EuaV1SgLoWqta0rThBp1ZgDfjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:48 +0000
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
Subject: [RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
Date: Sun, 18 Jan 2026 22:54:39 +0900
Message-ID: <20260118135440.1958279-38-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0075.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc5b43-04e8-4497-afa8-08de56993945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8IBbYYXjfZ6VTZMWlN8uO+mmKS/gqmybx9+JIIX5aJ/vmcaRcobK4X9NEQ6?=
 =?us-ascii?Q?b0e5XbX8bq59ZPdrOckmA6K29SUD7eldualX/Vlfw3ckh7qg8LrHVJ7B/jW5?=
 =?us-ascii?Q?5QmiQRornrRKsyNIqwz7NWPRRe/g3HnlbNMleYRaVbm3KXx1bTnkYVewgs+Q?=
 =?us-ascii?Q?WQCssFkvsQyKdFNDGmhXgeMpPlet6FeYfskVdBNgmuZdKLa6dcFomGSGHOKS?=
 =?us-ascii?Q?30jQZkAOGa5nT1sPRowYB4lpaQDOqAZTJuLHDOkHs2u2ZMX8Ry11oRHZ23t3?=
 =?us-ascii?Q?Ui0U+gg99i0yLaLVATlRVJ6VYKh93tjbBLY5aRRNlHasUULFRDFd1VAD8DKZ?=
 =?us-ascii?Q?RRe29XMogP/wNXC8y84zW35VYyEMoVy6U5OGJz2QZ3ZE9GeQqOmY6ZwU9VRK?=
 =?us-ascii?Q?a9w8FgxqboW9H4RgTvA3lFmGpR0ZQow8cOsd3f85nccaja/W7xX/HmpZpPAu?=
 =?us-ascii?Q?wDa3TJjCVrP4V6UQjSF/r9yut3MeuEb7mvHCFpxWyXaMBKotCXk/quc88XBr?=
 =?us-ascii?Q?buxVvZBY4z0zTiLd/gl0nOCMi+/nbO2pdkrCRcssN0xIknMw30U1uN6gvKFk?=
 =?us-ascii?Q?+o1uYYOmB+WC613gH87zjkXfhGyIS0sTSj6lC02s2KLZLZs3YVmYRSl8v0xM?=
 =?us-ascii?Q?+BNpptJjQAuxQskxPRg3WdIQs6pvAkXydIdZRCPdGW2iZLWFtzz+TD2sRlIp?=
 =?us-ascii?Q?5155CGtqOz0dxOJZ0S3OmKjcHMhPIusbogfshoutzPYG1Mom+mYfFusJxNv9?=
 =?us-ascii?Q?cHX4/684j5ZgAKq8fCM4W1jLj5t2MJY47sb8QIc9exR2qhUUujvyg3N43h+9?=
 =?us-ascii?Q?HCg/1PGPrdEniscQck4eVtr83DPhM5SJ9EdzZDlA1lbcVLJzkmYZsQyPNeB2?=
 =?us-ascii?Q?y3KQ/iAjy3fYTuc906hoVZV6av4gOKvOxROTrr9mECA1JY4KoOV+TMO5Rc5X?=
 =?us-ascii?Q?axPGemlQx44mpvvt0TcQOffFeA3yokgMpNKXj9eP7n8LXIxfze1SI585ZiW3?=
 =?us-ascii?Q?QfntCA1TbbscxH2+t2Agd7gkFdAVmstmoXMdc+C2k+bt2wFunRzgVRkxVZJW?=
 =?us-ascii?Q?/EiQQohknbmVfq8q/h2lt8oeQOKlhLOPWmM42Ahn0kmaaXFPqB7PrefwKtLB?=
 =?us-ascii?Q?UQ4tsU3DEx/tHAQVF/VU5+zxTZx6OBxDjzDkgVKA8bm4oFp+XrWo9hcSb/xF?=
 =?us-ascii?Q?Rs5SHSy1HfcooqwGzWCLeAPGxkn4s4iUrykmxq3GsknzB/va0mDdKWOMsgHz?=
 =?us-ascii?Q?Fc5DvSp4XuEDR6wtXOr4WYtpEuCPVGir57KWfAbAzSxsi2pCJO7b2NHIXTBu?=
 =?us-ascii?Q?9aaKzJZu6ci5mYVb0mx9Vphtu/OlMryKbW3BllzXwXtqLMy2MYWPv7I5bb3S?=
 =?us-ascii?Q?cWJ0I2nRzrituAMWP75MQsHcJyMllKhwmK0D/+utepm1SmC8AC8CyMPm24uv?=
 =?us-ascii?Q?6Xh7rCjrLFFUulUbKz5TyGQN36NyYPmhi0NTrXqPlUZadVvF6J1jRYcPORuq?=
 =?us-ascii?Q?dwvYuYDMLMZXa7zVg+kVCUc+TorpHEucyWb2ybnOjV+/CMVkq7WSd3eudXrD?=
 =?us-ascii?Q?IVt6PM2Zaia+TDNHpb6yHSzDmhN0AQ82iMEiGfQ868HBBJ9FDXrkvYr4KK0W?=
 =?us-ascii?Q?KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5z3xShoQLEx+EO4iw4mnU9NqBOArob6OqNnseORrqPR3e39U2aauML2TulJM?=
 =?us-ascii?Q?m56AdrXyQEeCVX/+Nux11bqk9CKvCH6IegtAePUVgfX0cMJYE7PxGvdBLB9K?=
 =?us-ascii?Q?xSEqx8FIQZHa6l2a6l+b7TIwzYvo7ssWgkbLIQMdqN10qg3thfClQMVLJocJ?=
 =?us-ascii?Q?z7FybpNpp/BC6gnfW/8eru+wpTevRbU3SuvH1gXZPZ0ubUJ+R8wks4pJ7qHk?=
 =?us-ascii?Q?FEGAA/4cEv8LqDrseCiPolgC20pCRO5d08wFUZmKiX3GFJCpqm9b/Jc5LEyd?=
 =?us-ascii?Q?QgPi0Uih+HX3/xPC568coAX9FYG3dajXiD6Pdzub5Na4o1qzUu1ZHU8KbaZu?=
 =?us-ascii?Q?9qKeeDcnzMvbsHfPbIjgDkLa3XYgQKc3anSsxMh2xQKIhtJg+BoEDxfjjco0?=
 =?us-ascii?Q?W6wJdhwnmZisSO72HtgfScPyhlUDGj2vljt8a0emjPwtd6WZ8oSDwECOMZ4F?=
 =?us-ascii?Q?mHuBdSiRfI69rmCN8Bmy/NFWNT/h51n2v4UFbx1etHEaD1VvxaUAQ/bBzVrI?=
 =?us-ascii?Q?VOjuev/SW9RZSjFUjLoB2/o9bzqhx5chD5iHYiqBbtnfpF84ovamW/+BG9+H?=
 =?us-ascii?Q?Jhx1Bu0zMckYdgrfDwGH5EU+gw6HmtjbJ3uc78qIhHmW0DU98W7ISUxe2uuf?=
 =?us-ascii?Q?hDL721Nv5FKghwPFY4ea7/eLa0uCqLpYfZIkaFeh1ciCfZVvJZSur+iOLle6?=
 =?us-ascii?Q?BuSARjt5XJyYucnrfUmhT141purSgrENRQguUQah5dJmhefk9a4i/k2G/fD8?=
 =?us-ascii?Q?01+m0xC6k/gUcJqy5x0UK5WcCHSuaBwAC8AVfXCaszVL/4peHznpdsj1vvJS?=
 =?us-ascii?Q?SB1mgyDhPU9P5TlSLPJeT+4L1Qs/Z+mWE9OQRVwmDrJaZvTkhKefyG6/ptJx?=
 =?us-ascii?Q?0FU199727FmTzkXzhS7fzHouKwgCaj9HmsolRGTVwFzW/I7nayJLqdSXWmin?=
 =?us-ascii?Q?RPfyNFj3AdS4GoJrC/QDLHpctoCPXd1G5OSXFrGpMv0hBRK5Pz4W7IUARdHU?=
 =?us-ascii?Q?rxRsoOhcjrzXkjUCFrgefbugRPt2Z1J1yH3K78w5S8O1QRXKfe45hwTf1iRv?=
 =?us-ascii?Q?7wo0eQv54X27iRaJbocW0jZXJbixsx1e8MamKF1cC2qv6HbnC/fQaMsra5jR?=
 =?us-ascii?Q?34M0kAZVgz+B9Srk0ZIk9mgvLVVA0D5+qd+X6wWq7VdjuoFX3z+aGyc9YpWl?=
 =?us-ascii?Q?zEh+rfA1ObcB//d1t1U/Azv6/PhoGIT92vybsBoW3/O1UD6AK2lbKp6iYeUD?=
 =?us-ascii?Q?QIGQSp/bummSmgfH3/oaBAzDB6vSgnL4ApxGDY82n3lQ0irT5f8QqEByEah7?=
 =?us-ascii?Q?X4oavOBzHbO+H9X+fXN9HK5/lXZnUoNbLx+8X3cyhlZIjfofI869FzK9I/bw?=
 =?us-ascii?Q?5NoyaISyaGc25iFWFUd4FVqs+K7SN2mF3yPw7ILc0boyZ6tweQCGIxpwdZGS?=
 =?us-ascii?Q?AwDnxgMpP6eJmvkSp5I1jV7GRbjavXAqf/QOxGJGLxGWVI92Cb0ZmFzaCB1j?=
 =?us-ascii?Q?e4pY750J6WE5OG4/31VOOe1wazRpImLWrFrW1v7Hep980QIBxycQdQEdtSyA?=
 =?us-ascii?Q?Uq0/q46vemgP1J7tc0p3xg9NPrIXXSu/W71CSwwB3J18b26f+9a1NT5zuLa9?=
 =?us-ascii?Q?ZmLB7cwdBA/QVWDWBtH5cBvlSKWdzmahnfpmyIceTKSxEP8wFFvLXZOY2LwO?=
 =?us-ascii?Q?Pl0iODmC4Np196T2QvNwTv/K4muHgOGQSbRsPlXbJROl6vi482P72jqbNz4f?=
 =?us-ascii?Q?fbDW94ZreVgmi/0PTr7kgcP4LBscSjes73F3XTqT1VXKtU4j1+FV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc5b43-04e8-4497-afa8-08de56993945
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:22.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JBvEHVNqqmPLMrHGFCL2XJEruwKlFpKPQYIw94jOzbhFBO+6yJf1akBdItZjhqY5quhe+QAtdGlfn5T1LcGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Add a new test mode controlled by a flag, PCITEST_FLAGS_USE_REMOTE_EDMA.
When requested, the driver:
- Issues COMMAND_REMOTE_EDMA_SETUP to the endpoint and locates the BAR
  containing a pcitest_edma_info header (magic/version).
- Creates a remote dw-edma instance by ioremapping the endpoint's
  exposed eDMA registers and linked-list regions and probing dw-edma on
  top of it.
- Requests one DMA_SLAVE channel per direction and performs the
  transfer.
- Uses COMMAND_REMOTE_EDMA_CHECKSUM to validate the result when the
  transfer direction is host-to-endpoint. For the opposite direction,
  the endpoint provides the expected checksum up front.

One MSI/MSI-X vector is reserved for the remote dw-edma instance by
freeing the last test IRQ vector. This keeps existing MSI/MSI-X tests
unchanged unless the remote-eDMA mode is invoked.

BAR read/write tests skip the BAR reserved for remote-eDMA metadata to
avoid corrupting the eDMA window.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 633 +++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |   3 +-
 2 files changed, 635 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1c0fd185114f..52d700374ac6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -8,7 +8,10 @@
 
 #include <linux/crc32.h>
 #include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -17,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pci.h>
@@ -39,6 +43,8 @@
 #define COMMAND_COPY				BIT(5)
 #define COMMAND_ENABLE_DOORBELL			BIT(6)
 #define COMMAND_DISABLE_DOORBELL		BIT(7)
+#define COMMAND_REMOTE_EDMA_SETUP		BIT(8)
+#define COMMAND_REMOTE_EDMA_CHECKSUM		BIT(9)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -55,6 +61,10 @@
 #define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
 #define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
 #define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
+#define STATUS_REMOTE_EDMA_SETUP_SUCCESS	BIT(14)
+#define STATUS_REMOTE_EDMA_SETUP_FAIL		BIT(15)
+#define STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS	BIT(16)
+#define STATUS_REMOTE_EDMA_CHECKSUM_FAIL	BIT(17)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -130,6 +140,9 @@ struct pci_endpoint_test {
 	size_t alignment;
 	u32 ep_caps;
 	const char *name;
+
+	/* For extended tests that rely on vendor-specific features */
+	void *data;
 };
 
 struct pci_endpoint_test_data {
@@ -149,6 +162,610 @@ static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
 	writel(value, test->base + offset);
 }
 
+static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id);
+
+#if IS_REACHABLE(CONFIG_DW_EDMA)
+#include <linux/dma/edma.h>
+
+#define PCITEST_EDMA_INFO_MAGIC		0x414d4445U /* 'EDMA' */
+#define PCITEST_EDMA_INFO_VERSION	0x00010000U
+
+struct pci_endpoint_test_edma {
+	bool			probed;
+	void __iomem		*bar_base;
+	int			irq;
+
+	/* Remote dw-edma instance */
+	struct dw_edma_chip	chip;
+
+	/* One channel per direction */
+	struct dma_chan		*m2d;
+	struct dma_chan		*d2m;
+};
+
+struct pcitest_edma_info {
+	__le32 magic;
+	__le32 version;
+
+	__le32 reg_off;
+	__le32 reg_size;
+
+	__le64 ll_rd_phys;
+	__le32 ll_rd_off;
+	__le32 ll_rd_size;
+
+	__le64 ll_wr_phys;
+	__le32 ll_wr_off;
+	__le32 ll_wr_size;
+
+	__le64 test_buf_phys;
+	__le32 test_buf_size;
+};
+
+struct pci_endpoint_test_edma_filter {
+	struct device *dma_dev;
+	unsigned long direction;
+};
+
+static bool test_edma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct pci_endpoint_test_edma_filter *filter = param;
+	u32 dir = filter->direction;
+	struct dma_slave_caps caps;
+	int ret;
+
+	if (chan->device->dev != filter->dma_dev)
+		return false;
+
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		return false;
+
+	return !!(caps.directions & dir);
+}
+
+static int pci_endpoint_test_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
+	struct pci_endpoint_test_edma *edma;
+
+	if (!test)
+		return -EINVAL;
+
+	edma = test->data;
+	if (!edma)
+		return -EINVAL;
+
+	/*
+	 * Only one vector is reserved for remote eDMA use, thus 'nr' is
+	 * ignored. See pci_endpoint_test_edma_reserve_irq().
+	 */
+	return pci_irq_vector(pdev, edma->irq);
+}
+
+static enum pci_barno pci_endpoint_test_edma_bar(struct pci_dev *pdev)
+{
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		void __iomem *base;
+		u32 magic;
+
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		if (!pci_resource_len(pdev, bar))
+			continue;
+
+		base = pci_iomap_range(pdev, bar, 0, sizeof(u32));
+		if (!base)
+			continue;
+
+		magic = ioread32(base);
+		pci_iounmap(pdev, base);
+
+		if (magic == PCITEST_EDMA_INFO_MAGIC)
+			return bar;
+	}
+	return NO_BAR;
+}
+
+static bool pci_endpoint_test_bar_is_reserved(struct pci_endpoint_test *test,
+					      enum pci_barno barno)
+{
+	struct pci_dev *pdev = test->pdev;
+	enum pci_barno edma_bar = pci_endpoint_test_edma_bar(pdev);
+
+	return barno == NO_BAR || barno == edma_bar;
+}
+
+static void pci_endpoint_test_dw_edma_cleanup(struct pci_endpoint_test *test,
+					      struct pci_endpoint_test_edma *edma)
+{
+	if (!edma)
+		return;
+
+	if (edma->m2d) {
+		dmaengine_terminate_sync(edma->m2d);
+		dma_release_channel(edma->m2d);
+		edma->m2d = NULL;
+	}
+
+	if (edma->d2m) {
+		dmaengine_terminate_sync(edma->d2m);
+		dma_release_channel(edma->d2m);
+		edma->d2m = NULL;
+	}
+
+	if (edma->probed) {
+		dw_edma_remove(&edma->chip);
+		edma->probed = false;
+	}
+
+	if (edma->bar_base) {
+		pci_iounmap(test->pdev, edma->bar_base);
+		edma->bar_base = NULL;
+	}
+}
+
+static void pci_endpoint_test_remote_edma_teardown(struct pci_endpoint_test *test)
+{
+	struct pci_endpoint_test_edma *edma = test->data;
+
+	pci_endpoint_test_dw_edma_cleanup(test, edma);
+	kfree(edma);
+	test->data = NULL;
+}
+
+/*
+ * Reserve exactly one IRQ vector for dw-edma by freeing the last handler.
+ * This avoids changing existing MSI/MSI-X tests unless remote eDMA is used.
+ */
+static int pci_endpoint_test_edma_reserve_irq(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+
+	if (test->irq_type != PCITEST_IRQ_TYPE_MSI &&
+	    test->irq_type != PCITEST_IRQ_TYPE_MSIX)
+		return -EOPNOTSUPP;
+
+	if (test->num_irqs < 2)
+		return -ENOSPC;
+
+	/* use the last vector for remote eDMA use */
+	free_irq(pci_irq_vector(pdev, test->num_irqs - 1), test);
+	return test->num_irqs - 1;
+}
+
+static void pci_endpoint_test_edma_restore_irq(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	int ret;
+
+	ret = request_irq(pci_irq_vector(pdev, test->num_irqs - 1),
+			  pci_endpoint_test_irqhandler, IRQF_SHARED, test->name,
+			  test);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "failed to restore IRQ vector %d after remote eDMA: %d\n",
+			 test->num_irqs - 1, ret);
+}
+
+static const struct dw_edma_plat_ops test_edma_ops = {
+	.irq_vector     = pci_endpoint_test_edma_irq_vector,
+};
+
+static int pci_endpoint_test_dw_edma_setup(struct pci_endpoint_test *test)
+{
+	struct pci_endpoint_test_edma *edma = test->data;
+	struct pci_endpoint_test_edma_filter f;
+	struct pci_endpoint_test_edma *new;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	struct pcitest_edma_info info;
+	resource_size_t bar_size;
+	u32 ll_rd_off, ll_rd_size;
+	u32 ll_wr_off, ll_wr_size;
+	u32 reg_off, reg_size;
+	dma_cap_mask_t mask;
+	enum pci_barno bar;
+	int ret;
+
+	if (edma && edma->probed)
+		return 0;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	ret = pci_endpoint_test_edma_reserve_irq(test);
+	if (ret < 0)
+		goto err_free;
+	new->irq = ret;
+
+	bar = pci_endpoint_test_edma_bar(pdev);
+	if (bar == NO_BAR) {
+		ret = -EOPNOTSUPP;
+		goto err_restore_irq;
+	}
+
+	new->bar_base = pci_iomap(pdev, bar, 0);
+	if (!new->bar_base) {
+		ret = -ENOMEM;
+		goto err_restore_irq;
+	}
+	bar_size = pci_resource_len(pdev, bar);
+
+	/* Snapshot the info (avoid repeated __iomem reads). */
+	memcpy_fromio(&info, new->bar_base, sizeof(info));
+	if (le32_to_cpu(info.magic) != PCITEST_EDMA_INFO_MAGIC ||
+	    le32_to_cpu(info.version) != PCITEST_EDMA_INFO_VERSION) {
+		dev_err(&pdev->dev, "Invalid eDMA info\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+
+	reg_off = le32_to_cpu(info.reg_off);
+	reg_size = le32_to_cpu(info.reg_size);
+	ll_rd_off = le32_to_cpu(info.ll_rd_off);
+	ll_rd_size = le32_to_cpu(info.ll_rd_size);
+	ll_wr_off = le32_to_cpu(info.ll_wr_off);
+	ll_wr_size = le32_to_cpu(info.ll_wr_size);
+
+	if (reg_off > bar_size || reg_size > bar_size - reg_off ||
+	    ll_rd_off > bar_size || ll_rd_size > bar_size - ll_rd_off ||
+	    ll_wr_off > bar_size || ll_wr_size > bar_size - ll_wr_off) {
+		dev_err(&pdev->dev, "eDMA info offsets out of BAR range\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+
+	memset(&new->chip, 0, sizeof(new->chip));
+	new->chip.dev = &pdev->dev;
+	new->chip.mf = EDMA_MF_EDMA_UNROLL;
+	new->chip.nr_irqs = 1;
+	new->chip.ops = &test_edma_ops;
+	new->chip.reg_base = new->bar_base + reg_off;
+	new->chip.ll_rd_cnt = 1;
+	new->chip.ll_region_rd[0].paddr = le64_to_cpu(info.ll_rd_phys);
+	new->chip.ll_region_rd[0].vaddr.io = new->bar_base + ll_rd_off;
+	new->chip.ll_region_rd[0].sz = ll_rd_size;
+	new->chip.ll_wr_cnt = 1;
+	new->chip.ll_region_wr[0].paddr = le64_to_cpu(info.ll_wr_phys);
+	new->chip.ll_region_wr[0].vaddr.io = new->bar_base + ll_wr_off;
+	new->chip.ll_region_wr[0].sz = ll_wr_size;
+
+	test->data = new;
+	ret = dw_edma_probe(&new->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to probe eDMA: %d\n", ret);
+		goto err_cleanup;
+	}
+	new->probed = true;
+
+	/* Request one channel per direction. */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	f.dma_dev = dev;
+	f.direction = BIT(DMA_MEM_TO_DEV);
+	new->m2d = dma_request_channel(mask, test_edma_filter_fn, &f);
+	f.direction = BIT(DMA_DEV_TO_MEM);
+	new->d2m = dma_request_channel(mask, test_edma_filter_fn, &f);
+	if (!new->m2d || !new->d2m) {
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+
+	/*
+	 * Best-effort attempt, ie. even if it fails for some reason, the
+	 * endpoint will ignore endpoint-local interrupts (edma_int bus).
+	 */
+	dw_edma_chan_irq_config(new->m2d, DW_EDMA_CH_IRQ_REMOTE);
+	dw_edma_chan_irq_config(new->d2m, DW_EDMA_CH_IRQ_REMOTE);
+
+	return 0;
+err_cleanup:
+	pci_endpoint_test_dw_edma_cleanup(test, new);
+err_restore_irq:
+	pci_endpoint_test_edma_restore_irq(test);
+err_free:
+	kfree(new);
+	test->data = NULL;
+	return ret;
+}
+
+static int pci_endpoint_test_remote_edma_setup(struct pci_endpoint_test *test,
+					       size_t size)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	unsigned long left;
+	u32 status;
+
+	/* Same rule as existing tests: IRQ type must be configured first */
+	if (test->irq_type != PCITEST_IRQ_TYPE_MSI &&
+	    test->irq_type != PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type for remote eDMA\n");
+		return -EINVAL;
+	}
+
+	/* Need one spare vector for dw-edma */
+	if (test->num_irqs < 2)
+		return -ENOSPC;
+
+	/*
+	 * Ensure EP command handler won't reject us due to stale flags.
+	 * (remote-eDMA setup itself is not "FLAG_USE_DMA")
+	 */
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, 0);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 test->irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_REMOTE_EDMA_SETUP);
+
+	left = wait_for_completion_timeout(&test->irq_raised,
+					   msecs_to_jiffies(1000));
+	if (!left)
+		return -ETIMEDOUT;
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_REMOTE_EDMA_SETUP_FAIL) {
+		dev_err(dev, "Endpoint failed to setup remote eDMA window\n");
+		return -EIO;
+	}
+	if (!(status & STATUS_REMOTE_EDMA_SETUP_SUCCESS)) {
+		dev_err(dev,
+			"Endpoint did not report remote eDMA setup success\n");
+		return -EIO;
+	}
+
+	return pci_endpoint_test_dw_edma_setup(test);
+}
+
+static int pci_endpoint_test_edma_xfer(struct pci_dev *pdev,
+				       struct pci_endpoint_test_edma *edma,
+				       void *buf, size_t len,
+				       dma_addr_t dev_addr,
+				       enum dma_transfer_direction dir)
+{
+	struct dma_async_tx_descriptor *tx;
+	enum dma_data_direction map_dir;
+	struct device *dev = &pdev->dev;
+	struct dma_slave_config cfg;
+	struct completion done;
+	struct dma_chan *chan;
+	struct scatterlist sg;
+	dma_cookie_t cookie;
+	int ret;
+
+	memset(&cfg, 0, sizeof(cfg));
+	if (dir == DMA_MEM_TO_DEV) {
+		chan = edma->m2d;
+		map_dir = DMA_TO_DEVICE;
+		cfg.direction = DMA_MEM_TO_DEV;
+		cfg.dst_addr = dev_addr;
+	} else if (dir == DMA_DEV_TO_MEM) {
+		chan = edma->d2m;
+		map_dir = DMA_FROM_DEVICE;
+		cfg.direction = DMA_DEV_TO_MEM;
+		cfg.src_addr = dev_addr;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		return ret;
+
+	sg_init_one(&sg, buf, len);
+	if (!dma_map_sg(dev, &sg, 1, map_dir)) {
+		dev_err(dev, "unable to map local address\n");
+		return -EIO;
+	}
+
+	tx = dmaengine_prep_slave_sg(chan, &sg, 1, dir,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx) {
+		dev_err(dev, "failed to prepare slave for sg\n");
+		ret = -EIO;
+		goto unmap;
+	}
+
+	init_completion(&done);
+	tx->callback = (dma_async_tx_callback)complete;
+	tx->callback_param = &done;
+
+	cookie = dmaengine_submit(tx);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "remote eDMA submission error: %d\n", ret);
+		goto unmap;
+	}
+
+	dma_async_issue_pending(chan);
+
+	if (!wait_for_completion_timeout(&done, msecs_to_jiffies(5000))) {
+		dev_err(dev, "remote eDMA transfer timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+		goto unmap;
+	}
+
+	ret = 0;
+unmap:
+	dma_unmap_sg(dev, &sg, 1, map_dir);
+	return ret;
+}
+
+static int pci_endpoint_test_edma_write(struct pci_endpoint_test *test,
+					size_t size)
+{
+	struct pci_endpoint_test_edma *edma;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	struct pcitest_edma_info info;
+	u32 reg, crc32, peer_crc32;
+	unsigned long left;
+	int ret;
+
+	/*
+	 * Note that test->alignment does not apply here. If some vendor
+	 * dmaengine for remote use may impose some alignment restriction, we
+	 * may as well introduce another field such as
+	 * test->remote_dma_alignment.
+	 */
+	void *orig_addr __free(kfree) = kzalloc(size, GFP_KERNEL);
+	if (!orig_addr)
+		return -ENOMEM;
+
+	ret = pci_endpoint_test_remote_edma_setup(test, size);
+	if (ret)
+		return ret;
+
+	edma = test->data;
+	if (!edma) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	get_random_bytes(orig_addr, size);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	memcpy_fromio(&info, edma->bar_base, sizeof(info));
+	if (le32_to_cpu(info.test_buf_size) < size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = pci_endpoint_test_edma_xfer(test->pdev, edma, orig_addr, size,
+					  le64_to_cpu(info.test_buf_phys),
+					  DMA_MEM_TO_DEV);
+	if (ret) {
+		dev_err(dev, "pci_endpoint_test_edma_xfer error: %d\n", ret);
+		goto err;
+	}
+
+	reinit_completion(&test->irq_raised);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_REMOTE_EDMA_CHECKSUM);
+
+	left = wait_for_completion_timeout(&test->irq_raised,
+					   msecs_to_jiffies(1000));
+
+	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!left || !(reg & STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS)) {
+		dev_err(dev, "Failed to get checksum\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	crc32 = crc32_le(~0, orig_addr, size);
+	peer_crc32 = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
+	if (crc32 != peer_crc32) {
+		dev_err(dev,
+			"Checksum mismatch: %#x vs %#x\n", crc32, peer_crc32);
+		ret = -EINVAL;
+	}
+err:
+	pci_endpoint_test_remote_edma_teardown(test);
+	pci_endpoint_test_edma_restore_irq(test);
+	return ret;
+}
+
+static int pci_endpoint_test_edma_read(struct pci_endpoint_test *test,
+				       size_t size)
+{
+	struct pci_endpoint_test_edma *edma;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	struct pcitest_edma_info info;
+	u32 crc32, peer_crc32;
+	int ret;
+
+	/*
+	 * Note that test->alignment does not apply here. If some vendor
+	 * dmaengine for remote use may impose some alignment restriction, we
+	 * may as well introduce another field such as
+	 * test->remote_dma_alignment.
+	 */
+	void *orig_addr __free(kfree) = kzalloc(size, GFP_KERNEL);
+	if (!orig_addr)
+		return -ENOMEM;
+
+	ret = pci_endpoint_test_remote_edma_setup(test, size);
+	if (ret)
+		return ret;
+
+	peer_crc32 = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
+
+	edma = test->data;
+	if (!edma) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	memcpy_fromio(&info, edma->bar_base, sizeof(info));
+	if (le32_to_cpu(info.test_buf_size) < size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = pci_endpoint_test_edma_xfer(test->pdev, edma, orig_addr, size,
+					  le64_to_cpu(info.test_buf_phys),
+					  DMA_DEV_TO_MEM);
+	if (ret) {
+		dev_err(dev, "pci_endpoint_test_edma_xfer error: %d\n", ret);
+		goto err;
+	}
+
+	crc32 = crc32_le(~0, orig_addr, size);
+	if (crc32 != peer_crc32) {
+		dev_err(dev,
+			"Checksum mismatch: %#x vs %#x\n", crc32, peer_crc32);
+		ret = -EINVAL;
+	}
+err:
+	pci_endpoint_test_remote_edma_teardown(test);
+	pci_endpoint_test_edma_restore_irq(test);
+	return ret;
+}
+#else
+static bool pci_endpoint_test_bar_is_reserved(struct pci_endpoint_test *test,
+					      enum pci_barno barno)
+{
+	return 0;
+}
+
+static void pci_endpoint_test_remote_edma_teardown(struct pci_endpoint_test *test)
+{
+}
+
+static int pci_endpoint_test_edma_write(struct pci_endpoint_test *test,
+					size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int pci_endpoint_test_edma_read(struct pci_endpoint_test *test,
+				       size_t size)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 {
 	struct pci_endpoint_test *test = dev_id;
@@ -307,6 +924,9 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (barno == test->test_reg_bar)
 		bar_size = 0x4;
 
+	if (pci_endpoint_test_bar_is_reserved(test, barno))
+		return -EOPNOTSUPP;
+
 	/*
 	 * Allocate a buffer of max size 1MB, and reuse that buffer while
 	 * iterating over the whole BAR size (which might be much larger).
@@ -354,6 +974,9 @@ static void pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
 	if (barno == test->test_reg_bar)
 		size = 0x4;
 
+	if (pci_endpoint_test_bar_is_reserved(test, barno))
+		return;
+
 	for (j = 0; j < size; j += 4)
 		writel_relaxed(bar_test_pattern_with_offset(barno, j),
 			       test->bar[barno] + j);
@@ -372,6 +995,9 @@ static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
 	if (barno == test->test_reg_bar)
 		size = 0x4;
 
+	if (pci_endpoint_test_bar_is_reserved(test, barno))
+		return 0;
+
 	for (j = 0; j < size; j += 4) {
 		u32 expected = bar_test_pattern_with_offset(barno, j);
 
@@ -645,6 +1271,9 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 
 	size = param.size;
 
+	if (param.flags & PCITEST_FLAGS_USE_REMOTE_EDMA)
+		return pci_endpoint_test_edma_write(test, size);
+
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
@@ -742,6 +1371,9 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 
 	size = param.size;
 
+	if (param.flags & PCITEST_FLAGS_USE_REMOTE_EDMA)
+		return pci_endpoint_test_edma_read(test, size);
+
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
@@ -1139,6 +1771,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_remote_edma_teardown(test);
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
 
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d6023a45a9d0..c72d999cecf7 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -30,7 +30,8 @@
 #define PCITEST_IRQ_TYPE_MSIX		2
 #define PCITEST_IRQ_TYPE_AUTO		3
 
-#define PCITEST_FLAGS_USE_DMA	0x00000001
+#define PCITEST_FLAGS_USE_DMA		0x00000001
+#define PCITEST_FLAGS_USE_REMOTE_EDMA	0x00000002
 
 struct pci_endpoint_test_xfer_param {
 	unsigned long size;
-- 
2.51.0


