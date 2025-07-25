Return-Path: <linux-kselftest+bounces-37997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBBB12228
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234FE587CB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB82EF2B0;
	Fri, 25 Jul 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSo02WMK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19C2EBBB8;
	Fri, 25 Jul 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461558; cv=fail; b=ioDY8Hpdgr4X6YFmoYtRS0NzYIylCKOvwg0Fo0RuXooyFpYsviEWQo6iA/QdzsN7yJ/F4bWc+tcMfrkFrnvWDGGbrVQvWdmvpj8E9K/j3jrVfNso1JY9eNwG6j1+NfMFiPhNJT8ncw2AVvFK8jQhUrEAPpKrZ3ri8y9QPLVHHfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461558; c=relaxed/simple;
	bh=Hcs6QauDf++OAvcXmxwQqHlm7knRS5myTvwiKtcqg7M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jpX40Q60jIS+Jz4tMDMtl97jt8M692NUvZr8AeJePkqh1m01Gfx2K5pf51doQf+9GBR03dyijWET4w4rwPV2ZdZkv+sVjgOf5bjQMi5aMwXY1O4g7jkqU83aEPt/Uy65Wn2bZUGEFTDKqOt7rJKiPngzZj2F3xX9A9N/25feEzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSo02WMK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753461557; x=1784997557;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Hcs6QauDf++OAvcXmxwQqHlm7knRS5myTvwiKtcqg7M=;
  b=eSo02WMKR/DJUtXuAM501MOhBb42RSPtnLI/Znw6axf6NnmtgT01bTd2
   AdmnfolvtBTVbCCDEmVlTsSA4yqRHfrhqnC30UqY/RFuUk5aMUwhtBrLh
   Q7V6PNtd4NfT+VZNrdrtsBdg81z6Shhd0TNRbkFMrAWjxg4uSWq5BjoK9
   eCxM2fRPCqEdATZ7uqB1qckTzlXE38sXvj9imRwAZ1hcI/lElzXi0uSdR
   aZSltYtqeBJHIcTLGel+w4M5FQUoC63wx+6MafJ9MtEdijgQXGqcQ+EgV
   RhYST/cVacwfoaXAE4fky0IFXQAN7MXirpziQV2ljGqxpkeGWCMa2BgHq
   A==;
X-CSE-ConnectionGUID: CiuzO0d0TrC/68z0fchgOQ==
X-CSE-MsgGUID: uUku4irsT4Wnw3iNR8hwLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="43414773"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="43414773"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 09:39:15 -0700
X-CSE-ConnectionGUID: Ld9Pdb00QM+xtYbcwAKfQA==
X-CSE-MsgGUID: qurzh0WNSU2/ALA537rnFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="198183865"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 09:39:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 09:39:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 09:39:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 09:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxYGByK6y+97rDPCoePve1+QBbNiwdgLiFxQNSsDm+aXWkNKVKMBU8qcm7o58AX8axsZ1yIyI2iHkfu+nQ2SR/TLoyE7YqU5t9nmiZTFRjC2+H9+w2b1FqFCvwnjNUSiQ+oiIpj4iQ36YsAY6jhy50DPg9tYdGnoB7ukFC3Scu7KsPl4jwK8H0b7+F7qEtkzWi9cOxa66KpO7IYZ2VAs7SPJDi8XKvmjdojy1HPcHEqmB+poEdTo8MVILD5T2YuO1QaRtint+QUU7tMLtA7N7htbsaFNOyk7ypYtxb2qs58Y4apYioM9NfPh8F2QraLheTPIdvPj+qqwfxiH9Iq7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SCVd1RNfhXhguJZAPica0TaPyYkcLjvDtIbWC9ZOwE=;
 b=W1chEtJDQ5Lj34S9c/MitFv1IOenGZAzpxOvf8aMCwLhJLeGs5NtbRanoEoaPJZQDRFHvlx2lf9xwaIpV53pvse9a2GYYJq1l4iPxiED+4qQUqnf/nFe5x37ruZqQzdXWV13VDBYsWYgtMjQWyTRdUMut1ykwMlzo6iNjkDodVcUr2rBLOKSxpzCOiSC1l00F9Rgc3o2vF6Lvm4BS9NHrPbtgY+FFLccVQFPnvHeaQizHr7PLNZgbRDCSlLEclHdgNmpnTTPfRjdM1YL9Q8suJZNkK96dSjeAQTWTIXsaijCsJqQEZRbuCeYAZ2F4XH+qELusBVunPrAc9R/erIU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 16:38:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 16:38:30 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 09:38:28 -0700
To: Jakub Kicinski <kuba@kernel.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
Message-ID: <6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250725080023.6425488c@kernel.org>
References: <20250725080023.6425488c@kernel.org>
Subject: Re: Crediting test authors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6758a43d-a354-4a1c-01bf-08ddcb99b02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzV1K2xGVEt4b2UrUkZyU2xCbFNUZU41b2FVUU9oR3ptandrL1J5c0pnd1Ey?=
 =?utf-8?B?VnRiUmRlOHRZdmVWZkVtbzE4T2QvNVBDUkxuSDE1Zzg1YWRNQk1WY1gvOEVj?=
 =?utf-8?B?UG02cUF1ekhvRlRwa3BUaFN3N3E5eDB1Nmg2bnhnWHUxenhnL3B0c2xqakUv?=
 =?utf-8?B?azl6N0k1aEtmUDJQTFVHOHZFb0wzUXJERXNzRmpHaVVPTmo2ZmdmNExacHVU?=
 =?utf-8?B?SUVvN0I2akFVZkgwcDdjVFJUd3R2cmcrYkFMVm01TFR0T0ZMWDhLTU92VFlj?=
 =?utf-8?B?cng5QXg5QnJ5TTVGTUhTZWFVdlRYblhDSnRPNnk1b01nUEZKY1pkZ1EzeWlo?=
 =?utf-8?B?S1dZZWx2QnRzUkZwU0F0UW1tMWM0M2x6WkdwVUtYeVozWk5LYjkvN3lLdGFH?=
 =?utf-8?B?OXMrdHV6cTR4RlZ3NjAzcTFibFo0M2V6eTVleXVIZjBJUkJGL0tCRmVGMEFj?=
 =?utf-8?B?eFVkRlh4b3NaUXZ2NlFxeU5FSnZaZldzZG5ZbGE0UGlZb0tGYzZLczgwbU9V?=
 =?utf-8?B?WTVpdFRMR0hmQkhXMXZBU040bGh4N09oTmVzUXdHcFI4Rm1aSjZBbGttdVkv?=
 =?utf-8?B?b1FwN0VWSEpvR2thRENucWliZDBERDhiZWdxWXg1SCtYZWgzRjY0ZGNhQm9l?=
 =?utf-8?B?SXY0WkdtcnJyUHRzMGJjbU9GdG9lV3hHUHNFNytZa3VmeUFLempVN3hvQjBI?=
 =?utf-8?B?QnRDcVMwdkRSbHBhaENQOU5kbk9heEpkUjE5MkYxSjFScldFdFFmWTlYNDl5?=
 =?utf-8?B?TzFLcDRLSnZtcHBpZUFqRmhmK0lsdDFCbXNnZFMxQ3NzK0JscFJkY1h6bTJx?=
 =?utf-8?B?R3ZxU1ozZnJBV0lpOHNXY0tvdzhISmlKWkhZb2dCbngrSVIwR1FzZGNGVWJu?=
 =?utf-8?B?RXdEZG1GSmhTb2F5WHlLWFhPalpoYUJrTG5OdjAwY1o3N1VRUFVtV3U2cW9i?=
 =?utf-8?B?T3BhTGVxSmZGa3BJMktqUXpPdkpCRE9iazZ3TCs4ellyWSsvcjc5ZjhLUGpv?=
 =?utf-8?B?eXdkWEg5Nmt3TVB2aXZBUEd1ZjJKNUxFa043a1JPeHQvNlRNSGdSZmlWZFRC?=
 =?utf-8?B?T1lZcHQ5anR4bDlTdW9UYW1WQnhoa2JxeGwrRHRiWlpCMzRTd0JhcGJEM3BX?=
 =?utf-8?B?b2I3bkhzVlRTQTV1WTlwU1BqR2lOeURqTUV5OGR4T28zbFNRV1VMQXhlT2d3?=
 =?utf-8?B?QmpzVndXRnBkM2V1Z1ZveHRKODcxZ1F5Z1BWTEVVY1gyMlR3OU05ZHovZ2tN?=
 =?utf-8?B?MUM0cURadlpjYkNZSGF0cG9LWHlhemJDMmZlY2g2MDcwR1I5Ylp6Skk4aFh5?=
 =?utf-8?B?UnREc2N3QmN3N1BpZ3EydTBDYXFma1BSSG9BemVkNkQxRW1UYTJ4TXV5a29l?=
 =?utf-8?B?bThLMW40QnlRRWM0bWNtK0NyUHIyQ2hweVBSQ25UYU41UUxWa2t3YlRsemJL?=
 =?utf-8?B?RmRSUWdIM2FSd1lHWko1WUx3d1YrKzZCVHYyaWNTelhydElhWXhVaHR0c2c2?=
 =?utf-8?B?UkVod1ltcStWaVhmTGJQbFFCN2cwRlJ2cWdoUzFzMHh0RGJsVEMrYnlWQU1N?=
 =?utf-8?B?N2FUdm43N2hWMlBiUVMwdUhodmh3eHlXR2lHankycDBCUHlBMnZPZ3dkZEVI?=
 =?utf-8?B?MkFiNU5WYXZaTDBDNXZZUUF6RGprTU85R3VuWnMxdHQwaW9lSHMycFdUY09D?=
 =?utf-8?B?RFhoVFREdnhkYXo1eDFRbnFQYlBZczBvT0wxbTl3V1YyTnM1dUw1VXNROUF0?=
 =?utf-8?B?SmhUUEFUcm1oWkVacjh2S2ZxYklZT2NTWWpFM0FCOSs2N016em9ubDlPQTcv?=
 =?utf-8?B?QzQ2VkpuS2lkZk9nQ2M2N2d4ekQ5UWtETmIzejZvckFlWk90Sy9xRDJlVzFR?=
 =?utf-8?B?Z09ib0ozano0R0pPend4RDdjSGwvaEpaUTA3dGN2b1hXRVdtMjdXMWJDV1BQ?=
 =?utf-8?Q?NrGEmC9XtTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZaK0Irb2dtSEhFN2FXYU1NcGd6RDQ2dzFmR2VvMW1GRElNTWdLMDBFalFC?=
 =?utf-8?B?c2labXNkNjBSUWdFYnVRWXB6YnQ3akpYbDZkK3M4WDJhM3ExUXhCMGZaRWls?=
 =?utf-8?B?SUEzdGV2THJoR3FzajVBbU1IdzUrUEFrN3JQMTNIcVR2OWZ3N2ljUzNGSmx3?=
 =?utf-8?B?VjdtMU9WMytBb3MzblNvdm5KdmoreE5OOHNyWHRiQnptcjV3bjhYNXIrMU9F?=
 =?utf-8?B?ZDRNZVN1bE5pM0UwM3podVBTVDlRQ04yUmVxVmJUNG4xSUpmc0ZrNkxEMmxG?=
 =?utf-8?B?R0pQcGMzZ0lycEFoaWtDM2dSZTRwQmVMRWsrdVJwWXFIQVduQy9CMDZYY3li?=
 =?utf-8?B?TkJITjFTcktSQ0hXWC9JcjJjcUcyVVV6Z3FXZnErVlhjRmNoQzN1eThKWEV6?=
 =?utf-8?B?cmw3dmIvQkY1RVphenduekQvRXpSbkxJTnlPS2JOOVNjM2NGV0dpdHVCSzlh?=
 =?utf-8?B?T21TbWRCa0FDVjd5VEwwbFgyeTRPdkJOYTlCZVk0NjMrNlEyM1ZtWTVDVVlP?=
 =?utf-8?B?WnlMVk1WbFJpeVAzZnVWQVBDdVArR2pFSU9YdXNvWHkwMFJFZVhKYzJkTmFU?=
 =?utf-8?B?U0NocWFVZzV6QVRzb2dkRTROVFJUZ0NVU0tJTVZDeEJVSXdOVTJrVmJJWG9K?=
 =?utf-8?B?Sk5lcEZjWUFoYlc3ZFpDNDRZL1dHbDJ4OHNMWVoveC9TSW5STGxqNnhQSlJW?=
 =?utf-8?B?U2V5RjY3ZFR1UXZDUTdqMEExSGtOQWFXMURpMmJvUVoxQkV6cjM2RTA1YTlK?=
 =?utf-8?B?TUp2Ylg5ek55emVOMzlZMms5ZGtla29qc1FHQ0tMOFJXdStwTTB5ck9wYnFU?=
 =?utf-8?B?N2dEUCsweVYvK0lYZWdEQ0JwZnhXdWhPZ01IWDRwU3VHeW9QK3lBZk1DaW5S?=
 =?utf-8?B?TmFNK0Z4Z3oyUEQwM2J1cU1iTUw1UmZlN2lzUWFQV2E3OGRIcGI5OUpSaHJR?=
 =?utf-8?B?Ym1qc1NDalZaVUFnN0VncG40SEticmszVUsrSXR4dFpUNlhsQ3ZObTlaYkdt?=
 =?utf-8?B?bWJZekF2SHQ1eXl2TkVKWTlpbllIWEdBQ0g4L3c3d0V2Sy9TU0o1cEQ2b2Rq?=
 =?utf-8?B?Q2oxYlhFdVJ4OGI5MGpwZWp5anQ5aHQrUjMrK3lQWVNab0RJanluWkpDMGVr?=
 =?utf-8?B?dWh6Tk83aEdtclJJZEcrNVU2MG9rSmpobVg3NmxMNHREdU8wN2xJMFlzdHhR?=
 =?utf-8?B?L3hCa3lvdUJGK0cvL0JvU2d4UlFWUC82ZEVUdGg1NW1KYXEvN1NzMEluWCth?=
 =?utf-8?B?eGtGY0dmbkpiOVRHZXZqWktqd05SVThVM0wwRkQ5WnJTdlIwOE1Ba2w5K0VK?=
 =?utf-8?B?NmsrYVZNL0lneXBMTW9VaFN2UE80cUF2VVhzRHVIaE5TWU1RcTI5NWw1OHlS?=
 =?utf-8?B?SmhuVkl5RGJpQ1NZV1dyWVFXcGV0SnRLMnRva1RNVUI4OUtlRVlWSmpBRWNR?=
 =?utf-8?B?SFl5VEhPOEZ1UTgya1M0R3lPbzgrdXVWbyt1UTRUaWwrMzllMXcvZmM5ZUt6?=
 =?utf-8?B?bUZQUmFQcjM2S25DRWNhY0lvVFpzcksxYk9PY3l0Z1dJMGNPdGpLRWFaQzR4?=
 =?utf-8?B?d3h0OTVWWVVKTmZsYXRpSGJZRjVWeVRaNTcvRnNNM2UwOHlpTHlOWkZBaWpi?=
 =?utf-8?B?anhLc3BxYjV4NEhDWHd4cFh2ZkpicCtJTHA3SXFyc1RpM05yVHRkMEw2WUwy?=
 =?utf-8?B?NnlvQzZ0MjdqcUswS00yRkFRVjVsTzVUK3U0cllVRXVrdk5makVPTjNBelFE?=
 =?utf-8?B?NHlaekJNR0RHdkNGNVVBWVBJSFNpMXVYeWhOMVZ1TE9rZEdsSGxwNXVDOFJT?=
 =?utf-8?B?MkJ3T0dtZDgwaEs2a2VGMjJtTmFaeFJLWXhoUzRUY1lkem0yeHg5cStYM3dK?=
 =?utf-8?B?Mm5pa2EvNTVheXJ2VzZ0S0pWYmc5T3NuTXVxKzZXYjNYOGdFYjI0NkhrMDF6?=
 =?utf-8?B?dnEvMVVZcG5HalJ1dXlLUldDZ1E3ekt2SlluSVFvWFBZa05SekF0ZVc0Mmlr?=
 =?utf-8?B?c3FCc0pQUUtUWnBDM2cwZEVIdklXaEQzdXpZSlNoK01wdmNqR1VWRURJZWZU?=
 =?utf-8?B?YjBVbG9XR09uUzRuU2Y3YTdDVzB5UnVYSzR2ZzRQenZzaFpndUxlUDJIb1VY?=
 =?utf-8?B?aEgwNW9na2VETW10ZHFvR1VaSUI2WEdEdmdTMndHK3FVMi9JOVpiUjJFbHgz?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6758a43d-a354-4a1c-01bf-08ddcb99b02b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:38:30.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyUDrXW/mp1OVErvsuB6oRYh3q1O1CITBwYSQtP4Io4cdnUYOMrfk+K71HHwgw7VzT9IDbS+zjzoAFuWwHRybxW9mlT3UVIwGwJaYQN95TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
> Hi!
> 
> Does anyone have ideas about crediting test authors or tests for bugs
> discovered?  We increasingly see situations where someone adds a test
> then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.
> 
> Using reported-by doesn't feel right. But credit should go to the
> person who wrote the test. Is anyone else having this dilemma?

Is that not a "credit in the changelog" situation?

"Big thanks to DeveloperX for their recent TestY added with CommitZ for
 catching this case."

Reported-by: Some CI Bot

