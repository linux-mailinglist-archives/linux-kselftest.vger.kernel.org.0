Return-Path: <linux-kselftest+bounces-25132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F56A1BD24
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993161675AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E4224AF8;
	Fri, 24 Jan 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUBdPeOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815F155726;
	Fri, 24 Jan 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749453; cv=fail; b=jTl37HGlgfgXt3tVJeg9Qu0XnIrnJMikUavzr0is4aQBO2lGafwfX3aqOlAwtj7acu7kLphiRZfwC5YHnUQtLltlOI81ZLkTez3kT8h812SkaWAWu7iqJA7dWctQdd+7ClN4rvYOslHmO2ylSuB2XbBlVcDK3IA0+AIuf4nK2Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749453; c=relaxed/simple;
	bh=9bcFTHhxjFXaPqI2tmu/FCXzmhtLYw202U92pNgG+D8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgqWS9NVj4M1C1TGhPSGF9Iob03MSJNRwq8T0YYoixl3EbZ4j2O4qJ53El35s1eFqnhT7C/wE4Vdcx/p87KTmRWi9+PQVT0m49P7cB1Xjyv+FASnqUz64fycmBUZ89nA4Oe+OMGnYzn8Vmsh0qo5VSyqkJmyQVy5XtyU9upWgMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUBdPeOg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737749452; x=1769285452;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9bcFTHhxjFXaPqI2tmu/FCXzmhtLYw202U92pNgG+D8=;
  b=hUBdPeOgTR+tmWF98JOFlgcLqLkKpyYBULqMm2/30xdop43p2qUKj/vu
   Xla+yA8YtX/9CAjCSaiyGW/daRQ4BB6dbNgnxbVAvEYhcBrjRb6ne8uP6
   Hb/iA6/s6uqvMHQrVtcnTJlvXC2VTGAbKvrxNEvGBzdMUhAc/sghhfjM3
   EbiRvIk5C3N2ylQ84x9QAxhJMInyr22rW6XSVT92FE3aydgmEi1xlnuC7
   lU/42jsJQxlHTyIz4JA4DJQoEhrHE7FJM5dmy69hZ61qb6X6OGx+DFyCX
   KvcgSQSSOBnei/iBg30BvHwqmGmEnsQ1423+pY9YM9o2dxZRRYvmQDUWI
   w==;
X-CSE-ConnectionGUID: k+cOoJpwSnygwqWALqIQEQ==
X-CSE-MsgGUID: IgakZQYBS42RcvU0ZSN9fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38464762"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="38464762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 12:10:51 -0800
X-CSE-ConnectionGUID: CmhkBAzkQSS7EEn3Dcy7iQ==
X-CSE-MsgGUID: 4wwmxtrbSlOP+MpA0ANe5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107979097"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 12:10:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 12:10:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 12:10:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 12:10:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tueEEX1ZlM7/YJDCiHRIEMj9KDYNrxIBrzdUILsiLHs/I/MMe7QXOaPPoLqFz+KRMkSNhFJH94eGJUWWz1ONH5djsfXinTInbD2rJcSXn4JXRF3ioZUy237fEY19+WB38PHG/+R1NBu7pwv7DOmEkr0VJXu0xfgAT8UlAXKzOJbe0mnNqPnd/IpA0iZuDnwgNOlD+CUM8xfP2qp56dZ9Sb4VcgDJTbNWwrimsRZCKSOIJQgrCA876XJIY4cAnu9KND23OtIxryi285gTGCJ+Wlixf5KpiyM4s1Aj3X2PoUN1ChLpceos197V7xOOwIdTrNw6WnKl7LXCwA+xP84psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZoK1S4/BRYpHZoZvbHJ3RRFTxfv2/nJ/9WCk04E1GA=;
 b=H7G727KhFRpVpprPkP2AhtH+R3rCihaISqDxZWZBVrF0+uKEtBgbh+wvAxcGiSvdH+WM8CE2xdMiBWL9F145L1rh9zbWzKHz0QaK6g5K5Pn6iXUyl0eD1gJOpDfXNjkgotL9g1SnXeziVqXOxkHxBuuGch50Czn5s2JBdVLd8KSvYGZPDwlPUq4k2PVdlvp2VzxWFtTE78bvZExJJsfhhk4JK5EOEXHwjGSrxP9J7CkE9wVuLxjV/VvYYQbM+kYZhWhprNLOwVG59G4RsR8Wf1zm1bAkC8hKZqQ3cUwzssN0Hv63dOehQqMo4ItuPTljpP9DkbsRR6qmLA5ToYRRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Fri, 24 Jan 2025 20:09:55 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:09:54 +0000
Date: Fri, 24 Jan 2025 21:09:28 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kirill@shutemov.name>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 2/3] selftests/lam: Skip test if LAM is disabled
Message-ID: <l5cpgzcxhpfbvpdvlaz3deomb5lkpyzgfbklgg6wmcaw3vicga@b6wzenpmg7jm>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <09e6958c424a5da763f2331745cfe145962b0a83.1732728879.git.maciej.wieczor-retman@intel.com>
 <81714cba-7924-4a4a-a5fc-b6f84bda352a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81714cba-7924-4a4a-a5fc-b6f84bda352a@intel.com>
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b1cacf-78c0-4cd6-e871-08dd3cb3114a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZRluf3hs8u5aog06/TWJ3W6tlDPF+ZhihyDcAgSEo7nzR+T/xs7e1W0Fd8?=
 =?iso-8859-1?Q?bvxpHEz9jI4LMFIeSs2QVqJF2hgBB0HC+WwttTNi7+/4kuKWRGWjb51vs9?=
 =?iso-8859-1?Q?i6umafM0XSC/oad0wgLva9uOthaXqD6acgY7MEnn0XVp5+BiMMmO+ID7bj?=
 =?iso-8859-1?Q?E/Zxke2qMyngUXDLlhfPiC7Px9y7jM2mUeeISilxWVbWLGqO6I45PnncuZ?=
 =?iso-8859-1?Q?rWjDtgZq7GRbPV8tftNd7Ixi87lCDwqDLU9+FsEP23a/WbH+BcdXIbbcMp?=
 =?iso-8859-1?Q?il8MjQyRtwa0h85Pz+MQ08hIX8sgIWum6ogczsIIElAkoIr/ymqKH6Hg99?=
 =?iso-8859-1?Q?jGvoktKXg8z/o2hF/x+EtlyD65q/Bbs8ziAr1F9D7sdDmYt4anTJAoR3LR?=
 =?iso-8859-1?Q?g1QF9Jage4kBc5SMRI7ZZuy0P1VGKeWHLo5jUtm29EZtRg+fjBSxpFted+?=
 =?iso-8859-1?Q?smRBUeu426e4WQ3OiUtiTPgOFs9dDPWiVbKOrv5GbqOjbtSMLDgmLkS6CL?=
 =?iso-8859-1?Q?s/IhgoDUT91ddDiI38AoABeUFJyGWCQE6kQXvJUv9xrBrQVQtjOnmlKhtp?=
 =?iso-8859-1?Q?mwSauWCkc118c4EP2GcvGpom8LthkdMXMxZFsZNo7l+QHYEIHHAFYzKdAq?=
 =?iso-8859-1?Q?AkxKDbUyN0Vw7nrwS7+GQRD8MK8imQ4+4aLe6036wrrF0CE4UyenJ6qnZ4?=
 =?iso-8859-1?Q?D8qz1qeHl41+tEAPYuAyJgMrYUwLiKLuokOE6DZhySqXbOJHopyAnXbux3?=
 =?iso-8859-1?Q?xyh5Fnf1Nly2QeuXXodCgqELAAeAq/n6N5I2HXgfpgjkHmw6eACsD7tfT5?=
 =?iso-8859-1?Q?y9Pfcmn9L3w6e8vTsJ8yu/q+LfaF3YDMbn7vkWUoxX1mKEddBNi+2p1ec2?=
 =?iso-8859-1?Q?9F5lQzxLcpqIG/h3VpxatUvcE7k52aOyjra0EQvxVSpUVmDcqsNz5aikFT?=
 =?iso-8859-1?Q?HZFpF9LCvcUK2maaNqirn7MllY8fCEPYvV+m1ZnRKaHjrhPsq2IV0vyLX3?=
 =?iso-8859-1?Q?WYgC7xJF9C2NWGop0XeW26msocpz6siM/jL0OXSGbryG4XRIDjdCJsgbZR?=
 =?iso-8859-1?Q?KmUEaB8uQ3GHvcehrA3xQrp9NEBE6GqdGHkpQuILpefEi8EcGUx4JvyGkE?=
 =?iso-8859-1?Q?C8OubZ2ND64Bi9zXTLMmYhMzXxsAlvIPCmJxx7QSi4kOaAkqf4+UHerTAQ?=
 =?iso-8859-1?Q?31+RYuOCqg3N8a2qEMEX1E+BMT2BcG2XH/FmgRPZla/b+PQevPDS6N5vYe?=
 =?iso-8859-1?Q?VZZkdmATwF+PamjP+R7oPvAREG1m4YYHyPJ0FEGAQ5E1hlo+dtT+R4gJW0?=
 =?iso-8859-1?Q?K6GC2jaW3vWykaNyidoayk4diMngmiyQShD+VJQO+PAWzMZ2usPqdnXvad?=
 =?iso-8859-1?Q?CLUwlX4qXu0Su/LZBLA4JThbwITJqxXkFzqWDjW/iomlL4g5r4+OsAShX9?=
 =?iso-8859-1?Q?L+K4HmpWEjwWkPcc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BrF8Zk68MmGe2cT+E4outpBVJWoKPcTYoVZq2Dusiz/kzjBZnW4iB2C+HR?=
 =?iso-8859-1?Q?4D75j87+41iuW77glmJDC1hjyrcALqPY06b/04kXMtGM/W36R/ucTdxHWu?=
 =?iso-8859-1?Q?VtIME0/yo1hqAmQC8EYyVsGouhnerdZan2hFa2Lq5klBDbiJJ87D+gIgKm?=
 =?iso-8859-1?Q?RinCpHktqDweqeENU2g991CjKsr9VWyVMFACZv4LTLNR9Hf6ajq9yGDyUU?=
 =?iso-8859-1?Q?iatg4s7U6hmvExZ7DWyhyWMObjEP3FyIE3WFBgiM8gj30rDL6VE1zvnyaM?=
 =?iso-8859-1?Q?UvsB9uc4aFSaTXF6joHublCyHKrs3kQluKXvTgODbgYYKGr66TbOBXy6BQ?=
 =?iso-8859-1?Q?3DKXZx4HBoha5NrsHvn7jwo9qQ7KLYaR4K8pvgokxAxelehO6ytcDltG+Z?=
 =?iso-8859-1?Q?nrzZvFTotiP/kPBczuIkwp/mm8fdxbJgc0jdMPg7iFkJUzxGs5SACMph2b?=
 =?iso-8859-1?Q?+eHiPul80Loc6RenOG0CbEWbSWN9Zu2z6suc497kEpxkJlVd2+W9unun5p?=
 =?iso-8859-1?Q?Eo2rR3orPzPDtygSex1kwvb9nXpAaRE9ov6ZTZd3FsHWMe5VAg+6VP9O79?=
 =?iso-8859-1?Q?U8ABEdy5i/HVBuMYqyuzZz3Y0BwSbubuG9rV5OM62RLM7PuW+cLiphX4+A?=
 =?iso-8859-1?Q?rc8sObspFIo3MuZcyPL4ib/henPwn9rryevzolso6UfnxiMm5hvyT/Q8QB?=
 =?iso-8859-1?Q?W8Za/Ozs82POENgJ1NI5FFkzvjHUpHEZvT09ADoCN18kDUKBVXJBUY9aO4?=
 =?iso-8859-1?Q?4bMwnsUMuP6wGHJhsz1xpf4lMGtKcLBMX7aEfAz4zm4+iWz589FjNtRyQi?=
 =?iso-8859-1?Q?dh0J7ozRi20q+OEHQjFgnUyJf8QxyCLL1HFV/Ehk74k50cwl2zrB3vyyl1?=
 =?iso-8859-1?Q?iRUceRNwMEONyQ2C63WeF9LqjyU9vpJOlT1//7/9ABpw58bYZEbG32FMvs?=
 =?iso-8859-1?Q?5P2COdc0me4u87rfD4us+FPX4ZorpRa6TzPQVoC3QUSncU8kHhGqjJoVz2?=
 =?iso-8859-1?Q?HuVcclZe+xgIpRPs8OV8Er6L1Siy0tXYdGger3WaybIyhF8/fQ9ZggmNPg?=
 =?iso-8859-1?Q?HzCxBqR/k18159bvFMDHfj40sr3nu3pqefao0AkyFHlWGtLykx9P78eXLZ?=
 =?iso-8859-1?Q?WDuzRwYOQu6zHhJJ+hyzHomosmXrMjh+BulTFIXqVtbkWi6MQG4fOHgJOq?=
 =?iso-8859-1?Q?8+EygHjeD2uZVz/iYvMC7Ef2mQP5xFdb6BEpz+1a3Q4rvPAmsM9nRJo31B?=
 =?iso-8859-1?Q?zUlTIrPrfUd6FOkAeINi5diz7mJuACDzlgx8qOxRbpPoj21R3pTS3QE6W+?=
 =?iso-8859-1?Q?Lw3FU/5KMMi/xs15BfR7RqUgwSTGXWZ0FkjYA4w5xosTT+FjVInG089kxs?=
 =?iso-8859-1?Q?IQfYVnhuHPaHokd2EO+CELxb3W17xuLAeFRMB6+/2zBZ1aNgzD+0mqb/6r?=
 =?iso-8859-1?Q?DGXdl+L+no2HB54Q5USTiyTRsaAahSlZ4Gcwrx42A3+XJ6hKjm2kNgHgyH?=
 =?iso-8859-1?Q?haMvrdsnXeIh5oGdqfjlaylhTwdFow02X5dRC2CR0ctdU27wMV5nnAS7/B?=
 =?iso-8859-1?Q?AXa1yT8Osbfw4tT05oypt1CSG+h64JINBd7Kl09uefJ9XzqWvDacZy1pqf?=
 =?iso-8859-1?Q?U9W/yLm0R/6Z0DJea4T2nO38QGWxJUQEMsjkHEFLIqAAN893u2IVAEtwd9?=
 =?iso-8859-1?Q?FcAB9YUkbLatKt7H8kU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b1cacf-78c0-4cd6-e871-08dd3cb3114a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:09:54.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XMZI67REZfTbKp/FyOPLItrhSUlkFs2HpvTwsMDOzOTn6hXcM3IUyfo4dw4BivkF8+L1e0ge65r3hsDWsPMQ7hP6UPlnM9k7joFdZ9Tm6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
X-OriginatorOrg: intel.com

On 2025-01-24 at 08:23:09 -0800, Dave Hansen wrote:
>On 11/27/24 09:35, Maciej Wieczor-Retman wrote:
>> +static inline int kernel_has_lam(void)
>> +{
>> +	unsigned long bits;
>> +
>> +	syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits);
>> +	return !!bits;
>> +}
>
>Generally, I'm less picky about selftest/ code than in-kernel code. But
>people really do take selftest code and use it as a starting point for
>production code.
>
>I'd much rather have overly verbose, obviously correct code:
>
>	err = syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits);
>
>	/* Handle syscall failure, like pre-LAM kernels: */
>	if (err)
>		return 0
>
>	/* Tag bits are empty on non-LAM systems: */
>	return !!bits;
>

Sure, more comments is always good :)

>Actually, I was going to argue for that^ just on style and writing good
>code. But then I spotted a bug. What happens if the kernel has
>CONFIG_ADDRESS_MASKING=n, either because it is config'd off or it's old?
>The:
>
>	put_user(0, (unsigned long __user *)arg2);
>
>won't ever get run and 'bits' will be uninitialized.

Huh, yeah, you're right. I tested it with both CONFIG_ADDRESS_MASKING=n and =y,
and on systems with it both available and not available but must've been a
coincidence it worked.

I'll fix the checks and init bits for the next version.

>
>So, I think this code was trying to be compact, fast and clever. But it
>really just turns out to be buggy.
>

-- 
Kind regards
Maciej Wieczór-Retman

