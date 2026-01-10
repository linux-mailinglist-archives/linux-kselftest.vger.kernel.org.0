Return-Path: <linux-kselftest+bounces-48638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB8D0C993
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92C6E300B017
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0412B93;
	Sat, 10 Jan 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LImw/i5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAF4A07;
	Sat, 10 Jan 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003419; cv=fail; b=A9lTMjRFTpdFfAgHUY8RyxgBi/gsgjZcsAv9l9xZthu820nmI4CVe8/lwoVokBoDnBMKP+jZlCAErahRxgWL5mXlrcDzOLdT1r0lpoayVQpnZIFDi8xBXpEe0R1QYAzYGQuvaehpXZZOE4iDUu3bzUoPgBwSfEzPuFfwXaIbrIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003419; c=relaxed/simple;
	bh=hTxRJocax/E0etnwERBH/R5PgyyXcc6U5ueipArxo58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bW6IY4+zGrEHjJYU9i3aNYa5b8jLsuEC/UQWsESCYGaZ4OGWPjlI+ULT425kO5Mw4Nf48VIKSy+9rCjDW/aSs/O8mR4X06euh8L4ArAfsJvy3ShWLyj9beIF6LOPsFwEOqoitJhNC2VgU9B89Dev2/De482sjzDE+kb+fDEdpsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LImw/i5n; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768003415; x=1799539415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hTxRJocax/E0etnwERBH/R5PgyyXcc6U5ueipArxo58=;
  b=LImw/i5ndacydFXINRaGZdRDxUJDxuwNRkdPmLrAI6s52N2d1iCjGgOH
   sEYqfDTMt2uexRoWFRa+NkPKwX/EfR3G4frjJxcIpq4/dH6rm3PtHTabB
   QSJTBi0cOB8RYda1n/wa1MKcOkN2DwNpmr9wcSK+VhGPK0R8ZXHrNAOaD
   0PrKl4ytG+db1lG5QbtvW+pMQEmkcqIUpC669eKXxcwgDEgO6u+3NB03w
   xC9bHlQq1ZwOREEsHDDcz8T0moyAdS2i+uepNQSVDSoT8dhfnJGRp64bg
   FlMwDXkC+bz0ZMjwhMk1UtsxTYHTT+/2ASxkrbp4Oji1hzkVXLgbqXIdF
   g==;
X-CSE-ConnectionGUID: xCZDnCm2TB2fmxezDwTQqw==
X-CSE-MsgGUID: YfkzSEcpQ6eJaWbQ0CjuqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="71960200"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="71960200"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:03:34 -0800
X-CSE-ConnectionGUID: +xZYVo1mRBi2j+e+bfi4Dw==
X-CSE-MsgGUID: Rn4zIx9YQwq/YJV48AOMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="204372202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:03:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 16:03:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 16:03:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 16:03:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4OAMMnfc1VvYQvvmbX8skEudJdDL3/6VDoSAz5NuXWymu+/mUfl/BLb5G+7YeaDqhWv11VLLm4IXDBjtlAtciHvQUh5oB3i9TYnMAfHOTtTkzYXBWtp8fjkOPpuvGOEYDfz0cxzdYrV/qnlAZ3t3nkfuhl9l2V9oncvirg/Z0O60/d8Xx1v7yiFd62OtP4eqIsXqt5PYY6LiC4shTNj0jX1X4Be0CQaxrvysntCBVTEwBvGPJcSQf+249qy0AWxDcOU35vcc9fxq78Ez7pCWn/vHWnWA+YGuWrGJMnA6QKOmYxnvIjnIWxu24XZDBiSbA6y379oRC3xj3QBM7Necw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3p1eFox9ecBiU4k3M+yR019SjGs9xQGzAuh8qRqvLg=;
 b=cVmXlcYBFO8tpamKoOOnwYKCYYx65sEs4ERTaPTLeDHKyGeskUSmlqMYz1G0IzjmACI3N2mFs8wVxR2nUPZTZXgwIrBl4YbvmF/ertdzdBcGkQfyTu+z05vIsNwkgH1erHzGeefnupAANQmECJYciv1b5Aot7HtEtb7r8CO/6y1GSZh7yjO+yGHEBNWufI5RX40q32XcrmTM0odbf6G2TZd2TawE+E7P6cqZTpnsbESZD4gInaOfasTSrYvwlMWOi/3lOJVuMC9sZeabfSDZKGvjThj2pt73Spc15chl9yvlVyE26KqnPuT3m6U7Grb6kjN3FZnfCCDrxU0iSwJguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6183.namprd11.prod.outlook.com (2603:10b6:208:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sat, 10 Jan
 2026 00:03:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9499.004; Sat, 10 Jan 2026
 00:03:12 +0000
Message-ID: <bea4807f-fb01-4bbd-a5d2-66b78d524c30@intel.com>
Date: Fri, 9 Jan 2026 16:02:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] selftests/resctrl: Add Hygon CPUs support and bug
 fixes
To: Shuah <shuah@kernel.org>, Xiaochen Shen <shenxiaochen@open-hieco.net>,
	<tony.luck@intel.com>, <bp@alien8.de>, <fenghuay@nvidia.com>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
 <bdecae64-5f6e-42d4-a05b-3334b95e6ec0@intel.com>
 <3692e9fb-b827-413f-902e-a57d6d3aca20@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3692e9fb-b827-413f-902e-a57d6d3aca20@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: ae30c542-e816-4576-b675-08de4fdba52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjFCaUxUdUc2RnUrZHlORmY0N0JXbDJzY0ZGdkptZytMd2xBdDlCc1pBZ2NY?=
 =?utf-8?B?OElDM3R1MnJBcnA0QW84VjlUdW5lOE81NkZTYzhCbThEQjd4OEVTd3JiVFRC?=
 =?utf-8?B?SVBGZVVDNlUrUnBDRjEwRTN0TjdhVVV2ZFJybk1BbEgxUFBxYlZYdHRhcjgz?=
 =?utf-8?B?OVZRM1g5ZFV3OGFjaVlBc0h1WE1JL2JJblNpTFlJa2VzM3JvVmxwaVBYSUw0?=
 =?utf-8?B?eGQvekhPTnlxTElWc3ZyMVFHNzBMd3RjNVRCRlVpNzM0N3hKVHBLNWVuQjQ3?=
 =?utf-8?B?TEJhR0JxaTZCRGRUMDBTUFpxWDNOSGFFcmp3TDFhUkNYdE5wb3UxVFhtaUhS?=
 =?utf-8?B?bDF0eXFCdkEzbnRra3A2TEVKSEZMZDNOSXNxOWhjTmxodllIeW9JTWQ4RTRG?=
 =?utf-8?B?NFNsOFVIbGdFRHU2akNqNjdodUpRRHE5emFscm5Na3RtaWxQY08rZjVKWlly?=
 =?utf-8?B?cm8rODM5UnAxeUUwbkJxNlEzWjlmSG5VOUkvUzZKS0xPaEVybkVtWWorU29B?=
 =?utf-8?B?bi9NZ3BET0cyVHhnbmdYcEVNSVBLT3BKck9LUDFLY3F4VTlCaWZST29Jdm15?=
 =?utf-8?B?WmxpN3hlOWR2THYvT2g3R0hjdXA4QkU3YnB2RDNCK3hSVkVBL2tSK0Y3cjY1?=
 =?utf-8?B?QklYZFpIaWpwSHp3ZXNCOFRqNERNUHdDcnhWMUtBZWYxQ01wUnVEVDQweXNS?=
 =?utf-8?B?L01wUTZndFVJK0RablZ2RkxEZURLY3MvY1ZGRnlaa3BWeUVIZ1RNd0ZoZkpH?=
 =?utf-8?B?VGNuaUNrSnZ2RUZaLzZjME5jME9PMmJnRzhCcVA2Rk5EdXFjb1NCZ2xRbDNG?=
 =?utf-8?B?RE9TQk83RXNwbHZDUVI4clRyVHNHS2JtakdnbGlvbUFweW83K1pQY25kY040?=
 =?utf-8?B?djJiU0I2dThDSHRqZW53MUxDMnNvcDlBVWJENzJpV1Y0eGhJbWJoeERGRlpn?=
 =?utf-8?B?c3NHdXYya1IzbzI2ajNKUkFXR2l3elRnaUs1dWpRZ3BxaFVINWltY3A4SzdM?=
 =?utf-8?B?ZHQrNGFIR1lDeERseHNaVkpUSzcwTnN0a1pYUWZXTnBkaVA0MDBuenpLZXpY?=
 =?utf-8?B?ZXgyc1dVMjQwdlZtbHhRcDA5czljbCt5bzNXUEx5NUhYQWV1cnBiMzBMZGwx?=
 =?utf-8?B?SitkVXF4U3Y0TVB3OGFBZk4ycnJZbnZDRG1hVEVDRGlSVkR0SnRmTmNRU0M2?=
 =?utf-8?B?QWlFL3ZXNFM5emQ4QlV1RnM5aGNDbXRIc0pPMjlmeGV0S2lEZ3RlcmVGemU3?=
 =?utf-8?B?ZUR0eWhEek9kUlZWSVdKby85N1pjamFSVUw5cU1kS0ZLb1Z0cm9keC9USHY3?=
 =?utf-8?B?R2F1b2lIWmFGdWtub2Zxdzc1QVB4bHNETUhocEdSc3hPd2dVM2lZZ1BZYTBM?=
 =?utf-8?B?MHlkT2hJY1ZER1pCbCs2eUhReXc4WFpWRm93M3ZveFUyYXM4OVM2OStFcVJo?=
 =?utf-8?B?T1dHeW5OTm81UG1XTVlWamNQc3lsVkhNd3dhVUd5YWMxcGwzNzhkMW51SGNP?=
 =?utf-8?B?RDVJWWdQQXNVaHlEVGxUNldqU1IxcUNjck1wSmc2cHNSN3dHVGI4OWUrai9X?=
 =?utf-8?B?ajltdkw0ZUxGMFUvZlRNUms2azlNQmlDeFkxY2xJMEdobEgwbHdSVnVESVRF?=
 =?utf-8?B?ampPcE5WTFBYQnhjeTFrYmpGYy9jOW1aZkJuU0luZEZoTUR6N1BwclRPR1Vr?=
 =?utf-8?B?bzYvOVhqSjV3OWhrZnErV2s4R1RyeWFvbVhzV0pjN1ZUc3pQWndnZnFGVi9Z?=
 =?utf-8?B?WHhMRE90VXVWbVQ2K3FEMjVieXV1VFJUZXRtMFptdWQrRllGdkYwalBMUVhr?=
 =?utf-8?B?RHV6em80N01LMUY2c011SDJRdlVLdkREcXZ5SzhrRHFSdEM4MXRtdVVxb3M2?=
 =?utf-8?B?Y1JuQitjMWlIbXBibUFkUFFZZmZEdUVWQkczenpmazRhR25yNDlINVR3Z0lJ?=
 =?utf-8?Q?90Fm1sF66QnlLr2d76ozA9/9xPcqd43j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHQyQjEwaU1pQzhGTk1aRWhxR0dWTEd2QWZFZUdOTDNQQVdERWN6MEhzUUFo?=
 =?utf-8?B?b0F5QkZGa1dWNmE5dHJ1bXhEd0lvaWg5QWt0anV5ckE3SnFNcmlmMytNTjJj?=
 =?utf-8?B?blVlNVNIUXR2bXBNMklhTC9uUHViN2lvVStuN3g1SXlGamlZVzBqZk0yUXVF?=
 =?utf-8?B?czNxeHd3TGVRd0twekV6OWNNY3ovSVM4R3VDZ3RZY0hQamNib0VYT1I5N0ox?=
 =?utf-8?B?UG5nVGp3L3pYVVFZTnFIMDlUWWtpNzR1K0RIV2VRMUorVkl0QXMydTJLMmk5?=
 =?utf-8?B?QlliZGNjVGtPK0E4d0taRXUzL2hjUTJQTmFEaVNpck1LNGNGMWZqMG5BZWVn?=
 =?utf-8?B?YTZHRWtWajVVcnFlNnVpb2ZhZjBSWHdoWUQvdjVxMkt5RkNQY3NYUUJUNXBX?=
 =?utf-8?B?Ujc5UlRzckxhT0ZYd1FlSm1KM3YwbitGZVBVOVVvUytSOHE0WjNsYkdrQmZt?=
 =?utf-8?B?TWJVUUpIdDk5RGRTVjdRdXVKeTUxVjFXdUIvZFBFQ3RRQW16UDBUdnQvaEVB?=
 =?utf-8?B?bG80WGlrOXgrM2U3WXB4OU9WK0U2SkdPZmhJWTdGb1EyOGJUcWVwZzZWVERu?=
 =?utf-8?B?WU9PMCtWTE1DaVMrRk1FaXNseDRLbjBoN2pYZWc2OFlQTDNWUUI0MzM0U1lm?=
 =?utf-8?B?V2hpemwwL2NnSGZKckZYUUhsczZrNitrdFdqcURtS3oxMVhiTTNtSm11ZXNi?=
 =?utf-8?B?WjUyRHNKVTh5QTNENjRobjlreG83Z1ZMdWNRU011ZzJwM2ZvZ2NJbUNLQ1gx?=
 =?utf-8?B?dWZNRWd5ZDhnVWZWZFAyb2NNdmZmRUJBTFUycmsvQTA4em9adFhUTHl1dnNu?=
 =?utf-8?B?M2NDL2FOaVBDNU1YaFJzNWM1VUdtNmZxNGNHUUJHdmdtOTB2NmFTbGJDSmdB?=
 =?utf-8?B?UXlVQmdQT1YyNlJMMHo5V1RqbUlwTnMzaUdjRUJuTmRMbFhmZTRSeXRZb3hV?=
 =?utf-8?B?WHl3RnU1YVhVSndwVUhHekNudVV6NWhHbXNZU2xFMnpXTGhIcklHQy9GSGRj?=
 =?utf-8?B?RTdaOEZzUUoxNUVQdm85MnJSSy92OVRkRUYzWS9rNXkwVTljY2lqTlJKSXI2?=
 =?utf-8?B?cmsrLzc0S2I4TWlwZ3E5YjFrSWhQbCtnUS8vdm1vSm96MlJDcjlvdmRKN0Q1?=
 =?utf-8?B?ZFAwR005aUZ1S01kZXNwVW5hWVE0RVc1TTBsbDVoK0pnVFpJTEJsTnQ1QlhS?=
 =?utf-8?B?eC9vMTNIYkp3VDlzSGhOaTR5dVpOOG1raVROS21YdkliWjJJdXlMRFVTOFNy?=
 =?utf-8?B?RWZoU3lQVXpHaGpoeU9EN2tIamFLdW9nbnVpT1NoMmYzcWZiVVlqd0UreFNL?=
 =?utf-8?B?dXVQdjJWUThKQytvVC84U2JjTnFwU2xtNVg4V1dIZmh5cTR2TkdqWWFqM3F2?=
 =?utf-8?B?L09TejRpTForeFdPdldicHcyWlJWVmFBZmtnd0xaSjR6M2ZpTm5JMVFISDBn?=
 =?utf-8?B?c2RZTFhtb3ZnTTQ3TVNjTTF0cktUemNWRHZXbm1RYlZ3SGFFYlhLa2p5NXJY?=
 =?utf-8?B?eUpHd1ZadzFoMnVMUjBTT2pHZlhKY3YwRWZ1eWhGWjMzelhBWWVoZjVqV3M0?=
 =?utf-8?B?djhHdjFNZTN3SnFpcnFwSmNwMGI2YkVVclIvUXhvZS9mcG9HWU9tSnBqNnFR?=
 =?utf-8?B?eVNHNHFkQ1E3dnFiaDZLN3FtRDJvUzRIcXdjLzdDL3pTNW1PL2EwR2FJSGE2?=
 =?utf-8?B?S080YlIyOUtJZ2wrWVFDYUtIMXRQM3hBY2NhMktHZVZlUUJwTisyU0xlUFJU?=
 =?utf-8?B?WE1BcWNZTmx6bE03eUZWOHQzM3Q1d3BqTEd2Y1lSUE9VdmdXZDF6UTdYdURa?=
 =?utf-8?B?WlRySXNBWVZrRUpES3JtQXdWajNLcC93ZFZyTkNud1dsaDVsMFg4UUFQS0x2?=
 =?utf-8?B?UmEvbXgrcTdjOW1vMldEUzJSQ2VNOHBYaEhCc090b0JSUXJib2FEMWp6WmE0?=
 =?utf-8?B?Z3JvdE1VaDBTMHgvQ29LaVl3N3lCWndySUVLMnFuZG5nS2R0YmNibzNiREds?=
 =?utf-8?B?eEFZS2RtRjJKSFVndkkvKzB5cUtaTnVrSndNaEo5NGdzS3RkYTQ5QnAvSUVF?=
 =?utf-8?B?dkJUKzhUaVBaNGVSMXJES2ZwWGI5M3owYTVVTnhadmdSczVzQkpQc2RSaWk4?=
 =?utf-8?B?UWwvYnZuaUZ1eHdBL01kUS9XWHU2Uy82Ym1MSEwwbW1vbEtBblFFeUdnUkFQ?=
 =?utf-8?B?eDQ2Z29ta3RaTkQxUjRWZ1R5NnFiR1FGY3NYNGhrQ0YwdC9YS1RQK011Q3dl?=
 =?utf-8?B?ZFFxOGM0L2VZMldMZm1OYWdUMVh1ZTJqTUluTHp2bHdFU3FCbmx4anVUVm9J?=
 =?utf-8?B?YVBveFlaTlFteDl4bytnMkFGMzN2WS9JVnJCbHNpcXQxZXNydUNLWDJmVmd6?=
 =?utf-8?Q?KEM1lTqLPWFLqL3c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae30c542-e816-4576-b675-08de4fdba52d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 00:03:12.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB9Jqcl+SKYgRovETEzDlKNA9fZN0lNA/P9qpsHXwLf/bpYntBdOfF5G2ZNpw18q/d3TV6nABKzgrIAevciNVmraHAuD9Cy6PBoVVOEPY4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6183
X-OriginatorOrg: intel.com



On 1/9/26 3:51 PM, Shuah wrote:
> 
> Applied to linux-kselftest next branch for Linux 6.20-rc1

Thank you very much Shuah.

Reinette


