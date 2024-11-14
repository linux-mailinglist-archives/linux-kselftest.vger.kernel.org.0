Return-Path: <linux-kselftest+bounces-21999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC89C8150
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 04:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC62281859
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C041E7C16;
	Thu, 14 Nov 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju8CvmCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240ED1E4110;
	Thu, 14 Nov 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553712; cv=fail; b=EpKpN6JyjjXFi2VedugL1dcGNPEIT+l7ftzb3N7wj3sWm8/EE7syVblhUkWGZ31n0kgXazUQwrDnRO+VwANS5aaHs8b/Ssr9j8HZon5B0SK1YMseQzThO19jBz9GInvphu4yse44ZHszA3UON8u0WDdcJcusD46OH8nq3e0GsVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553712; c=relaxed/simple;
	bh=Y/g9avS6IK3Qc/XkC5Jn+AGearSrMgXoCwzy4+gS3BU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nO51HPkqk7vsX3IdeM1oHdJdQJIn9cYBLFNO/bHVDx1Ft7B9hjr1d6YINMEfTpiKuOTSxc0jdpt7BqjKAxkFIETBd/7HAWV6mFsBZ8JBbsaqf28bpBzZFmLuDkhSEXM9iUoQ1dwWzZ/W3ANtBLjIETCZ1zRSGkwyhhzniPJYU24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ju8CvmCn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731553711; x=1763089711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y/g9avS6IK3Qc/XkC5Jn+AGearSrMgXoCwzy4+gS3BU=;
  b=Ju8CvmCnuYgAUy/xsgoY6aRn9odQuxOpZPA+SMzL2P9udWzNtOxtCH6U
   ebPH/+xE2vS5BtTc6xW9D2gTstR/JyTf7HtgKPbnN4hfi/5FK+q9qWHwX
   C/D5GYBseNLvjf6y0FnVm8Fez4ElWyF6BXpXdRmcDnz3NnsNeJORcOSfg
   LDH7HghlU0QUi4ykIGVezZXcyLLzU6JkWox1C43tASIATa//c3MkQW19A
   nBabrayYZ4ulEDLtA8UJn/fAhPajPHJVfEioQg+JK55SWWXNrgNr7PdIy
   G9eaxqedt2GS5vmghWVL3GSnpGJnnDDHgMEOBqOKRLE9/1nKTmZaZgsob
   Q==;
X-CSE-ConnectionGUID: Ba4+5CVpTGiho3pbypJ5xw==
X-CSE-MsgGUID: +qTTdFL7SgWoY8BFLB672A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42591232"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42591232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:08:30 -0800
X-CSE-ConnectionGUID: LDcehUwHTAay5NQHbbYcGA==
X-CSE-MsgGUID: IM4W0G5cQ1CyGibay11y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88047579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 19:08:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 19:08:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 19:08:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 19:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXaGvqni7/sJSdxrBJMZn7EyyavcXmx7k5R9qZlaxGjLZydMwh8xIHyp0JOSwU39CgLD1GOTwVlMhXImqbRbwG+/vQdcZJqBRsj9cxWGTtg2cTWQLgNeexRrEtActbuIB+BxeI/APUwqDMA26yHHO2MuZkauhVsdPT8t9cJ0cM39z+9sJrcv659S0gcobyHenDEokP0opsiwDOmK4Lwnhyy/gSUc+XMge+VM9H/POZIetFet7+PzKD5Qdtv4MWXmi4Lc6mGTPq6f92Z9HR6U1b3n/8AQqSgI5eefo7AwLhcwvedCzvUeJquFzVa3VErTqWnOzSycTF8/1c9/e5px7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SagKQreA0QpGUunHXUH4gDRAsUIeM7hRjEBQdCCuyrI=;
 b=fPJrM4133P2WLTZuUa/veemK2qH02AFn385wlT0x1v8TZ61TQi0RpPPMdi1T1il+CxNxz72hivMQpbbcso/d6gTrWjO6IcY0aYZlJ0U1WYBQT50lbFnCE+kBDEHG1/8mx++5+V47UkfFwa3lgzCjoGHgo2oCKkiZYO2/NFH9NyZbcLwPAbB2lSz9chNLAwlp/KEG1Lnv7LaSn0ldaTZnLEuHg3pCPamo4fj7FT4YU087MqDiYxHpErN8VYFWS2EUMj+GNrdRaqd0H9zkDu7e4HVidQtdv9xyyrFX1THJSjC07FRDhDRupRoHsReN1K7yxEcw3APAfSFtV3fPqmF71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 03:08:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 03:08:27 +0000
Message-ID: <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
Date: Thu, 14 Nov 2024 11:13:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZzVB7Fun48rGztuV@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ecd53c-df7a-4886-f933-08dd04599c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck40dHA5bW1pVGtxc1d5dGgzbzVaakFZNnBoVFRYc1hWbGFqeEIzWERmeWl5?=
 =?utf-8?B?M1RyU04xaFBnejNLeWdIUFUrVG1Sb3BvTjJTV2NBVlhheGdDVXM3VmVHcE51?=
 =?utf-8?B?dkJQS0I2VCtCUzhicHNUNlhEQ0YrVFpSeHpWa2FIakFxV0U1emZXZTdFL1ph?=
 =?utf-8?B?MEx3WFNIaHpHNjhTZ0hCMXc4ZjIzdVdla2tzZTBac1hZbzZPTkF2elpuVWFk?=
 =?utf-8?B?Z0l2ZWVWZFZJcENveUR6SWRiSXhyZlVlT2R1YUFvWU8vTmhNa2I0VVJNc3Iy?=
 =?utf-8?B?N2orY2hLSzJRc28rNWZ2ZkdKQTl1ek5sV1hGempMOENkV05uR1Fuak8rUUNC?=
 =?utf-8?B?R0o4cHpqMDNjUGJ0WWNSMU1RZGlmVEJqQkV2Uk9CbURxTHRRRkRDaEFyVG1z?=
 =?utf-8?B?RTlYSnhWS0lUSWlJQWhKU0ZVSVh6YVEralhKY2hZcW1hVnl5dDNEODR0Ly85?=
 =?utf-8?B?NDd4czZwMkNRSjFvVEp4TEt1UnRmdUo2dTRja2trd2hMVnJSSVVZamh2cVpn?=
 =?utf-8?B?R09ob0lTVmhKY3FFZGFaeTZRWGQ3R3N6MHB6QVVUblRmOEJ1Z3lmNW1aQVBG?=
 =?utf-8?B?bHFGS1c4bmtvWHFRR09wUkJvTzV5QlIwMVM5UEZPYzdGOXd4KzJHMUhMVVNS?=
 =?utf-8?B?TmhPaVR3NzYvOTBLLzluemVxRFBncmpRdFIvQ01QVTJySHF2TXRqeWcwNVRa?=
 =?utf-8?B?VHQ4cmRzaExEU1pwbmIrcWd3akc5d0tnSjlKOHhhelZuWGdVYW83Mk9Pa3lj?=
 =?utf-8?B?a2VqQk9GQ3MwSW4wVDYrc1gyZUN6V2ZpSWkzanE1UlE0YWppeVI5eHJ1elQ4?=
 =?utf-8?B?Nk5va3BEaFVSRWpPdlFIaURsTXVQTXNOMzVxY205WHZMdkFzdVhHaUdQZW1v?=
 =?utf-8?B?NmFUS2tNZHZTdmQ3QitpamVLa0Z2ZjFySXYxK2FmVkpWVHoxNkEzT2NQVG5S?=
 =?utf-8?B?TEQwc1VPbStjRGZMOU9FUFlrOHZFaVZzUVZjTlo3a0JTWWY4OUhXeTV1cTQr?=
 =?utf-8?B?MVJVWE1obWdtUnFJVk42akZwVDUraFVtdDZVdEZyQVJETjJCUVM1QmlMVUhY?=
 =?utf-8?B?ZFpPNEc0U085YzlvZnh1Tng4NUtJdnFDL29jUDhtWTdnWllPUGJjN0ZaTVdx?=
 =?utf-8?B?cEpmc25Db0tTZnJjbmt4QXpzTitDd0k5RmJxaXpKMEMyMDVKU3B5dk1ONUE1?=
 =?utf-8?B?SmNZaWVDWS8rNXJKZlFFZm5FY2ZoUXpLWFVKcys1aEdoTjVQeU1md1dIbHN0?=
 =?utf-8?B?NlFLcFd5eXpveEZJeFBWQTVPVThlcEFvcmh4YUZucXdRV2FzdjNNdlBjTUtV?=
 =?utf-8?B?b2N2cVl0dDJOSkVaUWhob3RBbTJaeWhpRTdqL3Evd25SZEhvdTFDR2g3L0dr?=
 =?utf-8?B?dEtaemtYRm1kNHVXOFRTR1prTkZucHNwemlFL1pjS0laRjlQdVl5V3ZYbnBD?=
 =?utf-8?B?bzhtTGliYmx0RVpYV0ppdkFRaWhKR2UxeTNWdlpTZk5PdW5SQythVkU4WUZn?=
 =?utf-8?B?b01kVWxZMER5YUJDMnU4WnBDa1BsT1Q1NDlCS3NuYjFrbzZUZVpHUEV5Zlcx?=
 =?utf-8?B?NTFvRVFzbFhpMVp2VWRLL2RDNnJFbmZMQVVJc0Y0OEdWREJ5eno5Y2tuaXFN?=
 =?utf-8?B?NUh4YU9FRkM5ZGlEUTY5eVZTS2E1eTlXQkkzTEswbEs0MXFYaXJ5K1k1T1lD?=
 =?utf-8?B?U2hXeFNVdnQwVGx2Tk05UHErUy9RYVhrUmpDUW9ZUnJuK1dDS21KNWZveE5N?=
 =?utf-8?Q?VESADCNkuNLgf4wRh14D+U4iTZ+5OSgc86wHs0G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JqaU80K28rUFQ1b2NxOVdCc2Z3bWwvTnRzMzZCNEhXUHo0UHo3RGpkVWQ4?=
 =?utf-8?B?VzRlWnlJc1JaR3UrZUpFWTlyckc5bTB5Rkl6N3FZUFdzR01qcm1Ja2ZXeTBk?=
 =?utf-8?B?T2RaOThHbzdkRU5vTVZIMGlFR1Jkb2ZSd0VYWEdRZ0VEWHoxN3pRSXNUSStB?=
 =?utf-8?B?TVRrS1pYWWVoSjZTMFdIRkRBc1cyU3pweWY3c1JOSkpNNnBJQS9nZ0ZvbHZI?=
 =?utf-8?B?SE16anczOXBNdDg4SzREUHJZNkk0dWNQMU5QS1NTMFRETFIvM2tIZlNWdWVO?=
 =?utf-8?B?TmwrUHh3SHVsQ3VNVkhPdVZBWkg4OHlSOXNFQkQvOTdOaDJhSDlqVEhtNWRn?=
 =?utf-8?B?UVNiQmw4cWdmRHhrcGpJdGxWdDVjeE9sNmlRNmZ2ZDdPSmxQQTRqSHFOV3Zz?=
 =?utf-8?B?dEl3bFVBbmkxbWNBaFlPcjBHYU9hNVBhd3k4VEowRkhqZnRwamEwL3lwMzhv?=
 =?utf-8?B?ay9QNVZvUGVnZDVXcWIwazE4OXFQckNyVnM3TGN6eE5CZENUZWJsRzN3OGtG?=
 =?utf-8?B?ejllWXBnOHBmWmN1c3djU1MwYlZOZzZ1Sk1uQk5CcEJMZEdjU3lpaUNXdnh6?=
 =?utf-8?B?YU1PSE0rY1ppS2xBSG5Ra20zNnpWNVJGVm1kM3c1VGZKcGtmdWQ0MUVLdXpr?=
 =?utf-8?B?TSt3VXpVeE9QQWlkL1NwaWlUbWdTOGdGODZCUkhjT3lYKzYzbUxKZ1N5b2lH?=
 =?utf-8?B?WmlBaitTUitnMi8vZm1iK0JRVEZVd3podmZ0aHNUSkx0QzcxNTYrNEs1WVlx?=
 =?utf-8?B?MmZ1RDhyRzU5aTlIcStMeXVIeUp5TVJ0RisrVmNIcXljQ1pzQWhabUlwN1FB?=
 =?utf-8?B?R1JVYlNFNmIvQmFXajBnVyt1TnpyL3FDckN4dG5LemhUVnFGaWIrdC83d3Jv?=
 =?utf-8?B?dzljeDFrQ0hRMW1OR3pyTzRrQk1KZHpYcnBQNmQrTUkxVC91eldCOXpJS3Qr?=
 =?utf-8?B?SVNtN3pTeGY1RnY0ditqUzQ4ODYxODBta2UySHowVjd1ZkhoeCtiUFNIS1oz?=
 =?utf-8?B?WVJqUzdZOVBhUnI1a3pSdXVHVHZqOWxWVk93M3dxeDVrbytjSk1vdzlOY0F4?=
 =?utf-8?B?VlpId2ZPRzJFeDBLVUhJWGFsaEhzaVpacnphSEVHK09yTmxBTlZidEtHYVd0?=
 =?utf-8?B?OGM4WEROUUR4SVBlanpoYlFIRGthb1dFTVUreG5yNHl5di9YVmhEcUtTaXcw?=
 =?utf-8?B?QjMvN1dIWDlFQXB5NjhWWWhsdmVSdDJkM1JJRmtzUHRodmVmTGZ0dm1JOVY1?=
 =?utf-8?B?SDcwejV6c1hpTXVUMGlraS9Lajc2Zm9EV3hYZzJZUUtzN3FOOGJHUlgyTytR?=
 =?utf-8?B?aXlENldTTVNJMWYzS3NVeU1yTERjZEZYLzV6Vk9jWUdkeEgwRXBQbGZvVmlr?=
 =?utf-8?B?cXNZQVJTcVpZZHFJUS9LRS96QmxUazRXWEVhemxBT2hqNXhEZTRkWHZVbGwv?=
 =?utf-8?B?YVVPV0pJWmZyWmlGcUs3dVVTdE1pdDN1NnNPVVU0NzQ2ZkhvcjdKcUNudDBi?=
 =?utf-8?B?aE5pVFl4dzFIVHRqWDJvbUJrR0dneGpvY21haDBTYWw5azBaZFY4MzFVeHQ2?=
 =?utf-8?B?c3htbFVsdXFsZnZXVzFvczZ5UWZyYnhURkZtUFVEeTZJYmc0aXpWQnArRDVN?=
 =?utf-8?B?NDAyblZScHVRWlFNU0xHaXM5QS9sWS9sMHBsWEtxV2ZNNHFyV1laWmk5UUJC?=
 =?utf-8?B?eCtnRDFGL3BtV0lLZ1A3SFhiaWM0dlBDQVBsTk9BQ1dPRTVZQzFuNkd6N0Ir?=
 =?utf-8?B?WDQ0V1ZqWnlrZHNiejMvNUYrUFIzaEZRbGVxdGttNjJIMC9FM1kxYjRaaXFK?=
 =?utf-8?B?Um5ZdU8yQkhUazhzVnpHWmxrRVA4ZEhKSWZrUVlUNnFzRXI5em8ySlM1Z1JC?=
 =?utf-8?B?U0FVekVEZkQ5Q205TVROUDFVKzhzRStkUGJ2UG0vek5zdGtzTUZrS2hweWFR?=
 =?utf-8?B?V3pnZEV3RG5jbmFtQlplQlp5cVVmcEhvT0ZjZVcvT0RnQldING9VQVRBU0J2?=
 =?utf-8?B?NFJpRjFFR1l1dkMyVUdTcnNkT3ZVaFRxdWVnZFp4NCs4eVllckNDSkFSeklW?=
 =?utf-8?B?L0R3Y2YveUs3MmlSTDJHTUhnS0pRL21MTG83bDFJVWtYVFU1aXp4VGlOVW1Z?=
 =?utf-8?Q?vwUCPclI5M7P98j8XVgqd6/MF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ecd53c-df7a-4886-f933-08dd04599c03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:08:27.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufHw8rFELMZzaZIbfBPyZUfmEcfw792ZVWIjcAhORcMrrpqMFY+fdyD/ykDg4SAaxRg2Z7VdOxPn3zZ2mpGZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-OriginatorOrg: intel.com

On 2024/11/14 08:18, Nicolin Chen wrote:
> On Tue, Nov 12, 2024 at 09:15:02PM +0800, Yi Liu wrote:
>> On 2024/11/6 04:04, Nicolin Chen wrote:
>>> +5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
>>> +   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
>>> +   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
>>> +   iommufd core will link the vIOMMU object to the struct iommu_device that the
>>> +   struct device is behind.
>>
>> It looks to be reasonable to share the viommu_obj between devices behind
>> the same physical IOMMU. This design seems no enforcement for it. So it's
>> all up to userspace from what I got. :)
> 
> It enforces at the vDEVICE allocation:
> 	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
> 		return -EINVAL;

this matches the device and the viommu.

> 
> Yet, assuming you are referring to creating two vIOMMUs per VM for
> two devices behind the same IOMMU (?), there is no enforcement..

right, but not limited to two vIOMMUs as the viommu_obj is not instanced
per vIOMMUs.

> The suggested way for VMM, just like two devices sharing the same
> s2 parent hwpt, is to share the vIOMMU object.

so the user would try to create vDevices with a given viommu_obj until
failure, then it would allocate another viommu_obj for the failed device.
is it? sounds reasonable.

-- 
Regards,
Yi Liu

