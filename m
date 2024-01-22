Return-Path: <linux-kselftest+bounces-3294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01653835C1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A11C22E3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FE179BA;
	Mon, 22 Jan 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaDCrZNT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4001A708;
	Mon, 22 Jan 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910191; cv=fail; b=SJUh6DUIasPRijizjIqmUnnS5XyxmrIf1PbVmguG7zy6pvp4QfaBEIrvf1XMhQfKQiRv5Emvh0ix3n3wYXHQiOqXVIaLVTjNK31U4eGN5Oj7qXU9ftHi2yk0D+nmY66j3T4QKEe/zF4kEmZdWUuU9OnMpKlaelqEEYazLDUxGjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910191; c=relaxed/simple;
	bh=zf+tXUouP8GiPmADGugwru44IBs8AdXt6e3RXp1x5Hc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i0gj2Y51aB/MN1c21HArLkvzzq3lHpH9T4gDRaSKaIiricaImV8/y0LJGi9TfnXyxcHlYPosei83k5JsfTNPMUppO1++y1B/PK+Y/8WfRg9lUeiIMOqAFrtG5Z2bFS5CsVUJ/E3YZ/LmyRvwHMmxmZ9D6WJHTSt3E/ghEW1ivEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaDCrZNT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705910189; x=1737446189;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zf+tXUouP8GiPmADGugwru44IBs8AdXt6e3RXp1x5Hc=;
  b=EaDCrZNTMHPGvi8GZWmP107g01BLtNvItLypVqGEwxXlEmRVv0K9NFW5
   50L4MoCpq1rdF+EE+/4IwcmvY7R3EEprNUpLmYKsMNp8Px2oRaM/g3kvo
   MosI6VePp+vXaCHRlblqBNaexX5j/tcTiM4uP7uB3gqsgSU2LT9WHPSFp
   1rUm6PUnGAOEAm2jC2cI0+pcVYzcUhpIpzdVIbxu/6ohu+8TPwjP9nX9J
   4vc4z7sReWpO8xbxOD5gXtIgSez5pqw8+bR2L6UCC83uQMX49c+5uEV5/
   lgrw4d8ztqgocjocTxyj3NICc9HdnlSkej6mFdp73nIiX+eisc8dDdulX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1024827"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1024827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1032498615"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1032498615"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2024 23:56:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 23:56:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 23:56:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Jan 2024 23:56:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Jan 2024 23:56:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh+zMhHWYtJgNsCLipUMAFLzn1WKdXcoeXpj8cjUc6EfiXbRg4FuZ7z/CbtKZ4/LfOU6vAp3bI38qdCvPrWrylJJndeKL4F6yr+ffopj3I/BKRHxnXk+9sL9R0WD5Rq7/1dekbtEvWFmGz+IoAjpFmMjPEgIJHxf0KU/GXxAaCobcsDL9n1ZLX+ZZrUAm7Msy+KzNUJDWpG9+X8W7Nm/Rd0eOV+M4+cVUyByG+WPuJZT5nw3SCbvQdQEFSY8ode9xnumK0TcdciAoYepMNjByWip+OuRjHdaD+WnbhAtxaPwwVAJAvFhmtDsrbrGh6YdODzWlJgtxJVYrSFNIUxiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbOrpLVS5kmTZfWhtJ7m/1bTT1oda1HAugMC6WLA5yM=;
 b=LiRxl2BDYxnNveTCRuGCDSf3SiX4vwofVuHTdJIVK3JRMe6/ymcF9NzNGf8TGVf64TTarDaxDdjzThiIMxFOT5Ax6OnZV87/68xj94zyjFLRT10t0pY+TgZTbrAC8pmPQ/hJzGS90tw2xe7BIYBjPMdK5B+jynp2lFx5aBPXeq7teKZyFlXB+tAtvSAiKkqx6Yj11gtppXRqFpMvj9pqMXKoYqMmbsS8WWFZh4n6ozl0tg6nYsMSPVW1t8hCnIv6sBmlNw7esCWjsJ34cKClIfXwbz1HS6tmNlk7Bv2P8Gxp4CB2e+k0+LVoaKl1d7JA5C+3ZOG2KwahbQEqwRzuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 07:56:20 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Mon, 22 Jan 2024
 07:56:20 +0000
Date: Mon, 22 Jan 2024 08:56:12 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
 <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d177d02-ed78-4254-76af-08dc1b1f9ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0qjPYwmerxidGVbqJuzoZTEdJQNLwqE3PvLzJkrG7bBDi+LguhGRPb7hPqZVX5uHDaIbg3tvZ2AQ1vpK3RTSGlU1pSYncbEj5f+/l/hOfpAGFvJtToOUS82zO0N6Bz23eKCYvXLz/Pz5YqLTINTQYyBVzjY4ZnOm/sPIrmMNOxKcyP0+ECcyLtquWYFX8A7TcrTit8VivXOlKv1F28MifISxUXUE40dCy1PXcND9R91x5kylo+AAGqF+X7vPmNY5UHe54B8cMfDNXSRag/O+FHGsfWmknwYcxaAvS0XYb2SBBRJMvnbW2AqtxzRJ0UPgsdcekvnz4OX67wHZxpPSu551rFb9ijS4eH8bPdEIuQLced7ZHXbzr4lmfFxJf4VlDNYaaLeM57YZKUCdUH9P4M2/2oN4yHWhlMqzIMD5wK929HVJfl0cIsoiOlmOKc60uTxVzds+Pd7jopAQa368DbS/m5jorLxsr6vVgGWWUT1dCiTen18nb9AThiFvkh2KnAzv7p2onR9Xi5bthjqbjEl74tAni0deOwoDvwVJFcXAleN7jiTGFNI3BJuYV6/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(6862004)(8676002)(8936002)(66946007)(66556008)(66476007)(54906003)(316002)(6636002)(2906002)(5660300002)(66574015)(26005)(82960400001)(86362001)(6512007)(6666004)(9686003)(6506007)(53546011)(478600001)(6486002)(33716001)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SU3+/aHHGoc/eaxdkZJkWPiVJWbIBsGuj9amTp6RjyFkW/UEfCbfUmtyuE?=
 =?iso-8859-1?Q?CRfGPZtkwveAFHKnzqFyV0kp485ov7Src5zIcevJFK647mw6H/ZWlTv4sJ?=
 =?iso-8859-1?Q?ckF/k58cO3fCanlSo01PtpOjCFzhKDhG27H2h/sdC0l7ONpqPSZiYgvbTU?=
 =?iso-8859-1?Q?1UVrgoPOXPog0/l/alHLXKn6gU/+3Vt+UanYYXpkJgTNmF6MNfZZaFPWDs?=
 =?iso-8859-1?Q?EHKDBAsLnOikmfk3bTZcea83ZxfBnrGCf3z+ibjI7+2NxRk3rV0W/EW9hj?=
 =?iso-8859-1?Q?77PcR+xqRep0FXVBbDsNsHdFS6AdPYPSVocZvpQAJ6dLCk7zTR2IPPtk/p?=
 =?iso-8859-1?Q?eYLme3XMe8l0yPLydMMVGDEYhJ+F7DgbttuexbQRh/R0AsFm7iKx00As0u?=
 =?iso-8859-1?Q?OWCGlOjswRlbsIpYbROgfPj5pLjoqJrZCv53QQx+lrMHZWStuAG4GQbBoc?=
 =?iso-8859-1?Q?Y9FxerxgfRN4c4guQMa99YxqYqenp2iVZ8M58QZrgtII2pyZcdwlf66qHI?=
 =?iso-8859-1?Q?Umf/UETQPrMMIAquKm5ChtgYWU5PdKeoMM8SwaRRu1tHo1pYjEOrWkMM3G?=
 =?iso-8859-1?Q?JShgyIfjb3e498ZM4icvWWl7tLC/q6n52eF4oplvN9IVfknR3uEf+dtcYf?=
 =?iso-8859-1?Q?GLBiaN0WvHA5A/fx/MMZxFOdNml7QKEjOZI5+Om+T7GyHW/frIEJGrf87E?=
 =?iso-8859-1?Q?X8KKoETZMwYvgi7boIkyF+DfF2pby7f5W/yK1/50UvLG98eH4b4WSor/Ek?=
 =?iso-8859-1?Q?l9j67Lhm+W4KIl/g+v2uSIYPQfVGugQPZPhc9ekp0iTTYHKOaXYykqieUO?=
 =?iso-8859-1?Q?FfWTJK0MJ109dWoKEcoU4ldOzxiStHCDLEFUWTmyuwrtiV0dMzaM096ndO?=
 =?iso-8859-1?Q?fdpwDVbpWbKET24wfXCZVZUM/9+uWfWqSRMjvDuEL8E35RE0ZAe+xKwy0M?=
 =?iso-8859-1?Q?jyyQcTePwMFQxwGiZ6DNwCIM/6GdjvrbUf0WA0A/b60XonbSXMEsHRiU0f?=
 =?iso-8859-1?Q?CL1d467GP3YQjwoKbqXg4ybsn7kyTup6ceX2jyDDZws68bC/pGRpPvmUE2?=
 =?iso-8859-1?Q?hGUmO6P6Fr3nfRE5aBh72vhHrjJL73hnfYSjH+xDkiggaB3fUKtgUxCt0J?=
 =?iso-8859-1?Q?BbKZpBse5aovLqpckx34YGV8LIejr49/oI1LLr5FpYzzbARUr8Ham001gU?=
 =?iso-8859-1?Q?n3WZJf590QBOmA/cu7CfvRjk0u5Nq5IgCGujGHdJkWhHawKxFPNyy89jgK?=
 =?iso-8859-1?Q?zabxS9+D6V3TUkMEonFNDRUYn6AT+cWVVHe5RsZQke2tjv4AdeFJlW5m+F?=
 =?iso-8859-1?Q?iYNXiUbamfXa/oVQBl9fjNmsF+0tqS6jK8nZhMWsBjh8xgzHsEL1mEKAmr?=
 =?iso-8859-1?Q?pwFmEnOTDXKi487f0HNA6fDLetaY731y9cjJQ9Nhj6LAcnJOw0F4WTCr6N?=
 =?iso-8859-1?Q?lC+MFmEJek0Y2bWCF4daGHfO+SwQ5jwNZNg/kO/j+9SI0SVWyowSfzYWSs?=
 =?iso-8859-1?Q?9BgbXNbHahKNQPuynYR4d2BOSHm361SJ656UWh80ADES5kLCL3ghRIIES6?=
 =?iso-8859-1?Q?QrPBRmXn2NDd547OKin8jnIfE5Bad7X5F13tqvGetpAS3gNrxHbsUhorwK?=
 =?iso-8859-1?Q?HmSuS2JsDFuh4xfSBbWn8ubUzHJOJKKgkfYKI3fFmfw0WnRD1liiKEJn9i?=
 =?iso-8859-1?Q?H53cw8kSwsDmQjGKj18=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d177d02-ed78-4254-76af-08dc1b1f9ecc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 07:56:20.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OXcAA94uUra9T8oZwETc93mBf3855IP3brD8xhWT7/+OTV9Wr1/FFJjAaz1lcFpigtKiGigvSJDuM5RAx4cY04uK23ChlJpg8nHO+vIwHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

Hi!

On 2024-01-19 at 08:39:31 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
>> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>>
>>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>>> +
>>>>>>>> +	/* Contiguous mask write check. */
>>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>>> +	if (ret)
>>>>>>>> +		return ret;
>>>>>>>
>>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>>> noncont_cat_run_test(), fails.
>>>>>>
>>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>>> and I believe that the test will report an error rather than failure.
>>>>>
>>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>>> source code of the test to understand what the test was trying to do at the time it
>>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>>> trying to do. 
>>>>
>>>> When a write_schemata() is executed the string that is being written gets
>>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>>> it would be easy for the user to figure out which one failed.
>>>
>>> It would be easy for the user the figure out if (a) it is obvious to the user
>>> what schema a particular write_schema() call attempted to write and (b) all the
>>> write_schema() calls attempt to write different schema.
>> 
>> Okay, your comment made me wonder if on error the schemata still is printed. I
>> double checked in the code and whether write_schemata() fails or not it has a
>> goto path where before returning it will print out the schema. So I believe that
>> satisfies your (a) condition.
>
>Let me try with an example.
>Scenario 1:
>The test has the following code:
>	...
>	write_schemata(..., "0xfff", ...);
>	...
>	write_schemata(..., "0xf0f", ...);
>	...
>
>Scenario 2:
>The test has the following code:
>	...
>	write_schemata(..., schemata, ...);
>	...
>	write_schemata(..., schemata, ...);
>	...
>
>Any failure of write_schemata() in scenario 1 will be easy to trace. As you
>state, write_schemata() prints the schemata attempted and it will thus be
>easy to look at the code to see which write_schemata() call failed since it
>is obvious from the code which schemata was attempted.
>A failure of one of the write_schemata() in scenario 2 will not be as easy
>to trace since the user first needs to determine what the value of "schemata"
>is at each call and that may depend on the platform, bit shifting done in test,
>and state of system state at time of test.

Doing things similar to scenario 1 would be great from a debugging perspective
but since the masks can have different sizes putting literals there seems
impossible.

Maybe the code could be improved by putting an example CBM in the comment above
a write_schemata() call? "For a 12 bit maximum CBM value, the contiguous
schemata will look like '0x3f'" and "For a 12 bit maximum CBM value, the
non-contiguous schemata will look like '0xf0f'"

This seems like the closest I could get to what you're
showing in scenario 1 (which I assume would be the best).

>> As for (b) depends on what you meant. Other tests that run more than one
>> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
>> that the non-contiguous test should attempt more schematas? For example shift
>> the bit hole from one side to the other? I assumed one CBM with a centered bit
>> hole would be enough to check if non-contiguous CBM feature works properly and
>> more CBMs would be redundant.
>
>Let me try with an example.
>Scenario 1:
>The test has the following code:
>	...
>	write_schemata(..., "0xfff", ...);
>	...
>	write_schemata(..., "0xf0f", ...);
>	...
>
>Scenario 2:
>The test has the following code:
>	...
>	write_schemata(..., "0xfff", ...);
>	...
>	write_schemata(..., "0xfff", ...);
>	...
>
>A failure of either write_schemata() in scenario 1 will be easy to trace since 
>the schemata attempted is different in each case. The schemata printed by the
>write_schemata() error message can thus easily be connected to the specific
>write_schemata() call.
>A failure of either write_schemata() in scenario 2 is not so obvious since they
>both attempted the same schemata so the error message printed by write_schemata()
>could belong to either. 

I believe my code follows the first scenario example (since one schemata is half
the full CBM, and the other one is the full CBM with a hole in the middle).

I'm sorry to drag this thread out but I want to be sure if I'm right or are you
suggesting something and I missed it?

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

