Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4E6AD4EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 03:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGCm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 21:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCGCm2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 21:42:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC424EC5;
        Mon,  6 Mar 2023 18:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678156947; x=1709692947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=imQkzIK9eUaeObiMm4+lGHdL2kMM6zFnWtziKjjZJvc=;
  b=h27pHsmewKe5lbGe8bAa2hjFfqguxRb+7jdvjUi8PyuNwXmSMJobLfub
   eoYjzJpRpo5Tv6d4u1D72bb2mjbN7uPj2WZvwSbG2+FoG2wFk8tCAlD6O
   VAix02pM8N1BiBu1WzEcx6aTTvRlMklapSRu2kYuUur8emp6NhC59f1/6
   csoXDBz7APvpLqt7jpPUciAoWiyICB+7b6ylb6aOzvOnZpgspMTjBJBW8
   rKjk3EdQgTEZu84YzPjvmqXatYbCbDlvfv9FgheZ8L4soFWU3Q+1GySuk
   X3WOWZbXZwtZOxzb4Q5dmymBp06NX/DLedmSP+l0gTNqqGli3ZiJvUurj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337266596"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337266596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653815452"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653815452"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 18:42:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:42:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:42:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 18:42:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 18:42:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgnFXdyX7asy6CjfDtCUO0kYFBHvUW7a37eZD2b/RehHvCHFC2L+kQGBzi2SjfDn5gwR8RwPPguQT/FRvPIQ7abmTFJftwTt2f/+PyqCwr0k3YALKG+TTnwAIzM9F8FpEtUYANn6pSOzj0QnD0NNs2zHI0Lj6ni7Tndg4uHK7hV0d5tVrJ7l+e0zHJuzSMX0upsKdbvyfW7QRXnseK5TjGVq3bDsbYErpyFlkLF2fvYHM5VPS/1B1JV3ca9omYBFRbheAb7eneSfuRgzFNlpa6hqjHfex7MTZLA6xsiLxhzYE0g1ybNO1AQ/mWVfDZgukNel/2eMzVPj9/llD9ErdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpMIwuwQVj31iof1tcis5xJroGYMPOEC3Zj0SCYTZzg=;
 b=SbPdriojVGd8y3XbNDeIDA9+8M0HCsFk9tUI6TuKoR7RwkUUfXXaJPBmfxh79N7EjWdqZpxUVAuGMoabiYx2hzHn7u3aEzZxbEQssII3W9ZN2feanpOyNqPbP3E6MOT6MICFI3xWkJTDYhwrRWu/Q33nFXVS8Z6w3nu4NVLwwZQXnjpNlKU6eEwmO/GtqIK2DkUoFJbaLc0W/BTN4pLHvQ2vkqUtM8XeeQStqkY+p0QOWxvpiGHTBr8/RzAY9dZtvZVEL+1xJs/DDykkm2FXDy1uOzzzxFIlUj8RyPI1TvHMIelpoamZBL7SIfXeytZggI5jbQGjCSfUptVw/jutVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4583.namprd11.prod.outlook.com (2603:10b6:208:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Tue, 7 Mar
 2023 02:42:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:42:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZSLAU/BSaoz29rUmbcKRH4RqHN67nLb5wgAcZzgCAAGN/cA==
Date:   Tue, 7 Mar 2023 02:42:23 +0000
Message-ID: <BN9PR11MB5276E3418B829505626E43798CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB527622B6031FDB540D2820138CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZQtNE7aPpzv5RX@nvidia.com>
In-Reply-To: <ZAZQtNE7aPpzv5RX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4583:EE_
x-ms-office365-filtering-correlation-id: d5515586-e1c5-457c-702e-08db1eb5947c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MeIIPTeZ8a3kjJTzn+dk2rSgLUkIG3FfhxB903fby13Gg4HRf9sKzZTTxuyFWXnB0qtoycWIBhSP//cD6zjnoqb8gnOzyFjamInZujNlGabzt9Rl3D3Y+doeX85MQfv5KHfOjvfUJB7LnFCld01b76Q+OFhTAD2uh5LmDOkg06DKFrA3dzrHcNRzGwfRSgKR0NSQMiWK3+x2Nf3HuSPJ5V/nEs9Ol46abLXlIMyMqewhPzrpGBE3uLA9qX9fKnM8j9+lYnduCWtoaKyYlD0+kxn3EU7gK/xfXZHz8CyYV3xdWKYDNsfYHjqB0cazS6h59vN5cFBQlW2OGJa8rjIrXQ729ySSL+4IoNA2mxTa5wyBuz2vNf9EuKnaLe2VDj+NCYfFQId+GKchPNK0EdYzNywGDIGSTXsrlMGUKrlsS2L5+qRWck4quCnedDuM96o8+hzHDcIrqCqJBU+MzhjPqNKHf7hjWfdmf/zjQKtMo5eHBkpRmywapO/Oa4d7V2Z/trJ7w9gRI4IZj+NRWndhSuXDiuqoDeJKfqUYV9UItYsV/mflQdmlFwtAEC0FtdJf9ApNvIarHw/cb6pcUyUVssj05sFM+bdw9GUrhU9nHosSItVoN81ydpxSnytv/3PUq44rA3Dsfs4YUdMQ4ujPSkgmqCukV7Qc9bBGKyAR9+mVPgJeCVkOs+Im0sE3JrmF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(33656002)(316002)(83380400001)(7696005)(478600001)(107886003)(71200400001)(6506007)(52536014)(26005)(86362001)(186003)(9686003)(8936002)(66446008)(4326008)(76116006)(8676002)(66476007)(64756008)(66556008)(5660300002)(6916009)(2906002)(41300700001)(122000001)(66946007)(38100700002)(54906003)(82960400001)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lgp+CANf4xYjhmx8/GECLWt8PhHV8enL6GTdwmziK3Rf2uoqqVMysjyCeuvd?=
 =?us-ascii?Q?t3xIWydxdGzELPahLpbz7vSW0IMHPnxv06qEXXCZr6z0w14px1ESCG4FSKi+?=
 =?us-ascii?Q?2vYoUmK5Xw5xZyEzuEZ+ZVSbeaL/j2JuEqn7Mndc7PIoogTanKRzDQ9iReXf?=
 =?us-ascii?Q?E3EzqtP0pazfofbjanIC3iuIHnnPXrrL5yjV0+HAdk9Tt3H8bPtPCoS4jQc5?=
 =?us-ascii?Q?0sZX7I1XbVwrvAqyHh+fSayxakWryNB8kqX3DQYBbTLL8qva24HIv3OeTdYk?=
 =?us-ascii?Q?EUuq6HRmH2Z+xRcnIl8SM4X9hnn0h/CP3mkf4aZTuVouQG0LI8juGV1ozUTd?=
 =?us-ascii?Q?wt42TDJEcEQde8CLSXF+jfyUlDT08YRgnYUTABKW8/cD7WaQESy0Wb2lu8F9?=
 =?us-ascii?Q?0tgNnLf0H1Y7t9ggQ0JWvzIACWMT5jbAXLLRd35e6ZbBKy1468UuJ3n68GVI?=
 =?us-ascii?Q?J2KIkIh2Gcy6SEfKuvXHuOdkga77C07pxENbOCXIXPj0b9ts4+pbcaYPb/J2?=
 =?us-ascii?Q?E9NG2ShrQEC+JZBfe7tLiYl/Nirbm3N5QLYslDA0ofbmju3/6f3ivXgrdl4J?=
 =?us-ascii?Q?fJaQGYKpSE65EL3zT4Bp+mvQH/d0XvlVDTXcJi0Louu0v+woCipG1mcCoa0z?=
 =?us-ascii?Q?W9d5bp7qwE16GoviZ+fU5QU97GWv5V9LiYAjOTL3PgBgo7CrucjYQGEjJJvA?=
 =?us-ascii?Q?SB9Xt1L9yyuR1omXr8yBDmIKxEji8yEFijw8pWRGvgExmzq7UCh5KKOCp9Av?=
 =?us-ascii?Q?f573uxI2v0GZNduawL3+ln0zbP+4nZT9+7zZuMeQjvBnSItSkfoCI1cQJpLT?=
 =?us-ascii?Q?rKhvnwe/r0AOMEa0bNzTePLGot02XPagv6R0hnp92Iq2CaWY1nD1l9IUbyGW?=
 =?us-ascii?Q?0jG7tG/yVhMNt1gVsZqnEGUJvoAnRp184Vs6S6z38wojorgJvVsNHbwB4MIu?=
 =?us-ascii?Q?p4V50pWPuc88JTvgiAU9ItmmpznofM+wkRyHZZtoYWVwdHbG4ngh6NQs3kx7?=
 =?us-ascii?Q?6smu2o0vJunVQM314kMQwsJGmhPTqQM0+VkIkDYHSyWhQX93kIZK3U2GxeBU?=
 =?us-ascii?Q?00HurNvFa13jd/VV6rY3OU/ymg+WCDHsSLz5BscewHSKn08bN0yJCarcfGzf?=
 =?us-ascii?Q?SffqGykufwmsrIDEK/TiBj+W88+uyuNoplmyDL1NtCoRne0Mb5mM3OsTuUcV?=
 =?us-ascii?Q?LiEBkPmaZDAzqKWZWKukkOMJ6wrIpWBOpSP532Zy91DQE161R1rSCawHDUHq?=
 =?us-ascii?Q?dzOmQ4mWwxpXPe/fQn3gl/o26bzRfCTnuKv65T1+dpjV8qpe3qTLObxVFicg?=
 =?us-ascii?Q?MPiCpgAjd4UIYr//4HZqx7wLIA230Y7HrG8RO867E1l8NxB1P4DZ11UhEp3M?=
 =?us-ascii?Q?SPwJc1Qy7Xjz4zegUZ4/+EqfhLYuoIMfG07fgbOkvqahFz0Hi2UbiT/jmk9p?=
 =?us-ascii?Q?A6FEqHOD6HgfTXlwc44BWT2GNsR5Ahp2jX8jSMSa6UIciflMIOvveDd5sozE?=
 =?us-ascii?Q?4gBvP2iRskURVjEL5o0S4ZOPQvDDm8bXv/Nn7Zp9ZK6paQHleXHo0C8Z1Fd1?=
 =?us-ascii?Q?uj5RVdiV9+JkRNCPPt8AzmfFuCfZp/bL62dcgbcZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5515586-e1c5-457c-702e-08db1eb5947c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 02:42:23.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psNtu+MLoqehGz9z9ZmagcpXGOkH359qqUxh9TLbkxrxM63KExykAl77Lpk/3GGIECzQYtlFB1m/CqRx5MwROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 7, 2023 4:45 AM
>=20
> On Thu, Mar 02, 2023 at 08:20:05AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, February 25, 2023 8:28 AM
> > >
> > > +static struct iommufd_hw_pagetable *
> > > +iommufd_device_do_replace_locked(struct iommufd_device *idev,
> > > +				 struct iommufd_hw_pagetable *hwpt)
> > > +{
> > > +	struct iommufd_hw_pagetable *old_hwpt;
> > > +	int rc;
> > > +
> > > +	lockdep_assert_held(&idev->igroup->lock);
> > > +
> > > +	/* Try to upgrade the domain we have */
> > > +	if (idev->enforce_cache_coherency) {
> > > +		rc =3D iommufd_hw_pagetable_enforce_cc(hwpt);
> > > +		if (rc)
> > > +			return ERR_PTR(-EINVAL);
> > > +	}
> > > +
> > > +	rc =3D iommufd_device_setup_msi(idev, hwpt);
> > > +	if (rc)
> > > +		return ERR_PTR(rc);
> > > +
> > > +	old_hwpt =3D idev->igroup->hwpt;
> > > +	if (hwpt->ioas !=3D old_hwpt->ioas) {
> > > +		rc =3D iopt_table_enforce_group_resv_regions(
> > > +			&hwpt->ioas->iopt, idev->igroup->group, NULL);
> > > +		if (rc)
> > > +			return ERR_PTR(rc);
> > > +	}
> >
> > This is inconsistent with the earlier cleanup in the attach path
> > where setup_msi/enforce_group_resv_region are done only
> > once per group (if that is the right thing to do).
>=20
> Logically replace is 'detach every device in the group' - which makes
> devices 0 - then 'reattach them all' to the new ioas.
>=20
> So at this point it is still being done only once per group.
>=20
> The 2nd idevs to call this function will see hwpt->ioas =3D=3D
> old_hwpt->ioas
>=20

but setup_msi() is still done for every device which is inconsistent
with what patch5 does.
