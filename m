Return-Path: <linux-kselftest+bounces-18567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15816989B17
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF19B20CC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF202487AE;
	Mon, 30 Sep 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFQIaJHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E03F8F7
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680285; cv=fail; b=ZO9c8Lapn5rfkqWgSQ2kA/sgC89cy5WUTse3zOKerWZoRhUJZHwwOmutCkMsH0Y0thou+DYl/9p0K65edb8q8jo708Z7up+zKw3ItUYPPhLPZyMQneyolQme0K1M3aoUOJbgu5zRtqtYYXSUmAn7wkHTf5h4fU27IEsuZCorenQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680285; c=relaxed/simple;
	bh=8Wg7zSQRIj5d0hRQNj0bMne4eabGjbFGaSLnAq8pZMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YdXgDdICONOl3aHbtmPJOzH3s5gCxX8Mnfbt3E1l3SQ4q4BsbnbKi0sYm0Hyjm0N5Rkqt84uQ2RLASAXHKLPenoiHuHghNn8ICPWH00359TWleC4FuoQoLYpiUkUMYnY4voVvtWJS1bQxpH9xAZLCWc1Rba8IVDa7qLQFPoeQxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFQIaJHl; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680283; x=1759216283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Wg7zSQRIj5d0hRQNj0bMne4eabGjbFGaSLnAq8pZMI=;
  b=LFQIaJHl3mIz2wXLYzp94m62T8awKzcplve8GYvHZFtWRYvsA59JbF/l
   GFEP1VyE8wdAMSPT8uqqZ5fydsFck+1a+5k4Wx0Lzi+o96il+5lkNH0c+
   DoJqrrpLS0CO+cck/F4fmrZbPhfloWfXs2iBkBM0mWPbcUjtvPY8cjWww
   j8JOY6HbPGMM+MCukmZUDIWhSQQurkJfWRH6xIrL3jjIKyvT81ANab/OX
   FblL3CxzGlGFUG0k2Zm/imLwLWz0kctvqJ9AhsRIJKJqWymxBuBdHIbeo
   88caOZPDvSmuRpIrAu3FRwc74jy19Y5SdfZreuE+vP8gTGzgOr/tYia33
   g==;
X-CSE-ConnectionGUID: Yw5/d4xGQpOt0immveU+tQ==
X-CSE-MsgGUID: 5MMUp73/Qxuk6nKdzo7mzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37336282"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37336282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:11:19 -0700
X-CSE-ConnectionGUID: PUn1VseHStiCzL3FThkycw==
X-CSE-MsgGUID: B4h97GmEQYigtxGE7VcsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73487792"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:11:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:11:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:11:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:11:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:11:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRaYlSCsHRewJgB2MKs2w+kvzK/+TcU1vUVsP/Xa6Z1q7neXcaAfFHT1vLOTI9LJ4IArgNlKyglS4SjHXKT5JT+OIKkXGlkN5xURpXbU40VFJxnSpHeme8JX2NfRmn7PnVX0HY0bH+CZyHXs4XPGDOAcpI7ZOCPzx/83wjbx+bE6Zd+F+Hk7Gsj8d6cz+iZe79/srzPo7DvCrxQ5TXVbdAm5iWcxwh+XuMleKg2DFH3g5rG8QsnoDK0rBJ3P8G1MMCwGfy32Fc0lYC1UmYIUPtGi6rBshMGN7qaLuWn2xaObrzYhX4l49/xw7Q8Jj9UZ9pJplYR6KzaBob0AEZhEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wg7zSQRIj5d0hRQNj0bMne4eabGjbFGaSLnAq8pZMI=;
 b=PyUoRVGRoOo1ee//2+4ayDQSseHO/xinQR7Ivy5W0+qFFHwGIKoih6sztIcEWrUftHq3NYaSBGG/OWXcU+BeCI//jRjoWv3qGLfVQ5BkcM4Rr4NyA5AxM+SuA/TjsLvOd08GBzZs/kkOZxO2b44CbfUVElspnPqXky9eeq+LsI24UnaDRDJRnjrKLehnTPI0oTtloKnvvBGnqOp1X/qDB7tbCbURCw4iBG3NbcAO7UmEQdOm5Dh1+fZphjmUt5Uu2LogyZSNvIwsq35YpBs8Fgvtk1I0zBSF5p3J0QVhgWe1OUsk2hlC75SMagb+NjElb3JF2lJAK88GvEBsuzfSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:11:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:11:17 +0000
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
Subject: RE: [PATCH v2 1/6] iommu: Pass old domain to set_dev_pasid op
Thread-Topic: [PATCH v2 1/6] iommu: Pass old domain to set_dev_pasid op
Thread-Index: AQHbBRRYmv5fc9CwVUCpLq3i8dhj+LJwBY1g
Date: Mon, 30 Sep 2024 07:11:17 +0000
Message-ID: <BN9PR11MB52761C767384001A6918CE278C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-2-yi.l.liu@intel.com>
In-Reply-To: <20240912130427.10119-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: 7514c84d-f8fd-4c49-dc59-08dce11f13c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ucFekgSCG9nU1vl9JdeymPCfjZc/t2B080mV5a4rlNqyJXb395AvEQg2JmtD?=
 =?us-ascii?Q?gos6BeHsA2F4YAxZx8+zXVCgA28vZ4BPZ/v9kO9VaEgJj8n65r1UFK7rbZxv?=
 =?us-ascii?Q?p7U4SG5sxx0YO42LdpS65OTNCG4Y9n94Qz0SkqAIf7QJP4RVvaht7BAP1sdE?=
 =?us-ascii?Q?NwgH5qxZ5HuwCETo4HKrHlkwOpfYkAP4jRQZQdXqkTyiRLHR81fFV3xnXBDm?=
 =?us-ascii?Q?eMIpkFyfW0SWFMaXzpZGfeDbayU3Yxgyfh9mMdt0ljBjdHE6+zqbEv4yCSN7?=
 =?us-ascii?Q?rUQFrMVVghV5q41RegKzGf4JY5SUAC+hVYPV2veGkK1TnOoDo65iZnnir4QM?=
 =?us-ascii?Q?tbTr+saEkTs78H5YzXMvWfVn4CTVr0PS/gxEoMb8qPJG5qzOp94ADKHZR1Bq?=
 =?us-ascii?Q?hMWL+GCyY6SCte/vLR4a1lwbbErEORP1e56BUDVPVx+xYPw8gBYg14PEfkXi?=
 =?us-ascii?Q?kcNQQbm3MHa7YPaQzgwOeB8JL1+vXrij5HDwstjE3iMWapjxekl8mdVCE82+?=
 =?us-ascii?Q?W9feEiY+y4YbSJoyo8VK7infpy6gb9uFEZlWqy/Bp5ATxPDkLhwfMgj8QUqd?=
 =?us-ascii?Q?D/azKn32Y878Z5hq9k6lLpS7NRTplb6JynJfju5bS658OPK7FXe8sleksT2z?=
 =?us-ascii?Q?5Xyjbj+YS313uIb2kbSXxOPGLgjP69wAhek3Xfe1dohiyHQ5OTvHzkbmS1IP?=
 =?us-ascii?Q?MX7xoTk6aa3AquG4lHgNRif7gMUi0oCM6S8WcM72clBFgZUtO3jPMMsthz0e?=
 =?us-ascii?Q?yD4BCXOsUWHZj+Jf4hGuUKqy2sbkH4zK2Lgo6J7c+sPkYO6ZJwT18eSn9p+Z?=
 =?us-ascii?Q?1mvKcqL2wzWgjGeqnNrO9K+MjpC22UZYAXdHlMjz3Fv7oEaJWszIxLZHw8np?=
 =?us-ascii?Q?lwMCQ1TadCfIOXyH9RNnBhORaIkAD1ZRuzg9OpWjSz5565i9brFmL1ujUx6/?=
 =?us-ascii?Q?ghpixUN7SeBJiO1SQ6wX1L8WpAqACMGKvBK8dKqhiX9Avk2e2bjngrcFZnOk?=
 =?us-ascii?Q?gU1Ly0DzCDILvSyC0Sk/P1+djDdv72go8DbGw2YryQGNFxuHOkUvDQRiqve3?=
 =?us-ascii?Q?HhACgLuoRtQMy38rbdFxeYwsgn+H2O06F/1ePfZKvQqZsunJVa1/VpPtbFmw?=
 =?us-ascii?Q?aADje+zhM8ChjCNw0JZqGaW8yr6NBdiwgVhZOGelITvxpExBzc1bgflx0C+m?=
 =?us-ascii?Q?lJXswTvlZNJ12h+eX/zjJ+Pov/+Xsx61K5f2TVZtI3IY6+Z40tVfcYPTo5WN?=
 =?us-ascii?Q?8graH/G2KUpO6i/0vOVbFMmXPdMmcb83VDV0ReVIgoE6nJFOH92zxndwcndN?=
 =?us-ascii?Q?TX9ldbJ3YWUlSez9z3Ck2Et6BPPjTMujXWKMRSPc5myndxKcn3LIPsmPFca2?=
 =?us-ascii?Q?ZuUXdYRQVENnC5x73oGJ9YtsOYmkyOgniZnnOg/l4B4bDTMPvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2c061oReWi+/nFmkUl6rAOOuL8aUtLhpoW+vJYaWirz3MuIBzHwM2bgUBr8V?=
 =?us-ascii?Q?EAh2wygKeiQOOVNxB1PGKRgIWgZ3/KrmHqFyTL2RCjPqyKdqQGKXgdIdyn+y?=
 =?us-ascii?Q?as0L/EWw87kjcsBqW00wy1s3MdkQg7qN3hbUv8HybMW7ndUJxcr8MQqJ+Mh6?=
 =?us-ascii?Q?mpQRY/xJSZkP4wiVi6v1j/NKFRRU4vEYIn2qacPuAIwPf9o99Iufh5KZ3D8G?=
 =?us-ascii?Q?ntXqqCaW1br2VkXIXlEfpGQeNMVORXhd8s3wLjLAAmtts5kBWRRz/tWv2JXr?=
 =?us-ascii?Q?hfufUdkz3LDufc+B+ND6mA0YCd9Z1VKmopRpevzJybgQ2LrDuOZiQ0AyrlfH?=
 =?us-ascii?Q?TiiikiK+jgC0v7+mLd5t8z+/S3Vig58Pl4T0CLw5/uKJJ9Q1Al/4mqCdTr3o?=
 =?us-ascii?Q?XohcQX8K35ELKfEIY+vLT6r5OieMfOWGBRP5za/CDpmklB5mGPGzrXa0EtFn?=
 =?us-ascii?Q?OZ+SKv8OssjlP1slkLnF9morTbnxuEUCqVDhYYsa6pmwaU0cR50buhF0P63O?=
 =?us-ascii?Q?6Ra5YhngWJzwI6Nj6parTSBBMdUAAH2KTW9RZDN3dFE4kxeItWYAmZM+vFqQ?=
 =?us-ascii?Q?tNcXk7yCoR5AehOfAfBggcym/MtVVBOzWdwkhoJ3/n1DXuzKHaXkgggEsWiL?=
 =?us-ascii?Q?oFGECjOtXG9W0ahJpOogOM8BfmBuSpxZv8lhGmUANGV9rlB88XndkgiY9OaC?=
 =?us-ascii?Q?XGPhghVkPYMAvy6NnPn6O+KV3pg/1gPUgauOn4YRkWEXWo1n36A+hNxMPU0N?=
 =?us-ascii?Q?b/hC379rV1Tf5Hi14+RgPkXYYy0UQ7RXjXZoOvNTGvEanuREcampWCR//M4/?=
 =?us-ascii?Q?sYEmOzYSBH4naLpSL7fKe6UnvB5x4wMmGNYqxBzMKsi36iK9AikX54vdCsJU?=
 =?us-ascii?Q?xrwCSOI6Z2BnqDXRwXTKfAXy5E+r9N+cOah1w9yaQGSDFi3QNb9Pth7PnFfA?=
 =?us-ascii?Q?8FGL90mCZJunxcjZ4S1jaxQanddF5Az2ooNdL/zrsIGfi5rqtoYaen6pxSi3?=
 =?us-ascii?Q?sKXGmnFcS/1aNLzl9+0RK+R8ZgazEWN/v4fHLj+aCP7A9bax9jT1KsgxFENx?=
 =?us-ascii?Q?cM1vbgQOtCXZp0UTNPBorEsGlYpjYxiFmCHwQwfoYTFAW0kXqYZULZDb62L3?=
 =?us-ascii?Q?ale5pE7IQlNL+gkKXXFn+34iw60/s9i11J3vFtx09XaGDeDuJ+RqKkIcSs/y?=
 =?us-ascii?Q?gStZz7bdVKE4sU5//pxL1XJgEIpRHOegNqJK5AMTGIG7QFQagaljYA/wZY/m?=
 =?us-ascii?Q?+oGlT0LMJ57t6mBcoVxCNxKLblYxzFgLengoK7FtHHkHGZaosVrtYW+Vs/YQ?=
 =?us-ascii?Q?XHsd2r+MULc5EzxpUgp6iEzPG4btqT8GbBtiAwlRes4WgmjA8rBym83dRHJW?=
 =?us-ascii?Q?sKfvIbK6/L053SSQUIguFG5fA344H/+S6ZMCEncCobrcbwP2JxqmOw0Wyjj+?=
 =?us-ascii?Q?xh9rWlfeppwU4IjrP9TPDCu+2/Aejrh4l/xuTHXy9Le/Lot8pkb+VgKuJovc?=
 =?us-ascii?Q?Y3qryueIFIHcMazTt5wL4leNPPtuPHxUxhM2UC8o9ux96aSttsMyLy81FBRI?=
 =?us-ascii?Q?9UvJCtQrjJawXGZAI3Dm5ltKSVwVQZjhLsOAN+Q4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7514c84d-f8fd-4c49-dc59-08dce11f13c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:11:17.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHVWhUElCBI1bLCOQ9qX3olet443EENhtWLvEW0ctXD0XIWNhCgo4VM77Af3/5tjKLr5GWHmV/56DtoOBYd1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:04 PM
>=20
> To support domain replacement for pasid, the underlying iommu driver
> needs
> to know the old domain hence be able to clean up the existing attachment.
> It would be much convenient for iommu layer to pass down the old domain.
> Otherwise, iommu drivers would need to track domain for pasids by
> themselves,
> this would duplicate code among the iommu drivers. Or iommu drivers
> would
> rely group->pasid_array to get domain, which may not always the correct
> one.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

