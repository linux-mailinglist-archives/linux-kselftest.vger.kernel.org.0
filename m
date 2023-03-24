Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244A6C751E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 02:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCXBiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 21:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXBiG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 21:38:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D259769F;
        Thu, 23 Mar 2023 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679621884; x=1711157884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kfVS04oT0aSv8947XgLixOTUe9e4XoP+mVhwJPRqkoY=;
  b=etQjzfYxiMH4dN/3RG+yrzZEaNvQMzcjpLoRTC135wEWsouBQtoZX/D9
   oNfNLuMgRcodWOVs27hRNxgVIY0/uklMVjbaE04Ql2ZeRa8FiYF3OyQFV
   sYqKCCQIm3d7DO23TSYxDq+bn1JyNulVD10BFS8SKLgZwyYLBcl0kRddu
   oSvhPdXbawOCbapj74xs+UWjC/AqXr9Dv4MEGKpS+TEmgFZ3LJOvqEA10
   FmSw9F/7incKXsgFQeZQapuR8PHeYQi4lLoMUOp3Wuhy8/PK/D/n5griv
   H5fUKFf9/zDMUnuP0Y7l2KnIsWUDJAyxLRcFJxSle/Ug5hyWYMGdTbIn4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341231323"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="341231323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 18:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632658064"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="632658064"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 18:37:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 18:37:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 18:37:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 18:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A26rVyulA3PEreYnQWcf1PbDwoKhuPN1Wa6qnC7QBVkJ8zHNCZfW5fu2pjGEHovakQG9SogldBHgpCqR0aTQE7DGNjhW54r/3IzRyluMLi5veQgxus9/1mSRGsrKQnXZqB7GWtm7lYDUFOoSRaxOFQ9rRuqIRIUHxW+yM15tNEsnt5i+jzcws54qFVUjOHlCMxZHAb5JRQOA9iAJAILCOn+p0+0Eb5LAdL61Ci2plMFYH2NQXfc3n89QaVLed8R0BmN6+5cos5hAGC3YWGgdazzrmIDUtKdeTKLcfsdJHERFzeZhTkdqdyWA4ZuuzpFwgsP7u9pc+Wh7LSei8gUlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVtE8r+X13VJNH/DBCu9lx/qclWRFFfMRz9l4/GbV/8=;
 b=CF89KK0YVF1B2Cn9+fL8ClvDZLE8s/RMcIAN93bZE8/7fD85LjUkmk6/Va75O7Ng0p8p4JXmoDdiS6+pM6i3Xt7b5eMziPwhb0Hu+KLK1+5dkugFgHF0gp2zAMYbFYvVn9WoFrQO/HRhbNwwyfa1ki+d+Jl6+8Y0WwKxYjebUqoS022WxGNpgTAByYL2fFzDqCy8O38/XK6DRspD9+SLVagPZ5VK/HwKv0T9uU1tTNw1Mpjg/1aOpYpg6GZx3rRc6XgXAljWVeZtaXUe3B7QFxzh5x6b3BvTg6UfnpZr39TYem9JG8Gr6HKSl0VcGUHXe23l2AksdrrMNRGqcYtrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 01:37:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 01:37:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggAB8LYCAAK8/AA==
Date:   Fri, 24 Mar 2023 01:37:51 +0000
Message-ID: <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxg9cRIpsozB15G@nvidia.com>
In-Reply-To: <ZBxg9cRIpsozB15G@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8337:EE_
x-ms-office365-filtering-correlation-id: b8579362-c8c8-4932-f048-08db2c08620a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2R7T3z+55PuHtioEPlnKaCPd6hpQvbnbEU+fPgrYbcsU+eqRr4FYB3gkD31puFUYU1RssmnfFo6KG4+VwAoF231kDedCf614HZRa1KmxluCkcuVexG8Lu/l+BAXremUbGHjCNJDTqQnZtLcLAPX9CfOePCrDr/i3C4eR2eiQkmoL4Bz28IM6KW7qXXAxZtdqXYAaJp2d3WckRZVdDzfN6tErpO0T4Info6+u4JhGrhMjSMPru8odnjToeiFWofwstnCPJsaM/sIy/aWGo3afyxI64ipOJ29dBEsr+hrY7dE1ehMbPTOMzyopiFHi4YJWSjSWjyaao0dIwDlcjnktiP3AudE27hsY/L9+WmF2511++ns5aW1nUm+Mv4Vv4dJI8xkVPH9FMecRKl4v6CQeUgfil0qvK/OiE9vh1WjzoLAsG5H17AwRD2Zbf70NJ17KmTEXN9gkdkYbQClntoZ3kLjvzdE5e5D9PAhtkLHSQoNhNokGF2BlsDm7SF5zcUXZ5XKmaTKfCXY9VP/bhnRyYEvIo+GmlPhV8In5KTWf5L3/qnywssPT1rKvH+nfIhAw81sOSb8KDzOYvCrY79Rp0y2RUiLyGlKX9n6SYmCg8xqjIEtM9LiZ4rHg0b2hd9BT7K06gwGmZkv6e0AjHd93dKyYhbc4534Tl3SlNOwp7dm3/vFPj5Kvh8RJ/6wAQKE0ezF8r/41wKcGVv1fA7Drg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199018)(33656002)(316002)(83380400001)(478600001)(54906003)(9686003)(186003)(26005)(7696005)(6506007)(71200400001)(38070700005)(55016003)(38100700002)(82960400001)(86362001)(52536014)(64756008)(66556008)(8936002)(66446008)(66476007)(6916009)(76116006)(2906002)(66946007)(5660300002)(8676002)(4326008)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+ffd4dM6CX0m6qF8J7z3JxaYlZSfsp+c/+hLDgO+WKSGBHw9od4rNY9f/Ac?=
 =?us-ascii?Q?2Q+bURRuo7oO/WIZNwsaGkME/pmpw3F/UJNSoQBgHZv95CPLpfd2lNC9cFvO?=
 =?us-ascii?Q?fTmFUvZXhDEUz8dXh76EABmcXJySAIKcfeOexvM+DrE6bPEIIOnyx0NVexTr?=
 =?us-ascii?Q?ozI/3sADWW5htApJR2FhOyACie9EIEoSydcaYtoMrVPbHa91ZM02sNRHaaEb?=
 =?us-ascii?Q?qWSIGKc3FT+2NRCxnwae4LgcFldUB7i3bLNrKo1L91VyQMkqCqBXoPi+avtP?=
 =?us-ascii?Q?9qmF+gKbNeFvU7lYBFBAr2GMJn6tHwQf7WTxExnjtetKrDgxq30zzydFJ3/9?=
 =?us-ascii?Q?sMFs92rPBh5E/uCB3sXWKnE3kuVOLgIYPEzZvawSVnYZrrSvScwHqgy//K/W?=
 =?us-ascii?Q?8y776VxpGV2IwrQj3fzhTfAfAd737QWs9+VIWrciLvhp3HR1EfIKFe4YAHu/?=
 =?us-ascii?Q?zrC8sE/yR5z3uHsQasQuMcmKRJbCEwvKIfifW8CWHgJzqf9i2mn+an9bfOsj?=
 =?us-ascii?Q?TIuQdvl3/uRPLL8rTdHzIk9h1xPFELSnM2aNGifh7xAm3iUz6ivpY/OsJr0E?=
 =?us-ascii?Q?p+AfgJ9UjTLuXS036mk05A4DYYwRA0LvLj8WnczNtHtYy9EQR0mGTEEKmK2E?=
 =?us-ascii?Q?/QUsR030ZOJ4+ymN0BvHvfG3JMz0/QTFcPEvXKMZ3s0svAqoATwK6pTHX8rh?=
 =?us-ascii?Q?NyGyJ97ZrhOTVaH2EfIAjDlF0LdowIfduvViOrUwtmKNBcvGE+UlhBPAM2EI?=
 =?us-ascii?Q?W8p1IdHUplNym1f/mb1tCyo9lmalitN6uyqGCjHo2LvN7WftRfSykZBqtfTZ?=
 =?us-ascii?Q?PfbztBQEPD9owpennjAb6jX0SS1BAZDdQ/eTn5/1LlVK0ZGiZBW5Qh3bC3mU?=
 =?us-ascii?Q?48FocWQzFjsSCXnfPI0tnItPFMtXa9tVXhiVf6ZQSVOLmwpwaMzo7j8DEGJx?=
 =?us-ascii?Q?2c1zkc+KF3YJKcOeUeEZL717Mutl6elyhY3bS1P4/TvS4M/ae1tmfMAnD/KZ?=
 =?us-ascii?Q?sW4jjKRhebyAOf8pKb74/vmoog+KMnjXHEbU9Q+GKLC0qC03EY6cN5x6wA5y?=
 =?us-ascii?Q?Oo4eI2yd2fgjNpNz2Yu2L4VGgaNdJxzWWnorPfSPYiRVxSdo6WhKS5xT3uys?=
 =?us-ascii?Q?Ul3EzmfTDqu/nvb5tVmplQ5FqD7b8NQUqJ4jmsThDgnE0/y8uaaVj6pUitXM?=
 =?us-ascii?Q?N3YxftZRvPTLdf3+OawU48IDGdIn/wrezsJrTFVIWUIXB/+bD2s5SzbNzkkE?=
 =?us-ascii?Q?mPLNHYHwzpk6H7WFd048eVv5oEpikqZ+GvZqAFK/sMaTLAtyGIXUBUVlBmBc?=
 =?us-ascii?Q?Cwghyp1Pi/yGO9rn0znjbaMZKnMs0Jx8nepQUuDVL7noMhytawYdJVl8XwxD?=
 =?us-ascii?Q?qnR0I2aQFUNd9c++C8dhOo2yDOt17T9GIogm4WVokChxTg65nbD7/uO0vEUA?=
 =?us-ascii?Q?k+2OYtbCxon+84wwNF+Mbtjg7m1uGQnIOOpCfnnZeCBL/Y8bjdI1fp4GGtQy?=
 =?us-ascii?Q?jbaXpD0Dqbuhf0coVy/wz6jLDaPV/tECEZA8xwNohRbmrmMHFgNR1qFouujU?=
 =?us-ascii?Q?j+vxWLkXfCKkOLgHmiPRWtAys/svO0oWWlzIxj4Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8579362-c8c8-4932-f048-08db2c08620a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 01:37:51.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KifEGpk9AngAixrMlJ5nA7xHxZQDRPre3tqajqqsBdd2OMKLDsN77jl/qPXQfRF32qWcA5aDBvZHs7Rmemrtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 23, 2023 10:24 PM
>=20
> On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, March 22, 2023 3:15 AM
> > >
> > >  	/*
> > > -	 * FIXME: Hack around missing a device-centric iommu api, only
> > > attach to
> > > -	 * the group once for the first device that is in the group.
> > > +	 * Only attach to the group once for the first device that is in th=
e
> > > +	 * group. All the other devices will follow this attachment. The us=
er
> > > +	 * should attach every device individually to as the per-device
> > > reserved
> >
> > "individually to the hwpt"
>=20
> Done
>=20
> > I thought about whether holding igroup->lock is necessary here.
> >
> > The caller should avoid racing attach/detach/replace on the same device=
.
>=20
> I think even if the caller races we should be fine

If vfio races attach/detach then lots of things are messed.

e.g. iommufd_device_detach() directly calls list_del(&idev->group_item)
w/o checking whether the device has been attached.

And with that race UAF could occur if we narrow down the lock scope
to iommufd_hw_pagetable_attach():

              cpu0                                cpu1
vfio_iommufd_attach()
  iommufd_device_attach()
    iommufd_device_auto_get_domain()
      mutex_lock(&ioas->mutex);
      iommufd_hw_pagetable_alloc()
        hwpt =3D iommufd_object_alloc() //hwpt.users=3D1
        hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
        iommufd_hw_pagetable_attach() //hwpt.users=3D2
                                          vfio_iommufd_detach()
                                            iommufd_device_detach()
                                              mutex_lock(&idev->igroup->loc=
k);
                                              hwpt =3D iommufd_hw_pagetable=
_detach()
                                              mutex_unlock(&idev->igroup->l=
ock);
                                              iommufd_hw_pagetable_put(hwpt=
)
                                                iommufd_object_destroy_user=
(hwpt) //hwpt.users=3D0
                                                  iommufd_hw_pagetable_dest=
roy(hwpt)
                                                    iommu_domain_free(hwpt-=
>domain);
        iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain); //UAF

From past discussion we assumed the calling driver i.e. vfio should do
the right thing e.g. by holding dev_set->lock otherwise itself is already
messed.

igroup->lock is really for protection cross devices in the group. But as
pointed out below we can narrow its scope in this function as another
device cannot detach from this hwpt w/o first attaching to it which is
already protected by ioas->mutex.

>=20
> The point of the lock scope was the capture these lines:
>=20
> 	rc =3D iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> 	if (rc)
> 		goto out_detach;
> 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
>=20
> But based on the current arrangement none of them rely on the igroup
> mutex so it does seem we can narrow it
>=20
