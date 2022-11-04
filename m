Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE26192C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKDIc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDIc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 04:32:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB18275E2;
        Fri,  4 Nov 2022 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667550776; x=1699086776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qaqIB0DLjDa/q1nJj6Jd2LMoKIF5bSoAlMvTirS7r8Y=;
  b=jl5AglLL7hXML7PdxlcRwtRgOq7wl6bldxN+paDU2pbuO2xx/qIJVfKs
   lSapNrVc6pO2YexeFWJI0K5ULrc1qkv3YA8TKxpupRhs4kXTU0PNcA/Jh
   /3rbA9ugeggd8VaQsakCZH3KX3YK5Pkf4/A012Zw0vrqJYHu+508jYvyY
   MRcODRm+mz+G8WG6W/fADAZgVh58TkGq0Lqwn2BwYUHOlE7eN4LbcdMNT
   v4WV/6uuetOz5cPUMMz27PeMh8DiiYm0CAj2Qd57l3C5Gp8vw/THthbVG
   L+jxt5S2d7dXIVe0WqS284uuXDtNC75kJ+3UZrxhs+najB64Z138u9kjS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290303266"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="290303266"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666291185"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="666291185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2022 01:32:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 01:32:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 01:32:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 01:32:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 01:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu/P1fmUugNiBjf7hF3RW5d9U0nLlZAfLZdvx6YppwGHjSLJclUd1b84Mw2NsKn7QmemHNjaPdQ0wJ98Kr9PA7Wny15SOKOam7mziF/mh3NyBGwcIiClnxLiASs5/60omyOsEYNk3rcRp9uCzz2LPGFdZIuiISJFCGcPiwkfSGurjMQVmsuW4/xpqkJjAB2zy7PSKTMSWeiNZvrp8iFLWOauw/Ng/XWoxdCoq8imb8ASoPj6qsgEUK0br65DT5EtJRO9eCkyYLyUiQZCWdDBcm+5eTt8JFoTCskq34DPtG+taYG0ZH54W+bqzEB00q4ofc+Twd+1v/S6ibJLgvL8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEGAH9uBeuAF+Br8ZTyRf7mEzNhrjmxZVsmjgBGqPfk=;
 b=DyZLVN9586EnmmcddMdXB/mzn8oFfz3Pa2oGqdTBJeuAVmmiMIgNQj/QR31/8xz9K8qqlxxgLQPwTwvthDxsKeFSKyjVpg86dNi7xxPDfvYQ5/yau0w/5NzyrDTji3hgZh3mD0Fh/GHGKsHuWy5fxjF60S+bSnHhZeXzK/FHIkaQUFXGXldEA9TOyjIML9LocEC8S/d4CuLUuvQxtuk7iV3kzyHt534j/G2JDkZWnGYlUwcBOaX2gZR/dCsTuzLChxm6jwjGnm4ycnBNmWDsIOD3cmW4rrk4QL1IKALGWxbdg9FU9Rpfb/dRkhbOvEF3kepCHS11JWEpDyjx2GpS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 08:32:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 08:32:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Thread-Topic: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Thread-Index: AQHY6J1k/MYko282jUa1sWU0zIDdtq4uXG3g
Date:   Fri, 4 Nov 2022 08:32:30 +0000
Message-ID: <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7511:EE_
x-ms-office365-filtering-correlation-id: 1af0de13-fe65-4e7e-7430-08dabe3f1d30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72pkc4N80OliOpi05lq7jZnVBuuCF0KQOllFGXM6Ta9yUaWCXMMZ/VOQGfrV8lSb/AQr2/CpAep9/tieD7xbd++rmMf0brMgzYIFTvaZ/fsYf3jFHJTyMJKrBCWX0WZF4Ntjk88IaQus12iOj48mgl26jLzRHphzrb6d1sXKA0JS0xBVqvr2637dbipubnrk94xmYLJ6TgBt8UpHbNTAUYBB5W7dBaapeZ/OJpqY8KAltHfumfWEBpHW9qk9RYXAmFJzQkx7kngdOQY7Vd9/NoYm/5kqNpXtec3dAI15iQlK2ePV85ZdsXi+soaj7lEwHQlyRFLKfD0usI1l7RWv1evzBqJl/fGPRd41FaD9FpSjPjlHPADumE9/jPkNTE7T4rggz9TsIciL6bBAxINAEOBmF531yPXUmCWkWl3n3YOky0HvY5Rk5NlXTHAiWallBJ6kxjnv9+bU5cgx2Beydt46bJsni+sEUOoYQCC6h/aV9KpWEJrCY0oXFHhVAK45A5PzvjohxiJTTE/sTqSUrVZ1eTf8kcCyhi2uP8Mmkb3cMYs7MAnUBCtkaXYx8I12PXAPhcvl5aSXJTjOBXqBnkXO/GZvov82YzXaCUswf0OHnssIVCKMs2yPqLP98lVokU8k59nyQO5xfKwRIyuqAny5z0Ad3H2Fo23rxVXWi9sj86pIsZVgq2N4UTu/1miw3oNQrNbE+8mYRQbFsOtUsSlSl4/dcXSDXL0qN5mTka0ZLaSuq/cu6wwTG4RS7yJF89uByBv5itlDUJt4e+2ZNh95L+Tn2y8HiPWwlSO3mOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(66446008)(7416002)(8936002)(5660300002)(921005)(82960400001)(41300700001)(4326008)(76116006)(38070700005)(55016003)(71200400001)(52536014)(8676002)(33656002)(7406005)(83380400001)(26005)(122000001)(64756008)(186003)(7696005)(9686003)(478600001)(6506007)(38100700002)(66946007)(2906002)(54906003)(66556008)(86362001)(316002)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Haz219PgZdje3qN6FqAA53uCPmm8esabpCGpIOk2+YsWedBRrXhuPXuwHm6?=
 =?us-ascii?Q?21OHXY3e4x8GZL/86Y/GerX7X7YgrIM/H25HFfvJcnNMDHyJQKn46oWebwcn?=
 =?us-ascii?Q?0xz6FwnQ5fGaKUMZGd91ShSCUAu8y7171DH58gobox5iuagIsqZJx+gW5cK/?=
 =?us-ascii?Q?tTdctpeCfwUKRBxtV6go58RRQBW9jO7bnKBGj6wh26oL3ae8B1IEDez+4HYS?=
 =?us-ascii?Q?uurW+AW7C2p+hmakOpooKMVgUCF/jNu9VDvtAsIJq7AU4P5uXCfoslOS3v2b?=
 =?us-ascii?Q?vSTDq2AxUZuTWJizXhKQlz60IJ7MfvASIqMwGy4TTGpRnjqbK7X2mrtWSfqX?=
 =?us-ascii?Q?kXS/rmChY+vvmLRP0DNVmFI60I5jXUxcu91ODfz1jHjiKvmzjgNH/UVZYr8f?=
 =?us-ascii?Q?qDaWvBH+P2gLDplnCzcS21NigpNXnzyxmqg9GOoCrPN6x1I/raN/83p4KsTb?=
 =?us-ascii?Q?TJYEt0A5XzY2x/iFmBQU6iRvJPFGjRCpWdfJ2D/LivYPHJCkUHgu7hz4/+DF?=
 =?us-ascii?Q?wTzECL3Lqiu9inOMyb/0KeblEYUbC60QuqvIRjO1WKuWwBNNEBIhz/WmwPhW?=
 =?us-ascii?Q?oaPjlBgLXSKNRsXUgnMKYu2LvkAEUW9ElxA7ILbAllz7UTZe9/wGvqK1TIi2?=
 =?us-ascii?Q?jQyGVL/g2T196hmOCPySDnFRM+0pAREtf8bU6fI2vFX37ijQjCD86sN1R8kG?=
 =?us-ascii?Q?k4BP507LSVKcQF6+7GXNu6eI8fTDj/8hfb+8vl4HVfrrN6C1z2PVQo9cuieJ?=
 =?us-ascii?Q?Tvise+0elIU4keRX94LjGj0ANsqqUjTH7qM8+LpqtBBFluGP4T0CYcBIlkCL?=
 =?us-ascii?Q?cwyRhfRlddhnU2hvelE/ZDy/MAXfYPIQ8ItkjizmWkpTJJW5iWdo4+289DcP?=
 =?us-ascii?Q?sEkoH/G+BD+4Wod6Pi7cGV3RFn3nNeNq3+T8o9S7fpYDB9mUJDo8p+6PUGf6?=
 =?us-ascii?Q?1mkqyTqmDrQzX6XAGHFrCjsj/6v64XCpGq67J8pEj3Rq8eGcEzrPBGggy30G?=
 =?us-ascii?Q?TYchk3LkkG4kQiXp7d4pLFlPKxq0cJT0Rv9W+C2s/m3KxVzecmoOSaU5Veh4?=
 =?us-ascii?Q?/zcIja5dk/I2xraVFX4Y2Vwu+YvJw/zd3V8HMPuVZa8lILo7eQ2xSt+/f2SE?=
 =?us-ascii?Q?72sAxd4X/d9l/q/CdpNc1IYYJm4rlDoXfwD75CmQN+0HQ3/JYiVc92h20q18?=
 =?us-ascii?Q?WFuY0draeKig6z2BOwh7NG22l1njg8VpPsFVtgextyhCFFpqHUqQmZXwQKI4?=
 =?us-ascii?Q?TKSkuIhtyeTB5v4v/Jv2PxbiTsfD5QvHNcZnoCvgbnzJtMLNFGwHvmeL9Xe0?=
 =?us-ascii?Q?Evhyd8TzAx22Zi50jf0OhqcHeN7lo1prmd8FH0RyhH0s0Uw7bUWiK5Fq/uD+?=
 =?us-ascii?Q?pALa/x40buhlexUmLcVaMEc1kuTbPEBTC6yW48Hfc+E/RM1vYvQ8SyvKYGuP?=
 =?us-ascii?Q?MuVsj2p438mORBCfTnUQ3VNw9r0d8LIGJ1EDr+24JK0nRTpDSTE0DPcyXrPQ?=
 =?us-ascii?Q?aC+ITk6d6ahE6QwxtPD45ZpLjF9MhNws0eAMVspPhNgoCY+7vfZtw5PBI3UF?=
 =?us-ascii?Q?y0Ug7b7kKUABlRv+Vr/vUd+HQm++vhG3+m3RAKh+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af0de13-fe65-4e7e-7430-08dabe3f1d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 08:32:30.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tG4trWrDgXScxsRSJG+ZMSv4FHXHXrmnpAsaXFEnMdcBF/JSwiAkRICG5QDDX47He8AT5B39GnWnQA29EQ9gyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> +int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_allow_iovas *cmd =3D ucmd->cmd;
> +	struct rb_root_cached allowed_iova =3D RB_ROOT_CACHED;
> +	struct interval_tree_node *node;
> +	struct iommufd_ioas *ioas;
> +	struct io_pagetable *iopt;
> +	int rc =3D 0;
> +
> +	ioas =3D iommufd_get_ioas(ucmd, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +	iopt =3D &ioas->iopt;

Missed the check of __reserved field

> +
> +int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_copy *cmd =3D ucmd->cmd;
> +	struct iommufd_ioas *src_ioas;
> +	struct iommufd_ioas *dst_ioas;
> +	unsigned int flags =3D 0;
> +	LIST_HEAD(pages_list);
> +	unsigned long iova;
> +	int rc;
> +
> +	if ((cmd->flags &
> +	     ~(IOMMU_IOAS_MAP_FIXED_IOVA |
> IOMMU_IOAS_MAP_WRITEABLE |
> +	       IOMMU_IOAS_MAP_READABLE)))
> +		return -EOPNOTSUPP;
> +	if (cmd->length >=3D ULONG_MAX)
> +		return -EOVERFLOW;

and overflow on cmd->dest_iova/src_iova

> +
> +	src_ioas =3D iommufd_get_ioas(ucmd, cmd->src_ioas_id);
> +	if (IS_ERR(src_ioas))
> +		return PTR_ERR(src_ioas);
> +	rc =3D iopt_get_pages(&src_ioas->iopt, cmd->src_iova, cmd->length,
> +			    &pages_list);
> +	iommufd_put_object(&src_ioas->obj);
> +	if (rc)
> +		goto out_pages;

direct return given iopt_get_pages() already called
iopt_free_pages_list() upon error.

> +int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_unmap *cmd =3D ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	unsigned long unmapped =3D 0;
> +	int rc;
> +
> +	ioas =3D iommufd_get_ioas(ucmd, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	if (cmd->iova =3D=3D 0 && cmd->length =3D=3D U64_MAX) {
> +		rc =3D iopt_unmap_all(&ioas->iopt, &unmapped);
> +		if (rc)
> +			goto out_put;
> +	} else {
> +		if (cmd->iova >=3D ULONG_MAX || cmd->length >=3D
> ULONG_MAX) {
> +			rc =3D -EOVERFLOW;
> +			goto out_put;
> +		}

Above check can be moved before iommufd_get_ioas().

> +static int iommufd_option(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_option *cmd =3D ucmd->cmd;
> +	int rc;
> +

lack of __reserved check

>  static struct iommufd_ioctl_op iommufd_ioctl_ops[] =3D {
>  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct
> iommu_destroy, id),
> +	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
> +		 struct iommu_ioas_alloc, out_ioas_id),
> +	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> +		 struct iommu_ioas_allow_iovas, allowed_iovas),
> +	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct
> iommu_ioas_copy,
> +		 src_iova),
> +	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
> +		 struct iommu_ioas_iova_ranges, out_iova_alignment),
> +	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct
> iommu_ioas_map,
> +		 __reserved),
> +	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct
> iommu_ioas_unmap,
> +		 length),
> +	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
> +		 val64),
>  };

Just personal preference - it reads better to me if the above order (and
the enum definition in iommufd.h) can be same as how those commands
are defined/explained in iommufd.h.

> +/**
> + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> + * @size: sizeof(struct iommu_ioas_iova_ranges)
> + * @ioas_id: IOAS ID to read ranges from
> + * @num_iovas: Input/Output total number of ranges in the IOAS
> + * @__reserved: Must be 0
> + * @allowed_iovas: Pointer to the output array of struct iommu_iova_rang=
e
> + * @out_iova_alignment: Minimum alignment required for mapping IOVA
> + *
> + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these
> ranges
> + * is not allowed. out_num_iovas will be set to the total number of iova=
s
> and
> + * the out_valid_iovas[] will be filled in as space permits.

out_num_iovas and out_valid_iovas[] are stale.

> + *
> + * The allowed ranges are dependent on the HW path the DMA operation
> takes, and
> + * can change during the lifetime of the IOAS. A fresh empty IOAS will h=
ave a
> + * full range, and each attached device will narrow the ranges based on =
that
> + * devices HW restrictions. Detatching a device can widen the ranges.

devices -> device's

> +/**
> + * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
> + * @size: sizeof(struct iommu_ioas_allow_iovas)
> + * @ioas_id: IOAS ID to allow IOVAs from

missed num_iovas and __reserved

> + * @allowed_iovas: Pointer to array of struct iommu_iova_range
> + *
> + * Ensure a range of IOVAs are always available for allocation. If this =
call
> + * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of
> IOVA ranges
> + * that are narrower than the ranges provided here. This call will fail =
if
> + * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given ranges.
> + *
> + * When an IOAS is first created the IOVA_RANGES will be maximally sized=
,
> and as
> + * devices are attached the IOVA will narrow based on the device
> restrictions.
> + * When an allowed range is specified any narrowing will be refused, ie
> device
> + * attachment can fail if the device requires limiting within the allowe=
d
> range.
> + *
> + * Automatic IOVA allocation is also impacted by this call. MAP will onl=
y
> + * allocate within the allowed IOVAs if they are present.

According to iopt_check_iova() FIXED_IOVA can specify an iova which
is not in allowed list but in the list of reported IOVA_RANGES. Is it
correct or make more sense to have FIXED_IOVA also under guard of
the allowed list (if violating then fail the map call)?

> +/**
> + * struct iommu_ioas_unmap - ioctl(IOMMU_IOAS_UNMAP)
> + * @size: sizeof(struct iommu_ioas_unmap)
> + * @ioas_id: IOAS ID to change the mapping of
> + * @iova: IOVA to start the unmapping at
> + * @length: Number of bytes to unmap, and return back the bytes
> unmapped
> + *
> + * Unmap an IOVA range. The iova/length must be a superset of a
> previously
> + * mapped range used with IOMMU_IOAS_PAGETABLE_MAP or COPY.

remove 'PAGETABLE'

> +/**
> + * enum iommufd_option
> + * @IOMMU_OPTION_RLIMIT_MODE:
> + *    Change how RLIMIT_MEMLOCK accounting works. The caller must have
> privilege
> + *    to invoke this. Value 0 (default) is user based accouting, 1 uses =
process
> + *    based accounting. Global option, object_id must be 0
> + * @IOMMU_OPTION_HUGE_PAGES:
> + *    Value 1 (default) allows contiguous pages to be combined when
> generating
> + *    iommu mappings. Value 0 disables combining, everything is mapped t=
o
> + *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOA=
S
> + *    option, the object_id must be the IOAS ID.

What about HWPT ID? Is there value of supporting HWPT's with different
mapping size attached to the same IOAS?

> +/**
> + * @size: sizeof(struct iommu_option)
> + * @option_id: One of enum iommufd_option
> + * @op: One of enum iommufd_option_ops
> + * @__reserved: Must be 0
> + * @object_id: ID of the object if required
> + * @val64: Option value to set or value returned on get
> + *
> + * Change a simple option value. This multiplexor allows controlling a
> options
> + * on objects. IOMMU_OPTION_OP_SET will load an option and
> IOMMU_OPTION_OP_GET
> + * will return the current value.
> + */

This is quite generic. Does it imply that future device capability reportin=
g
can be also implemented based on this cmd, i.e. have OP_GET on a
device object?
