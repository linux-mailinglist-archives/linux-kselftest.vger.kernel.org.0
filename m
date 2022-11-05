Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B530B61A69A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 02:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKEBcX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 21:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKEBcW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 21:32:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91C95BD;
        Fri,  4 Nov 2022 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667611941; x=1699147941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Spuv/9KB3oW/IPmYYrTgNZdieJ/qJhkaKF4Lihum4L8=;
  b=d/MD2KCMX/8hms3hXNaXd404Qy1YgXkXCfW8s89CIVOZPCwRXnMcQF77
   ZadpTmwSPHfBV+/SsLuy3zsFQTnxqIhrRXXqPM8W+SH9GUyHqcGVI6Vh/
   G/EvpvtFxKF6E6n+msFJRYvQYImpSEHBINhk8TPj5SWPE9ArVopN4NewH
   c+X+aVWyt0ge6GrLshX1i7566hRXouzc7rHgMgZ5ADRyzQ5zx+rnb9jWm
   la5zpc52X2mM4H10EQRQrY6WPhJIqyQ1IqNhDpu5/D5T9lPPq/IOISYwE
   CJwxT84yqE1W7GOdgW1GoIbFJekzPbT3xYdoArHQXwCTmDOE5tbRA49yr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="307732648"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="307732648"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="698849094"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="698849094"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 04 Nov 2022 18:32:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:32:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 18:32:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 18:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoW0xBvK8MPyAX4KivBzzqpkjaqia93Gnf0l5JCItflJJY3e+1W8P6VxXsxSw7k+SnkwgX1R4rRawP6phtFiA1iet7G39KzfxaGTpS3np23uFP8LbS1Ds4ZRj7zVYzjc3F08Fq+78BoVRNBVxBh6CyDAhABwcenQ1q675/KFI4KJX0Kep0h2nvPD+Q+7GPVgu6KJI+ehdKQYcl0Er1y3I0O1BXLo99MbBeGpQ1sExPMvRLiccmvnGB1Wxo5p67fVRe2BeHRacUzAne4FRGbL5NY0yjHu7QpvQD/Oieis0YerpYw+1grDou+3f5DTsoSuQ+dJUWg9R/rFdJ66honCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoMa5Yh+i82caUniIWjz3ea176Wa5kG9tnQhZjwZ3ss=;
 b=jsAn8HCa5M7e3cE2xklmKoH45dTxxS7EeLhOggGLtFWpB0GB5fadaI1d7AyL0cIAeoydqKE1etsaVBO1ToBxYHMOF1sCiQKoQR69WHbq57vDdU2OVbH1O1mwUK8v1NNaBC/1xXwgNMj+kG1xhQ9PClgYgwcKfHdbusI5XdSyzvJ2oQttp6OIKfhP5zbNMDEaq2mdj3e+fMkj0HD2brgYQhpJSbJYZ7U1J7bd+9WLasaCk0PugdTlfq2WI1Neit81wDvc7U6BoNTozUuyp8MYs95FbGq0A+R9KThBDRIk1rWU90utlV/mFu1VE67qKhJVbFsFnMmZ/NgYTz/6l5UVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 01:32:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 01:32:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Thread-Topic: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Thread-Index: AQHY6J1pV+jGP7pJvkiET+h0q4ynNq4suG4ggAKAUoCAAGJs4A==
Date:   Sat, 5 Nov 2022 01:32:16 +0000
Message-ID: <BN9PR11MB5276963FA6F6C80157E1357F8C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2VqK3m9i6FlQd9+@nvidia.com>
In-Reply-To: <Y2VqK3m9i6FlQd9+@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6776:EE_
x-ms-office365-filtering-correlation-id: c2adc2e4-5022-44f5-8246-08dabecd92fc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HM4IjNy0h4YimknA3a6sWQbmUVjWvEP7MhZPImS/AYcWj8aXn67Tjll0E6EcE9lEGY6vhmiiKYchlG0WnoVKl6s25qrqr5ta+K5U0XIfmLxTwnK3qCZsa3kenCd6QK51xJeNXr4aQoJt7vwWEY0J22s83n14jI8WjThDcSJo0OOMK2LNPNKwtntyU9yE+K6dlxOMqrvl4lt4GNAFb0eGo+Z/yfW//Es0nT9oz5sCsSHi7FWWpEHUvEC88+czX/YzDZU313aUbFv5MOBFr9tZWY9gTSQuEctH5PWRHFhOOoLf0hduwsY8r0MgoX9yG65EGDQWZ5wCssKyY8ORH5h5QgwiRgFtA9BXqH0HAwHexodE2YpAWNyNaUx/u94LSNo3GoBXccxCX+Qb0bQRFlJaSOSH8/r29OFWRb1s4EBPYDYBISbYJUUvl5TG6QFi7UFQaCraOIOf5RstlcQSLMas4JMNxzkwrPd+7Z3JTGhJcQSdfwPSj0tulONApNp1qzzCV0Lm6veKIoZabISMtaPnJ6RbJfjxrtvgXW7bZ86dgKjpljiAvbt6n8Qdp2yaebMVZj3Xy+eRm0yvtYy+6UGk4QsT2+CVXrlitmCcqeu8fQtEGEf9KqT6RQJDgbNV1eILEaMDqt1lLWDreiHbrd2nIYny+kJDzfEaNJq/VTaTpUfvFb24m45PQ27Md/G10o86a3cqkdDKZonz5pKdFqVCd0QDO0fZg6SiqPmijT6hs/MHsCWZ7+0TVlsvREkkFdplIv1L6mG1wG1k8ok1Cd7UHTvg2oFQIsqPFTsTydjHe8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(54906003)(83380400001)(316002)(2906002)(52536014)(6916009)(9686003)(66476007)(66556008)(76116006)(8936002)(66446008)(64756008)(6506007)(4326008)(8676002)(66946007)(7696005)(478600001)(7416002)(5660300002)(55016003)(26005)(7406005)(82960400001)(38100700002)(71200400001)(41300700001)(33656002)(86362001)(186003)(38070700005)(122000001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jiLUpp//TtjWpp1CZywHdPf7ipasZv7xyyfSS2R5NAfvqRIW04klGOpgOF//?=
 =?us-ascii?Q?3MTzYsdLmGXkoh9kVDjN42aoJVWGuWTf3jftxnTUjNoyLEte1X83KldY3EJV?=
 =?us-ascii?Q?nWpUtrU80eLKyaOfIwXb6sJwsjzXD9Y4w8/JQ08HXzdHqCVQ7g+kxqS/duhV?=
 =?us-ascii?Q?8BfE0SdBc8iwdlRG0jwEz1HytaVUwZ7EZSF3KyFlSkvjnmHVcrBZEJIbF3+2?=
 =?us-ascii?Q?EBS+pfk+ZYa5VidTyaoNwQp0nhh5k9PHvdUfutFBCzAnHxTRLcKoYiZ9s7n6?=
 =?us-ascii?Q?E/cIvfJcSNet06ZgcyJ/h/QacQvNA7XM8COVmTD+tloJXclwvrzga2nFyel6?=
 =?us-ascii?Q?PSWUKg8kenLh+mWX3j+pdXGFrQzzu0xCRGFTzloCmwWnQCr9z4Owd07lKGL7?=
 =?us-ascii?Q?OT13wqgZ5qizLGFgKU4jh4mM8/WaQBeuzObU9uj+nLVeJ0H+uC+QIlkb41/h?=
 =?us-ascii?Q?Xfpbtwvk6A9UPl2eFBQljYtF6ZlnrzBM2ck4frR7uL8Cq/oKvmmS97dVLNvE?=
 =?us-ascii?Q?spuGHp+CRifTcUtsFEnYVmKZDmMQfOa7+ZbSdtq/+TKf/mD1I34ivRT07lwL?=
 =?us-ascii?Q?YSbPdsuX0SZUauyUobO2mlmb8NoSfeqxZhQDTUuTqx6ii0BO3tFZ7JkTOA8e?=
 =?us-ascii?Q?yfsWbJ2e4xJbF3KHw9MJQo92xLwA4KPsLtzlwjf63OqGIid1mFsGIykC0kGM?=
 =?us-ascii?Q?Zv/ULnBFb9yWFRW43HHK8PlSFFf3O14m7M2hBp4buc8LQrcWW72a9684NIDb?=
 =?us-ascii?Q?Z2U1k1V7PE2Tke3xbWaOzTD2RTMNKVh2vPng+XIpC9e098ymuESt3lHGaWOu?=
 =?us-ascii?Q?wOdh/qp/S9tfhRVbj6HFA9QoSUOlwACaiW6RQe07j0H7g0HAtJKVG3rIE1zt?=
 =?us-ascii?Q?dMGY5wRa5RqhIvZwzK+gbFXMzZJc/qRFyW78ikX0VnyFTQo7VPbmwIKT3/lh?=
 =?us-ascii?Q?GJtgUQIU88+LEnmRM1oMbvmliRq7Lt/Esa9rhcD5/CISpf/fiqEyi4T0liht?=
 =?us-ascii?Q?QI0qM3dNa9IDrDN/NTZHxfgLmbSWw0h4ZCjKL602w3rAvqKq6L+2X70VmLBa?=
 =?us-ascii?Q?xDmOsHnK0G8r+hLHtHRK5Q3xZxmWT2JfP/gN9cWc79R4dDKMnzbNZPn9TpQ2?=
 =?us-ascii?Q?hVFrof/TlHQClqmqYCpidOZ4Q6Hl8YMLVOUvYLIQYt00cyY11Y6Chh+Koblo?=
 =?us-ascii?Q?84ftgYpeTja/k4LKmtUpEvwFz6qtoib1uIlhYuK32VIbBqxG9ivAZ2IR/Mdq?=
 =?us-ascii?Q?M6w5TbekCHmCh3E1qc1ubIPehvcuFgffjr5GM8g/+dkhNCbFyFJGUVHkIhSG?=
 =?us-ascii?Q?B8Bx0553t7R6ejSK/R2/kApV05byZBnOnYDZs3pNZzefFTVYP6++umsDWzKX?=
 =?us-ascii?Q?CxvPpYK1mv8Y7h1B+riHCFtyuAXvTq3M6NO5gu4r7X669cfRpANb3QLMqy7P?=
 =?us-ascii?Q?V7DTarnCaUVKnH6nUEkF3WHjPrcHIm9dMnk5NZ0WBp+XkQptaNB4mo4o25Ay?=
 =?us-ascii?Q?2hYpHhqFM9bnhVpvfC4zVpjClPj2MXZXiZPg6i0XT63wh7gSVI/oyd7lWvsk?=
 =?us-ascii?Q?GCEcQ+3nBKZmXaOn+c4U4s6O0qLyF5ldWb2LJrKH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2adc2e4-5022-44f5-8246-08dabecd92fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 01:32:16.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaqW0WeHAADlG3RqHO9Dd9Ag9+joxY/+/+oTZJaH1Rc5eeA254MXmoRpAz9hjHr/cRN4iym+biOeynLcE0YW6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 5, 2022 3:38 AM
>=20
> On Thu, Nov 03, 2022 at 05:31:17AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, October 26, 2022 2:12 AM
> > > +/*
> > > + * This iterator travels over spans in an interval tree. It does not=
 return
> > > + * nodes but classifies each span as either a hole, where no nodes
> intersect,
> > > or
> > > + * a used, which is fully covered by nodes. Each iteration step togg=
les
> > > between
> > > + * hole and used until the entire range is covered. The returned spa=
ns
> > > always
> > > + * fully cover the requested range.
> > > + *
> > > + * The iterator is greedy, it always returns the largest hole or use=
d
> possible,
> > > + * consolidating all consecutive nodes.
> > > + *
> > > + * Only is_hole, start_hole/used and last_hole/used are part of the
> external
> > > + * interface.
> >
> > slightly better readability if moving this sentence into the structure =
as
> > the break line
>=20
> Do you mean like this?
>=20
> @@ -37,13 +37,16 @@ interval_tree_iter_next(struct interval_tree_node
> *node,
>   * The iterator is greedy, it always returns the largest hole or used po=
ssible,
>   * consolidating all consecutive nodes.
> - *
> - * Only is_hole, start_hole/used and last_hole/used are part of the exte=
rnal
> - * interface.
>   */
>  struct interval_tree_span_iter {
>  	struct interval_tree_node *nodes[2];
>  	unsigned long first_index;
>  	unsigned long last_index;
> +
> +	/*
> +	 * Only is_hole, start_hole/used and last_hole/used are part of the
> +	 * external interface.
> +	 */

/* Members below here are part of the external interface */

>  	union {
>  		unsigned long start_hole;
>  		unsigned long start_used;
>=20
> > > +void interval_tree_span_iter_advance(struct interval_tree_span_iter
> *iter,
> > > +				     struct rb_root_cached *itree,
> > > +				     unsigned long new_index)
> > > +{
> > > +	if (iter->is_hole =3D=3D -1)
> > > +		return;
> > > +
> > > +	iter->first_index =3D new_index;
> > > +	if (new_index =3D=3D iter->last_index) {
> > > +		iter->is_hole =3D -1;
> > > +		return;
> > > +	}
> > > +
> > > +	/* Rely on the union aliasing hole/used */
> > > +	if (iter->start_hole <=3D new_index && new_index <=3D iter->last_ho=
le) {
> >
> > "<=3D" to "<"
> >
> > > +		iter->start_hole =3D new_index;
> > > +		return;
> > > +	}
>=20
> Hrm, I don't think so..  This is testing if new_index is valid for the
> current span. new_index =3D=3D start_XXX is a valid index of the span and
> new_index =3D=3D last_XX is also a valid index, so either of them should
> just update start_XX and do nothing else.
>=20

You are right.
