Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC66C6148
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCWIGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWIGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:06:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4DF974;
        Thu, 23 Mar 2023 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558798; x=1711094798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mHv7+ZiTecL8HkYP0eFfIqPweIUPyUSGyUKiYgNpsvw=;
  b=IUiqUAPd/YyNO7ny7Z2Q3RperR8qrUr7pp2X88BYbViWUr4GCqzrV/RL
   iL5ig4oTGwCthXURvbyBxwwg6Ay+JvKkNwW06EZD4vTaU/+DrcozK5wuC
   UXiceDaBOvjxXlRoCQk5FtOJYqef/Nh1M6t18JJ7DErIlZagi1pbEXqPC
   yo3kFJbPH3bJbX2+A1cW5ilKhsqIudnsAhsfyitS90fobcu8EBFJWTjk6
   bJq15pao4AAkNVLmY0H/5PZ//xw2Yhqyo20q47NxJYwJu5cE4SAnMqsS+
   kuxQDSYI/6/MoxrS+Ol8srFUUr37rM5t1+Tt6x30+Y6wkBnIDZiQJfB09
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338146920"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338146920"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="1011689449"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="1011689449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 01:06:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:06:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:06:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:06:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjjPgDbgcrvR2DoGjWJ9Aua/y3AkjSabQlpgFM3qtYwM6QiS3eHaTv8vdChlNDe/mx2bOoWN72YJZ3tg3S9sbJmE6Zba9e6IiLOXYgKy0AZAFaaC1r0kHk3JsFWue3v/vpS7BcFw4XkYIJIISX/r483lYNohoFJHPmBYjOkCE+WjmGVc9RHG5FMB+9MmqAdGjjBuBg3A2Jj1X9/m+qB8GOZN39DwGzYS2g0IAMwgwhv4ewq7F9LG+zb2hrv8QXjEPnB/cGGm1RlxpmizboO+dtIEY1vcZ5M+NKA5X89ka0XtUe9HsW3iXBWdtMxTLRF/GR6aqoQUsvLiXLqIUkGqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He/0wdrqy503dEyyzRQ5wXtlng3jyev+GjEH7AD2Y7U=;
 b=M+qM1zC6U1Mxp0BY5w1vDXc0q5SQ5nJ3h4s9EzdMzG1SxLS1D9IBflWejErRN3BVusyV8Gfebij009pWELKa6CYJtQqtCu0msujaoeVFwcT5LfPX+XGCQlVDQaWD8hs3e2nkPpVlxTRHhRecGtnNKagdFGWEQ2NEnU4PEPpWdr9Z8+xVuvyH7HG8bT5/4izE+y58SERm4IfF2jjpW5IR7nGj+kMXgGVTawwy5nOrSyKt41itlcmUTn1sf5WUjFCikKlQe5F0Kfndnj80fdxNflEjr3tDbCZnuhVjFbWWiP+v8pvu7KMBC6N/6hKqwIJ3AvQq4RIJzGJ860DNDEZ2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:06:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:06:26 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Thread-Topic: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Thread-Index: AQHZUl5/crYV8FrgA0CauavbhCdtA67zSlUAgABKJICAFIFFUA==
Date:   Thu, 23 Mar 2023 08:06:26 +0000
Message-ID: <DS0PR11MB7529C74B5A37F745AD822C5FC3879@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
 <ZArTN9tIDKuvmuje@Asurada-Nvidia>
In-Reply-To: <ZArTN9tIDKuvmuje@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB6287:EE_
x-ms-office365-filtering-correlation-id: 34fa039e-5d0c-4ce6-ae59-08db2b757ff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlLbgEZHwmr5dRYcpDFd8W7mTy8+/IsIgVMRecrGwV17KSQA/Id5VSqg9Xyb8yBOu54b9845n64cIZdbJpemfsDorr0DFdFbwxBSJJ+XY7LNzqQiyaJrqhZk3dnDtd+QDyqJM3Ht3f75xSu3cgKoBo7xMLRNUWm3O97NrXw41U6h/EdCIZ4l7XZDCV8eU2TTT+a0diAXqS6Z9uFhRBOp3If4ToGyoMftUin+5NO4d3HAM6nCzMEjpL00anwTi6VWpBHWrK1E4xxpB7SWXrFLIOgoKCXbKsF23eq49iOH8i8xFkh6jPCYzCnf9AOYt/1tGWpCwk8pK8N5YReNYyL2507qvNW5VnJ1Vb9PkO1zJbVB2CD3GU2BZ4DZqviGjkMxWesTh55Z+DSgIMg6zpCzpgbFPRIwpzW/xzu3eYDB5NsSic3UNotrwQYMJyRo/lvlyiXcrT/7F12tv1TOA2RHsCjbBGjbGuChP+MfGXX9IrmiCz3X5q/nAxu728MRvmdMZFAwE6wfxZbCzgYEQnf0zZhqwyReRZP4P7em8TCv8ooqZ1zEAFYe8lnRpzucs4lR57yIQvQO7Mt85x4N/XopgoC/sMoitrPp7CvcieIk6MOkxuDpObEmTH1ZGRjurqzNAXEiPO008iPN+hvFns9lUc48Y92D7VxOZJwl0IpltgpaKMBqIKJ7Eo7xiYixGjgbYntXWpJntLcAn0NnhnfoVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(55016003)(8936002)(7416002)(5660300002)(52536014)(83380400001)(2906002)(33656002)(54906003)(478600001)(110136005)(38070700005)(71200400001)(7696005)(316002)(86362001)(26005)(53546011)(66446008)(66946007)(6506007)(9686003)(41300700001)(38100700002)(122000001)(4326008)(66476007)(8676002)(66556008)(76116006)(82960400001)(186003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xX22hsJMxeudGkg6bH9AZPjsIkc87Dv3aZIz3PxPMDECHTI/PkryYQhjEj0B?=
 =?us-ascii?Q?jSlJ1MShmL1D5zjKzObXlAfmy0bPvqRxG+qIzS3I3RrgZgbrNa9WMBb9Fx25?=
 =?us-ascii?Q?E9H3GV5HFrMqbj400Yf6gpbJ8OUvs7HZzYX3fI2jwnyuX6uVZkHwbE6F2aFh?=
 =?us-ascii?Q?xnx86reOPIzu/HcGWnysP3aGn8VUeRa/k+By9jJQQadWQgEAdOhPfy9/I47a?=
 =?us-ascii?Q?NGIvdY2r4vCxkd/a9PS2GfJ0G4iQjCgTm55bBtFNFOLq+Ch/vXabHL2JRRsH?=
 =?us-ascii?Q?to2dTVhRGpeSC9/GeAXBx5eb/X2KSKF7x1gi3/aVM+1jnsN6etkCsbCUQmHW?=
 =?us-ascii?Q?kl0n+iFSLve2vC+pdeOcr2DFJY5AgEOk3NiNT93Z3I/xG0MZYy2UtbUxwSWh?=
 =?us-ascii?Q?LhSRPBXomGy2+4MVghLKpYBZo2cLOnV1KHxkoWPmia3ur8nPwvfbGxy5hyP+?=
 =?us-ascii?Q?4UJAnh6KVRX4aAPQ36+tuCjoTMnKK6kvzBpRHpcaBSUG7WwVGLDfsTTRPReo?=
 =?us-ascii?Q?Qp2oWGXXblMAx2Qhn+JBF3c0IgIjrxZorHh5zPnaCCeKUmBjue8nykXwSg+S?=
 =?us-ascii?Q?9EirZgEQLkpDiTkojr+d2x1/3HT9H7s5A3oJmxf+24V2gzUavX2tZS9DYzfe?=
 =?us-ascii?Q?g/VWX5mBIMVwxxL4qOvnbmCTPGYCymxoM7VKwhstlvv1L3RLra6FzTvPILE+?=
 =?us-ascii?Q?kRQI4f5VYggYC0iBNxOZidrylxgAbAyHqVPu+Rz6zwxBqGDIoxMhhnKpap8e?=
 =?us-ascii?Q?IFOuLDd5D+KyJ/YLjFIIeD48AB98qShP5hzjN4KPgxgw0z2ZIj2xT5Qx4P6R?=
 =?us-ascii?Q?Ye8Hjy5kEYI3+9oBc0ECsn2sFPAbpDT7zGyX2pbyZrVs4olVcREKzXegXFkG?=
 =?us-ascii?Q?S3rh2VO8TAdd5m1e91J/Tm+Heb9ztpn+yrCNChgN4Q2oKtp9qtgwgENdSKA7?=
 =?us-ascii?Q?GWmShdVfAYkJy4UCFACpJlTY9KrPa93KSwMKAuUCmfC5jHkivA3HrLiSfsca?=
 =?us-ascii?Q?+CDryzi4LI9jFLJ2SI40BvDfTTJ7HDESN8f4FB1YffRNBZqmbr7n4dBpnmnz?=
 =?us-ascii?Q?Coaf7WUyZAkfSsi3wPb9oz+eVsiob8dslOdWOVGuF04KmAP9tohr2mTIa6vg?=
 =?us-ascii?Q?dsBC5HxVRUT4GKddqZN2FX/VfRX7wvHVY5uz4f89prkFfZVj1PPlJQasmP2I?=
 =?us-ascii?Q?x5zZHUFbOTIGdrpb53izTHwBlSDasX9oFX5oWmYq+cpOj5MZhHWFsYSvtxt5?=
 =?us-ascii?Q?ekUbN7vviOCHTdvbh8EbzXPWNs2LxgQUJI89/8f2CAyPgvb0k3nyEQlFv9QN?=
 =?us-ascii?Q?Zo/3vL4P3ObQck5M6GimlvxHGq01iNCDn92YpIR0ihkbwvdSXSuIKNLgNNAa?=
 =?us-ascii?Q?Eo48mE1IYGyQyTyIQN4i64kAoQp7lFdSDoSJRjpz5gs4tuMImyqSIRQvsLpt?=
 =?us-ascii?Q?mzzH6mQ8oBtss+ffEf3BC/rmtIMUD/VA7rcVVgm18mcg5bcdTnlfv7btJwq1?=
 =?us-ascii?Q?b8gMQx95ySmBly8ADNWHKj1DAyimB87U0JRBUqshKfZAbNg35eMmDryRhVrL?=
 =?us-ascii?Q?c8G/1nb4OT6ydm3NsDc8oeyun6iuskU1o7aga9Hb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fa039e-5d0c-4ce6-ae59-08db2b757ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:06:26.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdUgSkPqBB/54h00nLoJkWM5aj1HnqRalC/O+88kMKDDBkj+mY8SRvRYZNFwtyDmxAieAxl6pgyPCfm/UMWWyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, March 10, 2023 2:51 PM
 >=20
> On Fri, Mar 10, 2023 at 10:25:10AM +0800, Baolu Lu wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On 3/9/23 4:09 PM, Yi Liu wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > >
> > > A user-managed hw_pagetable does not need to get populated, since it
> is
> > > managed by a guest OS. Move the iopt_table_add_domain and
> list_add_tail
> > > calls into a helper, where the hwpt pointer will be redirected to its
> > > hwpt->parent if it's available.
> > >
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
> > >   1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> b/drivers/iommu/iommufd/hw_pagetable.c
> > > index 16e92a1c150b..6e45ec0a66fa 100644
> > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct
> iommufd_hw_pagetable *hwpt)
> > >       return 0;
> > >   }
> > >
> > > +static int iommufd_hw_pagetable_link_ioas(struct
> iommufd_hw_pagetable *hwpt)
> > > +{
> > > +     int rc;
> > > +
> > > +     if (hwpt->parent)
> > > +             hwpt =3D hwpt->parent;
> > > +
> > > +     if (!list_empty(&hwpt->hwpt_item))
> > > +             return 0;
> >
> > What is above check for? Is it "the hwpt has already been inserted into
> > the hwpt list of its ioas in another place"?
> >
> > If so, is it possible that hwpt will be deleted from the list even when
> > this user hwpt is still linked to the ioas?
>=20
> It means that the hwpt is already linked to the ioas. And the
> hwpt_item can be only empty after a destroy().
>=20
> With that being said, after I think it through, perhaps Yi's
> previous change removing it might be better. So, it could be:
>=20
> -------------------------------------------------------------------------=
------
> +	/*
> +	 * Only a parent hwpt needs to be linked to the IOAS. And a hwpt-
> >parent
> +	 * must be linked to the IOAS already, when it's being allocated.
> +	 */
>  	if (hwpt->parent)
> -		hwpt =3D hwpt->parent;
> -
> -	if (!list_empty(&hwpt->hwpt_item))
>  		return 0;
>=20
> -------------------------------------------------------------------------=
------
>=20
> I was concerned about the case where a device gets attached to
> the nested hwpt without staging at the parent hwpt first.

I think I was convinced with the reason that this helper may be
called by allocation for both standalone s2 hwpt and the nested
hwpt. So my change was not enough. Yours covers both cases.

> But,
> the link between the parent hwpt and the IOAS happened inside
> the allocation function now, not attach() any more.

Not quite get. This helper is also called in the allocation path. Is
it? Anyhow, with Jason's comment, this helper may be reworked.
We can sync later on the next version.

Regards,
Yi Liu

