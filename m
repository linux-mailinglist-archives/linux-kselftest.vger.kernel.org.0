Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06596B3E5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 12:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCJLtb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 06:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJLta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 06:49:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5AA3365;
        Fri, 10 Mar 2023 03:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678448968; x=1709984968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FvS0oCChADd8kjxahPhtwrExY/E3HOykkS09aMsVp4U=;
  b=cZnpO5EfCOgygmNAJ6dhqFtjuAw/D/ybBinXqrz2RakD65UunATH7n1+
   zJTu9vjsRTaUQNj74b7RMQXB8eI51U+eIUGb0DTK70Fa/ft4JcWmj2KHk
   T82G++5xvpVMmfF2iJRpZ26zF5JHxwyJZDqbIDeKDtBbhorB4mK4ownN9
   jSDi6lguUYyUVHUnSulxNl58+0gRVwSvgid4esccgLfEgIvMMO1/GD4cT
   m5qwMMhYRJGogWYQkbFeJRGjgjnfsGa830EpcdfjEX3NvYURt6VHV5SmU
   T+eORoiu5YMogst0AyQeqNEyQzEFgfq8h2iy9JaZU0RYjsKVqBHta8hw6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401571286"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401571286"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="677785395"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="677785395"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 03:49:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:49:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:49:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 03:49:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 03:49:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By7ODE2A6OXz2gaBz5cQxDOr4dbTdK2OV1bNxWTk//cQfX7CV9GZ7RoZJTjxcLmblPeq33BWqrdcIFrpwrAEijnCLS6GQe803R8EEC3eQjoqXdSjr3qGUCh1y8PZBx+IaOv7vT9zSpwAT0hZTjac6xOikgRp7M4OQDg7tkMWYDkeiSfnBh84sosm+IXrFaxHAGsk6zqaaqFb2vtYKNVJUdJ8kk1Xy6apaAD0IxVMqKhskH6ZkCmqmt/412V5grknK4JQYT5mv6HOWEDmHwIk7hCMA1+7IsKB1mR0LLGeilqBoLV2Niq+aH3zEviqRKOWCMiWGt3K3+3/wWyOtyJCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hUchHUsLUvOmCdV0QIF/CeAeqXjYN/ORylOU6u+nOg=;
 b=XGrt+IYmrs8lheZ3JL2Vo4RolC6WAGqz1yHPkFV2NtbNwLh6jNPLA5I9H0vsuDB+25HxtytzayuJDBVxoTkZxFljtxtJeqLxFX2fQuHmX3BmDIyyyfZxC90P4k+QfQarCqpj77OaSsiB1lf+orrZPWIKocMyoMe7vkaHUgtZLYmES0lyAGBuHb6wcfLdLmVmr7drvzH34qtxeU6VesFnHswGtZo2dVEAL2gefkOHypLvLuUfw3ljylqOBTiAevoajniRLTn7hNECe3tYEaG4WeaNY8PQqgYU7M7zZsPiQdRmYTvMs4zG57gPGFQ4Jtn2f0e+w+nIZzdnTTzpJVhfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6274.namprd11.prod.outlook.com (2603:10b6:a03:457::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 11:48:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 11:48:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 12/17] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH v2 12/17] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZUVX/ECoTrm2Zp0uI0xtF50pSWa7z5+EQ
Date:   Fri, 10 Mar 2023 11:48:58 +0000
Message-ID: <BN9PR11MB5276166EE02EE60085F103598CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6274:EE_
x-ms-office365-filtering-correlation-id: 8e1a2429-2dc0-4b0e-5b7b-08db215d6f0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5JgrPYm6WsnpXGfoJYYCgkwXWpsN9KTjYOgjgyC7lRcPb6pVnyIWdEJbrw1QkhrQ0bLMnpngJ4J0W6DY5R9wb9R48Ep9HUzGWU8xPmwOjzllwWn2pQkVSAKfpexAluAibkrf7piKeEAHqvqhGg+TvZG7JcWM9dJIwR3bW7/Kg74RCN3rcVLuYyGxah+FC5V16bWt02ydvuCEFCSW/KTgG00XXj0tZNqFCGpqf39YH9OOASLQkedw2SI5dySjgXby1qo/Q65p0/nR2xisP2syJXPvyYLILxl83hq4NNtq6xCMXdCfePAAnV3Y55uuhNsXLggNpoGSKSE+hAYCzo1OHa1+vbqt5rZrVJHB28FnQJ73ua7tf8v2MCg0zhgbfMpYhkgHB0hpiX3NQ6o9TnHwI7zbL9yQOpBm73ebamxyh+qAO60+Ki2mlUmm8JEYv4e5/j+ciHdKcd7YIvnJ2nS5ez8QiiRDP27lq6gtHdcqXhP+tjhQGVcMF3E6xqtKLy7nlISCC9d5FuQeslPmf4mXn82cEY/kg8k12xOo0zXJmU3wSTblea79e5vvLJic6iJXBVmHONHJbkYQgIUGkcYih5EYzN3fT95WdtepvSqvUafQkEBTvtrYwEQBIwesQFmy5n21RmFB/ppbo9s6vPw9Ex9g2zvxaJ524QE/ZNSJpVM23Q9xD/KwjTbsQH3g4crrOkOGwSItootkF5UASmIlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199018)(2906002)(4326008)(38070700005)(76116006)(66946007)(5660300002)(64756008)(26005)(52536014)(8936002)(33656002)(66476007)(41300700001)(8676002)(110136005)(86362001)(316002)(55016003)(38100700002)(7696005)(71200400001)(478600001)(54906003)(66556008)(82960400001)(66446008)(107886003)(122000001)(6506007)(9686003)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TwQmRqsvq+V06k1JJ4A2V40dn8250pQgVfpKV0enDvYhloSseg2Wfpoj1bcc?=
 =?us-ascii?Q?0Oa+4ai8x6A8nnsMWlzKPhFv3l3DubjnNbKVJaLVPnxep1WwQTkvaJPmsGeW?=
 =?us-ascii?Q?MKSVZHSl6lQq1x5FCrdxcwKc/Eg5v1OtZiUNdnU84gHH++1TZGMrA4ZitLxG?=
 =?us-ascii?Q?VeeB1Nf+KoZxG0brpO6PKE+NRacxeVRKHuPmtRUGmZZRgxDS7MUUFhYzqi/W?=
 =?us-ascii?Q?fJvztkv6W6QQgKxfiDN1mvYdHohelCyvUH/NahxZHTfeGaLu1EX+2eONZiTt?=
 =?us-ascii?Q?OMZ/+EakGwLW2hfce+AZap1QmjUXGuX3lLUwfPqFbC6W8rgwIfyX/u1VwBXj?=
 =?us-ascii?Q?KvTPfvtxFUsIkKBbcx5Ml5WkWlJ1GrDXZGFd6fa8mRJFKbQtV51EwJfXQNfK?=
 =?us-ascii?Q?IHEReqxrmMwsemK0U9tycy9eyLms7TKPeUTvLIF/+3CsQvvkkBokZGGwQoCk?=
 =?us-ascii?Q?Upjeg435FvhB+i7sBcf/K3hBvqU8h1ZWl9iZ8Z9fkV9DOG0UfwS7coxr3T6m?=
 =?us-ascii?Q?3EDgeLnWqXheR1N+vXyhvk2CD5VfI8xMfwx0jrQARi69J4q8M28J86Tbk4+F?=
 =?us-ascii?Q?qDZMoSvmWjb9DC0gb4ebHnmObs0C4EhhF+2h2zfeS/kV+tQGPb8bN1nxSIvx?=
 =?us-ascii?Q?CEe2cimp+u/0Q5MWeBQDDwlNud9mFA80k+lxOA59V0mCYODqeGyy9xiBzjYk?=
 =?us-ascii?Q?H9DYkZ1DAFLxzK5NjclWGSFF4ghnw6ri7wiSUo23w0N9dfYvuIIDS04aJx4E?=
 =?us-ascii?Q?ArDBwAZRHL5JbeizMkgdcbBH4QbVkhAZf2aiGzQ3mpJs8+c4HkGev7LDeyMB?=
 =?us-ascii?Q?2KSh8C6Z+wwYNurf9B7NnXSdCjem7/vvTva6daldabtNbMwt0QmJgVpV/kG5?=
 =?us-ascii?Q?Yzw3STLUrq+xqXI8slsNseRSCbp4a+lVsIeLVSij3YTKfKfz10ApH24ZlY5/?=
 =?us-ascii?Q?4Gs+hDB9VHxew9O3tP6r5fqWV7VTJXG9Ak/KXueAhXlVc0j1K3vVZg+zNrFr?=
 =?us-ascii?Q?AGsLhB4+bVRyBQNehIjydPH0D+tZ9SGdC3NgO7cJK7NEJZ2J0WpRPZuzc4zz?=
 =?us-ascii?Q?hhA+Ocx7bER1F9nzWnc05I6bL68fCNC+zfcrq2zSxHCHHMBxaGzVzsphgNIu?=
 =?us-ascii?Q?tEitte8lrhn4paXhtJhsdkofe16eUM3WTx6nzl1p8vQP55zzh4qitA/lFGxM?=
 =?us-ascii?Q?UcwICXCLBxgKBh11LFZI9COWKjwha7so+8AjzQmgVSbCbbpmAq8pr4sCfImc?=
 =?us-ascii?Q?cy/rLMV05nch28GAuv8gqiF14zshyAQSDjjQxI+xpVQG68+XBRVhbIff0x01?=
 =?us-ascii?Q?uhTDa0VLp9kR74iDkVmR3mD0aq5YwlMzAK7sfP3oLwKkz9wMUpLFh5pI6AWU?=
 =?us-ascii?Q?o+UGy7jY8pm/Ur+aTZwOsK/oZM0S92Xn5h0FK4bXARUwqhXcv6mtZzAOzofc?=
 =?us-ascii?Q?QLBguo8HypqyRWRgoZVmyg+Hcuf4zVaen4/bAYqWEl9Ze2WF30ofcHxr0S5Z?=
 =?us-ascii?Q?6Ex9V/Sm8wkJE5nXiNsYk2YksqTvwikk2y41I3HOCxcfj1747/mIUjwNg6ZE?=
 =?us-ascii?Q?hchmqUBewEyvhWRA/JSkoHQZhvzYenqL5I+su0XQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a2429-2dc0-4b0e-5b7b-08db215d6f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 11:48:58.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apbFlkrpl97UdBnjYKOMmRUlHauQfQ86pMZNK2vbUnSoB1Utsop2PrfJYdgtCx4WKOBHnpFw/4F9lX8o03befQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> @@ -359,6 +360,76 @@ iommufd_device_do_attach(struct iommufd_device
> *idev,
>  	return NULL;
>  }
>=20
> +static struct iommufd_hw_pagetable *
> +iommufd_device_do_replace(struct iommufd_device *idev,
> +			  struct iommufd_hw_pagetable *hwpt)
> +{
> +	struct iommufd_group *igroup =3D idev->igroup;
> +	struct iommufd_hw_pagetable *old_hwpt;
> +	unsigned int num_devices =3D 0;
> +	struct iommufd_device *cur;
> +	int rc;
> +
> +	mutex_lock(&idev->igroup->lock);
> +
> +	if (hwpt =3D=3D igroup->hwpt) {
> +		mutex_unlock(&idev->igroup->lock);
> +		return NULL;
> +	}
> +
> +	/* Try to upgrade the domain we have */
> +	list_for_each_entry(cur, &igroup->device_list, group_item) {
> +		num_devices++;
> +		if (cur->enforce_cache_coherency) {
> +			rc =3D iommufd_hw_pagetable_enforce_cc(hwpt);
> +			if (rc)
> +				goto err_unlock;
> +		}
> +	}
> +
> +	old_hwpt =3D igroup->hwpt;
> +	if (hwpt->ioas !=3D old_hwpt->ioas) {

Do we allow this function to be used as attach/detach?

if yes old_hwpt could be NULL here.

if no an explicit check on old_hwpt!=3DNULL is also required.

and looks the policy for physical attach is different from the one that
Nicoline applies for access. iommufd_access_set_ioas() can behave
like normal attach/detach.

should be consistent here.
