Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2456A16DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBXHCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 02:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHCp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 02:02:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3DC60D62
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 23:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677222164; x=1708758164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fw7pKq0YOJoAkrdp2uEoI11fvS9VmlvKA+TLl/tRo0E=;
  b=eBJ6NCeVbRkM2ZBqAgIVH9C8CCycUQ2+30pGD//SCSdHvRJKYLxCHVCZ
   hxMhCLki56Vc/OBCUc9Gl4Qc9SIPOhhjvLBLsEaqxIKfpQ3BiYtVN1pVH
   ZNbgsllHJNfUbDq47HCqM2AjiBOG/iRRqoljEJLeHDrQ0SRscm2ciYe6k
   tUK2CC1EtdC7MkHw/zIfPlun7omLa+I5TtDn1CKNRn64CzOgMI/c9+dgr
   ucbajPGtRaf+fIUDfUGs0oH5+8mf5dUitWjV7nrEUDFrIHSQ0F2SC19M5
   CA7kb4Bc7vksn/pWdds50n/1U8wyi1On89iE7tmO1ET5ZLRhjdnCkiaiC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="395922828"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="395922828"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 23:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918327275"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918327275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 23:02:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 23:02:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 23:02:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 23:02:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 23:02:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RviDBuSpVX/FxaMt6OjemvSQuOuFWT1An0zs6/M99Jqkopf9NBO3DPxwM0uXKcGlFEC/PTqXPMsZWTCb6Hjv/zqedETvAwnlxekUcXefGyeRm+I2mdpFh5Erifc2FoMeqdygBPztBmEjhELvYN9WPsW3tFXFZTSNJsefWJb2p/846DcThCZmKKB+Q4t6pa77j7jRFxxn0hGmp26SoqqKe7Ekav08z+3/eCk1SmA1D/CDdvKmYvc3W1PDHjRz1gWtO0mf17PPiJ4au/c27Tva/33NFL8iSGx07x4yaScj1Y/h2F3mVe2++C1yp5E0yPpiG0lNzxv31i/2vtya7icPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2xKEywZUym6jhE7p2TZF32neNd+dPeGMamCKLZ1Nts=;
 b=G4JPpuKc8GjdeTvGjE3QhVdm4FnyVCTgYxSwhBoFMUUGJYUiKJpEG30sW2ObiDqV27Oby0q4YKAtlFsCx77sbm55m0//MTDq6WvqcKu/pB9asfaR0//8Fjog3kYgJ7U7Bk1O2xYRVmUGg5M/t0KxF78+lH2VkYeSCZ+o21mVZZn8a2vZHFgDjoHxn4WMJ1M6dJ5czgWFsJsVgset9MNyQLrhJmwb5W6LeEaEZWqVfalhPhf09iuB3ob2w69MOV6FckRc/NlenXS7vB44Abf+3Ujrw5CVmMwld8XPMckxgnjQPbM6jM4azk0YPDcvRlRwvzf8Reu0n8g2iWWCnN6ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 07:02:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 07:02:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 7/7] iommufd/selftest: Add a selftest for
 iommufd_device_attach() with a hwpt argument
Thread-Topic: [PATCH v2 7/7] iommufd/selftest: Add a selftest for
 iommufd_device_attach() with a hwpt argument
Thread-Index: AQHZRwELqjRG3HURuUi4V255fLJDm67dqrFw
Date:   Fri, 24 Feb 2023 07:02:06 +0000
Message-ID: <BN9PR11MB5276995EF79AE2557ADE27BD8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <7-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <7-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5881:EE_
x-ms-office365-filtering-correlation-id: cebde942-7fde-4233-6016-08db16350a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFVdptUeuSJ77dTr4gb1Ryib7//UD0J4lgg5FpD+qDiABKS7iTW786eZO2OWHN4V/bgfsaZyh0JNpFv37nj4J9fPzLPHbufnRojF+v8D2Y71UpuHs1sj667hodTRw2vJ2AX4XHeuwU6jZho3cbmvRyKcDaeI/rsD7sqXByCtHiHmMx33dc9OxENVezVSG5rZ4SThZ07QSPgsHb8zkz/wJoJVOV8wKUsBmOJVegKvoXnzN7vPHo3RMveedBaAze1HBfcK1quoQrw07LtTMkARXWjxFLsKSayDZBWgMC0hIMnJMf6213tolXVDiNuVhfv1r828qHL6d4LLmTbg/Im2Bococ0vWuERLOmR8hjGgTE/8xM+IfiDllbrxJu0tHBxb/P5uEdvxlankIwgJPJDPrUwlS53nN4A1laOYC4Ga8NX0YJZMe2BZwhiTU4Mty5yTzU1hByqYaEUuZYQp0jzta6IGgeFCKMKoTfkft91EL7yNCp++qf9XI5jsvnmsq4uHXei4ONHesb5ydMOLt4ruj4c4/EUWm1MsDwn+61e8GqholgL9RMPKGR7TIJghJvbGgrtRkhQW1N66d6MPepIGGKyA1mTXAK5RBe7ekyceUNsfAbRVyvuMI+LDo6rnpi+8W1xj2ZYh8g3DegRb0GrzXUnFWafBfDxUQaQEooOUMRmaUmB59DVlEDgIF9N4W88jElJM/KNrYR231BQRWc6Bgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(41300700001)(82960400001)(66556008)(52536014)(5660300002)(2906002)(107886003)(110136005)(54906003)(7696005)(66946007)(66476007)(316002)(6506007)(478600001)(9686003)(26005)(76116006)(66446008)(8676002)(71200400001)(186003)(64756008)(33656002)(38100700002)(8936002)(55016003)(86362001)(38070700005)(4326008)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xPIj0J1uzswZanYZpQNEay248GFuVOD/tXtS4VgW/jObFLLOgPf+sz/wqjt?=
 =?us-ascii?Q?/j9Mc3luaIl+ypE9DUrZnk4DHixcnwW9oyx+bcxnMzxyk8yXL0qR4Jz/80ex?=
 =?us-ascii?Q?cbFrM2FEWbrxYRnh98QY1XANN4GyIlOvx0L1SIUFfwcxfDmOgeT7YrR7srFj?=
 =?us-ascii?Q?5DHjODdbb0vztjliTFRpD/DzI7LxKXJEYmEQ2zsqo/PqFWhuVH0XFLRaqP1s?=
 =?us-ascii?Q?It9Bctb4kfujltDY7BdyQAzegCOK8eSfMP/0JoA3xkJGpLEyJib8YqV2zdzr?=
 =?us-ascii?Q?rGvnoFJ8hVGaPA5DyyJDnlM+R0UMSsi7TlE2lTVsp9Xzl7A2Mmr/LLPxEhK9?=
 =?us-ascii?Q?CxZWjoj4BftID253GHpDrsGJxTQoGsged6Te3rP9IHkFgIzIDliRE9eesqB8?=
 =?us-ascii?Q?8TDrPRPQK6EAyef9GMZPP00XPcIsoYri/DNHCcturDo6uvP4FN66I6ANNDWD?=
 =?us-ascii?Q?lHIBoBjVsiiA6lqD9BljafR8J5sE1QyWDn1Yb4f+oqod+SrMTfbbrS2vtf2z?=
 =?us-ascii?Q?KwFOl9qGbaknaRcXC1rVMycQ/Wy03/6MYuqTGCu98GO3DTXCBzUXgCk5e5IT?=
 =?us-ascii?Q?BQy04JzAIAk9VwiaPo57ck7xk2wv5ard2HGAHsOYivsCNtfKUvG4aDXZo4Qv?=
 =?us-ascii?Q?0/jZPACk7DiZ4xm4gj7ptOCSoBOhtnAEN1AUIx1zDpedoLPQwGv3T9E1gfwO?=
 =?us-ascii?Q?QDr0psQnTg7kM1c/ZSqJ+2PPDKfkLWTFkL6FSqZAIC6Amf/62e/vJPrD254F?=
 =?us-ascii?Q?Li1kJ8/NWSrRw2OP7iVi1LfnmzQ4M6ai3XLVeSi9M2vFPm70wAg4XyJDcSmy?=
 =?us-ascii?Q?nqRaJzPSkiG5OeOeCfSBoMAQtN+UR96AeZmejY9qGhrsiTn2/rbDdFaHXbB8?=
 =?us-ascii?Q?kpwyTYHf4yb6pd5YIuoNTzGD1R/mLozEdwwVxvZN0HEJtmcmhkjtmXVBxgE6?=
 =?us-ascii?Q?565EbT+6+F4nN8mqfHlBrxnEJ48ALrh0UhKrnXSBjGim/VYbcsjyprhfM/qT?=
 =?us-ascii?Q?uBitme14WKFG4r+BHNIqzLEbwqgJD1aedZmn9A0xvNVSjhgfTDm2e8n539jG?=
 =?us-ascii?Q?OXAUpMfLAmlkioi0uxua37XdXFjUcviiK3n//WdxwHdYClCE5RC6U88maZpo?=
 =?us-ascii?Q?YFzZQxUlyrek5ET0OKHqna0JrWKYulvVNRADp1eVW0pz42qMa2+oM7ujwJ4l?=
 =?us-ascii?Q?XwMOAXBPIhhprEbrg4jCCiEImd1ccTClPyRflj1GWCvGIIYAqGXxervvsg3/?=
 =?us-ascii?Q?LxRKuMcPR6SaT2Na22z/MCeL49o0P7d2g9vGapJT9hxpd9Kjg0oJlzztCbfI?=
 =?us-ascii?Q?bAZzDZbHoaHbBrhKK9KiSphCTR3J+dWP26nNDHaXY5yoklBgzXsHCkvbDvYz?=
 =?us-ascii?Q?me8/l0SXJy9O4f/0olWq6dYggprGoyqUwewy0T7rwVHxsZlvRIa+sDsi0wRQ?=
 =?us-ascii?Q?aSOIgj1f+93kCuWbx7PRTaZEAXn30Pizexpd2fRx8gmPZR5saxJBDuAwfF0t?=
 =?us-ascii?Q?XHPuznCCcQgqaybU2VXQ6bVdh5IyjuKnVd3vWjG21OYr2RLK9QAhi0zU0J+l?=
 =?us-ascii?Q?78toXobEsWeDE0iN6b/BKoYsRJBAsCBl2oLKFPWl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebde942-7fde-4233-6016-08db16350a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 07:02:06.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVtB7pXh388YMYUDduHjEuaEKA/F6FlSata8s/iEBtOKACcvs64C4T1NYJ4a9pSdCAcBJO3Fx+HuO1clAzXgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
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
>=20
> This can now be covered since we have a full struct device.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/iommu/iommufd.c
> b/tools/testing/selftests/iommu/iommufd.c
> index 0c4bbd4079a425..69cb79d6a0711d 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -187,6 +187,7 @@ FIXTURE(iommufd_ioas)
>  	int fd;
>  	uint32_t ioas_id;
>  	uint32_t domain_id;
> +	uint32_t hwpt_id;
>  	uint64_t base_iova;
>  };
>=20
> @@ -212,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
>  	}
>=20
>  	for (i =3D 0; i !=3D variant->mock_domains; i++) {
> -		test_cmd_mock_domain(self->ioas_id, NULL, &self-
> >domain_id);
> +		test_cmd_mock_domain(self->ioas_id, &self->domain_id,
> &self->hwpt_id);

I didn't get how this works. self->domain_id now means device_id but
other references still take it as a domain, e.g.:

TEST_F(iommufd_ioas, ioas_destroy)
{
        if (self->domain_id) {
                /* IOAS cannot be freed while a domain is on it */
                EXPECT_ERRNO(EBUSY,
                             _test_ioctl_destroy(self->fd, self->ioas_id));
        } else {
                /* Can allocate and manually free an IOAS table */
                test_ioctl_destroy(self->ioas_id);
        }
}

