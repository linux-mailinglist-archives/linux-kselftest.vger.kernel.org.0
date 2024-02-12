Return-Path: <linux-kselftest+bounces-4513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87E8519D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DE9288019
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E83D556;
	Mon, 12 Feb 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbWlQxe9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427333FE58;
	Mon, 12 Feb 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756084; cv=fail; b=F8aXkzpD95MLuySeEM1Xc+SD5WnOgfJAeVrLBWtpf35KEk1YAmbtsUaEFk5EVTQXpwLZtW7xL2iTrb6A21vn9bTD3xI2XwxudByeVmQYBVOlavWOpqJib0nvVyzjHKQEAY22vIS9iVO7ZwyTsy03nFq86k1Wa2CKa8e1l43L/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756084; c=relaxed/simple;
	bh=zqGTrrdgT99m4hY7hJevzBBg2TtZSaCmtq+SdxZrvWY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1fx7MAe3OgGshRMjV6vh5eouXTBAyzJn2grVH+JMeODHDgzpqrtegMw0m/DRSwuEz8PiTp13SzDgqqFLig6q3vA4slIbMIjT7w71Uw4gUXvu/kdxpZVl1z1W9eZcGtFXLz2UBZemlVWbcn6UFXI9IamA95dUZiMCi5Ktlg76y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbWlQxe9; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756083; x=1739292083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zqGTrrdgT99m4hY7hJevzBBg2TtZSaCmtq+SdxZrvWY=;
  b=bbWlQxe9p9E0Ru0UPZVWYOBeN1W8FHT3TqDnYaOpU4HPAk9efMUACeJ6
   KMVJmb+TZGX2q7cBg4zfdECmZamqWWLqm1ZbdpLdWyD6UOpwmV1OPi/v5
   TDvSlckOmNhws8NXWHkx6gl++5lnKAz96y8vm7QRxZ99ydDdIg3rz1J8d
   XyzSdjhUp+y4uoNumXeKM1+ZYTVE4JXKTKZt9/Bnq4vRP7ubWu2B6AKUK
   nCMhnob44VlDs0zEeRbN8OV1U/tiRkEm3va2HbvvB/VaCBYoe/2glpHWY
   atqW4+aqg6WlE5ix62OHdUS8l4qBbXjpnIOTgRUYWJUo+4tkvXFJX2V1S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396173327"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="396173327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:41:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911538034"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911538034"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 08:41:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:41:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:41:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 08:41:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 08:41:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWUrN/TRvTvhozrrrhgcuBos9mgu0fSJx+q1BiKu51jggsKxisQgmZzTvltGOtx8Y0I7Oxtvyg+qi0B2FSNYmYDzYnzPaQWVGD7FRUn2D98nC3JJnXK0zNwsjDMpRdALAyzBf2+yU/qxY63P1fhj+3Un1pKTngvIAkehQlNgwDUAwq8PbyXKt9XTMed7MJTNWbGNihiUlgvKX32TMj5iS0EnZDlblU7DJN2DGxqbjef8iDxMPSkFqjbv3GrvKEFUrmYdbi6daSyRVWJGlefbwfOOGLvrjhlIo8OYNfSRBwNGKoCKU+on31DiDP/5KZyUzCp3YWeMFyMTAprY7thaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAsbQWv0R/HjFClU5koCso0BOvJbvSMsdKBHR576gVw=;
 b=fRtgiQLHx1FGu8MivWY0n/KzpUU3ZN7bLj8iAcqmuqgyfhsHV3a5zWbJAGhZqtNolyMMh19X9Y/ZPCoZFNOkpDx7y5oK3eXscdBOojjyxueZExEAqzx51reK7GGd4z3W8kiRvNZNTuaVmSoyhJKXq6XF24Ud/lX519g2YJajf5ehTLRE7cqKiDayvxP/x+nFH2hBO1yuh5ChzsU2VNwZIgP1fMIbGRfsPv59lzeZWjNDB0VvUMivtrxaecNY1NzunT4akfhozKHQOUskFd3OsNQP350QImjxC49Vs51xvoI6+VBS7BQ+fLEWOrReAyzlY99vl6GuwzIqNB19+hY0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:41:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Mon, 12 Feb 2024
 16:41:19 +0000
Message-ID: <6da6439b-5ced-4c57-b48f-c0fa33f4d524@intel.com>
Date: Mon, 12 Feb 2024 08:41:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
 <b63354ab-458a-46a5-a80a-971845f1de9d@intel.com>
 <gybtxxilnj3wychwz5cdzltwzhhazx2dvzkyk7r3afqnkilja3@e3btzsz6odc3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <gybtxxilnj3wychwz5cdzltwzhhazx2dvzkyk7r3afqnkilja3@e3btzsz6odc3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3f66f0-61b9-48e7-6920-08dc2be97027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVkeUVdlhBlKSToNR3+tisMviggVi1f0IIn0nslaA8hyX3UeHb3hxYJe8VtzqT2jFAwhLrbzkJ+tcML1RAHuG7Xu6WXaRjhb2qb8ChPyqd1Q45gJEL0FSSYbtW8AQVok6/EQT6FbPQE0e/+e/8+0hVx3d43wj7YkE4ekuXJpgPC01nf4LRVAx9u5axkdDym/5BC/Jq2o+7NdvwD/Jq4BBbNmbxcLpe3q9K+jPvD20qTY6uaOl1tGiKaqNO3hcotkc9Ses/sNTxzJIi6W+2p63MT0/tt76Ha/PrlST4N2OpTDea9Wzja5aqgUzdWdzeAL6hXo7qYYtAvFy1RYDFRlHnUgxjlke9zI8UKUgShMujhnHUb3S+WSq3AGcLCcc1l+dVQ0S54avWRKbF1I7Vq1BYvNflHWd0NeeOpsacqOTeFHwOObTw8K3sVlfIz1s+7coWjJ2cJQY0s2aSIbk2P6zG06zSGBFAaryWJMCN6uGenUcHRYII3vN948hlkA20d01AzaC9XMRxmQo/PiFjdsAvj931BPp8RE8Tmu3B7tYbW9Z3YshKYmTeHskM7/vPYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(4326008)(4744005)(8676002)(44832011)(5660300002)(2906002)(6862004)(2616005)(38100700002)(36756003)(82960400001)(31696002)(86362001)(26005)(66476007)(66556008)(66946007)(6636002)(316002)(37006003)(6506007)(53546011)(6666004)(6486002)(478600001)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEkvU1loYnBvQWV1TXhiaDArbWdNbjdRMHpla2luNUM0Y2ttNjZZMHMwWmZV?=
 =?utf-8?B?ZGozOUNEQkQyTkpCbkhjNnhtRGtJUlF1Y053MC8xQUxoM0FxTnFRQXF1VUsv?=
 =?utf-8?B?aStZaWhzeXBCa0ttNkpLdVVrRmhmaVdmUlNnOWRxaW5vcTJLNkp2d3ZYWGJ1?=
 =?utf-8?B?RUs4WjJMc1lVQzNrbmRrRjBlbkVqUmtHMVpwNGhkWGJUazZ2akl3ZU4xUlBK?=
 =?utf-8?B?VTBYNlFQOFdEUlE3ZFU5S3pPb3l2NU9OS2ljUWxMN2RubUhUMDk4NFJJTlN1?=
 =?utf-8?B?bE5VQUNzNjZ1eWFCRjJ4N0ZnMjVqVGFCbW5TTEsyWlQwRkJhRzhkZ3UxNWh4?=
 =?utf-8?B?bDRKRTdGUXdxTjlaMTRsNTJJeEZ0S1hYSjR1MFlKSGpjS1RSb2RxVmVKQXQx?=
 =?utf-8?B?VytSYUJyY1U2TmhpUEszOUJlTCtPYjNYcDMrUjhEQ3MrSjdwK0tXcXJqQlkv?=
 =?utf-8?B?ZnBUajBBMHZCaS9qMFRkTkNpalM0WHN0RXB2NDVJVjVyQ3JXVW9LZzhDSVhH?=
 =?utf-8?B?WGNCV1NXc1hSbWFUcllGalQ3STh1YldiQlM0UkNVcG80U1Nab0RuZjhXbVlr?=
 =?utf-8?B?b3ExNExpRWd4Q0RROW1wY0o3RWFhRURPNVpwZjhwZmhBZkRCcS82aFcyNWJI?=
 =?utf-8?B?VlNZUUZsRHZNZXB1c1dFL2lCSDBHUzNMMkxoQlprNks2RDgxc3pWbG8xYkNW?=
 =?utf-8?B?VU14RnhzZkxPL0poVFBWZmFNb3VWNy8xZ2dUczVzTzBIZHBXUEc2WjlTOTdm?=
 =?utf-8?B?b0dHdzdpSythUmpVcnRKMDdyQ1pHeGp6MGdmdnNXVmtvVVlzVC9pSTMwcnFp?=
 =?utf-8?B?amo5aGNldGJVWkYvNjh2d2NQQS85NUVBNGRtQWtzR21JTElwWHVmazJxSmll?=
 =?utf-8?B?Q0d3d25rL1hLUDdHbnRkMzhTeFJiTFd4SHlrdTRqVUdxTVRseTlzelFVUDYy?=
 =?utf-8?B?WU10SDlucW1GekljbEJ3SDRMT3F0ZGRtcG04bFRDdlltc1dXc2p1cG1TbXFi?=
 =?utf-8?B?Ny9RM1dtajhUcTVaYWZLWVBIbXVXVVhaK0FEV2RiNnpGbjExV3lpbFJMekFn?=
 =?utf-8?B?UGJLWlNuaGR6eElKQnFWODB5Z1VaekV1ZVNhRkQwY0M2TUMzMlZUQmhVVlAv?=
 =?utf-8?B?b2VqUjNyZTIxR0xDdHVzWUFMSUdXRGNmK1RuY1dpT0V5eGNUeEFnSE8vRUtK?=
 =?utf-8?B?WGRaSmx1OEFkc1dhem8rSUY4dlVhVFpib3pyWG5saTFkZHdadkpob2lkcWJW?=
 =?utf-8?B?TjNvWjlrbmJwZ0VGRVZHamhNM01RTUR0ZFVVbkwwS2xicXI2SlJPWkYwSzZj?=
 =?utf-8?B?R2NMM09Ma2gzMStYZ2RETWprYi9LMXAxTXRTOWtheEhIbVdRQmlKcjMyMldr?=
 =?utf-8?B?RFdzakZ3Z2dUVm1EVnhIYkdFcXFSdm1MWEI4cGVMR1VaYnB6ZzU2bGZrVUM0?=
 =?utf-8?B?YkdsOXNzMll1b0V2NFFsUEppSFhIRnlaTDR0VkY3TEJJaG1LZ0tISGFPVlgx?=
 =?utf-8?B?MmVrR3NvdlNEamdpMlVJbFRadGZLeG5STFhSWDNLb3o0SEc0TjJDdGdtNmxv?=
 =?utf-8?B?WFFLVVdBaWxMUzFnZjhQYXRZQXMyQjdabThXd1BFSVBucW51MHBBWURJKzFX?=
 =?utf-8?B?NGdNUUdvNnRPMG96Zy9hUllGMkpwSnNsZU1TTDUrZ3JTb0RFZ3hDL3lQRFBS?=
 =?utf-8?B?WFdoTEpJKzF2N2ZZalVtejhPNUxWTFdLNFFrVEE5YzRPOGZwRUZqWkJOLzE1?=
 =?utf-8?B?UlVJWU5QTk9mMkRyWFhkbm1BSE4vNnlaNllhWS9GQXArMWprUkMrbzkvYW9J?=
 =?utf-8?B?S1N3UjREWWJrc0JIZlB6NTRMSW5ZVndQSGUxNU0xQllrWXYxRlBWemFpMW5E?=
 =?utf-8?B?OS9zZUIvZlk4QjFwS2FKb2tvZzgyeGdSRTBzL3dVQytJRExpd21RRmxFUkl5?=
 =?utf-8?B?UG9pMjQxeXk0bnpvOW13VEVFOVRDUjk1aGNRakMwU0ZGcyszLzgxWmdrZElB?=
 =?utf-8?B?STlmVHZZb1pZcGwzWTIwRUxFRUlrY21jOXJZb05FWW5WcTVLa3BkTThzZVNv?=
 =?utf-8?B?bktmbGJMdEF2OVo3cFB5cEwwTjB4ZngybEFUOE5RL25sa0FRWkV3SzBPd3Ni?=
 =?utf-8?B?U0NHVjZrMXpiWFQycytXVDFDZmNYRlZMRm1tMVFzZDNqRGFGdWNLclZmR0R6?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3f66f0-61b9-48e7-6920-08dc2be97027
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:41:19.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzBuQKyFgphZ8t2rvihC2dv2zcIJsHpZYCRAgFvF49vYulXbmSpBUQ/YJXgha2eBb4xkjNZ0wIxwyHOayCGCn11GVOOfrehtCAsOV+cad1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/11/2024 11:38 PM, Maciej Wieczor-Retman wrote:
> Sure, I guess I could make the check 'if (bit_center < 3)' to also check if the
> full_cache_mask isn't too short for some reason (since later 2 is substracted
> from bit_center for the 'hole' bit shift).

Thank you.
 
> Or would this need some comment as well (why exactly the '3' is there, maybe
> write something about about the minimal full_cache_mask length for this test)?

The use of "Or" and "as well" makes it unclear what you propose. I do
think the check in addition to a comment will be helpful.

Thank you.

Reinette

