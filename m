Return-Path: <linux-kselftest+bounces-21573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB69BFBB6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987511F22B79
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50300101E6;
	Thu,  7 Nov 2024 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzZ6Ng8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850BD268;
	Thu,  7 Nov 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943495; cv=fail; b=KOgskTRAbZ0DYPe/uXkJR52W3XkH6BxBJWraEr1dJp8ql9rfUKYu+iAMYSgiEDyhc6QBXpexwdm1Y/ci8kC8mHA0/V/SaZUZW71W6blEXzyfkSCfLd0COdFaI1kM/Rde7U3hdhaWDRJA0RrOC+seUoNOcdjgPOTITyQzb2y79ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943495; c=relaxed/simple;
	bh=Yo2MCrp4Nw3wQ5fDGA7PUH14Yeed5ZkxzzwlOjSBjCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2wKVPP7dzPlf17Vtaak71y2wnS0YJCsRXujM366dypeXfLn6w2ghOlwoFOLEqntyATSrcCd6YF/bJ4MvlxJQ/jBU/GMclbzq//cIRIZyPTXi2aSRwMN9Y3l2G+6ih42ixtbjAlSHaJLFCnouooRCQbiuMOj4SjWtzy9Hun2bps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzZ6Ng8d; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN6sDH5/ybZ/iBBHL4nHktvoJmo3pdy9rvhSJrW0U2hNql03QOXiT9hL41S3ctpjCPZ2kVPWOe/xZuTkynlDIgWWg69cHOx+9ZoKUv0Pr62NUoc7EKUmwqKvrbTA/4V5OwxK8r7QGohj5NnxOeJC9TQfpjNhfzKRiaY7AyhqcHRt1BIazbZGFoyc1COH5pwwtu6KBiDVTqEwlLjbA+2zg549EflyTHX5sgrTbsngW53NmszrPnvXpHQn5FLPZTb9BP2ZLjAppkVwOyqKaWoMeaJVfInS11KZcZGdLSS4OOWMeGS7YZ6Wbf1fZxIdxOse+KMFFWtqMWqjXLgz7ZU7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCX8t0HSra5LDf++z/4+FpLmHsf4GIjotxIZH17g2EA=;
 b=Kk6FxZvC+fEWXcyrSOgYDAcCHfQVDH5SWC70unIYJHPcPvCQjTyikZ1GcbYdPu8braZe3JrYK99dhQcqsQzLVl2fEh6QUrxgTY15TtNw637PhpWHks+RFtU5Ou5sHyYRmgeSYxGeV0CHyANFxfbj+uP39W6Rg0q7/ox01jR0wuXzfipjEq/I18x8g/nOyl6SM0DXZpQ1uj9P2geDS+d/LpHbOpy9Klt3NKvggI7bsicK6yCo/Y1ip79kz0bpaKwSOz1T15fCCj7ZAHWo+Nkc7dEvkw79xpI7FcUXP1ZWXy60o7Ze5tj+NbQ6dGr1r+bTMvgE6t6Q4vZzmQecepoa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCX8t0HSra5LDf++z/4+FpLmHsf4GIjotxIZH17g2EA=;
 b=vzZ6Ng8dQNMg8ef6NMwPhAM4Xn0JNvUTTh+xKZsmCsr7rXgoaRnu4G9DTPazdhaDXBtAjBuISRNTL1Ozsj+eRvra2TD5ihfUgPiiqBE6GrKTlz34igxKAeLNkbtw9XmwV2vIzgfSfUgDmZXYMaRJ97Sa6oc2yx/lIbMIURGG6RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 01:38:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:38:09 +0000
Message-ID: <40c1587f-a6af-4851-8632-cb02adece66b@amd.com>
Date: Thu, 7 Nov 2024 12:37:59 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 05/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 baolu.lu@linux.intel.com, eric.auger@redhat.com, jean-philippe@linaro.org,
 mdf@kernel.org, mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 patches@lists.linux.dev
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <5d2efe229821f5db7a832d9d6be84217289ac3f4.1730313237.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <5d2efe229821f5db7a832d9d6be84217289ac3f4.1730313237.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0049.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e25fbc9-c72c-4158-0890-08dcfeccd5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eitTVkN5dHJDMHBKbnV0bHF2QkE0R1ZLbVE0YU5vaGJkaTZ2MnJzb01jOFZv?=
 =?utf-8?B?SW5ZSnJvUHhhZGpWN0FuYk96TG5RZktzTVloaUpLWWIvU0g1QmgvYWg3N0Vn?=
 =?utf-8?B?WTNTZWtGUDNzbDBNNnErOUQ5T2xDODN4SVdnQlpSQ0FJeUgvZ0tYTlcwSDZK?=
 =?utf-8?B?MFRHREg2UkJGdnVrS3I1MUZIUk5xT0ZTdUM0T096RTQwQWswZFFUTllHYkFa?=
 =?utf-8?B?b1o2TUdRN3QrR1dITDl2enZ1S28vbUFZZjQ2RGZud0ZmSGNhWmRLc3lNdjFX?=
 =?utf-8?B?WjBuNGViRFlwenFZU2tiT3U1QzRGcDliT1FDS0hIS0Y3STV0bk1sUVdIS21r?=
 =?utf-8?B?V0MzbGV4Tm5yTU05Z255ZzM0SWhDdjdnTGI3aWFlMkJoMXNtZlpnT0NNNzlS?=
 =?utf-8?B?b0tOblNEbURPYVVXbU8rQ2JwRmZWaDJLeWJ3K3dFNTZuTU1DKzZaVzBYVWg1?=
 =?utf-8?B?SDcrWTRSWXV2dUh1WkdxdjNzeWQzNDFQUUNiNlVueGhmREJpVmdibmgvREI2?=
 =?utf-8?B?MXphUFEwVHpWYXVGSzBldWd0enIrNXVpQ3ZMV0Q0emdQTURRZ0dOM2pGNlpn?=
 =?utf-8?B?VGUvSVhyK2RYY3pWQXpqa0FPdjlMd1RNZlBYOGk5WWZMZi9QLy9GT0xIbzNS?=
 =?utf-8?B?WHRod3VMQy83RWIxRk8wNEp2ODN1dURMSmxOdU5mcWpDVjk3eE9aeHduUnIz?=
 =?utf-8?B?T0lJbkVkK1grR1kyWUw0VWdoczJNTk9yNHlkcHRzUUtYM2NjcEVzWEtrSCts?=
 =?utf-8?B?bWRubHRDUC9CQ0hQNUlZcWRRQ1pXdEhzQ0wzbWFVK2xYNnQxUGdBTzhDajhS?=
 =?utf-8?B?a1Z2Ukk3ZlphMldScDZsaUJCVTJFYzBEWDJRRnJJNENjcXVTcXZlbkpVWEd2?=
 =?utf-8?B?a2lTNlhsMjhVUkxWWEVtU3VSVkQzSldhOGZSU2I1V1pYUzBsWTFmWDJJNFlO?=
 =?utf-8?B?ZU9Qb2hpVXJIbURabDM2SW5JNitlUkJUbXRlcDdEMmh6NjBZNjBKVUpDTW9Q?=
 =?utf-8?B?T2REUk1DYmk2YTRhUWllK0g0ZGUxZGFIVnhNZk1TZDQ5T0VTMFR3a3lQUkJJ?=
 =?utf-8?B?VE9IT1VrZ25jZCtHNnpsbXlYUmJxclc5dTZvMm5SOTJDYUJ4YVRJWjd0U05v?=
 =?utf-8?B?NTl6WnIxN0hwZlZBQVpuL3l0WXhxVmkwVHp1bWxGcGhHZUVvY3VPMTk4SVlF?=
 =?utf-8?B?ZWtodUJaSVk2Y2lzcFpYRzYrNGZwcGZBRUtOeldUMHowU3lqMDBXZ25ZRjZh?=
 =?utf-8?B?MjIrek9GWmJySWdMQk94a0s5TjVWTmZFRHhDcGRMdWNvVHpsdHJTa0xDQjNN?=
 =?utf-8?B?K1NNNkt0ZHlvdmhHZVJMRXZjaU9va2gvMnlDY0J6Y2ZkWGFTL21OcmQzdldn?=
 =?utf-8?B?ME9jTXZhaWorOVo1RDJjdGFNcWUrL0hzWG1taXJNL2lUclFqUXpGc1AvNnlk?=
 =?utf-8?B?U2ExaEVXNHlIdlpvOW1pRXVUNm1ObkRvWDZQNlI5YldLd1BCLy9JWEQ3NHJp?=
 =?utf-8?B?UytYK0dneEROeVc2dUNEeU80Y0o3VVVYZ1ZYNTUveEppQ1ltTVVZTFdUKzlG?=
 =?utf-8?B?anN2MXpBby9Tc2JkZWtoeERuZ0RBb2FPZmoydk1wRXZjaS8zcm03N1M4a2FC?=
 =?utf-8?B?QWZqOUlKN05FVXMvTmZzYmdzekhhVjZZWVo3RCtITnB6MUpVSWl0WkYyUk8v?=
 =?utf-8?B?QmlKbVJ4TlEwTFJEU0E2UUR6QWFXQWJJNWtzaTBic1RyVFdockQrTWZ0RWp5?=
 =?utf-8?Q?Tc2MXp5wOCJ4cLWd6Y4CDlV7QjNjuc2NakIEqCI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnFZRHg5YWJ6TVcwTlByMUx0M2FEdll3Nm5rTDhtU2tHK1lieFVFTk1qdG42?=
 =?utf-8?B?enVDd1hocnUvMlYzc3cxSTI0VllESFE4bWwydEhPZWd2dys1OWw0Vmkrazh4?=
 =?utf-8?B?SGNKOWppbDNlMVNkTkx1Y2t4SWxSNlJtUXQ5djF4VnJrQW1iV21DaGRTNDVO?=
 =?utf-8?B?KytUWHliZkQ3MmFpVldLVjJsUGNhRDVkb29qbFdyTFA1VnY3cTQxdGpJSkEr?=
 =?utf-8?B?ZzNXd0FDRC9UL0xWeHIxNmhiWXJUTVRNaHFiL1V4aFBaY1o3M2ZTZ3REMTg0?=
 =?utf-8?B?Nys5MGZFRm5XbHNHOVZkR0Nla0hDeFhiTXFMVG5VYXNlRmo1SDZFOGdCc05O?=
 =?utf-8?B?ZUg3VVljbVpGdEZDZWNvS1N4M1Z0M1BWVyt0RnRTSWRCa1lDdEFyclpPYURs?=
 =?utf-8?B?WVYxM3NLSE50RlBOYk8rRG9mdjhPQTZQU2pwdGMyOE5PaXozNHVkR3ZJbC96?=
 =?utf-8?B?Tm9RVXhLdk9JWENSTkFaZW1PUk1jNkdhR2dqRXo4RWZFZk05VEVZYWo0Ulkx?=
 =?utf-8?B?SEU1Vlg3cWt2eFZENXRxSHJWL1VVcnlGVExzcCtlZ3A2TE44UmxiRmdaRnB5?=
 =?utf-8?B?dWZSQVZhcWFOZE1QNndDbit1MzFONmlJSW1wL2htS0d4NDlvNnJIUnFJN01q?=
 =?utf-8?B?SFVWVkxQOUN1clNkQ1pCSmYrckVxUlFNU2J6YnZyUnI5NklIQStzQUFOMG54?=
 =?utf-8?B?TVlDd1ZHbThGWlNtTVBWQ29qd1poNVN6eFl3SnpSV2w3Rjl5aEV6elRiemlt?=
 =?utf-8?B?cmkyR3Z6RmdlME82NVhwNlpGaGdPK1NkUGF2QzZJbmhFRGtjWGJKb2Y1eVJu?=
 =?utf-8?B?eGdiTklUYXVUZHhTRmhxM3ROdWJFMlRLTFFIeDNmV1JXNUhiNGRMQVg0czRn?=
 =?utf-8?B?eGFxWmhsTVhPcTkxcXFIcmphRVFnNHFNVC9Xd2lqeG9yNTNaNVRhOTRxdXhu?=
 =?utf-8?B?OHBrN2RFeWJOZ3pGVDJqTXVCV0V1RE96Sk5naml4NTFmWmlTcnk1bTJFT2NS?=
 =?utf-8?B?WERQSy9lbDUwUkhlaVA3QkE0eGNsRTZrYnJJa0dxRnNkUllMeFQ2N2QrOTAw?=
 =?utf-8?B?aDdCNUtOWmRKcW1VVW5PSWxjZjcwT3V6UHJ5bWNLdEJveEMvbzd1NE5iUFNo?=
 =?utf-8?B?THpGalcyMm03a2hGczFaWWw5NWwvYytZUkFLS0tLU29XRjU4aGJHcVdieDI0?=
 =?utf-8?B?dnZLa2pKcnZjVklQOXJDUTZ2MlJpdHJ1WEV1aXdmSmJZSjgyR3F2aU9JQ3VK?=
 =?utf-8?B?TDBGSGVhR3BXQkZNdUI0TXdEUlVIU2JsaExsakJaUHI4ZzZlTkdEelh5Skcv?=
 =?utf-8?B?MUpmNVIrYk1xYmlUWHJna3VNTFNXUDkxbDJLR25XME9RVDZ4aXFCaEdQek9O?=
 =?utf-8?B?d3pqSjBaWHhkd2Rhd2ErMXlPYk5Db3VTdWZ2aVZ6V0JwdGZreXdwMmpwMXVL?=
 =?utf-8?B?WXVXUFZUSTI4eDRSZmUzVUYvVGZmY2FZYzYxSGdrRlE3YWM0dTBmYmFTRDhL?=
 =?utf-8?B?K2lKKzNwK01SOGIwNVNWaisxNkg5T1R5MFJJMlhvMlRhT2RnY3lkSTBkdkxM?=
 =?utf-8?B?MjZHTWFoTTlVS1R4SE5yR01wNGlhejVWdlJod21jY2haSkRNOXltRHA2a1Bk?=
 =?utf-8?B?Z1JVYWRBLy9MMHlpRVplTFNJa3FpTjUweDdCWkZkYjQvaitmSHdSV0pVZEY4?=
 =?utf-8?B?ZTN4eEw3QlJWbW00amZWYXpSWHZKeXdvQzNBaVFjRERyTU1YQldwQ2lxSVVC?=
 =?utf-8?B?cFVjdHBRZkVSS3N6RFdWOEpUSGFXelg1ZnJ5aEF4TmIyWTVpdXd1UkJLWjhi?=
 =?utf-8?B?N2E1Q09jZi9OQ3A2OWc3WXFyQzdDSnNUUi83d0NrbVZrU1diSmdPSUNvWC9h?=
 =?utf-8?B?OC9lOG5uMFF3Q3pVdGlzR2ZpTUtva2NXZU5lV2IyQklHMFhpZGJhQk54Y2g5?=
 =?utf-8?B?TXNTRGlnMEpQZGkwdmNpSzBSRHRSTkI5UGdkeFUzN2hKdUhKUmpvR3ZrTE9y?=
 =?utf-8?B?bEhrcDczZTV0bXhPSmQ3MFRWa2QvK09VTUFmcmVrU09pMEsySlJPRVJ5d09Z?=
 =?utf-8?B?ekdlZnlTWndFNHYwRzdEQkZ6RE50bVdxNndDUENYMFgvSFhGVDJ3eUQ4bFZv?=
 =?utf-8?Q?/DyV8qiGo4l/l57jPfmvNSzX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e25fbc9-c72c-4158-0890-08dcfeccd5cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 01:38:09.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIq0pCqNA89vUexYqGR1ktIG7jKUNZBebFYT7fokG1sc0Z+d5Yjs8vQP1aUcP2C20c14NV5EeKV/ojPOhuV6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On 31/10/24 08:34, Nicolin Chen wrote:
> Add a new ioctl for user space to do a vIOMMU allocation. It must be based
> on a nesting parent HWPT, so take its refcount.
> 
> IOMMU driver wanting to support vIOMMUs must define its IOMMU_VIOMMU_TYPE_
> in the uAPI header and implement a viommu_alloc op in its iommu_ops.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/Makefile          |  3 +-
>   drivers/iommu/iommufd/iommufd_private.h |  3 +
>   include/uapi/linux/iommufd.h            | 40 ++++++++++++
>   drivers/iommu/iommufd/main.c            |  6 ++
>   drivers/iommu/iommufd/viommu.c          | 81 +++++++++++++++++++++++++
>   5 files changed, 132 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/iommu/iommufd/viommu.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 266e23d657ff..8f6f0dd038d0 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -7,7 +7,8 @@ iommufd-y := \
>   	ioas.o \
>   	main.o \
>   	pages.o \
> -	vfio_compat.o
> +	vfio_compat.o \
> +	viommu.o
>   
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index be347f726fda..a8104d9d4cef 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -506,6 +506,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>   	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
>   }
>   
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
> +void iommufd_viommu_destroy(struct iommufd_object *obj);
> +
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
>   void iommufd_selftest_destroy(struct iommufd_object *obj);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 41b1a01e9293..302844136b02 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -52,6 +52,7 @@ enum {
>   	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>   	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>   	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
> +	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
>   };
>   
>   /**
> @@ -822,4 +823,43 @@ struct iommu_fault_alloc {
>   	__u32 out_fault_fd;
>   };
>   #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
> +
> +/**
> + * enum iommu_viommu_type - Virtual IOMMU Type
> + * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
> + */
> +enum iommu_viommu_type {
> +	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> +};
> +
> +/**
> + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> + * @size: sizeof(struct iommu_viommu_alloc)
> + * @flags: Must be 0
> + * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
> + * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
> + * @hwpt_id: ID of a nesting parent HWPT to associate to
> + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + *
> + * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
> + * virtualization support that is a security-isolated slice of the real IOMMU HW
> + * that is unique to a specific VM. Operations global to the IOMMU are connected
> + * to the vIOMMU, such as:
> + * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
> + * - Non-device-affiliated event reporting, e.g. invalidation queue errors
> + * - Access to a sharable nesting parent pagetable across physical IOMMUs
> + * - Virtualization of various platforms IDs, e.g. RIDs and others
> + * - Delivery of paravirtualized invalidation
> + * - Direct assigned invalidation queues
> + * - Direct assigned interrupts
> + */
> +struct iommu_viommu_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 type;
> +	__u32 dev_id;
> +	__u32 hwpt_id;
> +	__u32 out_viommu_id;
> +};
> +#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
>   #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 30e6c2af3b45..cc514f9bc3e6 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -307,6 +307,7 @@ union ucmd_buffer {
>   	struct iommu_ioas_unmap unmap;
>   	struct iommu_option option;
>   	struct iommu_vfio_ioas vfio_ioas;
> +	struct iommu_viommu_alloc viommu;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -360,6 +361,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 val64),
>   	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
>   		 __reserved),
> +	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
> +		 struct iommu_viommu_alloc, out_viommu_id),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> @@ -495,6 +498,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	[IOMMUFD_OBJ_FAULT] = {
>   		.destroy = iommufd_fault_destroy,
>   	},
> +	[IOMMUFD_OBJ_VIOMMU] = {
> +		.destroy = iommufd_viommu_destroy,
> +	},
>   #ifdef CONFIG_IOMMUFD_TEST
>   	[IOMMUFD_OBJ_SELFTEST] = {
>   		.destroy = iommufd_selftest_destroy,
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> new file mode 100644
> index 000000000000..888239b78667
> --- /dev/null
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include "iommufd_private.h"
> +
> +void iommufd_viommu_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_viommu *viommu =
> +		container_of(obj, struct iommufd_viommu, obj);
> +
> +	if (viommu->ops && viommu->ops->destroy)
> +		viommu->ops->destroy(viommu);
> +	refcount_dec(&viommu->hwpt->common.obj.users);
> +}
> +
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops->viommu_alloc) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_idev;
> +	}
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);
> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {


I am trying to use this for my so-called viommu which does not have this 
so this fails. My viommu is only visible to the VM via paravirt 
interface to populate sDTE (secure device table) so no viommu device in 
the guest or nested paging, nothing like this just yet.

Is there a writeup somewhere about possible uses of this 
IOMMU_HWPT_ALLOC_NEST_PARENT? I'd think one pass through device equals 1 
IOAS, 1 HWPT, 1 domain, 1 viommu, even with guest visible vIOMMU but it 
is not the case, is it?

btw is there a way to get a snapshot of all current objects in iommufd? 
They all use "dev_id" and not file descriptors so cannot look at 
/proc/><pid>/fd, and there is nothing in debugfs either.

For my current hack, I can pass IOMMU_HWPT_ALLOC_NEST_PARENT to QEMU's 
iommufd_backend_alloc_hwpt() but it is... meh. Thanks,


> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
> +				   ucmd->ictx, cmd->type);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +	refcount_inc(&viommu->hwpt->common.obj.users);
> +	/*
> +	 * It is the most likely case that a physical IOMMU is unpluggable. A
> +	 * pluggable IOMMU instance (if exists) is responsible for refcounting
> +	 * on its own.
> +	 */
> +	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
> +
> +	cmd->out_viommu_id = viommu->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> +	goto out_put_hwpt;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
> +out_put_hwpt:
> +	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
> +out_put_idev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	return rc;
> +}

-- 
Alexey


