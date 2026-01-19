Return-Path: <linux-kselftest+bounces-49351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE6D3A689
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F3053002B9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69B2C21F1;
	Mon, 19 Jan 2026 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fa43tLq7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zoAfBTXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630A2C2340;
	Mon, 19 Jan 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821404; cv=fail; b=jX9ZwmXBI9b0lwSQ0/MXnZ3b/bJBijsmSjAZcjKNOa8Kzp34c8UXz4g9LRU1FRMAArN8FK4ZzFUR7bgfAWLxl+E0KvyWtqsGK8KlYve6SuTSC1KX7YmGGV2xmDO2Iw9jcq359Zs0Amru1VtzLuCjMt7NFFJZZU2rSGqpJlU43rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821404; c=relaxed/simple;
	bh=ccLbC7Qlawk7VerVP5mwGe5nfVKmTyTdzR8mRqSc5M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8mSU4DqPFogwG/NaT1dMM7lrgh+UMetdb6B0SUBuv2pHy+Xdiej+yBCv44151BIua+ykgXd2Yl5uuyxcoUr0TacXcuugxZpCfDMfmLNzZkEJmQ7YL3NE7nKz2r8OWZaeKwj7qp6QaLguuOOTmRBsAXwSLFmAXTHBsYDZ3Broa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fa43tLq7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zoAfBTXL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDNBX1512384;
	Mon, 19 Jan 2026 11:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bf8BLnDJZ5Zr9e6weX
	VTlUiumPEobYvMLHMOYQSdJ6M=; b=fa43tLq7TiPC1LeGxIvKkle7zdmK0jCLrd
	ysc8pEtLxJaMygKIbdGwOJOCrjpKKUYds40a9JKSpgGaygzqJdnFAo5T5k6dvIcL
	2+ZuHrru7Irk94k2pVxdeqbb5uye0iVcZnuh9NAD1dSVBBwVNrzuTzxk0Asi772b
	N/TiHAdr17OZXLBq8G/CJWFN1CqwOrMblQKjfEw1z2zAHG79OQg0anuqYstMLpkr
	wZ/1epay+nuXTRqaWjSl7SF/T/HiY3XgJOTgcTuFGX/dn6JjXlTU3KCwdvZLfg71
	prDj8jApSfA6usOqt+ccuM28gK27313nfq9qIvvecWzEUoa0dNKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qa4cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:16:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JBG4uU008388;
	Mon, 19 Jan 2026 11:16:29 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v88v1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXCWWiJ//DxO9z4bWRXcwQcZ6bgzxeUp4PE+mWftu6QuKUzsQqgvb3K2wOPciRd34kFF7TXq+WlLPcl60o/fIg0yMiYj5Hrv+lbPnMigX9CHE0JPUSBnQxN3xCc/DMCBBb82fYmB/p2DTAtDd/6kjrgCPwtmmmAiLaHpSPm2m12wofTrEMaAgKLtY9C2j6HlOvqNqp89WAimwNWulMGUsjm9QChxub6D1aNoblZYxeMZy/DhfwWWTWInS4r3KzPnsHyTuZ/TMm3la33tHzowFoWQZ/QgnvwvIEP/2f8e2uSLxcHHOWHAcxudwqjhyN2W4+jxc6mV4medBvxvRPKA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf8BLnDJZ5Zr9e6weXVTlUiumPEobYvMLHMOYQSdJ6M=;
 b=nGpMuTXEBM5q6DInAYwEoxMsBx+pt69gTZB6XrYWLgyYyzpkMfSqqMbt2vTYiVP31QIpRGIglyvbKySwyVZTrahFJSklQ1wrSRHreDNbQkXI2eds0osuxL3S7vbD+lxAepQP/j7ExcqToSSS2SwLbsKPMajWbcCT3WMfiQWzzsSFzwzhABdHx5YuMN/1u/eaNWRCAUIvvDte1337KL1p7XY65JfNTRqHERWPTB2iu7kBb3xTEKKEywXavL5kMZ1kNMWHueAPAYOJZISbN5n/RT+dsoVV4vG1/oDceSYSvjy2qaZQ8wtpsGhDEU+ld6JE1uSoGBtoO9VtJxJPB2QukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf8BLnDJZ5Zr9e6weXVTlUiumPEobYvMLHMOYQSdJ6M=;
 b=zoAfBTXL8qKTKXcM+dUGgDsRzr98KI6TeZvtsqNaWP+FDsJvCWxMtm0RJDvmkiM5s/uMBiLq4d2sgcCGVDoPtRZlIb7gchsH00KPtl8pQBk3fxTbr25BadORx6CbsC8a1MVJfV2waZL5Qvi1eLj0rNiNcCgJU16U9qA3VnZWaBc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 11:16:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 11:16:26 +0000
Date: Mon, 19 Jan 2026 11:16:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Message-ID: <7b4c877e-3ad9-42b3-91bd-e65390f9a343@lucifer.local>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <3d2e85ed-f072-4fca-8c22-461b001495c1@kernel.org>
 <79d2636a-bb15-4c7f-a633-c4bf408a2bc8@lucifer.local>
 <a6479b82-a68c-49f5-8631-b3f536059352@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6479b82-a68c-49f5-8631-b3f536059352@kernel.org>
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf9bc2f-90ce-4adf-19ef-08de574c2fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HnuiUsQUcKlnM8x69PQyZYBN3dvsRpsgkQfBlVbMcKLXF+hu9IMaIt8IWfpq?=
 =?us-ascii?Q?Vz+64g8Ch+R1z/C/KXgU8l5/OroakEEvX/whY8TL0l5+500b6q3YkjaKH9dD?=
 =?us-ascii?Q?cN2pG3nP+DHnbOUvIhbyY4wSZOajwFHvP4PFYt/hGjKVVQepTAPdcPuuqh48?=
 =?us-ascii?Q?UarH1nDXWZvKCjjV9JEDOUhF3YeoEJ8FC4++B60cxxSuNuE6QHVfKLc3u3+0?=
 =?us-ascii?Q?ofwuo7QfuwQASG/syUvg9HjTSwtZTciTAc6RT7RYfXaWbyl+Dlf47xsIJYMJ?=
 =?us-ascii?Q?UlTtvj/j2Ec0cB3zubm90kzqgXgSgiPWmUxqtUkNWCe8mC10IH+wtdEY5lTk?=
 =?us-ascii?Q?4rxvKNPXtILEaI5V7BJftEsdXWp182G0E6fSM/dgbJgkm27GY1O/73cb99oO?=
 =?us-ascii?Q?SHLINkSNWhKeTFwabXVbK1YNKCFw4r6aO9BJ7wOuLJIloyEuCPqthIe0JbRy?=
 =?us-ascii?Q?OF8aDB4Ep9lDP3IkbtlE2bNBaIw4so3IZ99WSRjdsDv5ANpKrKo1NTAIqJvo?=
 =?us-ascii?Q?fM2RedFEltexYnSLTQHo+b1zdF4zMw2fmML1R/srsxEZALRnA42UilwaF0LY?=
 =?us-ascii?Q?mFimIfOWWNV2rS7pomhs0PJm/yOUp5JfM36w2+1qqRN/DqTxJwiU6oLjVT8A?=
 =?us-ascii?Q?X6HfhV419Kpz0iUwXoF0vf9Z63QWqeOyalmdklw43IlEVAUof82zGwqfKmYA?=
 =?us-ascii?Q?mAlOcCA4gM77KOJpEnbyyYCWGIl8tEkmUk9auF881eAojdl4hSwaWzOMl9FT?=
 =?us-ascii?Q?c4DTzH15SuUrD3Yrk9GKujFSmEeCnZucTyQARUNO4Vq8m92G9WbAdmfkzOfc?=
 =?us-ascii?Q?Oban+WkpSpaoelTr9gnQiA0C9lo+X2rnLrKi1zXz6kUaJJ/2tBJ2LxubmnG/?=
 =?us-ascii?Q?3oOVp6SthTbxZGz5KH2hHJ5yqhFnMrMAnyH7aHZfJ3mXhawxIZJGvoEMpX9J?=
 =?us-ascii?Q?jNG5VFFfovPe28jCUQl0zMi2BYtgUN0OYjkGYgoJNMz9rAfmGvxdSq1LurrE?=
 =?us-ascii?Q?8wd/AMnohYke4XPoEdEum9dZ+n5z1soJWRKXc6Oqtxc3lUbFl7xCHtMsBBu5?=
 =?us-ascii?Q?KPlDrGS6UXiff5x3bMeMZMsDQStNdUNanre33MBDT5Ut/fZTQGugO3h2gFPN?=
 =?us-ascii?Q?8a3ndgKheB3gyirybyRNhbqe6ugsg79YpWA/CFRARiBXVfMmbUWHPePdZgEs?=
 =?us-ascii?Q?YRvsYgstqfRD04+i4t92T+x9hbVnkE91aLWuGK6OLPAGHKjjf+5gYekR8v6k?=
 =?us-ascii?Q?ZJYPYdhqo2ag5kz6RlahJ6lZCSA8H+vQcWgUp8AHmSbJSC41FB4kA4OJrs3W?=
 =?us-ascii?Q?WKfj25dZa3t/kLd2DXwVkjhvlr7B69OJrA4vq+zb/ooJc1FTPdMLlCWi1Nbe?=
 =?us-ascii?Q?LBoQ1ht1Vcm2t2UJBSmEu8pCzhhWc6SA1v0U+cViVLovj4aoVwI8+69KQLVi?=
 =?us-ascii?Q?Q7Bb3+uYAexqhNnOm8KDhl+aDBpIT0T0Nqs2tyxb3JL0hEpOwkMegOVhlGqD?=
 =?us-ascii?Q?5q/yiiZ4aRYgrmZplE92R4A5MKSEN79dLpS9oxMexJyMMbmzWN7jLCzStcun?=
 =?us-ascii?Q?bkb5kwrS6FCB3aEULY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9GP3fISxmMaf0apBeuNoGOLGe8MGxcQnyjVTGqMglxCvm2W3bf7pU/htZKB?=
 =?us-ascii?Q?t1PpPRMWlDnVEaFEjkdFfcWWyY/Wh48oTBjMQSzTt2J7VSpDt5EXebGD9zLH?=
 =?us-ascii?Q?kzitsvuB2CtkGdj50ytv4JZ23G1Gr5d/SHUS7MnJDodgd6prL2aQGBYLbWGY?=
 =?us-ascii?Q?dPwY9m4OelnaWAqmDzO6T6qApUp8mEMvVnQajp04IBAFM4z3pCePCFSX4QKw?=
 =?us-ascii?Q?wxLewbiLnNvMk8hiTPLFiM7UAC1MaCkDupjai2yI4tMF1c9EtBug3svpePOB?=
 =?us-ascii?Q?/xOr8hqlhxZveAOwAExPFE4NTyhEYHxJpxrJvU0HFv8J8WVSxM9yOf5JbLP7?=
 =?us-ascii?Q?+U7+kTeqRIyYlI21SlHJHIZYWPBERCUJFkZkbjnGDridJ47nynoePUFrxnIX?=
 =?us-ascii?Q?OKTT18kvxf1yaJ1N4eimLKXuatQVyQ/w4bC0j2tCU3M9HwuNjBUXe0BvAWMz?=
 =?us-ascii?Q?tuldKAYPmDX4fTIXdAMC4HeI/BOLalfqIdcpbQ4rPX8RfeRDUQFT5pgTHQBs?=
 =?us-ascii?Q?HQ2okyXxjURs7cQQMkIzRP+wOYNvAUvnyQMXV6hfThGildVIQuyiHV3jnh6U?=
 =?us-ascii?Q?9XvXbNzqxGbtSDCVA5SAD0iIeHytFp7pGbgXFiPCkbR9nSeRzicj9e31ZMyc?=
 =?us-ascii?Q?mHfSc8VATsq9epWNVYexO/IP8nvyCDzmhQGIPmuhQ0swTf9DTxsGIjFZiR37?=
 =?us-ascii?Q?gMrqSjIX0+Xb46PQt9CstqD2m+BpCY0d+hTWClxxE+4UtsbvnwR/dyx/gO+I?=
 =?us-ascii?Q?vI4fdg4fq2KmCrl5MnGhnVIepJhFCDuGiu5RQE5amwSL5+NB83e59vrZzNLY?=
 =?us-ascii?Q?VfBev6k2uZNoHAM424cSM2/DhWB/gl8duOZ4wCGHgem2qC48r19OhKPA9Ngr?=
 =?us-ascii?Q?/3zVoU/9MOTyruBx5NiyxT1JcB+ia4jyzFXMtdrOv7qieA3mids051YKqpX/?=
 =?us-ascii?Q?QCUq57Ayd4OIpo+0G99R3Yx+asmf0xjBAt8Qd2HL+XBHYe/2aBmz1yIZcDFS?=
 =?us-ascii?Q?pdmo1pXUsr+0i4wBgjoeAGvODC5nWq8jYdlGLNfaPog3XS4DAPEaEtWnnIGZ?=
 =?us-ascii?Q?AYPwcYEhbdW1I5HzQQaHMsm7PUvLSPrpCy0YeFmo+c9inbhEp9NShPRw/TQY?=
 =?us-ascii?Q?9FQ1Yv35JcW5Ygb5dPKzGuY8IEJyztTXRHolzKppYxD7pAMV+Rog0qe7+14r?=
 =?us-ascii?Q?onqiyOPOt4nSow9uVheBs00GYjmyZjP/ZzvTIzRIIjbmA7JxNZKnRaXExUxy?=
 =?us-ascii?Q?BorhkKoLjt+8BPw+fetPIpoe8teHYbdlyzJryK3fmkIW8ldAw9+awS8ibPbc?=
 =?us-ascii?Q?S0hGUxTRqO6wNybAcK2CGObOTC6WnkqhNHTkwZW6QAv53x3EsRHbgoOwEyCx?=
 =?us-ascii?Q?b/FXCa2P30X/YfYf3um1exlWxUQzELSUQuFBBd7NJa1AhaBzdGJlQeIR+UDs?=
 =?us-ascii?Q?xRCyesEuYSwYAtJNcPF0k4Gc0oiGAiz9GXJOCK5UXuF43GUrkZqfPAtBj7co?=
 =?us-ascii?Q?CKg/ClkheOiCNEQUyC2OLRw1uEh4Tg9/BFO/YOyLGWKzdcGDY105m15JrJ8r?=
 =?us-ascii?Q?JF351qDlYBIzX6q9ShvJ60qccwlq1qqXwgOzbxDhwxCT4QwByYcsqxxQLaCn?=
 =?us-ascii?Q?ktHBKMC94Ew5BqbyN7agJlszzWdcUAlfFwYVIcqnviZ0ZaZtGcv97esBjZ4I?=
 =?us-ascii?Q?G8NEEXy1WqRE/TJRuIvV8CJlHw5hK4gXISwCXkyTHqfU3t3ePQ9tC7ND1//u?=
 =?us-ascii?Q?0EWOXnCupWKUGS8ny0P70wuDCxqXoKE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jOLtunrwpD4S8GuNwT/ZtBfXA0HKw5dtDk6CWNx7KjezFtjdrm6Et8IIt/re1WHK+Dv+zZbhLfoM06ZBAvzyikurNPTVdGrwSC7MEBjlo3onZ2OfEVEalf+mhyWJWJgnlUUv1Q2vmRuA3g4TSyO3lD8M8NsBi+PVAC3Xl4mgfEyaeKFv2abe2Ya4mHQ7kLdJlQ86/nnUtZ+UKBU9DCVwjLXEXUim8diqQdL4399maWlYxAMziZI8ePUIOY7m5EMFnqDqHjRlWeHiNrxaRyiz/l1IRXVO0+BTBX8x38ZNSEAl/5TySDPIYTBtMm12GwznjQhDM70tUc8W5iozNThtOfRF6kuhWtbZ/7a7rPIp8N98pcnUFQbL0I1N8Dd7D6AaLPWhJubCpF01BRfhRO1wUGWXuimErgjwyR/6clPrtuJOchEB9hg7CQ7s+4+a8pR4Cd1uFRKXt+NeVsmRN5kAuNH5NYAsaVECUztoLVSg9Frg41YrQKLpteRd6lQye0JNey3fr0ObZQOeGbgrLQj+buQ3M/gzlFscKuoP/34tPYTZlh1Na1i34jFiexij+Tjc+7fwxQrP5gbnGJeOhUsUHgvGxy7y5By+RpbnMvH0JhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf9bc2f-90ce-4adf-19ef-08de574c2fbb
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:16:26.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJh8D4F8D5UMKZSCI5i/dRhz5clLdj71jY6l/Sb+H5m4wFfzATF8/bZjzWJ/k1GRLLLNLCMeRdqX/j7SRsZ1BfRhH3MoZDXLhnnNkh7pUwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190093
X-Proofpoint-GUID: oXDEhbHfb3azM2D42B0sMClJ0yAWLHZD
X-Proofpoint-ORIG-GUID: oXDEhbHfb3azM2D42B0sMClJ0yAWLHZD
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e128e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=toH4KdYtoxDtoiild2cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MiBTYWx0ZWRfX8cCej0sXqBdf
 9xB4eUIRXgdhbIcYrEsb1DLvjx3BkG1Tbuxl2Wpwe8S12Lt6Si4oJsXSp/RUfaWh2EDzLvTmsm2
 gJ0uGE66H0NkA7uUkBoSKvjR85oMg2sdDUr8v7OrncteGzM8W8rcMDgHaU1cumgtW/FHfmn+WZ2
 2X9zqxgK0nk8rc5ylMKpPzwIv2SYIYWUkiNDQNrHwVgO9JizVCPfBhFma0E0cZv91IPSRHJtB7h
 RnaZB/mm+W1tX2dxdNjgVdiKUBuJWGnBRql0FpasxvZSpzWqVvG44aY0K0Ep6SIedA5tJ1iCYob
 r2Cvoe7KlEPD/jbcvXkTT5FfmNtsNUk8Tt2J/NS/usMjCF7JfJq5HhVzZkxqUojpeQS+tUtFond
 ikJQZ/cy/dOD224REaX50/e8psIEE08SbBz5Qi3w1k86rkRiR1RQ+3Kvb0p9VlHkzbwt5iOZKLJ
 D97Tdig+fnPLAS8teNA==

On Mon, Jan 19, 2026 at 12:11:39PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/19/26 12:06, Lorenzo Stoakes wrote:
> > On Mon, Jan 19, 2026 at 11:39:51AM +0100, David Hildenbrand (Red Hat) wrote:
> > > On
> > >
> > > $ uname -r
> > > 6.18.4-200.fc43.x86_64
> > >
> > > I am getting
> > >
> > > $ ./va_high_addr_switch
> > > mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d7000 - OK
> > > mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7fe7de6d6000 - OK
> > > mmap(addr_switch_hint, pagesize): 0x7fe7de6d7000 - OK
> > > mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
> > > mmap(NULL): 0x7fe7de6d5000 - OK
> > > mmap(low_addr): 0x40000000 - OK
> > > mmap(high_addr): 0x7fe7de6d5000 - OK
> > > mmap(high_addr) again: 0x7fe7de6d3000 - OK
> > > mmap(high_addr, MAP_FIXED): 0xffffffffffffffff - FAILED
> > > mmap(-1): 0x7fe7de6d1000 - OK
> > > mmap(-1) again: 0x7fe7de6cf000 - OK
> > > mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d0000 - OK
> > > mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7fe7de6cf000 - OK
> > > mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7fe7de6cd000 - OK
> > > mmap(addr_switch_hint, pagesize): 0x7fe7de6cc000 - OK
> > > mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
> > >
> > >
> > > Are these the same issues you see?
> >
> > No, that's entirely separate bug it seems :)
> >
>
> Oh, lol, I ran the wrong test.

:)) but found another bug...

>
> Yes, on Fedora config I just get
>
>  $ ./virtual_address_range
> TAP version 13
> 1..1
> ok 1 # SKIP prctl(PR_SET_VMA_ANON_NAME) not supported
> # 1 skipped test(s) detected. Consider enabling relevant config options to
> improve coverage.
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

Yeah and the test runners seem to be the same, so this test has just _not
been running_ for a long while.

Then if you configure a kernel that _does_ support this, it fails with a
test assertion.

I tried to dig in and it seemed that the logic just got confused rather
than it being a legit failure as it's making odd impl detail asserts about
lengths of gaps between VMA regions...

>
>
> > Seems to work locally for me on 6.18.3, and also in VM with tip mm-unstable,
> > strange.
>
> Maybe a hardware thing (notebook not supporting 5 level page tables, maybe?)

Yeah and that's something that should probably be addressed... you'd think
it'd pass anyway?

>
> >
> > The issue here is with virtual_address_space.c which seems to just to be
> > generally broken, I couldn't even bisect to a working one, and I really did
> > try.
> >
> > Actually hang on, isn't va_high_addr_space already then testing what
> > virtual_address_space should be testing anyway if it were sensible??
> >
> > That suggests then that just removing virtual_address_space without
> > replacement (since this already exists) is the right way (...!)
>
> I cannot really judge, I would have to decipher the details of the tests ...

Yup, in any case removal of a test that is fundamentally broken to the
point of not being able to bisect it, that doesn't mmake any sense, that
risks timeout due to it taking so long doing something crazy (it tries to
map across ALL of the VA address space), that relies on implementation
details of the kernel/libc (i.e. how the space is laid out in the first
place), etc. makes sense.

It is just not useful, and needs to be replaced with something that is. If
we want to unit test get_unmapped_area(), then we should unit test
get_unmapped_area() in isolation.

It's actively broken and harmful to keep a broken test case around. A
replacement that works can be added later.

>
> --
> Cheers
>
> David

Thanks, Lorenzo

