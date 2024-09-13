Return-Path: <linux-kselftest+bounces-17931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29446977EB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BBB1C2095A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBC1D86D8;
	Fri, 13 Sep 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1mempDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0819C562
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227827; cv=fail; b=LX1g+E45kQvSKmRHgdlxhaG356EhCOjcclntLMwJupVb+erZr3g69sfqD8VnMiMKi+bj2bEPJyPNzFqOUeBL8I2cDIxAsFF61dWgXJBb4iH2WOx7On5sd6ztPGSegn8iHXRUF+OTqhlNsBqfV06JtgTmCdSipr1E3H88B5h/8zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227827; c=relaxed/simple;
	bh=uVnQ1L7/XRzzx2kV0tmJiNFh5vAuGnWMED779tT2d70=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bv0ndGoEnvahpHBFigfd/QTN7zwns0T3CdwWaFX75lBvx0wRQvriA/W4wHuCTrzfWRxOm/Ki7PeQBdjcnLGKrAHfghvOcJmp+cMUau/gOR1QT3/KL7xcqWn3N/hydO7zRqZBkh6QXUSIV2oRTTMM3h7ua5hAJmWDWrVD3ofF+o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1mempDM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726227826; x=1757763826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uVnQ1L7/XRzzx2kV0tmJiNFh5vAuGnWMED779tT2d70=;
  b=m1mempDMaaLJlsP1KQlZoPWDPz2gO4uVn1Wq2ZUWUd972/KqpUggUX0e
   9ZfJ/LYM3KQAlsEZPgZt4BOVHAMZgXmM2IKdlBkqNbRNfLiO9eXcVsYZC
   eGXUqIIFb+SQDm9VQqhfzG/1WAASNhbwns9rAYiO98QFhJsynPRjPmvmq
   gncv7CGbLS1xMAaPUugY2oSy4gDgKN4BW73W/FEx8dF3i7tDLg9yWFhbC
   zTh0jYKYRCrVAmFBxzh8OX2Qc7UAFwbH+PXU6G2aHkZ8jCHV0CMyrHATo
   W73hN2NbK/l9gobzIzcXzNhhhFUoPOqszJP1v+89bvcCFb4NSaVyVxaiB
   g==;
X-CSE-ConnectionGUID: rr8wS2HBRkOqflDY38YuvA==
X-CSE-MsgGUID: fRdRKv9XT+GriktmwAZBlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50538886"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="50538886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:43:45 -0700
X-CSE-ConnectionGUID: uSqo13BqTCCHIlsHKhYY2A==
X-CSE-MsgGUID: ByBk8lPSSomObVkX/OkAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105484010"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 04:43:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 04:43:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 04:43:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 04:43:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 04:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enpG7NjjIVTUM6nHVJrGHYf8G5ZW/aGfQFxcyJ7ICmiInnVCNO4XipjgqCSaw20hvPHDEMoAAsPDgc5Fx762KdsvUJAodr6zvUJfl3n2GnpmbyHAMN+VqX0NRGI6N4sF88yCM6UOdZWwkedpDmKhKmmXxNZEhRJ0Bjiyd611OhQ5Sm8mwaqJfN90haMi1oKTIINmG/PeAJ1LLzFKhBd4LOFKjJpnLZjyYlWQolHpuwtCyZWe9Yn7jYaOY68/gubx4zNBuevn2Cgr6N63ivsMVNzkIWVrIKEYSDRUq0TTV4WXiCC6svMKWqFFybW2P3Aj+kcbXRCiztCfQsad3eGBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6k0oSYyhR1YOuRHVnzKWkOUeO1UW3voi6LREfak7xY=;
 b=Z8B6aVZDXbD/lqlEcSQY7Dit5coR/+yjyHVIbXKKI5WruOYlsCR1RmnaSBf+gohRS+zfkXcrwYbhVYzapQsKq6jubD9HD6HmQcSRGesgIhXAwlvqwhn2hYgr29vchAjWiikR71fD0ATLp/6g4Quur7iYcwgFM7e6TKve9HpUx0F0fYOvSyzgOZa1ERjDuOBsrTa5SAfwAuJS3X8fobN0J+O1OzoJJkEmbIpMFvl0nA2MXeY070OZUqkz0QDUq+Z+CERyaf3Q4/jTboBGip8Eo1ytrCN65ErCrVK8mSPnpv+qdtuanY5ZUIduz0tpVUFB/+FpNoSEnBucDa2amnb4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 11:43:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 11:43:40 +0000
Message-ID: <574cbdf2-74fa-4719-8965-c4d61268a3e3@intel.com>
Date: Fri, 13 Sep 2024 19:47:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: Add a wrapper for remove_dev_pasid
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
 <20240912130653.11028-4-yi.l.liu@intel.com>
 <71452c12-7339-4122-a7a3-64dd32ddba3b@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <71452c12-7339-4122-a7a3-64dd32ddba3b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: d2caa558-8646-4b01-85f7-08dcd3e9500f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUJrS1FHS3YrVzEzbFExUjY1TmtHU3o4WkxwU0NpNEJnMEs4bnJ5WHJYSUV5?=
 =?utf-8?B?djRCT1ZxWVBmYXRjUExMbERXTVBxZVN5MENqWFprN1Y3WS94ZGhqa1gxQlZv?=
 =?utf-8?B?R0h4WVZYYzl4NmxpRE1aMGpOb0lrOFA1d3dxNEtiSml3WmhnTFpYSnZtaHRv?=
 =?utf-8?B?MnZVbGpoMFNRTTVtZVlNTGZuMVZtMHZqQ05seGV5a2JCUXBXQVdGMzNneFcv?=
 =?utf-8?B?bnFjNldNK1FHaExzQXRGZUM1S3VCZzFWVnpSdUhCek45R0UxWm5MQllHbHYv?=
 =?utf-8?B?d2FQODRvN0FIUCtuRFNvL0FHSzk3dURKYWhwVVdrYWh1UjF6MjdyaVk3K01r?=
 =?utf-8?B?VGpqbTBuK3BPS0hHSzNmZkhzVllrNW9ZWHZwTlFreW1jTU1lWEJ4enpGazk0?=
 =?utf-8?B?NkZ4T2tjTjIrR2k2dFQ4bHREdEx3NXVJQkpvZGI2VHBHT2g2Rm5JQi8wMlYy?=
 =?utf-8?B?elV1NXRGQXgxdmYrVDIrdFdHNHFmM1FZdzlMNnpjZG4yd0JtRjkrelJnQmFY?=
 =?utf-8?B?QWd0VGh2UUU3cVFtZFhnWDBuL0lLV1ROS2w1U2lUa3VoUnVsa09pSkNwTmtE?=
 =?utf-8?B?ZTVRN2lySm1YRnh0bkVnSmZjUU9EMjBwYTlGNEVib3JySFc4OVpESjZWUVUy?=
 =?utf-8?B?MjRrVldaWnloRnNrZHh6OEpqTU44Umc1VTlITUFJNk5NVDJnc3hnL2kwMCt3?=
 =?utf-8?B?K3JMN0IwLy94K1RJRUEySk5UR0RmRU9nemFZcGVNQkVLYjZ0eXNCbmRBVVVk?=
 =?utf-8?B?MUNldmJMbUNGWWMzUUcwR042YTMyRmNoWTV3QXZadS9qYnpvbHJMYkxuZGhG?=
 =?utf-8?B?YjBYd0p4ZlZWY1dBUm5IWUk0YzBjKzM2SStadDNkbkxqU3ArcW5rdWVlV3Rh?=
 =?utf-8?B?ZTkzbnE2TkVoSG9vWkduMmpySXlCUitPYUJVQTVweUlLS0FJUWhGN0RHRzkw?=
 =?utf-8?B?QzRoeUVrT1BSd2FmQlVyUjNGeEdNRndCeVRDZFlocys4RlYyQjZWMEFaTmdw?=
 =?utf-8?B?YkxZa3ppZnVBWUdreEYyQWMyNUtvejQ4aEx0dzBzaU1iSzZSZ0FHcy9PWktO?=
 =?utf-8?B?bTlrc3g3dDIwbkZEWUE5YUJSQ2tLaXFvbEhMR2JDZks2SlBSaHFJMWpwNWts?=
 =?utf-8?B?alNUTHJQaG9tR2VLZ3UvMnIrUzF0dmZXNGtFU0ViQS9wZENQQ0s5Zk9LUWx5?=
 =?utf-8?B?Zk9XN0Fzek5QTFN1SWhmUFNqR0ZIVTU2SDZXUjEyYlhuR1paZS80Z05oZTc4?=
 =?utf-8?B?TmZPeHgxT3VGdThZU2xDMUxzdjBMcHY2aVhkY2dPZXU1M0ZGcXduUjJBOTBm?=
 =?utf-8?B?V1B0SURubWhxMUNaNmZIQytXTXFjUWlvd2ZrS09NdFVBWU8zQlNBb00yNzlY?=
 =?utf-8?B?VXZUdEx5OGFEclpGd1E0U1NEVkRsemx3ZmNMVmxkWVZTa1R4TUJ3U25yTUNX?=
 =?utf-8?B?QUQ3VnNjUjl4blRCcXptbityakZoclBvbkdENWZsM1FYSUNMcnMwZmlmWkh3?=
 =?utf-8?B?WGhQWnRSTHNUNmpnTEVOZWIxbTVhQkMxU2tGRkdEYzZ1VTFqekJadGttTnlK?=
 =?utf-8?B?UjZQajkzU1ZveGp1ZVVQUWowZVJvK2ovbm5iVDVkb2h3RElLMkN4Q1JDU3dM?=
 =?utf-8?B?QWlLY1JhYWF4RjYwOUpPZU9ybTVaZWdSWE1BOE1JQUZuRU5FNUEzeWxSY1lL?=
 =?utf-8?B?TW1xVFFVTWQ4M0JUbVRqU0gyNXdJWk9SejZRV3VJRGJRWmpMa0lIcEJkT1BY?=
 =?utf-8?B?clEyTVhsRHVsZEpDVmlrQ0NaLzVvM0toaWxLcStid0pFUWlHNHp3TGx4VlBL?=
 =?utf-8?B?WkFqZ3YyMGJMbGQrcXFRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDlpeW9qZm44c3dDL21pZFJRZC8zNDNwaHJYSzdXWVFSVHUxSzEzVW5KeEpU?=
 =?utf-8?B?TnJQRlB0ek96RWY5RUI5NG9VODJZSk1NbHJFSnhVbU15NnlFT0FZMzdab2Jh?=
 =?utf-8?B?TzlmRFlHbEMza2d0eTJIdXE2dE9aNzU4TGFNNHFPMXVaUVNBMDdnZDY3RzEx?=
 =?utf-8?B?WDNsYUE2VGl4bEcxaFN2NVptQmJxNTU4bld6ZjU5YWJlQk1BZnhoMXBCS1Bo?=
 =?utf-8?B?QkY4MFYra2JEWUtNQVNZWjQ5cnJxNy83M3FNZVBMenkrOElVUUhocnl4a2F5?=
 =?utf-8?B?VzB0djAwVEdzSXJtVDB0ZDVXMzQzUlJobzlidWxvdU9CMHgyVGhYMXhSQm1Z?=
 =?utf-8?B?R29oaWVwNis2VEUzRWpsN3N6KzR3cE5ZTVVPSlZDQWRoazhxUVdEZHY1VkdD?=
 =?utf-8?B?dzBVSkRUQXVsbGFueW0yK2c4aXZqR0xIVVc0cWJvWmUvYS9MQklUN3pHZnVo?=
 =?utf-8?B?QmNxaEMrYXdGVjRJQTZ2MzRoanhXVlp6NzNrWTEweVZYbENIbHZ0R1NIZ1d2?=
 =?utf-8?B?cVpsTDIzS0Y0WnNocC9oRXpLOGpPc0hHVlB3Sk55NEx2dDdpYVJZL2x1SmJZ?=
 =?utf-8?B?dkZjVFZhbDJldlV5YlV4MHJNYXZTKzF2MUlrdFU0Q3ZFRC9pTFpaR1JzL29l?=
 =?utf-8?B?MlZkSFUzbzdYZWo0bUY0bEtJOTRuam9DQTlpUjhoYm05Zms4dFVDMUNQd2Jk?=
 =?utf-8?B?ZXhiYU1LOVZ0Zk00a2FRWElQTk5sSHFQemNLbXlIdDhGZGtSSCtvK3pVa1JP?=
 =?utf-8?B?WGF1enBQSzdLeDNTVUNIbldwcUI0aGR5dFpxeWU5aFQ3QmhVMkJCK09oZWRL?=
 =?utf-8?B?TDAzMlFpalhKYzRsTUdIdk1maGV6ckNiVzlpOUp2Yk4xNWJZc0xRVWlVTVJa?=
 =?utf-8?B?ZnVFKzBya0lWaTVpUnZDZkJvR2p6Nms3V1JGVXFLbm5BalBuUmlzcDkyc3Jz?=
 =?utf-8?B?RSsycHdSV2hWTll6ek0zVDhhVk5zQmMyMkxJZ0IzUXBRSVBYT2FNeUVmTjFV?=
 =?utf-8?B?a3o3UzEzRHpuM0UzL0diSnRiV0huTzJnZktIL0s2NGZiYUZ5cWhIUlVtMGVJ?=
 =?utf-8?B?TVFkN3dKcFo2K1hLS0tRRFRrQ1dXR3dNYzVzamRNR1NpMlZuU0VtZ3FxMUJK?=
 =?utf-8?B?dFhyY3h0cVRReTRNVWxqK1g2WUkzcmZSYXlEcTZWSlREUElxK1ZZWHNYcnQz?=
 =?utf-8?B?ajdTbVhRdTNCNVhvZXR1TzFvb1hFdVY0R0E0S1JPZ1c0Q2RqTnlKb0x1ODM1?=
 =?utf-8?B?dmh4TzdxWWpGN1dhQUh0STFGaFplK1I5bjdiQmdPellCSExPVitNdnJWN21Z?=
 =?utf-8?B?VURkRkduMWFhUTFzb2JPTmYySlZ2WFRaYTZtR2FiVGVnNkN0Mkw0NGYxS2F4?=
 =?utf-8?B?NkprMVJEcEh5VWtvL1FrbDl6Y1RiQmE5eHlTeUUwNTV5REFsdDYxM1pjNzNu?=
 =?utf-8?B?TGpZdnhBOTZtSEU0VTY2UzhsQ2dTM1lyYWNvSTk3emFVNGRZYzZ3REh5M1d2?=
 =?utf-8?B?Um5TQzdaNjZMY2RJbXFFNHRxRGhTRXZCQTVNU2dOc2VuTXNjdVpIQkYwcjQx?=
 =?utf-8?B?S0hUWWNPYnlHcS9lbkVtNi9JamJXdVcrbHhkTjdsYnVFaWhnbkhZYTVBREpp?=
 =?utf-8?B?WitEcHRqSUtJY0ErNmNpN3Nla3JrMERCNjFpU2RrYi93eEVPNkx1MzZKSUpG?=
 =?utf-8?B?c002RTJPZTh3NDRYL0VuamdNWXFkM3krRnR1YlM3ZVhrOTBpTmg1R01keFdr?=
 =?utf-8?B?N3A1Wjg5YVpVMmF6OEFwWDU5TWVCNStpUlBoZWNFYW04azJqT3NVZ1FRTXoz?=
 =?utf-8?B?c0QxM01NUTh3OUl1SkNINXQ4QkR5SFY1YlNIOE1YMlVKNU1zVEFEc2dSLzZV?=
 =?utf-8?B?ZEc5VW1DQlFmS0hRWVB6WW02U25IaXZRU3pjUk0wMjhmdFVWODBvSnMya3VB?=
 =?utf-8?B?QVZ0YlFoZTNqbjJYUkV6UDY1ZHFBa3J5N2ZDTDRkeHU1dEdvaTB1SmZzbWlY?=
 =?utf-8?B?emw5S0tscnQ0b0lUcy9ob3U3Q2hWa3BoQUxmTXMzSXZ5SWo4U3ZJQVlrOE9t?=
 =?utf-8?B?QnlpNE83M3k1U1F3ZmFaMlE0WDRqb0JCNDYrTG9CTmUvWHhPWExmMXdzNUp3?=
 =?utf-8?Q?/3Tn/HhYzzukb1YgUnmLHcA6A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2caa558-8646-4b01-85f7-08dcd3e9500f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 11:43:40.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9ogwSK/3b9z5p2x+PblkBJ4g/Lh7C7ob2sFewgHAo4jjd4vyWm/DrL7e7DNicnwrsodVpIi3YpV7mDbj7bNCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com

On 2024/9/13 10:24, Baolu Lu wrote:
> On 9/12/24 9:06 PM, Yi Liu wrote:
>> The iommu drivers are on the way to drop the remove_dev_pasid op by
>> extending the blocked_domain to support PASID. However, this cannot be
>> done in one shot. So far, the Intel iommu and the ARM SMMUv3 driver have
>> supported it, while the AMD iommu driver has not yet. During this
>> transition, the IOMMU core needs to support both ways to destroy the
>> attachment of device/PASID and domain.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> This patch should be moved before the change in drivers. After all
> drivers convert to use set blocking domain to pasid, the
> remove_dev_pasid could be removed as the last step.

you are right! let me fix it.

-- 
Regards,
Yi Liu

