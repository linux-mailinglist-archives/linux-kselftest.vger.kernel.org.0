Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E237768CB47
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 01:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBGAhM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 19:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBGAhJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 19:37:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036D24484;
        Mon,  6 Feb 2023 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675730227; x=1707266227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CH1lsIb+/QngJEDs5Gn36F3WaFmtfZty37gFkhDv6yE=;
  b=SuYkzJLYRONOQTth7q8nickNJw3tBaXLtNHhYa7boNG7RHrvOWiP3a21
   KyL91eAH42WcPh0gU4+D4Zp+XloRio5K38v8y+beYED8KyhDcD3EkzUSA
   4OdCbkmWWxFsjd5BCXWBKEZQQnpo8gZyfpBKy7DSJX8EBIB5s81EJdIoW
   QgYCRzNFU20m1U8x44M7seO7xcxwBbqrKxw+RhnuV2Ze6b0AIVhB28h5F
   H2NN9KRQiltfK2U+hBH+mnb9wYfDOHSzz5nK4Vy6oFAmtMUJ7pv2/NYaH
   kzrXXr1jBb+thM6SVdhoarKqdcNsbh9PFdCnci00tnNBAQCY1EWfOaP2Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309004756"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309004756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="660025299"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="660025299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 16:37:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 16:37:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 16:37:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 16:37:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DduCgunHoACKCoQKdC4IUZB+62LFMUzQg83XW+62DReVLDlEA18iG6mqCGoPUkDquyaTkI+YTrVYBrL7mxa4cwpG0Dw3/DbPLEXZIZbjyYjtPG74wb7uLN9Fl0jXQNxq+h0PaK743qCjcll8pDEEvOMtyxOz1Tz2kXYzfvFuid+OR+VfSmANzaH420vh9eNFsBOAUptCmk4rzq+GI7ewS29SGRKK7xZCLQb524mN+tDHuwMOA2Xsa8oZNrMacSGltZIs8KUne5hLx+hSmVF5qVOWsv+mCuI1C3jMWRX+voy4GFBHSPnDsoZnVVt1kO2pcZuq2C59xfWJeJUS3g7y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4/PS0hT3umuGJs9KfBBuYYv6QSVwn9NfClqMIsVhDQ=;
 b=EEE82cYsaWUGAYNRsgrRS8Httuam6Lt/dY68NUx63uDCKZ2z+EfxRIu8cVH/hd8/xbM89QFnBryoYrWutYQL7XMJtQpKm87RbyOqeG9DfkPRfx/xd+rO1xEJTCn5g8a/ye8LqyahFx9Sava+2dyPx44vXzOoNwP9sAJ42J5eEXHQxHpjZBY0+1GR4EOrlgBSicqjZiT7X+kDFCrmZ10odBduGYjKNG20eUlylpRyXxdzogr642FOp4QzuB1XWvPoF8HH7eH0lMuKTQutL1GxNmp8ubyj1IsDAfiNZ2HX0HAOjyPcQIcoS2trmUQhYYMhF+bUdApRrB5O27vkKFRNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 00:37:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 00:37:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Thread-Index: AQHZNtTLkB/Ugg11HEWfRX5kjXpVwK7BoBMwgACxoQCAAFj8EA==
Date:   Tue, 7 Feb 2023 00:37:01 +0000
Message-ID: <BN9PR11MB5276E4D38184A2910A7661B38CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <de1cec7698e9b4e2ad03b7d9414b25d655fe5a6e.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB52760BBE37B65AAFA0CDCC708CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+FSVoRpVguZUmW9@Asurada-Nvidia>
In-Reply-To: <Y+FSVoRpVguZUmW9@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6872:EE_
x-ms-office365-filtering-correlation-id: e2788ae3-232a-42d7-dde3-08db08a36dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiHNHOrg1y65FbrPEtcJNdiyyRgtlvwEBV8OrfmYIeVGKTUu+6Z9NACwtvQm4SUgHkjQi7vraGV00VjA5QZeUq/9gAZ+SIgX4Abvr/2gntP8/JIPpkfLjVfdg4fS4OmoosOX78MVAmq+MOCD1kpM7LAyfdvAfYWXw1PkY3ACh+O65BWvZAsL8DZ6YptQDYUpJtVfGewXgjBoKTNNpMFSpXFTEayUkekVIwSjEAD6ViLw3sp8r5u9UH7BTUYfeLBt9zzZuy0KfeDwZb1reEuVuakb6otPHnuyAMf1PZ69zA5MOsCi+swFJYENFL1io+V52UpNxhsB83zIIC8aJlYbtXrz/RWwOcQZKH0oAuZQJ+6Y5zDCxH/CsEcVepQGWWnMfEL14c5u/f+dopSLiLo+Pmfid+KiEyYFvSeajaxkxaZnf44tSMhwWu0KLXjmHsGVkN04X72e2AvfzbPf/SM0FZqSfzTQZO/2oSF6lRnXLMWkM0WDd7cETqOh3xd1tp1s3jvGZHundp63HChbZ1YfMt5y5atjwnHVIc0DVT6BKnYBcw73znPC/lTbVDy5e43B7AN9qNGPpC4+6BGl/2JF246lDSTnYErRKanPnZRIPf1LwcwneRewSH7rPiBOro7W4iTVWWzIAYbOXZ/KiyAgp0/9V7juUakuFSJIDAI6/DxdSx5y5pJq0WiU6w26bwT1eeomhZZpEqqZKqlMvdSyaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(33656002)(38070700005)(55016003)(38100700002)(86362001)(122000001)(316002)(82960400001)(2906002)(71200400001)(54906003)(478600001)(7696005)(8936002)(41300700001)(5660300002)(7416002)(6506007)(64756008)(66476007)(4326008)(66556008)(8676002)(66946007)(6916009)(52536014)(66446008)(83380400001)(26005)(186003)(9686003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?axppF3g2JKVW58KvKay/0tECrOJorYdy/N+xbWFZx35+Xk5ps4/gkKYW4sDE?=
 =?us-ascii?Q?1bMW+5/ZLUtWV69pl2bk2HCweln9tHyCOZmRMcZ0HAQjf77YRYadyeYwdbMJ?=
 =?us-ascii?Q?9meH6M6NiouxmlrquXUIU5AfYcOtgdbfLigWEgDx1h0pdgl5jZQ42iSEYTsA?=
 =?us-ascii?Q?BXdRfQoQQguRvwGV9XtHDcWrCWu5oxzmtpooSvuaJaOZvY6qA2069PMo+icM?=
 =?us-ascii?Q?uzPJFqY1Ynu/w9lY0lE3D+zeB6nmogZPDxLk5f6olQ+mzVAgbI8xJk67ypv0?=
 =?us-ascii?Q?ln5Ubj4unagfwYYcbTCwBpmTMtjJTO1SkW5JAWx7GT3wWNo850T2l4KACAHr?=
 =?us-ascii?Q?eLzXvGiPSkDMPzftySfoXuU0wkeGRzpseHI0LK0au19yI7luWQ7rWoHMXPQa?=
 =?us-ascii?Q?diCG/zzHtHBvtgHdjI5zkdju1vLWK4KjW6lsZbZlvusIjRwadP5NoQ1qcLR0?=
 =?us-ascii?Q?yXfewAgKMMGu5QrrxBdZcPxNJD1ibPdvpevIP4jhrzwF4xVb5+JkHFoAuZ57?=
 =?us-ascii?Q?k36tgcfztEuDInWJQi/aWu6BotdMHEqWzYFnAizIRH0/wB1FO8vtifn9rn0Y?=
 =?us-ascii?Q?Yz0hsoHQLSzxgwwEwerDcjDkUlveLg6PKMfoJh7oejnHKa/fMKtG8pwLFqFa?=
 =?us-ascii?Q?3sj6Qmt7O1RPb+f2LrdaWGH8UmedUYIlKGU9D3sn2VGPT8Cb04/KozIztNRF?=
 =?us-ascii?Q?pIIpKXc1pAqwOrl4/b2eS/mAaFCnqNCnMo1YUVhJ9eITqzYtthCNwQyAD8l7?=
 =?us-ascii?Q?aYDVssB4LkcyKa+NjKUCk/TlbfmHOJXEax5GKHWPKhKSBBFvB0RjOHlr5jU/?=
 =?us-ascii?Q?6wTZNj4pNZu90mirp6wg8kiBa+U92J+sZw4HCYNa5bB5/FTQUivKZ6dm3w8P?=
 =?us-ascii?Q?q5326RUxF5S0yk4F+FFvtyOm+/I+/xM8fmPq0Pagt9V+bX+dn9DtNklz4Nqa?=
 =?us-ascii?Q?MIy9mR6SAzrpf4PbgE2zauqpXu0IY/dU2pFRTtOwHABMPypuleAHpVN+09HW?=
 =?us-ascii?Q?Rf+Dpbyu4LWjVSHipFrK5wrAmJEDrZ8MgQErS/7QKBM/jyQYdiiiObZPKzHD?=
 =?us-ascii?Q?jf5l1CgHIziSqnrKSJ4a4eTuourWqnQmai1C8Fdavz2tBgbFJrRuUgllA2s4?=
 =?us-ascii?Q?RaRfvpB7YcWS7JiNy6rBlzp/cwegj0pNy9fwB9I/AxhDmcFt3nTvwGaXSHtT?=
 =?us-ascii?Q?F4g6liRGIq+pnp/SFIpMFo0v80iDt2PKDcEQbLNeQ/7PS9B9DeXTOMoQ5Iy9?=
 =?us-ascii?Q?vX+jz2xzhbj29xBmNrzRFvWAVwZACw3zuPJr0onqZnT08MIdJDhto4kPffaE?=
 =?us-ascii?Q?ohlT5NL8iINRXlO+tH1FlHpJV1TeotxamrDr6MW1YssZx4UoCcoxotH0st4s?=
 =?us-ascii?Q?heebdCajo6Npe50VQ/boXqCJfkkpGSZ5XB8ysiXmses/FPtbSbgApM2MfzRp?=
 =?us-ascii?Q?3Qc0SvIYc/x23nBBadhIuRZC3CIMbvuxGdrePxJ2rnJ+y5aq/6yThL3rch0s?=
 =?us-ascii?Q?a3PORQvSVgfNeHgvHwyJ/PtBxwMT+HAyTaauzzIzuiLQYE8FfHLVYDgR3qio?=
 =?us-ascii?Q?9LB1XtJ4LSduvf6KxWa1DVsAmQz9SjCee1A5SfOP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2788ae3-232a-42d7-dde3-08db08a36dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:37:01.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MCGbX1LzV9U26XB/R9IyjyZVseDuusG3Gr1x4WpDHKOO2Fh4YawWjz2b40b+9FkmUV/mWSpX2IeZYC/Fptirw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, February 7, 2023 3:18 AM
>=20
> On Mon, Feb 06, 2023 at 08:46:04AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, February 2, 2023 3:05 PM
> > >
> > > @@ -246,6 +249,18 @@ static int iommufd_device_do_attach(struct
> > > iommufd_device *idev,
> > >               }
> > >       }
> > >
> > > +     if (cur_hwpt) {
> > > +             /* Replace the cur_hwpt */
> > > +             mutex_lock(&cur_hwpt->devices_lock);
> > > +             if (cur_hwpt->ioas !=3D hwpt->ioas)
> > > +                     iopt_remove_reserved_iova(&cur_hwpt->ioas->iopt=
,
> > > +                                               idev->dev);
> > > +             list_del(&cur_hwpt->hwpt_item);
> >
> > emmm shouldn't this be done only when the device is the last
> > one attached to the hwpt? and if it's the last one you should
> > also iopt_table_remove_domain() together with list_del, i.e.
> > similar housekeeping as done in iommufd_device_detach().
>=20
> You are right. I had another patch on top of this series,
> moving this list_del() and iopt_table_remove_domain() to
> the destroy() callback, so I overlooked.
>=20
> And I just found that the list_add_del(hwpt_item) in the
> IOMMUFD_OBJ_HW_PAGETABLE case doesn't seem to call at the
> first device's attachment. So, I think that we might need
> my previous "symmetric" patch in this series too.
>=20

Yes, that makes sense.
