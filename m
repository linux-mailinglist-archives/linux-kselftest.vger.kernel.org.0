Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263169ECBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 03:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBVCMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 21:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBVCL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 21:11:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1F32E75;
        Tue, 21 Feb 2023 18:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677031904; x=1708567904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=orrZV4a0s2GLfuTdn3b7EFUL+gdotK5+zDps2Bc4ydM=;
  b=LdVOo2YUeJyOl5O+lBdhdk9Ih1kaxz0Gyp08Z1kFuNWuDi/SpRRXOKXF
   kD/VcWwa/WEYLEs0pycY979eWg1s5P4v+EwN0MvCYlEtu9jLTSKVXTJk2
   54Jr2ASmwUKqoGz93LU/d1gdXdDkM4j9U/1eZ/QS96eesIqZDxR1pQma1
   LxIkpC3P/BZBENIatjJN/dTafCC2IIZ9rCqwoHFhMirVeFtk01huQOeVS
   ytBTKQRzzhsvKLj0pRHsR19VWmdi79P7Ve+4AryTWS5zA2uhcKeCwez5C
   VKAdM9oAMFbOvcnvjezd0XJYchE9mR1Rs/NwDVed6/LsqW9RNTwDk/5Z7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="313186404"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="313186404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 18:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="649395713"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="649395713"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2023 18:11:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:11:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:11:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 18:11:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 18:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQJTfxtQEpSXrydyPRg5YYyNKOqIfv3QOEPWDw/rVT5iiXkE3zOPzeAIZaI/m631jjFg2xAmMFWMVNT9M21wfVpqnXD+XI7uy5tCQJ5jAWHss+Ql+bN+q58M/E7qXEti4BkoECt8xPAk1sROoNefSqz5OJ15aXAhUjhRIMRlCPu43KXYf3bV/bHOMlgwDLRA3r/mgEC0Stc2pa/B9C6vRBbKTzdYJk+BEPjq2UbLKdtuKIRpUkgyKVSnWQPtFvzhdNRHqov8fRMzQl1dempNT3m3Sozcl/4fHuNi/NiueZCuVCH3A3qP5+di9nL9Fiey9zDWDkj2m+0XG5a0Ky8Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaTTkMGJKHvyySILzsFilHtJKUVrskS5yh4QMmBVhKY=;
 b=N/Ow2IjrkCT3SA9kGKDKo5zf5emIKtg/fSvevBU0VeIpksNWOpx5q0147u5Z6QSZvLUEUGkU5hHh1ax/wtDvZ5zWzDR5JajBbvrmOq114HhEQBRKrgMHyQyif+qXQ2o8dqOTnJ3MR8MZilYo/7oQHf7eL7U0MG2VegmKmecPXOeRLgDnMKR9izjLtiuoqABCvWVEEE6WT+KlrNw+R+S8qb1FEE8qX3VR5YzweFGnzoQDK224tbl55U83CO5Xg/Ln0f9Ojn1fx/p1RQyeYmc3/860jtlCZNsFQQ23WRXVqdwdy/5a9VNnu6XTYw9OYnpiMKq1WpmGeBiKqUQ1tWk3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 02:11:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 02:11:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7PjtZwgABzeQCACkyk0A==
Date:   Wed, 22 Feb 2023 02:11:39 +0000
Message-ID: <BN9PR11MB5276A3EABA1F00DED4B5B5DF8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+zVliMV/R0ALrlT@nvidia.com>
In-Reply-To: <Y+zVliMV/R0ALrlT@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: 55428316-3551-46a8-0917-08db147a2279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/qWTuVf01CcWemqs8EEeW80FqyAQl11M9+YvgjvNPhmxZzPosey1eYGfoCpQQHPd1pXa7vraJPPVilQIxIjvBTV+2jaJi7Fcx8zAh+/ivJWHg+RZ0v9JHi+yd25odVsQXWjmyK/wwflp2W0WPAGoU4RfOghx045txx/MGUb0nd0tlhFCKkK8umgHVfDsye4WB50BAyMTuBVbPqzXP43lCGc2+kBFaJlzOdEjCyP2lHTXm4kqTjwzPUQwuP4470cJJncHTL3ML+bRK+39rBDWcnZa4z/EGKR5yhMtCd4FoTilhp5pMZeZaTpIqTFw+gnxBQmTcFnh0lnxdNIVyG1FFugqzLB1WT1Y5wl3bSwYc7w0jA7qi+nCO7CYLwLC898uBqLZxXobEHsYvoPoK3qWQTnITWeQezzjupMSIOSVfmGgEToOuEj2/TXV1AFgeMVuy+cinMZ2X5/XqTjdYSskyKqIYyEf5DhxYHhhXfMmI6ZPm+RkpXrRFBtOzVDlnKbA1+jdcItJpSHKNNs9p2SxYj682okl1E27hprIP2KRfDLQ42/zms2ZA9x2dX+ttHhBQVdHBjbqn1zDOQIGieo/11ekPNCcg4ZZQ0ZAvTIICp6F4yGJaZoKPuW+obnrUS8/DDMMuJ/CwbRyfXjFCIDct/TAjMBECWhUc1n0nvV0JtbKltEIQBEB8ZOhHnrc8nq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199018)(316002)(33656002)(38070700005)(82960400001)(83380400001)(2906002)(86362001)(122000001)(38100700002)(41300700001)(52536014)(8936002)(7416002)(5660300002)(4326008)(8676002)(6916009)(66946007)(66476007)(76116006)(478600001)(66556008)(66446008)(966005)(7696005)(9686003)(186003)(26005)(6506007)(54906003)(64756008)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUF+fAsOoUrrcfIJxD5hl4TkkJkeBS4pvRxEW8Dk+s/9C1OmG+iqdtgPBmoA?=
 =?us-ascii?Q?CsWjgxFNnIxjNHMSgzBwnuK410te3p3fBUSfORJb064rB3WyyGbLIEP/MBpa?=
 =?us-ascii?Q?C2MDfMcY4ybCO4z5mQHhCNOJhGmQzRl5ZxwlWKiJtIE/eIDhLoIIV+Q5Uq7v?=
 =?us-ascii?Q?8Nwq/d6Yz8VL6NAtuxvP8CZ8x2AD056/wmErosfzQrQJ0eX3k6TdPigLFNnd?=
 =?us-ascii?Q?imnjHUbIVqE8+9Ep10N1nNk6bAYotZtHZ4SYRKQH1E5yRUL+9qm4PkNnXVNT?=
 =?us-ascii?Q?i0ZG+XDiAu1Jw421El8sXzS5fvYLatNZpUTmFnTgKmZRWZ6MJD6KF0W2aYZP?=
 =?us-ascii?Q?4gQ6J/x411L0AokDF7I4Er0PoLHpN3StBqbaeRlx5UxH8876Mzc2cCnhCpnT?=
 =?us-ascii?Q?7+1MPAorv3F3/Cir8NHGKMy/V+WR/BuQctCagbePk0phOhN0tAbMOMvZfJZC?=
 =?us-ascii?Q?8ZQCRw5TV4Ew7fhwVJE9jqI6KLSfRMMrALIRU2w0WE4jrPi0TdUESqoP5kJL?=
 =?us-ascii?Q?Ff7B/CfanWZi5l3YSDwI+s7Er66LHkm2nG4siCxxG2ePCKImOQ+HHkL/TehX?=
 =?us-ascii?Q?+TD2Kt/3AG0SGjpUTueLnifmBnziyw7VknWK2nAYVJAg2BngnmFfiXtRghig?=
 =?us-ascii?Q?PVv1CAfIphETDWJWdyOBu5ZK3rEIQrtevQ3dMJ1MaE56dGLCV83SFEhqJINP?=
 =?us-ascii?Q?jrBOq8M/Rm/1Wvzef0WgHWFPTz4l4muQ7jnsQolNITD12Rl5MJtkllPOEFW+?=
 =?us-ascii?Q?XF22uud21zv1y2v5BCXPcmI7cx7Q8bMbf/hXFWJAH8SGbyhIekPGNLhFyIpG?=
 =?us-ascii?Q?3sOA2BAww6rsixtLXVGvCOlxp64Ozj9mLKfe1Q7nQDqMzBO4hSMYiKM0HJpd?=
 =?us-ascii?Q?eeYH4sYjyYdVuaSjVAEhOUQIXoC01bgXv0066AhWp76kai97xVH7VZevD7vS?=
 =?us-ascii?Q?mm3Qze6ehCY2gvGtMYSJH7qEYv3fByFrDIh92XDK3R/Zbwa7ZA66y/Kikegr?=
 =?us-ascii?Q?Ot73E+FQ94sdb6FHhsZPGC8P9VaRJ7uPkfVdu4gqYJbK/pQLeOdX6e1jsTWf?=
 =?us-ascii?Q?ugtN6HMJypyeV7lTmnN9iScJG0UP2KrM08hbTR4U6YbphQ/dKayx4os+p5V2?=
 =?us-ascii?Q?aasf2WYR+h7VH4M8I9nS/ZSGcgvP8cvO+MFVEf8XNXlH13EilaZKTqDRbTZs?=
 =?us-ascii?Q?pQMPMg0FcIGQqjD7KwJpn0OuvqAoX1R+t7oIJaFi6AU7aopUxx5FY3Ir+pJq?=
 =?us-ascii?Q?3JkiN3KGxLTL1n5i90SyNMdLBpKOpy5fVzcI8D3sgE30c0eLcNWw965YpJhC?=
 =?us-ascii?Q?LAA0dHQUYFvj2chem2Zd2u6csRYrkYwVsjCrP2f8RjFEaSrNSKjmzh0w9H/r?=
 =?us-ascii?Q?BWgPcz+Wt/a8h2CVQ3dCgxBetuO0o5m52W7Jsckj08QqwfsCZ2I4tCIz1Vwz?=
 =?us-ascii?Q?Q0rZZFxLadghJrbO9QNs7cGN9NPGzpRabRycQcvKY2alkvE/dbA6WzpU4zyr?=
 =?us-ascii?Q?7f0FrvBrbQZK9NB7S+KmWkEDv1GkYQfurRc21IrL47SZhJex94p7avAi8NPr?=
 =?us-ascii?Q?sGPCv8lrh9i/8opwf7WLl29tY7oV2nv0oX/ep2vu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55428316-3551-46a8-0917-08db147a2279
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 02:11:39.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qImDmkHA9YBcnv5++j+vm2w/+J6ObS1+zU3qD0W0fY7qTOPVcKDwHdxoxPA7FHJEx06bhM9GPlQV3wnD5frwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
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
> Sent: Wednesday, February 15, 2023 8:53 PM
>=20
> On Wed, Feb 15, 2023 at 06:10:47AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > >
> > > +int iommu_group_replace_domain(struct iommu_group *group,
> > > +			       struct iommu_domain *new_domain)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!new_domain)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > > +	ret =3D __iommu_group_set_domain(group, new_domain);
> > > +	if (ret)
> > > +		__iommu_group_set_domain(group, group->domain);
> >
> > Just realize the error unwind is a nop given below:
> >
> > __iommu_group_set_domain()
> > {
> > 	if (group->domain =3D=3D new_domain)
> > 		return 0;
> >
> > 	...
> >
> > There was an attempt [1] to fix error unwind in iommu_attach_group(), b=
y
> > temporarily set group->domain to NULL before calling set_domain().
> >
> > Jason, I wonder why this recovering cannot be done in
> > __iommu_group_set_domain() directly, e.g.:
> >
> > 	ret =3D __iommu_group_for_each_dev(group, new_domain,
> > 					  iommu_group_do_attach_device);
> > 	if (ret) {
> > 		__iommu_group_for_each_dev(group, group->domain,
> > 					  iommu_group_do_attach_device);
> > 		return ret;
> > 	}
> > 	group->domain =3D new_domain;
>=20
> We talked about this already, some times this is not the correct
> recovery case, eg if we are going to a blocking domain we need to drop
> all references to the prior domain, not put them back.
>=20
> Failures are WARN_ON events not error recovery.
>=20

OK, I remember that. Then here looks we also need temporarily
set group->domain to NULL before calling set_domain() to recover,
as [1] does.

[1] https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@=
amd.com/
