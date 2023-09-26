Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2B7AE64F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 08:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjIZG4r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZG4q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 02:56:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F328E4;
        Mon, 25 Sep 2023 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695711400; x=1727247400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uobchIyFuk587UU48EaWQ+IZAC7JlcMLfBWWTDM2Oic=;
  b=CHfMCjyqjZO89zh41ki1jNH1FolGh5eCjkwwukrhWYH5IbLS0XWiZxMI
   EqpSQIePZSXCgB78NgYc+CG/jDnZ9McAk9XwizLJlVPXYFBEpFlBKS6Yo
   gyu117KssBuOR1Pvbqf1rvcGMKtpLJr0DhjtHkHkmhDuYj5ORh+DfChSt
   zNCdXzGWrrsteQ3OUjIPJSIzPXMlKroulJZaYPpiHMwS99NXvTXnLLwQe
   16U8SCFI0YTa774sw2dOASyhtLETvULOfixaTstgVhlVoaFOZRvRhSg8Z
   rXi3yJZLLsCFaPsSrpb8wKllTvmwd8d67Lpt9hLT8EwxU9cAG6zR51xcb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360879309"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360879309"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892097080"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892097080"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 23:55:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:56:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:56:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD7GmX98Z1EX0rDacj60L6nFYZbOM5k5HJnu6/anjJ7lYgCuTX5NYtI7ugbEiHYU+Nl2iMLDELqtrPrzjJNAAPjYlF1DlSODdO+KKEoITxOzZNHHRBVL4EPdCTuaWX67sqYt+yTx4lacLUn6nOMtfiDeOMl37+8yURfyDo+VtJ7rv+baiPDGYXi0mYZ9YhXevx4h8pLa5yHFi6SH5VYpuggR6xbD9Zy/wHvYBOkcOxyQiINX4x5Lj/iKz7qSZJIXGYdXO8z7w04pEACMhmH3ElqClU1uHwiuWM1FphruFYqrIDp6jgsSaDKoDyFdbsMnv6PO2lkNThluLRFzeSpoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO67U1E90KbBqyeg7+jeEbneJGwDlhfXd6ZL0xEn828=;
 b=ScfiEDpw7X/px2pVmrYEr4X0TCfz0tk8d7IWNgZe3LfDOl9GE+b/C1wI2Hz13NwCtZIsbv5Pga8tIx6mGI2GJ5Xoj3v/sCSYhQhm+uDomApTI/7OiAk9BwmKYumIrISl3r2lnl5RW05WS5po3x2x7ChWww+YE6gMLPumtKXAnkKoT1Y05lfcLSCrYvkbpediRLxJyS9BlWosqX2hvKT/uoKDUrrWbeMZHoFvhx9OR83jvULxFJzVYIXb5/+gUZGUHcDdmEE5XwzjAiPVihKRz57UQlYt4K5jN8YTxXTlC31Zvwxwe5p9PsKKLnOL7DmqPEBAwBBsA+0aJ7Euvvzk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 06:56:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 06:56:34 +0000
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
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: RE: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Topic: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Index: AQHZ7GCQqMA2D6hFIkG8of68DC8uNLAss+nA
Date:   Tue, 26 Sep 2023 06:56:33 +0000
Message-ID: <BN9PR11MB52767E1B944C0B2F0667D5DE8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
In-Reply-To: <20230921075138.124099-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7727:EE_
x-ms-office365-filtering-correlation-id: a5258b38-807c-4558-1830-08dbbe5db882
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZH2NrNs+eCUOy0TwnjemBRCV2rFLvxm8bLhAbCAjXU8AxJgce6x4JGZtxxHJn3XpjCCbKmemt1DpHyXzJWyPn+8HG/0VyQBQ/h6gEFmCYPJN/AsOdTXvzGVzB/XCTDqGm6pM1/CpJsDBgZF7ski40xUGrr7DJVKRmfHF9B4eAHVreZ1J9AnkDdo2EjYF/xnE/jph3QzaVSDle+XlZe58yUKMHgj7+q6TDso8ePX6QFYCt8nkLh0gKvV48V3ovqQsTdchrjeQGvTwzRyF2h5pzznaW0tJXxRLGrgBJyNzgCjIiKh4I5lT7qoFMqaXFH9DNP/hlE64P0ewf6aoiFHxd0+2J8BYPXDS2+RVHDV8H+03yqLk3bpWbcNAeHWilDO1WjTlq9NfJRe1ux/u759e+IMyZYeadsvUn/uq5yxS75fQBn0oQQw4uTkoGrKr5QRuKaem/RAtaNZVtvForXZwGOJgqStINzArH+Ajux8OYFSZq/HYUzRmSHcmrN+9Q3j8D3JqR2pnOLe4OZjYBbRTD1LbeHVTv+O2Wu684UIC2RY0HPTQSn1bis9G03PVg5mD6nMAVEjGUK55Wbf3RwHl8q1/GbhUtIU1UdZdurUr+EwGEyMgen2TdpzzWeJjDcZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(76116006)(38100700002)(9686003)(54906003)(4744005)(316002)(8936002)(41300700001)(6506007)(2906002)(52536014)(55016003)(5660300002)(7416002)(64756008)(4326008)(33656002)(8676002)(71200400001)(478600001)(110136005)(38070700005)(66446008)(82960400001)(122000001)(66556008)(26005)(7696005)(86362001)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/btOpIEAC8H+YL7YJdhNRHU/H0W+xOrv0ALBTg9LWVJPxs41gJWD0oqTxqSX?=
 =?us-ascii?Q?++V9QQNOb1p9VW1E/7tPnM1VcufQts6E1YgAt9bwNoSOTCStKpdgs6mENzF7?=
 =?us-ascii?Q?2VvfGovQKQg8Einei61JA5F6fZnkJUgzopOI2ltxeBGUqSOhFM3PSqvUdP9Q?=
 =?us-ascii?Q?1DShCA7iCohlhrH+WfGCBS2OYu+F9wg7t4ahzM71uVQKaqoHl4HrnlveuYuD?=
 =?us-ascii?Q?zYMwUt8Trzp+fOMjZpfWr1+AjqcNqB5umMbwFjfQBYIEEJHq5mo4FLMWBL9p?=
 =?us-ascii?Q?jm4qtHX3H0DvQWmMdADYIoWS0kyrdppXaD8RSsJ0eWxdnG1FLYjqFP248qyn?=
 =?us-ascii?Q?QxOKjIFDnqd1hSE2si5Fox3uWRaSPVtHK+rTbkF4mniL7etqj8rS4aADmlbR?=
 =?us-ascii?Q?tYr29T+1tbEUgtUHY90cJaKOqnY53Z0B/LMFybDVwJ3X0LwSA+pVG1K1WPNE?=
 =?us-ascii?Q?y51AAKjtm4J4Rwa+FnuBaUv8oTKKn9hBs3hA3DZcMRmWUgeXPP0Tp+Z2dJw2?=
 =?us-ascii?Q?/sEH7XYJZ650JLubCV08Iu1p/63lxVgx80dhuSycVj8qkU2/Mp4+nFmU3cCb?=
 =?us-ascii?Q?xQmuH5JZ6aO+Mw+pnV3bft3eCyWWZFg3hIHZ/VnFrX9Yyask67P/m9pl6uuo?=
 =?us-ascii?Q?9s2/rVLIT3s/T5vsYfJrulkwtGFBdJKgIXd9LWF8cqDgAMsi06QtjCzgQHEY?=
 =?us-ascii?Q?5RYhoNID9PzySCcyHYYFf8hqJmenTqE5m4X3SjkAOU9hi2w+0TYm1Wgp1G9E?=
 =?us-ascii?Q?Ed3fW8VF8wPCljNDqhzuNSKLR/YAIs/S4PXIqw6U+caBO8Zj5zd/spr6sC40?=
 =?us-ascii?Q?EFk4jxgiUkFLR+/3ut8kLmF7Jg1Zo7gXvI8T9azbDJ3KdCD1Th0fcNMKHsbk?=
 =?us-ascii?Q?GHuViH/SVA9nLC44bxxmjxxah9aTCA+/qdekFl4JPmcw5uBS/Z0uwAhzAExg?=
 =?us-ascii?Q?UShY34NZf+0Ed51yIlWxaJ3mRNNlc2WN26lzs8DPPhzkouGJIES292IdEku+?=
 =?us-ascii?Q?W96PpwQ+0iHsHifvOrEyHjffqMduLMUjSVkyQdMdS2SMM9nI63dtqsbWKPTE?=
 =?us-ascii?Q?WfeeuTmVZ0C3OlsC4fSmJ+HqrOFWMkMRGl5ykXmT9iBWPSGXyKu4sbaMBXJ3?=
 =?us-ascii?Q?BZ7/qr/2zX+L5/raT0Lqf8dVYs04kf+j2BtM8VfsHgYOfXP7QPy+S7DZTh9d?=
 =?us-ascii?Q?xJpcEkh52vMvl6mLuiXnYS8tTtXtnFvau4kjb6OhIBoDg+jXzXbsydD+fiyJ?=
 =?us-ascii?Q?VoT7annZoZrzKcU5GZ9Ze+3wHQK7PpJ2awZ2YrWNAinauFTYfI4VgdsvgRQU?=
 =?us-ascii?Q?ioK8xEmWUIqL9QwQuOEpMUf+muXym/swUg0DAO8PP5UkbtJUXwOMV5XNTUax?=
 =?us-ascii?Q?ubmy5Q7EJj9i+t6xecBgzv/DNx8SHwROh1ZU+owUy7bz8n/XXoBiX4Vev14I?=
 =?us-ascii?Q?H9r4t3pMuOMxnHlET8VunPkzsYgRaSy+2A5D8M9QLvO7d9v3avNyGrySaDMD?=
 =?us-ascii?Q?Q/GfIGiuKA0l0x/AhdGGmNwz2Y73ZwMDIo2DitF8NBGVNaITAXr7O43+0kSK?=
 =?us-ascii?Q?5ZGl0BjXZ3bhARLUoptw5SYoGlAQN4STx2ESENDW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5258b38-807c-4558-1830-08dbbe5db882
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:56:33.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ee+PROxNZbfAzt4gvFraSgiPbIWvxuNpM7inn7LVdV35MH8M3CT3eI9Js0H/psvaFmFqRIAGVQCzHeiexq05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:51 PM
> +
> +/**
> + * iommu_copy_user_data - Copy iommu driver specific user space data
> + * @dst_data: Pointer to an iommu driver specific user data that is defi=
ned
> in
> + *            include/uapi/linux/iommufd.h
> + * @src_data: Pointer to a struct iommu_user_data for user space data in=
fo
> + * @data_len: Length of current user data structure, i.e. sizeof(struct =
_dst)
> + * @min_len: Initial length of user data structure for backward compatib=
ility.
> + *           This should be offsetofend using the last member in the use=
r data
> + *           struct that was initially added to include/uapi/linux/iommu=
fd.h
> + */
> +static inline int iommu_copy_user_data(void *dst_data,
> +				       const struct iommu_user_data *src_data,
> +				       size_t data_len, size_t min_len)

iommu_copy_struct_from_user()?

btw given the confusion raised on how this would be used is it clearer
to move it to the patch together with the 1st user?
