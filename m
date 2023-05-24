Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18570ECE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbjEXFHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbjEXFHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:07:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77242189;
        Tue, 23 May 2023 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684904850; x=1716440850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w1/UDTDpaCItpYHEX7iQNLnS342RvPIlNeRKjxghABI=;
  b=PwW8Y0Q7+MZ0h5AmAfHt5phxOwIYjOvNU/yoWcvwQuqPt4sM1oEgZ3Mx
   LJY7qMN1E5DBQKGteHR5Pw5JLGTQYaPUXphcMF5WverfIl1USrPEOQeDj
   uaQlYsFobYnoBsHhZ9Dv1bujXG9Dntbk+6O6bCtnBiUNg581BnH+JalCh
   nsfCsE98J1CCGOh+UkXc4NbSCMA/h6H1JoYr5ozXiE35xhA5Nsyga6U4U
   AUU4ptZ3i2l6pUA+v6vz9pv7zhu2xlHUERhCCmZfIF1BpG6ZNs7lGvCIh
   PvoKSE+426kTOJcxBnvOrdrAaY1UL2a8GrvFXp9Zw0P635Hd2htCk2oFH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333820486"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="333820486"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654672951"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="654672951"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2023 22:04:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:04:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:04:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfH+0y/smXCsPUFhNWl72HHx+/uiLiDSg2UDXVjNXsa93peaSp6UqZ+f0g8ANMrdDDx2Zo8qwDjROZEw1Xuy/vf/KEK0RPMbGb3RnQI0StlYiguRRsEfI8wD3ioG9ctw+jW3Y3ksve+gSPd4PkEMvalNpfczE8NQjxPJu9XBg3WvtMAGachJEkZ93W+aXsBtngc8sEW9bmdpydKiwcXsYOgZMB5bi50XHyuzfD5lRhcC8WRrpooDl3dot3WHTrpk+mFqcC1bkWaufVqSks392VaIuhwvfpaFdryrgpp12dH6WmKmaYLN4g5IXfQOmQUnkhOgysDwKi+ujs0StEeuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjSHFk1j3ulGeFKA+sFy4aoimTIpcyTAmvSvfmuGpQ=;
 b=ggt+/332J4el36RPxxX1iTKHlzuhIhH4hxo3fNn5XrD3bFVYZSnb9FBEs13ii8Jm0BraGsgY6rSTQtkQJlzejLlwHbYlyF6HmVHHtCEBGzlkWW9Gw4r0sdf6Q8ESmU1iiujkVDDH8RB6/mrgUBx4Wr1pPES4zDPAeX84SH/V23FSfvj7jvtoM29+Sdw+9DkIjVuYE0Vbeg2sc5MqOyvQbZQ0+aUbxddaDTnf0QgEGVHyihRwUfLKmGk3KlGOS6XVJEmnJUCHmvyI6TzXRL5tdVgyMwZg1gzxNYrj7B8kTjVoy/Nb3AJtHgGxFPir4ajAW7nJhz2ggD1NGL8n13S2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:04:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:04:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: RE: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Topic: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Index: AQHZhBZWuzKsMmALyU6hSy4chTQw+K9hVrvAgACovICABvKcYA==
Date:   Wed, 24 May 2023 05:04:03 +0000
Message-ID: <BN9PR11MB527698FFB2960DE4424CBD4E8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-4-yi.l.liu@intel.com>
 <BN9PR11MB5276FADBA5E22DCF3FFA2F838C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfGs85B4hPBBxXc@Asurada-Nvidia>
In-Reply-To: <ZGfGs85B4hPBBxXc@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB5976:EE_
x-ms-office365-filtering-correlation-id: a4a194c3-c649-4f89-1517-08db5c144b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3pgCLLgl2kUJRCf4wyd2/jwLStgN1raJg3Mc4ao9gF20PoSJwsezPe17eLIW3AfQMia3GaZoZlbV3L1MxLsFekrXI0uben7eXMXrV8PvqdTCxGqXbksafwceDBLWje/FYuBwVm9O5MIrtxJ3oIyOo8KRVqKuKxCUfFs9BCsam1NLbCiHtgSvSfxK/OaosS8WJuqhCreI7UESx98VU0FKwhFflUa/xlhOlTL+P/ufSZ6Fe5F7SF9fWlh+ZXMmzzfcNSnW6X7Zz9py2bbRKh8xnFwboxllNvyvkVVQpqbSdS4elrQMl8iFbOv4CgV08vvDiFQR6R8SFggno5ACpi2zGHm/78AuAd6F38oEMJqc4LS0jOT46TtW7k5/zF83jw6DOr2v9vd7/sT7YV1lV959AByuIj9P5+lmMok/XeDfdKhR2ehZfmTtBrOE/9YXxP6yjeRVnDjsrLqN6gAERMM2+E5aAv1I4PHeFHYG9FkC5BzRdeqdJ6Tw+iplRQzuOKtm49yk3t5gqLzO9GWS5h+FDUqS/vH7hCiFugtBXfdviZO9nw3RZjBuQFwYKukh8Sa4OxGhdQVIuaxhl9sGu8lR1VmkK1U9nat0VozcmNZAgwYbeYtlnFOUjEtGNbqjlvq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(8936002)(8676002)(7416002)(52536014)(5660300002)(9686003)(186003)(6506007)(122000001)(26005)(86362001)(82960400001)(38100700002)(38070700005)(66446008)(66946007)(71200400001)(55016003)(41300700001)(7696005)(478600001)(33656002)(64756008)(66476007)(76116006)(4326008)(6916009)(66556008)(316002)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VJD7GuJLoDX/vKuLtlY+p4YTb3IpCJUpAGKzRhYLEMGYF0T2rLHDNXt+4w/T?=
 =?us-ascii?Q?BaoM5LZPWPb1zNxfMZxjLfCTWH3j/P+PNITnO+69tTzoh4LmosZ2KdRd9pvv?=
 =?us-ascii?Q?CB0IexzD5SKIMk3olm+G2PALbUHEVBhJsbDfJSONQkG6TmP87ei8YYm5owlz?=
 =?us-ascii?Q?t9SQ5SICNZbHqP9O5gOMZ2onTC0VhIZstIiZJ7OnS9utImZCjE8Mj20TlX3c?=
 =?us-ascii?Q?yhzghTV9cNiOP9IhvNkV7HC0ZrjscJjahyFq0IkYFiJit2qTuCuBqRPbGXJR?=
 =?us-ascii?Q?wPRxCYr2Z+yw38Y/d+LCM8MzJFhas5/Vfg2Ju4T3QveqZK/rqrTNDwj6lzT6?=
 =?us-ascii?Q?fwyaPyC9iaBsFZHr9M99cAy9z1GiWOJpzUVpurXJ7PesAwRmDDSyLTWwuiDX?=
 =?us-ascii?Q?3TEkJAyWo5tUevD23TVz1o5+SrDS1sPM6Lni0GR+EAyS4qDFpMqvCPhF4SDL?=
 =?us-ascii?Q?c76sDuVLWzDP0Zkf88JiG+N7aVQuT8l5p800h8EzKPZo5WSRQgxx0U7nGQYW?=
 =?us-ascii?Q?K+PqfS+0RJu5mQGpzf+40Rrp0ZkhB/9EntJKa0/mOqlyyOCh0HjL4NXUDr5t?=
 =?us-ascii?Q?K6RuWRp3L7TI3WT3Se7qJdo5wlvn/eazE/cm2v2MjZUR69TDcHXNGTXjH3t7?=
 =?us-ascii?Q?RwKExLMOkJKS+rOSkdxf5yrqP34bnNspd6Jai8KuhSSZ+Jod0BApccVJDeji?=
 =?us-ascii?Q?EpvKl1vTXGpX8/qmvsgpL79gCIj5iiTRqxMvspZCUj/LfHUwktkDPKcY09d9?=
 =?us-ascii?Q?bWs2RIIsjehDKdH6G3SMdl2dComCPP96QkiWrzofp6CS9gtsFlpIftSpqmhj?=
 =?us-ascii?Q?49FI5iO5ZioRZF5/gUKBKLMXjYRahCKDoeUpIE3Fj4VymDa9Oz5mkvxg3iKs?=
 =?us-ascii?Q?9ju7FNjNjlkSD3B9Mt7B+TYTNs/O+V8OfGaeOY/UUvIQrxDf62rFCMSsQL3M?=
 =?us-ascii?Q?Z3ydugEg0LUr2PMYa2BjIE9baWsUFpcakLHnqZgnk9EUhimkEy9gtyh8aHqX?=
 =?us-ascii?Q?py5JR2wh3BL+wVCD15AbYwA551nug+l3flwURlQloGo7fkc/Ci72jAILkdFE?=
 =?us-ascii?Q?Aua6BmerEcQUoUKy5OPNWQDzUYX0l2HYoCJnUGtu8L6N1ktF+ZPkGNr6rcVy?=
 =?us-ascii?Q?qdXIpRnpmUoh5m/cudbe3cX5tvEx23FVIqDx/+p3JOkyyr5ZZNqQ7f3CnFc3?=
 =?us-ascii?Q?bRdUbWyZaE63hkw5Eykp1zWkYy0+mYK2xEnWCM6Dk+KRk7fDLGcJtxhiSf3V?=
 =?us-ascii?Q?nT0/ZAO1au1E2nbEb+HBAF4sFJELAgnXvZYhYqW5nblfzVaVzoUHJDtXEzR5?=
 =?us-ascii?Q?ATvzL1lC7n1ar59cvKjq0KQZzHNm/+S4E/uU7Y/i8plRN3KKDYE4zGZ9bNP8?=
 =?us-ascii?Q?RvtNM0N9MhgmO3zzdB1vsgXJoR5GxBwTdoSUuioqoyv4EEf0jyL5ptHNZ9H1?=
 =?us-ascii?Q?WAy1VT5VublBB6TOveXUw+upctW+BwmVJfUgc4TeYQol8QlmfBHSi51uo6qR?=
 =?us-ascii?Q?tsEYCQFeRFPuyMRgF/0GNCPiICTm7PjHItfE+r+3XGeS5YOLyXXIPzpZPIYb?=
 =?us-ascii?Q?eCrsuJHTS4XH+79zKaHiOypv0QiY3UYkVL1WbOTs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a194c3-c649-4f89-1517-08db5c144b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:04:03.2938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmhTess4gVnw4G7bzXp0WfpH3EvCCv6oa071X/EiEnaZTjnsFMTU1pA3uzDJDwaU+hGqkzeh0zqO5iUeNco5LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
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
> Sent: Saturday, May 20, 2023 2:58 AM
>=20
> On Fri, May 19, 2023 at 08:56:25AM +0000, Tian, Kevin wrote:
>=20
> > > From: Yi Liu <yi.l.liu@intel.com>
> > > Sent: Thursday, May 11, 2023 10:39 PM
> > >
> > >
> > > @@ -88,7 +90,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> > > *ictx, struct iommufd_ioas *ioas,
> > >       refcount_inc(&ioas->obj.users);
> > >       hwpt->ioas =3D ioas;
> > >
> > > -     hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
> > > +     if (ops->domain_alloc_user)
> > > +             hwpt->domain =3D ops->domain_alloc_user(idev->dev, NULL=
,
> > > NULL);
> > > +     else
> > > +             hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
> >
> > this reminds the comment for @domain_alloc_user() should clarify
> > that UNMANGED domain type is assumed when no user data is
> > provided, to be compatible with iommu_domain_alloc().
>=20
> Yes. Perhaps:
>=20
>  * @domain_alloc_user: allocate user iommu domain. A valid user_data
> pointer and
>  *                     a parent pointer to a kernel-managed domain are re=
quired
>  *                     to allocate an IOMMU_DOMAIN_NESTED domain. Otherwi=
se,
> the
>  *                     new domain will be set to an IOMMU_DOMAIN_UNMANAGE=
D
> type.
>=20

yes, this is clearer.
