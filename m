Return-Path: <linux-kselftest+bounces-46081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C71C72B9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 21A462E72A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A630AAD8;
	Thu, 20 Nov 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkzTOsND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B703081A1;
	Thu, 20 Nov 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626007; cv=fail; b=pr4akQsr2vUPqclnzQVN7A+0IrziTPfzB5jDGoaCtWlsnxpIdM6ihc0keF7tq19XuEDgeXjk8r5NNwTnoLbcBdUvUcJ4X2D2RlbbjicnwC02IRzwLvwI6+PakSOPbatprNK5UjibTX512OQj4inkGodHQvIemvS3bfChMgJlydQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626007; c=relaxed/simple;
	bh=gGYh91OZhwsiS9PrIioKeGHXwQFWdWW2107okEL33sM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LavMyqa4vdcoZaeDC63KkzPD0atUKZnUMcqxwhOo4/dr+TqkRWecaGsHYa3aRF87Ed1TohUZ+SQOggjBecXS8jUXWZNpiEe9XIZUCKH5Np+i/Y64Vf2Lg3/ofKCXSyhyqJrI1qUf/iU71B7vQOx4fbM5lFtq3pH8DEyR/87rg80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkzTOsND; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763626006; x=1795162006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gGYh91OZhwsiS9PrIioKeGHXwQFWdWW2107okEL33sM=;
  b=XkzTOsNDVtr3P2U4NZnltsWkygD+AomdfpljqPYyaAw8r+g9d7L//jwX
   yp/PH8oF+JJZdbKYPb++WIOs6BI6h6Wl3cw+/5sqLimmNkSJXLuNs89BS
   5ICrcoLVcUW91Omj2DGlURvfHL35lXF0IA0DumoL2Fvz4Wdq3rMb3Nm1J
   SdkpoM8u1J+S5IPjAzORAN8PTPRmFlI6mkHLuId+nDZswCKq9LiqA/8jw
   0fGcIfWAten8sw9K6tgtdUaupzqGeEaA3YQX79tRWB1FIbq8jQ4Lsh7IO
   aGKUQ7Cbmnb7DLt90SdBLrhoBeC1pNYlDog7fuz6gt+b5yT5XhE5xPdIP
   Q==;
X-CSE-ConnectionGUID: 9JourJT3Rmer35/xvWG0DA==
X-CSE-MsgGUID: kNiJZH48SNCt3lcVg4WIWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69541913"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69541913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:06:46 -0800
X-CSE-ConnectionGUID: oqUnlRObQCuqEtN0gaN1uw==
X-CSE-MsgGUID: jYHMeA4pS0G2hSw7b19XtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195592244"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:06:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:06:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 00:06:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8fG/qHy7FI4kSkdqC2pwJ0Q59he0Uk/xA3K7j1ytQ2s+Z7xVmjnTnWomgHs9fOay/TCxhOYXWrBrqRxHBuKLMBS0CWNoV/XHZUD0mTPz9WHaSpP5dW7wKZApEJ8bfWfzyXauDXTZxyPEglaZXURULbE7hVKOj3XZjAIto3arH6IhvC1I+tdQdc19zPw4IQESkqgkW5q/3nULnKdZ2v40o+tZnKnUoROz3J4kjWKowzjpAaF8CeDgQC8n4UgVwaEMWTSI/hA4thKv2nAC74iwvevdRJdq5JGBDuycGxYXADs/A0YmVl20TRd/UEkAzcm1UsGtQlqgc26wfhMYvhAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=easHkekooNmM9D6m/BxPz3Pd+GgEiIUlp08fYUCsdC8=;
 b=akBGJLSX0l78dxzh6On95hy/6PjFfRTs02zX2QmSX1OFH9TgzUJxoN4A0J/fofoWkJl0OcN7MV1JETquuaSJXNtY0EiaOQ0gnVssD5Jq1FerGF03RkVq6ipPLVl7x1OHi7OrGLP7E9XwMa+n2dsBLK3TdS0gaFTBkYP4oZstwUHeb99/OXBHBDhrqY3oXGjbt5kgOTJgOh5ygWV+/bDEwAIKNGtlSD1BXT5yMiE/YTxgdS6vj3V2LyL1PJVP8/5jKnN9qtwVFnf2vmp3pNaVtDPxt0Lu9R8yDH5MjUkkaV+w97i6t/t9ZNIcd/wDiLTQ+oGJLmQqY9MjrztlxwOtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:06:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 08:06:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Simona Vetter <simona.vetter@ffwll.ch>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: RE: [PATCH 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Thread-Topic: [PATCH 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Thread-Index: AQHcUAaTASnDBj0AFki08REbkmf1H7TnnacAgBFEagCAAmcCUA==
Date: Thu, 20 Nov 2025 08:06:35 +0000
Message-ID: <BN9PR11MB527647A3F324D841A5BF1B728CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <9-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aQ5L/NXA+pYfK9zf@Asurada-Nvidia> <20251118192512.GT10864@nvidia.com>
In-Reply-To: <20251118192512.GT10864@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 8b2e2a4b-46d2-4b58-b12b-08de280bb9bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Jp/T8MDHial1q/ljxvglrg7pmO6RYFlneH9K4ZwDfrSuXwEhFtO2+GS6Co?=
 =?iso-8859-1?Q?IYrwl8gK7SGKmytXDZKgyqX9ZCgsJAFHgf4paWdJyblBX8OH5QTrcp4rvj?=
 =?iso-8859-1?Q?Vw6gm9yrvS8Kuj4j5k+mpZkXsKq/ESpwbLAjQily6BJbX3KQfgOXaViBw3?=
 =?iso-8859-1?Q?m++9Xk2LNW/1MfBFARigVabfHCYmc3/IN3MBeAHrzFxGrNksVww8R0hy1m?=
 =?iso-8859-1?Q?l/2YRYSHsI+HQSVvhcrN7icZN010xSQitkPN7F0AG36+4SIRSBjhAa1xJa?=
 =?iso-8859-1?Q?e9KAvo1feVs5+haeflJAbH75zXG9lBMC/0DGMW7xxDme6nTxAqU7C6obVI?=
 =?iso-8859-1?Q?VOILw+3yJ5cYVDuSLQUQaqzOCLoUBavRYeDU87LSo26mxbWKnatt/c5eDK?=
 =?iso-8859-1?Q?fxctQ6JOPkgWmc0LvamCiLQIePrMfIpPyPSYZ3nMQjS62zaFaskEHyLJ8Y?=
 =?iso-8859-1?Q?Gra/3/dwP1oANbJnFjIRaM70ZugIWJ57T9xWAtmO5PQnj+vB0xSNga7JNP?=
 =?iso-8859-1?Q?5q/L7YEt6evWq7NnAHcawkS+RqrazrvzqOG5zTsoMWNJzzKitDylPUaxLM?=
 =?iso-8859-1?Q?1D2Hmw1fphzjb8ZK+BEG71V8gy1WyoYH70aWV5l9ezyUZ3JNGsTI0oXjKi?=
 =?iso-8859-1?Q?eMaDMXFKjeGlMchsMHkmrrzJUje12J/r40V0Kjas+/471zJwPvi5NDnl+w?=
 =?iso-8859-1?Q?9ogC+bM+RyqVglvSRAIoObyaWgfU3/iE1ca/q8iB4SUIj3d+BzTLdvjGxH?=
 =?iso-8859-1?Q?guEe7m2Jh3rDl/7wwWVd0noRiXP9NiA05QQPm0Aak7pETURmAjkSE4cizb?=
 =?iso-8859-1?Q?TYI1mJj3LxVxMwyRxXNwlypNREtVcgD/XAYMZJ+S3IMJfdkqKpgWPCGJkT?=
 =?iso-8859-1?Q?WIpsGD5MGSkHXWxLeY/b8gXhEIzEv6FNyQKe4vKSfOOQWLJsZP9zB7yjOs?=
 =?iso-8859-1?Q?S8e4JWSfvWI1jnHZYlpuCVi49MS+uq3aL8mgfV7H71K1XIotrLM4IrZpcx?=
 =?iso-8859-1?Q?z8ySZZUrDyIencbz5GDwXKjGxG5TPU19vNM2fS1z+lsLoYz9esD1C56GP9?=
 =?iso-8859-1?Q?MC0KVwmTRtDkpajp/n9ffvMLmHRn0syxGTkBI0DkqQLY3wR/zQBj6r8xBN?=
 =?iso-8859-1?Q?PKhRCwIG8ON2lS/NFYlYQf5wgey9eIGG8jtu7lcjdVhDZlUEKt0W0Bf+2P?=
 =?iso-8859-1?Q?wvAV/gW5fE2Pt4ngkSts+HGUuttCzF90dfYj0VhCtcy/+k1TuUgVquoG8F?=
 =?iso-8859-1?Q?ywk3swQf9K/P05cxojOJDrHFQKANVN5QZC+k/Wr1ATUYOf/U2KTRP3H8GT?=
 =?iso-8859-1?Q?jpDcPkUBtzCJ/sSS2K00jNN+cB0cbccXE9DYUpPYzlyY+Cla+GZ8gTUkkI?=
 =?iso-8859-1?Q?fQenj2+EEJrdUdcbFPmZyGxi6OVlK/KVSkW+HbL4ETY/yebjymxizFIMiD?=
 =?iso-8859-1?Q?OeHVD03R+0vXc4PLOmjrj8EeaMzZpsJJtUdgO9u2Tx+bfqfvZYijzA73M9?=
 =?iso-8859-1?Q?vnEFowekdA2VM4PM6cDaq8ivkUnwaWxrq/I+yZqtP76V9wea/Qh/HIVT0m?=
 =?iso-8859-1?Q?yINjVTq0xA9jhHXFU06fYZ0McBqB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OwurbRIYJAsjcvs1EtHfPLe8To2v03g+bdhjb3rZAoa8NSuhNmKQNAXwsq?=
 =?iso-8859-1?Q?ayD44I7VLNeWI/BARIvAOvkSWQ+xSVHBko3Oh6CC/g7H7KSUu4ndTGVTL/?=
 =?iso-8859-1?Q?0U/hE3xguQtNqDoks6rASMJQ6GiCjw9DRw0SvFrNo5dEOca8wrlElzLrwh?=
 =?iso-8859-1?Q?vtg9B21CvRRFASLYxE6qPjbbW5K3lVyRTBgh9j3L6JnHhbY5m1V5emQBgP?=
 =?iso-8859-1?Q?GOVMD3KTdu5FFlVxoMJ+ZmBRxJou5HHrlSH4aUNJdpVas7Fv4TOJvW1ViQ?=
 =?iso-8859-1?Q?be7sirV5V5G5HPkaViAKvPkI4zWxvPsU+GjRch84dkSeQPP0vUA3xxHKzx?=
 =?iso-8859-1?Q?ak3QVM3VMGro2ufAHKkD4rfLamLT2K84H5ZSQM5uiu8/u8edijh8Tvlm9y?=
 =?iso-8859-1?Q?tyUuBzox2CeB9x4uf2MF6SbvH+/6IiOwwZzh1I6iGITaTDdSaBAqn7Sy1M?=
 =?iso-8859-1?Q?v0im07ej3myGSQz/88XMxJIm7dzs30IKBNmFWyqwaxyb68MGbA8Cd7cWBG?=
 =?iso-8859-1?Q?ThBE2wVWaJ2XcNxrsWiS8ZanRK/ZpPQ9e3jFeWPsz51DNDVG9jPiJonESQ?=
 =?iso-8859-1?Q?dX3ye4KumSbYOxfTpC85H6GHbgexoEPSsoQ3NfT2vKu1xSp/NwLUqOVm3N?=
 =?iso-8859-1?Q?UekPQ6jj8D511IkoiB91wlkT2rgKncKN99E6JBeHpo/JEZ4Le41aGUYyIv?=
 =?iso-8859-1?Q?+IoUA6DvxetVr+ygiaXvp/dMFvqHd+loWMSi/59QhinO9fdOJzS74AAtJi?=
 =?iso-8859-1?Q?nNAj/95mUfvguv6gWt4alleJXKHOV5Ujub2XECgNOqYM4eRcB917z6nlHs?=
 =?iso-8859-1?Q?pnNisUViiSQDQrE1WuF6I6jb7aL6VFQhlfCZ/ISCV6FDg7JbaJi3Eg5BfX?=
 =?iso-8859-1?Q?AH52doso9reWQ2vp8yYSSwSvknuwnvy06R74LTksP6QSgphjt/pVDsLbgF?=
 =?iso-8859-1?Q?8uxI5QR5+eOG8sgcNyvZYx8li/8U6cle8+nLavDGk404JePqUeADIgotov?=
 =?iso-8859-1?Q?p/6TqGDw7NFWEFlih3dE8btriQNpEdaPuSy9sLsMKhZGihbtyYTAiYJU9v?=
 =?iso-8859-1?Q?JjwtgHxWm8qYa50418kxMYiQELQUIrgx6AnNvzI1Bxn84I1okMwfJ+gl2a?=
 =?iso-8859-1?Q?Dxbx32NFQKrgNQqQypu9NHJcoZlfQ3TOli+IylaFuslRoxrEkAb3JVqgFj?=
 =?iso-8859-1?Q?iajh0ZAw/JEmld1nYxvphvGY1yGldpi4+GV7syDz/9WlcIPpx7UWEu1fMi?=
 =?iso-8859-1?Q?L4wa9Ak/g1iIIotoA/+h2LDnBjz+x8eKnt3UKLExuBl18cgzEkCC4hpfAv?=
 =?iso-8859-1?Q?08YB4HJeGz9qAYckwcAmrR039Rq08FGOLKxUcU9urNvl+MArG52CyqjURn?=
 =?iso-8859-1?Q?MU1Iq7dps8eQhQhI03zOMNgWSriBQzMjr32UWjQeydv55cUmqnkOmKCPkY?=
 =?iso-8859-1?Q?2b9avRiaUtbUWJrl/zsMAohxayKjd3fJom/HfkR9f3FTlK0KxKB/moagb3?=
 =?iso-8859-1?Q?5m2Q09TsBplBHPltHOdpq3e2EzXn1M14nRTxlJJjPysVX3UcwtmK2dDC5E?=
 =?iso-8859-1?Q?aNeg9JTrggddjR8XDnZnfmz8nygfY3FUtr49u9DYjgWumxe2CMOKvyBFzB?=
 =?iso-8859-1?Q?0BpwviOzKpRM/wk0/YyTBWncPJok08e7sV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2e2a4b-46d2-4b58-b12b-08de280bb9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:06:35.8610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX/iCWYNMVPwthhfFTglq7EdriRquBuOgvluF2HxD1K6DoS5DvPPRDp8PnEtM2FlbvjGh8BaB4iGDddQ9dUk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 19, 2025 3:25 AM
>=20
> On Fri, Nov 07, 2025 at 11:43:56AM -0800, Nicolin Chen wrote:
> > > +static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
> > > +{
> > > +	struct iommufd_test_dma_buf *priv =3D dmabuf->priv;
> > > +
> > > +	kfree(priv);
> > > +}
> >
> > Missing
> > 	kfree(priv->memory);
> > ?
>=20
> Yes, thanks
>=20

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

