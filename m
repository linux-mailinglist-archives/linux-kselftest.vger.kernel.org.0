Return-Path: <linux-kselftest+bounces-945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5E800447
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 08:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FF1C20CD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD411716;
	Fri,  1 Dec 2023 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFWTQA2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A713171B;
	Thu, 30 Nov 2023 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701414213; x=1732950213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eH2d6tgwufHrUcIvshio6Ihv+0BnqRcgGPCG8mhbOVo=;
  b=SFWTQA2WaarGvIkKESIz8qmUGnoc0yqyE1uaef7GP13akqlMAXvPyk37
   O+Me1Un9pSKS8QtCpnDFEVOT48/JlOu9O7pn4OdXunZ/TM00g1jWBybep
   B1W640N4ZoVvfFBxpbaDWxQ2KAanYt9v4YKfrtkn5xMchvvjyMsY3U9Nu
   Q+uls7R+jm+K4pQ+Geq9wnUE1i3euS5XSBh3GF3ReO6/bfb2qzxP02fO9
   NDGbU1Zs4Biw5XYbY8bjaBYsxAATi6zV51VVTONUr54+CUVq+yvgjDOcC
   G5hBmLaEbntUeOHrvJN8rL8TE45HINObseOpGHcE6pZbjgJYYmG16D1ZT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="459950086"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="459950086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 23:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913479926"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913479926"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 23:03:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 23:03:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 23:03:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 23:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtTJB9Uq2FT2EmLnEcQWq2+AulbnpBEOkCNM35EYy8+PElw+X23zBx+P6Q4pI8fwka5zHdRlbNiF9NCAb8MSSp9UP6u4/Q8t1ad1YkkGJbZqxvyIhUsunA1PbQFFjzS+b8ymVJkeIyWtvgsTigVWf1zK3dp7+bKlQdWzmYuHP+H42LXziyyUT+mydvMtsPZl0sBKFOfTpC5p/asrG+Woi4ZweQ6Y/C2lTHaTFHwLaBumpswU/OcoPVF/z47cokZr7hqpoqR6r8hhzG4lVkpepR9+r0To6XIPfyRr9/Gp2aeUB58ZjD21aZKk17I3+a7kf2yjVgo4lwknUjsv+MNuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc8y9rpQF1NJ+7MeKeLjkaOz6/OyvgxyQQrA9jm+sB8=;
 b=B1hMQcN+R47krG3R0rBn4ni9wqNGgO7APcy2shZvArs9yf9anufEJ6DGZzX+f6sblzzDgOcSQRmE/iA3aRMtQNkODxFp8KU0vOZVihddCXcszdaQcmKrCbZxq+r6K9OxoOh6lAGD5Fezjkvx+a+S0pbaaaIDa9rIwBZ8zbjTSRhjQrgY0qpc8bvsPUbW1GpCvTkXMgCTh8ci52wbHBuULU/r0WwfMp6KeLQqy2YKvl39qLkV6rLSGYIiUUkDVPq536aYdztOSDVgy/RQOD2yI98Forq6pT3pRvGJUpQqGMKrjjSIsTE4joN/0cdgxScNbyA5z2brJ57DkLyVkzlNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7216.namprd11.prod.outlook.com (2603:10b6:8:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 07:02:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 07:02:53 +0000
Message-ID: <1a19c55b-763e-4d6b-9462-4d0ea86110e1@intel.com>
Date: Fri, 1 Dec 2023 15:05:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia> <20231129005715.GS436702@nvidia.com>
 <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
 <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
 <BN9PR11MB52761168800700D7131D601D8C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52761168800700D7131D601D8C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 241ca6d8-5041-4334-02f7-08dbf23b88ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRZhgF2nu5XD78uLMzK7gUld8p0NXMecxtDEo2C0WeXzax2h+k1JOe4sT0lpIlr9Bb892vp3XZUy5Z+K0M70YbJ4M89jzhnnH1z//BF1iRgqIfphuRUhRh3pbEBIO58thWuXk1M5D4br3jqTrCOazQBKCoB8qGVTPPzqR+6FZbWOQPA1UUZG4+S2XB9j22s2w5ZtWkd2woYzfJquWJ+IvHYCqbSgBGMKt0g+gOCrHu93QX79RVhbydbi1tLlO779apaJTWf1GMt5vKvLyvXsKPvq5xWbPSmLdA/MCLp21D3SJkGcHIerL14upvAnUx488Tv0gTSY9PmtwGApxj7nQhImSfWAY9GIPQkwwbjUr6/uq4i3f90d3cyAYJUv1LLWGnpQ3Fs2uNBZCfoVNyMYWr1cesu4rUvs6z2wJSNoycb1s/nLsZ9XJvBbfmbmMh67YYBBZALSukSpA33/rLnHqBzQimad5IIks+WyggjzBKqMKGRP0lKdba1ueG3Hwe/mULSs7V5N3uSUsssMnc5ZD3AYNwPEzk+bufyVzj+BWzSGRSZT51CVXJqi6Ye+MNUkKB08PO8Nf2s9wprtlBOVyEyN0aD1gyH0wc3USFggewuHEacmch4+23GhEIPEtCalOpXSiEQRoERV4SKMaNesAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82960400001)(38100700002)(31686004)(83380400001)(8676002)(110136005)(54906003)(31696002)(8936002)(86362001)(4326008)(2906002)(5660300002)(66946007)(66556008)(7416002)(66476007)(6486002)(478600001)(316002)(36756003)(6506007)(41300700001)(6666004)(6512007)(53546011)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tXRndwRDBqL0loVTJzVzhpV2UzbzR6dTd2c2hJOHdLUlRsdnZBLzVhblNK?=
 =?utf-8?B?bUJoMW0xdm5xZmlLbFQvRC93c2pjdTNLOGhpbXJqNW9qbVFTbjk1RmFSTjI5?=
 =?utf-8?B?UWVjakN0a1BsTGZWZlBwMkhRSUt0Qm92TDg5UUw2WDBzVjltS0FGRHRINmNT?=
 =?utf-8?B?NElnS2JHaVlJYzE1TXF3dE1ZVytmUjRkRnFpK25tTWQ0WEptVjRKcThMUm9l?=
 =?utf-8?B?ZEZZVHdXME44RW9wMFVOVVFDZjg4angrWTEyVTFrVkEzMm14b1pNV3lnOUxH?=
 =?utf-8?B?VUtUU2RzRHRTQjA1WVdoRGJ2cW5yYUVwc1pVdnFORUUrd2Z0M05maXlHMU4v?=
 =?utf-8?B?dG1LdGdSNHlqOXBvMVJYMm1HZXVhSmsraVd5Rmg5VkZNaE1wTUd0ckZxTTlx?=
 =?utf-8?B?RnJnSjc1Sjl5ejVoblBObXZGRG5UY3U0UURwSXhNLy9JNisrRUEycm1GVHZt?=
 =?utf-8?B?MERpVnpNbHJZUzBUQnMvRGZYcTdRY2dQUGNRbWI1Tmx4Q0R1OFdYWkIrQ3BD?=
 =?utf-8?B?ZXpZd2RBR0ExWGtva1IzTXppNk5pVFJLelJHL0NvaStKNHIrTGM0ckpqbFhv?=
 =?utf-8?B?bFJYbDZldnB6S2pCVU92N256ZndzcjVsVzExaVc3dVUrdVdxK3dUT3QxU2FF?=
 =?utf-8?B?ZTBqY0J4cXNJQzR5a01VdmNhcFNrcEFHVE1OVndlNU9aeXB6M2pBNEU2NlAy?=
 =?utf-8?B?aVJacmJnajk3TkluemZQSVJsekFBTGxJV1hYTERSYUxPSjR0a01DRGZwNk1J?=
 =?utf-8?B?eUluZ3RQcGsrRVVITUpnYTlHR3VPVG5RVHYvUTVZbmhaOU44NDV4Y1VkdnQy?=
 =?utf-8?B?cGdqTDRqVXhZKzZzOGZ3Y2tQcndiV0lwS3VSNDFtTjlJZ1ROVjFNTXlUKzNn?=
 =?utf-8?B?WWFSeVhMd2ZlWG1VSHFsY3ZydXFwYXlFWS9hMTFBUmQ1NGpITm1FZEJRVVZo?=
 =?utf-8?B?bTB1MHVGZGQ0MloyMVExQzA4OWV6TFh4TzRpWnIyMWxQMEZlQWJJMVQ5M1Zk?=
 =?utf-8?B?T1R1V3gxSFl1RXR4YmdFekExNlNIRFR4M3hPbFp1VWtvR3Z6dlRsRUI4OFJK?=
 =?utf-8?B?QVo0ZFpvWVFicFZJSFAxVXBodTlyK2VvekN5Ylo2VnhadGNlcTM3ZGhpU1lI?=
 =?utf-8?B?V0UyRVBWLzFjSElGNEo2aVlDQVZlbzdxM2k4T1ZZNFlFcGpQQ0lTUWVibHhj?=
 =?utf-8?B?dmFYeVFFLzhkVm84VytmQkpPRmNBUXRvajZYY0NTaFBTUGUzZU01SlpGcm9i?=
 =?utf-8?B?aFk0L2FpZGU4NkhENGY1aC9zNTlXVVA4akxRMHZnRlVPSWd5SFpLY2d6aEJR?=
 =?utf-8?B?Nld3RUNiOVpSWEVoUnRIUE0rNFhFRU1OMzZBeWMrME9jeGU0L0l6SUtDZUFP?=
 =?utf-8?B?VnlKR2F3RVZURUVMYnl5YldTM2kwUVNxRG1nTVRBWUx6K2VYU3lEcVV6Qklz?=
 =?utf-8?B?SzFaUWF6WEJEVWpkY2Y0WlBKSllWNVZCUVFFRllJVjBiRWFtRE15cklRNU5x?=
 =?utf-8?B?dU1GYzZrbEc2Tnp4Q3RGT3RweUNxWWZBQnFBTGF0WndsVmdjT3E2Z3VpR2I5?=
 =?utf-8?B?Q0l0U3pQaU4wUmVtYS8vMnk5QnorTGJmUGJuclEvaWt0ODZLdk5GUDFDc1B6?=
 =?utf-8?B?dHFnVitieE1EWkJOQ2p5SllHc1FzaWFuanNHcjVma1ZEQVgya1Z5d1R4dTdM?=
 =?utf-8?B?M3h5dStGTGw0T3BaZktnSHV3WFJZV0NhcmZBV0ZJSXlPUkZSMDNTblJxa0hk?=
 =?utf-8?B?Ym1XTTZ2UjY5NzRKbkxPSHUrSXdQUlVjV3MwWERzc0xIRUV2TFhhTlFWUTBS?=
 =?utf-8?B?YkFkTlhaZG9yRHp6Nmh2MlpDUk11N2t4eGN0N2N5YW8zdGdsbTlHUUplWDBD?=
 =?utf-8?B?czN3Zk5LcjZ5UWNMekI2REZsZUI2blV4WmlucCtncHdHM0RzaE5sVnozZG9K?=
 =?utf-8?B?N2JGMmNGUWsveDZFQUdYd1BDbGU4QzlwMEJFZ0NISFlaSmxCZ1djeWlMMkc5?=
 =?utf-8?B?amJpV3hpT090NWNYZGdjWFFGcW1VTzB4bkdmVk0rQWJWYS9aZVlSRllETm9W?=
 =?utf-8?B?b09hNlhOWU1la1JybjRCbFUrUEVQM2tZY3ZBRmRLcC92R0kzbGJORUZpMmJx?=
 =?utf-8?Q?YgTBm79tu51UBwI3Er/FWTFIV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 241ca6d8-5041-4334-02f7-08dbf23b88ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:02:52.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wt3fALwVy2HvcUzTV70CAFMGotGHxNq4Gvq9fH5g+6cpsMZ0DkbeHxnLJ8O36+pi0YEQ2+dftrrZZFGSotOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7216
X-OriginatorOrg: intel.com

On 2023/12/1 13:19, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Friday, December 1, 2023 12:50 PM
>>
>> On Fri, Dec 01, 2023 at 11:51:26AM +0800, Yi Liu wrote:
>>> On 2023/11/29 08:57, Jason Gunthorpe wrote:
>>>> On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
>>>>>>> I also thought about making this out_driver_error_code per HW.
>>>>>>> Yet, an error can be either per array or per entry/quest. The
>>>>>>> array-related error should be reported in the array structure
>>>>>>> that is a core uAPI, v.s. the per-HW entry structure. Though
>>>>>>> we could still report an array error in the entry structure
>>>>>>> at the first entry (or indexed by "array->entry_num")?
>>>>>>>
>>>>>>
>>>>>> why would there be an array error? array is just a software
>>>>>> entity containing actual HW invalidation cmds. If there is
>>>>>> any error with the array itself it should be reported via
>>>>>> ioctl errno.
>>>>>
>>>>> User array reading is a software operation, but kernel array
>>>>> reading is a hardware operation that can raise an error when
>>>>> the memory location to the array is incorrect or so.
>>>>
>>>> Well, we shouldn't get into a situation like that.. By the time the HW
>>>> got the address it should be valid.
>>>>
>>>>> With that being said, I think errno (-EIO) could do the job,
>>>>> as you suggested too.
>>>>
>>>> Do we have any idea what HW failures can be generated by the
>> commands
>>>> this will execture? IIRC I don't remember seeing any smmu specific
>>>> codes related to invalid invalidation? Everything is a valid input?
>>>>
>>>> Can vt-d fail single commands? What about AMD?
>>>
>>> Intel VT-d side, after each invalidation request, there is a wait
>>> descriptor which either provide an interrupt or an address for the
>>> hw to notify software the request before the wait descriptor has been
>>> completed. While, if there is error happened on the invalidation request,
>>> a flag (IQE, ICE, ITE) would be set in the Fault Status Register, and some
>>> detailed information would be recorded in the Invalidation Queue Error
>>> Record Register. So an invalidation request may be failed with some error
>>> reported. If no error, will return completion via the wait descriptor. Is
>>> this what you mean by "fail a single command"?
>>
>> I see the current VT-d series marking those as "REVISIT". How
>> will it report an error to the user space from those register?
>>
>> Are they global status registers so that it might be difficult
>> to direct the error to the nested domain for an event fd?
>>
> 
> They are global registers but invalidation queue is also the global
> resource. intel-iommu driver polls the status register after queueing
> new invalidation descriptors. The submission is serialized.
> 
> If the error is related to a descriptor itself (e.g. format issue) then
> the head register points to the problematic descriptor so software
> can direct it to the related domain.
> 
> If the error is related to device tlb invalidation (e.g. timeout) there
> is no way to associate the error with a specific descriptor by current
> spec. But intel-iommu driver batches descriptors per domain so
> we can still direct the error to the nested domain.
> 
> But I don't see the need of doing it via eventfd.
> 
> The poll semantics in intel-iommu driver is essentially a sync model.
> vt-d spec does allow software to optionally enable notification upon
> those errors but it's not used so far.
> 
> With that I still prefer to having driver-specific error code defined
> in the entry. If ARM is an event-driven model then we can define
> that field at least in vtd specific data structure.
> 
> btw given vtd doesn't use native format in uAPI it doesn't make
> sense to forward descriptor formatting errors back to userspace.
> Those, if happen, are driver's own problem. intel-iommu driver
> should verify the uAPI structure and return -EINVAL or proper
> errno to userspace purely in software.
> 
> With that Yi please just define error codes for device tlb related
> errors for vtd.

hmmm, this sounds like customized error code. is it? So far, VT-d
spec has two errors (ICE and ITE). ITE is valuable to let userspace
know. For ICE, looks like no much value. Intel iommu driver should
be responsible to submit a valid device-tlb invalidation to device.
is it?

-- 
Regards,
Yi Liu

