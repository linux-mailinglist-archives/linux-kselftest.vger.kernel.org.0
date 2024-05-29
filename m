Return-Path: <linux-kselftest+bounces-10853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23858D3DC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0611F21E15
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDAD184118;
	Wed, 29 May 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfvefNUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB23DDA1;
	Wed, 29 May 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005175; cv=fail; b=Jjk7iPC5VJMNDVi2yPt939lQfgjA9g57TmSq6DPY8Bwfl/UDRHwZdSOrvynhZetF1tHR1i/jEgHdVGzNBroIqzC4ZDUrcIC0OreFwxEwW+b23/OeJWfrRWCsHlqXHMhSGHh4LVNDpmvf6VeLLnStzBiVSxhklZeij8nBZJsgzs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005175; c=relaxed/simple;
	bh=urRg52Z1q+pYHYh8FsnXEHNhp9yzGnwW6pAsesALVhc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQGVDKeLSajeKxnz1fpFfK8akPJwh5XaUfG54BVfTzhdiIXkTJw1SFCcUYDD8GuUT9u+c6NFkOov21NLipMa0NIztmh8HATlNML73sKueA6T6/aYAD8/vdIx+zpQfmDb0d6da0QnQCj91GRynme6/YKWDuWgWJ6LqtjIgX1ebMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfvefNUy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717005174; x=1748541174;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=urRg52Z1q+pYHYh8FsnXEHNhp9yzGnwW6pAsesALVhc=;
  b=AfvefNUyHd20rE5VWSoxfrN1qhVY65H+lhZiHO3zoStQNYiPCaCG3thR
   tbckKJsVweQ/TGGzEjWPTmZHhcqO/hIWVNbW+YLrq30nsXPekeZeUnQNP
   wzNf9FMJWXXPsXSliUMyGkiiV9aN+9hkng+ogTHOXSE8Wl189cSvqwQXW
   LRfM1EAU7ejebEwp90SP0K3i5J/z/lcLZfevV+KA+eCDer0WqCcVtUesC
   h4v7HMVCyig8Up2lNIyX5Wz5iL8XD8S7A/N+zuUoxg5LjPTrVG204ahuy
   8y8syJDmKSn/WMQpkInrEQOGmKyU0XelWfBOenASUHt01US+Tv0bDIXxL
   Q==;
X-CSE-ConnectionGUID: q4lRih5JQ8iDD191LHu4wQ==
X-CSE-MsgGUID: hDjMhfjfSFOUFFuW1DEnHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16379442"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16379442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:52:53 -0700
X-CSE-ConnectionGUID: ojhg7LYpSbSd2Lssr2f5lA==
X-CSE-MsgGUID: apI6Q78LRMG/sVXOCYE0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66395191"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:52:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:52:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:52:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:52:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNmKC0FI7JAyFPen9+PEYnrz1S5uDYvMcSODSp8J7pBUHqI4cY7D3twydtRC6iq+qD6Bv0B+H5H/d6D4e+0A+U+25nXmw3NHFBMdn/FDZo+V2lquFXLegllpFxFFGZ8/pEh/xEfk46WcGQgu2mt6pU7lcxErb0T+C1xtX/iB9b4kDAEqSOhlsIJ3SeosNxcaJTBcR3hGl6BgVDn+pUL2AVkf4nefk0zdyzh2MygZe95EinsHicMsD5BRljylyVHcvyjMJNT09xotI7iz4SpqbF0YvBzsfpKVNSdRYc1sTYjw/ecsna6idpTCuYc/8E+J4jVcwDHhhm/SbRDh3oUm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY6psB/t2nSYNhALptCb8vncj1wlqKZGBBNMxkQbsL4=;
 b=HCk1fgiTOwUW9Erjhn64ivh7L0UhtA5omn1dXC5aF/tio7q+3jkY/U1XRxEeQydjDnIln/6e+xWWJ4+iaWveN4b4WijvURzKyf0zdli9FWS9Zs1Tx1eqgjxfOQ/RXic+YFd9vyEZ41LMP1Y8Zrmls6gMCpo+w+RaMl5kgbyC/Wc9PQqc7oRODg/zUIpQFqJBKgU9SUCqrDFU+vvm3cHs0L6HsvRKYe7X80I7EdySfu2N/htu7SbugLeu1ovb04a7GuaCtWxlRIuBiP5znMZ7lkkLtTb0qeYNrGJQycVhrAS2MpTXqq9FTFidh4ONYwq3f6O4Na2bAuig3ujc12E9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:52:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:52:48 +0000
Message-ID: <047c79de-c6b8-4fb0-aa9f-c48e4086e60c@intel.com>
Date: Wed, 29 May 2024 10:52:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/16] selftests/resctrl: Remove test name comparing
 from write_bm_pid_to_resctrl()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-17-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e671057-c560-44fa-e495-08dc80082716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWo1Z1R3Qk9GdzFXZG5YQytTWDdLdzAvaVk0K0ZMbU5lNU9qclpPR0I5aHdL?=
 =?utf-8?B?V1lkT09LQm1yQVFhb0VLZnVUOTcxbHdzcDNFZHYyRzFlczY2WmZmZ3lNN3ZW?=
 =?utf-8?B?ZDY4T08vV1N3amxFNE9wenEraE9qZDgxRlkyZjgwbGJzZmJjQW9XWHZvcGJH?=
 =?utf-8?B?aHBzTEY3STM0aGowNWJub1hheFhvbE5paUsrMzBXUHRLcWxkOGsvb0xSaGd4?=
 =?utf-8?B?VUg4SXdiMEhrNmNxZGwrcEhRMFhVU2RoMGNtTGNOMCtrZEVxUFRwUG1UNExS?=
 =?utf-8?B?RlRsbnVyenBqY0kxbFhQbTYveDN0WVc4YjBwczBKRGt4eTlXQ2ZrTGc5dHpj?=
 =?utf-8?B?VFJLdTgyNjUvVFVLVVVYeWRmK1RKWG5leEludEZhWHBKSVhseHRVdldhZmxH?=
 =?utf-8?B?UHFyc1p5aHRla2tWMXQxVGhia3hIVUlFOWlZYmhrMEREOStvMGlQdVY5bzhJ?=
 =?utf-8?B?L2ZEeHlLZG5oRGxpWm9seWdyUi9qRUdRbHVXVHJFV2JvOXZrRWpSNVZOUk0y?=
 =?utf-8?B?VGR5MjI1amlvRVlJUldXb2d5YlMrTFluTkZ3MDdXOTZPU2sza2wwWHhLMUNH?=
 =?utf-8?B?NmNaSWdUQ0lFREtjSkVqakI0SmVuRTg3aEdBNWp3QkQ1S1FoWUlqRXIzRit4?=
 =?utf-8?B?RTZ4am12RjREL3hSenBzUmxvZHBXZE1kY1lMSjJPYVFvOFhxRFlzNVM3dmJK?=
 =?utf-8?B?ZjY2N1hhNnJOdkR5K01CaTEveHB6NjBsWFZVeEc4ODdOY1lFVXVsUTNtRVpK?=
 =?utf-8?B?ZDBUZEhnUjhsZXFhaC9MNTlJR0M0a1dKb21IZ2kvTE53dUtTRlp2NWFNZXpF?=
 =?utf-8?B?RmJ2MEZyVHZnMlpaT3lIei9BWEErT0NqSDRLdE1VR1gxLzJKTmlaSVQvS20z?=
 =?utf-8?B?NURYSWZHdGZKcy85SVlvRWwxSzZyMG1tbGM1QnE2dkpDUlBSUEFRUExjbDBx?=
 =?utf-8?B?WWNsZXVlZGJScmtaenZQT1lmRlZFVWJrSnFvb3RjN3ZpRndUbVB3dGthdjdF?=
 =?utf-8?B?ZjZicnhzb1Bzak5KbXZNYXlDNXBMaHVRN0JvOUlRRFBHMSt3ZytiM1VwcXZI?=
 =?utf-8?B?cXNneGNzMjlDSEwrRzhIVFhDYmRzOGQ5c3FkMk52SVBqMjJTRFY1SjNYQ2tu?=
 =?utf-8?B?dE5kVDF3N2JuYWJ6LzY2VnZFdFY4YWhhMGNwaHIxSGpWOThVbDBwV1dDdVpz?=
 =?utf-8?B?UFBBeXFCU2JIRktFLzdZdE8zTTVsQ3FCWE1lRkpFQWFpL01PalBxTXNvNjFX?=
 =?utf-8?B?U3RLTXY4N1dHa0VBQUI2YnEzVHJrdENhRDVLQjNZOXdkRmtublo3enpsQlo4?=
 =?utf-8?B?bzUyS3lLTVdiV1hrNXN4YjN4OUgyTWVlNGsxUnRMaEM4T0JobVE5c25YMEJ6?=
 =?utf-8?B?dWx2ZXN6a0NSbFFtSU0yQ0VYbWM1clJ1WXhUTUNHSUFiMTlidnM4d3FVb2w5?=
 =?utf-8?B?Y3R4alJ3dHRYdEM3RncyNDl2anNvVEJvaGtzcTlTajBYckNzbjMvWDg1Wjdh?=
 =?utf-8?B?UHJMZUlkdUxDSDlrTHVHUERJTEJWZGRvbkdjM3lmNzJzVW85a2hUN2Vtd1V0?=
 =?utf-8?B?WlZXdW9VbkxIaUtvR1owTUdxMm52dmVTMGs2aE91RUVaU1ZCMklpWjJiNWRI?=
 =?utf-8?B?Ym1LWndtampOV01KRDhtRHNRaWxaUWE5d2VoZnpxUG9ZVWZYaXhTNThkWHlj?=
 =?utf-8?B?ZTRBSzVVOHFCWW9vSWlYMHJzeVFHQlRPRG1nanIyTG5QeXdMRWErNjZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVtRlEwa241TEJNMkJMV1BrbWtXWFQ0TUJ4MDVqdDBCdGxkTFhOUjZwdzJH?=
 =?utf-8?B?RkZSbEx4QWVsUm1oaXNoMHR4QlJFOFk1MGEydXk0SXNnOFFaeG1xY0xWcXgz?=
 =?utf-8?B?K1hKdCtJYVlod2dhR0V3K3dCdHg1Uitmc3c2SXBmRUZTMTV1LzlrVnVWL3l3?=
 =?utf-8?B?QlFFZDR4OFFDTmgzUFJQbk1raVVIOE01RWVLTlZydFFEcmFybjlReGpyazFj?=
 =?utf-8?B?Nng2ejY4UlV6Z0JUbzMxSS9paXd0Zk83MlVrNDA3bHRaRGhFWkRnZGlCdUEv?=
 =?utf-8?B?bEEyOHB2SzRMQWRhMlJJZWQ3Qmp4bDJPMmZzMnREWWNYaWN0QWg4ejBzRHEz?=
 =?utf-8?B?bVRZV3RxZzR4ZGdoelg3UlB3bmU2THFUSUFvSWhxbjlNbVYyYW04QXVXTlVY?=
 =?utf-8?B?NDQ3cnFrcVBlZTRDeU1NaGZtL3NtSWY1UWZlRXNNRXViNmFWSmU0M0RSNEV4?=
 =?utf-8?B?b1ZPT2pGZUU5ZFJicFg0RFVLdDd0THZMOThTMFo1dUhsWjRXUXZHakdKNnpy?=
 =?utf-8?B?TEpUdDFRcGVuQWZ4UTlvQjRqaEtRUW5qVjJzcUdCa3d5ZGxFVjNXdUNSbGRF?=
 =?utf-8?B?SjR6ZWtKdDhlZmZvUTZiQ004NDMwb2JFdTkxK0l6akEwNVBzUTV0V0VRVDBv?=
 =?utf-8?B?TG1rdDRUaVBGRUgzTTRjMFJMNVd4YWYxNE04VGZkb2xJeU1YbzRWVlZmLzg2?=
 =?utf-8?B?b0dkbjEvWXZTblpWS1BXVStSVWJJOGg5U1BnN2dUS2JNMG45UzhPM0NTeXd0?=
 =?utf-8?B?S0Q4NHpXMlJCbDVRaVUyU1orVllXYWdvUTlQRFNSTkhWY0wrWVVkb0ZiL0M1?=
 =?utf-8?B?Z0F6c2NpMTZDcWpJenFRM0NPZnJFOE40a0tQNnZ5ZGlWNUsrYUJoeVZHaUVn?=
 =?utf-8?B?aEw3cHgyYkwyTll0ZlBFRkhSQnNYTVYySEhYZHRxNHBsWjI4WDkwTG8xZURp?=
 =?utf-8?B?c1BRcE1Ha3V2Uk9jL0dqMFlndkVBaXFPQXJkbzNrSkRTcFRkelVNNkdTZTRY?=
 =?utf-8?B?V1AyWG9vTythOTNoYWFRSG5oQ2JrMWZuSUw5WEFxL3U0MEc3emd6YWRvWHJi?=
 =?utf-8?B?MEFnNWVtRWZxT1Y2cEFFSlBHeitvd29aTjNtZ3NUYVh3enZxdlZZbWdVZU9w?=
 =?utf-8?B?eld3SjhvRy9PaytLeU5uZ0tiRllocGk2T01QcS9BdU1IWnpqQlF4dVQyYlZn?=
 =?utf-8?B?eUZDUHNxKzFKUHlJN21Ta1NUbmpqaldUSFU4UXlQQmFNTG5tRE0weVFvdjll?=
 =?utf-8?B?anVBOU1sYmY5SDdKSUYrcU1pWXBUWHZBaHdPUjlZUTAzRmZzcGJCZHh3OG9L?=
 =?utf-8?B?TkhEZWRCUTVHQTR6N0VhSU1sRGdBT05kclBQOUZxQUhkbmoyaUxWdFVBeHEr?=
 =?utf-8?B?bTZjNUswVkdGZGM0SlNJQk1SZlEwakUvTy9uamFHVHlrSk11YWk4Y25zOW1R?=
 =?utf-8?B?UVIxdy92ZjZHaWxtTmN2MjZJc1Z3eDNHdTJ4TWRuWi9qNUlaY2phWjBQM1Z2?=
 =?utf-8?B?LytQQlNNdkMzWkFzcDRYTFpjL1VabHRncHpRek9zK0d6UmMvLzlwNzRzeE9C?=
 =?utf-8?B?WjhJckZZdnBkY200Q0lvWnpuemFIeTVpUzdGT1FNbnlOTVcxN29NNUc5Y2Nw?=
 =?utf-8?B?RkhNLy9hTXVLYVhzU1NIeUU3OHJDd0U2RGExZUpZYVlCL0F4amcxdDJzU3Iv?=
 =?utf-8?B?Tk1XU05NSnlnTXJseHlZY25YZWttRGczWGRIR2YzYVRWV1Nsckp2emZXY2Fl?=
 =?utf-8?B?UE1MY3VZTnJLQUhjdTFiZFZsSG1GalFQSWxpZTlpTHAzaXpnYnFJdzFEVEFq?=
 =?utf-8?B?K2tTUHkwZWxXaGpORUdpcndGU2VKVmNGS0FlRDRna3RkOUdRQ3BhMlE4NkYr?=
 =?utf-8?B?bW9LcVNKck93Y2R1WXNsVHp0UCtpU1dWbzQ5clBiWWdmdkdYSUhNOUliUXVy?=
 =?utf-8?B?Zk9YUUNmdFpTWFRVU3lSYkZQQytHemhpRTFNSEpQaEVocTBvaGR0dmFGa2NK?=
 =?utf-8?B?S09Jd1ZBK2UrYVhEVjZJOEpDV0dFWE9mekJ2a3lBdG1KcTZjR1RxejBvUzZw?=
 =?utf-8?B?VGdvUnV6MUtSNE9uM1c1M1grUkdneGZ4c080VlRXV3k2UUxzWGsvM0N6NXdq?=
 =?utf-8?B?c3RENjhnK2I5VUtFdGQwOWRFd2lUWWd1ODZUZ3MrbGlyNWhBRUJiTUszT09k?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e671057-c560-44fa-e495-08dc80082716
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:52:48.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxBsVWj3TwVM67yNdo3Qm8oESrw3Y0L855fxN79Wt5Zr+S/Hb2zNxN6wBkNOHBANr8yHgaYYjnDQ0nfyMGe/UtB1otYBsmgL2jE/jh3Lj7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> write_bm_pid_to_resctrl() uses resctrl_val to check test name which is
> not a good interface generic resctrl FS functions should provide.
> 
> Only MBM and CMT tests define mongrp so the test name check in
> write_bm_pid_to_resctrl() can be changed to depend simply on mongrp
> being non-NULL.

Second paragraph needs to be reworked because at this point
"Only MBM and CMT tests define mongrp" is not accurate.
Perhaps just (feel free to improve):
	Tests define mongrp when needed. Remove the test name check in
	write_bm_pid_to_resctrl() to only rely on mongrp being non-NULL.

> 
> With last user of resctrl_val gone, the parameter and member from the
> struct resctrl_val_param can removed. Test name constants can also be
> removed because they are not used anymore.

Imperative tone needed.


> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Patch looks good. Thank you.

Reinette

