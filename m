Return-Path: <linux-kselftest+bounces-6713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187588E863
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A0A1C2EFEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231D12EBE3;
	Wed, 27 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9bsZV64";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+vr4omv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48C12EBD1;
	Wed, 27 Mar 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551607; cv=fail; b=g4LwwapstMfmSi47HcOrdes0rgCXgcR93jl+RvCkpbVxAsGFP0IgrRMR0QXTWls+Oaj/a1ROaJzHzIuOcyXqtbC6vsC7ZC+JodB65YomqADVAzUU30tvtXr2V1Hj0xkCPxxecBFPwimgZeQNWWCUqRAInd8dGq5EcBL1gpE63tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551607; c=relaxed/simple;
	bh=QcCzq1qmc3nPR0QPl6inVV85x8uR+DnDT2IJ+mEWF+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnF+bwEUQ7Pkmrp5WnErt5I/H+qsD6N+5WdilBHRSnV3uTE4Ly3SUPtNBhnqaPU+h9aFYb5t4RDAg8ZC/TiF4P6TjEQCn9+UPiMcewd46Sp7pr3PjVHr9S6fBt8t5PpyfAIVJcGHZVNTBhLhHXx9v2zOaMhC5V3vi+60ecmwL38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9bsZV64; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+vr4omv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42REhuC5019502;
	Wed, 27 Mar 2024 14:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f0r6zthg5+qqdmmlg/qc3qs4zysUXczAv6I23TGzvvs=;
 b=T9bsZV641dTzC/MGVkybG2KYAaKY5XI2uVvz1RDY+WEtsP/vtUoBm3HG94INhopQXj6U
 ZTBS/LkU8kUhhBq45AdOvlmELmzKUTRINbGk4Y3kzyvoTatuGKL6h17kUm1kkjHL6vWt
 uW5gEeGcVg+MrCKWhPIT3L6l+8F6DjDfhqgCr2QMGiraN7vIZPma6Jh3ZCcfD4F6PGVv
 TelgG66uuc1SNrdFhCkr8wEyJodlV35t0fMDrPwt6HHiqN5OENSDbJZCJGr3R41fAPhj
 IVa3/U4gll6YdOHPVbExOUXxOKBmwvSewH60+ts5aGVgMHH2gPZCRJ+h3HkhWhpPvRxz kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy11u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 14:59:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42REBrXj015082;
	Wed, 27 Mar 2024 14:59:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhevqus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 14:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhV5CF71H3rNyXQB5LoVXdXMbmZDh+/o5Mye1c0WjTNkOjTDII9i87uP9/vr5xF6rboXxb8kBWfHR8vrJM451XjiJc07s3ZsPjOC670tnSr2cUl4PTje6CjOeTHCG169uJ44FRkTfeDawHX05oXcup0ZQvC1b0cnWZMv6/H+37drfK35MN41wCJCQRQoiQuFSV8OLRYcWMMhXXszPoKmThKwmlwjs3lYHiAIzIQ56/koz2e9tCOWr6R9ymTLP3ITWOksGQpB3L8uY8T60xB4JYAHf4ULhuWkmVx+ivDDxjX26WWyVzgGR2scC7crEbNpGQGEeKr0Ho6uH1Rb/Bo+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0r6zthg5+qqdmmlg/qc3qs4zysUXczAv6I23TGzvvs=;
 b=AG/O1R/obpVUIAGj36PpHyqm1jhS24ppf5N29ju7v1YbDFacKYMB0qv1/AG9IaxyZh4v5mclXiiIBV0eDQlgbnGx0nHaU94QsKu7iCCw59Pk5Zplm65qrc+sNVPbJsJBMjlmKqTDTftYvmoKhp+mRopluxf1J4yniYnS9HSuNel2AFoEB61J9M/Y4j95r986Il7LQNCQJe2+dX7W5f7Loqjp7/+YxaZDAOvoRlV7P+yeisBv8YCaTFngiJ6jqAbYm9u/HSx/weidE94Fg6YjfdrS9LbnMHw5gM5CUMYt2fdgmES3q12BwXcug1vYCbpOXYxFedvQUGOP9k86gkzGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0r6zthg5+qqdmmlg/qc3qs4zysUXczAv6I23TGzvvs=;
 b=P+vr4omvHw49vatewooZhxMFtF/3tDzPu3gucaj8RjJ0IKSE6HUlNllEIPaLeWNNYM8KrXPWqJH6OuKZP9OpsNGfRVGUttSvgBZkmrQ2p/Pf8mPQX/tesWg/JJvTgn3Hsh3F7C1+sg7amnRBNA/58pPdm86SM5/fSJ0HREGIqu4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 14:59:50 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 14:59:50 +0000
Message-ID: <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
Date: Wed, 27 Mar 2024 14:59:44 +0000
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240327114958.GG8419@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: f109ccfd-9762-48b7-6ae7-08dc4e6e8d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DOD0J/GKqPi3QYF6XU9JuQ109l1Pak0qBaUD+SamsT809IYWD0GrJwSJg08rVhbJFMSg6arnO6ALssguIa8m9UwqRUM+zkOS39KHZV45iZWKj07Ux0AatdrddIegWpF3bQmRGLD1y0xs2HO9aVtxrLl8g3rxHpODUnMFCpBVKBRcBKoaJOOvrHA1Pf6gCN4EMzpmJPW7+GYgDOrij4kEjGelNa6NoaKYxvYYPvhcDixDqtjbfSbDd4XJGQ1mtZcgEI1j/VENovoTNiyhqH6aOanZ2wA5LQMpBRmlxzVn3QSiP+cieyul9XFtHqV8jUmurhtw1MrPJgZop0DCvb5ta1h/L1QZc0BvgLM0IsSKkqo0Dy2jAK4dl49hdQGgj1J/knPjTYcoRYvl9SvC1I1UkrsLV32xADgXMZ2LJRvEVLQHzMuoeIxK9NWFLHO+g4WKjQ52S2I+/rpnPmttzmKnJmExkauXz44/r7jgm9uepBoOuTpN0foitO0dZpDjOvgz16nnmSFJFp7B0thxnswsRRbX1bvJBT+yUmE+WeSwGMydTPGQOC5BQdHYOSD2bwKy+1Diqd23jHHadWD3gjCmPqgup/dYuVG2aXi76iuY4N3o3+9myf72X8C4QNc0iW8J4/Ubq75kzPZ9GdOEWtmXsmIGaW4bbWMjL8qTfNfTYZk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHdUTEZXZjNkN20vemNibWZaV2pOR3ZPM2l6Zks1bFVGbnR4bWQyMWJVVXNO?=
 =?utf-8?B?OEt5UllxVkhSNmhFcC9yOGFLNXlLZHRoN1RDUStia1dmTlZ2Y3U5RDNqbkNV?=
 =?utf-8?B?QTQ4UlI3dzlrUU5MYWFTcXJFUkdsYm1FeUR1WXNhTDNnY1J1RVdjdUFUNkNO?=
 =?utf-8?B?RFlDOVpPNlljcExEZkZXdml3blFSdGowTWlRRVVRMEpGK0paa2VHek9lRWNk?=
 =?utf-8?B?TERZRlozVlhFNmFhMlZBZlZIN3ZOTjhtZzdUU1pBMitEeFBYRkZVYUNnVDZ2?=
 =?utf-8?B?aElMR2c4czdnbGxlWTBZcTk2ZlFnajlvTGp2bHJsbUQrQm1vMFVudFdsLzJB?=
 =?utf-8?B?NHhzYUVPem5zL1lZTWxGQXZVZ0N1MVA3eW9SYXMrOWg0OGNTUW9neXNSeUNk?=
 =?utf-8?B?SERMNzdGUEd4Y2ZicTZhM0xOTGc2NDZtK2hLQjZSRU5FNGdVeHk0MFpvdnFx?=
 =?utf-8?B?Ylc2bGFJRGtIUFo0QlhPRkt2OE5KaVdGOHE5ZENjYjVDdzZQaXBnVjFZZ0R4?=
 =?utf-8?B?YVQ2anllV2c4UlpSTTE5dFU1NkJTbDV5T3l2b2tTWFl2TUxKS3krRERsRk56?=
 =?utf-8?B?MWp4YUF0V1lRazRTS05XWUlIRjExeXZZMWxQTkZBWi9ZV2RlMmpLUzJlQnUz?=
 =?utf-8?B?ZDFoWUdqVWFGRWVYamdSL3FaQWVUeVZlR3VRUTN6amdwdVdWUGhQTHBNaGMw?=
 =?utf-8?B?emdodVFML3hjOGllVmMrVlRxQyswT29KaWR5WEgzZnF6ZSs3MCszZkQ4RTJ5?=
 =?utf-8?B?cXd6R1pDWG9oU2tLaUlMK0VGNjdzTXVWQjNRNk5UZlhNakF0dWV2bTAwVXEy?=
 =?utf-8?B?bWxlbm9WdGxWaHBqOUZUbFJDUFJJYW1waFpDbXRsVDMzUkZqUDRFUjJqMWJp?=
 =?utf-8?B?VVNwWENjSzd2SmRQSW1saWt2aXl0TWxSSjZoTHdMN3dLOGt1bkE3bHlIbVVP?=
 =?utf-8?B?c3gwUmtkL3dWbzI1VDZtREh3TUVqelZPN211WGU3czZ5UFYyR1hNeGQ2SUYx?=
 =?utf-8?B?ZW5DQnBDclZEUmpYT0UzWE9rWUlIeW5SVVlEUVhWenR3STJ2RlpzZGlPbFNW?=
 =?utf-8?B?Ym5ObEd0ZlE1NkZEbEJpRWJ0SThQMEZYdVZsVFY5ZkRCUDhoWGNZZ0h2dlRL?=
 =?utf-8?B?aWJ1ZnpwS2RoejJYWFlWMmE3UDRxQWdobTQwNnFkZ3haWUo4VE9FejgwaWdC?=
 =?utf-8?B?OWUySURBcFlXSWo0aUFsREhXS2JWZVZMU0EvUHo3VXF1RkRRaXVmRUdZTnhx?=
 =?utf-8?B?aFNWMU9EcG9sNFZMNGIxTzJOdnBCeGN4VFFVRTRnZmVWMENQTWk1bFJDMzFw?=
 =?utf-8?B?TXdialdKRUdLU2I2Vk5KTFlNcTJSVkNCNEdZTHI0eHBNVWgvdzlEelo0cEZM?=
 =?utf-8?B?NXpSODNyVkhPUjZzYTY3Z3VDMHcxV2k3blJWN1ViYU9mVzkyQms3cTVUbFJP?=
 =?utf-8?B?ZWJtcUpEM0x3R3hrNEV5ZjVrWm9ramdNUk9yYzk0R2x4QzNOU2pTWlZxQWla?=
 =?utf-8?B?dVlUV2ovWXkrU2RYbkhwNHMvaWE2VUVhZnNNa2lpSTQ1RkhJOXc5TktwN2FD?=
 =?utf-8?B?akRXWmxiU1B3dTljQnBvUFI1TG1yRllEQUVsdS8yTWNSY1QxTzhBQ0Z3eEV1?=
 =?utf-8?B?SldTNWdyRmd0N2JxYzU4bldybGJvOVNtL3ovclY1NFBuZWhzTnBBb29Qckk1?=
 =?utf-8?B?QmhFR3hLUkdrazgzejF2cFI5WGM2amdtbWwrSUd0dU92UzJ1anJyWDlRYzdq?=
 =?utf-8?B?K0JGcXczKzZ6UHdaNGZLRSt0WEp5ZWE4M1dKd1ZiVGpycjNMR3FYYTlXZmEz?=
 =?utf-8?B?SnFPR2tSZlBiZWg1ZXFPQWhESDNpaGtNeGNRN1lUaFpacDZLRjZ4ZU9LRkZm?=
 =?utf-8?B?bVlYVndjUlY5VjQwMDlPSk1IbVNRWEdLRFB5VVRYdjUzekU4dDNYYmphVjRY?=
 =?utf-8?B?Wi9ER21DWTFHNEZqQkdHYnE2T0hnK0gweUpmYWpBL1NwVnljR2FEejdyWEFm?=
 =?utf-8?B?WDhIL0ZDeGl1SUVyL2lhU3BoblU3MjdHcTkyNVBadElKMEtLdE81RmVCeGF0?=
 =?utf-8?B?QVdWRGdyVmNZaEI2R21ZN1FYYzlYNnJjcnJ5TStsUU55akltd1pPRmdxMGV6?=
 =?utf-8?B?TkpqcXQxUUhQbVlZQlA1SlVNOWNobFVuWmRMSUxFRzNEeHkzdmJQMWQxS2Qw?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hQVA1Y8hg9Z47jIZVFvMfZpE4Pnazk9FZuNinJDLrhw4ItqFxP5CLKntXJBKT6cPIdte/E9jBEr1zg6Tps/rWoA46sTZ4HcJSjjoVWNnmmb/XEumh5ab6lcW+Qp0SYnUnggnjfq2EEhD3oUtVNf8N50nrXVvkM0vLjU+x7LVCMbolyuga8nAWPxhgn7xrTZnTXn1H4VF8vc6u0oY7vhpIYLuixtH3CIpoo1+tTJi6374NagdzIUhL7YJVVNPYWG14614q6UY0r6khCAORncbNa2AAlDAKzYw1DBmAToGtrsyY80hu0JuwBjKc+afAxbqg8HarFaLwhXwyz8uv9aP4yTzkzjK8GKJIe7WNTEoNlpHpzFiaNGnTzaGDHe7t+UxQxSxtyY/QctIoUt7D0nK27IwUsZF08yqrcd4LTt8yIKyHRXw0uvoLf2v5e3A2gyjF7g+PMhLADQTBHAstruitbQGJZuv1kN+sa/Bqwe8s4PKoCPNG7MUNxzXifPtp/X2WerL2pBWEsEWJR9ghcsuNBv6LV/tOIhIldqMtqqjYQmMbDLtGUpRrHbBQ6MsRz3qp9LwnHNFQqCtMHAxSnhEmR0l2Q9gWYKBA0u71/JPVJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f109ccfd-9762-48b7-6ae7-08dc4e6e8d12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:59:50.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSPCQGBNcZxRRAQFgOKiy/NBkNf/HbomxyzmDUS11B3xHWx2ozZBy3IXcV4sUvJGdcaGINukZHW5ELdQBX1OZYljM1q1NbbEZFCb+TmY0QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=900 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403270102
X-Proofpoint-ORIG-GUID: 485qmAULmT2aNToLU_6nA_Pk75kfIPwl
X-Proofpoint-GUID: 485qmAULmT2aNToLU_6nA_Pk75kfIPwl

On 27/03/2024 11:49, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>> Even after applying this config patch and following snippet (which doesn't
>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>> finding failed tests.
>>>>
>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>                    mmap_flags, -1, 0);
>>>> -       assert(vrc == self->buffer);
>>>> +       assert(vrc == self->buffer);// ???
>>>>
>>>> On x86:
>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>> On ARM64:
>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>
>>>> The log files are attached.
>>>
>>> You probably don't have enough transparent huge pages available to the process
>>>
>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>> After making huge pages available, the iommufd test always passed on x86.
>> But there are still failures on arm64. I'm looking into the failures.
> 
> Oh that is really strange. Joao? Nicolin?
> 
Definitely strange, I'll have a look.

So it set the expected number of dirty bits as that assert doesn't fail, but it
is failing when we check that even bits are set but not odd ones. Like it's
hasn't set those bits.

For mock tests there should be no difference between x86 and ARM assuming the
typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
that I can think of that affected mock domain.

Muhammad, could you paste your kconfig?

>> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap
>> not ok 139 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear
>> not ok 140 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap
>> not ok 144 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear
>> not ok 145 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap
>> not ok 149 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear
>> not ok 150 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
>> not ok 159 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
>> not ok 160 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap
>> not ok 164 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear
>> not ok 165 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap ...
>> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
>> not ok 169 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> 
>> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear ...
>> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
>> # get_dirty_bitmap_no_clear: Test terminated by assertion
>> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
>> not ok 170 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
> 


