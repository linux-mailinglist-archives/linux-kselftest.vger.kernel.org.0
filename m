Return-Path: <linux-kselftest+bounces-1501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202380C2AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 09:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3B228098E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066161F618;
	Mon, 11 Dec 2023 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsmxpWoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064A100;
	Mon, 11 Dec 2023 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702281944; x=1733817944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zLKpfEshP81Zk2arI9WmVZOoX9JPFPjvSk5cw9cMK9E=;
  b=VsmxpWoEYxBsMGtf3hlppe5iLt98+tiXSPKtq5dJIc4Mf3rCDoxGlFJm
   XOZ9q1ASgF7+rGeQ56OWvitn0WAnmGU5rULedOslGm17zf5TaqGCDG8os
   3GXJgqT8LKVy5mWue495PVlkA4FTg+OjsHv9FipeRj3XAS84W52Y1Mn9R
   hFixYY7GtL39L/ZV91HsnRQTsRccTqXtRM1A66cnyGQ6GwsEYSSAty5iZ
   3w6SIzhR5K80BkayLK56qbcajoyotEOILLFCrQ04j27tkNchame6Dsj7E
   UPvauv//o2lZKeWievZ+BoOwHEORYtPqqQwy3eWgHmwyG58Mkp+sqILqF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1738012"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1738012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916744452"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="916744452"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 00:05:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 00:05:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 00:05:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 00:05:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 00:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3IipY1w+Fp3RwWOYyV8yBbxSFiFWbqy+6y3g7ZkMN4ZZAnDPY4kkwxWUc8gz0mxl+ZM240OdO0Zm59r8G8AOn/ZFWQuAxN502GkZBfWP2RZ1d4k4sENWH2XY5d9Zz3/aojt7X8crWL/HkAdr+qaFQbykVEAqgH+ZNMaPj9rLnRLNc1eEsIhnvV8AYF0r4hS9vBAYSC/MkKbLaImw0ifA/S4MUx0wTfkJMfyzAZ32/RUYM/Pmsl7JTwsiJmfjKvydllnAFnXyJrgp6ITcHJQc/kYDk/y2Lo8KoVENV0J2TB2S19N8dzmOhfhESqrWThlp1J0tVACsc11PrAeR0ywlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1J6RsllcLPTEgixrOQdSrtNjWcH7iIJ9Qzk8+VJpQA=;
 b=g2TLpXaiiJ2n1VOLjCY2wf+63EqSdg9WC7oIktXC2BhX+SzMGkTpMZus3NcQk74k7V6Pxsa6mJcxo4/1nKKDJgmGbCP1OnN9MFFVpIdw1Z/HwssJWwcLewNUJ07wjn+joQZygTWAGBEnqQeCIhgeUwg5kylaACvw54cc2TnZBj+vkvafJ9rprydBKU2tJAa6n4BDTdtb/WdR8h0/+2IqQJGDIXcIwbdEoQAb7sTIjhK9tzJy+3MB8GO5356CWHbRNsBcMO6ybwpUD/AacK7c7AYO8Ay0yB9fzcZ0VQU7Hya+X42/Oh9EOY7vNDWiTCyOwP65/e6EhNZU2qB5G27XUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 08:05:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 08:05:39 +0000
Message-ID: <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
Date: Mon, 11 Dec 2023 16:08:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
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
	<yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 1993d188-5b0a-46d9-c3e6-08dbfa1ff615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSR+U5ewM0ndpBsN4jQCtYK/SPx4SnuMnoRISO0JId0i/TaY3piGSCIiT2NHBguaxnRo8/VAP6bzh0uBfWwgUuFHk5z5tKrF2mZUH8C+GcHTSx6cj2JiiaxwFxj02QH6tsFs6ZYKmfxbyAWGyB2qNzHubQedAqnI3cHJH/pG4ZPiCDKnGjvo0WHjlGb6MhJvNiRwLqqJYmAnqiXdO5n+AEerWkDD6QQvZ+9nsfxMizYjW6bpG9pI831ILgMG1PBk1C9ZYtjhRH5S3bgn1ySGK3OQiFPq7VXRe1MEbxb83NsMBXJQt3ScjT2ZnP4fJ0s/Mx4q9EOMdww8wFq21M8jwi21nJ7L55lOvyOspugVlmSgO545ADxyZm3eyTtsN6AXPiUwHpf3VWU4NcfEZlC4EGpoRNLhQMBZcQql2xWdVaCjKO2GFBjk/mx32PTiFnu4u65qpSYIzv/bft9Unn7qIdfdGC5IBla+ovbiqniP5Vfvl1XV5byNZAFQtqT7iwdvpMiAcU96ejJA1aM5pnuG/jhQnidgEXaSE00Q787EptrjUUOFPZ2IeJJ1uKgK6QTgACFRtMs2d1yeYRMjFK/2WNvTgKdrQ9mhzImqz36chL0sYJ3lrNQgNlMnZUcwp2N/YZZAUDLrKYVA0IiGp/kJ3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6512007)(6486002)(2616005)(26005)(53546011)(478600001)(6506007)(6666004)(7416002)(5660300002)(41300700001)(2906002)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(110136005)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpOWk43cjVpa0UxV25qQndGdGphNHlVN3R6RUxCNkJUTmxDcHplelAzR0xF?=
 =?utf-8?B?b2Q2Q0M3a291dmg0YzVQT0l0N2dUQ0VMU1ZJSnJ6cHR1dmo5cDJVQXBwVHVQ?=
 =?utf-8?B?cTJOZUZ1cjVidG1oeFZZTjhzbTJwaXR5aE1ySkw2MnBBb1JDODVucjExN0Ry?=
 =?utf-8?B?Zzk1WlFyR1FXQXhBaHdFdFk5R29pMU9GWncxT2E4Z21SUG0xRTlSWTJNMlhG?=
 =?utf-8?B?SmhvZU9WSzFzK2FtVHZCcWo4Q1lUMmg2d1RJYjhkTytDb2VBaXozdzZBREdy?=
 =?utf-8?B?d0haOVFSNU5VLzlod3VTQXV0bnBqbkNRQVdkV2tOK2Q5RE00TENuMDJCbmg5?=
 =?utf-8?B?bTNKRHQ0ZVJZVm5wQVd5Vm9DVzhuY1hDa0wvaU5IS1JvR1NCeWJhLzlOZG5q?=
 =?utf-8?B?bGxnMzBFb21veW45cVpjRExmQ2xSMDFQZFJobUFqaHVWNGM5WWtHSm1HTGRi?=
 =?utf-8?B?T01WQzM5WTRtRWY4NnhUS3YxR2NRZDBjQmN2aGVaRkoraUJrM2t6ZmoyTHFl?=
 =?utf-8?B?SHlsOUJsTkx0VVBLSW9mSkV0UFZSbFZkOC9lQkdsanJuK0RENzhyN0ZpMldG?=
 =?utf-8?B?S0g4MndZVDI0K3FLakVBQzRucGo5Vm5MMDUzZCt2ZzJaVlBXaEZLenM3QXVH?=
 =?utf-8?B?cUtwN3Y1NEZhNU9lWlZGelZCWDBNRWhVSHUwVEp0WkV0YXE4czFQUi92MW5L?=
 =?utf-8?B?SExPcXh6MHJPdEZvRm1CWXBvb0hiSUZmWDZZT3NaSjJQb0xjY3NyNSs2SzBs?=
 =?utf-8?B?bStUbEFUbDVaM0hWTFlheENYUmZESHp4OGk4WTlWdk8vWFp1TGdZZHB4b3pU?=
 =?utf-8?B?MHNORjVJb3ZZbWlSOWgwSEo3ZDU4T3l5SnVENUNocnJvdHE5QVJvdHZpWVBq?=
 =?utf-8?B?eHFuY3FReVlxbnRMcWI2eXRuakh3MHdFaWdXeXFTdDFPUHVGbCtLSjBZbWxT?=
 =?utf-8?B?ZWhHNEpUbW9MZUFIdmgvWURJTVd1TC8xcmJrSWkrazVncTBUekM2TTMvbFRu?=
 =?utf-8?B?cjZLRjdIUkVyYk5hK2U5Y1YzYy9WbDFOTEFBUUdmZm02NHZsNStiUk5SY1Ju?=
 =?utf-8?B?YzV5Y2cxWHZOMmxHbXRNa01yQmJQc2F1T084Ui9xOHdHNTZUL0pDYTg4K2My?=
 =?utf-8?B?K2pyL3hQdzdtZ2VjSFFBZmNPbFBnYnFHTG9lcTZKenAzbTJtcWlkRXoreFM5?=
 =?utf-8?B?cHVFOFJ3ck45bjdiMHFOSStDc0lwdUdPbWk4dzVQVzRmTEswQ1grYmRPZVp2?=
 =?utf-8?B?M1JuWkFsdVExUHplR0V3d1JRUzRaRGxSVnVDRFY0T0xEM2FpdE52UFBTNTBn?=
 =?utf-8?B?UVFsVjJvZFAvM3VCZTI0QmoyTXROM01kNnJHYXVvbXJsOXliMzBJWXVTbytw?=
 =?utf-8?B?LzFGbzVCV3htUmxMNHJIVk1aQmI5MGtYanF5UE0wUnlGRWxPK24yOUQ5ZUR2?=
 =?utf-8?B?ZjBvRzhxRW1JbmN6YmhKZ0NZbWdLc2VUcFRvWFhabGRuTHRZYUh0VHBSV0Fs?=
 =?utf-8?B?ekc2TFp6VzRReUNrd3VRNG5VMGNvUHdXbERJWVRjLzRsRU1KcituNzVYYmlj?=
 =?utf-8?B?TzdTRklqcTNXK0tLTi9ZdmdYZlFaK3Rhbnd5ZDR3S1hjT2dKTUZZL3BaaGwv?=
 =?utf-8?B?eFBreXJ5ajJSODZNYnY0dEJVbUJPNUtVaStsVG12KzBXdU1hdVdPOUh2Nnpa?=
 =?utf-8?B?ZlVtcEZhR0JDRzlsaURIekc4dTg5elBxTlRLYlNlbXFob0IxTDFvR1BNdUcz?=
 =?utf-8?B?S1p1SGY3WnA2dFV5d3FUN0tqMW9ZM2VHdVN1aEltR3hLS3dhOTA0ZUpzQi91?=
 =?utf-8?B?ZTlGSmZGMnNVckoxSzFTTmx6QnlSV2JCSHhWKzFUM1cwOE5mY2JUY3RGV2dO?=
 =?utf-8?B?bzhtVUVQSTFwTUtXREZzMHJpeVBoSFZSWkZjcjJhMyt1Q29aVWl3ZnR1RnY2?=
 =?utf-8?B?b0J2RjlTdllONWM1elJWMFk4UnRGbDRKZWo4QnJjZ0VvamdtRi9JOXV3d2xC?=
 =?utf-8?B?RDJiSnRyRjRGb3pHM3Zha3Q1N3B4RS9kR2ZBQVpFQTdpMXpKWlZNRmdLWGgx?=
 =?utf-8?B?Vi9uSnd2NWQ1VGV0Q01XVVpUcWpRK3R2cmVaQVU3NGlSOEhMV242emhqY05w?=
 =?utf-8?Q?0ZW1MoEjOkDCCbiLszj7tjjJA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993d188-5b0a-46d9-c3e6-08dbfa1ff615
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 08:05:38.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUXijNr7TdyX/zVkiGfBD54T2C1oPGmD4/eISDQI0FJKjF8NGFMzOrohHet3md6PQlkpxYBOjsxVT7h2UkD1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

On 2023/12/7 16:47, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 27, 2023 2:39 PM
>>
>> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
>> +				       struct vfio_device_feature_pasid __user
>> *arg,
>> +				       size_t argsz)
>> +{
>> +	struct vfio_pci_core_device *vdev =
>> +		container_of(device, struct vfio_pci_core_device, vdev);
>> +	struct vfio_device_feature_pasid pasid = { 0 };
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 capabilities = 0;
>> +	int ret;
>> +
>> +	/* We do not support SET of the PASID capability */
> 
> this line alone is meaningless. Please explain the reason e.g. due to
> no PASID capability per VF...

sure. I think the major reason is we don't allow userspace to change the
PASID configuration. is it?

> 
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(pasid));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	/*
>> +	 * Needs go to PF if the device is VF as VF shares its PF's
>> +	 * PASID Capability.
>> +	 */
> 
> /* VF shares the PASID capability of its PF */

got it.

>> +	if (pdev->is_virtfn)
>> +		pdev = pci_physfn(pdev);
>> +
>> +	if (!pdev->pasid_enabled)
>> +		goto out;
>> +
>> +#ifdef CONFIG_PCI_PASID
>> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
>> +			      &capabilities);
>> +#endif
> 
> #ifdef is unnecessary. If CONFIG_PCI_PASID is false pdev->pasid_enabled
> won't be set anyway.

it's sad that the pdev->pasid_cap is defined under #if CONFIG_PCI_PASID.
Perhaps we can have a wrapper for it.

> and it should read from PCI_PASID_CTRL which indicates whether a
> capability is actually enabled.

yes, for the EXEC and PRIV capability, needs to check if it's enabled or
not before reporting.

> 
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the
>> device.
>> + * Zero width means no support for PASID.
> 
> also mention the encoding of this field according to PCIe spec.

yes.

> or turn it to a plain number field.

It is not exact the same as the spec since bit0 is reserved. But
here bit0 is used as well.

>> + */
>> +struct vfio_device_feature_pasid {
>> +	__u16 capabilities;
>> +#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
>> +#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
>> +	__u8 width;
>> +	__u8 __reserved;
>> +};
>> +#define VFIO_DEVICE_FEATURE_PASID 11
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>
>>   /**
>> --
>> 2.34.1
> 

-- 
Regards,
Yi Liu

