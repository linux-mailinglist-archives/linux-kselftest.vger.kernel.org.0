Return-Path: <linux-kselftest+bounces-695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467987FB1B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 06:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99D2B211AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935BA10A35;
	Tue, 28 Nov 2023 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkfYAoPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E75C4;
	Mon, 27 Nov 2023 21:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701151174; x=1732687174;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gc+FhaEjS+zz9trJ2NlyUbH/KAdl90tGS5OQ30sqU6I=;
  b=dkfYAoPUZJjhlASMRunLwPC4nFZzFVdw64B+eHg5Lnkl/WafMRjzi0Sa
   z9E0VREiluKNZ8+GvjWjL9ltwPTj2bugsZPhe5s2GQsyMyhZ4N0eHO8V7
   CwmdJfG4rD22Gpm+4RlAHfnTPYHT+gwAWinrTr6F3Clj58GuWU2GzAUhn
   +CzZnp+F+QwWoIZ1zvdjXUXDmW/AMgne8ziI9g6FgyeeMQq2LXJBVR3Sf
   4UlRNraS7sliIHbigYD+TT/wPpLe5YOjU+jDWm7RuTFW5ugde21X4zt9o
   PJEPTGkG83z4ZDa+GEqsEuxUQ0EUjvfDu2t2YL+SWATYtBSVVBXYrTO6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="11554125"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="11554125"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="10014287"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 21:59:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 21:59:32 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 21:59:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 21:59:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 21:59:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlIqDZvwu94zAuj8RGCGdqMbaYbctOkljpAAqabI5V3ZdsG5Ta/8mpPL97yi8+wwjktT06Xk9Ci2LKHLiNC2qyorF4I2WVBZ/NUypLSMHymxnrprh+Sg0hIsW3W4nMbtLD7Ql1xuYi5HOEoJ4o98VTGiI1RXu3LL0VCs/HNJ/our791prPSGGRGtlgTxHLVOQV3KwD2J2GnafLzniNvJNmdv/ouosSFKiOdJZOMep/8FzdZugNfxB4Nx9HymM9ofm/NeGA+ieP4SDmZEo7A5GLuwA3AT3MBVRMLBGWT5Uj7AocOuvpvU6WsYX/YkA4xms2CBjRrbxZ5kOVSeZfSb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rIEoNWuJM8UW51ZyraRSI/bR+UoC+XIkGXP5kVJwr0=;
 b=JKf8Rc8+8p23pFCSiMO8HqHm+DdpI8vgZV6vt3v83CrX7dZP2VGzbxrvxTi7ZSOTGfCSKdWnkalxr7qHu9uP+F+hIO5DdIr/NYYPFy+ntm9T2Xu5wJPSiS9ot2cOTDFVXFZoO4oVtCWzHQjrk/bV5M0U569S3/GxmWvaL0P2ci+dbOPbF71/8EeSlIATluS7k80XJGZGKvedhTlkhbJ5Fq+KGryF++ohlV4MloZANBqMSkr6ITkVcDDtl5505thBMRHFXxRB0PXj4gbZuQR/MmBTp5epkxS/4M99YDD9HXq1P36zr1gAaBDi9beUkcS3w487Fbl0K+9IY+9EXsgcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 05:59:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:59:29 +0000
Message-ID: <51640965-4196-4da1-88b4-cb0e406931f3@intel.com>
Date: Tue, 28 Nov 2023 14:01:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: dd76264f-9e8a-43ed-27d0-08dbefd72ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0jvWPsvnq/8UDtWu/DZElxvwhinUECzDOU6Z+z8CSwSDUuczobbVuqUL96rkN7g407RBpBxslMaY/kclyVEkv279HwDT+tULe0hnu1C/uwCFbDcYGN7Wfki7eoIWfkmGKLka5VjqBZWFtZsXl3cdutGyY6CZ4jOe5Wf2OD1SejOSmJCNp0w5g2OnrtCxeQXRhqvHjmhs4RjIO9YaxzYZctFIHd3+JKgG/kBQV5I5ZzlUAnWyAB+H0esuHlW+WvWJwrN9BC5+DD9iATgwnJhPNOmkjh0VVzvxqwVMYOyiKx+lJJnb/mHFP3KY80ZRlx0XufCKZVImxcr1hCD+L7azo+2lymuqjWgFMenY8C8sUCljiGVjgVNN+lc40cZkV+jhQ6fX765QPLDQhWYE86Rl8ph6jlaeF/iYr5+eUPJI2o7pMzcMZnQIasYHVDZXeUBF/4LmP7L/kedMa0IhUxcu6Oqzin6TeqR6VWCtjpm19ggkN8rioVwwh3xz5IC2I/V8BzWGAp5rWF7iw5Dl6IyffyCBvJwLm03uWv1e9nLVqsT1Z79jO8Y66rWCaSh8hzxi+J6dPHIK9Za3NDImliQjz/hIm4/J3IZTE4PlgiEy+V0NdLZxnG48AIdWQNdhl1RL9sSJ3D41QXQlPFPEb3RfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(36756003)(83380400001)(31696002)(86362001)(38100700002)(66476007)(66556008)(110136005)(54906003)(6636002)(66946007)(6486002)(316002)(478600001)(5660300002)(41300700001)(4326008)(8676002)(8936002)(2906002)(31686004)(7416002)(26005)(2616005)(6506007)(6666004)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNISWQwSXZHWjNtSy9KNGhJTzhvRGRoK0lUU04rVTdyc0pCdXp6ajBVb3ZH?=
 =?utf-8?B?SXM3VGhrZ1JpMjJNVHJaSERNeGRobW5qNk5MZ2drT3E0SDZxRlozTUFZRXhk?=
 =?utf-8?B?RlNUQkRkbFBUamxMVk42ckQzZ3RaanhJUG1NYzZUeXdEazdvOU1EaW93Y1dZ?=
 =?utf-8?B?UjA1ZkRoWmtyT09UTVoyT0VzKythZmJjd044b1NTOEcwN0tRYWdCSnNXNXll?=
 =?utf-8?B?S21yUStSdXdyR0ZEdlp1K244eXhnWHJZcC8rVVBVOTM1ZnJuTGt2ZWdZNVNJ?=
 =?utf-8?B?V294MmZ4TWYxZzJZWTkwcFd4ck9uc2JIMDZBNE1Lb1dGWXNMTjkySEQwRjVI?=
 =?utf-8?B?b0NrbTcyb3FMMUZadFR4SGJwWlBsTG43TlZKWEpjSnJmT1N1TUJsMHFuSkV2?=
 =?utf-8?B?TmJDQzlQU1BtYmcvYmVCb3Jad1h4QW9TQi8yN3I0UzMzSUtxWkZCTzdNRWFF?=
 =?utf-8?B?Zk9QcHZDRU02MTY5djh1WUJPMFoxWUQ5Mkp6WWZXTGJmUEpLcmZGMDZMNjNR?=
 =?utf-8?B?dmZVendYcFZsMFhaclMxRTVSQUY5RlB6MzdQc3NQV1p2K3YxZm04SHJsOHVx?=
 =?utf-8?B?Tm80R1A0ZVNEZTRWSTU3NzJTbWx1S2RzTzhmMEJOMnZ2TkhYSVpERjhuK0xT?=
 =?utf-8?B?a0R1NWtKdTRWeEdyVmI3QlR4THJEa3lrY2JoOGVvQ1hQa2tiVVZuSkF0RDZy?=
 =?utf-8?B?NnhDWUhuY0hYMjhSVGdaZ295dGI4MXZ0SWQ4N1owbDJNc3pFL2NMbEN4R3lZ?=
 =?utf-8?B?cGlyU3J1WjlOVXdPVmt0bnQyTlpNQm1iQ1JNZUJFVW1wMCtEZjVEMkJObDRt?=
 =?utf-8?B?SXhEaFB3WEdrdkpOQ3RlT0RoaTk4a3NkMzVLamZ3aXlPZXpEZUMvRGcvMzE1?=
 =?utf-8?B?aENiNXBUZyttSkJsTVhBc25RWWQ0c25CRFBiN2Y3WnhHZnJHdW9PU0NBdk1m?=
 =?utf-8?B?Y0l5TGthYThWcUVFYVJwdFhMUXJReVAzZTBVdTl4b3BCVmFhbGJya2RJNDh3?=
 =?utf-8?B?RCtRY2Qxb2xuY2Zsd250eE5CVmhSaGVWRlZ3b0ViOFI3Tm1kcjBBRkZPL1lI?=
 =?utf-8?B?TmV5aTIzZ3Z6WUVhQll2Sk1KYmtCTlVBVktack1LSE5lZWliY3o5d1JZRmov?=
 =?utf-8?B?NEhpajBSOVhKa3pJazRab3l6N3hlbVFhajRESVROQ1loeGd0ZXhrTXZvNlZv?=
 =?utf-8?B?Z09QMjRaNGVUSXl2NTg5c1FqQ3V4SWR0T1Fob0V2WG1SZk1JOEhuT2xWd3dv?=
 =?utf-8?B?YTlzQjFKdlJ0TFE1M3U4UE1CRkNmd3dzUlJMMGFpSHhCUXFTbEZ6SkROMU9l?=
 =?utf-8?B?SWRDbnNwbDhndGJKY0owcW1ybndaVlY3Vk1pbzRwNlVzakowWTRia1Y4Znho?=
 =?utf-8?B?THBibDRpR29PSE9NV1lRSE9mNFVGNFk5Nk1ZTkdFUm1GRTBQdTRvaGNXRFRX?=
 =?utf-8?B?WDBOem11Z3ptYUVHVjhXUDJMei9nQTZ4bUZyaXB1ZEN2UTdqUXcvZFJLNW5l?=
 =?utf-8?B?NlhqMGROK2wvZ29vYVhSR2YySDVrdXZuSkVFcEV5eFZHemp6Z2RQV2c3bFV1?=
 =?utf-8?B?V21ETzhhdnVRVi9aZTEyT3J6VFRjcXJtRGw0Q2NQdEVRMDRzbHJDTEtMcnVs?=
 =?utf-8?B?NWJYMm9USUxYQ1h2aklmSnVjK3p2SmpTejVFVm5KN0d4OTVGcEVnRFRTK2hZ?=
 =?utf-8?B?VzRVQ0g2VWgrNjRSTTlsV0EwYU0zQURNTVZtTzA2czVNTnVwNlo2eUIxZ1F3?=
 =?utf-8?B?dGkwODZ1VFphSzFCRENieWU3VGxUVVJaK0xiVXpMQ1k0d3ZrYkNjL0lrMlRl?=
 =?utf-8?B?NDRlbkNyblNaOTMxR0lDZjZwWTNra2VCL3VRYlpRaTNZU1dINXRkM05hZlE4?=
 =?utf-8?B?YmxsUUh3TWd4V3VlN2NyOWZtWFhseFpVR0MzT2ZNbzk2RzlCVk5kcm4vM3RK?=
 =?utf-8?B?OHNFell6cTBnQ3I1aUx3UEZ3NStrTWJVTDlqUTFIYVM1b3pETnJ2OTg2L0ZR?=
 =?utf-8?B?K2Q1bG9jZGZ0dkVtRks4bFhNc0VVcE1NWnpYdTRKdFlQcHFvWFNCN01ZWTBw?=
 =?utf-8?B?UmVMSVFmcmZqdXFWSW1HR09Ka0ZnRk5SY0JNRGhBMW1EaVptSUt4QWRZdzNm?=
 =?utf-8?Q?XDlHlBnTMsi2W+blMdeSvrV89?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd76264f-9e8a-43ed-27d0-08dbefd72ef6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 05:59:29.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+2L7Bxe36m02TgiEy3gu02PIbj+gbvPUncD8KGHHhNaUhATmyHuUudcurh/KR8NhIvmsujqBVXc2i1KXeXyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

On 2023/11/28 03:53, Nicolin Chen wrote:
> On Fri, Nov 24, 2023 at 02:36:29AM +0000, Tian, Kevin wrote:
> 
>>>>>>>>> + * @out_driver_error_code: Report a driver speicifc error code
>>> upon
>>>>>>> failure.
>>>>>>>>> + *                         It's optional, driver has a choice to fill it or
>>>>>>>>> + *                         not.
>>>>>>>>
>>>>>>>> Being optional how does the user tell whether the code is filled or
>>> not?
>>>>>
>>>>> Well, naming it "error_code" indicates zero means no error while
>>>>> non-zero means something? An error return from this ioctl could
>>>>> also tell the user space to look up for this driver error code,
>>>>> if it ever cares.
>>>>
>>>> probably over-thinking but I'm not sure whether zero is guaranteed to
>>>> mean no error in all implementations...
>>>
>>> Well, you are right. Usually HW conveniently raises a flag in a
>>> register to indicate something wrong, yet it is probably unsafe
>>> to say it definitely.
>>>
>>
>> this reminds me one open. What about an implementation having
>> a hierarchical error code layout e.g. one main error register with
>> each bit representing an error category then multiple error code
>> registers each for one error category? In this case probably
>> a single out_driver_error_code cannot carry that raw information.
> 
> Hmm, good point.
> 
>> Instead the iommu driver may need to define a customized error
>> code convention in uapi header which is converted from the
>> raw error information.
>>
>>  From this angle should we simply say that the error code definition
>> must be included in the uapi header? If raw error information can
>> be carried by this field then this hw can simply say that the error
>> code format is same as the hw spec defines.
>>
>> With that explicit information then the viommu can easily tell
>> whether error code is filled or not based on its own convention.
> 
> That'd be to put this error_code field into the driver uAPI
> structure right?

looks to be. Then it would be convenient to reserve a code for
the case of no error (either no error happened or just not used)

> 
> I also thought about making this out_driver_error_code per HW.
> Yet, an error can be either per array or per entry/quest. The
> array-related error should be reported in the array structure
> that is a core uAPI, v.s. the per-HW entry structure. Though
> we could still report an array error in the entry structure
> at the first entry (or indexed by "array->entry_num")?

per-entry error code seems like to be a completion code. Each
entry in the array can have a corresponding code (0 for succ,
others for failure). do you already have such a need?

-- 
Regards,
Yi Liu

