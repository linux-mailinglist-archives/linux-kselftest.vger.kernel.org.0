Return-Path: <linux-kselftest+bounces-1640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75780E2E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6891C208E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF28F65;
	Tue, 12 Dec 2023 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVChpUbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F44B3;
	Mon, 11 Dec 2023 19:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702352513; x=1733888513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qUT265DnDEnY+YPiH1vvOgEzgdGCQxTiYCqcVDeV9EM=;
  b=UVChpUbJCtPTGi182XE5kAOOv3Il2LfvjxxEGlQfC7nOwmxsdYty141Q
   wetHkLktp4S+Q0quzfl54F/t7PZ88VzlTlEqVrcgm1RuOpFMqKPaYXLB9
   h855yr7VdavJilJFXfTIVdPZXiPO3DoQ+kpJr2YOpXoY5rUlxEp1HJGCO
   ZDzGHL5rrQgg9m+WzuszmKURz2X28D00KvDPrFSwp6C/vku3s+0Up/9hF
   rklLHgeQs4nedxOwFOScx9flJfM0o73+vdEFU+GOZQCsWQAbG7dTKH1X+
   1ijTLfTuX5kUZZlS1LKdicVkesNatwj/0VXizRjpQWzpTGelnJuQ5+HUP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461224508"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461224508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:41:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="807581539"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="807581539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 19:41:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:41:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 19:41:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 19:41:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+x4/YReTDytnN9zODf3R2mJ0xyOQhXgUvmpt2HcBkVmUcibhSoP7UaAX0qSVu7wOMjsyvZOydy5htK12gSpd80NRtpDJKsUKyYlV0C/BxGTnpifFZJ83PW6aKvHNZctNiJoLj2xPd2XQuiQ0lzQ6QYmM3acRANzFoksSf5IuqUudY2ziJuOWRYXzqxRtcITPHoPXbLPmZbXe/nb9z3hsZm+xwJm6VvLLe+7mfpFpGOzUd58801t1zD8ek+Be/lHtLmDfhMCmt0+Izd7VVTsUIxiHuR0Hh6Ep8zFZbcQKuvcHSm6P+1yWfmOtvrzFLH5p5WCS4G+qRmkZixDsA3jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l0mh1Oo4zgDQLfIvOCrJEXwWCtCEX7hdhG+RYDV6SU=;
 b=myKmGQzgvGkGwVHqfkJF62NAHTBt4fWcN6UetFGESqPo5ToUWi1IfvCIrs7/qbAFw2kPKobIlx5sqYT4k/IH7xMWH+TCfGqzzv6dn7IUt/lbZoNWV1jcD5TUE0E9UIkx1AwSApoDJSfLtWzBU0kUy2fAdyF3t69YYDySQ+JPYG34MLe8oVLGpQ6euq49ZCrKQhRfHZJHgnkQqievT9Iutbuqi0mWgmJxsCApLlL4CCXkiX8iiJWsX7iFFYsKZ3HPE5e2Xim4vKhYPpdeEsiS30C12Ui/rs876X99bw6+TJOXoISJ3gs/07plRxzk4lkdaqNabl8xIWBnn5bEqSUfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 03:41:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 03:41:50 +0000
Message-ID: <1c3e0582-3177-4b05-b0e8-e292fa3f9ed9@intel.com>
Date: Tue, 12 Dec 2023 11:44:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <BN9PR11MB5276DD7A14E938973DDEBEC18C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276DD7A14E938973DDEBEC18C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN2PR11MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 483eadb8-69c0-474c-d7e1-08dbfac445ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbzUVbJ1cKfmQFAUUP0OQOENe30BdxGxGfk9UTC8sE/F+GQ6jN56nuC6wnx63WPjIMN12s0ZnlwHsBC/gAa0C6a5B195v6RZuV3Lx+MD0+eldNwXyDHP+4wOs59R0tt3c3XKxw5gOx7XqS33O4lO1NjB7neUfcAfL7lRbvjgg75DoBVC3qcIOjUImXNm9gTJdcRH/EQzplsPeDQMfy/gkjDt7nHhsfs86ihWpNzheEiZxkdcdesQrAMIqG29/sAwPoUqLRsc+diecGrs7j61TDjb/Mk1GOBpiSE3/XBGEADkHC4IqX5ulYZavXIzZL/YT7dZo6IzFvLRSEDThcdvtef3PzK6E0tWoAzkFBu+cAqcpxxKyQaJiEPPdQbteW1C7UpJo38uDUeyAiZBS0IWQ27D6DxJexv1F2iodpFKi1PBdcO2lsyO6CTsmd05QRrmWzu+yKWjGocxv7bGdhy8WOTG4FjjHNdOvCls2fydXaqW7KEHBi/YGT76ucnTaerrPSEfsgm1utDToYZOQIMoEtvkVU3Sgm6zEiYTuRLXOcyZisV8et6wfd9DoQcg7pq6dtm3OfnMTwqtTWN/DTvQ5PqGLmFD/nb3xg0xVN4sHlszUXxwuPWqmDmQ15eUCcynsRrEZnBojhiq9LZaEVot4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(38100700002)(66476007)(66556008)(54906003)(82960400001)(36756003)(31696002)(86362001)(66946007)(26005)(2616005)(6512007)(6506007)(53546011)(6486002)(2906002)(316002)(110136005)(6666004)(478600001)(8676002)(5660300002)(4326008)(8936002)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEphb3JGV1ZvM0tuK1ZKdDVLY2taeWRIKzBESFNwOXlTbHdsMXJjVkxUVTZx?=
 =?utf-8?B?QlZWMm1EVTlhQWFwaXFuSnByU3pTSXVySEdHcEVUZU9iN21CVjF4aEpUOUI2?=
 =?utf-8?B?bnlIQWllMWI2M00vd0J5eDNNUTcxRDVDNGorNGdQMGVmclgyYmpFMzJFdlZ4?=
 =?utf-8?B?eFV3R0Y3RDk3cGdyVGZsS0JYTDhHZ28wM1JhdDBYTVk1YjI4dkVWU2IyRE5m?=
 =?utf-8?B?QkdKYUdwYW5xVXVFNFNuVWwrTExxZHJ4dkpCZkE4TjJxRC96ZEZsaCtUbmpl?=
 =?utf-8?B?cG9wdW1GdzhLU1MxbTErNGZvRzRuNGF4ZGNvZ3dhUERndnhXa0szTkxyajVO?=
 =?utf-8?B?Y3R0a25nWFkxSlRjTlUxc2RPcDEwUU9PWXIzNU1jYVpLYmsrV1FyVXpWU2ow?=
 =?utf-8?B?aGkzYS9HL09jNkZtK2dvVTVmREZnRkRXdEhMaHFDaTFFelRvMG90UmFBVzht?=
 =?utf-8?B?U1pXQUI4eHFUY1B2ZkJFZVdyQUVBWEhMaEl5ZFhVdk1kWWlYeFhGNzZQeXk1?=
 =?utf-8?B?NVRwaUNZdVpnTzQ2c1FPMWFiQU9tZlZZaFQvcnMyU2IxMTdnSzI2Z3pFam9y?=
 =?utf-8?B?akxpVi9zOHRveUxtMDRBVG1NVVV6SEpkREIybEZsbktudDRnN2I0K1FWM0Ns?=
 =?utf-8?B?Ym5hN1NjcTU1WUo3VnZRbG9xQTYyRXYxS0gvcytSWXFmYjBUQjJrYm0rTzJH?=
 =?utf-8?B?QXpyalpldXByeU85UEhVejB2L0tHZnA0R1NYQmJ6YkU1TjRVWFQvRzAycTRj?=
 =?utf-8?B?NGxWNFRIYnBoQVpOSXF0K3pOSFFIR05IOG4raXdqbkwzMWVnb3Y1cFZNZjJV?=
 =?utf-8?B?V1l4VUthSXA1T3ZUaGNJU3k0TitZaDFIMERTMUtlZXI1Zmk4ZklpUEJxWnIr?=
 =?utf-8?B?bTBzTVFlR2c0dlc1OEZaaU11R2FJTHhiSklsQ2ZUakRua0MrQnQySWJqUklK?=
 =?utf-8?B?N20rN1NpZ1NuNWdseDlhRzE0dkVxajErUHRFS3ZVWHROWjk5SHRFVldYYjhn?=
 =?utf-8?B?bUNJemhpQ3BxN0E4eHNFOGhFZC9iQmpxd1g3aEF0RVQxcTZ4OFVRNnhTVHRH?=
 =?utf-8?B?ZEtWcHlQYmtSTDNVaURtMXZyaGlybHczT0Z3aGFFTFRyV1hub3B6S253NEVk?=
 =?utf-8?B?ck5xVHQ0R0E0R1dJM1dNaC9UTEZJTVoyOHJvYXBMbzlrR3YveEZtUlM1NFp6?=
 =?utf-8?B?ZFlzU2xoYjNseUwxV2U3b1lDT1hhV1FzWWRDanRXNlNjVTBTc0VMWVBCSmht?=
 =?utf-8?B?aXJKTHJSaVowV0wyK0lYaVhQNVRsdFNjRGVNWi9sTWtOVlpyK0ZkQzNVRms2?=
 =?utf-8?B?S0dRQkJGVzNzN1V6V1cwbHM4cnIrZFFPYVRzQU1hYkhWZW5NNU1kLzJwTyt6?=
 =?utf-8?B?aUpqVVd5dVFYejdsNFd4QmsvODBaaGtsWFRyUjVzamN2MVZsUmlMSTc5cXI3?=
 =?utf-8?B?SGN3T1Q3NTN5TzV3ZU13ay9NaWM2dHhkcWgzZDBXNE1wcHFhQlIzLzE1enZC?=
 =?utf-8?B?VnNTM2M4WHo2RkJhSmVqMVY4ZGtUUFZPSFlMVzJGejRIa3c0a3BhT3BCMUV2?=
 =?utf-8?B?QTF3Wm1KcXFiRGZIYmNkRndrMWtOUUNZSnNTdm5pZHVFK1A1SVV1bEpUbU9s?=
 =?utf-8?B?VzZJYWxEY0pHdjQzVnpuc2pscG45UGtBMTFhTzN4Z2pGdURmRzZpTVcyMFVM?=
 =?utf-8?B?ZG9QZW1pYm1JSVlDNDYvQWdjcXI2MEZZTWpkdGp4eHp6L0E2Z25ZL3FoQ1hp?=
 =?utf-8?B?ZEFqNXpBU0RsMC9HektWVE1LbmdXV1JFZWZwbHA0T1QrTzQ3OFAwSHM0YlBI?=
 =?utf-8?B?emlWQ3JoK3haelU5dGNOdUJNSTRQdStoNW52endkODkyUGw3R1VBbStPdHVw?=
 =?utf-8?B?bHd1SnN5USs1VDdodDV5WEE4ZFZzNVJiN3JSUFE4QURkc2VpbVZKY2w1M1NW?=
 =?utf-8?B?NVY5Yk5TekY0Q0dibTZQMC9kdnppOGdienpvTWhYMjZZQk9KZ3ZpU09oVTZn?=
 =?utf-8?B?UmJ6bkt0dEZWajlPTFBqcEI3c2NHcDBBdFFBbU9NL3YzWFNIQWFtc2ZYOGJp?=
 =?utf-8?B?enJxNnJtcGtjenkvUTNFdzNNUTcxbXRYcGo0a205Z2dqZGZpeTNleTVRQmNL?=
 =?utf-8?Q?0NXwrd4frk7+h2zKasMDp6OML?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483eadb8-69c0-474c-d7e1-08dbfac445ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:41:49.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4NvTbN/8uv8iZv5sZfUsRLEWwScCMjiNxQb0xeiH8W/IUngIxnefccI8SZGTKs5E9URVejrF6sS3Ha6pna3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com

On 2023/12/12 10:16, Tian, Kevin wrote:
>> From: Alex Williamson <alex.williamson@redhat.com>
>> Sent: Tuesday, December 12, 2023 2:04 AM
>>
>> On Sun, 26 Nov 2023 22:39:09 -0800
>> Yi Liu <yi.l.liu@intel.com> wrote:
>>
>>> This reports the PASID capability data to userspace via
>> VFIO_DEVICE_FEATURE,
>>> hence userspace could probe PASID capability by it. This is a bit different
>>> with other capabilities which are reported to userspace when the user
>> reads
>>> the device's PCI configuration space. There are two reasons for this.
>>>
>>>   - First, Qemu by default exposes all available PCI capabilities in vfio-pci
>>>     config space to the guest as read-only, so adding PASID capability in the
>>>     vfio-pci config space will make it exposed to the guest automatically while
>>>     an old Qemu doesn't really support it.
>>
>> Shouldn't we also be working on hiding the PASID capability in QEMU
>> ASAP?  This feature only allows QEMU to know PASID control is actually
>> available, not the guest.  Maybe we're hoping this is really only used
>> by VFs where there's no capability currently exposed to the guest?
> 
> We expect this to be used by both PF/VF. It doesn't make sense to have
> separate interfaces between them.
> 
> I'm not aware of that the PASID capability has been exported today. So
> yes we should fix QEMU asap. and also remove the line exposing it
> in vfio_pci_config.c.

Kernel side hides the PASID capability by setting its length as 0
in the below array. As a result, QEMU wont see it in the cap chain.
Do you mean we need to let QEMU always ignore it even if kernel side
does not hide it?

static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
	...
	[PCI_EXT_CAP_ID_PASID]  =       0,      /* not yet */
	...
};

So far, kernel is still hiding it.

> 
>>
>>>   - Second, PASID capability does not exit on VFs (instead shares the cap of
>>
>> s/exit/exist/
>>
>>>     the PF). Creating a virtual PASID capability in vfio-pci config space needs
>>>     to find a hole to place it, but doing so may require device specific
>>>     knowledge to avoid potential conflict with device specific registers like
>>>     hiden bits in VF config space. It's simpler by moving this burden to the
>>>     VMM instead of maintaining a quirk system in the kernel.
>>
>> This feels a bit like an incomplete solution though and we might
>> already posses device specific knowledge in the form of a variant
>> driver.  Should this feature structure include a flag + field that
>> could serve to generically indicate to the VMM a location for
>> implementing the PASID capability?  The default core implementation
>> might fill this only for PFs where clearly an emualted PASID capability
>> can overlap the physical capability.  Thanks,
>>
> 
> make sense

A location maybe not enough, may also need to know if any successive
cap, so that we can insert the capability into the cap chain.

-- 
Regards,
Yi Liu

