Return-Path: <linux-kselftest+bounces-3235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618D83277A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC971C225F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FC3C48E;
	Fri, 19 Jan 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ma6Xpj6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181C3C09F;
	Fri, 19 Jan 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659156; cv=fail; b=jq8Wypo3LF/c9z+JijKVh6xYrWpoIK+aeyNpVcgzEnxM7TI3Xo95PtNJjlxIDHw0buXOJ69DuWRp23DdnFyyKXBr+mUVtObOe0esNhFwrOnpcNEwC7DmXLFRm/h7Wg+mjeD5qBXIoWojBdEX7ntP5ZdIdLyAJLGMjQqmxqcJVpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659156; c=relaxed/simple;
	bh=vAM8WwAa4pSyBcvmLwN/TJEEOg1GFhzhtk80m3+dML4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I879bdcoGUhzcNMOnv1/1NU7WSI1Y8XSg6KWDeI/a5C+Q2+2FXBVAMgA4KusRj5wwdy+2LjD9y1vdtbBApB8pkJGwzlmVK4ZNxh8FajfTe8c3q6EaGqxqisnHCGz1g8Qhf/qKzFM4jOC0xUne6Jc9SChSWhAZ3tSVyT0/JtjloE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ma6Xpj6j; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705659156; x=1737195156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vAM8WwAa4pSyBcvmLwN/TJEEOg1GFhzhtk80m3+dML4=;
  b=ma6Xpj6jn0TYxsOQXpRcbPgFr5mZtk00Z1OI7jFxWTjc4duXcG2Qmk+8
   Apaz76Ga+p4HUVgh5CKNEaQfWlJQsxW7ywntE96OE6mHqGnwJslNDceTG
   7dAG2wVCgn6QibPn2bgUt/CSduuwBlYHX0iMTPsr+eHoGnuTkHrfjL9lB
   QiL+DfTOJxnfeeTkVSOLgNCh8vlWQS+XmE79jx8kE86VrSCKb2+Mlx+Jn
   cEtg8TIwuqzn+kKRNiv2647rI4X3B0WMdF82nfMFFb19jsixeBmFlc93x
   xpE8DQpvZE9uzK3gObc1QQj8pUjQYcwevigPdT0djZWa7pLeVobghSYc0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19294440"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="19294440"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 02:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="19362333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 02:12:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 02:12:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 02:12:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 02:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb1AtvE01lRnFelmdpfe4SyU1TPd5WFmZT5fk3H/PYydNOSqlLcwQJj3lPTNJlgIlSLFg8yjEeIEHprKAfyp35oFUzfChqueBS7TTD3/FhbTykhQOP7XHb75K+wRBZmNZH/v5+mq2Uv/GNtlPcp5zJTkskMZ0V7xChCBZUY0G/PuzW+odAKZY0808B6XIm7yghF/+j27ufbWOzXs7rAVAkvjBFWTpjBZty7ds9ZZySOIeuMsApCLTZIJwOo4LLsOihLmB3f0aWfy0eA/+gRADMQAp+84Z35mv8HcvLLtm5Bz8g8wMSfSMbzB0Vt5YTThPE6u27o2j4IQpP9xo90waA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjqnm9BL5seac3s479Y8IlZ+MtkLdzp4fFoWwVc+WFs=;
 b=NYDmtGK13bOIdWZJbLnWwo6lmMsP3ghSLGsSZyjgWcZhCMH57vfhFTmT1X6UdFVuqKDpL3nthTysVARBy37FHUfqBFfcBf3fHo6UiiHNWtM4if96bYwtsZ/2M6UEMP59vQXi0GaOuYMt411WQSofONvqRthcytiYWndAHnPsQXAYFRbtPGshGDAfx99SP1LP886aPsQSB+Wp5dkyedNJeqvp5XBX9QpKuMm6XHY+5zMLzh5Zg1eL2UMmmfuNY4LlvO6l59Chr+37vyNQak6bvYr/UqwFgkXiNTO5TMs8GXhv8kHLMRWLJfK4EJ5JAyfycNhQlFrEMsToVLzsIRUovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 10:12:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2%2]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 10:12:30 +0000
Message-ID: <cb52ad1f-822f-4da6-9753-691454565b26@intel.com>
Date: Fri, 19 Jan 2024 18:15:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
 <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
 <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
 <20240117125625.GF734935@nvidia.com>
 <459d6a3a-0ad9-4980-be37-103211e927c2@intel.com>
 <20240118133857.GK734935@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240118133857.GK734935@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM6PR11MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: da3193f5-459c-40c2-0314-08dc18d72562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NP5aCIZxOwBsc0i8UdQdQArLLT1xPz4yQ3hVq+hF4CwXrZZFuweyg8odynX826cykpxzjNyLTXytGNTV+f65H7a19uwbay8wBsyhF+pYSXIi8zV38btSUIfVUrPUJfIQZIoKC27Pp7PxXjgl+/3VDhHStggXsK4oHoIZN78Zs/r2/nP+3+XxNZpBOg3g9gWGXEemoXcGtkRatZyWfgszcW5iYDSB7iZPjimqK37e06P8l7w/fKGMN2dbAIr/df8wldrhLyUcVbwSV8OYc/4i6ZvBp8J4XI7AVuvT9X5rVWnNniLiJiSrmYW/oQWQNPcpqHRw6epOhzn/9LyR9v1Uqe5JVzGCDzZyDb8mscWP5dWav4Qu31jMMLJK7iVpma9pmAmcKXwthXVH2+jfsnrQJtvICNF6UGBQB6+sjh5C+N8xlFV/Oq7ho+Mm++iEgDp4MzpSCa3Jai7jFCrNX5uyFHjSkwlkgp+yUuJcRF748hOmIsfek+H0za4C14L6scobP+w1nihj8TrwHMDzWv/41b5qsmQUDD+8Bo9bQaAPOXBFSnkoAdNeU8LJJNcgf+nQfIGAmvitHxa5DIIyQJurdnqp7rQXWRuCPBD3hDj4wgHAiv+f0O3YP34IwMozvbPBCmkTH2AzL74WaNljgJjBLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(36756003)(86362001)(31696002)(38100700002)(82960400001)(83380400001)(478600001)(6506007)(8936002)(8676002)(4326008)(6486002)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(5660300002)(7416002)(26005)(2906002)(6512007)(53546011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFWc25WOWdpWDRhNW9adS9uQkQ2WTVERER3K3NKUkh1N2RXaW1POXNnUWlW?=
 =?utf-8?B?NUUyd0tXUHBZN1dEejF4UFErQjErR2NDaUdBVG15bjFZVTFBU2IyVUphSXJT?=
 =?utf-8?B?WHhFbDdQdTJDWnBLRVJ3ajFXK2pRTm5UQndKVy9nZ1dRVit3SzVteDFyWm5o?=
 =?utf-8?B?YWVrQW5LNmlla2lJWGdObnVmWTNWa2dzZnU5cjRQY1Q4eHJkbXBhcFJtSWJI?=
 =?utf-8?B?VXR4Mkt3M1Z2YTJWS1BERy9FMzFMVEREdThsQzY0TWtCQVpFVzBHNkhwdnB6?=
 =?utf-8?B?UGVtbHNGQ0JrT1BLbExibTgxL3VHNDNuNVY3dHQrTy9VWmhxN2pGVWRxbzNj?=
 =?utf-8?B?dFNSdXcydU5EVXJzVXQ3UUdjWVdJR3NQN2ZDMS9RVG5rWWlnNlFOMjdUTFgx?=
 =?utf-8?B?RUFlSFduMnkwbWdrMXA0S3Q5Vk9KRDBDT1RRejF1SkNzWGx3L2ZUMjY1ekpC?=
 =?utf-8?B?SE9jL2Q5MTMzYUh4Zm9uR09oMytjRmFrTEpVK3F1SjVqV2duWkNtZkdRYS82?=
 =?utf-8?B?S0ZzV1RraXJ6d2JWbjFkNi8vSVMvbUxRRjFVTWwvam1wN2ZwUU9JMUQ4Z0Fy?=
 =?utf-8?B?bGJMRkZHbmFyTzFvYlJCYS9ubmpHV2RjTS9zdklpQnI0bzNhZTgxYVpGcnpH?=
 =?utf-8?B?MVV4U2dUTU1ROTJNY3EzVHFCT1VCcHFRSnBNM3RDQzZCdVJNZ213WmZKb1Nx?=
 =?utf-8?B?Y3Q4aDdtY0xVNXROYkNKSytvcnBpU3paRUIwV3M3ZVlPaFcxUk1RaUJqcm9s?=
 =?utf-8?B?QXpGTEpmWmRubkFickhoSWNlYjQxU0NiVko5bWt1MTVTOVdmU0xMZVZxRkIy?=
 =?utf-8?B?UXdrVTYrcUxyS1FVVGVld2lVdXdqc1Zya0hRV1FGVGRheDFDeHltYlMxcWRV?=
 =?utf-8?B?YXl0SG4vTW0zWnBlbjd3K3FkSWNtSDM0NDdkbnhuczUrOFl4WFVsdFlnVEFH?=
 =?utf-8?B?RUkrSVBOdUpnQnphN1NJbkVkTU9mY1lxdC9LbzZRWmpyc3JEeEk3Ylh0bFgw?=
 =?utf-8?B?TDRhdVRwVEZQVmJZYmlLM0JJMlRtKzJZL0h1Z1dKVDBhdUFMU0sxN2p2dzNW?=
 =?utf-8?B?bGxvVlFFYmxLeFlYUG5kc3ZJTFcxaStybDR1bkhmUENmNWxBUmRmZ0VOOFBJ?=
 =?utf-8?B?dmlGbTFGUDdVL1B0VlpMZUlPK1UzZFdwcTVzb3hOOWNPYUQvaWNwaXUwdHZa?=
 =?utf-8?B?Q3lkWWVDSEFYRWIvMDNVWXR6QVRZKzMxcEphT3BUTUxyMDFrTE5vOWI2N2NM?=
 =?utf-8?B?TjBDdnB3L3U4ZFdFbzFMUUJreXByTFhrZW9McTJtak5WTFdKbjZUaXNmNnNC?=
 =?utf-8?B?ODVmR09OSXgvZzZVM0JFOHpHa3d6MG5yckxXRSs5VXA3bnl5NHBIN2x4bnFS?=
 =?utf-8?B?L055dWczYzNXOTkxT0NjM2ExYUhLQXJ3Q0NxdGpmb2JLQUNVVkdUeitYWTBo?=
 =?utf-8?B?TWRtalB5TG1ZVFFrenIvVjhtOFpTRHp5TDdkcXhNclV4SjJHMzhDenp5QjZT?=
 =?utf-8?B?VjRmUEpaNHJiQzVXQldDWThPSnlPM2t0TE10UUtBZjBXdVRVUEo2ekFGR25z?=
 =?utf-8?B?RmFoemcrWUUwS0pQb1A2Y09heUNYdW1CT2xWK1lqa2hTR0Z1MlZiNU9xdTNa?=
 =?utf-8?B?RmlPampaZCtqaVhBMDZrZ2UwRytPWE1yME8vd25oVzdxSFQ0SDg1eVlMTWpG?=
 =?utf-8?B?QWhQYzZSbStXZk9hZ01SSmNrWmY5dFdmTDhDMEt5Y01iZGU3OWVHS3UxTE5N?=
 =?utf-8?B?TEJmZnRBbTV6Q2Z4WU1DU0xYQlRpWDJqWkxTUXdkSVFMeGY3eHFGZGlUL2xm?=
 =?utf-8?B?bXI1WWpIT1l3L3VRZUsycFNDVnY2NmFnR3ZSRDlOczBkMjRzZndUMU5SUExp?=
 =?utf-8?B?NHkvbGx3QzIrNE9HSFF4d2ZaWkl4Sk9UR2l6Q3N4V3pweVR5TnNMZmMwU3dJ?=
 =?utf-8?B?aHV2WThWWjFEdjZia2pmb1pZaVR2Y1Fjd1BpaDBoVEpSZnV4NkoyNjgrTzN5?=
 =?utf-8?B?dDZ1dk1HcUo0RW8xZmM3alNOclpwMkV4N2d0MFZGL3RhN0ZQWnJXNVFZajZC?=
 =?utf-8?B?RHljTEdva25KNFgrUGllQnhRd1hYbDZDVWt3dHBPVG14ZjBzR09TRFYzVzJm?=
 =?utf-8?Q?p3scBnhwO6+IAL2IZVm0//nO6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da3193f5-459c-40c2-0314-08dc18d72562
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:12:30.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGSJfwXifyKXWTP0AN6Q0ptyBse/ea1cMpA5lEK1WxprCL9MbC5nVZpY7zbfTXeMIJ8TQb4n7EkK0k+gS/+BBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com

On 2024/1/18 21:38, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 05:28:01PM +0800, Yi Liu wrote:
>> On 2024/1/17 20:56, Jason Gunthorpe wrote:
>>> On Wed, Jan 17, 2024 at 04:24:24PM +0800, Yi Liu wrote:
>>>> Above indeed makes more sense if there can be concurrent attach/replace/detach
>>>> on a single pasid. Just have one doubt should we add lock to protect the
>>>> whole attach/replace/detach paths. In the attach/replace path[1] [2], the
>>>> xarray entry is verified firstly, and then updated after returning from
>>>> iommu attach/replace API. It is uneasy to protect the xarray operations only
>>>> with xa_lock as a detach path can acquire xa_lock right after attach/replace
>>>> path checks the xarray. To avoid it, may need a mutex to protect the whole
>>>> attach/replace/detach path to avoid race. Or maybe the attach/replace path
>>>> should mark the corresponding entry as a special state that can block the
>>>> other path like detach until the attach/replace path update the final hwpt to
>>>> the xarray. Is there such state in xarray?
>>>
>>> If the caller is not allowed to make concurrent attaches/detaches to
>>> the same pasid then you can document that in a comment,
>>
>> yes. I can document it. Otherwise, we may need a mutex for pasid to allow
>> concurrent attaches/detaches.
>>
>>> but it is
>>> still better to use xarray in a self-consistent way.
>>
>> sure. I'll try. At least in the detach path, xarray should be what you've
>> suggested in prior email. Currently in the attach path, the logic is as
>> below. Perhaps I can skip the check on old_hwpt since
>> iommu_attach_device_pasid() should fail if there is an existing domain
>> attached on the pasid. Then the xarray should be more consistent. what
>> about your opinion?
>>
>> 	old_hwpt = xa_load(&idev->pasid_hwpts, pasid);
>> 	if (old_hwpt) {
>> 		/* Attach does not allow overwrite */
>> 		if (old_hwpt == hwpt)
>> 			return NULL;
>> 		else
>> 			return ERR_PTR(-EINVAL);
>> 	}
>>
>> 	rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid);
>> 	if (rc)
>> 		return ERR_PTR(rc);
>>
>> 	refcount_inc(&hwpt->obj.users);
>> 	xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
> 
> Use xa_cmpxchg()

sure.

-- 
Regards,
Yi Liu

