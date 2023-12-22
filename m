Return-Path: <linux-kselftest+bounces-2344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FB81C3AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A133E282A31
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9786D6FE;
	Fri, 22 Dec 2023 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL3/ckI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04905539A;
	Fri, 22 Dec 2023 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703217389; x=1734753389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RNxZXXpODuSau/0QLoA24AhEeGkISWbXA4Gm5BZxtTo=;
  b=gL3/ckI/2wDboQEhP1B0T0FIhA4/DHqg15clSM0vOYRNitUquZ1LnMdp
   e95+cQi8NhNjddu8bKP3o9pstDu9LAnAeaigvIbBa/CZslO+FAGtJ77ai
   kEMGCK05hVIOdnHmTHvmk2n64eIDOPpJSpTnG8r0EMFaoMPhew9FO3DxH
   h8GoCIP8cbNM/avTmc0EwbL2mY1mX9J/8mnmYpj5xWI3LtYj96vxNuvRH
   iY/EZqKduIH1pvPzpZVFfePgfGqhblrccCiSUKmWM3hy/HkNf/lUYjVR9
   +/JVjhvsLoBzo+W8wU56g0QjFd5Qm2+cvFuAsx7zNeZCw9LM35rPQP0Ww
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="14749137"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="14749137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:56:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="811204400"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="811204400"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 19:56:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 19:56:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 19:56:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 19:56:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3cZ32houhry/PBo7p6nhRxt86D4UdKX1nvQlOu0QaTrnzJKhlLBmtxhof7Stc/b8A7+OgJtS30Prk0xOdNRAWZH88IHk82LoLZvNovrD4yYTWXm6AqxmBFH5KeaCUfuINbbWYELQmNsUX6pZ3rG8UiZc53z5Xo3h4zxp9hig0JNq8U7LwDGT3fQ0WbdnXIi8n3QFjHhF9jmEBzc+2ggo9tSobMjtetE05iufJwiq1yQsTKvn7ixk7VEGzbKFZgugQKjAhockc6OU2ydAyLhUbzQI3HnERAWSmRX6M4J0lzuosnLWwSGTqeDoKVxbc83OY6he4Y2m3qIdx02MYmUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg94TVj59Rbv0VJ52jgnr9FOHO38rvHEoNDlHbReawU=;
 b=HuqSo3Qg+iZxvJEcoekJSP+FDzWkQaY/stBkDe+V919tA9ZFLjWlh99cJNl5fCuw9WPrmg70D+1XZPGXRdsTWELVVzUxAGCqeKFa5VvRbFsJ4vqezyawdjdY1amz7SW4GNOKZIWivuT0EsPz1QdczIUoAC8wcPKP3KvAMuCUrq8FuAp7/xlFxr3Cso8wjeAWeW3w1C+zuHq6qMfa+IaugkwDlZi5JzWZBp+G7zd9ybvWrabarvdfRUaf6qgeyKBdE/WsBDD3k0Mo5BLdW9uiVAgMLXBSKDwiBUw7xBs0yQiDQgoWqfa0Av8SClzZ+2CKYi4PqLc/TdrB6WrnA8DvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:56:23 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8%2]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:56:23 +0000
Message-ID: <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
Date: Fri, 22 Dec 2023 11:56:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
To: Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
 <20231221153948.119007-10-yi.l.liu@intel.com>
Content-Language: en-US
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20231221153948.119007-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 216ce2f9-e851-4194-12e0-08dc02a1f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8h8QhT9BdH+AbiUoh3gi7t1qFw9IW2HtS5vZllqFYWNvbM9WD7StJvurYfcVd9w8jjU2M7i73j82/QJRhY7kAiexUaNPvh3gSpJFnMXfIVe6nE7CcYonfB7NRgyG90toFEfG8fRaN9aWX5EDrv1q4SDlQkyL9iYJWeNVLP7xi/vvWhyHbMA6NJcseduhETpxI1QO3peSb6i7idslLnaAkcK8hRnD9brT9/VSnnW8KBZm7W3PB75Js/Pdnvjsdzv2WzYrX3wOpSOOWixOEkH79YB/sZWoa7ped55BDGf4GnePe3BT5vlNPNGqGaM3dve98AnPFYFzV8AfVWCnQ81VgWO/Wdaci1r3dLIxTQ5ODShuTRpzv4dImeTPLTaJduiitAP31zTgelj7Ig/RQ7T0l3HuFRsT6MD5J3RaU/lyKawUYBcagVqhDJPQ4ug2oDut7gN/+Jfo4Cp8V7XoOpcQKXKTVBmPA6gvsanx8wOEaLYG3lxEjyz+5wHihM3WyIiZJ7zTkXUEAfM60Rt2WA7ilfyL/Rdvn/5ocSGu6tIC5yEqFnu4WT0ygdCBIbqrXnfnMlO4RgMHO3craAuNkhZtIXOv+NTaSRchvdHMLvxk9i+AG2e+fPn1kB3eIJJ8EN0Sm3HCpgsbPo63V4g6SJCpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(41300700001)(2616005)(38100700002)(66476007)(54906003)(66556008)(316002)(7416002)(2906002)(5660300002)(8676002)(8936002)(4326008)(53546011)(6506007)(6512007)(6666004)(110136005)(66946007)(478600001)(6486002)(82960400001)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitVdlB2RlYzRjAzUnVtSjRBZklqRElmTEhKdzRUNkQ4VEMzZVRRak1pUE1z?=
 =?utf-8?B?cjBPNzlZNVhneW84UjVvdjB3VnRudmdOMCtwRmJadTdHMHdVeUljVllkVi9N?=
 =?utf-8?B?THJrakg3bXJ0UmQ0WWlPK1pDL3IzVkR1bm5rc1NoM1RTSmw1aEpkei91b1FO?=
 =?utf-8?B?TmhHODVZTG81K0N5YjN3K25hSkR6TEdDZGJKV1JWNnUzSzZmdHh3Z0Zjb0Ro?=
 =?utf-8?B?amZWNHNxT1huaXNXWHkvLzhOVERaU1RucDhpYXdnTmhLWjEyUng1TThWMERa?=
 =?utf-8?B?WkxrMzlNRGlIZWxXNmN0d0hVVjhra3pTeUVtRUpBdUlCeGxKKzJRekYxQytv?=
 =?utf-8?B?aE1nWXBwQXFvL1lTSi81M3ZHa0xLTlRIYjgvU2ljZXZiV3RZVWwwR2FYRlQ0?=
 =?utf-8?B?aWY1VnYyRWd3S0paMHpuT1VNQ3RWS21RMEpTc1Y0azZrL09XNkhacExVTHhZ?=
 =?utf-8?B?M0ViajI3OVFIVmNhRE1WZ3RMOXh5NWdFRDUwOXd6YnZLRStkaDlrYS96MldH?=
 =?utf-8?B?RkpDSHg1d2I4NHB0MHZmSC92N2hQUWpabnljZUJEeE1pL0dud0YzTkRpSnV0?=
 =?utf-8?B?Y3NNMjMxVGJCT3ZpbS9HWTQvUUtCSHBUcEJYSUpqdTdnaFpnSm1KdDBKejhu?=
 =?utf-8?B?TnNsc3ViQTluS0JVUkNvazFvRTBSb2FQVlF0OXFPNjc4dG4xUHVpYjd4MGJV?=
 =?utf-8?B?czdncUJQRUREeFB1Y1o3ZUg2NU01UVlVSTNLOCt6Z3RGNnVZNEh0dzVyQ1Z5?=
 =?utf-8?B?TUcxUHYvelM0Vlhsd09ZRVRtOVVZOURmVXFRRk9lSVJHTVRCY0p2UGtIc2Y0?=
 =?utf-8?B?T0xabXdZOHBleC9Pb0Uvckh2cVdQME1IWVY0NkxkQmFaT2FqUkxPNzVhak9E?=
 =?utf-8?B?T0J6dGRMeG9MYWQyNmdVejBmMnNkOG8wTGQ5N0ptempSamdPUFhMczJWM0Ny?=
 =?utf-8?B?eEJueEVaVGcvaUZlOW1iMmx5dUM4WEp4ZnUvcW9HNXpnbVZpTnlPUVhOUmdW?=
 =?utf-8?B?OXVFVjVHamd0UjVJMnFnUUtyMkVrcGQxeDhZa2UwdFpiRDdueFBYQlpZSG5T?=
 =?utf-8?B?UFA5TUx4K1YvY1ROcWdQWU9laGsvUFBsSDR4MEp0bFIvQmpmMmJpUWVZL0dy?=
 =?utf-8?B?RVdpQWMrdVNrMEJlMnN5UC91U2Q4RU94Q3lPU1FZSmNIbW1Md05lWlBTMnJT?=
 =?utf-8?B?azI2bmtta3NlbVh3RUZZc1RqeDBwNnRTSEFXTWdRU1llUkdpWi9SYzgwWG4y?=
 =?utf-8?B?MnlGdHRsM25uNGVobm9YanJ0SWhhdUJIZ2poL1QyUUFiSFQ2QllGTVBCeTJy?=
 =?utf-8?B?OGQ2U2ZTaWVTS1V4NTUyeS9NRTlsR0tVYlpTczdTaS83WEcxQVg2cExxdmNZ?=
 =?utf-8?B?UWd4eUZKQ25kL1VuVktyamw3ZkppNmNYNTBSemV4emE2aDAwemRMRXJ1SnZl?=
 =?utf-8?B?NDMwNSswMWhMMDRyVThzNnRaSEUzcytOOEd2ODA4OVZiRkswa1AwTXAyZCs4?=
 =?utf-8?B?MFhUVmRmL3hMZUxwSE1wbGc5KzQxcjU5anhlcXg3TEFUMUEvSE5RM1NjaTZ1?=
 =?utf-8?B?aTBBMnFzZXdFa0srRFErT1FFUHFiZHhzcFgrcUxKbDVWLytuSVlPTERmbVYv?=
 =?utf-8?B?QkdWcmVSbENlcGRpTzdEOGlMZVpNZzNMNUlUVFJFMmFnV3lmRjRKQm9taWV1?=
 =?utf-8?B?R1p6b3dkOEJwNUR1WDI5OTNucVFMaVUzVXk3YTU0aXJsVm9nOUc0SGw0SFdC?=
 =?utf-8?B?dkZKZ3l4SlgwM0RacXZheWFmOGZseldUcmZPanFZWlBZVzRmSUpxRXZRNVBV?=
 =?utf-8?B?ZTdPZHFJU0xPSlRmYnpsanhMQURWL0FXMWJGZEIrVHM0NWxzR3RRdjJMOC9T?=
 =?utf-8?B?L1FsNjcySC91bmVtSFYxc3pMWXhRdWp5U05GM21vTHNyR3BSQUE1cnhLUXB0?=
 =?utf-8?B?eFdlQlZ6ajRBbFNDc0ZXZHhRd3I5VEZWbTh3bGdBdDhLRzEwZHduQ0NQd2sy?=
 =?utf-8?B?NHQranpQOEFqWHJVK1dPTjNzNnY5RHYxeEc2RnNnOE1pcyt6d3N5dFRuQ1Jz?=
 =?utf-8?B?aldNMEZEMUhiTTJxU0VTT2YwZUU2VFhKcnNQL3piUVZZeXdhTHNLQXROSW02?=
 =?utf-8?B?STJjQ2RlRlFPSEJiaEtSZkZoUGtlbVk4MExUZ3R4STVwaGlpNWpWRUlUelVE?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 216ce2f9-e851-4194-12e0-08dc02a1f6d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 03:56:23.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pwHSY8IsLVySvaOd18Udln3K+WrJzC7XUu/ozbPX0jQJJmKg2I3XGHP6W2dW5liUbd0Qrqm8dvhKOdtk4ocsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
X-OriginatorOrg: intel.com

On 12/21/2023 11:39 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> This implements the .cache_invalidate_user() callback to support iotlb
> flush for nested domain.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/nested.c | 116 +++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
>
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index b5a5563ab32c..c665e2647045 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -73,9 +73,125 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
>   	kfree(to_dmar_domain(domain));
>   }
>   
> +static void nested_flush_pasid_iotlb(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, bool ih)
> +{
> +	u16 did = domain_id_iommu(domain, iommu);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	if (!list_empty(&domain->devices))
> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
> +				npages, ih, NULL);
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +}
> +
> +static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
> +				   unsigned mask, u32 *fault)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	u16 sid, qdep;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!info->ats_enabled)
> +			continue;
> +		sid = info->bus << 8 | info->devfn;
> +		qdep = info->ats_qdep;
> +		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> +				   qdep, addr, mask, fault);
> +		quirk_extra_dev_tlb_flush(info, addr, mask,
> +					  IOMMU_NO_PASID, qdep);
> +	}
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +}
> +
> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, u32 *error)
> +{
> +	struct iommu_domain_info *info;
> +	unsigned long i;
> +	unsigned mask;
> +	u32 fault = 0;
> +
> +	if (npages == U64_MAX)
> +		mask = 64 - VTD_PAGE_SHIFT;
> +	else
> +		mask = ilog2(__roundup_pow_of_two(npages));
> +
> +	xa_for_each(&domain->iommu_array, i, info) {
> +		nested_flush_pasid_iotlb(info->iommu, domain, addr, npages, 0);
> +
> +		if (domain->has_iotlb_device)
> +			continue;

Shouldn't this be if (!domain->has_iotlb_device)?
> +
> +		nested_flush_dev_iotlb(domain, addr, mask, &fault);
> +		if (fault & (DMA_FSTS_ITE | DMA_FSTS_ICE))
> +			break;
> +	}
> +
> +	if (fault & DMA_FSTS_ICE)
> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
> +	if (fault & DMA_FSTS_ITE)
> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
> +}
> +
> +static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
> +					      struct iommu_user_data_array *array)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
> +	u32 processed = 0;
> +	int ret = 0;
> +	u32 index;
> +
> +	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (index = 0; index < array->entry_num; index++) {
> +		ret = iommu_copy_struct_from_user_array(&inv_entry, array,
> +							IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +							index, inv_error);
> +		if (ret)
> +			break;
> +
> +		if (inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) {
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
> +		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		inv_entry.inv_error = 0;
> +		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
> +					 inv_entry.npages, &inv_entry.inv_error);
> +
> +		ret = iommu_respond_struct_to_user_array(array, index,
> +							 (void *)&inv_entry,
> +							 sizeof(inv_entry));
> +		if (ret)
> +			break;
> +
> +		processed++;
> +	}
> +
> +out:
> +	array->entry_num = processed;
> +	return ret;
> +}
> +
>   static const struct iommu_domain_ops intel_nested_domain_ops = {
>   	.attach_dev		= intel_nested_attach_dev,
>   	.free			= intel_nested_domain_free,
> +	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
>   };
>   
>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,


