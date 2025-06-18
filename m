Return-Path: <linux-kselftest+bounces-35284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA97CADEAD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14416173401
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022952957CE;
	Wed, 18 Jun 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLon3IEZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RARqOSmM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A382284B27;
	Wed, 18 Jun 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247432; cv=fail; b=MnsbvPwsamDJatI3v43r3tTfoenkjE672WZyKTWmy9MtDZS1YqZH02QVGcbma/MVylw+NZzTFNmG6OHAYj6n+L+SaTuI6moo/fjUuiJM/2uwZOVgocWHiIKRitB8xxT4NlIk6FB31ahQPQbClrE80VI3ASJB+uOIBs+//Pp9iR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247432; c=relaxed/simple;
	bh=LSxRmFWDwm3mjTiyMyFHJkVZFkUyPdOBXw4FdI9Qkys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzVEOVtMojNXkjX/kc3zeRq/3bDr1wL0+2X3UXMM7Ycm85lGydZdtuhVAss0brYA6RnDaCwvniNmKsc91Eq2F9uhrabF/ShGgPLS3LaGZmJ52FPiuKJpHxeDe6IjktsKRXvyqykpqpfSpmLbush4F01L9ITc83VcYd12XTIWHMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZLon3IEZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RARqOSmM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBMYvx001414;
	Wed, 18 Jun 2025 11:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vEexSq6mDWuFwqY6JM
	kp+abyBstWrW3kcmZZPVxUw/M=; b=ZLon3IEZEF3VZaKHSXV4lNMLEQ71eTTbFh
	dMh0in49wIDeCeNxqmJwZ1HYB8btl6wCxWsAAHBCR7WpfMLoBbkwA+esH23BBsmZ
	OmktbFSMSJVSz6YuUSpYKtyRne+Ywi11Kh1PKKJ9X8OymgJqtN6ZZabwEd8g9mgS
	9Fc7mY+KfNFc6cdDt/OtZmd5TyHFsRNst2HYGM0ectYovQoqXsKeM+N+LpnOebbh
	cZZSHB+uyx3QnrWhMYSQflA8Fcwc1DGEsZUroa/MEDpj9mlGhBPlyuC5e0Qlguto
	VM67GPHFlOqI4vTTZXiv0U9hMeTg9m8iB0V9m2wDZjLAKlg4A6hA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv57huh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:50:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBg7c4031671;
	Wed, 18 Jun 2025 11:50:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhaa4ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Csi0E524EDS9AMLs8xOdMuTYDTU+30BNkaJkqsiZTXQeHAX7gK0dRinR5C4PBIpysEjVEW3pdlvY7T//ea0mV5s3xhatStKzvqY0eEN/8Tx77BrRcJmYLPN5WoursC1Eeq1XNfE8OjhSmRJo9+jYIYGLvnfnZstuU2k8awrBK2GdoNzeJuagvbXlSVvFKWV16fIWCXc4z7CX62zOgcVGRdcW0bi9oVp6yiHSL212mQza8mImlotbciVBuJrS+NLlCQ+Vsuln5wBkWw3ryDnofI/hdY4eBYmJN49x18kmbNNP1l+EaNGEHZt9SO1uTyer314X3SBCpsHegWVqWg7q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEexSq6mDWuFwqY6JMkp+abyBstWrW3kcmZZPVxUw/M=;
 b=jnpU0bfNMepjhnz6PJ57qewG0Fdj3k7vhMdudq4F9ZtnfRDGrS1GtoKP5L+VE2Zellrgd+ducqBgaGVu9ISeqB++U0mIYeyyA/e2y4n6pMX94Npli4tijFuz8+EXjHxR0rgjwFGFDL7JwaSN8LhW3BiOSQ8t/v0sRscC6XssJVYGnCgCLubO/aRPXwLHBcXvqf2rXQsofF/gn2jxq4vWA1qotRYH1SwmCl4Tawk2R+IAhPvMgGNoaEYqVCZXJL0ZzcPxO4t4OcCn4WhMrAaTa1NtmoDKk2TYOccWfTU8bAgOIb2ILCF9glNBTs3ozslfKgucOC4h40U/koK1gOWHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEexSq6mDWuFwqY6JMkp+abyBstWrW3kcmZZPVxUw/M=;
 b=RARqOSmMGZanCkK8IldfKqv1YOXsLu9CfDaIx8rv1qzOJPoVYS17GraMf2CpDY6+V5FF8ArLNtUEBqsl3mVvIJRMXj4Jl7KynzVgMPQT+5b8BFY4l1s10T5tXR5sTvkMzjIo0KMOVjpZ485dPGAm/q9PbGItnwWv5dw59I0PtpU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8155.namprd10.prod.outlook.com (2603:10b6:408:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 11:50:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 11:50:05 +0000
Date: Wed, 18 Jun 2025 12:50:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <a49ee718-eaa1-4f0a-8c3a-0312e40b1d40@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
X-ClientProxiedBy: LO2P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e728f7-63fa-48a2-d71c-08ddae5e445d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wXA2GNS+iOjANdIIrZpRwxsnE3dt/47PLA3ByROPD5B/x9ms7LejBrAb45nS?=
 =?us-ascii?Q?LltEPpELz5RW4T2oBeyGVpYkOx/w0dFHApOqvdX8nJKgY/dpVMfaMi60NSzi?=
 =?us-ascii?Q?y2pFNmpdQSWT0QZFWqUbd7CDa+zW8RNbhtv+oFse7ShdNceqHWWOaXmnXpLz?=
 =?us-ascii?Q?XWhazqEUvz2+GOEDxgB1cbBoxZuWroouGO0DusPjEHBytmVEGLvaB8IFpuob?=
 =?us-ascii?Q?ISZ5Zx4c+60TBQCxYLkVk6/yF42MSJtknjmWUCnYJjDUd7PGuSvO2dE1K2Te?=
 =?us-ascii?Q?UiNFoBHeTKtOdmB28HMmHy65jZcZ2Wj4Zsy9Y0+VU+Oy/4gpiYWTtvQwpIHd?=
 =?us-ascii?Q?0MgAjkFPokDu+RhZCMlqhlsoBqHpOmtiKG5/MOwMhvNikCTiddHh074LnFPQ?=
 =?us-ascii?Q?YncCzz1UH2qhpErcQ7qW7W1jXaZ/cPbXCKmNErNgzmFIP+VpkXLzrOzr0SLb?=
 =?us-ascii?Q?gfoOc3ndd1np2tM/o9U79WZjAZ0sBbPOZUIf57Oqt/kPcyGXhnpxltHggdFD?=
 =?us-ascii?Q?L41J/SBJqnFbJZInxtbSkkQKPx8hpqcYD3KjM8Y0uOwuBf+WG+Tabuz5imXF?=
 =?us-ascii?Q?v+OkumKnxULyxAxYhd6YXD6oE0vDzR4yePKtO/CwwfFkq+mgLENUYOtfvohd?=
 =?us-ascii?Q?7PxCshExAPQw2MBLr0cSSC0LFDSEAOSv/U5naKBJynHDtqKHQyKjNI8/lpEe?=
 =?us-ascii?Q?HC899jKGD1VL32Azu3Yasqz7RHhZIlveQVhJfTJviCHqtZijFB0YtPP/aoTb?=
 =?us-ascii?Q?Yavb5tmx8bvMV0nKH19B9yLmPGcBMAO1XtKCoxpuzxdYTMoyBn8ua26r/uje?=
 =?us-ascii?Q?Tc2DzN7Cie+ceZT2yDzXY2X05r8HSk4P6QubdRDiXqMFtIcrcQRDifVjk9Ks?=
 =?us-ascii?Q?ZM3P1wTBkoO2b2DwOn0NdNYaHASOQNu8D8GW1t+1OBy1phzcNhlC/4JnR1GH?=
 =?us-ascii?Q?gv8kqpKGeZ3mZIAQUV948D1s0MPODKdzq5VcDsUCM/ZNzdsEuLqjq1hFev9P?=
 =?us-ascii?Q?GA2UwKuKUUXLmbLAusWp5iEzfHnf0AoRUT5bPL7xGRHp9+ENykaWSxfUECba?=
 =?us-ascii?Q?TULxZgjmfLr7Uyax2d8FcM28FTkC5NBenu/ZbGQzpSUo5IzuxdGTX8nXYuPe?=
 =?us-ascii?Q?SjYMgMsRSrjrHOJlM3HYn9KZF6OYOuJnKoRPyYz8hPpZoIy/hyG8MvcyN2nR?=
 =?us-ascii?Q?Ti2L/Kxq1VrokNj6ZRxbPS7YO9yLhOAaS6LmhGIGOsEnY3uYzE+LNbg7I31t?=
 =?us-ascii?Q?5RZEPWqeVJMDoB1XITrUZPVhHsZeR1RUy+AC/1VY5ELOGWmJtZDaHn0kPCPO?=
 =?us-ascii?Q?lcCLBItyeYF8ejip5T+XDj0hSRQB6L+YvwFEPCvmfVw3AWXSrKbjPfcSgAap?=
 =?us-ascii?Q?AMyYJcSqL3+rdxTnhO8Nz8Rh7NXo8g4mt7b0oCyi9g0KiQ7sv+rg1xh6Zy45?=
 =?us-ascii?Q?Mv46DO7qVuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ClQWcDuOave095OuYnCPeVakJLRronnVWXBYq+PAhA12QoR7eQekge5l3Ww?=
 =?us-ascii?Q?DDmS5RtNNnPB5IrE+IGXB5mQWshTzJrXZbHwwjpFurxgyDEL3YpQ5KDNQ3Tv?=
 =?us-ascii?Q?NM2ng5RT8aO/AbvlcU0xGNSWT0AGNM1HTSXnDFa+tYiEReySZq0VamdtKUCC?=
 =?us-ascii?Q?tQ1ywPicaN/QzfL88KZ8XhNRJ8/5BVDWVNgCGgErUM77DxJ/Lxv3jRuMQKLE?=
 =?us-ascii?Q?XGjrsexYaFWrx61g1C0uScY1mcBMPkZPOd5IPUq37ZRqGy9yhElz5ZMJKQXo?=
 =?us-ascii?Q?dCs7rJJ6xGv5OsHRH7GhF3wpQ5QStTV33V/r4PVNJcAtln1JuRkGA7kCg87I?=
 =?us-ascii?Q?5+fWaWJV07D/D2x1aNSkWypVzL/k16HOJmyIEDwpACppb640hQlQCZsxZcP2?=
 =?us-ascii?Q?WKf4Lb9HIQYcNe64ggDRBAQxSEWRfHpRdcZvcCJ8q+T2b+K4yRIZVPm6+92s?=
 =?us-ascii?Q?sB3N+DG7msCcnceHkJ+GmnOwgHFugdQTVy0Stu+ScmHXbteml7bkCkzqiVTk?=
 =?us-ascii?Q?dtiEe2Zv1XjA+WJrJpOgTdXZdg9Vq+16xRVQJ53pBPnR3UckLkjAAGaMlJBL?=
 =?us-ascii?Q?2UpduHRjt5OA1cq3qiRIBhBoJhiNryyOuDVBvybHxthPTqev/dPcrlgxT+Ij?=
 =?us-ascii?Q?vJwaA1AyXfT1u9gL3XXvmjlwWy5i0HFPQdeVX73mYrOOiyvedtG2AqU3/42S?=
 =?us-ascii?Q?AEXZQkg+nuLyq/oGZBMKiy89ZD8b5XbGCQsb85f+w+nqXcd3KsuIJh5VTVKh?=
 =?us-ascii?Q?my6c1Bn73LtSJb3MosmqpjN99OuRx16uHg93HtxwRgdi9CT3SOv5unMMrO52?=
 =?us-ascii?Q?bUovOoV/LXHPR9MM8QtzUKaDku7kia4ZcAEYz+P6CGrWkCfdH8WoHdSQNdX/?=
 =?us-ascii?Q?mUVTi8y2IEmLAUe7XLiPou5bXMgorxqCyCohiSK7JvgCKo6QdkfC6fV1oZWb?=
 =?us-ascii?Q?T9VpuRLjhTRwE/K6RMBMHuGOUj9+gpZInAu41xDRREkMF45nMt98QCQRZcNo?=
 =?us-ascii?Q?XRrWn7L1YpmAVBsMf9UEzzhueuqw/ISARfL4J4LBfCIguBZ+r+CpLKRzR7gz?=
 =?us-ascii?Q?8Z5+Z9XzmO3j8EHZ0fYB2bg2BjlRCaCzL/aUUZSdpvQP3pltI8ESXd35rO0A?=
 =?us-ascii?Q?0Df1oWD4G9JGMFk4G5l/CwO82WUMuF/EJ9o08zOA6Unul/XUh87Epb3EtxQq?=
 =?us-ascii?Q?9fMPxwbvzj21xFYzwYtxhWQDf/t8p/oFVb9QnlRfRcGqX6cPLUr8frynngrG?=
 =?us-ascii?Q?5+IMPQgmdZSU8e+feM3F8cFbXZAPO7UKZGy/cQSaUeeqsFWWsOSHEnL67cKa?=
 =?us-ascii?Q?oAwsjgp64sIf6GARzN4Vxu2i3JR5Myj/Bx9mI7jeTC7qyEERvW6Ha+8wZiFT?=
 =?us-ascii?Q?rLXnlrfrNrEHmU485BCc+6CSooiJ6wUHZNVbatUmH7e9cChehl1RDndHaVkD?=
 =?us-ascii?Q?Y0uhsuzlpgHwZceFoAbDOIq22BCc7SzNnawwNwu65gTcsbgyaHoHxZ6hgXn7?=
 =?us-ascii?Q?+X9EKDI9FRV19gpdYC5/rlT5l9z5+M9W/1jrgLpgpvHhyeywwGuGulQbUlPv?=
 =?us-ascii?Q?Xzyiw5KF36eSWQl8XXpSZOn1tiEhfkXxCAWQ9Qd8lEtJRp/koEh6EPBKamE7?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lcShB7O0VpSh1EnSKcsHyg6D/HNW4OKq7McK2ERI78A1xvL54Km7rfAlKFyDaq0jTJMyNywpbPSju47J72s+soCWppborzYpz+ETyRpudUPAnlWRfRzCv+ZBMiKGMpGBEiaPgFF4/aCCGfqhSqyZX5zy0q4lTTKW0tYlpNG+FJ/efKAU9KXX0SJG49YeCAO0ukYDYAgf8kKKUpslBmBVmVM6udii8M3FDXrqlUR2pUKZ062HSP7/6c9NVs1pYxgX3WDEyxFy58CfQcuzPGElWw5pjWssV+FLXOcBkW0BhB+tXoi2U1ALEu37jQvWltN5CbN/GiENFK/1F0Y8lbELnBHFHDySKNMRL1u6B810CRuedfofDCh21OYwQtvAi2giMTeDZ5xB3fMk2rTYYBlZp3SsG2745Zu1y789uAbmDGN66ILynT8Id6CnKV+SnU1uzEitUQmkacfDtib7+RVytcDXOe9g6LM5EkNYQ+8QV5pK1whrqmu4B+lNe6VRwSF5loOVaT9/UwJcWDS8LE2RbNvLK+k5uzYGqkdNCpyFXst1koS76AfOhnkbU1oJb/h3fJOKy9JmHR8zinSaIkZzOCXetiRKs4G3gBwBy3ditck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e728f7-63fa-48a2-d71c-08ddae5e445d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:50:05.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moO6MGLVWQsZ6DHBWxO4U0kvlatiV6a/4OI/hDpbFjdFIBj0e+aJW6loMG6+LVnIk3GIIbnN8X18UXUZUsB4sBRAeRJMKK4RRH+FttYCgCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwMCBTYWx0ZWRfX3qaFEnDlhMcV Ste2RCx7tQ7sebur0a3diNihw7+zMVyp2DGH3fjsAniaG2xxhmlhUr5AcMNIQ+Ouz9IxeloFFFe pFcZIXSE3XJ/eRsaq/DOQhLResqxa7gb6m63cESCMWp4dbUGVrjn/ZHatQWgfAZuVNfK06TBMZB
 PxFhIHWfSLDbfZm4U1zr21MRyWBcC21wW7VnuueDcgD4p2jotXywgIlaSm/mdZ9SatV27nZkJql Esu5l+3g3218gbjuCguCz2+5gsG71iFLNASI3V+LzMw/q5LjN9/xzPOBB1vLQvW698uz4gijSXa 5jyJYzXb6z0C5/uxCzT2TxXEW/LWEdn0hcNXKjMzkNNdEMyPxjQQgT0oH/d5lGzcPxZgm87MXY2
 KhKGhAUOS/fDcRTy9ul0XP2BGRYQVll7lRZtDwktWRoc9/NwY6NC0pXy6Jtvsebcrqrm2BOq
X-Proofpoint-GUID: EP3G3UxRfVVZNlggJL4yoZLbTIkSBpaX
X-Proofpoint-ORIG-GUID: EP3G3UxRfVVZNlggJL4yoZLbTIkSBpaX
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=6852a7f1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=vtPyAvLKYeMDjO8fKDkA:9 a=CjuIK1q_8ugA:10

On Wed, Jun 18, 2025 at 12:37:29PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jun 18, 2025 at 04:58:56PM +0530, Dev Jain wrote:
> >
> > MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )
> >

To correct myself for being an idiot before, 256 x 4 KB is 1 MB not 1 GB
sorry :)

> > So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
> > with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().
>
> No haha, not at all!! Firstly fixed addressed override a lot of this, secondly
> the 256 page gap (which is configurable btw) is only applicable for mappings
> below a stack (in stack grow down arch).
>
> This assumption is totally incorrect, sorry. I'd suggest making assertions about
> this is really not all that useful, as things vary by arch and kernel
> configuration.

You can play with this program to see what happens in reality.

On my system the mappings of first two VMAs are immediately adjacent, then
the other is >1MB below:

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

int main()
{
	char *ptr;

	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
	if (ptr == MAP_FAILED) {
		perror("mmap 1");
		return EXIT_FAILURE;
	}
	printf("ptr1 = %p\n", ptr);

	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE | MAP_GROWSDOWN, -1, 0);
	if (ptr == MAP_FAILED) {
		perror("mmap 2");
		return EXIT_FAILURE;
	}
	printf("ptr2 = %p\n", ptr);

	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
	if (ptr == MAP_FAILED) {
		perror("mmap 3");
		return EXIT_FAILURE;
	}
	printf("ptr3 = %p\n", ptr);


	return EXIT_SUCCESS;
}

The definitive answers are in the get unmapped area logic.

But again not very useful to test imo beyond hand-wavey basics (and you
have to check that against all arches to be sure your hand waving is always
true :)

