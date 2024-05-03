Return-Path: <linux-kselftest+bounces-9418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3D8BB359
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3053283F7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E92E646;
	Fri,  3 May 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpEeqKPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBC28E11;
	Fri,  3 May 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761607; cv=fail; b=c580n3tBvaYPfAi2t3msk/ZA7FDP6trB3XOHPzc2rsHuwk5BO4LdwU7NhqPDuINSMRq1OQ5uAbnXBAE1IhbfZbRY+D4xIcY4Up0R6+jZB7aNGg+afr5p/yX2rdvxdwdYxcOxDrKaK2OVTpjUjsQPVpVvs7I2tTBXNqBoPVlFRAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761607; c=relaxed/simple;
	bh=dsHyjB3/C0Hc54YqWwEHBY+Hvv5lGAhm7S1TlnQk/fw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u4ea5ohcrF/AMtGzSu9QGFzKOwXC3PAHpd+Mi5jEqHopDlcZMkpsRkDqg7P6v/6I9P+zKVKh5jatnIL3pqjqqJg628KWsucjVeUoMAvpTepS87cY6IYyFYjQnrVtqDguyAhu0jCElYGlbcf91PGHM164cRH8MhLk/fjaq7qbVbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpEeqKPS; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714761606; x=1746297606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dsHyjB3/C0Hc54YqWwEHBY+Hvv5lGAhm7S1TlnQk/fw=;
  b=NpEeqKPSRfDWeRpJZzkPiauknm5VXusUuEIPfvj/yU6pS09+0oDppUsO
   httV1SCdCcdakR4PyMcUJPZvan3VUM6XRR9WMTfjdxW6prD/5M4BHW+uO
   ay1ZIfM3qTnqHFcoUxGYE/4PxVoE30CEyLkZmpracjJMkECItEdRlSMA2
   2NjCglg425IWiHKKyy964WBjpbsNr3HtxcSIzS6NpfpPB6GyInVIPmlnv
   epZvYjo+4bsbEMBprBkx/BVtRD/Snn1L5h/wZDtIDrK42H3FnJTAvoTvT
   DNAWqpF+aZAm+AglHdtGeyz+9LMAW8Kgc96yJkD7jAVw7hm7VduzE9G7Q
   w==;
X-CSE-ConnectionGUID: 1AE2KxJuSu2t6+bqyO+JYQ==
X-CSE-MsgGUID: Mmpr5eiyRJObBAyJi1em+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21991180"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21991180"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:40:05 -0700
X-CSE-ConnectionGUID: TVCU/R3nS/2m7sXL461SqA==
X-CSE-MsgGUID: 7OF6hcWNQ96mn1VfJi94LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="50719323"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:40:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:40:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:40:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps5vJIvQnSoQUzJWvgUn3QUSAgC3ueALhCxZ9IPTiy9B2H/9bBiwMUOPeZ5UI+r+6Hc396bw95DFZq8wifD+uj7wfL9TCfEZitdQ4nWpBOgnTs9gQyF+jJV3Q5ETUQ7VyOZpmw/WHVRC4oWEVmw//pT9jWJPAvdUOjfjDliPsiefC2+lMHrXgp5liNj4aFWLOhLSjl9uaklDIJ8RyFENRCV3prcMXj8BdxCkVpAF2BXM+OHmXvPjD/D+cKUE1i267427OcvtQDp1srzuITrbQ5V3FfrUY9ktv70+fuVRYmWx+vHAhKQvvSr6/01antAqm4saA75Rfo2KTey5ojHjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+2DEuNgzYGTfNs5btKJQnYskj0HXqy8FmiklDk+nlU=;
 b=bov+IDBZKO0Apo/73ve45Jg+V7CdR/Y6VYyeLOcq5yB9x0EwYNol66JvJiuYSnVNd5tMvYl+40TirDrwFmaB0wPL74iP3jqJS9ji4KAL69SP0O/6jPSntcaQ9c/AOaDGWrs3SZDwXAs/m/Oj/xeir3WGIsaW9ztaIJd9LS/b+jE/0f5Iwt/VrQPG+h7Oc5ckZe7zwS9kUxpBOH1dbs9jLEfYUCcz9HT+kIK87dddIg6tE3HbIY2kPj8GjoKQB7TmAze6MuCfw9xKhDiVBKfHJMWWvj3DPbpSdca1b8o6JBbBD5wKHo4lWAaOBZzcjRRnlpKLUZEFALI1R5yzPpXlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7434.namprd11.prod.outlook.com (2603:10b6:806:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 18:40:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 18:40:02 +0000
Message-ID: <977ebfe0-4c12-4631-8309-a10d92e33fbd@intel.com>
Date: Fri, 3 May 2024 11:39:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build failure: use
 LOCAL_HDRS
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240503021712.78601-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240503021712.78601-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 649207fe-1304-490c-fd2b-08dc6ba0718a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVVvTmQ0akhxQTJNdnNBN2I2cXZWa0N4OVVWeGp3VWlPOHRKdzJiWHFCNkZz?=
 =?utf-8?B?cWl0Rmg4b3Z3S2dYSnY3YjgvQWJiZitBem11eHB2WUJHOWdZVXUwSTBoMFFR?=
 =?utf-8?B?Ny9FczJUbUtSeWltWGcraVRrK2s4Wi9US0FFUkVIazQ1KytsOU5qRkM1cXpr?=
 =?utf-8?B?d2dQZHZ0a0xmM1ZGaDB1YmM5QUNrQXBtQmpIT3Jwa2JIUDk5eTZ2QjJ6MnNz?=
 =?utf-8?B?R0xITFZYSEFVWjhocXpmMDI3WFAyTUhoY0lXR3hyb1ZINHdpNU04dGhsWDhr?=
 =?utf-8?B?KzIrT3RCQkFjOHJCOGxDaFQvZiszbWpPQ2FWNGduaTY3SzJaT2dOSmZVaTJ3?=
 =?utf-8?B?MmFJSmFlL29UNzR5aUNBcE1oaTNWbjlYTC8rWjdReXZMYlVKVlJ6Zm1sYVlm?=
 =?utf-8?B?NkY4UU5qOU9hK3JJSFZyaGpTbmVaQisrS2Z1VldRaEl3aE9nV2FjUmxVaDYy?=
 =?utf-8?B?WDBBMUdpbzBKTWVEK3NKUFlJOWZqMGcxWG1LUVFxajQwT05IZE40NXQrWVJE?=
 =?utf-8?B?TjRPSTdXU284dFhGUW5QSjd0bjd3bldqT1cxMkR3VFJmYUkwMnljcFZDYWFi?=
 =?utf-8?B?WEZkek4zeWl0cnloVjV4bjdWdXE3bmFvcGsyTXlPUU15UjZjUG9VcWpmNjV5?=
 =?utf-8?B?eWlDWndDenJTODhpbHNYSlpKN1hRN1drS1JVV21rTUxpSWdQQjlmdFRrL0Vq?=
 =?utf-8?B?VExkTWE5SHlQei9hQmdMd3dmd0xUb3AxSW9PbUtKVGZjYjcvSFJSRXdzRFV2?=
 =?utf-8?B?N3FJb3c2MWVpUEN2cENtRlhwckg2ZW5mbytzWllieUdEa1hTYUg1MDhtbzhn?=
 =?utf-8?B?bnREN2IwWVMvS0VaVTBma1J6YlNsQlIyVHdYQ2pVY0ZtOUpBRXByalUxQlht?=
 =?utf-8?B?eWl0NlNnSlkwWTVWSmJ0MCtUT2E0bUFOWVZ6ZFJNbUFMdG1nVVdBTkJsNHpM?=
 =?utf-8?B?KzNwR1VoLzY3d0FNTnBNaVpMRVc3VFhPZittcWs3bmd2dXNZbWhwOUtzNGtt?=
 =?utf-8?B?ak5jV3JtY29kUy9LL1NNRDAzL0xhdjdWRWZSeW82YWhmd0xXbWl0VVlsL01J?=
 =?utf-8?B?d0gyQWhMNyttN1EwOUhodDJJQ1lMVngvQkNURDhCdHJzeitHWHVsZ0VzNG5a?=
 =?utf-8?B?OWh2bjg0Sm5IZU1jdVZCVmJIbEVGTHA2WDlMaVJaTzJEaXF2NmZhbHpwNW1y?=
 =?utf-8?B?V3kzS0krVlpvdlZnVHNiOVFsNGRka1pMOU1NMmQzQnI0T21BN05MRWw4S0JH?=
 =?utf-8?B?RWpjcXZXYi9uYWF4RW41aFZnZm5yQ0p2bERkRlBoWGZIdVVRK1VQaDhySmty?=
 =?utf-8?B?YXZLWHg3N2lkNFB4VGk5eVlZNXYwdnFuWDRER3hoQVhVL2FlbTlXQVdxZVVa?=
 =?utf-8?B?RDFUeU8vZTFVTDdpRFB1YnhaMXExbVh0NjJRdWlrTE0wS0dldmdLWTJRTVFV?=
 =?utf-8?B?OVRkOW05eHpCQ3RFSnhGOUQzWnIwajBxUGI1YlR2Z0xvTDE2SzNEYXFaMW0x?=
 =?utf-8?B?cDVhczY5NHJMM1FiNTJsSEE5NEZnbSt4VGJMSjIweWFhV3VocU9BRHpoZUU2?=
 =?utf-8?B?ak1PaVVydHJQQVF0cm40ZTk2aTYxVU5MOXdmYVkvdlFBekMrS1N0N1VxUlhu?=
 =?utf-8?Q?gifQhEFpyX8IaBqqREWmFFDcDSCLubCTFWN7aY8F4KY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVR3NlVQM3FndURpRGViUGlaOUJ5YmR2d1JJNmJKdE1kR1htblhjRXJxaHNm?=
 =?utf-8?B?WWxLcjNhQzJyZVBsUGxibXBjTmQ0dTE1Rm5TYlJwWHdVMUJhZXg2UVROQkR2?=
 =?utf-8?B?VE9sNk04SEEyUE9EQStCMmNpS3lPbWdDS3l3SlF6Wm5Kd3dPbjk4ZGRGZ2ow?=
 =?utf-8?B?VmVJN0hGcjU4TGJBMmFpOWc2ZWk0NDRnQTg3OVR2WStLNExCVDZlazBmQmRx?=
 =?utf-8?B?NmJoOENuZ01ySTE3WXU1ZVRqaUhEaFZMRFp3THVjd1AwTlBJckZSdGt3RWFK?=
 =?utf-8?B?V3dZbHVqWnFBUXdkNjFaMGoxQ2h3VVdISHZ6WGREWW1pZXlVQjZDQ0YyRmVE?=
 =?utf-8?B?UmFUZE15Q2xJTnd0SkFZWGNMbitydCszNnk2Q2NGS2trM093cm5ZSVlOaWJW?=
 =?utf-8?B?eXMyVGcxU3k4TXpac0U1ejRDeEFIbHZMcDhISWhkR0Q4aGplbWFvbS9oZVR6?=
 =?utf-8?B?N20rd2kzWklobzBxSDZaMU03ZFFnV2hXVXRzV3g2VlJnRnBBZlowTUVzUnZO?=
 =?utf-8?B?aFVnd1RPT216RWpGVU1uL2xWRm9oeGx2M3ErR1FZL0FUTGk2SEV0NUk4aHVV?=
 =?utf-8?B?MWt3ckdPeEY1NC93Rm9ZY2VpWHBFNzlQNHBRRWlwS2RVRlIrcW9tL0tERjV3?=
 =?utf-8?B?b2ZiSmVsZC8xRjBRaUVnQmZOeG1ncVdzUmxUTVdjcXZFUjlHdXI2RW00Skdy?=
 =?utf-8?B?cnhHVVBlYmErVUduMnd2bWhldmtlZ28zcFl4YjYzNTBObUdIRTI0SHB1VDdx?=
 =?utf-8?B?VVA4dStRVjVxdElWR2RYTTVyRFg5R004MENyUllzM2VXME5Zd3RtSFJoeEls?=
 =?utf-8?B?R20xQTl5R0hiRlQvb1NJSHdMWFdNVkxhMi9zTEUwUllRZ1p0UDVWSmdJdW14?=
 =?utf-8?B?YWVhZkR1WmlWZmhRN2tYZ0FJNEVWUjU3TWhXYkNtMzUxWklUVG5XdkwxWFZQ?=
 =?utf-8?B?YWQ5T0dOUDU4VjRVNmpmUExORFZGQVVabnl0N09nMmpwSHVDOFR1M3JBblc5?=
 =?utf-8?B?Q0ZZdFBQS1FxZ0UvV01vOGFxdzQ0UnFpVkkweEpwN2t5R3U3NjZLaVo5VkhP?=
 =?utf-8?B?ZThoU1BmT2hienNtSE1wMU5CMzVVZjdRVjRQaFRFWFd4azNwcWp4MldFVlBJ?=
 =?utf-8?B?S21LRFQ3TTBDYnQ5Q2VoNjU5NWVjZ3V1cStoS0RDNUdWUUhxODBmWWZuUVdC?=
 =?utf-8?B?N21yZW8yL0w1ZUpSMUZMNExjc1c4VnlmUUtDbEZpNHp0QzlPdEFBS2s5K3lq?=
 =?utf-8?B?ZHQ2ZGhnMEZocWdjWlZpUkNxV3V3eHhiMW8wcjZEUjlvMFdvaUZKQVFGN0hQ?=
 =?utf-8?B?RWdubnZFK3F1VkdzY1FXQ2FQVHVwYjhrUW5kUU5wOWxXQ1htRStGOENJYWFm?=
 =?utf-8?B?dGFmemkrM2JCZVN4UEhsWmJMS2JyeGUyRWo1NTgvWkxPV0ZWV093NHZTVXI0?=
 =?utf-8?B?L0ptWlRySGhkTHRBQ2ZEdVVnNTB1VmQzRk91OXBYQlhQRzlMTGFXTWkyQXR0?=
 =?utf-8?B?YlpPMHpZUklhZzd4cXhXSnUzWTdnWjdURVhSWmxFS2NuMmZTNjhlYmozdWZP?=
 =?utf-8?B?VGxPd2k4eXgrcTlyS2RISTRIYU5XUzY2b0dSVFR0M1hpd1I2WUVMTFpnb3VZ?=
 =?utf-8?B?NjYwMzcvcHJDUXJMTW5wR1drb281aGs0WGpGWGkwR2ZGZWdSUXZNbFpHVFI0?=
 =?utf-8?B?ZW0wSWxpQnZLMEZiWGcwSkhJaUNUZm9OUWtMQUFKSnIzS3diWkdrZEh1YlAz?=
 =?utf-8?B?ajdrS0NYb0RtSUFhMDZwdHNadGVNTk12V3RXZUhpdGtScG13LzErUWFHS2R0?=
 =?utf-8?B?Zjd5SlY1R2VzN0xVTHJFbDh3dk5HaUE5NTRTRTh0cWdqNk8vTHkzRTd5WGZ6?=
 =?utf-8?B?a0JpSVRtRXh5R0RBQmUxa1dQa3hEZHh2THNQdldEMnI1NVRsWjhrMUF1QjNs?=
 =?utf-8?B?MWR5cjlEemg1S2JmWDVLc2lVb1JnYWxqTzVXYStXbzBBT2llM2htMk4xYkFZ?=
 =?utf-8?B?NUdkRE9Uc3JrajdyWDZoRHo3ZHRRUkJSQnNvY2dBbTZYWEIzTmtzMU0zRFU1?=
 =?utf-8?B?cTAwaVdwVHpEVmxnVGtkQ01XMUNvT1BSOGdwa05xKzBhZFNCSWswZndBV1Va?=
 =?utf-8?B?M2dzbWxVQTkwOC9wN0RzLzlGWWlnTzhha3BCOStaM0NqQ3hZU3BEVTEzZkxP?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 649207fe-1304-490c-fd2b-08dc6ba0718a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:40:02.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AIWpivDjjO/RETq31IvuV7Yd8KU74NL8/aIXpkPihsV4+54cUIv3YcuZJawN7I1IGQ2yGlfGU2fr976GF7gz7KIgl/ToV+Qoo7PT/mZh5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7434
X-OriginatorOrg: intel.com



On 5/2/2024 7:17 PM, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...the following error occurs:
> 
>    clang: error: cannot specify -o when generating multiple output files
> 
> This is because clang, unlike gcc, won't accept invocations of this
> form:
> 
>     clang file1.c header2.h
> 
> Fix this by using selftests/lib.mk facilities for tracking local header
> file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
> be passed to the compiler.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Fixes: 8e289f454289 ("selftests/resctrl: Add resctrl.h into build deps")
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Thank you.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


