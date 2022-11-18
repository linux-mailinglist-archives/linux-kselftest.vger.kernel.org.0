Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2062EC3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 03:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiKRC7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 21:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKRC7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 21:59:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D92B1AD;
        Thu, 17 Nov 2022 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668740338; x=1700276338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZ+AzSQJtS0RofOqNenY2UNeUBTQBAh7HlmIyCxuO4U=;
  b=lXoK0ZMMCcETR+/VGmBEgvum6y0f7k75sD2E7rmMK/wF0zEEn9Kzt4My
   9Nuo79LjeUQ4qy0Z8Y+AEHPDbX9v3M64NIsg1BGNqiIwtwmsVmaN/W00e
   llbhC/Mg/jgCanM+Qs/tI2UgHjqCos6oEy5shXkurUiXLpWChnZpV8Bv1
   FWqsb+6kp6P/91CreYHPgWWp8U8nPM4sYeX+/KmIU9bWSUyFo4ELnsySV
   eEw3lKoAs89e4MEXcmzykRYg7hS1HiVy6vAPZurj4t3uXyqKAicER3GUu
   WSb+hH9JxebTKACP1ILYAPay6go4wbFzliychmcwdZx4O9sAprAgAeiPF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="375170934"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="375170934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703578492"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703578492"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 18:58:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 18:58:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 18:58:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 18:58:56 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 18:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btBGOPT9CkWTB+xTxzzMhMrt62+VYHiihyO7ESkYTc2JWR4b64XPjtQwV20zBncntr+BMIeYrCYUD5iqRXgb2vzkOjbxc/kQXvuD6DRypwvMuCnNvgE8IiNoHJkcSJKRsIWT8IteRBixTQQACma5Uxl3zOQct21X3kn8NfdgfTWKUJ8jlmBYVm2FjY8gcCVrf42UyFaJcFQV+8I4bFICUg7utiWYg8zlVZQ4JaUfelP052lX7cPRJx/ny0fhahIXXEKWHiOBQU9MO0LJCbdeB6U61WUYSiVFn9/vMSmGUhX7eti9fyGT9WB3hSZrcprsb5YyY8ZZfaG2zyjPj4PqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I03I0d6NnZcyxzwFbpaaacBvJ/i/9jxueL1raiyxgk=;
 b=l/TWuFFAafv8xCkzQJBsMgGpDbIZDuz6yj/VTdXvkQ36fLGl0mwS6mAgJtGwc8CiscvPp5owC7ybS/0trMk2Gu+jLhh+akB6iQTlPyOS8Sd0n9k2P2MgugVwg/Z4Smt12EmeDdodI48sQlJVuvmjRQZEZd4fQdu3yRDKXfTA75tH/AthkIyuQJbAZEUz6fRA70/B+gdxWz/SRyCR/OqWFBzScVwYtwdjbg9RFR5lkitcNTPmzx22yo2Q/1/rTJ9nAzjofbQ6wSd8wN8w7xJx/PP9PfG0T6gmcIFbCbvszVWX4fonZj1Lkg1oFE1yFia+VO6hMyFxym2xlr6zyLyICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 02:58:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 02:58:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Joerg Roedel" <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY+f/RLyRZNBfk70CFqNn2m/63jq5D/xhw
Date:   Fri, 18 Nov 2022 02:58:49 +0000
Message-ID: <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: d8a5e33b-6f4e-4af2-fe17-08dac910d155
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9y845tTmcCF5iFtzEwVNGr1CikfrarkuBWggcHIshDam2GVrEA0umZomAT+knxLRii5byYPcnzxQij8oImZ2z3IdW8GGYBBOJgD8pCIg9eoZGMuf33mVg6MmnflisbXQkVuMlUrW+bq7kKkxkynyOzY+LeXfmoa86ZPJgh68l/jxuDX04TeOAGPBWywhymWVwRhXkNiToYBCDtGG+AhZ+0+rtTCVWiNW9qOH1aiuQ2Wt9iAgWuBO6MEttCUpCysawkUSnlzO78HHy/5HiwPGODRrBeHc3qADOLj68IJvkfRG4FQXctJ7JX0EGzwQmj+LP4C4rd7QHs17c5ZrGfcFW8z9qHBumVyIMWZ1dO6itgZLDjt2gDaLQHadlZGCp1lB0Ga/Txd+rz5BkeE81Bn0+5P9LludtVW4MCSl1cNvZcAhRPQEvrG8R6HIZvr1fYX0TKDJUA0A/HHgmhr1//Jy3MdJMmJkdnDDPoJCxgnuFXloj69z/nLNerjKNjxyI/0w8j3hOLCpNVDoV2TlEHiPM80UdKbzMXeprPpmp8UEEOD4HK403iERu00KD0xcjWA8a6lL/Y/9iOrahdeFdz0mSO7VwRxlm3bnRd1socy92SbWmRdeQsWdWlMFdZqRdwira6Bpwn0qteob9Fv7fy1b2Ma9QJPR7wxTuwlpGBRbS+nM/Ogjr4x/QIkFzIZBIHJKqbbCopIQmEKqsvwFUIx94g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(5660300002)(8936002)(7416002)(41300700001)(52536014)(4744005)(478600001)(33656002)(2906002)(7406005)(82960400001)(71200400001)(38100700002)(9686003)(122000001)(7696005)(6506007)(55016003)(86362001)(921005)(38070700005)(26005)(186003)(316002)(66946007)(66476007)(4326008)(64756008)(8676002)(66446008)(66556008)(76116006)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2pP0PPgbJSU04xW9tk6n+FJ94GLGIqsdN+Fd41JljTBtZ7+TZc2T+nnBTiOs?=
 =?us-ascii?Q?MN5K+U/uZn/pUXAB45PcXvm/vUPSSZ4+uanKMjPtWjLL+Awi0zMPcvMVUT55?=
 =?us-ascii?Q?hogZwXORBBqutbdJiZ/04v5SZ6/3xawBKcw+g68oaIH4hUYjnAk5g0O5oG65?=
 =?us-ascii?Q?j8M8xCSTVsP16Wgfbfws8MoSsffhl0N7IVqtAQ39r7lo6DFpQSQtrUlZ9UGD?=
 =?us-ascii?Q?4+EjQsncMb+xWqlNXZtkXTt3WHNJ2U/Bn+3v7KY+cxS8KQ7rBp5ufcgIEK9X?=
 =?us-ascii?Q?rcTcw7GF0skFh98F3BPMG1M+0mfYE50arn8GDezkTxDN7HfqQB+p0FAkROv1?=
 =?us-ascii?Q?pHBGpTu5frqLkVkPpfXb9Q6P3UDNw0UX5o/vUN8no2GXzbDZTOpXR1RWSoE2?=
 =?us-ascii?Q?JjSPsP2dQ9TGW+OLFdNWFy3yAeb/+Z8vS5yrBhGGS/wiyzMxXwGg+xRl+rjk?=
 =?us-ascii?Q?j7B/cN17UXnUawDIrftLNZwIJkTwErumW3spy/rrq7ZqwnS+k1RXv2Agd2gq?=
 =?us-ascii?Q?eClRcVsppPrzTZDe7o1+BAxvoXoMMaTDw9VkO3YEvoaxcTEEgKWTbA2yOyb/?=
 =?us-ascii?Q?d1tIG9eQkqsxNIGFaNLs4y10/3QPjV6qS4N3iS0oTmKFugKISgk04glacDRr?=
 =?us-ascii?Q?OzS958bouxtH+K2+4v831Gfc/EEGn+w3nvRn7g1OEHUiykVFiGqYD1PBd5fN?=
 =?us-ascii?Q?uGKGX9ROhYdkrhIbLeGHEqQoVbXRRdWYWg+XMWoQZ2KYo+bSFVe91/WlJK/u?=
 =?us-ascii?Q?EFW2SqbDeRnHaRHpbWAOMzyZjO/lZ1pbUEUkT7oYDfyytj9YyRyb4mTENRiu?=
 =?us-ascii?Q?USxR9g4iOhbGX8k3KeKO54PEbNeYvpxbk0F1Y8SvyTit0lHAgIQRS0sTWmvi?=
 =?us-ascii?Q?Grpc6iIT4vmczwGuEVV5nJYnhf2p1N1L+Ovf9hTYiBqYnEK6vPJWWNnDOs7q?=
 =?us-ascii?Q?1CsEeZzlP4ylzAUv/NwhfKtXISfLNbBb5JQqInZtfOSh72b5nKUTsT/+BYg2?=
 =?us-ascii?Q?3pFGky/GDzywZCWYVtRGP8MGSMCgsf6mVOKsxXcDKKAwt9rh+WI5FBBJ+rYo?=
 =?us-ascii?Q?KVDaJLFx558be/r3ujBSMGfUqsDqpH0J0P8C5WXE1LMuA3u9juHFs24/AU9T?=
 =?us-ascii?Q?x7d2ZHIePX7k0/QblIoQGCvNe7Hk+QyDMCHbYuNHDD6QjUFUUlc2OhZE2cQ/?=
 =?us-ascii?Q?9H3GqDu1Xtsmt6NA2lzMPAQXihTyB2Y+pIYwOw5xsroD8nj4NRzIee7gxFf8?=
 =?us-ascii?Q?cNQMKFqc18CyekX3MpDW46CpRCZ3Uyhwq4exz9Ukn8c+BmC/IaRNOqbN/+j7?=
 =?us-ascii?Q?co1KZe9p+tsSPGRmR2KIxpTNJPK2LEoOmTqYpAtd5U81qAQT6eTkiKcmIRv3?=
 =?us-ascii?Q?s0Oeve1JCdb0lt/I9d4RieNRV8KyumOpfu/8yuMBxSZjDxPbfCGLOFsl5XpV?=
 =?us-ascii?Q?xprdfurf7cmywr2zyNsTMLTPX+NfMuq3lIsI/s3NX0o/kMTVYBH+BsIw6h+1?=
 =?us-ascii?Q?43/RpP/erQtm5D2MPxngXwohuE79OejzL7HVPxvDKBwe7gn/pb4YHDhA841c?=
 =?us-ascii?Q?vADWW8NJBO2IRNfjM2/n+1Gs42tAeSk8vYbIbndu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a5e33b-6f4e-4af2-fe17-08dac910d155
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 02:58:49.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhijQLJWhzo9ZItRbJWUbkjoU17N9vzlrel5qa0VWWCxwpZKSD7+sjlRMDJSfeTvBM83GaRVOnP0C/zhbZqQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
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
> Sent: Thursday, November 17, 2022 5:01 AM
> index ca28a135b9675f..2fdff04000b326 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -5,6 +5,7 @@ iommufd-y :=3D \
>  	io_pagetable.o \
>  	ioas.o \
>  	main.o \
> -	pages.o
> +	pages.o \
> +	vfio_compat.o
>=20

move vfio_compat out of core? it's not required if VFIO
is not configured.
