Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2968FDA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 04:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBIDC5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 22:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjBIDBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 22:01:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C837B4D;
        Wed,  8 Feb 2023 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911453; x=1707447453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=khfiQRG9pgnPxYUscU34mN/SP18T6ncjcuUhtnuAHIs=;
  b=JCWYQJLA7XZW36zsJ3JjivjGrzfjXl6bCIcwm/46rB2dk7rZoMI0dkWo
   RnUth70tabz28+ZcKqolb8pyv/Wk3m7P/C+uw8Lb66nHMc6CsQz9wd/FM
   eSr72Kka/t7N7Uq8KQRxkzBtju/c7PgWm/c0+dGgLUzpvoanuNS2h5c74
   n+L0U+p/+VgtHL8o6RvWVI0rs/o34DmUeW+goj/c3HAZTR3rrVUdtffx7
   O1JiPhcoIzqQtoAoHRoZP+hoydfH8FMCq4vRJluLsjK49tdKPBm9ds5B3
   F9UOv234ezP3K45/4JZqJfNUkkWjEtq1TSQSLPxfaKnJVgipabRUcT/s9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392384904"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392384904"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:57:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776298974"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776298974"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 18:56:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:56:50 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:56:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:56:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:56:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hreIaTjbF96a/b4XO6TQWXLrJ45L4CkkSLK+9p7Xy0ezoP+k1Z3yxqbzYROOgmq9fh+bBYRM2W9hliGQAvi3e8n56t8mGxGyFQjTtnglQVtb1y1pS+vROP3yh5z8P5zSFyv8J9ewW+dasoCBlnnF4fthvWN0UpauqJKER4UY5+7NipCrpL2+yRsMOZHbqOSJOp6B8pQS7HwYJavR5SfHhxbgBkwqGvQj4V6X1+qq0Hra3nEBBqT5zjaYsqUHzAfijzKfD8IoiiYlhNsRMy0jshZEVl3+9X3IiSWE2fIJnCwE0Ri7Bft+IXSIHVYUvB4pQlV9LzgR9+WnTJb8zTkH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7+c1niD9ZdB+kryMW5aNgIxJnJY2AmouBctvrQdLj0=;
 b=PNbHIUh2NRnl+CEXJsc6noZmKDMwAq8cVhh3DHJfs+JPL7m2tOHhxsLvOjuMi0upFZde+wZP2wd5dZwEyfGT+oZ4UMYnAXRiFljejgpijyucex5aNA5gziY71ZN0cOlcmafrSP9L4ygZ6DoeXeQS0Exox4C3LaUNnQy7LtXZyy7wiTH7k6T4VfiW3MZSnn9lwUJs+fty4mm1dnyIQZ+1QLXBeUIRxYW4vpEUiACNC6kMQnec4A0bQ8/nufOVscngxEgCr3GWGjesTEk5vb5HVYbaWg/VnBCyIJ19X6QJRq123XM0vntieIPCmwyTiyXyupOVYi/QVhXLti3L/pN3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5544.namprd11.prod.outlook.com (2603:10b6:208:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:56:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:56:39 +0000
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
Subject: RE: [PATCH v2 03/10] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Topic: [PATCH v2 03/10] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Index: AQHZOzoM5El+JaA+Aka5+yDNWUDRda7F7ZHw
Date:   Thu, 9 Feb 2023 02:56:39 +0000
Message-ID: <BN9PR11MB527662B3BCB562D4E0969C878CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5544:EE_
x-ms-office365-filtering-correlation-id: caab7c7a-0027-4e18-2c16-08db0a4943e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T/jYzEZZUXStCbQDBZa3L12jTrZmG1Rm6+2s7zFRvRy9ED9Ttnpj3MteJDudPbumjPPqtgrOpx4KLZmUsEG2jKYhZGoIa2jrpsYDAFPscNYzoxhpvlth6UzDsd8n6DlyirvA14LBdRp/dymD20JrEP1nVjj4j5g0kKCtP3NeCtgg03X/PB7RLUvPkTDPHMkC27CJAHFT4SEXJX4FJFwEnih14w4THQapA5xN5RCQIejaeO+I364MRAuJz70hZWIUMIit54scYAfpakUCbehVOg2wTUxtru1SGbXVIPl4L6/hhWN5pKG8dHLLYMvdcsV2N3zfa5273IZM4jOzVAh4izLvcLRHupJmKwx8YHwy0hXrZAhk0KIOXuAMPYAXt/htHSIjZujxvKjmAwy2hoJwB4yutJDFR57nJoujhHCkZNaQaKGMkqPisCTsNLRo27DZRYB3egDjRppbM9v/lG8mSrpnAWD3E35MlSMSR1L+HxEjZ3RJdfvs/x0NaZeI56fn2Rb1g3uGAe4YxpTgNB5Hbo6mchChxSdbcyG/VahUvUW6bDvqc3safC6XQ8dALHw/S14XtbzVsFC7nbcUdi9hNUASsWMjpCylm79iw1FrwBb+2hC93rl+bYXsngNzYPeOuUno6ANbZnI5Ooi+7PWBb/cv2O0UZ8Wt7DMmx1lYMxsz1L16F0jdRuQhfIlARTj72oNwGLn0bmMp/rSR8FtEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(83380400001)(55016003)(54906003)(2906002)(316002)(76116006)(110136005)(38070700005)(478600001)(82960400001)(38100700002)(71200400001)(122000001)(26005)(66556008)(66946007)(4326008)(4744005)(8676002)(41300700001)(6506007)(8936002)(5660300002)(7416002)(86362001)(64756008)(52536014)(33656002)(66446008)(9686003)(186003)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kj/yGaldp6J3RsTih09MmQk+avPGJhjTtzJ/4J09ivncysLJjPdJLO3HY/Xc?=
 =?us-ascii?Q?1XDIN43hBrZf2Xxu1F1I8xpiCzbGuVTWdhEy4peWZbiyA5PJyugsB5oIan3j?=
 =?us-ascii?Q?BggU1lL5snhNodAp9T3BNvMv8Jy6XaLEKENdCYKnkGmFA9EIqE9WgcRuU00f?=
 =?us-ascii?Q?yvnHRi3mmzOdDtW9AqhBvBfXZ0191LO2hct9xVCuc2O6PcChW8g7cbeLh7l+?=
 =?us-ascii?Q?93G64NNaUeNSFjV9FNTaDSCaMsWQ2T5tfiHfy48zJaz1kA1oZvA0F2TGIYGq?=
 =?us-ascii?Q?q29QY1DLKnpig3tfHkSyXeLrXnwaPnjEJSowCcdgUOEri+pz15p9yQGRhok9?=
 =?us-ascii?Q?Yc2kNT8Nn/nNLq97968G5N0mYRw3U8eLWfgo3UkVsUuuEOHceNwNseFsCcPF?=
 =?us-ascii?Q?VleTVHh/L+s9oAlMc7EspkQaXuCbH0XUQbo5pKkX0JHkOlZtJp7fyCaZ01zm?=
 =?us-ascii?Q?uCiCeYpJFODxmk7+HYNHqhArfPm1KRu1sRaepj9/BQPeFKsKznmgKHT6Qa5q?=
 =?us-ascii?Q?nHJlIAz9gF6elK+gRbaKtgmIMm6UPM2Lrc5Sm8FTtxcULYdLnPmVwAsLkWaG?=
 =?us-ascii?Q?lT0+fVsqtd1129h20lou2InKkypfZGZgEDkzowgFuKoXzGZ6IBTnomMdwlUB?=
 =?us-ascii?Q?EGIP98rn2iWZO6NsDgGUl4nG5qndP3+GRq9pgrq8eVDVQ/8MoE+qiIHhT+bP?=
 =?us-ascii?Q?phGR9lRH5RXEZ6oXij4+Rg61PndHMKlpiDPlJ1Te9Kx5e9DS3UyJISo5o+Et?=
 =?us-ascii?Q?Mdo7ZX+2jQNWJzHEgF6mM8lwWeX8GlJyBosNGQ8ErvpVXJZ39LpMbS0R/9yX?=
 =?us-ascii?Q?yxniz4qOxo+BxnbdRqnYDVoWJq7uM0jlehso2AJbg67tvieQTnCHDL98Hs6g?=
 =?us-ascii?Q?HIEcawV+M906YI66gttfAEzktuw96xrIIZZZ+FG3u1GF0TAcCCYE7tvbZoUa?=
 =?us-ascii?Q?40+KLaGVKnIJkq+xq+3kSR70DS/36HFGQCRooDZWtucTfUg03343Fz9jC5+y?=
 =?us-ascii?Q?17UTvAJE1L7BcuCj1Xrgf81fq+LItoJJvu52WyziGcs71R+fCDRRqZ1GtJri?=
 =?us-ascii?Q?5e7uSEeqzAIJOjWIBnuqv81a5rdstfy155nBBgHe6GazyQw/A/WjALLsmKCy?=
 =?us-ascii?Q?GxpbGhVAqjLmORGanR1ovIaPGt4SwL9smytc18VwFm3/EHA3pHm10Xg8/EuI?=
 =?us-ascii?Q?cBHdywmPm4SvSMBfzDIG8OJrU0R46Rb5Vyjf4niMZYfkA0NOCEUngPzYteln?=
 =?us-ascii?Q?Vbibk9OeKcwnI51Xh1bJVtWWB5lpz/hHosPrBWGS8olTfxJCgVwOcItAAvYV?=
 =?us-ascii?Q?mXUU5GorxsMxD60znkb1co1hmBahEBD60fBdnRLCBMdWLg0f8e7koang71Fp?=
 =?us-ascii?Q?ESTCPOQjl9lPGzMthmoo2l2wU59nIaarI9t4IU5Vs0od1jMHQuGSH8Yo3KHY?=
 =?us-ascii?Q?sj8tKgODWyZARTglvHYSgjj4bDMD65HUkHEXfo9EDTNJxnk6QEaQRuMdpIy4?=
 =?us-ascii?Q?p2RtxNNGEjlHBKkoHIC/XsuEBmuKhMHWsI06lkOmO0DniUVmxxfAQ3cBRE+S?=
 =?us-ascii?Q?JN+dro13paKKSt7djLzBANbMbQYVp+lwZCcCH9rt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caab7c7a-0027-4e18-2c16-08db0a4943e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:56:39.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZN11YOTeFjen3x1deDFtoqL6WxDTc3Gbn8DFSpyNy0c1f1z970/WQmyRoAUOSb5svr/NxgZXteSVHD2+p4sUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>
> @@ -141,10 +141,19 @@ static const struct iommufd_access_ops
> vfio_user_ops =3D {
>  int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
>  			       struct iommufd_ctx *ictx, u32 *out_device_id)
>  {
> +	struct iommufd_access *user;
> +
>  	lockdep_assert_held(&vdev->dev_set->lock);
>=20
> -	vdev->iommufd_ictx =3D ictx;
>  	iommufd_ctx_get(ictx);
> +	user =3D iommufd_access_create(vdev->iommufd_ictx, &vfio_user_ops,
> vdev);
> +	if (IS_ERR(user)) {
> +		iommufd_ctx_put(vdev->iommufd_ictx);
> +		return PTR_ERR(user);
> +	}
> +	iommufd_access_set_ioas(user, 0);

this is not required since ioas has been NULL after creation.

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
