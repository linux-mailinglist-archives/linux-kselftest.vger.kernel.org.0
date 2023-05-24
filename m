Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529CB70EF35
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjEXHRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbjEXHRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:17:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C010CF;
        Wed, 24 May 2023 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684912620; x=1716448620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yBIGi8H7cGddECgvklDavznHrnZfUAH6CqJxHAgBoWU=;
  b=DojL3eFeMCL3uUuxA7gc6GaJ2fsMWbDigMsebgnKkTT5Z4GZ4TVD6sOu
   +W3WqthW96bj+CKYxYIgMz868VslyvUb71d+t36NVzIY4aOuzsNlsJnu8
   KD7oou6WHhmkaxVLbSoSYb9Z7x5aWq00VmKiPYqdncKx9huwtgK7R8xE1
   1S6OnyoplX9WR3jUZXwLM4/0OnHP/2qKcUVMQeJ9O3uwKFl8v/k/cyURv
   xIe6gapOxCDGXhXjdSo0KyFpD+1HBMMoZuH2DvNnzq9xPEAKylKm5qEBn
   OE/2QZ/AzWtchT40mt4szk0I8jfy823REYNhjcGL03Mg9ARfetBkG3Egu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355839216"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="355839216"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707382526"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="707382526"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2023 00:16:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:16:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:16:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX0sbvLAEwFsGLvrs/kqHSVjMaMs6K7V7srbR3NAu1ASk+E7ocagsBfvJnulK8DbYKHh62X0O4lkkQ3HE8wVRrQmq57hZJ9wN0mUU5b864wPlSjcXZfPfNNZMgeb80E08KD/uwWlszuB7Gyh+bBouLFmtKkOTJwKSKYQzRF3rGJmGYjEONYKzRYACRATUYtoEhVHcSYYN9L4YlYngG0WssVFxkTz8Azl/8GaycnBKao69706fAdK8IqkZADFyuiGzqu11WWMBETDX8/I/ZhxQSxDQv8zfFj1mXBrib0iQ7NqrSxPwo6PfkOz5RCxogTSbrHogE0Yn1jspWOYbrjqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP0n0we6xvZsWDd4JSzDRqU4ElkSV+93CP1SIDuCLlY=;
 b=X1P/PAoqgKvB+ZoC1SqWby3C9YzLBdGlEvfXPUN1JOfuV82rS9EQSa3ELaNN6zZLDpxU6Z77rk4Of/ni24CEN8xppZy1aThsfesvu95ePsT6i+yIJqkMEP2DQ7NxjaRF9/MaeqsQasyHyYeoFmkaPsQJ8dN5R6106zabQjx2Ie4SESfLeuYX+y9ph7qe0efzyX4z2ZC9O1pishZtlPhjaWBmCuz8XuRYlCDzdSNpl7LDyuZnPoTbmThfcF/YeXWy6qZ/HTeiIyWvjbuAfXP23fBG3ra3D9JnfGoPAXUt/HLjD2y+SF1jyjek4lOe1hj9qLslEEG3VT/8JhUv/rReyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 07:16:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:16:49 +0000
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
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZhBgSwGcl3uvCJkywv9FuZGNxPq9pE3ZA
Date:   Wed, 24 May 2023 07:16:49 +0000
Message-ID: <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7933:EE_
x-ms-office365-filtering-correlation-id: 5b7c7755-7a0b-449e-6ff3-08db5c26d757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJLxZDfwM7Z/Vuvmssv28oOwPOeq765R61mrgp/bJVOwvp0UPwSblzsXXnvSg8PjVIG83Dw7/Ei9oerUYVpEnahnZJCGuSPoYHtr3fNQJzL1iyZFkjqq0WhIE0PdgJHPaXt7qGSBumpa9mLowa8sdL0o2et2ij9Zv6wIBHMEub2sOqNV7qKMf6BEWR0mj0VB4EjSjnpHxaP5QAd/JPAHzfCFvhPzM0vmndlhd0OMtKh/4cN24okmRgag/xwoGEC8I2/sy9aOYrvzz7n/RU71/tzqzDUsZ5bWVgzZUjVl5A2dW8vGzjLyiyou1FJwOVvCM1P4jZVo63GhH52ML29AmSLjdWxhZlrZpukPK8JhUdLMnEvJdyBCTMcWnapkN/AYBqfWCIn4TcbrcFgIoOxG8RzuLJ5H1AHGpC+g9PNm1ZNid9uFcjfboOSrUA4mwrdMHedsAa3NUsyvC683LOY39vJBMSdeEu8OayVVZLyZQMC4UH439DtKLttA8VBsYcg8NO4UlVgtgSwGqkEa9KAizyoxD2m5SZ2eQzSXCf/vdvJIXt2fSaswQEhz3EcW0Oh2KICqAwKWgE2jBGXc570pxk1cYbVwtTCL+zpq1lDGdwC8qi5qIklm4ZLjjwQB6NAH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(7416002)(52536014)(5660300002)(2906002)(8936002)(316002)(66946007)(4326008)(64756008)(66476007)(66446008)(66556008)(76116006)(54906003)(8676002)(478600001)(110136005)(33656002)(83380400001)(71200400001)(186003)(6506007)(9686003)(26005)(41300700001)(55016003)(38100700002)(38070700005)(86362001)(7696005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sypPG3OmEyWnV1A4AKpmbOWDry55dGsCR3WkerAC7PA9l14wswv4gURHJxAE?=
 =?us-ascii?Q?lBVnATYQLtbKnB2kqEPBRKBubtRVqu8vFNDBUihhzxOcMw8yCT+LwVTXDjyd?=
 =?us-ascii?Q?U7nxwwrks9KCVJ475NoYGZ1EGkRloyyTaQcqlzToKGXzYnwzObzZF4ouI5oR?=
 =?us-ascii?Q?gsl+3PRTcXWsxQCfjivIIaLigM+/h3ntpHEsVKkEn5j0XsQN0TkhXcieBRIX?=
 =?us-ascii?Q?qrrmxtsmZeY6NPcF8VjO6020n1fbsLOmPljO69LmHvmYj/2jBn16qBwZrD1L?=
 =?us-ascii?Q?ADoGG4GIxX1edmHbwVJvcF+60vqN99TiaYkeEgpbFDNKqCVmJalCtZ2WzlDl?=
 =?us-ascii?Q?2uiTKivvPfixK6mnYNJ8KoWfMsRFQ0H7hIRbodrmVNLGvz8/SaoMHAFbLZYt?=
 =?us-ascii?Q?SXfaeEFIpsQpHpUrmoTUhpd+XoyOoQbgoxjPKLlwsXDQJ/aQ6TjOrvbWzoCx?=
 =?us-ascii?Q?9A68guiIjPSwf/tjsbvElmej0bj7dxKD903d6woyqu4wNEVmr1opy1DAX1nc?=
 =?us-ascii?Q?+JCXY3pcuzRxvHMveqmnBEah9gbGnEabtExqneJm8zxfVhrL+e+b+JygyUew?=
 =?us-ascii?Q?f2hhs66t8m9+s70xTela+WXFobGwOlHZX8LgSj/ayBT4kvafyEb6z4HgROWG?=
 =?us-ascii?Q?gEuakQQ7ItQ0/A0LnnF9kRRFttfCxHdDo6Y+6QatluRXobsswJGiWOjJ8UhH?=
 =?us-ascii?Q?T7fkq8yVf5MiHJVZp9myv2Lsqsfc0ha+wbP3XUFUOUnlfwczyqNJQMZEkr+G?=
 =?us-ascii?Q?MAbnu5xKYasRcnbdB0JKplKUaf77kBrgwwfftcuj6dCLG4cvTO+NFKZQpkns?=
 =?us-ascii?Q?oRwQLU59aF+W/NyPQ0Y19bArbcpXQglgR9KEdS2+0yt2rXxlilmD1xWOdcdZ?=
 =?us-ascii?Q?rfwcvQT/I6FaWX5iea+3iUmXzh5RpF0se14WUJOuyUg1e49v374/GqiJUg94?=
 =?us-ascii?Q?+HGjCAGXZS9Myi+CvfmCheWd+QqCJgSi+3dRkx1ed1jCgNXHukCMQy6PJnj9?=
 =?us-ascii?Q?eZUxDuXkJNQXDsvJXXUfg96F1GIWg6jZMUBl/FCxfFdaRPh5ouZAqdAyxZn/?=
 =?us-ascii?Q?Xis6mxpQpVU6QlYqm7iJLY5/1HbzWb4cK0NebNU/x92kt5S6FiWZwUkC6Zhz?=
 =?us-ascii?Q?DQNmUGyKvziO/VFXDm4xNHe+xfxmZfshf/1zJ3cC2ejksvLzvkhkMqUIste2?=
 =?us-ascii?Q?7qGp7Jwu6TZcrz28QsiixT0f/50w8FqJdS+Xpm4L7wcikdCnKoYAOZ2WVCJp?=
 =?us-ascii?Q?Kv/QFc/OVyPfa9X4i3hvsxqkhmLbAoCrEnLYKvuji1bjuKLo8e1GoXRBbkU5?=
 =?us-ascii?Q?yeqUD5SxC31BhgpZs+UPKfuFO2+Lwunp6DJxbsVbt3BBk67G2hYzKePxTfvB?=
 =?us-ascii?Q?PHGQDLEHeKNR+SDQjtMAfN5vjR9gtuB9yuKi+nWM2xEcu/YgKOoKKWP0hAqn?=
 =?us-ascii?Q?6QQhRHYl4I3sOVMKGaD5KnsTaU3p+xy7V9bdSya2Kidl67o9TY3yuwTT/Ucf?=
 =?us-ascii?Q?av3e3FZFOF0LtKijtQS8+yy5PsmoaQySBs+jHglv8gisnpZ5icLpxOLyVSTr?=
 =?us-ascii?Q?49OF4IhFEIttCb5M/jALqjo4V2yl7EDXZPey0YjU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c7755-7a0b-449e-6ff3-08db5c26d757
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:16:49.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1f3g2zfR1Brch+I6CMOChNp3eylCW1larPGoGwWNwYE8uj34S+Zxk3BvCwz71E1M+P5XMp19oC92O7P5VPXbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
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

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
>=20
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translatio=
n.
> + * This could be used for guest shared virtual address. In this case, th=
e
> + * first level page tables are used for GVA-GPA translation in the guest=
,
> + * second level page tables are used for GPA-HPA translation.

it's not just for guest SVA. Actually in this series it's RID_PASID nested
translation.

> + *
> + * @iommu:      IOMMU which the device belong to
> + * @dev:        Device to be set up for translation
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @domain:     User domain nested on a s2 domain

"User stage-1 domain"

> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
> *dev,
> +			     u32 pasid, struct dmar_domain *domain)
> +{
> +	struct iommu_hwpt_intel_vtd *s1_cfg =3D &domain->s1_cfg;
> +	pgd_t *s1_gpgd =3D (pgd_t *)(uintptr_t)domain->s1_pgtbl;
> +	struct dmar_domain *s2_domain =3D domain->s2_domain;
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	struct dma_pte *pgd =3D s2_domain->pgd;
> +	struct pasid_entry *pte;
> +	int agaw;
> +
> +	if (!ecap_nest(iommu->ecap)) {
> +		pr_err_ratelimited("%s: No nested translation support\n",
> +				   iommu->name);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Sanity checking performed by caller to make sure address width

"by caller"? it's checked in this function.

> +	 * matching in two dimensions: CPU vs. IOMMU, guest vs. host.
> +	 */
> +	switch (s1_cfg->addr_width) {
> +	case ADDR_WIDTH_4LEVEL:
> +		break;
> +#ifdef CONFIG_X86
> +	case ADDR_WIDTH_5LEVEL:
> +		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
> +		    !cap_fl5lp_support(iommu->cap)) {
> +			dev_err_ratelimited(dev,
> +					    "5-level paging not supported\n");
> +			return -EINVAL;
> +		}
> +		break;
> +#endif
> +	default:
> +		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
> +				    s1_cfg->addr_width);
> +		return -EINVAL;
> +	}
> +
> +	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_SRE) && !ecap_srs(iommu-
> >ecap)) {
> +		pr_err_ratelimited("No supervisor request support on %s\n",
> +				   iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_EAFE)
> && !ecap_eafs(iommu->ecap)) {
> +		pr_err_ratelimited("No extended access flag support
> on %s\n",
> +				   iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Memory type is only applicable to devices inside processor
> coherent
> +	 * domain. Will add MTS support once coherent devices are available.
> +	 */
> +	if (s1_cfg->flags & IOMMU_VTD_PGTBL_MTS_MASK) {
> +		pr_warn_ratelimited("No memory type support %s\n",
> +				    iommu->name);
> +		return -EINVAL;
> +	}

If it's unsupported why exposing them in the uAPI at this point?

> +
> +	agaw =3D iommu_skip_agaw(s2_domain, iommu, &pgd);
> +	if (agaw < 0) {
> +		dev_err_ratelimited(dev, "Invalid domain page table\n");
> +		return -EINVAL;
> +	}

this looks problematic.

static inline int iommu_skip_agaw(struct dmar_domain *domain,
                                  struct intel_iommu *iommu,
                                  struct dma_pte **pgd)
{
	int agaw;

	for (agaw =3D domain->agaw; agaw > iommu->agaw; agaw--) {
		*pgd =3D phys_to_virt(dma_pte_addr(*pgd));
		if (!dma_pte_present(*pgd))
			return -EINVAL;
	}

	return agaw;
}

why is it safe to change pgd level of s2 domain when it's used as
the parent? this s2 pgtbl might be used by other devices behind
other iommus which already maps GPAs in a level which this
iommu doesn't support...

shouldn't we simply fail it as another incompatible condition?

> +
> +	/* First level PGD (in GPA) must be supported by the second level. */
> +	if ((uintptr_t)s1_gpgd > (1ULL << s2_domain->gaw)) {
> +		dev_err_ratelimited(dev,
> +				    "Guest PGD %lx not supported,
> max %llx\n",
> +				    (uintptr_t)s1_gpgd, s2_domain-
> >max_addr);
> +		return -EINVAL;
> +	}

I'm not sure how useful this check is. Even if the pgd is sane the
lower level PTEs could include unsupported GPA's. If a guest really
doesn't want to follow the GPA restriction which vIOMMU reports,
it can easily cause IOMMU fault in many ways.

Then why treating pgd specially?
