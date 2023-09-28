Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012047B107C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjI1Byn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Byn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 21:54:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4AAC;
        Wed, 27 Sep 2023 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695866082; x=1727402082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJc/QysescemoKOW+DykoXe9W/F3IUNeJe2VXQW9jbM=;
  b=W960fF2Wzdg+/nXLuz87te7ULM2xlSM0F1NyEPZ3wDCpYKENtmmHP9Jy
   01TrAVKJ3zvbBjePjoc4AOGrfWSPyXUqREpJlpUSGY2VYVF/gKzUBDUJi
   Uj3jwQFi7WUEF4KhKdVSfWOU+ivysLuHudzYSCHfwK0JEFx8s/5u9HwHK
   tUHGf33Kz41MIfNtkqEJ4Q1kJku6v8xq6ScIHe/su/s2NjIwfTsBUYkbc
   T863seIwDPJd56LWpBVeLVqyDUPna/f73iwVJZdGuJKvxwQ7PDXTcXzI0
   anLQzyaP3uLsQRgxw8VmLy7TfI3wz213oTx1BQUtDaAYEz15eWBrP+ZEL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384766265"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="384766265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752797537"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="752797537"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 18:54:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:54:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:54:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 18:54:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 18:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYHTBf0HOveVlmiKy2pFbSIcYfh5YW3FGJ9hhWWHhajb1VkIQo/VlaWS9tQKPHwNds74vs8b3xZfA2d1FQWhsDDMQ+EjfK4R9CxTCz0uYuTjsncPZHGd1OsTfse8NJpOhzr1riYPgg25jaQTa5wEXdRNyCeivWwSvnHC4C0MmwBUAoYk2bhQnDNd41lbGXKiHUzmPTgU5u3qLIu1lV0dw2noBX2ysH6f8JgDWV/b6wyCiPn6VrJhvaxiaFk4GhlbAISuz1U6NXBbx+WzMMEQa9FNZx1QJW+ShdamKjLl/WxrRcX0Thj2ZwvRFFYYECx1ZfeX7KsxAG0h6fYsaGfKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aK28ax+ZXowixrapZriDFI3M1A1DKVT6AqPWpW7sKo=;
 b=HQa//sF2kn8sDOmgofmXoPoR7QnelzkTopJY8ElTkQOIe2LGq4VEUgxPOnjoWIEv45lJ0I/F311O6MriZOMZvfi5RYdq8nnzjJ4OyIaDFGWP3wOz2UWHRm1n6TEbjMwDk9apGCQwM0sCalKWBwBrN6OeklZi3X+cyU3RHnD5YqGx8pUiU41eVB3gKMZ9wbqF6jD6IZXAnNUCNXtpKreMzJ2S9LOoKeFJ9GJitrNCLGIZyKjXBEeESVN9TOWZlgTYuU4CEyAcdtdszgqQbMF0VWTWi3jTu7Un5wFAY4L3fV2MXhPlVboD4Pnm6PsV5ExUvY9pYK5s9w2VORQshn2+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5467.namprd11.prod.outlook.com (2603:10b6:408:100::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 01:54:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:54:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Topic: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Index: AQHZ8Fuji0mclsZAxEygwByYUuBlHLAt+cCAgADYgwCAAKoZwA==
Date:   Thu, 28 Sep 2023 01:54:36 +0000
Message-ID: <BN9PR11MB5276FE438034E96DE3FC61988CC1A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-4-yi.l.liu@intel.com>
 <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
 <20230927154424.GC339126@nvidia.com>
In-Reply-To: <20230927154424.GC339126@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5467:EE_
x-ms-office365-filtering-correlation-id: 2271ce48-dda3-4476-536c-08dbbfc5de45
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIzss2ddhvB5BAHhcXTXVjFe6kg6nlbpakBzCZwyIHjiqekrg6/P+KcWfoL72RjKwC/4kvciS2P/Csx4aa1xryapUCuBEOHxxeUBLX8NjR1i+9AaaRrbN61KBNOHCUTC4t4GXnf8OyuZSwF7kAl/YI1ElNHEHAYB3CuzrVBJFTtuo4vDTBL3LSrG5oU7VHjln4DoEUrp0aI7+K5Tyb/XfWIYavhQc5XgMYkuSwUdp0QsMAfPpz9NFmlTpP2Wciapo94H3TMyXpnIBksZSDsYaH/hLFdTvDyCMyXyKUGCPM3b82apjNXlhrZwZUrhiWBPhuMkT7iZ/1tren6pHxLWlCKPTsfWYZU9N7FIA1STOZfN1pTlvBrSxLNLVvoPRlVO/8R6YriVpxSIhOwKOEOSCwTCzod58Dwoh5larf3yB9V1eHK7RaAK7RrkbPsOmENnfKC5MXFzTEdpbqvg3+6iM/PyFB+jmaSY9c13bSbP1I49wU5KvoaRfZFThyDd/B0SR2fxiKFYhKx7TXR81lAcS4R3vJyMM4jVgZZBN2UEZWfataD4I0vozSJO09KIeOeNkI+f1ulQ9heJCTsJip5YX8vzwhGB+v/CC08Y4sBCZceYK/yV4ZlDTTGEg0Okbvgg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(7416002)(66476007)(41300700001)(4326008)(8676002)(52536014)(66446008)(5660300002)(8936002)(66556008)(54906003)(66946007)(316002)(64756008)(76116006)(110136005)(478600001)(71200400001)(6506007)(7696005)(53546011)(9686003)(26005)(55016003)(122000001)(38070700005)(38100700002)(33656002)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TDawYCPh6e5DVxIvKSL15CFVgYYEzHKoRc8HGN8AtgAYckGB4PB4k6obYxIg?=
 =?us-ascii?Q?pCZUvRQJy3aQvlzB/2psPf7IOj9kREQU9t5pzBnPfqKpehKZEN0cK5RVVbso?=
 =?us-ascii?Q?81gnlEwoEJZSFl53M5O6uNyb0VUgk9g+GfkRGcr2Wla1l0kC+rwtVyUH9fYT?=
 =?us-ascii?Q?XkCutSvGVm+XWobVPwMyC3NEkNacdgaGr7U05lbbk7KMqiaEHHO8fA2DI7Gw?=
 =?us-ascii?Q?n3lyJtnE6bENLRSab2qXEmXNShwHDrGwfWrUBpkzmlf063m8Z5qGHoH5KO0U?=
 =?us-ascii?Q?chYjz3hekKbOqLEWSPUIzmCus5YGF9CKQNu/9aMwAIEkGABv9obl4/f9pkjS?=
 =?us-ascii?Q?Mava5e9X4NrBVfcGOMVAItj6vWYxNPzSoTqTZ0mnptr4oJ/e/aniCU/7oh/E?=
 =?us-ascii?Q?3gLNXM7DE9D4U7AZ7RrRcp8symwNri2cKEnWdJgcFl5+F1D16Ux7902xJEE8?=
 =?us-ascii?Q?Kt6cvk73Xxrrh6Run29tpEtOIwEcCpmzZoqkQNR3guZ3Oo9Q/bcFs6fV/21v?=
 =?us-ascii?Q?TNzDl4tjDKB/Kr+UOEY6yN019VEKQ8xZ+NA7cszqRQV/XphAKvmoOzWZ4f77?=
 =?us-ascii?Q?M8ng0L1kZE4nzvALG4gCuEShuZ8bDsuMWXzSZbAVoLpS8XTVX96X7f27aGwN?=
 =?us-ascii?Q?IJQ388JXROpdKQ0RZ2AaFPmREd2MLxlVTG/DPaYh8FDr6WLJubPw4WYSuiMF?=
 =?us-ascii?Q?b4cuHoqulfgttxMnYr+ItPqnbtKigKN/U/4ucjYGJhEgDaS6vwZgU9EmtFn1?=
 =?us-ascii?Q?khiieMvY+2EWjt++U72hbIzKyoivnnm6wTK5iqnvX+p5sSYen+2qi27sJ61Z?=
 =?us-ascii?Q?BR002Ll4lP5ssUUwIp7NIzthV9B7CyqKGTIwcJyTWIBTVBTUiKfQcw7+Xr7E?=
 =?us-ascii?Q?ndP4JTGzXd1jHzIkh8ezSx8OpQ+BhefQkU1EFV9oWlHJHIkqYWpMdfcsifaQ?=
 =?us-ascii?Q?b6f2u30m3hnpPopxytJjwvM7WhfE4cqM+hw4pbRWvcpFziPTphXZbAhJ9BD8?=
 =?us-ascii?Q?l7802RWfzbKLZjcgCNXgKvFvWTG4R7oNsETQaS2Fp3Y00NiPuw/JICFCjeBv?=
 =?us-ascii?Q?g0qp9aNZ0rSEvXdqnWFcbi2rYXFnDW3M3aJiHHFjfumYMlvrWw51nam6+a2/?=
 =?us-ascii?Q?omstdhunOtWNpqwDusii+Kna5v8eL0Hb2P2wsw0oHpPlaK3qNL8bICosKj97?=
 =?us-ascii?Q?7W/5B/aod46InLACVIWlys2doTj+pxrNCdKe7/Pirm4GHub+fJJfVkvwB1tK?=
 =?us-ascii?Q?VvzvBFmEmRSGTtLWsx7CEvEkrtULLz/5Xq3DCdBCxESqlDu7/c6Px7GQBAS1?=
 =?us-ascii?Q?aPOugK2mJOkvsdJEKe+r7WgosbUf5hcdhl81/13vVQKcG+2lco/QqB2HdOd7?=
 =?us-ascii?Q?58ADmkWehTbcZ2dO7X3YhMp/aBEaF4HM4fVKISwb2zbQQK//vV4cat1C/tZN?=
 =?us-ascii?Q?huwgsWygoFPEVidZJbKaHZW6je2W8+HcTYZBJdffA0fxp3YlfPkNCCfSa4L/?=
 =?us-ascii?Q?dD6/XEF1x5yVHxLcC2Bp/NgK/9Yf8mvqaqJscIbNbGqnRZWApmvEIIEVKHl6?=
 =?us-ascii?Q?gmvFM5AOin6BC8rGIbdtIIiJd3ZvzOv4AF4xq+MD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271ce48-dda3-4476-536c-08dbbfc5de45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 01:54:36.1406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn68Rc+V/L48SJVt5gqEZ8YfZC5ubjDM/710eo4zsZssej7p53i7M2BXZJ7SrfUPquSToAb5ps7EIjZYDhomBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5467
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
> Sent: Wednesday, September 27, 2023 11:44 PM
>=20
> On Wed, Sep 27, 2023 at 10:49:29AM +0800, Baolu Lu wrote:
> > On 9/26/23 5:26 PM, Yi Liu wrote:
> > > From: Kevin Tian<kevin.tian@intel.com>
> > >
> > > This introduces three APIs for device drivers to manage pasid attach/
> > > replace/detach.
> > >
> > >      int iommufd_device_pasid_attach(struct iommufd_device *idev,
> > > 				    u32 pasid, u32 *pt_id);
> > >      int iommufd_device_pasid_replace(struct iommufd_device *idev,
> > > 				     u32 pasid, u32 *pt_id);
> > >      void iommufd_device_pasid_detach(struct iommufd_device *idev,
> > > 				     u32 pasid);
> >
> > I am a bit puzzled. Do we really need both attach and replace interface=
s
> > to install a hwpt onto a pasid on device? The IOMMUFD already tracks th=
e
> > connections between hwpt and {device, pasid}, so it could easily call
> > the right iommu interfaces (attach vs. replace). Perhaps I overlooked
> > previous discussion on this.
>=20
> It was a decision that attach will fail if something is already
> attached..
>=20
> But for this API we could go the way of the iommu code and have only
> 'set' and 'unset' as the two operations.
>=20

I'm not sure the benefit of doing so. Instead it makes the caller side
vfio more confusing by using attach/replace/detach for device vs.
using set/unset for pasid?
