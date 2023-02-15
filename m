Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76002697750
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 08:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjBOHYn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 02:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOHYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 02:24:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FE21A31;
        Tue, 14 Feb 2023 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676445882; x=1707981882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ANa7FmEZUvP60TJQkLTnjQgVrlX0FMtSygL4/jU7eR0=;
  b=lvkeT5L45cKpqwfGK1L0Jm5LHQF2wu9+kQYBD1oK4l5h0NrmxmCtaMcH
   J3jH65VYVNnaHr8w6a5mjY9VC72pWjBtgD0BvVbPlkzI0TOuF4CzC2sRG
   1/lgU7kzgLi6lXZRYVwCTDXVe0HuctxHAfgtjov+fHr5a31SxFpuvIM5c
   Y4Vstg6ZDX+XelCqiDjLFWHJGhk2dwnGoea5/ZhIRCRqdwzomJVCIEFCi
   DeL6Y4Iy3c6+693R5HDCSP8h9dHe2w48e/02GUKbjqvG+ZvkdgwRIZpH1
   hwAFhEq2Xw1Stg277WhvzDLqKFxOub9hlnZ4rYiEpT1q3xnt2Y3Hou1nG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329994011"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="329994011"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669505119"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="669505119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2023 23:24:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 23:24:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 23:24:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 23:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk71nlYowIEVlufwnOB7aVHk70mgLJnR6xgRmFscQLbg18FfLFojkqvxz5tywrOZppqnA+3XFgX9A9kib7xvMJ+kWu7nVXPclOvlvGAxYuAl/PoDnJMRvUwNchTM0EdMPfSj8hUHmhuWvUqHBzVtly+L52924ZHnZzXWkwc5PgXr1bN9ZtRnh4MIdW1QaRuZFPEJNcbCjg2WEe99FiIE5naeNa6MJhdbvuNmqIZ8tNjrdrOZBtvHbfap5CE1dlw4r4UO1tiiE0vVgu2SJwtdMEsQqn2bELX52Stvo2z7Eka1Anfx5MZGRbVWoPai47yN8XwoauTdkbuFxrAVzHXZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANa7FmEZUvP60TJQkLTnjQgVrlX0FMtSygL4/jU7eR0=;
 b=ju2Hg3hv1JXQ+fkKoJzLVp2L5/tFRAvY9FEFZJ7BxEOqoBuEgC2TcLzweBwKZtbgF4mTv/C7FrkUPQLRpLMC8SUFch+cVL/BEUcqg9ex7XVM3U72YmfXD7VQqS63IaHNYk2Ah/ayUBEQlhz26TY/y/nc80LVx1HsFAMCkNAQBRVAdauMGqypINHVDzzijAOArz6dKYFlxrySiF3HHro4yNqQIyOMXlld92XmBn4FdVwZT2iUIPLt2rJtNHcE8JHaAg8TiREpQAJXJVH6OTYuqoXEpNoObx3w8Lyu5/A06VipPtk6idcuf4ftgBaXD30RksE95vYzMZ8erNpolTrdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7170.namprd11.prod.outlook.com (2603:10b6:930:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 07:24:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 07:24:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIABdh8AgANLy2CAAFjcAIAAdaUAgAFQnACAAPZWYIAABlAAgAACwKCAAFWxgIAAAXRw
Date:   Wed, 15 Feb 2023 07:24:30 +0000
Message-ID: <BN9PR11MB5276768FA501B5CD573745108CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia> <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
 <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
 <BN9PR11MB5276FA23E61977389D0C1A198CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+yGfXYlumqOU5xj@Asurada-Nvidia>
In-Reply-To: <Y+yGfXYlumqOU5xj@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7170:EE_
x-ms-office365-filtering-correlation-id: e36c3f1b-dba3-44d8-6f43-08db0f25ad65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kfy2rgadEbQ2hrGNiQIlfPbp/eHo4MGTFU4x0+Jjr/iGc5x+NFesQUaz1HzMSeTuvuAfxpOBFg5b4Qs8TLaAYSWP5mMbrtZQyOwqsysR9ykg6DMLpCMa8PByOw59nxNRsEUD5WbjAtmxO1X3ACuTrM2I2IKH9hdnv+Mki70qir33IaK26mv+gSyLLqzCmBRCq6CFuUbckY4AvXGWXvTAfuCK6YfqLCyUTnbkVGbRr6G2lKegMJeg+7EghE5v2E8DhgT0ZzgCodu+pSNrbl+I5zCirHw9yzWiBK1HBC1nckuSukIAQp5rDQzDJa/39kJ7HPqr3TMSKEd3Fcpnpmvvmm+zamXOgnECyz5hffnA6zzmvi5u8L0sXtLLsLTZEpCuyohpRosmBKdrP3VCfQU90lu8nxhXT+xB72bo8bjvtUq4aLqcHv0Gt6BI4dTZInOAPdf3WrJP/ZINbVsGOmQP7EQBPNIku12rmx7olan5i2N7uFWtTgOboGCEj3uSRblsRriPR/rKcGNWKTP4Q6qxLKZxrYcsrUG9Bzu51xnIZBR2r5ahG54uaEMGvWbgMRxxL9M/fvMg1GFuBSlUJ6LP8aekrAJA3Wxs/yBvWRRTnT7QW9uDqPZGHczaPAJXpjvT1/Su9ryK5i1npdg6h0U2rA2GePA/w/aQ/VoO5QCy7SBzD+yaVxUHIEBhgiyOWFcsw0MC5f1ONB9Ppji0QPkcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(7696005)(83380400001)(186003)(2906002)(4744005)(71200400001)(9686003)(6916009)(64756008)(66476007)(8676002)(478600001)(38100700002)(6506007)(66446008)(33656002)(86362001)(122000001)(4326008)(55016003)(41300700001)(66946007)(26005)(52536014)(54906003)(316002)(7416002)(8936002)(66556008)(5660300002)(38070700005)(82960400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZRZ7LR3OSyFtoNa1t/aJ4n30uaGBwahICuynPo/cCRkFrkRrKJovZxf4xVQ8?=
 =?us-ascii?Q?DUdnE6wds4yUvG/LPYp5nEQJWtjqHuwzR0K7EbMLImAorQUQhQw6H/X9fRs0?=
 =?us-ascii?Q?9OzCb3e6s0VrALjZz4dV0SfDINsOvB3dZVbWyBQyZuTXkCywfXiGpL6LPDmf?=
 =?us-ascii?Q?inv1IVg8vOGZ5cWbGfF8aB+srZVzzkwFTjz/v5v/MjFT7w1x89flR3xzTLgt?=
 =?us-ascii?Q?kgWSPwt8kaSZYI9YwJ+sDQYOKvMhICcxklxJiH75/L0j372tdjyQtmjbS3+3?=
 =?us-ascii?Q?XTrFmXFlhNXS/WEQ0BXxfcNy+CbkP26+OE5YqaSTcIwB3cuRxGWNVbt3XwgJ?=
 =?us-ascii?Q?Ch3AdNTp7tXzFWaGk8GMhi8BZGEKETtbIj95Dm2hVsg04hFmCWCG0Bb9g1O8?=
 =?us-ascii?Q?i471NAEf5GpEbPWTYoa7ayr2KsepaF0H38lhWdhu+OQPGeM7RmG95QV85irm?=
 =?us-ascii?Q?jrSgNbK8n3j2EnGF/SpZTz0fHnT86iMAPUYXMrgWZBP9l/4PNKRrt1QG01a2?=
 =?us-ascii?Q?TcvmWyH43CRRXDfPgYVDoOQUWuExPysqUXeH4u3U1yR7NFcKEzL9tCvWIRqU?=
 =?us-ascii?Q?aSgV9RbGJ87my42jc9JvtG19efdAZhDUpJO7EleilNGHqRwkqDQUzpdnUIiu?=
 =?us-ascii?Q?AEcXfj1c32ljjcRRJk9gkj/aIUPcmSM2hCGI8yjzEJdHCfL0adH9TA6qSjG1?=
 =?us-ascii?Q?HRnM7/lVJN5hf85b6PtY6Oz6zNEXdm1Myn2rpTcRxi6Laohvq1ZbDiwP5xFN?=
 =?us-ascii?Q?7HWm2l3iobP8KLisazQcW52B0UL2bYCuswxjk8XpU3geiIwAGOyM2za0GK0o?=
 =?us-ascii?Q?jpu18KbEgpZ/7xMfMJRowKfkwRKia3qxaVSO+pbMi4apOjaxDz56u8D2HJT2?=
 =?us-ascii?Q?O+/zGO07FgmFP7CpW7Gf34+/LcSuhlyHsfIGIJoxfKtqUcFKbEPIWDl5oO/z?=
 =?us-ascii?Q?4PT/maNRTLlbjQivNOeaqFt/NkCsrdClh9cuuPmQegRFOqUy+2fevOwysHOA?=
 =?us-ascii?Q?MRZHf1+1uDiofzf22mcHbzMYA/F8hSxEtTe0WgvB9/quP1nZNaAOGrq7wY1s?=
 =?us-ascii?Q?Kq1cQN1nzg+IyJDepm+ho42xEPDX5DGItEGrTIAmv2pbdA+4trW+UQ5S13Iu?=
 =?us-ascii?Q?TJ91IknIOnjRPYb5hLDvtsTH+vpYJzsV9gV/1zFHJSXr8g/1Ua7PxVsSUf6H?=
 =?us-ascii?Q?igVBEkDBMp1vQnrxaioz4pzFe4OajgwVKEWsStd13VXQPSp39LNZCHyZeuV0?=
 =?us-ascii?Q?AajuZtpQDkFh73lRnQThHdkbA0KeTUSH2PeO1/lJzxolFAg4iDUmNmsg72R+?=
 =?us-ascii?Q?gqfmv3EBi+eppH3GqxJLkFC7R1cxFUIAij4PQMgsKoPh3zUuQL5LQ0vopXnR?=
 =?us-ascii?Q?cDDFKkJUWZphw7LYG1zcncukbAjLJXY8jBc4RqWTGbwNiVVv9JNqEMsTCHQy?=
 =?us-ascii?Q?K387/aG9gqrIwkwwQl5Uk4mlrSOnpwk6Y7Qm1utG1peL4OUwytrg+TOpAOHs?=
 =?us-ascii?Q?pLdwboQyzaEJrW4bIV8QaK6WoT+PS/XE8gKRSB6Jvv8Ar6wePel1gBlg/A/M?=
 =?us-ascii?Q?6GU8pmR3F4t1/yvSJHO/rchJmvahdEGgKFUCe4hk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36c3f1b-dba3-44d8-6f43-08db0f25ad65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 07:24:30.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SB/nzzrTG1C1pgnicnhyc9/2LuQ/sPjxIDMpzDdaaPC4XTHTvI90ph+bUanQvDrrzrjFx7LZB/s3uB2Wz2aRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7170
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
> Sent: Wednesday, February 15, 2023 3:15 PM
>=20
> But things will be out of control, if user space continues mapping
> something onto domain1's iopt for idev2, even after it is attached
> covertly to domain2's iopt by the replace routine. I wonder how
> kernel should handle this and keep the consistency between IOMMUFD
> objects and iommu_group.
>=20

this is where I don't understand.

domain mapping just reflects what an address space has.

Take Qemu for example. w/o vIOMMU domain mappings is added/
removed according to the change in the GPA address space.

w/ vIOMMU then it is synced with guest page table.

why would userspace construct mappings for a specific device?

when device is moved from one domain to another domain, it just
bears with whatever the new domain allows it to access.

