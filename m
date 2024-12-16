Return-Path: <linux-kselftest+bounces-23434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259759F3CF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 22:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F08188056A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0361D54E3;
	Mon, 16 Dec 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T12r+dc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504A1D54C0;
	Mon, 16 Dec 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385495; cv=fail; b=exl8gZpp2kCn45Fkj6hfc+BR9DCZhiBPRZGNv1nzgiWta6RA4fwpN/kiMMwWQo/iM1VBfJ9h9QoMhJxze/hYJRgvTwXng6jVhqqIhoZ1sumY49ZrknIR7mdwXIlkb4LqzYxw7VBN+kCDet+4+xvLk61n+rHyYu7b7ZiYcCfY8+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385495; c=relaxed/simple;
	bh=G5qL6H1hBBS+w157/hYFFaiLQE7CUcZ1mw2dR1gXT40=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoylvefQdMXwe3oquaws53SJ5nBxFKjrcFjdDszJKnLOl3QRBwm27QoQDqPhRD0EyFdUizFJrFrtMpxF//rVtTcUUz2WIm0uG8fXVnXTidVZ6UKxSeOJ2IGxgAQUK4oUcKodBscZiwjV2Gm7qcezyaqijdZKTIqQEFI/c9yGn9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T12r+dc0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734385493; x=1765921493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G5qL6H1hBBS+w157/hYFFaiLQE7CUcZ1mw2dR1gXT40=;
  b=T12r+dc0K0XFOUU/ed3UDshnUssAC0QulyE40+ryNBZr0nz4hv/KlDs4
   4oh1kDLF6SVEFxzR3n1qt8DPi+zbziUsq+RCU5QHtp1I550wfi9vFnrH2
   Tv3QeFc5C37L9AoU5PmHQwm9SD+xCf7sxW+AkCfoi+TodIoNJ68/+XUEU
   6LYB4jnKe8QDqvlUvxMc2SS8hEzFurI0EqtSt+mcEt673lB6AsnvVg3yy
   kH1/7m5Qy8+5LfJZu9ps8Uvo+xrpC5Nqulv1EVX8YCkDov01GAW++N3re
   hb9kIUKE/IjqxGR4jl+kA6r30IkWbrFnzR9lHaFsSaQV/1K4ej2kPo6Io
   A==;
X-CSE-ConnectionGUID: DDexmE4bSu+84lLAyMPvWA==
X-CSE-MsgGUID: CbyKYK4tSlajDVtwdQG7Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35015860"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="35015860"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 13:43:19 -0800
X-CSE-ConnectionGUID: o+AVFUb3R3e4DyvIMuhfUw==
X-CSE-MsgGUID: QC+TGbSnSCOrr5exX6mo5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="128132781"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 13:43:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 13:43:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 13:43:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 13:43:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz/lFsMVzBQIPojMrwKRq/TtOQQkgnRSTGULtdGrUHKTjE+9PnTOQgOQg1lriK0bvtrgtBo3IlKLxzAU3HYAMD07E62FLLha0gpGRiU13sZzLVz7fEjE43gWWdgpQ2jO/OFPdfU+ps+jEljWwI6MIloIsGoqFCcWxHuj277CNWnoKCmArvOm1sAVDHFX2ImYQohSvPeQFU2wRQ3SRYtyagwv3GR9km8Uw35z6PNAboBZTzAKE2Xss0M7FP4XPig2V/mmuydB6A9+dwf97xOWFhhqIeVVQT2+r7S/E/c17soQ08dAz+QixfM4ia8RmgoFqyg72YN8IyeKdwCPX62WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYs0Xqae06/pKh4hF+OGjIurh2GDXtHXAsJN+YpJARc=;
 b=f+P2G/lLDfMo2CQiHXHwQGBKBLBGFU1x+6P7mTVz9dXv+PVL4uYEdm8wXu/u4IAFzc9+Xphgj+1jp5UAwz3NLFoKvZfQrFuU/wZJ2TPXqvTEt6MgoR2YLAkw5zSSlhMYRUr85ytHoHg8BkfvduwjkP17QJIut97XkUeeLLJ5q5C1puP6CMN9TrSMXTeWnmJmWBRyv0ZTKbj+1EeeyOLpASxAcXs8f1Xu9udJ4ngNCUeyG8Qmr+2AQH2sPEM17RdfwW4LdBo9oCcHPsqM8iX4DcOJ2yXze5U3cUYXeuF/B9xY9roN1xMRc3Ma+Pu90wBAohGzE2a8ijApzvYshXCCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 21:43:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 21:43:16 +0000
Message-ID: <6c540c6d-680d-4a22-bec9-e4184bff051f@intel.com>
Date: Mon, 16 Dec 2024 13:43:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <83dcba6a462ec010a3c80bd8c6d66f49502b75ae.1734361935.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <83dcba6a462ec010a3c80bd8c6d66f49502b75ae.1734361935.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e323ed7-53c4-4726-0e66-08dd1e1aa652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEpjeXppWU9Da25HZFVNUUs3Smc0dnQyekNsK3dpN1VRbDJtR0VPMHlRRUtN?=
 =?utf-8?B?cDlHRm1kMnBrNi9OTWZFWSs4YkdyZUU3bTZPbC95Vyt2YTVKOTZ2MGttMUhv?=
 =?utf-8?B?blB1QmZVQUZsN3VTWkJOaDFqZzZ5dmZ5anBhRWQ0cDRCdEhJUE0xblByb0pt?=
 =?utf-8?B?aUg1MHdBWFRtTGJWZ3kySFo1eGd1ekJFVmFXYjNoUU1EM2dxYmhXNUZzUjhn?=
 =?utf-8?B?YSs1dFJNaERJZ2V4OUdZS2N0eW40QzlHZmdkd2VmNVVXMkVEZGtLYzJLak1o?=
 =?utf-8?B?dUFEQ0xSOGRZK2FudVpIcUJaSXB5UEprVVB5bTBxUXZmU2R2VVZUNUlRUFp0?=
 =?utf-8?B?S1JUNjZVNmM5RDV5MFIwejEvMnBweUFOb21ZNHNwZHFBV1ZDM1pZSkxFNk9k?=
 =?utf-8?B?a0FCYkZvS2ZjWGtOVTdFNCt0SXoxMGZwc21qc2YwU0hnUkZFb21xMFZXY0Z2?=
 =?utf-8?B?QTg1aXlZTkRvc2tIS281OFNUNk5ZclF2SEsrSkQ1azZlUEtaMFdxMk9rL0N6?=
 =?utf-8?B?aEZaM0gzSDhtaEViSlZJaFhNdG5HZ0VZdWtuN3FsRlBXQ3o4OFpXU21mdnFO?=
 =?utf-8?B?K2JLOVRIVXBCUU8yczBmVVgvdmh6N1k0TFN2aHZLZ2JMQ0k1NnBaWUR3c3Zh?=
 =?utf-8?B?OU84T25ESEFGeUU0cVFjZU01dEtTQ1o2WDZuV2MwNnlXbDJHeUtNa3VZM25Y?=
 =?utf-8?B?ZlFsbVUzR3l0elIraVZPc1VFRUdHdXdSQXlHMmxWemxyaElMSEg3WW5Wa2ts?=
 =?utf-8?B?VkFFSWFxSUUzWUFTdVA2dFN2L25OQW9oWjBWdXFObUVZeVc2UE93RG9keUx0?=
 =?utf-8?B?aEZBN2dDQ3UyeENsdHZIYzdZcDBCcHBGRHhWbHZic0wxZ3lBNHZpM3VxcDFT?=
 =?utf-8?B?YytaWkpWU29BSlRoTEZmdTlZUnFuZE1RaVlJQ3c2SFVXN3hyNmc5VDVOeG5y?=
 =?utf-8?B?dktGdHNpRDNRWjJXandObGswby9YUWdKcUNiSnU3QlRhaHRCWStzSHV0QlZO?=
 =?utf-8?B?ZUg4cmREQy95SkZLRnUyaW5xWisyYmlUVmkrVzBORzgwdjZML0F5NG1CZG1V?=
 =?utf-8?B?YVlpQWluQlNIeVgrbC90a0VZT3JEbkpOcXZOSHh6bEZJaW5KSCsxOU5kcERr?=
 =?utf-8?B?LzcyRXlQVFNtQVBTVFZEeFI2MmZIRms1MGNhUVc2bWdRdUV4eUZ0cnpPRmlP?=
 =?utf-8?B?VGxwZFV5NmNibHR1SzFpLzlLakNuMXhvMk5BNGVtRzUwMWREVHlBcE43cGtZ?=
 =?utf-8?B?UFZFV3htL08wQ0pFa2V1cS9SeHRTY29SMXJkQkQrVWlnN0IzT2dnTnJUUzhU?=
 =?utf-8?B?dUlxbkwyam5kQ28vcThoKy82UGlMd21aZmZDRlpPOTlRZUEzam5UT2tWcUV0?=
 =?utf-8?B?UlRPRFBuZXc4SjVqb1AzTWNvVVFhZDg5UlRHcnZoUmFhSkJmRm41RW9QYzZk?=
 =?utf-8?B?bzcza1RtZU42d2FQQTMwTEtSNEpFK05PRVBrUXVOY3o3SlBtcWtyQUdLcEtw?=
 =?utf-8?B?RWdxTFo4WndJZ1BVOW5zanFBUWh4SzE5anhuakcwSm8vZXFxcjFLV0l0V3hW?=
 =?utf-8?B?L0crNHQ1Uk80eGVGa1I4Rm0yN0JZOWZyOXF4RWFBNkVuS1hSTEZNNkE4a2dI?=
 =?utf-8?B?NCs1UFNwZ2lMU3BLRi9Hd0hJb3h6TDgvUitvWkN4cHNhdG1BRllhQjAwTm1y?=
 =?utf-8?B?VHpQQjN2dUxQYjhpTVhSZFVlOXFiTHlJRGNkeE91dnlaVmhYZG1FWmpMWXJL?=
 =?utf-8?B?YVQ2dDlXZDdyb3JXd3Vnc3dTdVpCejZmQU56ZXQ3TVJIaTRSUk5UOVVFNlgy?=
 =?utf-8?B?T1ZqMmNEc3gvSlduTTNmY2ZqdXlDL01sYWZLcmM2SXpLMm03RmZTL3RkNEVq?=
 =?utf-8?Q?mEC2Wd5cub21e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBYclBrQ29HZFR2UFJGckZSQmZ3ak1mcytRVHBxQWtCd2FnR1YrOGtySkNL?=
 =?utf-8?B?K3hjcG1YTDNDeEtBdjk2VVJYUC9IZzhoU0Z1Z2s4Rk93Yk00SlpZbUs2bElE?=
 =?utf-8?B?ZGg0Yk9id0o3U0VwdDloZTAyVHpKZktPNmNYU2gxZDZJejlaU1hiYzR5NzZO?=
 =?utf-8?B?d1UrOTVKa3dQRWF4OFg4NlRtQkw2RjlyRTBlNWpmc2I5aDM0aDNaOU93VUg2?=
 =?utf-8?B?NHpqQTlzL0htYW9ZaGMxTUlTSTFEU0NhcytHTTl0TiticXpqcWpLaWtBZEIz?=
 =?utf-8?B?NTRqaXVUL0I2RHRzS280eEZFaFNheDM2cDB0eHRyU1RlbzZlSjBGeHdwQitB?=
 =?utf-8?B?bG11NEgzWHl0aG1Db3NlaUduRkVDRzRFb3lNeDA0TWtNNlM3V0ZVcW1BV1p5?=
 =?utf-8?B?aFlEMmJqc3RFR2tGV0tZYTJLVkdRcVFmLzFXNUVzZ1NodmNWbk5pSjI0VHZi?=
 =?utf-8?B?OENibTFadXBqN3RncVllaU11Qmt1RTNxcDFyc2d3Z1BxTVN6cktBK3FvbmZC?=
 =?utf-8?B?anNvVGVSWVAwSnA5Y2NTcTN4cHZ2UVlOUGN5ZUhUaHB0bkY1OUtYZnJmTGVI?=
 =?utf-8?B?VElmcW0rcDlaMHhkYWlTd2t4U1VSYnV4VnBMUDhCd0pkTHJWZ1ZsdURDbDU1?=
 =?utf-8?B?OUlnZUd6QlRXSUlJd01meTJCUlExSFl6Z05ESGFKTUhKTVIwa0RSYmlkYU1L?=
 =?utf-8?B?Y1doVjlLRSs3RVhmS2ViTjRwaGcwQWVDUTVUWi81TlVwbllIUVh2eU40Qzg2?=
 =?utf-8?B?ZzQ2NHlSMWEyQ3ZtaE9CSTIwYVlMZnBZVlJMWGtsbnlqNHMzSWlKS3JxQmZI?=
 =?utf-8?B?d2ViN2lYR0U5VVk3cmdXckk4UjQweEVTQUUvbllFK05tRmtVY0Yrb3FQNnVX?=
 =?utf-8?B?QVlaNHQ3Y3B3WmtTOGdBSm1HMS9BVWU5QXpyM0FTR0w3V2xCZDBxQ3dCL1d1?=
 =?utf-8?B?R1poVDhMVU5jM3hReHhnZkZQNDBhUUJ3dE1DTHdxa1dhOVdJSVRva1pHTE9o?=
 =?utf-8?B?dlZ5YXlwRWF6T3JXM0swVWpETjBmNWcrb1FCTWFEclZya3ViUnN6RWxKcmtS?=
 =?utf-8?B?ZUV3VlNWK1lSUExERVdOZUlLam5BTGVDcGh2NzF5eGlvOVNpQ0NISXhSdXp5?=
 =?utf-8?B?VmEwUnEyVS81RHRVTDBrVDRNb0ZBMnhoeWFFWHZpblNRWncxajA5TkVOWTZk?=
 =?utf-8?B?VmZYZnFYbzJaMkUvTTlDL1pnTk9PWThXbEpDa2FQTU85dkNhQkpTRjIwUjRD?=
 =?utf-8?B?T0I2c2lEcmF2QUlDY2hlbmVwa3BsM016KzBXZHpraUFxNFhmRU1JY0JVL0lO?=
 =?utf-8?B?Wk5HRlNRQW9Ud1IxRXNsV2tHTkg5MXhjdHdRa2RmYjN2VklZWnJNOVdRZTJG?=
 =?utf-8?B?cytuay9WdExkYlI2WjArSTdCak5LNVVCc3paQUtCOExpT1lYaGM1MUNDR0ph?=
 =?utf-8?B?bG9GVGdIRGtRQlFoNUhJSG53MldpVUprL2tSYlc4TDlrZEhJcm9KUGFDaWhz?=
 =?utf-8?B?UFA1NVNKNDJaUm1jY0o1b2lmZ2tuK2V4R3NOQ2FWSU00Vk4zcWIzak1KcVdu?=
 =?utf-8?B?QzJrZ1NvOGx4c01nVW93N1orZXk3YWlra05yLzZ3MitTTEZJVGV3QUdQeEE1?=
 =?utf-8?B?U1RxNkNmYzU3SVVGdlpGcXJQWnJTUi80aVp4QUNrWmpLakpsVG9namhra0lr?=
 =?utf-8?B?WUdGU09sdG5ndDZtTUE4Z3JKdFB4bHVSTEpKMGo1QzJTWjBUS250dFg3Smdp?=
 =?utf-8?B?ZTRzN2tvWTBPdjJMOXhzV0MvK2o4WGl1cSt5VmJ0QWxSdG15R2ZIZGIzTlh4?=
 =?utf-8?B?OWNTOEtUWnZTRWw1Um1PWlVkQmZldXNacTVXbnUzZzJNeUFCcUVOY1h3WG80?=
 =?utf-8?B?ZGZIZXI4b1czMzBKQ1k4ZUExck12SU9lejY4bWcybmVSQVZueVBEd1RlYU1p?=
 =?utf-8?B?emtEUy9vRlFOekZFYTMxZEs2SlUzNGRsTG02SmwxR2xzcWZBQm5jWkpIYnc4?=
 =?utf-8?B?RXhqNk1vVGFlVTRyUkxJOU1GTGdVblBvSWE2azR6cmNrZStCSEUxVVVmdHFo?=
 =?utf-8?B?RC9CVnArWFJsNERNWklXNmxuNHo2aXo4R3FlV2JOSDl3QWEzanZYYnNSYTZ0?=
 =?utf-8?B?K3RjcG9lNjNXRzhSbDRqUkFUeUZ2eXB0NXhHaHloUzNydEdTbTgwYnRaeWt1?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e323ed7-53c4-4726-0e66-08dd1e1aa652
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:43:16.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyTFOa2Vzmb7s6CbJnCi2ASsegElYyKtDIOtszIVx6qJ9ogoWaJTtQ6u2JexOy61FJwL+9h1VI3kYaAcjNOQVOxJOraM2xEYypZQ01pFvA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/16/24 7:18 AM, Maciej Wieczor-Retman wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two, three, four or six
> nodes. When SNC mode is enabled the effective amount of L3 cache
> available for allocation is divided by the number of nodes per L3.
> 
> It's possible to detect which SNC mode is active by comparing the number
> of CPUs that share a cache with CPU0, with the number of CPUs on node0.
> 
> Detect SNC mode once and let other tests inherit that information.
> 
> Update CFLAGS after including lib.mk in the Makefile so that fallthrough
> macro can be used.
> 
> To check if SNC detection is reliable one can check the
> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
> are operational and the ratio should be calculated correctly. If it has
> any contents, it means the detected SNC mode can't be trusted and should
> be disabled.
> 
> Check if detection was not reliable due to offline cpus. If it was skip
> running tests since the results couldn't be trusted.
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



