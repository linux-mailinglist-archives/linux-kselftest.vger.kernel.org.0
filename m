Return-Path: <linux-kselftest+bounces-31239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE49A94E08
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EE016F48E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28120F069;
	Mon, 21 Apr 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoED6HOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B791D5178;
	Mon, 21 Apr 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223882; cv=fail; b=u4Jtk/vB7ku/bgQqpNawQiuMva0QYKHxzeEDzrf8TvNVuTkGohbUEEu2+UrW410PYGdi2C1G4MykcGnv4zDo+jwOHSFBTh1D9hKMHxNFpFpuQepkczwI9lwF5oHEG/74Umkpfv9EuptvFXlqMw/RbMoMtIiT2raLQME2fYiHAqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223882; c=relaxed/simple;
	bh=q6K6f9llB2KE0gnzrOQh/Q778mNvAI1i8NcmRUFhpLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0kN9JQSP8Mi9QyO1dE2Tvow8AdYAGGpjz5luzS4z5XdAfXllux2Zj52m3eNLFeb3fs5NCyMY/FiP4zC7NVenLCNVbzPHUJMiamj1qeSpBNT8hUWzANqRy4V8D6W2zfk9ePYFGHVH1KiPf+AFQj0jsoloQOOVOwnjphooQOAp2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoED6HOn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745223881; x=1776759881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q6K6f9llB2KE0gnzrOQh/Q778mNvAI1i8NcmRUFhpLE=;
  b=PoED6HOnK5rCEYq6CnNBRNp0XmRbs5nRKhBRr0spH7Zy5Uvy+sR3XQj6
   ojarDgc1+u7DeX4D0LOi2raVHYY0A4A8CnAFe8q8+UHuEXs3tk+hBHmbr
   3I2Z6+jf7C/E+m/FTScbKjGaV+6Xqb0kbskpGDuCz5D2sGROAKUbjlxWf
   jqc4nCZ78s+cbrZ8dagMgkkFl1dlbMau24sP6wOMnGiIkaRnTJCuWQSSl
   JP5WcEI4G1nNy0D2+ZqQKVDUXYA/gHi5Ov8rwLOXXdg6H6zIt6aFM9MEv
   ncKHt+XzguMNT9zbah1FueYjk1yu8pEI62Eb9wPRcttFXLdH9fWr85ERI
   Q==;
X-CSE-ConnectionGUID: SGhDKjUEQeSvdvjGeP3PDQ==
X-CSE-MsgGUID: YMqyUCWtRzi0l+8dABNQZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="64163705"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="64163705"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:24:40 -0700
X-CSE-ConnectionGUID: qOAyyg7HQjuol8uvl25ZpA==
X-CSE-MsgGUID: I09v897pQmSVspAbh+KWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="131628995"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:24:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 01:24:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 01:24:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 01:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqToa5bbiNgry7Xh+sNOjU72TVJ2z4Tt/ALi/osFmrUMHN9mWwKWP0SXVPhGcedKansXAQUYAxmyA6Crh/1Jws62zywil2It6RzQAL18A/8ETwTO5KZ99uDUyS7MuU5aqZ9MZrLzximgB2L+6qy80QMm7tQJOowuJc3hoyu+GDFw88rEHpoRxw+BeqSOhezSosWsxQy9zk/BWMuoej9vBOwCre4Iu5fuQqbFJqjYJE09X0mn54eA9/yBniejSHSx0uXV1xhRV4OtZ8PK4lf1QcCqYIbQvYnhdlqBVLCNFhi/0ch0txkkfS3ABstf9iz70cp16G10JCX5l+cLULUxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0d8DgnNb/UJbmZlnVoEd8wdRfe4w/fGilKqWutm4lA=;
 b=zKl6zEGxx0DAuW05Kt0KpS6JpqLUwOqYHBbalBoxcPjZRdijzq7MM3RzONyqPTa2bNqfI89qQlcV1woToG2wRWrEE4Vq66xFFA/k6Ckf1bdPu8Hfm4gA4MxtPKtYU4QrPJGIBtzwNiqoB1k2JSBdVGpFxYfH+YyzLMKrFkyENXc+TL09kuS+KXuwTW6mt7DBlKL1N/XY5kjGDDQW6R0ZZjDrhr6+wbIpl/d3f0hmwdDENSvaupcTRg+LZHWZ9etc6VNzXrrvxBBlkYp+gSqfNGuDt2AhQOvG0/o38GGsjdu2sV6lZpmDfgjx0W4XGwRmmhQADF4U+kytlaLHTGtt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 08:23:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 08:23:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v1 14/16] iommu/arm-smmu-v3: Add vsmmu_alloc impl op
Thread-Topic: [PATCH v1 14/16] iommu/arm-smmu-v3: Add vsmmu_alloc impl op
Thread-Index: AQHbqqxsv6Osn30sv0aA7Kn1RIMJ2LOt1jIA
Date: Mon, 21 Apr 2025 08:23:50 +0000
Message-ID: <BN9PR11MB5276C09E05B9BE8BC66ACE058CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <c5193cce7c23590b54e6d03e77fedfcb02037cef.1744353300.git.nicolinc@nvidia.com>
In-Reply-To: <c5193cce7c23590b54e6d03e77fedfcb02037cef.1744353300.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5184:EE_
x-ms-office365-filtering-correlation-id: 2940bb58-b840-4df0-ee05-08dd80add836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?noURl4iTgLjCt/nMjkmzdjH2T+J6HrrecxZpFa74O7+DjPq/dExYCMjGXVR5?=
 =?us-ascii?Q?HvMH3l6ZHPvsR7gZIvhlMZRB8T6uIVYrq4V+6g0lPVbeJdRBAlcTfZRdXhiJ?=
 =?us-ascii?Q?AQAzy92AAYikgPdpkTxqIEVCwVIuWPtd7GOwwQ/OC4gvLBpYV+xXzxTbjaO/?=
 =?us-ascii?Q?H6FGJsjdcNIlP8/VxkBqAxn+zXZY//1nRhok5Bz0SVPv8la9xb4gzF3/0ThQ?=
 =?us-ascii?Q?iW5XPFf59gWlKUbrVo7XqstyXXYmWlw/HMPgLFpWmthzzhrFJbTFl37rkQcM?=
 =?us-ascii?Q?BH1ANJASvlcPZUaUhLsd/BqVSfAG8isY/1MenPuUWOH5X+Gx77ybUAMe2gcb?=
 =?us-ascii?Q?6R2BSPAm0srFVINK8ka5D/hQdCj5JU28uBRl8iyp06PKt80b0wGzgAqXBVu3?=
 =?us-ascii?Q?FkH3cNZm6tTafS86VaE0rdoGgSeS/HYWvJsY8WHlgN1MIxTDhAhTyVNfjXgP?=
 =?us-ascii?Q?sAJd7ohBSPdyljFcgayifuzmbkKW017CU4RAO9mr0l6mCUXtvR3mkK7bVHjF?=
 =?us-ascii?Q?Txq+jkIDVNijU9IHL954Jduc5zoXwU7GEwMXO4RxZL0X74zPo7l8fgHGbjuo?=
 =?us-ascii?Q?HKMUXs74WBVrZczoHXxAdwvQEyc6NF5Xu1Jr/CD/Dn6W4cr1tiYH4juDSEda?=
 =?us-ascii?Q?rUvxes3Ul6D52KASleM3ng/BEpBrWrQQ3E8sYeBKmEGAt20ZAZb8y4gxItkF?=
 =?us-ascii?Q?o8yp4euvGVpr4TbiZGzIWGn+L/+npmx0bOBO9mDey3c+g9/Sh0z390Q49ZnT?=
 =?us-ascii?Q?luDljAtJTJhS6UqJj4u1DMrLCXQyoMdqrwGAcgrNLBy05PPkq71xeEM/7LV8?=
 =?us-ascii?Q?sx2hDB/oxpBY3/hueNgL7INijoleY/BKJGSxzhQ5Z75QPWvRTdE/N/3Fe06S?=
 =?us-ascii?Q?iNdavzUcgp/dTwTgNiDQlgtJ5Qcpwbqh/3H04MsS9ke2qTWpE1fMtg/29F/0?=
 =?us-ascii?Q?Ju07iXu9Co7YTFQL8+mwPOuYMwyqFg/0zpSQBjM/B17jy0cyMP+3o448ikax?=
 =?us-ascii?Q?WgP9evboPiQddnytb/1Bk4ZTYmIJgZdFvePHspB+8AgnpkLDm3xmNN+v6Gvt?=
 =?us-ascii?Q?kpXbmPtDtptgm3OT+glj6NAW+2X7dzZxDV9e3ISxIGj0My0Hmf+PaCkgLFZF?=
 =?us-ascii?Q?er1DF0E9YaZzboGZrpTzV8kFynNNxjv7Il+fTOicXeeuESYbvClVtUStVdmi?=
 =?us-ascii?Q?f7Dr2MK8+2KRaJ0rckh3pN3eRQRk135NZ6DJnW15eDccUtu9UmrTknIU3/AJ?=
 =?us-ascii?Q?+6jXofRb8V1wiUT7Pqi0Ukbn+pMAeKsJmVqrbNHyRBIa3KP0LivciwhHtZLH?=
 =?us-ascii?Q?9xhcQGFpaHLG/RI9iv70AhtSFYC4fwGCjq+VpXDQtKPcOb+hTtFaTljXO3xY?=
 =?us-ascii?Q?w/XxXH5HYrx+K5sYZxhANp1uZ3OfhmAVNlBFb6xfoAgpvX0bCcFSs0RwO5Op?=
 =?us-ascii?Q?x/zLmFXdJ+cJNJdfZ8HKGhj1KmzzG8goNo3p2C14uNGq9QaBKSAZptzM43Fb?=
 =?us-ascii?Q?Q897ECUDthO1ddI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zcyDKvbKzotCTYdWtS1zXRdVG8a7p47rkP9azrSqJH6Ts4oyeRd1O9nLTJj?=
 =?us-ascii?Q?d5Q7lrRTu3NiqQQvBLnUheVCjRd91Ds7rvbE2RBSLwuWfW/RNJ9tYx/FDszB?=
 =?us-ascii?Q?WkaYPch3NdorvVOwpmgSPrm9yr7+iS/ohIT/OkLGQ+gICKl4yxNULUq90dI4?=
 =?us-ascii?Q?22Tsq1VC1MYDP1Y8tKcRAhNpoVRua3udiicEkRE2vdZifXbtZfgP2K1qvQZK?=
 =?us-ascii?Q?KD8PyboSnv4BL9OL/ocHKmCOnHM/CVRZ2IaKzc4sFC7DgwwzUZXhkzb1DFIP?=
 =?us-ascii?Q?IrrFHhBpKBChUmZduG72tRQPk+JGvu5Io/yzTk+Zrl5j6fcSHw2MKHJPbGL5?=
 =?us-ascii?Q?QhzIBVjZXudaohK9y1zFZX8UUfHV3vBnfbiFB6F2/1aNTUKfhzWZmR0VqUx9?=
 =?us-ascii?Q?Oy6cFJKSEkoeGpf0JW/jcpIlkGng7xWclKf/LyfhXKBWmPFV5Nby5eOx6xA6?=
 =?us-ascii?Q?9rMq8STYu40rbedlcc8tZEclyZxr03GO49uu5FN3nqIwGaK17oPuW35Z2Q5N?=
 =?us-ascii?Q?1BlZtXT4TUnf7MANAPtifD4BxWpn/MC2zubi5BQfE4dBp2YhGPeUvzcKBB+c?=
 =?us-ascii?Q?mWCQIDCiqW4KvNSX7qD5SfFvDhJdnxHCRlJv/2+hAxsSQ50B9P0Cpfxu3mdw?=
 =?us-ascii?Q?4EPhaMCcw7JJ7LzLOlBLKlFHKqU+YcEtOrmgh8f3shTZXQ8IyoFkVJXGUlzE?=
 =?us-ascii?Q?VJNiYbtCAq+9O2MMvz/b/nd0I0shTqafvquU7NB2wZpTc3y6v2VKLa/hFqot?=
 =?us-ascii?Q?hjWHylczhzxcmhvw3RQekjcEnPnUeb1G0YEDjFIyOL8epT/FE+hSwHXU9s7s?=
 =?us-ascii?Q?g7ryYKfVSc31EixPMNH+wDRszgTyf3xR5IIv4W1aYfxp7Bg2p9ia+MnVdH+h?=
 =?us-ascii?Q?ryvyxAdnC0l1QVmBeJZlrlVz85fpw5EbJIgnNXTLANwLbMyvkKtzbI2caD+1?=
 =?us-ascii?Q?Dzn7wniKm1csRDBqMDQWfkF8nnuMHzJCRynSrjIoLYgVyOHoHzlZlnQfSHYu?=
 =?us-ascii?Q?PvV0h58KRkdRs6k1427TFZ0eZyLMHswB/tbSL/3XMlSoZn7WVsiPbr/h9b+g?=
 =?us-ascii?Q?OW+U49ZXnyIhTXEG5bVyV0+nzUzEjZA9/uPlorQp8NIxA7hdD+npCwLL+yCB?=
 =?us-ascii?Q?MWp059m/yDJ4DfKCE+ltZn35oIeYVNJZjavVfk+ZQt9Rw3alt9eTDPs7TuJr?=
 =?us-ascii?Q?RKNht+i4pyJTLqxJGO0UdCsDsasxRIHOK+HcfQUM32A9lH/Kt9fTKHOBYyd/?=
 =?us-ascii?Q?0Jvf54CSiuwQpjV6VizkV51wTcmqytkVJ+E5iQyeHmCYQjmrT8f8n/F2TGTG?=
 =?us-ascii?Q?qCYmTxsgtq6QJJyI0DxuV+jn3j7kz0i9ub/aCZhGwL8V5URlba+8jKxrxObi?=
 =?us-ascii?Q?tu6qsjl3/kecxEIPzMhu3CrL8HfmrRjsXM4YskwpV5QQo4rdPb1TE6g3zIst?=
 =?us-ascii?Q?PHrN7ym6U52iHrUd5NgGHt+VOVFdBNf6tRYij7Pw0PVkxg7GC4u2VFQZ4xJz?=
 =?us-ascii?Q?aWLeBAXA6fc4QfPkS3Ma9m0vdtH5mke80gxlAVVFxheyP3p1JblCMq+aVtbN?=
 =?us-ascii?Q?wMge01b/mInVT/gSgTJ3zGTP5NPPSbZcG1K0n/QZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2940bb58-b840-4df0-ee05-08dd80add836
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 08:23:50.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHFf9nxdseMpHbojY8RFOeHVZs25JWg3vr+qjtNxqYOvl2pNWNti7yOHgKpo6y1e8XwlfJCvy1VqxBjDdM0luA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, April 11, 2025 2:38 PM
>=20
> An impl driver might support its own vIOMMU object, as the following patc=
h
> will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
>=20
> Add a vsmmu_alloc op to give impl a try, upon failure fallback to standar=
d
> vsmmu allocation for IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++-
> -----
>  2 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6b8f0d20dac3..a5835af72417 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -16,6 +16,7 @@
>  #include <linux/sizes.h>
>=20
>  struct arm_smmu_device;
> +struct arm_smmu_domain;
>=20
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
> @@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
>  	int (*init_structures)(struct arm_smmu_device *smmu);
>  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>  		struct arm_smmu_device *smmu, struct
> arm_smmu_cmdq_ent *ent);
> +	struct arm_vsmmu *(*vsmmu_alloc)(
> +		struct arm_smmu_device *smmu,
> +		struct arm_smmu_domain *smmu_domain, struct
> iommufd_ctx *ictx,
> +		unsigned int viommu_type,
> +		const struct iommu_user_data *user_data);
>  };
>=20
>  /* An SMMUv3 instance */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 66855cae775e..aa8653af50f2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct
> device *dev,
>  		iommu_get_iommu_dev(dev, struct arm_smmu_device,
> iommu);
>  	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>  	struct arm_smmu_domain *s2_parent =3D to_smmu_domain(parent);
> -	struct arm_vsmmu *vsmmu;
> -
> -	if (viommu_type !=3D IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> -		return ERR_PTR(-EOPNOTSUPP);
> +	struct arm_vsmmu *vsmmu =3D NULL;
>=20
>  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct
> device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return ERR_PTR(-EOPNOTSUPP);
>=20
> -	vsmmu =3D iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> -				     &arm_vsmmu_ops);
> +	if (master->smmu->impl_ops && master->smmu->impl_ops-
> >vsmmu_alloc)
> +		vsmmu =3D master->smmu->impl_ops->vsmmu_alloc(
> +			master->smmu, s2_parent, ictx, viommu_type,
> user_data);
> +	if (PTR_ERR(vsmmu) =3D=3D -EOPNOTSUPP) {

did it work on standard SMMUv3 when there is no @vsmmu_alloc()
and the variable 'vsmmu' is initialized to NULL?

> +		if (viommu_type !=3D IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +			return ERR_PTR(-EOPNOTSUPP);
> +		/* Fallback to standard SMMUv3 type if viommu_type
> matches */
> +		vsmmu =3D iommufd_viommu_alloc(ictx, struct arm_vsmmu,
> core,
> +					     &arm_vsmmu_ops);
> +	}
>  	if (IS_ERR(vsmmu))
>  		return ERR_CAST(vsmmu);
>=20
> --
> 2.43.0


