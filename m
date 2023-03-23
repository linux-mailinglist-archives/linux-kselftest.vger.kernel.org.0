Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE26C6145
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCWIE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCWIE2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:04:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578F2BDE0;
        Thu, 23 Mar 2023 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558667; x=1711094667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LwcSMtFPcx5ugaauadHALxgKLYV1hecbxuo12bw08Vo=;
  b=nDnJEf52OGPYRp44nmENczyjXYNr2QJSFepYhpc5Ls1mbx68xla2ZbFd
   JVVT8lQ7MSomA3VCmgAFFWPFGsUi3LS0nUPaTDvNiUrGe9qhDrEYZyhV/
   NQhzTq7By/uDJ8B9Y6Pi9aQ5GmkjyewLIkNTCx94/A2RX+/2kEZGU0elt
   VpPgraRZJ5zmKsk7WTbKubUOK1cB/s5RPgce8waiJi6GNe/6Lpi4ptbmv
   sd23Li6eVNBW1bJD8Aa8v1lzwZKJQQBGkUN9/o4ZLocdaDTAod63Y9BsJ
   ClX0zT+9A8FFidl8k/TPWuztO/ZrZ3owML9urgMSOA439sVhH/HogVnMl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339458653"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="339458653"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="746620303"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="746620303"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2023 01:04:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:04:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:04:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:04:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGI6LcCZR0PdYJ4b32hS7Amx6scjE8GH5si1HMfLp0aoElJ/qHyYnAvOWps6IwG3wF2tJmBAhiyEWJpkuSqVFyfoRkXkrw/aGkM3APW2sSlCl4cjZWuKBycbnDN7cMv91PNX/Q+rRG3RJLAyKOGFaPsZaqROer9aye1y6ig/QLzB3DtkpJURwQ+26gNPZXFyz7qsW5S7WEpbpghNiIhM0dnKiqopNYaKx6UVBLGmW475O5QrKD5wksyuppXkdWjHE2bSNNVNheNkekDVLXlm/4TTgB4xemUjk/2MZ7cALY42O16N344PKiDOgwzu2DII+NR1THAgaulUBAtRFMAqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwcSMtFPcx5ugaauadHALxgKLYV1hecbxuo12bw08Vo=;
 b=V++kr3N7DFHqax/mY9Yv1XHMsT85rSlqYugbUungLetKF1DwQbxXu9GM6ZJ/LfOJVe5tmLszYP+8CPlXvm+sXG4pmQx3wRq6b8xm81UWwkeYiCjFTZ71NKtQDBSye5hV5Q2gOXG5SvQ1a3FyUUd/YIrzd8peRn9gBaSXvrvXlf2ycOyvwGMJZG18jx2OwBVS8Bhe3dyBKEi3i69QvRhVp5bXSM5uvDLQJRoMQ8JbyN4tTLpTmaNIgSP6Z1x27YHgaqLoHCZ/2oqA+VMxt45ED3djpFqdyIbwKCG8+apvmnVWXoGKp78/4pYzMaR3NCFEpt0J3WN66JLyECULr/c3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:04:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:04:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 00/17] Add iommufd physical device operations for
 replace and alloc hwpt
Thread-Topic: [PATCH v3 00/17] Add iommufd physical device operations for
 replace and alloc hwpt
Thread-Index: AQHZXCl697U9GkIK/0afOodbSFi/O68IA3/A
Date:   Thu, 23 Mar 2023 08:04:24 +0000
Message-ID: <BN9PR11MB5276539F11666AC861AC26E98C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: 96997ac4-bdbe-4aaa-1dcf-08db2b753767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JokBSubPRzb5us0LTxH8zuvzHCBXKUoGeki+Gk2OAOV/Y07fOW+wr1IsGds+ifki0pEba01oH72hZApWGrwrLWqRGlkXUKmb1Jm6ONRobnpTyG88pC38/ndmq+hKcfnxLHMt9Zxd3nnfWi5hDic6qP4hB68DR8s9SeZYk1bq9PyZFsGKBx0MmjlU3POcxq2UrnjEbFN654RJNQzUO6spiMAL27iC7NPVTbkJfqIbcwiXuQPYWEvtKX1B9C7H+v/2jYNTiGp9LBub0CHPThpt//6kvpIIKFX9whxnwML1OOPmJdvqOXws+2HGxLU0WG29RAjSN1xbyjm/CzHcXLJAKBmwM65+xHtXWzKh1O4CNzvfrHk9CSUtjp+Rkik2rBuw92ckMlq5NLu5i9krMab5ZIVjwbGvsoxmIKcxdlNlfXy6tdWwHRQeMrXSnOqcNRu+D/9kGTq75oTklSdFNZL3jk31ADJt96zfgvnfxRBdo+B7QdGZPWJfoPxg6gafdRXCfnKsCpJf9RagQLJ3Tk1BkVFUi14avkxGoPAMiG58PAPCnQjOf30PAcsPWpEWC1zwdu+UH2sJRGq52ryF42pGWMZnuPHeOHzSYNypEUhEFt5OHTfD9FaR2wzbKNrmxyvUpvaC1fXKvyg123qsAVYQtreolL2gXyQ2NMSMkY5HbUF+Ej8aIrHRHoOk2K/N9Xp2jiKzYyxazrGOH/5XEZ0Jzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199018)(55016003)(122000001)(82960400001)(38100700002)(186003)(9686003)(110136005)(54906003)(2906002)(316002)(83380400001)(41300700001)(86362001)(7696005)(66446008)(4326008)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(71200400001)(26005)(478600001)(33656002)(4744005)(6506007)(52536014)(8936002)(38070700005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OLdDd8O4y5NGE865dqrvtF1MFPVL4Rrpqo/5nN0ACI4H0M5odqxjhDdEmmIw?=
 =?us-ascii?Q?jbJWxvH9vmURFHzmnr5ZM8tQ89IkckMhqNv5fuGsixM0QbKJ88Cc0a+N7A2Y?=
 =?us-ascii?Q?ofEtgezEPJ9dKCR2P0HOlJaBlNUcu+9OrgGfjT1EDTjlikHGBsj8+ITuOmEn?=
 =?us-ascii?Q?RZ5DzpRQ/mNKz8/ehRud//OVXpgnOle8Uo4ZVq8Hpw1rrtJdY2kYiw+ZrbcL?=
 =?us-ascii?Q?u+7tPnwyItNpeNhTfslGIhewIx7T+j6PlcyxQVYo3a+Wh8baN+WIWygGGHSP?=
 =?us-ascii?Q?P3CbEVCl0LG8LqHgrp4prsOEERhAfbos4WmoZ/VLYALzki1m6Ls+Ls9L27b+?=
 =?us-ascii?Q?Oj7wlDzwTSIi5befUHdrvNQeSBn2TyGYz0ZYFowvJj9+emnGBjTvxpvdU2Wq?=
 =?us-ascii?Q?RNpsEv8H6HMVzY5Gk9iZN+PPE+tAIFj1esVIk8THBk8cgoohtpybD7bTs6Yi?=
 =?us-ascii?Q?pu2DnSZqAoG07pn6RZ2FzqnEw0CxpNOMzao3pfddlxj4H6ahkSXybD/DrquQ?=
 =?us-ascii?Q?nBFbWHluwFA4qoOg65o1Zn+9+jkYvNKmuUQGJ8bnkKUn8Wwh/nzBVYKhrV83?=
 =?us-ascii?Q?JuMZdVKlb91xU2MlM95a1SLZR+K1aACcuTUXYX3Apo3Djl2VZDMAIO2umq+P?=
 =?us-ascii?Q?sVG1/v4+zdQzvcygJ17NnJAaMziQJP51/LnRSKjzXygUuXdWktZMDHuw9GY4?=
 =?us-ascii?Q?M0UodHMOwoMjq7EZ1M5xBkVekPKp9WkrkzpeFeo4rmhApJHuWhRDUNzv1mgQ?=
 =?us-ascii?Q?fBuQ709VqZ4iykVIhjmLyAYb6DPC33fVsoxb6sjI73Ci067t6XAJsw7RW56n?=
 =?us-ascii?Q?5Em97FoWKYxgE/cZis3o7k53ZUGVHKAt8qXmOqok6PD8gYOoQJrSPWqzrGiS?=
 =?us-ascii?Q?1gNYhLifZg+yC46X1kZSzqrYcTO9CuSKn+LPlNTvqm1mS3Dw7nLFj0+PIXjH?=
 =?us-ascii?Q?/nOio4rQgEPdz87cZtvjaPwaeezQ76UziRhG1d4SMzg9Ow6BR5ggg7sAJF3S?=
 =?us-ascii?Q?wHC2wd0NJ0lJNgo6p2KRjFOOGAh7FQwJNEDrzFsA+DGPNPyigTOf3mNksoBV?=
 =?us-ascii?Q?MI5FXifYEdG3ewjYT+LGswuwK5rc7Q95TQUfgUpPbh/51Qq/O6Q2wUvYJYul?=
 =?us-ascii?Q?yLUwNKoUWKNYGuMquNwjXRQG/Zd/5S9dSb0dBaFc66ETM+xwsMHcGiarQF8K?=
 =?us-ascii?Q?r/PIe8cEJZ/QOUrcWQ1hh8ZR7iwtifUOym2yNzcFpfOzMtm91EkaJ8WIkbsC?=
 =?us-ascii?Q?rJuSfCtTMhO5JN94EL5OzMXHp33HaP8SvdQvu0wCqecp3WlbWXKKMXRMQlpq?=
 =?us-ascii?Q?kmb6+M1JnVLGkpCAdKNvHqmlkig3hgpUVaeBu3PYih0DkOvofvJqVB/eG0v+?=
 =?us-ascii?Q?aqA4nVhncHCkA9A0njEdv5eHXL+YoNf0RzQy/7aTfEjhMAJZGAy2PHOIkyJf?=
 =?us-ascii?Q?EdkfbwIuU5G0QyqCit8ch6xuILThbwqWVC6KCYLe4qMrAeQvD3M/JjuWn1UK?=
 =?us-ascii?Q?1dmQOYTV62oSK/+YRfWmrdZCO/NDjQCsNY1HSGPfCh6wxi/IvFarfmBdxYup?=
 =?us-ascii?Q?GoRNDe/f8Gy6Cw+oxNXqgElCUV+tQVtjclZL124Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96997ac4-bdbe-4aaa-1dcf-08db2b753767
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:04:24.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqjO0jE1NjB1ECVw0+99xCOZCKI7ySPtyaOWovbF6n+acwwtPpsZWdirBPyNJK3CCDTSVjwQMne2yxV2sIIsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
> The implementation is complicated because we have to introduce some
> per-iommu_group memory in iommufd and redo how we think about multi-
> device
> groups to be more explicit. This solves all the locking problems in the
> prior attempts.
>=20

By tracking groups explicitly should we also move DMA ownership claim
to be per group?
