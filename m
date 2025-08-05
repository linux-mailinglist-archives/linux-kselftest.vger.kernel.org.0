Return-Path: <linux-kselftest+bounces-38305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DBB1B7B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301261618D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B847275B07;
	Tue,  5 Aug 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTSOilPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3919343B;
	Tue,  5 Aug 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408381; cv=fail; b=RlriwKx6p0iYDvIOJncWvUYzCfp90y33QCIeGq9JNIdROBYUMIuVWacgHUVAWqQ9MH3KP5Mrtzg79MpmldJllB74K8AMP6PR49ACnNackjWrNScHpT9yJ0qXC7QOyAkIyA/NgaLBwgsddUcQMne8pn0hXJWEPYnjtcEqhD5z120=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408381; c=relaxed/simple;
	bh=KYcqkZE/hefq855Z9sbAAeowI7nR+4gRRxVPQHESZu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IeosrPCk4UL2bHzTk2+NOa4xnWc6PnGOlpgVqsP1T59RJ7uR7DCWW/KNAulSJawyTD0mRfFFQbuIG2w0VWujY6qPYsdNwPwdzg0A24wi5Rmaf6Z0o7D1RSTptHWT5WFcpgyt8+DXGI8Unoe5NZ1c3ab4V/9SvLdeJF4ZRkr2AfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTSOilPw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754408379; x=1785944379;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KYcqkZE/hefq855Z9sbAAeowI7nR+4gRRxVPQHESZu4=;
  b=jTSOilPwj7MeIWzH1wvEOmsmWxte4SZCeNrAklFpcfFMGIy3Muv/LRUc
   l9R3MhFdBw7X8zVD1h3ewl9LiMsyzOhbLpRdNbPPuK/IQayhZZyrf+ju3
   dDQVYuG1HM030mE5TPw67fDXkiemGn2wGad0DZmMFAJexoLJTl0WcaLN1
   jfTd+lTmBJJadgTGRO36A7PbJqGwI3EQaA9k8TuSVF5wSfND/8/qZDSUt
   M3v0ZbpJeppadLVdK5H9WjXQQAY/1LYqaya7Xc3yxWfFAfgsyW8NyZSaA
   woFXEmweXnPOMbmm5ed+WtAnjF7OVlQsZ8MQsUxrJXFB/SXpSnuLF3LgT
   g==;
X-CSE-ConnectionGUID: jV/YL4buQUaz3JurZ54gEg==
X-CSE-MsgGUID: m0uI/BtqSwK07khxwgVNOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56790034"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56790034"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 08:39:38 -0700
X-CSE-ConnectionGUID: asR9xw0jRgGmLeR+OL+2Uw==
X-CSE-MsgGUID: PAckntgoSiKxLqjm4mZ0+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164942717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 08:39:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 08:39:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 08:39:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 Aug 2025 08:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaHK3jzvGOdDyA1RiUty9ysaGgo/Dxh7ShQTlhYwG+Kw4Wvpe19bLaHCsRTIvLiIWgmifO53iYMYFD998GMkqnzvgUIiDNl184o9UK8IWylsg+b6mEdL5bFDZpCDZeZ4bpC/CJq+dW28g3YCvIpvNTHKOhOTvDN94Whdyq5nSdartg5jDhYODDw2HrxIKsS4N3b8iIWhhy719lVrC151aIE8OiKdrNQGDNBwmNhS2QoSBxhv5wjiJFuo2v2l6HaVWYZbCfviQzAzi8GTNArpKwa02x1BPYCMO+lvWzYm2I9AuytU02LGSwzuITU+mMIfe+uGsC1o/oWAb+TU4JYJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VNoeL8NAph3bFfPWRJSFn9HTOFdB+iURCMI7KV9XrI=;
 b=fz1WRnIoz7bfN3iLg3Ygug/BGDiDr3PKZF93k5Z4lUR+MGuWsQrAbsXGGnkkgb2uQ5GUyKqhIuD65T8Xt18nBF7NTZRFBJfWI9BQ0B3jNlVf3e5j10nUUzoleY/r077t9nW7P/ce+75sGkduLIdkvsL6GohGOFp5Bl/fOHd1pbCOW8eBUYw5VIXwVcVqc8PcoWCB0OF7tVURbiAmbQL2UjucSIyNenUoEp3ZDBwA6FcpSEqjuPj5zxyn48S8E3T+ueGZPo+8/1sgB7/6I5OO2weKNyBGr4d6ZQqW9upBgWRoScMMNfNXgLMuKYIhl9g/Pc1ZRJ8Ed7NnDli7qE5hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH0PR11MB7542.namprd11.prod.outlook.com
 (2603:10b6:510:28b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 15:39:34 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 15:39:34 +0000
Date: Tue, 5 Aug 2025 10:41:06 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 05/30] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Message-ID: <68922612d9712_1923952949e@iweiny-mobl.notmuch>
References: <20250613191359.35078-1-sagis@google.com>
 <20250613191359.35078-6-sagis@google.com>
 <aH62f9X25LHuUx8n@iweiny-mobl>
 <CAAhR5DEQ9QWfdzO1yCuFzYjju+Q=pDGbcYyRWFmA_6tc8A4LNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhR5DEQ9QWfdzO1yCuFzYjju+Q=pDGbcYyRWFmA_6tc8A4LNA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a6e478-a882-417c-2d24-08ddd436473b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVRvWUdwVDc5a2lvaWpubVEwdllSTVZwSU9uVk5ZMC9tKzd4Zy8zTUoxc0hw?=
 =?utf-8?B?dVhrVVNhVXQxVmJkTWVEU0Z4WHN2eTdUYTNWSFNBcTR2QXJJbExQc3dLekFY?=
 =?utf-8?B?eDVFMDhFRW5TQ3VDalZVVHRGV3VjSkhQK3AxcDlMYlU0MTU2K2UrbkVPSG8w?=
 =?utf-8?B?UmhKeWVhZFRHejBhd0V1bEttTmlBdG5TSkcrV2IrRkNzWFBhVldyT2dPOGgz?=
 =?utf-8?B?dnR3WTd2M0VTT3l4S2xPUVRoaUFHbURFRFJBSzZJS1B4QklnSWtkVkpFWlF4?=
 =?utf-8?B?Z2pGU1JqT0l0SDZXc3FpRWx1T0hkTHJSWnpkQzlMMkRORzFzQ1ExZG94ZkhN?=
 =?utf-8?B?dFU2aHo0V21pVlBNZTFYaG9xRTQ4dDhlaE5KUEtVSkVLMTFaTys3MHllK2Yy?=
 =?utf-8?B?OWxHc0c3L2o0L2pFajJMSHUzUlcvZlF5ZzA1WHRSVldDZFViS3lsRHZLTEVW?=
 =?utf-8?B?cWNKdEFvbU1kZTJKRUNqUUpjcE44a1ZHaldjb2toK1ZoNUhCSFRnd0NkQXdv?=
 =?utf-8?B?dDhBR2VybFdNU2tLaVgrQ1lWUWFUdkZHUmN5SzZUV3NiR1drbjh6OStKTFhL?=
 =?utf-8?B?czk0alFvSHA4TGE1WVc1WFh5Z0ZOQjd0dXFNR2x0emVWYkFkTTR5ampqVmc0?=
 =?utf-8?B?QTJqTUlOa0RCU3NRWVZWczdFZzlOcFdzSHE5UUhmWXE0YlJ3cDQzeHhvUnlY?=
 =?utf-8?B?aW1lZ3d5WkRjTkJvbEpJV2lzSGRGbkZRa2pTQXppU04xWHlYVGY4K3dKdGJW?=
 =?utf-8?B?ZFBpWWRhVnZwS1cxOWF3L21NajhGVVBpM0VDZjZRT1dUanR0MU0wMCtnTGhx?=
 =?utf-8?B?Rm0zWkJMMEFpWXRFOHhGZ1B3Kzh6aVl0SzMwcC91eTNUZ3ZFY3ZNUUlWeDZR?=
 =?utf-8?B?aVAyNS9SbkhEYmhWTTBmT0JXMW9vMUFYVHVZcnFwOENDR0ZFWXJVZDZ2M1lY?=
 =?utf-8?B?amJIdUZ6eDBtcmdsZFJnNVErR2dOd3VnT0lHbnd3cXVubDVaWkhJdmxSNFpa?=
 =?utf-8?B?RmFBcVk2Y1hMZ08vVWUydTdUYmtCeG96M1VPbUdDZE5jMXg4UG9pcXNXcU9F?=
 =?utf-8?B?VG9pdlM1L1REOXI3OXZ6ZUNKc1lPSm1rTXNGTXdBSWdaRk1LcjBGU2xRajRD?=
 =?utf-8?B?SFFuSEVoZXRoZ2VVbVBkbmZXREVkdk5RSXdzOTNZTzJqdzNDQnVvOUtUYVpS?=
 =?utf-8?B?TDgwcHE0WVNpZ0NmQ1JGUnBLVHpuNmhaWUZURVhHdHJwWTRGZ3JOZkdnK21m?=
 =?utf-8?B?amtYYTZqYmRpRmV2bVRNREJZU3M1Y0QzdFAwcDhmaExmc2gyNDNYeHlBZk9Z?=
 =?utf-8?B?azNJdHJUdzdtUXFxNTQrUmlnUTMzOUFGZnFuT2wycjMxZHgyZFc4TjA5R1Fz?=
 =?utf-8?B?d014S2dYR1BGRzVPR3o1K3I3Kzg3Z0hJV0dNQjZoQSsrSHZuZnUrSmppc1NM?=
 =?utf-8?B?eTFwUGlNcDNFQVlxdHlMTWhudkNKS3ZndlViOUxRVUhlZng0NUc5UXU0M1kr?=
 =?utf-8?B?bityaFlQeXhJOVAxRXB6Y3JPYkF4VTY1TjJCQ2lqSGZ1RkhlRkdjWEZvUmo2?=
 =?utf-8?B?MXZka0hncXQ2alNLa0lSK3ZncU5iY3pJblZDWEgxUUtwL3I0MDU0MjB0NVlz?=
 =?utf-8?B?Y2I0cW5TUTJuaTdnelFvcHppQ1l0WUh5NkhJcXVub0RlSkZmUFVsU2ZzL3lV?=
 =?utf-8?B?anUyZVJxUnp4Y2VuY2V5K0FMUXRieGVuMXZUbzVwM1hETEorSzB2TlN0aTR3?=
 =?utf-8?B?YjZPT0EwVnh0ZEhrV2ZwUGsyU2ZsZmVIQjJTQnR4ZVFWQ0xDWHpKY0lZUjJJ?=
 =?utf-8?B?NW1tbm8yMGhVbVQzL3luNzFIZ1FRZFQ5VkFtM2phN3pnVFlZcFI5QUdZZ3d0?=
 =?utf-8?B?WkVzT1VLYVFnUDdpVW5ldzBmQUpXRmwrYTJNNTNpSnhlSFBSL0ZMR1FJZW56?=
 =?utf-8?Q?HI88sBeeb5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tGQWtGUExaaTBHaTlvazJJTElvRHJRNE92OW5qTGVTZHRrbGVvbWZIOEFP?=
 =?utf-8?B?bFREVVJOYnRjaUF1NzVCcFloNEY5b0tKeHBpaWZUODNZL051UVZacE94aVpE?=
 =?utf-8?B?bkdxcFY1c1ZjOUxPTHFoTUordmFiY0xLSVRIOS9aMzJmVmFxc3doU0djTnJF?=
 =?utf-8?B?cVZtSHU0Z09Bd3IxYjN1Q3V3eklCY1VVanM3M1BWV1Nsa2E1OXhHRGdIcDBE?=
 =?utf-8?B?b2JwSGRKV2xBWCtYdXo3MjdhdWJKd1BsWFh0QVFwYmRVM1o2dHZVa0hZbVZt?=
 =?utf-8?B?UzM0VGN2eWIzeWhlb1BwbXJXRHdSalQzZkt6aUJwdXpBVmNuQzU0blI5Uith?=
 =?utf-8?B?ZVJObGZkTjl6QnorRnJybERtRDNxNzVBR1BMVGlhVXVuMUt6eE1KUTVhTmc0?=
 =?utf-8?B?ai9zb0pKc3FoUzJ1dm9BcWxjd1UrSmpqK3g1NVVoRHBtM2lYMFZtZVBQeWZZ?=
 =?utf-8?B?b3laNStFUkdFZmRkTEs2Wis3Y2ZYRDV6MHBBbVJKWUJsaHV3VmJvakpMWjd6?=
 =?utf-8?B?VVIvd2VyaEppZG5iY1c4eFR1TG1mcVdJZG44M3dubTAzNEpuRU1HZSszRWZy?=
 =?utf-8?B?OVNuRmJPc3BVWVJLTnFtWmxIbStKc2hCU1pONTllT212MzBuaFFBcW1aMHNZ?=
 =?utf-8?B?Z2c5Tm03TVkrNWhnSDNUNC9uaGdhQVE3TWN4QnB4UXdkUE54Nkw2Qm5ObXhF?=
 =?utf-8?B?NTdJcEcxZDFDcmhyc2pjNlQ4NEFvajVtVXlDYitmbVFYcGVvczdMQkd2Qmx5?=
 =?utf-8?B?a0kzTHo3dHAxSGRiOEVuSEhpb3pmNEVRb0k5SytQbnVuMGpNdDYrWDQreUVJ?=
 =?utf-8?B?YXVSTGhudDErNXRDT1lXUCtVa3luMUVIWTNiQ2xoL0ZlN1lMWU1LVnZIcFFw?=
 =?utf-8?B?NmNucm1PZkg4UnZLaS9Hdm1za2hYMnRCYVIwSkVPR0FCaUlzUlNOV0s2dXlr?=
 =?utf-8?B?U04yalJXOVEvbDRtVlVjV0ZHS0huVlZzcStwMHdIVEZab3crcjUybmNwa05O?=
 =?utf-8?B?aEJHU1ZybUxpQTBSOUVKZ2xOM1kwRmJaOStheXFNaXFrb3FPM2ZCVk84ejJw?=
 =?utf-8?B?QUJnRnhwV0N2ZSs4Wnl1NWRRMUNlZzJNRUd5ZzhpMEh2KzN4WldaQ2l1S091?=
 =?utf-8?B?Y2J4RXREUHlBeE9KYnBTbmlLWHFGNUNSNzlURmhFcXhhQjBYQUdtL1Npa29O?=
 =?utf-8?B?cktBY1pORnVvYU9taVRadDRlMUx1Tm9FeFBuRXB2aTE5NU02Q09lQXo3YUFB?=
 =?utf-8?B?QjVQMDRnQllVa3gxbWVBT0IrZ2hBeEFBd3FyWTVsK3g1TnVnekt4anNja05J?=
 =?utf-8?B?d084enoxVXZES1RIODVTQW1ycHpyRzM0dWw5TnphN0NKdnF1WWhFbDFmeXBv?=
 =?utf-8?B?WC9nV3hteGZ5WHJhSjZkOENvbmZDYVk4ODNZMlNjUzkwOCt1aDk3eGJrcERW?=
 =?utf-8?B?MHIwYUVFYkVhOGp6cE41RTZBYkY1Qmw2Y2J3ZmVPbytzZXh4cGFxbENZRWEy?=
 =?utf-8?B?M0ZJWE9hQVRNS2QyRklROWduN0pKdTh3OFFoa2FtVmZEWDNyb01FekViQVZY?=
 =?utf-8?B?ODIvMUkwcldKRmxxb2ZBdDI5b0pRbi94aXBzdHRiRi9ScUx2bmZRM0ZMSVQ4?=
 =?utf-8?B?VnJZU083L1IrY3R0cmVYdFdXSzNLU3hsMmJXTXF6MUpDNEFaVzg4Y1BUeEdC?=
 =?utf-8?B?eHVxdUNycjcwbjV0UE5Cb2JjL2tOaTl2SlM1QzlxZ2ZHY0tGa0VhYVVaMmJW?=
 =?utf-8?B?ODNURG5pYTFiTFgyREhHL082TTFQVGtNLzhzdGZFSVF3TVJ5MmhaWG5YZDRQ?=
 =?utf-8?B?ZWtQb3czNWoxY0QwZG9IYlpidThQQzB3M05kRzFDaEMyREhJNnozeVhlVCtV?=
 =?utf-8?B?Z3N3d1ArOXhYMjZmZWlTMUVXcmhOQmx0ajZCYTdhS2QxSnBTZ25tVjFxeGg1?=
 =?utf-8?B?NEFKb3FHUEJoRTNBbzY0YU5LenRBOFRkbWlxRFB0VVBjUHlROEd4VGpLQnBJ?=
 =?utf-8?B?eUxHSVJEL0RBN3U0MFpOWnVDclV0S2lqcUxacklNbGFoL1kwaUh0RDdpNy92?=
 =?utf-8?B?bjNad01zQlhHUmpJR29GaXFaaVNjWS8yQmQ1ZjBJYVR6MjR5RGU0VzEyVTBJ?=
 =?utf-8?Q?9ROL8jmdvb0Yk0yC0fwuPO/XF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a6e478-a882-417c-2d24-08ddd436473b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:39:34.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8iIE82qhy2q2d9NDTY1/IHps0WGTQxylpe58pfSAoDZnTlamVXdF+CAie/tpCiC5ef2nigIC46xwSve+QhUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> On Mon, Jul 21, 2025 at 4:51 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Jun 13, 2025 at 12:13:32PM -0700, Sagi Shahar wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > >
> >
> > [snip]
> >
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> > > index d082d429e127..d9f4ecd6ffbc 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > > @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
> > >
> > >  void kvm_init_vm_address_properties(struct kvm_vm *vm)
> > >  {
> > > +     uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR)
> >
> > This fails to compile.
> 
> Looks like it's a simple case of missing semicolon at the end of the
> line, it builds fine if you add it.

Yea.

> I can update it in the next
> version.

When do you expect this to be updated?

It would be nice to see this land soon such that we don't have to keep
carrying these patches out of tree.

Would it help if I review this series?  I thought it was relatively well
reviewed.  But given the above simple mistake perhaps it needs more
review?

Ira

