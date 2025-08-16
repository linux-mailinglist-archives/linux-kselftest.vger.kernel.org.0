Return-Path: <linux-kselftest+bounces-39130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B284DB2894A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E49C5C5F8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460423DE;
	Sat, 16 Aug 2025 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qeb6BqjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CF171C9;
	Sat, 16 Aug 2025 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304363; cv=fail; b=kARoIJ/gaGj8+bPVwuJ5QnH33DKhPmpAPNIVxkItViwrCA4Y8KL8DaA9wTtJg1rvmN7W6YPYQsrkSEw9TAZJQ7Vc2TU1Iz82TcQQBcynAbIlf4MC4MsH8KLuOeENaw4jS9MU8/z2hmZyq6KbIOS61Bh7u/AIUhKwc5uBPK7BUqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304363; c=relaxed/simple;
	bh=1ZBIu+WDDFQ3+jvNFXyzLMcMWxj0GtyG/ggiuOHD+UQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kpUZqv9Mqwh7xEoVRCDuGts/zTreeYtxrT15qR1wL9vM8jfPzGh4vgKAZXly2WboLS6exnXP2C3fGYhCkNVZq00vtkCzP1sSxgvrCRUE03BfjMQNM/3qEmfzo5QZGZh2WP1klXe10r6MT02IOugPoF6g7F8cCzIN9DHwT75AcnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qeb6BqjE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755304362; x=1786840362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ZBIu+WDDFQ3+jvNFXyzLMcMWxj0GtyG/ggiuOHD+UQ=;
  b=Qeb6BqjELhG8pViwpurJJOaRDyMYdze8MnftvPJ68ST2FhDHIt6lh2Ve
   v7G3YL6ID1RtE5mU7ZQcAvPRmEm+k0TpjLNYt5V2Islj1lq759cVWl4JZ
   08fYdq7Aq4bjItaGbwGgMX1Ws6upRWu3k4tFoYP4aGeoZICRhb1r6m2Y9
   pB6wWIxFuQChN2AdHnLiN8cyGVwMq7p6CVHjdT41lPZIRdv0mC37PUcha
   XUIjhL0kbbanJgEVoPS4DvkXBh4x9YUmvy/4jg58H+wp+CtXASvGaD8jt
   LOk9H0ioqjfQq+JHG0AV/LD9KymWMDDMsXwZQNFeDddso8zy3B7q4E66D
   A==;
X-CSE-ConnectionGUID: 34GE18UvRoCJAJ661Lbxyw==
X-CSE-MsgGUID: ODqHX3+gRyGLmTijs1ryGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="61257479"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61257479"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:32:42 -0700
X-CSE-ConnectionGUID: Jvr5t9KURCGY0alCGUTCVQ==
X-CSE-MsgGUID: K6SshI9RQTGMI2RQnScd2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171250498"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:32:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 17:32:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 17:32:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.53)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 17:32:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUw3Cdilz4dAJqOQgPRQEhKiF/PQXMlowsgTyYprACF8G3gZuqCJdnksOtB2+20r6zhKO+/9/mBfQK5AhETGOckR4792b6qa3YRJUViEk9UT1qp+voBymrZtSIYNf7JseA3TBebwvCmUMjlQQralSbs+1U5ikZ5+zpZEqSnkCPiD3SQVpKp5vAWj2W9sQ4ZupgBylbQvS+cepE0VJMzdL0V2v8RWu3yO/JkGNGFbQC7jNMe8Tfoc0f9WhKn3aXLZ4eya1fK7MQNZYV8q2gzhITq7sw8RuouS5HeHBp8hBTaLhoFoF4ruyWXkSvNgQc+xCCk0qKfR/L+7vaQJWRN9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ1zrgfJiCRyg0BMIvUPQWpQ/MWZJapeSFodDpbxNBU=;
 b=fvfVCOmX3rhYrE5B8xsUuPOyYlt53WElIAPFTnIzpba4ONZ+w+nyP7ZM9iHdOx8WWAdpwyTXAW1p5WKTOa8u7zFoh1Hsf+vv6ndUJTEPV7x0a3Ao346jotv2yBuH8aYrY30a4t3vTZT/QtCkvR9HZyS9RWQinWJ+1xazzxhF+5FxOtzbuAX8adiioManqWAoVj5vIsuAyij5LGIRwj4AcVohe3qlVpXPIQKjgYptolIEmkcv/XqbNiHIf91KosT5JJBHd2z4uQnlUTKR4oDPkoYAuHBHbDoqUQ+AyUl8ou7OcwiAQyFVyoGNq6nKHIegoDg2yp0pl4O0H+o/Aa7S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 00:32:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 00:32:37 +0000
Message-ID: <09c45d9d-df5b-456f-a8ff-b887d8a705c1@intel.com>
Date: Fri, 15 Aug 2025 17:32:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
CC: Binbin Wu <binbin.wu@linux.intel.com>, <linux-kselftest@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Ackerley
 Tng" <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, Andrew
 Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	"Erdem Aktas" <erdemaktas@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com> <aJpO_zN3buvaQoAW@google.com>
 <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
 <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
 <aJ_PQPkD3qrlW8jZ@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aJ_PQPkD3qrlW8jZ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1019fe-d6ab-4920-dd2f-08dddc5c66ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE9YVG00WUJMSjV0cDYwdXg0cm4rcm5UMUxMQnhRb1MrK1ZhMXo1VFBoRU9N?=
 =?utf-8?B?Q1A5cWFKcDlYcEp3MUZYUTJlbzZ4UFQrekhkZEZvZnhESG04Rm5Rb3dlamVM?=
 =?utf-8?B?bkxsaWJYc2UyT0tVaEtYZFgxbElybGI3dDI2M1Z5N2hVRGdualc2a0NnWFlE?=
 =?utf-8?B?Y3hjVTdlZkFETnV3eWZPclVHNFdpVmRQVTkwR21tLzdLRms2WTVLaW1GSWZ4?=
 =?utf-8?B?eDdlbUpIWi8xQktGYklPZGdoeHdNYWhJQ0NVYnlyTGJTYTZrb0hKb1NocWo2?=
 =?utf-8?B?Q2NaV3ZVajJ0NWNYRm9tSFVoUVFDQ0RuR2ExN28vTklQcTBERm14NHFoOFVp?=
 =?utf-8?B?TGRRc1U5TnBTZUZia3FwNE0rcGkzazU2R2l2RGJEWFZBUWNJcENqUW1jODRJ?=
 =?utf-8?B?M2pIU3d2bkF2ZXZFOTExbGRmWm5COUQ2VW5wemxRdkNxQWRuVGh6enN0Z2Zw?=
 =?utf-8?B?VzloZVJrdmhCWUpvK1AvYmZzS1pyWG5MVFJ3WURqRldmU1htRGxYK3pPR29D?=
 =?utf-8?B?dzl0R00zcnR5ejRJL0lLWEk5VmNjREF5Rm1WeG41SDlnTnQ4RlMrK1NRMm0y?=
 =?utf-8?B?NTBUTVVtdEdPdlBXZ0lSV0pIRzJqQWU0QUNibmw2TXdUeFVUdndRWjBuNjRr?=
 =?utf-8?B?WUtkQllOS0pJWjVHalhqZ3UycU0yOVQ2MlJYVG5LNWdCaStZcHNSM0t1dWo1?=
 =?utf-8?B?RE9QNTJPOStCcmNNaURaYjRGSno1cGlFR053N3NKMlhWb1dtMTd2VUxhRmtX?=
 =?utf-8?B?NDdnRzBsMDA2MlhuaFhRZWd1SXpGQUorTkFwN1JqZDF2NzJTVklaRk5vZVFJ?=
 =?utf-8?B?TFE2TkFyc2lSWWhOTjMrcmxiSDl4a0tOcmQyQlhRVllaNmNZRm5aeTh6VjJn?=
 =?utf-8?B?MkUySGlETXVNMlJQeENDdElVRFJPWXdiVkpnRW1LNjN2a0NqOEpnSzA5elFX?=
 =?utf-8?B?a2R6MDNTcHhtVHFKdzNLeFRwb3VpQ1h1Z2N1UnppUnpBZXR1ZXJDZFBZWHR0?=
 =?utf-8?B?Wmhzd24wbFNrejExTS9YZTQ5TjN4QWtXTXlHTFZZWCtPQU8yeThFeS9VNUx2?=
 =?utf-8?B?Y0doYWQwQm1nQ3RlUTF0bUI2VkpkcGZvamZjMzNsRDVtQkhKam0wT3NrVFBx?=
 =?utf-8?B?S21zYndxYUtrL0szQ2xzMUFESWMxK0p3bDNNY2k5RjA0eXlyU3g3NXhPZmFN?=
 =?utf-8?B?ajlFMENYMU80WUxLY29kYldHOEFSblh2ZDRFOGlFdEVFd2ZsZFFRdzJKRVcy?=
 =?utf-8?B?UXIxaUFNWVo5dFV5bkRjT2owVWxFMnZjYjRoZE5MK2NYMnV3WiszdUh4ekhB?=
 =?utf-8?B?VytURzNkVHhpc3J1UEJQYkRCek04VWdEdGpCM3ZpU1gwQS9BNlJiR3hmUE0x?=
 =?utf-8?B?dXRRUVpaYTAzMjNocU10N3JMQkJzWE5BSDk2eHpvZFRVQzVESk02RE1DcXlG?=
 =?utf-8?B?NWN4ZmFpS3Vnc2syKy9rd2tlbWpBeDQwdEgyQzUrYmFPMDdzWVpIWW1sc0Z2?=
 =?utf-8?B?SlFYZVp4N3UzTC9DV3VuaTQ4cG90b2l1UVlLdXJhNVppcmZFTXJSRysxUFBO?=
 =?utf-8?B?QTNWVUx6cnRybVExV3Z1a1E5WUFMMWg0WTBDa01TV3ZkWnhwMmF4M2M2dzdJ?=
 =?utf-8?B?WFllNkJKMzBrTlVWREh4YldQSXJybTFEbTAxY25wZXdpNFBsb0haak9yVnlI?=
 =?utf-8?B?Y0E2a1RtMStHa3JPQ1hIbTBuR050UnIwclV1RlJib1NBV29hYlk4bG1VY2xC?=
 =?utf-8?B?NUpIRndYc25qYVhDcEZyYU1SazIwR2h6TzRoRmhXNTZuUDdiK0VGanFJU1ln?=
 =?utf-8?B?eXUzS3VsSitFOVRvUFNtU2gvZm00QVZONExBSWMza1dwU1hNeVpTOGFQWFc0?=
 =?utf-8?B?Vk0wMktSMzVMS1JuYlNKKzlNZmRaMDZMSE0zRHVQeTBPMFcvUjVnbDdsdk5K?=
 =?utf-8?Q?E3Q/to2/Ruo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJ1Ti82YVBmVkdINy9Ub0VFRld2UHZOZHBlSzY3cVJyY3NJWWh3c01aOHdm?=
 =?utf-8?B?M1BDazM5K25SVjVDQ1JaeTBtVVF1UTRlT1B5cEhob0EwcytBVFloMHBYNFUr?=
 =?utf-8?B?RUZ3NWhEK2VTcGgrUXcyQzVPSk5LVVdsL2xaR1JwOFQ1bFRRTnlldGFVRXQ3?=
 =?utf-8?B?ams1M090aGRVQUhyNXYrSHRXNmh0NGtXTXJEcExYa0hOVkxQeGxjS0piUitq?=
 =?utf-8?B?UWxoVW1RTDFPcjk0Nlc2bnZyVW5wdjNXMEFqRmFsaEQ4K1BrR0NpU01Jc1d3?=
 =?utf-8?B?ZW45ZUpNYTZGMXROQVVSK1JlZzExM3JDRThqZE5ZT2FTMVE0Sy9GOHJYaUNk?=
 =?utf-8?B?MHNTUUNwL2dQdzN6d3RSVDFUL0JtU2RURk9taFVvTHBId2RSKy9hd0c1RUdx?=
 =?utf-8?B?aGVFeGlvWW1YalNoOGhpQlF5M1h6VUh3T2V1MjFpQVROdHJtcDh0OHU0Zm82?=
 =?utf-8?B?ZVRoeFY5TlRVTG10aEJwNUxRdDlKbWk4NjZhbkVnYWRBS25lRC9aZEtMQmJj?=
 =?utf-8?B?VER2OGdzV0pDMlA2MjAzV2JqRkdtQXVabDVTYzJBaUduRlpiQmhxeHhGenhj?=
 =?utf-8?B?aFZORGlVTndSYTBSMnRzczFiSG5sWmpObWFmZU5mV0N3UTF2T1p5cFBhWEVR?=
 =?utf-8?B?Z1VzdU1jbmVJeDYzRFNIZUhuS2Q0K0dVSXJsV0gySERLc1ZFbTNKb2EyQldq?=
 =?utf-8?B?cFJOclVuUnpLbExOL0txNk9BTEVOMU5Uc2ovK2pqTEV4Z2NzeW5RT3h0UGtV?=
 =?utf-8?B?ZVRQdVRERWJCa0IycDBtTjNSeldXaVFtR1diTVFrSnVLVDFYS3QwOUlobkk3?=
 =?utf-8?B?ZGdQeTZta3V4c1YxUkRMNEpoVjZVbnhzN2lwTElKR3ZTQlhrN0FUd3o5elZN?=
 =?utf-8?B?VmxMUVp0bExmcHpVWnJ1TjBRTUZrNzh6OEVheXZBdkRMVVhJbGNrNkZNRlNo?=
 =?utf-8?B?N3BTVTZyWGhla01XWjUrbEtvNWUvMkl4anRrTlpEQVdJMldHa0o0QmxpQlF0?=
 =?utf-8?B?Qk1NRjRUYUtwM0RSQ3lFYnIwWEJ1aHBJZ1BHcXpyQ1ZWRjdBZHJCdk5tMFJw?=
 =?utf-8?B?WFRFVGphSDM3TGl3RHBrYUwraGQ3QWlHL2Q0emZOaGM5cnA1M3ArOGpqeGVu?=
 =?utf-8?B?ZU5OODVhQm5QZHFyaFZUc1UyVFNZNzB1WS81dEkxNlVoMERqeHpIOTFERGpM?=
 =?utf-8?B?eThjT3BJaGh2QzF1cFpnNVo5WWx0TDVsYlRJdHcrR0hNRldoUy94VUdvTjMv?=
 =?utf-8?B?OEVFSlZrNDZROXVnSzliZlVDU3EyNlRheGhIUkwwRDhEdUV6QzZ3MDhJak45?=
 =?utf-8?B?a05sVjVWTDY4RXdlY2NHeEp6MnNMVzhNcTVyVktVNmZZbHh5WVlIWklmNkRi?=
 =?utf-8?B?UHVJRy9MNDMrcVIxc3dGa1RyaEdFMVh3dmFlT2VmOTRYWFVtTUF3dStaWFhG?=
 =?utf-8?B?WHc5aFU1bXoxK1VhS3FDUjkxSEJOVGFFdVV1UEdSTDJvV0JzcUZQNTMxZWRw?=
 =?utf-8?B?R20vV25ISlZ1dkpES3BRbExRU0VZV3oyR2lIeXA4aHNnMmc2S2hHemp1YW02?=
 =?utf-8?B?N2x2SCt1UDZPTjR4a1pTZEhnczdSRDZtUXhlRS9CclRpc01ibitnYjdsdzFM?=
 =?utf-8?B?czY1TVhWRmVKSGZ2MWJzSUNTTlNQNkVVcDRTMkFNNkNtS0FnUDYxUERRcnc0?=
 =?utf-8?B?WWZkT3Jwa2RVc0pRSzRnVXY2dTJGRVFxSS8yVk8rNXJzcG1YeTlmZ1RsMWxW?=
 =?utf-8?B?TmdBbTFLdGxmWkZGTGVWVXhjd2JybEpvYXRyQ005WXdRUTN6Y3ltMGNFUDJz?=
 =?utf-8?B?RUZaSHU5OEZzWUFKQW9aUVgrYmY2QWVMZ21tc0FpODNqM0FVcDhZcXE0TkNJ?=
 =?utf-8?B?b1JuWGZ2bWtHWDNFUkZBUnJwcGtGSmpuOEdRc2NRdTJSZmI1V1A2aUhLTVJI?=
 =?utf-8?B?VjkvYndOR0psa2tWVisydThjTXVuMnZBMUErTHJlTjFETXM4MXlmdnZ3bkZ5?=
 =?utf-8?B?RUJyY09jQ25iL0syVXZURDQwa1dRQ2x4cll4Z3JEZHNhWEJHQnRQcTRVcUZD?=
 =?utf-8?B?THlDTzFFVWwxVU16UzlvRHBRS2ZZWFhmMC9NM0ZUaHZ4a1p6RjhBbVROeEFZ?=
 =?utf-8?B?eTdZeGZJR2xwNUxHZDAxRDQxSHNPdWxvR29NaDRoeHlMVFhzOHlsL3RpTm1r?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1019fe-d6ab-4920-dd2f-08dddc5c66ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 00:32:37.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ4GU+MkPnaImjsB+F0dCzzdFrWGUGkb6LYSlmQEzOOYfTKZasVYbRb5OLa0fJqV6AXu+oW0LoqM9IQ6TjWyRCm+TlZrU+TWsVmiNmIJweg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com



On 8/15/25 5:22 PM, Sean Christopherson wrote:
> On Fri, Aug 15, 2025, Sagi Shahar wrote:
>> On Tue, Aug 12, 2025 at 11:22 PM Binbin Wu <binbin.wu@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 8/12/2025 4:13 AM, Sean Christopherson wrote:
>>>> On Thu, Aug 07, 2025, Sagi Shahar wrote:
>>> [...]
>>>>> +
>>>>> +/*
>>>>> + * Boot parameters for the TD.
>>>>> + *
>>>>> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
>>>>> + * before boot, so to run selftests, these registers' values have to be
>>>>> + * initialized by the TD.
>>>>> + *
>>>>> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
>>>>> + *
>>>>> + * The TD boot code will read off parameters from this struct and set up the
>>>>> + * vCPU for executing selftests.
>>>>> + */
>>>>> +struct __packed td_boot_parameters {
>>>> None of these comments explain why these structures are __packed, and I suspect
>>>> _that_ is the most interesting/relevant information for unfamiliar readers.
>>> I guess because the fields defined in this structure are accessed by hard-coded
>>> offsets in boot code.
>>> But as you suggested below, replicating the functionality of the kernel's
>>> OFFSET() could get rid of "__packed".
>>>
>>
>> I agree, I think the reason for using __packed is because of the hard
>> coded offsets. I tried using OFFSET() as Sean suggested but couldn't
>> make it work.
>>
>> I can't get the Kbuild scripts to work inside the kvm selftests
>> Makefile. I tried adding the following rules based on a reference I
>> found:
>>
>> +include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
>> +       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
>> +
>> +lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
>> +       $(call if_changed_dep,cc_s_c)
>>
>> But I'm getting the following error when trying to generate the header:
>>
>> /bin/sh: -c: line 1: syntax error near unexpected token `;'
>> /bin/sh: -c: line 1: `set -e;  ;  printf '# cannot find fixdep (%s)\n'
>>  > lib/x86/tdx/.td_boot_offsets.s.cmd; printf '# using basic dep
>> data\n\n' >> lib/x86/tdx/.td_boot_offsets.s.cmd; cat
>> lib/x86/tdx/.td_boot_offsets.s.d >>
>> lib/x86/tdx/.td_boot_offsets.s.cmd; printf '\n%s\n'
>> 'cmd_lib/x86/tdx/td_boot_offsets.s := ' >>
>> lib/x86/tdx/.td_boot_offsets.s.cmd'
>> make: *** [Makefile.kvm:44: lib/x86/tdx/td_boot_offsets.s] Error 2
>>
>> For now I can add a comment on the __packed and add a TODO to replace
>> it with OFFSET. I think that making OFFSET work inside the kvm
>> selftests will require more expertise in the Kbuild system which I
>> don't have.
> 
> No, I don't want to punt on this.  I don't care about __packed, I care about the
> maintenance and review costs associated with hand coding struct offsets in .S
> files.
> 
> The problem is this line:
> 
> 	$(call if_changed_dep,cc_s_c)
> 
> IIUC, the kernel's "generic" command for generating a .s file from a .c file
> assumes various paths and flags, which doesn't play nice with KVM selftests'
> unusual setup.
> 
> We could fudge around that by defining a custom command, e.g.
> 
> 	cmd_kvm_cc_s_c = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
> 
> but that just runs into more problems with the build system (variables not
> defined, more assumptions about the environment, etc).
> 
> AFAICT, there's no need to use if_changed_dep, i.e. fixdep.  KVM selftests
> generate dependencies using standard mechanisms, and they appear to work as
> expected for this case, so just omit the if_change_dep and let the existing
> dependency stuff do its magic.
> 
> This could be tidied up, e.g. add kbuild.h to tool/s, and is obviously incomplete,
> but it works.
> 

Thank you very much Sean. So much cleaner than what I came up with. I need to
investigate why those includes did not seem to work for me.

Reinette




