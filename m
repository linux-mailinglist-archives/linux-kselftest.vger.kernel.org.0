Return-Path: <linux-kselftest+bounces-44484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C0C2335F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441733A9640
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A034280A56;
	Fri, 31 Oct 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+qvLsfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E927F010;
	Fri, 31 Oct 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882695; cv=fail; b=qJBtMYADWtUlTX7gqvVkf12w+Osq2tQ6Y0zZGeWhbEOITc5hFgk7YRrO4fBYmsvyfuScre3RB6h15UJjdGVPNdkdIBNMdQkIj4oxCxLJqM5cGqEXF+NLgufpyxhdavhdNQfC4t9pKzFtzapXdpMk67fDUtviC+TAQk3JURIJJNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882695; c=relaxed/simple;
	bh=xybtw47sj1ZjfzD52XcnmB6xx8JXF/lIen8rcoWGGwA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tk36dT6sGWlz2Su5J85IPWFroT9smQxO58LsPCAXHZE3fh7AuI8SGSqsePkawDUE7JIssvJzdZMxzKLvopOqzZuzbqGRuqXSSmdaYMGeOoMKzG+AkWy5iKBt37x3QfF5NpkopeoeiyCxAS70W5S0nNVW52YaE0Neuodym2oGM8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+qvLsfH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882694; x=1793418694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xybtw47sj1ZjfzD52XcnmB6xx8JXF/lIen8rcoWGGwA=;
  b=j+qvLsfHlTc/39CVYqnOluAa01LKS21Jzy8ygpBcSPqUtWElDLhnYQsr
   EZ+DrWuKm+PwRN0HwTccqtr8iY1gBt0s//6jVfpdpq+DKNS+aUD+USnif
   fxsMI+vWDy36HVLjolRldNfPHAH6xGwMdnlQVyeZrTKzM9gfmjJOm9QhQ
   gPMuQvw8tDt1IUxsI0dI08W5OAJwnBwakzES12ocGP5Z2oMNDbZyPiU+F
   YZFVZLvYhq4vEeuTSGEcd2815MgclIyLsKSdPoDn9ZxWzaaRaZ3TyiGjG
   eL746NPDTZ32DUPuLErIT6Ey+mjjF27Q/I3gAHwNo3FHWGE9HT8emT0he
   Q==;
X-CSE-ConnectionGUID: AVDUHV3gQ06r3Iv28eKl2Q==
X-CSE-MsgGUID: iYXBm9mzTQ+Mtmp3jtvBFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74713501"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="74713501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:51:33 -0700
X-CSE-ConnectionGUID: g5MimpShR4OZv1SVy+x2Vg==
X-CSE-MsgGUID: 2/hCK+E1ThizzNOsIF/43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="190479115"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:51:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:51:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:51:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny+6Oq9wKMceoTW3JXIEppyXrGoxCeW8YjfYiKl2X47K/iWTsx68wrK3Pa9NNnMadBTIKfV6BTWpuVdxQjOf2xwGbOnP4K0YDDtXFVFxkxYC37cZ9aN0ciaD9uB/WU0MGeRAudSj7oCzuJsEiUMXdzYRszjFni1vFyokXvT1tAJSM4NFNcuSCBTs/T3LHW5baxbsiU7z1ii3ba1AJerAcMIyu8F5VlqfE/zXDugPt6B2fWEM0iuLSBY6uFGkg896tY2DPx5XLDXqcrBzlMvxZNrnJ6DTn1SJjQTGCf0/Q+fOhVcbiiLqMGQHeZ3jpzL7b+M0zczYbm08/B2EhGkU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xybtw47sj1ZjfzD52XcnmB6xx8JXF/lIen8rcoWGGwA=;
 b=MFw9VzsjkqUBZOz3t5cC7MXjma+aLLxNFh93N9udMymCRn8v5wZChxmZr50ICk57C7s8IblyfbpZbmtIqR/eeETSiqFCJmVPccuZ9lNXTJGEhkqz5YxwdgDp2uIjb8fyi+IY3kOF/uBsityfYfn1+9OMQiNVH2UO2s20041f9uA+A7dPwr63AmjQMcpj2j/79w+9rBOGzMAcgeYqnVOOeeHcY2zmy5OnF3x1hFdrhvvju5yMNOMPcrIeZlbFWvxLWxfnTAjKaRKERL1rC7tzePO4ePiaEaY9+ayOOWT47eX7nvMsVBdtzdyCe8yHALjpGPI8Xpa+81PReSLTdSZp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:51:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:51:23 +0000
Message-ID: <4f794c21-941d-4aaa-bd1a-a853002c74c4@intel.com>
Date: Thu, 30 Oct 2025 20:51:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/23] KVM: selftests: Allocate pgd in virt_map() as
 necessary
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-3-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-3-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: cef87e61-174b-494f-a896-08de1830c228
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Kzl5NnJjemFOdGdkMmJzUzVEbHlPYk5FZWc1R1VEQ20xVmREeGVBRm9abDVC?=
 =?utf-8?B?UHJ4UGlNRzVVWkJYRTNnNjdaRjl3WXViN0s2YlpxZEtMZzJqT1djQUpTSVZC?=
 =?utf-8?B?MzB2T0VqbTU5eWxFbG9wQW44VzF2NlQrWVhzMytCdHZyQnZLMEpxTHh6VG5P?=
 =?utf-8?B?R1J1R3Yxc3k3c2h3WmwyRDNIM0JFMGJUMitkcm1vQTVCeDVSRjIvNkJuelQ5?=
 =?utf-8?B?VDNhb3BFOTgybXdwZkwxQjd5ZzFsdUMzenhQRFhMR1BReWNLa3BSU0NpZWQ2?=
 =?utf-8?B?OVczU2lBNlNyaTE3VDZ6NlVXK3NNY0N2d2RUVmZaZkVhNnlpL0NJejB6cEpQ?=
 =?utf-8?B?c2xXdisrZkZPaE51WHZEVkw0aW43aDMwWVI2TWlvZldEaUo1L052U1NRc0dS?=
 =?utf-8?B?M0xyWCtnS0hjZUdIQVowYzZBTnVNODFFSEdZNWZ4ZmlvWlZEdkx0M0JjK29I?=
 =?utf-8?B?eVdXTmMrVTlKODQ3cFlPWUwzemRxQk1MYWtlajJ2aFczUHd3NHhWTDNoaG0z?=
 =?utf-8?B?Wk9aTE5PbE1WWTZJa1ZLRnR2NWFlR1dhUFlDdHVWaGJITDR4UytNNUFLZnRW?=
 =?utf-8?B?eEhHSStXU0R3NkZnMy9GOFlOTUhLOVBCY0JlVk9aT213U0JKRDMrNGREbEwx?=
 =?utf-8?B?eTlGVTlDR2M2T1ZicjE2OUhvY2RuTXl6bjFyTHhicjhKcE5UVlVUeDRNMXpr?=
 =?utf-8?B?TE9OOG9zSFNSUW85VmdZOGxqZ3I2M1lPbXc2STVVaEdMUlZCdG42Y3hBSnBn?=
 =?utf-8?B?c2J6Zm1xNnpDTFhuTGZEY2x1Zkxjbm4rczhSTENrSVJ1Yi9ZaytXUjRyWnBD?=
 =?utf-8?B?aVhkWkIrMUYvTHdEc1BweEJuQW1pSWVPZytEN1R6bnJxL1RDZUJ1UnYvYlhy?=
 =?utf-8?B?Q3Y2UE4rRmpqbkRxanNXSmVHdW5ETTR3UXBnT01SSUVsU3NKNTRza29oRUhU?=
 =?utf-8?B?aXJGUkNkUTFzQzZTQXVDK29mbzhBazIwRVF6YTNWd3hoRW9wWGpuMTF5K2o1?=
 =?utf-8?B?YUpmb1pqWHdsT2ZzanNsbDEwcldacStZOW01Skk5a3ZadVNTdFcvNDZNNkhh?=
 =?utf-8?B?OGVpaTV4WFhydGN3QUtnTnJ4OEE3UUpWaG85YWRWTi9wMGh4NFNJNzMyVTFr?=
 =?utf-8?B?L0xWZWJNVzNMelhrb0QvVjk1YmQ1bUJnM20wZ1N4bFpzSlhEdlJIeHhkTWor?=
 =?utf-8?B?RkxheTJyTThNbllDUFRrOTdmTVc1TjA5a25oS0dNaHkrRHdWM21pL2JTMUhJ?=
 =?utf-8?B?Q05CKzZueUpkZjZiRldDNXVkemsrQ05NaUdIczV1RGZ3RWpaZzc2ZE85N25P?=
 =?utf-8?B?T0FScFRpTlpIR05Tajl2R3JEZ3lacEJ3RGZJMlVnR1QzWmJEUkFxUjRsay9V?=
 =?utf-8?B?WjhVOGd5ME9VK1dBM2U3dVlOYVluTVc2KzRNZ3pSbDRTdTMvS0FXdTdFdi9s?=
 =?utf-8?B?MDFGejFzYTEwN3U4TDlPcTlpMFpHdjU5UW9MdGQyY0ZYNU1BVHhGTEhLVFFM?=
 =?utf-8?B?K2F1OXJ4WExRc29EazcxVjZpZHovaWZ3ZmRqTzRUUGd4N1FQM2lFRkNHeU5R?=
 =?utf-8?B?YzJaMWFJMVJwQ1krdllyOTRtSXcrWjYxMUlQY2FQUzNDck05OUsvYWREVVox?=
 =?utf-8?B?dWJFOHBDYnNjb0ljMTR4eUU3bm9SbzBLb3ppcG1lSmM0VkZQNmRyanFDV1g5?=
 =?utf-8?B?SWMrZUlGYmZ1MWlGS3Nwdjg5SlE0Q3M3OE0zWFpTSlZaMDUwUjlBKzU2T2Jn?=
 =?utf-8?B?K1E4c0RuMmxjb0N3cFh0OUxtbksrYlZyQUpoc3lPRW1tczU3UWp0SW9YZ1cr?=
 =?utf-8?B?RWFOMGliQ25sUEJlNklDYUhLZnh1NGl2TTBBU3BUNWN0ZHVvZ0pLNE1QZ0hH?=
 =?utf-8?B?UUx0Zk55RDRMaXdGU3V0QkNLbmRXQkhmOStmN1NUZUxzOUFNOTd5Mk01R0dT?=
 =?utf-8?B?dkJnTkhUOUVPaU11M2dhSkc5cENabmNITkxicHNoRzU4Sy9nMXBPc3FwakVS?=
 =?utf-8?Q?XwwvghLq+fcTfDuxwdLlwLHXqphmD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWl3MXpVVzR5SERZV282UFBRSjFTNFdueUFQQkN3VG5OOHpvWXhFanlsWS9v?=
 =?utf-8?B?OTAzLzVXZjBUUlg3bGU4akVidXNXYVVkWDhyS29LR0N5biszOUlaTytFTjFF?=
 =?utf-8?B?M1FwZ1pVODc2eWdZL1E5bG1XU25NL0piWUEwRGhORlFBZzVCZEhSRnRnRnRm?=
 =?utf-8?B?UlN2ZTMyeWxCUis3NVFaTGVHMWdDK3pqdEV5bVRnMlNoUFdta1I2Wm5pYkh5?=
 =?utf-8?B?VURYR0dDV25RTmxHOVVvTHlRdjJzV2JyTnRpTXVMK1dnRkZUVWhZcVBuRTVz?=
 =?utf-8?B?SjhlWWpIQXpHME45clkzK2oxdXRET1RxYTVxV0dtc254Z3p2TFJlQTE3dElq?=
 =?utf-8?B?NHNPYzFiYkdnQ1F5QUZLbXgzZGl0WkxiRmhwYXVWSHRXbzhQU1EyMTkrMnFJ?=
 =?utf-8?B?UFF3ME1VbGI1ZDlNMGxNZjNHUStmMy9GVC9uTS9HOXlpMDkrRWZhQXBpMklZ?=
 =?utf-8?B?Rkw3TU1pL2RPWkduN0dpdkFtbndGdjdsbDdMWlA3ZWVoQkRKVm5VQTZRYUNC?=
 =?utf-8?B?MHFBY0NEQ0VkRG85VW9SdXIyYWRlM0RJZDlaQUc0WjQwL0xUYjd5REFKQ2Ev?=
 =?utf-8?B?aGRSMk1vTTNKd3hDTDZ2WFJaVmh0NldncC9aMTgxSW12Q0JOZHVBZjkyOG5v?=
 =?utf-8?B?VHZyR2k2b2tmN25uV2dJY0crdEt5YkxmNGgrR1Uxc2RsTXJ6SWdiRWMreTlJ?=
 =?utf-8?B?NGowQytqc0xPTkZaTEhOYkc2dGM1U0hDV2pCSzhBSnA2b1dQZHlxMnVvUWZ5?=
 =?utf-8?B?TGQ1UTQ0UzlKc2QxaG5yVUVDeVR4QjRnYXl3RWY1WkkzVFF1RER0bmFnS1JW?=
 =?utf-8?B?OUN1ME9ob2d3RHF1WXVEeSt6eU11MzhhQUsvOXhXek8xYnZEZ3dsRVZZYXRO?=
 =?utf-8?B?ZnJrMG5wc3JjUlRnMENBTHkxM2g3UjI3SXdINFRneXA0TmpESEVFSDg0Uy9D?=
 =?utf-8?B?Q3F2QmJJeFE1VlMwYjdNczN3VmlTMVhqTjNVTmZPM2JZVklDZXNBcDF5WVlO?=
 =?utf-8?B?MFJHbzNMTFVHbFk2NWRjaWNhbkpIZVQ0SkQvV3piQS9zaEI4ZFBuNFkzTkwx?=
 =?utf-8?B?NGZORmt1QndvaURWN1lpV1lMa3pQaE92SkcxTzg2VU9lYXNmMnkxT1F0Ykly?=
 =?utf-8?B?WFo1aUFGWGF2MzBmYjJWakZaMHJybVkreGk1aDJqdXdrSTBDNE85THFWaWMr?=
 =?utf-8?B?YVp4Q3VtNXZ0OG9VKzlqUk9aNElPQmtFVjRqS2JkU0MwWHFIWW9tcTUxYjNP?=
 =?utf-8?B?QnVzeE5JNFhzQnVzZ1pERHhKQmpPN1ZhcEVHVmlPQVlQUmd2NTlsSi9SWWM5?=
 =?utf-8?B?aHdXdDRSWWd5Mk5MVW03TUhHdUdPWG5lSDdlLzVMUUxFR0VDazZudDEzOGs4?=
 =?utf-8?B?RXhIa004R0kxZVVQZFczekswNWljS0c4c29wZnNYNDByZlJkaDNkaTNyZlB2?=
 =?utf-8?B?aHNxVFVldklDaEYvL01hQTVIekNSd2R1UDhjbU52V0w2S3YvV2YzTGNFZlg2?=
 =?utf-8?B?a1I1Ry9QdFU4OGF6ZHArVTF2WXlrNVh2SmhEYWJGNnMxenovQk96bU9rYkVF?=
 =?utf-8?B?YnBWRittMlRhTmZQMEVvbUV3RTlLUzNoS0VsRHNtUTRMWWh2OERnK3JMOEw3?=
 =?utf-8?B?WC91Y2g5UEJETWFQakZrZ2t2U05Hd2RHNVQxdDlIeHZON0p0WEpkdHkvVVpZ?=
 =?utf-8?B?eHNSSE45NXRKaFhQQXBIa0o0TUJObWNGeUx0ekxFRk9XRklZYTNnOW5RZFZ0?=
 =?utf-8?B?Z0I3MUk5bDY3aTUzRjFEU2k4aXM2ck9PbHZCZWNPYytNU29jcnJGNW80bEVu?=
 =?utf-8?B?elRMalVYUEFSOFFLcjlsbFZHeVNrOE5KYmExYlNydEJSYkNvcGR4VmVlVFJD?=
 =?utf-8?B?cUZrcjl5OS9oK3BSbzZDZlF3WDJFOFNzYWdJVVZOSnZYeUFMOUFJR1ZmVlRN?=
 =?utf-8?B?dWc4dWpzdUpRNy9wZDV3Zmt4UjVrd29qMW9XSGNLZTduWnZBOWQ3ZmRCekIy?=
 =?utf-8?B?NW5LbUdYUiszaDBjVEFaZ0M0UlpWWHhyd2ZVdit3UU5XRU9Sa1dYbUNWY1BM?=
 =?utf-8?B?ZCtkUFdlVWJ2YUc0dlc3WDgvZkFTVVUxWUxyZW1kS2JHb1NUWkZndWpUbDNq?=
 =?utf-8?B?VjBRMGFiNG83NVJ3UE9NeFl0RjlvejZEd1U1dWxuSkx1REUvSnQwVHNVaHVl?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cef87e61-174b-494f-a896-08de1830c228
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:51:22.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq3Zt6mjGlM/WJKkPEaSPueAWJHKN9DAWZ1mCnhJGMaXb59wYAm/BSeOEWSpS1yXa8h15jCdAG8fcJe4aUBleDkxQdLeg5KsEVJj/1Z1YFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> If virt_map() is called before any call to ____vm_vaddr_alloc() it
> will create the mapping using an invalid pgd.

If virt_map() is currently called before any call to ____vm_vaddr_alloc()
then this patch would be a bugfix ... but it is not a bugfix so this
"if" does not seem relevant to existing code but a future change for which
this changelog does not provide information.
> Add call to virt_pgd_alloc() as part of virt_map() before creating the
> mapping, similarly to ____vm_vaddr_alloc()

The changelog is missing "why" this change is needed. Yes, it mentions the
hypothetical scenario that it aims to address but it would be helpful to
be specific about what this is a preparatory change for. What scenario would
require virt_map() to be called before ____vm_vaddr_alloc()?

Alternatively, would this patch not be unnecessary if
vm_tdx_setup_boot_code_region() is moved to be after kvm_vm_elf_load()?
As it is written (looking ahead at patch #16) it looks like the TDX boot region
creation and initialization is between slot 0's creation and initialization.

Reinette

