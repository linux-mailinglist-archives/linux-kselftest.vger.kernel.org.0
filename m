Return-Path: <linux-kselftest+bounces-3633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4983E20D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF801F21DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C021A02;
	Fri, 26 Jan 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bChjo5Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22121370;
	Fri, 26 Jan 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295493; cv=fail; b=GaM2RhM32frX8300fQsLxu/qHE+aUNBgcsNBBk+rS8Q8lTEbcoAu25NqeXfk+gdjWVeW50ecRALFRljnFRj+WygxGfPcD7B8cHn6tUbla9/y5Yfq5nbU/901XkwIeKLa8MaeVVyrnCvZxFD8xkKDtVtqUpE0WP7i+xnqunKUJEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295493; c=relaxed/simple;
	bh=gBQ1hc2g4ldFQ09QyA/zFNeOKvdqSh8hWUHgKDIbH+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ss/jvXgfAk+75RqMnpaRJuS+vhjxFIQSZ1Rc7BXIWPblOV0vmjHfyjP2M6ge5NElDdoWmoRLWdSY0Lm/TEAVeliWDUc215crvS4Tfh72xGibbOzHt+9XSbCEPxa+I1f03Iu3WwuBO/uOqw4muKuTvEQHQ8eKBFIifMw/0aQ4tt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bChjo5Li; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706295492; x=1737831492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gBQ1hc2g4ldFQ09QyA/zFNeOKvdqSh8hWUHgKDIbH+g=;
  b=bChjo5LigqF2ct1j06BTtw6nxQb31LO7EgVqvDFHVGfV0yJFMwS9Lm2A
   DX9ul2rg82nk9ZVSXetPrL0HP8UpDprqzuH0evdlrgbDU/yQbnT7jQWtY
   sz3f/RVFdCd/akXd96z9MqNtaUNR2wj1N+hVUi1O3Y35JiJmm2iMwMTxf
   dtC2s0Hk+ee8w4Cnxkk7WOFBnVlwK/uBKlko0B0HEGrLokMAQbFP+YEzc
   juRocfYR+S8OaaL+7cfS24Ac/dwJLOyu93IjElAHn5k3N16P275OM7fD4
   Nt9rZkTb5uYQwFQVWAuv2GZaPHRleJQ33ERfFwGW7Ow9Yf0s5/L3N+ZEp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2417534"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2417534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 10:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910412930"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910412930"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 10:58:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:58:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 10:58:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 10:58:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2ipLKsQAsMopOHYbEV5kUVJqrVqydOl9aqfaG/M8Lp8hSHdfSXjd7KUybDvkLMyGOgLmhGtoFuTUS7oH+C1k8K21KS9Kpp/MVn/likWeQrWDpgUFsoC2MJ4hzBKtDwW8SV68x/NpcADWVk8DGQfn9T+HMCgqYcNbXblsA85WQ4YTJMpQO+C5WjAiNRN6ABrJ7RpgERcUGVTjs7Vh6NudZuJBMcKM4WfHsGDvXQoFSZj2iNBlEnTbMhVbAxNxdisqKTAKTlCTcK1ivFU+/2ctWgTGIRMSHaOmVt8mOGn76udMMR5beoWKlsdb3jNdh4sXXfyHbXXYaahC+677xWh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW7wXgzhCabBaSFI/6b8R1QZirOBqM8yJofQZs9jLrM=;
 b=ocQUlwMKe1PlwUgqfc8hXNxhVguIMOOWRaMx43fS4FGTTVrC7NI847CZvF/xp7+HtTfI3eYCRX62PFhTUo38enN1SHUNIXFeR7wZKfZ6Dq3zSFrZOrKd/gYBIBle9OuRfjLH1+yvPeBnrfcqSuLulPjrBqKnJ5zpu5S5yBSIx8BJkoaGYgDIWY/f3gvNd4Q101HIdcmm6g/V6saYpOG4oLPuyE1263wNMSIKoE2BaPYk9G6bs8kkQzVoXDywfvOSHdLPx0AllEffFysLSjOgB85jPqAwQVmqO9zd5SNs3/mcKSjc6oUQZojgfUQlp8XNPLfwtNSX8gTq+dHZrX1Zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Fri, 26 Jan
 2024 18:58:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 18:58:07 +0000
Message-ID: <611fd2b6-d9ec-42f0-9711-b1398fc02842@intel.com>
Date: Fri, 26 Jan 2024 10:58:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
 <ea9b0e06-c07e-eb4b-9e7d-ed20419b677d@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ea9b0e06-c07e-eb4b-9e7d-ed20419b677d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: c35d86dc-5941-44b0-85a6-08dc1ea0bb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksMDoyYceHjyiQVAVhVUga66cyRm6+VYZw+l+oSYSO1IKNqfcYFLi0964JEO4Jviqc8phkG4vOcwTB7tuVhllYrc0k0X9/Ys6vzpODrHNraNTGuJKNCeKB6sQTWGHPo18uF/zT2H2DcZc+Pf0nLA6zEJVfCmzZMlZKiorrQHu2YXmc882lQq7E5OIRbr79hIZOomxjIYWk94SZArFV+xw8UcMOTuj5Rxo2zGJZBAvhb6hSOjJ/qUPL6d9GdB+phgMsgQ8CEAZss/jt8ZgbG4tsAv1DPC31YW/da5l5X94P54jjwaSIeTQFdoEDrMHqSJHVlWOe2D7EsD3vtWNWLwDHLUwbHOT3KvhvadCvyWS5IDpSfEvhbfHcXyOniAkhRXdxFboLVS/66YGd7ZBmp8QAPb9AqAm20+7jywWE1hLflwaLh3NubfruwwF65jpB/E2s/rUWSZInMLIhpqctXoHoYhYSxU7WdGhgNwfNdhs1TPlrVjABSp7eHwCjwYRUn98yigUkUZlKTfxbxC6G+uChLpfyJtKBcKmaxrMdw85JfhkJtFWcaLQ9w3naYCI4BeY8s4l47inELvVFeLPRujZOaeELbGb0SogcHTQUXUV27QjjdGJ6gprGL/h7z9chrx779v3QVKz091+vJ4U7qVIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(6666004)(2906002)(6512007)(66476007)(110136005)(478600001)(66946007)(26005)(8676002)(2616005)(6486002)(316002)(8936002)(41300700001)(6636002)(5660300002)(6506007)(66556008)(44832011)(4326008)(53546011)(86362001)(82960400001)(38100700002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzNFOEM5WWJSOUZXL203YjVQY25aN3BRKzZ5Y2c4ZXhFcGVKdWZTM3pCeXZU?=
 =?utf-8?B?ek1RZElCT205Znk4ajM3cm9hdC9LWHhiL2lVVzdrVVp4Vldrenk2Mjd1bW8v?=
 =?utf-8?B?ZHAwYmJ0a0NwL3UzeUFUeUNBSU9mTjJneDlCVFN4blRjMTJDbUFkQXpENjRK?=
 =?utf-8?B?OUx6RTlQVXk4MnVUcjhPM0M1T0VORWF5YWMyVDJkeHdSV2ZGMWxRYk1QVzZm?=
 =?utf-8?B?OVFRT1BDUmNQMmJPa1ZKYm1Bb3YzV21hald0NjlwazkvakpLMGY0MGRjcW4x?=
 =?utf-8?B?c0VBTXR4TVQyeE1FM0ZEMlJPVXRPZ2QzNGUrTWJjckZUTE9YSHJxZDBZbmdN?=
 =?utf-8?B?VFQvWDlqbEthd0pZTmp2YXJrcmpYK3ZMdFlucnA1bmxsMnAzbXNFV2xHbGV1?=
 =?utf-8?B?cEJMenhNbWgrT3JHOTNZeGtNSWdmTkVxbWY0WVZueGlWYmVmM0RhWUZ4VEdt?=
 =?utf-8?B?WkdHckJKTmU0UVpzOUNRaWNCcitHQnBiaUZtV1BTRFVrV3B1TnVpTHVEMjY2?=
 =?utf-8?B?TjdFSXBEeUFxU3ZId3dnMFg5bVJhVFd1ZU93YVBVcjFOKy8xUXhOWml1MmpJ?=
 =?utf-8?B?VW9yZ09sc3pvbjdYaDdCaHozT3RZcWFFZDFsdnFFR0RuK1JHd1huS0J6bnlt?=
 =?utf-8?B?YWdWeWZjbmNMTTZXSExQeHcwVzhSMEtkOWJNTWNlS0VpekloVlMxRGo5THFT?=
 =?utf-8?B?TVJ5WjYvdWkyNFZ6SlloNmhkM0FLWXhhNUFhVWh4UUJNTlpTb25TL3Y2YWtV?=
 =?utf-8?B?dWl1Nldyc1M3aEhCa3Ntakg5VFlYRGNSQ1BySVliYlRWNkg2bDU3YnZ4ZXp3?=
 =?utf-8?B?a0c2RnB0aDhHMk9GTjg1a1cybnpvZ08rNklqa0RxVnRtbWNtb0piYnZWY1py?=
 =?utf-8?B?RXF2azZyQWszNkE3RnRDdHcvMkZZZk0ybnUwRm9LSmE4V0xwZjFUZFJleGZl?=
 =?utf-8?B?SHI2d0J1MGF0Ri9WN0dkb2cyazY2ZklhRTh0bU9HSVdoQzJVbVNYVU0veTlo?=
 =?utf-8?B?MWlCcTRrR25GcGpLTE96YXdQVkNhWFc0Snh3dVJoU29uaC9vVDFIekdveFB1?=
 =?utf-8?B?Y0Z4RXdYSUNCdk4xbWNkWkpoNEorTnJ5bXE3TldSMzBLdGVtb20zckQ1YUNP?=
 =?utf-8?B?K0VuWjJqa0c5dWU0OWorSmZCaGo0S1E4YmUyNmdJeGd0SmNUWFluZUxQZU4v?=
 =?utf-8?B?M2M5K3lRSEo3OTI3TmRDK2NVSlErdDRBSFA3bHZSRlEzRkRXcXJZMXR4T2w3?=
 =?utf-8?B?K3FSazdvSzdmbGdEN1NDWGltKzZVcTN4cTVTOXMzMU1GZnNuTUhWc0RCREZF?=
 =?utf-8?B?NGVsQUd3V3R0Q01iM1BEUU5mSFBPOTdBRk1ma2hoc1VSTkdyN0RkejFBVlI5?=
 =?utf-8?B?R0h4dmdBWkNoTWFJa0pKdGNiNTArbmkybmxMS0IzQjFzQXJZaXBhWGZrZ3kv?=
 =?utf-8?B?VE5GcXZza2NqMUp0L0lHQXhPdGVUTDNKT2VPRzFBT0lMK0hUT3J6YWJ5THdH?=
 =?utf-8?B?bkhtR2hwc0x6d29KODhCdmRuZ2FDOTlaczg4R0RGelpXQStNek40akpUdW5n?=
 =?utf-8?B?THd0bTlheGgvRUdXWlBLQmozZi95c3QrSThoZ0UxcW1iRHhWMjY5bGs3MWlh?=
 =?utf-8?B?NEozTXQrb01pb2kraGxONnRKaVRhQlNOZXpFSDVXK3RSa1J1QkhtR0tyZkgv?=
 =?utf-8?B?eWVob1F0MktYTEx3S3lyTzVIcFRDL3B6YVYvOHVWelNuM0RDZlZRQ3Vhekdr?=
 =?utf-8?B?Vm90Q296YStNWWtqMHdNeGRsQkxIMEpsM3dXenhvMVZtbWhMSWd6TE1EdXAz?=
 =?utf-8?B?Njh1bDJhdzBDU1I3bGl6WHZGL0lQVFVPa2g1ZHd6MXdxek5ubGxFTDlTUzQx?=
 =?utf-8?B?VWErcHJjV0N1ZVJFNjRRZHkvdHpJbE12YmovOVZONFlHMGlRcG9yYUhybm9o?=
 =?utf-8?B?N1Fza1prcTdGUVFucTVSdU9xdTB0Z1p2aEdKOUxnckpzSzJtUEFPbmhNSmpN?=
 =?utf-8?B?L2xhUG55Y3oxamM0K3ljSXVwVDI3RStsdlFXdWlZQ250c3Z5VG4yQ2tLUnV4?=
 =?utf-8?B?Wkw1TmZpeEJiUGlKQ240NW5ZaWVGRHBiZW1CcEFKd29JaXpaeTFpc0dtdWkw?=
 =?utf-8?B?NFFScDV3dFQxVk1IbEo5c0RHNlpqZGlKWG1ZajdsK2JVQ2hNNUNQOVluSFV3?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c35d86dc-5941-44b0-85a6-08dc1ea0bb76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:58:06.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTMNe3XoMXeBvqb8iwTfyGOch1jCd72rcfPhU3a6Ue/5wLbdLRfon1B91wSFWHCQSWup5Kr7lRMZKBZ+q7hxiPCC79TMHyLp8aGSEHZZ3e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com



On 1/25/2024 4:14 AM, Ilpo Järvinen wrote:
> On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:


>> +	fp = fopen(file_path, "r");
>> +	if (!fp) {
>> +		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);
>> +		ksft_perror(reason);
> 
> Was this the conclusion of the kstf_perror() discussion with Reinette? I 
> expected a bit different outcome when I stopped following it...
> 
> In any case, it would be nice though if ksft_perror() (or some kselftest.h 
> function yet to be added with a different name) would accept full printf 
> interface and just add the errno string into the end of the string so one 
> would not need to build constructs like this at all.
> 
> It will require a bit of macro trickery into kselftest.h. I don't know how 
> it should handle the case where somebody just passes a char pointer to it, 
> not a string literal, but I guess it would just throw an error while 
> compiling if somebody tries to do that as the macro string literal 
> concatenation could not build useful/compilable token.
> 
> It would make these prints informative enough to become actually useful 
> without needed to resort to preparing the string in advance which seems
> to be required almost every single case with the current interface.

I think this can be accomplished with a new:
	void  ksft_vprint_msg(const char *msg, va_list args)

... but ksft_perror() does conform to perror() and I expect that having one
support variable number of arguments while the other does to cause confusion.

To support variable number of arguments with errno I'd propose just to use
ksft_print_msg() with strerror(errno), errno as the arguments (or even %m
that that errno handling within ksft_print_msg() aims to support). This does
indeed seem to be the custom in other tests.

Reinette

