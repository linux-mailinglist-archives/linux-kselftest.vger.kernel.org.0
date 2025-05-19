Return-Path: <linux-kselftest+bounces-33336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB168ABC52E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EEF1B626A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C228852A;
	Mon, 19 May 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKt5Jq25"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037E278E42;
	Mon, 19 May 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674328; cv=fail; b=aEOLVIAQNbNGJNhOF1WFnn/fKExEbq+HmWwdVn6A+WRm6FvOw3BoJdNKE4OnUkAGMuYbaSkMy5LE2Vc1SWO32NIqmnoS6owWu6Sm9W2HdGUl50joxKkZ2cqOBpRdvV91jP5gj01wQuRzHm5uB4m/L8FKiLdcbujvNRBK9dO28U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674328; c=relaxed/simple;
	bh=+gaZCykeH3Ve0bDCDh2ARCsolM3rpSiZEk+eqt19L5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qFMvse/sdbVPkMVRB7tjFPe0jnK5ZKWqPnLs3oUGYMlulZkXrrGRPsjLRNBvWasrmFG2Vq+swc9oQustjumPN4BOVlMr0r7U93Qtwe8UthQZZJ+61C2DFgLRtc43r/R+Y7nRpTgDwPpjRP4PQy4WyuKhSq+ZB1lCOOqoz29TFKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKt5Jq25; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6hB6TVg9t4Xz0UHrtZqrPOqrZxNPdDQAM3MaM5feQrmbDnsGbEmdIgLbrTyFCoXoH2nWNu+uHpt9FZwTV6/jbLrSSkBDzQOZh+wvjVzI5t8lRSZLcZz9OErb+qrRE7cQQ7JyW8xyQYKj4Xhzb8i2XHaIauMsUzDwtX/I7zU8NY4w0SX+d9cqK3OIBZHHWE2pstpKBeAvySRyPjDkYLkAWJZf2te2c0FT+9rKY7I+cEZ3pmCwKMirnNXKn4ylwzwBb0d4462g3diIPoqp1fBX6mabfPDtZ8u7dd4O7cyI0a4OEl0fAxhF5+LhoIa/OIgPd2HYMGM1KmOhYPBmls9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5BArQx0hRBlgBGAB+Rnop+oLO8pn80ii8FzIJcNt34=;
 b=mXA6lbh7QwES/c/vXLw689iIPq5m0tiXthhU5ZXG7O2hlDMFMft2wTQzizs8asr/mo8ZqO5XjQu2GVogvt02lA++MLDzkmZ/XjciAIJjOwmPmvsoOQDiJN7F/rMKogy2fJqM9pl4T2Ndi8trhjyIoJ54/y/+s6uiuHVqMkUCx0+Au1svPohxZnLORvjN99OZcppmho261fDCiGXVCZJv3/MDglc75W6RAqT5afmIdbHABEFLJtowYf10Q0uCvCkcxuiwXQ5Hs8KuBPv/JKXN6DREa9kY/Yn5oYe2Uxpacvtyaa/ANFq792SKtmsUyoqezcIDw1DfCFjId8nlsZOrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5BArQx0hRBlgBGAB+Rnop+oLO8pn80ii8FzIJcNt34=;
 b=mKt5Jq25UUKZv0FOwdBEvEYRiTate9lHoYyUhcgkaUSMYwQR17iPcj4gmLJri2yB42f7DvyhIlxq7nHkVYGPTo6ChxOsHfSWMfYs2m+/kDC/RT9sd1qlRA40r6DGNCZD18/WQ7FpkMzflW9lPTNSlsHftnTv3nwqhV4thjLx1ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 17:05:24 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%4]) with mapi id 15.20.8746.029; Mon, 19 May 2025
 17:05:24 +0000
Message-ID: <c0af7aa9-a991-4d20-a2bd-c6065f04fc3d@amd.com>
Date: Mon, 19 May 2025 22:35:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "will@kernel.org" <will@kernel.org>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
 "praan@google.com" <praan@google.com>,
 "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCajRTEU3vPQAzpD@Asurada-Nvidia>
 <BN9PR11MB527678D4598D453EE1EBF4588C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB527678D4598D453EE1EBF4588C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::6) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 87102a01-aa2a-4805-c279-08dd96f75841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRxKy95OHlacEc2eWlvZ0ZoQVlvZDFYcFBhN1FjWFphTkxCYnkxRWFOZDRm?=
 =?utf-8?B?dkNyWHJyQ2YrcjBRaE9oOUljai9CbDNmSjZDdFowc293UVUweHZEazdyU0do?=
 =?utf-8?B?eXR5bUZqbEo2RWpzMDRLM1I2SVJKZXRMY05XWnJFc3ZwK2xaRjZMU3VoVTY1?=
 =?utf-8?B?QU9pOVdNTG1uUXp6MHBtL1RicjlwQ1RwMEJQSGZGK2lYUXdyQzRYb3l2VVQ1?=
 =?utf-8?B?ZllFYUVrd1praTBXRzNxUnVDbFlxM1dmbFVPUGxhb0NYMFlkQkM2YkZjVlFp?=
 =?utf-8?B?cmdIQm1sUDVjbWV6dFF6MGtTSDNWYkoyTFV4RytQQlFGNklkSVFGT0d1MmlQ?=
 =?utf-8?B?YzJNUGhTL2ZHOFhHYXcvWkpuODBSY3BDdTArMXRGWG1FTmdjYTRIc21hZnpS?=
 =?utf-8?B?elZuNlo2bWZOTFFTeWN2ejdFZHVVWnd6NkhRc3BzWVZ0bVpFSm9VZVVldTNQ?=
 =?utf-8?B?SFphWjBiZW45Qmh6cld2VlBDMUF3RlJFU1hXT1VNYkllYWtXSStVcGRlaW1Z?=
 =?utf-8?B?ZVlEL0tZS2NRbk5FSG1MVldLWFZadmcwZnMvelArdkJaK1ZOMlMwbjYwMWFL?=
 =?utf-8?B?dEZnNlFmcVZCWWdXUlVXMjBSZWlaNlRlaGYwSjZNZ3Zyc2JGbTkrVG81MEwz?=
 =?utf-8?B?VFN1YzhVSHo1OS93WVdFRlBvUTg0Smh3L0hySFJBdHRsQk4yYXdWZEJyMFF3?=
 =?utf-8?B?dEFCazJ6cXB4SGtpUFZhR1JWQlB4UE1wcUZuOThEZThlaUZaa0l6czRoaUtn?=
 =?utf-8?B?ZGhHTkthd0R6UEN4WFplV3cvZHBXdVRlMDl6bFZnZWRSN054dHIzV2MvWGlQ?=
 =?utf-8?B?NVp5QnFUcjFibVd6TUc1RjRsd0RvSXE2TTJBRXlab2k4TzNnWFRUOEVobmph?=
 =?utf-8?B?UnA5dEtNcEg5aGJJVWxucndBenhnUTBlMTZDZTRhT0pVc1pVa0tRQ0U4c21G?=
 =?utf-8?B?aTd5U1lqT2ZZeFRXL0VqNllCVDUraThmUHVaTzM1NTAwUjZuTUJ5bWpSZnpZ?=
 =?utf-8?B?VGMyRmRHWHJXZS81V1RNeEJUbUJkZFRoZVpDRGg0MjVUNm9pRkFoSG9hQ0ky?=
 =?utf-8?B?OGpHZ3AydU5nNklad2VvVXVwUFZMMWh0SjhxdWxkM3VrK3lRUTVIUnBKaFM4?=
 =?utf-8?B?bnJ3SjI3VCtTMG5tNVdqUHYxbzYyaXdyUmtSbmpzNW9xOW5rQXdpd1JYWUtl?=
 =?utf-8?B?bFMyNE1WWkUzS0JLV2dIbkFaeUVVVWpqaVhaWDVoVGZ2UU8xdDFaUEJnRGE3?=
 =?utf-8?B?ZTl3ZnlWNjNkaFdGUGlsSVVPRmRBbDFITjF6bDRxZGNDQjAybXJ4Wnl4QWpB?=
 =?utf-8?B?QTFDcENpdk1rNUJ4SDJ6TFIwTmhubWtiSElkeklYazI4QVEya1NUeTdHN0Rn?=
 =?utf-8?B?RjhicFEwSTgxSUNDdDFRQWRySkNUcGV1MmladFB3bExKVXZTTDQ1UnVQbkg0?=
 =?utf-8?B?bmppUkJ0YThwVHJjNkZEWUFtTGszM3J1dTFSMDdJNU5CYUJNWHZwNWN5bklW?=
 =?utf-8?B?Qy9zTTk2bFIvYTQ2bGNnRWs2L2xMK2xtU3JWTnhRd1dxc1VsMDdlS2FudlZD?=
 =?utf-8?B?NEJNa0dDNDY2WFZKUnRJMUxrWmlTNTc3dlVPVlJKdm1EenY2N1NkUEczdVZG?=
 =?utf-8?B?NWxZc244RFhJVGYyV0Zyc2lyQ3NuWDgyWUh2MmV5cTVsbys2dHA4N1RuRzJN?=
 =?utf-8?B?a3UxbXl4YW1VRjQyVW9JS3hpV0dJdjAvZGovTUFwRUtTR2pRQ1BiamVFazVa?=
 =?utf-8?B?NHhlSjF0Y1R3VnZnblVCSnpEaGlQQmdEVVU4bnovbEU2WlBDWjNMZmxGNWlQ?=
 =?utf-8?B?OWp5Nks1c1MrUEF0SU5aSHE2UGJPWGdWR0ozMCs0ZkQ0RFlXNDA1VGtpSnFv?=
 =?utf-8?Q?Jbeo6UvO49BXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3lnbHVWK1NBQ0xTNTE4VkwzOHY5SXRyUmpacnFaNERHVUlWVTlzK20yY2N4?=
 =?utf-8?B?L1p3UmV6QXgzeHRVMHU5SGVuNFRyOE0yUW04dktwd0hEYTB4c05PZWFCVVR1?=
 =?utf-8?B?YnYrUEtVN0ZlbFJ6czR3eUs5Ty9uUDFrWkRmVC9qNTRtaUxlOVpZc0E5aHR3?=
 =?utf-8?B?TTJlRnJMVUJVYUo3OUloVlJRSVR5SVdKS3ZiSGpjcmhIa0lSWFhwUW1QY0p0?=
 =?utf-8?B?c2lURlVONHdPUjRQQjE2cyt6OElpYTF2OC93MmF3ckVwMGZuOFpsTVhTSGhs?=
 =?utf-8?B?ankyQ2J6TUs5eDVPYS9pbTRGZGg4SXlKK3AwdEJ6Z0hpNEQwcW1aUERJdURx?=
 =?utf-8?B?NndrWiticnIrQ1pNcnJneTlrTVZPWTl3SmtQZEU2UHFsZS9zZndBaXJjc1NG?=
 =?utf-8?B?Y0syUmxDK3h4aTVyR2hOYnRkWkhVaDhGRnJBamV2dXRETFd6b0tOc2laVzNz?=
 =?utf-8?B?VFROQWxyRzNMcm9jQ1hWWFdpTUVyU2lrYVN4dFhLVFlLeENsUkgxOUdKck5L?=
 =?utf-8?B?d2R2ZkF0NzJXV2o4YVFnZTNoVXJVcW1Xb2tuL0paNm5IcllZM01tam9TelVM?=
 =?utf-8?B?YmJET3BncFk1dk9iRU45S1JVVWdGNDFWMzNucnREMldKb0JwSndIR013REtv?=
 =?utf-8?B?TGJNUEphc2ZMOXRHTkI5RnJYUzR0U1orUU1TVnVMNzcrL1RLemhrKzdybUlY?=
 =?utf-8?B?TW9jN0o3MWFRL2VHZVNsMHBzRFJRZmt0ajRPUitpOGUvaW5pdnhxWWlwdWo0?=
 =?utf-8?B?dThWcStXVG9qaHNDb1VkeWNtRVVKSjdxVmo2NHluZmlkdVJRM1J1T3NGNklM?=
 =?utf-8?B?V05BcmNxL2lWZnNBbmZFL2w3RGltWERrZWpRYU1BbnZnVFJTUmJUZzdrSmFQ?=
 =?utf-8?B?dmluaUR0d0p0RzRRRWxwQUpCTWJnVGtoaUNwV0dxaXFSYmM0ZFVnOUJKbnZ6?=
 =?utf-8?B?cnM5cVBYVWtSaXl2bDJvTVFQdDZMK29idEdabmhXVFJld2hNMmN5Q0hKd2hp?=
 =?utf-8?B?TWhTTHVxNEZ1MTZTeG1kMlNHbU8yVHpacUZlc1lBT3NyMWMvRHR2b1NteUpV?=
 =?utf-8?B?cFJqSUdpYzhGcEYyYm1rNVFFeHdYbHB4eFBKOHowV0RLVHprY1dlYUJ0amo3?=
 =?utf-8?B?R2pHU08zaVhyZkxORG9wK3oxYmFRQThYdFlaOUFNbEp1MUxYclJOR1k0Mmpz?=
 =?utf-8?B?M0FhMk8rQjNwTTh1amQvb1pSbDVMNkN4VzNjWGQ3dUFISkNMd0JhNVlGV1Z0?=
 =?utf-8?B?dXpCYW5jdmMvR09nUm1ZM1FrdVBGa2tGb3ZyMHdsV1FZU1Y1WjNLT2pOTnY1?=
 =?utf-8?B?T0taVGNUZXExMVpLOGllQy9BR1g1cWM4bkZOdDJOQUdTM0dlV3BScitPY0Fo?=
 =?utf-8?B?QnpQWWoxSnpORnc2Ulp0ajJNOTJsSGVURVA1Q2hwZ083Ym1FUzUxQ0p1SU9n?=
 =?utf-8?B?UG1tN3VFMDBMZ0djcnhqQ0E3anBGY2ZuTEZXbnJmWkhjNWFlWHVJOXJhNFhp?=
 =?utf-8?B?R3hLbnNuY1pZRW9KMmU3QUhJdEY2OUhkaGJ5UE9FbTZGL2tpb2QzSmNkOUJW?=
 =?utf-8?B?QUxReER3cE1NWUo4SzVINkVWREZIdXk1UEl2VHVlaHBDRkg2NWcyR1BjcVlK?=
 =?utf-8?B?S3BmUnY0MEp5ai9iNUxsdmhQbHM2Q2JJcUdhTzAyRm5rZXRYT1VYVnMrUC9h?=
 =?utf-8?B?WC9kaFZxVmtYbFB0Y3JlUnRqdWRoaVFqa3VEUnhEVWFEZUZnb0Q2UGFKT3Nt?=
 =?utf-8?B?ZXRJbGpnSmtHb1NlVmFwQmlUQ1V3Vk84d0MxaSt4L2pieDQyUTZzSk9NT1E3?=
 =?utf-8?B?dHNDMHpMek56V0Z5R2lnOGVCbkpFN1hvd25RYW9mN20yajNLQ3pVM0poV1ky?=
 =?utf-8?B?Y3FyMzRleHdDUkd0aEVUem5Na3I5TGQwVWVScFRzNVlJUUpPYWxRTkhGU0w5?=
 =?utf-8?B?d256Q2xnMTNiQldtNXlNZVAxdjlmSUZNQ2w1NHl3bWgyRjJHODVpa2hhMnB4?=
 =?utf-8?B?SjJoU1RmUGluK2NOcVQxSXRBZ2xzOXRPNHlwdVpHdTdlUTA5UGFmRzNkaTd6?=
 =?utf-8?B?N3ZSWXliWmp6b3RNZ3IzQ00xOEVKeDNkdkxJSTl6TDFRL20vb1BISzk4Wm4y?=
 =?utf-8?Q?Afr27TJyAi0ne0y4YLc4e14CE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87102a01-aa2a-4805-c279-08dd96f75841
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 17:05:24.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6paPEi7pG64LXccT4GlfXsyGMpp18+KJr3HFvBS5MaT7DSKxBpU1bXYBSrH0/b/HzS9wAohgH45CF0Vt7a1Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540

Kevin, Nicolin,


On 5/16/2025 8:29 AM, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Friday, May 16, 2025 10:30 AM
>>
>> On Thu, May 15, 2025 at 05:58:41AM +0000, Tian, Kevin wrote:
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Sent: Friday, May 9, 2025 11:03 AM
>>>>
>>>> Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure,
>>>> representing
>>>> a HW-accelerated queue type of IOMMU's physical queue that can be
>> passed
>>>> through to a user space VM for direct hardware control, such as:
>>>>  - NVIDIA's Virtual Command Queue
>>>>  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
>>>>
>>>> Introduce an allocator iommufd_hw_queue_alloc(). And add a pair of
>>>> viommu
>>>> ops for iommufd to forward user space ioctls to IOMMU drivers.
>>>>
>>>> Given that the first user of this HW QUEUE (tegra241-cmdqv) will need to
>>>> ensure the queue memory to be physically contiguous, add a flag
>> property
>>>> in iommufd_viommu_ops and
>>>> IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to allow
>>>> driver to flag it so that the core will validate the physical pages of a
>>>> given guest queue.
>>>
>>> 'READS' is confusing here. What about xxx_CONTIG_PAS?
>>
>> Combining Jason's first comments here:
>> https://lore.kernel.org/linux-
>> iommu/20250515160620.GJ382960@nvidia.com/
>>
>> So, pinning should be optional too. And I think there would be
>> unlikely a case where HW needs contiguous physical pages while
>> not requiring to pin the pages, right?

AMD IOMMU needs contiguous GPA space for buffer (like command buffer), not
contiguous physical address.


>>
>> So, we need an flag that could indicate to do both tests. Yet,
>> "xxx_CONTIG_PAS" doesn't sound very fitting, compared to this
>> "IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA".
>>
>> Perhaps, we should just add some comments to clarify a bit. Or
>> do you have some better naming?
>>
> 
> let's wait until that open is closed, i.e. whether we still let the core
> manage it and whether AMD requires pinning even when IOVA
> is used.

I think we may still want to pin those buffer address.

-Vasant



