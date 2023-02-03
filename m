Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AF6893B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBCJ2r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBCJ20 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 04:28:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F76D046;
        Fri,  3 Feb 2023 01:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675416505; x=1706952505;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XXDzJoTNlBSHD2jj/IO1a9lCJOVd634YaWqGC7O5poA=;
  b=fcFvsC0BUfjRGm+enqqNIwM7F2uuMGozlioOqVD/3aTiaBqMUK0HNVre
   epuMrSTMco8LECCjzGeYRyGCWvYTag2anDTN5pCHnP0R/eDhIos3v1MdU
   v9ZsgRZDVPKdNRf1Xqq25eKgCSkTa79g22/4l+WCpHuP/OJFNqvy/K50w
   KS+1w+GzhB8WM0UeNDCilnXWE6Wlu17nOjBwJFYlVMpsJeWEif9YFL4Tm
   gRveOe8HC2F/NEsjEipo4gXDWrIAcQVSWEOxtH3oxL9jBLs7++Xkowk/3
   R5d+xWo3u5GO6XqaU3M5KFZ06B8X4xWXbev2cVK7PHHR1pCtTPfuzN4sS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="309036808"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="309036808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="774259062"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="774259062"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2023 01:28:10 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:28:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 01:28:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 01:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzelVb0Q+IQuvNXqYMWe1k3pKZR5zdVV1vQyHZDua91aCawg0oabqGgLHjJ3Jo1kzEEwO3ZJEVCnd1hYPyl+4sAorFkHfT0/dwONlv81/IrvK5PRHcnmtjjRPVxlVAolqtf2sHkhxrGdkoF/Wk7AdqzVXOpNeQg0wTCe3a0U0gjSca6vo8O92chNH4rmnz1ncmRxiCZv5M25agBRfjmvOEyy8TEQ1+r5EH8VzAO+PH1c0lf40zeLbZMUaB8xcL2Gt0drlGjR59sZaanPtn3IGRZ8OIDK/EsBNt3pqoii6JI3Azaoh6GqKl1dYqDbRzEIWobWA3AopmaplQyFx6WOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXDzJoTNlBSHD2jj/IO1a9lCJOVd634YaWqGC7O5poA=;
 b=iciE6vQthK8E0zpm6qKIa159bL5+qzV4C87X9o/Fp4Un4rljBr3hYhRS/DccT6N6NKA5QsDmxnP9FuwQv/W+cB5z5JHiL5UZNZdpyRdFK/PGywmQQkVwWhdyPRiJiMaNAFi/nuvsE4Uwo04Xp7DCk2Y/iU9mXPjCGGRmZYLHNRylSq/8dsRMCAWQN720xpGwOmqpO1OOw4YiSSw4lEInwXcAisQQLxxxblcWBrMuEHbQNOf3EIm3ScRls8amYTYMnrwqn4jaPjI2vi1M7ckOAPHhK+0Zsssk5s+CuTNtxKUN7fQYpIjVrx5dRVH1E38/7mUL7NfDxKTHSUT4m6xVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 09:28:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 09:28:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 3/8] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Topic: [PATCH v1 3/8] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Index: AQHZNtTJDNGdO3E9fUqqSA0twolHd6688sNAgAAC9OA=
Date:   Fri, 3 Feb 2023 09:28:03 +0000
Message-ID: <BN9PR11MB5276721CE80769AEC8590D7F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <f86e468509886c8fe59d2326f83bbf95254e0913.1675320212.git.nicolinc@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7806:EE_
x-ms-office365-filtering-correlation-id: 4618ce30-d775-4f04-0922-08db05c8f30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sVaLS9HAEqajz7KxyErlVSLWYti7W9S3maG1GycqByk9ViZqXbhOM23oEkJD4mLdMF3UTjdAWWXttB0ahgHDl5QyyuM7Rv7gWMFbu1MlhgXEBZ3HdIwVNmchfPfXqA3zKtkI0b9NsrrFFUkBs+pcUb+n5XbBHz7XNitkLAUIdznIxBW4RiNlwGJ11NDwNGkpMKkKQXMmIiUoNwbqBzlcm7PZrZtB0BC/fabkromGX98rqFFj+0TmLRQmrX+uk2wL773ysTUEby/125SDDvpg8BN72acVStSO3fJH6b5cMahpsZHrsUqO383fAlS9QkEW5ohuRPqgOgCGmxGTgaPk2fLRz9DDC1tOid11xTq9hfbLpHtFQAAMMNb/eP/bJmpp79kYoU3XQumUXqsZgajPThymREsHpRzuPorC8Svb+RIkRlUG7uMjWBGm9dYShu3qFCg+Ef+e5oEtYxoZR75Or6heZUN/C8y/gucwjd/oW7N9fv4pJOcoBQW889ts3GsAWkNiAYyH+VzoTE9CnkjFXPybdmcqLwfuWD5o7kWZZlXsJLTeQv3HcoJIJO7WZKVQLi1bEo+5wv66/gcVt/v/vb8wtKwT5X1ILCjg/gh5zrJ1Ya36K/XX80r5vY3LSm49wnmZgSn3L1j3+qRwjCG9mGMFEs7Fr0ECm+LU4sS+brB6weqe0Vzn75/VYqQTSJEwDmp6fUP++kAxTpftFkzAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(122000001)(38070700005)(38100700002)(86362001)(55016003)(82960400001)(33656002)(76116006)(4326008)(7696005)(71200400001)(41300700001)(8676002)(2906002)(52536014)(316002)(8936002)(7416002)(54906003)(110136005)(5660300002)(83380400001)(66446008)(26005)(66946007)(478600001)(66556008)(9686003)(66476007)(64756008)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vX+8NSvn4Pt8pPjI3oz1DFzSjTGERzf3sS/9VUSBlLWnCM+id80s4Z2RlHgw?=
 =?us-ascii?Q?DfNMrw+efR5lsLAFxx+oq+qDhebGmAUwcu2txBuOnBForz26xratozwbmWKB?=
 =?us-ascii?Q?4mXw/QiKulzamvaBu6+KT2Vbl1+DqB1KY9Lr8PKCYR6Q2Zc0lMTYYOERdMIV?=
 =?us-ascii?Q?1L1gOVgeoSYJbMQBGfwnSr4TsRURWS3SvtTQfi00kv9pMi1zvwi7ifSQPBnl?=
 =?us-ascii?Q?eQMKGjN8gE3BQdmqFd5ea8x+v68PhKGl4zDGEdRDVBYV95kToEt2gPCez4CV?=
 =?us-ascii?Q?g8D/Nqh1Yu5nOSTrb4KVxy0vbO328AjLgl9a8VxkoU/zhVbc7rZRk9EnaTUZ?=
 =?us-ascii?Q?QzeWo88IIVnN4CLgV+HBWT4HvV6oSmVNizmJToDH6IQW5yiF5+LA8hs5jpN7?=
 =?us-ascii?Q?w5IFcRlpFrNDcfmCB6gyKEvgqKazArO95Eh9laIrURd97Qp4oyDa5CramTD4?=
 =?us-ascii?Q?1ylA4Le6tJrPTCCk7Vhyc4l+PFbjHZ8kk+skk8/aa2VnvE1STjIv9ZJHQARb?=
 =?us-ascii?Q?trWq/UuMrdZU1O8/a+9U111j9LL5L05deIzrlqGjWbtdMasCAaWHY3oLCd7U?=
 =?us-ascii?Q?XX2+8gqKqQCZx68l9JZW4MeuzKxxttzMGAw1d7wpwUk6nip32PyLOD72GnZC?=
 =?us-ascii?Q?8/heLLyy+ly8qPncTEawtYcG+552GqYx4ULCy71Fq1KHOD1W4afOnpebu8yt?=
 =?us-ascii?Q?KVvi4OtEkE6PYn8jBpHIoluv5V9KKYq8IWINTsYrF4Yd3uChNVZnIFmvvdtB?=
 =?us-ascii?Q?TKNs3DcAgS2Cxw+6sYKL237DQxWEBSuFQF8Qp35HlwWgHr249l99xtyNLuUV?=
 =?us-ascii?Q?aeRbem3ZVxd2K2BAx0HZfP4wl4O8DzhDE62owJYSSq6+tVuod3fwXGq4DL7m?=
 =?us-ascii?Q?Hfhs8bC2/JSk+PImF0Hi+/ab3nRrj4gYlRslvlYTesgXumez+Sm02h0Rdct9?=
 =?us-ascii?Q?0welnphhiTzgJOJW74gOQvP1uW1kD9TqorltVU+9ZHkzCOO6TP9iuP1h1qpL?=
 =?us-ascii?Q?yddEvIiWK4Lc/txIk1bquxtHHkFZqPIoQROaj9xTLUbeUz3Y1oqsLVSMPkPy?=
 =?us-ascii?Q?S6axuhEeCYlPow7Ll1ulezL77LgG2pB1dEVosqem2mnoqR4wREpZLb0yD813?=
 =?us-ascii?Q?b2eLpSHFrxofMOJjQM+RwvaHyQ9FmGbF6HLedyJLyohbp/IiBFw5rcEXO+v+?=
 =?us-ascii?Q?FN4W+ihuv49DEDNAmpW6TCctQFLeDmo42PtB6J0QGy0PHpr/fTngUGtqpF/U?=
 =?us-ascii?Q?cLeoffYsupaxSeWlcQx+Let2fW5of0LO3WQmDBh5ZivG/aoF2EVisW2UqIWH?=
 =?us-ascii?Q?yXItWkQTg+JaiqeErFhhTryDZZRiyYGW0Sz7951GYNjL/Xx412UoLr5MxxUe?=
 =?us-ascii?Q?T/KM78T9uI8r5GaZQWxhy4+QNr1WE0M9JAzLFpt7zvLHMs42ttbD2QEjJZbp?=
 =?us-ascii?Q?gCuEM7YjCZsr3uOyTzLMlHfa+CzTvPFICowL4Bg/GC1tYMzpJ+r3Y2o5WZbf?=
 =?us-ascii?Q?pMJ3P2xtRiv4nerQoFD9YksZIK8lJNW7hL1SsmYRoy59L9zGq/iTADMao1ep?=
 =?us-ascii?Q?tzEhXVpodCuUh1s42xXP1UyScofgNIfCgh+JDFAa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4618ce30-d775-4f04-0922-08db05c8f30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 09:28:03.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iXf57hU1fbin/rlZEkSIzBpvEtFvhfvIlqMmzRoLUT/GZ/wZaPvGKkXbUNeyW+zC3GsVIKaABvsLGCO6IwyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin
> Sent: Friday, February 3, 2023 5:24 PM
>=20
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> >
> > To prepare for an access->ioas replacement, move
> iommufd_access_create()
> > call into vfio_iommufd_emulated_bind(), making it symmetric with the
> > __vfio_iommufd_access_destroy() call in
> vfio_iommufd_emulated_unbind().
> > This means an access is created/destroyed by the bind()/unbind(), and t=
he
> > vfio_iommufd_emulated_attach_ioas() only updates the access->ioas
> pointer.
> >
> > Since there's no longer an ioas_id input for iommufd_access_create(), a=
dd
> > a new helper iommufd_access_set_ioas() to set access->ioas. We can late=
r
> > add a "replace" feature simply to the new iommufd_access_set_ioas() too=
.
> >
> > Leaving the access->ioas in vfio_iommufd_emulated_attach_ioas(),
> however,
> > can introduce some potential of a race condition during pin_/unpin_page=
s()
> > call where access->ioas->iopt is getting referenced. So, add an ioas_lo=
ck
> > to protect it.
> >
>=20
> What about introducing another flag e.g. vdev->iommufd_access_attached
> which got set in vfio_iommufd_emulated_attach_ioas() to fulfill what
> vdev->iommufd_access guards today?

Obviously this doesn't work with what 'replace' requires in following
patches. So please just ignore this comment...
