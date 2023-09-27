Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0B7AFD14
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjI0HxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjI0HxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 03:53:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44F1A8;
        Wed, 27 Sep 2023 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801184; x=1727337184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5tdRck3TQRhHLuCraSrDfGMo1kZIXvmMxSfwjy5ljJA=;
  b=ilIJn3WiTITogU9CeIxfFyagzq0gmu/Eql8bdRAbq9V8TaclwEhiJZiZ
   Ep491/7taU6X+bc5pC6q4Jk248iP3oAVeyDPKmMUslfeig5NhorbhS7/c
   6cgcSYv9Fqalw8aStWDwVAyRKsVIvt7fD5RRFpQtpd30eb+L56lb3ShPv
   KSQm1c8CVUl4yysAkYu9prAP7EDvTCzJKtvA/bP5pQRFP7Dgo150ZMpe4
   FddvuUtfZKqA1JmoWPr87Vzx34jF38YzsDWR0S6CjTm8zLgCpF6TNE2yy
   s49IQK98xu8lXwvN9pMrdUsPGvow0iMYpHPuzeuZ/jmaCgk/xjUQh6fAL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381659700"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381659700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="455518"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 00:52:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:52:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 00:52:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 00:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRtfqXUXEDYTE6h6cEKOnWnaQRyLs74nfpcq7YFMnlUIaSjpJa5C82tz5jkzMKteI6AyACPyj1WnC5tuhRnPthdip29uAgqVlCYLU2RSUbdIKhAgsp/XgsQF/PexV29c6x+dU1SlWO4WaVYvBaI2/4MDvQXGs1tKBuWqf8KitI31gPx45ky9hElcgaAgsBQT8Yt0sfGl3UbEJbu5Awy5kHpNUaLj3ya2H3J6KwW/MllUiyIKaFTGwg32CWFXGltslxr4anf57u3xD/kEokCTBM9aySJ4S5PMVUa1l7jSJpUrNi/Kqnxb9BszjeBJYMKOp0BQJWJVxROvf7lHka1BDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqPJFjJ619N4fGt57ZD+NYR69t1yJ2OiTULdqmEzPEk=;
 b=gaw3fkjhppRC7vMepRO6GOiOetv+J1dXeLN0lIkrYvmN/GcX4t1OWZ8eTC1h6Gbx4E7Ki8Cot7R9GSgDrMkH+rb4E1VwAohH2WxbGGEtYcq4IgMN6TAvkxMsgoW2yFwmBpG5IFzu8UeHMHb8CcnlZDYirHC6oJiMjRZjxJT7F7Wp/LKDWQixUwlOH5tZyRUHOGK6P/LUL5bIVC+ogl6jWpFufM17LKdrFNcPp8cDfoSoQvZzaGt0me5FqoP9sl72R3dN/XLx0XNsyVhaW5jldYgrn+HFgRn/netM70f+4JZ8Ed6TPcxVCFUPNjN1aN8ewRXZde7fKlViXLVjvCn9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 07:52:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 07:52:53 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Topic: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Index: AQHZ8FugfyIGJa74hEWHVr2uRxtb/LAuTgKg
Date:   Wed, 27 Sep 2023 07:52:53 +0000
Message-ID: <BN9PR11MB52766E649727842C98B7396B8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-9-yi.l.liu@intel.com>
In-Reply-To: <20230926092651.17041-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: 9e152d94-95ee-41ed-de2e-08dbbf2ec17f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tn2DIMzI546xNWUeu0dIgSvPsb6nmC0xxTiBCbNUqsVmUcytCZMfrVVOYav1DeFY1LsnvrmTzZtf2qIsfy63zjV1teUwSglZW1cM8dnVmGl8U0VELftuCdUfA8B0JA9PCOUkC+Rk+Q4ZQ7R6sbN6vsouhlzhf1XMwRO5lbkWvyggMxtPpJtczIel294ljlsokxgMxAxeIUJVuG1Zd021B3+jr9vKPnLoSiI4iE34fAKLFLH/xCK4PgKZwca3WgGGkC36sgWRYNVKL8QW41st69TBnW4zqdpJeqO7mKt9BpWADPoWpyQA1o0YmfXt2MuMVMMgs8Thv3tnofKMeMEt59zU+efytBXbWAOIUvSURR1KYEIbGcIANgwnuGpMnZAWdvnzen5vTCJiVibwZVBOqn4nZx+QyQLVxJRscaxEL0JoINBim6/cVcTLH9cOlNfzrKo4ES1Ct9aFUxYXVAbivLH307tW6ZFuIqO9yybgee5je+AEBTiFNfeXYVbwQ3ylcx5jOedSIJSsa8iSCRMiSn4W5dPj/+7ekCEX1zbITwJ4u3Wno56ScWVFHaX2sbjLbdHysEiwdV/wMGB0GJKAroMD+N/N2LE6pfSIhQAC/z6JuPvpT2/RW+arqtQFSV+k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(66946007)(71200400001)(316002)(66556008)(66446008)(122000001)(7696005)(9686003)(6506007)(66476007)(26005)(54906003)(33656002)(478600001)(64756008)(55016003)(82960400001)(8936002)(2906002)(5660300002)(110136005)(76116006)(38100700002)(4326008)(52536014)(38070700005)(8676002)(7416002)(86362001)(4744005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sNUHwB8SinKu1tZYC8yNeVpe7YtjvXF06n4UuIW0FwtrLDUakmInilRYj2+C?=
 =?us-ascii?Q?GStHAyHrj+zxl7IminZa+wn1p+yMGKSllmUbhZ1zTz2ynJDH78Xe+tGv91TE?=
 =?us-ascii?Q?voBvYjsBfDl3Ep+iQW0m8LN5nYGh82sODnnYCHY9Ctqb0EIzwlKLiwqW/b0o?=
 =?us-ascii?Q?ciKcIV+v9Yzxbyn2jd10jfQdlKzpCQCu3J10LM0MuEEc0L5knuKCuFKB21aR?=
 =?us-ascii?Q?w8khleRVU/pjbhabyroOsmKG28IlpUMZHxXfo+EX4uRynMUw+1B/CJDnlqns?=
 =?us-ascii?Q?YB4Dh13C3Z84jzry2E0hr5KaQKvITdGjYV8ZYo6nwzJl3z3AIKOU74S6INoO?=
 =?us-ascii?Q?+193bVXI5lLlkOONx0fUwJDR8tKt2oGFTPhrADsBYe2GTuJdTH5tWeFbI2ff?=
 =?us-ascii?Q?KrFG7zwwQB/DKUADU/Y1d3iFonrbrTd1mUubodbBYjqHEmgwUJ67hhauuJFn?=
 =?us-ascii?Q?1thnbDhZYohk2Ei2/OlPqBpiAhwa0q2ijh3mOZ+Vyu/OXCSKtlmtOwAhD7Q+?=
 =?us-ascii?Q?BRwEKRyo4He7Xa5VtJ3j1XyK4bh0U0Y/BIUINxDVLB8fwECbdojjFtj8oN0s?=
 =?us-ascii?Q?YIIltz7CBHlf58xI59WpwAnwL24US+CSFWPEOR8WKqu11VIzT1WHj6KfPDaJ?=
 =?us-ascii?Q?ejXphAVv7PnZTbGRawy7bmiIEtXRuOUAKKqdklXFVcvu5u9+fs0zR4Yd6qYr?=
 =?us-ascii?Q?e/2LNqVYV9ZsIQAplHL3qD7da3eb2TOx5jzb1z60tzYeu/TY0o0HJxMoyRoQ?=
 =?us-ascii?Q?U6nebYGG84723Z1t4WFsBngW8i9Lnc0h47m2uS7x0hmZeRG2NUKNXwL/RiXy?=
 =?us-ascii?Q?lQc7CchoB05rsCXTKZJINoEMCL1t6WBee7KkbrMWR+qdy3CUnwaAWO9KiNQt?=
 =?us-ascii?Q?b0kOIycvBDg+m+B44ryFZyyx60u4L/GSyHEGJS9C8ZToOR7Daakh18jZezFd?=
 =?us-ascii?Q?JVrIZMDeMZE2SVesSbeFl3Dx1iSCotNze4Nz50Id+oTl9Lm/MC7Rdw2TmovZ?=
 =?us-ascii?Q?4wkIpEtzhpo7BsoE0pXpZJduyza4tzMrZ0il5Qo9NhWzN4Y3ZyVeLVgflmpf?=
 =?us-ascii?Q?PhIhe8Gobqs1Cwm0oMBn7LHUqCbx/fH3GJx61paKnspQyv98ckGgcI+PO+ff?=
 =?us-ascii?Q?4o0reoKd8boQI3R2k39ePWh3vsRAvkXUbIVMN5QfpRyNFbvlL++KdAF3e4kp?=
 =?us-ascii?Q?o41fc8fMOcB0XwyLfBItJaIhZU070iRAcM7t+P8UInz0529/66cBmoSQl9xl?=
 =?us-ascii?Q?81/LVi4lRM++DIPxcIulOuHTo5805yTZ/H6erA8P2wDvAGiaASF1ojDkw0zO?=
 =?us-ascii?Q?qCbfc1ZJJRMazu79QXD1JYGmG1bkSuL2pII+SDkdxL7J+2h7v6nFmu372vbL?=
 =?us-ascii?Q?1dBdQWpWhgMcfZAm3Xxab34D7SFAq0AWeAWo/kHyA8IE4HEoZDgbr3TvQiwN?=
 =?us-ascii?Q?L0k5TX6aKcvRt/0ORbhJzDGPXw1kw52rj+XFHkd+x5YmT34FKilUQwuBPYzi?=
 =?us-ascii?Q?TMDQlFvzCSWEUniF92fRhLUAdrmgpvn37VYWK8crnjF8IX6OPRYYGjj/agMD?=
 =?us-ascii?Q?45p09r6zZMSyyGrxwSsMdC3pztGgTLGZzobhU1x5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e152d94-95ee-41ed-de2e-08dbbf2ec17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:52:53.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHRy8Kvy5NpTE3hV/IYn8s+D5TDCbRoK3Wmsmp5Di2JXti9vEFtJko29vdpkHNO1OFYet8viGhzz8yVIuLfy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 26, 2023 5:27 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This allows the upper layers to set a nested type domain to a PASID of a
> device if the PASID feature is supported by the IOMMU hardware.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/nested.c | 47
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

pasid can be attached to either user hwpt or kernel hwpt.

We should also introduce a set_dev_pasid callback for non-nest domain ops.
