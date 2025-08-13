Return-Path: <linux-kselftest+bounces-38901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1960B24F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4D0681A73
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98927F007;
	Wed, 13 Aug 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEcWzv2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5F25B312;
	Wed, 13 Aug 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101058; cv=fail; b=lQdzOBZBho9f/fdPXCl0c5ZxDtK6bGUc0yNdRaSOBbAfzPAWM7d6Idzrrp+qYVSpnYV+HolFc6sCO0GITZM3IIoSYDzVVdmBRzLT83RHj3PJXxDvv8s5fYVEFe9kOEvW2uds+bQVEVZlo1DoiBYUxgBG4DkrcfkHq2ryciKlBcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101058; c=relaxed/simple;
	bh=bFLWUzKfhpl2mH669UzXJwW41Oh0xQoTLuNfpWo15NA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVM7EsP6XCgP+hiN4YRoqIaYsD3I9UNDuYN4KHiTCRlGHJ+k+8gSCwGYFi/4DihoEYD2rnLeBhkyTUMpXLleLbi+y57StCoT7MJ9Q9AJkGGrkMNCY1oZX1EjJMi/23ZwcR4bapjd5/t4HcmSFiFI5LPTJ/QB4jAG5PtqiljyT5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEcWzv2B; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755101057; x=1786637057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bFLWUzKfhpl2mH669UzXJwW41Oh0xQoTLuNfpWo15NA=;
  b=QEcWzv2BJIMDdYfjKVRSwQkbOMW8zlzYWXHIchg1N9eoikW7op1EUwmP
   1occb3RvPUBOX7BO3xn7nn4UnU+A4aUY6PXaF230pDBgzTz9wOJytDwkZ
   C/SsuVorb1TZxuQwQSex6Dx+5SqHVIqv/Zd7GqAFpdkFk78/0XkypCWaO
   iCZ9rnaLD4jDeFCf3msAKrjr5QDa/7zPcEdR+UZKutgxVrHM5exrfBzby
   Z5Mg4O7Qmt2fpH21DvfIreNWG8gS0LpHSdqZlJ9+PnULuc4G1MN3SU+zh
   oaOk3kVmmA38XkLYDMuqRcITOvb0tl41VFvYqF5Mt6Sujn1ngYrclgqLz
   Q==;
X-CSE-ConnectionGUID: Bpur5c5MTKWTuNRJ9uejdA==
X-CSE-MsgGUID: 4BDHTrMzQVyzEFyE7e0ZiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68104458"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68104458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 09:04:15 -0700
X-CSE-ConnectionGUID: jcQoas4JS2y89PW5wlVU+w==
X-CSE-MsgGUID: qkGKWx9TTi2PQogbddRL8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="167306515"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 09:04:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 09:04:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 09:04:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 09:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey4O+OyYyl6pYbKDcgAFezGMShkh1CNVBV/hdKbB4h3MWMaSAMrlZGRbzb1nuc7ltwuza4BgixX1Xnbw2SygaZsTGvs/qb3yZcXobbEB5gqKfMnV82EmORQX0ZlVbIHMNH5Il04eFBclG9/1MvB7CUot/AeRiionwZUKff8LETCgezD9hT30h/tk0yeghN7P8dw0QalBnMo/Tk34WUZHbrXM4HRrYyYk85w0MnxJcLnMRos0uvswCbvHzJJWrqmL/qRZ3mrZtpEGSTVKpdwBWT4owVrr2m1TdxtpF5M1XUZmsZV0dt+dpN74tz+23B6HP+6oAe9xzyLHKDARi9OB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcw3fOp+BAUc1RmFBGsQjywUI3NAegnbqWeSfvHac80=;
 b=O2Pz4Ezo/tQRSSkI+8g7G9IqfPQH4H0FuOQSZHAjUGyYpv5Fe/+jJyYVYN9apaSr/287k3+IPTng6NiprgRufjed+5A58ZdjPkj/j18wkLujEi5gHO9o/5DIQfy2HjjUUp2e3DPzYClPEZ5w7CYLg8wteZs/uWUBMPPsXXlQzRFol2Iwvdj2KQ7d6UPF0unzInf56SDVAY6kupe98bfkqFhM2q6fqtbGARKWE+8xpo7JfzgSTRTOzpkTviF0OL2h03vWbZps/k1qCxxic23W2mXw/HndwtrqWnkG2IUBaFYbqFb7PcvRcbmYc2Lb3yRmdCkSYgE2ksQ18zVqfDTFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA1PR11MB7870.namprd11.prod.outlook.com
 (2603:10b6:208:3f8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 16:03:25 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 16:03:25 +0000
Date: Wed, 13 Aug 2025 11:05:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [PATCH v8 28/30] KVM: selftests: TDX: Add TDX UPM selftest
Message-ID: <689cb7b077704_20a6d929455@iweiny-mobl.notmuch>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-29-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807201628.1185915-29-sagis@google.com>
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA1PR11MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: ca781563-1e55-459a-0ff5-08ddda82ef3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/VzqTTslDs/D7HdUH/JDX1dVYT3fYcMbjhLo3GIlVurkXAmlBputtNj+O3L?=
 =?us-ascii?Q?plwIUGcrpB/q14PLtd1cfc8J2dT4ZABDjgzpnITdN6z1AVnD3YC8cK7/MhX8?=
 =?us-ascii?Q?xyvkmrNKuoBf1OII/S7kP8wVZ0O/oknUAils/Ii58VkIZ8sKQUk/NtPsi3Wn?=
 =?us-ascii?Q?UoeX9OZK+Bfz2ZuuhseSKity6x/xgI2NmrCv4E4rs6vf91fh6h/m89v2cDDl?=
 =?us-ascii?Q?8eimlQQFj8V4wrfwgp6Wdj7S1RBd7cWh66fIDGCE+28ETweZ+UDS5ta5Uc1D?=
 =?us-ascii?Q?ldbP6DU8A52Y3Zr7zdaTrL6narsxUphH9LF6isr0ShuYu/lM7QBU59juqAOE?=
 =?us-ascii?Q?uHFJkT6P/M5MYU+2PqqJBjHaBU+ZjaA/zeHs0aD/XMHJKx8Lpk4q6HXLQdsM?=
 =?us-ascii?Q?IwuHsZQ9hHRl5Orp2mWoHBCXOW2Qdo3+rCfE9RB18v4uWen0SH1D2iHCGJYJ?=
 =?us-ascii?Q?j2N5+e+/GrADzfKnaVi5FqJ2kRi7/lqcYEynWqksV8ZlnfdnEbxlmflOjyH4?=
 =?us-ascii?Q?/m5lF8lhuit4qBxjmWwQXKQnJX5zPRp4RFK2pi+UhaMtB7P3kV4lXmUrlSc2?=
 =?us-ascii?Q?m7YiDeLmHZJgN+6M5UitOTCShnuA1xYFIU67xZ6+YUb+ap7Ev+rwpJSLgzi7?=
 =?us-ascii?Q?5bMoaNjEKkZbsAn8VjtCV8UsrjcuFe76JsWxfAQhVZazX3PqqS0Z2An2Z4Qy?=
 =?us-ascii?Q?m2GuazZOky6JP76T0+D+wV5LLjCPHAargDLfu5TppX+pHf0P0mvG3/VVRsxD?=
 =?us-ascii?Q?1RDrhwmNsKhF+s8PKdGWaNawwnSWfRv79UJWqKHvtVgGDxDzJoT1tD5XEt4K?=
 =?us-ascii?Q?Ji+CcdxuN3OMZAJigV/dKFlBqaMMmffjG7fb9GNkjDWHE2KauXsNXqUIdwxk?=
 =?us-ascii?Q?w+2Yz2stZ7FBbmVQhV74cSmtY3ijfhjwSWOVTLFpj2Jwye8Ja2x57r2f+o7k?=
 =?us-ascii?Q?NZkelsryvK/eeDHDTp8SoKZoPaf7bxCF9kGCuStWhRP2IT9HC7PcXkAluMPK?=
 =?us-ascii?Q?IKNBPwQIYpaCMCPcrzUEM0R6NRR11jU41Wk6OhWE3SwEraWdXgPaaJbgWs82?=
 =?us-ascii?Q?8mhuIBKO6BsIibnUtVnRYYGVZXJqfVlWbs709hpSuNd5hUit+YyewaJkSYmv?=
 =?us-ascii?Q?lZV0OPoEI+eriZ50Jm/TOUjNJOWVo5c0A3zlV4Jcxf2A4vV0EY2oyAVhY04U?=
 =?us-ascii?Q?KrUZlijUSDss819q0QYHnNthqh+C0qAaKrFtxMQU4/bZEMqVEc9GwYjgUN64?=
 =?us-ascii?Q?AtJDMHGbW8obt2+21bh0m2HhqstiXvznr+S2lW1pwMd2ypHw5rWSyb0zeKEL?=
 =?us-ascii?Q?elEiGtWw4r4P6BOWbkU3a4Dot5NKVDqEQHOYcLfh09oHI+NZQ4e8AQ6W68bV?=
 =?us-ascii?Q?QNieVnmVhcO188CmqsZtCyZXSnvqQQrR0q8ou3dvJF4wk4E2Dfk0u0Pm8sWm?=
 =?us-ascii?Q?u8sSMGiRRRISg6sqS8SSNFIoi3x/rMsXgC9FYbilN58WW4Q/KdtxpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KfRmOYMg+K0Bn0Wf4NPJaGcex8u7Rj9X4MAS6hf57DrBTGYMWB/KZ+LqXqkC?=
 =?us-ascii?Q?Hv1FU7cgM9n320JYPD6T1J1B+fiTPLOaV9Fj6NfUXRdnaggF8gqitEo2vbbr?=
 =?us-ascii?Q?5avVAdsXQnlHoIsqENkuFemaxHd87j3tU3QNnnKLqLaVQ/mCf4VZI/KZ2wVU?=
 =?us-ascii?Q?c/GNyYG2gZQuHZXqdRaLOStSowSkhah/+y9X+mibjmMV77xtB4cmAVdm//Gi?=
 =?us-ascii?Q?DXseh57/ZEtPa+xgKfLqQEPhtVAR7Ae6sidFA013Jh1B2o4Hj13KH5FgejJS?=
 =?us-ascii?Q?BnsVkpCeCd0ECNAg1MSWWlecXqbBnXcRzqeHzq8whihNzGs0BxVC9ZUQMFTV?=
 =?us-ascii?Q?m8UFTf+lCzK33wvSd0RN+1IijJ0IhDd3CC44uSl3bdGNA4OoWTItMouCMNqq?=
 =?us-ascii?Q?V/G4PghgpuquB1O9ffxPLWnoZoDpyXOQ5SjggGM1zuE5yc+8jXddJM9x1CFM?=
 =?us-ascii?Q?zaGQ2E5II7Z05tY15Lct5F+4kHFzY2vcP47/MXRY040Ufg7oBarWrMKAyS1V?=
 =?us-ascii?Q?RRtjc1e6bXH+hZ71sdYC4Y7V9YgUKcUuVDapFBvD+D7m3IQ2bRgF+j6LuXwC?=
 =?us-ascii?Q?//sQz0dK1/QwfuT4WaoIQE9d2faOg/zdmUNc61i7AJyo4ng7FVNuu3TJpdd1?=
 =?us-ascii?Q?QvqqtPuGl3wPJZxeksonaX/W8STfPMocNGcelrbcrUVlT+mCxLMKxCUH7uxS?=
 =?us-ascii?Q?oqfzTjrW2iGUFDTpls1m+fCwDwBOnlVlF/a94Ry1DcJtW7kc5QgAcU6JL4Ng?=
 =?us-ascii?Q?DMSkDQt7Jj3VjaeVtKoZ38j3edIHCPEIn1Qe0kLEp65pZqyvYteFznl4KoLi?=
 =?us-ascii?Q?oyHnN5MOmma7hNlWmY3BVaeRnx/AFwTzFRCTQE96zkiFVCqTh7MnrqsvSGgV?=
 =?us-ascii?Q?M3z3YHVwNrmX8xzKh7At3NfyFexqnnYVD54BdtVK36JjpOy4rs/NUctL0hzE?=
 =?us-ascii?Q?1AbN0CWFW52VuMELslwOqMWnoZVEHkSh3F91Ji+V4Usom8AzXOLYEMFT1V7y?=
 =?us-ascii?Q?grPSHDU3lqYtVt2TEjXyPyOaRfoynVPAKymLPiSbmeYtmbi8I4vb1yahj/tW?=
 =?us-ascii?Q?3F8B/L90Xq4VrjHDirbHjy+In6hIZAyCi2g0eFlIyKvfDsGdm8fw0SR6eoV7?=
 =?us-ascii?Q?18bTJrUQY7ZjZq7y7PH3pnvXOjyakz4i48YHFR52APTNdcf0DjUGdFPrSxY/?=
 =?us-ascii?Q?nfe1/snioAhtUibIgGUxD8ui34sv3N59r+GAmQ9cztBfWvq+LiKQG8jS8u2c?=
 =?us-ascii?Q?5FlX6u2qt2DKRPdQ+LgOoMnXDRFR+iu89J9rPakmMyDRknxgV/uTfQQSpRbC?=
 =?us-ascii?Q?hZWS9JyOi8gyeVpVcm9JGjM6P4LjcpUuHRwqTWHiQnqTzWBI0wWZs5MOSdpI?=
 =?us-ascii?Q?z4Ym5Iqd7g+Nsjsg6EZjtnsEGB23PfM3idS9kXA/yygmuGKt7fmCpHEtuo4+?=
 =?us-ascii?Q?D6Xnsu++Pczh3s41A6bbJ9MAEeZgJ5/KxFtkcMIm8huNWMHKNvmtt70QXqWD?=
 =?us-ascii?Q?7I4/Xs9iYbgBwXs2788VUxCoy+bljHaBTYAIgYWqIxRDlfkwx71vbyOQwnNe?=
 =?us-ascii?Q?LP4kpIXYpC6vRWJ25WqYnjRRguSyO8euDTki3J7B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca781563-1e55-459a-0ff5-08ddda82ef3b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:03:25.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9xUDH1/zqj4xrSHdzkDpLR2vTsTOarSKcYZwweEVKA7ps1yZCYDdPiRwwXpZ2zvPfKV/Q3kUoGg7xXg2ds6/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>

NIT: UPM?

Also for consistency with the next patch:

	"KVM: selftests: TDX: Add TDX UPM selftests for explicit conversion"

> 
> This tests the use of guest memory with explicit TDG.VP.VMCALL<MapGPA>
> calls.
> 

[snip]

> +
> +/*
> + * 0x80000000 is arbitrarily selected. The selected address need not be the same
> + * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
> + * code or boot page.
> + */
> +#define TDX_UPM_TEST_AREA_GPA (0x80000000)
> +/* Test area GPA is arbitrarily selected */
> +#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
> +/* Select any bit that can be used as a flag */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
> +/*
> + * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
> + * guest, once as shared and once as private
> + */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED				\
> +	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
> +		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
> +
> +/* The test area is 2MB in size */
> +#define TDX_UPM_TEST_AREA_SIZE SZ_2M
> +/* 0th general area is 1MB in size */
> +#define TDX_UPM_GENERAL_AREA_0_SIZE SZ_1M
> +/* Focus area is 40KB in size */
> +#define TDX_UPM_FOCUS_AREA_SIZE (SZ_32K + SZ_8K)
> +/* 1st general area is the rest of the space in the test area */
> +#define TDX_UPM_GENERAL_AREA_1_SIZE				\
> +	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
> +		TDX_UPM_FOCUS_AREA_SIZE)
> +
> +/*
> + * The test memory area is set up as two general areas, sandwiching a focus
> + * area.  The general areas act as control areas. After they are filled, they
> + * are not expected to change throughout the tests. The focus area is memory
> + * permissions change from private to shared and vice-versa.
> + *
> + * The focus area is intentionally small, and sandwiched to test that when the
> + * focus area's permissions change, the other areas' permissions are not
> + * affected.
> + */
> +struct __packed tdx_upm_test_area {
> +	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
> +	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
> +	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
> +};

Is this really needed with the defines and helpers you have?

> +
> +static void fill_test_area(struct tdx_upm_test_area *test_area_base,
> +			   uint8_t pattern)
> +{
> +	memset(test_area_base, pattern, sizeof(*test_area_base));
> +}
> +
> +static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
> +			    uint8_t pattern)
> +{
> +	memset(test_area_base->focus_area, pattern,
> +	       sizeof(test_area_base->focus_area));
> +}
> +
> +static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)

memchr_inv()?

> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (base[i] != expected_pattern)
> +			return false;
> +	}
> +
> +	return true;
> +}

[snip]

> +
> +
> +#define TDX_UPM_TEST_ASSERT(x)				\
> +	do {						\
> +		if (!(x))				\
> +			tdx_test_fatal(__LINE__);	\

I think Sean mentioned he did not want to use the tdx_* error functions.
And why is a special assert needed for this test only?

> +	} while (0)
> +
> +/*
> + * Shared variables between guest and host
> + */
> +static struct tdx_upm_test_area *test_area_gpa_private;
> +static struct tdx_upm_test_area *test_area_gpa_shared;
> +
> +/*
> + * Test stages for syncing with host
> + */
> +enum {
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
> +	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
> +};

I don't follow what these are used for.  It seems like a synchronization
mechanism between the guest and host test code?  But I don't see any state
machine which is transitioning from 1 stage to the next.

Ah I think I see it now.  These are not the test stages.  Rather they are
the return values that the guess is sending to the host to signal
completion of each stage.

> +
> +#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
> +
> +/*
> + * Does vcpu_run, and also manages memory conversions if requested by the TD.

NIT: "vcpu_run; also manages memory conversions if requested by the TD."

> + */
> +void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
> +					    struct kvm_vcpu *vcpu)
> +{
> +	for (;;) {
> +		vcpu_run(vcpu);
> +		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
> +		    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
> +			uint64_t gpa = vcpu->run->hypercall.args[0];
> +
> +			handle_memory_conversion(vm, vcpu->id, gpa,
> +						 vcpu->run->hypercall.args[1] << 12,
> +						 vcpu->run->hypercall.args[2] &
> +						  KVM_MAP_GPA_RANGE_ENCRYPTED);
> +			vcpu->run->hypercall.ret = 0;
> +			continue;
> +		} else if (vcpu->run->exit_reason == KVM_EXIT_IO &&
> +			   vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
> +			uint64_t gpa = tdx_test_read_64bit(vcpu,
> +							   TDX_UPM_TEST_ACCEPT_PRINT_PORT);
> +
> +			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n",
> +			       gpa);
> +			continue;
> +		} else if (vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT) {
> +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",
> +				  vcpu->run->system_event.data[12],
> +				  vcpu->run->system_event.data[13]);
> +		}
> +		break;
> +	}
> +}
> +

[snip]

> +
> +static void verify_upm_test(void)
> +{
> +	struct tdx_upm_test_area *test_area_base_hva;
> +	vm_vaddr_t test_area_gva_private;
> +	uint64_t test_area_npages;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
> +
> +	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
> +
> +	/*
> +	 * Set up shared memory page for testing by first allocating as private
> +	 * and then mapping the same GPA again as shared. This way, the TD does
> +	 * not have to remap its page tables at runtime.
> +	 */
> +	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
> +	vm_userspace_mem_region_add(vm,
> +				    VM_MEM_SRC_ANONYMOUS, TDX_UPM_TEST_AREA_GPA,
> +				    3, test_area_npages, KVM_MEM_GUEST_MEMFD);
> +	vm->memslots[MEM_REGION_TEST_DATA] = 3;

I find it odd that one has to 'know' that slot 3 is the next one and that
it is just a magic number here based off of what td_initialize() did.

Sean already mentioned not defining MEM_REGION_TDX_BOOT_PARAMS.  Perhaps
this could be made more dynamic when that change is implemented?

> +
> +	test_area_gva_private = vm_vaddr_alloc_private(vm, TDX_UPM_TEST_AREA_SIZE,
> +						       TDX_UPM_TEST_AREA_GVA_PRIVATE,
> +						       TDX_UPM_TEST_AREA_GPA,
> +						       MEM_REGION_TEST_DATA);
> +	TEST_ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	test_area_gpa_private = (struct tdx_upm_test_area *)
> +		addr_gva2gpa(vm, test_area_gva_private);
> +	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
> +			(uint64_t)test_area_gpa_private,
> +			test_area_npages);
> +	TEST_ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
> +		       (vm_paddr_t)test_area_gpa_private);
> +
> +	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		    "Failed to mark memory intended as backing memory for TD shared memory");
> +
> +	sync_global_to_guest(vm, test_area_gpa_private);
> +	test_area_gpa_shared = (struct tdx_upm_test_area *)
> +		((uint64_t)test_area_gpa_private | vm->arch.s_bit);
> +	sync_global_to_guest(vm, test_area_gpa_shared);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying UPM functionality: explicit MapGPA\n");

Not sure if Sean's comment regarding printf applies here.

Personally, I don't mind the noise in the output.  But I am running things
by hand.  I can see how having no output on success is a good thing when
running a suite of tests.

Ira

[snip]

