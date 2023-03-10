Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A6B3C91
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCJKn1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCJKnZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:43:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70893CF;
        Fri, 10 Mar 2023 02:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678444984; x=1709980984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/3j3+EJzpYiGNlkkYM7mFY4U0pkIfXDNugOkd7l22s=;
  b=Q9zLGKwlOYzkNnd15GWWVNyPxT2he8jPYQnBHT2wSPAp54qvpUdaqD4m
   wart2GLVgSikPHbqUx3TyTuNsWNrSYtBAHtArZWsGUfIalIzxHki8kaMr
   RrmalG1LJkHrn2uRIoIVSmupIMoV7cSJ+dNUAgB0sT9KD3utQgnixqnUU
   ZgRVawJ7ZNp9PYefFdwzGmfOO95ZwQZLJEugk26eHKhmVRXlFcJinWC4j
   obCK4KO9qpEEFAOBKg153PTbRXAbPs5isGkCFobB7J3moCktjgA6hOmhT
   c5DUpdlntqLIpFHPAu3625vXZd+8wBfoHmyZJ49zCExvv3QK67XOmoMhl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320553719"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="320553719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801536802"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801536802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2023 02:42:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:42:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:42:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:42:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXsTHcz0r7COr8rsZmAHGck5xCSbNI7VGbUrUs7HBFng3RL2iGXlJsF55txhak1HwvhOcIxs16+IVEtDJRXzUCAZYZxT+0tsl7i4/BpaPuNrCdzYsT7gI6kGmJejUgQy0HbCqIunJIPO+N2oR7IWfsrgEot/JjX5g7kKF29WyoS+TO+19QvhYlhhsWwgYy+JxigoMHw+Cj3SpIyqU+A9qIUc/7GkfoU5e1NIWkTIX3ZKV3GDpzxZDTUUB65tISQ66g6KKDcqMbZpkGV76lcmMqm4H0drmG4O2moRWLdHwamDcxGE/osaFyf/2vgPuwhJcbC3thbb81pE0iwHnPcp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/3j3+EJzpYiGNlkkYM7mFY4U0pkIfXDNugOkd7l22s=;
 b=kECVMJYZXu+x9v5K7LfTEZQ2rfdome7z1tzoCtkObcU+Rp8cNU2yzR1CYjk0IR5opU6r29ic4KhW6H0s/NOPRw5TqEKyvTfPwrIIc5yuLVlZUvgOzi6QV8YpIO7PO+1/+r5mL6Xd8Bu3V2kw+utNrCJI9xaMJgNcpxCbMlVBMD+Ui7LrTDU0k997VYDe6m4L698jBRUwCGnXbH0EVQqZe+5cl/SLBgLODKaYJSoHyRG7JkVWPvnOWZXie77AeVroxxMsiTV2CrgsonOAM+pbUWOiuLzNJZwQAt+9DactSjk6jX2bvFXIeN5zQ56AsESlj7eh2GhrkuIEqt6tif+pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 10:42:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:42:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 06/17] iommufd: Use the iommufd_group to avoid
 duplicate MSI setup
Thread-Topic: [PATCH v2 06/17] iommufd: Use the iommufd_group to avoid
 duplicate MSI setup
Thread-Index: AQHZUVYG0gZ7qTB350K2NPv20TTy5a7z11Zg
Date:   Fri, 10 Mar 2023 10:42:56 +0000
Message-ID: <BN9PR11MB52763331804CF970E61D174A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <6-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <6-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6745:EE_
x-ms-office365-filtering-correlation-id: a2e452fb-94d9-4969-95d0-08db215435dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8A6YZ5bKMLhrYqvpxJbWGU7siuu8DZmEwfsQxKliOKtpe48EV30rlrbIshUt05DDBU10yQUIOeBtKtQ1/qrB3VTb256wjwW/+ggPGloLlLaGH4sJn/++PUbFAaHVJDm0AhsQ6DZ6wW3nq3DizeaDdDDii8IvglWvMUNOdo2GWQa0OtjUEMk9blNu8kJ2nKVRHcFV0jzfqKppXOitzyaBDbvpCOH97T0FJD94jmh/rnEqnl6Q8thTgfCgt190ItqV9d8uPjZqLHT1TULrNHSic2/EHKkJ8Seu5dMc6aXGRy9vpXBobOlPKbAYwXK0pewvQHUHnVHCPG+FhPDEPykmElfdnZP1kJlNfF/fvq5a3nHBLJyVMW99IZ5qO0hqrb8n09TAxgAe+oFQT5yiJl7WyW2zmSUOA/Al7aLlKQduDIonwVyzdmIA5VhLcj5Sm0UsmQ+rdkKcwLNmvz8PxigE7jyunu+YPxSVTrlyDkho0dEG7veiiiFJkJR76QnWXh4YqUhbawTp/16Untm2VUM8SWA+sNhJTYkFVQnKvDgQPGwWzY+2nJP8hQ3nILhrC+n8NyOg3qRO3GZOqE4G6j2QKbQWx5NeOGtwGiPeYpb2LC5AqbZChPCfEZTgqwz2cPFSpbCoD+gsTQFpWLq+zktQxpOUnTE+VaZXVkhnggztU2s16QKVVpnG0WxASXh0+0hEs4UZzjeeUcTcl6erIvzyiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199018)(8936002)(4744005)(52536014)(9686003)(5660300002)(26005)(66946007)(6506007)(38100700002)(107886003)(82960400001)(122000001)(186003)(55016003)(41300700001)(86362001)(66556008)(4326008)(110136005)(64756008)(316002)(8676002)(66476007)(33656002)(66446008)(54906003)(71200400001)(7696005)(478600001)(38070700005)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3A0Dpo54ln58qMaMwQGwJg/G2geRkCWqJm7o4GipD/x3up1IJ6ygC+qseQ5g?=
 =?us-ascii?Q?cNN1W6o2bveuAtjwo4zm5bPt4j36IRAMSsyhXAPlCW1l966ENv/qCxcVXQk9?=
 =?us-ascii?Q?DlrG1L/iBK6o/iTBIligqEeNGu9Ffz6J7qCwsduUqnQWhRsQoPANLNfiwCOX?=
 =?us-ascii?Q?GswjbqdF3St/F8qZz5SQhxb1ywfDkTFfsb9Faev03SyNiEcj/8Sd5mXmxEG8?=
 =?us-ascii?Q?79Nbf1G0kyVIxWFdXzT66H4NC+d7Es1zkZ+o1Jf0xIPGZpvsxdkev04LMNbb?=
 =?us-ascii?Q?tnaHJKzx6bTLJY9tZmeNIEPsN5UBxFiFVugtnwP2W+LpzbPB23ZNKCPfD17V?=
 =?us-ascii?Q?xUt9MtRB4tUh8Yke/rX3kcP62/e5Q81BYLE/DfTiWgwGy2TWyb6T+hzu0XbD?=
 =?us-ascii?Q?k44PGu0qFlrNWNCfEjfAebHUmjpGoXmnG3KDeqU8NTOuGmgBRpxCsc2oFSUs?=
 =?us-ascii?Q?zKjkdy5cpRwQnAYnPetj5Py7If+m7impbL4Ixo8MGZddUexd6Bh6VO421tfD?=
 =?us-ascii?Q?xLt21ewuWWZ6T9IudtmtykmLUsdju7aiynQvfG7xHMRyvaI4+9xokLu0iSTs?=
 =?us-ascii?Q?hiCzem1Hj9eM70Jpz+EIFI51+6rqntUNtuzp7tMF62ZUoSDjFY0ESyIgHA+b?=
 =?us-ascii?Q?ngv5IL6P7zZNVdL9NOP6D/TUi8n/jZcEQgQ9SGHb+tIL1RbYOxYWS8BB6AWv?=
 =?us-ascii?Q?2kxhXnqzoa46qNfGnv9AmfNW3UOssIer8vT3gVXSY3sMGnbIJ9BuHYU9JziN?=
 =?us-ascii?Q?5Bar7ngTmfqV18h2ZFeVkjmBBH1yJKFeWwq8ywMvkj31rFfNW0ML/Awt4TiY?=
 =?us-ascii?Q?Z/Rf6vIv4U/IBRAgXfAdi0BnRENeOLD3ZKsxdcqNymUeg2jLQ+sZgdQCU1GM?=
 =?us-ascii?Q?SzZ/MAPdKhrHJk4Ys9i6G2fGijiZpnku4Cv3tEj4VPpSIQadraIn9yNv7WLZ?=
 =?us-ascii?Q?3smI0tDDQ7N2Ka7Cf+0U6dKZhVotoRxhv4swF1jAkKoCkwYtSgYGTPFoQqh+?=
 =?us-ascii?Q?zhqesg3hkQVGhRPh3xZI7sjZUhu4E5P2MTCVRzs+wKm6bADt9gAP7m5MYJno?=
 =?us-ascii?Q?ARbtwEEL+OwtYM5io6bIey5cQxVrAxJRHDwa09mWLy/3ZmcdoJeyNygqobiB?=
 =?us-ascii?Q?xdMRL78bhUtTDvj7uzmJg2CL5IBpBUc+wh0AL/Jew2yGO6Z7hiwLitsF/sqN?=
 =?us-ascii?Q?+f7DSLSP00XiDpz1RqbI6UiRlNzGT6o7Nx97SW30rtuYC9qbEII0wid5ZlSa?=
 =?us-ascii?Q?wYUKdq92ePTiEhlP6BbjazjZbnOchx3Rc33g83C0Hkg5xtoXkDyHsxqgczdM?=
 =?us-ascii?Q?zOUSSUqm88Ea4tOpp+kXRvXuQffux1W8VkzPCNTwn9Y4K4e15QV23RA2O5Db?=
 =?us-ascii?Q?fkN8VMLlUfup4OqGDIoLZI3kQu/Gj2O/pG0J2hEYg+cxcXUlpKaGZ05JLlYb?=
 =?us-ascii?Q?R/xeiNmTQ6elBb/D4TYPuGa2s7mH8EWI2QO3/q9SO12x/QD7sZszZziIXuDP?=
 =?us-ascii?Q?7qy9AossmyDaoIodfH/yta8hAEk+n/KM4QgiPOhVE848a9+EOf9dpV4LyYVL?=
 =?us-ascii?Q?LZpkD7/SFKjvj2oRl1TSuNZMpIXw19nRNGAmdGfm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e452fb-94d9-4969-95d0-08db215435dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:42:56.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfAV6q8X5AHetEOLDEtBhkMCNplo8lrwovLOuDY57LsGn7bG4MvAqNbvMrwiGD2jZqD0+m94jWnemq01jUHAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> This only needs to be done once per group, not once per device. The once
> per device was a way to make the device list work. Since we are abandonin=
g
> this we can optimize things a bit.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
