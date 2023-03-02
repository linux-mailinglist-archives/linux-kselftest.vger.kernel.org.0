Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55446A7C48
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCBIMe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBIMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:12:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D99234FB;
        Thu,  2 Mar 2023 00:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744752; x=1709280752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Wi5GwlmVHVZNJK58w/sToaByS5prdNR3IKjzvoNgPc=;
  b=iDdjFIwrF8Tefpa5ekOZoNPIMT8tN9SRsWzaHKxlzqsyLefso/lt6qY/
   DCTaBXPLYoeUTEcB4rKkxV9Mr2ZVVdNBsiBUqCXinm5GLOwrgPbPf/ZJY
   xtuEcjbrmDbhWJQX/Hrfhixip5pNKYCd2EVYdIxRTtcsg9xRn2iUUbw0l
   Hjrj2F6sZvuODZWxdtuPxkT5SoWMoWSyolQ+q48ww2pBCPi96OwL9alYl
   IUybT6cCMRTCVmIxHPJvmHFTeIWr7OuF2hpZ7bsii3XCzY+5DHTXGv+KN
   2TXNdzsyZyV5MD87qv+1hy8P1fkVOcEe4DlyCuz+vqv8Ego/6fydh4lZd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333378795"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="333378795"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738965986"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="738965986"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 00:12:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:12:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:12:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:12:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJfvq0fRq8QpGEOny6GK6BuXuQjCQPd4tNzAQwoY1suxkt7XQMbVxmE4rxGnQS9vtH/Ks5YtZifOTHOo04xkYJ4DOczQfQJ5i+Pre47d37lMda7I8SDF9JhyRZBCm+/yTmZHzbH88GEL2d8c13ov/jvfHAvBwBdMHYN3XAyhkdBxwO9izDXrvMn3C153/bYIwFI3mcH59rfxIz/pII/fdps6Tm7rCvVS07zyIVUa0aKn9qcL47U+Epcb+7o+ouhhPJu/bAbx2Prm2KY0FYr+L5naWa+0LM0PE5KB7wQvIuhlvfzq7t0iXU7aFXHfTDo3zTQxuUuAxEIy+XbtQ0Lotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sh30DFIGfnOGDKGt96iWkIXGFFJ+eWMKVPJKZf+B3k=;
 b=VsFH+doA5ckW/k5ZnIZcaX10vV7RK2XsbA0pGssbSCQ3eNwMFKx8wAgHLhA0Wqb8gmmEOCiJXotueQ3ooVcvCgeF5GwD09dadXiJ9nSKKE0Zb+aEpYQoSxlu8c2+AHUAtWLkjnMt0kcKmhZ9Ou039MF9rCELOPkH9YJpTf04JAjO2pa+k0vGJwD4axRAchE33cxrJhHDQIh7VHgJbE/DfEfpxo6RC2hz/4Ogxzv9sweeTtvbEtn9K1sSBmypqwf9ccuyu+PA0OIuJCilpfO/MVT3mBuRiOiM0ruedNRN/YbCTVPx1QgMWQRjgg3ORs1aBn8somT7fmJ5wYFgvJZ/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 08:12:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:12:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 06/14] iommufd: Move putting a hwpt to a helper function
Thread-Topic: [PATCH 06/14] iommufd: Move putting a hwpt to a helper function
Thread-Index: AQHZSLAOXmIUyw9HXkOI9zskfeBLvK7nK5ww
Date:   Thu, 2 Mar 2023 08:12:28 +0000
Message-ID: <BN9PR11MB527614F2188AE6BC5289DE1C8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <6-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <6-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4860:EE_
x-ms-office365-filtering-correlation-id: afd2d259-539f-44f3-ad1f-08db1af5dd7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFUArXU6fv4B5cJwhBANdVPXICZhYx4Ds5GkiLivdk4gex7NhPuCMZSs8bAVrpjf+d55NQBgFXxoiIqSKccuAOW+nJ/+VbQ2PwCIQi3PMSVATLe9u3m7tImVVHiBRZfG1z+GGtoilWrTpRw9HqS0EBFPg/rcoo6yvQVtqdJnxQEgVvazIWIGCKfJOzYz5uVvUy7FkDup0/OaHdixVZqSrt+1pwGna+Ft/E6qL4Nng1hJ8Oh7PDH+cijCCi3e+PN1JeQ/BevOeAv64Y4pn2FleC3KDkpqpB58TryBHPWp+6CI8DO1/LFDIEV1XLs3yaQR1fYrlJLeDm1/U26a1JHLU69KqEtp0WVqA/qdb0pt1TsoOcHoELrhBSpVmSQOhgYZx+Fv1nfRWCDdjRvWNOI8iX7SKbBk3yT/+eEyKDRyzYMAfv2g3ZSGSrCimmOlZ1WXAKYMykU6PeYitcga06iwtLtUfM4SokILMLWXZUoIOS5rydb5AAe8xocwhutlcAzeab19v8wAKlyGi3sZZj15V8om9+JPyEK+lZsCsC7sGwNVYDlktwCB9owL1n5bPlnNWQj61vboH2iUfuTfkkMYMWjc0AnNlltOa6zvhojfUgNOv9hfB77cznKkL/O8taIB9aC08omoUxHsHtN7zN6djFhGuyBhddCYkGAE6rwOd3yq4VehCyG1uNfqRmwIb7HuEojxKUBGmGgsa0QwIYTlcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(83380400001)(107886003)(38100700002)(122000001)(52536014)(5660300002)(8936002)(71200400001)(82960400001)(478600001)(86362001)(33656002)(55016003)(38070700005)(186003)(26005)(9686003)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(7696005)(2906002)(76116006)(4744005)(8676002)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7yOX77eo6BavRKdnVdGHQbu/+AxA9oP9+avwcTMxY0D98Slq4Eiza9waRP5O?=
 =?us-ascii?Q?bV45BH/SxAQon7Qv6ezGuavqrE7r3YiKvEcpLtl5UHnIMhZA4jbtavy6Gd+P?=
 =?us-ascii?Q?E1tDijm5nMHEZ2OpswCgZid9AI+5WCK2BrGg0HwGaMq3gAADzlCAFbPWS53R?=
 =?us-ascii?Q?IZRHd+Tgr35irrG4z5Nlg7SYloffv7sQlhEJfKWG9j0n2zoK73lU/u4fpaO6?=
 =?us-ascii?Q?sFRWKIgX+weJqiokpFh7G//EARWSkuSN2LyyAId2vmbNkgziRlm14mYKj3gF?=
 =?us-ascii?Q?Lk0NHt2C6syakyeMqfu6hHtM9ONsg6XdMfniRTex2tWD3g8NDDiI5kbBpDeK?=
 =?us-ascii?Q?epR68/IAIwUX1LyItXSu5bc/fy+6YIgh/dW3u7g4xj2Plzdyx5ZDMAo14iAz?=
 =?us-ascii?Q?ztGVcrUQhFHk0QAndjlEFb+nwoMEE4mFJsTAB3iHzHalmsWKyvq/kQrx639j?=
 =?us-ascii?Q?JcNicA+k/9JcrtbZajwQBgXRf7HhNyK07YgmcpQu8WEw6aH27btr3+UjkjC4?=
 =?us-ascii?Q?xIiQuKqDFWzm0WVR9UinlSApfTLYjq33qRwv1fcKWThmc2gQ+ynUMr87ckcc?=
 =?us-ascii?Q?9n+BTl/Yr6GOGgLsxm0rlcS2ny8ZoYO25KdgSWVbgLM5OeBXq2JFx33mXBJF?=
 =?us-ascii?Q?ccXPuFJ2J4nlyLa5PczCzc8BAZe59ApppMRGAyYGyYieSQ0i+49wPEeU/nx1?=
 =?us-ascii?Q?t/COgeavL9GLw9hzE/QakRXtnZP8bRCk6We7mkCJWhRQWp2YdxOTgZtX6GPc?=
 =?us-ascii?Q?BjKmtz8zv6DQ1yhoKXudRcD2dzPl9wDePqn2LSMuyplsjstBv45Z36PzTKiF?=
 =?us-ascii?Q?+L3hQwhvloPPkQWXRgzkeeulok1ZEQ1cFaU9rQW4hUHkWQtK0qS5VQ1KdO+v?=
 =?us-ascii?Q?53On0GEjPvL9MEjeBfosoxwyBBXRc7WjF6Z9E8UeeJVd4ELM/qf0UjoTY43M?=
 =?us-ascii?Q?78OfFArY2a2NaPyG78umcpc7d71c0scO4IL/8LA4G5vFJgcEqBLDbCpGA4qn?=
 =?us-ascii?Q?mJHY+QIu/Lkk5FDqDme79H3eaKV5vKW8o+jw1RUHX/urI+lEiiSD7MpAo+uc?=
 =?us-ascii?Q?BDjcl1BQGgys4T3j4SH4EdTeSmvijZgyisTaAAbsqxC7zxeSVWIOgE7gMiFa?=
 =?us-ascii?Q?AZVCrG/4Q1SN6q97+31tMscH6k8ZaraQ+WK1pfD8NmCwchS5QDUD/esHMQvg?=
 =?us-ascii?Q?FU4o1CJIVeIsJkw/iYSPsa3KqtkCuto5ETq90sadykIIbceQLuvaqO9WVUGZ?=
 =?us-ascii?Q?f1t+Oc5MwS3SBaQC9l4NYNY4BPQ9v4mY8+mZLPgXoJu93hh3WEuavJVECN6c?=
 =?us-ascii?Q?+MD9vcRVHSOdVYAfx9OFlbDg+yVkQgNsPN/M0+Mb1Kzs7FjgeZqI6arZrhwS?=
 =?us-ascii?Q?pKHkqus5pPQVkjNsNRhkergBqAuMEz+4bh4tvA7jkYvtJL9W4UtyhVEfHajw?=
 =?us-ascii?Q?r9mtOPsjHKUcIFxKyBbC+6BZzG4CiXmDlZkmecXzp5801f27RU5WvPq48ffS?=
 =?us-ascii?Q?f8WIWni/82P0Zt7nddI2UKNSFjQn2SCSsc6czktmWuOv8PD7nwVUzOlcKpfp?=
 =?us-ascii?Q?Q3NpB6i13rvDxKmyWmh65dVIoiox/LlnXPiiIGGJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd2d259-539f-44f3-ad1f-08db1af5dd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:12:28.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZy12vBEozyhCGTD9UOjKlPkKB28yB0bux1w6YJvUGlUg4fYRcqRQP/U1iEi8JranR1gU1AEZrHOBkcuzP0eyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>
> @@ -481,11 +481,7 @@ void iommufd_device_detach(struct
> iommufd_device *idev)
>  	hwpt =3D iommufd_hw_pagetable_detach(idev);
>  	mutex_unlock(&idev->igroup->lock);
>=20
> -	if (hwpt->auto_domain)
> -		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
> -	else
> -		refcount_dec(&hwpt->obj.users);
> -
> +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
>  	refcount_dec(&idev->obj.users);
>  }

As commented in patch3 this should be called in
iommufd_hw_pagetable_detach() when idev->igroup->hwpt is cleared.
