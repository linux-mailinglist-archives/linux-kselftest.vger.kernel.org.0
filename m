Return-Path: <linux-kselftest+bounces-38851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C00B24AA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE3E3B27FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9B2EA470;
	Wed, 13 Aug 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFEZ4+39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814E2E7F39;
	Wed, 13 Aug 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092087; cv=fail; b=PkKzNus0GJL/6e3+eghT1dcpEyQSLL9lR+IVb6mWMIlU+qDFm3vwxbbROIFuCdeeK0/ElBrIl3GwR7KhVGVs/pJQPCBZnM6sTP43t/9cDheuRG1fQmqeCi2WCg3C/kGNVL2OK90SfysOqnYuq6YYNshRUdtZnSldOt/I/Cu2GYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092087; c=relaxed/simple;
	bh=kOplSnkVtO0f6Yj1oXUHDvjK5in41J5xjVXyU9vEeng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGyX+MT6rFaOV2PSUzTr6sMzHUYq8TmsLvHNi7cFoAgdhgQp9HzsN3Fqq+pCMvO0oJkEZzFxfsYCtMa7D4KbSbaDsdUlDlCmcwb5ujDvg83/r2q+yZ1dr4lhJdMEv2+zOhRbh6TF6omCBoEjIx/aQ5KV7F8kk7Q3+1ZPRVIZkbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFEZ4+39; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755092086; x=1786628086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kOplSnkVtO0f6Yj1oXUHDvjK5in41J5xjVXyU9vEeng=;
  b=PFEZ4+39IvdLpUJ+gD1UGOE4Zg7I1WeFDs7Ykkel75WYFiEHG4fOtARZ
   PZ29U77kt1G/3w4evsgxyef1cwYUnBn7wohj63Yq3tjTS3u2O3U/RAcA3
   r3aabcj97SPUzSSn1RMAOSOgMOqi2wUa1wxGpz3BOZbRPzgf7YGw0+mOO
   c7zsGUzNCcPAe+zr2mDRxMqw4uhBiG0QcmDEj7SKCzD7nkgQWmpWUYfAM
   NNn2eMAcgDLW1GspBgvmaFiuxC6D71p3a89/OunZQtAC6LSoid3vlsrTH
   wrkngQX106hnG0JHohNXX3+KC6FS67tl8oT8HRaXHtYKuc5s3Nr1uI14w
   g==;
X-CSE-ConnectionGUID: P9myLBnmQV2wzUTyWbydzQ==
X-CSE-MsgGUID: +gzOaDSaRLm2zr0AlaubKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74833721"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74833721"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:34:45 -0700
X-CSE-ConnectionGUID: XrVvZ1pQTriBh6n21Pcxbg==
X-CSE-MsgGUID: ayS5RnOLSQm2dQl6O8legw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165966765"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:34:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 06:34:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 06:34:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 06:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsSHZ6LalfpWZh6Cjvl7Qjk+xmQL4exQnR1q3OVBf9tZ2k2TJS8jJQTiegZWEszM70x+04HwEYVWPYeamUMkQZIoRq07m5V0p8zu52lFHiINjf2qrLiWe71EUJtUXhuztSJuxc8kP6F5YZXlQbz6skOQbEXYLR7IfquffSYOxsiFIcC++/fhNjse0ITP5mecTgJqPfSUaG3lG68XOKQCVgjuxBI6NRJ1VwW8EPgHUJEVHYRphwGPy7t+4s9+Etvonam3IK1fDanBVXDTUNBUmsq6XXdLuLeSBiizD7JPG37ypeMvvMr+uiBUGWGAAiWiLA+D/pcliUgvrr3qw9qrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b9gaA9bO9pumtq3ZL6XDWMvR1tX0SnfHwKIRdbc9Q0=;
 b=Qo0jnVCdCQUtBksnbEKKpwLfFspdvTypmji1yOyPEIYh+vIX0Nx2cS7c1dOgT59bH+6rKObfd69Zu1FAeE47WCxSNp5oyy2CFwS3KvkhgWOPTM4Ue4uXLQH7pmkhhjFNylm9/sIBrZA/xbAG7wS21iJhJ4CObk8ZdnhhAsieisuMGXdH2s3gfL2786FBBvurKeKT8Jz60arR74mOr47lhUwdsbmqVpjnfZ6QwiCQEUX2Sj8iRVFVToJpwWC3jztWfZ/0/zwoFz6BfnE6u1lk+g27t76EzGze1SzcfQ8JUdyx345Olpbi+wMtCJ8BqolYN6XN2jP0WCIrSVVyE/xl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 13:34:30 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 13:34:30 +0000
Message-ID: <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com>
Date: Wed, 13 Aug 2025 21:34:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/30] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-8-sagis@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250807201628.1185915-8-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f63049-b735-4a71-d87e-08ddda6e21a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU5rSEJqTnNjalphZWV6eERnNTgycS9LdkxaVHNYZ2ZtSWI5eitNVDNHRHFI?=
 =?utf-8?B?K093U0JoNmR6RVA5bC9tT0xQdnh3TnU5WldzWDVtaUNxa1F0d1lVUFhYOVNI?=
 =?utf-8?B?VEpPV2Z0QmlrYjAwK0h6TTliUkMvL1FmME1EMWRpK0ZFSSszQld6SE9Uemow?=
 =?utf-8?B?bHdweVhuaVFXeCtlTjcrR3lKakIxdlpuMUt1cWNJWnNQOTJiQU1Qb3FsaVRZ?=
 =?utf-8?B?Wk4rWkp4VTRHN2pUNkR1bHpNK2s0SUtQUUNLaWxFTFpxYWpGaGg5NE5DVHh2?=
 =?utf-8?B?N2lKZ1E5ckN6dmovZmpzZTNBcEVQdFZIQnpZY1Jjd0xGNUl2TGNxQ2d0TnZl?=
 =?utf-8?B?Y29ubHYrc3YwRnhPTm1PTWFNR2hIMmVJK1V5allZWmY2eHVqQ0I4UVRRUlhz?=
 =?utf-8?B?RVV2bjE4eGMwNjFNNmx5TGRJTStwSENzL2JITlNsaVBHU2d1TEpRZTQ4UGhj?=
 =?utf-8?B?TlNCNHgwc2ZqN1lHR1Nmc2lHM21ueG14RmlhTkRRekpoUStkV3p2S2pPeXRo?=
 =?utf-8?B?U052blM4V1o5UXFRMmxDMWExYUprV2l3eENVMFFMZFFXVGFueEFEUExWTExz?=
 =?utf-8?B?ZGNESnYwY3ZNMnh3bDRNd2k1MkpyY1htRlJZWTB3NGo5ODdsVFNTSzROdWJI?=
 =?utf-8?B?UDlDcjVmUmtGZXB6VkpkNXM4S2NtVThWUnQ1V3pRdnVWM1VWTnBhdWV1RG5K?=
 =?utf-8?B?TlpqVklpSlhVdmVWbHQwdUR2K05wdzVwOE1vYmwraUVpTllyaDJxNGVLNklL?=
 =?utf-8?B?eVB2RCtKbEhUdGVmZFVobDNheWIvb2tpUm5IOGNtWnF1RFBxV3RuczZqQmh3?=
 =?utf-8?B?NWhnd3ByQnAwQXh6K1Vla1dFTWt4Y1BURVhzZWdOM3dxc2xKVnFNVDNPeUs4?=
 =?utf-8?B?UTBMeUVsa2RhQ3pORnFtc3p1b2dMOHRyNkg3bHJjOGpoZytKSEMwaHFlYzVU?=
 =?utf-8?B?Q0YyVXl3SWtFeDVmSTUvMHJFYnRJSnlTNmgySzFWcVZSMUJxREFpMUVud1lX?=
 =?utf-8?B?L0tVaTJFa1JJcU80MTZxdFFMMEExdXk0QzRVU1pxV3B3aTZDOVQ4akFqOTI4?=
 =?utf-8?B?MWZHamVveENtR0xRaU54bkc4SVhDcXZ1SFU5aFdzNmxXWUhnTUZlZ3IrV21J?=
 =?utf-8?B?N0l6b1U0dFdtNUFZVklheGljWjNWeHpnczdpTkU2aUJHYkpGQzFmQzlzalJz?=
 =?utf-8?B?NEo5OU40ZDJmbHlldldPQjdURG85MWNiQnVIeFVMOWZxa2hpcXRJbXZkMEN3?=
 =?utf-8?B?akpVU3RXR0UrWjY3cmthQXdNTktHdjBET2dOT2pYa0RVK0xPd29kSmFCSk1L?=
 =?utf-8?B?NWpqQkNCZ3B5UERMTW5JQXpqTmZubzQ1N3Fqak5MRUh2aTBKbytFcFBSciti?=
 =?utf-8?B?NUc5Z3RNaDZFK3JGbWV3bTNib2g2a3U2MXY0OXJqdm56ajBSTlhuU1RwNGt5?=
 =?utf-8?B?UUovb1B0b3hBQUpHY09GTElDM2QwUmpCd0tYRFhVUmh4T1pwV0Z3aXZpOVQ5?=
 =?utf-8?B?ai94SFcvNm5WSDFOLzVsUFUrVnVuaFBXeGZsdFE1TGUydnJNSkhTNjNUS3dw?=
 =?utf-8?B?UTYzR3RQV2RkMmtPYjRlcVgwUmk1U05pQVJETXlmTWlSRGpPZVUwQ1JPRUJ1?=
 =?utf-8?B?aG03ZS9NT241TmpEQU1qdjJtK3E5MHBkWXRqVElVQjkzRnlsS3E3K0FNOWlk?=
 =?utf-8?B?UVRldWhQVUE5dUxoNXFLSmhOdWRyVkJIUERDeE8zejY0ckJjdUQyelcrYnNR?=
 =?utf-8?B?ZU1nYmQzdzRFSlJZQXdZVEhZL0NWdEt3OFhCZnNrdVhEeUhQMHNCVjZrM01K?=
 =?utf-8?B?MEJZK05qRWVESFdyNE11cDdEdjhhRzBxRjBhTGcvTEFVUnBSa01ERDE5bksz?=
 =?utf-8?B?dHQ2YndFUVZLUVZ4MFdYR25PZ1AvaGxXY0I1NXNuQXhsNUxoRk4rMlFOWmpX?=
 =?utf-8?B?N0RJTUJWK1RwbWFZZEQ0cVA1WUlEWnR3TVJVQUhIc3hMK2RGUTdHSHZnVEQw?=
 =?utf-8?B?MDBLbHhBeURnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhzVjJlN1QzTExuLzRYYVpGenpoZGVJWVYvaUZkdmtiZ3BEcFVvejc0M1Mw?=
 =?utf-8?B?UVZwajF3R2xGdzNBTnJ0WmI1T2ZtU2FRQTdMUlNSeThvSFhSd1RCZU5JWjBX?=
 =?utf-8?B?MkJVNkNwQW50a21oRXJ0amVWeHBVbHc0QmtRdHVOam1MZWJSZDI0bE03Q1JZ?=
 =?utf-8?B?MDFUNmZtMExXQUFZbkdOYnZaU1FWRHNVaUMzRVlrdm4yU1lUeXFWZVhQVnZx?=
 =?utf-8?B?Wm8yN2xLdFpuZ2R4Znp2REZJRnBpaytWU0UyREg1NFFxTkg4Z2FIRTNlbFJv?=
 =?utf-8?B?MUVaeHhOVTA5WmJmYjkzeklPOGNzU1B0VWpmbWxXYnBlUjVMRVg0SzQwTlg5?=
 =?utf-8?B?LzM3c01vekN5WXRrRTdJZ3pLQjE3bjUybGF3VGRoTDBLbXpJQ0pzUXdzTjh1?=
 =?utf-8?B?UHpGMk1GWUN3eW9ZZU85Mi9iRVQxSmdqUVFxeklNUkxPakxtTVhqV3JIUkZD?=
 =?utf-8?B?TUUxSUZCZkVIQXEwZ2FsK1hRVXpJcTlwMllkZlJ1UUpwc1ZwREVQdlIrV1c3?=
 =?utf-8?B?OGp2VlRuNEZvSXVYUEQxL2RmSEk4TEE2Sm1DeDFtZDZ4YmZWeUxHNk5nVmRR?=
 =?utf-8?B?MUp1cXg1UUVlZjZqYXRXME1Vc05wTTNRN1liYWZCa3JCdFk2cHhnK2Evc280?=
 =?utf-8?B?cmNnUFRVcDBvcDRUZFN5a0JUU1hHeDQ5R0VOLzZuUi9rMSs1ZStpN1RVeTdk?=
 =?utf-8?B?TmFKWFpCV1RFeTZLbVI0Q2VTanJGRHQ4TWllNTUrTi9IaDRjSHpZaE5ydWZZ?=
 =?utf-8?B?VWNOSXhsbElrMm9GYlVTWC85VHViOFZheTZobEgrRE56SE05Z2VYWi9RRWJK?=
 =?utf-8?B?c2NQOVhHdmtMekdJSFJGUDl3VFE0WHRXVlU0NTFndGRnbS92OTJ5TVhtOHZy?=
 =?utf-8?B?VWpaQjFJS1Z1Q1lDdkRsWWg2YzYxTnJzUjJrazlBYmQrbmpCLzBJV2l5WGtK?=
 =?utf-8?B?QkdEWWZERVdZOFJjd0Fwdnp1alZnVDVTaGdQTnBCQmR4Y2RQajdXbVo5MGJS?=
 =?utf-8?B?VVFObmFNMWprNFV3Ym4zRXlha0ZkTE5JQXpyUUVmclZ0cU1jTGZ5a1BWeEh2?=
 =?utf-8?B?WW8vdXh1TnlnNWx4dmRTamU3b2ZFdDFNNGRoQTROTVRiNzdsRWRBRTU3NkVz?=
 =?utf-8?B?ai9ERjY2d0M0VXpRNTRTbmhWUDM3MjREUFk5WHh1NTlwRkpUbW0rbTBDTlZm?=
 =?utf-8?B?WlpXdi9MWlFJMzRRbFl2eTBmOWpwZnB0WFd4U3M5S0RqQTRUbmxtV00vaTdH?=
 =?utf-8?B?Uy9KdVFzRDhPT2VPbDNXeXZmaTU4NitJUmRDNjFCZ2trYTJDTStPNE1kM1lY?=
 =?utf-8?B?emo0VDhvMVJhVUFkZFpzMmNjZ0c0Vy91NDZsSWZUdUdFNlcvZ0dpQnhqV2Jo?=
 =?utf-8?B?cjVNeHR1RW9Rd2RDVTRsUVpRVE5oNlIyMjRRTDJvZ1VNYm13dDEvR0V6bStT?=
 =?utf-8?B?djFidWZEVnlWaXlZMGVzZi9ZKzNNb25oNlJHM29kLzFRVE5ZRm1RY2NQeUR4?=
 =?utf-8?B?UkRIcUFRVnhIVWJxbG1LeklvWGpISnBxYjJTRlBRaWt5b3YwMEVsVmVjWHdu?=
 =?utf-8?B?aUlZVk5Idm1wcThpcEszcUVyVDZhdXBHU1pRM1c4bzU0azRMdi9tcit6cUVr?=
 =?utf-8?B?VmdkMjd3OGZyeW9YQkZraFhGMzFnWUJ3YzFxQnVwZ0RLUzNDRUtoYkxqRy9u?=
 =?utf-8?B?WUNEZnZTTCtiQlhZUmM1NmJ2b3JVZVQrUEF5b0loZzNBWm1PNGFpZkZ0bHBz?=
 =?utf-8?B?NGFwSmJ3Qm4rb3dWeXREeGRqNG5rZisvS2JpWndYSU5LUTVNN0ZFZzd2V1dq?=
 =?utf-8?B?eS9HZlBEUGhIRnh4eG9SZ3JwaytKNFdwamJQSDNhdHdXUFNxQ3N6RzNjaXlr?=
 =?utf-8?B?VzVWdlpCU2g3YVh5aTcrc1RoeTduS0lhYkxoSXIxaWFsZEN0Wlh4TzBhNWlE?=
 =?utf-8?B?REQ3UUNkVkQ3MHJEZGRCS05DaHVyZTl5UVFJMTF4QTlLUk5Fc3d6dS8xVUwz?=
 =?utf-8?B?UVd5Ui96UXlXT1Y1WmRjb0tuZmlFbk5ESXFVdmY0Y2FCR1JQaXZOZHk2cGdI?=
 =?utf-8?B?Z0lZdzdld2pEVHROTGFzMUV6VExrWURmZTB1MlFzditvbGNkeHhjaUxxTDdm?=
 =?utf-8?B?b09HVW14M2k1ZWE2aTdFTEtqK2VaVWtQNE96Z0czT29tRlNsdmd5d1IySDFU?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f63049-b735-4a71-d87e-08ddda6e21a5
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:34:30.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVeVCQGXo4OolZx7xJ6u+klmlRN1mL44RFXG38Lw9mrpkY1qtiVK4f289KA1Xu1Y+HhmgTWt+T0A3as4LqXLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> This also exercises the KVM_TDX_CAPABILITIES ioctl.
> 
> Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 392d6272d17e..bb074af4a476 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -140,6 +140,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
>  	}
>  }
>  
> +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	/* TDX spec: any bits 0 in supported_attrs must be 0 in attributes */
> +	TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> +
> +	/* TDX spec: any bits 1 in attributes must be 1 in supported_attrs */
> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
> +
> +	free(tdx_cap);
> +}
> +
>  #define KVM_MAX_CPUID_ENTRIES 256
>  
>  #define CPUID_EXT_VMX			BIT(5)
> @@ -256,6 +271,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
>  	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>  	free(cpuid);
>  
> +	tdx_check_attributes(vm, attributes);
> +
>  	init_vm->attributes = attributes;
>  
>  	tdx_apply_cpuid_restrictions(&init_vm->cpuid);

Do we need to set the init_vm->xfam based on cpuid.0xd and validate it with tdx_cap->supported_xfam?


