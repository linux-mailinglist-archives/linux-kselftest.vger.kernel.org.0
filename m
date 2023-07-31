Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA0768EA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGaH1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGaH06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 03:26:58 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C926E88;
        Mon, 31 Jul 2023 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690788203; x=1722324203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uP7eZ1HhP9M8io4tv3cGW6Xjkotw98/a7cTVdGdtb6w=;
  b=J1KbFTxvssRdmXZe9lvgESSslr1Va2XD7Ol491c+5zk+1pjcYLFFT23n
   oufWpuB9AKrqw9uB6R8wt/6yTVhnCfCRxG2YC0vPie4tNvOFQEks8y494
   68ruIrS8bPFWhOr8JVMqG1PCo2mxTlyLju2AX4CSqpcHoQZ2HSaXSp1ew
   xtG1UnPjaJ4jJ+a9Cxcc/JJBUmtJrKhl/IHU7bRZMZurVv1YTIYryRsK4
   rMLkFO0w3aQcKhstLTK2ruO35PKznS0bpn5ZV050+/Vgn0jVNvNREGkgp
   fvPI7IrEcprzwDCuPRzP9umGiWkPnrK0fFWekrW6TzrApVR4Isb/t2tf7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="367833382"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="367833382"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 00:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678213753"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678213753"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 00:22:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 00:22:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 00:22:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 00:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa9UCsFVEyXfKKQ+EA4KhKa6Jv2CsZmPFcJzm4MO2i4ANYxOgLHfh+MsLvXA2DQHgU9Igqi6WHoYQlOHfBRdKLK9wlH/VEC0WyEVnIlZRxgz769SkDD9veYeMNdzj8TgnW/6T3L9xpQ4YiqcC3BYbHTr2YM22R7Mi2IkHrRutnaiI5i6nGVBF8UioNTLpSMjyucY/br7OkWTpbFL0X0S1V2w+Bih3U4CY6Cuvoyt7tkz0qvVucEhkCz48JpY1i5/2cdzgYfFnvVAdlIaqhZR4ydvJz2uCCxIkTy1QfoCwUhx5GmgDBGDJ4RxP7nF9DZYQYojfs+JttQCbSsyO9LazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdlY7AqA5JglhwfWVxblT27Y8vtJxdPPFnzU7ZWwQ3k=;
 b=Qo52MZ5B24zlJnFE3SgUHRhlRbiTWNepxA/K82MkKPkD6dvCp3TCArk3xLd8fbk2QvPriky5i/LRuNi73NE0YLMwyqz2GENJruiFwHW6yoJFxZvhlKv9zDV2vgOtXI3GToPlsO9bvnWAspwhXz2si5+c9r6uL5a4a10mJXqKwkY6l4NqzAC1wDAvvkkcAg/QTF18iLdEiTP9Axuak8TkSBSH16YjSUgvuWc/ymsHe1EHFct6guR0r/lPFtd41jAveLZrWBvSNDBTkHSU+DWfikwXaXiv7wnKA+Uia4B1KFPfCJpFS6G63K1a2gosztqZWC9bhNVO5qvS7NlWWnHw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 07:22:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 07:22:11 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZvh6g8vUsI6Dm/EODafeBVdTkM6/PfUiAgAAUwQCAA/CBUA==
Date:   Mon, 31 Jul 2023 07:22:11 +0000
Message-ID: <DS0PR11MB752986582BDB95CA75663B00C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com> <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <ZMQSlvlVEE3G4R/8@Asurada-Nvidia>
In-Reply-To: <ZMQSlvlVEE3G4R/8@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY5PR11MB6186:EE_
x-ms-office365-filtering-correlation-id: 38ede48a-8564-4258-8b06-08db9196db42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPODTez8ZHQRjxNjBL7mwA0YXvOalG8GFee98K5y/DF2GJXxfMZSUYMCMajSJJ2CUmcahZIRGXSrwaN8RICWz3WDUFjQ4JajVw0o1+7ZFg4wSY/s6dKlIwUPcAVFMf/LMcnkx7mov3u+Vm7VmrmJMT7cX7r6prp4f5tzQ+aCa9zpvDhsbtUluZAy70lyS1FIpQkYZWqGRNjvwDQDL/X1OesKxm4w3hu2x39Tp7R0tDkzcOsdsQJeM46TNUAGkr45isCVfv3fZG9ce2dIO6+IM3xt/Rvl4HXi+YTUJklHmFb7H/AHuVVtdc3NcLxvn9E8yF/+6OtW5qAecVSXh1zjhReMeIqWYGH7pJXvTwInSpbCox7z90DyPtKVINAoTzf2FwDzo/i9pZNJx9pq9HA4zSh12B9qc7xtbOIHk2vTzUDiUELKY5J+4ztodUEh+ve7UimHNrrtcdkQJnr7VOafy5k7KoWGfHZ79MDvj6fS+rfIgMB7rdiffl8D1UpvJ6+dJLkwERc7tlBDpQPTgHGZDl2tvYnlGU5Ui9YGHnn5PLwtp4E04hyor6EbHpxc7kuYImLgriE6rcFkDlZVyKcvcZaQhHNx2NqaF9HZOmoVD6g4A7Y2dbxoHiKwea3Z/QTM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(9686003)(71200400001)(7696005)(33656002)(186003)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(26005)(6506007)(55016003)(52536014)(5660300002)(41300700001)(8936002)(8676002)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(316002)(7416002)(478600001)(110136005)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hA7V1+leFKkE53H95PcWIZPv0riUMpZ/sF4jGqrS1q25Zx+ZNTc6b3+hbFfO?=
 =?us-ascii?Q?PWtFOctKxZ3nGp7VRl6sCuiRQ6kDS5FAtj+QySwGgGW15RZVPbqQS7afsqr6?=
 =?us-ascii?Q?UiJcQYrcm2w3oxvLyDp5u88zUMrWASHSE2ZwALFLsRoQnQIoW6WiwugoO4Fj?=
 =?us-ascii?Q?Pu83/DAfQMxLBvYu8vVgs2fUuY6PuT1oTCRDMa7VLiUJwTZJpsNFzjljEu7Y?=
 =?us-ascii?Q?ctYZEUpi3tSUoobRwO+lORXtT8LzX3+1vYuRH8prcINNIaYrNwGw6rQrftXG?=
 =?us-ascii?Q?gdW7LzS6IWvOdPqtjBVyGngiIvqwmqhop4ShTamGEU5mAbw7NErhiMscNSCc?=
 =?us-ascii?Q?p74Kd0jKfqUhWRTyIJTYm5ugavXBluPPo+xmo5EWvNjkfuFIv9jQwNfgDHRS?=
 =?us-ascii?Q?4Kg0ujIaSzxw6LQp9TeCiN99BRpAWfiDwoFE/QtWtfM590D6vTpeLrsQNJ3V?=
 =?us-ascii?Q?aRIwdc/DdasBFmw+lKm1UznZDvcEGjOacbv/eD7X3akMXMispaBas8uy3nRS?=
 =?us-ascii?Q?lO/fjS0ntOxEOW1XPXu3z+qr0CHaYmPjPMOG3bRoGMl+5mvLlBaW3KKPM95o?=
 =?us-ascii?Q?6IjZtX6W+02Z6yq5N2Ye77sviF48OYJq4rNjSew5rurqwGRFF/7B1SYcsN4b?=
 =?us-ascii?Q?cEw1crGgYKlyhlqbxNOPXjMq8mNKSlBKQ0ZHqceD4cT8uehHRKC8SzYw+FOD?=
 =?us-ascii?Q?tJCRjOUqzKXAjz1d0oVxPxgA2aCd3NYyBdNrTVSxFDGwvlpQFmzMD5MYrQ+4?=
 =?us-ascii?Q?wf54Nwrw/L7+GYmteLqszN0YIxzxjMkLvKm22F0RXAtEqaFufGyrDWwOey1K?=
 =?us-ascii?Q?4w3iyP5V/wxS+oERsYXSp7r3OUihzz0C1CtUcw8DnEaauI8M6rtHJF/X/0IM?=
 =?us-ascii?Q?iIZXY13pcDj0qI1IsrnZ/PibsjOYLYTKUpU0I1WJLyA6t2+pliGp1kTLF9OD?=
 =?us-ascii?Q?YIg225emyGOBR9j4n8NAwkpbkO/+hamyMp7dGIp6d7G1KyyCmEz5PvHPeEJO?=
 =?us-ascii?Q?blILKaNlCcS2RzzroervQUHYmmUzz6MGbtG5Uu5z59dpFw1upEBeLdWCc7GF?=
 =?us-ascii?Q?nD4zfAZa+/7eb702yHaETnvKCdxVHwlFMSclbtnyyHscDOLEK9zUsszBAO3M?=
 =?us-ascii?Q?xoy6YJrzxGzl6yrryca1VcOu1IJlIcKPpXd9iMfXmG/qo/vQL+7iba9JC3a2?=
 =?us-ascii?Q?awv4W12t2VSoMlO3CzBj+EvK+sXKN1YHtX7nNV6g70950DqJ/ffqubR2Dyfb?=
 =?us-ascii?Q?oH4HKZU1ma+md/i9+dwyglDCK3HhpsnZwyZ8cn2UKT7Dz+4g3c6JFRVbLr8x?=
 =?us-ascii?Q?FE6tuyMQ2YN8QUfrZIm+I+NPZVR7axHhXddhzeiBk81wjd+g+BZRSoU4grh+?=
 =?us-ascii?Q?tCBF7QGMSPDveesoN738vVXom+oMZeMg8wd4WQeGLuIb7DGjlHiXOWA5yTEd?=
 =?us-ascii?Q?M4i7u16U3UNBzcom3Dp+77tQ5P9LwHo+dBKKIAHmI/LRlAw3vTf2PNbhCDWG?=
 =?us-ascii?Q?Xxfh2rGuc934sdMRdxnO0YmmT7Ef8vHh4rgrUA0Jxe+cvcR74ERutLdugwjw?=
 =?us-ascii?Q?U8F39D5HJ4fcuZFciAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ede48a-8564-4258-8b06-08db9196db42
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 07:22:11.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUxBx6DJN2gVRPpUokOOXSBDVFPNmFdthbFvaGTxsAshfUERUfCNhxkfwff8J+DZ7byzw38w3t8Um3+EiLMIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, July 29, 2023 3:10 AM
>=20
> On Fri, Jul 28, 2023 at 02:55:57PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 24, 2023 at 04:03:57AM -0700, Yi Liu wrote:
> >
> > > +	switch (pt_obj->type) {
> > > +	case IOMMUFD_OBJ_IOAS:
> > > +		ioas =3D container_of(pt_obj, struct iommufd_ioas, obj);
> > > +		break;
> > > +	case IOMMUFD_OBJ_HW_PAGETABLE:
> > > +		/* pt_id points HWPT only when hwpt_type
> is !IOMMU_HWPT_TYPE_DEFAULT */
> > > +		if (cmd->hwpt_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT) {
> > > +			rc =3D -EINVAL;
> > > +			goto out_put_pt;
> > > +		}
> > > +
> > > +		parent =3D container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> > > +		/*
> > > +		 * Cannot allocate user-managed hwpt linking to auto_created
> > > +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> > > +		 * don't allocate another user-managed hwpt linking to it.
> > > +		 */
> > > +		if (parent->auto_domain || parent->parent) {
> > > +			rc =3D -EINVAL;
> > > +			goto out_put_pt;
> > > +		}
> > > +		ioas =3D parent->ioas;
> >
> > Why do we set ioas here? I would think it should be NULL.
> >
> > I think it is looking like a mistake to try and re-use
> > iommufd_hw_pagetable_alloc() directly for the nested case. It should
> > not have a IOAS argument, it should not do enforce_cc, or iopt_*
> > functions
> >
> > So must of the function is removed. Probably better to make a new
> > ioas-less function for the nesting case.
>=20
> OK.
>=20
> @Yi, along with the PATCH-6 (IOMMU_RESV_SW_MSI), I will rework
> on this -- mainly breaking up NESTED hwpt with IOAS.

Thanks. Then I'll address the hw_info comments first.

Regards,
Yi Liu
