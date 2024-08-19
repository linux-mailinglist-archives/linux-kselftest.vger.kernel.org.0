Return-Path: <linux-kselftest+bounces-15719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59895759B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDAB284B17
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F4158A37;
	Mon, 19 Aug 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVl+rznQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j3gdkOAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF2158A30;
	Mon, 19 Aug 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099062; cv=fail; b=HPt8aMeihoaOKd47jLr6iuuL1OP/RwHtHrSoqecS2ySY7P3iAGEXazUfc8usWwVQAe89+/Pq1VOxFDOk6WICrzYrg+UrBrY3eYey1wJc5Tb7mul6X4OzcuEaGStJR0sYYnsJ7StViXAYoniArSytc+dSEbheJPDaYMDxP3nNBBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099062; c=relaxed/simple;
	bh=bNLbGJuAiNPj+3FOaGlW2U/9oNYOa9RFhvp0QBcgLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELNvP8h8aaXSEevaKkvERXIyMkueqA4KgX2t4xI9DN+r7DeO9oth733EFCVnOEAj6fPmmES6uw7nTo21P6cHDqk3jsyP53rax0XD7Wqv2m586kH+b/Lb4Yav3TrFfGPv6jO6ZbOynGCAZFTzw24LWlN9o2ITMYhxE36HaeY39+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVl+rznQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j3gdkOAJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBW6H007552;
	Mon, 19 Aug 2024 20:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NFcdmN2Piu/ilBg
	z8PQPHiwphNh/aLDycMq3/Q+9C04=; b=iVl+rznQokgQbwwv8QLTP8sMPiKw5Bp
	i0LaUz1fi5HOJykWRZUnPY//lTQoSKh2VnmHT+NPvaFZLGmH4OcCrv55RTE4ShJT
	BDZWs408PvkX6lL+A9OwyA9/AjBOoRu1DR9GgGjz3aamY2X+50SECWA33/Mg8ILx
	bTOfnYjdzcaZlVf6NjQhfrVPe04fE3AgPPFtxrFNIDPpkcZ+X67d2h1YaNr5Kdml
	RkcSNuvsPBIfyEpBf16md9XHeHuEdNvFIOLo85M9BxND/Pu3ag6vYl0D8NS5c6n0
	qZjZxAfg5n6CeTfly2I41PRC70FuHdoAubf01Q5c+WGsRQfLe9pGb4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hkgm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:24:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJbWap003084;
	Mon, 19 Aug 2024 20:24:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h8r3cp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4In56YoXqNifEDdrZnf8XKO/XnVrAErDWVLFvx5bHfVqs6mX726Tx3JNedL5ntygUSaZqm7EExF57fd6y7Bff2r7spl+EiBrkjjw8cPQ4K/n2zZ5YOzTj6gAvFCpBpiXZ4QoeqsLr7J6O2sRn/nKPKZAnLKwXrLwBzbet3r0+XGzWptX0wDXwPyATYnnz47v6AmV8fxQ62hf3g03WkptZG+6zQE8mjeMO+84Qwr/9f7ahwm3yWvkdRkS7nizSucAnySVIjsoTZ1WjvoDQjBgo7xdXXxcMBLR9rqMrwDOBQn1mh68GfDoedg+bQqud+e5yBNa+ynlJ137sBI5i/4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFcdmN2Piu/ilBgz8PQPHiwphNh/aLDycMq3/Q+9C04=;
 b=RIpzoLpC0/zQWN9JqTjT+BSVB4TYtJWAh8MTsc5gVrNGn9mwborIi2gCzVHJuguUO+QsjhZW2g1mgkipcrxv5UM982ChNt3+lDGVnK3+Q3x/WxIv3vQmnbO6gc4uVNXifWOqrESgVRoCzg8IpTXa37JHbeoG43T7zhINEmvFVBns8zW8erlt65YzAUYH6uqaOmJVFQSZeqolrhW7LnJ4FTqySQJvR3JoW/Bf83CF6TwTX/rSTT3ubavP6dQnEyzUuTxvQvJ0zRhmW4dO8JDBeKMqpgv/gy5D/KxKRngdCwr4/76TiMwFqXemjbH+4T49PDTKhhK0F/2nNlXgCXvUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFcdmN2Piu/ilBgz8PQPHiwphNh/aLDycMq3/Q+9C04=;
 b=j3gdkOAJYsff9F6eFOtKJeFmhrsCnsi0rS4YuPFxKAMb07ISO6myvalUJaDP8kyntWysoMO4YOqzmtsyzbEIBnDbiqjOoT4J1TNVDIh6C5C+jxyv3XMXxDYPV+b4+BFB17cnQvsCJCR4Tp406DmmutNt3AZf+POadWwN9bnVzRo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN6PR10MB7517.namprd10.prod.outlook.com (2603:10b6:208:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Mon, 19 Aug
 2024 20:23:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:22:58 +0000
Date: Mon, 19 Aug 2024 16:22:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jeffxu@chromium.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <bezdejvhkvdxf4nbyraszotp6vgknbxw5rkue2m7wkr2i3zbtm@35vi7lcysoeu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN6PR10MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4872b61a-dd92-4e21-e6f6-08dcc08cb76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcpHZi2TKUYOx+8Y0Mk8D1YlLYMLq3NwYjaMHpQlmUM/jqGhUqrFcd6iFheC?=
 =?us-ascii?Q?5EwxFG+eKCZVeqZ0RWoDRoOeDwS79aW1dS/vD7dIk+bb4H9rYFiqTfo3OuX2?=
 =?us-ascii?Q?pAV+EKb0lPE26i8mj2u3oerMvBWONZ0cU/2cKkD9IJY7cRtgwqgo+AUUO63U?=
 =?us-ascii?Q?6COBcEgYI3URh0fGv4hW90RWFPuDSGy08BYNZirM7Gc8WlcI/pVlE2OtSXU6?=
 =?us-ascii?Q?BWbjZdOoOXN8blMMCqQh6TvNWSw2Mer8F8vhAgU6Ud5D5naBEPVIKNmQMnB/?=
 =?us-ascii?Q?UDOXagAmK7LdFqHYLckcZD6Igudntv8PKn3NNJDtHZlCuLphh7BsSNgmq88e?=
 =?us-ascii?Q?4aY5N6rj5T3IxJwdSdyEQXpTimOtV4xWwNoadl5IXGpxwnVygL5sUlywUfVF?=
 =?us-ascii?Q?ooLbjrHmYALC9F0GA8sQ8CrwEL5Jh0KrefX6v4DBQSYkrbqleUIczYX9IPmq?=
 =?us-ascii?Q?Rj3BCGByUr4e5KtcWPn+vrhryi1RWbWdRXB9JfDit7iFN/ynBovv/Z+tQpLx?=
 =?us-ascii?Q?TzmkqCLnvE3F19Fud4X0n7VMcb/1MuoMKaeanrp3WfwRsy85MKk93bXW01VK?=
 =?us-ascii?Q?5TusXeBC7f+R06Qp9bKMCUJbI2SM0ADdhLJcO+l3nbmC5tw1NqM5U1Nyoht8?=
 =?us-ascii?Q?mYC3CITzkrGWpNxPcGs8OWuVSM6vdACgweHodJLVfv4ryAEYoIgZxHn7Fcx8?=
 =?us-ascii?Q?TX4SDkVVge9HezdNVf2nZXYpEnJfenh/1OgZf7OPm7JRQ29fr5Cqz+B9qG8w?=
 =?us-ascii?Q?YpbHupfEAMvJH0s9Vh1HjZIhEMYzJD37PS74FSNztsD53jSKm2v32YBQSqju?=
 =?us-ascii?Q?htk+yzEngoXwhtfmGKvKyonIMY6GhbubEMioMSKW+ObT36GRpBP5FYKirw+J?=
 =?us-ascii?Q?nQvWXafJdanFd+RCepSO8O0p95whRYy/JAn0LF67Z17pggGanzTIQXXBl8Lg?=
 =?us-ascii?Q?JteyHM1FSbwNyc/W7AUvgpkGGpCtUupDCX/UaobWsk7NveAvTALa5Lem8Z5Y?=
 =?us-ascii?Q?sTecW/uHVLM5+4PXKFuBMA8j/rQrHVoNcfy7jIh7oRRUpj5Q8eR1CwOpESrt?=
 =?us-ascii?Q?/ki4uERXdv0ePLZKEs9Uf0pV3RRdiN2L5XgVytO7ZQ6CvhatZfXbuVA9vJlf?=
 =?us-ascii?Q?+cEWdCwiiA8CN5s6vSc97c4+1Q3JpyChqfbCLhgVoMHAyuBLU/Q6knAtDJKm?=
 =?us-ascii?Q?/cTPoQIiL/+Yuv/lapEaIIyq64aTUS4exQEEIO6QAy8hTGPkSr9hWHQbDXcP?=
 =?us-ascii?Q?HFvBaQGI8vP1J9A4ZtPuJVkZo7wMzQA3lQX2oH9BRWl52YojUdDhQawVA7Xg?=
 =?us-ascii?Q?hUH1Eu2xjyx5U/v54Uu29fIW6ffXZZ9HN8kYhIjn+IJ0mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFdvFleJd4yRfBItLofDzf84RYCsHCayM3QXgpZ7e/ZdvcOeZTWmfNTcCSoN?=
 =?us-ascii?Q?UiaG/uyw7xjEaeaX6EeU4Eq0vooONMi2CdutP8hK6iPRoc0HlbEpI3vyf3mL?=
 =?us-ascii?Q?8ypGSiON5GUSHZBx9IXw+Nof/+kPWOwXbvnJI/yjiK5slsVb88glD7IS2Q6v?=
 =?us-ascii?Q?ui6iom5M5JovCAgt5k2fu4UtqN1qMC9QOOWKN/1atIpMdluxnzkwIqgHuoXm?=
 =?us-ascii?Q?oY+aCMZ7mZ/e0aRXKhhVwcbc3f7oLZn8FAOUKO+7alCfzTcrf51WWn1o0sD/?=
 =?us-ascii?Q?d3t0HB6f2B1ipInHd/40huVRHmlhpDbpQ6c5lYAVr/RsTAMPU1hyVUucSI/9?=
 =?us-ascii?Q?dm4eWJvy9JC0YsZxCVsnfP59GaEHPYFbgTzuUEw1Wj6E3ueOtwvW3qMnwHZi?=
 =?us-ascii?Q?+GdmdroYVu/syE7Fe1zjjeoJNSTI8DTfv4QmFc5WYpfR7Loyhav7+Z6WO2iT?=
 =?us-ascii?Q?IVTMt9hYedWB4Ruzei9slMfHpOiXFBHw6l9lOAaPEQjTfk5uyMhqvUZXkCaY?=
 =?us-ascii?Q?SGDSCDuk46YPqT643g0c1zDqC1wXeQ/7jvD6Q4MEX+w+EeaS/0lMNbdBeDAg?=
 =?us-ascii?Q?x/P1jO/fjHHlgAGARs0R2wf6KP6jixe+RRIfjtvo1XTfOMtTvb6tWGZOnN5b?=
 =?us-ascii?Q?aNso0pHxdDUbgJlpvxllPY8IMfnt3pDFLvqJuzMVnXKBw9KZ146k5Xe1tFEt?=
 =?us-ascii?Q?tqOuA0+Siajl2yjAUvs35vyDBHqtbc9iiRygJ6YBnz1UmARXVRyxZPCG/BdS?=
 =?us-ascii?Q?Qzth+zzKeuyBO7g4+T8iXaDMbKtDzLV6mgDd2pNfERTOtwdiH+LBUAfH35KR?=
 =?us-ascii?Q?yxM0rgxyzd6snqVz5msNHQQNKcLra2visMJiU+yLNuF17RsUv89Apc6HncaS?=
 =?us-ascii?Q?pCEQo1dvwFq7uu73fbbzi6DMLongOGn+1n+yj8/aGHDXEZKfJ5e7qSFKJP7L?=
 =?us-ascii?Q?gRxlem+5FQPBLoSg2Gsku17IsMd2wVHZK2mIdHxO3jo9D9M5dA8Py99uSMcx?=
 =?us-ascii?Q?AkT9IaTJbN1BefRqo9KOOtNGB3CJNX7V67A6+c67UIYU5BQnZy0wCdITOmn0?=
 =?us-ascii?Q?ytHnqknL5NELOQKqip3d3R53Qxzi87DEN9oysbpaszb0y7JQvYTZFCxYbDlO?=
 =?us-ascii?Q?IL8Vk0FAyo37++piZbmUCVQiWp9bujWbrtZ2vgDOZd3kYX/qWRvG4riUsqoz?=
 =?us-ascii?Q?w/kBFEcp33hVopZZuusRS5knAsgbLS+AHt2Gecdfa8TSd7Lnv/IYDKKTEJjZ?=
 =?us-ascii?Q?SweGOGRBYHPTyRU6aeo8fk9PDfcgnkmZclnsAhG7m49Yyk6wD3H3B7iRud0i?=
 =?us-ascii?Q?DlIy/SAuse6Ca82o6LXaJezBd/8cONxOxhifnqzc7jgZNI+0B4Kwirugei3g?=
 =?us-ascii?Q?s2Mhn3x67foa3MIr5DNY2idlrl8N10saJ9WN5UP9G9hiBiToc03KXbfL4KgM?=
 =?us-ascii?Q?FWs2Ix45RgXtdAr6AL70hBow4hzNivmO0iXjuyZ/gF9Ntf3dV+YGQPzH/vbR?=
 =?us-ascii?Q?6DxHBMlSneXD6ckJ2byQlyvBfJ0EJOrbvy1B7itSHDW2qgYSuK1ef6Y11grk?=
 =?us-ascii?Q?Wp5OQqHztTicikjGvKrXg0hQxlkYGJUqIa5Y216I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hrdLEoTEddYK0xshjW/KZDnvxASOGS5VXhnEeGE1ptYQeGyRO+DPGIReCDDBOn2p84ZjG9cpAFywzdE4zPJ87i2Jn/q22iq3rp51nC8kf7XJXZuiuGzrS4gpinyP+E8GTtONG2CF+DM0itYcvkFE3xiGJN8/d4uboDVNDmGgT/EgulMifc6vtlYWSQopzL3x+koQ8Mpvr0bTwTGq1nQgwH7+2qAKMwvKVY4RfcJwpnshYcLOOeUVdKhHHQHpqP/dDi9js9Jf2fMiBqnJ751P6ap98vr/uaywc6GIrD3o1nn5kKgrd8y99TEkTeXcmaZIN+SVfzAPn7EurM77JXizHeGQL0Kmyi0a87d/8R6LIkftNE4sWjDakk5COckPmEgZUxZQreXrf/7/Sa1TjBco39FeLKpL9K9uXEngaAYthospBIXNedRIpOqth9/EO7fxnRtDfQyIVO7j1URB6Z4EVN6bFpNKSpvCRgiEbGmwlkCYXQTw1etOeINJxYpaXTsv+1xDxu3iFE0ZZDjsQWY+5b/n7ucFbCCjn0wAeevTo3xljwr3+kSLgGm0bcJ7TX92+Q56kOGYbqq1sbdKdCUDpKhrxD0puOVXjYdDlHkE93Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872b61a-dd92-4e21-e6f6-08dcc08cb76f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:22:58.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMCRlP8moILlkY68B12rtW8ZZIprNtVN7yZfW7l6xpJQu1Qr7doHi5hBx4QLvatVKawcYH5HIB7gjtnJEPAuDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190138
X-Proofpoint-ORIG-GUID: tmKgF3s2aQHuzDzSr1NCg1oyhDyoK0R5
X-Proofpoint-GUID: tmKgF3s2aQHuzDzSr1NCg1oyhDyoK0R5

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:18]:
> We were doing an extra mmap tree traversal just to check if the entire
> range is modifiable. This can be done when we iterate through the VMAs
> instead.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Although this has the side effect of potentially splitting the first vma
if it is not mseal()'ed, there really is no risk here since someone
making an invalid call that splits the vma for whatever reason can
modify the bad call to achieve the same split.  That is, this doesn't
help or hinder an attacker.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mmap.c | 11 +----------
>  mm/vma.c  | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3af256bacef3..30ae4cb5cec9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -	/*
> -	 * Check if memory is sealed, prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> +	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
>  }
>  
>  /*
> diff --git a/mm/vma.c b/mm/vma.c
> index 84965f2cd580..5850f7c0949b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>  
> +		/* Don't bother splitting the VMA if we can't unmap it anyway */
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto start_split_failed;
> +		}
> +
>  		error = __split_vma(vmi, vma, start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	next = vma;
>  	do {
> +		if (!can_modify_vma(next)) {
> +			error = -EPERM;
> +			goto modify_vma_failed;
> +		}
> +
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
>  			error = __split_vma(vmi, next, end, 0);
> @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	__mt_destroy(&mt_detach);
>  	return 0;
>  
> +modify_vma_failed:
>  clear_tree_failed:
>  userfaultfd_error:
>  munmap_gather_failed:
> @@ -860,13 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>  
> -	/*
> -	 * Check if memory is sealed, prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
> 
> -- 
> 2.46.0
> 

