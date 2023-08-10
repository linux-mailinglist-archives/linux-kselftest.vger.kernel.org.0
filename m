Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0594776E9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 05:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHJDfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 23:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjHJDfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 23:35:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A6F2107;
        Wed,  9 Aug 2023 20:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691638540; x=1723174540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2biGbpC7MZsf701QFEhJGhug+GdSftnqusqgxUt1or8=;
  b=UFBg3l5iNWlEGF5gH6NRoyJemJD9TqEWuxj9ayCkTKi8xxheuXytpJHU
   kV16YnR4QlWlFgKC5QlU13Cv1LBJubg8AGUrZphouybJ9VBA7irMJMyt5
   yYiayQdVz3KWMnMfP9OtCOdCXmupwDRiYeExUp6I6gCUgLPIEcXdlPBya
   mbLcwBT8m88sYcOQyNEW3TWkr0Ip7HSFpS1pejJuITkpd6NHWKL3km0x7
   eF9Bp8RjguxTqPg9At1lfWM01fNJG02fekU2ZiBkpz0ADGQNLlyD6CkNf
   BjRvjdg7Ulg971+KmaDCNgVdpwfVHgqbBgQV5XRcU1NglznYUgM9QQn+7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435184090"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="435184090"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846209846"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="846209846"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2023 20:35:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:35:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 20:35:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 20:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXDtA/0x+3HWT4LiGTvtyHceJqObCkuXEjwWkZPAS0YdR8SVUA1E+rSe3QadvJuByWFouzUhsYpW5we01p5OmFUJ6TwFWtOwU39eAOB1VBCU3r+zKO1NbaOnOF/5ccwLSlMF2T+MpNRmKMFQBUou4ky9ji6t4wnxE6N8x4DLaSqM6asjjb8irvBxo4BSmBo0YhqHcM2MvpHYeN7QDg/9+J6gT9IZ1773iS/zxeW4sy5Kt6wJL5JuVMDlJV6Iho8bSvLe5SizkCdfETcjSE9nggGFzlnv7yNVZALrPK3WerWHgmcr1k0nbnvO1yXFZKV8GMo3K5GwuRIx5oPA0+M7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFHh7u4Qqi4Z3hs27w6BJyduzX9m95rMXGvZd2ISOd0=;
 b=fDOsBNUAQGmHY6y51iNOKJw345A5ZJozjWQkO3baEQc6c4121zSYOMIX9ND1Ex3T45IrL6Bf6W0mGHYNArT2e+3zWE2C0dJcEvct9qC+xANR7kZCtOMY0sLrRq+Wy/LGiIZHGJOYT7AS1gIlwyVF4psAzilvpYAAFiYUUsXShe0w1el17KW9i5JoP50tO2hV45k5z06m5xEfw7G7N5x6XYl5FxBP4AWG1BGchXRokhHRnrpl78Ub4AGY4ogJT++jkVLaGg6CtiyOpqYrIfSAcWYYB4hqfxP46ws+ngKDZN8PqHxNXblOswJcTekKQ0WZ/iPaNnptaySlL45Y3EegGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 03:35:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 03:35:36 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZyg3yWhUfFHBvh0mecI5NxOn1hK/iLSiAgAC2DgA=
Date:   Thu, 10 Aug 2023 03:35:36 +0000
Message-ID: <DS0PR11MB752929F059690A48A105062DC313A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com> <ZNPCNQxUesiMD1wM@nvidia.com>
In-Reply-To: <ZNPCNQxUesiMD1wM@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MW5PR11MB5761:EE_
x-ms-office365-filtering-correlation-id: 388ee0c0-d059-4792-1fb4-08db9952dc3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDzbOvBYIk6gJOkTx0GT1WGeQkppMGSBm1LNt0yOl7liQKU8v9X2/EBbOtt6wfC8z5IBr05bMpRv0GtezryrND7Cye6oizF8SVvTL6G5kONNvR9SY/mm5Mp2Z9D43HdiUWF0RRdp8ypmaNTve6BnR6oaXaIb9v1GxH7xA3G3XizPH7JtDATR3EO4gKdzUMicK5pqvz39OZBtRC+94ZoQmDbICJxCBM+vygFGUlwCRguIqPAhK0fLUNcXbbkQrwGwnDQsnkO0Jb+2E8Sb54JTLUl8dVp7W+RmnvnqGVpMYLgdpVVsSiIRZ92FU595Oi94UX24xF4YMk/ThVmb4qYLDY99fL5JluSZGWG7SgkUKgRcjr2RyqlToIsavNCGO4wha0AQxwf+GparW1HJ85MLww5A6g8g0IhMdAPSCY6OGPsQQpJWfAbF6AGw02PezUwtpV6K8FBxq9MhJJNkwjnkvGG9MUeanENiZc7cP3MlDsG8fwQLd2b9wO1d+yZDHq5k68x7yJkVXQ98VuCN6I1ddZ7x49w6t0lCx3c0xqbI/cxxryKaxBWGlaH8z9lJnJu+k9X/Xz7Daq1LLZ8EE9rLoP6vA2ayd7qGUx/h5mrUJvAFS20Kbhj7EOwU2Y9gu7MjFmbT/O5RktsmEE+DV6FzlRpjBS1Zzng927YxcMVLsIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(1800799006)(186006)(8936002)(52536014)(7416002)(5660300002)(38070700005)(8676002)(41300700001)(316002)(83380400001)(55016003)(86362001)(4744005)(4326008)(6916009)(2906002)(9686003)(71200400001)(6506007)(7696005)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(122000001)(478600001)(38100700002)(54906003)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DGchqzFWLKew1qPh4znZW3LjtIXasx+gF55H8UmyLE3mabDoJ44TtLJ48kpZ?=
 =?us-ascii?Q?tUXPLGiz3gA6o/+Oh3Ay0Lshzh47JVHkHdFSwTmOEOeoyIUdjPiGN1AQmMEv?=
 =?us-ascii?Q?YSGNq9AYwVabToHR4pWlRAPH//9BuOHZh/IIDpB1NZwQF/cmrDRX4Sagk2/C?=
 =?us-ascii?Q?FvCsJqcpOxXxHbOpbTdHwJEAyLPZAs5AMInsD5TRO+3JuZoh4psoTjTRlqGe?=
 =?us-ascii?Q?jEzIO+8Z3kfhLS19DxQBkRNnLA3x3vmw3hDuAxbsfk8RKfH4x/cIONKer4Zn?=
 =?us-ascii?Q?UODHbTxkP58vdJLhl6EGAO2TvG8uKD0n8MspmvdDpPubVcnnh86/2rD32J6z?=
 =?us-ascii?Q?QUooTLiQcc9rpV6BI2i4agaSMvfYBqGpHl3U49ph3+FIkm7rGjQp4mNjCA4v?=
 =?us-ascii?Q?j6xYKlA/NlGZESFMtqsr0YT8DSxvy5uDAzFkTU509ig6VGA8kDAbqvmNFjCC?=
 =?us-ascii?Q?0qR60KGvxAt5n4mWyG8TosSBYRvgTIX7BE5SD/VNafGsDIUnfQ9Cq/vTPKej?=
 =?us-ascii?Q?rSwuq99zfe8YjClm31SNMnERN2c0431umFFH1qmjqs/ZAkjG3aIZ/rULcupe?=
 =?us-ascii?Q?8H17ljIde7X25AIQqp2SUMAvcuXBuo+COGsSDLpBC6r5EgxcyBCiU1OLjS50?=
 =?us-ascii?Q?v7rZaqVOcJzHyZTL/HTQVWS89Q0qCSldMQs2I0QXXxjF8Mh5IdRng39b4kVv?=
 =?us-ascii?Q?0u1eq0n5WR0KVMwjMSG9i0H/7q5KxUZ0lo6KWMIXFIXF7PmR2CJ6lGwu5lIc?=
 =?us-ascii?Q?ylhO1PVvzlb/3Cls2U6Tz2gwZSLTmFg817uqXbtaW3TNuHUKSJ3M4WjGG8Ds?=
 =?us-ascii?Q?QQreuWYIu1Z83PxIekIti3XAkIi8DWvyTZxE81Vaece3jlRyc/CFcyXRmpQn?=
 =?us-ascii?Q?vt6m9KfWtk1r0PL/xqNil1tCIt8nq2rYHqJOxvkyyRG+2cAkQ4QvRLYVd1zW?=
 =?us-ascii?Q?Nciq4KU9gBjYdlPWzCGRAQ4S9BLjLVuyOq/C8Y1mhVU3K0NqFCadF263E1A6?=
 =?us-ascii?Q?i340y/Jces2p6oty/KWvfq0LkEhW4XgGIyU1J5Cg7iMVQWcq/k3gWy5+emh9?=
 =?us-ascii?Q?2i1Boi5ETbkA5c49DTIueAW4mpVFy91hBS+kBUe/FtllhpIsLPXrlbonio4l?=
 =?us-ascii?Q?TTyu3n93wqY5KLBnVNt+cAljiwMUSe0Rd5nIG5V99xwA7bVnmqleKtRMrMPe?=
 =?us-ascii?Q?b1xkZLHO2Esh9sHv/kOMqhDGfyI9wFhBKbYmxTtO6VIOK7n/vVKiAh+L1n6L?=
 =?us-ascii?Q?VdAF6c581JMYFnt6X2V02NouLEXzdX8m/mTUVm2dpmFwSUODQD6zrWyhNRZ4?=
 =?us-ascii?Q?SJ+R/+VydzJfXRPh71beK3KC0uCXMY3HXa3hMM9ucFeE+2rv3f5Xrh1SsADV?=
 =?us-ascii?Q?w/jc8GBQQU7IAyR+4+6vxV6WLoNlKmxEiJVH5GxW/QWcmc681jQ8KstYT9sI?=
 =?us-ascii?Q?O6xIjtwXGYeqPL3a/M2IXxAbyG2HGZD4JlF6Q0glce1pB22r3MjeeEcwpHkI?=
 =?us-ascii?Q?pIQYSMwXVxZBWM/CkdvFsp+m+7dp5TMxf+1hqc/5pP3Hmt/GfdlY6KI4+w?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ee0c0-d059-4792-1fb4-08db9952dc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 03:35:36.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf2qPhBkBByz31sKbh6Kw0F/vkcj6gS0Xoq0tAY9qfHXnSeSqTPbhHTSuXNZNoOZYl6l9CAD/CPCZxUClrU5Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 10, 2023 12:44 AM
>=20
> On Tue, Aug 08, 2023 at 08:35:09AM -0700, Yi Liu wrote:
> > +static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
> > +{
> > +	int index =3D 0;
> > +
> > +	for (; index < bytes; index++) {
> > +		if (put_user(0, (uint8_t __user *)(ptr + index)))
> > +			return -EFAULT;
> > +	}
>=20
> I've recently learned this routine is spelled 'clear_user()'

I see. Will replace with it.

Regards,
Yi Liu
