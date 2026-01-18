Return-Path: <linux-kselftest+bounces-49298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601ED39646
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05EB2300E4E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759F3570B7;
	Sun, 18 Jan 2026 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OzgBPjOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810134B410;
	Sun, 18 Jan 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744559; cv=fail; b=njAktPBacXEyuWqg65AZMHTjrhGLgWKeTm6IeKsCxSsyQk+rJFmQEVO7WxGLNaijx9RKZFNiBZsuhPdgVCINtKVKhzDvkJmPwXPm1HZ75Xi8J6FNPcTKuWNbCyLfURliSpPf3/BDTPXSw8vGMetYEPsumzbErtyB+t2LJlUmW74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744559; c=relaxed/simple;
	bh=XTAf4moWA3ONm/EDufGRoCTADoj36/C2rHn7GqSZFJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+gKe3ElP2ZrJc42hdb8SCyl8fqtRm8r2WlfFXJeqpNLXw8Y2GQ2qFhGb/ns+VnMXwYjWZzbSIHt6feXMJxrezSuB9vcrBTjw/iN3pgdHrXVIIHXI5LNFa8ODr38NWURtc6Q2dOuw7jpUl5AEq+SI/L6oGwTL6va49ap4zAQtS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OzgBPjOP; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNCq1pdam+LHf1AftWZW8Aj66FXgVaWvisDPSdmj1Tzuwv2gRzpdZ2ymcNQ2p0V4tnociVUztdCDe0ZekWU0/EJAqX39lFxcPsr3hqtdl26eTiiEihHBgj4XQfJ71bE/SCYWV0oZkEE6jv9XINqLa32II2yNeniq22PkCw6M75vuwFus/TxWf1ImvUGXtLu0GddMaGThTsga+WmloCKBwfuYJlW1Pe8nKiPrKtWGrSUlHDvRDIDYZI4YYiAVsGs0vDqUFGU4+C+8ONPu0V7EeZcjidIEee0LlQ2JBJbDSipE3XVpe8NiGisg+xrDxgC4KN2uMyG35c14am+TFcbtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqZ4zFSJKcS2aXV8+pNLIdL+h0NJNfQfOFRYdRf/uRY=;
 b=JnTwzg9xYTp+TF05yx7IwV7O/N8Gf6oK7KkLX84KZvi9urEeSD5WautCsD/a/ir1ihvTimK2bu5iQZOCoX161wprnm4V7paHf/AW7i5u1SipYTjgrC/LF/LDiel0mRT3j7xgmicV1pDPncJx4/XT6XY65XeYtOUYzBPljCgKxBmm4MTReq6xq8zI0tJXACUtHIqlKP1Z/blhk2zCbrXfwqv9cmi58Avnm+/LmrflysppTq4XaBx+uW6q1V6A1EJIyL7lUfrQ218iFuParMVl+GoKMari+Om0ZZHaoPb+L3pWuEi7tTlfEtJqZbDN4ObboVggs/vQDixGwyUXfGI2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqZ4zFSJKcS2aXV8+pNLIdL+h0NJNfQfOFRYdRf/uRY=;
 b=OzgBPjOPjSiwS5I5P25maVfU1Z1r5X3hWfFQCtFs52oeZH+WiINdt2KqC7sLEwKzdmquZru43k900q0XPRg3f+XgUDUP8YASkzRx4QamOsP5JUTufmVyfIdf4/6RXP3xebyXceeJTxidgmj7n+WpqQ2r6Y5PmWhptsXB2t7Vd9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:47 +0000
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
Subject: [RFC PATCH v4 34/38] Documentation: driver-api: ntb: Document remote embedded-DMA transport
Date: Sun, 18 Jan 2026 22:54:36 +0900
Message-ID: <20260118135440.1958279-35-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f1054a-752a-46d9-9455-08de569937ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXqGKxjr0Rmd020EU3Vb7auqyUc3JS5JqRAZ6nbdBH8M4CPBJ8dDp+zacGUq?=
 =?us-ascii?Q?/GyyOix2QPej7YOaPrRkXzLuZANmfnyBM8Cy6KSdrCGgR+l2wklmjqlG8rzt?=
 =?us-ascii?Q?ZkjUgP18JmY3atGKzEi+T9xmR/OMkPwj1le+nl+ntkR0juLOo4Zix/Fufmst?=
 =?us-ascii?Q?h1sdiCEy7YNvErJP9rdy+MbqsQP95SFUIHRmVCT9pyqdGQ6DoC2u2BXi7aev?=
 =?us-ascii?Q?M5jIK34MQjN1zSvhHwLFWGvcWePaTyKn6wjJ0vBSzjR5UJbq4JXcjv60GDNe?=
 =?us-ascii?Q?AQw9R1UrG2lQHJgaz795pAd68ojLW4qlXDDqSxixNk7zMz7V0R1+7+QMijmt?=
 =?us-ascii?Q?VnuYdEOuqg20PenDzVeX0XnCKuIcpUZEyqgd7sziNnyRsprignyiChh0hr6d?=
 =?us-ascii?Q?BH5+yM4lYsyR/5Me4HwXIYEZ6QAZ8xCPGE42QFjjJiR1jKjfwr0pMoOfK4VQ?=
 =?us-ascii?Q?vYsIW7d9gIhrM0jXRlf+eEFtoHvFkZNTHOuI+XgYmzUM3KQhKxtcfAHCVCq3?=
 =?us-ascii?Q?e8c/R9vorBV7UPI3psHEFZrWNi0OAyV/UMZsyHMAbRgyqlepFkYJFOHRSL4g?=
 =?us-ascii?Q?C4FYtnDVsox3KIKrqxTYxgQL9bFK3MIyjMmMD7NRKO8nTY5y9VFThw/zoNXf?=
 =?us-ascii?Q?BXIf+B75JWrlN5K5TSCgKk7gc5VngcWHUsJhCgv/9aWQTK39H338gVGNsZio?=
 =?us-ascii?Q?4TrIeIlXEn1hLENi09foF3OvinJBz3wZXi8RJM88zDXB50FWslSbsgJAmq5v?=
 =?us-ascii?Q?ZFaZBAN1wOK9klNqtKwLUWOH3TYcf5E7O20r23rGnxIBebjIjCM3Brt5b5bD?=
 =?us-ascii?Q?9cjElvZrdyqWq6S+GsJDSNplHy60K4OchHTf4BZMPbDBrrnvpuMVPxR4Finy?=
 =?us-ascii?Q?lkASub9YDwziFDaXrGjC9yB1IRLBDDDeILLTx0qnGV5R/2+j6dXIfoGs1+dt?=
 =?us-ascii?Q?7srBahSt81KjW8zKxzwzh3j5c8P3rc1J6sySXe8ktRKokMM0kwv+qBpoDmhu?=
 =?us-ascii?Q?KYYgOes6kHuUIiEqei62iXaXAGkaJEaltgVhD/IdAxF1fGk9zZiBnRUSIWZm?=
 =?us-ascii?Q?79XyySll6OqemtQUlhbRbCwE9089m3zqDpXUJhVu58j5BtalO9z6AmR8AtQO?=
 =?us-ascii?Q?AAAjdaMzSYRi8qIVLG293FT7ufIlMOuf0Q5I8JAoBADIqmPd47635r1WVEyz?=
 =?us-ascii?Q?KL4KwB4MIoExhkf1OEdY457YJf11u3X06so5S111iCTH+mLpeMyBefk6bNnY?=
 =?us-ascii?Q?gfRfmeB8bbg/I1V7TuWwlS9ZMMilrm43eA6gHt9v+ViJ3+ydphHfROju2c+r?=
 =?us-ascii?Q?MMk0Xf9hSccgKBIwDdGt/sBvykf8dbii2BbMBQeKx1WTaQeLkL6+bai1wbRR?=
 =?us-ascii?Q?jKE8U2uIZL0ewLZPqjEloLscBqlDE9w45pMAZxrJh/6F8ckL8ZXoA0RlNcwu?=
 =?us-ascii?Q?Z0Q5ySVLQG9dW6XYJJdU/c0cwSmjwFgCHoErhBzu6NFDQEk2PGUFcf5zlJGE?=
 =?us-ascii?Q?VgCjj/rDMgfJ/5EUFB6BD7dmZdghQrVvmGPU1Feor+NRaK2h3dW74k+Lq6pu?=
 =?us-ascii?Q?UKSqZ4kg51b2wroEfJmc0+W01mg7NXUdRODXFTeSmA+jp0HFMxxiAxrbtwWA?=
 =?us-ascii?Q?pQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?haAFqZSMRVt8o5akNoJC8cMTex1qT3ISt2aONoyA+fat1LvuDm3lav63KHPP?=
 =?us-ascii?Q?OWCZKR1gjUxorufT89PIuanIxoe/CRulUoWd0j6OMTL4YlRok7YwYlKFbyW7?=
 =?us-ascii?Q?NsGTQsvhgHYKfXx/2qH7MTQcG9+Irwo50wFI3TFZ47+wuah7p7zcG9dljVNW?=
 =?us-ascii?Q?UgtZvuKihYXOvpHAB4vsZGExrEbmgXOdenGLNA/kTXWfImkpOsxZjMyCUPRR?=
 =?us-ascii?Q?7MDa0De2hwVE8gYo3AhPOhzu3OTM7FlokP86Jg4OazRc4TVpN/je9VSJZW9V?=
 =?us-ascii?Q?8PBjBiVdJ0n0FoE7i8KkuFhWG2nuN3gXK16Kgvcg8JirFniyzzXOC/K8lMlo?=
 =?us-ascii?Q?RlhQrilr3eDceJSV3HT3hfW5MzEWYbToooK5Rf7/SC4bKvTN6GTGw9lNVPX+?=
 =?us-ascii?Q?aS0u5B+acv0Uh2RvKB8g6febI6tsqielPpV0IHU0W6bVAVBXVTRH0jUWyWKU?=
 =?us-ascii?Q?Y5GPO2W9mCNDvefYEhKymUFs1AAb/c4j4dK1VK/YzQatZy+WyjFHRcoF6G+4?=
 =?us-ascii?Q?e4ZPdHHZx02zllinhwi8ez+LwaOJ6317y66Re4CkLd1VyMTt0MvPPa/6Bfdy?=
 =?us-ascii?Q?O7cRXp3Y4ZITpaagQcciqvYbwwhN+XOyDZi1co2IBYMaaSWrsY0vUfz6kg+B?=
 =?us-ascii?Q?pb6qA69Xq83VLlNW783m3LV/RjZ9UPfRUSG1Oo9g5IAgIRqddt9ZhWsWH7Lx?=
 =?us-ascii?Q?BY0UdSur9sS5TSNV9hESQdOCpALVJwiSnoGr4/kvVUZr6sfJz+jmdctYC1xO?=
 =?us-ascii?Q?FEKwgr9PdD/jKoISduOe2voaow4IdYgpsSQNBQ6J0mhM8NVHC0IbezxyxI6X?=
 =?us-ascii?Q?wrIdCgNjliUVYmmcyKf7KaEQp711PTSVHK+BewzB6ieWeq3lhBuRLFcqSzbJ?=
 =?us-ascii?Q?wJnFWVLvfMQoUzBnI7FZECcPIiwo4wyq39vo9jAHrA+neYWtuWxE8qY53ylo?=
 =?us-ascii?Q?H3ldsD/K4A2uqPHULh2c3W4Hpfl31S3qHVzegfPbBfroqgo+D5m0vuXJtRE3?=
 =?us-ascii?Q?rwT/jnG7rqeauhoa2aG7U2xGzz/6HZTUyyqnoFOAjGNULBkVqHC1cbCkQRxI?=
 =?us-ascii?Q?SKV9bnYKxHtuH1rRSeFmlqb/sTlsbK/ouidbjAA1oufW/iFnDuU/fIuF3yfn?=
 =?us-ascii?Q?AVguaPpahMRr3eeT5zmaP3N9b5piLmEA81UALZmow/XJ6Ir+gaMysmmvs3Vf?=
 =?us-ascii?Q?rCbsYg5eSfxpBenqx5j2GiKPuElVJesr66G3aPjMhXB1KJYkD6EiwJPhwicM?=
 =?us-ascii?Q?f1sRuvaWPXxd4CbpSfqw7e0fcZ4jJcxCtNYXv73X3D/OjCjUscz5n/VGxunU?=
 =?us-ascii?Q?HXa2fYXegtwyLVRJfokCCvXRwTekwlfIykKoijSTmheBnr+tju357dBIq+o2?=
 =?us-ascii?Q?6cSPsGQQJcRVwRURrZipUw6+Kv5V/50kSQNL6rTv9AqBw1HPmkTSrRhXDmhD?=
 =?us-ascii?Q?IvON2tq8C38o/YFPulUwgwHVnoQvDstIICB80OnJMNJUSLcpd2Swa6fJ1KqS?=
 =?us-ascii?Q?sQlIVL/R5q6ijY1KCH583frRh8qgmHAAZImqWNaFm4JE+1Q3viypJ5V6hYAP?=
 =?us-ascii?Q?YL4diPGSFh5KtEzNDTtO0PPVzbkSwHZIqCn8LCq/2VfY7cbLi/wEdJlxQ2qZ?=
 =?us-ascii?Q?PR87jJPxs3SQ3wBDy744xIthCRpYyjipOnU+pxHSl7GvvDh68HlrVsBOefE5?=
 =?us-ascii?Q?CXzwMWDrY/8Q3E8alga4zxeMQ8JSWqKlF5qrLnOqU1z/d0c3F3c6vcPBPZ/d?=
 =?us-ascii?Q?KW46VMIOQpfIAl22+BiFzQuIUttaMDgXd1C6/cbIUcyzDXWqL6Y1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f1054a-752a-46d9-9455-08de569937ec
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:20.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4FBSxwPGhr5uUoKfLDvcmlIOX18bS55Rnbw8q/DOzsi+vo3AZiYKgfW4O/fwQbCOc0/pffOD7urbAhmOlPC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

The NTB transport code is split into a common library
(ntb_transport_core) and NTB client modules.

Document the two transport variants:
- ntb_transport: legacy shared-memory rings (CPU/local DMA memcpy)
- ntb_transport_edma: remote embedded-DMA data plane

Also describe how to select the desired driver (module load order or
driver_override binding) and add data-flow diagrams for both directions.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/driver-api/ntb.rst | 193 +++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
index a49c41383779..75f96726c373 100644
--- a/Documentation/driver-api/ntb.rst
+++ b/Documentation/driver-api/ntb.rst
@@ -132,6 +132,199 @@ Transport queue pair.  Network data is copied between socket buffers and the
 Transport queue pair buffer.  The Transport client may be used for other things
 besides Netdev, however no other applications have yet been written.
 
+Transport variants
+~~~~~~~~~~~~~~~~~~
+
+The ``ntb_transport`` module is a thin NTB client driver. Most of its
+functionality is implemented in the ``ntb_transport_core`` library module,
+which provides a "queue pair" abstraction to transport clients such as
+``ntb_netdev``. Another transport variant, ``ntb_transport_edma``, relies
+on an endpoint embedded DMA engine for the data plane. When
+``ntb_transport_edma`` is loaded before ``ntb_transport``, or when an NTB
+device is explicitly bound to ``ntb_transport_edma`` via sysfs, it will be
+selected. Only one transport driver can bind to a given NTB device, and the
+upper layer does not need to care which variant is active::
+
+                       +--------------------+
+                       | ntb_transport_core |
+                       +--------------------+
+                         ^                ^
+                         |                |
+      ntb_transport -----+                +----- ntb_transport_edma
+     (cpu/dma memcpy)                       (remote embedded DMA transfer)
+                                                         |
+                                                         v
+                                                   +-----------+
+                                                   |  ntb_edma |
+                                                   +-----------+
+                                                         ^
+                                                         |
+                                                 +----------------+
+                                                 |                |
+                                            ntb_dw_edma         [...]
+
+
+Legacy shared-memory backend (``ntb_transport``)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The default backend uses the NTB memory windows as the data plane. For a TX,
+the payload is copied into a window-backed ring buffer and the receiver copies
+it back out. Copying is performed by the CPU or by a local DMA engine when the
+``use_dma`` module parameter is set.
+
+This mode is widely applicable but is sensitive to memory window size, as
+one descriptor can hold the entire MTU-sized packet data. It also requires
+one extra memcpy on both ends, as opposed to the Remote embedded DMA
+backend, described below.
+
+Remote embedded DMA backend (``ntb_transport_edma``)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The remote embedded DMA backend moves payload data directly between the two
+systems' memories, and uses the NTB memory windows only for control
+structures and for exposing the endpoint PCI embedded DMA engine to the
+host. It is provided by the ``ntb_transport_edma`` module.
+
+The current implementation supports Synopsys DesignWare PCIe embedded DMA
+(eDMA) via the ``ntb_dw_edma``, which is the only remote embedded DMA
+backend option at the moment, and the ``dw-edma`` DMA-engine driver
+(``drivers/dma/dw-edma``). The transport is not inherently tied to
+DesignWare: additional vendor-specific backends can be added by registering
+an ``ntb_edma_backend`` implementation (See ``[...]`` in the above figure.)
+
+At a high level:
+
+* One memory window is reserved as the "eDMA window". The endpoint maps its DMA
+  register block and linked-list descriptor memory into that window so the
+  host can ioremap it.
+
+* The remaining memory windows contain small per-QP control rings used to
+  exchange receive-buffer addresses and completion information.
+
+* For RC->EP traffic the RC controls the endpoint DMA read channels through the
+  eDMA window and the DMA engine pulls from RC memory into an EP RX buffer.
+
+* For EP->RC traffic the endpoint uses its local DMA write channels to push into
+  an RC RX buffer.
+
+Because the data plane no longer uses window-backed payload rings, this mode
+scales better when window space is scarce (for example, when using many queue
+pairs).
+
+The following figures illustrate the data flow when ``ntb_netdev`` sits on top
+of the transport:
+
+::
+
+       Figure 1. RC->EP traffic via ntb_netdev + ntb_transport_edma
+                         backed by ntb_dw_edma
+
+             EP                                   RC
+          phys addr                            phys addr
+            space                                space
+             +-+                                  +-+
+             | |                                  | |
+             | |                ||                | |
+             +-+-----.          ||                | |
+    EDMA REG | |      \\    [A] ||                | |
+             +-+----.  '---+-+  ||                | |
+             | |     \\    | |<---------[0-a]----------
+             +-+-----------| |<----------[2]----------.
+     EDMA LL | |           | |  ||                | | :
+             | |           | |  ||                | | :
+             +-+-----------+-+  ||  [B]           | | :
+             | |                ||  ++            | | :
+          ---------[0-b]----------->||----------------'
+             | |            ++  ||  ||            | |
+             | |            ||  ||  ++            | |
+             | |            ||<----------[4]-----------
+             | |            ++  ||                | |
+             | |           [C]  ||                | |
+          .--|#|<------------------------[3]------|#|<-.
+          :  |#|                ||                |#|  :
+         [5] | |                ||                | | [1]
+          :  | |                ||                | |  :
+          '->|#|                                  |#|--'
+             |#|                                  |#|
+             | |                                  | |
+
+       Figure 2. EP->RC traffic via ntb_netdev + ntb_transport_edma
+                        backed by ntb_dw_edma
+
+             EP                                   RC
+          phys addr                            phys addr
+            space                                space
+             +-+                                  +-+
+             | |                                  | |
+             | |                ||                | |
+             +-+                ||                | |
+    EDMA REG | |                ||                | |
+             +-+                ||                | |
+    ^        | |                ||                | |
+    :        +-+                ||                | |
+    : EDMA LL| |                ||                | |
+    :        | |                ||                | |
+    :        +-+                ||  [C]           | |
+    :        | |                ||  ++            | |
+    :     -----------[4]----------->||            | |
+    :        | |            ++  ||  ||            | |
+    :        | |            ||  ||  ++            | |
+    '----------------[2]-----||<--------[0-b]-----------
+             | |            ++  ||                | |
+             | |           [B]  ||                | |
+          .->|#|--------[3]---------------------->|#|--.
+          :  |#|                ||                |#|  :
+         [1] | |                ||                | | [5]
+          :  | |                ||                | |  :
+          '--|#|                                  |#|<-'
+             |#|                                  |#|
+             | |                                  | |
+
+       0-a. configure remote embedded DMA (e.g. program endpoint DMA registers)
+       0-b. DMA-map and publish destination address (DAR)
+       1.   network stack builds skb (copy from application/user memory)
+       2.   consume DAR, DMA-map source address (SAR) and start the DMA transfer
+       3.   DMA transfer (payload moves between RC/EP memory)
+       4.   consume completion (commit)
+       5.   network stack delivers data to application/user memory
+
+       [A]: Dedicated MW that aggregates DMA regs and LL (peer ioremaps it)
+       [B]: Control-plane ring buffer for "produce"
+       [C]: Control-plane ring buffer for "consume"
+
+Enabling the remote embedded DMA transport requires:
+
+* ``CONFIG_NTB_TRANSPORT`` and ``CONFIG_NTB_TRANSPORT_EDMA``,
+
+* a matching embedded-DMA backend enabled and/or loaded (e.g.
+  ``CONFIG_NTB_DW_EDMA``),
+
+* an endpoint configuration exposing an extra Memory Window, which,
+  in the ``ntb_dw_edma`` case, exposes eDMA registers and LL region. That
+  means at least the two Memory Windows (MW1 and MW2) need to be present.
+
+* loading ``ntb_transport_edma`` (instead of ``ntb_transport``) on both sides,
+  or explicitly bind to ``ntb_transport_edma`` when both are loaded. See
+  the following::
+
+      dev=<ntb device>  # pick one from: /sys/bus/ntb/devices/
+
+      # switch from ntb_transport -> ntb_transport_edma
+      echo $dev > /sys/bus/ntb/drivers/ntb_transport/unbind
+      echo ntb_transport_edma > /sys/bus/ntb/devices/$dev/driver_override
+      echo $dev > /sys/bus/ntb/drivers/ntb_transport_edma/bind
+
+      # switch back (optional)
+      echo $dev > /sys/bus/ntb/drivers/ntb_transport_edma/unbind
+      echo ntb_transport > /sys/bus/ntb/devices/$dev/driver_override
+      echo $dev > /sys/bus/ntb/drivers/ntb_transport/bind
+
+The remote embedded DMA mode uses a different memory window layout from the
+legacy shared-memory transport. There is no automatic fallback at runtime:
+if the endpoint does not expose a compatible eDMA window,
+``ntb_transport_edma`` will fail to attach. In that case, users need to
+manually switch back to ``ntb_transport``.
+
 NTB Ping Pong Test Client (ntb\_pingpong)
 -----------------------------------------
 
-- 
2.51.0


