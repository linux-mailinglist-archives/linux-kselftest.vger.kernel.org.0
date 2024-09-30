Return-Path: <linux-kselftest+bounces-18585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190B989C25
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755BE280BE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38AB5674E;
	Mon, 30 Sep 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE1p3UVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDA40862;
	Mon, 30 Sep 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683397; cv=fail; b=uSRBulJr0E/fs9spKKCFEfKM05q31KzZ2+Q2U1PRcdEZvgFfivDVwldoB8uRPcC5Kia5zT0FmeG4OiHAA3s8j7rX6ukyg1DKy1z85Py8Gxx7tKf3a/4mdOit+77Aka/PHTzxJdvNHdgRyBjS/YgxSOeEwW57v1f1eqBpjow9m8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683397; c=relaxed/simple;
	bh=6cRO7ACpfIY+iGXdtxvvJ1RmMS2bNZFv5RKp87PsAjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CpEIb/5Wiij0RtwfA+yjkLWwIHoO2VF7C+0EnrV7rMrEXEjCqHGJsdEI7YRXXy8SgkWB0Iscfr4DVa5W3rkmxwyFt+BRsFnpTo0qEnfh2+/k2y87Xxv0W0IRBpvPBh5jASFfjv/65KkugbLN4R0zlfoV+gZw4Bzjs6jEOxzZwpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE1p3UVu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727683396; x=1759219396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6cRO7ACpfIY+iGXdtxvvJ1RmMS2bNZFv5RKp87PsAjc=;
  b=TE1p3UVuEvQf8n4KOWQ247skSWQACLCAH2pE+BNSQ1sNIUiazwSDT2Ej
   wigLFKK4I9EOIIvB3C5mGkeusQHj85W3A8e1gN5NXD9E7+Xfi8YnPWvlc
   Kxum+C8XWcy6jd+Uugh+p5LNic/bi7sRExJRJQnp/Y33l3AKBVkZjNrIg
   LoWIpMN99EwIEhQXaYPNInd71BlU8fbti6xKgC7Kzd6IOTH5qwV9f1Dw3
   0gbG574qJoCg5YcpSephzfTuDyeztxeYMMIHtbvvj/4ixgZ2jE0Ixs7CA
   EI1I1uqle2ZIFB7nYfjkGsMnbV102R4wMPG73NJk2FvHJrpOKi10sxBNL
   g==;
X-CSE-ConnectionGUID: bS6JxGcBRAC4Zon+goQ3gQ==
X-CSE-MsgGUID: fjpqReXTSwaiCiQGQ0/VoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44274954"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44274954"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:03:15 -0700
X-CSE-ConnectionGUID: jfXJlAeNQuyfMSBrXt0MJg==
X-CSE-MsgGUID: 77hidakgTqyh5FQ0xK5YPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77293470"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 01:03:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 01:03:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 01:03:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 01:03:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 01:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwauLeOZ+Lz4l8eFRbDXneCF4wwRpb+HAdtpMSxooQrkOpPRsx1UBLLU5T/CpKScl6+fgulIzLNIUAe6/PKEnVcQi5+eLZTBll+JG/hGjScyDnCVKq4JpewtLGTf++wlDAvcuL3372nkh9Dh4gqT34wMi+LSHl6/wqTguvDfr0/4hlal5FxsclNU3SQaHvHy/vi3CJUPBVDVgChF/rAFK1UrzXe5o99lztcxte/2JLt4KtNyaAEwozI899lslqw+kaYHe7RNf7eGQ3/tONJbCwGj7kP2NjHuGCL+lNhLaLJ0/wdTOavpFL3kTZ3j/L8KiF/DhUY6cQi3hBvwIreDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cRO7ACpfIY+iGXdtxvvJ1RmMS2bNZFv5RKp87PsAjc=;
 b=VCX1WNI8VJBh0wwg5+qVWwYJJn5io4rzByCnocruaYteasRFLG6Shgkjmb4OAgTyHVsaPpYGiS0k8A7+jYCWxU1L4rOfUUGIjgDCpP8NNAVSA4gyk2J7PJQ9A/3CPt5YO5ysKM6o55jDHFdOE5SNw0Ikp6u7AC8i6rmj3gPZxD1oTrT/g9kYTQ640wSyeZxqMxmEGRlzbazYo2B4JyiBIcythH4ZoskDo52b/QxfjPfRXx8BINtrgxUglW9v6nMdPyQXqlgobjRV7Mbs6V6zfoRBEkb+lF0n5jdIrEtzsGmeeWGj+3tg5mXyaw/ZaoyNeHqzTMT8QBLMMrgplMkfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6536.namprd11.prod.outlook.com (2603:10b6:930:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:03:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 08:03:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID
 capability
Thread-Topic: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID
 capability
Thread-Index: AQHbBRYrZYVr2aQ12EC4Mt6ZadMIerJwFB4g
Date: Mon, 30 Sep 2024 08:03:09 +0000
Message-ID: <BN9PR11MB52761D0961E0D8BFA679F2308C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-5-yi.l.liu@intel.com>
In-Reply-To: <20240912131729.14951-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6536:EE_
x-ms-office365-filtering-correlation-id: 020518f5-9188-4581-d287-08dce1265313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1YYGjzxx03ccBUWoYQTO0XyPkUsTNleCxbfMpSeALogXNBELNuqolVQT44Vq?=
 =?us-ascii?Q?hs6/oVKc8EnDt+80f3ETSZ8TZPAro5aXrZhCn31LhtKfG7INWUOwUJmtjFUP?=
 =?us-ascii?Q?c67V4VZ2XXkkErL9qiwyUYvbORVK4Iwe1cgbWpx4hNrpNg806olnS60cAdZ5?=
 =?us-ascii?Q?uErAKjdnQoPEoxf1QIZlStu/qO+fTP9yfY5jbAOHJnkzWf7rANZQZH551HRA?=
 =?us-ascii?Q?0H9KAq5uS3edkIRfel6dV0z4AvjNHhztlC6+IVx82JWhPDuvKuVyM6r/FNQf?=
 =?us-ascii?Q?zCCC8MlovYxlKw21ua4M+9ix447UgEpacKRU3fYFnQIj5HrnT4bq16i/qYoe?=
 =?us-ascii?Q?fcn9WXZt8r+NXjxR+6Hs9kp8DLODgKQxeQpWG/SNr2qvEdSKXOEFtCxL558E?=
 =?us-ascii?Q?Nxp6P7Y+nrynB1PfDjxba71TnT6tT9INWbVZluQ7MZe/yzzQ677e/+Zl3gvJ?=
 =?us-ascii?Q?Zc2ZDewB8/0YBCMbNDcfvEhhy5Hb4f78uzl4XbKftzC7OsUcZ9yJ88qJ13fI?=
 =?us-ascii?Q?4l2qoBelVfK6giU4C6IKkcKlpHyfKbHDqg7/Xt6dRHPkuO7Fa3g6vroHEvdB?=
 =?us-ascii?Q?YVCNrGjm3AjnChnLPo9BlKvD9vVFzgOjUScCqice2rBbfdwY0h24Mn/p02RY?=
 =?us-ascii?Q?MbamLUyQ+G33rAfRdhHevKO8Ad0da85bfb/GZ2DuRnW0gCKg4/9w/5hUQUfa?=
 =?us-ascii?Q?OPGDsmivJNOQovNrRyVAay33PzCQ4O4ueKPJVx9yqCrDHvbqKCJqCC5DFOaG?=
 =?us-ascii?Q?wBQnQI0IBricUjx/2QeTGzpdb5Z+wwTiArFlYE86mS0BkO4YXahQbq84IUNk?=
 =?us-ascii?Q?deMWLv9DALIlIRyhEUACydN96OZxfsUvI+wPOGOkHqVyv5/nJ/bfMNbVy8rW?=
 =?us-ascii?Q?dcG0CY1pL+Azxh5LUSI2rMTGGqhpy2kd8sSmj+NLCvzzUXOjd7AX7dZgPpkb?=
 =?us-ascii?Q?dCbA0JG2ZwFt33ECDdI5En/zsH5dREf6GSAPS2hGGVdm9q4WN8n1vVMGfgF5?=
 =?us-ascii?Q?otXRJh4OFkkyewgt6HnH8q1C5JhEkc9B+wPqCjhqdEFtb3ozpQ2TvE36Vkd+?=
 =?us-ascii?Q?guk46eIvIhZfCLruufdNw/f1rcBNWJDK29wV0dgQo0M3qNICVBZyQ1BK6/B2?=
 =?us-ascii?Q?XZokGJlk+Ug+k79RLH+a2GDdxIagAoPGJPjKtVeQLNxvfqc7B6vrZe1shPXK?=
 =?us-ascii?Q?UiBiQcrTlQHgCPQbWMEComQIl67iVglz9kKpcE6cQIxQqgyXUlWOi6dj3H43?=
 =?us-ascii?Q?SiYpXG7HScpqs1I4eG4KI2anlTe8pJHSt5Ij6bP+Rbsul9+5HnYTXwx94DLg?=
 =?us-ascii?Q?k9LSWlLGA18PQVpkG9Qp9EtepG5iUON7S2j9KHlkkB/xVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vyLecmorfvS5fLj7Fa1ghNbvGV7uFpHd/7Z/YVmVM7QaAFzbMgvz4LspOjL4?=
 =?us-ascii?Q?1C+LJz+Fh/6ZwUsO+tv1qGcyefZNSVZ9PTKbsieErS6ppyVQ5qWaQXLMgwlu?=
 =?us-ascii?Q?vBOlWAXBh3BnJ/WfGnWjcI0eX5xTuE9+eQow1RXZNzgGKjpteeVQuizbAgRr?=
 =?us-ascii?Q?oNh1eHpghihIDoDvTQkrMtoHb7vC3xM0SjopQzJSVhotQoOHiXTBFDmcA5/j?=
 =?us-ascii?Q?sTbPzQ0x3nGN1mpIR+kTwE+hVJjwH7fSTowv2HuuZQHpfKqhCapfW4SkHalF?=
 =?us-ascii?Q?wo7c/A84VWsK7suCiUesUSMcMcqCxXWyxYOKwb4i9n2a32KgB1xDny7ZdxIa?=
 =?us-ascii?Q?ciM0Sk5LctDMfQAK7vAaQUTgmaRnfZy5BXz0mwj5Oebnb2/Tl/OWx24uwVFj?=
 =?us-ascii?Q?Ut7pvrqnbs/zETw4koBWjiViJyKI7LbZC7B9HgWvKoAGBvCfaLXppcMtyYnc?=
 =?us-ascii?Q?CPtvCKQX4vch78eAHH7HciUGMwQubD3dgMT40m3wFEg6tuGT/+VgZ6WN2sC7?=
 =?us-ascii?Q?X50CWh9KtaGf0nDZ2YmNtfszFmCNDl0CBLKAm6/fdRYcF2iybEDPmcMLFB8n?=
 =?us-ascii?Q?e5lkdkAanMAiGIWY88uKuUGRaUNCtfLh0U3UzNlxfO7RWBwLsT72jy8UPRjK?=
 =?us-ascii?Q?JdQ/VJdEXRlmRUptiWtUjYNS9nK4WNUkum2q33lxH92X8IWFg80p+UtlCif1?=
 =?us-ascii?Q?c2ESR7Y0dLHc+X5nmoKQMZwjCOKiwckQZET4ZFv47abRbwv0LHUNQ4HEs8o7?=
 =?us-ascii?Q?96QdHzjy6r4GC4DbC1Uu3zWEwLKm8n3/UNe9tccHhwhKHVebhzd4Tn7pKZj/?=
 =?us-ascii?Q?mbZuW1MEi7r3sbp6XYXnaYAnWbR7dFaGOV+Y1pLMW3UAE5ZhquODmkFUGigG?=
 =?us-ascii?Q?646LbKSwuhiQvLzCHqX06YAaNhdsv2qAml7Wm12BbWEmeex8aHSRC/0q4Cs2?=
 =?us-ascii?Q?GmqVIr1zyy0FKVZ6zeLgnlhLxeSgw4pA1zpZBuG/aMN1NFe4VnrRf8Pev4ES?=
 =?us-ascii?Q?/japu4XGatg4RaJmKKCz0pGH7QotB9n1cSKkCbJQJvzS8PWIFKU1KeY+b+2i?=
 =?us-ascii?Q?Rit0Tk3FDbwjZu6ug8g5ZRxegfPqJ2zUCEfcNk2jB+x2EL6PkuHK7cOAwx4c?=
 =?us-ascii?Q?iq73B3NUYQ3XipCMYOFYmWzc3Tx0tPev/IvTCtJp07DjzIEBdXUXrrwpkUpl?=
 =?us-ascii?Q?ljq4yKRGd1lWGzDv9lsLly38FX6LJ3caM5gNcS2MGs8MGU4wg5nVKGa3CifZ?=
 =?us-ascii?Q?Xv4zYYE39BBbMIAtzLRnBKeDUZqbL3EWCUMict/QpT65IA1TJRZdLAydcpe+?=
 =?us-ascii?Q?Z6/GFjuHTIn1ZgzGfzdEVAzdpZ3NoKPBvaZKE5+6yd3Z9IYUgQDRXtxWIPrg?=
 =?us-ascii?Q?+xDqRmLYKyYAjbsXKRnKV9h5YvgwNg3j7uC59Kk85OTMD0aYTPz1pVWt4EtE?=
 =?us-ascii?Q?5glEMvCmJa0UwvIPu21m92ds7wS90Ky+DSe2EpRGJQayM5wjcDDiCGTvJ2qm?=
 =?us-ascii?Q?h8DFIASYP6k9u73xJ5hKQVzhqmfaWHhCVdZLkN/wCcv2a11hYjYU6sS/a4cW?=
 =?us-ascii?Q?QFApNWPMchCF0VpupZ6KXwQVIjCk/AYdmoVzLcSK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 020518f5-9188-4581-d287-08dce1265313
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:03:09.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxnXahRNHRaLGqyMLrZpVTF/8E/wtCNzMg3zPpXcttitq6wa9q6136SuZyiQD9tSEaVZ1MNbOWg9bcXSaD9fXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6536
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:17 PM
>=20
> PASID usage requires PASID support in both device and IOMMU. Since the
> iommu drivers always enable the PASID capability for the device if it
> is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
> report the PASID capability to userspace.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

