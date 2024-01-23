Return-Path: <linux-kselftest+bounces-3394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D6838865
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD34B21410
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D656468;
	Tue, 23 Jan 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImXawlDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C176121;
	Tue, 23 Jan 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996705; cv=fail; b=SsOkJnxEXOM0cgDdUG+HPYXWMS+gcdpIaIf6X9lapaoeLZ9dpVqv9+JZhgsse8pVHIWZLJ8fDPPzWB+0iZXFpNuYaKFZ3VTIlLtn5Dlc6oSYJSARqy77oUuMT6QcS63Wnjme8m3HcoOv9OCQ6eipeDgPDtOgPRfsAsz4BtbRfwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996705; c=relaxed/simple;
	bh=MskmvaJ7trLqwGTfi7f0B60rC9JNJcjQJTeRzPYyRmI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qiBSdOyF/wAQz+OTTDUTTFPXuMITxALD/rzRAaijhwcX/oKhLh0mu48mvQw4TbpGxWUaisMIeQc1AguQ2q9MDFH/LC88m4tqd2XjoKIzpg3G9tFkPbnuqa4ptiHGs66D8FvZe/cjaoxEB7/cQ+y5YE3gZSKqGfsCKwoJQLUX6f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImXawlDc; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705996703; x=1737532703;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MskmvaJ7trLqwGTfi7f0B60rC9JNJcjQJTeRzPYyRmI=;
  b=ImXawlDciAHNPHKSon7OT7iAnwVm0GfLAahWgrw6dxS6ted59yB/ae3W
   55KooATHUbk/wjVhpXyVVz4yUPMJVQYS77bw18gja2vG2mD//U1v28MbA
   k+fnoCi4Jc6kt7xhKgsKFjAK2X1sYcnW4krqWP4HZyD9/xcDcXTZDKLKd
   ISOebwg+Wj2ASTGzTe9OPnYaHB4XGoLnQV8/pQL1/MO20fyeBOnhoAmji
   DH19+3ovHVd/+mE1hlaL5sXtat3t2zQj7oxQ+BtN1cW7TNB/vu9R342A3
   /1wDqK0SBpWrqX/IImY0AXrViK9ZN38X8tKXilbhQgVpT3wLQQLSdaqO+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432606255"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="432606255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929261245"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="929261245"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 23:58:22 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 23:58:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 23:58:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 23:58:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBF8i4Vf3OOb2prZQbHrMpoND0oEk9rD7W7HZpNUk6/PSVvYuyL/AEMDYrMJlUlhYt8GDiIFhD4DSxMu9/L8H5N9tsLakCNUMAMhSXxcewDWfvNAVY+V1OcWfeeK8eM+DX1zUqlx9FWfwFbCeL2vaucX/oZEHB05UcSMzki409Bw04+kspXIntE+elcaIKz8N+KWXCLb47CA46dcsnOR6FXCsAwb9wx2/QWw+kMBsp4Y7exGhn300kSZsTtTml3vNFWt81VoJAon0USUWVGL3MLBYoVLD8KHfmDDKvLV72kiXSidwCa01VHvcTnr8CuaWa6vbP5g7CbHevTCOsds7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNcnAC3LHSUWHKuVnyJCUIx9avNI+veeCKln9YlX8i8=;
 b=YHeVocQKZFPgArAbMINc/9qaUAgsK+7cohYzXpIirCeVSE96L8jVMSC6A8Ej23aKdlWZnUHVXaFEBAaoQyjlipw3X8BWmqHPvCATirT2C3Dp62JSreXcvPrTekivDXLuvsm2ajtVfpJY1jAR+CUmVTItKK6BfvQZ6PDkhXR0F5HJL8gwZrWOw/sYy0ilR03C38JVp9BfrDo4sER1f7merVRilkUfRCDcbeMx1X0UDnzbb7tlS8wAzSvcZLayfi29ZDYOZzgOjK8pONvmcGhONHZyRF4L4Lo3ugAJ75+HVgta64C+j/EHSaoBGwZK795kUKor397Q8PYrDZyGB1W9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Tue, 23 Jan
 2024 07:58:12 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Tue, 23 Jan 2024
 07:58:12 +0000
Date: Tue, 23 Jan 2024 08:58:04 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <h7cbw6x7bxx5o7vyamhacgarx5fs5rgmyttawxkrl6fgtjjqmk@naisceux4lns>
References: <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
 <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
 <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
 <227e43a1-a11a-4d49-8dde-c8b65527e926@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <227e43a1-a11a-4d49-8dde-c8b65527e926@intel.com>
X-ClientProxiedBy: VI1P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::23) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a6838a-44c5-4957-89c7-08dc1be90bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkQwliqevjACRTHDrAeCtM679JLHe/MvzAEm/23uVH+jvLgctGPdZzspXa67Kp55Npt3sOtMNgON/nqw/yltIlLoMoVeAfzCxJic8NLxf/smNHBeHFytT/H9xlC4k6OeebwbnQB0nF3FkplGNFPN9/0ClSbZMQauriWIEavXaUGMpAmqaiyfSKCNr0P/GxDhTN9inGLWZjMMSykcSHXqhiWiBCIWIxwoisFa2hcqqhfsQUrpdmafcggezhatW39htoc20N/Ied6nffphTl3HzcpvESWLU1mY8I0wh++FeyAEFxWCzJySNWVSk/xF45lTq2aR9y90qB1jiRY3bOjkmcLKmIf3uJ38OSQ0HIojFxtIImEmqPza9XbCUaJ5II6lJQdIpTZ5SX2v355c3dkzZfzaZ90I727YICrbw/nbIt/DXkeRfaVT9DlX3AkOII/KLXt2XdsmEIkWacRmLT/KmOyCCA4AhXzE3LM9s5SX9kE6cGZ6lS0o5hsamUJSLxZaE7IbPbSmdsqls0OkiPaLOW2mL6SS2egmaBYexNsyt2PDuRDXv8Om5Kb/OA12vc+C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(33716001)(6506007)(4326008)(8676002)(6512007)(53546011)(9686003)(26005)(66574015)(86362001)(6636002)(478600001)(8936002)(54906003)(6666004)(6862004)(66946007)(6486002)(82960400001)(66556008)(66476007)(38100700002)(83380400001)(316002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hXQ5pRcYplH7pL5mZ/tkaTkDNvFyT5z2JaWj2WZpys2Z4qgxtTAonlU7oc?=
 =?iso-8859-1?Q?N/Jkr/Ieu5J+3XZoOTqdqoOBhDa/zddlFKTItvwSFZbqiLIC1jYpsgeYLq?=
 =?iso-8859-1?Q?C7wyAktXNw9Ed7c435g/MCp0TodSUGpMOTeP5K2/PREczT2skPBJqBMUMv?=
 =?iso-8859-1?Q?RKvNMsggRZI6Pa3FdDH1W6Ny5pbzqI/udJJHel6lNA94tOFbR+R6KdGCGW?=
 =?iso-8859-1?Q?TEHj7pgclNLsclpGfE/bKOrFF2V9YBYpzecX1VNdR9cjE2lFOnsPAVva2E?=
 =?iso-8859-1?Q?clKNlg1UPWpM7j2ftfYv6NQD7e4IfGe4eMSk/j5zBN3F0yjLxCAq/+IOai?=
 =?iso-8859-1?Q?MY0Xymz4AGx71/cfbeNmtWCRVrVYnI1TfriHjMCiIdp2z7MP5rfgaXa/l9?=
 =?iso-8859-1?Q?kxnNOb4G3oho45RESlInqrqLgyGRi4tmn0nJiM27BgDZkho45wKYjNDfFC?=
 =?iso-8859-1?Q?3ksm6leysqwXxglOQWPGfNrq5/J69j5hm8Zh5CsjkEif/knm6Ywko+tMvH?=
 =?iso-8859-1?Q?lgaWcjOTSePI1LKfeiy8uNzLHavtXdpY4dgDOLPRtYumyNjvRzeZhTjYom?=
 =?iso-8859-1?Q?fvX0IsUPfq95qNfbhfmB/UtJEfVIrOBJACh/pP/EhAvBkUwcg0WCwZMK4e?=
 =?iso-8859-1?Q?PX9mA+YI8frd0L1U1USiziF2H29adaPSPJEIz4Qb0oONzHl5DuUnWGth3q?=
 =?iso-8859-1?Q?1E6ZNSzk/1I5/xesFHqLC9qaHQOI14+OQl1FqunU2vToIkRXMHXROzek2N?=
 =?iso-8859-1?Q?71aVJ+OkhQo6DMPl7BClH3hBTF4G6MMZn7x+sdUOx4vOV+PN17IQPaIK01?=
 =?iso-8859-1?Q?WjIiflWvx7c/TeVph1m0Ipholdb8vDcGY7g4aYFiLLx+qVRbijxwxVWAiF?=
 =?iso-8859-1?Q?Er0ADm9eG1pYql2waL3pYKHco9xzGdAEyCVPR1y0/LtHX9M/Nmp/RNr3Ka?=
 =?iso-8859-1?Q?nTkLLGAS9ugs0USR5gp907/SrsrEdEZ5VNYPA4DK5RcK4IsoAfJWEFgOoP?=
 =?iso-8859-1?Q?Ldtkyk+Mw+CZls2SBrgk2uM0asUyv9E2tpfuZL7VB7hIdPb2QQHtW1vSJl?=
 =?iso-8859-1?Q?ZQU2LxPK6eyrrlCaYSxW1BAyTmnqKAL0Or5a7e01Ey2k9+/mufxkYWB6up?=
 =?iso-8859-1?Q?ih7A2Rl4wB8PTq0qEQVsVjU7CZtMd0p8L5ZI+rsqv+dhkjmOoBDbwQ84ua?=
 =?iso-8859-1?Q?C7zg5rkepYfO97HES0lZXL4rBtnqC1AhV5OGj09xqFXCT6dMtho+uR1pd8?=
 =?iso-8859-1?Q?FHlaP0uH0AaPCSezJYV0qLIz87wBXjm41VkL8qtGGyHLQ9eQaEpMt3Ca8u?=
 =?iso-8859-1?Q?gWi0IC/agO8/kcGojBZIsHqSVWCD5TWdHQPo5cJJ1ZIINviLhu/T7Gr0QW?=
 =?iso-8859-1?Q?Ryft6GN6tcUmYw4EWuHwgZu0fktuFA4TMWY7rvXpmrKbn3slEt6rwcROJi?=
 =?iso-8859-1?Q?GV8JxYWRlD0NY3unjnjDoB5lKZApjsZKledNyNOL3bMC+ymTS9qkWHEtWZ?=
 =?iso-8859-1?Q?+t/MePhTZhbWqM6qibXx3Vk+0w7OdohUT5kgLQwuRP2ME05oD88kHYWRMg?=
 =?iso-8859-1?Q?azplF1aenMxLAKVJYPgYCr/gIS35LgaVHAo4LX03k5GAt6bsgYccgQ62pF?=
 =?iso-8859-1?Q?XAUEGetfxbsNTfT/04wrc8QS4T/LmA0Gl/HzQaD22v2Fy8NtlAuGmobHvX?=
 =?iso-8859-1?Q?SiW9kD+z667EVOoBfV8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a6838a-44c5-4957-89c7-08dc1be90bc7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 07:58:12.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWstjzKrn5ZeliESkJg/Hg4jcULjVo5XHoPOlQAoPzKmCpJP/8jbPQj0hPFc2UHNzNInFPdTwO4MG1G5X92Nv/icKzjmhfWKwthtJbvsWXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com

On 2024-01-22 at 08:32:36 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/21/2024 11:56 PM, Maciej Wieczór-Retman wrote:
>> Hi!
>> 
>> On 2024-01-19 at 08:39:31 -0800, Reinette Chatre wrote:
>>> Hi Maciej,
>>>
>>> On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
>>>> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>>>>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>>>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>>>>
>>>>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>>>>> +
>>>>>>>>>> +	/* Contiguous mask write check. */
>>>>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>
>>>>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>>>>> noncont_cat_run_test(), fails.
>>>>>>>>
>>>>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>>>>> and I believe that the test will report an error rather than failure.
>>>>>>>
>>>>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>>>>> source code of the test to understand what the test was trying to do at the time it
>>>>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>>>>> trying to do. 
>>>>>>
>>>>>> When a write_schemata() is executed the string that is being written gets
>>>>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>>>>> it would be easy for the user to figure out which one failed.
>>>>>
>>>>> It would be easy for the user the figure out if (a) it is obvious to the user
>>>>> what schema a particular write_schema() call attempted to write and (b) all the
>>>>> write_schema() calls attempt to write different schema.
>> 
>>>> As for (b) depends on what you meant. Other tests that run more than one
>>>> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
>>>> that the non-contiguous test should attempt more schematas? For example shift
>>>> the bit hole from one side to the other? I assumed one CBM with a centered bit
>>>> hole would be enough to check if non-contiguous CBM feature works properly and
>>>> more CBMs would be redundant.
>>>
>>> Let me try with an example.
>>> Scenario 1:
>>> The test has the following code:
>>> 	...
>>> 	write_schemata(..., "0xfff", ...);
>>> 	...
>>> 	write_schemata(..., "0xf0f", ...);
>>> 	...
>>>
>>> Scenario 2:
>>> The test has the following code:
>>> 	...
>>> 	write_schemata(..., "0xfff", ...);
>>> 	...
>>> 	write_schemata(..., "0xfff", ...);
>>> 	...
>>>
>>> A failure of either write_schemata() in scenario 1 will be easy to trace since 
>>> the schemata attempted is different in each case. The schemata printed by the
>>> write_schemata() error message can thus easily be connected to the specific
>>> write_schemata() call.
>>> A failure of either write_schemata() in scenario 2 is not so obvious since they
>>> both attempted the same schemata so the error message printed by write_schemata()
>>> could belong to either. 
>
>> I'm sorry to drag this thread out but I want to be sure if I'm right or are you
>> suggesting something and I missed it?
>
>Please just add a ksft_print_msg() to noncont_cat_run_test() when this
>write_schemata() fails.

My point all along was that if write_schemata() fails it already prints out all
the necessary information. I'd like to avoid adding redundant messages so please
take a look at how it looks now:

I injected write_schemata() with an error so it will take a path as if write()
failed with 'Permission denied' as a reason. Here is the output for L3
non-contiguous CAT test:

	[root@spr1 ~]# ./resctrl_tests -t L3_NONCONT_CAT
	TAP version 13
	# Pass: Check kernel supports resctrl filesystem
	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
	# resctrl filesystem not mounted
	# dmesg: [   18.579861] resctrl: L3 allocation detected
	# dmesg: [   18.590395] resctrl: L2 allocation detected
	# dmesg: [   18.595181] resctrl: MB allocation detected
	# dmesg: [   18.599963] resctrl: L3 monitoring detected
	1..1
	# Starting L3_NONCONT_CAT test ...
	# Mounting resctrl to "/sys/fs/resctrl"
	# Write schema "L3:0=ff" to resctrl FS # write() failed : Permission denied
	not ok 1 L3_NONCONT_CAT: test
	# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Of course if you still think adding a ksft_print_msg() there would be meaningful
I'll try to write a sensible message. But I hope you can see what I meant when I
wrote that the user could already easily see what failed.

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

