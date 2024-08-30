Return-Path: <linux-kselftest+bounces-16849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C8966977
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94C21F24817
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706C1BCA06;
	Fri, 30 Aug 2024 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bd0e4h1I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uYl7caB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E723DBB6;
	Fri, 30 Aug 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045831; cv=fail; b=MbnO/oh/ZDPs4N3LCulAAUWZwn+m1o/Cr9Wly3RS9CygTlaJJ09bolSGe8uBXIOseo2eECzMIuTSzIIv2CKr7HWt7Xw6JZiieZ4KYszxzH1uk9pBLEA1hGH+UFD6xl8x0DHanHF9NYmcs8Uk6BEL4ucxpRzGM3McSqVuh97kyR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045831; c=relaxed/simple;
	bh=1Y5RuUQW8nW1WwbsZycutVWmIlSPDWcQ+AhGr7nllws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkonaYmTNJvO/QXpTl1C2qHJ0oQpmim8xmJGnMnu//C42F/wgp/nVA5++pKeTc5lQ+w63mHfVqybGDXDdUbkDzFpr20WhjGjmCa4Cg8orOqpBTAjQsaJP6EqGFJtc1LlVJcxiiXt89JhipXdozAZvhboOllNW015A/10qB0gmBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bd0e4h1I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uYl7caB8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UInO0t007930;
	Fri, 30 Aug 2024 19:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JcsUsRthbfu/mkJ
	KXsGOltWmYTeMkFN68aYdmydmYxc=; b=bd0e4h1I/0QlN4zSVUR2RPGN+iCdXvq
	2VRJZfo4372LF0I2JxMFWaeLy84Qgh6mtJheN+WZWam8ZhmNJnptzX2abBTW0GIJ
	+PHY2SYtFPryarjQklQ5kzsx4q1+dIdyE8M2dTwN1RUtVByhc3Ybrq57PK9Lk+oN
	BEMvj2AB57iyTmm1u2SAy4J5FSDXt0GhOueF25SwAzCi3RAc5yh8P1GfSNfwo5qO
	aoBos1TQdqkOidaK1j2iT226RwMQPUm7YAyHH3jylq7PxBwwKhOjIVFq9iKQ9UeP
	TFBow95Fklpsdtk7agnkl/zxQPFmCfdz9ZPF8IwfSXf0oRk4lcRU8CQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bkcr82p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:23:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UJ2C1F031763;
	Fri, 30 Aug 2024 19:23:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0yegk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNCTj76AuKpq2f2+bwc8KqGrfaLUmgiEyjkLZW+Hk9x5qN7t1pc87rd8YEA9LGoUoSxobFLI0ceeJwYl1kiGj98op426fBcfcx5Jo8XO2pHe6gBcpnnl4Ke+R7Ds4bGOFGMsqbxZ7+0Qy/D9albFsIDwy8RFNC6Ck9Fdk0W8v0vd+nCew+gCQXn5R9g2avVf7HPLEeMvk1IdGZdyfC9RuYoEqnnMrw8y123jEKqS71HHEVdnsuItClmZkuYe3aWxuJRe/gKDQX4F8/3hHNoiKA2CY+eoajS8foOLxD3ThekExOS2IjkrWWjFTv7byZ7PU/7sLoydsuh8PhlTfpeVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcsUsRthbfu/mkJKXsGOltWmYTeMkFN68aYdmydmYxc=;
 b=Bpf0EuZr95RD1DyPMlizW+Cq1kTQdJySt27Zi7Y3GQ9/yQNkDx9TiQh2mI6koeHNj/WLA4E5t9/dQIBucvuniyTS2WgI0pgoa4KRkIptsrbh49pz/c5ajBTq//lVUXIK1wjA8bt9k2Jx46vV1bR0nsVB3ARG9wNLupPugbsyDh4LDBq2ca1YJU0IJ+n31K2YVD6+tKMSxhsmBYvCzoois0+gW4T+NWVQ6MOq1ZNozgiAVPV+fclVr8Dlx+jTz5Vx3SG+LjvKOTqCh1wya+rRE2SjQCAqBBs9CtAiJEj/MCpQBoTSU+PP0vxVe1Blr3zqPj7g0fM1GcbdXlqbzoeJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcsUsRthbfu/mkJKXsGOltWmYTeMkFN68aYdmydmYxc=;
 b=uYl7caB8NPUPrd3dw1LMZf1KSfpqW3+UHTWzxCAu9P5AkGRKMGfs7h9tc3XBFofho44m84lo+ZJbx1mNa5bD3aBiz+19tdizLJ71dqCTxXUVDsCRzzdMdfYhiDXnLyXfgxwVG5s46pjGiYfu5/IicHQTZwweDCStPmNdJQGEIOU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB6486.namprd10.prod.outlook.com (2603:10b6:303:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 19:22:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 19:22:55 +0000
Date: Fri, 30 Aug 2024 20:22:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d8574c-5df8-4dcb-e400-08dcc9292606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkzy79i/UsDBLNUuGg535CNk705zHT9Ssng+zGCXNS0vErUbcazMUtkeKzBD?=
 =?us-ascii?Q?/NcmCquFkz7dPzbeqngquIt/STP3cPFIWi08hn64mNvx05Gs61QNfqg/Q3js?=
 =?us-ascii?Q?AxjRfcD7D7QIniy2VsUlYFQjC4wyYn26Zfc9sg6nXoTGdsBNWM6owk+oXrCd?=
 =?us-ascii?Q?UNx1vHSwwjbMAELUyC2KohhPNC3Xk7JWPqPBWoD6p8/5B/DC9fTXiZiq6ydP?=
 =?us-ascii?Q?5d9Bvm4f+E6SyvzGNA7gPmi7EFCCsAdMl0p0A8fUJaX6N1IEBYxhTF3Ar1nq?=
 =?us-ascii?Q?PbMmQ4JmQ+VpcTfawV9JL4XIrpsoFIDVvZLLlYGBCy/lb/DIuWvuPLhXWBip?=
 =?us-ascii?Q?aqrNeq3VIvw27dqLdswPDdtH4GdpZzkRDNUzCWL0yTJc/oiDxLmnDYiLvrno?=
 =?us-ascii?Q?RFndkgl2FHo0dHUAA26gFt7XJogH31FfyxZW9isHFKKIKvHWOxt8oxdNJInH?=
 =?us-ascii?Q?GLG4JN7R1tgJt/KfpltZOBxbIn6vXpe14CP07h6EpO1GYkWDr7U0piNLN3Rn?=
 =?us-ascii?Q?HJkSqC/7EYfOl2Sdzv5qE643N73J0mX5elAfBvR7lhKvwQ41cCIh0lLbug0Y?=
 =?us-ascii?Q?Bg+ez/CAxtBMWHKwTfeztALmREzwbCHX1lJivsB5ipAabgLX9+8qPGPRUiAg?=
 =?us-ascii?Q?tzTjIVOxI5NvU8SYCCCPslNIvKZT9lz/ywKwxpim0rCgI5QqB0IAJ+hY7lQ2?=
 =?us-ascii?Q?0K14Uh6HTS18/7fLA89HztJJ9gcVrEemZSfJnktbNtgMYU+Dhfv5y+k5iO3N?=
 =?us-ascii?Q?jNFmOBNhdEgUvW6zN2kCXg43zm1SYzq+InXkiDCMN0MJGHaIIVa7MlD+w8D9?=
 =?us-ascii?Q?QkmegHKM7sxI5JVNJ5HFvL1DWc+vY2IXR3PYrpvEWIc6V4JCnS4ruI3Rhs1g?=
 =?us-ascii?Q?sX//Y9DgU3GOUbu9UbfRE+8ZYAHrobi71g8LNMQUgtVgnVysDdi/rWctr7r8?=
 =?us-ascii?Q?5rU1nFUfgv4hdbdDnOJ5qiIdHJvb+aLqITizaC+pXVG/hF/5wO3Q3j0SP8U7?=
 =?us-ascii?Q?VdeiZO2yWNLcq6mahpK1A/t0Wlvi6cw1oCx7aiqKXKSMg2VnH7kkmFFjHiHf?=
 =?us-ascii?Q?wzIHU5jcbYCa/HJRtW+9vrCzaZzKElY49v8KaX3DhBoAu8552NcnwwgAuWmW?=
 =?us-ascii?Q?imHWQslOOS+gQBdAP49FQRERk9fQxYxXdFyMcKMvbsuMyISNoLS/74r+rgsR?=
 =?us-ascii?Q?6Uh8qx+grBuFncvYnIp6KfrMmw4mduFSTzLML37a2nI7Bp9sgqo0GqIT63Vn?=
 =?us-ascii?Q?rrOVJFpUIqzVMrzaCNYKN6QAK0+dR/21adJHqx63yWwR2wsrXZaiA3iF6sVp?=
 =?us-ascii?Q?qjWyKaQ13nc2nIhj8Oo6CjcGNStrLHwaembKIVSYuFjKVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIS3eSaCGDxMII21O4zvd0f9HK0+LsqzgtPME21HKvp4luQm32+uEyXJKDeB?=
 =?us-ascii?Q?yYVqpm92b4nKCUPw/6SN5oJ31txGtKy4+/LXIsbMeLWZnc01oJOL0LqFNq/h?=
 =?us-ascii?Q?eDC3bWnVrHl/5NAbsML2uJiW3JFJoDPKywoepvtAC7Uy7Fiycp7NIX0I0j6a?=
 =?us-ascii?Q?Jr9WmhOz194RQ28aUmOs7Mx80/Ya+c4FPJDGK6+No4jfMvCEZX8N1IXqiwRV?=
 =?us-ascii?Q?TNeWibSfqpMI+Cz+anHuCNolzeFPGvBPRM6iyIlL2w367obwCeSBuvNKgIkC?=
 =?us-ascii?Q?+YCG1uyLbqSzqPDPhvGJKcTA9gCS7NtBa3SqvS8x+d+6B2jdw0eaIj396I4w?=
 =?us-ascii?Q?fQfatwIjd+ytKu4UNc/B7JIk35SZ0OfpKjCsBJ3vZFAwQqFuVM17SneDvLhn?=
 =?us-ascii?Q?LjqK7Anj80NVIL32/V6cGfXcXPG3zqyPm9TKfFvT4SOPfhbUqzmi7NAPJJAF?=
 =?us-ascii?Q?5S0JBwLF2X076QESt0wywbY1PBaWquhE1uVm8QCEOH6vT/Ce8pj42CxfYv4u?=
 =?us-ascii?Q?ZdWLt8H7fu3YnfGpt9QFqt54pz0CH55wO8Sd2H3enGvYlPBGwySotfvBnZYX?=
 =?us-ascii?Q?0Bhk7+CTmJZJ6q2tye3mQuDBLli3gJ4pI61bDMR31QZPR9x01tuXQJX6aBkG?=
 =?us-ascii?Q?uaaW63GKIX47aw1EquMQzDT+oNvh4MY88NMBEMyMB0qeopjanfG+lc6OXWkX?=
 =?us-ascii?Q?G/fuORy2VcvWO9Bypn8upWt2bP4RIk0f/mAwb8Qdw4nMFW6DwTsR14c8lYWg?=
 =?us-ascii?Q?2Q+49NNNnoabjaz8aBxJYrlJf9fz7Byf4uNuANB+KDGwdO+5U0jEqVQO1joO?=
 =?us-ascii?Q?QZsyjWPd3882MoGR27+7kUJ4M8kAufvu69UbL4JY6Rj3CTL9A0SUFXIUe+X2?=
 =?us-ascii?Q?pWgvKesmDVUeroq/S8EC+/j6gM/Qyzu2V/keS1+3SU3ZT58cFOjYqi9kNsZM?=
 =?us-ascii?Q?+c1ROkKVB5WemPGYusK48g/Kf8sF4NIIjppJRW6EmfMw7e//4Flc0q09clE2?=
 =?us-ascii?Q?7e87TAM8wGOyxOhDqt/QKClVNjiC44T3DIwxd3OUzpPdeyjrHfG+kfPR83pn?=
 =?us-ascii?Q?EQhqudrujNw5M/QOfstL0jbK8EfV2CMGJ0kvawWBSXbX8iI3j1/E/DChp03x?=
 =?us-ascii?Q?JFsXLVLo/ZA2DaoFfgUDlvUCRfYZnts/yeu5p4bSx0TcPg8wLLsetA9ynxef?=
 =?us-ascii?Q?PheflyCISQW9++CJsw2i5NiHLe9SWoxNnUjgKsnWtPe2+pRtxie034zaFOiB?=
 =?us-ascii?Q?60l6h64aU5JIDy01O75hHuHY2u0JDPXoZix0Y804oiWYNWlhvAfjEDiPvyfV?=
 =?us-ascii?Q?zoEJVvyHPcUQavFmRCk+scupZsPpzRZOmN2fQHsUbxdI4SfHmmVcz/SlnTJp?=
 =?us-ascii?Q?GEoDiuaxxMxzhWtZ2AIqEIpqwj7kWjYhh9aMaA+MCrARDYClWC9jqjs6/IcF?=
 =?us-ascii?Q?kN97Funx58gbRnWSnf7qIIZuAgc81r2NuiYpCKjtP6fko0Th0RBIrnpPCaDy?=
 =?us-ascii?Q?QjLAN8Fw6tYUfX3gE+/ziEoRPxivFt6IiryGPKntUW7hX7tYbkod2VLfIPR7?=
 =?us-ascii?Q?cbzO+JD6P90H0UembPFVLhghtYtk1DF7P8mIGVgik99AZfA47Uv4a5Y1047X?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GAsycGMtOpq5fZZmpUWDRYvWKuh06AVjFOVBeuyJIKP3DmDFiv4PlKUcPShzuL6lBg0T2O5DF7iJCaKge4fHlFna+BVXm1jOBMkRb15ZRJguL/2lRycnwCEtRGpN05m1Omg9iLzZVu5Qe3qNV9nQrjYwP2s/kPfstPXAWQXn8H2q25XlDyTx48ZHRzUG2doItA0QhKRskn4q9hgrXzh5hsoNZsY1UasOyrkLnDqIMsfBEQx4qaqr5E0dcSL3utMQtWXCYXEpEZVL7fiazNFu4kFH9Ap1lqWVSSxklWHuT/p1pfrqLOtfyjPM1MbBdn/nIBzuvqvXWjvC7iR/RemJSdK+e/HVVpJOPmfgDPBYqX5MyTZ+MtqSfI1eP9SNEe5eS2MKoG0eg5VoB22kCCwPLSWwLaZhkx+hM5Ze86Bi+WMrH1ICYOhyMTb5G8jrz05rpzp8jP7wSlppANyBiMk5lHSndOZHmQUTbj75Re6D6bNnkg0M1T5dm4h+TO9W0k9jdhaLXfK3WJXcpIUka8jmLKFrFQGOvMwGz6bwWSY2mTiVT87OfqK2p3pooDJihGBmY1Nj46uY21bO5kLVw+U5+NKQCD1z5QykeAmOR6y0znw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d8574c-5df8-4dcb-e400-08dcc9292606
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 19:22:55.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4gNquTfMo7JHxL49sk6giYpq/IADdmbI6WNjTRUirfNQIIYwWjeuHfImDx4mhhao0IuFuwhWCz1km+olebKDtmaynmW+2JSpI/1yqZNjZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300149
X-Proofpoint-GUID: HfOGDOmfAxZwF2734pFuZ4lkwa9O2PJH
X-Proofpoint-ORIG-GUID: HfOGDOmfAxZwF2734pFuZ4lkwa9O2PJH

On Fri, Aug 30, 2024 at 07:43:12PM GMT, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add sealing test to cover mmap for
> > Expand/shrink across sealed vmas (MAP_FIXED)
> > Reuse the same address in !MAP_FIXED case.
>
> This commit message is woefully small. I told you on v1 to improve the
> commit messages. Linus has told you to do this before.
>
> Please actually respond to feedback. Thanks.
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 126 +++++++++++++++++++++++-
> >  1 file changed, 125 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> > index e855c8ccefc3..3516389034a7 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ranges(bool seal)
> >  	REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_mmap_expand_seal_middle(bool seal)
>
> This test doesn't expand, doesn't do anything in the middle. It does mmap()
> though and relates to mseal, so that's something... this is compeltely
> misnamed and needs to be rethought.
>

OK correction - it _seals_ in the middle. The remained of the criticism remains,
and this is rather confusing... and I continue to wonder what the purpose of
this is?

> > +{
> > +	void *ptr;
> > +	unsigned long page_size = getpagesize();
> > +	unsigned long size = 12 * page_size;
> > +	int ret;
> > +	void *ret2;
> > +	int prot;
> > +
> > +	setup_single_address(size, &ptr);
>
> Please replace every single instance of this with an mmap(). There's
> literally no reason to abstract it. And munmap() what you map.
>
> > +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
>
> Pretty sure Pedro pointed out you should be checking against MAP_FAILED
> here. I really don't understand why the rest of your test is full of
> mmap()'s but for some reason you choose to abstract this one call? What?
>
> > +	/* ummap last 4 pages. */
> > +	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
>
> sys_munmap()? What's wrong with munmap()?
>
> > +	FAIL_TEST_IF_FALSE(!ret);
>
> Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
>
> Would be nice to have something human-readable like ASSERT_EQ() or
> ASSERT_TRUE() or ASSERT_FALSE().
>
> > +
> > +	size = get_vma_size(ptr, &prot);
> > +	FAIL_TEST_IF_FALSE(size == 8 * page_size);
> > +	FAIL_TEST_IF_FALSE(prot == 0x4);
> > +
> > +	if (seal) {
> > +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(!ret);
> > +	}
> > +
> > +	/* use mmap to expand and overwrite (MAP_FIXED)  */
>
> You don't really need to say MAP_FIXED, it's below.
>
> > +	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
> > +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>
> Why read-only?
>
> You're not expanding you're overwriting. You're not doing anything in the
> middle.
>
> I'm again confused about what you think you're testing here. I don't think
> we need an arbitrary MAP_FIXED mmap() at a size larger than the overwritten
> VMA?
>
> You just need a single instance of a MAP_FIXED mmap() over a sealed mmap()
> if that's what you want.
>
> > +	if (seal) {
> > +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> > +		FAIL_TEST_IF_FALSE(errno == EPERM);
> > +
> > +		size = get_vma_size(ptr, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 0x4);
> > +
> > +		size = get_vma_size(ptr + 4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 0x4);
> > +	} else
> > +		FAIL_TEST_IF_FALSE(ret2 == ptr);
>
> Don't do dangling else's after a big block.
>
> > +
> > +	REPORT_TEST_PASS();
> > +}
> > +
> > +static void test_seal_mmap_shrink_seal_middle(bool seal)
>
> What's going on in the 'middle'? This test doesn't shrink, it overwrites
> the beginning of a sealed VMA?

Correction - the middle is sealed. Other points remain.

> > +{
> > +	void *ptr;
> > +	unsigned long page_size = getpagesize();
> > +	unsigned long size = 12 * page_size;
> > +	int ret;
> > +	void *ret2;
> > +	int prot;
> > +
> > +	setup_single_address(size, &ptr);
> > +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > +
> > +	if (seal) {
> > +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(!ret);
> > +	}
> > +
> > +	/* use mmap to shrink and overwrite (MAP_FIXED)  */
>
> What exactly are you shrinking? You're overwriting the start of the vma?
>
> What is this testing that is different from the previous test? This seems
> useless honestly.
>
> > +	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
> > +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	if (seal) {
> > +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> > +		FAIL_TEST_IF_FALSE(errno == EPERM);
> > +
> > +		size = get_vma_size(ptr, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 0x4);
>
> What the hell is this comparison to magic numbers? This is
> ridiculous. What's wrong with PROT_xxx??
>
> > +
> > +		size = get_vma_size(ptr + 4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 0x4);
> > +
> > +		size = get_vma_size(ptr + 4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 0x4);
>
> Err dude, you're doing this twice?
>
> So what are we testing here exactly? That we got a VMA split? This is
> err... why are we asserting this?

I guess, that we can't overwrite a sealed bit of a VMA at the end. But again
this feels entirely redundant. For this kind of thing to fail would mean the
whole VMA machinery is broken.

>
> > +	} else
> > +		FAIL_TEST_IF_FALSE(ret2 == ptr);
> > +
> > +	REPORT_TEST_PASS();
> > +}
> > +
> > +static void test_seal_mmap_reuse_addr(bool seal)
>
> This is wrong, you're not reusing anything. This test is useless.
>
> > +{
> > +	void *ptr;
> > +	unsigned long page_size = getpagesize();
> > +	unsigned long size = page_size;
> > +	int ret;
> > +	void *ret2;
> > +	int prot;
> > +
> > +	setup_single_address(size, &ptr);
> > +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > +
> > +	if (seal) {
> > +		ret = sys_mseal(ptr, size);
> > +		FAIL_TEST_IF_FALSE(!ret);
>
> We could avoid this horrid ret, ret2 naming if you just did:
>
> 	FAIL_TEST_IF_FALSE(sys_mseal(ptr, size));
>
> > +	}
> > +
> > +	/* use mmap to change protection. */
> > +	ret2 = mmap(ptr, size, PROT_NONE,
> > +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>
> How are you using mmap to change the protection when you're providing a
> hint to the address to use? You're not changing any protection at all!
>
> You're allocating an entirely new VMA hinting that you want it near
> ptr. Please read the man page for mmap():
>
>        If addr is NULL, then the kernel chooses the (page-aligned) address
>        at which to create the mapping; this is the most portable method of
>        creating a new mapping.  If addr is not NULL, then the kernel takes
>        it as a hint about where to place the mapping; on Linux, the kernel
>        will pick a nearby page boundary (but always above or equal to the
>        value specified by /proc/sys/vm/mmap_min_addr) and attempt to create
>        the mapping there.  If another mapping already exists there, the
>        kernel picks a new address that may or may not depend on the hint.
>        The address of the new mapping is returned as the result of the
>        call.
>
> > +
> > +	/* MAP_FIXED is not used, expect new addr */
> > +	FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
>
> This is beyond horrible. You really have to add more asserts.
>
> Also you're expecting a new address here, so again, what on earth are you
> asserting? That we can mmap()?
>
> > +	FAIL_TEST_IF_FALSE(ret2 != ptr);
> > +
> > +	size = get_vma_size(ptr, &prot);
> > +	FAIL_TEST_IF_FALSE(size == page_size);
> > +	FAIL_TEST_IF_FALSE(prot == 0x4);
> > +
> > +	REPORT_TEST_PASS();
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	bool test_seal = seal_support();
> > @@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
> >  	if (!get_vma_size_supported())
> >  		ksft_exit_skip("get_vma_size not supported\n");
> >
> > -	ksft_set_plan(91);
> > +	ksft_set_plan(97);
>
> I'm guessing this is the number of tests, but I mean this is horrible. Is
> there not a better way of doing this?
>
> >
> >  	test_seal_addseal();
> >  	test_seal_unmapped_start();
> > @@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
> >  	test_munmap_free_multiple_ranges(false);
> >  	test_munmap_free_multiple_ranges(true);
> >
> > +	test_seal_mmap_expand_seal_middle(false);
> > +	test_seal_mmap_expand_seal_middle(true);
> > +	test_seal_mmap_shrink_seal_middle(false);
> > +	test_seal_mmap_shrink_seal_middle(true);
> > +	test_seal_mmap_reuse_addr(false);
> > +	test_seal_mmap_reuse_addr(true);
> > +
> >  	ksft_finished();
> >  }
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >

