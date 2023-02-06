Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1268B7B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 09:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFItV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 03:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFItU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 03:49:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459FD15CAC;
        Mon,  6 Feb 2023 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675673359; x=1707209359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ZqVv58/drZ8Qm2WSY+SDGRxc1MJjEL1cz/KIxCuv/A=;
  b=LcpNftc5MViVXMdQ8hF8oOppwhPcf819cQjXaNQWGAIcjet8V6U1Kn8D
   ErRTnB5RU0zgyI12yW46AzfXQHIatvStsk8WlC7/gd/7osfAaw5DD/tVv
   zyJgLcZJ/XkmUKFS9D05TeKy5KqOXdYVNwPJoGmwO37k9Vb02/+38SyFo
   0jC3WLh//HIVErxml7X6k15oxOFvGY+3AeF9jRHr/kdjCd7PumnnJ9Dh9
   u5bAciG1gHtnwGoJtbwO+x55kE8Jy1TXrfFIo50izVoxmGTmRuvsLcj24
   puNjMbXKV2Ri2lVS/F6PqITSl2K+1s5yxHNOVYhN13GG1J0rpiKZP5zFQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="391555363"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391555363"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 00:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="755178198"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755178198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2023 00:49:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 00:49:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 00:49:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 00:49:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLYmwaeTPkMaWtIEiFlkWFZ9KMEOMDJS5X2dk7Hw2C+/bYerynxrJ4/fVYGkseq4RBfsT8RnTbHw6SBGy8KKe4NpGa8CR6dLoYzh797EpS4rySJqokcey9N7b2T3CMjUZ0EyKhh3ExX6AFd5irBpCYvn6xBDfG+HXYF/yb6naicggJBj25qZvDnC19C6gVV0BpCrm9sFMI/bUYoGISdISryKtLsmn7pPj27MI4e2CRFiaULgQB19yjLttWurys4/Fujm615IHSszf1XXLbhGegAbKHxMV7+qmEbkBRXIJRuS+4tkl9dw4WLoGVYj+LJJtPc08tpQKORwncYGLVCLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcFpxS2s9MOcocTBVpMKIUmOxsW7jOdHsE8kPU5z4k4=;
 b=S1E4AiQqpX6hY0U/Lh9uQl20gT4k6IKTrt+hPYnWbrMJv1nLhyu7H5aLGMEetJC1Il3tGNjG0GOEKeX2nO2pXT20v102+FhqEJ4hZT9HVc702hJcZf130mMoNNERr0AmbSi26IvL8OFfb7aQ3G3ChschCsSzvb8k5MALJ7MdHfsnEBdOsKXavuz2yTboyVLiZSyu6J0MasjdJiT5Ebbt0WaC+10bsMq+Y0/VRok4+c3G6FWWU1GcvmhrmJ3aEzKlsQ2+qtgt/JK5WK8nkE6nH8cA63oYfauj2jj9WHBEaxTnZ4nUMXWhAzTJl8bhrp6CJinc6JrAiCQ4qq/EjUDolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:49:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:49:16 +0000
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 8/8] vfio-iommufd: Support IO page table replacement
Thread-Topic: [PATCH v1 8/8] vfio-iommufd: Support IO page table replacement
Thread-Index: AQHZNtTNAxNBEby0lE2dVGWKZ2MA4q7Bogbg
Date:   Mon, 6 Feb 2023 08:49:16 +0000
Message-ID: <BN9PR11MB527655AB356F73CA193300398CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a85ebe54c2fff9ca134a33cdf8744a7c1d66feef.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <a85ebe54c2fff9ca134a33cdf8744a7c1d66feef.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: 33f11cd1-c478-4437-a8f9-08db081f076d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x31WVj4BLQISvaeBSarjHSoGYNdJ7eQx5wfCkSiCWJks+5lmFmaQsztkypsZEMMWk2muYp3pZblkfNxptPlTzPRzg+++gKXO7nhZmOamvgxz7kyEcaBEPj6CUqQgpywGW64hzL4mWvOD1ai9z3jETfEb7wMYWGvxlUVJ4qqYTJy747yY8exy00rqEEM3Oloq/oLyyRda9ZoMftgmqKOKKofpAnu6p0b0BC1BWqLJjy5zBkMu3+NzQVdhb3hrfJy/P8w/b4UaOvUS2JlEw0+rcDtF0+h8tjExsWpUlZMbZyRmaYEOK5y6tm26T2eUJBJuPvbp1kYnZZw7l3OJqSJyy4zl2KlFuWhaIAqRc/u9BBfHAA9G9ED7lYSBX59kAJHvk75Lzr0BmnlZXdtK4Ql+zKOz0cezHF+j1ZOcnBemKE/vpQeOMKlZPH1UiPSqnXEAtX4wdpCcz2KjxTaSjPFlPOB+imC5BA9YmH6SxKN59izhYnt6gVcVQVywaGCflBkBu9xlmriohTTE+ekkKXKCRX6MtTVeaiL9uMslC/PuECZocDD4oClqBkIqkaO1lYbEuFpoczdyG+BbB55DlL8BvkleJgSiAudy8a+whsldpHETHlmI/qaSpijxmV9N51eFNzPmRcE2jt5Vo/tQ0vVnuZnm21I6JmwETZpUeVktYCl0Iik8fQtrYmOZYYDACIS1K3Yx6NuVBwFNn0EZ7Ag+kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(82960400001)(38100700002)(38070700005)(122000001)(86362001)(33656002)(4744005)(478600001)(52536014)(8936002)(5660300002)(7416002)(4326008)(2906002)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(41300700001)(8676002)(55016003)(54906003)(26005)(186003)(9686003)(83380400001)(110136005)(6506007)(7696005)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OXksNhZfSWTE4o8EWO3o1gB75k4ET5aUp/HCC+HREmGY1WYs6erI6ST5bdct?=
 =?us-ascii?Q?ABB17MFy4A1UFvX7VC2/yWM2et2ZYpJD/xSFoY0BdptqyiH//p1U0mCqxm57?=
 =?us-ascii?Q?+PmPzLdArytdQJvf82nqlYHWdbg0AWNU/13UUVEyz9gGMLw5Qo0a+Q7F3km/?=
 =?us-ascii?Q?+L1UiBnbqMf9rG7nzAJgLwnTE0MJJ7DEHDbIVX54LPKD5PHfLtZl9SV7bAkH?=
 =?us-ascii?Q?oz2s3XKot8mGKcTcVB71yrgpnC+O04Cl/XFBewzh/0ShnjGZyOA402iCX0Nw?=
 =?us-ascii?Q?He/6tqkD9069xHK1BTiElsVFP7IGq/44Rer230yQxiWnfV+fTuIohZGqJ2GG?=
 =?us-ascii?Q?X7L2tirRd9Sax/L9iS62kiuxmxroHBtUmhjg++kOCZsYytocM8AWR95zF0VT?=
 =?us-ascii?Q?7chSnH8preBGn5Ernng9lYMnv2moPeZ5UIxAitqRiYnXLI+bzjUPDCaeq30m?=
 =?us-ascii?Q?eKHADGHJKQrRt+Zj5wBqysDQanw37mDzdLBOvi582Q3qzRb2/y3UTeAJ334s?=
 =?us-ascii?Q?SHD7jnFY7MjNsn2CscHE34kyG5bH02nhj2nEUfsT6o4SKeMM+mb6u2nAOhVh?=
 =?us-ascii?Q?0um2+08B+SkihtlRCzK0P0RhdB+fJdMFQ99JaAGW/pGwsgr4Fyqq37VR1fFL?=
 =?us-ascii?Q?IZ4OnykMH1m4A9OaovPQSEdgDZg3lUlzWSjm6Q0PFhhDtvpT27ergb1ws7vL?=
 =?us-ascii?Q?uCCictifDLuIeUGS6XsQY42J41dbotJU/rCtWRzxkKou/aYE5R82PuPXqUPc?=
 =?us-ascii?Q?Iz6EbdfDr32ZKZs/GUCIm4bCNesUBSarLsw1FCPWWE4A6A4NL7mp4eKTSxFy?=
 =?us-ascii?Q?7IjDcTJnvN7GSJc+Uv4Ia8wgYNfL7NfLtGiSN4Z23cAme5e8UNEx56ZMFXas?=
 =?us-ascii?Q?V3TeLwaewGWKgPjxrP+YWpBbOAAYYGWH3vjc3d4ER6CSupmk/nwyeAuouja0?=
 =?us-ascii?Q?nyXE9HfoSpU5YFEHohoJcjYPG4RZ5visnz1t0e7KKKOY6oTmM5xoXcHEnRho?=
 =?us-ascii?Q?pOjoGh05YTjaPq9lcR2evgNZ6tvQBMot8xF5AxZS+J6tiYtzaj/7fHclTQyq?=
 =?us-ascii?Q?bhWwFA9ym5f5DJxGKPgEXlbHNx60dYrbiSZhDIlMjPwOiKalCFxH4sxckTAv?=
 =?us-ascii?Q?PL4wHfu+GxaB06wNWiLdcX+8ALl3hbceLPMZkK+xwiUxLFWf9zyKR8wko3g3?=
 =?us-ascii?Q?8yC8rUKzTD/aeRSx+SUDzOF6CLDBMrrBxiTW5BliCZWvKOiWfLjtx4eE1UIz?=
 =?us-ascii?Q?x98ZByL4FBj5qMoAuR+cNb7LfH5VUYoVkhqZ5qeZM/vkvsWyJfhYMt+Anvrl?=
 =?us-ascii?Q?o4xrxurVUkgXLqIORUTjtbAzm8tr09uwXZHaZMgjyLYQcx6MqNn+mA/c7g9n?=
 =?us-ascii?Q?RhIuIHmMaoEiiBi46Djt70H+oDO6DlGBF5x0Goll5AJtX2Tthga6v5C02Szn?=
 =?us-ascii?Q?8bGaMf3ZBQGheBfELzMfjiJ+F0H2b8RbAdpXwK/4A/Z5zQ5nR+nNsmGthYXH?=
 =?us-ascii?Q?85iHB1o2MFhokMphCefW1gg6VvYwF2B2arqqfWrPD6SUN6m1B+OQTr/pfOjw?=
 =?us-ascii?Q?vQ00kNayuhdFfBQs4ry8ltuwcCF0mpPP7zWxo1B/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f11cd1-c478-4437-a8f9-08db081f076d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:49:16.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uorJ+GMSnvEJmIa+BtTk6fl7FqPLqXzsmlLWkWP7NXo2K2EW9aLfC/qPNkMoz7HncpcQqMDT/ZC+bJncW3J0xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, February 2, 2023 3:05 PM
>=20
> Remove the vdev->iommufd_attached check, since the kernel can internally
> handle a replacement of the IO page table now.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/iommufd.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index 7e09defbcffe..f9e89b3eef69 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -111,9 +111,6 @@ int vfio_iommufd_physical_attach_ioas(struct
> vfio_device *vdev, u32 *pt_id)
>  		return 0;
>  	}
>=20
> -	if (vdev->iommufd_attached)
> -		return -EBUSY;
> -
>  	rc =3D iommufd_device_attach(vdev->iommufd_device, pt_id);
>  	if (rc)
>  		return rc;

also update vfio uapi description to explain the replace semantics.
