Return-Path: <linux-kselftest+bounces-4338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CF84DCAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1795F1C212F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE376BFD8;
	Thu,  8 Feb 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI2+Hc5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22806BB5C;
	Thu,  8 Feb 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384055; cv=fail; b=AmHC/bhTS/7qbwyRJhuKuUJIA4R3lEG0DVIvcylr/e4TMquXFQjOYyKber+gEM3AChnK/kbNkoLKeA71WuRchtTDPAXYrGLBKNYVViioAY++wDcFtlCOg5R60bBSPGuBtcFmHLa/YtbtcwipGQJGNw4qsHabESjrydTMS9gh4nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384055; c=relaxed/simple;
	bh=lURIfTILfRdT0Rn1EUi5QqXnMBgYBLrNCv0Ja/bqAnw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzzZQ0TAQnaJXzJUYL33A7/QyChcTWistr5HJ4PUTxKe05senLH1X2DpRbOypzgDfbB7UW1ynq7eSBk/nocYvvSix9tyLj/MRGzyiS4RacoEik/lBas9ZAp40zhozYtflo7dG2/xpfuc1yDT0onc+hOcHI/s5cPKklCzAiQM15c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI2+Hc5n; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707384054; x=1738920054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lURIfTILfRdT0Rn1EUi5QqXnMBgYBLrNCv0Ja/bqAnw=;
  b=OI2+Hc5ncklDToSb9pWsXLRZJ5XBLskpl3YYrm67zAJwWY7s3pcW04j5
   jY8no0a76JPZIDtwAPcubaGouy7aBuFSjANul/Sqi9qvecIOkfbi9v1S1
   KHvQgGyC89xZyR7zRkhNnp9yUFqbIJpckAPm2IKrjuH34qHMQKJusgAmn
   +eKABCgcKIie7nzLsc62JvPZPkjPIIeru1edlBfq7RziEAKHrqADUgkg6
   TEUBJJojC/c0rlTzaBAXkmp8A131JUXlMOX6SIigGybgRVBRzTPpGSxoW
   GHuOeT+EXGd1nBcBw6/kJhfT8D7daePhC6Y7k1l2ljYWv4WgZ552TZp7v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1065480"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1065480"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6378425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 01:20:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 01:20:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II3aWUeLGYcZel3YAbLaRVoWeHuD3OpRf08f7v3328kw2PvMuZjcOwSw50NSSsvGMS6sqRCVPuLZpMUcd0HbiCsNznShwmmvgQEhOLUrcHv62hH4y3L3JMNWFj+564Dyi347XaI40RR0EMe5A8TAGPBjr6qA/wq5c4Yc2VZXlvTSK8Eo+owHpwWqbtm4vL9QyNJXECRog938f5DXpfMa2i0TNNwg3skiIp3Yy5EkkTb1LxiTvrZePCbAeMFinm8Imjy/sopWYi67fJ/Ukp19lsSXJDPnZrQrkMRDMyf3l5lv/7hx9Oj46/H0TxPmAkBGtPiURgbkJ5g3R/0u0m7Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/X5bw8fLg83LhPTtdSc51Vx2bncG7aXLwCHF1IEBzo=;
 b=Yzs0vP9Gcafux88bHZVHgX61q9Dm9v4NbvRZSEBtUtZ5pj5SzH/7EQprnnBPHzJN2IAMn9LWiogEaQuMs49PFU9dpcStI4J8n+rcxFvkkgKhl9GF59MTJTNrJq2A28/o0msawL979Eu2MBNd3iSBWokxzRqyQbZJdHWlBQPKuFFO6oS1DyiXZiPEbkZGzJP6wHJd4B6/b2PdNhnX0QPtOIH0V+CPMNKMuTIKvG//JtdQmqzzRxO0CDG2Hjh8uPU/34Ylygl9wUNxIHxvXswziV/PkbYRepYCNtqZ0jJRMtAEkz3/tvlLuYGnqg9y6lHhwzczcsYK0yZN2IMhoDEMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 09:20:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 09:20:49 +0000
Message-ID: <defdccc8-449d-42a7-aee6-8ac212a777ba@intel.com>
Date: Thu, 8 Feb 2024 17:23:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 8/8] iommu/vt-d: Add missing dirty tracking set for
 parent domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-9-yi.l.liu@intel.com>
 <BN9PR11MB52761895C4DB8861C32A4B698C442@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52761895C4DB8861C32A4B698C442@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1126a100-1f15-4012-6a16-08dc28873d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEs5nt2OLoMh1ko4FKbvI6wFhfUyfnJIw1XNQXYqJ9/HyVA+1BxqWMyOJqXteS/YQiQgdMxcgS19aQOI7BDD3V9Zv5Tip9AUM0qRWOtizObSR/N3CqoaZouBBxh57kMIlYObK7urmeAagYfSXENPF8xuElO/zbbUK4Lgo1paauX3Hgafhfd5v+Jp484cM4ix28qWMYCe9dfwNCvmD03o4DFYUq7B321tfrZzDNdPVQXDunWc8Z/8PL8kSi13w2PoKWHdZ0NDhT337SJ2PlWJUweTR0SzlIVGiWYOvQ34QeaI8MiiYVf3owTdzJdpN7FmBH61Zls2Bhsby2AKwpaVMKv+WqDZ9y59dcLgWdROm15IQ/MwKGgVIj8SO9lBq2N4IXBJLJUSpUK8n/4gNDswImhUW0QDPNDlbZyEZlPTLO95Td9IJ0Kgvmp9ia0iqh2gHfKjDCmargzGERxStY/NewyvbdxQOFSu7tXpYbi9rZMZZ9NB0dAWq3fhUOaWG41W1dKMrHC1pMA4fJqq34edLtFir7d3A3Ps/fIQ21cyLt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(38100700002)(2906002)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(26005)(66476007)(66946007)(966005)(7416002)(4744005)(8936002)(31696002)(8676002)(86362001)(4326008)(6512007)(5660300002)(36756003)(6506007)(6666004)(2616005)(53546011)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVNN0twMjlYdWttYW9WZjl5WHp6YTBuSUlaU3BwNXNGbDhlYzFWekgvUDRD?=
 =?utf-8?B?N2ZxSzJpTXZqeWZOTTl1SCtUZTZxRUFzNHpuM3dZckZOSVlwRjBoZmxpOGFs?=
 =?utf-8?B?bmw4MUhaV0luUS9pMmJjQ21LMUpERmdIZTl1Y0d4bmZCNUFMUWtPVFBKSC9Y?=
 =?utf-8?B?ZjlESHVKNWVodTdWaDdxQUF3aUJmTkZaYUgyVWQyM1dKMjZubG1UNGJpSktv?=
 =?utf-8?B?OVNaN3lHNmVzYW9POXBwaVZ3Y0kxTlc3ZkF5OVZYcytmeEpEWjhpSGk4Y1hU?=
 =?utf-8?B?NE43UjhtTWVrUXhaV2xpYzlzbGNRR1dyYktBd0JCVU1hWldiVGxMejYzWnVq?=
 =?utf-8?B?cXQ3ckJMeXdOaVZ3R3l4MTRIODZaSTg4UzFPUENtQkg4SXRnVFBxcStvbm1j?=
 =?utf-8?B?L3BrSGhLL3pQVk1ic3NQU1BzeDBRSW1uR2FGUHFOQXlhb1FPOVZvU1dMUHp4?=
 =?utf-8?B?d1ZqWTFrN2FORVFKZHBtTjFQM1pVbnI1VkNQRFdMdDMzSzJqR3A1UUhpQlU1?=
 =?utf-8?B?Ulp4QS82UlRONXdzL2ltOTdYOFUzSnplS1dpNmFRSXFhMHlieFptUjJBRDFE?=
 =?utf-8?B?RGFCL0UwVzhFdEpYNitBdFU4T3JSZ0VPMHY1eWNUSzBiWkNNZFA1SlFueTBZ?=
 =?utf-8?B?OS9MWWE0alBVNEJPaGpHenJmcU5kYlYrWk5iY3JtS3dFaW5ITFRRQkk0bkFl?=
 =?utf-8?B?RFh6dVc0Q1NiVENuTzEvQUdMSzdyR1dDMXRpeGZJNEU1TFZiNXhuNnFhNzZz?=
 =?utf-8?B?NGNsZ3hpY1BNYlZOODdSS01OWkgrR0lMUElZOWMvRmdMekU4eTZEdVkrTDJO?=
 =?utf-8?B?UDJyeXFGQ0c0RGJhT0RQODlvV1ZJQi93Kyt3RERVUVI0TFloWVhGc3VrdVJI?=
 =?utf-8?B?bkMyeFJ0cldyajJLcHd4RjB4UkxjcXV4K0VRMFZkUXhzWGlMaGt1R0paYWRj?=
 =?utf-8?B?M3A1SmdnWnMyZEdYSW1kWUNuZUVxeEMwS2N2ak1OY1hrTGJnMVNVVTNNdGY5?=
 =?utf-8?B?WUI4eVVPSThPUldhM2R5V1dUdndCQmVjTU5yYmgzTTMreUV2S2hvUDNFZ0pD?=
 =?utf-8?B?VlVQNi9idUlRTW1WUForVGVKbjZJdmhXNFNqVWNNZzVXN1VLbG8xSDhEQlhZ?=
 =?utf-8?B?dlNEdGtZMDRkR2pqVmxsbUg3UmxSeVMrYWdRUUZZMHdmSDN5a2hueW1NbnFY?=
 =?utf-8?B?N2JMSTBQWVNPbXZuMUVReGNTcXBLWlhBQ1hyaDBuay92TkdVMHpQdE5VczZ2?=
 =?utf-8?B?NStGTlpmUXJEU3lEWHhSdE1kcjlnMGYxWTdENm4vOWlmWTExR1NMeDhtaHZU?=
 =?utf-8?B?UjJwK2ZwTHQ0ZVpVNm91TFMxLytMMEt2Q0JNOHZiMjN2Y1doUVZ0dm5kNStD?=
 =?utf-8?B?Y2J3WFVNQllmd1liWjVqa1EwcUpxRG9JTEQ3MWs4YitrTFV0MTQzSm5CR2Zt?=
 =?utf-8?B?VStsZHZUSjQyUWk1azJxMFRHc29sWHdyUFdmZHRqaTJ4QnhueDFXbWdTcTdE?=
 =?utf-8?B?M1ZkQkYrcFdLTUdvb25OZnhqekZzR1lMY3hSSGpXM080aDZ1ZnBhcHprZXgv?=
 =?utf-8?B?d2E2ODZMWjNmay81bE9xMXpBSzhqTm9JRFNsa0tmczEvbFd0cENxM1JiUmFV?=
 =?utf-8?B?ZkpVK2JPSlJBdUsvQXVwNUJZSTJMcHlYbk4yalB0MlZOblhqaGJsejVaOEM0?=
 =?utf-8?B?N3MwZDJJN1Z6YTU0VDFaaUJqS29uZ2VGVWE1WVk5czFNVGtiaFVkNHlXTzMv?=
 =?utf-8?B?cUZkZ3NMUjg2OUtMWFJmOERxQjdKKy9pQ0xMZHRQTTZlYVFNalBTTTg4eDVp?=
 =?utf-8?B?eUlUQkdpZ0JIcXZRaWVGWFczK2FMVmx6WkEwNFhiOTkrajM2K0NJUzBmalhX?=
 =?utf-8?B?YTdUNkdKc3haaUdiLzRTSVBpWnc4RjRtcE5wNlNkbUpMQW9lOStJbHJXUi9L?=
 =?utf-8?B?WHVoalNybElLR2lqbDhvSUxpczRqM25UU1NUdGl4YUk5OVA0cFFtbm1GMDlw?=
 =?utf-8?B?WW9OT1l0MFZudVVSQlN6RndEa3JRNEZnYTV1K1FydkdhcktOUjBodUNRZ3ZS?=
 =?utf-8?B?NnM5WXQ5Y1JLaUZvY3p3YWNlWGptSTR3Z1FUMWFvQXpyQ3lidjVnV2UwNkY2?=
 =?utf-8?Q?CA7qqHuGb1OX+k6FGqAvwSfS4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1126a100-1f15-4012-6a16-08dc28873d67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:20:49.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufwvDpvpZ/yF1qBblTLEOOy58dz0G6SQBKJWEuZdR0aL6QFHtUBwQsX2lwLu2uKzZIXgWMl+67cHmvlI3G2ngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com

On 2024/2/8 16:53, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 8, 2024 4:23 PM
>>
>> @@ -4760,6 +4790,12 @@ static int intel_iommu_set_dirty_tracking(struct
>> iommu_domain *domain,
>>   	if (ret)
>>   		goto err_unwind;
>>
>> +	if (dmar_domain->nested_parent) {
>> +		ret = parent_domain_set_dirty_tracking(dmar_domain,
>> enable);
>> +		if (ret)
>> +			goto err_unwind;
>> +	}
>> +
> 
> there also lack of setting dirty tracking when a device is attached to the
> nested domain while the parent already has dirty-tracking enabled.
> 
> but looks even w/o nesting this is missed in the attach path.
> 
> could be fixed separately. so for this one:

it's fixed here. 
https://lore.kernel.org/linux-iommu/20240208091414.28133-1-yi.l.liu@intel.com/

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu

