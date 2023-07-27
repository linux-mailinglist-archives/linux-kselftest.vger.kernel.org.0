Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9E764D5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjG0Ibw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjG0I26 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 04:28:58 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334155BC;
        Thu, 27 Jul 2023 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690445739; x=1721981739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G+9SFEuBqhb03RWWy8hROl8bTq2U2RH8kY6YtRxt364=;
  b=YaRsCEOin2EJInLmdRZEEybe/ZMEaTNOrGkBOG/71sM7V8FiQJH/IaTB
   9T81Cxwr90NMDtIFP1WztTShC3V8qrRM1///S3HYnr9TkyQJdJgpYhdG0
   sSto/yoE9Uf5EILlxMveQEDqlcscpMbL/aA1bctOCMAg5ZeGtkvsUASN0
   OHHjjL3Bg1a4QU9acv43T3gcJsK1miaKswzLjleP+NjD1nt+Ey/O5MV7v
   TFvyg7EbCPrqzsfderyXag0tw0dk8vUmkqI6kTjDePNSxtaMvJNFwZaxr
   B47x2rSKduv/KIDAAgxCCNOBt3nm1X703fncOMvVBy0vr5D3SVt0nnGEt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="370917228"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="370917228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 01:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="817015933"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="817015933"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 01:14:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 01:14:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 01:14:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 01:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehZHHrnCfct9JcuiOCsUbr0F9sykjX65aV4WYK1UZH33zD7w/MeC1v4IokWeQZR8y8ukO+ZP6qj9qw29vWlrDL19AEoBO+7pCavrToM3Ddw2XWigkzCPka3jJYuHV/tpzyblG89zEATpeqgEv06+HoWA+/ph4UaxYn/RHxEJhFIdnvKTebhxhM3EZ0IZHDiJiKtE1LjHfGByylrEsq5Z3wxC8eHTUDJdEn35X5JfLL+na4nKNRchrPpZGwQ/zTtQ+Voojw0pzCB5PZt8uS1ZzF1ITK3U+ZQj9ZpCMQs78Et+4pFMNzjMQZdMU9QgZ5ra3Qbg5oaBBGi5JkZLzkNDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44bFIsY8Ugwz/Vsvwz+W9XLAeFP55+CpjGwmQoz7CE4=;
 b=cAGrE73lz54mQB5A6+R85nh53HkW7VsIhON8GsL6h8JbkCdOdg4iXl2T+6U8Zfskt9Rn15cDZnhlbrh+0cMtMLwDIU3A8nH8UdhLk+EiAmjjCnZeOdJig1bxOq73iNjVg/xZhx2+2B7mrPS8vf1Bs2oByHGKJMtcxMfLKOuvlCbwwGr5aQQrm6ZQyxU+Ig2LUK5QchWzEtsHD5JzodZfBrBXMSqFFAhUXlf2GsYmYIgbxYrECXq+/IUK60XBHhSekPTvkzmi7G+sX/5q6uJJGujgVc2pOD0Ad0bma77yPsjn/Bdr0SjDXR/Fm1+x7WqIjwgqYjxgCKb5w0sRVct5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:14:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:14:45 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Topic: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Index: AQHZvh39pjev3HWHHkqCl2UrU23cMq/NSB6Q
Date:   Thu, 27 Jul 2023 08:14:45 +0000
Message-ID: <BN9PR11MB5276E70BEC76AB3D96CCF5028C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-5-yi.l.liu@intel.com>
In-Reply-To: <20230724105936.107042-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5043:EE_
x-ms-office365-filtering-correlation-id: b487ba43-9c4e-43f8-6361-08db8e798997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3W39/E022eJxVLg1bUAG3qaI+yi++9OlrfvbiqzFRESllD88nh8HklF8b+YNMSH/BDfjsrds85ypwhR1pJl26JXc2ZBXymOXGBe0vbPEK8ylR1mtG/unrdRQ9OghWAds9PzHt48q9DGYVW2OeDeozsdYqaRYm4wuUp4uZWsAaNAk0n3TGUPsEpbyM3A1DTrRzdIRXTbtMlT+iYgqlbZwGPGTIqpW10jZRMc3SN087xoA1/Q82zFrfxi97fT505EbzP0zQjm+D2qnAQN5VAD/ggicwCaU7rRrlojDGlDXRJcFgea/iY04dccZbeL+kSi6MsH/iq94OSWEJHHv0j82X25873zk6InA/6+vUvDjHh3G7Bc7UjVq6Zv1KgecXWolo4vadQkBp+8BOZMvmZLDgY3yFgthQIWn9NK4YR2J6K/xzxUbvG8dN2QB35dIyC9pXFDgQDRujPFo61hpKKMVs2rWRBxPSh6KqxW2dnc40TxwzHU8P2q/ZVQlTo4tWb/upeigo7kobZgJaqCi8V2Eehc+MR8Q7kyYgkDKTNOZdBRoYFFbRYotmjczvW4kbheqZRSzv48d8yt26z+a/6513eqtKzAqL1MviEMLH7h9i/RSfnPVTEoEALMlwO2LXqHa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(478600001)(9686003)(54906003)(7696005)(110136005)(66476007)(71200400001)(186003)(26005)(6506007)(2906002)(66446008)(66556008)(4326008)(316002)(76116006)(8936002)(5660300002)(7416002)(8676002)(52536014)(41300700001)(64756008)(82960400001)(66946007)(122000001)(38100700002)(33656002)(55016003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YFPUghqFxzNJCB/S34aLO4DNXfxHBRjlCGR3prsp2jjZijODoK41FvsjztCr?=
 =?us-ascii?Q?zLEd2fjLZ2EP3Rmup3rbgNdiWRzKDMBQvnFK3UMPicOTmwJEe7ufF8aHUL2D?=
 =?us-ascii?Q?V0dRhNXB7IuJAYwefMUtwzx88leEuB5Qz/iftr7Kjs6+PM5E5cK5rlMr7apA?=
 =?us-ascii?Q?bupSuvnIJK66Drh8Z+wX+ABwkj2TjH2A3hbZiCAPpaz+BKB0j88OseoyTixS?=
 =?us-ascii?Q?yxRCuEbGkmviTVAzZaxKOW/A7vFczf3RLOdPQmYYWn4lKOBsZb9Jxm2BSbmk?=
 =?us-ascii?Q?St+Czl2EqhrxpbGrhrExXFFa0G430N+Ch3xHG8wSfueybBkROVkBkFRPHE5H?=
 =?us-ascii?Q?EiTSxJ//dsf4zQetv3G6BMUp+EzUNSuiVnZRHzOhcjhCGSXeNw+gdXT7XZ7Y?=
 =?us-ascii?Q?S5HrCWreaPma2+xzN/T8EtKdYTPAUg2BQjQVNp8w2x9yf+WFOVX0NQtU17L0?=
 =?us-ascii?Q?voikSaMLkWFsFHma0OtPglfQSEumMnE/aPwrq8t9VD63NDyIEQc/g3a6mXV1?=
 =?us-ascii?Q?WKUQR6f/b2R+DR1K0jxUtlw5hDsRytIRjVwapkltVsta1obe49BxClzctVQS?=
 =?us-ascii?Q?o8uD0dGRsT7sSXx+eVB6HLtSWXFmAxhZsTRZ6aRlhlt8Qb2jJbaSGYLk/9D8?=
 =?us-ascii?Q?2Ikkx+061C57O8YX3VxgiuQGoYvK9t1MSuOXDAnQvvMLAcsygWILc1llTDbm?=
 =?us-ascii?Q?HbGfojyGnSKgsl+TEuN6dOxeojutT2MqslJ5EfaEqPSkM6NpiptEMYTT0eUR?=
 =?us-ascii?Q?yeCXVHv3+KtAxPFCHCRTXGI+k+O8QCTcGmx/FAJrmt5/2uLvD3JSz5ev0pSv?=
 =?us-ascii?Q?X8WS/XEzlZK1xthh9mPS0bVMcshAIVnFJldifRcLyrHDRizE95TykmNccmTg?=
 =?us-ascii?Q?hvgap7Ufp7tD3B6CdeiqlFXzBHfd67T+4pmlM0ld4ck9mIdHLVSP1HKbXP+r?=
 =?us-ascii?Q?gw5QhgJTPc30OakUnDpev4U1xaPLo7gZUpkWXV8AqyTGP/MKGcrz3VTTBb9R?=
 =?us-ascii?Q?dg8C4DogibhtSoeGeUbN+FEGJ3arLZdu66Rqaazp9CsC7oHvUasz9qFNQMB2?=
 =?us-ascii?Q?pLH9peSqLLZUPFJvLZpMU+Y9QChcK1dODORJ/uHCSMVXARIhSWkiRGuLxYta?=
 =?us-ascii?Q?TiCH8++URxEYpYt7D90vBXAXFohTik6SNjrWno+xvNGVHoBK6ev1/hUtCr8Y?=
 =?us-ascii?Q?CkiNwmW8ZDbTk6FwYd0YMgM5W5wUPdyMy8NpoMW/57WWVx5uV2Z0B9nJ5dPP?=
 =?us-ascii?Q?318iM6UIkJq2eFWNtAwrazuaZetVEcwUE4CL+T0m6dFgOwI4096pnIz5WYiA?=
 =?us-ascii?Q?ltLVx0sVBNLbm9TOclU8DFB3sd7K4Bpfx/4M2NJFxhRVyfXA0igbQbz34n8x?=
 =?us-ascii?Q?ryPBIi2K903Jh/x4VoiEQzHh9HKNe/LYQR1VE41oQQLt9ALhsVmNg7Ml2I6A?=
 =?us-ascii?Q?3PszojJBP4D06XB/EDaDpJFfs6MXvC5qeyYVm/QLoNG3yCtjWWrHjoYKaf8j?=
 =?us-ascii?Q?1LRfDDNPTUy4ZpT5hYDiW9UdHFaosBjVFUqCgBw+GHNPjjpXpKkZ1ONSjAUr?=
 =?us-ascii?Q?hBVMzn7lBHLAbZQ8lBTD8z/mk7oPPp/sO5+g3ADY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b487ba43-9c4e-43f8-6361-08db8e798997
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 08:14:45.3606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4DdM8DQ37ar4VlSeDVJ78fZ0lowWGPtsoWDWjR2RjctTPgnVHEGnVDdwn2p3Bmhuhy6YBX8Zb0SARQpHGXDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:00 PM
>=20
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -8,6 +8,7 @@
>=20
>  #include "io_pagetable.h"
>  #include "iommufd_private.h"
> +#include "iommufd_test.h"

Is it stale?

> @@ -211,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
>=20
>  	for (i =3D 0; i !=3D variant->mock_domains; i++) {
>  		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
> -				     &self->hwpt_id, NULL);
> +				     &self->hwpt_id, &self->device_id);
>  		self->base_iova =3D MOCK_APERTURE_START;
>  	}
>  }
> @@ -290,6 +292,19 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
>  	}
>  }
>=20
> +TEST_F(iommufd_ioas, get_hw_info)
> +{
> +	struct iommu_test_hw_info info;
> +
> +	if (self->device_id) {
> +		test_cmd_get_hw_info(self->device_id, sizeof(info), &info);
> +		assert(info.test_reg =3D=3D
> IOMMU_HW_INFO_SELFTEST_REGVAL);
> +	} else {
> +		test_err_get_hw_info(ENOENT, self->device_id,
> +				     sizeof(info), &info);
> +	}

If self->device_id is invalid it should be reported right after
test_cmd_mock_domain()?
