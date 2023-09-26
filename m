Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A77AE713
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 09:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjIZHqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 03:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHqa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 03:46:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31180F3;
        Tue, 26 Sep 2023 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695714384; x=1727250384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OSTNyHIn4Ul1MB9BlINa48ufykHt5aWC1RxZGWgYEt4=;
  b=KjRKKseRUc7SDtYNTyHdNqN+qnbqzIkr6fWbHsJ7kFnQZ8xSbkKiemc9
   ntAoEQKKA+E5D4HCPPQxA3htgOUpcK3vWzhGyieE26PWfKt9BGcm3c/C3
   gwX8y5Z6CikoMwIcD1TfDV/Q/AvuKORElLdL2wSpMcmiPAb68pAlihJAn
   JIpNc+xt+Ahhl9JPgsQy0qJY6agWYkp9tZCgUsdS4v3/XNl7cGvkcD99X
   GuYsqxrJCJCmCQUEE4X5K2gOBAWufaYyc2RwdpYjPIP/SLldyhdKya0WA
   VjfEWk7c9xWLqKP6ho4CeDW3NWTUNWsT9Q0ZLOPO0KJc0jwySdKkeTDxj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412425478"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412425478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 00:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698361649"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698361649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 00:46:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 00:46:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlKVY2c5Pimp8al9bD8+i/2tk5CPNCl2hGypqztYC1BIK4KbwCLnsBerlChSU8+On6Z0ZrD7msY+pIPvQfJB/oiF/9EvLLPqdGedCqt35t36LUOxOaS00M7zNw4OHHXR2sBhbtDei25GXHzP2zwtj5xEHQT5aPegNC7adz6lErMXJT7ej8fHomCVaVSoqegrrN5OYxhoHa/WGcINrTa0oINhVG3E4pKN2eeVrAeRQ5hHApb1+JWDo1lzB8R//fU17X09QxNNm78BK/oKvqZjfldnnie3CTwi+9+Y7kz3HMwletK8skoCgLyNamYo/vaRBgtlF8cKfhA+/OjFS5JZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSTNyHIn4Ul1MB9BlINa48ufykHt5aWC1RxZGWgYEt4=;
 b=FdUwYeneATGCNZGLLmD3HiCiXIvCgWEQ7L2uq1ALeEuCmTVmzXEe2Q8wU6DsddFm5BG7QK7888aWSJbk+6LUPdLqusxvf+EKiouPhFo93CNJ9QLJjBRzl8ixkrP8pDrZp1K2Y70/1Z+zIfO3p0+ndaMk+4+jB1q/MeOEJ7QGjyPSL6iOWeRbOQjNO8XFEOOkMnQV5DMqPVlfKYf086u3rckHH8hQdEy994QOixXvG3zaefnZ9vk/0ac0Y9C5D/8uHn7esN18emOZ4WAtSgPsB2bxYi85iBENOEgPpAO3io7BDcOwQPFJ5KYDl573Q6gQ1a1X5WIXXZw65HBa2v94fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 07:46:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 07:46:16 +0000
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
Subject: RE: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into a
 struct
Thread-Topic: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into
 a struct
Thread-Index: AQHZ7GCMWbnWx0cAMU2zkB3ZEg1GubAswivA
Date:   Tue, 26 Sep 2023 07:46:16 +0000
Message-ID: <BN9PR11MB527605D349265147DBB91C5F8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-4-yi.l.liu@intel.com>
In-Reply-To: <20230921075138.124099-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6453:EE_
x-ms-office365-filtering-correlation-id: bd257edf-f25a-4050-6157-08dbbe64aa1c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbxaBIUQ+UiR9w0v+fcy2/TKY8XPiBTz2asf2BEBwVBPdkOptc0OmSc+gLNLknU6mP/c1DrMxcUbVKIMvKQYN6N4+NXf+Rth8ssgVeZ56itrFJQ3LRbUJvqZHfEDpEJ7oLebmAGrEGtQfsoYT2Bh807ZKpVf6g/WFp0I8k4497d05X0g9DMoorLnj7Fmwt3NBhlU4ebeCA/h3MUrTEVZ/wnL2l9f4NnAjxBchb16ZVg/aVy8TUwPECnHm1D3pKun3vHnE0a8d5cCFWlrj5uXoszb5BUdSpERsXpmb4t1br6IF0kgcn6wAxmLvoUvKQ32dTAV4dbcj6/pXm+ZOQktUK1VDMRfRmQYbW3XGyltT07sSZurZyIexdUpzXfr3AiAvJli2+8lxZ0+WYlXYcUB88RbFCoj1VMYSbOUUXbAwshaAbpYYUK1AHe/mfjkMqNeNi1F+ECLgUqgdeMmfI1RZasxAtX7WLV2NK4nrlHHX5SpxtcDGTXCQpDULZ6or18QADBZqCNoIiDkoeWjkaQIonWLBJIYZcitIjNEabpqpgMiz/vMurbpswNCwp6nvlOGA+0jJvmVsN4J2VtdmQeFS/X1QKbENRhCTrbXT/PSsHV01U/dnRa2OaMmt9p/KiHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(9686003)(7696005)(6506007)(478600001)(71200400001)(26005)(4744005)(2906002)(7416002)(4326008)(66946007)(76116006)(110136005)(64756008)(316002)(54906003)(8936002)(8676002)(52536014)(5660300002)(41300700001)(66446008)(66556008)(66476007)(33656002)(55016003)(86362001)(122000001)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bBhocBxNR/mj8trkOFvAaGuwIJsazHuUtAJF+rXZffBiYtaiJw6WAa/QFW/L?=
 =?us-ascii?Q?8ccTiy0avK8F9IQe1xUF77l5jcxAkvnjb1coxReVje45ANcf4UdU9OXGO7mC?=
 =?us-ascii?Q?DOSmaCjnqvfjMaZY2OS0NRN/YBuETeOAFS8t8HS02AFfM6JKOBI34Wfs+AJQ?=
 =?us-ascii?Q?C9G4lq1pcPlA2rH3FjMp812mnBuCJtg10hzcv8X3u8wRjd+mBtEDiETdHZtD?=
 =?us-ascii?Q?dxyRa1V9n6Ug9ebRQPli/10mqw5a0yUyHCLgbWr7xO4EnTerHfjh8NrgNrtQ?=
 =?us-ascii?Q?/TXYPK+gb+eNuDyns7plym8Qai6etog974EZKjO6nmT/CumcicjkJ/jNiaNE?=
 =?us-ascii?Q?cDO1xGt94+nLGUTZCWoWXpcffVY10fzLvKwD0VTP873OcEstQG10TxZedTZu?=
 =?us-ascii?Q?9iaw41Xf4T+6P1LllCdG7pQttsddjIEY42zt4gD50lq/kDQvVeGJhB9utBWT?=
 =?us-ascii?Q?8T8iYJY3z3Hz16rNe1iJ3oeTQe43JCO9/Fi36qev8OpEBC3P73XIOEVD3upF?=
 =?us-ascii?Q?pcrpALmXvzmRzIqZwgt8cip5813YSjCoEYRd6VvBvExeFfPw5N/Ipq5PivfY?=
 =?us-ascii?Q?OEW+vWwTxQCkyXNyEfLAbQ9ecPKvidLFOftK7rZDh4FTjZoItPenQZn9X1Oc?=
 =?us-ascii?Q?CTeDvNUAMqh2Cld2Q8hy6vI0mnQVQLV9W1rTQxPR0aHqIXfUzf2ML/oZAy4u?=
 =?us-ascii?Q?g2Fx2BzoqIOjQ7K40enLu+Z00iWFqp2HlZ2am0eCtdfO1gOVCZz+j5pg7hVa?=
 =?us-ascii?Q?NdeEY3uKfNbHmEfViyPg0/EGSWGHbksO3l0cpT21zqhDMPpE3fJWFO+wL91H?=
 =?us-ascii?Q?/ZA4mDl13MJfhylep2CbB3MyC5SO+0YW4JDXWC8s96iT2w7hRLH+2ltqL6z1?=
 =?us-ascii?Q?iRVdlDupPtuZHh9cm9FvcbV0XH5YzX6HZyYzWfykT98Y+B0ZNvvp/ImPFarB?=
 =?us-ascii?Q?W2FeiuMbY38JVlySAlVDRW3IT6rixGWiNnRO9tglzUYuQgWQNRKx35b9xypm?=
 =?us-ascii?Q?rG55H+wpGBUVRC5u19bwi3UFyXyAOF/1onBznLa8R9rewD/isHg7HfVZ33jd?=
 =?us-ascii?Q?b6ZBVzr79MancNrBaiOZ/tEiiokNe7AAp+Qh2fqIbZp5NQw+Vc+39rB83tQZ?=
 =?us-ascii?Q?u5eq0oospkTOkSn8lZfTRrJTKE7FoX9Z2XTd7atblPB4AEprftQTX+RWrkV7?=
 =?us-ascii?Q?yxgK/jkxWOOiAHcyO5k7zJK2N0PvzpMZW9e0wLH3ZcR7reTixchyA7yId4e9?=
 =?us-ascii?Q?vujI/3n93VH+qWD7kVKIp8LVJU9fBut/cWliX58+m07EQBsz1waEiit3eFqs?=
 =?us-ascii?Q?vInPhgsncs6vlotkihkPjuZ1Q47mDFIfwkzLxMmhNZfqJoWYiK7KKdL+zl1D?=
 =?us-ascii?Q?JB3oC3Y+ZpmKzCtk0UQ6zN7Ce2SLlgfRHgDMSIiwXxHrwa0wsBma0ozgvprc?=
 =?us-ascii?Q?DxS1Q9Fq+2E7jn2xo2ltaK8P4UVWprALbUVDJMHZMxil35drBd+fdExzu2Ob?=
 =?us-ascii?Q?zmroigUvOhR9UohRwDOsm4gQteRTVi9xTLyY78IrvCP1gMmBjDrAg9KT1SKy?=
 =?us-ascii?Q?5eqE8dls+p63DFd+mfUir2yFVmpTx6viqa3tcz69?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd257edf-f25a-4050-6157-08dbbe64aa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:46:16.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ha7qxjx7sKO4vIscj0iHKY3DXBwaePHzoiaCkaapjE+WlQq+o7oXDKsTATSXZn14Vg1AFJOJOAC++74qaNh69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:51 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> The struct iommufd_hw_pagetable has been representing a kernel-managed
> HWPT, yet soon will be reused to represent a user-managed HWPT. These
> two types of HWPTs has the same IOMMUFD object type and an
> iommu_domain
> object, but have quite different attributes/members.
>=20
> Add a union in struct iommufd_hw_pagetable and group all the existing
> kernel-managed members. One of the following patches will add another
> struct for user-managed members.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
