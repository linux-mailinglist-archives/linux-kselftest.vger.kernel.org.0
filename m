Return-Path: <linux-kselftest+bounces-15059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1594CBCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CB61C209F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4316D31D;
	Fri,  9 Aug 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVx9SZsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544818EA2;
	Fri,  9 Aug 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190441; cv=fail; b=q0GSCaP2AXG08RDLYjZuyyCYVl+tVHidy7JnSEAQ7QUkAbpyw/HyHFhECfwdmlAztGdrEI36Yrah6hnuEXruYZ3ktCOvFf4yDUkXrGUUIMrD2Uo/aDHtcbQ88RkElMc3/EHT2UHu+66ZWlGGjzsxZDI6huO/L/PcKrQ7eDYMijk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190441; c=relaxed/simple;
	bh=1NW5iFGe+FFhk/pqWH8AbRS+BnL/4bsl2ECla+6vfHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCCmqlCyB33pYyBJdsUcqd5x1TVfnydATa4AuKaTkiR0aQSM2vdbaxONLkT3xnQrQYoeRDN8xlQzgwCGpdD9V+56OMi75+6zZM04IBh6nLNrrD2AZidTIp8J501i+8afQ+H/yFo0U0XQu9JPyM0zy3KDHIvISq+yBQgd2m/2uOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVx9SZsb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723190440; x=1754726440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1NW5iFGe+FFhk/pqWH8AbRS+BnL/4bsl2ECla+6vfHY=;
  b=aVx9SZsbk1mYAaP07dwsY2BX+19XXTBHSAAE41V2nortcKmij/tT8zfW
   utQYOFDu15dSqRAERLbRMNA8DVmihd5HZ709y3j+Zec8k4eASsVqRROEr
   26vRb/Lm6RZSmfJPAydfTyz9I1jjSPU/8lBlhk45tP4ohl1pk1XmZRtX3
   98vGHEUB88luh4U9wrW4mQdxZHCo/ydYJnIc+V0cmrkVAk2sA+1cUrLef
   SPs4bFUGmYjlYODTvbRzHEn3/yOur34VfPJTq1aiCPs/pQ/7wHQ5YdrLP
   kGbQx22u+6C5qSTSvsWzgq0Vxy5OBqd9+MHIcwrEow2/ZSuamB/gEQrqL
   w==;
X-CSE-ConnectionGUID: RE6h36vLQnWSQLFDe1upDQ==
X-CSE-MsgGUID: 81GPVFwJQ5uOSP90o4Ph+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25121222"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="25121222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:00:39 -0700
X-CSE-ConnectionGUID: R/Zr0yGbSRushjb/ZjzHig==
X-CSE-MsgGUID: c7XZXZ8HRcOE4Rlb/SKelQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57449505"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:00:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:00:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:00:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAeevM8VH+oKqB9aZ2ePlpic6+E/mjp+7+FJSQpm9SJ9O1BjP05u4mfO0KCWchBvzuj6AQYmTI4olZER0zXr1WFYLQnUVaCG1LuC5Y+gOzzSPSjb5p4qAqnKmhSX2UHgxHKu84UAgz5gml0fA/pmgDoA/MAeXnao1/I53FaAH3KXoQwzrCcMX6B/M0APkaO+lP7zTw+Dv4KcmfpgOb8KwQw9pLZCevsVJwNVmuFld9Rxw3uFgYl2c3ODDeAVDK+AzYOShiGNHHVEtT2OlDItk0ySyr/om/MpFLdwtAKA7RSh5qLhtRcQWXrzMhE/qKll6z/8rq7IC3GDfprYJZZBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2UnSPpWs9K87iBZlM//3f/glA7Pa2glYOlQnVXvA2A=;
 b=hQ28g7nREP5BtfpM7nL6aX5uvqJjzCpVIqlX3kILDUE2p3ZAdGUmtrKeCUdr6Xkq71hMD7vih3WZE9YU1epRp3coPi2NtZsDaZzzy/0ZGOYxkalb2g2uuxe7Ph/AMA/JveDTe/lTqoKFIZdxlO4bHFtUf8YtmGaMV9ou/2x8DJ95RQ+M3ZFFxtDvhkLoEmD9LtotqgTzzJgDoh/Jvobas1N2bXJQP+uKX5jONiS845JDTMtWCQ+WAxioqhLYKFC3B/2wKXI1KykUAi9gwzo8ldMzZQ+FWI0qd0Q7XWJBPBhJq53Gu1kGD6993xKfexXYrjUaz8HOQksjYuYEk1sJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 08:00:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:00:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Topic: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Index: AQHa5Tymvv0QPh+hX0iHTvry+ddr+7IZ6L5AgANsmACAAK1ygIAAlRmg
Date: Fri, 9 Aug 2024 08:00:34 +0000
Message-ID: <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <ZrVN05VylFq8lK4q@Asurada-Nvidia>
In-Reply-To: <ZrVN05VylFq8lK4q@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8312:EE_
x-ms-office365-filtering-correlation-id: 81ac5ed9-77dc-4622-44c4-08dcb84958c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WSI3J1c1WH5MYdhkXvCNPuSvsyrRC55CoGQYrsgYL4kTobqBghio9SG2/DRz?=
 =?us-ascii?Q?sYazrMl1R6fBoQLkSseeOujgEI4nT8MDuymq4QrIRO7zD++TOx2YFl5eqbZ7?=
 =?us-ascii?Q?bTN4OL1jI0GnpyJhb/UqVegngIV8hBe/HBeAQwVzdl5HK1GLl43tQz6LWb3j?=
 =?us-ascii?Q?toE3uFLgb4U7COcz6+7ceI9/9wZsBGi0wjD4uyCKIgmB4Kz+x+99bmIECNJa?=
 =?us-ascii?Q?SqaLHFdMdmFquzwFCm/rdrLZJbRZb1PsWZ2WrmEvONzpfrlFperHxkkr1ym9?=
 =?us-ascii?Q?WE8ycox4Rw/+PftjzIcHo1jizxKKeseZIYs7JCXNiF+uxTUiz0qXySZZBLb0?=
 =?us-ascii?Q?zBkaO63klGvT1/OscZ5vQ9cH6/Xd31hEM9uFhJ+QWmha1Y44bzM5grywVMba?=
 =?us-ascii?Q?OvjXmdfGLxNaJuKBnfdyRPbk1n3RkEBvkyLc62R9XxR4z4BnMKGHGvG+/eFu?=
 =?us-ascii?Q?9Dg93YaHoiO/dUyzjTfO4xoLMruLq8HR+4jNQzUx3+h4sE2822HYjjydcCsH?=
 =?us-ascii?Q?a88Rpc63aCZ/vlQcHRmvEM4ay9v+E01Ew20IHuIsJ3OD63KMxwy/d6w3IHha?=
 =?us-ascii?Q?c75F/NarQRhId0vFHTxbBHmOHRJTF0vI2h7/9yme2R+rWc/S3HMiwd4nwx2f?=
 =?us-ascii?Q?zAoawidimUSamw0dtUbQLEuH+FOyTyQmgNhTd7Dzk34QvD9uS3R1JIkmmKpK?=
 =?us-ascii?Q?rJ1ANQxLzOKe5CQzhJYk1uojF6Ry/ZozpoWA/puv/sYAM5pLXK5NoE+V57YK?=
 =?us-ascii?Q?n+HpyEeY9C1UUhm4vXrCoe3KdZHnz7gCn+oOb/cC7Jfrz92jk0U3cPknEUJt?=
 =?us-ascii?Q?C6ZIJNiPtQue5wCb1hRZupWA1PwY/u2cN/RukQWc5wiF+PErmhYKqERZsWGO?=
 =?us-ascii?Q?PXlhwWGib8C25d+yHEGEPuKs1pVvRtUlDjQCpoXyR8PLoxVMVQAhyLvn1GeZ?=
 =?us-ascii?Q?S52WPjjOVWivAvYl2prg8yXLembiPCpwq2s/Tl7AY5UU7JyXdpZ1Li6wGzae?=
 =?us-ascii?Q?fWca3ZCkGPbt2K9bsaQSmIfsxlavYmdAVNjrqKRxdevV0qQkz2cwok7EFAic?=
 =?us-ascii?Q?TxuWRGRStI0RgZF3Ndi00UiJmh0lkTcBsWu80bu+qSNcNlPxzSveLTAUhr5R?=
 =?us-ascii?Q?ugM2FS3889pTvSNj7lYtK9lWp00rrWKviR7SiksMWqCfyoS/UG142PmrV5ew?=
 =?us-ascii?Q?7pOXF7V+GTqkM2njK9rGhsaqSM0Is7PyJPXyvO3qz+8W1FveiYzH0yZJTicN?=
 =?us-ascii?Q?H6P1kWMShqumMWRH3eNmYby3no4llyzU8uIQk3+6EjSsLYUQUqJp+16KwL8E?=
 =?us-ascii?Q?lRHqk4zg2ZYXv1+HM0ZLwXU5Oo/kopD8WuY0gv6swMVJucOTidSgH5pgeh+c?=
 =?us-ascii?Q?n8TTeLMrCvsz0jEywzRf7MeaDNHLEl7ToIafqyvGU9okLSvNoQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eORfitrJERIK8mBINm+w4yWZ9PeVNM5SMZiUe+Y/erud1U0Ymz3uY53l6K4Q?=
 =?us-ascii?Q?EJW1ltLs1y8xbbAQYpvcSgHsu6p2z1MXp8I6J0aiQdyY71ALv5Gh8u/hFYgn?=
 =?us-ascii?Q?ZPpZgk3VEP/2KaClnrGaOjLo4VRpUSqjNvJevzeu5dEc+ywQYUPSk1f6OIB2?=
 =?us-ascii?Q?LwTyiPNSJP3Rm+H1wny2ew+sTTtrwFi+s1Rc1j0mbzM8vXxLZ0HN0NQH5jp4?=
 =?us-ascii?Q?R/TbghT/efQTs90ARi8jzlerUQyIc5nipTyjWkcCra9DVeztCYdsg92Ket/H?=
 =?us-ascii?Q?Qx2L9v+AwyH9iG29udxVnnGEIQBN4tnwtCSROH90h8nkUR5yzQ5E4lMz6XNI?=
 =?us-ascii?Q?jIY0R1y1hMdnBk1sH1KdGqEwV95F8vnW6uusXWfbE4E6w1Te8j71kXANbKma?=
 =?us-ascii?Q?04ADFGjJVrRe/SpM9yFVfmJv2evTYtCY3IYVlD/KDrYYileHXp7LRyHNaVnu?=
 =?us-ascii?Q?mAKA+DmV1aiUmEwyzz2XvDhQx/JXDzbgCe/iISaTulQLXwvQC23bfkrko9Wz?=
 =?us-ascii?Q?W3l6jCQIPJiPd4eWr6x4BeUEFIaKrACd3YkdVsDeGjKujwe1asyjE5JekMTl?=
 =?us-ascii?Q?NJlzWC/kn7+w+MvA97opCDv/Cyi3esvc+24pm5asWzywDm+5HuaocHwt16hI?=
 =?us-ascii?Q?S9uMCzKtR2lXG4IErTI0EZAtvSZobmpKuPudvurPIr34E1dzFlgXq+j8sXqc?=
 =?us-ascii?Q?t4u1v8dnfNcvwvUZe1hlVa0KDk3Ydj1KB7GsiQQoOZZVK7etCkqBlICLs7fg?=
 =?us-ascii?Q?LcglfgiWq7MXYirtuqTrqkFucxlFX/WWTOYxI1vGOZ0esv6rMWc5ImA0uRAl?=
 =?us-ascii?Q?grV6Rdw0/WUqmeosSqP8vTci7+9aXxLh7jP1lfNjRkw/pXPyE+/2itBRPNaj?=
 =?us-ascii?Q?fmO7E2ZA+v7glNRUOTsArgSFs9q5gRFyvlRFBNgxs7qpZv7VobjhmlbZAu7V?=
 =?us-ascii?Q?BwWbaxVAv7URULOvVP3fyA/fPdbQE2dluPi9PD6VMbQJTnDeFbWh9Ht4EjFo?=
 =?us-ascii?Q?f6U+kaFeC8vnTMzmTjHWCAmQqqctT7kmoxVLAwrYGRzS8FozVO5+X0zOy3jI?=
 =?us-ascii?Q?o8RKLxyrLFWXGBfzyRLvAhAokGJRI0pfmz/XOQ2vq68xlFMw0qDyBCCGmxo9?=
 =?us-ascii?Q?ib+cEf4bV4A+6Op9P/OxdCo9pocrP9LQ12ZTQQKYHAeee7UnrRq3ETw8BMON?=
 =?us-ascii?Q?Nn8Twe4/ppK6wCwQps1QrIWkk6uNmT7wW7MpTSEoIbDcNToCPJ8bbFVS21qI?=
 =?us-ascii?Q?iF0zLI1rP26wZk2Vtlv2fvdDOC05xQQvmw6zF5dpbthpldN/1PaCrBY1xLMz?=
 =?us-ascii?Q?qtd/F/45ZsrMkGP59LSTdJi0bSbxIvgnk5EXtevAeOfIZ/lssgBJDgiwuMWq?=
 =?us-ascii?Q?HIDwWVkPj44Z63SsruhQdet1f2xCaOxbTt2zP9/HmSoEVgXmA1bVzdc4q3pE?=
 =?us-ascii?Q?epTfSZHFnewPW5YeUkJ6hx5AoQL2L7GCuDVJte8L8UXczshDFKRLXBYqz4a0?=
 =?us-ascii?Q?R8E+qA/8NhxHHAT/wccX62SdvDax47idMUdBYvSW4pl2QZWd9X2gGwWZg7ur?=
 =?us-ascii?Q?rlKMSLHkLqwoxnse9sMWUUL3xLT/IlkGKmta1L41?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ac5ed9-77dc-4622-44c4-08dcb84958c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:00:34.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj2zCzlGV/Ic4fvnxmp0bFX/mA2j/iZv1Mu9og8+3Bdttxdrt7FoWZLXIVYrMepleWOLdNpDG+0+j1JY1tiLnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, August 9, 2024 7:00 AM
>=20
> On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
> > On 06/08/2024 9:25 am, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Saturday, August 3, 2024 8:32 AM
> > > >
> > > > From: Robin Murphy <robin.murphy@arm.com>
> > > >
> > > > Currently, iommu-dma is the only place outside of IOMMUFD and
> drivers
> > > > which might need to be aware of the stage 2 domain encapsulated
> within
> > > > a nested domain. This would be in the legacy-VFIO-style case where
> we're
> > >
> > > why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
> >
> > Because with proper nesting we ideally shouldn't need the host-managed
> > MSI mess at all, which all stems from the old VFIO paradigm of
> > completely abstracting interrupts from userspace. I'm still hoping
> > IOMMUFD can grow its own interface for efficient MSI passthrough, where
> > the VMM can simply map the physical MSI doorbell into whatever IPA (GPA=
)
> > it wants it to appear at in the S2 domain, then whatever the guest does
> > with S1 it can program the MSI address into the endpoint accordingly
> > without us having to fiddle with it.
>=20
> Hmm, until now I wasn't so convinced myself that it could work as I
> was worried about the data. But having a second thought, since the
> host configures the MSI, it can still set the correct data. What we
> only need is to change the MSI address from a RMRed IPA/gIOVA to a
> real gIOVA of the vITS page.
>=20
> I did a quick hack to test that loop. MSI in the guest still works
> fine without having the RMR node in its IORT. Sweet!
>=20
> To go further on this path, we will need the following changes:
> - MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
>   hypercall) should set gIOVA instead of fetching from msi_cookie.
>   That hypercall doesn't forward an address currently, since host
>   kernel pre-sets the msi_cookie. So, we need a way to forward the
>   gIOVA to kernel and pack it into the msi_msg structure. I haven't
>   read the VFIO PCI code thoroughly, yet wonder if we could just
>   let the guest program the gIOVA to the PCI register and fall it
>   through to the hardware, so host kernel handling that hypercall
>   can just read it back from the register?
> - IOMMUFD should provide VMM a way to tell the gPA (or directly +
>   GITS_TRANSLATER?). Then kernel should do the stage-2 mapping. I
>   have talked to Jason about this a while ago, and we have a few
>   thoughts how to implement it. But eventually, I think we still
>   can't avoid a middle man like msi_cookie to associate the gPA in
>   IOMMUFD to PA in irqchip?

Probably a new IOMMU_DMA_MSI_COOKIE_USER type which uses
GPA (passed in in ALLOC_HWPT for a nested_parent type) as IOVA
in iommu_dma_get_msi_page()?

>=20
> One more concern is the MSI window size. VMM sets up a MSI region
> that must fit the hardware window size. Most of ITS versions have
> only one page size but one of them can have multiple pages? What
> if vITS is one-page size while the underlying pITS has multiple?
>=20
> My understanding of the current kernel-defined 1MB size is also a
> hard-coding window to potential fit all cases, since IOMMU code in
> the code can just eyeball what's going on in the irqchip subsystem
> and adjust accordingly if someday it needs to. But VMM can't?
>=20
> Thanks
> Nicolin

