Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D60697622
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 07:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjBOGKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 01:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOGKw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 01:10:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84E2B09C;
        Tue, 14 Feb 2023 22:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676441451; x=1707977451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zhtUr599cfLAz7OMf2EZc09zeFQyL8y1CtQNdZ4fvCc=;
  b=KDsTuCS6wSQBNBbwuBiDxjq2T9MtDwiJDRAlQrwnQtZXEtPBko/wFkvp
   co9f6oRtcovumzPlQUVh0CGJVQ2nYSeFyhS20QcsudVHGwDIg+NqFt6IH
   0/6y313xE4O/vI2hAEWX05DTnu0c0nXEE3wv4sPUcDIv23xRSan4KPpGY
   ryimNG4CVlrwtnfIH1FqQ/UnPq0Cve4KY+BE3VYRei67PXqjCLX7pHQ8O
   j9S5/KtVdt94v1q23WlxBq/6uioCmGYi6eZNzXcJIMmcsJphDLyiYzRMC
   NmJ1pMHqgKlXZ9duwOdKDKeCsWS8gmuZeTYuY2WSBXqHDh6Ao+K5yMthZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417574562"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="417574562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:10:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793374497"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="793374497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2023 22:10:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 22:10:49 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 22:10:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 22:10:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 22:10:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXYaU3dkJDfw+bP8B6ITUYQB5ovAIxX0PnuwiHNeJlX2Lajv0FMuUri6PUh1iFwIRjW2R9g7sTQbux9s8yh17Vky24c69izboKNCtUoJRSvnPFvnTd+QRm6YK5ome4gSh1y86DBIL/MDJVWMNPH7Xzaq35BeG40+Vp2ByT/rJpPTE2qwggfmr9LKwVOjkvBiBX7XwldTtx3HzM1KRD9EzWJB+p9vno5b+RG3BWMikpcruAB0AVafkd0labqSejoBOH6SzDgAzrfqLIPsr0sN+QsY8pHJQ46oupwplUUaC8THAwmjjv+0CKxXqXsfM1ifGT5IE1O9i+Nt7V5eBVU4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZbOJXrEJExYcOBUvxA50c4KgzWbZxtwMnpN5u9mK94=;
 b=V+BP7/8OcyruE6MSEMD+lZ9PzFuGq0l2qGncKyamqQ1YjdMl8yeE8QsB2Hex4w2rsq/h7MMyrZaKoy+j6Nzt79IrZfaJfYql9quJsjtNIJGP7sSYo0P93IRz2GuyGtFMa/5c6HdmUrwZFKWgjRR+aQ19WbZgwvuA3kU0F9RK0Ycj3WTIND4uN1xo4/3kV7b7Rc3258Qu6+I4Zld78Hyqq3ykuVl0jK48+BeeZC7j3t0VahLx7vpqRPI5uzG4aRDYuxv6WKnR/okvjitYYv207hnbJa6Jnu8CU+9k60exLHhtZ/4MFe4FaDKSfJjxKGNUtxxhaSoBlPxQO7I5x3H3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 06:10:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 06:10:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7PjtZw
Date:   Wed, 15 Feb 2023 06:10:47 +0000
Message-ID: <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7545:EE_
x-ms-office365-filtering-correlation-id: 8638d591-5931-41b7-cbce-08db0f1b6127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahAcbZkOiMBAy1PPj5K9kzEbRZA78mDAgusGdO4eShnTC/fbPdTblXDXFAMX+1G1sGDLvOvRkpnlN8VdOhI0ZnMNE7BY1zChjh+G5CBXPDaJLtp4zXFT3NPdw/39E4sLfpBLs/poC5N1Ux9RgAF/oTdmsSguYzsZiVig59Oh5HDptM/n0g2yWW/6b/GXMbJpp6ssawLl4CUGhvOJ4F4NZVDgpsO9oewPugnzGsrV8jN/AryioFW66XUwtI9YGb/YeDfGRhfruAjNq/PtLe5obtnvZxNwKZ606e1i3C2i2iKHmmJjDsTAZ/WTHhCLXDYYIrqR5ILC+ORZO3O/fLdyt8y5gdHLlQjtHRV4vQ+l67tGx2XTQsoAWesVb/0CsNRe7lY6Ge7r/3cVpzjPcRYxgQ3/nIqoVAE981nwKxlOnSTUiyNIkItN/b6fgk7tsQCQtsD5eTtbn7H7DoMKwXQ/pgG+Wsm3Fu0v+94HksVC57tBTd069VqW6UZDT5geBhykHQ63BE+N2SKU1xZnegJyJIGoTImrdDCNPNAuBlco+ypJ//+pZVl2rI19BTng8XFZ+G3usnRxtv/88dkD0RFilicz8fGwAV0YtrpqhW/p1dU3okAZdUA/l+4j1yjkS8m+otFThaYGluuTKsckC7XgmoaE8J8v4OxMnafhBXWof7d5Z+3oXvjLz+5tfcMCNSNd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(52536014)(7416002)(966005)(8936002)(2906002)(4326008)(41300700001)(5660300002)(66556008)(8676002)(64756008)(66946007)(76116006)(66446008)(66476007)(54906003)(316002)(110136005)(71200400001)(7696005)(478600001)(55016003)(9686003)(6506007)(33656002)(26005)(186003)(86362001)(83380400001)(38070700005)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qV3nHsfwX8KECC1uGgE75VMpoDdfyAiL4YJNAjES5/FdAjTL4ZXSQf4sppqy?=
 =?us-ascii?Q?FcfjULHMdMQxmaZPA8aB7xQXRtQi8az07cxVyjj3koGHGUyuRBWUKzux5yN8?=
 =?us-ascii?Q?7c2RMZ2c4QEuIPnmEDdVG3ymlgPExzrqIJ+zi/QhieIFzP1AElvZFUe2so9p?=
 =?us-ascii?Q?A+oQJibxVA1YmIcEpXpKu4bTy4p623MYRnBwm/ttSk8UqquP6VUoD275GbO8?=
 =?us-ascii?Q?/96zHcmkPU9DLvS/yGzNfJJo8U58H/QMBa41OJVxLprGBZQk1UWnQWuc8iFP?=
 =?us-ascii?Q?RunjdIY0bOKqpkm0G86XsCpMqLxdOY8qtH9Wo4dY1EZo5Yzo/Pi264XSbfee?=
 =?us-ascii?Q?RQ55rhx5k2uNTjjqTDsyQSUprrR916TtO/JUa+cojJ7dizEeMc2yaKUWzCKn?=
 =?us-ascii?Q?UGe4BU8SRLoHe63+s4+uOZ2JM6tiJtN5gBpgzQUZ6yOPzXP3mPe9OiEi6RLG?=
 =?us-ascii?Q?6NMihXgImzEoWqZG/DdZnIdictzIQrYt2iOcfCz7tjrehzDxn0fjn22BiMsV?=
 =?us-ascii?Q?MMWGZ4IU+dbtY4Il3NOMjSNVz+qpMs0MjWyLdtTYiFQWlCGB4WILL4zyaYpU?=
 =?us-ascii?Q?UAglXnFMs3YmnGSbmcl7zTrs+a7WATtJHBUW/I8ZJVABmQiAI3qw6BulRwzM?=
 =?us-ascii?Q?ojO91PujFm0Vj02Xo3Vx6KZb12ZlVXFhiq4xAMyReLBuaJC2LAQc/18b/KQp?=
 =?us-ascii?Q?uPb6ji03fiXIm7F1vgGcu8t/3mXuO3MYPHX/MFCPAk713OU0jYDlvFdnUbOn?=
 =?us-ascii?Q?OoCnPeYBhAVAh6Ah+kTam8zT+8xu7bmWUMbAxz+izu5KyYi2Mbjasz5gm2Vp?=
 =?us-ascii?Q?SXL98UAsyrTkgw2mVnFfNuX/bGpAGMgEpy4qnoh/GaXjMgUeg+0AVhwI1GB4?=
 =?us-ascii?Q?ddKb0K8XC7rpRV0EKuX2CoBgCK1EAIun6enmALqgnqqTvCONIkY26LYY2MD1?=
 =?us-ascii?Q?umZAPdqioXTrQSWw9cwztA+RGZiVd61C5symtgzu/gR4SuEQJimCsEKMOMdm?=
 =?us-ascii?Q?fvqi2VvKxZoKpD33dZ2j7yqM70MxtqkHO75GrEWX3HiECMva3rCfg6aBvuAc?=
 =?us-ascii?Q?Mks39cw7ESuAa4eV2tdVvHSdWrKdZwdTikJUFnxeL0mkciZG4WhWCwwkUb3P?=
 =?us-ascii?Q?aoVhnC/FJ20lD6cUEMQZ8SFutcSvRy76kMmZ4mdUu/VEdtNPt+jHfN/DjO8W?=
 =?us-ascii?Q?VfIuFFEAz/LTMQ6QqitT8WsRnu1gxC2+Ej1vt4JSDEjiGyc4PZdBumgqGB6m?=
 =?us-ascii?Q?EKkFaSbDEkOvL3EnFA7pqO9srHohRAlLFuk1jp0639rmaFD3FW/HKKQg/Wvu?=
 =?us-ascii?Q?EMTYUHh7XlsgheYrsu3rzD+P1346wtaD+Kucqpu0f5sRss1gC8jxNzHmZ4uv?=
 =?us-ascii?Q?AZ6LV98aTNUW6pszBQ6fdlO8+0Utprle4isrkGAC+a3u+Zh/LNSDB1Gsc5sU?=
 =?us-ascii?Q?X4/IVwWxhPF9y+WUkRLEPQAtHrc0/0cvg2L56mzqtGYtl3HksGKfwd8H31ap?=
 =?us-ascii?Q?JGoNdKcbTRLYvyb580xGOulzjSFpUWtl7dqxR8qn6Ez+UL8bjpLt3KAxH27H?=
 =?us-ascii?Q?VnGv3lPe1KshQPG3m2KwUSz30BLVhDKK5EtxZnDz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638d591-5931-41b7-cbce-08db0f1b6127
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 06:10:47.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Lquvn7wS7T6BuzF6afsiQh7pYz5BeUkIDmUTT3plXmNCvsT1oMDHQ0jHdbMZXyiFCsdPCchCwGzOc9cqoTx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
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
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *new_domain)
> +{
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret =3D __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		__iommu_group_set_domain(group, group->domain);

Just realize the error unwind is a nop given below:

__iommu_group_set_domain()
{
	if (group->domain =3D=3D new_domain)
		return 0;

	...

There was an attempt [1] to fix error unwind in iommu_attach_group(), by
temporarily set group->domain to NULL before calling set_domain().

Jason, I wonder why this recovering cannot be done in
__iommu_group_set_domain() directly, e.g.:

	ret =3D __iommu_group_for_each_dev(group, new_domain,
					  iommu_group_do_attach_device);
	if (ret) {
		__iommu_group_for_each_dev(group, group->domain,
					  iommu_group_do_attach_device);
		return ret;
	}
	group->domain =3D new_domain;

Thanks,
Kevin

[1] https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@=
amd.com/
