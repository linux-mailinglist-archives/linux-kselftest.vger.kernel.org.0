Return-Path: <linux-kselftest+bounces-39896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4124B350BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 03:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FC244EA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 01:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBA265623;
	Tue, 26 Aug 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIkUmgX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D741BD9F0;
	Tue, 26 Aug 2025 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170496; cv=fail; b=YifyPJmvasizG/aC/g4OdOC2EAai+uLguo8Pz5Yvv0U/GleF3h0MG3Opgw8fnoHEMMD5DGsPDCgkYsGmPpvAN6Jb3AU6981fjm/kLbYJ98Q+74eqpXjajl1NbEVqLxo415gHN6YeDDOb4V2wxs4sJvcYu/qyiChuN+Dri89/Juc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170496; c=relaxed/simple;
	bh=kci+ON14z1riSb7sDgeA/ju0OKcgMptvEiffRXG/eV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=foTAlQ81qv2BPnQi6dYjqMLDAzIfRNQD8V4Vg1Edhcu7JiHezye7NQJKE+WrJdUwBbKPuSyoVjCw1GX6c6WOwBRoWaHzpzxXfITKX4XugjmG7fMZG2y4bs0SRzoLmHK0HtCJJC/tOkU/dCNLi+yMjy0gPjbvrDIda5mLlUJmSCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIkUmgX0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756170495; x=1787706495;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kci+ON14z1riSb7sDgeA/ju0OKcgMptvEiffRXG/eV4=;
  b=mIkUmgX0WCeZQt4fHjBdoqwxOYwKdQY//quddd3oyX5wDEhYzJpLJnCI
   tx46q38B+YtFGdLE1jwOemjzH2ic4ZTdR2ncwklUnyTQ/XXLiuS+WDAQi
   kDYDWKN26chXG0zUTAoDo9k8jEzcdqa9NfEDMfCfyahYwyb8QwgwdLCDk
   gRVVQSr8rIR7tpzrxbzujDcT78KfQHrK7kL98/ViUdETO5iCtUoHp6t3+
   8cHRGEicP0OC4R9B3aGZLnDOXtXG4byYipO8QJouHIGSWEHBtNrkBwYXF
   Qn4apFvpboT596TVykLDL6CYRcKw/Sx1tNrxncYNoj7+MB3v6s/JVVg/G
   A==;
X-CSE-ConnectionGUID: XMhrtAhVQJ6HuJvz7VJJeQ==
X-CSE-MsgGUID: vRK2il5EQo+a9xQNocuOkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68987776"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68987776"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:08:14 -0700
X-CSE-ConnectionGUID: IHL/D6ZhRwKvplAkQokxDQ==
X-CSE-MsgGUID: QUS8b9irTsyL+ax0rgCQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173614367"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:08:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 18:08:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 18:08:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.84)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 18:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7hz3FoubdgWxfAQhCnO/DB/OlrZDEiv7xCKkWrzadVtpgHUA2iPUpLgwehdGYcMug/sF0q2+5MdH3haXSO/mqKnO+yqMbz0azprLiHjD8jAGbcQCZ4iKClrOrkUSf7S1O5zV3QM5B0cJGcgfbG48jsynQ3jguOGJp4jeCSK2L7hEOEIGeluIiRyTEVRZNPO0rMfBNitlL+mLQiGvSoNMenmDGI3qG2JiOsCHJ069LLXWbiqgfe3gMXROYZRKfcveZIpDu6i1XhAyhLlRS0vbEfJ84jjUFdZw41zImGgGirqmfYtMHifhVVXALtCbb33kKp5KQQXuK42fylVTun7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHM8r3aw0Ck2+HdyjlDJugSYFZjHHOn2r5FWF8UGuMQ=;
 b=EbfAPj+7Qr08LVGv/McTzMMP7yvGpYfJpUuIO8rjzw4B8SGcEBZ90xPtz+XvnPyoTDxxX79WbcfG6BeWRxlczeg8+DKe6dw5/roz4HRY+couSbeRg/EgqI2zne4GHkKaS9QxIoEXG8I+ExvLyO1HbEI/5EnyVoYP+VjsXPu8u6KTaIadDh6noDN+39wtm85nj5raUxPrMPXHY6qnHaDJWZEDDdzLF9ZNK+o7hcuVwfXut15k85H8ViCkvrjd9ekUQ3/sIN0x4qp5sY4fxs51Jdw+DZ8QDg/p/GqbjF74+1Ql8x02y8ZiaMynvNkG9XbCC5qkwzhZUoTwFJreqs0Rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 01:08:09 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 01:08:09 +0000
Date: Tue, 26 Aug 2025 09:07:18 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <aK0IxsvmlNvc/u7j@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-15-sagis@google.com>
 <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
 <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS0PR11MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd72eba-8643-44b0-0d19-08dde43d05ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJKMUhsQVFkVytuSzZPNHljaTVmS1l6YmVQcnE1YS9BbjgvTzNwaThUZUVq?=
 =?utf-8?B?ZTF3SmlxRDUvZ2JVcjFSM0pVcGw4TlpUbnR4ZDRBa0hWMWkxQ2xjUjNzZ3U2?=
 =?utf-8?B?NWcyZGcwNFl3SlU0WlQ1VDRhRjlRM2tUVGwvMlZlRTI5aTVEUUsybDduTXF4?=
 =?utf-8?B?MU1ncUs4bXYxRVV1S2Z3YzA1RzBLUkpDbU8zeHBJYWZNZ0s5b05meVpMR05J?=
 =?utf-8?B?eDUyN2MwQUdqN09tcmNCTjQ1QWZBcllJYitweHVFNExiN2lWZDQzcllwekxY?=
 =?utf-8?B?TUN3YlRhUEF3eXQ0SHlNUnpRRWs3U2wwbUlsYXM2SlcxcXNuNUVrNXg4dzhV?=
 =?utf-8?B?aWd4ZGFwR3h0TjkyKzJUSis3akdVcEd4TFhiOUdBK2NLaHpFNUFoYXM5TUpW?=
 =?utf-8?B?akt3Z3JRWHlpRmdkK0FzUWhUVmVid1llZVV1MXM0Mi9QaWxqd2N0QlhiOE5w?=
 =?utf-8?B?Zll3ckY4Y2hza1BQaG1BZnB6N1ZqYXpKRzJRaDJxSm5idTlBV2dnRVNLa29x?=
 =?utf-8?B?UDk3VkZtUXh0M2RlalhiME5wemxVbTUza0k0aEdISXkzTkZzV001Ull6dFpo?=
 =?utf-8?B?MU5sMmU3R3JhNWpiaU1VNW9mZys4MFIzY2lpb2x5OEZTTUNBZHRSZGw0R1Ju?=
 =?utf-8?B?MFJCNHRycEUzaUI4SUtqZ2pwQ2crbTlxZVFPT3JwQmVMUjNJUUxxVTFiMUFY?=
 =?utf-8?B?S2hjMEY2aWw4andZL3NJMC9yZUluRE1tZVVia1p5TWh0NHF0Ym12RGxCUzV1?=
 =?utf-8?B?ZGhJVVpKaEE4bUtlbCt0aTBvZGNPMmtYMU5MaXZoamxON3ozYUNMWWI3c21v?=
 =?utf-8?B?MTVVVGVzSTU1bXFQY3Z2MGRMcCtmZ21xZDZCenplT3MrcWxidTdnb3dpQmVz?=
 =?utf-8?B?bWtPTDQ2SlV0VTU3ZWpqdUk0RkJQSnF0QlpUNTFNZlNmYjJVeVNMTzlEeGpO?=
 =?utf-8?B?aDVHNEhtaHNPeUxtUlJNbGF0QzVtdm1rNTNRRXowNGR6SXViZEg1dStpcCtm?=
 =?utf-8?B?czQzYWVCV2U3eDVsVU9IanI1VzdiajYwUVVqRjltS3ZpaGk3QlNUVktrdG1V?=
 =?utf-8?B?VDJZN1FRNXoxZnhRSjNJdHM0T2g0VHpwN2N0VmtydzZpN1BrRGYwbEY4bkQw?=
 =?utf-8?B?Z3hwd2tUQ2JLbkFmUEFOT0QwT0htQ0tOYktVd25qQTBuU3V5NWFjcXc1SDFD?=
 =?utf-8?B?aEZ3akFDL082eXFPY09LeWE2MS9qUTBrNGM1cHE0Rm45UVhvUmVYTGpKWk80?=
 =?utf-8?B?dG9LVUdOT01RcEVLaHExcGFaKzUvUWIzUi8zdWF1OE5pUVUybC9yLzRRMjRU?=
 =?utf-8?B?R0FIeHc2UmpUSWFuSlhUOGFlRGVPcUJ0M24wK01yb2U5ZXRGOTNZbmhNclJw?=
 =?utf-8?B?bG53QUZmNDAvZHF5RTI0ZGoxZkVQR3Y2SklUTk9DUFE3NzNBZW82RmsvR0dI?=
 =?utf-8?B?MEcwSmFJTzIyNjg2SXFudFBoNHZNTk5laDVaNHE2ZENSditKbnR5R0JNR3pv?=
 =?utf-8?B?VGxHdDFZSVNwRU00OUltOEt0eUlYUEJ1SjBKNC81SnFYTUN2Q0JkVTJidWEv?=
 =?utf-8?B?bHBRNzVjUS8zMDVPM3kxcXROT2VGRU4yOTgybitZRm1ybXJkYTVYRlRhRUh3?=
 =?utf-8?B?aC81Z3IxMVFIcUtCa3FRNkJwd3hLSU5yeHFySU83WEpVRTJ0QlRyVVV2cFN2?=
 =?utf-8?B?eGFKR3MxV3YvNXRkTVJoUzBrVUR6MHVsVVlodFRldzdTbkJMc0RkeGFxZGU3?=
 =?utf-8?B?WTZNb29ZVml1OW9VdHhLUVFnTnB0L0xrekFvYncyK2FjcXJTUERiMUtjaDNH?=
 =?utf-8?B?QmxIUkpRMXZxZURhbEVjeE5Ram9QOEJNaHJKa0JCL0RHVmJrdTVDNmFlWmRr?=
 =?utf-8?B?c0QrenRyTmc5RG5VaUQzQ2w1dkM0V2h3dXBrTGNJMFFrRWRNZVlNM294Ry91?=
 =?utf-8?Q?vzyACu27AcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UThvYXZCU0dLdE9UcDBJcEgrV2dVdmNNRVhVTCtiNGFOeERLQkY5NWgyU0hE?=
 =?utf-8?B?VUJOYXorM3VGMXI5NVl0TzFWWG9wVVZlTTNlaUt4YkkrcjZxQ21CTnd3TG9q?=
 =?utf-8?B?TkxkaHltWEYyRmpyTGRDc3BEYUhDV0lzL3pLbUpLVnBkMGNuMEZYNG9DT0R3?=
 =?utf-8?B?U1JESDRieVh0aGNFMitWbFMzd3dLdDBRTUhvOXlub0pzdDhLOXVRZlQwWGdy?=
 =?utf-8?B?N096b0hMakJraDhNRVhUSE5YeEVsalJFT0NvSlZiWC9qM1p2VGlPSTBqNmZx?=
 =?utf-8?B?SU1vQU5icGhjZTcvbXBnYXZGNGZIcWh2OWpSSmQ5Q3hQcWVoaUNmTXBlM0Vj?=
 =?utf-8?B?eUVOamUrejNySWdMR0djWERNcGIwVGg5a244Q2MrZ2w5alVLWnpFNWRxeUxX?=
 =?utf-8?B?SmVDZ2lZSUlkUGEyakJYZkNIcU5rTVZ5azlyTjJTejk1Rk84bkt1dWg3NWV4?=
 =?utf-8?B?aHRmMm1jbEVTQUNDZFArTHJhVjNBL20vanp4cTAyOGRMRGZxa3NGSzIvZ0Nl?=
 =?utf-8?B?bTBxalFxZjExQTc5aHE4OGRUSnNORlJ5dEZhZklQdlZ5anBlTEFNN0hTbGd0?=
 =?utf-8?B?MkV1NHlJdmV5VXg5MTB0dUlKc242cUY1WmV1elN4VTR3N2EyTXI0UFlUYlZv?=
 =?utf-8?B?ODRLZEhkYzkrNkZ2RXNraW5Pem5NR2JkYUc5OTE0NDJ5b1RBZnF3YXl4eUdq?=
 =?utf-8?B?YThqMmkxcWNRdVMwN2VXQ2R2OTV2dkp4TVBOL3RvbmEyNDFkdGpPSHM2UTFi?=
 =?utf-8?B?eXFnWTNtYnZsS29xYjJxbi9SZGZ6VzJkSU14WlY3UmQwMFcvWEsrYk1DS0Z2?=
 =?utf-8?B?eWRwejlQaFBhR2l1U3E2NzAzVlNBb1Y5Nmt5MnR5akhJRkhtOFg3MkgyVlMx?=
 =?utf-8?B?NFRYblNiNDZYd3dMS1l5elZsK1M3d21zYW1CcE1OUzNScXBEbVBzYlNvVE41?=
 =?utf-8?B?d0tEd3kwak83TDdKNnMyanNlcjBaVTdXTTlia0VNZ0g5OG8remttNnFWOW1O?=
 =?utf-8?B?N1VhWUdwbkEzdFY5Z01XTnl0MjJ0YWdZR0U0YkJ3NkJ2Z0dndmFuWmhmZ2J6?=
 =?utf-8?B?LzdPVklDZDk3TVQ0SWtpMS90cVBUSUFZREcwY1BQcy9BdFBGREMxZDJ3bW4v?=
 =?utf-8?B?WGZjcFpwanNVK1gxL2loS1NZUzFEV0h1dlZXTllVTmxqMWdpb3h3V3UzWSt2?=
 =?utf-8?B?SHNQTjJNSHlycWViWkxHTWZuY2VMdlR2VFZtbnBXZWkrdzJCZ1k3dHp5bWZJ?=
 =?utf-8?B?aVpMcjFtWkIxTEZ0MnlHT1cvazJXQVhKMjVzU2VBSXdHSno1cVFJRFBCMGlR?=
 =?utf-8?B?Y2RxcWJobzZMNk1GRGtxQmsrQVV4QnhnQVB1blUxelE4Z0NxbldaSHdIRHha?=
 =?utf-8?B?OU55NENiMytjcVhrNlNXdCt1OVVhNW9JUytDdFRpckpqcVJHVllmcTlxMkZR?=
 =?utf-8?B?dUVFWTRyQ0IxZ2lHR0pQZ0pLaXJkUGo1SFdVb2t5WWQ4blFaKzRSRERTS2RQ?=
 =?utf-8?B?bGdIMmpxcHFJb2VCRnZmU3drZUJqZ2wrV0ltZWNkb3R6b3ZnVEdDUmhhNlJK?=
 =?utf-8?B?b24rZEJCWlU5Z3hsZ1pESGRlMUxsSFUwRTkyWXZFaStVaXU0TmJRaVFVc2s1?=
 =?utf-8?B?Y3ZGelJCREhZRjZmRmhEaytEM0tBSFNEc24zVGtjM3ZWbSt0WURtOGg4bzVS?=
 =?utf-8?B?ZFRzUDAyZzd3ajBBNzF2TGR4TUlVUkYya3pMaEtPUjZ1cWQ2aFFMbE8rME9u?=
 =?utf-8?B?Z3kzdHNOeW9qVUpMOWRneE40UDdVT04zT3NXa0JSSHQzMVlrV0NFc3gxWUov?=
 =?utf-8?B?am1vbmxWTTNpa1dkVmNEZmdsbWl4UzZPZEFXQjB6amFiczBsbG9SaEQ5M2NY?=
 =?utf-8?B?Z3o5b3VsN002ZmZzZndFdkxPNStDOEw2OHZLVHhoT0d0YzdxN2JkUmJ1b3Y4?=
 =?utf-8?B?T3RIMUtYekVHZXlUMmtPK2RUMTJjMndQZktoZ1ZQbTBMTlBLK1pZRHY1cUor?=
 =?utf-8?B?b2kxWitEZ01xMlBnNkErZi9hYk8rQjcwdzg5bHBzTFNFclpnME93aVRsUGFF?=
 =?utf-8?B?TmF3OEw3eXVJL2VEZHRmcDF2VzhvVjlXYzBxbytPS2JpOXVuM3ZKNGFpL08w?=
 =?utf-8?Q?gdpewGgRL+ZyWuQlOr/DBHxG4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd72eba-8643-44b0-0d19-08dde43d05ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:08:09.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGEy+2ZRdEM6DUcLeLQ+HxHQJAGd0Nw5fmkSjRYtRrRU5OB57PwDg4whgKxsWT0F5ajUkOJZaqcEAqB7MJtZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 02:02:00PM -0500, Sagi Shahar wrote:
> On Mon, Aug 25, 2025 at 3:41 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
> > > From: Ackerley Tng <ackerleytng@google.com>
> > >
> > > TDX protected memory needs to be measured and encrypted before it can be
> > > used by the guest. Traverse the VM's memory regions and initialize all
> > > the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> > >
> > > Once all the memory is initialized, the VM can be finalized by calling
> > > KVM_TDX_FINALIZE_VM.
> > >
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > Co-developed-by: Sagi Shahar <sagis@google.com>
> > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > ---
> > >  .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
> > >  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
> > >  2 files changed, 99 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > index a2509959c7ce..2467b6c35557 100644
> > > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
> > >  void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
> > >  void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
> > >
> > > +void vm_tdx_finalize(struct kvm_vm *vm);
> > > +
> > >  #endif // SELFTESTS_TDX_TDX_UTIL_H
> > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > index d8eab99d9333..4024587ed3c2 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> > >
> > >       free(init_vm);
> > >  }
> > > +
> > > +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> > > +                             uint64_t gpa, uint64_t size)
> > > +{
> > > +     uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> > > +     struct kvm_tdx_init_mem_region mem_region = {
> > > +             .source_addr = (uint64_t)source_pages,
> > > +             .gpa = gpa,
> > > +             .nr_pages = size / PAGE_SIZE,
> > > +     };
> > > +     struct kvm_vcpu *vcpu;
> > > +
> > > +     vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> > > +
> > > +     TEST_ASSERT((mem_region.nr_pages > 0) &&
> > > +                 ((mem_region.nr_pages * PAGE_SIZE) == size),
> > > +                 "Cannot add partial pages to the guest memory.\n");
> > > +     TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> > > +                 "Source memory buffer is not page aligned\n");
> > > +     vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> > > +}
> > > +
> > > +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
> > > +                        uint64_t size)
> > > +{
> > > +     void *scratch_page = calloc(1, PAGE_SIZE);
> > > +     uint64_t nr_pages = size / PAGE_SIZE;
> > > +     int i;
> > > +
> > > +     TEST_ASSERT(scratch_page,
> > > +                 "Could not allocate memory for loading memory region");
> > > +
> > > +     for (i = 0; i < nr_pages; i++) {
> > > +             memcpy(scratch_page, hva, PAGE_SIZE);
> > > +
> > > +             tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
> > > +
> > > +             hva += PAGE_SIZE;
> > > +             gpa += PAGE_SIZE;
> > > +     }
> > > +
> > > +     free(scratch_page);
> > > +}
> > > +
> > > +static void load_td_private_memory(struct kvm_vm *vm)
> > > +{
> > > +     struct userspace_mem_region *region;
> > > +     int ctr;
> > > +
> > > +     hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> > > +             const struct sparsebit *protected_pages = region->protected_phy_pages;
> > > +             const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> > > +             const uint64_t hva_base = region->region.userspace_addr;
> > > +             const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> > > +
> > > +             sparsebit_idx_t i;
> > > +             sparsebit_idx_t j;
> > > +
> > > +             if (!sparsebit_any_set(protected_pages))
> > > +                     continue;
> > > +
> > > +             sparsebit_for_each_set_range(protected_pages, i, j) {
> > > +                     const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> > > +                     const uint64_t offset =
> > > +                             (i - lowest_page_in_region) * vm->page_size;
> > > +                     const uint64_t hva = hva_base + offset;
> > > +                     const uint64_t gpa = gpa_base + offset;
> > > +
> > > +                     vm_set_memory_attributes(vm, gpa, size_to_load,
> > > +                                              KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > > +
> > > +                     /*
> > > +                      * Here, memory is being loaded from hva to gpa. If the memory
> > > +                      * mapped to hva is also used to back gpa, then a copy has to be
> > > +                      * made just for loading, since KVM_TDX_INIT_MEM_REGION ioctl
> > > +                      * cannot encrypt memory in place.
> > > +                      *
> > > +                      * To determine if memory mapped to hva is also used to back
> > > +                      * gpa, use a heuristic:
> > > +                      *
> > > +                      * If this memslot has guest_memfd, then this memslot should
> > > +                      * have memory backed from two sources: hva for shared memory
> > > +                      * and gpa will be backed by guest_memfd.
> > > +                      */
> > > +                     if (region->region.guest_memfd == -1)
> > Why to pass !guest_memfd region to tdx_init_mem_region()?
> >
> 
> Not sure I understand your comment.

From the implementation of tdx_init_pages(), it also invokes
tdx_init_mem_region(), which further invokes ioctl KVM_TDX_INIT_MEM_REGION.

However, if the region is with guest_memfd == -1, the ioctl
KVM_TDX_INIT_MEM_REGION should fail as kvm_gmem_populate() won't succeed.

So, I'm wondering why there's a need to for the case of
"region->region.guest_memfd == -1".

Or anything I missed?

> > > +                             tdx_init_pages(vm, (void *)hva, gpa, size_to_load);
> > > +                     else
> > > +                             tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +void vm_tdx_finalize(struct kvm_vm *vm)
> > > +{
> > > +     load_td_private_memory(vm);
> > > +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> > > +}
> > > --
> > > 2.51.0.rc1.193.gad69d77794-goog
> > >
> > >

