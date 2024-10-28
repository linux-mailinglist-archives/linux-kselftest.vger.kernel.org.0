Return-Path: <linux-kselftest+bounces-20772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C604B9B230F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F781F21039
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6449D16F8F5;
	Mon, 28 Oct 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoZFjj4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AE156243;
	Mon, 28 Oct 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083390; cv=fail; b=r6e+EhnacosFDVE1yyn8pWvc3NA79kalN2eelyDkQ0CLuUxem150txs9Ha9UgoPSU9porDxleVoQ7cLtd7RVqJsrmq0Gj2R5vGmlVknYNh46hwAO7w0EYRd93i7/lCO8mmKYQtPuIWJaerlvMT5NCW712WRxS4fQ24GO01Q/XII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083390; c=relaxed/simple;
	bh=VcDU9xWeOcIpuce9z9pjBoERjPB0ANfbI0aB7/UrX8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LC96cG2jvRYb/W7KI8fxbeZs8SrjRdW9y8P3NEwmrcwyydTSKTpgECLAzn3/iJnjMZdTjS+L3MvhM32Ie0oBYfUETEifGXw6Y5jg1Ixzk7zS7t3KUOA9dCvEka2ABbIZ6RvOgny2wFAYmRBX3HXVJfYW2yFXJLvDBiEdn2lQLTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoZFjj4V; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083388; x=1761619388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VcDU9xWeOcIpuce9z9pjBoERjPB0ANfbI0aB7/UrX8U=;
  b=VoZFjj4VDM0cQbHfYpWEuAS4/MMxnc8jIrMxOGfTvlSfP0UsTcCGVNXQ
   dHG3FyLlMaSo9VnU0Ip7XZYYKYDGc8RmbteWQ/Yki4SxJk4WF2hq+Adt6
   897pbx1mx+yxhGCw0g03qrDrdZ2FFb+99CtPV8+nTAQPTmehAtIIy8w3x
   sWmVJRmqAjiDjtYSX2gpVQRkX+gkjY0iVcJcpx/kqgeLMbv2jkvjbUH7Q
   6qPEC9YnfD4zU+HfH3GdVbD7w0jv1NHxGtP2ywtYplRcF0MDLgInnGHnS
   n2X25s95IPx1/u0Wu15/MwGPK/vHl+xqK+mjaOY3XX0WP5V/vmiGAjiGf
   A==;
X-CSE-ConnectionGUID: 97kWJNaCRPqQIen3gMJz8Q==
X-CSE-MsgGUID: gnNpqanVS+2RIWTfg5ctyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249045"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40249045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:43:08 -0700
X-CSE-ConnectionGUID: n5cFatAxQHO2FPe60wwkJg==
X-CSE-MsgGUID: FKFX7dKRSZyYHnx0R14+eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81420009"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:43:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:43:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:43:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:43:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYnfmp3Q2C448zjsetNeGkqJ3yF7Ji4YsiZbj2OZEt54gUjEwEMnGwieNV846OZUpMf5VUz/F4P0XXL/dYS6iTkHtR/OVi22TFTccPb10LaIy6s+vNuf3n58FRTdJ7I5RObVjSwmGc5EieMX8xlsZdRNQ8Czx4qRUX4QNsL1y3zfN+lTbzefGa5OuYCZ0JzHIP5sZLcEFVFJwWcuuF7DNbbO7+JiGP1ItQTS9Vnhv9/NlETOJv5LJYVs6vdhJdniDM5QNBMPzujH1L8tSvipNpNxXBUFGfoi4Z1i7FodoQGUxruWJ6J6jw8QC1oYDwzwLitZuSUnPIDNATqh00NEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcDU9xWeOcIpuce9z9pjBoERjPB0ANfbI0aB7/UrX8U=;
 b=BNKQarZLq7ixodbHfOqg/8iIjCjYMp3UC6Gcxa4FvqcrQbpUacDE3y5EXGgrdMiJNZVN2oFVDna/mSapaSkebjUtktveckWOFlAvQ1tB0WlgutrR4PioPFXYlp5aBI15V8OkKbq+EegeV+fon+BRV4/rVLEFPSCvEKGWAnjcURgZX9XCGfRVS2UOXhuZA7d4iPYS1CX0Yp0ZfC4qOJ5dqRz6Gm62n7cy6cCq4wt9XfrayrXNSIggX/fJEL2QcKW2vCoKG3UCEa4BruvsHNoiPHrVo5KTyYCrxXs9x3ignhsd3gTbZe/Bxxq2BQSEYFel6hfvNXhWxcaVoe1wljdmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:43:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:43:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Topic: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Index: AQHbJziuWBuW6knYnkGpoc9WKLVHPbKbd67g
Date: Mon, 28 Oct 2024 02:43:04 +0000
Message-ID: <BN9PR11MB5276918B39F18F4D51638EB38C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: be235197-7432-4ca9-7505-08dcf6fa3f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QL44wBk/s24sCBCqJT+5KnKfYI3iHGeOr8nqs+a+KknC3dtBHG1PWr4dfKzI?=
 =?us-ascii?Q?UZ/jDxGzg/G1bzUfA2TCx4HYVLGMxH0Z/87qiYrchAB88IzSaetsSetiTP6m?=
 =?us-ascii?Q?0v3ppSCSdh3bRXH8b31kvDrVXdUZ2mWank/8GV146hzjn/vajBGnwbfh/8en?=
 =?us-ascii?Q?Jx4oqWF7PCLkW33ELzcpvWC+HSATNjYs6k4h7cW+cDg/7Ghap1KHn13KvsgN?=
 =?us-ascii?Q?BDJV5ys1gF7EGizyJl7vpUz7ipL0rv00KJSg6Led27cy3nprEaOwspmLEce7?=
 =?us-ascii?Q?v68+lW+rMXXN//5kGkSVvVX3fIyOqC01WVFtAJdg0TD3CyGtAL/ARtIF/ew0?=
 =?us-ascii?Q?yYnqr8218in5jvehV7qVikaRz123kzkW8fCYDvqPSF08isUBxyOyCY45wmlj?=
 =?us-ascii?Q?bK5XEMPyH+hzdeO1Kgi53ONTFAw4wlcmXkeafcbUoOcOkErsJggQ61T3qwYu?=
 =?us-ascii?Q?Ws4T4VICR7Wnp6RexAjLoxlEdBKETU4HPYBG9y2djCY8biTwUm5uj8dd+YeC?=
 =?us-ascii?Q?rMFEJtx6bcshhBX5o1NNxVxXklF8mdTcEf6FX3xMHX2S5js/q6a/4WRZ59Mg?=
 =?us-ascii?Q?w84B7ye2U6VY6lAOut74mt25xqk8OunV4gkbM8yxIkPO/u9/J5iFI6QgDQUZ?=
 =?us-ascii?Q?EbLSlNbALhCRysUzd1ybxs2XODqmpprznq4LnA0RGZcgP8WpbeqeY/x+UKb8?=
 =?us-ascii?Q?F+UiKq2zkOf6o/wxBK6pZsK9J4NNAaxUltol1wXFyKp7nzU2PPybVYu/Kxs/?=
 =?us-ascii?Q?uYhfKLa57AM7WkfpRT9lQiOHTDQHJOEGBa8WZ0ZcHvLb1YmFIlHl8Rt3SqQv?=
 =?us-ascii?Q?kmbEpf+XHGGpiTtv/9qa20DTJ2KJ3FJnOWGwYYloV3U97hw0jcgfj76kTRtN?=
 =?us-ascii?Q?5oPklnzJnhLDm0xbAl0RoqS/0blbPQezdVFn/GJEetvH9M75bHGlqx0UDCYG?=
 =?us-ascii?Q?/9u2Vjfnw8T/ld4ra/afh8QBYJW6khmAaULXHiYb+s+OygPyoaBlAuS6Moff?=
 =?us-ascii?Q?rwSq8ure7d6B11M5OXUEZKldVaM9r0BB79RxwkmZfZ6MoJ0b1Mv6TUIYJFeD?=
 =?us-ascii?Q?MDSZrt2NX01KX0q382RktcIYMJAESqK9rMwY4zyiDBIv+53LNGHyRxFuK4Jq?=
 =?us-ascii?Q?oG8LmOAg9QzJaWE12rAIfykNPfLo7Wqb9m39Op77OiEPjTKN90TmZLSARti7?=
 =?us-ascii?Q?fSKDeu+sWeTaLTlO3B0gFl8WERAYvthOAZCPm9/D3fWojXBSEes6k7fTbvSo?=
 =?us-ascii?Q?M3ZnUFi2gtpfWpx4nvSHOSqcS37otFmL7HeBSyUC6LX0aH0KncvvSIk/TNo4?=
 =?us-ascii?Q?TDI8dm2eWotjY5Jt2CoiufiS05ATSIb86uUvE6b8Haio1/LmliMVtUkxQC4q?=
 =?us-ascii?Q?w9vU5Vo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ExP1E22ORCdf4kx9DnTf0VeC8kVKsjyzSZxQCdhjJ/4QL6N0AbljQL3RqRxZ?=
 =?us-ascii?Q?884gADwaI7lc97hrzDKOFCp1RrF8LBii0GtGPxaCtu2ayyaau8jI1gi2tYqi?=
 =?us-ascii?Q?vRDSzVvY+pNR6s6Ykh3sYwRM43AEb6lTWy+bpi6NUgYyyvQ1SrQblneIE/tb?=
 =?us-ascii?Q?FgWkCdFXQio3S+soVbD8oZ7e4uoNT9G0F3qKKGSfjIa6MttYyPPHuIrLVJkx?=
 =?us-ascii?Q?keMjWtj8ypS5/XF+jJTij2ep1S0tqtHqWhK2cdbVJDRW8ZMO6NrQsHBswr1L?=
 =?us-ascii?Q?S+X/b2BO6WIUHEYbeBsS8vpamR7J9jvZpruhGiC8BbO0iHY/f2LOWztaC2VW?=
 =?us-ascii?Q?tXVn2bdxCHKWB/4RbdDlcoJ+ArawSjF4WZjlGn48LyIwHdiHURIg3igLFYNw?=
 =?us-ascii?Q?+e+3euPAN2faaCAcTHAlIsIEymPXnZ8tp6/KMDmVRe8+Dy1aCEqctkW+yK97?=
 =?us-ascii?Q?bazHj6hGR39xfTFc1D8ekzb9wCWo3xNeLZW0agGeAmrwD/E48A2lg/mvRwAb?=
 =?us-ascii?Q?tNuSPkApkiHJTlO1xm1qoBrXn9p6K+X6XFtbmy46Cmy70qI9nCeYrUIQ3VEe?=
 =?us-ascii?Q?V0i6cWgkAlXPMMxnmXBF+whSar8nlyQK0RzhStPGZK+x1BKYm2DT6RuTgr6T?=
 =?us-ascii?Q?K8yohgzOlnghfHc5L4nT4k1I1jO7spQlNRS08L3p77BgKFyj1v6/OXBi6o7K?=
 =?us-ascii?Q?L5aoBhgjiT6/etQtT+YxhwoQBtOCJ+trpczjCVK1K79bcmU18wm/Oa4FZXYw?=
 =?us-ascii?Q?plDU7OG1luPl17jw/EtyjPn+uo7OfC41d4uPg1mURQmHcAiTC7A+7a4d7RGh?=
 =?us-ascii?Q?ORiGsZ+BLDFiw62IIEp+3xOUm+ri2qKhK7RnDDdk6+U093BfTVHRUyd8gG0A?=
 =?us-ascii?Q?qLcMYtLaIWDXDCpHcD5HHdwEAxny68Uby0u1FWi5Ikpu3Ww6ylPZFHBtuxbX?=
 =?us-ascii?Q?7t1kHsK8+JAWjVDfYbdgT2TC5q9PKMfJ8u+Km5cpYBPSzFAEi13kj17nJWlX?=
 =?us-ascii?Q?JnKPSVIT4/Fzn7Qqls8LzrvnsN1eunuBH/9SYOPZcKeqFJvQWlC8y8TtbpoF?=
 =?us-ascii?Q?+Yz0d7y7zqQIPpeeaqnxO4qWlS4p/hegICYn2AwC8dWL6ckzafzt/UXIqC7r?=
 =?us-ascii?Q?GZhcDxPgZdZv/KVNFg3wna7xpNOiyOYCMtvawMUGUeAT2pUWK8co16rPejWT?=
 =?us-ascii?Q?vrHkADZ2bVEvT81YbMn8ga3+yLUju7AKm/4KVLANNa9Vs0Hb7uEfBY74OvPX?=
 =?us-ascii?Q?tLAXCIHIEj/2gypmygr7zXWzYe8oMW+dSyvE7vRH+nkdcHXeS1oszQziZzT3?=
 =?us-ascii?Q?9EwISN9JzzcM145MpgoUlZMP0Xu4wgH3BL+xo0QDaP8VVLAvESRWIFIjcItI?=
 =?us-ascii?Q?EWJzImjGKy4ud2T7+OZjcHkG/Mwu0g3RiXUAE6PjWsZSzTOkWx7CuwFAleld?=
 =?us-ascii?Q?8B0OSfbgkcUT5vX5HK5l2ai9BUuHymzlcC50OkIPf3Pbsic24pph6t1tRdI+?=
 =?us-ascii?Q?+tZxMIs9UrQUta+TXzEisFI93KuBw98d9Oolb8T0iZb9su1dNiL6t1l0bM6v?=
 =?us-ascii?Q?qi7/SD4SRhGGIIA+RuBhOWgmlnVtqix7ydAef85v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be235197-7432-4ca9-7505-08dcf6fa3f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:43:04.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4LPLGXAe0ud+x7cu17a6SvyvXIYx1aM1Ow7pd5noqhvokKa5tdTezc1sArYGWUPNXuZFvpjQ1zuNtTu1QaSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Add a new ioctl for user space to do a vIOMMU allocation. It must be base=
d
> on a nesting parent HWPT, so take its refcount.
>=20
> IOMMU driver wanting to support vIOMMUs must define its
> IOMMU_VIOMMU_TYPE_
> in the uAPI header and implement a viommu_alloc op in its iommu_ops.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

