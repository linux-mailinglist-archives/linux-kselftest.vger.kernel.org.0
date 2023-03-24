Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C76C7529
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 02:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCXBnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 21:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 21:43:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13281558A;
        Thu, 23 Mar 2023 18:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679622183; x=1711158183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B8HwopsDg7NEqLEyyDBVedK1NYgOUJ8vWfZ9q+JkOzY=;
  b=SW11OUuSs2NejKP2jMH9QgKRwhk+kTbxXI8veH9W7QlHqQtk/0T8NIzO
   MrpO27NKm6/Mw0uU+SdN1eLITfGkGmZOjP5CqX30RzLflFZk+ShN/jkHb
   XcKp/bH5jLfE3fHeZnnX0MAcR3eWHQpxNzoY4nPda37TG8pi/bQm2Th3D
   Ac9vT2IjEPGd28rMDcF87ofuBTgXCgPIyhcJhA5ibKgC9ZjLKpjKQl4mH
   MyfpJZj5UBWJGc+6vVYAbvmt9clygapAyXmlILf0OXJVVQvuO+3bJKQdT
   dRGnhu/gp71CMWCJukLJBh5Hx3GcN+rcJswS0wgp1KpG5bp/Ps3WqdlLJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337179359"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="337179359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 18:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826059232"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="826059232"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2023 18:43:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 18:43:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 18:43:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 18:43:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 18:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcJYK/5v6Is6j9TQUamyfvfjt9iqJtCUhsJszqNJophlg+XC7uYw4HMAQatf1XXSvYauVjmBu5qH2YAXokJ6TU5CQJeWHBOA040iojj9yq7BXWb2dGoH66VzASwoGMkXFl6iam5OD7ulRTF4hWEVX2qBmaaey2mNNzkphb54j64nct4bYtlmcqq/h14Nb3ZGfpFn9VakvS2bq6kZbBSALDFTDXwubuBgiNujfUS1jCz6w5bENBArghk9Ie3QS5NVHL5mfTzLkeyzrpRztsmb0m5hIJdWbB5zrMwS2lToCSqD8PWpHu0V+j0Yx4domKfI6x0t5DEnZFx5ulS0tOL7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhFWoieqFiIgHV3Qa1GtkOe8mA3NC/EoWXEWENdI2X4=;
 b=MYgbXbovSN0iMHqUbv7CiPKZKt0pN/GfBh8Mem9jUuKBHzDRIY8CExHIfZoyUQCw9JxSAMv0i/3iMrRyggR29xZ6kfwd4Sm1+S3vd6eCouTdo2o0d6MLOWY+FgIFC4qR+VqkjtD0Y7+wersVz20wmqzhI8b4OdWMuKp/tdqAuC+3X5KWIsrnVsoK04AmdAnPnUa5UfdGu8Bxf0eHdZTXa5KKaXjyqvsNc2YFgSZi9u5/XJhv88Mp1LUmHdQ/4kZSe1mtzhA7MU6RMM0muLF1O6lp4jy3hY1U2f0NOPHeSwUX8mJXdcyhVCZk5FqnCHIdIMQXgfF+jAyp2rOePSlisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 01:42:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 01:42:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZXCmQLfVu+4pznkeqY9jbKuj//68H+ZjAgAB2PQCAALp6AA==
Date:   Fri, 24 Mar 2023 01:42:58 +0000
Message-ID: <BN9PR11MB5276B41014B2A28952B626B58C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276B73DF56654BEA4EA51AA8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxioEDUtPMro+ew@nvidia.com>
In-Reply-To: <ZBxioEDUtPMro+ew@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8337:EE_
x-ms-office365-filtering-correlation-id: a7e84a6d-07e9-431a-303b-08db2c0918b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lL8MhlWR4M6PFlFv50HrNGiXXEZRPawUt05r4Wh9fjC7UKHUogGPFicnGB1a5FWDw+/Q+LTGgHIkYipHoSCPvCBdRMghfmnUbmn17nNOclUwL16WMI/JvmiM7OgpG1QCCJ8uH2S9qgzVduIiOHr3McqaxyXfebxS7oYb2+H7zUrzS3BMonjFi075SgxI6rQRL3e5UMX2J43c/gZuTOOrFikg0ZAaTkAKpB1YBhABo9WqYrhwCeCXIBjphRr0j0alsVsar1YuxLhFoK2Hyj3v+Wq84PtWzUdLCZ8A8lGkSEqnUBv5W9khtml6PhBR3Jq1Buq6JCSZY0cOL342By2Yv+USBQolSDfGinbxyWmueY44O0ouE8RKCRdAXlmED9TSZWIJ8tAhoriTOGuk51Arg35XWFvzhp1MQHgZCdl6cf3wytxNId2meF8IGNaI7aGk9zOH2oGu0N0tpWFcjEnO+RNq4eArtFaQaWoJc5OLv8+ZeJdz8D+5UKE5HbnVtlHhXJ6tBlsus+G15JOcNuz3/2NLo4IzJb+CDc6ywVp3QWFyWTj0x7coFmUPasfj0c1zvXxKGCrqlYwA6SY9aiw4/347KCcHEWyptB19iFw/B9dc7i9fNdx3Av+xkeQanqiXtAiLITbuAiyR5kz+C3sIT+dfccgasVm44bKShV9zzVfdGEbLNv3E+tZG/dfuXwQjpm+A0jCqAknILQkHt7HLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199018)(66899018)(33656002)(316002)(83380400001)(478600001)(54906003)(9686003)(186003)(26005)(7696005)(6506007)(71200400001)(38070700005)(55016003)(38100700002)(82960400001)(86362001)(52536014)(64756008)(66556008)(8936002)(66446008)(66476007)(6916009)(76116006)(2906002)(66946007)(5660300002)(8676002)(4326008)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9UI9UWjDMZ0RjBRRjD8lCR+ZWYtktNkO4uoxqZr/NpNs6lvLvTBemOoLlHc9?=
 =?us-ascii?Q?+vUNk7AKWk7D/HL8y1FLDdWFr5LglfyocjAc+ICRRuri8DCh/1MKjug09omB?=
 =?us-ascii?Q?qQgi3Op73g7eqxKnj7jelDc4YWEW/4/MsdJyinsNKWq4cgvWiW4NnoLxWMvi?=
 =?us-ascii?Q?/a0ZERlhcUkjY+Iu3VGq//CFQvFzNlgwHYJ7MvoueJUBOKML68AVg289Q1Y7?=
 =?us-ascii?Q?Q6x41xbDwYqgj2VGzBaONW9/iiDufhic7Rk9WurIfMFrbRhof/vrsgGxVTOC?=
 =?us-ascii?Q?jriHPhyB2Nh9IDsuYT5cdaqdO2XT4SUxEBhnZnz89OG1HZ5kqhT//P7yyVID?=
 =?us-ascii?Q?zH0/1ALd4ypUHzEcqUm1GnUEjqR0YkX6HViBaYP49/oN7YmorkLOpSO4Y3tI?=
 =?us-ascii?Q?xgH4eSQX4uCTq4z/HZs909h0/HSR4cY/vZCDyKticGSIeBe+T6bRv7p5U0He?=
 =?us-ascii?Q?KL/r1OH3cSnmW7uzfaPMS28miq7hh7V1v1TElfsgK7+J/QU3d11vcn9Dx7D5?=
 =?us-ascii?Q?InX2sFgNX08mpk4jCTR2yoUp+bZCTAt8F6Sf8ZsVVUqTBhFzZ5kr7Vrkf7XJ?=
 =?us-ascii?Q?u0QAjuEaPvAlC4medEV48gYL1owUjpHZwsBh0jLpyMQ7IxZzhe9hgKMJPyPO?=
 =?us-ascii?Q?xgEJl8yyK28TuHs2JUhOendLMXpF++Zui0MmI7RM7KP0GR+TL6rA+mLcX8Ic?=
 =?us-ascii?Q?l+AKX/rVjrPGDXQPcloVmq6Lqv1NNOEONW/qmLOrxaz87KnpwbdNqnff+qmH?=
 =?us-ascii?Q?T0m1KVgtTTfrRi9r2YIenb3Zw6DOGid6NaHgg2Tv7a42rAvJkzc6OWK8jPiV?=
 =?us-ascii?Q?vX1M1vYV3EY+9IHmPfbi+4wRaT7RQIKvTunhAP/0vUKPIsNLip5hRchcVJ0j?=
 =?us-ascii?Q?adhhdLg+id2sNcNji/l70Sc0IAoFuMrp0yAoUAoEgHzjglrqxHzd8jvPnmzU?=
 =?us-ascii?Q?kaOJcTrzps9dF5TU42Pkwz9zKYZwgWH4uL0TF1bhXu7MyOqSkviXR3CkdtCY?=
 =?us-ascii?Q?8y35O0NMT4S5eu9AI8Hr3oQenhFOcLMs1uxxLFXOwlVyWg3+9vrg/pzucMAA?=
 =?us-ascii?Q?MRMX6Umxdsc4eK5vR/KQNcD7UCNts1X6JKklh5X0vqIlyjcvNfHnvkx6v7JR?=
 =?us-ascii?Q?1YR6zMySNYIMD2SPlcDhJu7FsS5M4wHkAyBn220zJKr1cErpGIezVHJDVxUk?=
 =?us-ascii?Q?f7jvHdYPc3Su6OGqL3Q9m5cAlMw/19+u2jVWl3kBoXyMtVi9rpFrYvB2CPBO?=
 =?us-ascii?Q?XXn+f2SpBLqo2Zno4QBIquWJO9HWPPiG4lHNNPuGXe1DMELS0JDTmLGG5agD?=
 =?us-ascii?Q?3iVScZDM1VrDjG46EZ9/i0vWH+ASGWmMWhDnN5B8bUtHsbDm7IbbybqkEXr/?=
 =?us-ascii?Q?rQkjO9bBISrZhbq3ga98NBH8MpIsf2IWHG81whJhNh6vAbbaprTGxLrAhY6v?=
 =?us-ascii?Q?ynMHtyVJfXt9J9rO5KfPeK4mKzbbbOJxC7jJpV9FHftnl0Xckp+ohUnqPipR?=
 =?us-ascii?Q?wsUtICtdE1Oz8HmehzNpwSSkl1IW0TX9/KCZyQYvdsLsZupvkpGHTpRrGjuA?=
 =?us-ascii?Q?54RGnpIf4pD4pt9bf//09QYLwbDokWbScnJDjP/e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e84a6d-07e9-431a-303b-08db2c0918b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 01:42:58.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+MZTe+KDWYynGpJmFUF2euJWP5f6ZhRhm9R7GT3Hbox1GrC+zOWg0VQVn2+N9KW3YaaXcrxNrn6nRCsSueK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 23, 2023 10:31 PM
>=20
> On Thu, Mar 23, 2023 at 07:31:02AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, March 22, 2023 3:15 AM
> > > +
> > > +	mutex_lock(&idev->igroup->lock);
> > > +
> > > +	if (igroup->hwpt =3D=3D NULL) {
> > > +		rc =3D -EINVAL;
> > > +		goto err_unlock;
> > > +	}
> > > +
> > > +	if (hwpt =3D=3D igroup->hwpt) {
> > > +		mutex_unlock(&idev->igroup->lock);
> > > +		return NULL;
> > > +	}
> >
> > goto err_unlock;
>=20
> No, this is a success path, it should not jumpt to an err label or use
>=20
>   return ERR_PTR(0)

My bad.

>=20
> > > +	/* Move the refcounts held by the device_list to the new hwpt */
> > > +	refcount_add(num_devices, &hwpt->obj.users);
> > > +	if (num_devices > 1)
> > > +		WARN_ON(refcount_sub_and_test(num_devices - 1,
> > > +					      &old_hwpt->obj.users));
> >
> > A comment is welcomed to match "caller must destroy old_hwpt".
>=20
> ??
>=20

It's not intuitive when moving the refcnt why we subtract num_devices
from the old_hwpt only when it's greater than 1. It's really about
the destroy must be done by the caller.
