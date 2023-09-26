Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E07AE734
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 09:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjIZH6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZH6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 03:58:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E711DC;
        Tue, 26 Sep 2023 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715075; x=1727251075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4cpDI+VinWvXF1l6Ag9PnpwPqM2Z8sguLrCrpP/knxw=;
  b=VlDV2NaD+zyZL77n7GOGgyERbNIIbVK3piL1sQxJY7vxdUJD7m7nxc3V
   quHaIuAlfkR09jvKvwZujDoFPinK3OBxj0i7e65osGb0oeq1q7y9FZxCu
   OI2kZ+4+2APdY40XHcCISTna0dLjc/SeXQ1zUISsBNefgdHOk0dWz5l2L
   q4ClywSLccbjv7I3mDDJiRJWpF7YUX7P5agG1+vnNPdjvGUK1iPunNRV/
   WsOL0U3oHDdycbqsSN2xIpjLGsduzCH6Bp3SUkktg5yaF+dfKdNO4f9Zb
   UmWOxqyXEDXPNN7URIfP8QFyFx7NS8AnCHay6EJJuLJP4/JdJtvP+VQH7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360889479"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360889479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 00:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="752070033"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="752070033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 00:57:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 00:57:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 00:57:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 00:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9FO4apet5NQbp5TX8zMCfTiT2IeA6ZCJCmAKzzo8IaQZMREzfpRXqkCcJoFJ12ikRp4KZF3SOI/JH7RHpKEZ/1L3+kZrr2XHez/hGZa0WkJZlLngOfaxj34JMCKc2fsp3uvkRftmVlV0GFk9ASNYjBw+3spBw+pWdbYCatzcq4tAK2/qNM4inuEPr/HB79OJfltVn+1tQdeO8rNuHhLTjidbQLgttM09NVTmZVHPXdm1H0SvL6YDyvUM0Kz/HzIaxUzUQucLUJcBs5mNdzbwU6M80NeFoVR+1An7HlEb5JMm4aH8oQPErOfxxUv5sJTukc7sw2xOmwdbReuNJBZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cpDI+VinWvXF1l6Ag9PnpwPqM2Z8sguLrCrpP/knxw=;
 b=CB1a4YqupruygaKzCvhhQZC6EDIFe57/VuynmBf8ZK5mlUvZWE8tsem64gUsyCpn+oSh4/USL825mm4y6h3BiHAj1KwCa7iM6ZyBSBbBjK7D29qXcfVk0YkDEDs19VL2/oUIhtamz7UvxSvQlcCabsGkdb6FBged7l5GvQCtmPazGj+PUxraXpN7LMx96DisYOSRfGrAM0SMP9dCBJ5QfjWaDWDPNeYIzLLaa3bGxpSZMd9TQGIYjTnIwtF4Krk7uBEskV0s4/29Euen8EX0pZMlotV/n17RonfAPXmUdmuDf53yrDlj+wfj28F/xjDorQP/F/K38dDhmSodKH9MsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Tue, 26 Sep
 2023 07:57:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 07:57:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Topic: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Index: AQHZ7GCN3k0pHsaUpUaqL7OxTm+gurAsxMbA
Date:   Tue, 26 Sep 2023 07:57:49 +0000
Message-ID: <BN9PR11MB52762F3A9537A6E48E454BBF8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
In-Reply-To: <20230921075138.124099-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8579:EE_
x-ms-office365-filtering-correlation-id: 76cf931e-dcf8-4964-c8be-08dbbe66477b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UJyZUXZs0iDott2QV8Ek/56g4FNcwDICBb9azezYtjm2EYQ9qXWajGSf4ELNqMR2ohgYsa5HZsNHlau5vVlacpz5hF9bG3EdUbuFrPhDJvrzUXppiU27RhA/739ZGpwQDI+qfqHkkhrizwc7GiBm16kkTOIsuo858OETyw+USdiQZ4O88m/KyZxbWvT9sqjsMq+AJ6LYCcU7LV80g416ImJ9v+Tzvo4ZmtnsBRxDqlOmaIWqwJyFiyPGJljvV5syJaNkTme+rTOqBlSFJZT5GowH5wWRb4mmbTfND0KbFIAnbBxkmeH5UPoFZ6GAPEjBvl8Nw+PBSxDlk5MiiOv28cQ2cKUM+T0TsOvV/2/x6SHEnAuFjlt6fMzsYx/3hYWufNl/9ErX11lqLZm1W2SnQ9zcLg/Qi4mom7Z7qoqlid8RNKj3p0MyAt9K2xMHrtqXhWRsfxGlH+3on6wWKiJrlBcWC+NtjdUAI4be/vRmcjBxiZSI+lGNVm98eUyP3jRyd491xKFh0B3w0gEDX2UqFYUvilQJdrEkRvvJAx2+ByfxdUHFIB/yKyVYki5zY0X5Kij5j0sUKOvJSUWiEBvxNSgSIgE7YNVQfT93GJFgRi/H584rkv7eDAC8H7RaT2U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(122000001)(26005)(71200400001)(478600001)(86362001)(82960400001)(38070700005)(33656002)(5660300002)(55016003)(7696005)(6506007)(38100700002)(9686003)(2906002)(4326008)(8676002)(54906003)(316002)(41300700001)(110136005)(66556008)(76116006)(66946007)(66476007)(66446008)(7416002)(64756008)(8936002)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vAqb7Epx6JhUxRZy5JGTdNafq+Afjz/UpZYEErpRMChPqTNGyL6FK4UrBkn?=
 =?us-ascii?Q?1r0Ubvd007hCKKa04ZvTc9SMRzaPjKVFCsFfqto59nz6DdHI2NhviXTZujTB?=
 =?us-ascii?Q?VIGinhqtgWKeUbSeK4Rhm6z6cpZSPGp+ImERDDifq/ZUc0Et53WKeE8FAWFf?=
 =?us-ascii?Q?vI04DIZ7bCnl6xxUwIDOzNSC3Y6DzvJdxstGCQzRJlLSijqzWEAEp0Nqxyos?=
 =?us-ascii?Q?4uBKhs8eAYFJRTukpnb7yDkCm3eseM81FAOBzHxWePpfVjzj8U5jrFm3KHoB?=
 =?us-ascii?Q?K/Gus3kKn3Kl/PzgkkFU8Cm89yGrzc8on9WWPfyGq3dpbdBte13X6wMRtBip?=
 =?us-ascii?Q?+KH2Ryeu1FzrBWqwRYy2Agcd0FJw1pQle6YxygA6omRW5WhBy534jZdFmJXd?=
 =?us-ascii?Q?NxDBcPxI/nGA1iRa/nwbooLbDv81g6GT9uaBk69gYsCHKytWR3BwaP/aTv+C?=
 =?us-ascii?Q?rJRhWbwIZVocA8RL+eVw9ILgsFEKUIsnV+6++z1uUq/m7cqp1SNpgrNbW0dv?=
 =?us-ascii?Q?YGMYUXwKTAAbqjJq81qhl5oi9BUOhzZU+htLISB2h/d3wl4LkqNtRIFr6Ili?=
 =?us-ascii?Q?JE5gu1xIXfjGWx9KzqGFJZP5enYU2k1i5k83W1+PjoRzCnTVDUIjBC/Tm9sf?=
 =?us-ascii?Q?6G1unpoh289Kkn/addz5gnP8fwZRGa9zfRmAEiQTbM1ZsHT+R799jkwA7UHL?=
 =?us-ascii?Q?9g91mocSh7gxqPlLNWzimv4Bsc0Gf1cYad81gymeQrk0K4mUHwhrS6Zp8Rw5?=
 =?us-ascii?Q?37JmeVnb9xXtUR+IwExmTkJQQK+xe1iRm6JJNXkUS3JRqHziFetdsVHK+9Hg?=
 =?us-ascii?Q?/St+Q/tQAbzgtl5Zf+nfOs6NVNFnf+BJD7LedHtE4j+hnzaLNZ6WuhtpdZkB?=
 =?us-ascii?Q?lxwOI7HqPQrnk9AnVKMW+MrpE6jhiMmE6/EvLd9Xyl1g2+YHAfCnZOqXW4fO?=
 =?us-ascii?Q?oeWREFdyMDDaHYc8mWBC3nHiCUc8j64TxZwEs1FNVQu+8imw3M2TWtXzR4Oq?=
 =?us-ascii?Q?ja3OejVwBOweY/cSZx412e8jIaHoDp8i4yMQIAuGVHQeDDywlncloUD8RhX5?=
 =?us-ascii?Q?BSRwBKMA0AZdqMaeygc5+RWsTZyAp+t7dPJLNXtE3kcCTFCqO+GKdVF8ZfAJ?=
 =?us-ascii?Q?p8xwUBnh1XMkLbQ4JhgA31R/bgcjmCF0QWv01JVWuYl6PkmUfnI1o3wzysmt?=
 =?us-ascii?Q?RE9jPerh+O1AkeIh1Bpx8ZreyFMaar7x+RrJ3Jffn0abzCGL7PNVzZkb1kju?=
 =?us-ascii?Q?cXU44XGZZmBaM8F8N1rPd0DQtxpCF/YZZQLOsoYtF7Nk695zKUOA7J1C7XOT?=
 =?us-ascii?Q?p4fKrDzzG8h1w2DmshKtyY4fk5N69gw1tt8x1YrgYqsUy37fYmQcQ6yL4ZVq?=
 =?us-ascii?Q?dLuZOxS4v52liW/Cn/D6HYUu1lpzn7p9EkMLHoxJWIdA2XD+QVk32f/swMXs?=
 =?us-ascii?Q?5M3yMnGP/f/Az6D38tSqWEUceqc/3tDfjDcPWGT8YLvLiOYgdWAKX/RsdFwn?=
 =?us-ascii?Q?Pzz+i2XF33nEXso3tbitj5PNxpEV3Hp4UEyg54L6knDybz1Bg+hxDQBBdUyR?=
 =?us-ascii?Q?xrVgwCLNXh1LRezvQPHZWyRK0Epttj+CkBzqE+BA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf931e-dcf8-4964-c8be-08dbbe66477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:57:49.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMGIIszf6DJXZPcUmUdvNw1jUCQAl/1oDzOyBr/3YJwAZWixhxQ4TV6x6dvp7Dx0D6UztlT5FBdGqw2PB0YtVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:51 PM
>=20
> -void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
> +static void iommufd_kernel_managed_hwpt_destroy(struct
> iommufd_object *obj)

'_managed_' could be removed. 'kernel_hwpt' and 'user_hwpt' are
clear enough.

ditto for all other related functions.

