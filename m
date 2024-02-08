Return-Path: <linux-kselftest+bounces-4330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962884DB9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E3E2846F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF8E6A8A9;
	Thu,  8 Feb 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBXZWVHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9769E1E;
	Thu,  8 Feb 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381753; cv=fail; b=NLoAwkFxI+ObClawwo+TxMnTW0+2Y5cdXi15tL617bNYCFv1/JGb6loN81nu6gNpaseW3p1d8m3J8B4kprRUH+za8oVD29pv665YYUYv9Y1RctioJNUSyIRJinwFzWW4a+SPbYpqSahRmzmZBunb3EvwajRVdatZUsn3PQvXUOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381753; c=relaxed/simple;
	bh=Z20mgmIQ8GPCnjsfMlKouL7eUBrA5zTSqXhw9quv1Us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjrLI4GS71SORsLAFkfEMV3arjU847sLS9Lg4GSOsLQ+Ejn/7YKDYzuaWAh78Ch2ZkUUJ4ePW5k7VPXi1QY5F3Z4xV/Kk8O7tfkjhi0i25Slqv4+Mn6rj7hL35aMDRBhgKUYYt07Jbu8adkF++15tQOn9BUVnUwgr6M10FwmI6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBXZWVHT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381752; x=1738917752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z20mgmIQ8GPCnjsfMlKouL7eUBrA5zTSqXhw9quv1Us=;
  b=nBXZWVHTDyuaYADhW5Zf3ELMsX14o99mS/u7rxf9M8p0Sm6iNRK9bs3v
   PZ7NigwRojiw+D1IHTk9YWiGxEXXDk/ZKP3z8aXYYjk6Bn7uLuMHsoC5A
   gFYlCq4Q0nq2G4vQlo0aeIiEty6Ec8cdY8inPMwciGvA5ooeHeY3TXX5v
   wdTfYuBPXQhR0TVyyYxpDl+YF5xHUO7+Wbvz4L11wg1IUrAs631c3eWJJ
   HDGI8wF5l/q1vd7QzlesbEj+ax5Jus8vxVupCyBL+sVl8b8Rd3Fk1c3YO
   8/RfeK6IaYe2hIn9hiV2I23Pn9xF1fMqw326uG41QsmuEsV+zPLqXYSdd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1311262"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1311262"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1587806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:42:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:42:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:42:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:42:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMDoIofAMCiSfLLaJLM7rQRaWMDVDhy8E/XaLHcNFodCveFM/kKzyWyiKnjao0A7Axm89Qop1g1yuqiTdGRzpkzYpcVvpMSOvo7ZJQd7B9HQNXVXJ3cz3eucqCUCbBWEDP2x2Sj1VutT5GBTtd6rO7cjXVk+uq1LNAqPR3tj11n/s/wf67WXhEF8TIsLThdErK5r17RaVHaKc5LJ0fegXCXNt8I1cJF9YhLI0hIYQh4NFYr5T1bRRvTqC62VE8muFEgtvVrg3eZF/NcOWgH2oOSbWNn44/lwqqoMJoS3tfTdR1/e7UkN7nTCiE9u3dTEUimUyxaxPKbCIMw6VkQAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z20mgmIQ8GPCnjsfMlKouL7eUBrA5zTSqXhw9quv1Us=;
 b=gIr3RMdGcCosfC3HwtGpAS/KhwuI2xQe2JiRR811ier4b/CS98Em/EaUCYUh0qU5aZUABuRTwZu+yb3DcKqjDaBpV1uOOwbrWxzlXo1OFXHB2Zeq/AKtmSQau54/fmvaOe5P/LPX5WJotdRZHFb5L27+lxkf2cbm0DXcYCov6cRswNXQKOfsP1J8C11BI3ajQuUl9vyeLpmk9/5oCGQ6J5d/jotCGXCjtI2x+OkG5F6u/UAYFwST9lv44Yc+S51/bdLrkNkrWAy3P3Thnl1qEP+pTPE6Nk9xKQl5kFUXiCyxwZ3bOAU89KnyMtjsbGS6Nhm/y+KjUd9E483dmuXVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 08:42:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:42:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH rc 5/8] iommu/vt-d: Add missing device iotlb flush for
 parent domain
Thread-Topic: [PATCH rc 5/8] iommu/vt-d: Add missing device iotlb flush for
 parent domain
Thread-Index: AQHaWmgTXy/QKp+m406psCSd5N//4bEAIJQQ
Date: Thu, 8 Feb 2024 08:42:25 +0000
Message-ID: <BN9PR11MB5276890E8AE4C552A66CBEB68C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-6-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: 48316849-16e8-491a-0f0f-08dc2881dff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJJwvMkr1y33dFkaS/xdIBPb+dVH9zW4ss8yqxIYaq5qKES/Hb+4YA1JtU3jXr3F+LlJrZsiTEoDcOzCZIKT08qlHFjWhSeSJPy6NEsR4mKKqzcW7I/R8ly3BdOZbUJcQZZQTvI526KC5PJXs9BMB4WtcfwP0O5Erl+WOafFsRDANfMFjVXpeKpoDq/nYkIV39JDqmLM15VyfAAfFLUOXugwYZE1wG0cHMQKhbygUV8nWsldQsNkDHvBP39d+tL/atk5zk/z1bxyOVcDQi91J6RX1XuY12h/fnqI3M/m0FJqW1iexUzoDYY+bY0gX7MhdCgGxiCxoMpuvPoDPuwERvjYfR0A/lZgCZs/SZRTxfBropMHrOUj015TkFdGyoSt/K9LARoTzPPFfVBHjVQ08EmYMx7GbSJ1YKpKoFMSNwoLVOrp919SJyPdS9Dm2KRlfD4R760pq6k5EFq5H42UrbhNz+pcOyFGiUNLZTjdlTrJWLbjKiysPOEnXYeGiqpeakddzm23vPgoWryIPlWqJdCLCNPJtM8NhM0nliAV0QM8bicdQoGwbPpEURK0DaxfBcBfM1RDT413L5IhCVLd4rY3qgUUOPUuiMKCcCLmyKf89W6Lljy8bxvzzYcecxsj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(55016003)(4744005)(52536014)(5660300002)(8936002)(8676002)(4326008)(7416002)(41300700001)(82960400001)(86362001)(38070700009)(26005)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(110136005)(7696005)(6506007)(71200400001)(38100700002)(122000001)(316002)(54906003)(478600001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qYp4U3Kl8M2uz56XEsHrbsWSXD8JayWiRkIFTmhB8+gRykO0tkYW24FsK9rN?=
 =?us-ascii?Q?f1UUmS3COdXCGJo8JnT2sQH6lyRxsYRhDpDUZIKZBEcPdAIJ4UKDE9k4yv3G?=
 =?us-ascii?Q?CP1ghhVRzbwuEufMeZUs61MA2I0ok7TF7JYhylj+x3Nr3tAwKPtNpzMmnnw6?=
 =?us-ascii?Q?KQ47IyEkkwvc4514WPmr98a/N9F4T5kxAygoirNuKuVqxkYqL2hUci/SXUMO?=
 =?us-ascii?Q?tvLe4jS93sDKMNY9bFV7jNn0PaNtBz1VMblF1Bk55/cXOfoUO3cNK+hSPxcr?=
 =?us-ascii?Q?aLK8zzmt/rTdiN13ZiH4fCLaDMh2ihXTBVlRP6Xjg2Re1y5btyY6WlHpiIRG?=
 =?us-ascii?Q?jvdsyV6H0nNfJjqI7Krz5s3UdZ7VSU9fNTnxeUCZL5dE7bQhKBYoySafcH1L?=
 =?us-ascii?Q?VjS9sXKugYpmbEaIADzAgJWIU4rFFaYTubTg/qD3VdU+KXXoACAjh1SlJ6G1?=
 =?us-ascii?Q?o6fL3lWqbCir69ptx4gMhOePyY31+4SD9/a33pShI0G+iC6wV+pDdNSPdMfr?=
 =?us-ascii?Q?mdr6CtnaxRk3odH075/wyjJPRL2tGFls57B5aLmM3EH5/dZFVh7x+0sKLtLK?=
 =?us-ascii?Q?rPdfpE917WQMYlwOq1IjxVogFSxq7PBx0WjhSUXdDUMQsjJraAgNrPUgM143?=
 =?us-ascii?Q?vFBVJBwVzqPPnMjgRhSmUWjOOoxQC5/fWEvvWosvAKdLHuaDGSTxKyMv5FXV?=
 =?us-ascii?Q?rzhTya61EoEH4UnSyAursw7yXdVUbRiqF9b+9O22Z+3BRo+1uwja7UQ7JedG?=
 =?us-ascii?Q?7/D8gSwOvxpJ6eFYfW970/6aI28CGfqrp/eDZruF/SxzqKWLtxgKCnHX8bY4?=
 =?us-ascii?Q?VyyjOtudlxz98m8/L0lqxDnxHaJ/IornPlc/8F2WzdsoXk2Tmzw5eSbmL4ut?=
 =?us-ascii?Q?iepQmh10B1FRpSrERu6mmX1GJHvOPck9/VUkILb7ytxpB0B6PXzV/RtCBR3w?=
 =?us-ascii?Q?LfmuJLT9k3CtUoaNz1pksqTa3RfIMKAVqlMfmVZsraUYSaoXS1IXUQRQMk3a?=
 =?us-ascii?Q?KRe19FncG4dJOmcUnf1UeAbbtzmx6wZDrr3ib5/5rFyLzC3Mujl02eTbu5ps?=
 =?us-ascii?Q?YXL4ZqlpTpqE3jB5oTupiSdOLUpjyTdMAMUoo4hjqLnbo+tiYb8Guw/IlZ0h?=
 =?us-ascii?Q?a23eRI/lSATD3jzhp0V8hO7KsVLrT0XFQxsMSFA70/RB90uKp0MHCJUsQr4S?=
 =?us-ascii?Q?yWljPHZwwjvSVJSg9g+6dZGlXSeDrgQO+Vq/qtmwMIUaO5evZHxpQT/sxqgE?=
 =?us-ascii?Q?kRzJCO5K3yY6qA7fiBCnIL0S4zHWGryXYa3up8y+osEY0oaKrZWC4z/SjuBA?=
 =?us-ascii?Q?oiyc5sKHK0+CvuHscpmYE8hh2M32AEYBr/O2eJg4zgaAUiBQP0kz4SXbjCPD?=
 =?us-ascii?Q?KNXPhfcjcFCYshv5v80aDViT32C1OxYCQtnVXUZz6PejrGXYVxw7qVp/Gjqe?=
 =?us-ascii?Q?EGQlL4WqkNO2sRPP2BTpyA78ZwxRIhv67abRc3C1oU8zR1pFxiAsto480O2P?=
 =?us-ascii?Q?cbqrY+jBNxBZ6eNgyMYONND4llWYcS/16QMcvc4J2ul1qAKlDBKCL2bbDoL8?=
 =?us-ascii?Q?dCaPHE5DH5D4Sq4DVE2jTYK/bqcZ19LeSerYEHjf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48316849-16e8-491a-0f0f-08dc2881dff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:42:25.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9tnsXSCduV/x3e1FJk+ZiDXV0w1hXGMOLWIYGegoe8E4fcK+F/FTymDDybN/ZfR6Udtr51BTEiGSew2jvghgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> ATS-capable devices cache the result of nested translation. This result
> relies on the mappings in s2 domain (a.k.a. parent). When there are
> modifications in the s2 domain, the related nested translation caches on
> the device should be flushed. This includes the devices that are attached
> to the s1 domain. However, the existing code ignores this fact to only
> loops its own devices.
>=20
> As there is no easy way to identify the exact set of nested translations
> affected by the change of s2 domain. So, this just flushes the entire
> device iotlb on the device.
>=20
> As above, driver loops the s2 domain's s1_domains list and loops the devi=
ces
> list of each s1_domain to flush the entire device iotlb on the devices.
>=20
> Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

