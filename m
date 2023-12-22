Return-Path: <linux-kselftest+bounces-2343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831A81C390
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A42876A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A048EDF;
	Fri, 22 Dec 2023 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQMPu7T2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49F184C;
	Fri, 22 Dec 2023 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703216385; x=1734752385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0mX0Dp9fMooQk3fH5t8EDrFPCqqMArV2bzsFosxS2Fk=;
  b=WQMPu7T2wL8fxndHB29xEQujNIKyAzqPZe8oNeO78iouRARpsbGc29Ou
   WvsifrlCuvYHlQvq/gWE26SKLZug9CbCyuDHkQG2g9P4DRSIIcWaBn9mw
   8uEj4QCGqc1fnTXiJETDiUT7dYA9N7saU3Ilio4VfV8j6q17ugt8vj5PU
   uAT0QMvQFmE81Q2Zwpjx84LNTgiPAP+uWy2sOQJ36P22LSejGzdgPd1JP
   0/DZ1g+RscQBpeyg1TWB0qCicFFtxvJL01k0DLzFcWyREndFj0zJtMA//
   3+cQfxofEd+yMMVBIF7BTZDPp9aUrL5pFHls8ZYjtuvax/3zSmdJ/Whlq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398858728"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="398858728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25206068"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 19:39:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 19:39:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 19:39:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 19:39:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M17D3n4L96RyE64dJQtpwSjOQeYND3Go884SXZkjjI+Y4hLWZ1IhF6ciKaPBlvD2B6y+7OfYhdPKE1XNRZcuzt6TvaMIY52rG1hnukXMrnjsvb+tjCkvUR5Wj/Vwq3lxOPGI0kCwscMFxrQXpWl+/EpupxGCvb3064DrAl9Udi7dMGepEo9Y2D4c6VZXe2ahknGI7fLdNdjtxx4pbtnDpC78mhXmwucw+Tg6UGm2+CyT4/m20I2hW1KgAJ3d9qbhQ1dyIz1l14wopTrxjFQehe+tKXnOb+q3yOiZlpNROjR85jZXfC0hUPfvkkGXKCKWfP2HB8pW1D0ZoDq8ZeHG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0xu4ryeZQNFNzHZuilvHrn+K+ZWZD2A6M8Zm+uHkGU=;
 b=JOx9qFQLTrF18P7pxJBmlBm4CgsmEGT1YcDN+44LJW/odHKWBt8KtXhFXRQ968aqjOszosSIem9q28rjpLnQ/XFMOc5RMpB4wgQJZOA+oooAw0RNYL6s8xI1JubcVk0iwDV0Q+4vrNA0v0Ie5nSH/ADZF6iajtw0NnJQX4xZiHjwY3FJgclEeXTuy92buqzYu4+U0L0SIYsm9vVlPeLfbLxEvtpOdKcuAgMw4Hwjpt8Kt3qFZ6TIwE0R9SgKzhlly8H8ceBUtigREu+ZesfhckzRIJeEIa1FUwwFvVVgE0aYqZzQWPlfVQxe+/lgfKYEIvLOjvmzd4XFfA36MeO5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:39:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:39:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 4/9] iommufd/selftest: Add
 mock_domain_cache_invalidate_user support
Thread-Topic: [PATCH v7 4/9] iommufd/selftest: Add
 mock_domain_cache_invalidate_user support
Thread-Index: AQHaNCP2IX56eLXUyEyhwzd2QU9HVLC0qCWw
Date: Fri, 22 Dec 2023 03:39:40 +0000
Message-ID: <BN9PR11MB527659B1FD68C7FADEBD04548C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-5-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 693fe661-b3d4-46e1-57ab-08dc029fa163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IEuJd+lSiUbp4JQHM8dOEFaUPyt9BhqdTvCx3ssLeyh33pb+zTh8/wxBr5NcmUatAsd93LsQSe//6hCEcJ7u71Oe3icqP7/IU4UwRp69ryUEMzJXGgOUv1DVd2q2iGhY31aVo/TQ7aTl8G6s6znKjX3i12GOnkfE8Vg/4LXORfMyRuU6mtcAXxm9Gldn8OuhM4WJQYCbi0zRDd6zasAw/eEUwBaf3lp4uSb9kkgsD147IGCknf0XMrncfDWgOsxa2P7DYN/J+Q12OJHYAap5Aas5HOYVi6c3hVftjIR/VqSkh/WWAOOiNTdSrD9AK6TgVWccPyvZgOqlfvq7DN57bsNP4e/JcirNKkefLv6FcS2DO6TWm4x0gLxPc90xW/p65iNXbz/y/+0YbEtZKcRP8Dyfl9kKaoTm88wzeDiZwxkiYPXILyKdBGEW9BpSGO6wv9Mr4VFeqt1LO4N6k/cSY1iI3i67qAWumZWfMeaq2R78zuULpkoDznblrr3+zi7nNl3JVv6owSd9971GlEbFIm8SEy+l4ekRZc0jfkgZzMpMZX1q5ELvwIUCrYV3NZoTI2b4/+nIrd0bRXP4qLJo0lUAgi4BKMcuzB9O84GkK/PcKMEq92EDLLfAJdu5flBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(55016003)(38100700002)(52536014)(122000001)(4326008)(478600001)(82960400001)(5660300002)(54906003)(110136005)(316002)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(8676002)(8936002)(26005)(83380400001)(7696005)(9686003)(71200400001)(6506007)(41300700001)(86362001)(33656002)(38070700009)(2906002)(4744005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1huprOwxwpq9+3N027Pv0TrOrozn4/JYwFjnlrPF6birI9UdiW6MoolWYdlw?=
 =?us-ascii?Q?6DLWtz3+yQeiDNJjTBO5aEI1MXoEDwj0oArNeXzD3rT9KrxIn/UinPZUxq62?=
 =?us-ascii?Q?MHIxI+Ixb1ViDX6d2XK8Al9f3Yg4I5jPsAWZRZjRPxXrxwIaRK87WEWknUC7?=
 =?us-ascii?Q?B4vKt9IcajONtt7jZY8fGvC9K3U7kr9mjHTtha3iLoubej+9rUqnO0azZUkI?=
 =?us-ascii?Q?iIZjoAI/FwZqzOobLO5Qhx/f8CAnnlCX3lcfqZfn4bUm+vj+BxMQVdUcKCxW?=
 =?us-ascii?Q?mG4JCrfoggjWXpM1KqIO1LUe0UE1q3oc/Kjvqlsb9gcCkFMxeThtd6wW5H4G?=
 =?us-ascii?Q?ZrnIlVwE7bgcQQFRoRnioSTmwPAAlHy/jgB0S++imhkn9Zi2/EDcL22j1xJ1?=
 =?us-ascii?Q?9Hyou6UIv4U1oI+tP21ThYPpLH50+c+GdI7qtJw1ttEnL925E3rqn16EHxY1?=
 =?us-ascii?Q?PzC1aTAjhBPRSa9upb0Phni1YKm4kA7XyL//nPcKw1fiWeVi1X3P87VlHyr9?=
 =?us-ascii?Q?aAeTsBz+tUhM6l+Em0rCcy4ruXOJ1WBmklLd4njOMnOlUuAbnw+fcEHLjfVH?=
 =?us-ascii?Q?SYdskcJwr2l6ag2zaQ7IEIF2U4QX3ao02fyrLl/gSwosfrkWpBWsag3UH77n?=
 =?us-ascii?Q?+t3z/CTq8qldVoMLgYbGtw2KQAVMPB+e2ptZ7jECdpeQjV0V6A1xvlQhSqjv?=
 =?us-ascii?Q?A82i9SeyR6yCMPDizvAbKu6/9iLsL2OCmyLnAB0mYgthsDH1D4dpj943Rx8z?=
 =?us-ascii?Q?kEU4VVswvyHjeCrDFcSIgR8Wcb4vqwukhtqmEtbCphP/WB6FBvMF9KvBrFCx?=
 =?us-ascii?Q?J+4McQEbfZaa8KmGagX3Sci2USSUpQKBIc1Z5IdtcKYohABL/KESYDSnagFi?=
 =?us-ascii?Q?6zLJlDJJiN1SsgH0IOXidKIRB44UsNbfhpdV1gzXsQREywIQxKWfN2+7raeY?=
 =?us-ascii?Q?F98KiAB+lnqMfdnW4VMf79/3n/3kAzJX9RWHhtWrsA+DQ9fQXQjiuIZNo/R4?=
 =?us-ascii?Q?+dveFsHdDb+BdpA61K1zofOVa+WfXrQZn4I0O8+5O0ATA3pN6rEoA2SdLDSV?=
 =?us-ascii?Q?4/TQQ8vZvz9CISCczWKyGj2kYN6Y9OTXAjBfww68vE8oOQI5jzFYzBKtEJL4?=
 =?us-ascii?Q?6jgP2kjRtH4lCiXU3/e7pJEMBh8DRwG29lo5I9P0s2xO+6VuQBtDqhGuFekP?=
 =?us-ascii?Q?GLu87GMBJ9iGtacc29bZnV4vE8IXC8E5KD1PBdqKKSKzjUuhN4MINgax42YD?=
 =?us-ascii?Q?sV1iaNgnNGOQ36bI6/lEpMYOIT7iUWPtKfzJkVdKaL8LC0GX17ZdLb5jh/iE?=
 =?us-ascii?Q?WBM1ZGmZ0tjKD88WL+qUMHuRKq2Tg7zHLkv1bha1K3X8I09NT+1rQmAzKyw6?=
 =?us-ascii?Q?GAd9ZaylfR5gu/EyGk6PL+lRzzdRdk1t4I9n9/Ig46uCbaZgSeMkxz259emQ?=
 =?us-ascii?Q?v11a0SekpmES6vpJyuLfrsGm4S08QeLiniDWpD1JdoAEHeelfomXElBJQXTO?=
 =?us-ascii?Q?0xgyqLkSlXjjYkeuT+Jsd88Zf16AZz+TeO5kR1MU4n85NHe9E+BgZlslmGRT?=
 =?us-ascii?Q?Dv06kDXes+QZVP8MS7TFI7Ymo2irRSk4n58Y7DLr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 693fe661-b3d4-46e1-57ab-08dc029fa163
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 03:39:41.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJT4Tz2YybDiDxJG2s4kkW9WffQ3L9wgFsVAkv8ilHKdgkRV/jYWUxYcsnToG6fq4nX0fTxKFp8lDh3uohmz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
> +
> +
> +		if ((inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) &&
> +		    (inv.flags &
> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR)) {
> +			rc =3D -EINVAL;
> +			break;
> +		}
> +

a  nit. is there a reason why the two flags can not be set together?

in concept a mock iommu error could occur in either invalidate-one
or invalidate-all.

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

