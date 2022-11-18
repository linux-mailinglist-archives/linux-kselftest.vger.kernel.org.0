Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAFB62EC28
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 03:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiKRCzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 21:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiKRCz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 21:55:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED874AA2;
        Thu, 17 Nov 2022 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668740128; x=1700276128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nUD89k27z1/8emRZFnK/ljhLD12nxa/kxUyFmC4Dcg4=;
  b=mWOx2TIFYzlKEdx9kORtekn+gb2dHy9kS3jDVHJc8SfW99L7JZdBwN3c
   0QEbO10chrzaReCoE0i/9gxqg/zVIEjpFviyI+TD2SBuvC8heGDAQqfoj
   vbEKi4ZJM2u/HJRgc8AxKdyLPPtF1AOHdGvQ30F3fneInSvT6ZXHMEEOW
   kEmXk59ClDxUJXKHcNSE+sedPN13K5hAvX1MUYayk/YzoEEjrAizhPIED
   M0Qg/+JWCVYngsqDS9PJ+tEFPUzFlfhzFdo00e2mQijHGNbmWqLGztgpD
   TIBnM/Tbp4jhaHmjBstyPM4rQBpFSV8lfAVFlmo7ya96ItDSBi7EVBYmy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313048901"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="313048901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="671163917"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="671163917"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2022 18:55:26 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 18:55:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 18:55:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 18:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpfUaIjoHMg+hYie0r1XiDZLjYAiJy2+RAaJ0MrEr3ZigeaYkQeA8NXGRcDyd1+7BMKxH6xbzBOSlMsywwe/jSK1l3rJgpokscdyoxwWzA+XS32/HQJ1/9bEsC3dvOEbL2quwsZA35nsPYF7W5Gg7YszsQ8hPp8ShOGI9CaB3DBqNCE7fWEai2xmWUIYaS7HIT+Gd4W9diFnUe0rsSbZNeEzD31jDyYatmbsgZjFUe/UnW4o5IAwZuz/XX50FQpmYZDj+eZHEM2F+oG95dTHjbSMW/Bo1sE2xTA96DXYHotfVHPVd/VsXRapeIVZo8SX4aCWR0q42D13j4litrrXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUD89k27z1/8emRZFnK/ljhLD12nxa/kxUyFmC4Dcg4=;
 b=fpSremh3NmyuAlYQRXw8JR3iRXa6U9z0NKX8X5mirfoqPBYAvgyNb5cnfZoKb/an/Y7En0xvjVuhkzk1SltHw4BbbpHCzKwKGZoAId+V7+QjCs4syqnoVP0jjwDw1sWvi0khdFwJc1FRpzL4m+J5cJU9SBoej34IREVAZPzFBbwzBlfohk0IrIA46HtGJxSrjwfjyTwyCPME2uVkVq2Y3Ehdsex0z/o6iCquEhidqULvIR2BeV8GfaQVsnXWF63A66Jdedve4QglGbll374p//E/nuQJLHY80GwddarKw6KRnBBZaYAIapECDVv4vV4DeR4EzNQwoH1XZfbKp8aPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 02:55:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 02:55:21 +0000
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
        Jason Wang <jasowang@redhat.com>,
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
Subject: RE: [PATCH v5 10/19] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Topic: [PATCH v5 10/19] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Index: AQHY+f+f5UyNSJvZC0+IiVGmpfVBKa5D/kkA
Date:   Fri, 18 Nov 2022 02:55:20 +0000
Message-ID: <BN9PR11MB52761E296D2EC7A8174D2E998C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <10-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <10-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: ccfad883-5cbc-4934-4bff-08dac91054f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBmT2R7REmIT54898mEqVhgEfyKbjD1OafXdsnHEFJTKnsIPj9FVTHjbWh9RpXF0EA88TzySnx4r5pFk0UcEWTVPqITup7CR/v9kG8Dog/foMcdTJ5qghxT1INal0UlEz5doFjr6ewUUqR6K24fxrRgP3I+MA9b9f3iaAxZ4v70o0fBRd6+wil7phGABkDmk+VgraqfwWjZjj0aiTbQcLfl0AACcw3evFVkNd2N0nfjN+OttqOCizxamkKoXflVENQK4n56NaBDqUYqGpIGhf1k3sdF6RDvWWJd+7R8s8p5lrM8CxKscbSvHy7GoAo65jvxlNW1iVtXs/sgCtAVN/+i4AMlKB6Iun3o4DEwz+CngMFfN0vz9+k6becvtHH0p786O+TqYK4blUt4gdAYOxURiUOQS/2uHx2mEok0KHfc4w4ABxwt507/oWUa8fVI+kxuPoZARNd1q2gjFiEcEkitA4BB1sycMcrFAy+h00Q96/ZNCr9i5u//DwQPM4v/HaK+jQDt1GEND4YS/l3q3iOX4jafIEQvpDQYDEET04c1jGzrLizORJNp0pFjFv08MGVb00Bw05b6yQPGiFmfm881+sj2YUiI49HmdiopwUULbOm2A9ez5b6ZO/14juhkxqpzTkhLyx8EdRLZWNeZYSxiG9k44J8wVPxKS86ot3k2bo2YYM6LVXCK6lbg9hQvm4JFTSRSNcgVQxcauREW/MY8qsylPYuAwMlQYySCFdk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(5660300002)(8936002)(7416002)(41300700001)(52536014)(478600001)(33656002)(2906002)(7406005)(82960400001)(71200400001)(83380400001)(38100700002)(9686003)(122000001)(7696005)(6506007)(55016003)(86362001)(921005)(38070700005)(26005)(186003)(316002)(66946007)(66476007)(4326008)(64756008)(8676002)(66446008)(66556008)(76116006)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8+GPTe5HuYTtKef1VnatHOizgHvV4RackK7HhYGuwwfA+k/mrbHOoDrtPy7?=
 =?us-ascii?Q?p5oe6bgoRzaF/FQu+IHTyBW0JQurclUI3l6Um0EZ8ie385i09Ms3YHJAt8cm?=
 =?us-ascii?Q?QNnN1bQGihRNejDWN8wwppjs7vhdGWN482eBU904Z9TWt57hwsC35Z/LkSZA?=
 =?us-ascii?Q?wp23ewcD1AIYt/q1nMrAbk1foXjVqgsAxYk7Afu9B3fxxASrZ+xsM20fhZEf?=
 =?us-ascii?Q?bWw9bkuzrLM96JakyPh2k1lmfcfV4EzSYsMW/nNPOsxHagoM8DzkZubvw0uI?=
 =?us-ascii?Q?KYYy4tqJXjBCah8p+4vXCFFgL23kJ8Zm+aRlXsepz2+AvKg4LrvE7rT5JLRR?=
 =?us-ascii?Q?shNgsSUxxliy2RWVmcWlRKZBzAB0WbaC9XlWCg6TXwLiry+pSIS5aDHnUrNm?=
 =?us-ascii?Q?S0Odr2kBts458UTkV/yhznmLVDRI/ixLmSf6Q7A3spnaNr0H3dOMKNA6x91Q?=
 =?us-ascii?Q?Oo6tE9y1CzXXF2fY0ZKIW4DfMVTK6vRdMrhT0B0/u11rlef06R7/AZsMcyHU?=
 =?us-ascii?Q?NPLOWNj/L6PdYbSgnk72l7DaOcW8HjtLxju9jMZZ4aHppooJbJ5Vk1OCsp5g?=
 =?us-ascii?Q?cbJqGxYDFjrUJ0WukYEy9gkn9Xtx7snSX6otwaM7/yy1oV4LFIXxg/RykeXl?=
 =?us-ascii?Q?KrLeNugub5d1F91n4vu59kzT3ESTDboDsjRs1unbgnewdx15u4l/vR3cmnft?=
 =?us-ascii?Q?WiZ6W/0F6z3ZUMo8VE5fOGqFTImf6G/q7xldlRgR2J39QDpb5JAzYyEe+Piv?=
 =?us-ascii?Q?VfqNuo92s/aPg/xs0pSt/lNgCnETbTdUqQpIsI5Ie9EWSch6fM5F65UJkVME?=
 =?us-ascii?Q?Y6qvlXwcLjgB6EVjp5o+DzpQNeRNxomszms4U3Nl27OIZH3xzRUV8IC4xmzL?=
 =?us-ascii?Q?PXrWcixYq0ei/W8yCOXyDwld212NSG1ndr/HEwYgavSe3gE3rdpmytysrCBR?=
 =?us-ascii?Q?zXbcnAuHZ0wgzaxEtLUPGwvyu538Kls3rzUUsMrU35orSLd7DJFiJlO/r3r3?=
 =?us-ascii?Q?ICpP6mds4pTDsM6tDiXblfzlwRXE/RBdmMfULbgTlUgqv0Py/RSh/ruUC5Qe?=
 =?us-ascii?Q?OvtordngO64zvK3uOMt5pO0QYd1pS87E17SkN42d2mKrfGpcpPXrg5pY9yiu?=
 =?us-ascii?Q?q8X8RXqIFAwGOQWZX5W0+4ZED9NuYqP+Bxyb1aMe2qQpUa393sNwDkIeuLfT?=
 =?us-ascii?Q?hcWlHomCHIIntE4MahlyNDZIN6Af/awd3kaCdjE3nGcF5m/kKEFr35cDULq8?=
 =?us-ascii?Q?tXOlhy+ZTUATvaHRMuY9zcx5uyB7sYvxhFOJlTdZ8ZjYI6YKgExF1aENiRex?=
 =?us-ascii?Q?W/yhU1Bxsz9ZfF47oYzhI9bIivoGOXZW3ZuPwukqXOEJLJ5SXQslcwmriafD?=
 =?us-ascii?Q?sUmA931A8c6DDIqjxZgOm20Q4tRXK000Y33Diyz7giyleuNuAP/mK24kIIRT?=
 =?us-ascii?Q?pniNhMybNSs+dvgLlAdJQIaHkrzDSqEgoaJvZzBnXz8cIQjnUCdRjs2dWA0J?=
 =?us-ascii?Q?sOMJ0mnuSvrPFWexzcarvZPRcaxCvLFEQQLDXtpGD2OUGSguNRQJbdHVVhUp?=
 =?us-ascii?Q?7HAeSD0g+ASkDYiKJn2cggS10z6UcGPLHxhgCtVr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfad883-5cbc-4934-4bff-08dac91054f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 02:55:20.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buLkLbty/E7iKjhxUQJOzTs+lrQI4iOxcktx1CRliW0ej+bPMEn0poP0x9oidUECUPTtuCuobi26Dl7EheNcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, November 17, 2022 5:01 AM
>=20
> This is the remainder of the IOAS data structure. Provide an object calle=
d
> an io_pagetable that is composed of iopt_areas pointing at iopt_pages,
> along with a list of iommu_domains that mirror the IOVA to PFN map.
>=20
> At the top this is a simple interval tree of iopt_areas indicating the ma=
p
> of IOVA to iopt_pages. An xarray keeps track of a list of domains. Based
> on the attached domains there is a minimum alignment for areas (which may
> be smaller than PAGE_SIZE), an interval tree of reserved IOVA that can't
> be mapped and an IOVA of allowed IOVA that can always be mappable.
>=20
> The concept of an 'access' refers to something like a VFIO mdev that is
> accessing the IOVA and using a 'struct page *' for CPU based access.
>=20
> Externally an API is provided that matches the requirements of the IOCTL
> interface for map/unmap and domain attachment.
>=20
> The API provides a 'copy' primitive to establish a new IOVA map in a
> different IOAS from an existing mapping by re-using the iopt_pages. This
> is the basic mechanism to provide single pinning.
>=20
> This is designed to support a pre-registration flow where userspace would
> setup an dummy IOAS with no domains, map in memory and then establish
> an
> access to pin all PFNs into the xarray.
>=20
> Copy can then be used to create new IOVA mappings in a different IOAS,
> with iommu_domains attached. Upon copy the PFNs will be read out of the
> xarray and mapped into the iommu_domains, avoiding any pin_user_pages()
> overheads.
>=20
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
