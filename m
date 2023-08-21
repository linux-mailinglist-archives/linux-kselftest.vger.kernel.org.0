Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2782782128
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHUBYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 21:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHUBYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 21:24:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB91B9;
        Sun, 20 Aug 2023 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692581047; x=1724117047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gb8amgNMxwqEnPhyW1Zr72hfgwYg1sPB+CiSSb35MlA=;
  b=msVoRYbvE5qV2T5fF5UOHGCLqle7nwjgV/UQBKdZ5P2erzlrjJOq0Mmg
   /ea/+LykkT6Q973mMSns95oIm/LEFkLgoJS2Galeqh8KwD1hAaDlCRgvg
   Bayp0Pgue0KRQESQMAG9j7fDKRg6grLve5JXVVuMRXykBhVEMS9T2UTkX
   pcnrcfnf43FBdGwaYvIaOwdu6YSW+ESnkxaONlmXfh2TsCHNM1jKSU4h0
   tgor7j3ycTV1yCdx5fXp+8sqhllX//ENVuTI3rHMvvc1RIwv80AfJJB59
   2pHm38tSPb2KaT24+K8gz/8kAgfvbNIBOkjO7/C38htSgq0K24jMPCd05
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="459835481"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="459835481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 18:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685487917"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685487917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2023 18:24:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 20 Aug 2023 18:24:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 20 Aug 2023 18:24:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 20 Aug 2023 18:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnMCx/KLAhgo19Ops/SjCOoq10Z34FhdQs/X2y9Yk17TXnZLF6mRNinEGUfa2cJeYJkJqyXfQ+/zZMMTSJO9maVX9SoMF9tGCxBbofaWOQhhBPh5d4RhGnFSPLjTAZvM7vd0RM4EuaDKdQrdFKSxRVWe2xGLskt5hhU5d/SbfygaeTFpz21Qy1lxVKrmGowHP5uK8pRUSECvw4BZUpDA3c8UlVueThxhfG5k+nwpSK1niDuOvDSpSo0E3iuIYR6YifCkWxT9ka65PzNhCD4qMcgetstbEcuJJoZfYYT+c7XmPKwexNGX30npnwtMOcj8kolAD6c5mRKaFOK/EhnjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TutKDHp2bNOhXvEvQbONypThZgA+UtR2pAQ35RICJ98=;
 b=mj0UX6LZVqCzOdqVbgMVyqJkjiBifYudlb0lwPziyPoKx9/S70Dx+J0ktbHIjHsIrrxdGXMPvadEsAeE4JvcmV/MmDZ7Yep4vFsEVMazO33UL/1UC766q0fUxapSqVaoy7BgS1Rf2mqlNnQb2YXkbek8C/WlZGkI1b2o0hYB2RHv2hv03Kz2xmpCdMwsLxryaqiwK4YylM7HfaEsJ3dPCB+YQqG9PgIDiyV5aS2qUVPYfQUKpEYf/j9c4JhuFX6+AyB4mYEt7gS/uv81IYYy0vb5pBwH91QL1qke83IO3b265wSosNsz1kJ5CWqG1l+0mvZO6D5KtCORLFRYa0+0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 01:24:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 01:24:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAhYJoCAAMpSgIAAnN2AgABV8ACAAPMnQIAACsKAgAAAQaCAAArdAIAAc+AAgAAuy4CAAAHYgIAAEEsAgABtjjCAANwPAIAAFauAgAAk/wCAABq7AIAAbchggADcogCABZpGAIAFaUoAgAAQuYCAAAbAgIAAAWQAgAOZJwA=
Date:   Mon, 21 Aug 2023 01:24:01 +0000
Message-ID: <BN9PR11MB527666891DBDA346D9EA58018C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZNUI0D7ZMvLWlBNx@nvidia.com> <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com> <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia> <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
 <ZN+i1pEoN/NsWPKS@nvidia.com> <ZN+w3fahQpM2W9Yx@Asurada-Nvidia>
 <ZN+2h5rpTUI5aG3M@nvidia.com> <ZN+3spv3/8N2IDVa@Asurada-Nvidia>
In-Reply-To: <ZN+3spv3/8N2IDVa@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6916:EE_
x-ms-office365-filtering-correlation-id: 1172c134-7c83-4285-b0d6-08dba1e54ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gslB1VmOt9ERHOq0IRouAou0p9xIH3boYTLsd7XaBsgv32DlyGgsxHBnxtmmwQ5LGKadY1lR7pDhrzO3DLZWb3zj9UmdsGTTtXQtxE8VTTqVUI/sxSEPKX63eFFY6zu1wQPRWxh076pCtr6QOj+c8hpegwQS3fJ6EIgdFePk6W/5Orv+VC5taozHNaHXTSMIG2zyYeneI08N5tALbhAGEc6dmmpQeIBWdGDS1ms4+ljSbBGUYX7bT5e9rZWN6270EpkgvdLjl1fzDUG80GJNv7l2AyMiTE+Z4V1/TCb3cwQew5YWSDCKKNQ9Oi9WguydgP1YiRQsfVt7lABaOwQCCSsgTGKfv5QSiTvHXfYHh6WPnIysQpBp5hoIO5ESiP0OSzukp9a5UR3hyXrLhISx0VrZnpXZyHVsDM87z5lrZuLs1KcyhmEo96iDeoxwayRWZO/7d/RYofzc0b58hxdDxjeaZKQG2qOoXJ9yovkhRh69CCqFdlUQ+gNjiIpdA1XTvwBA9Oh5qK4vflFOw19hTThUaFwjWJZW4BDsm5Hi874t8LaAYhxV9u/Gt2E+W2sBYDd6nh8ws4dZq8qGdF/5SrLRNhQ2oOPgvCo1NyPAlOcXOvjQKE7cX0zDfFKvMy6g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(54906003)(76116006)(66556008)(66946007)(316002)(9686003)(82960400001)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(6506007)(4744005)(2906002)(7416002)(86362001)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EgpBX8yLhKFt7UNqn/1DzlrmTR7+1fVWNb2dLV7thEFV9wQBbkQsdqzOHp7r?=
 =?us-ascii?Q?u/0sgMh1dN1eNt7V89VPqfP/kV+Y0kEog0X5HcRpXylvLRux74iztOPiskbv?=
 =?us-ascii?Q?+RpnAIfP6VSYoz0IvgjqWldSth7zHkiCX+z9bQB0zZcvpnn00K5ZjNnieD3A?=
 =?us-ascii?Q?q8un/MonIvGvy/yM/TuTmRgtsKoMimiOQz+wuFZuJ2DgbyHScWyOE7fDnysO?=
 =?us-ascii?Q?1Oae4t6c5mSSI5ZRvzdQYM2/IUmDUKiHAeXVYKhSYCSBESWW5ubQjsI2FMUG?=
 =?us-ascii?Q?dwCTD+OCVj05I6T8Yj7+YACCjgRvyOFDXjaH9TYbiOd8bE7PTG+F+X8vLs7M?=
 =?us-ascii?Q?OCv0NJWX+xYpEfCv3NclyKn6xbYm+WxeUW6rrIjdDQxY3lcWtwYQC3ui1qa+?=
 =?us-ascii?Q?N4jK6z/OMYxcmO+LzOOuSahn98J+p04Taku8DvO8MqnKT/jSXHEXdB9iCy54?=
 =?us-ascii?Q?slsPjudp7ywlDL6JX5nJa/ooK0x2qN64T5R3jH1QYpdM5/I3uZTHLDtvegL2?=
 =?us-ascii?Q?Ytr2fkRQ3Gcg5lGk7EdicK+71l0gvUojgIBG5WqWqhZWKKG4Ez5/XnOCWw7o?=
 =?us-ascii?Q?AGFMB0h11+i0Vs/AdmgASUVSszGjomPRoMzLFimPZizT6L+Go+s6Bc5Wvf6J?=
 =?us-ascii?Q?kikIVQqEDkv9/matbkW/ct1OP8ab5r7uSDZxrgkdY9OhWmnH47JbOFL5nR3b?=
 =?us-ascii?Q?DqypbtkTtB3F2lZNCS99wRKgIyRrE+ChThcvu6DFgJKysJBKvkP0kCp5R0Kc?=
 =?us-ascii?Q?NDz1xHnJSFaqUoXu0hSzcRxEew8PclIudBfUDSe12ZF2/N2dJQBDhsx9txTB?=
 =?us-ascii?Q?XsgkPZGC5Msgmfeiz/929gNlxLxdNXeRCO12S5Wz+fAQEU8/7j9ApOm1it6l?=
 =?us-ascii?Q?Qn5jb/6AvNMsvojO591o+nbakDyMb7aC15i929MDc8VVR+APg1/T2jEeFpoh?=
 =?us-ascii?Q?T7BngZjoLEa9lxRW/LrgJ1aFMV6CE6CWwDSl/1a+a36AfQk9v5OeHXtiU5ug?=
 =?us-ascii?Q?9UAFsmvuwk2WACMoIsaHsWm3I+Wif7MUbpMKj6dXgAEVKYfaY1CYqxQUXT+B?=
 =?us-ascii?Q?j3+KQdDhCPQKwvYMGXDm8Ss4jcN8FL/Axtr4nGu2+3IYVzpikfxFf7OHr7hm?=
 =?us-ascii?Q?scz4DT5qCTECXoRNqa6wIVqCrS7uY4u4yidWEyz0dU8YdWvbG0OMC0yFZZuV?=
 =?us-ascii?Q?G6uP+aHbpiLkjF98WVzTMqjH+a0JJLYk90lJ2UPH8z5xrL5LV3vhhChWTXwF?=
 =?us-ascii?Q?gS8oLVFcJqToOXN7J4ortKTPb+tcNwKro3i3FNQfksewKw/kGADdemrhHwDG?=
 =?us-ascii?Q?cH7qtcMYQ/SFmyQ6NKCOe5MUvRiyifvpQdr+ktyZUH/ZFfgJ2Gl07tCujyoQ?=
 =?us-ascii?Q?+6NfoU1UD0SzoIhKEbq4KhUHHOOC3KrFTsWhv5iGVKY3RW2QthtVeoksZSds?=
 =?us-ascii?Q?CAXHiQWvFI0rg//LHOI2tfAN9OCobOkn+BTya8kRP7xw1scasCUkAdsOY+m1?=
 =?us-ascii?Q?M2j1oBjtcQ4et76LE5ZPAT8N2TlM8f3AjIMnIuDJNhtBHKPG5cNs4WBFzGnf?=
 =?us-ascii?Q?uGPtit6soFPv1a6qXGiKAK5LoPSUDXBLfdCbyE4g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1172c134-7c83-4285-b0d6-08dba1e54ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 01:24:01.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAwDRoNamg30mz9zdJR+BjkWtevTvWdUI91+g/c8upU3Xqowv8dMmk/GecOcSBfedvCtwSkQyrBvnoWDdDXL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, August 19, 2023 2:26 AM
>=20
> On Fri, Aug 18, 2023 at 03:20:55PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 18, 2023 at 10:56:45AM -0700, Nicolin Chen wrote:
> >
> > > > The highest array index sounds generic, the error code maybe is too
> > >
> > > We could do in its and report the error code in its raw form:
> > > 	__u32 out_array_index;
> > > 	/* number of bits used to report error code in the returned
> array_index */
> > > 	__u32 out_array_index_error_code_bits;
> > > Or just:
> > > 	__u32 out_array_index;
> > > 	__u32 out_error_code;
> > >
> > > Do we have to define a list of generic error code?
> >
> > out_driver_error_code may be OK
>=20
> Ack. Will implement the array in that way.
>=20

Yes. Error code is driver specific. Just having a field to carry it is
sufficient.
