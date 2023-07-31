Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2547C769266
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGaJyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjGaJyV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 05:54:21 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D61FCA;
        Mon, 31 Jul 2023 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690797220; x=1722333220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CdPU+p3L3i4rVRqsYWnLKe2Gogq0Q23mubTOlQppPD0=;
  b=mqPfUPCFH1TaYMsDj7zAOkYURLgArtwRN7OXr8QWV60xmFbSc1qAvZ7g
   n95vf5jbbJTE5tLE0hQy66oKtkuMBNBkmPPwWyCYAdow7S9IiqyHwafBn
   Tlnw1uHpNgqeiyrCP89bCivd4klqwv40+zOsqJlJITDkSDEINyrKrEbiV
   7r5/7dfeIYrhIDtNVvCS2UeaT7WfRq4fjhsG1hmcFv90J/sNSfFpf5btl
   ELgDolDb9NGsTvDUOY/0sR+Q8g9wVJenOsY+7PogLO6MUO37rzXLlx9OY
   Kj7iEqlWnsu3sqVQ8yj/xsoyJtNsR4EKfY6tnVvz8CuTh7tmiyGxbZ689
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399922473"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="399922473"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="731542126"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="731542126"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2023 02:53:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 02:53:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 02:53:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 02:53:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 02:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgPm3OhcOD2vG4gA1muvwtowlNjJrZ/LzNM6ASao9Cb6LJfXvEpCaGxFeKkpr7P0rNQJpam8EGS/0p0fk61s6r+yLngoOlFQ6OlGwBXUYmE+3D0UFiNqKD9oZZrvUjEF8UwDr/JNTAztca4tSWEH+Do86w5NU2ZIQonwxoK8V0FKCx0cWZp7YY/XKjT8L52QzOXJlEVsJsBb70g5Td8ukCWuzzXylf5uVPiCzYL/nNGN0CO4aP77fEmqICDEsx+K1iBdbPd08f9cxAOX0H0c9/28M6D8hYtk1MTFCWjE/R17MikcUqJdJ53mQrV3pZRtbALiqu46WahY0BqAKXzteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yasUGsGkGJKEH8y/M2q/5MTcVm5hjzyWvhrv8LbQgsU=;
 b=lT2QegK/bvK0GMtyj4xPqziL4x1xWmeL3dIjRysgdiXYXa074uMdSpAWO47DmsM6heMz/IOj19zZde2XmTz8LaHb1pxzHQf4Xp8HIyNWBpp8oc2FQYod1Q4cJdUH+kNUK+TMWKVZ3uUDPq3etNTwfYS6WRH51SD1dSy0fFhe1WNhcO1WuRL7Z1hKgR5lJ3xwblBegNjUKVOUB+f5LF22D2a6AJn9t7L6TeWduEUH07T4kG7pM5YB63C9XrDNzD9pqBNufn3XRqrow8vKNA4Gn7xIFXaOKpOEi3OBbKc5lJDrcFl4pcTQa301McIjXESis2iS6iGWmYBkuu8CPgbsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:53:00 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 09:53:00 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Topic: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Index: AQHZvh6fETfU1PPcmk+sspmvDZMOoa/PejEAgAP4HwCAADg6gA==
Date:   Mon, 31 Jul 2023 09:53:00 +0000
Message-ID: <DS0PR11MB7529091305AC7D478CBC86BAC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com> <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY8PR11MB7845:EE_
x-ms-office365-filtering-correlation-id: 1eb90fba-0e04-41f3-536c-08db91abecdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLjp1hnTK8cUQHTTydyC5cOvQX9izK7TkvKAO1RLjJcnjnJ7Z/T9A6otLckRqhmJjtBEgLxyOu2R95lhanGwCcDVuBekfJyJaqYBiynEFIlhXlsqtoCiuv1LlpjrD1oTjVujkqtnJYKn2TD5gojXQezisT16NSEYLvnxcWS7zOLX0zT/JJCbiKfh4ilOxkxmuhh4F7T5PWYWNOc08ftaPIy33fptYXMPhysZh08JunQRRKXFXxlwluecKUgjUfbkXagC1LpkfsbYwUgPt89ihFsVighYHT5e9XxNZ8zBWu7OE8YDaa2btJveCaAqJ1XwziATxiq8MO39vWKuu4NzdeUZpn5siH+p1zDYtJe6TYBlMOWHAWFLDaV0D8sQyPmGf6i1nCwo8cjgz1mvDYiQIO4ktM8Dq2oLC8BWpHXs5+OPnDlsjv+qZJyX8TCaAWEfCkfx534M3I6ePKsD//8sZgbY+LfUyup9nPwsVbW+0MXn48MZazsedBvT47/On9PIUecJUTLs4zKfe3CRLSwI6r9KiD/a6XOM13pmBYM6XfTESDX24+dKiCB4tHxCNNRUpDQvVht+hD5SVmxncO1O03np4tYYxE3JMSjVFfdJUp49887ilJ8RTDRvUaErenAD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(9686003)(7696005)(55016003)(6506007)(26005)(83380400001)(186003)(33656002)(76116006)(66946007)(52536014)(66556008)(7416002)(38070700005)(122000001)(54906003)(110136005)(82960400001)(41300700001)(86362001)(66476007)(316002)(66446008)(64756008)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1MRMt0OD0pGek+MlhnC+wFfklmME98gGcnUvbTrpFihAJwTHpbBzwOmhXw5K?=
 =?us-ascii?Q?9iTJFQrUIiWqJj9bTZofGd3CEBwEyDKx+ct8Wv8aOA43LIVuHy8ayYWpJPcC?=
 =?us-ascii?Q?3RbYxcaqq7iqZ6UKbj5+I62P8vnJYoWshn40ayMrQmCRGqwGP8KuZ1+PjBzq?=
 =?us-ascii?Q?fvom3OWr2Seg02AVWHpLdoOi92Zjvm8VibF5GlJiyY4513hwNMk+pAhy7mPd?=
 =?us-ascii?Q?uy0NkOq/MIceb8JA6ekQ+7MIokwi2VCKasfsx/0cS5E2q+2BnIsfcl30d5re?=
 =?us-ascii?Q?u+kMZToLnUIpxhzw/c3lmxEe0vusMatEK4OwAxKm7GP2famoI3VusMSlnsBy?=
 =?us-ascii?Q?PLm+5QJIH2c8i7trhPfRxGCVcoFsCF449XGpBzuAxB2uffSO+EnidTKb0avy?=
 =?us-ascii?Q?JYcIg+yvI8VJY2d9PlsmT8UxrnWl8qmwvNeFtFGXwLt/zpX9WWXsg4GCe5Xy?=
 =?us-ascii?Q?kq0kzP36JLSX+82cdCHBfcOprWu9CPjrV+RMU5+x4GHFuB9rQ0WCDSjc3XBJ?=
 =?us-ascii?Q?b9gXFj6nmGjyA4BAw/hhX0OX3/pqmJBg/cFWcOe8JnrClOtN098Y1czSJ7VF?=
 =?us-ascii?Q?aKPg4jAUJU/Oa/dHC/dPdWEoxrLb1nu3HzERpY5dbVfzyADu/CmW/NVjLIxl?=
 =?us-ascii?Q?MY5qzKL/X8H5o4ImDlzmCpEbaF74hpFrF4q8WZXqMbcSEndHSoY8p91qe7Zl?=
 =?us-ascii?Q?27zhwg0pgIi7w0U144S3f/TGmQ2uny7qDSP36LpV+WeT2HNQP8KKI7cTtNZs?=
 =?us-ascii?Q?SU44CxGhr0KCDf0HGKnXFHUZP2eE+EnUdJBVfa9Rs++mmufOSJt/O1fEPwPz?=
 =?us-ascii?Q?zCYrrq/U4RejO8XXx22LWx6yB4fybVXwsIOPxI5x1milWkJKY6NFlvb5pJN9?=
 =?us-ascii?Q?Wwg/JRJnv9WIW7eQGWjWfWZilll03nUzeGu5/p0qOlSONKViL2gTAla01OX6?=
 =?us-ascii?Q?w6DTYk67HsNQkWZQ6M9liXmY08n9CFZoszSJ2b6Y05UoUrJb6LxtKBMFeTeo?=
 =?us-ascii?Q?b2wJi6C75I8Y+nK9+tunea9h+4IiWsofpIrJbPHa6+K/ZNoUu8MCH1gkq2o1?=
 =?us-ascii?Q?r443J2uLuehfsd4nRH1bZ4GXxpBVfEdift+08I1EPmI+Ib28gPFjt6BfO6//?=
 =?us-ascii?Q?SNlgvuaeSDvT+ieSNqyAW6yAVkGM4U3T+6PkZ2Qp83jhFpjFlYf2GFv0viyb?=
 =?us-ascii?Q?1/CofeC3u89NSCw1YrlpB/W1/cjwVvttuDeAh7L5PDnJ39+jRIvXZhDjh4GR?=
 =?us-ascii?Q?TEIzOIls1wLkXBNfXdJH1GbXQsPxcAg9v8QOmPRmJeVYG8Jcqe0wgyG1mPhv?=
 =?us-ascii?Q?RQvKljuH2O+hVQ232Z41wYARoTE+wQLyurSm9RuE4+YR0NEHFpUQGTY96WsR?=
 =?us-ascii?Q?a2cqV04qGIiO6EDcEKs/iSTR220Rz51nQReK5zK9703fXP8Vz2nJfWPuTrlW?=
 =?us-ascii?Q?x8vjyCtaw/UrQcEcMNf/Vd3k/fFPpE6qEeOTSQJVtO+o83RsXuOtEz5pQeXE?=
 =?us-ascii?Q?fPw8sH1X+mNsiAanwGZyz6S41LqmXeBa3tPfegPOLxzoF53IdAEBQK5YfB96?=
 =?us-ascii?Q?Rw+A26BMbQSrvpv1WllKJ07UukoswqC9NiNkzMg7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb90fba-0e04-41f3-536c-08db91abecdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 09:53:00.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KEDIpQj/DUrG2zD090U2KibJQn+E78ivT2Mc63/DCzJz44DvNzUi6kby703a0BIJq8NHdvoHHBuBbnaGiky4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7845
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Monday, July 31, 2023 2:22 PM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, July 29, 2023 1:45 AM
> >
> > On Mon, Jul 24, 2023 at 04:03:56AM -0700, Yi Liu wrote:
> >
> > > +/**
> > > + * struct iommu_resv_iova_ranges - ioctl(IOMMU_RESV_IOVA_RANGES)
> > > + * @size: sizeof(struct iommu_resv_iova_ranges)
> > > + * @dev_id: device to read resv iova ranges for
> > > + * @num_iovas: Input/Output total number of resv ranges for the devi=
ce
> > > + * @__reserved: Must be 0
> > > + * @resv_iovas: Pointer to the output array of struct
> > iommu_resv_iova_range
> > > + *
> > > + * Query a device for ranges of reserved IOVAs. num_iovas will be se=
t to
> > the
> > > + * total number of iovas and the resv_iovas[] will be filled in as s=
pace
> > > + * permits.
> > > + *
> > > + * On input num_iovas is the length of the resv_iovas array. On outp=
ut it is
> > > + * the total number of iovas filled in. The ioctl will return -EMSGS=
IZE and
> > > + * set num_iovas to the required value if num_iovas is too small. In=
 this
> > > + * case the caller should allocate a larger output array and re-issu=
e the
> > > + * ioctl.
> > > + *
> > > + * Under nested translation, userspace should query the reserved IOV=
As
> > for a
> > > + * given device, and report it to the stage-1 I/O page table owner t=
o
> > exclude
> > > + * the reserved IOVAs. The reserved IOVAs can also be used to figure=
 out
> > the
> > > + * allowed IOVA ranges for the IOAS that the device is attached to. =
For
> > detail
> > > + * see ioctl IOMMU_IOAS_IOVA_RANGES.
> >
> > I'm not sure I like this, the other APIs here work with the *allowed*
> > IOVAs, which is the inverse of this one which works with the
> > *disallowed* IOVAs.
> >
> > It means we can't take the output of this API and feed it into
> > IOMMUFD_CMD_IOAS_ALLOW_IOVAS.. Though I suppose qemu isn't going
> > to do
> > this anyhow.
> >
> > On the other hand, it is kind of hard to intersect an allowed list of
> > multiple idevs into a single master list.
> >
> > As it is, userspace will have to aggregate the list, sort it, merge
> > adjacent overlapping reserved ranges then invert the list to get an
> > allowed list. This is not entirely simple..
> >
> > Did you already write an algorithm to do this in qemu someplace?
>=20
> Qemu is optional to aggregate it for S2 given IOMMU_IOAS_IOVA_RANGES
> is still being used. If the only purpose of using this new cmd is to repo=
rt
> per-device reserved ranges to the guest then aggregation is not required.
>=20
> Arguably IOMMU_IOAS_IOVA_RANGES becomes redundant with this
> new cmd. But it's already there and as you said it's actually more
> convenient to be used if the user doesn't care about per-device
> reserved ranges...

Yes. it's not simple as userspace needs to do a lot  ofwork to get the allo=
wed
iovas if multiple devices are attached to an IOAS.

> > Anyhow, this should be split out from this series. It seems simple
> > enough to merge it now if someone can confirm what qemu needs.

Ok, so the reason is this new ioctl can be used to figure out allowd iovas.
Right?

Regards,
Yi Liu
