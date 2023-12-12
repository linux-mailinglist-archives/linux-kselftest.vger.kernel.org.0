Return-Path: <linux-kselftest+bounces-1641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664DB80E301
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C471C21947
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D064C148;
	Tue, 12 Dec 2023 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCu5FG4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7436FD;
	Mon, 11 Dec 2023 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702353084; x=1733889084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1sHm2SHlVeJ23NSpoCykbJPICcVtmz+X8r+GIE4kUZ4=;
  b=YCu5FG4Kzj/2V+m7nTP0idfL9QZz9Z1lCP/OnNdMiLb95fa02nBmVZ8i
   aJPipVUAlPOPnBaeoNknUJB9k+MhKJq3jNcHeEHUQ9WJkmdZmsxmpC+0a
   G0iKAG7CBAEmWHiXABnvi8bkD9zBrrvGXhINHdDXD4cf+sJBbc0drVnQp
   KloQh1Jj2qYvJI7C7x3LWpBsdoS0DY/8B6JqMQWCPq6JgU4dvwe7o9LLL
   +6azcPbsxJwJfl8WVp3m6xZOkBFKrgiJYIkIXliPuU7bH7JD6r+FE7SM2
   hS/Hp6Y3ccPOIoWBj35m6hF/8cTSMx9UmV4/+8wCQDZif8dv0kyft9ciV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379744346"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="379744346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766651959"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="766651959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 19:51:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:51:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 19:51:22 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 19:51:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXnAt62bCXiWgepcZfe8lksgC0rpkIAQG3XI/v5+h/QL5eGEqtHP4zgwNATFcBY+pgYE5GRuELjqRI7e7D8KUJy8z7Xq+vt15KgotoAwrlXhF6gkh1tQ1OsNkl1KW3hAVpHAw015Mowsc5oGnnzoZiU56tEhK0GV6N7XzQ2g76KjsvUTKF4Z9kcGXI+HiJ9yPL5DA2/RUamCfpdYRL6UQMJfg5nR8pPMxijzGtXsDl0k7ms5pxpnIQBBri4Ov7iKo9pZui4PA8aOxF5/vPjw1IyujCL56pIdjcAygzM+vXUyA3S2KG+vMglqHgpHu2/pjmkYVP2gWG0exlA1Z9GzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXr+lYFpS77CqeXBVZuM1XC7n3+3/zMojF3qKznYiTM=;
 b=jDldzoN2OEXeUAhRMXtt5KKd3Rwg2L3jzlb9oTt8HA3vs5NpOUpvkCFHd1Pc4VMReKLk37vobegP5xlREax+WMmfSOL2Cd7oVFvhe8U8g8FJ8y/QhnFI09uIKDThONO33coJ2r85N0fWMDqCH84ThBVtlxq/K8kRSRG3bgpUl069RWFDnv8x8p296N3+oDcXSsUKnNEd5hpBiylRPBnJTZ9pgYegMn2DEvG416qJtXtP8sWcyrdyCuPoDQuciofcp8SdeY+Cq6h6wn8FVYz/2bRpTpCJXkG59SBTj2EUoatVkHpfUTs9YdAx6puz2bflFDXcn6dYUND5sWMwBIBl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 03:51:15 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 03:51:15 +0000
Message-ID: <25455a53-0437-4f84-98e5-0e744d46be72@intel.com>
Date: Tue, 12 Dec 2023 11:53:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231211203946.35552183.alex.williamson@redhat.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231211203946.35552183.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f71a3e-5bfd-457f-2901-08dbfac596e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5xsPpCiPT9f+NsB9QuQDqpKODaJ1VtPv0P1o/25+B62Rq6UhmGoDRJNxEonIvBF/A31x9g6vA91LaamljaEGKWIH3s36OJjGTVlh1wP9G380AK6y89KwiBLvlVYKkedDwBAmdCoCgLudfxn90yCdcURkTqr/JckfuXnsHMmexslUmmqEIZp3ZxLN7mMqqAPxC1Hazo8yzfkOc9RgGEyATyXEt5goXPCUEk6eYoonnOvbHYwzmVDtKWp6/m9wz5Dfu3Jq+Ex86FGotuxDeI9xxUX04sWYGZTJQf2TxYv07o4o8Qr/mXa1j1PSkA02FsmOv7bhq/HWxuWlDRhiAcW1Kuq2qGFSW5BC2TsJWZxGwwrtOdTj131ur3ynxqAgZhxXTVKJ2iZe/9dktZRDyo+kpshXwo3fVdXnTKS91QcTtX/9TRJLnzDP/Hfk4X9hN6Dbd1fk9qZfwrcAl2s3yVsOhuh4OQ0qJbN8Dn6HnEZ1fe5LCbXU7YIncyinPAR5QFehpQo8UNXcV7igTwYVz0LQrLZ6f6wPMXk9LuJlSAY85Id2zXe42ltvXpiN5psaEN3m1GqrnEtdh2QZ9HKApHJMnfYQCTUisXcvy39740S+7Hj9P40eBSvl8s9f3FaEiXtk7RYtKpRlwxRNAozDYvnxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(53546011)(26005)(2616005)(6486002)(6666004)(6506007)(478600001)(41300700001)(83380400001)(7416002)(2906002)(5660300002)(66946007)(6636002)(54906003)(66476007)(66556008)(4326008)(110136005)(8936002)(8676002)(316002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0toR2ZncHNzcGc4VmtmR2Y0cU5EY1N0YzVtYU1hOFVPbERDbkhXVG9aSVRq?=
 =?utf-8?B?dTBPSHdxbWdQQ0gwZGJjb0xYTE9HZlhYZGRKUXFoRk9yQWt1ZmhSNFoxblBV?=
 =?utf-8?B?VDkvNVhJd29rL1NVV2VvTnFZU3JRci93Q2tGak1EQmpwZ3ZKYnZsV3JFTjJU?=
 =?utf-8?B?UThBOGFTSk1aRlhYWlVyWVFVM3kwS0FkNHEzbWlLaWlOcWE4Y2NRYXBKYXJD?=
 =?utf-8?B?R2VSOFRIUEtscDlwM1pDaGNaUENCcGkreGdSQi9aMGdxcFR5aXRnQjM1VWl1?=
 =?utf-8?B?d04zQVBJV1cwVTd6cTA5UHNEUU9IU3RtUUoyc3pxWUd6aDcyRHlEVUZwQWlv?=
 =?utf-8?B?WVBsMjc3MHRVODdpODZ3c0M0LzhwV0hUZE5hZVJldGJnWWRDdTZ3ZnF0NEhH?=
 =?utf-8?B?d2lPSGVMM2ZodWlIeUQ5cjJ0UlRuZis3a3dzK09kckIrUXNMQWg0ci81RlhV?=
 =?utf-8?B?dW5ESTcwVnJ0YjVxMVQrd3NJSEVWREZaZ3Q2Q0ZMSzAyaXVsV245RGJQSDZu?=
 =?utf-8?B?NXJGbE8yRzRCYUMyY0c0RGZYNmFReExLQXhhRnlORlo5cDlBeTRzRWw5UTRX?=
 =?utf-8?B?Yzd3SVVPeEEwdkxXUUtWQllMWE1lYUt4SDR1dlYvWWdWbjhuQ0hONWIzZW9q?=
 =?utf-8?B?SlhzcS9YbkhrRm9ISDhZdFhMbm5uZFZOT09TLytHSzhFRE04N1RQTGgvbHBk?=
 =?utf-8?B?a3BvTEl4OGpkNDlvcC80d2FXY3NUTUJrek1vVXNkZVIramZvbjdObVN1UkMr?=
 =?utf-8?B?QXNKWm9LSlpSM2xEWmNUOEs2c25kbmE3eEdRV2lxa1NEeHFQQnd6ZkpPeWFL?=
 =?utf-8?B?REtCdFp1SzZoUEpLQ1pIdjRNVURYd2JBRlNDRU5mU3RqcVdhcDRpSGtISGo0?=
 =?utf-8?B?ZFZiL0pSTDBQM1dPV0tnMjhqOVhyMnNGb0dPUHBFNU9zTUxFWU9sTHJ0NlJh?=
 =?utf-8?B?T2NYTFVoMDlNODdMenlBNVFlTFZpbWNhVTU3VmloeVAxL3c5UVgzc1dYdFdG?=
 =?utf-8?B?MHNXMXlBa29xL3ZyVWtYVWE1RUlNL09LZDFIVkszSVNXY2VmeCtZUXozOGJW?=
 =?utf-8?B?UU1TdThka1VaRHJVU0tHMFFtbHBWWkpQZTRIVUZTS3hqWVNsQ2RPYURtQ3pW?=
 =?utf-8?B?S05hcjZZUGpIMFhERkZNZm9yN2w2QkQzRngrQ2FUUEdQQXBaR3grRlo2bnA5?=
 =?utf-8?B?Wm1icFYzUnZOb0JzZEhEZDlDWXZrQitIRW1sNys5WHo3SmUzZ3c4aHVDZFlJ?=
 =?utf-8?B?eFA5NmNzclMwMFJ6Ny9YWkxWMmxtY0JCdzVoRER5T0hiK0J2WkNTWURPSjRM?=
 =?utf-8?B?aFJLM2FKRjBZMng1N2tWMGtTbXJlamFiRStGSVJmOXhCcGpabXB4RER4dnBq?=
 =?utf-8?B?eUpubEhLMnpjYXh6T05HSHBudDVobG90QXFtUDlKdUZjN2dQZEVjd1lNWVps?=
 =?utf-8?B?SjEzTzU0SEhHaWVld1NjK3czbFptY3NsNFRqR1JHUDlwWUd6WmlMdDFCUXVl?=
 =?utf-8?B?V0JRV3V1WkMzSldqSUJMT2d0aG0vZG5IWVc4UnJrOGs0Wk8rOW14OGtMc01N?=
 =?utf-8?B?ZVhaS2UvMXVqdWprSkRuTXNRM2V6SnN4ZlY1bmRKUC9kNWg5Q2NoWTgvMlJv?=
 =?utf-8?B?cndyY2NVVGd1eTVPa0Zhb2NtdW92TTZxRit2MEdMZ1RsTnVhOFZPNVFnT0pW?=
 =?utf-8?B?MEU0VUM4MFBCT2l5bWcwWEtuellQcVNYaGJLZUdCU1NPUGxmOGpVTk5uUVNS?=
 =?utf-8?B?cUdUVks4a3ZYOVA1VDNqdzBKaVZPNDgyb3g4Y1lVVEF6eXd2cFFBYS9JZGRp?=
 =?utf-8?B?WDg4WG1uYVNtVWdxQWxzSzB3V042dG96QXl4MTM2eDFIVWtWNTBqN0VKNlcx?=
 =?utf-8?B?cllGYWgxaEJkSXRCV3hmdnlHWUJlcmh2MDVqRVErL3hXNEErZzdkR1l0eGVP?=
 =?utf-8?B?MUgxQkJxaCtyZ2oxY01IcmhmOVl2dXY3ZWxDelNPL2Fnc0V1SC91SUtqSHQv?=
 =?utf-8?B?R2hMVllOZGZZOUsza0pnMmpVa0NrUDhxa2ttcERzVkhLaWZCYnVySVRuZjM2?=
 =?utf-8?B?YjMvb0dFdWl1NHhCN0J0d0ZXOWRHNElOL1hSYnN2K0NYRmczb1d6WnBuMkM5?=
 =?utf-8?Q?ZVy7FYivMvdHcSJRd78JOZOeR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f71a3e-5bfd-457f-2901-08dbfac596e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:51:15.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvWROiF2EHd0Pw6JfUWo6AJs3HcPHw2q3WsnV1C/xJn1yVHhd0r02qDbHAbLo4rw1vv39h4ljCpEroxicGNf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com

On 2023/12/12 11:39, Alex Williamson wrote:
> On Tue, 12 Dec 2023 02:43:20 +0000
> "Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
> 
>>> -----Original Message-----
>>> From: Alex Williamson <alex.williamson@redhat.com>
>>> Sent: Tuesday, December 12, 2023 2:04 AM
>>> Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
>>> VFIO_DEVICE_FEATURE ioctl
>>>
>>> On Sun, 26 Nov 2023 22:39:09 -0800
>>> Yi Liu <yi.l.liu@intel.com> wrote:
>>>   
>>>> This reports the PASID capability data to userspace via
>>> VFIO_DEVICE_FEATURE,
>>>> hence userspace could probe PASID capability by it. This is a bit different
>>>> with other capabilities which are reported to userspace when the user
>>> reads
>>>> the device's PCI configuration space. There are two reasons for this.
>>>>
>>>>   - First, Qemu by default exposes all available PCI capabilities in vfio-pci
>>>>     config space to the guest as read-only, so adding PASID capability in the
>>>>     vfio-pci config space will make it exposed to the guest automatically
>>> while
>>>>     an old Qemu doesn't really support it.
>>>
>>> Shouldn't we also be working on hiding the PASID capability in QEMU
>>> ASAP?  This feature only allows QEMU to know PASID control is actually
>>> available, not the guest.  Maybe we're hoping this is really only used
>>> by VFs where there's no capability currently exposed to the guest?
>>
>> PASID capability is not exposed to QEMU through config space,
>> VFIO_DEVICE_FEATURE ioctl is the only interface to expose PASID
>> cap to QEMU for both PF and VF.
>>
>> /*
>>   * Lengths of PCIe/PCI-X Extended Config Capabilities
>>   *   0: Removed or masked from the user visible capability list
>>   *   FF: Variable length
>>   */
>> static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
>> ...
>>          [PCI_EXT_CAP_ID_PASID]  =       0,      /* not yet */
>> }
> 
> Ah, thanks.  The comment made me think is was already exposed and I
> didn't double check.  So we really just want to convey the information
> of the PASID capability outside of config space because if we pass the
> capability itself existing userspace will blindly expose a read-only
> version to the guest.  That could be better explained in the commit log
> and comments.

aha, yes. It was mentioned there, but seems not quite clear. Will refine. :)

  - First, Qemu by default exposes all available PCI capabilities in vfio-pci
    config space to the guest as read-only, so adding PASID capability in the
    vfio-pci config space will make it exposed to the guest automatically while
    an old Qemu doesn't really support it.


> So how do we keep up with PCIe spec updates relative to the PASID
> capability with this proposal?  Would it make more sense to report the
> raw capability register and capability version rather that a translated
> copy thereof?  Perhaps just masking the fields we're currently prepared
> to expose.  Thanks,

I have a minor concern on reporting raw capability register and capability
version. In this way, an old host kernel (supports version 1 pasid cap)
running on top of new hw which supports say version 2 pasid capability, the
VM would see the new capabilities that host kernel does not know. Is it
good?

-- 
Regards,
Yi Liu

