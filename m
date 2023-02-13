Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9E693C03
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 03:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBMCE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Feb 2023 21:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBMCEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Feb 2023 21:04:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C54AD2F;
        Sun, 12 Feb 2023 18:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676253865; x=1707789865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aWHsYraLdJogNHlt+NZIfkUx7hQXNjE0GGYQeKqFmfw=;
  b=OGSW2A+MkPcZu/X8mJK1lmCmNXAonl5/ylHauN8KRpFY2m6yM4GMC780
   KKy17xmHimBxlQGGejs6Bk2z6pmtozxN2VxWkQuy8YIpIWgP+GN10m3gz
   2dkG9cwD3PTWXJ4IsZEuhMH+A5XHtCvzedNznalYSvS4zNmk7FEKAzfJJ
   +tRAfFPfGBQ9iM+ZWTPfbSSwYEy5zZfweBMUAla0+SPQ7p8klXhRYu0UC
   7hEsbMVrD+1h4GeCNRGQHFFq63w7Vib1x/vfMfGyT0TM9pLlE2EwaDZPh
   ZJhJ99SYgj8MOhOzSy2oYxSUkLPdmQqvvDUTXgORwBn6lvI3vy0ZJBSaQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="393189348"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="393189348"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="997531950"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="997531950"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2023 18:04:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:04:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:04:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:04:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1QlCpkst0OwzOaaQQw3vUqCsTa/nEq8K/PHSqk4N+cMdRsrHnFAgh2NqFlDTX1qkvxhEntrXm1B7nVapf0PuODBuTGpBfLkV9cc6Ts2JgehF23eviVxFAOUtDXkhqZCakJs4wy/KC8NZq0cMnSaivqwAmiysGZwZIk7wuaINgnKDfxouoI3mo52B1wWuDnc5ch7wKr7IVkxlobCy0HohD+U61w8MErDke5oBxd8wt0s1OSIfpnrLJLG8jVKbq9tD/gMGrcBgE3Sxi7Ej2mgobZ+xupi6AYPysWYPWH5j5+QKj3mT5pUy15qt7DyzfT546HZOQ53JJ6VtPNkaqoPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L75laEb1kXWOy2lTAQ4nOsqfnwSfJ6v5uNRDDg4P69g=;
 b=N8MK1yW9K9V62Q0ZW4qFJawKbn9yKHDL2EFmOTvL2QR+z9qadVg4wAz4FfZ2LvQRn3ZCXVaZlqkbcvHX5pxeKltkpRpzAtK9zMQ/LbxGGgkFh9cKdbnwH+ka7M3clgWGf1VXpgAvUAvvu2/8XVIKpODqEcu2PqU54c8gR7Lf0k6erSWCWSwY+aZiM3QBuj8JPOsGvAq/yEwxk2KCUbwxI3h3hz8QpcXTKOODaFBdZPzTgUSI8Gn+OfEGNYGRvw6zmrmUFsFjkSAHQzBiayMHuBr7egUa6BrDQAHvgBuKxpDTEGNB7uzrqX3Khey0EpNI0uO+KhUo9rJ6FV/h7hUfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 02:04:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%7]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:04:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHZPD1Z97vAUws+KUSa8kZdlVER8q7Hy2OwgADhXoCAA3jRQA==
Date:   Mon, 13 Feb 2023 02:04:20 +0000
Message-ID: <BN9PR11MB5276C3A941EE5EAAF58805068CDD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-4-yi.l.liu@intel.com>
 <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+awR7UO6R2FzHiV@nvidia.com>
In-Reply-To: <Y+awR7UO6R2FzHiV@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: c33cdf1a-df46-48a5-1e06-08db0d669e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZwOoNJmXqoMgBv3+MU9BJ40QTTU8yDK09fJ3nRilk0OurHDxUQrZQ+m+am85GmF7lXSxnXoI3GSBRlCG2ZL7h+s3EOS0C30dWCUCl79Bh3HGi91exDpYohydyrbVRHI7neh9n91Qv+hNk+mTwxBa1iUcVvXP3VjUILJf7WiqtSj0unbKQ7/u/y69E9jPMV1K+ucP2ge+LdZwOxBzcFHO8wFHw+AYAxmK8V2DcaRXTgM4xD56836xWvVyeyrVtoYowCUe4hcE1+WqolB7phuhDxKtUd+nc23F9m2Om4FwChoDjUw88qxe/5RrBknkMnVKJt292IqD53gCcVY1zhhKTUiLukbnjawbcSfY8RieSofHDcSPZ9/F2x+jbsCyQ+wDFfEovOHp8HoKxtTkg3ziLbGXAb9XKtXH0SNMuP3EtTU001KAadPfT6tIBiF+6ms12r7/60YaLK1+mRf+1il0Nk1VkNe3CvEBMGPUx1/DZAgLJ8Q/12HF4vmZ1Lm+Px+CDApRdmFUdRx+BfLte0JzQ9NwK+x0QHqqJlIVi2Zau2gBd8D18GJkBtDmXI1ZSI5RurcNiTiG0qi/jFFniKXQOQdgiWioog2/X6WF83TSavW5aPSOKCvgNpnHYyAAne4P2IzXm5MnS4CKsBFHmJz7RBL/G38fV7VZka0wcPmL2eysw5HUgeJE3ihrESIx+0cEokIGiuS0YkuwkB14gy3Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(7416002)(5660300002)(4744005)(41300700001)(8936002)(52536014)(38100700002)(122000001)(82960400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(7696005)(316002)(6506007)(54906003)(26005)(186003)(9686003)(71200400001)(6916009)(4326008)(478600001)(8676002)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E3f2GAyK02LRuHaCBoJTgzTYB1RY9cz08g1m8JaWwE80iquINI8VtHLdub+x?=
 =?us-ascii?Q?CxgT7A3aM4vobiukF8Wl+223LaGJpzm1ZqoE+idowkGnqcqyhbSq/HYpTP2E?=
 =?us-ascii?Q?HDMb++hWHWa2LLEo7MCarY1vAg95yaAtp/Hq2GagTyhnzI7hwAvS+D8Pj/zp?=
 =?us-ascii?Q?zhwyQxRaaB+75AUPvGRa+hlk9BkEWwsOv1noV+L4uRa/0WiMqdlqvIf3x2tJ?=
 =?us-ascii?Q?AEdw5nFwJ6q8XqDP/4X2LQM7jfOC9s2Qwwc7CtZyuOvil5piEHRCbVedeZv/?=
 =?us-ascii?Q?XtJqalbQ3BYlWROhj9HDqD2GiPEPWRnmuIkKXOCmac8Rr1Avbnysxs/7a583?=
 =?us-ascii?Q?4ocTtF9a3ANWPrToR40IXoiMCR+9Dc1GkBWWYl0WxfUUyzKFcFMOe6ABJG6a?=
 =?us-ascii?Q?OOoNWzIKYdQQGNqdDaCzUYnW9dr4+dg9/syjLcz4UW0dFQTTn2wqstne9nlI?=
 =?us-ascii?Q?oOl45sffVGWRUfsB2SMEPf1E04eJM+2waEcQ4UdVupVii12l1XjrwN+TdVAO?=
 =?us-ascii?Q?AjAlkBceHZHoZbI53i4bSfKERwrxJwAa332Ki2ctlMsFgAhpST2lCa6QtUoK?=
 =?us-ascii?Q?Me3p2PjQQPvHl7/2si0WuRe/YgoNsRV0NxX3War6k32kA0WGkfG5wqpEG+LW?=
 =?us-ascii?Q?j1OIabbFRPBTQozb4LWDEU6AIF83yqt6z2ElgxTNMesa/IxzVoFdn29SZRX1?=
 =?us-ascii?Q?ZY9WR0lSGne0D7OyMvSIzoeyyxT+5zlGIJh5AS5Mp7t+y+HbeBgW99XGiQXm?=
 =?us-ascii?Q?VrXYNcb7kJNyleh9zkCB7Pk/LGv6BuBtkAW4d03bqbWM3tGeL+yhTDXo2Mgx?=
 =?us-ascii?Q?560251A4V47Rv99lf3OLrvAPiWgAbTrqAHeq1GhjbsdVpRz/5XyUGAyspFmi?=
 =?us-ascii?Q?eas7RA/lwVQff9lnqNKxlCL9LS2iFUMtb61XrxUgQ3SVsiqJzIgiqHv+Z118?=
 =?us-ascii?Q?vqNYPRtU6bV9yHq7Sj7v23PcoN1lfz/OHrBtp5MFYXOeO0rdypOxHoMVi1Do?=
 =?us-ascii?Q?GfWz4+3gMpJFICPKTbcrRzIZQjnIOjCfb2KVUtfe+wL1A2Hmr2c3Nqys4kXt?=
 =?us-ascii?Q?DXb3nxNe0XQyYHXKKdfAmVxA/o05z1naqVS7gkILzEnQXOEeonQ/VFuNmud3?=
 =?us-ascii?Q?9e6ZcqvmkBqFS4DobupiVsd6b5sKI7fWhSbB3hobpsxW/z3avqEKS+P2DRjD?=
 =?us-ascii?Q?hBLm4D7JWSHvoU+uVs4gWK5n6UPk9Jp8j1CJLdA9Ib8Ji2bbkkvqyUChlllZ?=
 =?us-ascii?Q?Pqeg/+YRvEPhMaq4VKde9LF7pcAZk2ayor03mGqdVhtL/ZZPNpFdINHq6rsn?=
 =?us-ascii?Q?oxIeJbvgZOmxTM/S+j/keK6xuMkCGFjvgQtqfPdVs62L1ugYSGy/MDmF+jZh?=
 =?us-ascii?Q?9OXiDFrTb1BlgrY07EuQgxa1bkdULDBR1mU5iombrFLRD6HM6+JYntFsX7tg?=
 =?us-ascii?Q?4JoWzoEOoqVkdkzbueqQXPZw/GmBQVpmycfixY001P1GkFquZDKwBQztMKiF?=
 =?us-ascii?Q?dp0K4ALDbkizihGy7u+6TdRuEXy+JFNBX4rBTLYfcLYR1Z1mZZTY2sew7Ofa?=
 =?us-ascii?Q?ZkbhUW3kJAHOK5Vb7h/bTvRkh9lY1USq6quDAjTf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33cdf1a-df46-48a5-1e06-08db0d669e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:04:20.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJh7iiu7AHKN5GZrW0GXFmRuuDqIWmMO/WwBdm/oxf7FK0f1LonPp9jsNya7Gt89swvncKR3ZesU6jNONBJimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
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
> Sent: Saturday, February 11, 2023 5:00 AM
>=20
>=20
> > > +struct iommu_device_info {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 data_len;
> > > +	__aligned_u64 data_ptr;
> >
> > moving forward iommu hw cap is not the only information reported
> > via this interface, e.g. it can be also used to report pasid mode.
> >
> > from this angle it's better to rename above two fields to be iommu
> > specific, e.g.:
> >
> > 	__u32 iommu_data_len;
> > 	__aligned_u64 iommu_data_ptr;
>=20
> maybe call it hw info
>=20

that is fine given we already have 'struct iommu_device_info'.

probably this cmd should be named as IOMMU_DEVIEC_GET_IOMMU_INFO
to be more accurate.
