Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1501E76C61D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjHBHKk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHBHKj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:10:39 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9A411A;
        Wed,  2 Aug 2023 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690960238; x=1722496238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XkVpVoEmEz4t3bxdYPv1vnPMhCvaWn9l9lvxy3/JoiU=;
  b=Glse5eTg06t6s5RL56tuxDDbSZHr7p0CZv8rMN4l+TEDUw4/2SMRnTrY
   6bLi+sDgSfilq8RjI5QGqDHlHxipAwH3CEf3e6wvJOztjS1lkuc7RZpfX
   ga0CwSpWxc7jizKX0ov0Rv19Z4iTlIMU1NlGNkU3IrneMr2ciF1ntxbtf
   qclkAZ22+pZ6sYgjQ9HlTS+aMqTSpwfewe4Mo4ks0WmgU9oeRVHKjen+4
   ydyH/HQIpfFZ6K7dSoZKeCOU6rQBObrVeuy38kkLXGrPWtW+M+03A02w9
   LEuDOSub96Rz4E0ADSsGRXxY0WgEjkl5uJixlm8vLK6Xx8p6m1E+EEFuA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349807361"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349807361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852778100"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852778100"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 00:10:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:10:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:10:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:10:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alNv9RhnHu5HS5WjQ/WedZIvYlJZsC5ojmMHaSmVymK6sFO+ey6GC1LnIlpW3YbpSf2q5JxJ0RW8fCV+XHrpDjkv2XdDHITg7pYDpYJKnI/Twx2tyjiwbtQ5vps9HcaI9w6Zmryd6aN5X9KhH8e+Z7yhAvAggcG184UJ2UZnFlsziVMxrjZlyXqlTUWcNthWWPqliVyNepp4Bd4aVuw2Lw21uSCtFQTK/YzGkhsyJ9I+ezZMSTMeSqaGKC7CP37xj44Vd6399IPt+ejK0XQDhdjJ4yWvWiqDWWUpk5DuudUor7y6ULWRVnwu8SP21tgwxcDx0L+y6yOnoTM1Ucm4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yvevByI2WdohqV9MQkNTqLCsXQqp0QBjsAQzmgzlls=;
 b=EtIBKEIz1ebMo+2BosRNoR5uPvVjDg52iF4DkY/a+tELkNgimRqo+aXVWdahm0NCpqhiczzzZPM15g9iT3YpyY0Bgaah3au7c8Y2qzxPIuQzELtCMHfpkw3fiW19a68ZMRWZdpqPVHkR+Qi4X2AhSgMJHgi1ilxsChaqdh6+GcxneSdoY3zeUMvd1BFlDQAa/3+qghaRvsXcklDOU667Rp3h+2FKkdu2+jBTPuzvEXLilLprLpozU8UQdC1Ewj/j5Iwta/i98ChzcF7KSxYYm1YYIkY9ALgcfHasMRjk+ndw7TB5pS28WrUEMagq/C0BpJeHQTOuMd85lbRsekpr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:10:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:10:33 +0000
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZvh/rKXvA0HWuiEqGDjpQbJoG+q/WoMHQ
Date:   Wed, 2 Aug 2023 07:10:33 +0000
Message-ID: <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: 1780338e-5a20-4112-050e-08db93279060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j775+6Yjf0C0Sj4+Htbl+85gs65CQQqhyEIkBOt4XweLNdHVVGQGMP89BCBRx6OB1y3EjnZuYmCSo328Egn8HUquPqYE5KJweLmLU7qaL2FFJVwEaBm4W3FaGyixB46yr9fO1CyMgKA0R2XPCQQipUrhXJU9ReaBtu/Rj4Om3fKS6TTFS1qBrSMFM1mbBIpXuriccZ+j/b5moF/qGX1ec2QenS91Hmy1cse5nqKfwJvcVUdJuE300LPSzXopK0KhXz4JPaywKqGJrc9+zC+cdhjiRe2Y92ucKTBfA+SwSmsoVzMFPBL3jMoWdnsGysIgoJ7V5Xe+OBYclnO2rpp9hoKavBl6GOfb/yFq9ug3wczoe31T2q3PJdW5b8pM6nePGeFaSihj7QBdsk2QaMXNVbNa+cWTeIj0zmliIemn4yVpaN9KoywM0T8D6sVCiKs+cyMG/1kTE3nEG4b5leeeprmoKgCNW7jWHvfx0ZY+ntIPDTLdtNkRTXG5uc+BkNATCcyQX0peIkZScEy4JfSBGDq7iKWnGVI7M7RnbYs20Ey+3L0dcqeGVg6unXU2Il20TCq0qtULnD3PKZzgJAeRPpOj1zuNXaUjIkrwy8BbEE4x+pGXdQfEnsR3KfFGy38h9LA8MNOIKCELwbzcAx6YBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(64756008)(66446008)(66556008)(66476007)(4326008)(52536014)(66946007)(76116006)(2906002)(38100700002)(122000001)(82960400001)(186003)(6506007)(26005)(38070700005)(7416002)(83380400001)(110136005)(54906003)(55016003)(86362001)(33656002)(478600001)(9686003)(71200400001)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LtkqaCYr6p9PR8K6F4z0t21yxgVa82WcgimltxPr4k3RffH/Zeq8WnFBzumN?=
 =?us-ascii?Q?eDeyQjXar8sM1jnxEwRIEtMNaWQCV1UflN70RAmjLPypPKEL+ZIjbj+QrCrW?=
 =?us-ascii?Q?HdEHLv3jzKQzRiGnmnnjML8e2GcGYN7lhuzp3G43qXv20WHQ+pZkzLaLrIXa?=
 =?us-ascii?Q?YYWaJEWz2debdJskmpBkTcRT+V3p1Jf1ne1gnWt6IoxJcO3d6GrW5kqOCUWe?=
 =?us-ascii?Q?RZDzIY/xnR2a+JYJ0VUve871IisNhOPEbYSAe8FH1hww3SjPAJpacHCFH5lo?=
 =?us-ascii?Q?VPIzci6BFjiQyNDD/nnjV3tyEhkccV07mbJOiQxD5S6IvbGu+H/tLfkMbro+?=
 =?us-ascii?Q?yjAoZN69kKxM/GqzuGqAkvKqCFaOlQu28+mRAKUCWvRIcnr3UCZ0d67wtdVQ?=
 =?us-ascii?Q?AwGFDgwrDNsGqNrOK5qdAd7WqghW/Pk/hQt72j+CPOpBs5RfbwxJHYaZ9va8?=
 =?us-ascii?Q?39QyHbQHQOZ1KEXME2T2lSxtWEzmToKX592KnUetVcLBPXnRICRHWk4axRlf?=
 =?us-ascii?Q?NKA81aFda9JafjHn5YeLST2gCjVLlete/cSePDEKbdvTFNw3Rk3rG9CKFYlZ?=
 =?us-ascii?Q?g9H2PyvNqNpUc2H5CjhkU/cZmO6o5tzdHhiw9g8BchIrwajwxUuze537lZrZ?=
 =?us-ascii?Q?xqWyVZ7xikQpnuW56Bwv/VH+GQrfWA3500XRQiADNbaxPa0VINAVOF1E9Ma8?=
 =?us-ascii?Q?HqkzrNDWmnEHe/UgcKqRyOijFJuaR98MJ3xpiL+lurd+7MUU24BwyLjiFOav?=
 =?us-ascii?Q?k564dIXAZw9JU2hSTbcdlOzYqLU2dLu+5CyoG1WydAbsqIoj0cCVzONzZHxC?=
 =?us-ascii?Q?tzorgqLjC9DB/r9/JiAhIQah1zo2lJ36pMe715DZ3Nz9/k0UlAsctPUHCdp4?=
 =?us-ascii?Q?OFvEO0mRX25PB4WTBAI4jl7shjUlgyund0aVpxNG93K1T2usH1RMqB1oesrG?=
 =?us-ascii?Q?BsO2B7imc297wyd0xOJXNEScZbZk8aotxoUN/I9CqV4lnTePVryL43V/jdVD?=
 =?us-ascii?Q?JOPK0KO0FXhqJQAstKeoE7Ao2gi/R2cmvTDznmRQaXw+aaITURESLeXekB0A?=
 =?us-ascii?Q?71mDOm2gx4O19yxAUtPWBatmV/k+s6kZB3VHd6+UmQ6GNS91M/V8t0FxInO5?=
 =?us-ascii?Q?1x9FNkx0AO/xctE9hiq87dZou0SCl8tDzXPw4ZhT/Zl33OTfeobDBh3L1V/b?=
 =?us-ascii?Q?oYZ1GaQm7Gl7+zXBKIkkT23xBPlVpvTHhxHP+YPokPF961P/UHwSxyf3soOJ?=
 =?us-ascii?Q?qhWeoMjhTsdfUzA2avgXp/mcOpxtNMbaK1OJeogxTmWePYYMAWK+hX/NQ65z?=
 =?us-ascii?Q?gJ3ynqN1mHAqVZ7prM1hdjLhMzN2I2wNDpL4WaMhXgj/bb8/bwMl2F1qtxIl?=
 =?us-ascii?Q?4qqlavrAI+YjUYm7PQwXeHJrIxafm9jiSrcafIgulNfD73KFyCpqSRpZmEIT?=
 =?us-ascii?Q?kHEzTgZNJ0jNcNw8Hzf1OEaxe1WGW3beFvJXYbYQ6+7sijxAmfxA7cHX0lsx?=
 =?us-ascii?Q?wpbz1PxOWL6RYkbJG/uzPzZGWb9zexaVmwqmApJibySZLwqbsY9qUmD9o9gD?=
 =?us-ascii?Q?bDXevoSGfYtg97VySAgnXOtsII4XEV6/ACqbiYnG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780338e-5a20-4112-050e-08db93279060
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:10:33.7963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWCU5lvX5grzcZBwdhvcnE1I92DWRDTfuUvjZtmXSk+N0wIl6GRDOHXegoeP09nPHbSqVS/jikHB9AsyWTm/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:13 PM
>  }
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translatio=
n.
> + * This could be used for nested translation based vIOMMU. e.g. guest IO=
VA

s/could be/is/

> + * and guest shared virtual address. In this case, the first level page
> + * tables are used for GVA/GIOVA-GPA translation in the guest, second le=
vel
> + * page tables are used for GPA-HPA translation.

let's be consistent on using stage-1/stage-2

btw the convention is to have 1-line summary, then the list of
parameters followed by detail explanation of the function.

> + *
> + * @iommu:      IOMMU which the device belong to
> + * @dev:        Device to be set up for translation
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @domain:     User stage-1 domain nested on a s2 domain
> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
> *dev,
> +			     u32 pasid, struct dmar_domain *domain)
> +{
> +	struct iommu_hwpt_vtd_s1 *s1_cfg =3D &domain->s1_cfg;
> +	pgd_t *s1_gpgd =3D (pgd_t *)(uintptr_t)domain->s1_pgtbl;
> +	struct dmar_domain *s2_domain =3D domain->s2_domain;
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	struct dma_pte *pgd =3D s2_domain->pgd;
> +	struct pasid_entry *pte;
> +
> +	if (!ecap_nest(iommu->ecap)) {
> +		pr_err_ratelimited("%s: No nested translation support\n",
> +				   iommu->name);
> +		return -ENODEV;
> +	}

-EINVAL

> +
> +	if (s2_domain->agaw > iommu->agaw) {
> +		pr_err_ratelimited("Incompatible agaw %s\n", iommu-
> >name);
> +		return -EINVAL;
> +	}

there is a duplicated check in intel_nested_attach_dev().

> +
> +	pasid_set_slptr(pte, virt_to_phys(pgd));
> +	pasid_set_fault_enable(pte);
> +	pasid_set_domain_id(pte, did);
> +	pasid_set_address_width(pte, s2_domain->agaw);
> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> +	pasid_set_present(pte);
> +	spin_unlock(&iommu->lock);
> +

this lacks of handling of force_snooping
