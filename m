Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9F6A16C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 07:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjBXGvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 01:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBXGvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 01:51:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C856794
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 22:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677221460; x=1708757460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oMKSA6RQ368M0Bt13WalEocrFCQ92Rw64G3JIRzlqU0=;
  b=DyCyWniwhKA9qUExAf5xCZxEVuIcvySQkKoBHc4GxcPtM2xpxW9nVG3w
   DRM5NuLmV4Rv+cvvJRzwpvzX8Yik+QdFVekkmDfDqPx7TAAGksqNrO4UL
   x+5/OTO6CLXOgF5vs0lswbv2nHU4lF6Oa4zi1/NNy8DHbXePtF7gDWrbP
   KrOm1jpR6N7NCHGHx8oaBvbtnYwyGxCNt50CYGtCGB0OW5YJVrFAWtU6s
   xO7HxUJjGqOxjZoY7hPMwpqTPWLHivp9NSCcFlIRMjIiWr0DNqd3g5YmF
   JjgKUZD+db2FXKQAT9jcx7p8qT4MJwtivZjnAKXiXKIM09IMHUg0NlBHp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="395920601"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="395920601"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918325028"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918325028"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 22:50:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:50:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:50:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 22:50:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 22:50:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjgt+InloH4ienusUPAuDRwf+oQ/LnxTcD2fSoNNhDKbORBEezpAezXisVE3wy0HADg6esUUWbI3Yc8X6/KAic7oMWh9usVvqNWLePJMHdziORrLn5pZkvqFQvZDoR3JNImgdCIvU9PRrEureaUoGabmNmr7D5f9TnxsITpfEClLb5Vm8+A+bCJDW4mPynQAJqYYIpGnhQQ1Bs7JwVoEefek/9UeGXv7hiuqU4x1CiT/76QSTMhEs4KdMzIaVmrzYDpkgJosOxOzbLIIRFktQtEof4VIMklLzj12b1yzMGlJR22DieYIB1D7Ny/TFMzjHhRHCVQQU0y06WXdAuVDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mID4Bktnb1wYjMd8kiPMPZ/HCU7KlA09N+Z75fkeSTg=;
 b=ggfBN89fAdUHaZ9UhckkgqlLeKteJ0Ss834l5X2U0tWlv/XIz5O9rldVNOlXN55pRuNu2CQxIIZiBWvuYyCCPoad+F5GsasTnXQclkDCmTFsZ+WYc6zYGSLYVTzAhtyTTTh30MN0VhSgzA6r3ftEsxmAoVpd8GMeZRBM4m20cdMIs3+unCBhi/NUf7anfubJGMqRvFcrd7ArPFHk1/N3pjcu5b7eBiLZUWx9bG3O8/yVQvnWsBkPPSDdLMoYS8NgTawQAx7SdgnR5wdryOeYYlYCyOM4bdV11nqFoFUpVq7Gxaj93mdI3EVXeNsgljwD4r5JPua1Po4ct5H5Ngleyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 06:50:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 06:50:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 6/7] iommufd/selftest: Make selftest create a more
 complete mock device
Thread-Topic: [PATCH v2 6/7] iommufd/selftest: Make selftest create a more
 complete mock device
Thread-Index: AQHZRwERzGSsZ5jNi0qdnN/0SmHgha7dpllw
Date:   Fri, 24 Feb 2023 06:50:43 +0000
Message-ID: <BN9PR11MB527674E485D533D57A9965888CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <6-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <6-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5272:EE_
x-ms-office365-filtering-correlation-id: 0d97c6f9-42b7-4b0e-bf78-08db1633732b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Th9I8tl8HjwCWJ0bWhStqxomtNSfl6jTCERuecjceiVD8VggncZZm56Ez/9qKqC0D54I3AXLFaWH6MeLy3/yXIDqWCqeMgmn05a8DYQyXPGH1wtMzpF8547zhS2ssC1bUedBCpj/JbDtaCHI9QfllQ1HBwHvRBhOrChovt+MctUpPHDl0erNXiW+UMfPeJeO4f3r4bXQjuACNA2W3cmUTTOulywkAW51akmrjF/2nQRul+RZFLFVPX+LTWUpd7HV84u1MzhIOrwAp40LM63UmpHtKLTB5NJ6F5so575i0s6hI9un2nll16/2J2MxAElOw8RkRC8CjNfeetztBwLc6Jwd/Iq+YVuPBdFQosEU5Tyn6gie6wR438x5yzPx233pPPoPRtoAIFLhmqCsrcKk43PdE7nCeRmDJla6EaOiBZfEtTRYetxs4K1Eog11jtuORjTLaFNb9pjXRxt8ZdRNDKsgLQGPU9uVrBlnqofDhVkSchlVLx9BFwxchFz8dZu0Wx0IgzVER+WaPkBkT8P9momT/jXRfj2xLeWvY/VsTtsgfj8icoPMwiak+iGK1wbP6H2v8FojxxgBW17mVz1oJBE517SIKV1/l9PzNshbAvKOMYeRPNskvB1yCDZ/1pNjj4xzeS4Ci16SJXkTsTGw7V+72zboMhbhmo8dL562vHiKHlPwWgWdxy4xPUZc+zBfkF4mf8g8HwQN4TfX5ezi/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(54906003)(66556008)(66476007)(110136005)(66446008)(8676002)(5660300002)(76116006)(66946007)(52536014)(316002)(478600001)(64756008)(8936002)(4326008)(41300700001)(2906002)(71200400001)(7696005)(55016003)(107886003)(6506007)(9686003)(26005)(186003)(83380400001)(33656002)(122000001)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hew/OX+eZpUMA3PLmPDDkuFmf/uIpaPXu1/1Y+vRzHarSdPumPvpA2ZRU81l?=
 =?us-ascii?Q?PWvn9rVSwaWLn5fNp1ovGtAYNKw77KjUHPIndCqfBV1yKxaZBGNsm0xlmwPS?=
 =?us-ascii?Q?Z1iAvhLlK4JF4mxrCvaWGLef6bvaOpu+gBeZ1PnLNRJr6OkHHF4WpiWPk0ly?=
 =?us-ascii?Q?MoFai0g60E266HAdOdBmA907JGJf0w+WwA7XEsgqlQnLCL2oGj7CfZTH5xUz?=
 =?us-ascii?Q?LNNIZs6yYvXHnx22ffUlcDikvqFYoqcEGZuENLnHP0/aQt/uJ67iju1f8BGP?=
 =?us-ascii?Q?v/rAa3TjlN6iB4FUM6FKkZ8IIsXwM2d9DXEAEfeTqjuP2JwM2CBmtSP5A95T?=
 =?us-ascii?Q?3NaX/6xmvnuh7z9ik71FfDDDRA6qJOdZ2CAkaYuQ3jyEnPyIkmVwJMPx9IuL?=
 =?us-ascii?Q?wd7jfexC7TYLQ0TyvEf5N2R6lNa0h1Z7RdSdpv2Sj6VpErJtcGK2JSSwobEa?=
 =?us-ascii?Q?70uYaS+4gucjOqdTg5r31YAdBp60GcxX5/Xlz9RhyJ/MmvHz6VgMb4jb42h3?=
 =?us-ascii?Q?c2fkLtLrxcYD9Q9qd8ZPC/RX+VpOaPEy7Og6QcoPvC0RaqlRXOAfr+MSKbCx?=
 =?us-ascii?Q?1ULIpCBLRJTXay4JUSUU4ZWeGwvOcF3LlaHR7Am0+siPZHeaNou+i0eDQMEI?=
 =?us-ascii?Q?m742KGpVDU7w//iHazIIYEUAoSauYkIAN6QjRQao5+ZKfv5szj0RdcdFHlxV?=
 =?us-ascii?Q?NDSVO5c3Zj9JbAPfaMDFkShd6MBtTL/CUUIve1GLoCQCC3ONA21IpXYfBq2u?=
 =?us-ascii?Q?m332B3xTrsPj2LdoxNvkIMXpyApFzs/xpBbYLxjJGysBBMwg+y6IuDo5BaVy?=
 =?us-ascii?Q?QC8WsESEpXCI/V4u9f6sRUMDxU8NpfINvbRruBdLLg1UlrmI7yvFNN5IBM4b?=
 =?us-ascii?Q?BScRK3DjRYqDSgCrJ8EyOY2tnmjxEWNBDsKCHBdetwrWjueirexk6CmOc7g2?=
 =?us-ascii?Q?82ZGMssUfV0BFz0t1tSWTSrcj0uel2IPxqsLyMG2BNQf2ls1EnkM9TF2NSYL?=
 =?us-ascii?Q?B5CwavUxEj2Iitw6Qxjnzqhcl3SAcaSDXysHvWt8eyT7PNAvvt/7qBKZaL1M?=
 =?us-ascii?Q?siCj9MzviXmryp8QSm2xhEQrJjFfLPjF+8Nj8wknXYMi0jm/awh6sj3E4njM?=
 =?us-ascii?Q?Bo+n8M2rjK+xVc5rSlA1Hm7eUrIKZf/kQqYO9wmd8QHLtNlXjTtJY96kvgq/?=
 =?us-ascii?Q?2medMtYQyXpaFWME36QSqygijPBTO8erb80+NN7j/3Ndq6ZuNQ9p6S/CKTqo?=
 =?us-ascii?Q?1U78gJ/N5zlVih7Ah5EOAceepJRncW6K/3TsZAGTbW8USbY/kj4lpwDh8r/h?=
 =?us-ascii?Q?5WqE5LPPkF9imfCqSP8gbLNzR0ccMO2nf2HF/YycqkHGfjcNVD+b47iGWbhr?=
 =?us-ascii?Q?75aeGZqMvaQKx43OeEU+gE3RytyGek7q1QjeICmKcOtLZtn8yCiTTBChYnMI?=
 =?us-ascii?Q?UKr3Gc88yyyAExCJt+0KJog9qrcHrWdQ8/mhT0d8QRn8hdQ5EUsJQEfRcHVr?=
 =?us-ascii?Q?axzQ713c81jlwdULEuHckuUH2/XRvOmZ52kAw2fYtFys7RM1GwEku7qSfM/3?=
 =?us-ascii?Q?Ek+erI9UpWpyp/lMskZT45x+r45bV2LnEHxYzTMP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97c6f9-42b7-4b0e-bf78-08db1633732b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 06:50:43.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7z7S59Z0hChGx/EM0nIwUYlT/zzpyYiY6D+tGlCHc9O24SQjH+SlQxPqwsHqUQjvjI9w1wAcq6REqqfN8soTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 23, 2023 5:03 AM
>=20
> iommufd wants to use more infrastructure, like the iommu_group, that the
> mock device does not support. Create a more complete mock device that can
> go through the whole cycle of ownership, blocking domain, and has an
> iommu_group.

this is a nice move! Presumable with a real struct device we can further
extend the mock device to test nested, pasid attach/alloc, etc. in the
future.

> +
> +	/*
> +	 * The iommu core has no way to associate a single device with an
> iommu
> +	 * driver (heck currently it can't even support two iommu_drivers
> +	 * registering). Hack it together with an open coded dev_iommu_get().
> +	 * Notice that the normal notifier triggered iommu release process
> also
> +	 * does not work here because this bus is not in iommu_buses.
> +	 */
> +	mdev->dev.iommu =3D kzalloc(sizeof(*dev_iommu), GFP_KERNEL);
> +	if (!mdev->dev.iommu) {
> +		rc =3D -ENOMEM;
> +		goto err_group;
> +	}
> +	mutex_init(&mdev->dev.iommu->lock);
> +	mdev->dev.iommu->iommu_dev =3D &mock_iommu_device;

I understand how this hack works but didn't get why in this case
dev_iommu_get() cannot be reused...

but this is minor.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
