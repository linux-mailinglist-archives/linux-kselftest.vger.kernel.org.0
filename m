Return-Path: <linux-kselftest+bounces-6396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68687F126
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9822845BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A12557E;
	Mon, 18 Mar 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxRtG4LF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD41862C;
	Mon, 18 Mar 2024 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793972; cv=fail; b=BKzzBfmNMhuwCxLAmZfxwKnfQDBAdiFy3HDXkpKvDxReJyFqIpycg7VmfDYwArh6gcLZkRvyi3daMtyXzjVuh6PbT1KABqA8u4zEP7fkGL6ikJ+rvb85Pw0gwilE3k5Y6kqqjFjcr+Qc0dBKemfv/MnY7JW5KhbeO/UtfcXl5y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793972; c=relaxed/simple;
	bh=ogwyk3rl74+l5zuT4b1lgn3hHuk6F7MVXUVTSpUOxdk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WKMvTNU8aX4IxBWo9/WjWawpVe1gmVusCfTV0c+Bj/t3uwGfT5HjOdQ9Bvp0iZQcLo9yMoEC1lAvtvpwbcYg4P1O5jzdhuAbFljT5hn70cdF+PA0dFlvY6NNL67oH4lhCk+fB63rag5bv5HFaRwKeCdgvXVyghSxc1pfMJMx2zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxRtG4LF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710793971; x=1742329971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogwyk3rl74+l5zuT4b1lgn3hHuk6F7MVXUVTSpUOxdk=;
  b=VxRtG4LFhV7aSSmP6UAa4TXMGQWR/PpIxZjkEIvQrRLqqtcu1dM7dQii
   RKxN4pzqgdqh6TafPBC9hIvPdVc+wpJlIhYQeu4SLfGKcHKiKRapgk7i6
   5t+sE0bA7VY9ClEQsT8PuYlx7iyn/fmjBNv22YAPYXYakPg3Zti0Pc1hf
   NXYQ04L9Gtmdrc0MVsWXI8l1iwqoBT8Ov1rURsd8bsAySgoiALmelm8Yl
   pI81N73+dW1vGKkdPsMpbh8d+4jnOqkfnvJ5toGnwLIm3RhonLkQtMP4C
   P+KV+YFtjI117pR2hgly0UEbM6ZAPFvyeqeZp/uDGSGjXxPuJLlfWxgXi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5813509"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5813509"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13555116"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 13:32:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:32:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:32:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 13:32:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 13:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvWYmmHb+KfKGqxcKlVJ/kJgT0XFaHjX4nPIokUV2EAID2JYKuIk7hngKfmSv27XF6QQK1Aw41PGb5B7BXxIGCLD2ceaZpPI3tIwksvzVRcImFAPuMUaSeLOKJcBt4TF47PWUQVPGqnX9Din6f7J/bSEXq8rQ9hnsZOXa0qs/xQHDJMgstT1AqIzpxTGscj676WVo3ozML0z9qQeUMzehIPszbWecjZyl7aU1dm+dhQh9mGdkic5EdUMsIoFrEo+1nrbS+kpv8j0Cn1sgHOSGGN2UEslPGTHHHXcCZ9G7LR6uqwK2SyD9R40tEB+nHAbKLKufSNapOkt+W9N9uXeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWtRkpZuFP6CJDPLEC2aGwpCestwKSGUNNtlcHRDX+A=;
 b=EOIVjo/4eq/uJ5g/cpk2fptaIyguJZFhhOKq+f2aqL3sqfmv3jnGqpPPGKzgokUP3MpUJlD7CYFJlC85Bf8kiE2+rRXSui7SuFugUsES/XkJnE0rlaD897/6aRY2zzi+EleOwPeG3oadJ4eZeSXwvUKeZ+hl/5XgosGQ+JmPCC0FnJEyUtWRn+pp3oXK+RWI/yMDEv5NuVMTpYGH8+iYcKS1G0tk9UaVzJmtFLlGbQ2RtSw3lrNa77imMpD6PI+gshp5odmBD31zSkjRZp2YrVhdhoNGdz+m1wETTTI+mZs/FADcoAZasA6eKrSLcr4RbcJz9aqp6pjpzoeuiHNzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 20:32:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 20:32:45 +0000
Message-ID: <6948784d-6a20-435a-8781-30f324bed472@intel.com>
Date: Mon, 18 Mar 2024 13:32:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4570:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3TO/AtOHYuZx5jwoFh48SwQvfQ0XIT9UK82nd9ALL6WShIIPH1JzWp3IqL85GFGRVNHwy1ZrrziOMjkr8hhARKDeI6ODXxWhRMzaClszH+OAFxloKXm75pfiLdAwu8rub4V5slb7tmp2m3we3tAiRpRNmTrXeT+3ue+4EzfaXakXVqXOlQdm3mFK3eO7S7OI4le5tFx66VchOM4omHNMrZg9N9rsb0kIrr18YoduRd0ZnbrJFVqGjgJxioB7ZZcAlG08K8LddmCReiRhrB7d9kuDe5Clx4KW931NFCuwsFPqw1kCENUU92YNfPT5yJPZbSGrfhEu6AwsF3Z9dWRpkOWoSQYkPlFJev99OPUGe3Y+eUVsvpUwBtw5Tktc9FaviyV7V0rRSVYHWwkmJjyHtWupPwALueTSXhKVUyJ8svAzTwwNl0E42B1lr1T/q0WGjtvu5wh/BuKsoenjB2knnc+PY4YbvqHpb5BbJl4bxMQotKEkEDWtEKejCCZEeFgaxdRmUgU5TI3mRtkbTPryH4DyY+0NNMM/Vprm0WE0foGkkDKdo8tsPS8RlmR2GJTdp/5niQyo+SdtvbQjXDrKeZ3W8EUFv2W0fWT8MEk9CCkwvVNGSfQbpdUQK8mpqnX33rh4ohWdp/AJi7nx7ZkuoTNHr3rigsC/YckzdC7lG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRjNW93NUF3QkpqdGRpb2Rab1hKS2RCTzFVdDF5YTk0azI0dFZJWEtGcUpI?=
 =?utf-8?B?UENVNFM5aWZsbTl1SUpNeUd1Z0JYYnA3SDc1ZmwzMmpyWVpqbFVhUzV0UG9U?=
 =?utf-8?B?VnBuOUR2QmJ3RkRWb1pFaDl4eTQwWDBIdFdOQ1dUTThEeFBmeS9qa0ZlUmRI?=
 =?utf-8?B?d29pTTdsM0JZR3UwRW13SEZWR3RGSGhVeFBUc0IrNFNaYS9RSFhEcXNJMkph?=
 =?utf-8?B?TERuMG5ybVRPdzIzV0k4YTVpcTdpZGZJZktMV010ZUZNM2U3MzFNL2FhT0dV?=
 =?utf-8?B?Yk1zZmFRa0FFME96OHc3RXVWRjJmZ3ZycVBvQUprcVNYOHhKKy9udUlQemNQ?=
 =?utf-8?B?U3lDQ0Z6c2RwcjFJS2o3dDZ6YUxtZXFxM0w3aEt6SXA5OGVZK1diV1J2ZFhi?=
 =?utf-8?B?VVdwVy9SUTJWYjJOYktUT1NqRHVURHV3UGlValBISmJmRDRPMWFmYzQ4VzE2?=
 =?utf-8?B?TWV2eHM2ZnpKaEIzcjZya2lXZG9RalVaWWp2c25pRW1BNlZ6SmdvSExJTk5p?=
 =?utf-8?B?MSs5SUxIdjNMT09qTVErWFdWUldTcGk3ckplN3RlRk9aSWpCZ3dWKzBxWndK?=
 =?utf-8?B?L01vYlg1WG5JTnU2Z1NNSW1wNXFHK2pJeDgzQmRIMHZ4ODNDSldiTzBYZk5S?=
 =?utf-8?B?dG12ZzQ2SjNrOHljQWZQQlNwQktyNGF0OFpYc2twaGx2SVhoY0l5VktFNHJX?=
 =?utf-8?B?OE9jbFlqRFVyRVdNSDRKU1l6UnNYc2QyZU5ITVVQMk1ZZHVVb3B1VFFyNGRG?=
 =?utf-8?B?OHlhYVdyYVdKRVpoeVd5NFFCbTlRTXR4cEk0YnlmUHp5aW1KT0hKeHEwWThX?=
 =?utf-8?B?MDJwRE5LQWFhZGp0ZDRMZ1poU2hHN1IxMG5MekpiMXlWTHoyNVdYZGM0NGo0?=
 =?utf-8?B?Q3ZHTE9wUEZUWHBTUUpzOHZpS2M5NzdNeER6TTYza0dXQjF2MHp0c2FpZGUw?=
 =?utf-8?B?OTZjQmk0c0p0cWlwV25uUFVlU3FpN0p5bFVWc1lyYkRNVFVLZG1ZZkNTaXF4?=
 =?utf-8?B?cGNTTjZ3QTl3TFFqVHlRSFN0djJvdGN2aEQvVVdRVHhpTk1Va0RaMnYrRS9V?=
 =?utf-8?B?US9BeS9VVWs0dldDek5BQWFUNm0yRVFMY1B6WFl6dUsza1NDWkV3YmdTOFZn?=
 =?utf-8?B?aEl4Qjh6aittSUp2NlBCWFJETzhydnQ1bGYvd1pBZ05OV3FFa3lDOGFmQWxs?=
 =?utf-8?B?MUJRdExvVytKUGtZK21ONFozMGZCMlV0SEZBMDlOZy9JdUFwVXhhWERha0c4?=
 =?utf-8?B?RXB0SUhzT3QrdnV0RlB6QXJocWR1aDhDcmxNb3lNVjliU1RPL2N2V3FnakdH?=
 =?utf-8?B?NHFxTDV5NGtRbEdhcm5OSWRIeG5LVVBVQndESURhc2NJZ1N0SmZzUWo1dTNC?=
 =?utf-8?B?ME5vMWZ2SHZ3SXk2aFBMWVJ0OUsrYVY5MVlEcjBtcldQeWJFSVJwQ0VNd09r?=
 =?utf-8?B?VTFVb0puYms3T1UwL0NBNDQ5Tit3NG1LWXZueXBNRWphY3ZuazJ2WFhCUkh6?=
 =?utf-8?B?cFBrYlMrYWFKRFBxS3hMaWlkdTg4OFhNanJqM251UWVlMXljMUJJczYwN29m?=
 =?utf-8?B?WXpENmxVSmk3Q3RsM09NVmJISU5zN25MMmdxdEU0VkhnQ2xoZDhkamRISE8w?=
 =?utf-8?B?SGJ5UTEvVFUvMlQwbCtCR2tTckltaTNmOE1YSk5tSXJIR1dtZjRmaGppVVBn?=
 =?utf-8?B?ZWNIL0hBSFQrcFpJcjQ0K1Q5eEtmR0t6VXZkSFdUcUFLMHlSQ2NVNDhhd0FQ?=
 =?utf-8?B?NU5MUlJwTUgwQlZtK3lIZHFqWjl0b0hZdzMyZEpSY1BOVjNjT0d4MVc5a1Ay?=
 =?utf-8?B?eDE2NU94VWlPSnB6TFY2Yi9iSWsvcHFmL21ETkJDZTFOdWJDck0xZHpIRm5L?=
 =?utf-8?B?UHJxajM2clB1OHAzOFNzMzVnditpanlvcnNYV0NNdzNUYmRTUURWTmJVcHdE?=
 =?utf-8?B?K3J3RmRDekZUSmRvMTN2b25ERVZpUWF3WkxBTDRERytCbndCUjlqdTBlWnFl?=
 =?utf-8?B?Mkw5aDZxbHE0TVhuRFI1elZoc0JzMzJFbThrVlRNM2tGOHdTdDd2YzhpLzdt?=
 =?utf-8?B?YldpeGtCN0hLdWV5QVF6bkpZMnQxZUV5Qzk2RS9Bam5va1R2NHFaVUZxUDFl?=
 =?utf-8?B?N0VnK3BHcXc2RkJkZ3QzU0xkc21RNVlid0JIRTIzTGtMbzNQaEJ6RVBvc1J4?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de2439db-a7da-4141-3409-08dc478a91c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:32:45.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SAccSjiLdcaFAddMH1gAxFcUDgETuZNuJ2B2g4wxya0XiKU2c0IYWt4BOWBVvMgNKeQxYX5VhjfqzWdITE1TW2zAqMeD3I0o/7WyiI3pQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com

Hi Tony,

On 3/18/2024 12:34 PM, Luck, Tony wrote:
>>>> While that is in some ways a more accurate view, it breaks a lot of
>>>> legacy monitoring applications that expect the "L3" names.
>>>
>>> True - but the behaviour is different from a non SNC system, if this software can read the
>>> file - but goes wrong because the contents of the file represent something different, its
>>> still broken.
>>
>> This is a good point. There is also /sys/fs/resctrl/info/L3_MON to consider and trying to think
>> what to do about that makes me go in circles about when user space may expect resctrl to indicate
>> the resource and when user space may expect resctrl to indicate the scope. For example,
>> /sys/fs/resctrl/mon_data/mon_L3_00 contains files with data that monitor the
>> "L3" _resource_, no? If we change that to /sys/fs/resctrl/mon_data/mon_NODE_00 then it
>> switches the meaning of the middle term to be "scope" while it still contains the monitoring
>> data of the "L3" resource. So does that mean user space would need to rely on
>> /sys/fs/resctrl/info/L3_MON to obtain the information about which monitoring files
>> (/sys/fs/resctrl/info/L3_MON/mon_features) are related to the particular resource and then
>> match those filenames with the filenames in /sys/fs/resctrl/mon_data/mon_NODE_00 to know
>> which resource it applies to and learn from the directory name what scope measurement is at?
> 
> Reinette,
> 
> It's both a wave and a particle, depending on the observer.
> 
> In SNC systems resources on each socket are divided into 2, 3, 4 nodes. But the
> division is complicated. Memory and CPU cores are easy. They are each assigned
> to an SNC node. The cache is more complicated. The hash function for memory
> address to cache index is the part that is SNC aware. So memory on SNC node1
> will allocate in the cache indices assigned to SNC node1. But that function has to
> be independent of which CPU is doing the access. That's why I keep mentioning
> "well behaved NUMA applications when talking about SNC.
> 
> So the resctrl monitoring operations still work on the L3 cache, but in SNC mode
> they work on a portion of the L3 cache. As long as all accesses are NUMA local you
> can think of the cache as partitioned between the SNC nodes.
> 
> But not everything is well behaved from a NUMA perspective. It would be misleading
> to describe the occupancy and bandwidth as belonging to an SNC node.
> 
> It's also a bit misleading to describe in terms of an L3 cache instance. But doing
> so doesn't require application changes.

What is the use case for needing to expose the individual cluster counts? What if
resctrl just summed the cluster counts and presented the data as before - per L3
cache instance? I doubt that resctrl would be what applications would use to verify
whether they are "well behaved" wrt NUMA.

Reinette


