Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164BD76A707
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 04:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHACfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 22:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHACf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 22:35:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482751BFD;
        Mon, 31 Jul 2023 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690857322; x=1722393322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bCNLbswAFmcGJNZaal+dEuo+B9KiAnY9PHC3CP9ztWE=;
  b=NMrhUrW7MUuo9hT5MbEnoNRpUqrkfRGUdm7uRwiAYJszVyiGkk0AL9hg
   LtlSDWlrVegOFei7ZamNgmDEUgGVWirXF0y9CVs4mBRkKmrcOm+ZFjiJQ
   sOT7N39qtSBXO/q6YGGNrvYQE2idsNyfEgJLDBaAr7t0M1U8WXz4NyZXw
   uEkUWc6UQHo8LbmF49fDd1ML5Acv758oFG1yAxn9Wy/zg3/zreMmH7xdY
   SZEzsOtNVvkV7eZgix+16XpctGpmt3b60+RnwApOjleXr+TsUqzt4KNgW
   BAFpeNalFKw5FKggtmxs0X8bJPjeJV6BMFqR6RNyAIm7XfktZFi0FUCF4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366648325"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="366648325"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 19:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728510915"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="728510915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2023 19:35:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:35:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 19:35:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 19:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBCDkk97Xjvy7/39jrJ94j4E3CD0IY9IW6RxVXwKO6CUdqgqVXX88Y9tGqS06X6nwUyQjW3bUfvrhqNVberZox+vKvGU7//JvGK/8WYhmYBXa/5EdUS/2BNU150MFY9lJ+qc9WA2yX5ebB44zAAEZKhhdLIMZn+VZFwlCpqnZxp37/h6i0NEC0GZFmvai6nEHNBMnQ4QiY9d5y9/wmBaTl4OBKYCDkIqOYuai54GNuJyxrtystlJgmy5lCYUr5mSu0WN1VlaygfiyOp8C9dv7BapgW6us2fw+VG/4rUkb/JJG3v8LvJ0f0LZoZrfvMF8612+54zokZMJhU/dG/dY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQAFf1GKAIqLBQIkqPfYnUJOqldV30ef6FpXWf7M368=;
 b=gS/h0kbq197fjNumk6TlY09tyqujnXvHWkaAm46p3hk5adGQeqwKHnrjyfdUjfN/DuuomnYJPmSUCTYFTygM9UBSdSnDJ0lC7L4D7EkLEsm4yS5oTf4iAMv1YkBjkzxn8TKvTnkfqpTtwVBmioJdcfjtT3/tiMXN5I+LTqeX5nauZsuoXcLWE6q/zXOAHMFcUrfIfbf6A1r1tGwUQvBAL6/s7TYy2LbV7kmIcyQX6CiIcshqMLAcTETBga6ZR2ndj95rNB+oBdHEtDZLB077NwB3UN1beefg0I8mz4BNwxcsF4/t15LfSmXVpwnXNFreG2VxkbtLDK3zPvKL+Nuc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 02:35:13 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4a3e:51f9:8a29:afe5]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4a3e:51f9:8a29:afe5%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 02:35:13 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZvh6gRIUXrS8FTEq0LBGdPa9/j6/PfUiAgAP1GUCAAHPCgIAA3k9g
Date:   Tue, 1 Aug 2023 02:35:13 +0000
Message-ID: <BL1PR11MB52715DA47B85317EF13AD78A8C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com> <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe0IQksFgV6yKTB@nvidia.com>
In-Reply-To: <ZMe0IQksFgV6yKTB@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV8PR11MB8559:EE_
x-ms-office365-filtering-correlation-id: 5682ae1b-dc79-4ba7-16fb-08db9237ef15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S86gsJKzMN3DUNWw+5Cb9RG+pJ3HmT/fIvmjMFMkLXad2ViPl8Ld0+PmvaSFmCXYOCGutAOr4erjZS7M33S4vNjKkRxyfs7wyUp3d2h8mchFtb1lZGMY1VBmt55fZLp5Esb3ddbLFYWuWrCGa0Bx+l5k+Gx4WAgOQEpzJ3JQVBMmzAL/b2iEymmD0GWQsm0KoS46MypNiajdLd/pJWZ1cP6GtLMYmIqNxRarEnW48uKugbWuIkw+0sWTVwIloz9LK70ZEj76bbf0YF3KGGzSjQ8/uqURK35/8ZHWKADzDHh8705U5xiVrie2ffd9fDihg+Fs8seFSEzYxI41mp09rSK1pw4Qj/5SKfE6wRJ08XsT6LOzdGyBWwElZBt4a4odP9ciGtPP9B4faGjqf+42D+ln80YtJtzBIUq38C8nssovuTQX8RSalf2m8rT4XMviWfAAGfNwFhVw35xV+/6pWxYN529MXfMlFus1zWxW8P+sU2f+kZs6w3+mkWSWtfhkLbZNMFj2YhpXC+vttXOmnzbVCfSbxVoSF/fSuP3uph9L/g3tntc/PhAlju6lKFq7JbiAH7xh/sKyBQwFuOz3QNke0c0KkHwSneZL5HxKdOQwB5pizifI7kCIYNnoVJht
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(5660300002)(52536014)(186003)(8936002)(8676002)(6506007)(4326008)(316002)(83380400001)(7416002)(478600001)(76116006)(66446008)(54906003)(66476007)(66556008)(66946007)(6916009)(64756008)(86362001)(7696005)(41300700001)(9686003)(71200400001)(55016003)(38070700005)(2906002)(33656002)(38100700002)(82960400001)(122000001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ENa+CtOeMHCrRx0+ATE1+wKtTSoeYn3jU9IX1LmrtNUT3ejFQNCWdhO5H7Ee?=
 =?us-ascii?Q?2b/yCZiNTraLMnu3t1BGjRybXjOrY74878WBF89MVrXrTu2q7yniPsjTNeRY?=
 =?us-ascii?Q?eVUnkvhtUDG6k3U6a/7hh1Ra4t1DyuqDiluuz+8yp/iRfcRgV2CfstPs0nWV?=
 =?us-ascii?Q?gghRzZkA3nNqHux5Rw4x1l98mvSfh3Af188f+JXr8iCbzPPx4fdPE1uvo39J?=
 =?us-ascii?Q?xOE2/mvhctRnmwA3sHnVInyVY4ytyIPApRhkS3+X28fworYJZzZYbs0hcbTy?=
 =?us-ascii?Q?6clRJttSJIIuFPKBUuez+JN+tkAy+64Hf8KfboLe4GpPTcavLrygeU12ALd8?=
 =?us-ascii?Q?XsPznpo/G6dlloZ5TQOfpJzTKOvW2Ar29+HScGCN3/IRQVHXUlmW5W1XPE1E?=
 =?us-ascii?Q?Rzpc+tveIT5HBzs6FLMnmKASgwnOSq22+ss+ugVJqRr0snLPGR9SNLnSB5L6?=
 =?us-ascii?Q?/3ElgFAK7sAr3pIY4dcvt+AEGPTeNNb9I0QrLRjjheRrrdbPSfFQ/mpqKMFF?=
 =?us-ascii?Q?qKKEYjKfrbPiuE4MXOA8I/NEHD4L+K7daSVLiMcweAD8DI9sW+OQixFsanyT?=
 =?us-ascii?Q?mzC2fDlef44KtOE7o3JE1fhd0nuzGIMWkDu4eUokXWXIRCTMjFd/XEK/CUk4?=
 =?us-ascii?Q?eeBb3pc1AWYlmD37Y665BStIifGm2Y+68RQjGLinYIdGf4gdYWxiAiQObCe0?=
 =?us-ascii?Q?1aLicN8Dsx0t9tUFoFfmNO/ljxAQ7C6ph4tcMF8UdEgTfEPZ8T0xr6Dy7uEW?=
 =?us-ascii?Q?+n1EjBLZJ5aMH2xt6NByqJFbJ6u5wXYgXi3LRb1k8ZGKVNu2NQV46BAFdtd8?=
 =?us-ascii?Q?ukv3DS48uUublcBXetOqg5A8XO++optzzVnKPGP7+xSzts/WskHijqR0XfpH?=
 =?us-ascii?Q?9siC5zQCIyJpwWdu16ky4fvpQI2jB76LbKFhG3zQc60DEoeDq18BLJfqL1iC?=
 =?us-ascii?Q?9x1ZVJEt4PvNQ8fOphKo0WbdxGl3Epzh3F9VbR3zTfL3HVvj1np51hkV4D6B?=
 =?us-ascii?Q?ma0arVe5bxpi0DKjmYLWNaF0Mki7s7pMqTbOpbUT7YlPWviFM0tIpzNMNav7?=
 =?us-ascii?Q?VkEKhzAA8+oAU6QF3Hj4Ibi25UWxtSg28BgZVPcTfEiybpxlVdxT1bBAsong?=
 =?us-ascii?Q?xsXycvc5XnH5V6RdlTNUs4Pd9GaqUItqVOAwWAXYP7jWp4OONxjjWNmuQ10O?=
 =?us-ascii?Q?I2W5KZv2W9G2xC0JIuu+wfNWTE8xyjpqcT6ICVyXG0L6CVYs5ulXoKWnzEuE?=
 =?us-ascii?Q?tBLA84VjrT3uWA5wmG63m0U19mD7Scj9KjxI0Bn1/MSJIUrLueZ0S/Eqg/l3?=
 =?us-ascii?Q?xPQjyJGOTSAZbZeB/N0VnoESn0OVjdTbAmGaovBRZWhQSqs9t/haXeK1ynSe?=
 =?us-ascii?Q?X0aUw4F849EfpAkLS1hLAguA38ZkpdzZ1XjvJLLgkeLA6H6c0naz+Oyxvuk0?=
 =?us-ascii?Q?7rUEJBuEdiYzzJD5ED1hl7uTy/RUuI7I7uosdqiJZUEQeKM+5sBLpppDNe+/?=
 =?us-ascii?Q?W1rJ9cNIUY0AP26PkjUgLUxp8BMAJ36WmjtMUpfE7cM7Fud+OW+AJ8jjjNTk?=
 =?us-ascii?Q?SV856krC/iKkx36LK+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5682ae1b-dc79-4ba7-16fb-08db9237ef15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 02:35:13.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXjJgRdyjzdhawHzyB7dzLkhb8fqG9FulrXn94ODY7lfTsdz5nwMqAv5PwW4YVtvRIq1Grrgv7hw+IlF+a11GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, July 31, 2023 9:16 PM
>=20
> On Mon, Jul 31, 2023 at 06:31:20AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, July 29, 2023 1:56 AM
> > >
> > > On Mon, Jul 24, 2023 at 04:03:57AM -0700, Yi Liu wrote:
> > >
> > > > +	switch (pt_obj->type) {
> > > > +	case IOMMUFD_OBJ_IOAS:
> > > > +		ioas =3D container_of(pt_obj, struct iommufd_ioas, obj);
> > > > +		break;
> > > > +	case IOMMUFD_OBJ_HW_PAGETABLE:
> > > > +		/* pt_id points HWPT only when hwpt_type
> > > is !IOMMU_HWPT_TYPE_DEFAULT */
> > > > +		if (cmd->hwpt_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT) {
> > > > +			rc =3D -EINVAL;
> > > > +			goto out_put_pt;
> > > > +		}
> > > > +
> > > > +		parent =3D container_of(pt_obj, struct iommufd_hw_pagetable,
> > > obj);
> > > > +		/*
> > > > +		 * Cannot allocate user-managed hwpt linking to
> > > auto_created
> > > > +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> > > > +		 * don't allocate another user-managed hwpt linking to it.
> > > > +		 */
> > > > +		if (parent->auto_domain || parent->parent) {
> > > > +			rc =3D -EINVAL;
> > > > +			goto out_put_pt;
> > > > +		}
> > > > +		ioas =3D parent->ioas;
> > >
> > > Why do we set ioas here? I would think it should be NULL.
> > >
> > > I think it is looking like a mistake to try and re-use
> > > iommufd_hw_pagetable_alloc() directly for the nested case. It should
> > > not have a IOAS argument, it should not do enforce_cc, or iopt_*
> > > functions
> >
> > enforce_cc is still required since it's about memory accesses post
> > page table walking (no matter the walked table is single stage or
> > nested).
>=20
> enforce_cc only has meaning if the kernel owns the IOPTEs, and if we
> are creating a nest it does not. The guest has to set any necessary
> IOPTE bits.
>=20
> enforce_cc will be done on the parent of the nest as normal.

Ah, yes. What I described is the final behavior but in concept it's
done for the parent.

>=20
> > Ideally expanding uAPI structure size should come with new flag bits.
>=20
> Flags or some kind of 'zero is the same behavior as a smaller struct'
> scheme.
>=20
> This patch is doing the zero option:
>=20
>  	__u32 __reserved;
> +	__u32 hwpt_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
>  };
>=20
> hwpt_type =3D=3D 0 means default type
> data_len =3D=3D 0 means no data
> data_uptr is ignored (zero is safe)
>=20
> So there is no need to change it
>=20

Make sense
