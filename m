Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43E6AD967
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCGImO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCGImM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 03:42:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FF50733;
        Tue,  7 Mar 2023 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678178529; x=1709714529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mjQy9ipGfBx9QeCmz4yG1CeX6VnaSjs16OdM4Ra1n8=;
  b=QPml4t/1o/X1IBKY23kkp9lZ5xcEqREr/mmDQbSiV5IFbKtuZSOZxiEP
   BVIxDg6qkHtCcgDoHgXd4jxVjZCnL6hzIGX5SPVUe2X3FF/JT0w4oRNg3
   046obDZFUn0h0625DK66oWq0uM5EjwtNtL6vc1fH66GjdzIueiTn3WamW
   KRPWBNe5/iAovqtn9pAtN7MfQQoI5MP8CXTlqz5g3cqMvwY65e/kWFVbr
   lnu8faDB5D/YuvZyrzXG50B9Qzkc2lK+X35j3ONCPxcSMd5c2fDMoaekc
   a+EOWPPaOLHOfJma33TIDzhknTL8vl/k/csZBUrsmEL4uym+1g3R12yRC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316198424"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="316198424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="676492998"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="676492998"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2023 00:42:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 00:42:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 00:42:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 00:42:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 00:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzxLjIL3PwbaK0og6yXUY5HIrW6f3y5R8tictWPXvmkMMoWDQwQDG/JoDE0YOCDVROW4LdUismvFhYpqH9Ol7V7GjsaMBAIGsDs6/xm0hTqzX+hM83JhxSSyK1B4te8e4A4PQWXqW52uwxfWoBJ11WbDCBdgmBWVffPfANDmDbJO/kxzC29i5NTRhb3bcVUSi5yqkxUPYT3QTxFrnVaRuedqmLRdzP/+shL6F0UzDdnrdzOMarFrjuYonJMnG6R45NeMA1x+sU43UnT8LZpJ65wpcqvjx3zP6YpCMA1q9iAcmuQqHhkwMm+1gtjpeWumFo++WHAv70ZnenHzcq3N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYF+IVyiPXX9ijWnt6vh6Qs/rnnjddevxUnkErUS8kE=;
 b=luygGeMG31I0EQlj2Nb+X2CHFToY6QV4eOV+f1V93aprsnX1utR17myTTWMu5WcO80/s+9bLHzKXQp1DzRySDiz2tJNYGOJbItsALVpcaQgqTDwQTPUNLZ+EJVwyUlYzz3K+rGfEC468JeHhPnbsKgy8gg37lsKCEhbfOX81NL+uMG6FgCy8aex0Sb/d4r6FqjoNxG1nDX6xmK7+PNaP9GlRM2G3Tvo8Xu/KtmaILfMPE4GA21CclJW36E7foFISj0QBUKB/bN+CJxIB/VER1f3m7cPA3H3F8YxlHu0di5Vn8/dWsAktw28A0jGVCMvQARKhgcC7kFe6EJJP9vsOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 08:42:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 08:42:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Thread-Topic: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Thread-Index: AQHZSLASwwV5g7rlQUi/WXQEXqe0Tq7vCL8A
Date:   Tue, 7 Mar 2023 08:42:06 +0000
Message-ID: <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: 8937725d-73de-4528-5942-08db1ee7d4fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h38oBu9GuhPnJy9gt+N+c8oz6AIgovHqsTJ39nKcMJQD6dOiDasfXL/kk4BTnSjASvB4LGZXnN/OVlQI9XnrOqBsSyB9UYzovWIcSP9DQO26Oq57IWFNfZPJUyxM7uKPCco7fSay98wAj3A+sYoyFlQUjwZInOJA1GHdMKOkBNCMAUtU6yzQkJHR/EvgW7qVSn0NG8RdVJ8vUgA3eGDovtnHlC6nzpUWFQqTT8hZ9h11ZGwnKrWUiqX2vw8ClP8ZZ7+HkCiWbl2ORMNt3erVgnqROgTwct2AdOQ2kiZHOp03oZtgtAG3BhXqdXVRbNWjTc/6f1+hlB+TxGUF5PFumReZdmdaZAbNz3l7d8EoqqoZp79HAle9zA7RVchMzKfEy/Z+5XxQJz8SHL/Z+I6DCtc6pBGo8kDGXmP1mV9whA95onuK8GC0CBjMt0n/say8zJd2Wp58FOpio5cpfhFWJhHSgd/Yn4QiI2HcQPTzY4of1ghpqeM8ytVLKtPaWvfhMYfkls7uAwzSM4N/u+MsTwwNO3TFPJWjugK4gZn2Eu2BQ7OyeNpPoLfuIPgYT18LGk0Xp9ydAsKfUFYaK2Ok/bFh7Akk1czhnyKVPJPfstLlxZBOv0iQr8wQGIyxM/iH0OfQv5/MpxbrKPuIaC+IgJ6ZJh0NHIxWOguVARun0t4KNb+3V3oda+3CXYPdoP9fMF7x9OZd2d04JEZZ3vUMag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199018)(107886003)(52536014)(4326008)(76116006)(64756008)(41300700001)(66946007)(66556008)(66446008)(8676002)(8936002)(6506007)(5660300002)(2906002)(122000001)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(66476007)(7696005)(26005)(71200400001)(54906003)(55016003)(316002)(110136005)(478600001)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Rt+qRC9od8ZAPB00pgNZrNzzShX3rClpOvPN5KxG/qBaHsAvaw2kn/xDpfR?=
 =?us-ascii?Q?080rhX51EH+H3KzLWIew1Wupru9heE8N/wHl8L/bzjUz3r/VXHausgC5RIrG?=
 =?us-ascii?Q?XV162coU5GkELDvAn6r9ycWOZpcptpSyXGvhuc1yp2ibT0DoFk9ZVMfL+1s1?=
 =?us-ascii?Q?y4Dvpq9G72iBQF3JT+5MzMKK7uCy28N0f87MH5HXYd+gX2hA0+e5OcuqeTRV?=
 =?us-ascii?Q?YWMaztQAc97X45jHLxAg4aiqa2mYriD3vCk5+1MGefoH4f0VXJyuwmqJC1/W?=
 =?us-ascii?Q?ocfWhhDtfAYfxhmv2KuvjmaEqI+s5sMiknJxH9pSZfOOMhKX2pwPqbE8+KBY?=
 =?us-ascii?Q?MffAf8F8cdPDjS6X/qwIE1rL4P7D2+f9aDLuvusSY7FgfVLA7aOpjI5YFelu?=
 =?us-ascii?Q?I8+oiNOQDFtL8wpIEYrE68hexBJGpZe2+9Y3NrRkdZPNQu0SrP/ODSwjNWeC?=
 =?us-ascii?Q?jxsdsSMQCn/eA3YGvzTrwWO9cAzzdq4dVnexvC8WQACHbwHBAx0W9tjlBBWU?=
 =?us-ascii?Q?XEK7PxoIyrTlks6N/wsd9ncfdD+m8e663b72f6xASNnKxPNQ7ZcwyYs+pKCF?=
 =?us-ascii?Q?Pg2W1NB4wPEzoSgS7wqAS75gLzVSEoj0Z26cDqiIPrUpsl+TfP8ed/ll15Cn?=
 =?us-ascii?Q?UfIWGQg1NLTWCT/GqpEdOtTpx6qKtvIGEYzDPfO2x4gjqshLfCtVwvMRvF/z?=
 =?us-ascii?Q?03lcHNhoEp2jVlI8MvWkwAs2vK+V6y8tbjCWpBilqqRfTK3xZChDrDyQEX77?=
 =?us-ascii?Q?TrNqAQbN63PDYzAmtJ2VjMONzzRTlIriAi6UmzZnXTRgmzPISC6LZrO4UQUa?=
 =?us-ascii?Q?/stpaEff1KJpLG07srM0SESes4RSt7M0U25HGgpBQCFLVqTXnfbmLCa9DJ6X?=
 =?us-ascii?Q?HBhiwg5t1hKecYewSM1gP7t9b+b7o21st3fzdvkKk9S8Q60Ww4OSXJl0+cOD?=
 =?us-ascii?Q?xcH/MFNPU+YkbcJFBcVdd/6m36WMYNm1oHaeg7SO9r36P/KLiUPTfiqQXPMB?=
 =?us-ascii?Q?jsvynYK1wFSfK9cCnZmyGlsiZdfDj1+qBioQEz0O9Cav+nuEh3a4yW5gIQue?=
 =?us-ascii?Q?L1T3GgLlhNCHhJcIeUVuiOCMie3F7lKXCHpLAHkBpU4oGHUoW5DdmwwhZMfO?=
 =?us-ascii?Q?IqbPDWViSmmfwOiXcOVGdLSODpxnuLeuZA3Munv71LJ7yr7gsYXjJYljGzRi?=
 =?us-ascii?Q?Pze7m6xNk9FUKSHHyhr6IbcgycwwV/spG3nMPp06Xx537NnFrNbjYIokMUBv?=
 =?us-ascii?Q?PxdQ9dvMNiPFYpJLseDne5oHzHCLoGe73y9W6SCcn4LYzZtahjZM0LpAGEk9?=
 =?us-ascii?Q?D4v+lk9XK9hQo+OKYtMENEeOy3AEdyZBPJIAi1shzVvejorsFBkxUU1clBFC?=
 =?us-ascii?Q?+AGJRFzdLFcoGHlgz0Xw3hVkrP2u8PTXuB44spw86CWynMeAyjmyV1IQaMR8?=
 =?us-ascii?Q?w8YKQiRpFsfX82mlUCz02IYybfZLWZSCngfJEqU/DsYnTjGZ+FOnpooxyKR5?=
 =?us-ascii?Q?iKIuef7P2SfUHei//Bg3FUS8r7bUuijHo750URiauwXbgG2RAi965jZxKRpR?=
 =?us-ascii?Q?Rl3KM966JA0GdLExuiX4avjipvZoE7/JeqOIWd3K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8937725d-73de-4528-5942-08db1ee7d4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:42:06.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pQoz6ILZeeK1f5CqmahEUJG0fqIEPoWY5ot7s+bOTvMVG30GN2gG1XsGs7Xe5Hc2OQOUnjSfXy7Zl3AYvZNTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
[...]
> The implementation is complicated because we have to introduce some
> per-iommu_group memory in iommufd and redo how we think about multi-
> device
> groups to be more explicit. This solves all the locking problems in the
> prior attempts.
>=20

Now think about the pasid case.

pasid attach is managed as a device operation today:
	iommu_attach_device_pasid()

Following it naturally we'll have a pasid array per iommufd_device to
track attached HWPT per pasid.

But internally there is only one pasid table per iommu group. i.e. same
story as RID attach that once dev1 replaces hwpt on pasid1 then it takes
effect on all other devices in the same group.

Then confusion comes. If we must have explicit group object in iommufd
to manage domain replacement per rid, then do we need the same
explicit mechanism e.g. tracking pasid attached hwpt in iommufd_group
instead of in iommufd_device? and have a iommu_attach_group_pasid() API.

In contrast if it's fine to continue managing pasid attach/replace per devi=
ce,
does it imply there is another way of solving it cleanly w/o explicit group
object in the rid case?

Thanks
Kevin
