Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1120766343
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjG1El2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjG1El0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:41:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13769212A;
        Thu, 27 Jul 2023 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690519286; x=1722055286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xrzs9gKFZ0KKSsPkkjkrtdXgEzaNnuMUN9WfV6Cxe6o=;
  b=em90kMhU70rRu4b7wa0BOhyRJ8fi3ZTI8hBi79v3ByRrgBJq4KpIpZzB
   uqfksHXkTzE7A0lIkLGlcr+k1Y9jYUKdSGKpiR6MJUERiPhPukQGMvv9Y
   9BAzaxgly4m1WWPT28NLomJ+9DM/GA8Fw+Coc5lQUB9oJb3mV1GZZI8Kn
   yNS3YmfhincIS7HKVfKSiqtALnC/Y+3cVXGvmgnPgbiDcsxlOSwaS9DjI
   yG4z+PCsk2nFdD1OmMRNLTamZYpiunWox9rnkVeFJq48C99mcrumA4Mj6
   kTVgr5DICGZ2Q9SivQ7/O8sYV8rENmvLpewfvyTms7TUwBvzyWbRUgBU8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454866978"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454866978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 21:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757001652"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="757001652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 21:41:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:41:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:41:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 21:41:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 21:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzyaUgOvj53n3LJF4VZ9z29qRo3Y0xIMy+67z2XeWmMsgCyZltFOsSh+I/+HHTXJ6XNeTo34w1twb5kGcRdn+Aywtc27WxIgDU5QTIl2c93BVK3Exfqn3Maig8g5JIvxeZ6R7WCTuPaIv0izvJaeG+vg0ath96xvDswgyMGFFdYLbk6imRuocXZCqmZsO6UEHqcSHcLvq/J/WxgWj7l8loURfWYUjfS4OKUabQ4Aewngl1nHXeZqP1qlmGzH5SR7XxoPxA7+MPdx8E3swMOZJ64b//SLF4To3GdV+1v2EQU2IsF89ygzf5dl9/GwEUEY0+3PsydNasL2AqhKcYG8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+inazrXqos023i0GNTrTYut07hrOPG9rZKKZeDEokY=;
 b=cmd29pa9C/DFGNXzf8/Z7aO4x8AbFZGKgboiewCufk+nr65krXVQoCr7suZZn11AGbCMZXfjanNBPiNTr3wNzXzEZdNfsg+Fk0NvacA/rycZKAbifnjTCG5dNsg570NgE00ACYOf9mIJQBnkdTabuHbjp3bz907+UK6Wrm97dHSpB7IwwKbkM+8XV6u1doXXoAygz1G2TrFpvw5TFVuZ8J96hQQd+HmsfFN+lf8bff9RHg/5tEqCTcbzzAgvoq29OO03AwQkID5ugKc8Dm4xJ1IFVhIOL4iuQvfwrdukRY7/OgD/MoaoK+TMJTLb415JsnLoR/kRUnNwG6A1IF1YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 04:41:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:41:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Thread-Topic: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Thread-Index: AQHZwMh6JNYyFoJVN0+eOwrrdrt/qK/Ok45QgAAFJQCAAAC04A==
Date:   Fri, 28 Jul 2023 04:41:18 +0000
Message-ID: <BN9PR11MB5276C3F296F27696AFD92D0F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
 <BN9PR11MB527660F2932964A47396D1E88C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMNF5vTTp2IRMsWH@Asurada-Nvidia>
In-Reply-To: <ZMNF5vTTp2IRMsWH@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: 1808740d-802c-47a5-5ca5-08db8f24e242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKFiaaw8oME1PCbPSe2L+d08hTuivBGqUrYBy1sdOb3w05DKGzW5MCxzuI1qezFqVwJwYUiMwjxgnMnntJoXhNbvN8UQzOfvbRzLpEST2oDh8nOpT3mAEUMLh9e3Nys9FcAmxZaIUWfsS2rsXJf5h1L8wBIXIVUTpspcSbPsM/FqRtgOhbB6P2tJWpO3kQzOiXjHMbD7L9OoF4qJqXuIcMx/RaTpTOPAMeAMzsqo3xkWv/5aGTwtaycx8MhW/ozrPfw7IatFaXacKx/HDrhSlW2RB9kJitr7kxKnmie6tm/OCdYZFulgZRKzXTEK8aaTZRBcnqax7zQA1xx9uZJNdWENlHMDU92H3LGs1mRKfOVprAZHDQfZqncPdrqkMGlZd5Zxq7qvPIovysKToHTX/Cqbzlpz7iBbeAfQ0NaePz6cpJvnbu+Mgr5IIn97B9f/uZiQXCIFMfRuwRu1BlgApffpCmP6hXWw8cadyReZmMR/84WM35TRP6Vhnhua1pdoNDSvsX8mURU7wRn44HEtTWtH4ueleOoYHmtbZQgkt/Wqn4ewfQNWV8K7ni4szYLc4S43BuWw0z1xnbCWQRwX952LrqZEWqcaysoy81CothZSpAR/yb6AlBCJpybNBqt1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(38100700002)(83380400001)(122000001)(82960400001)(33656002)(52536014)(38070700005)(86362001)(55016003)(2906002)(54906003)(6506007)(26005)(71200400001)(478600001)(186003)(9686003)(7696005)(5660300002)(8676002)(7416002)(316002)(76116006)(8936002)(41300700001)(66446008)(66476007)(66556008)(4326008)(6916009)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yYEhdwtDmn6URvIbBSSrloRNgvhXCCGL4u2s3Abf0Rdb3amNb4tn1mTNm6s4?=
 =?us-ascii?Q?9b0ZfXO35E1Ya/k/Qur+4msAvampfMH/+8k9J4T41ivdo5qPJpegsez09nb4?=
 =?us-ascii?Q?dH44PIWG3qXaObH1gWZNDJOo341hEx+hBVhPZIjPV4UjTX1yFTSheJMQ6k5W?=
 =?us-ascii?Q?TOWgOG2NuW2WFfCdN49JCWIjlGgeCCT4yUu5WIeclvwV/Trblugob9i9AQvk?=
 =?us-ascii?Q?1SqdEtlBa0rcaKQq+JUkUUfflLkBM2PVgcMi42o6xAqsojhOe4cL1sfu3AS+?=
 =?us-ascii?Q?Vx9pURHogMa7er2OGkduV+gEod2AyJUn+lPeusA/lDNtekYb4V7hrRhkapCO?=
 =?us-ascii?Q?QPpQ4eL+mCfJi929IERf4XY2pvFOrvWexE8X8xCgFPQB3stnw99fdZm581P+?=
 =?us-ascii?Q?v8ikZiRaO+MD0JMnwfUvuy3LSKWc0REEJRRVoAZHxkuL6CQbSVo79IWDyYRy?=
 =?us-ascii?Q?Y0ycbHD8Du6bUCaa06fkxWM14Z0q1zKZUQI0zsvxjg6+1tLMYxuBghTexy4+?=
 =?us-ascii?Q?ZVDL8hUMmdx2hoJe9IKihOH7YJx6NQWqMabfUXWBdPT0ZNJ00/t5twsjg0zb?=
 =?us-ascii?Q?ekj26AM0zjjRfadJQsh9DJ4Pmo/Dl16291hysTZieJ5ETAXFXmluePlVHg46?=
 =?us-ascii?Q?N60ejszbR9NaMybfciVtjkhIDmsv/T9pmO2ZG/eskIobNImxRlIZzikYQFQi?=
 =?us-ascii?Q?lJKVAbIBJG0UhKEg0o9as4WrOyBJePuHhiGTcOt+UqIwQ3PRZjyBhkYzzVas?=
 =?us-ascii?Q?Da3uNEItqju77vr+NJcr+GG3gy7jEU9gFw5/gHexm7PG/Vwc99m0gPohaTLp?=
 =?us-ascii?Q?WzMLfC80hQC68c6rD6zVEzZcePmY/kQIGDNh9l9k3H/hRD6SJtAIsaG0vWwk?=
 =?us-ascii?Q?t0Wf8Gt0UdC6fGpQrgviKLgAP3IQEyaUN4k6aWsWNq6keQtogRbNIR5jEvT6?=
 =?us-ascii?Q?8jJ+UB8yD/5aPRpB2gQTubG/+MdPG7vp48hWXdA1okeFxivo/ZPDhsAm4xDX?=
 =?us-ascii?Q?F6VK8jUv8IOFFBRCyZRMgaNcjPqwVOhXLy6UQ8JPMT6hFeMbOUI5iAr2hFdL?=
 =?us-ascii?Q?2Zg0326Y5jPA0BSqOji/xkTBrVgX0A0ncGWXGWhFcg5Dolw8b6BHxGGrbNdm?=
 =?us-ascii?Q?bQqMPygNqiGF+hsX+W1RXrBlBmRG9dIYlcfMaMdD0oGwoeBF6qzw5ufbzCIY?=
 =?us-ascii?Q?LhnFVxzQjsY8bOOAcv5+cjbEhvodJbIfqiMkIfpll1dBYu56eg+bgmY9zpJ1?=
 =?us-ascii?Q?NlYtAI0cPT0Hk44r8lrT5rnEBviOaPb4StIL15zkSFvqFyjLr8euzZH5Wo27?=
 =?us-ascii?Q?YVnCprCLYC1TrS9GoLMAGOC7KU8ye/8QAJhmjNUSiEtMeWkdBmDUGDRVJH0s?=
 =?us-ascii?Q?fOOQRzD5KJn7m2dP5++t7qyI7B6J8YUnGtOWNo72Waiak37Z1F5QjF/jlMqZ?=
 =?us-ascii?Q?c61g7R31MBLK45l96kwKCs54UyZIkRYb3R4IGewWj58u8z5tuqbQn624YInj?=
 =?us-ascii?Q?y0NZ+2uR+xSuc3SbvL7RVZe8E79wreGCmeQpVi8k4E2Y6UAtqwwjAfJRgbTO?=
 =?us-ascii?Q?kblxX+omw7qw0TY8P3GajUy82AkYTbctFyrgdhfP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1808740d-802c-47a5-5ca5-08db8f24e242
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:41:18.0601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: in1jjtnahZUNZ1djECXvW5cEzxwI+cGca6uNX2IDU0ycwW/JNljXRweTf65RF9UTAKMv40SH/x19UAkbm+QO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 12:37 PM
>=20
> On Fri, Jul 28, 2023 at 04:23:03AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, July 28, 2023 4:25 AM
> > >
> > > +static int iommufd_access_change_ioas(struct iommufd_access *access,
> > > +                                   struct iommufd_ioas *new_ioas)
> > > +{
> > > +     u32 iopt_access_list_id =3D access->iopt_access_list_id;
> > > +     struct iommufd_ioas *cur_ioas =3D access->ioas;
> > > +     int rc;
> > > +
> > > +     lockdep_assert_held(&access->ioas_lock);
> > > +
> > > +     /* We are racing with a concurrent detach, bail */
> > > +     if (cur_ioas !=3D access->ioas_unpin)
> > > +             return -EBUSY;
> > > +
> > > +     if (IS_ERR(new_ioas))
> > > +             return PTR_ERR(new_ioas);
> >
> > iommufd_access_change_ioas_id() already checks errors.
>=20
> I've thought about that: given that iommufd_access_change_ioas
> is a standalone API, though it's not used anywhere else at the
> moment, it might be safer to have this check again. Otherwise,
> we would need a line of comments saying that "caller must make
> sure that the input new_ioas is not holding an error code" or
> so?
>=20

I don't think it's a common practice for the caller to pass in
an error pointer when it already knows it's an error...
