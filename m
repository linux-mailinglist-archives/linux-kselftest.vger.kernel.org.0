Return-Path: <linux-kselftest+bounces-17098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD696AF85
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845C01F21AC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37247A6A;
	Wed,  4 Sep 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQl3LATz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o8+Ll4Vx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEB3211;
	Wed,  4 Sep 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421040; cv=fail; b=IC46cnS/xa19YYRKi2BxM7Ou6kbJHU7+ZYE9wUSsPvgyWOS4pJpOS2tMkXi7Whyjs13Vcu/Mbo+tJL+9w7eep9rk1CUh23ycVxLTlEWg0kIQxHPj3aiyW4vlLVPGKGxw28oyMX070d/oWO03EMUD6D3d3Rwk2vupHBHXPsrO6nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421040; c=relaxed/simple;
	bh=Td/1tsU9KtHyI/tU7Sga9NsPHf26LFFF+mzAjDwqTZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrvzeCUGlI6ghYWtRMlhKRrchkqa7LPpzWF7Pv0YSHS76VR2tPnMITR9xsSgofLuojfmo3txnBZ5JJkvktvLLdBhOckvFUbSaF5CTFZX5t/vdXJ6HjiOc6Co1MGx7WHU1d9g83KNhg9JckvGXBAkueRUz6LPaA9x5NAEKA0KMkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQl3LATz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o8+Ll4Vx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841MUIa023199;
	Wed, 4 Sep 2024 03:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=cifPWfrC9YB+099
	IHadm0n99vvq4QzTeWAtqcMK96bU=; b=RQl3LATzL7Lb6RUlupvJPZrbhjVR28E
	KLQ1I6zINA2y7ANkvXg9xc8EBlRxo/EmE9s+My690+XyvT32In74PJk36P89fiLz
	YbhKmcUU8+PnszFIzjlpuzV5+1qw26dq1aMgUtmCS4yA67u726oOMCD+vvfFqWoW
	8PHyrZ8HNj836dMOag++yTOt133VC3tEPZ/Xj6RuoBBiqI1wePA9mk/eEaAr8vhh
	hfLziKr2xyXdmPmKfugURTKiSL+uIeFbcnNDGu661rIi+V8aHBlmTV/gzqv/U5tF
	NbTNMyC/uwjhNsCOGz3BmcGVAsPIRSEXDmD6D2Lqv7YyTNpcNoxpiJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsaacyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 03:36:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4842vc8e018419;
	Wed, 4 Sep 2024 03:36:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfjg15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 03:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyyVTufnvjRiR/5b3xsKB8djK+KxHJ6m2BalnVfT5miJ+LPHVHVLEO5Cc5HqMvXUKjThKTXjpFmTOsmL5+qPLbmBXz3n9SyaTuPsE7kBNxUu2sKAR55BXvgm/zeik3SLSVn/xz2WTuCV09hyeTrmQYZFC27Lal2oZ2v3a6Q9fhTlJuEBImfUTbDC3AF1+XRLPlJOsvMrJ8pUvg+3DClz1b5AaqRia9Ekrk58UKc87Ro/FXp9zn4Lkc10W3SQ4F4l+r7q8zqO0KVwHjJAq6+QtxTGY8O0Pj8QlSK/O+I2dhfAcQEFcpJEsAqbYe8JMhDjfacQZk0z9K3JCTTynIqtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cifPWfrC9YB+099IHadm0n99vvq4QzTeWAtqcMK96bU=;
 b=KH6N8v9lMf2+N0KClDNa2xKifsiRnZMHZVvuUwgjIZivpnq0abePnlxw60nYj7vXAmhTrwzdlM3K6JmIfcwb8cfW3JVUPKbSus0Rph7du48J9Z73gfsoxrq0uzf26WYbnqXD4TGeCNaqXs39rjY4DhpAT3eZ7muQQl5UwNAcjRaAXF6wWgxIckfP4OnEUt8gu2LFN7dVsBF1j4xJxOd7QF/5gcgI14/On+a/W4l1K1Nf7MQfgyxCiEWtBDj71ltX2JzGALCk7GwUj5l5LvCtre2I9Hvd+gwmofu8/VnrGPy36efVM9RXu1b4FJK8ssaW1DoBbUOcDegRSvZl2Ir+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cifPWfrC9YB+099IHadm0n99vvq4QzTeWAtqcMK96bU=;
 b=o8+Ll4VxJ9nwXyIJmUXRikpj6MIzTKwjvx8ujKq3F46QUeAkx7cM4uoyBCOz4Lpsv6JP2Uh8SFDVRvip8O5kd9WTP1x6MlA/n58YdrtXtd1GDLaESjn9OPtPekzB/7r7HTIEznDl30G8huV4/RZ/2rIE0EoEFSG08Eh9B2ddZlU=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 03:36:44 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 03:36:43 +0000
Date: Tue, 3 Sep 2024 23:36:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
Message-ID: <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Guenter Roeck <linux@roeck-us.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::26) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8cb8f1-cd0c-4713-836e-08dccc92cbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/k9Nhfquhz8+RhS+dL36nyPzChK7ztCR6PdVeXDW3GE11/7odXqBiYNvcC3i?=
 =?us-ascii?Q?vYGZk2KMkXxCHYXuQSFyIxhdkAwUbu8oBFp2Wc9JsMtkFwDNDfj7wyKnDwSE?=
 =?us-ascii?Q?NbAi1a+x2hpn4QYlqvMizm44s4M8UUHJeFt5U30xokbECSkjPk4K+F8fyQUB?=
 =?us-ascii?Q?vMh+dPOTjGKTO3dnfZjlyj/GES/1RFphUmWfccYXSKpor2HIYG/noXlrbDMx?=
 =?us-ascii?Q?URQwegkKT8YgchSXLcv1rhf/VOntW01lPeAmuRNwox629c39nrHgXbPeSV1T?=
 =?us-ascii?Q?x/1cXHISmphditvLfb3JRaf1k6K4nE0Iz69GUA5601QCUV2zo/TBkmuhQ036?=
 =?us-ascii?Q?9XFwqpZ3cXPweRwX6aql3enRVtNwMgh4VSqPz8s48uzQKoOq8jDXL36qfCRr?=
 =?us-ascii?Q?DOb28YF49gI6cOerafo4275qI2nmqHet5cytU7lI9iMz71bCV6STSW6zCqag?=
 =?us-ascii?Q?zmh6Hy1rN9t6pmtY+5xYkmgdMC6iUF/j2J1sfJHOGjB0fxyA7Ricvw4UAu+x?=
 =?us-ascii?Q?Tx4ff2EAGL04ktMle3dOWc+Vn8vqEBP/kjw7uKRx8gl+b7GyHsI3dfmWEN1f?=
 =?us-ascii?Q?ZMVrpjF4w5PF+X3jsnKZFXniD7/JZ+8cacvC4Al46rJTcj409TfQIEynzi2J?=
 =?us-ascii?Q?/Pz0yqSQtomyAbwtnSCJpJvKK/q6pXiBlouxtDim2qIIgxYoHm+vko539cIe?=
 =?us-ascii?Q?aPiWJhWwVvwNiq4jaCvl1iqJrQHsDCUjZn1AqgNwQ04I87irX/EmilfYhTer?=
 =?us-ascii?Q?eiCb/DVKijmnmMykY0yfY2l8/PG9+05YaWBUWWfFu7feKT/O6PprY7S1EIKt?=
 =?us-ascii?Q?Iv6Q+4k5bGlWk6MzDD3vymVHX2bMotbQ6aQOa/lQGitB7htTHURSogzMGRgc?=
 =?us-ascii?Q?50fUW3jOvCperjRxwr0N3KfoyqRISQ5r1g2xMd+O1ySMYrPMG5vafeo1hjs/?=
 =?us-ascii?Q?MAvvcZb/VFXoKhfSBruwgS3TPw3qQl39q59su/XmthgTXnT/kwrf6JKdqcyu?=
 =?us-ascii?Q?KI9jU8l2SiCkGeReh312RDFYbcOaF0AtRCbIpuKfKSyG6pA7KMNCY+dtAd6V?=
 =?us-ascii?Q?LEVJW3eoRm8dpbSEjgqyNESGywhhaG1FPosNBlkIryFYiHGqwEB1/7Cauk47?=
 =?us-ascii?Q?9aFh/MWNZWNJO0+9d/1EBsLp9vI5jENko9Fa0P38gyMp6cLD7TxiK1K0zT4a?=
 =?us-ascii?Q?ODiEPAtNvq58pWOCW7CKO8T/ObS0aSwQA+stniYYynwHX1QDc0N4tilKuTmk?=
 =?us-ascii?Q?5E02yEBrdv8q83zzP0EgBsXgikhbPikbw8QhNTrfpXh/Wo3I+DEa1hITdmXu?=
 =?us-ascii?Q?hYCIkuSKXhOIWboetTKN0bpgF4f36HSuI7b2Cnry88E7tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqAWurlQoKmGbFYm6U5P1j6Wi5RRA/cOPWXDiTBJQYQjMrT7VpqjOKdbdYH8?=
 =?us-ascii?Q?l5P//P8o6YXBxwZLpjDo+/95okIm5ei5DGWV0WZ/2U80NIG0RUhwtpBT9SS0?=
 =?us-ascii?Q?i27ke/W+OzA97uWcL1JWcnF6kQk/gKNc0V+3O/T9K/WHvA1CWek/NJlLxvNf?=
 =?us-ascii?Q?l2MJ7LJbJXgMoLcFOnLsg4wKzObAP9k2CuWRbX2Ad+4KkDM4/c7aMH+AnVFT?=
 =?us-ascii?Q?Dw87ZpCeU41TjZi/RruchFahY47/rMqCbw1TcGzK0QQOL8DZcFxWaLtLYH+G?=
 =?us-ascii?Q?RtzBuAhcs3GU0CDm/98boAFu0y5QfS3MGZ1Axm/w8H0pPkH3r+BrYbX9docn?=
 =?us-ascii?Q?m7TTFpk8xWBTQkyOJoadsfkD6DcC61xwEpKC6YZGpmFzaDHeVxz8A9IGosZZ?=
 =?us-ascii?Q?OD2yDvR/tTDDOQT6gAJ2T/GJb/KyhhcMZnDOLPJQegwZiRIcBZO6y6F0NdtX?=
 =?us-ascii?Q?HtvriguvFZ8Vv2Glkx/NID3/6bEHdORXCPkPOju/SzTfA36ip8Q1MdOMWOqZ?=
 =?us-ascii?Q?Eue3Y+jDOTWc+Wg7FHYImqLelB3lfdVnqWk/ku8nImARFJl6JdSTVEqCv0YQ?=
 =?us-ascii?Q?nEqpTwBvSasBHEv5LUzH1D6qzR0LBIEH9/dUmpD0Gutp5s1XzIcbA9HEpEQF?=
 =?us-ascii?Q?hWTZn5xdyxjmlLNcbbM2YD0XAMVB7OpldDtUAkLKD0S6wiYeGzm33JIPntD2?=
 =?us-ascii?Q?7IUcNJLaZ25sSWpsU2sRQCJ1mBI4XGsxB4oFbR6K32fRi9PYBL2nwnV+Epb/?=
 =?us-ascii?Q?mj0qPOyRtddTe4fWkDPE84GqRs9YTIydBPZMk7lqmqpyfh9WzjBwYK3prQrh?=
 =?us-ascii?Q?kwKVi35Uzzz8ox94cHvafLMCJNd5UIyacjFHVrCWiCPkQBSw84ITd4hT7SK5?=
 =?us-ascii?Q?COeHVX0RehwwhtUEArU2Ecv0kJsItnnyREAxJggV+i3pBQFO9kv1Q1sFOE2+?=
 =?us-ascii?Q?U9POBSortcEG1UYNDfSjoPhPEbup9o8mmDTQDMQbjGf/QlHSz8yTS10vuhzr?=
 =?us-ascii?Q?nCeXwDv1J/XlS4wAtdHOSkHbbbefHYWG/Lxox+cFtNlznAGAFmxIpqoUXDhX?=
 =?us-ascii?Q?uIjf4LKoSj1h3ycSWaKGav7CNx24NcsDhT6+Th0OBJ0C3S4XK4/Dc3/B83YL?=
 =?us-ascii?Q?vgcqHG0TBL3k1RJbyA3f24MQZUaaS4W0Ckbu6pD40NLJSFJUj07N7RLaPXNL?=
 =?us-ascii?Q?kvSEIHN/atcZG3TDeIOkwa70BFhwEx5yYsMLXX5ebCoO+sl6h5JZDilDRTEh?=
 =?us-ascii?Q?jK6Tnzdrh9oyFnU11zrN+QatEqE8Ht9zuxDpIXE1Y/zkmp4NORaotJbbJLVF?=
 =?us-ascii?Q?YxgwGph0wcMFf9a1RfvFays8KoENDu6gyL9wlwyCQFwc5sjpBXD2wvNhXU4m?=
 =?us-ascii?Q?qJw/rW1P+qWuRV/hQyMTFSKFarRlDGqjHqdziGIgOBZ9Rx3UdqiHDHxTip/c?=
 =?us-ascii?Q?7zovnjyLLhjisyFUgC8XZibZacWU/g3JN/XivmleGS5KAhFRa0jEehXE0bjI?=
 =?us-ascii?Q?CXJppSNLMAgp+MYO2GhXH+rVFr/UTnkZZDINkhQO2nYTLS4xCa9v3phECRix?=
 =?us-ascii?Q?BY2fqsdCZocWFx43DEZFixjqypyjwM3LiEOc1hXi7Xzd7uQGX/GpibtjZWF3?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9T5mGtN/1mSiEStPycwVz3syaxFhwLGVJv3Fyb34pUZ8ejl3UkjHSwhn5eFfwuZGy/snXtn03EZIFng2e+YMIeKEGBpLtc8LaVKNtKPh6HhA1n9VPuCr1fma97V9OoGIklc6WXsTU+meRuq45itBrU1TC0GZevUHNLapjuZkQvxkPBqFrphgLLJsuNoEmrrKQzkfLwAEw2UmCM8DLgiC3c0u6tVBn6XkrBBW2P4Zua38R/M7VGBzh/FRpChfTWoDjVFkyF+ByWrCrvBL5IKMrMmIxZmSfQYbtijVWOAUckiuVdw6fKHkihnGuNeYJxoxOOHjxuCMWFMCGvksadL9Lu1sLGFPZ4X1wHM/efpjChJECPM/xeL3Z5uAQhmKW2BjWFjxAacLTCywpOdQjoOXAt19Al+Co3UCDx758llC8znflpE4Wo/DmFB/m4tOpF0dxqTKARVBYxzU7mAOQ9+7Mh4mxyLJb+d1nc1zhKxg3i/J39bK2WoSm0Ush+pbwIrAZuwWhmkFS/bPIj5/CzybpD//bOvvmqUwgDUOi5mYaMt3Z3H7GAVO3inGOSfJ89H8FW5MMcu3Gu64UVhFzQ2kkVfQ18caPzIdI9Lyf4ggrKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8cb8f1-cd0c-4713-836e-08dccc92cbe9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 03:36:43.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5GuE89yHwT8d+pgbxre76mencvfO3w8sQjyzSJY1AeIDwMwl0cczTKVmhnHl5btDof5xOxMA0PQWBJgTYSnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040025
X-Proofpoint-ORIG-GUID: SoO7WtpA1v4HEwx1FaOexs4keRXfFnn3
X-Proofpoint-GUID: SoO7WtpA1v4HEwx1FaOexs4keRXfFnn3

* Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
> On 9/3/24 19:31, Liam R. Howlett wrote:
> > * SeongJae Park <sj@kernel.org> [240903 21:18]:
> > > On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > > 
> > > > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > > > as promised.
> > > > > 
> > > > > You can't do this, lockdep will tell you this is wrong.
> > > > 
> > > > Hmm, but lockdep was silence on my setup?
> > > > 
> > > > > We need a lock and to use the lock for writes.
> > > > 
> > > > This code is executed by a single-thread test code.  Do we still need the lock?
> > > > 
> > > > > 
> > > > > I'd suggest using different flags so the spinlock is used.
> > > > 
> > > > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > > > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > > > better flags?
> > 
> > That would be the lockdep complaining, so that's good.
> > 
> > > 
> > > I was actually thinking replacing the mt_init_flags() with mt_init(), which
> > > same to mt_init_flags() with zero flag, like below.
> > 
> > Yes.  This will use the spinlock which should fix your issue, but it
> > will use a different style of maple tree.
> > 
> > Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
> > you ever add threading you will want the rcu flag as well
> > (MT_FLAGS_USE_RCU).
> > 
> > I would recommend those two and just use the spinlock.
> > 
> 
> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
> the suspicious RCU usage message.
> 

I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw 
with:
CONFIG_LOCKDEP=y
CONFIG_DEBUG_SPINLOCK=y

and I don't have any issue with locking in the existing code.  How do I
recreate this issue?

Thanks,
Liam


