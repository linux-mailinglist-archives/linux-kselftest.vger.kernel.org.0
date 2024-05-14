Return-Path: <linux-kselftest+bounces-10199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9498C5CC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD481F22558
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A32181D11;
	Tue, 14 May 2024 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2fsGuIm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I2bLGl2h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9E181CFB;
	Tue, 14 May 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722113; cv=fail; b=aIqtZBuwE3swaKMLDpuJ/qn0ZMwFv7U/BnDbYkBQ/NN+6W+btHcO0ik9QkqfQlcgNyRKmtTLdd6q1UBPKqVPVsZvS1y8TFzowh1OtDOYNQ7WIeCDlsugcvuLU2fUARnOMA5WoerFcNxYJF1XtJDRPc778MfpS5PhL/8FjKLsQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722113; c=relaxed/simple;
	bh=Gm4mTklvqM3tZ0xHOqxAhzeKY2wy1XfhtMNyW8XdMG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M4Vu+12J+eZYmr7Je1S2hcz9fXGAIbGowcLQJ+2jLm39wwCw+t/IXViu22cu1E1AH4/s2WYhbQJ/MsOeFEMZwHaXQqAOlkAXGroysiDCdrkGTIf+CEXVDmlhRRfXTT4dDaV68YDSLg1oMZK+tQ6eD927/A8A5NuibUJfO3QS8ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2fsGuIm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I2bLGl2h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKXogx031848;
	Tue, 14 May 2024 21:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=irLcmatCwLShR+sEVH6slZ9bx1kjyc/VvmRCcg8Elzg=;
 b=c2fsGuImYnpyB+EeYQGXkWCrzw5cKCoW+jgcaGp6LhzkIjx7+yFkx0dMe+I28RcSK6GX
 pFWh2GCdg5XZ64n+Wcc92avPI+yLYKHTe9jQzhAujdJebb705JLDuFapXKHFxFYrOaZe
 SHBT04u2ihcY7lEqQYpuKj22A5Fkw1ASDpXx1atMFcZ1PdSo9CDcUfL1kpEfh64UAHa7
 gETbk6yWWj6aNHOtXzAqrMQv5o+pAPbWAyLw4Amx8rkNk5BqcDVb6ErFPGTYnjnWTB0l
 qCgySrW7es7TWgM7bBJYmMuDrSGUpiaglFZRQp1t8oHmTDwayOKDjYwFjWtBCvG+gnIi Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx32spg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:28:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKZtUV018061;
	Tue, 14 May 2024 21:28:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4e4aue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmolK6nFJ7HSTZmsHdt+eAZVpVGayiSTJo17AEL+8YMdDaElsnqg8zX7lF+LdGONjahMdy8moipoINOdj65nSFMKX/QbVSu18kJ5BFnxX+I2f4WzTy0Y/GX8E8Bt8zVkum4b23FL8UWvPbuzajRe1U1H9V1YbclTwr7cMW3o2kOpWtLbrnsQBcXySg8kE54aCixf7x12OEYWRvVe9IPEZopkaN5UqJuC5KC0coiivevDkUk1P5XTa4xEI04YCT0Jtd6yGpyD38lFT+QcdGWoYeop5DxDtVXkRUAsOdGDyuZjByPQ+0OWVwr/8C729dW3pUhunWjBxy2FlxD8bImCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irLcmatCwLShR+sEVH6slZ9bx1kjyc/VvmRCcg8Elzg=;
 b=cUbEUwdHkOIM7qWZzmPtXjvzefGwTr0tcbZCJ9CcCUgyrP2l4BxS/MU26x9C7q5p8Nsq9loUmQBZi5OGuBREoF2kH7z8BfCRAT3P6UuBn2M422vv5vBqLdFxZJAZKme49xPLvIijdO3dNGSxIlIwn0UGLNYjT/voH8fDBD8lzrC7JK++bLs0Ccz5pY1SPfKA7v+EHuaT5aQkG9DjOTVQxda/hleRyMiqTayuuhqR+LnGelLYTpdZs1xYyENy46kZRZoM/DhJfiuruGBqNsiLnoXjnziCvCxu8epH0WiiKL4inWbcyBmP2c9q28kLNUyyIV+7nBxMKdJjgTzMddWD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irLcmatCwLShR+sEVH6slZ9bx1kjyc/VvmRCcg8Elzg=;
 b=I2bLGl2hBxA5JgyU93YVfkMkilnbil5vBrA0s45CgkKimNAg3GYNM0emcdZ0S+iM1gzajCVnRcmuVWPQt9o1zD2RX+L2MSbG0wS/KoqbDcoZgUL2ZhiSQTRqZp+YsN+maBKmVmOpRwLNJt3SmBGRumWhFziOL3TOfEfl0ECIgLk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6594.namprd10.prod.outlook.com (2603:10b6:806:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 21:28:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 21:28:08 +0000
Date: Tue, 14 May 2024 17:28:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, surenb@google.com, merimus@google.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CY5PR22CA0038.namprd22.prod.outlook.com
 (2603:10b6:930:1d::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ed374e-e786-4181-1acb-08dc745cbfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?d+5C0ixJ5pgyNG3miAvUdxKj8locXee5C55/2IjKlDTppeVi2CNsRN6hnBTr?=
 =?us-ascii?Q?asKAtoxX5bPnlRNLZVRyQR7TPLeodckG72wu+mqDVX+6q7pwUzBgf5mJNUOD?=
 =?us-ascii?Q?m87z6HKCy2+NHB80sZ+DX/DLJIVXfS9EJPhOj/xhKiL04ubBE+Q/byVHU/gp?=
 =?us-ascii?Q?lkURnhGQSqSf4oxZfwPzHlxLQaVquJUXCD6UyoG/L/KFVBruaYw3LF9gTX3U?=
 =?us-ascii?Q?hG0ucRTEXpirp5zV2gfQmxR/LRuWbbaRhhz1tdR/XmbqPYu2KCxnihTpIFrV?=
 =?us-ascii?Q?Px6ykc9vFkB+YUg2FfCIRDr3kn6+4LW/u2U6kBUXkhJpuCqC1EX0oO6svXWb?=
 =?us-ascii?Q?rPmuiIANJbuYEIx/auffhhIhw7GjZCeTUHcQ9SgUd4wGWoOmrEEWxLqsIQiH?=
 =?us-ascii?Q?Ts0isTK9vxSZazMc+ESrP3O1ClwzURKgOAWFNTNjulO7t2zlOnvTANsKjNCi?=
 =?us-ascii?Q?/c/UTdqnUElUknGR2TTdZN03fd3ezMbOThqEFjY5PEgZbG8z6bRdc2Q1slZU?=
 =?us-ascii?Q?eV0CTQ4wOTnzo+NpCIlXoLj4MyXfd9CK9dZ9JPsK41vddyY+fyhWL0Hwcdme?=
 =?us-ascii?Q?9IAFWcqyMMjD7iLZJEoDlyYNEt+C/aBv4t8C96n1OJyfgIrzAIQUodaIIZTI?=
 =?us-ascii?Q?VrX/5IpA0gYxf7LBKvLXvcRhUdGowCK624SzGfwvIaLPVBNcrsVTTF0RzUpp?=
 =?us-ascii?Q?eIEoe/DVDr2hnkHv5QCf5wtQKDMkoANJpV18m9PES2Simgg3znqJfSNn49BL?=
 =?us-ascii?Q?8E/0QTdsabrKVUr5g8wu7jJa1tvo2gMjUJgoa0EJlJ4H74Wk5iPqkAu38tLR?=
 =?us-ascii?Q?6sutGBwyfYarI7b9yLUVMWkrXLPBxaOMcxLmxYKpQxFbpRdV6L47Q2djEkNU?=
 =?us-ascii?Q?uWBQId73HM6g9Rl2QnUByXkkGCvScNZrMHobNBxsgkFwTfDlK8YBGIrfxmtt?=
 =?us-ascii?Q?zHBmhW+yrkswqzYBMXyyeef1L0B3rB4vqxP/YfaIaC+o+C2h4SRuCJjzrGTi?=
 =?us-ascii?Q?vQjAAeMvf7Savt47n6anrp3K0hrqEYvg2tpc0xyMnmnOAgR1dBRuLvg3Yo4S?=
 =?us-ascii?Q?VpFabmsBqaScK6MUQUgopRxwxjYJWnRp92QooUbP/A5WN0fzpf1Wz1axzKu+?=
 =?us-ascii?Q?C/HPlmENUnyMxn9b0AmxUU03+u9fbkTkxI375WxSC76zvLRNJXVN4CtKOLV6?=
 =?us-ascii?Q?nrR/vMxPXUuzL2EuNxu6WIe9vYEGLGusXVJb8F0XQctjsnNReQcCoBCY5EeQ?=
 =?us-ascii?Q?GYKfTVzV2kAMDoIhR7mWkH5trvItlVdZe1YjRTI9Mg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jcpqC1nj1xagMhOYQh0/UJvtwlyYNDHVr0Eljic1r+XJYubGajzSK22ZLd0B?=
 =?us-ascii?Q?xzDWSbTo76AEr7327NOA+W0S0vUsato84IuZ4dfDF3ZDlXsnm7XbTDC0oJBQ?=
 =?us-ascii?Q?tiE4OiSXnOnN2+oNu/aeXXlmCdnsNQdDHaNi7ZyIuq1lcOCXF4rO8T7/3jcm?=
 =?us-ascii?Q?Z8VYUhdfrpWrot0+7JQtd1JawGoLhL5My30hcs4gmRRdgeAhOnCCIvoz6sRg?=
 =?us-ascii?Q?nJBlrtvWngpP/oCfDoxBtLKEffzu5rkPutE5INr3DcoQgGa/Z4bJKDklPsRs?=
 =?us-ascii?Q?LDOm9vOY3eF8u9pmwDbz1cv8KCdfENo18ADz3dND7EEVw6aBLlaEt2rEhZHa?=
 =?us-ascii?Q?sHwX4r+QmIiYgG1c3jDId8/kvZsDp34sQZwz0KFax0xucoHR99kHSzisjAjq?=
 =?us-ascii?Q?wKG3XbyN8ffAsVNdwC8PTfMCry/Ml8UR7eagDoHVPsBXmehqMw8ljK+clxgC?=
 =?us-ascii?Q?zAH0fTToopQaFaMebemW4Crv4niQFlBbeznzIsjz5icdBEqnpuUbeQVmyVQ8?=
 =?us-ascii?Q?vBS6hQ22tBYiIt7oSXYE8kLm3vLfiMCZMGF/LXFi06EOPGEp4CJpMBGc0IPP?=
 =?us-ascii?Q?OoA6Z8m6Lw9qHT0FXv452FxQXPSAsjwbugTG5YWxYPQkJhL/Bm+yjBJCp4jM?=
 =?us-ascii?Q?vIvzLkUyx5Lar54Twb37gWtL9eUIRIOokfD3TvKtrHSOPwTzlLJSCVJnFTre?=
 =?us-ascii?Q?qxQY0WIx41qZWlz9I341xB5B1kYj7P3X316UYJYuFoxb9RqgUVSiW2IcW5Fc?=
 =?us-ascii?Q?tJhWKgI+9bVDFvXr4lXv8HcVro3ljovUKeBpnFcn8xkeoC/IJZO0hV+O1KL0?=
 =?us-ascii?Q?kLk81l3mBBevNstrPtGyizSgAznTtrVSsEFPXULUa028bgbnr32InC/Jwif4?=
 =?us-ascii?Q?+rx8teJk3uNZmih72k0YAFKXY5BaFDvcBMK4DsE/BjdGOsqaXAVf/q69LQqP?=
 =?us-ascii?Q?k4RLtnIWvskhMe8ehF4RBA+Ud3nZ8ERW50y7jlrPTKMaYcESySHUQnnRfNgp?=
 =?us-ascii?Q?zIk/QfLNGu1XJGCasl7S3QVh4+vagDLgO/tham32xT9cGvy9cBxV8yomQw17?=
 =?us-ascii?Q?pwIZjYmf1r5TPTOLwsbA/Ce/dZPsO4BXm++JgDxaa86AvXmdTaJkke07H4Me?=
 =?us-ascii?Q?k1WxRgXNKFp/mimcLUWCDa7M37AXgy2Y2NQQaQEtLzo//ZdgvSlJA2+eza7f?=
 =?us-ascii?Q?+RlCzmhHJ05PIg3NrsNG100KEMEj62AzVpCRLw1KnckFH9kJq2cPC9fGXFT5?=
 =?us-ascii?Q?dIZPQij5pBCgz94M40jcnwifzVkohlndZwbQZW3HeufMEMS/IOIq4G/rKybw?=
 =?us-ascii?Q?RpR3soMbuI+nUZk/PrtFdSDc1yPP2QN08RLt0syCXRvBQL3Pc6tuPbAky9p1?=
 =?us-ascii?Q?c0aHLjwjmneShzW8og2cAwOC6+5vT/oFZT4j0gicmy54fU8dgmgLyAdh9vcC?=
 =?us-ascii?Q?gLMBQXYrDIm6tn/V79KGuqfuY9B1VN/NbvbUfCiWn3iFcWAiRRwg/bCo2O05?=
 =?us-ascii?Q?PnPToI81f07cLYPSCx6BLpTIvK9NmxmROjV5BOpCLkEUKUPHxL9vrzGp6sN4?=
 =?us-ascii?Q?k/F6MRs1+Bxmzkz2PPDYT5pAVyY61DDhC//Ivg/D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NniG8DmHQw8lJ4p9s5sneFpfRW/Uqogr4hP2jPIyxW4cjBVXUPQqPNURQOskp6gi+/6p0FTzOc1x3beKtHNepef9fI6W0sheUxVVDpvy6xdiTsQBsuzf0zvL8WgeVf8Jbo0I7bCbZbamyyGNtKHIVjNICGE+w/zs0MK6ttp7h3Xbg1jle43LFc61CaEvi3IMgB8DA5BNOhxiTnjfQ9M4IilGg2m0YYl84TIes5yiljBJZAcA49VovRWtXowTUQ5L6mRmCfbOZmnIyVTtYGatFVLvF4pso7xmAHN9840QzPEZF/zdGwRJq2nww50/+aJCdZw8iNr7LCjXMgQGTiP7uPoSy8ifqL4zuCEl8OqwP24rFv2peli7eDyxzB2eloa0nA6rVYjy5H0w2G9vjsRv2M2K6ARF2DEB+w6Hd31+cVIB99mhq7P3S7p9fL5FTpQt9RFexiBNZUDgrWslOXcG8vL190o+KE5GUVoNuVxsSQLlH2bQ9mdHKvBlRxWWKZO3CZ48jv5w2Wxa8XaTTHNH+55J8yHb92+HR7TRT6j6rNf2Njsbr44BCfGV5puJ11OFOkfLwzxjzP+4lU24DzeBE36b7+EPshRMIKTJslep9vw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed374e-e786-4181-1acb-08dc745cbfc9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 21:28:08.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiHJyxRE8tpQiQYshtfJEeJ06oVdjVFTFvpJjgnULUxOa74GdidSmjLf5YZNtjV0V6wBhhxL4dG363xoRAqVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140154
X-Proofpoint-GUID: NEXgMbMJ3uJWpQwNoe5UEWceM8Au6dc2
X-Proofpoint-ORIG-GUID: NEXgMbMJ3uJWpQwNoe5UEWceM8Au6dc2

* Andrew Morton <akpm@linux-foundation.org> [240514 13:47]:
> On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> 
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> 
> I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> of the total lack of Reviewed-by:s and Acked-by:s.
> 
> The code appears to be stable enough for a merge.
> 
> It's awkward that we're in conference this week, but I ask people to
> give consideration to the desirability of moving mseal() into mainline
> sometime over the next week, please.

I have looked at this code a fair bit at this point, but I wanted to get
some clarification on the fact that we now have mseal doing checks
upfront while others fail in the middle.

mbind:
                /*
                 * If any vma in the range got policy other than MPOL_BIND                                                             
                 * or MPOL_PREFERRED_MANY we return error. We don't reset                                                              
                 * the home node for vmas we already updated before.
                 */ 


mlock:
mlock will abort (through one path), when it sees a gap in mapped areas,
but will not undo what it did so far.

mlock_fixup can fail on vma_modify_flags(), but previous vmas are not
updated.  This can fail due to allocation failures on the splitting of
VMAs (or failed merging).  The allocations could happen before, but this
is more work (but doable, no doubt).

userfaultfd is... complicated.

And even munmap() can fail and NOT undo the previous split(s).
mmap.c:
                        /*
                         * If userfaultfd_unmap_prep returns an error the vmas                                                         
                         * will remain split, but userland will get a                                                                  
                         * highly unexpected error anyway. This is no
                         * different than the case where the first of the two                                                          
                         * __split_vma fails, but we don't undo the first
                         * split, despite we could. This is unlikely enough                                                            
                         * failure that it's not worth optimizing it for.                                                              
                         */


But this one is different form the others..
madvise:
        /*
         * If the interval [start,end) covers some unmapped address                                                                    
         * ranges, just ignore them, but return -ENOMEM at the end.
         * - different from the way of handling in mlock etc.
         */

Either we are planning to clean this up and do what we can up-front, or
just move the mseal check with the rest.  Otherwise we are making a
larger mess with more technical dept for a single user, and I think this
is not an acceptable trade-off.

Considering the benchmarks that were provided, performance arguments
seem like they are not a concern.

I want to know if we are planning to sort and move existing checks if we
proceed with this change?

Thanks,
Liam

