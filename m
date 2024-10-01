Return-Path: <linux-kselftest+bounces-18716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314B98B387
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 07:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC8D1F27665
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 05:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB119258C;
	Tue,  1 Oct 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wacsfw2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E019307D;
	Tue,  1 Oct 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759235; cv=fail; b=lFHoVSYOzcWaUkkQ9haNDfUQ2C+KV0lSojOFMLQHVp6Q3yv70oFkSKJ/VrA1988EyZPEUCimEmnBgwClCwl3jtoIgRDMFXjRCmgfrIECr+CgnZ1uOuLsWM2C6fmqpAp4//ZgjdVaDtdlWQPYrKTr4LlSaRJ6qdxanKuc5g+Su8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759235; c=relaxed/simple;
	bh=gUYYi6QjG1FtVrcQMge/gXQlvx7+/i9UZwl5ROeZl1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iz4YvPnjODp/UCRUFmH6lQ+8XRofVoy9z3TEDS9W+kGI1KWc4p1K33ttrCJa0neNrGTmjER1lufQRTvNVEfwvl/ZQLsu/Xb0B4E8ccfUmF+mNXfu8qyHjaFgXHvnHoMHEbdobO1A+mhpD+Qa94B7ieZ+Ep/YQBgs6UgXlwaLfI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wacsfw2Q; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGipAMrMSZrejFwJ4hRx8bmw2p7WjfdqYOhTzaZFueTcW3Kd7RYnwWJgKt+Zo5va368Gbx5j3IbC12jnoqO03aIwb2sL9V1Ljj4pDqY+KswlVt7FDTCbcAax85AxEdtN0IVY/uMdOiDtoPN8oDofs9LDyD00QD09jALYbwhNCtV1VJ1t3508N9zIaOo8tgtiRT2IAZ2YEM1BpbMGBoewZ/ciwN+FnWoLe3DZAPtsgFzKED4aODVqJRgCJZyb5u1OPKzREEry8V4O2fa90JxCtMCqBFEnIE4zbqEDtZwHxndxxyzyC6LOa9bzD9WZyPn8dx/sh9D+jnoyHVa3HwnyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NBgPiBMgBmVty8ny/ZetpUD1UGwBgG2/47u/Zy2LuQ=;
 b=CHnD5dOBMR+hxHKPhe7DGDWeo13q+/dDE8ZnqSFANx7RkVFvMq+RYn5yxCIPz52ejaTp5imDrEprK6tm5jLycbH7WsyQBMxk+sr0+lGpRzudZq5zqkcy2H11IYbIePUZj6da9ov8/j3/Uon4zqavVlv3RPNT06GryzP3FT5GodiOGP0vtokIXOKK7/EAPxOttvBqZqEkeDdik/BJpXJsEHKd/WYPNZ5PVZ4XzX6uKT5g6wS7/Zn6c9nAWd8IGhxOaAWkZ88pqCkg9hQo7jlUAgOM2+XtvaBElfEsOgUCTpDdRfPKvl7VofM/ukxV5ruzKg+PwkVHG9/+0TLgbNjOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NBgPiBMgBmVty8ny/ZetpUD1UGwBgG2/47u/Zy2LuQ=;
 b=Wacsfw2Q9dHt2/Ijtfi4yKFvcNXQK04pqEWYzrM51wejwnerajRn1w/CQ7P1QN8ngiP17L/oWsIDnsOszyPOTMo47OUwSno07XDMHocZ4qVo244CMTMJN8d9KHurIduTMLh5LVXXhw2QNIwomRQ8H+wvL/8rsttH4vcg8St/Bek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:07:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 05:07:10 +0000
Message-ID: <3414d639-50b7-4175-abb4-b3d87f5744f0@amd.com>
Date: Tue, 1 Oct 2024 15:06:57 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mdf@kernel.org" <mdf@kernel.org>, "mshavit@google.com"
 <mshavit@google.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "smostafa@google.com" <smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com> <f6899837-b908-4401-bbb7-5e205b6b3a88@amd.com>
 <ZvtuM1nG8UCeCLdM@Asurada-Nvidia>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZvtuM1nG8UCeCLdM@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P300CA0014.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::34) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 684e09d1-6e27-4614-17af-08dce1d6e54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZNanBJajR4TGlvOUo1SC8zSURtL2xFaElRME9ubG9wVkhZelpnZWVBcW1V?=
 =?utf-8?B?RnZ2WEZPd2hReXRYSXdLVjZld1NNczBFd1ptMUpjcWRRdDBXd1JwS29Pc3dW?=
 =?utf-8?B?UmVYbnJHeHd1YitxbEpVZmpDY1ViRkx1czNjQjN1VU1mcXkveTFwR0gwNUlB?=
 =?utf-8?B?eCt3cjhPaml1S0M0by83Um5KRWpiRmFpcUZOVUVNMFdFSFNhRklnMkxhREQ3?=
 =?utf-8?B?ZWVWQlh2d3VXK1pyaU1HZ1pib0p2QzBWVHh6aHFSdnI0TzA5NFVvRFRUdng1?=
 =?utf-8?B?cUVvRHpVNitlQmhWcFA4MGlsdWpmQVhEd1k0ZWI3ckNRRkFiU1Rob2dFWVNL?=
 =?utf-8?B?cFdyL0hCY3lGMWpjZTJUaTNxL0NocGw5MFBLZWFoSGtibDRvYjRXdSs5OE51?=
 =?utf-8?B?RTQ0QS9UdEY5UjVndUtpRHdSSDhUaHhWNGhaei9jWWh2OTRMamh6TGxndldp?=
 =?utf-8?B?K0tFRk9qbHNaL2NRWm12bEFmN2hyb0JlTnFyTDA5bFBsdE9raDBYa0FqaENB?=
 =?utf-8?B?a29MMUJQZ0dkQW5wWGFZL0xnd3lKd1ZJVHMwamhOMTYzUGpvN2l2R0hWTmJW?=
 =?utf-8?B?ZE4zakIxVDl5bG9wTVY4RHBoYTNSYWVZQkw5ejdMaWRIS2hpSXlPTzdWYmxx?=
 =?utf-8?B?TFNMT09GMVI2SHBOTU9rZm9rU3RZQU5XUGhuT1FDbTFEK1p2bDdqSW0xeUww?=
 =?utf-8?B?SDVPc0pSRXZVK0tEZDdxYU9aQVVaNFVaQTlyQ1ZQelRwUTB3cGFrbEIzOEZv?=
 =?utf-8?B?NVlwbEhtcUFIdjhSa3J6b2R3NXdPcTQ4WExJWDRWbndUN2FiVW14QVlSSXJE?=
 =?utf-8?B?UmpTNEZHQVBFYXhNbGpmSDRYZFR1R3oxKytwWVJkU0tReDVxQjAwamtoV25j?=
 =?utf-8?B?czd4WFlET2paR1dEdjVQKzR5NGlVTjdpdnFYeWVxS2FjcWZ3T1RnbEV4UU1B?=
 =?utf-8?B?eXRaeXh2cHFKYzREUkxLaFhnV2cvYkFiVEhqY0FlZkJ3czRMU3JKc08wZW5W?=
 =?utf-8?B?V21LUytWaTkxRjhOZ1lySEtPK2srVlhlb3ZRYlpjWmtrcVlxMWU1T2J6VDM4?=
 =?utf-8?B?OW5KVmwzcW5RTHRGMjdVUGpXUGNHbXVZMDQxY0diaGkzVndCalFCYktTU3FV?=
 =?utf-8?B?TFFvOUZHSVNvanAzdTVUa2ZRVUtxMldhc2NzUTRKUzJXalY3MW5CaUFNVzcw?=
 =?utf-8?B?c0IvMmt5V1BtZzN4YzVlUnIvcXZxWHJ5bVZheDFlU3Y0RVhIeDdOVmxLVG9j?=
 =?utf-8?B?Qk9qTmRLUVhhSUwvVVZwenREMTJnUE5pUWJEKzYrR0Z0eVFGQVBkY0h0MlIw?=
 =?utf-8?B?OXJyOXFCVlpoYmtFOXZVNjlOY2dObVovRVU4dndxd3dhOHVsUVRKeUFoT1F1?=
 =?utf-8?B?d1ZmSU5jV2ZCQ1JmSTBkUitNdHU2bWNDcDRhM0liSVF2NTBXTXh3L1R1ZWhZ?=
 =?utf-8?B?UDNWdHphVjltTnJDQytmVGxNdlNqMEVuNUc5TStNbEYrS1dkOWg3aE1JT2hO?=
 =?utf-8?B?czFxUzRIc2EwNmNCcnBFdEdFVjhqZUxxNDEyMnZuOFUzTFEvbnUrRTlINDMv?=
 =?utf-8?B?YnRKVlZqWHVVazRqK2RsT2NhSmVYbGl5U1FZV2Q1ZHNzdlNxWERiOU9UYU0v?=
 =?utf-8?B?UzRyYnBVRGtraDFqUXlpNE52WUdEaU1YYVAxRklvQ3o0T01jellsa2N1ODdi?=
 =?utf-8?B?TllYTWRFSEExSVpaL2owQmxyWDlmNUtscHZOZWlSTFIwTExQYzVKbTFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RExGNDdjbDlXRUhla3NQRGtRckJsRWdnQU9IV3Q2czZ4c1R1R1lnMG1Bci9Z?=
 =?utf-8?B?NE52b2xMUVVabFVoYm1KSkN4MVg5RGo0ZGtkaUt3S1R6Z0d4aWhOQmlVYUJl?=
 =?utf-8?B?UEs3M2dDb1dld1BUS3Vvd0thamxGQzNqTGVmVnpTZ0FoWTVZRUdrTHp1cWxq?=
 =?utf-8?B?Q0VVMHp3aTkzdmdhcEtwVDhxaU1rcm9hZjZpNm1PYkkyejdWRkpYSDI0SE9M?=
 =?utf-8?B?SmlJMkhNWXptZkluU2pSMHBXb2FHbytLalB0NVFyZ001MW13WGpIZmZabm1C?=
 =?utf-8?B?ZG1JMnNOVlgyZUY3SHZSaGQ0OUlUaVQwaFVyWGs4VzlkdWVMSzhENkJkSEFL?=
 =?utf-8?B?QVV3Rzlqb0UyMXVmNmc3THVQVjRKZnNORmVOVDNwWGpuN1ZQWHAzOGU5T0U3?=
 =?utf-8?B?bXozMXFXUjd4cWZGU2U4aE92SlhKMGUwM0NaS2c1ZzhKdFlsY3Y4WGlaekZC?=
 =?utf-8?B?VDMzay9Mc1Y1YW9heHBYdnBNR1V5cnhsZjQ2MjRBZmNUcFR4OUQxWVRXQWox?=
 =?utf-8?B?d2tORWV2Q2lwYkNHdGI0Sms4akdRcWk3S3lYN3RwYmRMdS92MUsxVkdsSm5N?=
 =?utf-8?B?aVVWQjlCWk5wWGRVdWpXUnp6SzdrNTdTUTVOVDVneHN5Y1UrUUlKZ0VMb0pT?=
 =?utf-8?B?Q1lBdXhkU01TcG5hUWRWR3dVRXlndU53NndURE14bm9VT2Q5endNdmZTLzho?=
 =?utf-8?B?cjgrZXU5NjFrNUluRXFoZFdnTG91M1BNWmhDeWZpOWw1dmdTeDNnWEFGSDA4?=
 =?utf-8?B?QkhnTlBMcmIwNHdaREhSTWdIa1I3S3BmakFDdjYvSml6RVNrTnltdkFpRmJs?=
 =?utf-8?B?MUIwUFhtRHlJeVhYWWRQWU5pemtYbVBWRXUxaHc1M2pnQnNkamxOcU9IZjE5?=
 =?utf-8?B?SXlSMTZYMkRBR25GQlNmKzFZK1puRC9rd1htOGhEZmNmUWdORlMrbHB3ME9K?=
 =?utf-8?B?bXNiS0hxSXVTY2xQaThiMTRrakpJaWpxOWx5UUZJNEFxeFR3VEZvK0dMdlRT?=
 =?utf-8?B?cnN1cUFFZDdPcDVYZ0w2d1ZNRkJnQXVSdU9tOXVkMm1Ma294WWhvVEpka2hz?=
 =?utf-8?B?a3JnSzRwZW8vbjllbng0bEhNVXRNcU1TVDFnLzdUNW85OGJaMUFLNXJQdXFa?=
 =?utf-8?B?RU0xQzROS2FLaGlvbDZuQksvVHZhb3RsQjBmNjJERS9MN0hJdFdGZWdmTlNu?=
 =?utf-8?B?OUNEQThIMDE1YzYydWEzSjhESTlIeEp2RTlhcEpDUFBjVzd2R0FwZVJqdlRl?=
 =?utf-8?B?T2FOUzY3b3BOdWYrTzN0OHlHVWtDcmxVdDFUZlVYeDFySTdaQmpEcWIxRXFh?=
 =?utf-8?B?aDBJYTBVb3ppNllnNDk1R3F2OG9aQmpLTnRRMXQ1QU9sZ2p3T3RWakQzWVh5?=
 =?utf-8?B?QVd3aFlRUHpyMi9Hd09CcTB2a3BpSHBnRVh1QXpVNjVCZ0NpMjZ4SDlHM2pO?=
 =?utf-8?B?dUJLM2drejZGUElCWGI2K3ljMG41RWNvYnhJc2N5c1l3MWUvWXlOeGdiaWJi?=
 =?utf-8?B?NUdlZnZ0ZHJVRWJ2cTBXeWZKb1VVakRoUHc0YUcwTTFFaS90RUpoazBDdCs4?=
 =?utf-8?B?aUVXUW9veU5FT3VLQitPWkNyZGlFT29aSlhvTUZTc3A2T3cxeEI0TUpuNG5R?=
 =?utf-8?B?c24wTkl0Uk1Ld2VBeFFFamRsekREc2w1MjRReEcrcHBCMFJQWmc5MUpibnNE?=
 =?utf-8?B?TG4xL0VIckhpTmVML0JSQ1VYV0g3aXdQQXE3V3lmTnZJVXlUS0VNUzZ6MDdm?=
 =?utf-8?B?SUlSWjJIRjVzczY0U1RFbllkazZ4MGpDZUJkOFJqQ1FkdGlaRWNTc1dzRGFN?=
 =?utf-8?B?L1htQXNtYlo4ZkZhcklUY3RQSlhhbG1uV3BwSy81Z2cyR0lmUkNIVldzakFB?=
 =?utf-8?B?a2w2WkRycUppNnFOYU05d3I3MHdqQ0Y4UXY1a2gyYmQ5eFVUc0c0TjdiYkVp?=
 =?utf-8?B?MlRmbDVkL28vR3hJNS9TZENSV2ozdlZVVWxLMm1RQ0d1endNSEFYOTluVXJa?=
 =?utf-8?B?a1pPMEhmeVArWEFsNDI5ZUZYRmU0MzVZcGZSOG03TTk2M0pKam80cVRQemRw?=
 =?utf-8?B?UUxkL3p6Vk9zTmRHQWdSRS9HZjZjc2NDV2MwNzdlbW1SRVRpeFpqMmt4cXNG?=
 =?utf-8?Q?27fbUhlSG11mwghIdxAtkHVMd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e09d1-6e27-4614-17af-08dce1d6e54a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:07:10.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XV0pRyBNaSGlMAVxIHEUkkqQXJKibVq5GiTvP7Y9tXESxKBkYJXsniqEwx1wnfrKRTgS4m/OUi/9Fm46hzOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779



On 1/10/24 13:36, Nicolin Chen wrote:
> On Tue, Oct 01, 2024 at 11:55:59AM +1000, Alexey Kardashevskiy wrote:
>> On 11/9/24 17:08, Nicolin Chen wrote:
>>> On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Sent: Wednesday, August 28, 2024 1:00 AM
>>>>>
>>>> [...]
>>>>> On a multi-IOMMU system, the VIOMMU object can be instanced to the
>>>>> number
>>>>> of vIOMMUs in a guest VM, while holding the same parent HWPT to share
>>>>> the
>>>>
>>>> Is there restriction that multiple vIOMMU objects can be only created
>>>> on a multi-IOMMU system?
>>>
>>> I think it should be generally restricted to the number of pIOMMUs,
>>> although likely (not 100% sure) we could do multiple vIOMMUs on a
>>> single-pIOMMU system. Any reason for doing that?
>>
>>
>> Just to clarify the terminology here - what are pIOMMU and vIOMMU exactly?
>>
>> On AMD, IOMMU is a pretend-pcie device, one per a rootport, manages a DT
>> - device table, one entry per BDFn, the entry owns a queue. A slice of
>> that can be passed to a VM (== queues mapped directly to the VM, and
>> such IOMMU appears in the VM as a pretend-pcie device too). So what is
>> [pv]IOMMU here? Thanks,
>   
> The "p" stands for physical: the entire IOMMU unit/instance. In
> the IOMMU subsystem terminology, it's a struct iommu_device. It
> sounds like AMD would register one iommu device per rootport?

Yup, my test machine has 4 of these.


> The "v" stands for virtual: a slice of the pIOMMU that could be
> shared or passed through to a VM:
>   - Intel IOMMU doesn't have passthrough queues, so it uses a
>     shared queue (for invalidation). In this case, vIOMMU will
>     be a pure SW structure for HW queue sharing (with the host
>     machine and other VMs). That said, I think the channel (or
>     the port) that Intel VT-d uses internally for a device to
>     do a two-stage translation can be seen as a "passthrough"
>     feature, held by a vIOMMU.
>   - AMD IOMMU can assign passthrough queues to VMs, in which
>     case, vIOMMU will be a structure holding all passthrough
>     resource (of the pIOMMU) assisgned to a VM. If there is a
>     shared resource, it can be packed into the vIOMMU struct
>     too. FYI, vQUEUE (future series) on the other hand will
>     represent each passthrough queue in a vIOMMU struct. The
>     VM then, per that specific pIOMMU (rootport?), will have
>     one vIOMMU holding a number of vQUEUEs.
>   - ARM SMMU is sort of in the middle, depending on the impls.
>     vIOMMU will be a structure holding both passthrough and
>     shared resource. It can define vQUEUEs, if the impl has
>     passthrough queues like AMD does.
> 
> Allowing a vIOMMU to hold shared resource makes it a bit of an
> upgraded model for IOMMU virtualization, from the existing HWPT
> model that now looks like a subset of the vIOMMU model.

Thanks for confirming.

I've just read in this thread that "it should be generally restricted to 
the number of pIOMMUs, although likely (not 100% sure) we could do 
multiple vIOMMUs on a single-pIOMMU system. Any reason for doing that?"? 
thought "we have every reason to do that, unless p means something 
different", so I decided to ask :) Thanks,


> 
> Thanks
> Nicolin

-- 
Alexey


