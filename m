Return-Path: <linux-kselftest+bounces-39129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF35B2893B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 02:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8094A5C1332
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED402904;
	Sat, 16 Aug 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swb7jkXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899F38B;
	Sat, 16 Aug 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304129; cv=fail; b=kHCkjEQ9uSKMQaxFJ9WsQg9CA+rh8AwnvyeOdAtLnFV+z7AYdHWcvKrNZqZsU3zEVHVm9CIYaE7fVJUKoBKFogdKtWg/BinaV+aHrrV1qN9u+kBydc5QNDdWsT9Vv/MQqANyAxxkBeL6B6m/2CRwDBHa9OpfJVKckPU5cO8azWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304129; c=relaxed/simple;
	bh=XZNlA02ThU80GKBWhJFaLx2vT7bzT9lKVCK/OQPTxQg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qI3KwC9iw6gxVhEjlNgLbWPyIX8sL4RzBmVEhHkpxE2rTXUaLsx2T8b0k6oLbgeYVxlb74wDgXlWzgYtGQ0ZmQesT4iFpDC5CjOQjiaX+Uj82IjETBS8po/XqEEDTfW1Pm+Zq0areUkqtFOxqam7N7A1pq12oMj9/+m8bxAx1tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swb7jkXg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755304128; x=1786840128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZNlA02ThU80GKBWhJFaLx2vT7bzT9lKVCK/OQPTxQg=;
  b=Swb7jkXgWFuC3Oz9L3LxFdWUs4cgZS8TSTxLLPjXzgrO3IjV4C7FLufj
   VRteZJDR1qCktfKCDjmhkovqJNIPDha+MLx0uoJBlV6hiE6+lHGmVN7Vt
   I//CXYcOd2mLj5podJtCHABHiz2fqKvRJIcEuUYQOJdlOfzZC/WF8W2Lk
   EzHM/SX12ljayeKaXvIsi3mvyarShYYid+dFArNXSRdi/MkoouCHJKMel
   5tmRW1wkAa28kjKnk5sUXnz6JWJl90ILGICRgRBgWutIjl/pjqivfaKqW
   E0rhMVJPYnuXJMsSn1B0ClFfDfs1dwbqogLoEONY1X3ghsiRRg8MlLpqO
   w==;
X-CSE-ConnectionGUID: ElC3MzTgRDS6VBmbTD931g==
X-CSE-MsgGUID: rGtFxKMGQNi7dxiU03z/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57580015"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57580015"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:28:45 -0700
X-CSE-ConnectionGUID: MaJ52a2IS0yWSeH7VtwHeA==
X-CSE-MsgGUID: GuXYZboQTFaFqPvCLW3KWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172337826"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:28:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 17:28:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 17:28:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 17:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9oZ/xMmOe9V0UJK1zmgMgjJzgxHbaAjIkKr81tk+LaF1JaYd8rZwrqGBNdSiIESN3nu/3nqOoqOtVc0NMMXdQRvRC41r5zAdZTQqCDYEs9Ny1PnOqaRajZEicXwpqJRGTE7+VTsp+4sHtvOfX2CWWN3BvmMO9evC7EWIa2xoXn+J8N7KfneTCi3WbWpafjICvhcOUuswbKUDpkZ4UzwRPOPEBfgjxrbNpgjz7IZV/Y4mPC/M1UGDaD+0akIvzXAcvVPluqfiIv76+c8qSCAxgCVD2yNHxfGtxMe4HZAGLO9giMIUHsPafy7mtH5jV/xqgRyiJIPl7CXMoaIWVIOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzv27N1NvW+s4QYVgjA8ynhtSBAh910pOveooC1psc8=;
 b=eOC+nhmW6+ZhlGVG6+TQuddKi+8JaDVVPeCr7pE2FAoSk+FTs7O0fUc/Or/SNVppZC1gsKmN9syCNZWP7EOkgk3zrl3Cm3YvnCdGFIhVGMTKzWZ6yYN58KkZ4UcvKiTnC0BkwNU2yt8dedxvmrhCs2Hry6o1qGS7qcp6lrpkR1IWio0VBtsfGPs2LhAr909GHx+J/Di1FuYeydhfxQPc2BwFc1BJDMXHMrh3vtjNyNveQLi6IRXAgA2S3DwpI7BuQ+WZ3iyBZ3GnYTgq+qp5KYYK9hh0G+xQR9puQj4Pah2gJGmlumBGpoEY3pfIA0jEXnB4qKPSIkDbw5MNjSVDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 00:28:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 00:28:41 +0000
Message-ID: <d8425202-733e-4b29-990d-56d9efed44f9@intel.com>
Date: Fri, 15 Aug 2025 17:28:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Sagi Shahar <sagis@google.com>, Binbin Wu <binbin.wu@linux.intel.com>
CC: Sean Christopherson <seanjc@google.com>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Shuah Khan" <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Ryan
 Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, Isaku
 Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>,
	"Rick Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, "Pratik R.
 Sampat" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com> <aJpO_zN3buvaQoAW@google.com>
 <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
 <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0358.namprd04.prod.outlook.com
 (2603:10b6:303:8a::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: c60e2113-c0d8-4fe7-63f6-08dddc5bd9e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE1nSE84N0RTNTR3b3NENzBKanUzVzNQUE1kWUp3cGdPR3kvYmdLdU1iaGF4?=
 =?utf-8?B?b0NZbHh4SHFmeU50K3A1YU9INUJRaUFReFB2NktIdG94L1F1bnpudVRZWkFx?=
 =?utf-8?B?VUQxWWh5TjB6VHJDYjFBS0RMVTdkQmE2SnlReFlkWUNKZC9vRFJ6SGk4d2Ru?=
 =?utf-8?B?L2hpZUkxdDhjcUZMRVFyQ2F4dTg3aHN3VCttaVlhMlZadW5vVkdKTFFCTCtM?=
 =?utf-8?B?eG9hTitNSjNBM1oyUDV5cXBaWmh5WWVsTGRMKzRDSFQ1RFVhMHRNUE9abU5j?=
 =?utf-8?B?WlZadFNSd2R0Ulh0eHhIUlI4bnpGN3JkdkJ0bWV0OTNtR3ZiNE1VbWF1NG5S?=
 =?utf-8?B?MXNaQUg0SVB3WWRCMTZkMGtDUExUY3NlNklGY1hjQlNZSG5NaDZpNkNzTzVE?=
 =?utf-8?B?ZExYS1Z3aUVzc2x4MmRIcUsvcDBhSkFkTkRMckRONGVlb3hnUVJBN2ZXcnRY?=
 =?utf-8?B?WXQ2UzdJbEJDMFhMamFRYU1uVGFWd1l6dVlMUy9nVjRWRXBZZm45eXM0OGND?=
 =?utf-8?B?NWQvSEg3TXpoQXJ5b0g3TmxUeEFFRm1RRHBmUm00cUVLS05UdXVISXZtRExx?=
 =?utf-8?B?VXFBM0pYYjdIeWkwN2QzS2EzSDZiNzJtbXBBdDNQZkZFOG1sdTlNOWp5cmhM?=
 =?utf-8?B?MStvUHp5RFN1SFhPb0tubHltMVdHeFJPTjd0TTNTZUljN1BWZUNucFp1UU45?=
 =?utf-8?B?b1pzRU1FU2NKYmZWR3lsb1dMZjdOdlVRZkphaVBvaUV0YkNJQWtDRkN1MlZU?=
 =?utf-8?B?UmovZnFLVSsyUStZc3lqNUZtNkZwMlQ5ZUUxWllid0hwaWZkajhOWVNyVnNp?=
 =?utf-8?B?SzcxRzdSeFdFQ1RBS1E1N29Mb3FJZnJ0UFpYM2d4Y0pRT3piMWd6SUg3SXFx?=
 =?utf-8?B?b25QK1NQK01XbnlEbEtaWE9uZU02NFY3eFFHcW1oZkhwODV5ZnBhY2JrMXU4?=
 =?utf-8?B?MXRqeW5NRCtZYm0yOW1GSmNlUW5Ea3hRSWlLNTB4VUErdXNSZENPUndTNlV0?=
 =?utf-8?B?TG93Z0VWUXJ6bCtTZzBxZklOcy9CcGNKZmtQREZsdkpzdmZma2ZaWUttMGdt?=
 =?utf-8?B?UWdmcC9DUmtrOWRoaHNrQmFuWjZ2RlhvVHlaVWx6ZS95ZmRsMW9ySnBwR0t0?=
 =?utf-8?B?K3krazBpZVVKMUdzWlB2eXg2ck0wVGpWbG9FSWZxTWQyQkYvSng2UE9VZlJH?=
 =?utf-8?B?Ty9yUDluTWRLcG9ab3NGcS9hTDQ1aFB2S3E1SXZLckQ2N1gwaWVZNW92Vzkx?=
 =?utf-8?B?bnBqMmF1MndGWnJJUmJFZklFUHRiZDcxWjNRZ2doMUhJMUdkb0lQNXlWdEZE?=
 =?utf-8?B?cHNDMjNVKzZwRGxqc3l1d3J4aXc2VEphU2Jtc2RiNVZEYXl4ckZVZGQyWUpF?=
 =?utf-8?B?bUdjSEtwcHUxK0FiTTkvWC82VTJOcTRvSTdFU1BhcmJ2aFA5MmExVFNYazly?=
 =?utf-8?B?UDZ5Wm9NbXFzMjlPeUtaSDVRUVJpQUZjQy9XMXJqQVpXbHJPZGJRbzJ3YnQ3?=
 =?utf-8?B?YUwvWVZyeVd6S3VOTjFua0RvcXZZeUpEQllmN0ZxMGhqUTRmMG51aFlNV2xa?=
 =?utf-8?B?TmtDN1VnT0dINE5JVVFjdllFTlpERTI5VDNCaFJ1c0xESlI0VVVRVVVMUlpm?=
 =?utf-8?B?TlZKamdoTU9lbnFGc1ZEN09FUVVjWTBhMHRuNFF3YUhwTzhRbURGMVN4dWhO?=
 =?utf-8?B?cEdSMTNZTUFtWFc1REZNU1pWd0pIb1I4b2pYclh3T1gwVEQ2QS9HS2xjWStB?=
 =?utf-8?B?bWlsbFB1bXpXS1RuZmdnYWRWZ1M2dDVoVVBtREF2Y2JWeE5yZlRvTSs5Mnhm?=
 =?utf-8?B?ZzZUcHRKdlR6NVdWN3BUWmhEWUtjRXhVYTc2enpMa2phbTYydjB5eDJmRnp4?=
 =?utf-8?B?V2NhNi9lSWVlUjVpL29oaGZJRlJTSnl5bnZPWUtEakRaZ3RNVVlrQzg4V052?=
 =?utf-8?Q?FR3yRzreN9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJnZVZvT0U0bmhxOW5hWk4xNW1kdjNuNjQybmZoSi9Ob0FPUCtOSE40YlBR?=
 =?utf-8?B?VEZNYXY3Zm5MVFFZbkl6SUthdFBheW1pSjFGK0NOdnl4QlJXUmFjMWZ4WXNw?=
 =?utf-8?B?QTYzdkJnWEQwb1pHZFV1ZzFpaE9vbC8rN3JKeDl4QlVERVhDR09lR2dpRUN0?=
 =?utf-8?B?VHEwRTJkcnN4REx5MlA1dzloOEZYN2JhWXh2N1ZMZS9Bbi9FL3l6NzVzSlY4?=
 =?utf-8?B?Ukg5VEIxTDgvZjNyTzdnTGNUTUlOcDBNYThDcnBLMXlGbnR6QTRKelFsR1F4?=
 =?utf-8?B?RHNIZmtGY2l2d250aHN3UUFKUFRGVW9rMU1lVkZzeEorYW5UNXRnTlJQYnJB?=
 =?utf-8?B?NVRQeE1WNFZzZWEzOGpCUDh4QmFQMzE5c2xXbWpIQkMyc3ljZk1IbkZ3YXdX?=
 =?utf-8?B?dkxWckxzcDM1WU9XSnBqOWJVcFZHN3kySERIODM5Sll5Z3dSRDdlVngweVox?=
 =?utf-8?B?SXlHMDBmMEZqS0pkU2RHTnIzQWhqSWR4aHNlM3d3NFY2UDhOeGlDNTdKQXJv?=
 =?utf-8?B?djFYOVVlYnR3WUw1Z3ZyMlh0L3YrRjlIcklaejFOMUxrVUZrazBneldWVlI5?=
 =?utf-8?B?QkFjK01zemxsdU1yYlVWNk04WWhXaW1GcTUvSFNsYndWbnNrWDB4cmhyenpi?=
 =?utf-8?B?NzJ2U29waWxnM3FQb3FBa1N4T3h6QUlmY3dVclJ3bG9UREx4Vnl4S1BFSDda?=
 =?utf-8?B?REh5S2tLSUFzNTBoSEtMZDExak84RVdKeUszVC80VFlMbTBIUjFtenZGOFpG?=
 =?utf-8?B?ZGEycE1zTUpzR1Vnck1kNld4VUNBU2FOOURJNVJjSFp4Q0YxakNsNHl2ZWhF?=
 =?utf-8?B?MlFlb2R0c1dyajRKbWxPSGNqNVhrK01CZm5kMlUyOXNjeng0Wk9qTnNsdTlo?=
 =?utf-8?B?Z3hnbUxSMjlZTEJGc1ZHNW5QWHVaSVpGTGpYMWxBYUFaKzV1TXpkMHR3U0Nh?=
 =?utf-8?B?V2ptSS9ZL3ZFRTNLdjJmVldkOWUwVXhQbUVCbGdQRXlmZDEwL0p5cmdiaDl0?=
 =?utf-8?B?V1ZOMDdtRUhCOG9Sb2ZEcms2ZjIyWnltWVJIWVd2TFFzNnBwL29wejhxVzVz?=
 =?utf-8?B?dFBIYmhDNTZYcmVlTnMyejFHVm92S3Z3NU5hajM1M3lDUy93MEhiZHVIaWpU?=
 =?utf-8?B?aUF5cWtEc3J2UlE2c014TCtaRDVQK2FOYzJ3MENRcWpYQkpDazFVSWJSbW9V?=
 =?utf-8?B?TU5vbCtHOXVLd0tkYjA1YmJZMUtsL3Y3TjdxYVlJcmtjYWpCV0Q0bG92U2kw?=
 =?utf-8?B?TEx2dVZFYXhtOXdHb00xNkNkU05uRTVmanVhYTg3dEJQVmR5aVJveWVSdlFw?=
 =?utf-8?B?NzdNQ2JpdXNqcGk3RlExRWsrYVF1YXZnbEE1RFYrRXpBSkFmYUdRb3ZLQzAz?=
 =?utf-8?B?TkVSN1lSQWFWNnRVVDBrM3EraXV4OGw5TjVTOEExc3RiM0hOT1N6andaQnBN?=
 =?utf-8?B?a3gwUWZ5eStnYyttTGhuSlhXV3FsV1VIbDZ1cUcvd01ZSlE1SWtpTHVQYmov?=
 =?utf-8?B?VDl6ZGhYMjY1OSt0Ny9vd2hDVXZkYlF3OFdnaFJ6cEIya1ljdlVUbUdpZS9u?=
 =?utf-8?B?R3NCMUNidGxxYmNsWkMvOVlldlZVQzZnVFZoZUMvbWVicjZwQU83U3gycVNQ?=
 =?utf-8?B?dUpDSkJrYWZJVXhRTUxSbzY4RnRVRGNIWFIrMmF3R3lXWU4rc2Z5a2UwSVZZ?=
 =?utf-8?B?ZnU3TXg3WmRXZlg0OWhBa053Wk01ZDgwaU9RVkwxaklqVWovZjZOZkNDR25C?=
 =?utf-8?B?d3lVRDF5RTVWcEFwVjhmTHFVNHpNbnF1cnVQR1haUG1FTUxaODZzeFZYM2Q1?=
 =?utf-8?B?K2lvVllvVStxSUV2cHRWM1dDRzdGRU11RGxNQ2tLbnhGY1k5RjEwTUF6eVpj?=
 =?utf-8?B?NFZMMzVudjFnSi95RkNKN1p4RnR6RzFqeGZTM255Ni8ya3NOakNUdUJkalo5?=
 =?utf-8?B?ZFVPc29nUURKNTdXQktKaUJxS3duaEdSUjFoYkwrSys1enNQbjV4OEVOUUdL?=
 =?utf-8?B?Sk1sRk9ycTZ0NW9vNHpmTUZXVWQyYWNRKzQzNkFmUUJDNjZxclBnbU5iMGw5?=
 =?utf-8?B?ZjhsUFFrTmNTOFdZbG1xL3lnd3B5dXVmUmVIaVJJYW0rMGgzYXQ1SHViNzdn?=
 =?utf-8?B?WHBtOFlEUGNvM2ZuOUJqa0RCY28vdkxEWFFRbVcrSmhCc2ZZQm9JckdrdTY1?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c60e2113-c0d8-4fe7-63f6-08dddc5bd9e9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 00:28:41.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7b22uDiN55K2dxsfWF3DVWhlG3ZfY0L8OwdAomrFooqda6zsA+DtUHnG96N89YpHMhdVPibqXa8U0qj1MfPH9yiU7watFX9bK+TcQZyoAp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

Hi Sagi,

On 8/14/25 10:20 PM, Sagi Shahar wrote:
> On Tue, Aug 12, 2025 at 11:22 PM Binbin Wu <binbin.wu@linux.intel.com> wrote:
>>
>>
>>
>> On 8/12/2025 4:13 AM, Sean Christopherson wrote:
>>> On Thu, Aug 07, 2025, Sagi Shahar wrote:
>> [...]
>>>> +
>>>> +/*
>>>> + * Boot parameters for the TD.
>>>> + *
>>>> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
>>>> + * before boot, so to run selftests, these registers' values have to be
>>>> + * initialized by the TD.
>>>> + *
>>>> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
>>>> + *
>>>> + * The TD boot code will read off parameters from this struct and set up the
>>>> + * vCPU for executing selftests.
>>>> + */
>>>> +struct __packed td_boot_parameters {
>>> None of these comments explain why these structures are __packed, and I suspect
>>> _that_ is the most interesting/relevant information for unfamiliar readers.
>> I guess because the fields defined in this structure are accessed by hard-coded
>> offsets in boot code.
>> But as you suggested below, replicating the functionality of the kernel's
>> OFFSET() could get rid of "__packed".
>>
> 
> I agree, I think the reason for using __packed is because of the hard
> coded offsets. I tried using OFFSET() as Sean suggested but couldn't
> make it work.
> 
> I can't get the Kbuild scripts to work inside the kvm selftests
> Makefile. I tried adding the following rules based on a reference I
> found:
> 
> +include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
> +       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> +
> +lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
> +       $(call if_changed_dep,cc_s_c)
> 
> But I'm getting the following error when trying to generate the header:
> 
> /bin/sh: -c: line 1: syntax error near unexpected token `;'
> /bin/sh: -c: line 1: `set -e;  ;  printf '# cannot find fixdep (%s)\n'
>  > lib/x86/tdx/.td_boot_offsets.s.cmd; printf '# using basic dep
> data\n\n' >> lib/x86/tdx/.td_boot_offsets.s.cmd; cat
> lib/x86/tdx/.td_boot_offsets.s.d >>
> lib/x86/tdx/.td_boot_offsets.s.cmd; printf '\n%s\n'
> 'cmd_lib/x86/tdx/td_boot_offsets.s := ' >>
> lib/x86/tdx/.td_boot_offsets.s.cmd'
> make: *** [Makefile.kvm:44: lib/x86/tdx/td_boot_offsets.s] Error 2
> 

I do not believe that the selftests can directly use the Kbuild
infrastructure. From what I understand, when similar things are needed they
are duplicated. Take for example tools/build/Build.include that is included
in Makefile.kvm and contains the needed things duplicated from
scripts/Kbuild.include.

I see two options here:
a) Selftests relies on the kernel to generate the header file. This unfortunately
   will create dependency on kernel being built first and I expect a no-go.
b) - Duplicate the filechk (that depends on tmp-target), filechk_offsets, and 
     sed-offsets defines in from scripts/Makefile.lib to tools/build/Build.include
   - Duplicate include/linux/kbuild.h in tools/include/linux

(b) will allow your rule duplicated below to work:
	include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
	       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)

tools/build/Build.include already contains if_changed_dep and the command
it calls may just be locally defined to make the other rule you are trying work.

I played around with this a bit and found changes below to work. I certainly
admit that it is crude but "it works" as a proof-of-concept. I also look forward to
learn from other folks on how to to this right.

If you think something like this is useful then please consider below only as a 
proof-of-concept since it needs to be split appropriately, missing cleanups
(handling "make clean"), may not need to be TDX specific, etc.

---8<---
 tools/build/Build.include                     | 56 +++++++++++++++++++
 tools/include/linux/kbuild.h                  | 16 ++++++
 tools/testing/selftests/kvm/Makefile.kvm      | 11 ++++
 .../selftests/kvm/lib/x86/asm-tdx-offsets.c   | 28 ++++++++++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        | 16 +-----
 5 files changed, 113 insertions(+), 14 deletions(-)
 create mode 100644 tools/include/linux/kbuild.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/asm-tdx-offsets.c

diff --git a/tools/build/Build.include b/tools/build/Build.include
index e45b2eb0d24a..330892a1ba15 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -20,6 +20,10 @@ space   := $(empty) $(empty)
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
 
+###
+# Name of target with a '.tmp_' as filename prefix. foo/bar.o => foo/.tmp_bar.o
+tmp-target = $(dir $@).tmp_$(notdir $@)
+
 ###
 # filename of target with directory and extension stripped
 basetarget = $(basename $(notdir $@))
@@ -43,6 +47,58 @@ escsq = $(subst $(squote),'\$(squote)',$1)
 echo-cmd = $(if $($(quiet)cmd_$(1)),\
            echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
 
+# Default sed regexp - multiline due to syntax constraints
+#
+# Use [:space:] because LLVM's integrated assembler inserts <tab> around
+# the .ascii directive whereas GCC keeps the <space> as-is.
+define sed-offsets
+	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
+	/^->/{s:->#\(.*\):/* \1 */:; \
+	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
+	s:->::; p;}'
+endef
+
+# Use filechk to avoid rebuilds when a header changes, but the resulting file
+# does not
+define filechk_offsets
+	 echo "#ifndef $2"; \
+	 echo "#define $2"; \
+	 echo "/*"; \
+	 echo " * DO NOT MODIFY."; \
+	 echo " *"; \
+	 echo " * This file was generated by Kbuild"; \
+	 echo " */"; \
+	 echo ""; \
+	 sed -ne $(sed-offsets) < $<; \
+	 echo ""; \
+	 echo "#endif"
+endef
+
+###
+# filechk is used to check if the content of a generated file is updated.
+# Sample usage:
+#
+# filechk_sample = echo $(KERNELRELEASE)
+# version.h: FORCE
+#	$(call filechk,sample)
+#
+# The rule defined shall write to stdout the content of the new file.
+# The existing file will be compared with the new one.
+# - If no file exist it is created
+# - If the content differ the new file is used
+# - If they are equal no change, and no timestamp update
+define filechk
+	echo $(tmp-target);					\
+	$(Q)set -e;						\
+	mkdir -p $(dir $@);					\
+	trap "rm -f $(tmp-target)" EXIT;			\
+	{ $(filechk_$(1)); } > $(tmp-target);			\
+	if [ ! -r $@ ] || ! cmp -s $@ $(tmp-target); then	\
+		$(echo-cmd) '  UPD     $@';			\
+		mv -f $(tmp-target) $@;				\
+	fi
+endef
+
 ###
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
 # (needed for make)
diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
new file mode 100644
index 000000000000..e7be517aaaf6
--- /dev/null
+++ b/tools/include/linux/kbuild.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_KBUILD_H
+#define __LINUX_KBUILD_H
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem))
+
+#define COMMENT(x) \
+	asm volatile("\n.ascii \"->#" x "\"")
+
+#endif
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ef2b1a47719c..e7bd835a56db 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -241,12 +241,14 @@ INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
+LINUX_TOOL_OUTPUT_ARCH_INCLUDE = $(OUTPUT)/include/$(ARCH)
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
+	-I$(LINUX_TOOL_OUTPUT_ARCH_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
 	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 ifeq ($(ARCH),s390)
@@ -256,6 +258,15 @@ ifeq ($(ARCH),x86)
 ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=x86-64-v2 -x c - -c -o /dev/null 2>/dev/null; echo "$$?"),0)
 	CFLAGS += -march=x86-64-v2
 endif
+
+GEN_HDRS := $(OUTPUT)/include/$(ARCH)/generated/asm-tdx-offsets.h
+
+$(OUTPUT)/lib/$(ARCH)/asm-tdx-offsets.s: lib/$(ARCH)/asm-tdx-offsets.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
+
+$(GEN_HDRS): $(OUTPUT)/lib/$(ARCH)/asm-tdx-offsets.s
+	$(call filechk,offsets,__ASM_KVM_SELFTESTS_OFFSETS_H__)
+
 endif
 ifeq ($(ARCH),arm64)
 tools_dir := $(top_srcdir)/tools
diff --git a/tools/testing/selftests/kvm/lib/x86/asm-tdx-offsets.c b/tools/testing/selftests/kvm/lib/x86/asm-tdx-offsets.c
new file mode 100644
index 000000000000..ad56d99b56be
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/asm-tdx-offsets.c
@@ -0,0 +1,28 @@
+#include <linux/kbuild.h>
+
+#include "tdx/tdcall.h"
+
+static inline void common(void)
+{
+	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
+	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
+	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
+	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
+	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
+	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+
+	BLANK();
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8, tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9, tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+}
+
+int main(void)
+{
+	common();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
index c393a0fb35be..e98aa5178db9 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
@@ -1,18 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Adapted from arch/x86/coco/tdx/tdcall.S */
 
+#include "generated/asm-tdx-offsets.h"
+
 /*
  * TDCALL is supported in Binutils >= 2.36, add it for older version.
  */
 #define tdcall		.byte 0x66,0x0f,0x01,0xcc
 
-#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10) */
-#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11) */
-#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r12) */
-#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r13) */
-#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r14) */
-#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r15) */
-
 /*
  * Bitmasks of exposed registers (with VMM).
  */
@@ -91,13 +86,6 @@ __tdx_hypercall:
 	pop %rbp
 	ret
 
-#define TDX_MODULE_rcx 0 /* offsetof(struct tdx_module_output, rcx) */
-#define TDX_MODULE_rdx 8 /* offsetof(struct tdx_module_output, rdx) */
-#define TDX_MODULE_r8 16 /* offsetof(struct tdx_module_output, r8) */
-#define TDX_MODULE_r9 24 /* offsetof(struct tdx_module_output, r9) */
-#define TDX_MODULE_r10 32 /* offsetof(struct tdx_module_output, r10) */
-#define TDX_MODULE_r11 40 /* offsetof(struct tdx_module_output, r11) */
-
 .globl __tdx_module_call
 .type __tdx_module_call, @function
 __tdx_module_call:
---8<---




