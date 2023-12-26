Return-Path: <linux-kselftest+bounces-2425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB181E4C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DA282B99
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 03:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75618EBE;
	Tue, 26 Dec 2023 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDd7fxBB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E541865A;
	Tue, 26 Dec 2023 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703563099; x=1735099099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6SREH9mKNEGePisTLp9qpamZiAnzukvwKH4He0jDVR0=;
  b=bDd7fxBBtoDNMOimnuzr6+l+o8mIXaEe6KyvGr+sV4aei+Q5dFHA3KqJ
   N4ZZ9bXdWUlL3Gz7zxDNUlnyVUEU4c5VlCFkm808iPs4m1YWf9aOR3QvC
   nIjZ49NE/eAWYD0gdytgo3LyV3Ww3soge4hw+L0HA/Xz+JGw4XIzEgnkz
   JEcMQbv0LLK7gHFjPSzInQ+A7JN/zUTWj4q/J5L+FIoeJAQFiE2DHNvoS
   lGP9g8AZLXsUJ3jlcurBszk0gDI8eSn5kDx70RCZCXMCcFgK2tYzzcRzv
   l4e0VzZfxxuorpPiwhq6kv2ws6+OJH76fRJP26l2NQjYwX72ExIxf1U8+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="462745109"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="462745109"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 19:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848331661"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="848331661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 19:58:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 19:58:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 19:58:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 19:58:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtVBXS04KBb4UvwMl6vn2Ne5ueVPFPVHFh/wSQ9Sf9v0yGmSjEyKt06a/aZOd6TPo9pSl3lgjR6WhTqZlIj4F/rOzz3XS4+Fq22sb9NfHu/g7Qj/ZI4GZpKX7tLtDHUNLJpI3SHF/IUxh/IbjBJjGaPGTqBB+l1ROkFpMpKRmtpiS04AugznZNQkYj/BNl2U7BuBnQmCHZ5bpzYFrFJL2xi4Ea6knrhDH+zBXOJNla71DLckwLFn/i0jC37LXsPMvty1PLDMD8g5cB0+gYZujS85rnvdR5gqYamyLfovp6Xzpcduw/MqP2DLFWGrFkyK/bgP5EKKRZ5SsD6ZDxra8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBTRgt/gQiB740pVxZCLVhDDMeLx5xGBBAKBiiawVN4=;
 b=KjwT2E0R3XvPk834ROsYoHC2ew8oSD5aTqosITNMuYdfe6sAevcSv+1YcH+minn0fp5lsC8JVK04O4fAOk+cYnBt32LyJsMKp+uo/zYncDDpNNur+SRqn/mzesGstjY+ob8mFm6ufqV10PQ25tezeBpkAiAWtkihawzCiv4t47Mv8cjcP3SOxgf+WyNaHouJu7TXBa6/eEXPFQreOgPxd06m2mpue2A5mCIc6rVv29bnfnsG6BDIVEtN/kkxF66qYQ9vLHKhglsBBbcayoTr8UscEw9zOccLeX4aWDcCyUB1IuPohXNIwLaREGT8UTlp/93Lg4JdZ6nYkCAN8GuTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 03:58:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 03:58:14 +0000
Message-ID: <acf7dabb-d9b0-4601-868b-03cfff10a206@intel.com>
Date: Tue, 26 Dec 2023 12:00:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-3-yi.l.liu@intel.com>
 <BN9PR11MB5276A3AFF358A0E822AD22B08C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A3AFF358A0E822AD22B08C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d3be7b-b0c9-4f1b-02e2-08dc05c6e153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2//Ro8Ji6xg9SbK566WbYjRp+mY1lBZnbgLCVUM0l63QlQq+DvHCjG0eKGddTtoRpFxGd/AUnS2pXMr/1wpaD+KBvVREB718xW/yfYFE6xubVEVUsb1bdF7TxVWXIgJzE9+xGEtYbLKgiMfaeZDRybheFUSFEwkzvdxF2IXld+JcWNekCp/sDXgBOaULuAtRNHMQkvNDCHfUhV9x8O+5ixCwJ0UOCblojNXBTiaZHmpboKghdYo78anm6P2J7R+pF+sLIz/FJN8CCQ9NQ2OMmkVie8cpjL5YddzQqKq3MZbL0iad3t9SAqWZrKXAbOl4Th4pmnIOZqGRmCMta3EARbdo9QGPiW+Yn+BlIVAk3UDJsIF9MUSMZwTO8C8usEU2yJtFpR/3c5FP0DAJ691UOM9xlM/MfPVG6Buxshb2ml8Nqcvel3TvWa5VxTIKCW9g4DK9g4bi0kvdqa9JefrseypMGEBYEFDgSBoSiu0Ex85ru47xXm0WzKreJeDS2NrBcrgXbmHJ+S5LSPAbZPb9u5pyk+i52TdufVbqcTr8PGBBD63wqxt5MYuGDrUxW4Cuy/hVMpHkwSYle4wJz8gSOwp74IhshYNbMUwLN1gr8DNAzlZJA9VtwyASq/pn6pIeRwb4zNHrUNR+btIWX1B5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31696002)(86362001)(6506007)(45080400002)(478600001)(966005)(26005)(6666004)(6512007)(53546011)(2616005)(2906002)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(4326008)(110136005)(54906003)(7416002)(6486002)(5660300002)(41300700001)(82960400001)(38100700002)(83380400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhrWGp0ZWFFci80dVozK2crMmJhc1NXaS95N0xFZWhhK29xN0JNTXZVRnhv?=
 =?utf-8?B?eGppMEJFQzk5ZDU4cGZncFk1NDg0akk3KzBzZmx6OGdoMlQ3OGVYRXJNZHdC?=
 =?utf-8?B?OXBjK0VDL01Nb1JwcENkWkZXVVhsa1FsaENDdm9EdmFqaEo1ZlJBM1FGSU0x?=
 =?utf-8?B?bGhFVGxvamsrUndJMmw2UXh6eHJVeHlYM1BURjNOd2Nmd1AyV0ZxNGFjeVZ5?=
 =?utf-8?B?QVRtVnRBUWorWWdpQnlUd0hSL2FRbmNTaUNtVGdNSDlxcXJyNEZKdW9pNWxB?=
 =?utf-8?B?MU45VjV5eFFuTGEwK21yVnZBVWtDSmNFeDJYTTZ4TmtYcGxKVWdtMkNqOUJO?=
 =?utf-8?B?azJPMHlJa204QVg5K0RodmlDd21qc2x3SGpXVjFVWFdvZ2FrYk5QaCttQXlt?=
 =?utf-8?B?dlNOblVFR3pUWUh1a1MyeW9veXBtWXJDRG9pOTFZZXVETk5Rb29YdUpRWjJs?=
 =?utf-8?B?S1J1Uk9Pd0c0VDlBM2xHSXh5YzNTSHk0UUpZYVlaS3owRzBSaGN3WXJKVWFI?=
 =?utf-8?B?REIxa3F2eFROdVNudzNwTXpVYXh1TkVuSVVHbW9OZzQ0ZTgrMndtRTI4ZnVz?=
 =?utf-8?B?aEg4QnQ2U1dKLzYyMzlvazBQNVdsSkw2VmhVb3dsQy81eUlnOE9YclJUY3pL?=
 =?utf-8?B?WStrWmJVaXFja2F6VWV6em9lS3NONHlDQ2pNejRWYjUwN0dwRmIydzRyODJz?=
 =?utf-8?B?V3FhL0xuMWVFMjRnT1gzWk82UkhLeC9NVmpCbnJEV0xJWHB1citNWEM5Mk84?=
 =?utf-8?B?aGtCRXRwMUZKeUVjWE5UT0N2Tnh4T0ZtWS81T1BIM0VXOStCcUZNTTMxYzBE?=
 =?utf-8?B?aXlDYUowU1VEZG0wQTZWckJ4dzl3bzBGWExzUm5YZ2IxbGNTUHV6aE5jUkY5?=
 =?utf-8?B?b1hxaWtoNkluMjVMdDUxRFVvUEREVXpUL2V3Rm8vWkJxZ1JmZGJWMFh3UVFC?=
 =?utf-8?B?bWxONUc2d1RGbkNDVm41MUxuN2tsMEZmWGlzaWpyaE5qSm5nZ0M0Tm4xL2t6?=
 =?utf-8?B?OU03ejdsRVhnb296bFZzTGQ0UUFyK25PcTN0VGVKSFpwcjRBWHE2aDlmaFZR?=
 =?utf-8?B?N2VVSy92ZGZ3SUZZWmw0NkM2RmVSdTdmbnpvRzRWd01hS2JWb1JRT3k0ckRW?=
 =?utf-8?B?b1YzREhCaHdYRjVibHhadGFqbzRjeDZGWSs0d09VcWNLNXYxZG5RSzk1V24r?=
 =?utf-8?B?a3huZ0RzMUdKTXh3bWdRNjI1NUV0blJ3Q0gvbjdFQWZmM0dZK2VFSXdZdTZC?=
 =?utf-8?B?YWNPWHdEWFNRUXpuQUZMSC9oYnpnVG1SZXE0cTBhRTRxSUYyQmZHUU9CY3lL?=
 =?utf-8?B?MzJQQXZ3a3pSNVZnK0lPTUhtWngxejJhblgzZ1pGT2RhcDczbklNSXgxMnhW?=
 =?utf-8?B?NXFkYmJTUGRlUmRQclJTUHRQMGdUSjlOek9zOUt2am5SVEFoTmRHUk40UmdR?=
 =?utf-8?B?S0ZiZ3o1TE1pd0pUVUliUXA0MlQ1Y1QwbEJjV2x0c0gwd0NMaTdpaHl5WEs0?=
 =?utf-8?B?dEdDUmo4dzZIeFUvWTBiYzR2d3dhS2c0aHVXQ1dxdGdjNnBHMldaMFp3cmxG?=
 =?utf-8?B?ell3ci93SXF2dWlWd0t4NmlwTUdQSG5Qc21FZ1c1aGIycjdWMGxmSTBIVkRF?=
 =?utf-8?B?eHlZa0h5OEl6N2FIWEcraE8vTE43aEpPa3psQ2orczNPSjZTdGVzcm9tWjZS?=
 =?utf-8?B?QzdZTkdjdldYUWV3Vy9oUFp4VGl4VHBNbU83bzZtcEduMnQ3NUh6VzIrMTF5?=
 =?utf-8?B?T3ZHSkJlVCtvY0IvcWo3TmNQdVQ0UE1nRGhZSWlpSVNYc0ZWUkMvendRMUdt?=
 =?utf-8?B?SlM1QXRSL05idGJXd0hOem9RQkdoWWlOMW8zK1lBTStQVWJMWnB6YWpjeDRG?=
 =?utf-8?B?cTdRaHNrUytaQ3JIOFlFT3RPT0ltdHUycHJQeURBYWZXR2RJcTRWaENNYjZ5?=
 =?utf-8?B?cFZYN1VOcGI3dVJmVEVLN3BnSDFPUEc0ekpCKzAySmFVaEx4TGg3YjZTUE5I?=
 =?utf-8?B?NUp6bWNLU09FK0xhWEZwM1lmQ0NZRWhZTmZza1FiZEYvMEFhUEE5bTk1QUJR?=
 =?utf-8?B?L2ttWm5zZmVrTjJxYkg2Zmh1aHg4OWtBU0NWVFlKaHVsUWJ1cFhYV0Q3UCtL?=
 =?utf-8?Q?PLSCfoIDg6YAZmVVVqSX4UHNU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d3be7b-b0c9-4f1b-02e2-08dc05c6e153
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 03:58:12.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IjoTlFLhm8Ep8ssnP0N/Ao7ZPdzZGI3rxMCFkZ2py9wQ60VaqTkLY8dVKhVyS3j4EjXDWNxmiPD7wkWM/ufMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com

On 2023/12/22 11:19, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>> +
>> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
>> +	struct iommu_user_data_array data_array = {
>> +		.type = cmd->req_type,
>> +		.uptr = u64_to_user_ptr(cmd->reqs_uptr),
>> +		.entry_len = cmd->req_len,
>> +		.entry_num = cmd->req_num,
>> +	};
>> +	struct iommufd_hw_pagetable *hwpt;
>> +	u32 done_num = 0;
>> +	int rc;
>> +
>> +	if (cmd->req_num && (!cmd->reqs_uptr || !cmd->req_len)) {
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
> 
> miss a check on the __reserved field.

done.

> 
>> @@ -323,6 +323,7 @@ union ucmd_buffer {
>>   	struct iommu_hwpt_alloc hwpt;
>>   	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>>   	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
>> +	struct iommu_hwpt_invalidate cache;
> 
> this should be in alphabetic order. I gave this comment in v6 too:
> 
> https://lore.kernel.org/linux-iommu/BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com/

oops, I did miss it. sigh, I paid too much attention to the error code
discussion in the end. :( I've revisited the comments and should have
done now.

>> +/**
>> + * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache
>> Invalidation
>> + *                                        Data Type
>> + * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for
>> VTD_S1
>> + */
>> +enum iommu_hwpt_invalidate_data_type {
>> +	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
>> +};
> 
> Defining DATA_VTD_S1 at this point is fine, if there is no usage on
> DATA_NONE. But following vtd specific definitions should be moved
> to the later vtd specific patches. they are not used by the common
> code anyway.

sure.

>> +
>> +/**
>> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
>> + *                                           stage-1 cache invalidation
>> + * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only
>> the
>> + *                            leaf PTE caching needs to be invalidated
>> + *                            and other paging structure caches can be
>> + *                            preserved.
> 
> "indicates whether the invalidation applies to all-levels page structure
> cache or just the leaf PTE cache"

done.

>> + */
>> +enum iommu_hwpt_vtd_s1_invalidate_flags {
>> +	IOMMU_VTD_INV_FLAGS_LEAF = 1 << 0,
>> +};
>> +
>> +/**
>> + * enum iommu_hwpt_vtd_s1_invalidate_error - Result of invalidation
> 
> "hardware error of invalidation"

done.

> 
>> + * @IOMMU_HWPT_INVALIDATE_VTD_S1_ICE: Invalidation Completion
>> Error, details
>> + *                                     refer to 11.4.7.1 Fault Status Register
>> + *                                     of VT-d specification.
>> + * @IOMMU_HWPT_INVALIDATE_VTD_S1_ITE: Invalidation Time-out Error,
>> details
>> + *                                     refer to 11.4.7.1 Fault Status Register
>> + *                                     of VT-d specification.
>> + */
>> +enum iommu_hwpt_vtd_s1_invalidate_error {
>> +	IOMMU_HWPT_INVALIDATE_VTD_S1_ICE = 1 << 0,
>> +	IOMMU_HWPT_INVALIDATE_VTD_S1_ITE = 1 << 1,
>> +};
>> +
>> +/**
>> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
>> + *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD_S1)
>> + * @addr: The start address of the addresses to be invalidated. It needs
>> + *        to be 4KB aligned.
> 
> 'of the range'

done.

> 
>> + * @npages: Number of contiguous 4K pages to be invalidated.
>> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
>> + * @inv_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
> 
> '@hw_error'

done.

>> + *
>> + * The Intel VT-d specific invalidation data for user-managed stage-1 cache
>> + * invalidation in nested translation. Userspace uses this structure to
>> + * tell the impacted cache scope after modifying the stage-1 page table.
>> + *
>> + * Invalidating all the caches related to the page table by setting @addr
>> + * to be 0 and @npages to be U64_MAX.
> 
> here should clarify that the invalidation applies to device TLB automatically
> for VT-d.

done.

>> + *
>> + * @inv_error is meaningful only if the request is handled by kernel. This
>> + * can be known by checking struct iommu_hwpt_invalidate::req_num
>> output.
>> + * @inv_error only covers the errors detected by hardware after submitting
>> the
>> + * invalidation. The software detected errors would go through the normal
>> + * ioctl errno.
>> + */
>> +struct iommu_hwpt_vtd_s1_invalidate {
>> +	__aligned_u64 addr;
>> +	__aligned_u64 npages;
>> +	__u32 flags;
>> +	__u32 inv_error;
>> +};
>> +
>> +/**
>> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>> + * @size: sizeof(struct iommu_hwpt_invalidate)
>> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
>> + * @reqs_uptr: User pointer to an array having @req_num of cache
>> invalidation
>> + *             requests. The request entries in the array are of fixed width
>> + *             @req_len, and contain a user data structure for invalidation
>> + *             request specific to the given hardware page table.
> 
> Just:
> 
> 'User pointer to an array of driver-specific cache invalidation requests'

done.

>> + * @req_type: One of enum iommu_hwpt_invalidate_data_type, defining
>> the data
>> + *            type of all the entries in the invalidation request array. It
>> + *            should be a type supported by the hwpt pointed by @hwpt_id.
>> + * @req_len: Length (in bytes) of a request entry in the request array
>> + * @req_num: Input the number of cache invalidation requests in the array.

s/req_len/entry_len, s/req_num/entry_num per the comments in last version.

>> + *           Output the number of requests successfully handled by kernel.
>> + * @__reserved: Must be 0.
>> + *
>> + * Invalidate the iommu cache for user-managed page table. Modifications
>> on a
>> + * user-managed page table should be followed by this operation to sync
>> cache.
>> + * Each ioctl can support one or more cache invalidation requests in the
>> array
>> + * that has a total size of @req_len * @req_num.
>> + *
>> + * An empty invalidation request array by setting @req_num==0 is allowed,
>> and
>> + * @req_len and @reqs_uptr would be ignored in this case. This can be
>> used to
>> + * check if the given @req_type is supported or not by kernel.
>> + */
>> +struct iommu_hwpt_invalidate {
>> +	__u32 size;
>> +	__u32 hwpt_id;
>> +	__aligned_u64 reqs_uptr;
>> +	__u32 req_type;
>> +	__u32 req_len;
>> +	__u32 req_num;
>> +	__u32 __reserved;
>> +};
>> +#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE,
>> IOMMUFD_CMD_HWPT_INVALIDATE)
>>   #endif
>> --
>> 2.34.1
> 

-- 
Regards,
Yi Liu

