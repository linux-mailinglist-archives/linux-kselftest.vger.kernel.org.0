Return-Path: <linux-kselftest+bounces-42489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DDBA4794
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683E616FCC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273422B5A3;
	Fri, 26 Sep 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHVJ1hfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A32223DEF;
	Fri, 26 Sep 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901593; cv=fail; b=gnCb/E6J2//62pzOh4pWV7vqfdRLFvEaj4LYQmWpmMUFhYcOwxXHI2Opq//+m3+WMG8oe3DKvlDdNPigTWyF71RrsdvUBMGEI2whz3FwZY2KOHvRnDHVNaYHOWRaxs7PaoXj8BIPku1p/rUmCuX2hLmcyLjPOc6L/G/eLMQlNck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901593; c=relaxed/simple;
	bh=n6Rb/6o0oX6tfD+yxPHPh1XqfiZ119NLjqO+4CX3iKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmZ3zGWOHNCo+pnMr623ozLQUu8K12ZoinKIqh3PAcWaZfhFKxE8KDAo034Ofxt1Pi0QwELCf6yGjUFimm8V/WT8QRUfS3MrXImmv7woIwcKXx8XU5S/AlZWxZPjx51wXRf1Qf3E/sVN8vzdB7o3/8hk+d3S9nF2jHSLAixJ9rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHVJ1hfJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758901592; x=1790437592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n6Rb/6o0oX6tfD+yxPHPh1XqfiZ119NLjqO+4CX3iKw=;
  b=lHVJ1hfJLT6fzTy85x7qhEPGXhcAZ6m186LUnfLZDjj8r9HzLwS3BBKN
   WI5sulP71q5sjiw1LXpmsrc83w/zkup0cy42JcQ3FCAP8b3Adcr92DEhX
   kz9xYMNZcfVCWHOR4mx5tf1LenrvpBFSGK8fbna7emZklKRtVaQU12aP0
   wqi+g5d5MtqwE9/XcVPUuHrNvDIVxQnhcV6U2yabao83kN9O0c6T9MMu9
   8CCSEHZb2ETGPKrx7gV+0y6BHyNvEuysz7S343NdKwrsD79A4mJnALP86
   zwKwfzTr7gGFCII/8L15bg5B3oll75vkG+KJQev58HFVaAYRrCLCQRdGc
   Q==;
X-CSE-ConnectionGUID: gQzhFMyqQIe/tEQFIRz9Wg==
X-CSE-MsgGUID: /Q/F6n9WSAu1XZ3ngKRrCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61155847"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61155847"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:46:31 -0700
X-CSE-ConnectionGUID: 4T2+ah8qT0utJKVSaUBNhw==
X-CSE-MsgGUID: Y1pyvL+lSb+IjHvq/DfROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="176764530"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:46:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:46:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 08:46:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ/i83WrRvT30Ly9T9jSC0quRT4paljbkt0YrkI8CjHEoRy1r34/uTEUoqa4TBoVRE70WkZmw+8cREhF1657ToBRJctSYBHg4WDjCrCP6VhUFVCksq33rNFDrBW+zDYWIbDYb+OKo+RXQYJDkFUv7sjHJPSBbCScznSmYd4bcltdM3CRbBMnNb7C0ldXTqVgxWSRjn7e0HSfAj4Wv76krcq35/xWckNGgNAomC4moO4W89RlWlIJ4AuQaDFsJa/RKeetOvD9gDGEYA2ZSWsf+aHTZAhAIIh29GPSS8l0zOMKrB7AowIoa5DC7bOZpuzV84bneD96YCsAp78LxI7r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Rb/6o0oX6tfD+yxPHPh1XqfiZ119NLjqO+4CX3iKw=;
 b=LdIelwXEhqwwVkntHaFE/wWoZJ+3mAeO9OuEBhi3Qv/Z81MsxBg5vZ6cLUpPfywebfyaBaRW0J27wWIX6poV6mqebJsuRNq8JUnmNIKpohptYcWNoHx3A2xWhWNTNp91iODSKmBNMchS9EM6204w2tsTMtKZy0xqrYENvANjjzpDIsiLfCbO6Y4TeC6wRXkmmfcd48OYnfXc0o3cBCGRXq8UpGI3EjxRvoAMGxKlToZ1y4PwoEos1uopDNgyrDZ4b1W3dYibWeDGHEEpk6SXzIK25VaFwlWDpZ6UfUpkdUtEOG0mc5/DTuXV3xoQ7KTCooQrQhuykzu0mNymYjHO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF77ABF615C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::836) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Fri, 26 Sep
 2025 15:46:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:46:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>, "brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dalias@libc.org"
	<dalias@libc.org>, "jeffxu@google.com" <jeffxu@google.com>, "will@kernel.org"
	<will@kernel.org>, "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "codonell@redhat.com"
	<codonell@redhat.com>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Topic: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Index: AQHcKvs2dWZnb030BEKK+EDimBzvQrSkY2wAgAAtHQCAAAnzgIAADPCAgAD7+IA=
Date: Fri, 26 Sep 2025 15:46:26 +0000
Message-ID: <eab692794cbc82080b708c581efd5973b6004be0.camel@intel.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
	 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
	 <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
	 <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
	 <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
In-Reply-To: <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF77ABF615C:EE_
x-ms-office365-filtering-correlation-id: 02807a5f-c454-47cc-e5e0-08ddfd13da13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eVVQTGVodEN1RndiSFhZT0RXdmdtNm1nWWVzTTFrOU1YUUdNTVpDVmNCaXB6?=
 =?utf-8?B?eHRiWE92QWhoUXZqeWppN2hYc1lKZ2JOSDlqbHJ5UTJpdGtxdUQ4RWRTQ1Nj?=
 =?utf-8?B?VGdUN01UaGRZN2prOHFKczN2WS9KNFZCYi9JQ2hUbHFZVm12bklhYlhJNEdj?=
 =?utf-8?B?YmNpVFlkaVFwYkxiRHN4MWJFTTZDTXpUVWZJV2Y0TVRHa1dBRXJ4bWo2SXlQ?=
 =?utf-8?B?ZlFpK0hEcjBWS0ZqWlRRLzVIMUo0ZEhScEdPS3FDdHhFSENnV0kyaFFzdWtE?=
 =?utf-8?B?Y2tSWk9YS0tWY3doTDlGVEhRZGVMNVVZTnc5ejNTc01hV0p5eHhHdEJkcnE3?=
 =?utf-8?B?WmphSkphTFRkSFBYZDRQeHFSRm5FRTF4UzR1N29NTis3M3BlcytldXNaUVhP?=
 =?utf-8?B?Y01nUWdLRGJsYnkydGlPVHVid1lSNVE1VFhRbzV3U1NjcEdZS1RLVjJTQ2Zv?=
 =?utf-8?B?MWNDZlVHdnRXT1N3M05WN3YxMzZGU0FTYkxLcWpnbzVIaUxJNSt4L0FFQkoz?=
 =?utf-8?B?dkZMVWNEWHN6c0xWcW95a2prMlhiTGs4ZFFnRzhVZ2tHOU1iV1V3UisySFhr?=
 =?utf-8?B?WDR0WE5PU1FZQVZVNWoweExuSXJlWmRoMjEvVmxBdGprSHUyYVRocVk1ZTFh?=
 =?utf-8?B?U3c0WlBlVTJ6NkpQN2FmbmZNQ0s5VUwvQ1BEMUlTdFFSaGo0bTV3VEdyTHd2?=
 =?utf-8?B?dFdZZVpDMmdnSGMzbFA3eVEvVUVlcDBDK2xsenJUdWd0M1RUTXpkc1M2VlRy?=
 =?utf-8?B?M3hVa2RSYXhuOFB1R0lVdnpnWnNiR3BxZDZ0d1B5cTZRbm9YTVl2S1pLTG5a?=
 =?utf-8?B?a21HZVZ1RWFEaXF5WFdiZjMrZGYvMHQ3NWRnTTRhV2gzYlFZVzBIM25XSFpq?=
 =?utf-8?B?d0RIYW5pTytNdk5jemZqOVVjQzVhR3QvVU5OVlFtVUkvQXJGMUFrUmVlUGk0?=
 =?utf-8?B?YTlOVlp4NlliYzIxbUNIR29ybmNyMmRTOTBBZm1MRUJBMXFYVEwzcUpOYnZD?=
 =?utf-8?B?eUIxOENTM0ZzckZmaXMzVDZxT3lkQmxERzl3MzVWMkp6Q1IxUmhreFNsQ3Zl?=
 =?utf-8?B?akd5YmVRaUNPSzEvYzRrRUUzRkVvYkpIVGIwVVhHWGZZYXl0M3RxcWRJcXdJ?=
 =?utf-8?B?RFpaMG9jeHdYZURLdUtqSGRtSE85Y2M2dVFjYkhCRVpRK0tlWnVlSHFjZlA1?=
 =?utf-8?B?YUxCaVZQYUxtc2lQZ2kvdThjcmR0SG51UGhwQVVrNklZMGtKL2VyUUxaUWRF?=
 =?utf-8?B?dG5jVktwaHRPZUJlQXY5cFAvdnl0S3NwdUtzOWZQSHFxaUNuT1l4anRPWCtO?=
 =?utf-8?B?ZldQQk1MdTI5OFZlQnNUUGxVUGFobVBJbzJKMXBhYjA3dUlIMUlnMU5uMTVL?=
 =?utf-8?B?MmVRVWIvNHEzcWx2bjFxOThXeDRKOU0zWHdIZDdOdE5PdHFWKzJkQlBQRkZG?=
 =?utf-8?B?QzJ1TzdTaU16NW5DQ2lCNC9iRURUc0ZtZzYxbDNDYS8zZlovMEV2dVNicnFH?=
 =?utf-8?B?MWd5d0pIdjdXRERnSjNwaVcyeUtjTEdSNEtWL3NiaTFFYVRsR1VJQTZPV3Qw?=
 =?utf-8?B?S1pRWWkycUcrRUtBemxFVXJWNTNXVXBWMmFBdW1YUHJCeng0TitTaDVrYUFL?=
 =?utf-8?B?TU1laHVMMkRrTXNTTDhLQnRnZ3Npbk0zTWVQYnREUzJmMG9lMXRTZEF5Tk5M?=
 =?utf-8?B?T1h4ejZWU01JKzIzY0NaanhQeHByZy9Ma0MxVTBCbDFCMG9HSG82ZDZDcGdi?=
 =?utf-8?B?RnpNdTlSaldDTmtXRjI3MzFRZGFxcHNOZkM0WXU2blV5Y0gwOWNZSnp0Ri96?=
 =?utf-8?B?eXROV0ZOS0dMTGZZRU9CMmIxSS9mZE9qZmJLanhzRlJlS1U3MVpTblEvS2VX?=
 =?utf-8?B?QWJaQzdTbnArK0t1ZDd1OStUVUE3ZGFhZ09Bc2U5dU5ySk15TnJUWmNyM3d5?=
 =?utf-8?B?L3djZkxCci9uR25LakhkbVJIN0xJZUpkOThpK044ajFLeGZTdFVrYU1iZC9V?=
 =?utf-8?B?NC9Ebkt1emgyM29xTGM0K3oxWURXc2xDMHAwMVVIMXB6czFLS2tzSEtCM1BU?=
 =?utf-8?Q?BYetKJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmdKbllFeVpGY1lORUdXUndhbE1waFZIRWNvbTJGVjdQNGxjTHhGODNXQ3I4?=
 =?utf-8?B?c2h0bnQwSXZQYzNVYUIycEFEeHFLWWpYTFV1MTZPdXhvNkp5SkxOcHNFMHNG?=
 =?utf-8?B?VHVaTzFtUGtEdk1LUHJrenV5d0ZJZHY4U0IzdXlPRTBhWnlONVgzTDJSVFYx?=
 =?utf-8?B?TE1ySmdFY2JtTkRwdVBTclVrdUZONEVtdWcwZGpiTExhOXVFK0xGT2lPYjVT?=
 =?utf-8?B?Q3p2Q05XNnNTZ2pYbTd5R1B6ZmtUSnYxS1JYbVpUbXBWUFZHME5GNUZkZW45?=
 =?utf-8?B?UXM3YVN3YkNaR2RmdVV5cWZJV2hGM1hCVEEvR0RiL1hva0lndmlqdzVrSWh2?=
 =?utf-8?B?blIzUGU0T1JjYy9iWUw5akpheWNwczNuUDlPeDRWRGp5eVRFaTR6MzQvelRI?=
 =?utf-8?B?SmxCVWg4bXZhVXltOGJsR3BGaXRsd2txRmJWNnNyVHVNUFFBWWZyTXFZWm5C?=
 =?utf-8?B?ZXdCVFdTc1dxMzc2Y2M0VnZZeUhycGxMMm9hdHA1L25ZUnJja3RPeUtRRUIv?=
 =?utf-8?B?U3FRRTQzcHJtZEFnNU1ORkJaL0FhTnJMYktQMXUzN3h2YkJkb2t2empEYytS?=
 =?utf-8?B?K1RueHQrWjNVQlkxeU9pOENIcDJTQzNXSzBhNFcxZm5lczZYK3lVcEFTUG9t?=
 =?utf-8?B?dEgxazBrc1cydWxCN05uclpRR0F5QnVSTnh1SUx3YzljQUFwdkFWV0VUV2h3?=
 =?utf-8?B?VVhld3hTVnRGTVAwMUprK2FIZzlZMldWYmRpR0JUdG5tSGhGWHpaMlUyWjVU?=
 =?utf-8?B?SGx5Zmx0UkphU05taWdiS3pEQlN3eEU0RlBaVnJpd1laTmhsYStlNXVyT0VM?=
 =?utf-8?B?OUpTWVI0VkVWV1pXVWdpRzNpYTNzNFVrb0M3Y0tJL3BScjk2MjFHTXhrYytP?=
 =?utf-8?B?cC9aZk1ZMThOSW9VMjV4VFhJWFlkcFhtQkpFVHp2bmtXYzdRN0kxd3I2Tm85?=
 =?utf-8?B?ZkoxTGgxbzJ0dVB5VnJUOG9tWi9pZTl3SEtKSkFaamVXN2hSYkI5OXZwVmpy?=
 =?utf-8?B?K24xUVA1cU54WEMwTlQ1T3c3WWVJbXczbFQ2cmZCd0x2YWtvWUxZNURibTds?=
 =?utf-8?B?KytMZEhkVjlpOUtBNm1ZY3RDRGhnUkdFMC9xc1J1NmNudkV2VVA0MXh1Q3RU?=
 =?utf-8?B?dHlSd0VPUzNnTFMyWUR5S1lWVXFjT3dqemVhSEFSd3Y5NTVBVWFUT3Ircndv?=
 =?utf-8?B?Y21iU1NNZUtPQTdlR0wweDlCRVVBUW1jc1Y2VGozUThCMVpFbi9VQUYrS3dl?=
 =?utf-8?B?V09ORzdrK0kxdnJITU81YmNzTUJqRjFxN3VkTExDRGUzamFiT0xtc2lOc2Fm?=
 =?utf-8?B?aG9STmdMZThlYjhVeHAyQWVMeWRucnk4aHNKRzNEbE8rNHMvRGhRNlR5UWlv?=
 =?utf-8?B?VFN4TDRKQnhTZUJmQ2FndjIzeW9YaCtZRkJhQys0Z01hY3UxTUFRSW5RZFV4?=
 =?utf-8?B?WjBQRU0wOWV4UjJUYkk0MDNZbHA0YmxGcFQwckVGRVo2Wm1rMkNBbC9JK2tR?=
 =?utf-8?B?NkxNVEFyajJZTFBncG15QzdEVTY1d0VpYjA1Um9oVG5sVEtZZ1RQc2F1M05N?=
 =?utf-8?B?YklzS3pHMnV5OWc0SEN6QXpjM1pmSG1wRFdUTEs1TXc3V3pENUo2L3gyRVdR?=
 =?utf-8?B?cVZHKytyOHlUL3h6dlVBdTNYZDQyZDdaWnhQY2YyOWsxOHEvNEZQVFBscTNr?=
 =?utf-8?B?TTExZDBmTzBEcGdkTGlaMFhXeFNuSDdGaVR6Q2N1N2VFQy81c1hwaHcwUTRq?=
 =?utf-8?B?Q05iWG5DZUZXQ3MvcVg2OXMrMDlpMVU2SXRJa25qOTJvNGJla1BlTFhqQmR1?=
 =?utf-8?B?eWFSQTliSzhYMTVCTVZpRGtEMkRVVHJaS1ZBeGZGN0NlNklXZEFmUjJvT1A2?=
 =?utf-8?B?b0czV25RamdxRUNpMkVxejR6bkpwa1VBYzFHblZDQldMR2EvRVR5MXpCNGFo?=
 =?utf-8?B?aU9IUyt5YmdBNzVCSjUzbmllMW9zS09peWFrTW9MU1NlcStuUk96VlIyMVlw?=
 =?utf-8?B?TnlmczgrMWJPQ0VlMmtkOTZFNGdLQmUzZFRIUHJVMER6V2lySFd2SEJEVEtV?=
 =?utf-8?B?UWRmcW4xSEViYTVhMFdWZkc5dkh4U1RUQmxKamNoSXR1UFFJNXFRMHJtRjJL?=
 =?utf-8?B?SzVjT3JJL2hYdGlpb3hVMkgvbHpKSE0yOHlTZ0JCZEFMU29sbkk1L0RQcG56?=
 =?utf-8?Q?W6bzZycPibGtlprrOwGh/bQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6BE637B79058148A4BDECB72615224F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02807a5f-c454-47cc-e5e0-08ddfd13da13
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 15:46:26.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubsxvntaNn9dF1dm0EUnYyJThQzfYJSWK9gwlC4N9qCmkf/ITeoeQBXsI8Oda7pSkCzORXzfsvj29psMb4f2F1o8YI7Csa7AGOn/Kot7q+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77ABF615C
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA5LTI2IGF0IDAxOjQ0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IEkgZG9uJ3Qga25vdyBhYm91dCBzdWJzdGFudGlhbCwgYnV0IEknZCBsb3ZlIHRvIGhlYXIgc29t
ZSBvZmZlbnNpdmUNCj4gPiBzZWN1cml0eSBwZXJzb25zIGFuYWx5c2lzLiBUaGVyZSBkZWZpbml0
ZWx5IHdhcyBhIHNjaG9vbCBvZiB0aG91Z2h0DQo+ID4gdGhvdWdoLCB0aGF0IHNoYWRvdyBzdGFj
ayBzaG91bGQgYmUgdHVybmVkIG9uIGFzIHdpZGVseSBhcw0KPiA+IHBvc3NpYmxlLiBJZiB3ZSBu
ZWVkIFdSU1MgdG8gbWFrZSB0aGF0IGhhcHBlbiBpbiBhIHNhbmUgd2F5LCB5b3UNCj4gPiBjb3Vs
ZCBhcmd1ZSB0aGVyZSBpcyBzb3J0IG9mIGEgc2VjdXJpdHkgYXQgc2NhbGUNCj4gPiBiZW5lZml0
Lg0KPiANCj4gSSBhZ3JlZSBpdCBzZWVtcyBjbGVhcmx5IGJldHRlciBmcm9tIGEgc2VjdXJpdHkg
cG9pbnQgb2YgdmlldyB0byBoYXZlDQo+IHdyaXRhYmxlIHNoYWRvdyBzdGFja3MgdGhhbiBub25l
IGF0IGFsbCwgSSBkb24ndCB0aGluayB0aGVyZSdzIG11Y2gNCj4gYXJndW1lbnQgdGhlcmUgb3Ro
ZXIgdGhhbiB0aGUgY29uY2VybnMgYWJvdXQgdGhlIG1lbW9yeSBjb25zdW1wdGlvbg0KPiBhbmQg
cGVyZm9ybWFuY2UgdHJhZGVvZmZzLg0KDQpJSVJDIHRoZSBXUlNTIGVxdWl2YWxlbnQgd29ya3Mg
dGhlIHNhbWUgZm9yIEFSTSB3aGVyZSB5b3UgbmVlZCB0byB1c2UgYQ0Kc3BlY2lhbCBpbnN0cnVj
dGlvbiwgcmlnaHQ/IFNvIHdlIGFyZSBub3QgdGFsa2luZyBhYm91dCBmdWxsIHdyaXRhYmxlDQpz
aGFkb3cgc3RhY2tzIHRoYXQgY291bGQgZ2V0IGF0dGFja2VkIGZyb20gYW55IG92ZXJmbG93LCBy
YXRoZXIsDQpsaW1pdGVkIHNwb3RzIHRoYXQgaGF2ZSB0aGUgV1JTUyAob3Igc2ltaWxhcikgaW5z
dHJ1Y3Rpb24uIEluIHRoZQ0KcHJlc2VuY2Ugb2YgZm9yd2FyZCBlZGdlIENGSSwgd2UgbWlnaHQg
YmUgYWJsZSB0byB3b3JyeSBsZXNzIGFib3V0DQphdHRhY2tlcnMgYmVpbmcgYWJsZSB0byBhY3R1
YWxseSByZWFjaCBpdD8gU3RpbGwgbm90IHF1aXRlIGFzIGxvY2tlZA0KZG93biBhcyBoYXZpbmcg
aXQgZGlzYWJsZWQsIGJ1dCBtYXliZSBub3Qgc3VjaCBhIGh1Z2UgZ2FwIGNvbXBhcmVkIHRvDQp0
aGUgbW1hcC9tdW5tYXAoKSBzdHVmZiB0aGF0IGlzIHRoZSBhbHRlcm5hdGl2ZSB3ZSBhcmUgd2Vp
Z2hpbmcuDQoNCj4gDQo+ID4gPiA+IEJ1dCBmb3IgYXV0b21hdGljIHRocmVhZCBjcmVhdGVkIHNo
YWRvdyBzdGFja3MsIHRoZXJlIGlzIG5vDQo+ID4gPiA+IG5lZWQgdG8gYWxsb3cgdXNlcnNwYWNl
IHRvIHVubWFwIGEgc2hhZG93IHN0YWNrLCBzbyB0aGUNCj4gPiA+ID4gYXV0b21hdGljYWxseSBj
cmVhdGVkIHN0YWNrcyBjb3VsZCBzaW1wbHkgYmUgbXNlYWxlZCBvbg0KPiA+ID4gPiBjcmVhdGlv
biBhbmQgdW5tYXBwZWQgZnJvbSB0aGUga2VybmVsLiBGb3IgYSBsb3Qgb2YgYXBwcw0KPiA+ID4g
PiAobW9zdD8pIHRoaXMgd291bGQgd29yayBwZXJmZWN0bHkgZmluZS4NCj4gDQo+ID4gPiBJbmRl
ZWQsIHdlIHNob3VsZCBiZSBhYmxlIHRvIGp1c3QgZG8gdGhhdCBpZiB3ZSdyZSBtc2VhbCgpaW5n
DQo+ID4gPiBzeXN0ZW0gbWFwcGluZ3MgSSB0aGluayAtIG1vc3QgbGlrZWx5IGFueXRoaW5nIHRo
YXQgaGFzIGEgcHJvYmxlbQ0KPiA+ID4gd2l0aCBpdCBwcm9iYWJseSBhbHJlYWR5IGhhcyBhIHBy
b2JsZW0gdGhlIGV4aXN0aW5nIG1zZWFsKCkNCj4gPiA+IHN0dWZmLsKgIFlldCBhbm90aGVyIHJl
YXNvbiB3ZSBzaG91bGQgYmUgZmFjdG9yaW5nIG1vcmUgb2YgdGhpcw0KPiA+ID4gY29kZSBvdXQg
aW50byB0aGUgZ2VuZXJpYyBjb2RlLCBsaWtlIEkgc2F5IEknbGwgdHJ5IHRvIGxvb2sgYXQNCj4g
PiA+IHRoYXQuDQo+IA0KPiA+IEFncmVlLiBCdXQgZm9yIHRoZSBtc2VhbCBzdHVmZiwgSSB0aGlu
ayB5b3Ugd291bGQgd2FudCB0byBoYXZlDQo+ID4gbWFwX3NoYWRvd19zdGFjayBub3QgYXZhaWxh
YmxlLg0KPiANCj4gVGhhdCBzZWVtcyBsaWtlIHNvbWV0aGluZyB1c2Vyc3BhY2UgY291bGQgZW5m
b3JjZSB3aXRoIGV4aXN0aW5nDQo+IHNlY3VyaXR5IG1lY2hhbmlzbXM/wqAgSSBjYW4gaW1hZ2lu
ZSBhIHN5c3RlbSBtaWdodCB3YW50IGRpZmZlcmVudA0KPiBwb2xpY2llcyBmb3IgZGlmZmVyZW50
IHByb2dyYW1zLg0KDQpZZXMsIHlvdSBjb3VsZCBhbHJlYWR5IGRvIGl0IHdpdGggc2VjY29tcCBv
ciBzb21ldGhpbmcuIE5vdCBzdXJlIGlmIGl0DQp3aWxsIHdvcmsgZm9yIHRoZSBkaXN0cm8td2lk
ZSBlbmFibGluZyBzY2hlbWVzIG9yIG5vdCB0aG91Z2guDQo=

