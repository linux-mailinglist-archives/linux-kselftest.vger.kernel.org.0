Return-Path: <linux-kselftest+bounces-1869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1C812105
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03212B20A64
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453207FBB6;
	Wed, 13 Dec 2023 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl4550Ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB1106;
	Wed, 13 Dec 2023 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504584; x=1734040584;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHrHgUi0SyOrtyjQ/r8Xl9feZCRZ4l0c5Cg8cBKVbDo=;
  b=jl4550EpJFq3uyOwQRlsZxIlEY0hvzOtrJzkqgcfrOSQTxloqY9PvhR2
   shTagy9ozwPSvn0Y7Vzzu7iZNjNe25oExC7nP8EGKPP6FZoUXHQEogVH9
   yKdfbPfSW0fJ6ifINUrUVg6CKQAWqv1Fa4DK1vKt2Aq5OK/7c6TBO7Qp3
   iHs4mgQGJ8vtGX5onp9CMcRIJS60aToosW7C0KyVmSMwwraIW8Ab7Pdk6
   dhCokGzhO4U+m4R3oGv8VKRV4WdRxVNbqSwsSPLXq/LxC78nuECKL+KHe
   p+NGgQi/mdKwodhQ0hBVJ7MP/bTjF16aboSwbX1Xs+nLdJFYqw2rQ3dPM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1854789"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1854789"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767370953"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767370953"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:56:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:56:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeKVEMvSTl+smS4ySItUUvAJeRt4JaY1Z1mdqPTiXmi7HVT5K1Eqydyda7e4/sTh2AXlQVMwJ3bXw6oixS0JCFU5bsQo23MVkjbr93TVvxsDPig4emDCFxLyFTRBrzBDzDiF44SQl0VdimHbLJ/7uR762Bs1UH9Nvuyd4amsk32QR4LNOsIbNYQS0Gr85NrLpshuHmABAiwkY5pmIWuaVWkKR92dZ0EVpetx++NnoU946+9NDNvdruTooERls6PWJ2ari7veJrf8RGO/gj53ba1LzhwKXAufAESjSkE5h1toJ4ykqV+zIuWei7ExixsVpDZzLQIbsK2Cr1QU1iCwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HYLgTXoOxY54O0TJ7bRmAFKB76xvXfJZ0kvGLgncng=;
 b=cly4W4hakwXQHb2jh8mKuPDZE39rvGdemP2REDZjYVVP6PtAvotk4RGLJ0MNt+1xFeXVrGkbBOwPrlwtbkj/KV6ObnmUK0v74L0cMXS+Nyb/OzcOuE7N4KFUa5jltMUbiQeXzP5WLWx0xFFiMDmLgqrssXreW90AjDqrF9YcCYBUG26lE3jPTFVWVBb66sFnN57cPXeRZaUqdpxvB35dZurek0/Xk3rNM8zKLHtfFH2XCDtTPAzl9+FAyMuuw1wxh4E3VvZSL2hsVLgnVtDdLg1GZ6dpEvwPCQQe610Jg40R7Kil5vhEGBsaezYKNo89GEkoLzOpGaUpHqCJjwgpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:56:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:56:18 +0000
Message-ID: <ac7b59fa-f2f4-40b3-bf60-7d35b4fcc267@intel.com>
Date: Wed, 13 Dec 2023 13:56:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/29] selftests/resctrl: Exclude shareable bits from
 schemata in CAT test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-11-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7873c6-f647-4b44-7d9f-08dbfc26560d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZOIzO7pWToIEmsiUlOJP7tZuqBSLLltYqjq0f2HiwicCyWbeXqkJMuToEYnKGdc8W2YO1FK+ls/5VoByX2Eoi29rO0YtzZNqTPCNBsu0kRtJ+sCNjlbnBexHT3luFjT2tsYD53WVEBElCf77QeqorDPLaFKsfPiS5uS0ot38c0/2x3FEqlmlHpv8BY7serNlrMDWD8kqBVNyCOiiGI3cjjzxZCDEsUAi3y35o+ZcdiNAU4fm44g9s5C/9gD8fkJZQ5CfXqs1Ar//2bR/vCd04IdYlAQbn9SmMdC/qPuWEtCHnRitbK2ab85EfyV8ktRgyXMtJsRqLbPgNSNBXrXVHt6DHeS1eRy3DL/nUuHxvoposFWr+oDrNtWWiNoGK9Jh47Gnx/k/M3JmJ2RZ+x6IGF9fp9h+xDHlTIt4OLlq5Q+UgS7kzHh24wPUALvXM9hApIIo+6STxWF/PbLI1BaDDpP+IA5y+Ll6Z5xOUoLzQ4/uyROiiYrwIu+nakr7qDqvvdccxg08D5ERjzLwF/BGCmmIefKBv3UdY443mLyGWo6msrANFzo4kAbmQqoJrEPCp68AeDG9X5bpbrSEkDktM/vuWn75FwzM1gYLQFNzc7+LbWghyToLQN83rMbehsXLPf4ixExVgIpRmnAZ/K3Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66574015)(2616005)(26005)(6506007)(6512007)(83380400001)(5660300002)(4326008)(44832011)(8936002)(8676002)(41300700001)(2906002)(4744005)(6486002)(53546011)(478600001)(316002)(6636002)(66556008)(66946007)(110136005)(66476007)(86362001)(31696002)(82960400001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWgwREp6a1ZNbnppcHNYVlpRNFYxWmRBQ2ltc2FxdGRwdUtVbVdlVC8wRGlB?=
 =?utf-8?B?WW9BMlFxMFBDNXU3eEwrWXE4ZG85bS9wYTlXamc5TXBQMTR0V2VuREcvcG1K?=
 =?utf-8?B?c1prc1JWdzRrREt0ZWRqK2l2bjdmOTZsc0F4TGVuNHhwNUUvWUF6cXV2aEdI?=
 =?utf-8?B?b0kvd3dMK0c2Y1BmWDVLbW8wYXlhVm9kWEdaZjExSWlza1RDMFVLYUNDTEl0?=
 =?utf-8?B?NC9VVmlRY1NLVmFWb1E4L1EzaFhaZmU2YndBSEo1dnJveDJ3QnhDU3pqWG8x?=
 =?utf-8?B?L2RlY3cwNjZGSTZYTnB3Zk00M2J1MkE3c2NHeXlRZ1IwNng3L29zMStDYzJV?=
 =?utf-8?B?ZUtMaTZNUlFGRndQRnlkWmxBajhxdmxUcmVXMWxKYllpRzZNMEZGRXZyaFda?=
 =?utf-8?B?Zk5xdUxBU2VDQjAwUWt6RmxjcGVzeDhpeDJOSkhYcFMvSXdOdjNReDFHeXh4?=
 =?utf-8?B?QlBqUXJTbWZFOFgreURMcjhIQUVKYUpvMUh2N1NleXlZUG4zWWJOcFY1VEJp?=
 =?utf-8?B?eGY0MkhQVE5PSGFkbmRvK05CQXc2S1RURnZLWkhiUndPazhIeVhwYXVZZ21W?=
 =?utf-8?B?QnFjREJqUGRWWmw0MjBHcDdoLy9PVmlhTVk5dWRobSt0SDEyMlg4NGNRY0Ri?=
 =?utf-8?B?NmRBUTVGdy9xZTRyN09MV1hEV1JmTWdiTGRkWWZ5MEJLeXJtRFllRHBtV1V5?=
 =?utf-8?B?Z1hLQ2JUelFOS01DdDhOeXRid1N3SnBCcjQzZ1QybXdpaklOVXJrYzI0S2g1?=
 =?utf-8?B?RWMyZDR4NDBYcEVpMWswcnNVb0xrNVBUcmVaNlRqcTRxQVBua1N1NTIyRVhO?=
 =?utf-8?B?SjJ1ZklwZHRhN2ladVR2cEpIV3Y3RDRDbDBJQld0M1N1NVE2R1FCbFVVanc3?=
 =?utf-8?B?TzJTQWtpRFVqcFh2STRkemltaU54bmN3YnFSWEJUV1JyZ2JlTnQ5azhUMzBR?=
 =?utf-8?B?aXZwYlZrak1zMEhkMWtrTEk3UWh5bkJyNTBCdzFtT2txaW56NlNPZ2hUWWIx?=
 =?utf-8?B?SFFjQjQvYTF4SVMrTWdvQkxLOTZUdkdWMFVGVGJTZ2hxU1lQRGJwMHlvMXdl?=
 =?utf-8?B?K2FpQUlwVkxBNkJyQ2xYR0x0RHBBb0lPR216bTIvYlBLMUh2QUpXT1c4eU15?=
 =?utf-8?B?Y3NwRC9wOXRQNGZOVmYzTVhaRWVNMWkwQ0xRa0JNTFJzRkdqTGFVbjc3aEJm?=
 =?utf-8?B?bG93RTZvMFMxMHlBajI3MWQ2cnlVK0l5bHZPbW5qdzV5QzliU3d4blNPeElu?=
 =?utf-8?B?SXVkcC9lTlJLU0x2MmtjMWp3aFJtd3duRGY5dFFNSUk3d05SemJ5Y1dnc29M?=
 =?utf-8?B?NDJTMHhBV2N1V2c3YWJEL1VoZHJHMUZrZUt2RTNVWkpTU0hPSlUvNXRiV3Vw?=
 =?utf-8?B?c0JwRjR2dGZ2cEIzdTBwcHM3MWFsRHZFaUJiUC9FQ2h5dW5QQmVucjFFZys1?=
 =?utf-8?B?R3Q5MS80YjNUOEN6VHZ4bGIyVjhpNTVWTUpCS0xrSWhjenFkU0xZRW1sTjk5?=
 =?utf-8?B?LzBndVBwSkZoS25ZQk1qMXVOeDUyZlB1REhwZFlvUStENkd3M0FjZE1CTnpn?=
 =?utf-8?B?SWhDdks0WjNTcExDS0ZDWmhiZzRsYml6dHE0OFBNZ1B5ZFBjNVhXWmZuQVVT?=
 =?utf-8?B?QWZUbC9GbFkzb1BMdXNXU0xmQVlSNzdyZHd3WW5RbEkyUFBmWVJFZTgxMzcy?=
 =?utf-8?B?K3JTN1c2bW94NzdsenJmSmFlT3B3WmtYOHM5ejN4amV1aks4dS8zbFA3V0Ni?=
 =?utf-8?B?dGlpZVl2THVSUGNLTDFqcEE4U1ZTcFhHcmtuSktSMk1Wbnc2T08wZDRGaitj?=
 =?utf-8?B?VmxlS2Q0bzBnV2RRUXVpV2pOSDlVeEMrVUNvdU91WE9wbzIxVXhQeVpEcy90?=
 =?utf-8?B?bFgzRDh4d1MwZE9WREpGTkZ2a2NqUWhuaHFLUEVJRkU3R1RtTWU5Zis4bVZE?=
 =?utf-8?B?UTNGeXlHdDh1QVUyYjNSMjQwN2pHY1I1RnlsUysyUGtSbXlJK3RLVURKcXI1?=
 =?utf-8?B?TWdkbE40V3pIVjFhTXpRM2dXUjV0blhYZVBBQVdPemFORW9jVm5reUh0b0la?=
 =?utf-8?B?MVVwYjdsTjhibFUrWDR2Q0N1T2p6blIxamtTcFJaSGpQbE1MVEVOTmd4SUpE?=
 =?utf-8?B?YVo4U2lpRkU1S3g2bFJmQ0g1YVIxbWFxd1REWFJURmlud1FYTElQdXlRakhJ?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7873c6-f647-4b44-7d9f-08dbfc26560d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:56:18.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdItF5u9EwesElbYfYT86l7Ezln50ZC81rd9XHSyGQyXypJgAaX1GBK458ATxvRvzIiIH8BhJMq0Tdv+qNWp6z97oD/z2z1aOQq7e7vjDBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> CAT test doesn't take shareable bits into account, i.e., the test might
> be sharing cache with some devices (e.g., graphics).
> 
> Introduce get_mask_no_shareable() and use it to provision an
> environment for CAT test where the allocated LLC is isolated better.
> Excluding shareable_bits may create hole(s) into the cbm_mask, thus add
> a new helper count_contiguous_bits() to find the longest contiguous set
> of CBM bits.
> 
> create_bit_mask() is needed by an upcoming CAT test rewrite so make it
> available in resctrl.h right away.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

