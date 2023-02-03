Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A56894D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 11:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjBCKLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjBCKLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 05:11:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142D8F276;
        Fri,  3 Feb 2023 02:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675419065; x=1706955065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NZc3sWmhNqqgvudBA2vvMYvYonmLMsniiYv5wfZrczs=;
  b=KM1VUwWvABaa1TpK7hTi9PRqXe+amVyz6sY6VIcwE+c5m55mw5KpME+i
   j8fgto9jzcTj6Rx7p7MP/gbOiu0SFtIWlBZo5uUN4ljbpoMC7ZBj5JP/b
   vsTg4nTgHp2P4W4rVi7LYL5/7Y0S5vxTckyxy0CT/CRSbYiej8TVzNf0g
   ObDfIwy4CbcdTeh6ow90McCBy05zpaap6Eih6NyaEe0H+zm3WBsrqMFY3
   MuerkkDZHN6bzMFJT6Sd5DVO9+GUQMP2YS1UbGoh8wNN3VD0WQ8QWx7ML
   BEbl4I57rh6SUjv8E33ahomEUb29bMkKOJ772jUnPeBuPxdKQu0fM/neJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="309046123"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="309046123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 02:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="754426966"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="754426966"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2023 02:10:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 02:10:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 02:10:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 02:10:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 02:10:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9TM4OVQQE2ncdFMYWk5Tg2CXEA7Y3Td7504CEe5jQkFjGzbQPfJnp+ATHbnh791rIEGy1t/A2jKLLMb4l8E3o9J4o3Ef5uVrDroIDYya+lgFQLbwRcqRM6vGGjuw8k6LY1tklgsVAYkdk6DoqoaTS8yV1Pa9oy5u++mru8SAtmPioDW4lfoS0F/b7hWjMpdDkCBjoj1e52x+E7bfNEHigxijcMQ3JVmrXOp3Op8PXBiNOjekx78Tdn7lEPR/AYCdnd4r9oZ/1hX57Z2fG9MKCFOoysBzmLPsOceG5ieJKRY7F6bnlEy1NoN0AvzXPgjjLTIiFDZhcPjYn+xaTYcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZc3sWmhNqqgvudBA2vvMYvYonmLMsniiYv5wfZrczs=;
 b=Wg6DSxi1B4yXxC1DkUvaTzn+2SwkEvi+x9t6bFDxOnymW7KVEnzXVXuphSObPYGVBGbkPpCdG8fvlgtQymfGj3/chRBCkfsHhP2hfEwXbQhAHGZe0Kaxt99i1x3sE38Y9ASH7qkwOJVqUrHJRQl4Yqk7dYwFNLEiCfUGR4KOZFdtu/R59LT0qQ3EuDut+KmlmMTFxUms02dIFfBrWz8yNlqvzaEVK7AJzP0l5fvD5QsCJLYFerLKQdMhn8v301Qc04glR1LI8bHdTvFYD1kE4llz6Fm6EpQS3sbT8wguhKVq4qnnEtVbVGWX0VTNFoloxuSYGz36CMqhy5yCNxCJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 10:10:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 10:10:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 5/8] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Topic: [PATCH v1 5/8] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Index: AQHZNtTKuwaQ8HB+HUStrJAG1SXPAK68/SpQ
Date:   Fri, 3 Feb 2023 10:10:45 +0000
Message-ID: <BN9PR11MB5276D06D3F9AA6202E20F8E68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <bfe5aed6d354ef547979f0b256c8a3f9bd5b223b.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <bfe5aed6d354ef547979f0b256c8a3f9bd5b223b.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: 1e708b8d-916c-47cf-42ac-08db05ceea4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRuNdbMA5/S+UAjRD5fCyMy14us5klagS/cxncFBXgaJALtFl6vRSQXQAOkYDFyg9XoJCHkMW2JhFfoEomZTf5e4yPISkTJaD596FWTEKTjpYX0pGHFbIWXnXE008LY/8MWhtXCF5MQWRDfF2Vzsw3y22u+1cnaY+YP/oxjP0iYj8DD/bMvzUgpdHF8hNbmFCtwPuODLcZ+HKEhjYZrnMkfMPCAxz9BPg6KvHIzfjBl/W0E6gX/PiRslHHmP0HCbwlrrFJBY+o130vnGHig5HmIO2NkK7QaNy2ijrZd0wj4WWaK5JBDqi/JSjgYg/b/CR0fCd6yBfPtLAyRbKicUyp3DNgdxXCNlp9tOa4e2mpPYeVpMI5odQUa+QF+OYlWdvlRZ7wAM2cA5PpEgk5Q76a8Xc9tp2JmHdnhn0SfRLCN5ZgUvpC+5FWcjw0/yVA0ugI3h85gM/Zxa3Y1UNHSfa19AV+v1DhldBML9jczO8x+Uq+mVC2wcASvUOBoWd3svWTpRHXfXAOfhoXGq5VsL6vZ3n6VPdJgQYPmDRfwFQ4YxyPCTf3VcZwQb9Z3UwDRrHo8XSR9AF2AGar+bJvm8eMOGe8eA4vQRc3V2ucchZufNycSCmfVFZXDaH+WcLSmRBv9V7uRd+ePDBqDOR8zUM0rcis9SyJcClkCmKx1sahI93HdrsjH4tfROQrqNGSKx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(4326008)(478600001)(8676002)(38100700002)(38070700005)(66476007)(66556008)(41300700001)(66446008)(76116006)(66946007)(64756008)(83380400001)(82960400001)(54906003)(110136005)(316002)(26005)(9686003)(55016003)(5660300002)(33656002)(186003)(6506007)(122000001)(7416002)(71200400001)(52536014)(86362001)(7696005)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nbZedtSnWl5M9e7oYMdpTJVbEx0q1LhpBYOKGDWBPYtFbkHOyeAFVHhK5Omp?=
 =?us-ascii?Q?Rq9ioRtxGrZoumj4RmE1+ugdEpVp6qKfcy5e51fssvYozjYF+V3pS062XGVZ?=
 =?us-ascii?Q?6cZX1f4T5bgNwGNxzpNurYW/wRuCrHle7ORO2HIUBH/dVqHAN93C3JiFaO8+?=
 =?us-ascii?Q?p4Cb6fRuC++0H1J8Qli7HEtr4nOee6qxcwRbUK3zTIIwo9Lw4faME9DKXQi7?=
 =?us-ascii?Q?8+oQtxFWuFJ/50g1gNgcXoBuuuiuNcEBNeryk2BomMc8dn4zHj3tYMCIX+5u?=
 =?us-ascii?Q?SvePT9zMq/BkPENOECoG9Hx5VeSONEygYqBwGJFSF13qleaikGUNJ/ndc3UP?=
 =?us-ascii?Q?rfOdCkGmWlZ+fYCEFojR6MW8GKRQiumz6ct+yYqVGjGxhQ2ylLmFwE7rD1Ig?=
 =?us-ascii?Q?mI0tluIfKRgFzn2l3cJaHFxEuNF3s/A160cacv69P9id+IMqk/+ioxPY1ovR?=
 =?us-ascii?Q?nz+6bKCVotD9B53aIrOoIbXSLX8+DHHHPH+3FK7khU++ffGp+pNWBxN1E8qK?=
 =?us-ascii?Q?vlDfQYDhOOEb+yMrFr5Qd8C7HP/odiR9CoU0K9kMD6Zn3WCiwYdQ5AqSvqye?=
 =?us-ascii?Q?VHzgJSbVA/4FYPilZuT3729MWOcvbNXiz+wtmjT7nyn4qkmNsk/0kbjQcIKo?=
 =?us-ascii?Q?2543Xz/yZHAR1nHjrEVn7Kvfa7osSXs1Nuu2DeFVYeS5o3WHsPUOalADvV4g?=
 =?us-ascii?Q?F8+kTLD1p2hWtZPYII5O/L1G2hqyu/zVtTCcmuWfRlaSjaWjYJ6CfcK+mw5g?=
 =?us-ascii?Q?9wZxWm9FAZ1ZaJLHtZg5bHLzq/qMBhZICkBelei8YJM9Ry1O1X7ju0IupQJ2?=
 =?us-ascii?Q?VjUuD3oEY5109vl3i9/SkcOPnE4GmGR8wegLncXEEGPqEbIfg6rWYlBiONO6?=
 =?us-ascii?Q?LwBn+npfrRZXNlqnvmuapRnmvJW2+dri9GcTy+Bh+M6mzVXkpspPwPjYV+Sm?=
 =?us-ascii?Q?XeoyLB3sZU1pddEGPG8HOskcqGf2XrIwFmxmG97FEBoMtiL+tRE9NLTCX4Wv?=
 =?us-ascii?Q?MH80tH872tFOh1K8+HEpXiPjPn8JM4rJsb6sAmoKuLH2sIKingWrXeJPAK6Y?=
 =?us-ascii?Q?eMQZCctWzouXjNidr4y4adP8MEZTPGhjS4jYZoe1/AWKMQ2DTTtM4js8hTLz?=
 =?us-ascii?Q?OjUxiA7BdZNlRO0ShpD4uJqfvS6PeJ7IClrhykSSI9wR9/363qV+GpL03CCV?=
 =?us-ascii?Q?l6lfsXGrs3FKyj0+urdFeaBZu1aD1TWRe7FmiOIh9NvYzD9PYP7n7jn4ilxi?=
 =?us-ascii?Q?1n5zoN05SZZAg8IENDo2C0AVMDiR2krp/gxrAap8m6qnSWmJjEFFeWboFi3+?=
 =?us-ascii?Q?7+AbcqS/s+ZyF6xsy4zf+61SBELyasCD/VvVism9xDOiOqUB01pG+Mo8dk6o?=
 =?us-ascii?Q?s9vihCvyblN1EPY70tqMHPKgITtSxAzKOgA+C7tWSnWmaUWjlizlQdPHSqUg?=
 =?us-ascii?Q?KVEhm9DjSwN47YXRoZLxwNDg+FM/oHT4pk1Unb6gP3RSTD3CqazeHRnNsdrc?=
 =?us-ascii?Q?wKDbN6uN1AVGaA8v2x+ROGPPYaAyqoIXeUKP84VEzjTCiJ0GhpVdEpiM8YwJ?=
 =?us-ascii?Q?Dd16HNXlwJPY5v0mHF0Lexf5oluLHC4huhwbd99I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e708b8d-916c-47cf-42ac-08db05ceea4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 10:10:45.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAVqiDjozjlSIzKIJypbT0wLJ/JCbBMJPFERiesn/i4gO1D5mEUnhG/Jw7t9Vxalo+D8AZyVz5GdRRpD4mZPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, February 2, 2023 3:05 PM
>=20
> Support an access->ioas replacement in iommufd_access_set_ioas(), which
> sets the access->ioas to NULL provisionally so that any further incoming
> iommufd_access_pin_pages() callback can be blocked.
>=20
> Then, call access->ops->unmap() to clean up the entire iopt. To allow an
> iommufd_access_unpin_pages() callback to happen via this unmap() call,
> add an ioas_unpin pointer so the unpin routine won't be affected by the
> "access->ioas =3D NULL" trick above.
>=20
> Also, a vdev without an ops->dma_unmap implementation cannot replace its
> access->ioas pointer. So add an iommufd_access_ioas_is_attached() helper
> to sanity that.
>=20

Presumably a driver which doesn't implement ops->dma_unmap shouldn't
be allowed to do pin/unpin. But it could use vfio_dma_rw() to access an
iova range. In the latter case I don't see why replace cannot work.

Probably what's required here is to deny !ops->dma_unmap in
vfio_pin/unpin_pages then making here replace always allowed?
