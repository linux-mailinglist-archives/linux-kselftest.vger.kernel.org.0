Return-Path: <linux-kselftest+bounces-49295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4031D396D9
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6976A3068BD4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD7352F89;
	Sun, 18 Jan 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SIplYjZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BA33C18A;
	Sun, 18 Jan 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744556; cv=fail; b=kxjrH10wUrHeaSv1amzH/2vaoplwpkzbPxsgFbMDIWep0N5rsxq2CPm9dX5iSvViwpkej/MpDJklAZrGwRWUjSBi8msHcu4kU4gKJroPmGya5NiBtZbCO+VX2F7aYS6gegB76v9NOBMHQJW1QdZa8/k/us0SzLzUIgbdpUDkP2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744556; c=relaxed/simple;
	bh=/3BEllXzpjc8B0U9/JLdJ/vM9yD+tyj/xJqZKmc0JZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmxXiGgrdBqZTjqAav2F9C6PcgjOc/99DlpgOdvkLT10gxMzx20nrx2l8880mv4jNbSBaukooT55Lltkru2RXIrEPKk1neZQXttGrwpLW0FCpwppQprLrLS56hV/OZdlydDj3sCAOJhnZ/bf/lVu8zVOduF8tGM/SOStVk74RPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SIplYjZI; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItYcw6zCqZTpq9qm112w7TpuE9iD/BtDf5HyNpRXt3wLuch3qngChHKckHJ8Kbu6ku6Nqqyl79oVHS9VEH8eT0nf/GfY5CxvAsCkyI+aYCHP7Z/zHw/OoEo/Rfv/itu9AKCBz/DOJK/4p0xmN7QPaiOGw/NQEd50wmLLnaIHyxNM2jZYb/CG/jbBVzshbDul/H3/6GBh2tgxMwR0Y7tSegoCfhVuD7PAgeCQpoApul8/pNAcsYeBr2MvIPyipnnhtMuA7IGWsV268iHw5yyOi2jQYsdPB0dM7gHScGFAPlCH7wxehOmR/KvodpLl8SCfRtsIiPm8J4yfQDVQp/AwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hMdAVVGJT+l4QJS2EZy8lvG+0HCCSue+ohCs2s/gxE=;
 b=EYoa8AKUrZkjhJmgjeJ3SzlqrI+OdppTMlGvBsEpzsJ0+DomiIy3N4KvNkvV0ADnT5BG0qrrAgP58+1gp6EnfQSNZdz4dVj0SU0+MZXeUIIBVhhM+F3Lqh4+hCsAR62vBIXHuKvGbRWerR/JxVUGOpbxvfcoIbFJjS1pX3dB8WwwW7JOEsx57pqPjhxpxRQ35zaRwJQGJlU5eQa0J3hHj2gG5oPGNn5vjIdwIbPkrVe23TEWKY8ts0MDUugniHM8ul6oDToIYNDiXaYna5TUD8Yphma+OPnuoLlHjj5lD5LbZGLacwk+gPOfN3HfZ2Z7ZQAjlRtrKICxYmvrRfLKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hMdAVVGJT+l4QJS2EZy8lvG+0HCCSue+ohCs2s/gxE=;
 b=SIplYjZIfRe9/0P1NwL4qUopFgo+b9N0q5UY9kqJ27Ir57/K9qjlauXF+8FufKhemX1WQq3zoMH7IlXK60bZEA51t3xgjlevfjuioh/SHUaMuqiGiHikiMkUjyucMEKX162zz6utu1BtBcQenBGO+HAu5FROfosS+JBIf0+coNU=
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
Subject: [RFC PATCH v4 31/38] NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
Date: Sun, 18 Jan 2026 22:54:33 +0900
Message-ID: <20260118135440.1958279-32-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cafa8f-3284-4bfa-71d0-08de56993660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMrdVbIICOg2EFIO3NQe2y+a3zC2UTdQgWcCokiy7wbl+xE1dV66npFfcOD2?=
 =?us-ascii?Q?eSHJepx3TEOEh4YoLODycYvyc6mMOoZ1S8jRn7emrkw6YaFfgHHWSV7NQNZO?=
 =?us-ascii?Q?nOjOjHKSL+q4oN0czzus6BK/84TpDj5TeOUvM9cQk2Y4ZoXlttqUQJgstJu+?=
 =?us-ascii?Q?Dt3YDuiEoDp1G//KXBYU0XyObHWmSYKCAQ7KW3bGOzHOKmeVfaSqvEn5dbwR?=
 =?us-ascii?Q?WwCO3/A8yHuVzkohNaT0k+OWYbRCxqKSmrBGkJ3CiTu7n2jYvn+HWVDxfoYC?=
 =?us-ascii?Q?FWmnWIMO3FM/C7kwpwb+jxd2MPgdrWtWyr4gePPTWsvhSmBhc3SDQf11PRi+?=
 =?us-ascii?Q?mYmFXi/ZoXUrIAIB0P2CBum5VawwrcrTh2v7Jc+GkT/jKdudn3wd5qkLHK8V?=
 =?us-ascii?Q?A4YGIbuoeJrw25cYZfiJZKko9wEcJ4r3i71EnOLhaz0FR/4GMQqamVcAjC1F?=
 =?us-ascii?Q?L5psZD+o7wNQPzEWzKvDBYuIz5iPOT03YNpFF8OrKxqHLNieC/pI4DDmad9Z?=
 =?us-ascii?Q?zbJW7dvcq9fR02ITlWn+hpVGjR+EGJAoe1WRnh2W03sfzt+XVF3ZlUaAS3Wy?=
 =?us-ascii?Q?0NWIKjQvecJz5fidQGMhe7kaSCt4XR5jBWIrQeNG0nhtsYg+7sJC5W8qOsX7?=
 =?us-ascii?Q?cGMBTuFFLduGv+++F2njn4VRSvXrP25nLE1BAmAyW9PX1XVHbnXlYpuTprx6?=
 =?us-ascii?Q?vUoe1bHJBG6roC4tJFcp2JfkWMjdOfZW1zqoJ0ZPpNECdn8zoGjgwZb/FUht?=
 =?us-ascii?Q?XITb5xR9pPcuj7Z7NypoLt8GjraWMtV2GDyXKCG5quLKMQuvslr1rLmgoVdv?=
 =?us-ascii?Q?FfxS//vT/VkzUnt2lnrPY/vuBc2KUTnPAVB73/w2WhMUbt7G5mdIC5IEmr/K?=
 =?us-ascii?Q?gU0nqZsXB2Ff8eL9nwyCrtGhaY1Ql9TlweddI1gt57tlS5h078udywjbxbbt?=
 =?us-ascii?Q?sr3Iwm5Y6ZdIZlD91mPrqV3543kwWJT4HQ67sNYoPSLo3qlPDJ1dA+JR+eAu?=
 =?us-ascii?Q?MjF+bRJmFD7fZT3xRmj4wF5Jgyi3QHkzLqd5+er43f34Ez90mVZDI21+r4TG?=
 =?us-ascii?Q?XcFa2hUVimFhysHOXrgZrPmBWUwq+QGOaGpxEzR7J9qbpkjgIyEv95R/ulFZ?=
 =?us-ascii?Q?xd031sxMmIMPf5Al4mSq+QDa0ZR8Bt1RE9NLb3vLawaVO4/XgcvtDtCRLJNu?=
 =?us-ascii?Q?PyYmuT+fEd75pb8sc1SCZOGD3ggkF1q967yrrOAXGNEJ1F+D/1fDeQHlXyyP?=
 =?us-ascii?Q?2M/Zj2CwTP4owphJuqjS9u//S7p/l4OMHk8zJa/WDQmbulbUsBlsxoRfm3lg?=
 =?us-ascii?Q?tOa7qhAP0uvNQEL5u2G3z8k2MWSMFzt+UzKPtFSyHN4TTV+HZUaApMjA5lan?=
 =?us-ascii?Q?U9Ayg29xF055Gse9jBXzqfzBF2a0kYIJE7Wlr6dXd7F364kRTy/klpUAkVib?=
 =?us-ascii?Q?bcsWt2HtufhVhSuh04X967EM8Jn85aLQORTnYre4AKT3KEh1J0vHDnlnKCZD?=
 =?us-ascii?Q?YWRyg+rFt3QWawAHatNJ3ctWO+7eYMRkbRPynFbUYtoVCfpnoZRr1RbVwNMJ?=
 =?us-ascii?Q?m2Rs1nxN2brQhbKto9yeT2OufUlCqRqe8AP7NEyMp2B0Xu2YhYXT34WpaqR+?=
 =?us-ascii?Q?Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbsEqRsCub8zfIEdp7AvPgIwIixesNoOzkGsmD53uyL75GyI27lXvc6AikVc?=
 =?us-ascii?Q?D0C40ZuEHpqtIwX2Fbi77FGx7qGNaQeAEw8VtUCfA0YK/gIKM6vWFcNzBzLW?=
 =?us-ascii?Q?Y7+xGYgVdSBXcI669tzA/njR2oZ26BpE/EuAS8GJvlFXUEM4OOMCz6LV5QvZ?=
 =?us-ascii?Q?XzIUrhJQYy5OFkZJsCpBphQA/RcdUENc0lMhvOuQcjDCJLS5ry46gVw1fuW+?=
 =?us-ascii?Q?RIFo4+DbJW5zIaFVx1JuqS+GUnhrHhquXPkH1tJhQ1tnSubKGTOVQaF9cd0Z?=
 =?us-ascii?Q?AJUMCISr5tUHQPVqP+ovcVvhG7zy0Yqf7K6+s+yCwZ7kEdixAEhq10cfkryA?=
 =?us-ascii?Q?I9VbpQZToFALBMT4xF3iBkS4ZRQg1bCv2bqZ4delHHvDfFM1Bp6t3MYkt47C?=
 =?us-ascii?Q?HhwapsLVJAiMuePswRDQZ6Wv40C7GTn+Q70aTN9iawnODB5BFVyC0qI4G8hp?=
 =?us-ascii?Q?Ga2XEK0OmJ+RvCgdGM80zWO3uBcMLCLNQOYAVYpeanRufA2H1RemAfWH94VP?=
 =?us-ascii?Q?j3papbox6D+QuzCRvE4VkQJrBHu1F23pe2GMi4fmRoC/iHPZa+vdyT4rhUXN?=
 =?us-ascii?Q?+e0MfmyFyQmsVaDFrA1dwlsAYcgDuCLnnNJXnr3UVrmeIxCp1+f/I2JHMMR+?=
 =?us-ascii?Q?cA9AQGOCsOZuNq2KxOnsPdSuXzu9XUCipjYvSkS+LnoFrd3wt0jsETBA8C/Z?=
 =?us-ascii?Q?79VALbIpYSEvF/WW/M0VH+RYQx//hQhTbMogPi3sP/aPvqsDYiY+OA96NIex?=
 =?us-ascii?Q?CkIxJJI7L8FaYO9y62fKBDOwFmybHeP3ka/h4HfaiWA7mcRIpu5oxvLhgYIb?=
 =?us-ascii?Q?kRjSlmNIcnd7JB4YrmdgRq/HK5u2OinxEN64d7kwZnwK0f7AO8FlX4+AbZ6O?=
 =?us-ascii?Q?yb+EwNMga7PPaOHjkybAmnO0NbdrJf1UJlMpLDHPKyNrW3N/My2Ru2ShjJGf?=
 =?us-ascii?Q?EBqDPufVNI+ETZZwqXGOykDCktsSRLgCevm1CHLihESHTL/8FXm9V4FlIGmN?=
 =?us-ascii?Q?D+2ny+NR0u1HOVUH0a2j4NEnFFNj70t89Y9hQMnypVk6jJpr+ifk0BrDrjXE?=
 =?us-ascii?Q?QJQ9icY43giYV0PTBtFReMoKurxqjEy7G2kyoB3pP23h4aU5kB/OsQD30Ppa?=
 =?us-ascii?Q?P8xu+k+tDRWQZ/xmtTrXTDEyD17hL9BpU3JIS9oMM6WiZJnZp35ZnbIqPS0D?=
 =?us-ascii?Q?jGE4WYQEtXUXdIaYaQtiqbKO6vhd32aGjXZzKYxYSuHRrmTvEP6EL1FL3ST4?=
 =?us-ascii?Q?NFpdlJtqrE03wypi3qBNdi8okWjC0Qb1Je/paa1mz+UGkrQCcl35yT96DgQM?=
 =?us-ascii?Q?rtBrUT3dP0vgiXMSIzYGlMfYXLbBBaK+CE5VPGg9OuK2saYR2+9cozprX6/g?=
 =?us-ascii?Q?78iPx+R0gFGCRKUrjQLOJPD78Hi6335WCbFjUGainykukDq2MZ6VGvqSAOrA?=
 =?us-ascii?Q?8R8E8LcVANBEG920z8H2+wahDm6Zd9o1S6pBNO0O7RWTd90+XndxprDyZDub?=
 =?us-ascii?Q?tlqMCTSWaoCjcV9KzjONjLkTxFHAzHXRiF1bXxtic5q6oBVkqcKMfloyOtKU?=
 =?us-ascii?Q?z8Ica8d0ZJYBcm7qf11uMHWKI+U1Zsj6Tbvl7L1hSCJv17MhAPsnwqES5+3E?=
 =?us-ascii?Q?qH+3vH7iBS8QE2TeAb3hVWY2qHhr+K8AOCjPC3afW+NA/FUAiV6GIpiSfFpe?=
 =?us-ascii?Q?efz/KY9Vua5DvvZuWUzqNZaDjDLQZHDkk7GQBadn6cp/0ZPas/cLjyhYDHwk?=
 =?us-ascii?Q?o3YJ790TX5cEIsyFgkpNCufWGPg9NZ6q/kp06Hm/FkHSO937lsh8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cafa8f-3284-4bfa-71d0-08de56993660
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:17.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBXYtNJDeuJIB+ebdXhEbc61NVohxRkhWafNefaz2TQqA88yosdMqRvsZJdBF91fALS+lU2QXr06uVO5dZRR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Some R-Car platforms using Synopsys DesignWare PCIe with the integrated
eDMA exhibit reproducible payload corruption in RC->EP remote DMA read
traffic whenever the endpoint issues 256-byte Memory Read (MRd) TLPs.

The eDMA injects multiple MRd requests of size less than or equal to
min(MRRS, MPS), so constraining the endpoint's MRd request size removes
256-byte MRd TLPs and avoids the issue. This change adds a per-SoC knob
in the ntb_hw_epf driver and sets MRRS=128 on R-Car.

We intentionally do not change the endpoint's MPS. Per PCIe Base
Specification, MPS limits the payload size of TLPs with data transmitted
by the Function, while Max_Read_Request_Size limits the size of read
requests produced by the Function as a Requester. Limiting MRRS is
sufficient to constrain MRd Byte Count, while lowering MPS would also
throttle unrelated traffic (e.g. endpoint-originated Posted Writes and
Completions with Data) without being necessary for this fix.

This quirk is scoped to the affected endpoint only and can be removed
once the underlying issue is resolved in the controller/IP.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 66 +++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c37ede4063dc..2cefe46d2520 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -79,6 +79,12 @@ enum epf_ntb_bar {
 	NTB_BAR_NUM,
 };
 
+struct ntb_epf_soc_data {
+	const enum pci_barno *barno_map;
+	/* non-zero to override MRRS for this SoC */
+	int force_mrrs;
+};
+
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
 struct ntb_epf_dev {
@@ -640,11 +646,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 }
 
 static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
-			    struct pci_dev *pdev)
+			    struct pci_dev *pdev,
+			    const struct ntb_epf_soc_data *soc)
 {
 	struct device *dev = ndev->dev;
 	size_t spad_sz, spad_off;
-	int ret;
+	int ret, cur;
 
 	pci_set_drvdata(pdev, ndev);
 
@@ -662,6 +669,17 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 
 	pci_set_master(pdev);
 
+	if (soc && pci_is_pcie(pdev) && soc->force_mrrs) {
+		cur = pcie_get_readrq(pdev);
+		ret = pcie_set_readrq(pdev, soc->force_mrrs);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to set MRRS=%d: %d\n",
+				 soc->force_mrrs, ret);
+		else
+			dev_info(&pdev->dev, "capped MRRS: %d->%d for ntb-epf\n",
+				 cur, soc->force_mrrs);
+	}
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -737,6 +755,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 static int ntb_epf_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
+	const struct ntb_epf_soc_data *soc = (const void *)id->driver_data;
 	struct device *dev = &pdev->dev;
 	struct ntb_epf_dev *ndev;
 	int ret;
@@ -748,16 +767,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	ndev->barno_map = (const enum pci_barno *)id->driver_data;
-	if (!ndev->barno_map)
+	if (!soc || !soc->barno_map)
 		return -EINVAL;
 
+	ndev->barno_map = soc->barno_map;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
 	mutex_init(&ndev->cmd_lock);
 
-	ret = ntb_epf_init_pci(ndev, pdev);
+	ret = ntb_epf_init_pci(ndev, pdev, soc);
 	if (ret) {
 		dev_err(dev, "Failed to init PCI\n");
 		return ret;
@@ -829,21 +848,52 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_MW4]	= NO_BAR,
 };
 
+static const struct ntb_epf_soc_data j721e_soc = {
+	.barno_map = j721e_map,
+};
+
+static const struct ntb_epf_soc_data mx8_soc = {
+	.barno_map = mx8_map,
+};
+
+static const struct ntb_epf_soc_data rcar_soc = {
+	.barno_map = rcar_barno,
+	/*
+	 * On some R-Car platforms using the Synopsys DWC PCIe + eDMA we
+	 * observe data corruption on RC->EP Remote DMA Read paths whenever
+	 * the EP issues large MRd requests. The corruption consistently
+	 * hits the tail of each 256-byte segment (e.g. offsets
+	 * 0x00E0..0x00FF within a 256B block, and again at 0x01E0..0x01FF
+	 * for larger transfers).
+	 *
+	 * The DMA injects multiple MRd requests of size less than or equal
+	 * to the min(MRRS, MPS) into the outbound request path. By
+	 * lowering MRRS to 128 we prevent 256B MRd TLPs from being
+	 * generated and avoid the issue on the affected hardware. We
+	 * intentionally keep MPS unchanged and scope this quirk to this
+	 * endpoint to avoid impacting unrelated devices.
+	 *
+	 * Remove this once the issue is resolved (maybe controller/IP
+	 * level) or a more preferable workaround becomes available.
+	 */
+	.force_mrrs = 128,
+};
+
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)j721e_map,
+		.driver_data = (kernel_ulong_t)&j721e_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)mx8_map,
+		.driver_data = (kernel_ulong_t)&mx8_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)rcar_barno,
+		.driver_data = (kernel_ulong_t)&rcar_soc,
 	},
 	{ },
 };
-- 
2.51.0


