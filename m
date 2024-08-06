Return-Path: <linux-kselftest+bounces-14841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED13948B40
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 10:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E891C22896
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C221BD00C;
	Tue,  6 Aug 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOQ3S99E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11005166F17;
	Tue,  6 Aug 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932741; cv=fail; b=RABhOauigKeQcxul2DaVlgecJFQbPlfg4kJjukXTE/fIkp0ElfdUPefmjnfrRil+drACY2HWcTpLkKlJA7nj2s3R+AVnY3cKehHD/BkS5lm7Ix/PlJ5VGQVOUCV8dUQzXRsso1ZygDRVLzIxAoeB2zm4NhEbG/b4ZXZcP+/Qe58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932741; c=relaxed/simple;
	bh=6kw1ufUhd7TmcdSv05MOt5fZJ8Nndwtya5jPEmW0gCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUARNdoTu79rz+61XVrWIutlvovn1i7CCqNwS96itQCK7JTCdEFyvp68eI5kdsJAZgCshLjLjmve/kfqsjQPad6izvwmKmvUn9KFmRX8YJFtcAvXcE28fuRwgwQ2uv8YbZHSFHt9hX1WHKPIC6tN9X8VCir1kyEvDBdyO4IqEYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOQ3S99E; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722932740; x=1754468740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6kw1ufUhd7TmcdSv05MOt5fZJ8Nndwtya5jPEmW0gCA=;
  b=iOQ3S99Elb3Hkr3P8yNpHlnxI72sVBpesnzjclGFEdYwqlnIA1m9xQjI
   l9rAfynwD9zaaKbIeFQvP6MzPV5WPr4DztvKHNY2gUkcQpxha0cOgIqKg
   zntjEV/fATI46xdmhp1QYkrIEG0NGztml9hl8ngolBujnKHFjc1tcuz0F
   ZJjomemGdjOZGQ985Ht5r2Pm6jjiFrH+g/57P0NzY6ZLHe6P5CvA3Zvf9
   jefvTlcJhbEoVrbjRHLv8iaypZVqV1ntrJUnrfF0ruKwQC9mWvRUU/1ib
   +Cn5cPJQRTj9EO6w2ic+BDI1ahNUkKlGjk4WXP/bEbqCg/+i7VLSNWYVl
   A==;
X-CSE-ConnectionGUID: EnYnHL+aR3uHS+VANJjb6A==
X-CSE-MsgGUID: 5cvVP5srSHWDaljtlRSSEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32338068"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="32338068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:25:39 -0700
X-CSE-ConnectionGUID: Cq166OByRFqNDQQDt8eNnA==
X-CSE-MsgGUID: V8yg5wDqQ8aMTNvLWLBP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56528507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 01:25:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:25:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:25:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 01:25:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 01:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmEJ2FGELqQZWT0QGc+aYRc+6NJAxF0HeRQvq0roV28PCP0pamzT++vo4LMRegy60oR4hxXuQJ8zHzWJfQnV+iFSvdD/UhOSkTVVRFTBooQF2vPrrzgkM39CyvDSy5C0yApqHy0ydJvxfUYwsZAAsPsl9eyvQYNlKQLgyvCA+QOu+WTgUezyo/qrTJVtUQvlizCwBqXYjxd21D7NCxguZQBrsx+f+7nSdaaIoOty6+yFNjAau6yAQJGd9o7/p0DJKQ1F5PfJuTxFxrCGcGcvZ/8r4E13/ktmG1YwrEtNSAcU3WdgLSEK/PoC9DYfx4HmIMe9NcDmQ5MguxW2WtwnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqwwwZNC7oWmhY8qFXTOYHtRmoEEns9S8RSuPH5dyXc=;
 b=XxlrvrKw0a9xxT3EE0EWeB64jd7lW1OIjeAiQ+y3ThGasDouD/3M+dyopOq+mimpXr1mUShzgpnCsWyhegC84AOk8Yyl1lyQ5+3zVwhkIQhnXP0pqbPcaHgTmOGWfvkcXHJIyZ3XSIjaVeAZsMfIiSLf6dzJWAYGGsYx78CZ5U/1LIjeDnRRR4qeIPVeDAlTsiMxzwTJyIQda0uV8lpZYIwa0M+rWURRMICW7iN1xuH83h7PouXhdyihyZSDRZHRIuoO1uLJLH/Aqdzmn/4p7G++TAIAJTBH/Fc/8AcZB5gWHO5UjxQAyKTIU0qNzi5lSeLetppRBKYLMGKh1KgU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Tue, 6 Aug
 2024 08:25:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:25:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Topic: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Index: AQHa5Tymvv0QPh+hX0iHTvry+ddr+7IZ6L5A
Date: Tue, 6 Aug 2024 08:25:33 +0000
Message-ID: <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
In-Reply-To: <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5168:EE_
x-ms-office365-filtering-correlation-id: bbfa5edb-ad19-4aa6-f74e-08dcb5f1573a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XTrp2SdbuJ8nIpVER4CDGKufG66aUGdxxZ6hTjFiPg/8Rda0HBbEprqNqlnl?=
 =?us-ascii?Q?4oRGMqlNYC89OL337SLzwvE7P0vLyVK/YIdyg3OthQaM2eLEpyuhkLNW1lHX?=
 =?us-ascii?Q?14GotYS6DbMtgJlujDXb2qpttWpJHO2NlKB0bMaQluWMF8ozaiUFBJKLqr1T?=
 =?us-ascii?Q?QzPx4Saa4RrPxQsgxhqMKqBkolDxnrece0GbtfdwVKxqWBftkBUFhicnDNKu?=
 =?us-ascii?Q?WIsB9hFn9Ytsf/L5FGFEmJ2QA+YZO2/TFwZ17bEZhnk61JNnDPTQHb3HfEWm?=
 =?us-ascii?Q?yJYEQFpBSb8K5Ff6D9Aqce/hsdUsNLoxbOcs8ZXPOYIAWumyQvZAuKfPvhbc?=
 =?us-ascii?Q?TYSxsmpP+gnJOnz61XW+t7oyegP4g51qIMs3cyHLDGz+IAbHmzQDicGAK/7X?=
 =?us-ascii?Q?UNkeXWLLHsbjUiH/YOozZXaAfVXLQP7Kq+ezAG5dIjwFG6gxAnxquQ+TWWX3?=
 =?us-ascii?Q?4FLn8eWh5+cOOAq84cKZuthVWkOrG0SnJ/3B6alAIY29bIDiltuouRBCER4R?=
 =?us-ascii?Q?7dXcrhhM2TMvsX1ego5rNqRopNEyeEmgLk3M4W8ijVmqBzATAsavWDPTSn6f?=
 =?us-ascii?Q?fPH2f9DuuLYX8M7YSvCNFcs2hXCjutGORJvxzZtn0B4HkmifmFm2bsMUZoWR?=
 =?us-ascii?Q?KH8O3yRCUc+YPs5kyQkYwPeoeTkkZTU4oManZ9vPo1dIa6QsbmbhdMc73uac?=
 =?us-ascii?Q?i7EHTAeO2RLR4oEjzpYMlfLlXYLIc4oSwh7k/R/ckjPAIQe0l/JgweRuIIha?=
 =?us-ascii?Q?Q+/VxOHSj0aEX/rmlsFuzfd8R/6lBHPttzPW25t2/nLZj5g3rd7HXDhkF6HQ?=
 =?us-ascii?Q?ftO2LSB76QgmkOQx4LbPWSCZAiaLvDML9YyaGxDlk9yHLrpbwGvRPM0XaNFH?=
 =?us-ascii?Q?EbIIPAdKHYDaMp8LiJY9c/7m2O9qkE5dnQkCtnsAhWqcRAusQWidaKQ4Lccm?=
 =?us-ascii?Q?39BFAM6VXYU+feG/4vaRAIgBbJrHoR8MFMk/7B8nfi04Ug27t5Jay6qz8Fyt?=
 =?us-ascii?Q?e5sXQQlPDJN+lP/8jGL8ajCkDlhbl3g/tiV/o5Av+hX9CWU7paLey6gg/8rg?=
 =?us-ascii?Q?kDI9xjVOrD02OS/aOC3ah0d0X8YyTwMvXq5snAEFJKnHfVoWkWhERc+VIvCT?=
 =?us-ascii?Q?XZRV86rQV12cX5C1hbnRvcn2HYH+iP+Rlj4y3KuUy+h4mPbPammNHr9BvqjR?=
 =?us-ascii?Q?5Tn7z8MXbCKyiSZmJ8L+lhW8mmHGMLHY47aULdi2k475Z7kW65FRzqbCCqzf?=
 =?us-ascii?Q?03szSC/2WcT096eW69Th8VY4vLGGWyaWXi7k97xx9uwuWqof0K2Gpu5QBSc6?=
 =?us-ascii?Q?Ypn511GSlcNVehIIlTZ75FFEdatJk7sqToUIkfzXi5QobBVgq39O1OBLljYf?=
 =?us-ascii?Q?mxAnKk9cCHPeGmOx5iK4Xc2ka8NaR/BbolvrYYEQG7reG5Lkbw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RRds9/V46UwLIdaQbb1dIvq03+2J/Ph8UNJGbgnBQNRwN9dUsuwf68N8+T/a?=
 =?us-ascii?Q?epiPPbqeOEXunAZg1aOrdVqgrTd2WedWCWc3RkahFiDAj5km+KBjggKWOjSq?=
 =?us-ascii?Q?pEu+6RUnh/celQomDjPDs5Bf7FhtKilZuXRM3KfNnlaQUdDuyQb80n6aJ4Dl?=
 =?us-ascii?Q?5kc+OScFSQTQw1L2KWZgRmWoMqc5DTTn9/Y7YcxnmGBB0nqN0qVrLv3i/tWn?=
 =?us-ascii?Q?y5tWORmJkJqlR4ZGA9KyzIxhKGaqP7xJFn6RK1wP4N+DgH5A4hw/q1CYaVWb?=
 =?us-ascii?Q?NzmwfU3z0+4WeNlMYlq5o9/lKz+oy6QCG3aVG9EqTJR1bKv2GItXeRizw52d?=
 =?us-ascii?Q?U47aJ9lanp32v+/QUyXc1uTrY2Bk8OBtK0L5R747uhFSevPNYA4hVBJTzsL7?=
 =?us-ascii?Q?E4hOhOWDbZM7/iMn1zSSAp08iCTLbhxDpm05xKcJbEu3JdvgUfuDgcQdCYZK?=
 =?us-ascii?Q?uvh4Ygq068r/43vgqALtTQfHkG8dXCwrmJU/Bld/gtcOiU349qIiIOCDb4m6?=
 =?us-ascii?Q?CEl8FLfhQl7JxOZ3SKBI86unqs6WekbxyPTVS6rHtGC77/Kuv+Z8KRi6ByBH?=
 =?us-ascii?Q?hdArYANUuFbRDKr/6B2sXCHO9Xc/jM6CEtZa6jty6tr8ZffU6F/vuCsxfLF0?=
 =?us-ascii?Q?ylxZxxQBUJfsRuEZGZ1BzrkY3q8JTBt1SRER6Ax52E0o2FCLL2WY3jB7b0e/?=
 =?us-ascii?Q?b5jqFfN63itLHNWOi74Cqoxe7BNE6IzOnYuxC6piou6pbwOuh/hT/ub5mjfG?=
 =?us-ascii?Q?Ews3LIeWEuVf/CcbuWJ2kJ+9+prnHNH4JT7YdbEGprtbFDu8VZcRDYeBmLmn?=
 =?us-ascii?Q?8VDO32ADaiE7A4DjnLSir3lou10kA1dyr5K3S7uyoZIDiSnxpRSNNP62eTji?=
 =?us-ascii?Q?Laro+wQaNBudwDj0ZNSLg2DNeD+ABP3s1TxUgbJc5FKi+tsvgPTRvM/666W3?=
 =?us-ascii?Q?kC1eRKLH9yZ8J+6TIM7Tl876oszhhtZ9/Dc0RBEW+ICpFvl0CB7VL8SIpC88?=
 =?us-ascii?Q?QvzEqea441p3KsgWuIO/7GkxiBFo55J7ysS5AXh66rzs2Rmna/la8AjP8HE0?=
 =?us-ascii?Q?vOAY06kvd1qpGJOlQRpvzVkm6DbNZWSL7Kbsj5njJm6T2AK6Vps36n1IzNw2?=
 =?us-ascii?Q?Z7p8PlA/KpoBSCW8J0NtIVODNIhEazMZVJpjncg9swJJe2Ai5G+i+ss9T3+9?=
 =?us-ascii?Q?owr+du5TghAP5vGaQ5K7kXCg9g4waxiIgARlwJvIIjEfgxd3Lau32Yg4SOB1?=
 =?us-ascii?Q?d9bO0wHb3xqfUR4Qqc20mXHUqVrcUpZt6h5K8L+ws5/9HoFsqIerrJIV5Y4O?=
 =?us-ascii?Q?RFWsFzGEbYghB4Q1MbsAJxhej8UEHPvcKGmFcvdzF1i8Z32nxKq0LLQvVnPF?=
 =?us-ascii?Q?k95q7cqyKLklFg3h7BZZK0RYuUGcTzMYVwjWplnkcmCCprlVbJUIWyhIIf+e?=
 =?us-ascii?Q?hCiQeiKKNPBLvLn+2XbtfV5/7/UQmguMwCGLnfQwCr59YpEbRMJl7jFH+Lo+?=
 =?us-ascii?Q?tnmdKDWJTKxKHKqGFJGMC2Hbc6LxCU8Homw4ALk+RFKmb4UQRSg0i7w2J5/D?=
 =?us-ascii?Q?aDksviK2mfWHd0NtxLZCW1P6pnmtJ/n6dm+q3rst?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfa5edb-ad19-4aa6-f74e-08dcb5f1573a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 08:25:33.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dij3yGevUlMrzP6t4KYJwgdQsrIwAvAt93/wEZ3nOqDGuBGqX179b3bKk8Stvln7ASnbjVGlTzR5yv870ZifVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, August 3, 2024 8:32 AM
>=20
> From: Robin Murphy <robin.murphy@arm.com>
>=20
> Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> which might need to be aware of the stage 2 domain encapsulated within
> a nested domain. This would be in the legacy-VFIO-style case where we're

why is it a legacy-VFIO-style? We only support nested in IOMMUFD.

> using host-managed MSIs with an identity mapping at stage 1, where it is
> the underlying stage 2 domain which owns an MSI cookie and holds the
> corresponding dynamic mappings. Hook up the new op to resolve what we
> need from a nested domain.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
>  include/linux/iommu.h     |  4 ++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7b1dfa0665df6..05e04934a5f81 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1799,6 +1799,20 @@ static struct iommu_dma_msi_page
> *iommu_dma_get_msi_page(struct device *dev,
>  	return NULL;
>  }
>=20
> +/*
> + * Nested domains may not have an MSI cookie or accept mappings, but
> they may
> + * be related to a domain which does, so we let them tell us what they n=
eed.
> + */
> +static struct iommu_domain
> *iommu_dma_get_msi_mapping_domain(struct device *dev)
> +{
> +	struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> +
> +	if (domain && domain->type =3D=3D IOMMU_DOMAIN_NESTED &&
> +	    domain->ops->get_msi_mapping_domain)

I'm not sure the core should restrict it to the NESTED type. Given
there is a new domain ops any type restriction can be handled
inside the callback. Anyway the driver should register the op
for a domain only when there is a need.=20

> +		domain =3D domain->ops->get_msi_mapping_domain(domain);
> +	return domain;
> +}
> +
>  /**
>   * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
>   * @desc: MSI descriptor, will store the MSI page
> @@ -1809,7 +1823,7 @@ static struct iommu_dma_msi_page
> *iommu_dma_get_msi_page(struct device *dev,
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
>  	struct device *dev =3D msi_desc_to_dev(desc);
> -	struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain =3D
> iommu_dma_get_msi_mapping_domain(dev);
>  	struct iommu_dma_msi_page *msi_page;
>  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>=20
> @@ -1842,7 +1856,7 @@ int iommu_dma_prepare_msi(struct msi_desc
> *desc, phys_addr_t msi_addr)
>  void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg
> *msg)
>  {
>  	struct device *dev =3D msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain =3D
> iommu_get_domain_for_dev(dev);
> +	const struct iommu_domain *domain =3D
> iommu_dma_get_msi_mapping_domain(dev);
>  	const struct iommu_dma_msi_page *msi_page;
>=20
>  	msi_page =3D msi_desc_get_iommu_cookie(desc);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4d47f2c333118..69ed76f9c3ec4 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -638,6 +638,8 @@ struct iommu_ops {
>   * @enable_nesting: Enable nesting
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
> + * @get_msi_mapping_domain: Return the related iommu_domain that
> should hold the
> + *                          MSI cookie and accept mapping(s).
>   */
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
> @@ -668,6 +670,8 @@ struct iommu_domain_ops {
>  				  unsigned long quirks);
>=20
>  	void (*free)(struct iommu_domain *domain);
> +	struct iommu_domain *
> +		(*get_msi_mapping_domain)(struct iommu_domain
> *domain);
>  };
>=20
>  /**
> --
> 2.43.0
>=20


