Return-Path: <linux-kselftest+bounces-18569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC32989B42
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E81C21162
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAE14A0AB;
	Mon, 30 Sep 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ+GqyJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DB1F5EA
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680762; cv=fail; b=iJBuXbJip+5JOXxD5miRVEpvihNam4JIkgdEematfq6+mMWXHmHBDHfjinBXvoV2Lv1THR3IcQB3Yr7A32Q0DZrR8tqhY31d3Kx/noC2BIwUmh2576eMzbOyZrMdUxtKQOr5+YqQWRau4For95qT5HTHFvfS9D4D30hku4jM+yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680762; c=relaxed/simple;
	bh=0cNdsNYwnx0AkJY50UDKB0NkhkJx+zycNI3Dh1DtUng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NprKf3Bvde8WZlCONvO6D2fOrQhRneCLstcxnwfyfTDvjHerJwVvOYBlC0hSp7xNwpcOl5eGwN1KBSXJfm0YoJToIicVmUheV5kq0SfFtYAw4+C6zweA90yAnBCQyNLbLrkxHUt1C7q4468Z99GWmyi8ei9vcYFn1MrcaLKO94I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ+GqyJO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680761; x=1759216761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cNdsNYwnx0AkJY50UDKB0NkhkJx+zycNI3Dh1DtUng=;
  b=UZ+GqyJO3UX8XuLzY8Itdac+g3KdpATAI4obiZhe7+j1j8QjkqDVHj+h
   NTiNgogsODUzChPDvD50BhP75Vazr9PZTxPvtetbTV22633S68YoaGTHu
   FfJ2dOxyiMe67nqj2Tg9CXUS07FYY/CzeTHESAxgLROcU/JTZofGuPyVX
   XNYdNuE5r6FJiGMnvJxftiVzhP1bTANyBo5pxUfyMgGs+tVFwcsy/JBG/
   JydJVknKFFf8eSiRvAzA78mbCREbS3B4L20BlJRE2XmnhwNTxhmgpfKXy
   kjXJBIUllQt600nXl95p8NAyBbM9bxl5S1kgRhw5sCtnPT1Y0mIOIL9+i
   Q==;
X-CSE-ConnectionGUID: edSnTE8qTBqP39BWnYOpcQ==
X-CSE-MsgGUID: zHxKh4jdQLWz0Fa44irzXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26928094"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26928094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:19:19 -0700
X-CSE-ConnectionGUID: qNzmgl0uSnKSJsVLY55r2Q==
X-CSE-MsgGUID: X5W063+VRcGCCL60EpmZNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="103993969"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:19:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:19:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:19:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcAT7gT8IssSr1K4Zo/Wby4qY2Jgmq+6NhWASwOoTGiKeV/C9gB6ytXYmXBh5XSPPMN0EfmjeG/F0qvgbQUSVUIM1rEjtG0T5oNvD+5xqd5SCZS+beImL16P6XfXe8RyJNTj4JwoDvFiUYBc8T2kAffVYWWaBpaLlrjIZGfQu0BedSyeBhx4WiXEo8TgX682DQBGfVCmXeWTUmn2ZHEeLb+PiXbuDsptQ/NBCMedPCavP4CivBWUZ2qYM7Qt4WlkeOyPR9dxAgJkluStCVNoNgkwb3D9YKhUvEPDlxpOcQ8cHuSWQrNhZiNDdHqU69J3Uk4/MsEUOfBF5GlQRpKHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cNdsNYwnx0AkJY50UDKB0NkhkJx+zycNI3Dh1DtUng=;
 b=uCKVHiIUW2dfQoGaAhWSZetwwqQDLUpXovZrTN2yCLEeBkSlkzFckTShXLLKfsQwee7Zh+Uq0mAgYGjTuyPPffBtOKBVTn+5O637J9Uhw0I7ND8Y/hNQl07yLz+/XBeT3+0ran2gvNI4a//NhFQxO2BGLkYx8y6KhVxUxwTcCStQTeYaAorAHlZoE0nS82hitvnOgDJ4PhT1Okxg1SiyUjtGQi6ktz/r/CHwSxkT5uA9FWQJk1a7L/XatmwwunZsl8lTlchf32McAH4nPwLMsFMKajMQInyXUSBIC57tzjtltJ9XZD7HgnDHgtl4vvcTS/rDJzBxxuAA5vGjOo1yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:19:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:19:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Topic: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Index: AQHbBRRZ/Gs6JvHngEmEM2d8kGigh7JU8DuAgAALpYCAGwsiQA==
Date: Mon, 30 Sep 2024 07:19:14 +0000
Message-ID: <BN9PR11MB5276AF2CB65A36369CF10A008C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
 <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
In-Reply-To: <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 98f06004-5d38-4560-c8fb-08dce1203011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2dKaFdiWDdFRmRrakg3aEJCcDRuWlpNYUJjUkc1eEdmZXpGSVYyblR0SWNV?=
 =?utf-8?B?VUtzRzF3bFQ1NHZPRUlRV2ljbGpEVHR3MW1Qd2VGalA2Szc5Mko1OVdLR1NY?=
 =?utf-8?B?VXJSU1pQQWtzSUR3eDB6Mm5NVGlYU3JHNFlXWnRUTzJZOG9lZTNQTGFvdFZ3?=
 =?utf-8?B?VzRrbnBtNjNGV1pKdEt2MkdVZ3FiODlxQ0xKMVpETlNSUDNhMURXbXh4a1FH?=
 =?utf-8?B?VDA5VFF0Yk1KYmM2WWRmUmIyei9BK1hVSEJEQVpqbHVRZ0FkajI1TzFKTWRP?=
 =?utf-8?B?ZVY5TlBjRGpxK2dMU0EwcEpxMWh0STFVdjQvdlJ4VDlJQmxwbFVoNUZReUs5?=
 =?utf-8?B?bXZaTVhVbEJMTzYxREJQbURscEFGQTBNK1BvZHNxbDhHU2FlelRJODRtbnR2?=
 =?utf-8?B?RWk0dStrVzJNSDVYOS9MajZickVTWk52Vk5PT3VGbjJWTjhIMDR6SFRDeEV5?=
 =?utf-8?B?YnBkWmRkL0RLWVJ5QmVnRHgzRjZnUkl5QVJOWkUrMFBxVnVubWNiSkRGbDlW?=
 =?utf-8?B?c2lQTCtCSTcrSDExUjVOUXJKQW80aGtyNUtlWU1VZXE2eEtxYWFTa0ZOMlpk?=
 =?utf-8?B?TDQwclBGckM0VW1yVDJTSUswcjRxYWJ6RDdMSUlHVXR2eHJON3hWWXlIaGF0?=
 =?utf-8?B?V1RDZW9kc3dCZHhzTkNxTHBhemQ1ZmNyZjdPdTg0Q2xMSHpLdC9oVlI0OHE0?=
 =?utf-8?B?NGpFbHV5SVorYWsrb283WkF0RGR4N3VhRnVVU1ZSU3JHZjVRejBiOVhKbFVG?=
 =?utf-8?B?QnppZGFhdjNVdC9Ca0JtUDJWRDlNZlhGYVNmanNFZzJaM2lGNjBxZVlHWG5M?=
 =?utf-8?B?KytZYUlmZWVsOWIyMTkyb2pQS2xNSDBzbnZUb0FnN0d2QnM4RkErVkV1azFL?=
 =?utf-8?B?VlpGSFhaM29hUHhRVzhBdjNyY3JMajc0T3Iwem5RdHZpOEVMTzZxei9QSzZo?=
 =?utf-8?B?R3RxTVdSb0s3UnV5aFQyYjRVd0JHY3VCeUlieHVGVXRIbzVNOTNRc0NoSkJi?=
 =?utf-8?B?TkwyYjJVdUlCNVBnSEhSOVJMSi9OZ0V2Zmk5NVM0dHFYZDM2UStYN0VacVVF?=
 =?utf-8?B?dkduMkl4dlBCUE53YXlzOExGTFRuZjZYbUZvdHF3YUxIVGE2ZjRqSjVaeDBX?=
 =?utf-8?B?dHdFWHF1RWJPSGJRbEZLQVhNTlV1OWorV2YyYjRaeE5tWEdxZHFNMjRrVDFQ?=
 =?utf-8?B?VUcwUE85NkE1dHRLVXFHUGZVb1puKzJCeVNKcW9lVjE5c2pMdmVRL0c1ZUtF?=
 =?utf-8?B?YmdjMzc3ZFdKSVk5em1ISXFMYUNXNjRSQWRKcTY3b0xXVFkrRjBRYkxWNmVq?=
 =?utf-8?B?K0p0a3U1UUxDUmZrWVpMTTBjM3QxQ2FTbjdNNEZtQ2hjVUJnU1BFWEdPcUJV?=
 =?utf-8?B?UkFUakJGbzFjcnd3NGprTUFXWWsxTkU1WjlHaVRsV3hWclA2ME14YmZtQSts?=
 =?utf-8?B?NFY2S1kxa0RjbkZlYng5U0Z3MGtoMlh5TTE4NVNVak40Q0pUbjBYTmFzN2ll?=
 =?utf-8?B?U0FsdDBlU1VnRG1scEUwOTdZbUNzSW9JYW1XTVhYcGFPMjBxaTBwL1F4K2Fy?=
 =?utf-8?B?OHQ4RG55eVlpeVcwTTM1TnZJREZHOUVQRW5nS3B6N1VRck9JeXQrcmFXN0w0?=
 =?utf-8?B?SE11L0ZHajRYYmkxSldoMWIycHdVMEJQanpDVTUyeVl3TUlPSE1tamtVZUJn?=
 =?utf-8?B?NXl4NDhvQ3BtVkRtTGhkcjBaQUx2aENSMkdWZ1RaY290RlpFMGJVMzFRRlYv?=
 =?utf-8?B?TG9sSnNZSDA5UDZDOEs4WjhXZlV0dW84SEQ0cnNPbWNJVUtqNUwyT0Zickc0?=
 =?utf-8?B?K2N3RnZ0azh1bXlNd1g0REhJQ250a2owTEZmcUNoVDkxZlRiaXp1R0NRRFNV?=
 =?utf-8?B?bkVEUm1hSitnMVczczBYa3BKZ1hLamQxVGZUeUttRXd1RWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVBSW1lUWt1Z3RtVk9NMldzci8zT09teGxGeThrcjhQa0JzQ201RlZ4Y29l?=
 =?utf-8?B?VVJWUUFKSkgyamIrbGtPOWV5OVNwSldhWWxPRTRrOGJwa1pqY2VDNTY5NGQr?=
 =?utf-8?B?UDVMRmF1WUlqRHl2L3dMeVdBL2JKa1JMSkdTL2ZJMUxwSW9kdmh3THlZM1c3?=
 =?utf-8?B?YWw3cWlRM3NnMWd6SERLQnJzcXVnYmJaclhQdmFNb2VXVU5rZXRvbjB1Qys2?=
 =?utf-8?B?YVNqMW84amxXVnowQXgxZFdQTEIyZmZiNFljeDl6TlBQaERWZWgrWmduNitQ?=
 =?utf-8?B?TkJrM2l1WXpBRmlScDlNNW5YNTBRU2JDS1owdXl1cDUzUExlUHYzb09JU2Za?=
 =?utf-8?B?eENITU95dkVUSWkxbHlOdTltQVR4QzBOVVFkb3FjbkEwdDdYaDRvNUlndzFU?=
 =?utf-8?B?WisyRUNjaWJhckgvNzhNUlNmNDFnQ3ByWHBzR29xbTR4Ulh5OGN0MUxoR1Zr?=
 =?utf-8?B?bzgvQ012TC9CNmMvWFBlZEZ5QTRxaUZtUU8xTk91aDg0TDlBeGRLL0kySXZS?=
 =?utf-8?B?YitmVEoyMGhudUp3OEJ5R3IxaW1tVW50L09wUDFHUlJSZHhjK1BrR3Z2WDBi?=
 =?utf-8?B?L1B2MysrSm9CME9KRHRVM0pJZlVyUTdiUlZiQmx3YUIzaFI1YkRpYVZ1ckda?=
 =?utf-8?B?M1ZlMEVwLzNRZFJHRVI1T3FUY0lrR0RQWG9CeTlkUFdVaGVqejdZNmNHUlVz?=
 =?utf-8?B?ZEtvSHlQWXlWQmlYUER2ZG9QSVNmM0xpSEdKeDFMNmlLR2lrcjA1TE80UmRL?=
 =?utf-8?B?bzF4WG50MEtwVWcwdmtZNjBRWEd4K3JOaXVVbElWMHhPRjZ5ODIxTjFUYk9z?=
 =?utf-8?B?RVRuQW5ia0xZb1FmK3R6djErK05OdmwzNDlBeWJraThaTllKNzdseXB1STdS?=
 =?utf-8?B?RytTK055aXk3S2ttdUJUZkp4N1pSVlRUWFcxblVaNGFJOXk2TXpmUFJDMWZV?=
 =?utf-8?B?cnJWa0hIQUkyMUE3TG1WZHZseHBQYWZQWGZtK0NPUEZod0FFcWpCVHdmdzZS?=
 =?utf-8?B?WFhFblZnbitBTGxJQW5WN0NpT0lGTGZxWURxMFdDWFZ5YTBZTkJ0OXQ4aStI?=
 =?utf-8?B?cTlnMWhEcmVkeTdjVlFUYS9qdDdZSjZMbG9obXRsUU5udTRSN3pPVGdxM3Ar?=
 =?utf-8?B?UjVvUjhrWWo5L243ajh3T1M5NEtrL09PbUg2QkNpaGgzUkNHZG9jcW11VmJR?=
 =?utf-8?B?YXArTzBDdEJhei85dVFjOTdNSGJUOWk3MmdvRDh3OGlXaUFtbURwYzhCcndN?=
 =?utf-8?B?SlBUWWIzc2ozR1hoVVhIMnJhUWpLTHNLbVNKVGNleFdiQm5sZE85N2JRUHNG?=
 =?utf-8?B?OHJMQTNCVENBOWFxaGJIT1VZeGV0ZmlvY1dCVXVqMVpNUUxZMmlmeHpsMkxj?=
 =?utf-8?B?VktudUtKeTN3RnpVbXUzQmhPSmhxWVNjRjZ1TGpjQzU0TjhKM0NEMWdrTG5I?=
 =?utf-8?B?OHQvbGk3OWtsWXlEZFNNQStvYzhCZlFZVGo4SnpydlJscmxSdFJzZklLQkdM?=
 =?utf-8?B?Tk9HUVA4WVROaDJaSTZ6TWFQbWRROWlyd2RId2o4Z1YraWIraGg1Zm5weHd6?=
 =?utf-8?B?Tm9FUWhHdnR1KzMzdkRaUkE3MTk0N1RrMTFaL0Y4SllraWJiWlRreGZJcDhN?=
 =?utf-8?B?R2RxdS9uMWxLYkpsRWozM04rby9kRlBibmxiUWhpNm5GRTAxRUpPZXFXVEdR?=
 =?utf-8?B?VjZZRjVyQytRYmhBREpUUXZmVDdGR3VINzFxaE1adWV6YXp2Z3FHUnFLVjJh?=
 =?utf-8?B?U0t0RzM4Wmo5dE9jWVE3VGZ2bkpBUkxyaENqTm9XRW1aMjM2TlhMellVR1pJ?=
 =?utf-8?B?elJMV2Q5M2NOazFJaFpHcUFXYmpTdG9IUWZ6dENlUmdxMTVkeG0rbnZZbjlw?=
 =?utf-8?B?WHlTVDFEckNWNTFPUk9SaWxrdFA1U0tERzB0STc5SG55THRhVTdDeDR3MWQ2?=
 =?utf-8?B?dXBSUkMyWkg4Nkx5MnAyZVVPUm1KdmYzRXppT0hmZUc2Z1dwSnBrOUNON2tS?=
 =?utf-8?B?V3d1akZpaWtLOGVjbldmOFk1dzdsZzlTanNzcjg2cFpOR3RucGMwd2NWVGRu?=
 =?utf-8?B?Y0Fua2RUQlpRMzBqaGhyV2g1U0RjcWZkOVgrME9kUGZjaGlIOGdLanBzbUo0?=
 =?utf-8?Q?+8QwLrwUCSjI0+yQrlOGS3Hlx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f06004-5d38-4560-c8fb-08dce1203011
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:19:14.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIKumhPBYP+cI2x+YN6mf8TSA+nsyVPJxgCknidHSxwLjDeyRTFXjTWSVphfRFKjHrkDTFe/Pp6+Yh5k9ra5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIFNlcHRlbWJlciAxMywgMjAyNCAxMDoxNyBBTQ0KPiANCj4gT24gOS8xMy8yNCA5OjM1IEFN
LCBCYW9sdSBMdSB3cm90ZToNCj4gPiBPbiA5LzEyLzI0IDk6MDQgUE0sIFlpIExpdSB3cm90ZToN
Cj4gPj4gK3N0YXRpYyB2b2lkIGludGVsX2lvbW11X3JlbW92ZV9kZXZfcGFzaWQoc3RydWN0IGRl
dmljZSAqZGV2LCBpb2FzaWRfdA0KPiA+PiBwYXNpZCwNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KPiA+
PiArew0KPiA+PiArwqDCoMKgIHN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXZf
aW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gPj4gK8KgwqDCoCBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlv
bW11ID0gaW5mby0+aW9tbXU7DQo+ID4+ICsNCj4gPj4gwqDCoMKgwqDCoCBpbnRlbF9wYXNpZF90
ZWFyX2Rvd25fZW50cnkoaW9tbXUsIGRldiwgcGFzaWQsDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTlRFTF9QQVNJRF9URUFSRE9XTl9EUkFJTl9QUlEp
Ow0KPiA+PiArwqDCoMKgIGlmIChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0lERU5USVRZ
KQ0KPiA+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+DQo+ID4gVGhlIHN0YXRpYyBpZGVu
dGl0eSBkb21haW4gaXMgbm90IGNhcGFibGUgb2YgaGFuZGxpbmcgcGFnZSByZXF1ZXN0cy4NCj4g
PiBUaGVyZWZvcmUgdGhlcmUgaXMgbm8gbmVlZCB0byBkcmFpbiBQUlEgZm9yIGFuIGlkZW50aXR5
IGRvbWFpbiByZW1vdmFsLg0KPiA+DQo+ID4gU28gaXQgcHJvYmFibHkgc2hvdWxkIGJlIHNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+ID4NCj4gPiAgwqDCoMKgwqBpZiAoZG9tYWluLT50eXBlID09IElP
TU1VX0RPTUFJTl9JREVOVElUWSkgew0KPiA+ICDCoMKgwqDCoMKgwqDCoCBpbnRlbF9wYXNpZF90
ZWFyX2Rvd25fZW50cnkoaW9tbXUsIGRldiwgcGFzaWQsIDApOw0KPiA+ICDCoMKgwqDCoMKgwqDC
oCByZXR1cm47DQo+ID4gIMKgwqDCoMKgfQ0KPiA+DQo+ID4gIMKgwqDCoMKgaW50ZWxfcGFzaWRf
dGVhcl9kb3duX2VudHJ5KGlvbW11LCBkZXYsIHBhc2lkLA0KPiA+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElO
VEVMX1BBU0lEX1RFQVJET1dOX0RSQUlOX1BSUSk7DQo+IA0KPiBKdXN0IHJldmlzaXRlZCB0aGlz
LiBJdCBzZWVtcyB0aGF0IHdlIGp1c3QgbmVlZCB0byBkcmFpbiBQUlEgaWYgdGhlDQo+IGF0dGFj
aGVkIGRvbWFpbiBpcyBpb3BmLWNhcGFibGUuIFRoZXJlZm9yZSwgaG93IGFib3V0IG1ha2luZyBp
dCBsaWtlDQo+IHRoaXM/DQo+IA0KPiAJdW5zaWduZWQgaW50IGZsYWdzID0gMDsNCj4gDQo+IAlp
ZiAoZG9tYWluLT5pb3BmX2hhbmRsZXIpDQo+IAkJZmxhZ3MgfD0gSU5URUxfUEFTSURfVEVBUkRP
V05fRFJBSU5fUFJROw0KPiANCj4gCWludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShpb21tdSwg
ZGV2LCBwYXNpZCwgZmxhZ3MpOw0KPiANCj4gCS8qIElkZW50aXR5IGRvbWFpbiBoYXMgbm8gbWV0
YSBkYXRhIGZvciBwYXNpZC4gKi8NCj4gCWlmIChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlO
X0lERU5USVRZKQ0KPiAJCXJldHVybjsNCj4gDQoNCnRoaXMgaXMgdGhlIHJpZ2h0IHRoaW5nIHRv
IGRvLCBidXQgYWxzbyBzdWdnZXN0aW5nIGEgYnVnIGluIGV4aXN0aW5nDQpjb2RlLiBpbnRlbF9w
YXNpZF90ZWFyX2Rvd25fZW50cnkoKSBpcyBub3QganVzdCBmb3IgUFJRIGRyYWluLg0KSXQncyBh
bHNvIGFib3V0IGlvdGxiL2RldnRsYiBpbnZhbGlkYXRpb24uIEZyb20gZGV2aWNlIHAuby52IGl0
DQpoYXMgbm8gaWRlYSBhYm91dCB0aGUgdHJhbnNsYXRpb24gbW9kZSBpbiB0aGUgSU9NTVUgc2lk
ZSBhbmQNCmFsd2F5cyBjYWNoZXMgdGhlIHZhbGlkIG1hcHBpbmdzIGluIGRldnRsYiB3aGVuIEFU
UyBpcyBlbmFibGVkLg0KDQpFeGlzdGluZyBjb2RlIHNraXBzIGFsbCB0aG9zZSBob3VzZWtlZXBp
bmcgZm9yIGlkZW50aWZ5IGRvbWFpbg0KYnkgZWFybHkgcmV0dXJuIGJlZm9yZSBpbnRlbF9wYXNp
ZF90ZWFyX2Rvd25fZW50cnkoKS4gV2UgbmVlZA0KYSBzZXBhcmF0ZSBmaXggZm9yIGl0IGJlZm9y
ZSB0aGlzIHNlcmllcz8NCg==

