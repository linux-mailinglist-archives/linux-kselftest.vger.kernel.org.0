Return-Path: <linux-kselftest+bounces-18605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7A989F1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57761C21A1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5617C9AC;
	Mon, 30 Sep 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fI5Xpv8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA52D613
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690984; cv=fail; b=DSi9jJB/7TNyNlwnJU7GdClnsOocsfcrvvlQWbOgAWw1vLAYB+s+86/dqZRjhqogl9Q9KTyYpPhqFLo33IlHBl01ka9B3YGadvmvuWo9sFaxMAi5qbklwTiDO2l+JU4fL7R+CNou+HVu/3yGoUSsNkMdkNwKo1DyKpQTEP9fHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690984; c=relaxed/simple;
	bh=IE8jhNssJSqI8O31X1RyPBSZ+72Hivlgsp4kpSZITH4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkNR4bW82SNbCDFLnfKikqMX9g4CiJ7QriwDecwn7+wZ7uAFPnB8yusZXbroheVycfU/ymYM1NuSrAtiXNxmQPVmESKQpEwiXfVez5tu6oANTJS2UmEuW/nxUNQtn+h+7uXztV3xNw/QOulbJhex0M+7OIK7KEy601gtwWSwnIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fI5Xpv8z; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727690981; x=1759226981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IE8jhNssJSqI8O31X1RyPBSZ+72Hivlgsp4kpSZITH4=;
  b=fI5Xpv8z321K+cYB+na23BcCO+QFt0YfoG1Qu4CvqB4kfp9p0/v3R8zU
   khTYdRSQGqDxl7+FSBHMBvFMJqG/ZYzPAH3kIrvwyLyQx1Qw5gfGPuDaZ
   NREX9pa19w/JRAs3xrSl8flwO9mtJpgXrUaeZMhhacXe8HH6LOSXCuG6A
   bgYvbTk4YSNtTNvBoj+dnsY2BkJyMMDECkPouGk1RBT0JJJB7utyxdQ/e
   3Xi3vdezNLrO+uMZS2w7OZMOM1Jeei/GM4/YV3EASotB0Epk9xANuBDXA
   nM4Lyez43akOxlWK7KBfHbbu3ihft2Ivn/Dc5N58AZCS/Rnc9+jZ0KC1R
   g==;
X-CSE-ConnectionGUID: vql0ZBNbQymQ8tJQdDBdvQ==
X-CSE-MsgGUID: i66uKoBpQqyLBm6hfrA+lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26867185"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26867185"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:09:27 -0700
X-CSE-ConnectionGUID: JhOdVQRJRRSnwoXTzO99Fw==
X-CSE-MsgGUID: XdNa0KFmShuHIne88O4fFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73652307"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 03:09:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:09:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:09:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 03:09:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 03:09:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1eb/4pncYzZcnUGdrO0ZKIdn7lazdtjK7Aa/eN7KfCoQoUDTyCvIOCVReWkF+NfB8tRyxvJg2LlclfgkQF8LF6NWk1M+kgDajRfbWknWylT944ARy+yH2rolxakZstZpO8LHu1RowyFETvIdkoCCv6+elj3OIaXJjOgMMBWJ2Pvf/6dovIwhHEHEiYYfXhTn+t5GayR4JDun/r+7VYkDUIjQfHrF8dXuzon6CtsIxe0buzC2pMP1sMQ8E/p58r5+41hiCUenfiYX/tEPwBERHdZcwg3nizQ/Hn5eDUKBKo5HJ1ugXjIW0Mqnyq4Gu59/IblC1ItW/F7bxf3clyTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivwtBDDirsp7KW38L92z5OYX61inEma+CBD1PmJq2Hk=;
 b=Rqy1PiYxq6Ps7+nS4diLrsRZ6HG7ck7nBootgmsyqEJAffjgoTk/qhffTxYe+aHdHQ+A0Q5OHsSgh1PHZUeF4XbPxwS4nEU55ISqAO3ZR+RzPd5j0KjBDiVDbWGwKmQtsQ/WJiWXmlupUUfyHWQsBfrg5OYpDee+ijCz8K+lWPE9uxAwZze67yg0hsPyZ0ZAjTXaRMKkN0NYQLQ7GsWdz3J3AwB49aDrQ6rOUKOhP+/vn+cPnmukhjVd+E6v+adwdDBe3oxlQbiUg2GvBRSc/jbF15fS6iJeQCDFKg8xiH20UY/u0dEk2D/NoxRX8aQge5aUlnBMVfo1djjjMsy1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 10:09:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:09:21 +0000
Message-ID: <3536aa5b-4ed9-4ba1-8f38-cf80ee768172@intel.com>
Date: Mon, 30 Sep 2024 18:13:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] iommufd: Refactor __fault_domain_replace_dev()
 to be a wrapper of iommu_replace_group_handle()
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-3-yi.l.liu@intel.com>
 <BN9PR11MB52762A627637B09C8A9175118C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52762A627637B09C8A9175118C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ac302c-92f2-451d-1606-08dce137f3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJ0TzBweE9tU0FsTG95MVFyaFJHRkJmMGRVSEFlNHpiOUtaa2UwdWk5WVZL?=
 =?utf-8?B?RUc4Q3JlRHlsdmpPRFlldFlpeUhmSzlpaWJSSXBJTHJIN1NSR3JzZnFsSzFp?=
 =?utf-8?B?K2Jvc2N5aTAwY2UrU1R5REttMFdPRWxqeXg5Sk5yMnBmOUpIUDlML3dlSmho?=
 =?utf-8?B?T1JkTmw4SFlFZVFIUkhTbEpVSVFIZ0RwdG9iU29xZVNRUWZONUpuT1NkeGs1?=
 =?utf-8?B?dnZmVlpXYWN1Wm41eUpWR1RESEF6UjV5MHVpWDFaSUJuVUdCc0Q5T0Z5S0h4?=
 =?utf-8?B?TnB6VGhaL0NEQTcxZFh3WEdUbWROZWhrTnNpb2hMY3hSQXlzOCs3U2dBN01G?=
 =?utf-8?B?VjNpcXhFN1JmR3FoVFpxblJaRnduQUdjS0NmY0xGeG5xR2ROTFVWNWtMK1ht?=
 =?utf-8?B?d3UwNEtHLzZLQytnc1Y3R3BnWXVLZU0xZ3FocFllQmJBdXBHWHpIbW1pOGtZ?=
 =?utf-8?B?dVlVaUtwdy9mdENHNHorb0ZWMWtmZTlyZThqSENHNDVkWERzSzI0ZXhkMHND?=
 =?utf-8?B?WUdhcmhvZGU1Q0VvWVlaL0pSdFp1U2F4QjVDZ2JSejRvcmcyNVppY2swV1hk?=
 =?utf-8?B?SHlHSmVrdGxFaXNHUG5uNnh5NHV0cEVSMTRuZW4xM0R5S2ZxVTI2K0hPT0pQ?=
 =?utf-8?B?amV3QzRsQ2phNnJ4UStHREJ3eDhBdVdHL3VTV3RRRk5ZMGE4QjZOUVdlUWRh?=
 =?utf-8?B?bStWKzljZmg5MXdMQXRjNDlXK0xKUzNjU0NFUmNKZXdyd0tzdktsYzNBTVNo?=
 =?utf-8?B?V054enhGbU5aZ1pOSVlEaUh5WW1IRndsT3lyS0VHekxtTGN6eHkzSG8xMU1Y?=
 =?utf-8?B?SHpJRmNoNjhuelRBdHpqNWs5M0c0a3VycFliSW5sMDR3S3lMTWc4dEo1Q3Ew?=
 =?utf-8?B?ZE90LzgrdkJWQ0E1VXNybUlCeGVTRnZaY2NOWVhnWDIxYWtCeGkyajRvZkpU?=
 =?utf-8?B?WExKMUx6RTJDaTVSYUpyQ3JrNXhXRUMvdW5TeHhsVHhWZDlZRlVPaUdaRXVX?=
 =?utf-8?B?SVMvVWdJQ1ZYYXp4N0I0ekY4OHRCMnpheVBRMlUwWFJHeHFIRG0xaGY4RFBt?=
 =?utf-8?B?QlUrbnpVNE4yTjdFL0NhOTJuNkdES255VVVCZkdpdWNLY1FhNTdRRTJZSjhY?=
 =?utf-8?B?U29xSmsvYVQ2UUcwalJzb2doRlArSTVpcjR0TzBkZVNmeEl6RldjL1NRMXJr?=
 =?utf-8?B?RWxkSm0zckx0MWVnYmllVGROWUtMeVpoNkdLRklORnpjdlhPTG0yckI5ZERa?=
 =?utf-8?B?QlBCdVd0d1B3NHJ5WEZaY0dDdmh3bVpKbWg3TVpGRUoyZC9MbW9nQS8vSXBJ?=
 =?utf-8?B?TnoxY001N2JKWm5idm1CazBldWtMeGRnMmh3ZnlXNjE3RFprc09CR2FkT085?=
 =?utf-8?B?OWNPUERjYmJHYXBlMlYyY1diS1VZVUp3dHllZ3RpSzRiVG5WSVc2S3FOM20x?=
 =?utf-8?B?Q1A4VnpkV0M2UlRFT29hbmtnd3M1Y1QzZENWbmNYU2ZxOGNBTXZEbWJod2Jm?=
 =?utf-8?B?TWxOcW9EMlUxdGViNk0zUm1JdnRZQ1BCdnVYTkQ0eVAvSHhFVnhpQkttQ3ZT?=
 =?utf-8?B?WmlmcFVCUDkyWmZEYU5uT3J2S1o2QkVGMTJBMnl1TkVZMFNtMys5Vk16WkJk?=
 =?utf-8?B?Z2g3M0Ywa1ZGSkxuVFhMMnF0N3AyK0tteURJT2FISFZlUXp2MHBJdHEzSWdX?=
 =?utf-8?B?UzduTFdSZ3RUTy8xamg4TmxQOGRVVWx5VVR5NGY5OG83SDZqTWdSWWFRL1hh?=
 =?utf-8?B?SXlGa2J4RjA3V2VrMGpZZFhWRmxSQStaOEl4MkxuY01RbEdNTGxxT1FYOXY4?=
 =?utf-8?B?ei82NFFVS1JYOFduRGdRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldUdEp3b09XOHFhamJUZlhZUmUzQWJmbUpkY3NPWVRFN2FmNHNFclJFdmJn?=
 =?utf-8?B?cjNBT0QveHNuV1V3YndrU0RsQVpLR1FaODVRV1dpZ3lMNW1ickM2VVdtbjlm?=
 =?utf-8?B?ei9vTUpmQ2dtMkhBUXUwNFkyY2xsZFFRQW5BQjh5cWp5bVc3VWUzdGN4eGR4?=
 =?utf-8?B?OHd3TE5nVUEzalVheVZNWFZLdXFNeXhkdjFWMXludm9BWkFrNUxvV3dNU2hB?=
 =?utf-8?B?T1ZkSTAwRUJDNE9pZnhjN0pzajkydFNNRUhzWkNabzZnRWIybXRKcVVsOHNM?=
 =?utf-8?B?VzBaZEJoMmN4ZktyL2FabUNOT3MrSVFvOHdwaWhwVnlQSXQxV3hSYnloajhm?=
 =?utf-8?B?dDNsNkFxL2c4Szh5Q2hLTktWWHYzRmNQVWljSzI4Y3JmZk4zY2w0T0E0c1Nv?=
 =?utf-8?B?Sjd4bEc5M2VKWWpzL1EySW55Q1RNOUsvRGFlOUhnNmw3QUlUTFRzMU93VTVD?=
 =?utf-8?B?c3BBSjJaaS9JcUVGQ2xZQmFKalh6ZGFSN2RYZjBRMDlBYkViQVpraUwxMGZY?=
 =?utf-8?B?azkzd2xSODh0a3pqK252ejN1dVc0dFJIczE3RkVxWGwvMnlNNFpzUzhOTXQv?=
 =?utf-8?B?Tjlhc2N4MWcwOEc2YTM5eHp3dkM4K093M29hT09mKzdxWVpZdW1ONzJleGNJ?=
 =?utf-8?B?ZGtxVDNSbmd4dVBrMmU1M0x5b2hDeE5HUmtKK1JGYklQUlpqVmZETXQyOHFF?=
 =?utf-8?B?WU5LZDNGd2pqc1Yvb0ZKalhtRUZkMGRnSXBFRkl0SENMS0NBYkhxckl3MXo1?=
 =?utf-8?B?TVlRM1JHemRqaUJiV3FoQUlDVlZ2SkVSZi9YM0F4T2RvaVZ5OGhtT1NrUTNu?=
 =?utf-8?B?UG9yam9NVTV4bzdpaGtaYlQrVWRDMFBGWVAyak50bWwzK1VQMnNlb0JSVWNM?=
 =?utf-8?B?ZDFoeHB6anU5eUV2Z3FHNEhVaCtyZzYvNTVnZUp1M3NZb3cxK2R3TXlWcFNs?=
 =?utf-8?B?eTVnUnpXSDRrWGVxY3lYcGwwWGpTWXBjSWFTdUVHRDFXTmdZN09LSmFCeElx?=
 =?utf-8?B?aytJYnNBZXd3b1ZhQ0xrQ1pjZStFRFRYY1BJWjZFcnVzSFNyK1dyelhsNkFP?=
 =?utf-8?B?Mlk3T0JJL2VVQUlsRitoakJjMHZWSnVYTjRkdzB6TGlQVmltWFJtSkZvemZW?=
 =?utf-8?B?d2VOUDQ5MkNwSUxIN1lsZWtDVUtVc0VOcVZpUlAyNmVUenFjMEJ0a3NFN2VE?=
 =?utf-8?B?VHdmeGw0Q1prU2l4a0NuK3BQQzNIbmZlUTg0QnZWWlB3aVhwRUp0bG13S3Nx?=
 =?utf-8?B?SS8rbXVJejhzQ1NSQklwclk3ZklyQWVCem1nS3JpTnVVUjM0TGtlSTJoOFdM?=
 =?utf-8?B?dFFWK0pxdDVqTGZXbUhMWDM2RnZLR0ZFUFAzUDJpenpVZXM4M3d4T21pQ25U?=
 =?utf-8?B?cktRdHBPVXNTL1lTdk90Y1FNY0RKdmwvc09oYWlyc1J5UWM2em5DMzErZUt6?=
 =?utf-8?B?QXNabkZ2akhHTHB3bWg5TzVwd0NiaHpscytQWWhIK3BrLzdBUVZkSW54OUln?=
 =?utf-8?B?YmlVcC9ETDFtbGRSZlNpRUFYbllJUVUxdTFXajUzZDgwSkk4T2xxc25HQ3Bp?=
 =?utf-8?B?SUJFNWh3TlNFWXpybk8wY3B5SUtyQUdNZ0Z2amVqbkVzZGo0a2VCSWlXeFk5?=
 =?utf-8?B?SFR3SS9wRWNDTjh6YWl5WDJOQjFZamdGYmplV040RmJxWVo1bklRUGJhNG1H?=
 =?utf-8?B?c0ErQkJyQTNNdWQrTFh3Yk5mSTFlempEd0FtMVVQV01BUWNPOEZRQjluNEQr?=
 =?utf-8?B?NTVqeVJnR0NSVDcveW91d0JBbDMyS3pxQWFXOWovTGY4RERucEUvc3Rsdy9x?=
 =?utf-8?B?VThiUXBJYytFZnNlWVNYK2dlYndvbk1pbzZnYXh0NG1DdExLaS9pNkNCRWxC?=
 =?utf-8?B?bjM0Qm5NZ0haWllpWVVSTkh5MlM0RjdXUENjTEJ5YWZWYWdoRUJUUTZaTUl0?=
 =?utf-8?B?UXNJTHh1cHlmNlNlSUdJeEkxZEtGL01rZmhjMC9yektqelhXQUVtRm9JaXZ4?=
 =?utf-8?B?QWlIYlZIMk1yYTdUbHNvNlZlSVFHdmhPaDhsZm9mZmlCZXdVSm5SeUNxOTho?=
 =?utf-8?B?MWxSKzJTUGZsRzU2ckMxYzZVRnVaK01mVXpOdDRWZzNOYWlZTUdKRkVicS9B?=
 =?utf-8?Q?ExY7libokgD2JV29VufhmqNar?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ac302c-92f2-451d-1606-08dce137f3be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:09:21.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEKGWP28HJO7VTrs3AYGftB+sjdMx7LjhZoWZ0JAiDLagNRQRLk/zG6ZZTqAzMecdlOK9K9FmxKgqNJIsYTtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com

On 2024/9/30 15:42, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 12, 2024 9:13 PM
>>
>> @@ -191,13 +187,25 @@ int iommufd_fault_domain_replace_dev(struct
>> iommufd_device *idev,
>>   			return ret;
>>   	}
>>
>> -	ret = __fault_domain_replace_dev(idev, hwpt, old);
>> +	if (hwpt->fault) {
>> +		curr = __fault_domain_replace_dev(idev, hwpt, old);
>> +		ret = IS_ERR(curr) ? PTR_ERR(curr) : 0;
>> +	} else {
>> +		ret = iommu_replace_group_handle(idev->igroup->group,
>> +						 hwpt->domain, NULL);
>> +	}
>> +
>>   	if (ret) {
>>   		if (iopf_on)
>>   			iommufd_fault_iopf_disable(idev);
>>   		return ret;
>>   	}
>>
>> +	if (curr) {
>> +		iommufd_auto_response_faults(old, curr);
>> +		kfree(curr);
>> +	}
>> +
> 
> this is incorrect. The old code does auto response as long as
> old->fault is true and replace succeeds. But now you make
> it an operation only when hwpt->fault is true.

oops, yes it is. needs to get the curr handle in this function instead of
getting it from the __fault_domain_replace_dev() helper.

-- 
Regards,
Yi Liu

