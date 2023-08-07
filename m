Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7A771C91
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHGItd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHGItc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 04:49:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4055B172C;
        Mon,  7 Aug 2023 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691398171; x=1722934171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Y3fTz1gwUl8Cxvvnrim4y9nz88M/8yE5Y6TsCGU6Ig=;
  b=Gx0TLyq2FGaspwnLvF+4/KqA2+Ac++JVn3aCQ8DW+BXYI3n80Yfohug7
   0L/N8dMKNSVqRBY4wE8Kx9ZBAuy7amHyupUH8kVeDx3aLVVxBDKHJpqMJ
   lQXicTDtJuEWAd/DqTU9phrH/sYoRWXLczMNy4lS71vweC5jBPuY2uAos
   T2FRBdi4ZwMsJ/f4gGDkxKKZsbn/ZCipC4XmzCHPC4RKabAnT3R2I15Ld
   jyrslmxDk2oVo0HNjgQCxSsArj4jeK0KITer65mCfRNM7rOj+Vh4RU9DX
   HAzB1T5tqBd5Upj2VvFM3FglWKE6C343a6T5PJhX5aOlPhNEmXPymMujB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="360575068"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="360575068"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 01:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="765913236"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="765913236"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2023 01:49:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 01:49:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 01:49:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 01:49:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 01:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJHeihoHOaQhjoQ6dKIKSgQuVjNN6PYqu48EqfSjUG/aMmkzQx2sRk4Nd8WHLew0Hm7kDuGYKbkeRY89BgQatFXUxq5pyyoCuPkN1lDuFAjkZzarSS+5NSS00VTDEAzLRpaxlDjhME+Bv9DjNYPDQWkLVv1YRw+sqy5i+nMjTTooo1RW5B5vvm9DOnDVFj8RWAoiUXKXW66EqrFsakpiLTAMffnzK2fjmOja0cUVaegLt+GDdI8ImTQPzbvK4nCBX0IMgYOJ6DK2DjUhMNf9faZsgXx07ziHxfr7pANFOFSehioFqlv2ASD9GAo06uMaSRzgQvDfcb42B9eRno2IVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OoIGi/YDdY/YwlaD2RhkQ17t5Cccpo2wV4rs7pNmR8=;
 b=DAKX+cDAoH+z+mYtg6UmpDS29+bJFcKDcAWDtm62Wpbf6Z5TiEboZy0N69GgPWLdxOkj52MzKW9PILg+kKgqANyERA8taQdgqb1cN+qQja06NMafVYP6KQy8clNyxOwnuOQiluWCd9Bkn5DtI1an75b7+u2Kjf8JhC0/HVUpF5oVnNgGvFdZ9qsAAcOF22NUgpD1UGLto7/qw6J+8IbZWx+EAJnNjQDVmx2MXsgMGaJUzVE8Zw+Gc/ZRZRq03kMFnIfTPTD/X8MZN35hRjB1gVJb7iyvOLuhzUgpbI/1vM/Px3eECOEGMT6NBwxqtz+f6V8fQubCdLBHsybTax2YFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Mon, 7 Aug
 2023 08:49:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 08:49:27 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZxhdBKtNyRcHbIEGMXGrFUJBCcK/ZYleAgADMzICABFl4IA==
Date:   Mon, 7 Aug 2023 08:49:27 +0000
Message-ID: <DS0PR11MB7529E1B07B438DA42B0C9F81C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
 <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
 <ZM0HO02QRHnIKIIJ@nvidia.com>
In-Reply-To: <ZM0HO02QRHnIKIIJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|LV3PR11MB8674:EE_
x-ms-office365-filtering-correlation-id: 194bec72-8906-4f56-4516-08db97233511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLxXJhSsJRLyJW+MRfo75qloXqAznkLsf/I5uxwZTsP+clG79Gw2i0aqDFO0IIK6gvEcfEUdTT9rMGueRVxruANa1BJnUCrM8ScTUCNstJVUZ6C33eSNM4YIa2oBIJNIBhKfsyEGjQPae856ozAQqwZ5Vkvoh2bzdQ7UjDjU9E+pVR3DRQ8AHhJcf0aEGgEIRrJV0PnGQyGPTxhEpGBZTxH3ZFi+eT2DgE+OZ4dB7/CS0/3dK5HjchVCrgl4QbOuY6gO3K5rcX+Eebp1o8dWH1MB5uSHPgmw8prpg01YyH5OVjh18su4K8rI9WpjHfVoHQiOJYiF0qXh775ru7DNkp1EXx8xLdoOokl1w0b61rZe94KdTqhYja3JeWLkQutJr9TQdPE/xzvx5WCO4lQyyTx4/rnBzXnvJ9nwH+HQgJ5bHUuWSX917zb1A0XucmKaHlf3BXkKECbhxCQXf0+Hi/I6NRZQN2pw5DQX2VlhVIkMf84MX7xjLGLyXBHC1W1XJ0BOcEUxWREfzVlSy+CSndkUeQk3npXfEPxN3Hq9tpsFTYK8LJt4/boBhtSZt/p6NB9M3LMczsxNeZh1JTsZRTYa9fBcrYlxMs8VMgSMixNd9UvVIrQNQFDXrlUID9NE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(1800799003)(186006)(55016003)(7696005)(71200400001)(478600001)(86362001)(122000001)(33656002)(9686003)(82960400001)(6506007)(53546011)(316002)(8936002)(8676002)(7416002)(41300700001)(38070700005)(52536014)(110136005)(54906003)(5660300002)(4326008)(2906002)(38100700002)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qj6MoqR29ThpegvXIsztjT+9qiCLumU5Zd/5pJex4uVluRKa71QBQK3w7iY6?=
 =?us-ascii?Q?RAnD2siMh9cZLv45bzPE1VNdDoPmrMe7F4pF+nbqXTRMS1Q64ZFcFlY3Hi1x?=
 =?us-ascii?Q?jVmYzTWVUXK4WHvNoFQcC5oXv9nJVcp8TCZELCbcZ5CP9mSbjPBhsZPyeTZb?=
 =?us-ascii?Q?nG5kyZrzHkviNy1nxbJc0FS578rdX/VqDfKeZT33Q3RtOLe2yOxEUY2WGDAk?=
 =?us-ascii?Q?3mZ7PiHrpGiD4fTX+wDmtHaaaF2x0QOoZMYp5bPobAY7WzTH9aPRfET8bHcY?=
 =?us-ascii?Q?5uJxXYQysywzwa4dmx6BsNLIcwUO+5vouiDp99JhGuo4KERPBBu2R85VDg2e?=
 =?us-ascii?Q?vTfGLgr8/5PjQnqolHdCeXhuaPun81VDCunALR9juTwDVgD3IILdtYC0Pckv?=
 =?us-ascii?Q?ucy5aF80AEGXsrK42X9mYL0ymRnDeGG7Bf+b9aoRvqZWx/4IWigS6ATZklzE?=
 =?us-ascii?Q?K4VVoJv6GacXLUquDNmDPnopXNTHUb26hV1m/9Gp98nnzEUrIzdJ2mjcTVzq?=
 =?us-ascii?Q?j+xySt0SOhRFZQCg3o53Go01gpkKTQ83GKbmNdtD3oNs5JjpFj+zCxGIpal8?=
 =?us-ascii?Q?Noj0D+xik55MEqkwQLvHElBzLOCTvVU4nhkvGKHO0zly2n9f2JQHOF/CIjGx?=
 =?us-ascii?Q?FY/2PWMVagsTsxZYcY81DPdEeFkRrl9hpbKGT0+4xpBzP9j49RhIdHsSIwZh?=
 =?us-ascii?Q?zmfEDYdzrYyUNoY/aXCmcJGVyuRj/KljiMPUhbm03GNlQuEfUtNdIuDjwuwW?=
 =?us-ascii?Q?wgE3SDbLEj1Iopx13AX8E+wJ6fdoVzgfiEmo8/kHwJwDqXPY7nAbqDP1VvL7?=
 =?us-ascii?Q?adxDgwDItHFe1Bpw1HirCeCPi+3hxVC97t4MP2BaxDHgtQcI2A9wrW79NS9B?=
 =?us-ascii?Q?4jJ3VqD2o2tEPxeY+PNIa+Yfw4YaoAysLLvPSdv44my7uFN0Ado8KhjGJTUC?=
 =?us-ascii?Q?Qn/7Z4L8D+MycpqqxWbDiovPIEZAnHN8p730slizhBQR4I3YkFR8tqzwaT+3?=
 =?us-ascii?Q?SYbwcMnsl2o000GX4+0TXoBbzO6L86qwQHAPAPSJv4vy51h5GX63K9U3Lwj+?=
 =?us-ascii?Q?YGJgtgg2QsH4jNWSHG6BmoayVqtzesGPQ7nLukATGkWHk7TyFJsfyR52ANVV?=
 =?us-ascii?Q?j7rilkB4a6P6Fj/dhMna4wrzZvN/fvHNn51cWHek5hyu8muc4kGmEe8cUYjZ?=
 =?us-ascii?Q?EmPNSXKneqCvCg8cDTJprGBR4SpI1SHT4diWgjaZtiffg252mf8RXcKrNqgE?=
 =?us-ascii?Q?bF4+mXTtWRcSWlpznc8kXgqMGmqsH4B4sOcZQse1YjqqeYuUrgEjLp0kdcqL?=
 =?us-ascii?Q?4J26807xYAmMp9toIW0bMfkQoPToB28XcSa6OimMmOyTPdZtDYFb5ZFNw5gE?=
 =?us-ascii?Q?mvZEAxZIVybIBTGS28k5H5ELnbJ41aEj8129KWcDoV2h+g8bb7L3obRwiXQU?=
 =?us-ascii?Q?+EMbcY1VeETpGgf+00GjLyYKJcCGFRf0wDvWZZICNTqFl6nwE6f7tkH3HUHE?=
 =?us-ascii?Q?hOaLIBmw7sO6ZOxNp7TCtJllxZ/E84J8tgroxh7yLSJez7K8mRYhhbUFVg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194bec72-8906-4f56-4516-08db97233511
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 08:49:27.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEPIsTGy2vOtFqiePlq8AWjN89gHp3aq1KpN5p0lQIChHogGIRZputKr7FXUgVcc3VHOojUVK3ohAo9x1NJEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
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
> Sent: Friday, August 4, 2023 10:12 PM
>=20
> On Fri, Aug 04, 2023 at 09:59:11AM +0800, Baolu Lu wrote:
> > On 2023/8/3 22:31, Yi Liu wrote:
> > > Under nested IOMMU translation, userspace owns the stage-1 translatio=
n
> > > table (e.g. the stage-1 page table of Intel VT-d or the context table
> > > of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor speci=
fic,
> > > and need to be compatiable with the underlying IOMMU hardware. Hence,
> >
> >                  compatible
> >
> > > userspace should know the IOMMU hardware capability before creating a=
nd
> > > configuring the stage-1 translation table to kernel.
> > >
> > > This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware informa=
tion
> > > (a.k.a capability) for a given device. The returned data is vendor sp=
ecific,
> > > userspace needs to decode it with the structure mapped by the @out_da=
ta_type
> > > field.
> > >
> > > As only physical devices have IOMMU hardware, so this will return err=
or
> > > if the given device is not a physical device.
> > >
> > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/iommufd/main.c | 79 +++++++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/iommufd.h | 36 ++++++++++++++++
> > >   2 files changed, 115 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/mai=
n.c
> > > index 94c498b8fdf6..a0302bcaa97c 100644
> > > --- a/drivers/iommu/iommufd/main.c
> > > +++ b/drivers/iommu/iommufd/main.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/bug.h>
> > >   #include <uapi/linux/iommufd.h>
> > >   #include <linux/iommufd.h>
> > > +#include "../iommu-priv.h"
> > >   #include "io_pagetable.h"
> > >   #include "iommufd_private.h"
> > > @@ -177,6 +178,81 @@ static int iommufd_destroy(struct iommufd_ucmd *=
ucmd)
> > >   	return 0;
> > >   }
> > > +static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
> > > +{
> > > +	int index =3D 0;
> > > +
> > > +	for (; index < bytes; index++) {
> > > +		if (put_user(0, (uint8_t __user *)(ptr + index)))
> > > +			return -EFAULT;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	u32 hw_info_type =3D IOMMU_HW_INFO_TYPE_NONE;
> > > +	struct iommu_hw_info *cmd =3D ucmd->cmd;
> > > +	unsigned int length =3D 0, data_len;
> > > +	struct iommufd_device *idev;
> > > +	const struct iommu_ops *ops;
> > > +	void __user *user_ptr;
> > > +	void *data =3D NULL;
> > > +	int rc =3D 0;
> > > +
> > > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> > > +	if (IS_ERR(idev))
> > > +		return PTR_ERR(idev);
> > > +
> > > +	user_ptr =3D u64_to_user_ptr(cmd->data_ptr);
> > > +
> > > +	ops =3D dev_iommu_ops(idev->dev);
> > > +	if (!ops->hw_info)
> > > +		goto done;
> > > +
> > > +	data =3D ops->hw_info(idev->dev, &data_len, &hw_info_type);
> > > +	if (IS_ERR(data)) {
> > > +		rc =3D PTR_ERR(data);
> > > +		goto out_err;
> >
> > Can kfree() handle a ERR_PTR input? I am afraid not,
> >
> > /**
> >  * kfree - free previously allocated memory
> >  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
> >  *
> >  * If @object is NULL, no operation is performed.
> >  */
> > void kfree(const void *object)
> > {
> >         struct folio *folio;
> >         struct slab *slab;
> >         struct kmem_cache *s;
> >
> >         trace_kfree(_RET_IP_, object);
> >
> >         if (unlikely(ZERO_OR_NULL_PTR(object)))
> >                 return;
> >
> > So, perhaps we should add
> >
> > 	data =3D NULL;
> >
> > before
> > 	goto out_err;
>=20
> No, use more labels.
>=20
> > > +	}
> > > +
> > > +	/* driver has hw_info callback should have a unique hw_info_type */
> > > +	if (WARN_ON_ONCE(hw_info_type =3D=3D IOMMU_HW_INFO_TYPE_NONE)) {
> > > +		rc =3D -ENODEV;
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	length =3D min(cmd->data_len, data_len);
> > > +	if (copy_to_user(user_ptr, data, length)) {
> > > +		rc =3D -EFAULT;
> > > +		goto out_err;
> > > +	}
> > > +
> > > +done:
>=20
> No label here, put it in a if {}

How about below?

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 94c498b8fdf6..a8bb7da87036 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/iommufd.h>
+#include "../iommu-priv.h"
=20
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -177,6 +178,80 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 	return 0;
 }
=20
+static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
+{
+	int index =3D 0;
+
+	for (; index < bytes; index++) {
+		if (put_user(0, (uint8_t __user *)(ptr + index)))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
+{
+	u32 hw_info_type =3D IOMMU_HW_INFO_TYPE_NONE;
+	struct iommu_hw_info *cmd =3D ucmd->cmd;
+	unsigned int length =3D 0, data_len;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	void __user *user_ptr;
+	void *data =3D NULL;
+	int rc =3D 0;
+
+	if (cmd->flags || cmd->__reserved || !cmd->data_len)
+		return -EOPNOTSUPP;
+
+	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	user_ptr =3D u64_to_user_ptr(cmd->data_ptr);
+
+	ops =3D dev_iommu_ops(idev->dev);
+	if (ops->hw_info) {
+		data =3D ops->hw_info(idev->dev, &data_len, &hw_info_type);
+		if (IS_ERR(data)) {
+			rc =3D PTR_ERR(data);
+			goto err_put;
+		}
+
+		/* driver has hw_info callback should have a unique hw_info_type */
+		if (WARN_ON_ONCE(hw_info_type =3D=3D IOMMU_HW_INFO_TYPE_NONE)) {
+			rc =3D -ENODEV;
+			goto err_free;
+		}
+
+		length =3D min(cmd->data_len, data_len);
+		if (copy_to_user(user_ptr, data, length)) {
+			rc =3D -EFAULT;
+			goto err_free;
+		}
+	}
+
+	/*
+	 * Zero the trailing bytes if the user buffer is bigger than the
+	 * data size kernel actually has.
+	 */
+	if (length < cmd->data_len) {
+		rc =3D iommufd_zero_fill_user(user_ptr + length,
+					    cmd->data_len - length);
+		if (rc)
+			goto err_free;
+	}
+
+	cmd->data_len =3D length;
+	cmd->out_data_type =3D hw_info_type;
+	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+err_free:
+	kfree(data);
+err_put:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 static int iommufd_fops_open(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx;

Regards,
Yi Liu

> > > +	/*
> > > +	 * Zero the trailing bytes if the user buffer is bigger than the
> > > +	 * data size kernel actually has.
> > > +	 */
> > > +	if (length < cmd->data_len) {
> > > +		rc =3D iommufd_zero_fill_user(user_ptr + length,
> > > +					    cmd->data_len - length);
> > > +		if (rc)
> > > +			goto out_err;
> > > +	}
> > > +
> > > +	cmd->data_len =3D length;
> > > +	cmd->out_data_type =3D hw_info_type;
> > > +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > > +
> > > +out_err:
>=20
> err_free:
> > > +	kfree(data);
>=20
> err_put:
>=20
> > > +	iommufd_put_object(&idev->obj);
> > > +	return rc;
> > > +}
>=20
> Jason
