Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8262535A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 07:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKKGIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 01:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiKKGH7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 01:07:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC05F852;
        Thu, 10 Nov 2022 22:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668146878; x=1699682878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d5yZWoMlToNZSX/A8rxAmzkQL5ESf2iWZxC/9H7pVh4=;
  b=dqywzqrdNxyCm3H15dF5/ShIX5GcFF0NeEtKROYWYgFxdVyGRFpe/fS5
   b1/fTMJLmbHX5rXLYmabYRHtgcSncs1Cv+lIhMDRr4UNf7Ry2Tf/Ch2gH
   tVcKnU7d7GstjeW479CVUexPQ+4qAOp9YScMBpd89z0ZUOBN7LDEfUhfG
   qkJrV/fMjCODMtLHXibCHzcrqGryjPDSeV1v2hpV+e3tAipq2NDzawfv7
   wnDLl49O/ZkjaAqs6UcZKhrGaEFHAQpKxrjLWg9eS8hQigD+Th6OgWkvt
   HcHW/1+sb1CB1Ovj8uN9R/eEEDYWy0mPwWkwYm//srbLhcEWar/Ie8HBL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375794501"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="375794501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 22:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668710003"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668710003"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2022 22:07:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:07:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 22:07:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 22:07:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rof9BxUJ7CfbT1OfFAGXi0WvigeLskmppK4kYU31ZXZtYX8QKofi+RomvD/hzrgQ5DogFRF470Xd9BFzHAwuaCEhyyl5B8v0irauT6jopf8Z2Qc6TgKomqxekitM/zLjbLTyaYAUR04VrQ3RnwsD6Q//plstLVdxKQ+0hLysFmi7vQlhhM9pX94O2hj/7Rkz5e4UIxrZXqrrUPdhAmmYwwHNAgUR5RbX64ze7Nm+H97FeUBEQgqNa2R6t4UDILyHbRBAh/wHUs7s+OwxguS/eZBPyB7VzflXAh8Y1BYaT+PjGzZeYB5xIZFTdc8qFF47Yzv/SNK0LkCICVPlHzMn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq33Sww7ibERyJgr3OJ1IT8S0DZKqTkmVWJ7AqMVCsw=;
 b=LWNqxoBUVxym1Sgqz02abhGODOIS/Wb1oLjwQ6VNiZ+PPkaoWdC10hk8i8MC3wqIM3pNvynu5ttttjYZGj+maoQY5CpOC63wyQyLcAwgymtyf//cG3TDDE+E9wNHAu/TnsDi4t7QFK5hn6AnEeKl2yqrkyP8wpUn/jS1Olb8N7PCqrdfSWWmquduoF1jn9Kd/6L3/Nfwv2OGtWxLSLVGeoAoW5DtILSvmZWX607a2cbEMysEw1qIfkmcymYTRe64DAIEpEqYKYTj5NPGxHodEG0VcngGfNeu4tkvAuQ8Tio7PiS9vg9t8DHR9bMFnf0waH8ACCPeCG0bzEXagHPvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM8PR11MB5686.namprd11.prod.outlook.com (2603:10b6:8:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:07:46 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:07:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 05/17] iommufd: File descriptor, context, kconfig and
 makefiles
Thread-Topic: [PATCH v4 05/17] iommufd: File descriptor, context, kconfig and
 makefiles
Thread-Index: AQHY8wv2NwaD3LlVDEq28pbGBQQkia45QZ/w
Date:   Fri, 11 Nov 2022 06:07:46 +0000
Message-ID: <BL1PR11MB527180BB98A24D6F1BA04BA98C009@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <5-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <5-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM8PR11MB5686:EE_
x-ms-office365-filtering-correlation-id: 456ddb1a-88a8-44bb-c309-08dac3ab0dce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6+UagZKNSbtRMiXJtPzqbcV207eAj4wkQe+dAN+R59/eylQdzCB6LlV7KFwb4KG3kQl3sQwQb+x7AxOCw19maP/nDPBb0fIUK+X+OflvMpMtd6CTmia30IXl4kFx0aF5/h0wiPYThS0n7lTED0x+dlVctaPUmRjGJhSJfu5JCeo19FWwCuT5jfPVjFDts0oy7wQV90xr/aa8vIbwy7OdgApx4Cf8dVPLBvk4zLO342JYL+m8CuLu6ZA1QOQ48TvI7iBkdHkq/mRtAqk5MjzBYiCGn1voHfChuDCJAOIyg+gOGPvHFYOmFh3fhCo1DTIcwGIkUOyUD6t7JHPDhcUGjFOD8XQuH2AWezxm+cd/dIqsoHr+UgJSdsqvpuv+ZVbTp2aTzBtbuQhPOhRlnuK7a0ORvcNLBwOm6Kghp+dLFYKB3gTJxs639w+DjkDqLak8F18/z/znDH82RCoxcTSRy2/SEI/KN2fFAcnAiq+rVSgwbat4V5EPsLnuh9NbYM/+vU6V3KIMCy0/AXvc2pXSGWTQDeIJeMEaDysDvv7bWjWPkxjjiIalVKDU9uDCvgLH1eumQW9C1Iyp/4v7Iv+R3RQvEIPEza5cPGSoYSEj/zEAhzvBjlLDVWRvvfHnmonG0dG0vZf90OwQ6Af4nx3spJmzocwenndmVf3lk5UbBsWP4YO9kPnaLn2nckwovvtzIqgXs/ACni6dLmdRZgZCDiFCmZPTyP27o6nYo2loAbpNCjLo3dQq/euE6FgRAok9DeApVluD4GZYj3Q8m9rrHCa17KBUTNn2EcIxZD0DH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(86362001)(478600001)(71200400001)(76116006)(316002)(66446008)(66476007)(64756008)(9686003)(7696005)(4326008)(26005)(6506007)(8676002)(4744005)(52536014)(7406005)(5660300002)(41300700001)(186003)(7416002)(110136005)(8936002)(54906003)(122000001)(82960400001)(2906002)(66946007)(55016003)(33656002)(38070700005)(66556008)(921005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWxiMQr8LuxduOBi1liiMKBpVJaYGLur+8m1Yyevts1N4n9h0THIz4tB8SDd?=
 =?us-ascii?Q?rPPVvBA8Py1o7do/WcFTQAh9ciPON+baJgQ2jhaB6pPAMattJ6XWsq4Mts1L?=
 =?us-ascii?Q?B0YT7YK5VVmnOdHvZjY53XndD3Ka5zSvfwLe1NkR7gYOli20JXlquZaA0ilj?=
 =?us-ascii?Q?2iq2+Cmc9NYhNNkwCVk+QoPVnXMkhUGqwPfWkPlK7YCZUjxfeBimHr+N6RW+?=
 =?us-ascii?Q?zsMk/SMjQks2nfHmglvxgnvYBYoG6wKXGqwxYcQieBelEngKlJPivCQdDqt7?=
 =?us-ascii?Q?Sw/vXUyx2ARG2fIEtzX/RounAPS9YyrO7nCwcZYtliNvTlr+6CxxInrZ+2iI?=
 =?us-ascii?Q?ba8lAYSDZwgu1VGkZZcVJnlf2IohIg/dh3PXRLrWZjF3OVq2bK9AM4DBKcaD?=
 =?us-ascii?Q?RTIbItUSFbGveAiCpgVatUHnkBS88qq5bzlEMCLj5xFPju1zDlqRr3GxXl/B?=
 =?us-ascii?Q?ILJTGO/4V9PIjPsG/USoqkkHs/p1xFefCiwz5mmJ54B/sBKWHDSbs11/fR7l?=
 =?us-ascii?Q?GTViYW9qQljt4jYz82lZpwxGP0SOkq7VIcm7nfAyHnA/hGOTUmAAT/IImtp+?=
 =?us-ascii?Q?81femCTPY4d4BP5ZsrzkxD08D6jd4y9EjHaT2kWU2TjCM2lSCqgyjrld0siz?=
 =?us-ascii?Q?0yWFTO+NaH7BHUSdjIyutZ1lGI8CTlU4Rg4Ghh1ZnRcw80eAD3OOmEnyY7zx?=
 =?us-ascii?Q?sXRqSq2pjhg4c1nDvVKO9J65H4T/ApmiX6i+TfcVDXLZ5ezOVzMyyNsDBUbg?=
 =?us-ascii?Q?Z38IaMyYuUPEzUm7a25ZgRaqwfcLFZr4lJodqH+9Uwpe1O67oUTCIbaCB2ax?=
 =?us-ascii?Q?91Qm0FeTXOGS9ryYQkAZ6rUTg0sl+1q4x6e/eJq4RHF6zm9/Pjox/dXS0ajg?=
 =?us-ascii?Q?CUtm1LxcYp6QFboyyZr5A9mzEZfGOgqUusplxPCeRApRox2jJvL5JUdeKTxU?=
 =?us-ascii?Q?dUGpYkvSr2DSUOBc1F2KD6QwRsBcA3L0uBWqbRlmFNDnWNHSanR7vf6m/JGM?=
 =?us-ascii?Q?Gncv7yC1XbOB9AvRVOvSuS8TO7miK94/a5icBfNKdi5MqV6HqtBBmZftJAop?=
 =?us-ascii?Q?VTen+jIaeZlRNUkrmABLYwmR0usDY56tTRgSLscVU9coi/zXPXHZD6MpwL6O?=
 =?us-ascii?Q?1SOC30WvmLsNjGMsJc2qaoWqV/YC4PcM4xQbSXM3YbDsxYB+yDezhcayHW1q?=
 =?us-ascii?Q?sJovWVD7+hBUN7bzHytSLrXpY42VPK+k+wFW1WzGMURF74J0TMu3RjK7Ebub?=
 =?us-ascii?Q?VHM7bP3+YEYUNiPMirNgHilrA5yegWnc3mCFSUhsfWILgPHC8b9WaKFXNEuz?=
 =?us-ascii?Q?umwT9yTFjEN0rh1aEurlV2GN2qD+hHerb4ee7sU14K3K8MV4TALQDGCA7Sj0?=
 =?us-ascii?Q?uVhswkEbBErexXnbLiiWE3IXAOdNd+e5dZl2EXUd4J4DnVTlApmXFt3BBcDK?=
 =?us-ascii?Q?U3JrpSnbsztuKhhOQcVdbHfKYLdKUpKpXLcZVSitOxwINuURtD38Tx1wLTuN?=
 =?us-ascii?Q?Dx8EIghmAPPAPylPJzLxQLoDZRMLtxd+sI3u3cQiUCvSEVqWtsenSKJtWoeU?=
 =?us-ascii?Q?V/xTPNXkbTWEvicaGcRPbgf2R+E7rMzzqzLlL4fd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ddb1a-88a8-44bb-c309-08dac3ab0dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:07:46.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zI1oDXa+5nj0rDwnp94ff9gWsjMj8T7IeLv5OnE5i1NLpoihxYJ+TbY8Fooawn4cxuLkt1u8sRiNc84wpoKroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5686
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
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> This is the basic infrastructure of a new miscdevice to hold the iommufd
> IOCTL API.
>=20
> It provides:
>  - A miscdevice to create file descriptors to run the IOCTL interface ove=
r
>=20
>  - A table based ioctl dispatch and centralized extendable pre-validation
>    step
>=20
>  - An xarray mapping userspace ID's to kernel objects. The design has
>    multiple inter-related objects held within in a single IOMMUFD fd
>=20
>  - A simple usage count to build a graph of object relations and protect
>    against hostile userspace racing ioctls
>=20
> The only IOCTL provided in this patch is the generic 'destroy any object
> by handle' operation.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
