Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F27CA186
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjJPI0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPI0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 04:26:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02507A1;
        Mon, 16 Oct 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697444790; x=1728980790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2dEd80Z0QMbHix3o2BvD5EbUxsvW+dhISGCfxKK430g=;
  b=atLeGppdHyk2iO1ivSPH418Hpll/mF+BI1vjMk8pKDOF8B+U9si30dZm
   XrfORf711TTOCilmhCUxTwy/6VTcUoShhP9QyfMA2A5a0/kYDoAXuaemo
   PO3zRn9mgf/lYx1UvftNcSZMdezhTdxDevzTpgv0UI4ANIAeYWDSdvftS
   FiBXU4Utz4vmwWAHZlJ9EMPsnpBucJibcB56nn4Nnkw3ReHG5BTMUUTMd
   0zXQ1LKlI9dCLov8JTJEUzX7K/9mP+VKD5dF5T9uJi221ep+BcFsQrQQW
   xq7zrKokSy5YIwPaYbMsuRQheUyuH5qPHC0DkFd8UsBggxJMtvUHwmXJ/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416543811"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="416543811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="872002154"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="872002154"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:26:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:26:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:26:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:26:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:26:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgIdvQUED2RgkGsKeMNGRE1BCHnrfogELaL0cUb4ICqWe3jZxs7IKSwyknc+il+mPHmIrKT9fJ86GXAncSylP9UfYzKYpjPUTclPU7Sb94TY+xaNK98BJgkr1+CyJKQjQTHroh1t9mnaW05lVLpp5uOCoAVSDWlSyofUNwu/fZ4HB7bfFCenStGH/wsIdmAA483xSfQQQ8B6S+bf6GMZUOGfnQQ+RCU9WOe639LyzIAU4cAq6t+taATLmffn5bnJ84ICrn+RXYDJsgYZN1ssQHNlBJOxqei29XdoE73u6WGcedmHhx983ew8ATWA9Mx6FRlHD2PCAxVUFQdPsajvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dEd80Z0QMbHix3o2BvD5EbUxsvW+dhISGCfxKK430g=;
 b=M+0xsYo8+n+2J1eGAC4rMMjWISypmNc4Y1h/MMeP/3/KC6XPcyIh3PV61rW9TpW6lkvA9bPCbJhERvh5/9OFNKbz2RkWSLMtrvqBBN7x8bslaASobikxXhJwoZ8FJUBtpKqyDmYfRlVwi70sqFo27j+xCG+5wcoXYm+m3dzcuynr5Fnvc0jAreJCSsrUL+QFtWUbLWb0QsZqWB0q2pjKmYB8RyaCC3yuWLbb2JO1MMS2kDIz4Vxd9ZTaCQFdGsFPS430pjzDwB6pr0j9Bm5CASXjnj3LKo5P50v5cDiEowD+v6WvEZVMYWj0fRvArcndP2PGhh5QAIVss+VaH9VTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8207.namprd11.prod.outlook.com (2603:10b6:8:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:26:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:26:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Subject: RE: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Topic: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Index: AQHZ7GCN3k0pHsaUpUaqL7OxTm+gurBDfEEAgAMqP4CAAMh40IAAdPYAgARWtXA=
Date:   Mon, 16 Oct 2023 08:26:25 +0000
Message-ID: <BN9PR11MB52763F73D66CBBF6BEBA9B968CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
 <20231010184932.GT3952@nvidia.com> <20231012190931.GO3952@nvidia.com>
 <BN9PR11MB5276A55B59EAE44DE058DDF58CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231013140538.GS3952@nvidia.com>
In-Reply-To: <20231013140538.GS3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8207:EE_
x-ms-office365-filtering-correlation-id: 7833c325-8f94-4075-accc-08dbce21963d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwXcaJoyk3ORqcSemEfXHdVb7Epl7nOZmCd4FICI5k2FLA0eMBPyFcpsgvqk+syN5YBNiZtfuMbwTmFcTfdnSICh5lfZMnV3va696m1kUNAMK0ThepCEZh2Nk9YesDe69pQLByafl/ZXPverqi3wcG5aUYBIrfIICvhFoJTTIpBi0t8ImPah05wEiXpM+yrX6xXCkN1DYLPgur7nLPyDsZZO73L3QQA3nj9ZorF8G/9tjUNk8f5E4xa506rvIDBiKuK75p/dqHZeEf8xWCM8h6XKrK7Ih5/6WUGY4IV/oev0RAXx+638+UVome1qtz2Q2zoFICmOUL6Itg9aTRNnOzTWkZWpofS5YKL48+lgl5Z507cnQDniqEpxoGFV3Q6TESz5cbdQTDGfzKnvzkHYwwx/kVnGvR+uCdUq63Kjhk/A2HI4VXmnpE7zb18Fq7vyXTqMcJ9yIxxGn7RkDCGUBQTXpKAwcmClRlzILdbG3ktfNhyVrmSi8P1sbX50uSWL23nh0OKNTD8r+mFZuh4PRVf5APlptZLfywiOSAytWNUoo7E7R3N4b6SyC6LbNs6zRRYFuL5KjHudqhcnOR7XH4KrXFX7InVEKS5uIdFiIiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66899024)(55016003)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(71200400001)(83380400001)(86362001)(38100700002)(82960400001)(316002)(9686003)(26005)(7696005)(6506007)(41300700001)(33656002)(5660300002)(38070700005)(122000001)(8936002)(8676002)(4326008)(52536014)(7416002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5id6hWWzN99ry8/1UDby0pyYsKrF/sQRXVkH3oeZIJjOz2hvF5M8UVTVYyQ6?=
 =?us-ascii?Q?D/xoqztOgCDbCNvrl9GC3SFczX5idqE3AZpSYVW+uUIIDEjp1Z9dZAzpfowI?=
 =?us-ascii?Q?BQnq52kdgcs/Jac6NkbIx5/gE7o0PDx912SC/Ve/gl7MJtAK14Kf1vgHsZ72?=
 =?us-ascii?Q?ebTH46ZpFQLj/ZN5VhQeR11rM7L5T5PvklT6ItJU5ZiBUHeUqCIqw83Tm4Pc?=
 =?us-ascii?Q?mMS7zTtb8Iid1bKUBnkJw1z/R3GAIt0Og4Qv8192i01lde3oTjqnwf+bvBKI?=
 =?us-ascii?Q?ZkbabTq8y/R8+3OtXJVy41Ijly1Ev5I7vaewgo9DIT4c/5cdAoStz4q/kUTG?=
 =?us-ascii?Q?EbLJUXhqzlq7ia2BrnvJLNWM3w8TlTtr1+DNjI13tbjRiIiM18PCmvreZzoa?=
 =?us-ascii?Q?YxJ40daVBbK3BHh88nFSckQyH+lScHymJA+NagwVEaSOGwnLNdXk3NqcOCu6?=
 =?us-ascii?Q?eWeNxN3aX4c99YJpJlqHnR6FUx0mCPLpHXJylexpY9eGZvM/vcrRvcZ2NfAe?=
 =?us-ascii?Q?JYu5i9pQNHtZdx4AHu8Ro+gX4XmjNWLMWpWSBdGNNjrlDCwsKzawliFA6iib?=
 =?us-ascii?Q?Hn9yoZzHGhobsfG8Cj3PaZ+ZXdGLhAxrZt/aM5+3Pist85JwAtXEJ0oTDHV7?=
 =?us-ascii?Q?sVTokPomqY/3vulzSN6VqQDm9Qpr4vZjpKFuhHcY1jIjldQzgSF+akOM4+82?=
 =?us-ascii?Q?9I3oBlY/2THIeNI4CqnEH9TJFAwWRuPasgNradNSrGthNKHITi4Qle84cpXG?=
 =?us-ascii?Q?sbXYSW0KN3cmRywGSjHjfRc1Lj+dJv5SHEQO0eBasGVmFaxB20VDJyvF07Ul?=
 =?us-ascii?Q?vikxyw3SFj6C3FWbmk34BJB2hOIap89Y2yuJ4tT9KJxZA+uyj7C+WTlvhi8S?=
 =?us-ascii?Q?itYOs6GAexAkLdOT4UJt6gk3FpOBR1idv+9uc7guKRGPFEGF0BXIHXrmtjfI?=
 =?us-ascii?Q?aVTZX+HJvzQjIh0ywfgUdMrMMYEr0VM+u3a1fMYS8gFa4G537lZu142g92Rc?=
 =?us-ascii?Q?lTEvgbQ/3Z3oflLOAdsm6N8GIqYObRqJAmC7jsnwxVdUzicKHKXLKgwrNPL1?=
 =?us-ascii?Q?h8D9sYdUXw4Eqk0nylw85kRqeoEOqsF/MSd6WYBwQwK6nRZbnuRFhGK1HHga?=
 =?us-ascii?Q?GU8et0mr1A2ALxvItWEzNS4jVadItL8y90+BeXAFV10uTQud0w2PJ0NQZash?=
 =?us-ascii?Q?oRTIBJVFNe8JUmHJ+U4dbKR0iShmqGQr2l1BPuRjXhGsF6lIX5YqRpaAN4g8?=
 =?us-ascii?Q?liIh/yCendg9XV988WdFNx4wPcQg8yFx4AbL0r9KuOIEFPkjNu+tLs3kqSq+?=
 =?us-ascii?Q?zHq8OeHJx2SsKHXFCmv8+R3yjJlhJ5AP5NNnIfMtK1bT8/tZK2976eHV/3uf?=
 =?us-ascii?Q?/YwhwlYwtkJV8DKMsknQ/gCwt2FlAS7ADsm+2If3aZXXjBHbDBV0hhD7lmZG?=
 =?us-ascii?Q?vZ+Uo+IA1QO8d6qBsBAiZvYLfmeAqUQW81KC9GD5BJoESWvhc8irFD3njRL9?=
 =?us-ascii?Q?4zD3SvI1+kmUjsYLQJrFAqxdjzvYumY7AC6QhjXRT9MelZETvqNOjrCC9U+U?=
 =?us-ascii?Q?dj7VadoL1BHcxlBju7PzvlYi3PwrUhkufy9a0SBz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7833c325-8f94-4075-accc-08dbce21963d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:26:25.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kJy8PmEMnEBAxHNObCEmOjB43tCE2vAYm6NTQ/cj1+YpqwejrJ3N55v7xGsKUrxFqwYhdcvnevZLmga8gv02g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 13, 2023 10:06 PM
>=20
> On Fri, Oct 13, 2023 at 07:13:34AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, October 13, 2023 3:10 AM
> > >
> > > Also, we probably should feed enforce_cache_coherency through the
> > > alloc_hwpt uapi and not try to autodetect it..
> > >
> >
> > In the past we had a long discussion about this with the conclusion
> > that user opt is the ideal model but it's fine to stay with autodetect
> > and existing vfio/kvm contract for coherency detection until we
> > see a real demand for user opt.
> >
> > Is there anything new which changes your mind to have user opt now?
>=20
> I guess, I was just looking at the complexity it brings to keep that
> working.
>=20

vfio_file_enforced_coherent() currently just looks at device_iommu_capable(=
)
and can be called before attach, assuming an autodetect model.=20

moving away from autodetect would need a new contract which I hesitate
to bother with at this point.
