Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26B16A7C1E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 08:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCBHzS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 02:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBHzR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 02:55:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E1534300;
        Wed,  1 Mar 2023 23:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677743717; x=1709279717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3gqh+AY1xZFmGFNrxbJwTcRjpCBc9W6rDkkYotpuP8=;
  b=FWGM2RAViD+aLqkE1rSgl716k0TDm+wmSNFdjz7cMt+R5M5qXXKyUVDV
   suDhshJIfPlE5Ci7SPj4HmWJxmj8bWA/RBPJsxM0y5rJrTk2V/fITclZ3
   FXzb5r+88GO+GDwqEFCtdvrAPBvTlGMr5iO8lr5rfZEKqy8Yh6DPERWRX
   ZG6tq9lKYJmyCDr//K2DVjEHvblzVl17Wn2ZYRBwx4bEg4BRQ0e0U/yTe
   5j51e8KbsKBffFdzvYonPSEv2bxH0k3H5clhGCNq+SXlXJH1eI9kQCLI7
   CranNVgSj1bGdK1zQfYZyoQl83Ctrkpt9EGZWr3Gu8cegu0Eqo/n7KUs4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318446248"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="318446248"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 23:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817890922"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="817890922"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2023 23:55:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 23:55:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 23:55:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 1 Mar 2023 23:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkfAIPGOkJa+L8ClPG3dc7TibgyVPPVCIA7YGIsIXJ+lWT2GnuaBRotsGU8ix2lWO9HJjkhPYSJz1IEWyna4nj8U2WVb804vezqi+UxWORFLwrqU1NjT3+8cBPhjipQtA5qXgtHhzRJ/7Sl4Nt2ZtrG1M0uyjEsukf7SjaZX9qKGnjukrksmuLpldkVXm2F2HuWhQbL+dkfl4KlfVgn6liYJfWSkqWIpi9G/sVTzZtYemnUem4Lvq2HgtCYlQMQQWlcaey7c/+y9GnkuyabFAwkDSaIjQukaDSUa42W9ddneaxKa2mE4J08djxn4zPvUzbQKJ1NBEDGJhAoTqxFUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnMc5XqfW4bv6pjwM7S7LptnxXpJXY/C2YmPpnlQJLg=;
 b=GWxFUBvRdbm+JWEn4NHQfbcwmQ/6yg8VtxQGeOaVk8F4acB6Pfamqgh1JV45NwMYAWYTlT4kn8y7GaghXtvskT1XoJmfBBHDDIdVznPbf8dArUMzMe/2fNo9JeNvQ3g1KPUxdUNf3ST55Yl/TeEWYuMGZJ8lYaZLWYa/VegmZ8oZG/1nPw531BL61FDTbZ19rK0N74S5dzlWj09P4sr86NFHH5+Zd7TSvK6+P0A1YKVpqH/Ib2pHa/TswC03p3FNO3N/puBADzGKy8KQYVVEnDrSvH8+P7O8vNRGWp9KUTNwYSCiwneHFV2aodsVW+KPqSpSlDa+EKEaQLbmuHEATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 07:55:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 07:55:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Topic: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Index: AQHZSLARxLaEke/AGESa0unZyuRN0a7nJK9Q
Date:   Thu, 2 Mar 2023 07:55:12 +0000
Message-ID: <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7849:EE_
x-ms-office365-filtering-correlation-id: 7408feca-2811-41bd-eb59-08db1af373aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FecJDAxk3XA1ZySKFEoZSMh2lJ0Ckf2Nmgbj4Id9KHWBvs1nuYgymCz811NKZ24FLQ5g+eBaJdMGdXiABULbkRhd3LCJ92sSV2GLI1EWMoVtWAzBHN4RKkOfomi09W4exdX0oDgDbh/Y2QZnKbnFhHDrliE0r99K8wyUvz6MPY5TiWofQufWdTwieIX56BRVn6ThpgqPZF0vZlkz5xGPiFtvq6WJlTf9GmEgpyX2FAGDBEUg4YG06LbQhIZHwf6BmhzpEW2qVLVlfn13fEyq56zSNRubXvk2QcW1Z9HKTVXjeQejXam+7FwxCcf9OULh5SfTL+eOx2wbd5pG4UpgOWyZAoNDmitQ253wXwTtlKj8mzgkyxouMfLVaHtl7i+8eMF6X0w4/lJLJbmyP+q0EDVa6IHmUponMUg96NnzFkNQuTtwHnLHiZN6Sm01xcjcD2/kTVDvEcTbPwjRjKcAY3hXCw65Lky5KUG2gQ/ezWv7VnMtPceWKIbVABZxOwhfv280fg/nOHCKX7qkIorP4ZtNFLEr12UxjVirofnZ4XKIVpf3sxMPOumRDZWNFEbjkLdnvnOHQjd7kSzGXahlZ9wek0T3oR+l21QuG5+R5H6XJBHHN8ApVONENag5vm+oWCDO6G7Ae4yjXnr2nFEOw5kFYTSM7FFENBWYGaly+nkl+JTPWJ9F4ge5bThY9S9tHKcsghFVa478+VHscEkDmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(83380400001)(478600001)(316002)(33656002)(4326008)(122000001)(82960400001)(64756008)(66446008)(8676002)(38100700002)(55016003)(76116006)(9686003)(6506007)(26005)(107886003)(186003)(66476007)(110136005)(71200400001)(7696005)(5660300002)(66946007)(66556008)(8936002)(38070700005)(86362001)(2906002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dUUqw00H+1giRSq2FiOuZmvEmZMMjnbSgKvkq2X+OzxW0+sE87WMukQgDi9/?=
 =?us-ascii?Q?NZkX3hoaOCbP7fcxM55Z/JIXFu48USiC+zyexNS1doFD6B8jyARPLMzSXnht?=
 =?us-ascii?Q?39xmbiZbFGRsct677+F5A+mOGdP2SS7mKtwkIjkvieQHsaarffhoUk74Vjk9?=
 =?us-ascii?Q?HY8Skvu7dTUy8YtlKSDyTXQvKTTkFNC1i8AZN/SqlJGzxqFLat2s9L7021si?=
 =?us-ascii?Q?z5AGAnCMIhpa9abDr2t7cDNVVBh0ZveEA2HHfehIkMhpBLg0ebP5GZuDN4C+?=
 =?us-ascii?Q?tX5wgG5B6tEjAT222qeQhjKMY5KLl6WoGa+Ht1kcdUsp12b6bgo1t1uT3mmJ?=
 =?us-ascii?Q?iyEOW1elq2aXGa7jK7Sx95H58DBaXRm+02YIV/gl/jxMyDBJ2HcwYVuJhZG2?=
 =?us-ascii?Q?ZUF7jEs3Vtkqu1+aX4sCPnJ2sViMviuXxsqh03xgdFM2bx8c9rQuMgW5ibUR?=
 =?us-ascii?Q?pF4ABK5TQCtdrpfrarZp4cyPzGXuTUZIAc3dYgmspYSnJ75waoiR/rFe/+cp?=
 =?us-ascii?Q?N1mGNNcW/ZUqvL21znGiHIEimQrhg0wpXspaVz42A2INNeKG0Jqkx/juLZN2?=
 =?us-ascii?Q?2RDGhqSZ9iHOJgLu6be/7lnl/ftf6+pevxxYNvsdw/CcgOfiUSz5zOopU60t?=
 =?us-ascii?Q?MQv6sKq/ptVjjEyfIdpgXyVpROr1ii8dTj6mZdnIYRPvJAgHhO1nTcNK3zoO?=
 =?us-ascii?Q?qoIcCNpU/V71VK6J/WNeOEubweHZn7ncSBxQVMdd7AV2h6tCoSIi0yl+syQM?=
 =?us-ascii?Q?H2Hwb2SW69RPqA3s2FO2Yvbfcz/NxGXIjGyOpjme1bHoVM6X57+wyQmbfTrY?=
 =?us-ascii?Q?iyW2mcgjpXeokJr9jkz0vm6m3RXfbRMs8FXQcMt7zrgr0EwXzkeIC2VouWQQ?=
 =?us-ascii?Q?ylG5n8JA7pilZgXYKtWtN5hOAb7gqtxFFElSHdApiTPUd7KLd4lAbpOx3MFu?=
 =?us-ascii?Q?+k4aZxYVFIRxoJQAuT6g+knLlyDFfqgRqqse5gTbSU90DPO0M20stUFMBInw?=
 =?us-ascii?Q?LaKC8mzRG6pBYKdJ/pDw2AAIXSpyARInPRUEEXz8McCIRkDbZkkq/MDwZ5fD?=
 =?us-ascii?Q?DFtTOp7g4jZ9+aDbHCPb5AS/3hp1s/4pT5wt99EVt1pGLljPrREKfAeES2yC?=
 =?us-ascii?Q?1dID35jsCMvtNb7J8tPN6XdrYOYHGBzA36Xw/aWwfH4ZLDnSD02ol6ZegAYr?=
 =?us-ascii?Q?fRqBAmDOyMAIIpNyGaVBAQTsFYuyrZ5CiTv0vGnbqrwyAwKOqOwDS2IDJuBX?=
 =?us-ascii?Q?NHVxaiMspcaA0pETN0+UBfHD2Nz9inp7SGjZbTeo6eEfgpWWVEtVp1Qq4td9?=
 =?us-ascii?Q?X0xIOTktcCurz3hrfceF1a9T0kAuV/RqgYVQjIKkPv/BbSs6rY350/cFA5FG?=
 =?us-ascii?Q?xQpqzCjOWuyOMDIRaJIcWVmaPDf5dB30/kcDRA5NkQ4W3JTRoWT2KE3T45+z?=
 =?us-ascii?Q?U0BMXVlFTO5g8jZDGnrIi4ornvDX/7eTeRlXUCv9o/1+Jf2eksqNNCpV86YS?=
 =?us-ascii?Q?J+Wqko+yjk0aNcoqzkIBlb50XRnvKzipdl3XIFAvFrpPwhw6YlTopIjBNW/N?=
 =?us-ascii?Q?MIEC5RtpK2IsxNveTk/YRp21NGQW6oQ9qvHOcbMI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7408feca-2811-41bd-eb59-08db1af373aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:55:12.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aPc/f01byAoKgInXvzSRpalq9B83m5BsgbbI79eg3GGkeID/Bc0DHEtMSQeYxbLLGCT3NgqtvpQWdhwUmedJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> +
> +	/*
> +	 * All objects using a group reference must put it before their destroy
> +	 * completes
> +	 */
> +	new_igroup->ictx =3D ictx;

Looks the comment is not related to the code. Probably put it in the
destroy function?

> +
> +	/*
> +	 * We dropped the lock so igroup is invalid. Assume that the
> +	 * xa had NULL in it, if this guess is wrong then we will obtain
> +	 * the actual value under lock and try again once.

this reads like "if this guess is wrong" is checked outside of the lock.
I'd just remove "under lock".

> +	 */
> +	cur_igroup =3D NULL;
> +	xa_lock(&ictx->groups);
> +	while (true) {
> +		igroup =3D __xa_cmpxchg(&ictx->groups, id, cur_igroup,
> new_igroup,
> +				      GFP_KERNEL);
> +		if (xa_is_err(igroup)) {
> +			xa_unlock(&ictx->groups);
> +			iommufd_put_group(new_igroup);
> +			return ERR_PTR(xa_err(igroup));
> +		}
> +
> +		/* new_group was successfully installed */
> +		if (cur_igroup =3D=3D igroup) {
> +			xa_unlock(&ictx->groups);
> +			return new_igroup;
> +		}
> +
> +		/* Check again if the current group is any good */
> +		if (igroup && igroup->group =3D=3D group &&
> +		    kref_get_unless_zero(&igroup->ref)) {
> +			xa_unlock(&ictx->groups);
> +			iommufd_put_group(new_igroup);
> +			return igroup;
> +		}
> +		cur_igroup =3D igroup;
> +	}

Add a WARN_ON(igroup->group !=3D group). The only valid race should
be when an existing group which is created by another device in the
same iommu group is being destroyed then we want another try
hoping that object will be removed from xarray soon. But there should
not be a case with the same slot pointing to a different iommu group.

> @@ -98,7 +195,7 @@ struct iommufd_device *iommufd_device_bind(struct
> iommufd_ctx *ictx,
>  	/* The calling driver is a user until iommufd_device_unbind() */
>  	refcount_inc(&idev->obj.users);
>  	/* group refcount moves into iommufd_device */
> -	idev->group =3D group;
> +	idev->igroup =3D igroup;

the comment about group refcount is stale now.
