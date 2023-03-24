Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD66D6C7616
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 04:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXDC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 23:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCXDC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 23:02:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052D1F935;
        Thu, 23 Mar 2023 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679626975; x=1711162975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45YSsr5FZh4nrZ0AkVxpo4SYAwFqNK8zwzrE4p6M2oc=;
  b=Q6d/byM6I8dFaLAzSheV+ienl5IdQ2S4sFUqrMSDKkZpNq/URF8xiqt/
   evToOs+gGVyixLYjleQUOKgV/7ssze2mcdctzpsTeVqVs6dqw/dVIQCx2
   /Nc+dVL9fG359uQyvDmrrvGH3HC+jor19bHAV17tQRI6h198Uk2BYI2y2
   B9y3HApGLVbSelVydmNwX8TOEz6mYb2KBYmpAmncMLtU25z/haKCWFBBx
   Imi3EW7cVHisHvQPSDIIiF7sgmoZFEjZx6n1NGs3kC5Ewf6sKKa3soKra
   CSFvhGiFbLoK5JjjXVY7NlnKig62f5w1KzedxynsLRkulovcdGn33n/5k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328093189"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="328093189"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856717166"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="856717166"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 20:02:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:02:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 20:02:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 20:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr2HMlNelaq9VEmyZqSTaoHLmGzGjrv35jb13mU+ZSM58XRejRu3rucxBcM8kh4WiIiTolFACEKEBaHeibW6q4z9wqzC4CU2oxcYD495+bUOWQfNPnVm3iuxthoEyJrXfSJ9zbKIMQmv1HO/Hjb1bzVaJOT7S1VBEtOawlyzwN1grhNOtRlnJ/VDp78r4JWN78rb/I0yaY2W7uHd1b2y+je4gEhmmELNdYO2qRr4ljno382ldFAzOwdhDJCMWvgT/b1DoEFAKt2IG+6EDjtVzp9bGG7x5u6jByRRh6CMSNbMeYhCLa1GG7coE5ssLuJzKE2hJwdw+lLRDikVxuzBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P67CFysvJRKEXc02k6s+Z62SRaUV7g6WjfbOufOIVg=;
 b=LL7RYed8Tyxm877b3uXJ2GJ58Fny64lVmOktQVD/MAZqTLq9u/ttvxs/N4OoaoAKuZlhlMmy+bBCAq47w2VFqLO58m0ZzEWpPVBQqlRsVYnaQohz4TrBe/GrQooJ5SHSm21W82XJ9IUVsO5B+S7hYs5n+OaTRy+zGJhJq00e6JNUETVhUwm8wnnFApmMNdggyxTFpambV1317sIJFgNx9uD4M8ctGorjQc+PidggodD2AxXnk3T4YKjPZ7CMvSjjdofto+f9AXs8TQwxY9LABRUaACG1woAlXD9DHryn5ySM2F2FumLyPYSZzhaxqmp9yV5cYPh25I4C/DCkB1puqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5484.namprd11.prod.outlook.com (2603:10b6:408:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 03:02:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 03:02:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v5 2/4] iommufd: Add iommufd_access_replace() API
Thread-Topic: [PATCH v5 2/4] iommufd: Add iommufd_access_replace() API
Thread-Index: AQHZXWJDldgoqUitjkeDxppFDShhiK8JPIaw
Date:   Fri, 24 Mar 2023 03:02:46 +0000
Message-ID: <BN9PR11MB5276E7E2BA88DD54DC5EE99A8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
 <2c3fa7a21373ee10af7cc9f8c370945a08341930.1679559476.git.nicolinc@nvidia.com>
In-Reply-To: <2c3fa7a21373ee10af7cc9f8c370945a08341930.1679559476.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5484:EE_
x-ms-office365-filtering-correlation-id: 0865fa13-e5b2-4089-5af6-08db2c143e84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P17y/0KHtAUJuKuvW756QpqFTGeBc+hpd9QjohtyK8dj6ur1QfTk9x/gto5X+Wy+pc/ZEEwDj9QTnBkpNKPVNuWtEnUwAJfOFCAseqUlmdTOilf4dPknk4fv3YBY55XEZhwjiCSda4yrr4kOaDaUi4SP5SaG35S7Hp1ub4+jKBOyZ6V4jiAMehgzrZcPya9QihtTGO0wm/wmUlbr+cdLfsinHw2qoGYGrfevM31I4B9hiuf/lqPGwT1VZY5fsswSofHkCxm7JGZckEOwOxzKwRpZepM6a/QKC4RPnANn/Hw0MW/nm+4Ud6YHO2Ii/WncU8EWQ7G0NQMiA7DsSGoqVPF0Ri9LBukwfGQzbHfX2YeJOrqTbTvsX7PjZ1Q7kkx0agkcd1LlOFdtHv3//uhOgtpvUDCMULJQJGAycB4TC16J3J6tDMy4VH0j8g0pGk2hun/xrq0OZp0L/MyhQpNLYOImQ0L8BI+M1ncRG/VyHd+77SgPggnZk/Rb0CRezZlqB6B1oj18l0LwWNLloUwFp1yic4cj9vuIp/jc0gLBYKa1EGUiKXup2IG5bd5g5H3YttpCvW2q4uNIxOY5j3077ebR5EysWvRRMBMng81mmZiVg/LyZv3FMnsTCjuVfi6WspSlXEIQn5j64+KX5G4p4e/ImugsWNgLrMwKyCLWmGKFoV4xjsS3uJDu/+Uo+F8eGPJEbkJXHChi8zF+H1r28A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199018)(82960400001)(316002)(54906003)(110136005)(33656002)(122000001)(83380400001)(41300700001)(38070700005)(8936002)(2906002)(71200400001)(4326008)(478600001)(66446008)(86362001)(8676002)(7696005)(64756008)(38100700002)(66946007)(52536014)(186003)(66556008)(66476007)(76116006)(5660300002)(4744005)(9686003)(6506007)(26005)(55016003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oH8RQGKLBX1si9ZuRMmM2g6kuWDOIm32bI76dDlDKYqw14Lbgh9+/BcNck23?=
 =?us-ascii?Q?KisgilQ/psxJ+z4/UEx037/J1+Sv0AWLc8nxRU/j/fujFJqmGWI9kSNsX0OC?=
 =?us-ascii?Q?DNmlGZw+el5iCUIISuzqmYFRVHFcj6uhLi2YC+OrDeoVsJkug8GX7y2Z+7eK?=
 =?us-ascii?Q?Se8ul491fT1HE8/suvtADXPuhT0VLHohXXxRlCE/o38CQeANCnvyTCevRUkF?=
 =?us-ascii?Q?Qv9LVgMt5zRnj6GvVIpsAwxVfcF68QBzW0u1moX55N1Z7UUBa+ov6g3yXUem?=
 =?us-ascii?Q?g2oVzlyS6Na9KWvveXfqLJ4fTw+gXEKjTu57cy0OCXUjyWYPQpOMoHHmlyEd?=
 =?us-ascii?Q?kY+niugFEw4miJARFhCmXPQy+wTUMX5JxyzO8cDvTEefT079k91QCGl8ji2o?=
 =?us-ascii?Q?xQNQ3gxdNWlovWhc4uhiJhgdlKJaGP+64Hpivs7+2ixT6YjoxjReD2j64uFd?=
 =?us-ascii?Q?ayndoLnZm3XR08/JIG1ssxAhw8P95L2vWOPnGUlsmk/tZ5HgWVl0m6SVR7vT?=
 =?us-ascii?Q?vbZoMDtg1+j4zbaEODAygBEa9W5NeXc63gGVI5ExACZy2O8KjjZpYsM3as9Q?=
 =?us-ascii?Q?ZRgT0pEDr84N7irJAZpO6lD1AT/kB7BU8EOswlMqvVMRUxne0zn8+fFziTe9?=
 =?us-ascii?Q?ozUHBu2k5bXGZ3shgMo145/GWCA1f5sj9Pk1P2uR6WXezo/BfhIJNBEYEQDZ?=
 =?us-ascii?Q?hxi8ac9cKk47yxz8/2unBGhYampDb1xpzxYtnA7Bs7FGEcnoBdx4B9rD+0+c?=
 =?us-ascii?Q?Z2ZrvncEFjeZyXnkQ07pjzO/Uv2XUmw8ZeUKhpDDbMZlWLkdnVxIrNNkIEQM?=
 =?us-ascii?Q?kUoQM5MP/KO5/NWG5Hopk5VxkWkLQMWBaQRn9vTY3zohpUtuK1MQdwL7G7x+?=
 =?us-ascii?Q?3cXCcL+R26XsZa99T30YZvBzJ+SoCrypIiZbau6XfHyxq6yls4BnlXxFis7f?=
 =?us-ascii?Q?dE0Bg6ePoqAFEdxDzTWcFOWUoyyAAQI4+bY6xTqyTt9CUYWYowYSIev800rk?=
 =?us-ascii?Q?DZr5U9LIFNL7xCMte2ImWdYohw1XAs3PSgHFLnqEuSalXqaSj+MD0lMErDwZ?=
 =?us-ascii?Q?LBLfESRaW0T1hb1LFW4mT97WEV3+qnjxp02DEZQZwGf71BgNToUEHSz+j7Bo?=
 =?us-ascii?Q?wt1R8KDfuONth7ca9DX/4mH8RfDPJb+U2O9WlvAw/N4Lg18IIeCzha47TJSf?=
 =?us-ascii?Q?gjKgEOFHJS9P6EmVTs9G/julebIA/OADGV+dkEIC4WN+t3K7LAudnIANFlEs?=
 =?us-ascii?Q?EvmQSDNME1m4cOvR8k0Gc3+sgcvoiJTHHjVs86jLj8AYfS8jH5guG94SJ6dj?=
 =?us-ascii?Q?Bp69dwAqFtLoC2wPd0q3Yf++Nq+j0dOzjp+i489Ovpurl0qATka4IirT2+7Z?=
 =?us-ascii?Q?Kkn52N/eNJtAI5gNx8+zEvF59Gbx1Kufn6hF5yUX+mOfIo524OOqjgfItG8+?=
 =?us-ascii?Q?guPLT4irJyxXmLxBb3YQhXqvUuk6JmXBJcG6xINqsKgCv44g2/e7nFzgpx59?=
 =?us-ascii?Q?Gh5UHpNNZCh/1/dlnOx46ykXJ8d9NbG7rqVoI9fxf3lKejcbD6v580frnIQ/?=
 =?us-ascii?Q?UBKbLcjAz7SpRb9KDRyNiRdCEqsCH5TDWrAfLhqj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0865fa13-e5b2-4089-5af6-08db2c143e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 03:02:46.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1P/9TkUKcCzSqmjh9cM4ZvxMIm3OnU4Pu6KxkRAUB/wcz5mtNiRc5rjnch/28jvPq2lFvniBIKuUnnpvg52MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5484
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 23, 2023 4:33 PM
>=20
> +int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
> +{
> +	struct iommufd_ioas *new_ioas;
> +
> +	mutex_lock(&access->ioas_lock);
> +	if (!access->ioas) {
>  		mutex_unlock(&access->ioas_lock);
> -		iommufd_put_object(obj);
> -		return rc;
> +		return -ENOENT;
> +	}
> +	if (access->ioas->obj.id =3D=3D ioas_id) {
> +		mutex_unlock(&access->ioas_lock);
> +		return 0;
>  	}
> -	iommufd_ref_to_users(obj);
>=20
> +	new_ioas =3D iommufd_access_change_pt(access, ioas_id);
> +	if (IS_ERR(new_ioas)) {
> +		mutex_unlock(&access->ioas_lock);
> +		return PTR_ERR(new_ioas);
> +	}
> +	__iommufd_access_detach(access);
>  	access->ioas =3D new_ioas;
>  	access->ioas_unpin =3D new_ioas;

Above three lines can be moved into iommufd_access_change_pt():

	If (access->ioas)
		__iommufd_access_detach(access);
	access->ioas =3D new_ioas;
	access->ioas_unpin =3D new_ioas;

Then both attach/replace can end by calling the common function.
