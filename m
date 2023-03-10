Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746D86B3DAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCJL1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 06:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCJL1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 06:27:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B3F4B42;
        Fri, 10 Mar 2023 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678447606; x=1709983606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d77jpfLT1oEVggyxZWMH6vafHFnOT+o2d2PFmhqBNSQ=;
  b=TbMNywoT346SN50QrPZ9zOdFKXfmsv6nAeqWebb54Blg9r5n84F/yVWm
   P5ffRCsPEhbq4kUFdb0XYyZzVwDcQefMP97RMeR0EUgdO0j5plev+0T8f
   PwqRvH7cvsVMfhiD25YRtcQX4lG1BKugKyVycxxdiNYLGkdO7YrCFK1tz
   dXY8TrpeHDKdwBYceJdSBQxNk+h/cAu4TZJtBfoT6e9L8l26FtlPbQLs/
   KsenVnOkBa9lRziyXdKhMpsnogoPGAyuY8oUa0rJVWmiPE5J3+6u9tnsu
   1QMGFeAVcGA5jMnDUHGpLwacFYag7YSVf5Ehy07vgHZwgVOz6E3gC7vdF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399305742"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399305742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923651678"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923651678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2023 03:26:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:26:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:26:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 03:26:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 03:26:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/s4dIVZNsBUWVcaeRVlk7x2igRWHcdM6vrbk09yFdW6pcrA6DJKewgFD4PW1xs7gCdep29ANwi3E3PoFqCDPAntQFWqqvuq7nGlpap0nowIHDo/zHyGbmeLKsJDLBhEubvDOVfqHzRk/LMVU6fHPZR1bf+/u16AK3PU+iQvYXjAykBSHrjuY3AxBQmvzLTkNjYLKzrC7nN135WBBnk3564py+t1OcnQ64D1nITqUtZqEzKTb7YWUE5LwHmq4Aw2OQipHNoh5ocFrXAhsEpocpButMOHWqz212/Px8ouEC0zxSrGCe8kIMDNoFx5qmzUHwkjeMO1YQ8y7MjTRKklNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PWBdtn0hFYuoq62tQORzPMx7QJ3t3LPgQpgBrDmG/s=;
 b=GdzfSGpyb0dmWaqSzIZFFAG+DV7gJlyClZ9qNQ013BGuL3m3LGEKzLVY24ePpPS9fURlbaG1AK5fU+7OzNpW3M0hSfflRGYWLRkDuXcHWD2FAT71eWhikYuUOocfF500M5XJVNedqtKMGphsjdtPZztsKex0vi1/Wum9j+YigaSsyMzxmI8bTHQLx+faqG8RAXGLNpoPooFTkVLj+dU4wIIunYteqpz4gp1H8sgDPjrDSwU93yp1k/d2u6cT+/Cwc88gTidjWatP2jg37+csfckqC7oMbn0gZZgoUrtmdw3tyzaM2YUk3sg5+XoV7zO1FgJzw/twemg/RUr88dZmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 11:26:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 11:26:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Thread-Topic: [PATCH v2 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Thread-Index: AQHZUVYBZz2HI/d4HkatP4T1IE+lj67z4dOQ
Date:   Fri, 10 Mar 2023 11:26:42 +0000
Message-ID: <BN9PR11MB52760C4E5C89118C1B898DA48CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7085:EE_
x-ms-office365-filtering-correlation-id: 9e75ef21-2ec4-4708-1bc1-08db215a532e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3Lyu1m52BnrrsQXySp5j9B87BLQOIZVNvQTpywcxjlPMtPNB7B/7D1T9XRUcMNoYHkDYqyqreLcWEMPjGCumOleZAhzNy9/YHzr0qjisLa+n6dpB0xyYUBGabxlQdSpqbCHKlCZ5MJW7tpnEMdWjQcHLGLIcdBnYLfRuXuxjhCbrANeOlz7cLOMX9n8Ozyz34HZHEOoFfCGCX8t9o7tixMbYm3VZlTYYuoT+iQ78/0rIkynjA//WAUAX5Kyq/stPOpST6Jogr43Uagz+pWZpSDn0m/xF5ZcKmbl5zoXSmX5LiKq+VGg+hx92JNlnBXj+sxvmrPy+0m/YWyck2S4Ubvn9XShAVh5lHayThUKHsMkyQjOaS72ZPPyJvz/Jf4JNdVsyV3AVHNT5adQ6v/UynrMY1xF5rfhwO0ulFWuo8LSCmKi99RnWPszg3h7AZkbbwF3R6OmbSyEKEjSoBtQgZ/emyyTK6bSipBrvKYMFPvSUucbJTZERNRwtUINQKqhDsd5WD3TxcTnjI3rqcEcDjLFqKRPQYvgt7rOH9XUtgQJRUkCoXLPH8O+AHC4+JSDSRwfiyMHeURTvC7u67DE6hZj4rNy0RQUSefM6MbFOfVpVSvwvj9UDCV4sm90rKiYI3ObfASB8EaMpQr0oCCzeJBkJQhVEu+GuhI3mwrDteFORw6k/joHXc31NUj1C+q82JYptOksxFkTNgh//ydXPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199018)(33656002)(41300700001)(55016003)(186003)(71200400001)(82960400001)(7696005)(107886003)(83380400001)(6506007)(26005)(38070700005)(9686003)(66556008)(2906002)(8936002)(66946007)(76116006)(52536014)(64756008)(66446008)(4326008)(8676002)(66476007)(5660300002)(122000001)(316002)(110136005)(38100700002)(86362001)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1j8uUrL1HFRHvxHmVWiPJzW/kBqjS9uFhlb2yG8RDcW1EfsWDdQcMPOG8Gj?=
 =?us-ascii?Q?mZRE5aS2RGCCNPIB+Za9/o3wq91kGdJd4QygjkEAlc6r+YYy7SycfeblFpVe?=
 =?us-ascii?Q?Fuf/55OhnxFBcHVCXaInSDNd6x5OYaCsaejXtVlysmXiotDjaFN7Ytqp/3iJ?=
 =?us-ascii?Q?5lh4muR765cGJPXxrdHN1tCpRMxWLL0YNbsfBhDsVfFdAbmAvTKwPlYNH5HK?=
 =?us-ascii?Q?134VqWtuyFLzqfPPw5YkkyFo3Jhpy9z85AJGnFHF6PxMuaLf5Wlq6SEwoWvO?=
 =?us-ascii?Q?YCT3Ozj/G/nLm0ss1GBdqdM8ggkluC5tU5pO/78HLwreTK8Iqi4qNAbwm0oP?=
 =?us-ascii?Q?zqY91gzwZRIu9hwucuUhaaOdZrD4wuBtXBGrWeg3tQchJI5mJXC+f6CYIptx?=
 =?us-ascii?Q?iin6gTsBQ4kmJJB6LfwbaK8XOdYGh76vsyziBb78bd591WegsmNB8ekkN32Y?=
 =?us-ascii?Q?aa/fBbaZCEb2hoH2u7uk6ASqTCsYuSq3o1y1SE8u6zY97e6tkfPFSvoJXKwh?=
 =?us-ascii?Q?4QBP43pFuVR57abmUlwfcqoNCliQcJE+et+2ffbrNT60kSZj3Sv3D8YkyydP?=
 =?us-ascii?Q?Ad3ozexvYz7U4TNklgtDm5cFQ/7D2uqDADqk+/i1iMvFQ42CCKt4fz5NsaOM?=
 =?us-ascii?Q?L2qpcgGpVS6W2IQTYCt+V4GPv49fn/eC5Aj43H2//KB8xLSOkKtJVmwYEDdu?=
 =?us-ascii?Q?1rY1EhEG3lB7Y2jzl7VU3456mzTyALsoHXp3T8CdOaPizsG/LW8SgbxxLGUl?=
 =?us-ascii?Q?TI+t1C0A2sjQ5oMm+e5T26+b9RZYHUe7rP74tBONvDS/NE6n4mq73y2ISEua?=
 =?us-ascii?Q?TqLBgOWa3bQRqfh9h8kbXH81TaUT+Tl/g5/LB0I6tR9XQ4J2b5XN7gc9BbN0?=
 =?us-ascii?Q?6z4izwX6FEC3IOduh/+3N8Ohf6K4f2yL3kdpaqf8sfL336jYDPG3BgOCM/kP?=
 =?us-ascii?Q?3VrX/MVln7XiroXuzt2VkKzmP8P3l8YUuWAxvt27WMGlIxTXQNUyV0OIGpVS?=
 =?us-ascii?Q?odfG5nZTzer13sLhVeUZONcKjqTpsNXehBaMQ5Hhp/9WCu8U1aTveZk4qUvE?=
 =?us-ascii?Q?aIp0npRLx2yzsT7tErijg6Am1JwOLn7kTLcbbqxLYU1GOP6Fyc9M4kKqgILZ?=
 =?us-ascii?Q?SNtIPy/tvc3btb8b7LCeXtcTV1KelNra5Np8jF4/vSZAPU9QDbb+8Oqkv6wY?=
 =?us-ascii?Q?PfTG8nZOUzjU7SsSe5+/KAukh27fTk7hv9UVR4+Rn0wFxlmqPVvRK74bgQAb?=
 =?us-ascii?Q?m1a/PaOvxMXEsK7x47El2ipulebJC/zxlDDQ2M6lfR/yHaxO1RGHm5moW/lk?=
 =?us-ascii?Q?2ZXb+q4MAFqYRp0dO6/wMmO+8QnAkWSSzbQYDSmSSKraKPNA6/SIT9IWRw56?=
 =?us-ascii?Q?8t9ML50QAgjwy7y9NltBGKkVO652hdOYONXcFhJ1KyqM5LMmK4jBshoX3x53?=
 =?us-ascii?Q?udAkIopOaXA2ap11BVNrZqkCb3ONeeKwg6IZ2G8xsDeTICZ1X387RWWKbSpl?=
 =?us-ascii?Q?0M94wl+8O8UoWgG4blLH3vb4ey6/KE5/vGVch5sW31jzhO3USdscNPs6ihum?=
 =?us-ascii?Q?gahCCSa/Xlc/8MvzhjMO7CmYgyuqSpNhISORculv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e75ef21-2ec4-4708-1bc1-08db215a532e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 11:26:42.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrQ6N2j9cDC+Z+kcW0aTvYTgId7K1p4bKMtZ1nDPltnAk4I7E422GAJtJIhIitQx55hzCDYmI9Msw8j5J1wxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> @@ -379,52 +388,57 @@ static int
> iommufd_device_auto_get_domain(struct iommufd_device *idev,
>=20
>  		if (!iommufd_lock_obj(&hwpt->obj))
>  			continue;
> -		rc =3D iommufd_device_do_attach(idev, hwpt);
> -		iommufd_put_object(&hwpt->obj);
> -
> -		/*
> -		 * -EINVAL means the domain is incompatible with the device.
> -		 * Other error codes should propagate to userspace as failure.
> -		 * Success means the domain is attached.
> -		 */
> -		if (rc =3D=3D -EINVAL)
> -			continue;
> +		destroy_hwpt =3D (*do_attach)(idev, hwpt);
>  		*pt_id =3D hwpt->obj.id;

only when succeed?

> +		iommufd_put_object(&hwpt->obj);
> +		if (IS_ERR(destroy_hwpt)) {
> +			/*
> +			 * -EINVAL means the domain is incompatible with
> the
> +			 * device. Other error codes should propagate to
> +			 * userspace as failure. Success means the domain is
> +			 * attached.
> +			 */
> +			if (PTR_ERR(destroy_hwpt) =3D=3D -EINVAL)
> +				continue;
> +			goto out_unlock;
> +		}
>  		goto out_unlock;

two goto's can be merged, if you still want to keep pt_id assignment
in original place.

>  	}
>=20
> -	hwpt =3D iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev, true);
> +	hwpt =3D iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
> +					  immediate_attach);
>  	if (IS_ERR(hwpt)) {
> -		rc =3D PTR_ERR(hwpt);
> +		destroy_hwpt =3D ERR_CAST(hwpt);
>  		goto out_unlock;
>  	}
> +
> +	if (!immediate_attach) {
> +		destroy_hwpt =3D (*do_attach)(idev, hwpt);
> +		if (IS_ERR(destroy_hwpt))
> +			goto out_abort;
> +	} else {
> +		destroy_hwpt =3D NULL;
> +	}
> +

Above is a bit confusing.

On one hand we have immediate_attach for drivers which must
complete attach before we can add the domain to iopt. From
this angle it should always be set when calling
iommufd_hw_pagetable_alloc() no matter it's attach or replace.

On the other hand we assume *replace* doesn't work with
driver which requires immediate_attach so it's done outside of
iommufd_hw_pagetable_alloc().

I'm unsure any better way of handling this transition phase, but
at least some comment would be useful in this part.
