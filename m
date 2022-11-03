Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119416175EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKCFDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 01:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCFDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 01:03:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673217E20;
        Wed,  2 Nov 2022 22:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667451793; x=1698987793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WlsoWM3cXQ40rTxzgRf+zKSEXCNgez6ahPIqPjBOkd0=;
  b=maBE11NLqk5UyVaTEQzcHC0szK2srUaciphplg4qctOqqC4wuYbJfL/d
   g4P/HkiLrmV/sCvZ8i1eh6AS6snIHx/Gi8D9HqeiLEFYV3zLAIEQEX+iK
   XQO5VpQY45oo5q0jGEbI125lJPuYLZ3HF9KJ0xvTZYI9EcwthDHGO17o9
   qZBnI6l+a20BROWusRLQMsY5pC6cMNf8uxi2BeskIgUYW859gNZsiJLxN
   IP+ob2yTbJgrKXSBSXeI10xnjAklEe7sccH4zydlnV/ifYMTBIdejs9Kp
   FbH5gnMLK7fTkfwlUipOJg9f/GI+45R32c386i3E2U6w1BVhlgZnc/WAl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289299866"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289299866"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 22:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759806889"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759806889"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2022 22:03:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 22:03:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 22:03:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 22:03:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 22:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN16u5A1heeBKuFlw2bWNehIoTl1E1Turc7cDdEYb625LggjlSbpmxzUD150C1B3Qs5ets88JD11U/vSZttCBqfH60UD/eJzqz/sV5F3bVp/AFc+RIRgTN5BmFsOrltB4AFm/6glmXmgrdCqGNJwEPYqKHBfrb38mCh5XsSA8Sx3xEqACyS7hVDS1HBJ8Xjx37IXYnedGooNvV+vN0ocXOQ7YhJhoWoM+vLEU0v3R/n03W/SOwM2b/ZW1PMjob491fB+VXpa+DMJI+fsQdwsd9lsPseC04LJE+VT/4zJcVJ7sld2CzuYcxVM/qbvedrA1OHsXFrqp9b0be6q7XFxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyuge1T/gEUBOaXmzilULfHQeBwmdTMPA+dhQMm2Lds=;
 b=CUZQlXxMEpi5aXmCCmDHsjcIaOKUpAGwvFUdNvc146HmJ9DsUGwbz3WIGirywGRN7w4oZw6/rk3qS0OLaSreAgC9fn5JMsnQXqnyETLfCyTHg6E/LzO4MdxjTzNMOd/2UQ3OUpY8qoQZbYcB+itYQSZGQ4+zG+rNF9nvHdgm5rdviop2OjnagJTYsPHEt8nzlYZXb3RG8vNpR16iQQxb/+PndHsLUJ9DPCQ3gsdfPhkP1rw2VXrutkFKgP2TF2gGqAcYeZ2ms5J4/+4Yny/jYqLhR7G/qzo5K8OYUcSiyZxDfmncLsKQw0OVzssfG6n9N+ikSejjcNFTE0veskaiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 05:03:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 05:03:02 +0000
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
Subject: RE: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Thread-Topic: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Thread-Index: AQHY6J1pKmFlCrqKv0W024OFAAUm9K4ssNig
Date:   Thu, 3 Nov 2022 05:03:01 +0000
Message-ID: <BN9PR11MB5276F41D50FFAFFCC8186B238C389@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 356cd29b-2411-4e91-e3b4-08dabd58af17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgYdYCv+p946+T/1CAhe2Ps0UBH/3PTT4nrGF5iXffSn9ItG0qyFUi+ITPtXjj4jKLi/zdhb/M9V6UBYKzm/6SMj5p03vWRqTMYGYr/BfOi2YOaPB/PaUmfAhVHp1GMJJskgC+mzkLv7JpV1z/wsL4XjYdj3qvhN5LTJIez4kYhPenbrGB/CYanFBY6R/Dcg2Qi51GRyFe5IL8lSVHjxcxcutbQ/uP1YuiIxVX7L6/X7Ymgns4haen5vV1fAhtDDRClWkQ85rsPDYhPY7Lt+y5Mmz4YNrB9Ddo4R5F5fmjH5OQN/+UQDapZGguS1lTOVRYfl2dqDY1uWnarrBfwRLp0/oXNqEHSvTNtKYBjlp3uw5tdX0GRUO82ff/45/ih17sJBip2BiSTRt4Dtn7V3Sv8oj4jQ4gycRG0gPAsSQwPaOcgy6oYLiXQy1O/LbZbq21TGvUdRFUTx4wFGfLsD3PyJ8OuCF0OjhjNPTK7HmMSEOWsOIhQhg06WLSrS/BttBLt8qAscnHBAeXR+YLjhAM5XR7xMNqSj95M28aknWw7bjdSMRKAHwT5+FZh6L0beER2VatuvJa6MozkU250ZkXqDo6H4nbYNCsMu0SsUgMMw52Su8kYtWK6IAJ2yceiw4s/wa6cLz/HPfVV3sam5mgb7/C6mGbHLDukG45vOfoV4EyDyHK3pONoVaF6Uu0VHxZ247KuKP+7RBZPyyauIp4uj9N7FcfHbrSyMlEVpNAKfaYObCojPIoEsXik4vt1HGOP1aBcSDW3sZrFlFhBuhYVyGqS4NNfYorypSeGP7ng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(66556008)(38070700005)(86362001)(38100700002)(122000001)(55016003)(33656002)(82960400001)(921005)(41300700001)(71200400001)(52536014)(316002)(4326008)(110136005)(9686003)(186003)(478600001)(26005)(7406005)(54906003)(5660300002)(8936002)(7416002)(4744005)(64756008)(66446008)(66476007)(8676002)(7696005)(66946007)(6506007)(76116006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?egewr6HOfJoQCcIIzZ4YRgvtAFyz/Pxg0kJQZqrUciREzJN349Z/tha4XHJE?=
 =?us-ascii?Q?zwgKtv8ob4f8Eu7v9QeKB8Cgp2o65Z9Tppg5/klqw33zD4BbhEbfesem//GY?=
 =?us-ascii?Q?sM4VuWfqnhehucYvFUvtTApVLStV3JwiaAEGK0BGe9aZjFEr/tkTTSpr73Ti?=
 =?us-ascii?Q?syLdAeA7JK76cdS9apmdpTDFLvI5szosBbeYB/iUpxqboNrb/KYH67sUFuui?=
 =?us-ascii?Q?fam+5FL9DknNqxuXh7newGnzOjvahBbaPURG8ARWGfb/TG63DJ2tnbLnSGWH?=
 =?us-ascii?Q?yah2mALVo/m1ZTLjheC9KD4D1Bj3i9agv93QY3CB6JY3/2cPVIq3icOIcYxP?=
 =?us-ascii?Q?j+nvzP7ieoniMy6ij6VNGH8KnRawoGK0rGG88t7l53d1Xw64MlhF27DXS7iV?=
 =?us-ascii?Q?2J7HlXRe4T2a18BlofcfgGBxu6iE1q5u7kumxB5wCiZFgVW+WlOxnBRk0hyN?=
 =?us-ascii?Q?3/71JfCm8XyuueC63DpITWdaH/lwU1vEF3+u8tRt443DX65zMVyb2opGRqQj?=
 =?us-ascii?Q?EJp7v91lz59714+iRh2d5bgVPNyp3fvYXh0c42jVu04pTvVScAllPy4Ctzhh?=
 =?us-ascii?Q?7gB2rwIDWLPGb76XXSyOpkNE5mvy2hwIdMPWjAn/O32VTyxshq8suDNESRHy?=
 =?us-ascii?Q?I6hRkaTqDUDthWnK4/0q1YfAPam/y1hJcIiH6p7+kMI6MpKQWmF/vhWprlww?=
 =?us-ascii?Q?gEtZlDSYbzbzhcj1qAsVlaGScS9YHCPs3udfJFVB0odv2uDeg/+A6NrxL8r9?=
 =?us-ascii?Q?Dk1qqGTQUZ+AA9yUe2C00BKy96OkaGK0R/mcttmt37M0kyvgE/pGzznxr75e?=
 =?us-ascii?Q?xqILGeeu00gS0R6/PWEgoEkNZi824CdTevxXt7A9MNFvvVyb7nlN9bU9GqUO?=
 =?us-ascii?Q?Ayoo/bagLwhw2ywd7MBcFKIMZyLjsz1kq8bnVRdAlrmK962yEZIhe0w6l3ny?=
 =?us-ascii?Q?Bk7QKfx+4TPyarTQYc+lDEgLrNjFgx5aD2iKHF0X/cN1eXq+V2Wnf3b6YURg?=
 =?us-ascii?Q?lQYHEH33gt83HelpxbBy3Gd6C+subJhROfeS1Buo+ogqV0oxmigZ8CzfBxI+?=
 =?us-ascii?Q?DLFUj4aA2/pgKmxbDCfmhswRC2T7xgPcniL6tfoa2OSoG6wMaFQ2el+8QG8j?=
 =?us-ascii?Q?pP9BgDQse36uFbkvybovlQr8jlJRVFVSXaX+HMVhziUQ2ms2NBP2z7iiXWMw?=
 =?us-ascii?Q?hXY3PBRWkHEq0Op5TFkCnzY0r84CygiqUI65FIXw8DVqoLawXBiT/xC8XkcS?=
 =?us-ascii?Q?+Qi1IZrzO3mLaZy2w2T6GFEz3xbKgrtFMZOp+TO+W9Z5Asho41xt1NoUVaoL?=
 =?us-ascii?Q?EaDph8yY798fdudoKkTLE6o+FZVLxxiccX9YzlVZqwadcW2u+9zl/Dwz7fRz?=
 =?us-ascii?Q?uRUzYx0SNxBpff1Qn6Qeg4uotOp9IxXeyIMPZVHK133G3IzO67KsPKd2aoBO?=
 =?us-ascii?Q?uXeE2AVW6NWOGuX6Hl/BBJjSu3VwxZ2C2k732OAxi1dQGll8JINKdeUHpjrl?=
 =?us-ascii?Q?BzCuR35gfT1TMIejxnXB2ZB8q/eqcsGKqMtAQzWbPTW3WN6jfpBJKOu2Ub9E?=
 =?us-ascii?Q?QxvpyhklYGqSORW7xX4SHSExGWRcsP7vzQqUDRS3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356cd29b-2411-4e91-e3b4-08dabd58af17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:03:01.8071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dugcSgRdV00XaytH5jfkAaeR3Hr2OWRabkJJf74l3WtpyGY5pYbz8U8RrKkIKzE+UoN7OA/+Ntn+Cu6OJX5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> This queries if a domain linked to a device should expect to support
> enforce_cache_coherency() so iommufd can negotiate the rules for when a
> domain should be shared or not.
>=20
> For iommufd a device that declares
> IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
> not be attached to a domain that does not support it.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit

> @@ -4458,7 +4458,11 @@ static bool intel_iommu_capable(struct device
> *dev, enum iommu_cap cap)
>  		return irq_remapping_enabled =3D=3D 1;
>  	if (cap =3D=3D IOMMU_CAP_PRE_BOOT_PROTECTION)
>  		return dmar_platform_optin();
> +	if (cap =3D=3D IOMMU_CAP_ENFORCE_CACHE_COHERENCY) {
> +		struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>=20
> +		return ecap_sc_support(info->iommu->ecap);
> +	}
>  	return false;
>  }

use switch/case while making this change.
