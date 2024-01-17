Return-Path: <linux-kselftest+bounces-3135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756383012F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF31F253B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6BD272;
	Wed, 17 Jan 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8Lt28O8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90826D30B;
	Wed, 17 Jan 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479692; cv=fail; b=JNoiS2LD0a4noXVSy8o1+wrEUv77j7lVftX3eA0cmxFe4vhRvv8jRFOrdCOdU1RRxPYYA/UUPFUZHglSz0/F4gkCU3le8eDcffhFtN3jMyeudRCvW72g384JymK8GbIM2ZyL/hwak6sDpIDvLL9kESDUuZv4ryp8iTQz6qI7GbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479692; c=relaxed/simple;
	bh=Ur5K8Q8ffZP7weF8yc/ScLfbWzZ1Xmw+HUkzfqZmKvY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=hftIPTOZPSNCishlNh8R+5dttgtMd8W6Hj8cIDQdp+w3Pg4wOBxrmbctKNViqYCRFVWtox5y/sCAXHin7e0fgRBCYYAS4rWybnjxFr0dwZqRZFnHPKBlUSvt9CrTeHIZ89vyvNhxy1H0EpKZfBcqJ0Rii/CfJ9oZl4m5NonT8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8Lt28O8; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705479690; x=1737015690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ur5K8Q8ffZP7weF8yc/ScLfbWzZ1Xmw+HUkzfqZmKvY=;
  b=V8Lt28O8/p8N9etU//PZfIVARKWyAcEk0h07Xhl2Q/QvHY1r89CoCbwD
   +a6krfP6vGQ2tnq6YVPr+c9drkDh8lTkSWUTFyl2oXYJWTo3/6Zm2EfxM
   2ckwvIIv/V/iBnSH6jclOpOBn3CiFageKND8JDo95oOHRNHmyeOFza7gu
   tYSvrYKug2YJqsjssIU1yfqBLkCZhE4NUxweqHAHMf8LVZDCjdl0gb3yf
   UScOk7g+2zTQ1qr808gGza2MA+g6UXTKvpYzHuzhp3938T408hKF4H+y4
   xftCMWdNwnvqDq0v/X0I5m3HOaAlFpQ01DjXUJ6dD4MWA0MC04B6Brt5F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="431266955"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="431266955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907676551"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907676551"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 00:21:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 00:21:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 00:21:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 00:21:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4u7syqx1UKNqK04S1EalfUeV41JMGQg7TY+TpM89mO4WrIF53WDe5Uqw9OCJARla/OkLyJ7BULKgzpPotXcDBajN0fgDY8sZ/tjAN7Ix+J4mMlLFcSuZkKQ6j9Jf1SNsKlV5DrH4GLZf5L+GREFNNwyZwv4JeZrAwZpur9+Q/1RJhbp++Pqgoz9Mu311bd7UM0u7TXogItHaBWUpLLO++49dQlvRzVlkVtT55Bhw+jfzn9DLSaqXvHijLpGhGuhxVqZ/uasXsXokDnLMbID2se3QgXgou0uOyYFxL1HAvfgoBU/UmIsMYmv7+vr0asAdVsGf67slEm3ZEjaTRXKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVMXY05dHpXYPQ1tIpnHY+tyAgd5iS1+AeM7+gBC574=;
 b=mQQRQcwQ31gbdgXEcO510MUeyMkUDekmKRdCNxcS5ow77GUTT5Dpd3Fw65FXYGRWGTMHQFqqosoUKn01Hsgd0F/WjacvI0ptNsie/jGdt9MS+aTEMIL8+5orsk0YxPDfNyGvSXpIHg+WpAkBjnP40VOzmvowngyC3cmUEbKsgIuFAnNItz7PHDIL+evWs5zqSdaui3jrsuiJZHI0To6fNZP2u5NW9HnjpDwyxRx3rXCaSXZ0nr3zviqDMNCL5m6uAWcIoLT5yRBk/HZ4t9QwIb1jFdwf3JXFMSA1N0hmpxLidwPJzQQt9hz5ShvOn+39qFNT6x/I1ORr+558AmWwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY8PR11MB7924.namprd11.prod.outlook.com (2603:10b6:930:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 08:21:26 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2%2]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:21:25 +0000
Message-ID: <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
Date: Wed, 17 Jan 2024 16:24:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
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
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
 <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CY8PR11MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 954e9de2-61f3-45f8-a469-08dc17354bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhqCleAihsxhfbtgmwhATTwTaI2whzm4PS7dZMm0PsjLpoMBxDGPAmK8/wqcdYGmNDPqXNtV7FHFxsEljgkCzdkpLqO1fEjkZjxYzDY4UETRdTOvtSvmN7VZ/8x0g3OWqc97fXDHOeMlTtaaNyUc0h6Xfyb1ofV3TXJ2xWAbIIz8RFWxGOYws/wwsdaBGwYifCx9onGb5LtF1zncSpVwEETHBBNNd9mRqLcsmT47NpdFPVrXiI9V6hczFwgTaMvqdD0vGoVGvdgHXou8/WS0dLGMaFiKWyCzAcs37Z+tKhQBWhRMm2OJcj9Xb7fDecqhZl75HZquEZqqUmO+RozxUb6fJydynwkB9+E8DAfzm526nfO7yaNxKLMavTh4uhIVohsEXkTWC3e0Fru+7pXaAADdsa32Kir/51GuLC/zSI4sAdDpTP36JuXIrXAJ0ce4tjXlMdHHgH9+5U42PyH2340UukKmAWPF4XSwDUUgGgYNWeW7N025BRNfPnQXiKKVUVsf3MB9MAxogHSJRM7zzxihx+nu4IWA08osRRkpa12Pc/VqFjkKTs755JpaGmgViqpe1OBIUDbt6O6lHo9hRMO8dUYRKr8ZT9rF5IQAIZfzTnw6h2mUmNxXrFD6YjEzOhkl1v8wTRp3qESOo2l5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(26005)(8676002)(7416002)(66476007)(66556008)(54906003)(2906002)(5660300002)(8936002)(6486002)(2616005)(36756003)(86362001)(31696002)(110136005)(66946007)(316002)(82960400001)(31686004)(6506007)(53546011)(6512007)(478600001)(41300700001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29BVFdYQ0w3T1RnZEpUUzdLUys1V0dtOVUzQURsdFZjMnRuSjVhbEJuYnBj?=
 =?utf-8?B?RFhHN25DVEhjY0pOUlF1N0pSRzNGME0reHdMVE5oSVN4dng3WXhhbUNUY29x?=
 =?utf-8?B?T3RmWFY3UGxGVnhJT1BNS2grakFVVjhSLzBUTlp5bnpYR3lhVWFuTVdXQVFB?=
 =?utf-8?B?RmlvSDloKzBjb1I4akV1L01tZUdPazhUYTN2c2JWMGt5dmNHbVNyd2JkZEEr?=
 =?utf-8?B?VW14NWg2blhadHVvU0hVR1Brc3BnK3VaaGhYcUJJdWI5Z2p0cHpFNzhlcXdR?=
 =?utf-8?B?SUs1bk1pM0w4YWdIcC9tNUFWNlNJbnRCKzlDRXJkQW5mdG5RYjJCczYzbVlw?=
 =?utf-8?B?OGFSSGxxRGRKeERYejRubnZuWmhDK2luUmcvcmhFTWN1Si8vbVc0UkkzbTdn?=
 =?utf-8?B?V0FqWUhSU09TYVFNejZYUTl4dEluWkpRV3Fta0pMTzlicWlVK0x5T1oyb1NT?=
 =?utf-8?B?bjF1d0FkenNhRnB4a1JzOC9xeWpobzlJL0x2a0Z6UzEzR0lLRy9oZC9sYThG?=
 =?utf-8?B?SVZTQjZHY1pPRFRMeS9HQkxzaURPN20yNW9teVRFK1VNTEhVK2RpZ3N6MXpr?=
 =?utf-8?B?RjU1UmJqWmo5bklBUmJERUV6cFNqOFJyRGgxcUpaeFAyaVZpTFBqakR6ellS?=
 =?utf-8?B?bjdaZERUM1ZDUll1bVRoUkN5andROG9hLzR6UlBMM0JEQTFIR3ZsSHlxQ0lE?=
 =?utf-8?B?RUdzZm15L3paT09Od0oyVzRUWCtwOGZiVEViOUE0WVk5em0reG4rQm1xL1dK?=
 =?utf-8?B?MG9rUUlaWitZREpGc1pJdVJxN3FXMnlGWGpZczlHbWpFSWVlc3JTSUJXV0Ft?=
 =?utf-8?B?TTc5VVQrVWkva1hGWS9lQ0RSaUxOWU5yMUNDQi9Oc2hNQjEwM3dmR285UWdO?=
 =?utf-8?B?RDVzU0tUMkdlK3EwdHZvUytJOUJkNlIrYWN0enRIL0lMT0g2ZGVTY2ZLek9J?=
 =?utf-8?B?TWIvZFdPcXVRa2ZpRFBRdlJlV21EL2dzbGh1Q2FWN0xMN3Y2NXQ1T1dYTHZt?=
 =?utf-8?B?OG5IWlBUVG1VUDV3bCtzdVVtNDhnaGovTElyYWJGK2hLZ3BraW54UGU3STVM?=
 =?utf-8?B?ZHZsZkVXZmlGUEV5OVFBbmpLTytaL2JBbnlSbHl0cXlCOG41NUtnemdsT2RK?=
 =?utf-8?B?ZWFpR0RaWGhKZjdzWmZSYUx1dldvc3JYUUVhN05QZ2JMdDF2NmhRVDBwOFla?=
 =?utf-8?B?L0h0bVVVT3UvS3NFSWZGYUYzNHJXaUFCMU1DTjUrZVlHdU5jZ0dsU2RDR2s1?=
 =?utf-8?B?WldNZDc3SEM3cGd6VzBJZDlzKzZuVEtVd3haSVpDQklSOUJ5c2U1TG1GZERz?=
 =?utf-8?B?QWk1Kzcyd1Y1MW5EbU16VkZ3UUJjeXRmcDNjVDdkOFVqMWRzSWZYZjcwZUlE?=
 =?utf-8?B?VU5yTWJlblpFR0M1Y0NOd05kbklIbFNkdlNGRlFlN3NGT2JxTnBjVjhscUxT?=
 =?utf-8?B?dXJ6U0N2K1NQVWpsT1crSXoxZ2NnWUtOc2FJNUhYRlU4QzBZSEtYbitad2RG?=
 =?utf-8?B?SHpqZGRlL2xlVVJRdGhPSjgvSG52V0VXbThnOEFyS25JaldEbkk2Y09GK2hK?=
 =?utf-8?B?eUJURTRBbjcvR1VEZXpkK2ZTbnlzMmdCQXZIUERBdnlWZVFoNnl4QXlGb1Zp?=
 =?utf-8?B?amluNXdSWWFkek14U3FnVWRnVGJYQkRRYzlEeDlmVHFMYUdFcDJSWXJzdEE2?=
 =?utf-8?B?SllvQTJlc1ZsWk5xd0JlS216bWhEQ3ZTc0dDdk5qTzJncFZLZDJ0TVVJUGpn?=
 =?utf-8?B?Zjlqa3NwRjF0WHVBcVFBZVFFR0FHQzFoVHM5VkNSTVIvMmFOV09Lb1VXZmc2?=
 =?utf-8?B?bGFtaCtLZFlONFo2TjJNb1JYcU54cGtmNTdKeXNRbkdjWllTVXRlL3BLd29h?=
 =?utf-8?B?Z0N1QTZJaHpmYzI0SXE1YjMzTytTdm04SmN4NHNBSjFjVlErbEp6UXNVWm9p?=
 =?utf-8?B?dUpwRDVJRnZmUFFnblpJNktJN1drdGhacXBHOHVkR3dqNWhFcW0yK2xXcUNs?=
 =?utf-8?B?RllINDA4VHF5eHNIYnlDZlNSeGp4T01neEZpWk5HZXdsK1UrTEZjeE1ZZkNJ?=
 =?utf-8?B?R3NmWXhnUmNqcXNoQW52L2FsRXlpbG1zallsaUxaUENkQU5GN0I5cTN0bGxR?=
 =?utf-8?Q?uFQZ6kSnt8kvIs5wq9Gr2dlJb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e9de2-61f3-45f8-a469-08dc17354bb0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:21:25.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnmM13Vn4z4dyOZRVDCjASM9EGftXKstWxKiWQdKAv+eiKZbpwpZxS6OkqAotzod48vtVCiCKRVdxPOJzXriGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7924
X-OriginatorOrg: intel.com

On 2024/1/17 12:17, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Tuesday, January 16, 2024 8:58 PM
>>
>> On Tue, Jan 16, 2024 at 01:18:12AM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Tuesday, January 16, 2024 1:25 AM
>>>>
>>>> On Sun, Nov 26, 2023 at 10:34:23PM -0800, Yi Liu wrote:
>>>>> +/**
>>>>> + * iommufd_device_pasid_detach - Disconnect a {device, pasid} to an
>>>> iommu_domain
>>>>> + * @idev: device to detach
>>>>> + * @pasid: pasid to detach
>>>>> + *
>>>>> + * Undo iommufd_device_pasid_attach(). This disconnects the
>> idev/pasid
>>>> from
>>>>> + * the previously attached pt_id.
>>>>> + */
>>>>> +void iommufd_device_pasid_detach(struct iommufd_device *idev, u32
>>>> pasid)
>>>>> +{
>>>>> +	struct iommufd_hw_pagetable *hwpt;
>>>>> +
>>>>> +	hwpt = xa_load(&idev->pasid_hwpts, pasid);
>>>>> +	if (!hwpt)
>>>>> +		return;
>>>>> +	xa_erase(&idev->pasid_hwpts, pasid);
>>>>> +	iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
>>>>> +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
>>>>> +}
>>>>
>>>> None of this xarray stuff looks locked properly
>>>>
>>>
>>> I had an impression from past discussions that the caller should not
>>> race attach/detach/replace on same device or pasid, otherwise it is
>>> already a problem in a higher level.
>>
>> I thought that was just at the iommu layer? We want VFIO to do the
>> same? Then why do we need the dual xarrays?
>>
>> Still, it looks really wrong to have code like this, we don't need to
>> - it can be locked properly, it isn't a performance path..
> 
> OK, let's add a lock for this.
> 
>>
>>> and the original intention of the group lock was to ensure all devices
>>> in the group have a same view. Not exactly to guard concurrent
>>> attach/detach.
>>
>> We don't have a group lock here, this is in iommufd.
> 
> I meant the lock in iommufd_group.
> 
>>
>> Use the xarray lock..
>>
>> eg
>>
>> hwpt = xa_erase(&idev->pasid_hwpts, pasid);
>> if (WARN_ON(!hwpt))
>>     return
>>
>> xa_erase is atomic.
>>
> 
> yes, that's better.

Above indeed makes more sense if there can be concurrent attach/replace/detach
on a single pasid. Just have one doubt should we add lock to protect the
whole attach/replace/detach paths. In the attach/replace path[1] [2], the
xarray entry is verified firstly, and then updated after returning from
iommu attach/replace API. It is uneasy to protect the xarray operations only
with xa_lock as a detach path can acquire xa_lock right after attach/replace
path checks the xarray. To avoid it, may need a mutex to protect the whole
attach/replace/detach path to avoid race. Or maybe the attach/replace path
should mark the corresponding entry as a special state that can block the
other path like detach until the attach/replace path update the final hwpt to
the xarray. Is there such state in xarray?

[1] iommufd_device_pasid_attach() -> iommufd_device_pasid_do_attach() -> 
__iommufd_device_pasid_do_attach()
[2] iommufd_device_pasid_replace -> iommufd_device_pasid_do_replace -> 
__iommufd_device_pasid_do_attach

Regards,
Yi Liu

