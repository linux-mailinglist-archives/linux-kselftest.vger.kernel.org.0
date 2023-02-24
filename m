Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD866A1696
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 07:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBXGZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 01:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXGZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 01:25:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126144DE1D
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677219947; x=1708755947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpeclSy2lgc3GQ4l9XUBivfNgXC2uGJYoomUaF/6fX8=;
  b=Q9p4gLbDHLWf34WtmQBnHbVKWURL7zuQaTd3XTLThupz/pyEypVuj0RE
   A1K1qMq6aO4FA5ARbjEhJHiR4QwP7dKvGBY6+g7lQwpgIz0ca92daOHbZ
   dHsITzaoUUmj0eSdoUyP2bfAkvY3j8w9QUsMdyfDcl6VXmex5NrVMM66F
   rOyxlYN3D1H96yryJv+DIJd+OxzjJsdCfGENx2FH8xinK96LMU5EpP6dT
   UvAxbo2O3id8LhFiBA6LopkWtRmLFz5+z0qqxsLxbJKEfj8cnI23xaekL
   isM88SA55Ng+xkiBFvmzWBT0c7H/D7FBtMySyD3xqIUVGlCbysnOGvRqR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="419641134"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="419641134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="796628164"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="796628164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2023 22:25:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:25:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 22:25:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 22:25:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Qd5HBsgYHN8BKIc13PpRM1uYuWfdoD+nQKkbJwQFxHYu0rYRGbCxJRLVELj0tDEKucuV5aZrLeHKsab0hc40kbN+URRttyJcWFv+q0axGuXSD2zoelbgb3Wy/i53aU75hH+KTIMCkJsD0d8f6RVZGTdd4Ta1MatrvRIq710swyk05MisGZFa4zF0P5Q4NkkF5SNSY4KrqsTFBFZSOPTKnd0dVNB/AM1qZ+3GTQdUB42Ohty7SSd6ilDb1iKepM4Y2AzVK5oT2/0yQ9ZJ5iApSeWi1Eilhz68rpHJeCRbYXsB+EW/ulhCkYj4EhVphQTiUqWX2RH3QJeEn44uu6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRhmiTmtimWzj8p0Zhue5fPmC5Z33WwxcHE6ZPRM9eo=;
 b=J9TsjSbT1q1cH4g8Xn6Rt/rYssc+iMZEWCcVt+FTYa9RSqo438aXBCrgyXNm0sO4Z0PZEaWl6Lf1GPt+b/1k8NL18CRGQHnq3nsSH0MLFbLEvymw3xb7ii/Sq3FfqRYw7f7eOL/B78M65+2BmlD+T/utHAYDJsjUFEVGwSMi6lmoJpyyrPVZzPteCsZQMsHdnYFF52kuYy3+cZZ836NFVOiDkKjjF2wsXJJgczj0rruh8+hQU/HREUEcPssF46SuXdqEEpnvO4ZDkeWJ6NqW0dZQUPV2mTB2r4RMrmnR470YV1UDzJB5EQpzgWvSPRp/7vlO0avwmafsZpLjYZaK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Fri, 24 Feb
 2023 06:25:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 06:25:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/7] iommufd: Move ioas related HWPT destruction into
 iommufd_hw_pagetable_destroy()
Thread-Topic: [PATCH v2 3/7] iommufd: Move ioas related HWPT destruction into
 iommufd_hw_pagetable_destroy()
Thread-Index: AQHZRwEI1VCM4qK530uK4+s8M9vGPq7dogag
Date:   Fri, 24 Feb 2023 06:25:43 +0000
Message-ID: <BN9PR11MB52764BF3146D5A69D261D5B98CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <3-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <3-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: 5b6ce3d7-ff30-4e47-1ac4-08db162ff558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6CMXCg1tY47mSeMoHAmfdN91EiglnuO82+t8YxMh9PxFGFuOTzv+F5/j+nrAiT1tNis0mBQn/tTfxY7NqN4VvOoJvV8KFTRbDT4c0o4IqV91dVzWpXCeekpUkXNez2c8lhwSpcudfHHGfLW2vqaEEiqLXbeyv3kHXF8iyaAqHx0eQMw1Pqz6545ZttZtV3OXZdkbfc5F/dQymChDRW/A6PRx9XeD5loX93NR4cfR5o1xbdzpTbisuoM0nrDBa7C00MQPXP5k0ixN1WkrFN41RWDYb6oVIyMI/cdo67bEGLGK2gVgTm4d/zglmRmt+WlTfTfXQ0zyTAnoV8pMaIF0BaPQSm7b02nQcr0+jMISPVTpyNSZ+nPxnchPzennrJTYWQ0cfgQQHyUgc/rRXFalGWpA9X57TjMUm2mw41QfV3MzSEPQFZuubVlDbyx0Ge36sSI/gozwk/H3VR4k0rzOranAUSoUTuazNT1ducGz4panhJp4M601AjVsYQxeIlFMnpp6F3J6H0NrCfYYnSHwNhGfwa5+UqqlxXU2KVB6FG0u/xFeqqj+XdUWhwVPYRUqG89SH9gOXfSaf7VkG4HTrEqAoUxvyUbYLP/mvhK2G1jEzJ1LXeQ/gnfwLAF5go7veQx1RWh/rGA8mD+jo+mDJPAwB3PFGWdGN8FxngwbznJPH+wXvQUtZJf7MwP+XQwRoN6JRNH1SIOXf7KbDfB3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(83380400001)(107886003)(8676002)(316002)(2906002)(66446008)(66556008)(66946007)(110136005)(71200400001)(54906003)(66476007)(86362001)(33656002)(41300700001)(55016003)(478600001)(122000001)(64756008)(82960400001)(38070700005)(76116006)(7696005)(4326008)(5660300002)(8936002)(52536014)(4744005)(186003)(9686003)(26005)(38100700002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sr0NNfzWJcLwIfWyC9RpHjSMU1WwziK93gFM/RAgJetsPTh8xDAxdeaaM/F1?=
 =?us-ascii?Q?9djYsUsOLrYpyACYDwLNIPljiMNV8QLLpKP87hTDuRN1fZt59RyH/K3xHIJG?=
 =?us-ascii?Q?ACTltRsenMG6QbC8iiANzaGr2xOJGFdWXqmzi/vzQHUmc9OjxooDETp+01kR?=
 =?us-ascii?Q?jz2qGa9zCLZFwHhAcIDihlshnkhqtIF+eZNC9vjLB614wpeApn/BWCtUE9sU?=
 =?us-ascii?Q?Zt7Ld2WOPMklTB0WsbWmVyIv63jZV/SRpEFuKKjDh0dg7VsBcFWHj8UcTVGU?=
 =?us-ascii?Q?5lPRcAW7CDcyo4GGXUOG0omhAyEXlIf2JbNOsIyify3XvpWJmWf3aBWdDOTy?=
 =?us-ascii?Q?4cD8n9VUHDQCSNLPDD0oTOAyMhJdRr41eT5DenyQxnS5/WpmXLqT7byaLuFU?=
 =?us-ascii?Q?HPvZQ26ng00x0z4swqAvZ1FKKpAFn+iYu72znIA1AOu9NNfmvWdufx7Xh65n?=
 =?us-ascii?Q?gA7oUkLcyganNUsjspDMzyZ6DrbVvBC9a3q/yRFVln8R1Bwx9IpBI74Lm+oM?=
 =?us-ascii?Q?78u4m+XNE+P5o5IG/nML7O5oNfvjUk9FMkg2NcdqXZQtH/W+BR4eIl9NMRgI?=
 =?us-ascii?Q?GUWbKAq3bs4wCQQgFkjCDH1KB1v5KQuTP8m7kRjl2sHb0sj9cT9+hAs90GLe?=
 =?us-ascii?Q?AJ0IDRsBSNwO3WouA/UQOwVWsOwJvHbckOPiUgFQkOhGtmZuVFu4ZOm84bTu?=
 =?us-ascii?Q?fe1qQz43AbucAn4BF36vRACYTTwiy5xMOYyKh9DSQm+c6rea7Wwgj43Sd/lg?=
 =?us-ascii?Q?YVdWFyDksRPCi///mmPR2loOGRNSblBLvxQjFd/fLk1cflBYx8P8F8xSvUgt?=
 =?us-ascii?Q?mbJtoUAeGJZsHj9sJRu7dxt0IIZwRM59Z/NUoTlIjlWimsX+q8vmI/fQUE22?=
 =?us-ascii?Q?MDyw4f64lIvdeaTcenbWkcA/Ocw3yPJq9wet7F4bagiPslrtAgauPl0hDNiZ?=
 =?us-ascii?Q?sWVyKeLVHlt5tFBZFhB9Ahz4vLMs5Cwpa1hHhGplO3gUJBw4afbQZ60snN7W?=
 =?us-ascii?Q?ByBhQAijtjZafYix+DPgawQ/fs+whKpwBHa5fmjOfd3loVrWyV060iTXOO2o?=
 =?us-ascii?Q?L0L4XriBNsBx/QanGnmUoX1XUVf71riId4r5/0NHGj/PRYlnmzeJP17x98G7?=
 =?us-ascii?Q?T0VzlMM5/qcKHarSz/J+wz2bOm9dKQ5CycY2sQizdIZgFwvLK6ZwrOG3Da3o?=
 =?us-ascii?Q?edY+o6oqn/Mwo3u68J6INwqDvZNG9v3SldUdPoaXb1ZMrWuorVgyuhSn8sTU?=
 =?us-ascii?Q?Yt4Wr8Dz/weonotU7J3NuWKSRbWIHxqFutnmFznE+TBr44GR+c+mGw466zzd?=
 =?us-ascii?Q?HjQUW9gTtpO0WjJQSFrBRhYZlrSkrrTB7Xwlbq29lc90aOMJq6cdE5FGj4Xn?=
 =?us-ascii?Q?yza1uLs1Rx5pp2WGxhAuj5LgnhXeZIILGXHUJk56fUFmxN4kybAU/vmDignE?=
 =?us-ascii?Q?bMM9SxfVmfIFmSEcBkwh1uq8FOY93g0QDc5XPEGTLhAZn8ML4Z7rOIbSC3nX?=
 =?us-ascii?Q?zLUlPmlTagd78zAeD1SbdsswjbkL1vOHtWfhslvmoUN9i2laI/0/y/VZ1l9w?=
 =?us-ascii?Q?ada5tUBS5tNxNf4BM8cTzonAqGAhUytUEj/e+dES?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6ce3d7-ff30-4e47-1ac4-08db162ff558
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 06:25:43.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba/3M4OYBJwF5ZAmDvR7R1wMA7Nqg6eyQMPxZc3QXzcGgPLvJqotRK/V8xQBpTpAhof7uFt1nsk2Y7PaZncUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
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
> Sent: Thursday, February 23, 2023 5:03 AM
> @@ -753,6 +744,10 @@ iommufd_device_selftest_attach(struct
> iommufd_ctx *ictx,
>  	if (rc)
>  		goto out_hwpt;
>=20
> +	mutex_lock(&ioas->mutex);
> +	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> +	mutex_unlock(&ioas->mutex);
> +
>  	refcount_inc(&hwpt->obj.users);
>  	iommufd_object_finalize(ictx, &hwpt->obj);
>  	return hwpt;
> @@ -765,7 +760,6 @@ iommufd_device_selftest_attach(struct iommufd_ctx
> *ictx,
>  void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
>  				    struct iommufd_hw_pagetable *hwpt)
>  {
> -	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
>  	refcount_dec(&hwpt->obj.users);
>  }
>  #endif

It will read clearer if first having a patch to add list_add_tail() to self=
test
attach and list_del() in selftest detach and then having this patch to
move list_del()+iopt_table_remove_domain() to HWPT destruction.

