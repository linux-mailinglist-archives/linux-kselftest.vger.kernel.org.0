Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D37A82F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjITNKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjITNKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD15B9;
        Wed, 20 Sep 2023 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695215410; x=1726751410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gV2lhE+GiZfNryrTwUKwIpH4u0ZFHtuV2hx3YfIicOM=;
  b=OWe5JOQ1z3+vxpIALHT9ywFvmyspscV7d7b7vRbkG2BPpt2HJrAQ5cX6
   h2i0Q8xwviBCIiH9H74/M8U6jXXzW7brXwuQerSE7rweKSyYrnGj3yfeJ
   7YfxuyBZLp1GGIu10SX5w0+j9inkGFyV5UqHKeuR35q10QHuhX5gpCHvB
   HB1/5HQicdNptM9GNX4Z8Wd5BCqiCDLv4rBjeM9Rzi+eklMiYYxX0ihV3
   tiK48WAUvB6/ESpt2fgmw9STlzS931eq0ZQt6kpIxWrttWrc7Rnu0hR6G
   V+A3dIVN9DYsV3DeDSjyhd7AH/oLi0hASPLZGSqn7uQPajrFfrnYW0N2L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384061301"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="384061301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870377331"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870377331"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:10:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:10:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:10:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:10:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1T3W0pIIEf3OMzqENb+I8usat1GM41DaDy5VuJ/wJbAgDbNsmhwonB3ykbvtG4FkByeGe/Wbha7C/0prmx1Uw/Q796xkgwmdFjr1mt0tE1xOFOWESqc4fo9X/PFyRymJY7wn7pRRvxoQF9h6DMIng8mjTcgjn+upOjqptepUdvchmSCwby30LKKCAmUHm+YQtEVzdcLciUNJN2sV2lP9RM+D5JPIvYbGYmbE5WQWNStXsQy87zWX75/O75BB5RAd3l6ZA3iDfywnkE9lkEnE4VK18MCHk4iZc0sZc89n5slxYFs6SPKCg0ZvJN0gZAjD49aslC8P4glQ0r+n7Xouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9L4Sl64Nq8FKC8BmObJgV3Su+IuycRdXV4Kf9C5OB0=;
 b=fMWFzrDWNrVYEd+USrYORaoP2XGD7W4ZX4ClVh27KzCzQsb/HsUy2ZI2pDbpRSjxAjmPptazKvBBZ2z+Yv9MSpgOYOCyNz6JH5VvctLD6hl80K3lyZMk2YjMCb1bBw/qk47bCDY+b1Dw8rhyQ84CF9S20o0va8VZnjFODVjP1GflbNETOyzim0MGRwRD0sfGJlOKR2XKMzmKh02HSKXSETeJQXz0m/RD1E0EN24ejZYQk1D0TUOjkr/uT4ExKFks1t9SvXPabipGiFr2Uk0FzG/x3IyRescJ+XPQxttv5jWBZKzg0eI014iuzPa5ndEuCFstFzA84oIpQW1IHu5wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 13:10:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:10:04 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Topic: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Index: AQHZ6ttUqZRrjysqnUa2j9no88GC0rAjMOqAgAB/mQCAAABTMA==
Date:   Wed, 20 Sep 2023 13:10:04 +0000
Message-ID: <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
In-Reply-To: <20230920130522.GV13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH0PR11MB4806:EE_
x-ms-office365-filtering-correlation-id: feadcf91-0d59-4ace-8bd5-08dbb9dae7a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/Mntt30wgBifBbo+Wi6TaDbOUrKNOxXEJPjksrjaoBdVB7RcJ0XVadZ1TlOz8p4lApCtwQDdSfgYypJ/+w9fCcVsApXvOvpm77FW/SUwEfK+JpWQyJCwTYCdgQpPDlIltoXqpXy+2hsQe4i18th2jDcgzhsrTnu0bbLrpOmGKn2N8M0zp6egtkRF3xB7FHVY6swGRoHg9xkHeljIG6qfvBRW72PshJWaFuG5MMvsu6UdoT73F6S2bnUpPIeAMEZMDBCRcUfNPe0BLwawyNrRdWhF9/7sAurYvunC+SnmRBRM8yy1yEqkBxheff4iaQMjoa9RmNMHPImAcKPgwwsCc8kGQ3NE5+qxOV5W6zkUgnTzq7QVGD9NYi+6S+5G9F8aJ/TqqYr2uuU1KEl4FF08bjBce3jtuAa3GGK4Dltm9XxEZajv+A0z/eK5xYFRMaItWZziOxazAuz1xgyIxoMDERf3k5sBH9/QbTGJMuy5Zhq6hevpRsSyg3+R3SYqzIU4LnD0TGRgLGKCPpQo/6ltmQwwfhUpP+UKV5VPlCnHBFK1OPFzAAI0XObZvQynqvWbQowNxw15X5wDs+iNyHRhqe8lbCBuPwJ5ZJgNg7XSwPFy3xXCmaH7yLbJVrEvgoS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(186009)(1800799009)(451199024)(4326008)(5660300002)(7696005)(8676002)(6506007)(8936002)(7416002)(41300700001)(52536014)(110136005)(64756008)(54906003)(66556008)(66476007)(478600001)(66446008)(76116006)(71200400001)(66946007)(9686003)(316002)(2906002)(26005)(83380400001)(38070700005)(55016003)(122000001)(38100700002)(82960400001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6NtGT8FLt16tv81hUNUEPY6Rk0BNxfbsvWhMPbof2wtGwymybfSS342wJZDE?=
 =?us-ascii?Q?xYUkWhLOxC6/PbXAhpkl432jjnoLc4sfvm/v9TgxwyC6oqHRdAmhSpY9Ijci?=
 =?us-ascii?Q?tinqJQkxmbwtp7wF/QwG0Ij8O+1+9eiNm+bwM6snosXByW3c4vy9q0EdAYfL?=
 =?us-ascii?Q?k4I+RfHOZhts7eNIA5awy5J+cROjzHrgFtu3YGJnZaZA6JK7OHH5O49aWgOs?=
 =?us-ascii?Q?e+VOgoJPLc1YPBrG6PJhAaM8CieuOYe14feegDtuGVxUoYwY469ND7aEdqmk?=
 =?us-ascii?Q?rhcw7BWK17JINQjLRkU7xvmNWAdOUdsmIDKP2TA9YcemFIoJ3ZqC6moMSToh?=
 =?us-ascii?Q?txWvOstM3LgMmENS+PvgLjCfFXX+FJS6GCfQ12TFU7EmMKW5MDq1SbSvIvJc?=
 =?us-ascii?Q?nzmcTIkLZ6FdqK8JRa0TsVBv/hHWiC8zzno7mqTHeCu259pKwa5K8KbLeqSy?=
 =?us-ascii?Q?i2kyP4EZS9LHAzVg4NVEVb+OBdhXNoTx5RH4kpzoqCzEQGaWSPfwEh+AL42g?=
 =?us-ascii?Q?B49CmzglbtrjYEmf5saIaAOxiYLX9iUTVCr0IvCL0jtvPLXDP8hN5SxdDEVc?=
 =?us-ascii?Q?Cr1/0EZ4rys827aQoUMmKG5XTeRCtRfglbqcWyudpV+UHXEXOueTXIDkn4tM?=
 =?us-ascii?Q?4N3Nc/dOSrQANS51rOcy1kA+0Hnp9Y0RGzm089NtLtH95HSgC0eO/LsP/vM/?=
 =?us-ascii?Q?ZS2QE2uU1KN2GoqxQS3cgp8xxA/4P55RRu2LohedsJrLOJCF0LuMR6a0Sv7r?=
 =?us-ascii?Q?KpBh+a0EPxcbstrRgw2IqSZ6CJAE/Af+kmR/NRepHIDMSS0DmJSEbvdfzUs5?=
 =?us-ascii?Q?lHSeqSfgABY3pyNCOkD6Rt4Ok2cmAXkCsn0E5sWyg2Y/dvSWOfZ1Ah9njS3M?=
 =?us-ascii?Q?Ph9TohkBvI2dUmFcfCE3IVXwwnYkrDoTjmwUrXxZi/zqtOXbfvPA0dWXR0OY?=
 =?us-ascii?Q?iv+n8pyplaeQ43I5xd5Ltug1640M6LdJcqKKpNvTuFCaUCqk/shDLaLN2vaU?=
 =?us-ascii?Q?QOF/LQn9xevp7kOgcByIpxVTOutbQuXxg2Cq49K7+Wc7Jg5Qqf6KMRPf6SDN?=
 =?us-ascii?Q?lyvmJ79SyIAjEO9BmGYGxXPCnfhX8csrIxfXrTI/hwAXx7Gz39bTRTF2Jbk1?=
 =?us-ascii?Q?EdYR3ZPm/7W2QK8DUZllpp9T+74/eLuh22dXMO3AdJY1ndLFg70P2w2L25tC?=
 =?us-ascii?Q?GG4YHZ/SsvYjom2S891IwwNauQPbwCFzB0In7+KNIpAqxyJU69Pzm+vOBtbN?=
 =?us-ascii?Q?SQ3z546XIlzAERMSO8R4EqqlaEfuBpRuEmUivYVoArxX+vug8J6OAwVH50Hi?=
 =?us-ascii?Q?W2h5egQ6fuqyvHZSbboyve8dEqE1U4q4oX2W5Y6gwXHcSU/Y3yAzfwMYb7DN?=
 =?us-ascii?Q?FKJi1bnv0UoLHWXckyoZwbXnP5Thfqs8qaOpgdS1tDFYpBsD70LdgqfwxGCS?=
 =?us-ascii?Q?TTDycxQkf/7kfKnaQWMP3WiHvZ5djTva0miWe0jl74qIEz62kK03SVVYNGg/?=
 =?us-ascii?Q?I20HGEgyOLudL2aIwv7LbbSrWfwqF7fLOLXhiUw0Q7HWvjHHtW13n7SP6SfJ?=
 =?us-ascii?Q?yPnbtSup9lsCWweJeFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feadcf91-0d59-4ace-8bd5-08dbb9dae7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:10:04.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QuvPV1ML5f//QfRDECuXYAJIl/VSFZkL0pXx4v6CLaEX57gMbQb1PEFzBDwoi8GoXcdsGrYTFqAN8TJlxeWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 20, 2023 9:05 PM
>=20
> On Wed, Sep 20, 2023 at 01:28:41PM +0800, Baolu Lu wrote:
> > >
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.=
c
> > > index 5db283c17e0d..491bcde1ff96 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -4074,6 +4074,25 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
> > >   	return NULL;
> > >   }
> > > +static struct iommu_domain *
> > > +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> > > +{
> > > +	struct iommu_domain *domain;
> > > +	struct intel_iommu *iommu;
> > > +
> > > +	iommu =3D device_to_iommu(dev, NULL, NULL);
> > > +	if (!iommu)
> > > +		return ERR_PTR(-ENODEV);
> > > +
> > > +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu-
> >ecap))
> > > +		return ERR_PTR(-EOPNOTSUPP);
>=20
> There is a check missing for supported flags
>=20
>  if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
> 	return ERR_PTR(-EOPNOTSUPP);

Well, the iommufd has such check. But I also noticed your another
reply to Weijiang. So your preference is to do the flags validation
in iommu driver instead of iommufd. Isn't it?

> > > +
> > > +	domain =3D iommu_domain_alloc(dev->bus);
> >
> > No need to bounce between core and driver. Just,
> >
> > 	intel_iommu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> >
> > and fully initialize it before return.
>=20
> If you are going to do that then intel_iommu_domain_alloc() should
> fully initialize the domain, not here.

I've also considered what Baolu described, but it requires to do some
extra initialization which is duplicated with iommu_domain_alloc().
So I chose this simple way.

Regards,
Yi Liu

