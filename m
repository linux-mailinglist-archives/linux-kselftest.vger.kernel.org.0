Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29C620404
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 00:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiKGXxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 18:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKGXxc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 18:53:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2A1DF15;
        Mon,  7 Nov 2022 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667865210; x=1699401210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=18muDm/G/qmztsgT7+hKKxx7ZJ0rqL6Yz/xY5Y3kWc8=;
  b=CneSexJVLYsUxbPKHLD08jfRevnGiAxAI0yYJRqHmwhBJm4J2/Q+46HP
   3YJ/CC9ITuM306AtWwVHOwyMY309o9Tl9ZF5izoQrelwQe8CM2bupKTQw
   n55T08v6UilisQqaUg+yL7HAVLJrJ0ux6mG26prWyc0alTKpu7Lp+DAlG
   +/BWRokeEa3WBTGdytR5edx91DPsJmvr/Gvp0e7+xdiwZ8ts+cZgp7vH7
   k095nWoJJkx8MusFEDo/Z6tPM6DfT6zyZEK5EedFdZQcmIoGFWLO5qNRi
   lb8PeqLWbqc6YGok8Hkq2lfmWQa2ceDdjFMMBHaGyC45aj1H8GIbrebRP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309263456"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="309263456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761283334"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="761283334"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2022 15:53:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:53:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:53:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 15:53:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 15:53:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcNpn7NeiZqRN7Ft69OwJMUto6lttRDYrYR8IPKLxude5+AU7JiDn2Pt+pdL79mobmrABloUAlUhqFBgWTA9wMJVJe6f/j20x/pHyVagZcGxnjncuOjNux44Vzs5MPlPiqyh0sU7Fbgmgb7bkFPZGvUPfrVYrOzp3/NZnekkG5cWmGkZZ6Tg48h1/oOoiQGpvuMPOSgTh2vUc7uATTFl+BT5OMpVpGmmyhjMD1U+kmY83RHRcj73xEw5DANZ7Htmpzi8+fSZSM/VJZTvUZNGUv4OUEoYX+ALnnJ1Jz87oNS4t/aqrrb9XjRMNXGiVLV2xXulzjL3LDad9Tkjgw2yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNiKn3TQppU/Y7UznE3utk29XVOxW//Rs+R1HwvItME=;
 b=bmRnbsRz3YdafoTYYQdd/4eGniTsEJxGnXYE2Syq93FIuNvRzQ+wvrcOuoif2cx6bsIlGuo8lyzK8yXYeuXqqotW4Sy7XJygiCMISJXhOUx6J76NOGTkoTcmeQ4X/3Yjl+gZMqw6xDqV2ifg//7eWnrP5Baf2lLMKSoZZpudH9SUlJB7TVIYUJiQ/xgD6BfSWJg19cK0VaK/qK7Tj+DyNvlRY+3OSxcOd2c01TdcM+mQM6HjmlCiT6gjqWPdpOoAwg8I/0r5ZRb8RjpSZ9/VF/YNR+4UL7JttjjlVs6LOtGfXj62LyOnZWGKX4VUg1DA6YR0EK6jMihz3mbQY20Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 23:53:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 23:53:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Joerg Roedel" <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY6J1rgVJHY6EaeUmpkBEcYy6wd64wHMEwgAOpDwCAAG9EkA==
Date:   Mon, 7 Nov 2022 23:53:24 +0000
Message-ID: <BN9PR11MB5276EA038EAA0345CA0ED0438C3C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2k7fkxSzxTPTXkN@nvidia.com>
In-Reply-To: <Y2k7fkxSzxTPTXkN@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7342:EE_
x-ms-office365-filtering-correlation-id: 90b0c620-6e58-4898-33a1-08dac11b420c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+zYXmCdImSoWlmOMooDXa39FzpPu9acehUdy35BwTElkChlWzOW9DGkTQsWdPkhU9EWVAi0AYNLGWBilru70FLv+/Ay8AB3CFIITDFXPi3jLdemPPUhXtJO7C/OM85QSgIOHwVpQnmZx9m0JjVe7v9WsA7NTuozxrft5LloiUEO80TAnjP7Tclr4a51vMPHCbubc+7DBB0GNx70B0Y2kDvDtQmrw+5O43LEuzcH49sTqPQ74PBAopxIoLImk1e0zOKtR2VfJAE1O7RzOFxPGZbPz+XPsRMPa5Qa6qzI5cIz49ek4rWLJqigxphJ9yy5NGR2UwHoAl8Op+mRWzgldxMrHNFuOFB941h2Mw6vk90U0ULjWEtVW31KidPCbqh4Jo5JEljIoNU8UG60vOK9mWtTj40q5cL2XxXdT8l/g7rCvxGZvp+MyFeEPlLIzT3lPGaquxTa20jbgtiFyuadRLjDRSvM+2P+l/X3Ub4CYxexmwdW5bgvp62VvoXQ/PdcJjjgobwN86dSOjE0htdizS/UZfyEHktYVpP45nQ98dirVgt/svsA8oAuGNmaPgeuaub3I8W4bOFv2r9SPTJ00hIxz05FU/Tl3RZ32vvZRK7rhaanw+Gvw8kWAOSxp+/+gov/a+f/BQqrLL8A4ePmfEYhQIn6tG0WR+CVuFVZerGzRS+7/I2KLbg2pzTajQn5sR64s9lkgAKBeBHSgjBMET8ADL1HuASU+dEm0zCdUZswWEf2WtQI7bKsQb0OWH+LGyvHEQX5TnAWYe7uNeeF8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(186003)(38100700002)(82960400001)(122000001)(71200400001)(55016003)(38070700005)(478600001)(86362001)(33656002)(83380400001)(7696005)(9686003)(6506007)(26005)(7416002)(7406005)(5660300002)(2906002)(8936002)(54906003)(316002)(6916009)(8676002)(66556008)(76116006)(4326008)(66476007)(66946007)(66446008)(64756008)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?su7So4DOJshBsY4st3bYiBfYanUSjArybLnDnUnv9Is4cGDqW10fpPfLHs/O?=
 =?us-ascii?Q?qabosUL3lIywwXW+/T0PUxsYmko7QOolsTSWrv8tMJn6+B43qWry9t2vxRdu?=
 =?us-ascii?Q?gd++d4hx6KZNcplU2QEZA7f0jkQqqhA+e6MKqAZkBfmeVI+FaJWwyfJiaYqE?=
 =?us-ascii?Q?wHvSw+po3V1G4FAxqoHHXflvukgvySWrx6mmqhp21oyWwF5x/+JDPCTzVMAY?=
 =?us-ascii?Q?JL+tCLOOUcGHPn8/ks04XVSMc5zeDWY4XYQiyr+fB3SpkiGzMFr1AtZR3x8C?=
 =?us-ascii?Q?TbKxfKOauaTsFwf6mRWU5KOXbaxoPzg3qtk918rIOvwUFfjC31wwQlOTuwN7?=
 =?us-ascii?Q?aG4zKrB7GjURXQ4+wB4KLmOg87sdMlhRAwJ5iqoE4b6tm5a6bIHqLPvZqpDJ?=
 =?us-ascii?Q?6PZnolQYImhgN6/8sUPUuBIKhYgv9vguXNVSrcy4Yp8RyHnBEjdtblUnf8EG?=
 =?us-ascii?Q?+44pSLHeMvsclJ5l9oqukT2qwNhi6UvCDltfdXyPzZetwZysEp5yD/UrqSv6?=
 =?us-ascii?Q?k4Xcw8fdLHewkR8ZTfGBToF06X4ycTM+WsWAPxeqD2oR0CE1gFewLs3FnW5G?=
 =?us-ascii?Q?YXlL3YZunxUv7RThVQOEgvaqAHafLMARQOEotYr0O05TFydzDpiiCIYMAEoW?=
 =?us-ascii?Q?/qCi3efQTaQqJSasH1jdLs2fciSrFSKcwjmc5mjTBorq0D+9LgfqfK9KEb77?=
 =?us-ascii?Q?Ylzv4EE/caM4Z12xr88cOzBHgRFq9uE9YP6Atu32Ge2d91yIPXEdt7/D6eoW?=
 =?us-ascii?Q?melpDtFTBKVj4IWM8oIScYp1ib5M643NUEDoc9VD+ePkoaYJ7xlwMcG/7yB6?=
 =?us-ascii?Q?xk1NaztlCnPOytd52iMHj/atAk1z7EhHQyKRkkdTzQjgNXDhkv3aa1iJK0Oi?=
 =?us-ascii?Q?JUzk22eJO7FpYaLGu5wJudO0vXipQrBBNSkBjg36BY9VnOhPNN50DlKUJWqx?=
 =?us-ascii?Q?sHSVVYHOneEjqBUk2E/yds7KIfDVkbVr20qsderJtJvM+3eAgxq90NJnTnII?=
 =?us-ascii?Q?t/GQpHidD22Rr3BNudG3cLgI23lszuERBE244qljwShPycjlZOIP76B7zm7T?=
 =?us-ascii?Q?i7EAgtjUi/abYto3USpLgzqfbfwMvySQrVXQPBkchKT4aQfDz+Jp2bMRNhzc?=
 =?us-ascii?Q?wYwrXXgjXz57UvSxSxTbVofZAyRo1en3paY0H5Aq3KmB2q6ZCCylX36z1HzO?=
 =?us-ascii?Q?IGbzD0IYu4FI0x/OEyI0MiCF22CHv6a0mp/KBpbc/QV5EV1KcKIi5CGCghI3?=
 =?us-ascii?Q?O+HYG4DcltyS868nNpHJHL5SMvc91bitnQkbYxcCnLLQDUdLI5UNN8daps0k?=
 =?us-ascii?Q?boRqTGPPgt7V5Np/Sc19Z56vC1J/aG9nVtslHFZmIaPEVafpAKk/qQepcbEu?=
 =?us-ascii?Q?+TIuAE+hEwddszto9GoIEubuTthtlSaxhc0nTO4buFTkKduESBCX9sLuTP1I?=
 =?us-ascii?Q?1tOSGNhtvDzZDqWF7m/b6jFll/FSE3hn8DHVWAdcy3A3sjRDpLoG6hVY0UUB?=
 =?us-ascii?Q?wU66Xt4TkpaHYs37u4sZ/8A58PoiHgCLaPTwd/w2zqRP5rRS9wLzK2NXrYa0?=
 =?us-ascii?Q?tG4f435TWiNHJ5RUlEivHUkDsQjhg5ZI03Ldm1Gi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b0c620-6e58-4898-33a1-08dac11b420c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 23:53:24.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jhp9wSr9M/8LgxQjRCzj1TrdBUE+z1mXfqpRoUK8U1U4YEruruqoTbzq7y+/v4p0g3ZWACgvWBI6yScBEAb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
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
> Sent: Tuesday, November 8, 2022 1:08 AM
>=20
> On Sat, Nov 05, 2022 at 09:31:39AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, October 26, 2022 2:12 AM
> > >
> > > +int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32
> > > *out_ioas_id)
> > > +{
> > > +	struct iommufd_ioas *ioas =3D NULL;
> > > +	struct iommufd_ioas *out_ioas;
> > > +
> > > +	ioas =3D iommufd_ioas_alloc(ictx);
> > > +	if (IS_ERR(ioas))
> > > +		return PTR_ERR(ioas);
> >
> > I tried to find out where the auto-created compat_ioas is destroyed.
> >
> > Is my understanding correct that nobody holds a long-term users
> > count on it then we expect it to be destroyed in iommufd release?
>=20
> This is creating a userspace owned ID, like every other IOAS.
>=20
> Userspace can obtain the ID using IOMMU_VFIO_IOAS GET and destroy it,
> if it wants. We keep track in a later hunk:
>=20
> +	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj =3D=3D obj)
> +		ictx->vfio_ioas =3D NULL;
>=20
> As with all userspace owned IDs they are always freed during iommufd
> release.
>=20
> So, a comment is:
>=20
> 	/*
> 	 * An automatically created compat IOAS is treated as a userspace
> 	 * created object. Userspace can learn the ID via
> IOMMU_VFIO_IOAS_GET,
> 	 * and if not manually destroyed it will be destroyed automatically
> 	 * at iommufd release.
> 	 */

this is clear

>=20
> > > +	case IOMMU_VFIO_IOAS_SET:
> > > +		ioas =3D iommufd_get_ioas(ucmd, cmd->ioas_id);
> > > +		if (IS_ERR(ioas))
> > > +			return PTR_ERR(ioas);
> > > +		xa_lock(&ucmd->ictx->objects);
> > > +		ucmd->ictx->vfio_ioas =3D ioas;
> > > +		xa_unlock(&ucmd->ictx->objects);
> > > +		iommufd_put_object(&ioas->obj);
> > > +		return 0;
> >
> > disallow changing vfio_ioas when it's already in-use e.g. has
> > a list of hwpt attached?
>=20
> I don't see a reason to do so..
>=20
> The semantic we have is the IOAS, whatever it is, is fixed once the
> device or access object is created. In VFIO sense that means it
> becomes locked to the IOAS that was set as compat when the vfio device
> is bound.
>=20
> Other than that, userspace can change the IOAS it wants freely, there
> is no harm to the kernel and it may even be useful.
>=20

it allows devices SET_CONTAINER to an same iommufd attached to different
IOAS's if IOAS_SET comes in the middle. Is it desired?

while it's flexible I don't see a real usage would use it. Instead it cause=
s
conceptual confusion to the original vfio semantics.=20
