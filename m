Return-Path: <linux-kselftest+bounces-18574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16249989B5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E33828226D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DDC1552E1;
	Mon, 30 Sep 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf1xPuHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501D1547DB
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681065; cv=fail; b=c56ES3rpJpsGNEahTIiDHOVP2n1AeaipNbt6GFCHNs0qW9/Q1hB080kPBLBXMLNxfLCiSApuSmTdsKbrgMCenTt/oXsLD9uoUvmCFTGOO9kuxRVBQsLOtmhmhCy94ljJqd47XAnlCY7x+jqyygfTfme1eNtMTXjDYopVuGVB1fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681065; c=relaxed/simple;
	bh=Qa67/m7mJnxYiHMVDXsflEGVTWEcM+Gfme/R9a/D+fI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZ/HMgSNoMud1b7Wy4sbRKe3x53Rf9iLyKuiuGc8kdaQtYQ6bdT5nEdunOBpYDF++wXtFFDNhFXMmNWugcXgdkQa4fnEvWw/Ovq+hevPb46VnrZBbJ2A8d85BTOdOdREpt5no6MM1GKAgbyAa41Oe9S4FWaKAzT8QrDkA4CatjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf1xPuHA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727681063; x=1759217063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qa67/m7mJnxYiHMVDXsflEGVTWEcM+Gfme/R9a/D+fI=;
  b=Jf1xPuHAwU3NuiOptqjObmn9k82T5refXcBxt+fhr+lkvV5W9MI0DHIT
   nZgBeg5+9KtGPINZB/OHGG24OGpkYr1QlzASabGZTtMoyy07aWDh5wAmq
   blzMjIprI5AkbQmOjO04BlxPP7whJVOI5OpLVbXb94x2Ga9R1E1P6Fubj
   lSCnEB4jhv/MbSxNYE3KMzU8lIpNW3hnyuKq0psyXXbgM8KBw5bzl3Rvm
   9a0bjGyxwNdpQy/PvN/qL48DAAUSI6WDU0U9dK0krbgDaJTg2wveuUakl
   nCraBsAIVvC166/7fM1JeGfxTX22x5v/ryRo/WJFXUKdg0mu4QSKnPbxv
   w==;
X-CSE-ConnectionGUID: tP+NP1BUSMK7eyjrwvm28A==
X-CSE-MsgGUID: mrckAmyKQtuIT/XVKjt7yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26631308"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26631308"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:24:23 -0700
X-CSE-ConnectionGUID: eX7x0osOQMeCP7XJZ7N5HQ==
X-CSE-MsgGUID: 6QmXjBFdQBiLFeSatDFlkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77286282"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:24:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:24:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQZ/hA01d9FgBEpj9JC8fxrVNbXX77a1buFCV9kn0M6UR7eN5j93J1yC1ymv+O81oBoMQGZvii90x7r4LvmMDIf+nxpwYhx4qHIJ2HMYdnCYcojpg0cYE225HS+MWh8OcH/fRb918wCldyXsM4say2AzciyUJBaC011IizrD/U17/i8UxGZSpUQw2+MUmKiSOryBEDKh/uyz8z8zb65qo2qzCOKak1KkwLJRHNPOoR5JCcLytZiMq7gYWwQ90z4ST4r9UpFho9geiOR96KrXiIb7i0r6cFuVSbJPSGFPEfXN5kKmw4qUndM+6kQBd4dZ1NEC7VeDZQFbiccpNY2t7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa67/m7mJnxYiHMVDXsflEGVTWEcM+Gfme/R9a/D+fI=;
 b=WPsjBcBYMz0Lg8XXo1dTlJU4C0EZ3tuiVdxhmBwg1DWS8BB0eXW5USLV3JL8Sq1H3oBNgdHT+2FVNeqaBPvklxGoeiXoHyokujg20LWJ+Oxu3lGY5buNYzeOQeho5+5CLK8gxObjm1F43fmhzgojla0cDwxvv/NiOpMSbZm5QFViVxLDgVss3VV9OwjkY3ceOpK25sRsugjPbplCwn+GjYSPtmb+rl3sguQj5b94lTUQeEe7trch3LvAyQHu9MbdoxXstcQtPysMBjr8pkIFM6TjKyLyc9VE6f3pHwWbjLaZvAWNhw/mJReQZCF0cXN3H2IP+VXzg98EhYcMOF/28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:24:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:24:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH 1/3] iommu/arm-smmu-v3: Make smmuv3 blocked domain support
 PASID
Thread-Topic: [PATCH 1/3] iommu/arm-smmu-v3: Make smmuv3 blocked domain
 support PASID
Thread-Index: AQHbBRSzaKFfJH1jnUC4nJJ4NHPrxLJwCUeg
Date: Mon, 30 Sep 2024 07:24:19 +0000
Message-ID: <BN9PR11MB52767D80BE28F15C797F36398C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
 <20240912130653.11028-2-yi.l.liu@intel.com>
In-Reply-To: <20240912130653.11028-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 1271cf3f-387c-4e3d-68cd-08dce120e5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mKexS48vAxrEzbFXipZVZpshbH/SnJcLIR7YgbK/Bp/wevr4Lq/A8Fd68+1g?=
 =?us-ascii?Q?JS9fEUVIAUtmARQPV9SPMOcGnlPpQFECUy4V6VI+jwiTOGgiX09pXg6T1jfz?=
 =?us-ascii?Q?mucQnVHFBttBe13bR0t4UuO2/R19kIswfUjOSyjibsOEoTkYFf935J+iKBLN?=
 =?us-ascii?Q?sTPqzh9knDDS6BoS7hJMkUeYCX5ZFbmnTpC4kcTRxEfAtWV6ridjh5fEst4k?=
 =?us-ascii?Q?mdaIDtysYwsCSLBchzezcMM4UJwRQbfhQW1hsBCVr22NjKV5o0buKSLEMnii?=
 =?us-ascii?Q?2LoRJfLYqsl3JztgcnJbksrtJzO1Gc3QHapdSk5wxWRYrcTnKtSCK2CyRZ2f?=
 =?us-ascii?Q?XR5y2iGUvoqEMhWzFITK4tTkAEEOqRzHE45TW7UMTwDG0zYsVgEmnJnRilPQ?=
 =?us-ascii?Q?CyQoO1+RNW/w93qgpaQ2Tge4f2hGF9U+EEdiyJtIvg3LcSD0216myM1kzvsN?=
 =?us-ascii?Q?SKNca2VqTlpV6PQ0Aw2ghfB0Ysv9wcUVOVECfAwDqrlTwGsXcQM9/cu5dFtD?=
 =?us-ascii?Q?WmhmqEFgFHNBXSVrLB5EUE3QCA7Iw5uvSuhIdxHAWIEBSjg7B2wGOhplZHFZ?=
 =?us-ascii?Q?Ymyr2g644v8hPkuKsc4T4oDMdeffMJbH8a01yvBbNZtBYspAzdBFP1SQRUCn?=
 =?us-ascii?Q?fZjh+R/Nscd02qs4mvY/kSXPXsbEr8mNvnugG/y09aT8QwAf8rTEhKrZSngk?=
 =?us-ascii?Q?oUtgpsC1RwjvU6hIdsXk+wMzIOP0DjBAqHEux1cRAtmvYDsY85320uUPTPAD?=
 =?us-ascii?Q?JynKWib70YTCTMbU/9hC9MHzz3yN1JPOcIOWkpeO+qkaZqINB1/aqRLnhW+B?=
 =?us-ascii?Q?0TFAbo39eoEs86iEpeJjo9zzbxiaP0cr43Q1qgU9NHUFoEbqbnrFsz0kX6hR?=
 =?us-ascii?Q?nTlDJCUXYSa+t1UFJCnH9LtdlPoOEJZrhRqK9BRrAPvv3NURo39jGZdNQ0rx?=
 =?us-ascii?Q?lREw6mYU6STueI6qtvVYy6k74yEfOp4fc3dzXClTE513BL5Uu/OPnHA2ohLD?=
 =?us-ascii?Q?igCX9hhZAE4gIMnLMaXNq5MDi4gdsSfJsS9/agWVXZSqZR9FhMo8tV6Ghfik?=
 =?us-ascii?Q?FnAs/NjEVl86IT6ySSbBkUFLuNsnDaMUF8ddZwwBsVcPykcVFiQ9qQZFbejS?=
 =?us-ascii?Q?7hC8bb8kLu9DhCW3761AVretFgorbOwtjeF+bHbB8rpuRq0groXcf190tL2K?=
 =?us-ascii?Q?kKL//EdiA2XaxXS/WeaO07aGC+LgEFBa/lkdVpNS3C+Zej3pIYvKm/x9CdeP?=
 =?us-ascii?Q?s0rLOfmdtr+6CpSPE+X1H6ZjCVj9mW9maY3XGva+2Ztpxg8uZN+POx5QrPFI?=
 =?us-ascii?Q?ERuRCjZ8LyoZ0BIG3+PdHji6kQBx25yybECZn9B10x5g2QmLuuPKxtE0HlTA?=
 =?us-ascii?Q?iEzpfq2WLyqlYO02/doMQpR4sSkX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cd4FSdLaWFrVfoOBNOM3+ufTYKFC3aneYZ5N77Ipr0hVlfIZf3yz2LZj9B+y?=
 =?us-ascii?Q?b+rXTaiWDY3z8YHpKKaBLaJPlZ0Py9tTT+IjqSgaO2otz0m2aiGkmz4txK9E?=
 =?us-ascii?Q?NA/RBrBRhueD4xm3uZjGpd7yWauAB2DmZH9RaueELqNroMlh0pVKfiOWKddd?=
 =?us-ascii?Q?BF0amuH9R3pKl24eiPeG782372tZa+HMXVCnZ0SjwRR8EtV2I7+tMPEOM3ks?=
 =?us-ascii?Q?oYJ9xeAMQ8uY9gLvUKcf6zM6JVTsE4BQDMjCjCZvIpjWOCwobqXhB7CGBi9F?=
 =?us-ascii?Q?H75X43CW4MXPlZ5Y5Dw7rifrLxfrtypMA0hYVlGLjHLDfZAR19J6xfDvwdVU?=
 =?us-ascii?Q?C8BXXF5x7KlwIrgMmkv58zQByOH2qMH3DfWP7A9yr1HtUKIMSFx6qN20ymo7?=
 =?us-ascii?Q?aQXHEva0q9T5dyV1ej70ynHkUBPIaask1v+GVMqP/yxgQ9Mxaf9dFW/ERbIz?=
 =?us-ascii?Q?3auHRreC+Gk52QSt/0x9ywaJ54KY5BIYTaxoRk8OsiBq8wCdD+3GyBhdsLdn?=
 =?us-ascii?Q?Na984SNE+TGVOLb2WfId7xkyChjKOQzdPTa+1h55eRsCqpvXFmAV89sTBYhM?=
 =?us-ascii?Q?QM44xU0ATh5X57WD+ZpV8V+gnymkQuoGlTbiDQt1mvKAQ2TEAYwpo1ZX4B2I?=
 =?us-ascii?Q?gMPTLBs637n8R2wEilJzVdhou8xIguYWxEIINqiwFxgURfley4Ry8A0thWH1?=
 =?us-ascii?Q?gZePce9qm6MkKi6Ldc4KAYotrbw75zVweL5/RoKXflfb4/crgS5yVhG0iMZp?=
 =?us-ascii?Q?JQJiCeNwx7V3GZftNmJh8QxMhOgErFrROv8oaURi0KpCF3/zgvPlT/rt7qpk?=
 =?us-ascii?Q?uPeAvP3f8HdfLkI3JwsYMc/xE0o5iQBnBbM+9xLoIz1gROAoVUnw1gIJTlP5?=
 =?us-ascii?Q?EAuNZ1dG22yz8XKNkVy5T/RRwZwqM+zIouWqPfXzR8QdtdrK9Lw5Amf35J67?=
 =?us-ascii?Q?h33p0rclMBfbe/vvOGl7xfNjg6l6O6g8MOu/ZwTO4q13v+xkttYRWWFfZcWJ?=
 =?us-ascii?Q?QELQB9NkwlRxvWL7rG7lnHTCbYRw2CqNIfuocwYXq8YVl+uxpC0nRyQ6l0uD?=
 =?us-ascii?Q?qCop4/nsQulr5EtzQOwE1MHGbxHJhsS++KO8cSCYxvXJFHjeZnS0BxnxJM02?=
 =?us-ascii?Q?/Kwq3STU1ugKm6SNGGBT7CwIhU7YnyDGdFjaMnrPpQCITMUkFHa4sOHTOAJ6?=
 =?us-ascii?Q?BsCuW2p4Qrtn34UPrc02VYxyjfSdd4odDq+TP04ZVXw2JFgyAisg0WhyF+ly?=
 =?us-ascii?Q?dT+n8lBdfspz1mLtTHggtG2XJhF+kikwNRjzGDVdxnoRLoyOkNTUq/9dqF8S?=
 =?us-ascii?Q?96PIEvcZgxRBWV/99bwpnJlTEgKsepeB7GcTFpf+xcXynzzM/9PhmovVxb38?=
 =?us-ascii?Q?sD0ZHXoa9zu4tHwmo4uidPU68Q6f7e2B2gTn06DiDA/6IqKQ4T+j/Bxo5FRU?=
 =?us-ascii?Q?OLZhw1AolX4NPE3xTMD/MVhWpyvQvlQET2oBkB32jowNvcUouw4lfBuY9eb5?=
 =?us-ascii?Q?xnLolDNey+Vqv86XbeQJAfhUXycmlRRCTtLxs5gz2VoctL3TMvHJgbbEUPZj?=
 =?us-ascii?Q?Ki987oOzIcqTgJj9W60U3ZV8gDN8O8HUMhGlTdRY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1271cf3f-387c-4e3d-68cd-08dce120e5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:24:19.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL5JWVL6nB0EMQKTJh+6F8tWtQnhmR7TGR7bznKdoA7oS5FXTRaPFpD9unV7hztn5oatkkgMMxiCZl6njqwfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:07 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> The blocked domain is used to park RID to be blocking DMA state. This
> can be extended to PASID as well. By this, the remove_dev_pasid() op
> of ARM SMMUv3 can be dropped.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

