Return-Path: <linux-kselftest+bounces-6443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ECC880A75
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 05:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FF81C2197B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 04:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D56125CE;
	Wed, 20 Mar 2024 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLws0lVi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3A125AC;
	Wed, 20 Mar 2024 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910260; cv=fail; b=ASgIJWUMn7ujRI9dAAekgrJVJ6x9pqHSyDoKgtv1R/bCaqVyRNq9oMzuZLkm2qf5VI06zOTTFrm9q3mIn4qHqAf3Vv+9oxM/s14+TfyM4TPEPPCHJqZEUR4ZdLSPDD3Jk1XtuZ7EONZySk15I0WH8wYGr2Nr72mJJTY29AIaLCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910260; c=relaxed/simple;
	bh=nCJUujth8TaiNNRp1ku2qrb7Y8aLk4E+fd1sglUYtp8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDGa7lWWdt66ZbiZ/FpCqEgdGaPfcEsuthAOUNtENbedWKP0w5oI/eTmXmgg9Ihz5+V5Ye39hOhXJ6JZ3DUcPY1efQwN/bHRaKjy8UWT4e/dEj7ZU0RmUaKl7743vbT7r+MRbizhE0eG1wrHnsqtSOf5dhIWnlGCq7CxtS92G48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLws0lVi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710910258; x=1742446258;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nCJUujth8TaiNNRp1ku2qrb7Y8aLk4E+fd1sglUYtp8=;
  b=nLws0lVisWILmqfwJadiWISHnmuA75KYeO/r9cEZdhg18vdhOPlBQdoo
   czRWC7f/C1EBWqJMCiw+/mJsGSBPjJ5B2S0YrxbtvJ1LxvVzPKBzuUrn3
   XJU1Jlyio1FsctaIgRKeiLQp6xitvmNg2VgrOTNzInCxaNzQ62Ta8uvpH
   215LZBQYiKCNIcfe327WOC+eEpfeu5o3uzVAmmSIkUA2JrygM24pZgzK9
   RpQ/9vkxGF5ap1svfvplIoMte7e8wBvTj6BxLQxSl4WToVrmmWxdnFQzI
   efXSsv8CtF6c9SKbBuThS99uJOnBULsms6GWO39d2/nSSUFiYXsfF7Uv3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5663193"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5663193"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 21:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="18489980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 21:50:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:50:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:50:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 21:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtSUFxF1qxM0S7oVksEvpPyZWVRPDHm4zjWHTioCltuSVVeE6sL70jOeR+0d6GgNdLtUhYqV18ZJQzaPgj7/axTJ7Xm2CSEukHBI7AXE9lWBYnQb46kKF5g7IreKLdr7bj2CVQOdjSIiset+6v94CD/BNuYG0UueDLNe29sjTYbcZKzh5xCF7fMij82xRKR2wBDc82vJD6QU2PbQWyZJc1iSXT6zJiboKhRcib0rw4wRHagUx9X4gFZfy5tu8maE416V1XDyVtqRRw4XwHV2lfWUWE7xGft1HgLuneL2PQAD8jxsx5nLVD5NYGHlPxkxQu8byaNGcrRcdaR0JDI7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT6csfUe4jkgzOttH6S/F+xzVwdTyVzVP6fCZc/FHWc=;
 b=WTTi+eyNviDJzv+1j+l+iSVe6VMi9YnvW4gijvPlm64iYe6iqWdySbi7csSz7Bb7zaaTI700mQYZbgTeI0cTUQhjcEvVAfLMoRuL9cNjN3RFSK4rnpnHDVuuKCkBG/5G7+uX5z9+iFrK0EuerP0/+DgeWjHh4wh/0nWp4GfZOv8gH9SVFhA0E1BTLFyggTXTFvnFdnikor5htsMyH5fzMVPjsbRYYkXjgU7WJyJ3DhMjiDcfOywzo7hLK7CkbhooSoTXNVJvDSRCorxaNAIGECxj0acWUmz9ZKqCAHJt+9/nB427Amcxc1YDf97S67vIt1fZloDOXZd0soA2E8RCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7863.namprd11.prod.outlook.com (2603:10b6:208:40c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 20 Mar
 2024 04:50:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Wed, 20 Mar 2024
 04:50:54 +0000
Message-ID: <832ec5e1-db5c-4123-8768-39ba9e6cca82@intel.com>
Date: Tue, 19 Mar 2024 21:50:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] selftests/resctrl: Convert get_mem_bw_imc() fd
 close to for loop
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-2-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240311135230.7007-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e9d42a-0e42-4613-a5a9-08dc489952f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbzRfdPa3X7Ayuvy5Ndy0waLoS64SouX0WntjksqXhYd7okfUmauHhKE37VD7I474pbOA41X+BlS4PfMdOdiiSdEyOuR+mD6NZK5h6t3SlNFIGRCorxLieGb/Ch9jx2StOG3QgcBWsGOLUXU5SMzrBXWhEky/V5Vem8c6oHLC+rDgAudQ6+nrJC4nheStgBY4HPmeeJDcb5AuCF6SAhdsUL3YoR58VZXvgRvHZZrC2oeUVuup7B+OG2zovf4gZu2TeCStJRXywvSFHgy0PabtImnkis43P2d+LRz9+LECW86YiJNFOs6fIFLjNvQ1qgKrxn3L7Cuk1nHX0fxWNwyNLMAhpx6DL+WsIVXHWW302GBlOZ4N/CGvTOXDWZ9hVgpCgTq35A57YrFD8kW9UoeO3S+eSnCB5HOi09woVfhSKIiV0nptlSxeH3caXApf5Wg5rNdWN/IPBrCTdRgQ3sBUAX2w7Wa9vWKuStzFSPsdwXCYi/uAme84F0RmZPIGjCdravN1nfTTlxeVHWfNcqVEqhBI6U1s4u71MqGWJ+our59lpJU+Ttt+/yzT+4QjtjVhGjE9l/4hQEP0BlQP3GnkL6rMs8SomqEhuYmRbd6ilSOQYtUqCWlPk+AnCK/gBPim182ym2y9GpBtH0KIJong/I6khQeo1YF+Dm40TiPWvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9RVXY5MnFZaHhvai9xQWZWYWRUclVvQ2FzUjlnS1J2bzF0YnhzSDZydnlq?=
 =?utf-8?B?T0I0V29FbzhFa08zT0ZDU0ZZMkU3Qm56SGVVTjFId3RlaUJNUGdKNTUxVFY5?=
 =?utf-8?B?UlVJVlJNcEI2WlZJVFNwTktkNVphb3ZlQ2RWZTBVTWtiQjVvQ29WTXRXOWpW?=
 =?utf-8?B?bG1iMUtGQTNOQWN0emZ5M2pDM0RTTjJNcEc4YWdPZTZmUjdiakdVcjNETnBz?=
 =?utf-8?B?cVgwUkdKV3FVYVVGbTZwcXM1aFU0c0FjcDRiUUZCc1JVNWxuYmtSTTU4UUI5?=
 =?utf-8?B?ODhieGZhczNvTnBTZnNNbXZzSVlQOVZ6M3hvcmN0eDNEb3VxY0xDdkJ4eTFT?=
 =?utf-8?B?dmJqV014aTRDVFY5NkplR3NWV2NGQWh6dGY3NURTdGsrdS9pZ1dLeW9UTWEv?=
 =?utf-8?B?Ny9ZWGhOdlFLQ0lkZkh3QS9Lb1hnbUF2S2c3RS9zdnQwa0JPQjdMaDZuZWxO?=
 =?utf-8?B?WjJocTlZclVtdGI1Sm54cXF1WVdUamh5Rkx0R09ER0p2K3djdVVUNVNJbThQ?=
 =?utf-8?B?b0ZXRFZPMWtSV3o1OGtHOEp4S1VDcDd2aGsrR014eFFUZHJtZHZnTTlwaVU1?=
 =?utf-8?B?VENjK3pCS0JycFJzR0JQMHNuYnB1YkxzNWNZZm4rdUExZkJ2S04wNHZoMWR1?=
 =?utf-8?B?SGpzQlVZUW5PcW0xa2xETHhJS1Y4YW1DWEVEWU8vbXJKWHNJcS81VWFKbUwz?=
 =?utf-8?B?NzdjZUtZQlFrUUJrOVluRmRmOHpDZnM5N1hPSitXRDNMTER1VVh1Y0p6aklP?=
 =?utf-8?B?T0RHWnh1WFZuMkJSenZrbzNHejlZR3dMcXgwQW9tcTNWaVlPS29QVXR3S1ZS?=
 =?utf-8?B?VnZEQ1YzelB3Y3FnT1pJUGRiK2s4bU1kRmZFT1FjQlRHdVNVWTNUd0pTT2NY?=
 =?utf-8?B?ZDRuOXkvYmRWdE0wZ2Z6TlJmN2lIeTRCWE9EdUc4SnBlRmZqZlJJT21SRXRp?=
 =?utf-8?B?cmJTWW5zUFpFYnpHRWFTcWx0MitTRlN1ZktlYXhCajRydjZ5bmNSdDFnK3Iw?=
 =?utf-8?B?MXdSL2hYbmpxTmoxKzlmYUNXN0g1VGZaNW1WRXhTTFJsb0hWcENtdmFwZ0Y4?=
 =?utf-8?B?RG4rY2VUVWJ3MzAxenVqWlNZeU9Da3Y1N3RSOXRMMVVmU1B6Z3dUcWdLeGpn?=
 =?utf-8?B?QjdaNFphTmE0NzErZXhyT0IxZnFtSTErOE16OG5tSXoySFlJR0JWMnNKaGd6?=
 =?utf-8?B?L2dhNTJhSVEvbndqN0JIVFFFcXVwSDhNdWZuQWIzR1JIRUFMTnk3YUFtWC91?=
 =?utf-8?B?bnphb0dReUpLaHR2RFJMRkNpem1MSFNIMGcrZlBsRDRtK1RteHJ5WW44QWpB?=
 =?utf-8?B?bFllaXlHWGROcWtzS1pqZWVvc09MczUweExPa0VhaE5oNlplS0dHNHNMdHFQ?=
 =?utf-8?B?NU15cERISUlqNUJZeFo1MlVyUkRMTW9ZekNNbjBPZDlPRWRxRlJxSnNoYUFZ?=
 =?utf-8?B?am93cXZDZ2RoNENxUUZCSHdPQ2hMTldYZjBDN1lKZEM2ZHBrQ1E4NkJ0enRz?=
 =?utf-8?B?QXovYUhjQ3g4K0s1VWl6Vk43RVRiTHFvdU9UWjVDSUlxK3ltdE9LNDRBcG1m?=
 =?utf-8?B?RG45SUU3eEZSUWpZdmprU3Q2SDhCNEJoYUFGdVdqTVkxbno3eG9CYjRFUmk5?=
 =?utf-8?B?U2ROTkZzTFMwaktiblR4ckUwZURPZXFSc2tkQ1dZemhIME5ydnl2QTNqQVVW?=
 =?utf-8?B?OCtsTzRYYTI3ZmFjTWtMZExpSHVwTCtILzZQRE8wUkg2alp0UXpzYzRXVFNi?=
 =?utf-8?B?UXpIOUdjWGxOeE1XeGFWOHhzSXJyRUZONlZvZEUvUVFRbVdHcjhPbXRWVFRK?=
 =?utf-8?B?UkxwT0ZkU1A3K1BEZW9EWC9WUjFCcGduRnhKeTZlSzQ4K2puQ0M1Y3BvTDR5?=
 =?utf-8?B?anplN2o2NC9qa2Q3dmVJd3ovRFFhVHBjMVAwYjFWV2wyRUhuZ0hJb2lVUE5F?=
 =?utf-8?B?SkdYNFptWXhYY09Cc0l6dUFuL3VYWHZzRDcwcmlrdmZDQm1OZXViMzM5QmZy?=
 =?utf-8?B?ck00OFJ3Y0l3VlJwem5hMElLdXhlUXRzR1lJd2NCSkRvblhEbUVNZnZrTGIx?=
 =?utf-8?B?SzJWaU95THJYTUYrTXhEZFh1YkRuMWRVQmJXQjcwQS9GbFdMcWptU1hLVmJF?=
 =?utf-8?B?a0o3YUN1MU1kZHVKUFNCemNZazF3MWNiRVBPZGVHcXJ2UzRrbWplUkxSOWRu?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e9d42a-0e42-4613-a5a9-08dc489952f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 04:50:53.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idOOA4Vq+vBrHfYrJ6VYi8i3H+s2AiT3Hzl/NgJWnULAiKVCee14rsZf0LjCrT2RJPCDMnYdDGuvnH1UeZxIHCc0ZkMN2msqzoIZVolKV3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7863
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:
> The open() side handles fds in a for loop but close() is based on two
> fixed indexes READ and WRITE.
> 
> Match the close() side with the open() side by using for loop for
> consistency.

I find the close() side to be more appropriate. I say this for two
reasons: (a) looking at the close() calls as they are now it is
obvious what the close() applies to and transitioning to a loop
adds a layer of unnecessary indirection, (b) I do not think a loop
is appropriate for the READ/WRITE define that just happen to be 0
and 1 ... there should not be an assumption about their underlying
value.

Reinette

