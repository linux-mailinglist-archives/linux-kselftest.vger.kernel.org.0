Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872CC68FD80
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 03:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjBIC7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBIC6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 21:58:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08EF40C0;
        Wed,  8 Feb 2023 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911336; x=1707447336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lRXLKoNt5hm1CGkoFkCCBZntCW4iHeb0hKUfbZO1xWQ=;
  b=m9VVKviXSE0pU6KwlucyP3d5CcKBxU48qRcNJFl0x2rGuDn4IEnqmCxX
   s/HfvfrsOU1qYU8TYOOvUNqq2L5vN/n1VVdfWDpca6mOc9euGH1dHMUA1
   L79Y+7V/qlwM/9FR+o4RTebsZTTDRJgslGz0rP/bE9PEh0zwQhaUQO505
   kkFHJ2LOj/JXsqkkwmX5WcyzODLMcrM7lUMB6aPlOsnVP3ZIStFW6vO48
   EVGhXdf0WwjT5yTlKKGRktL9k3DiWjFKdWUb46B1afp6opOLEV9OrKBVD
   vJBPvdnSP5gAWEMkDliOy+Cm85kIGHzz8SXIzP85V/7aKZ/kR+fXItVVG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310354128"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310354128"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810170368"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810170368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 18:55:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:55:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:55:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:55:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvtcZ8B5aa1bm8inJSIraYRj2QQVojLsYC2J3Y8A4S/l+nzHIThdoIJVkOIJF2c1PbzDmS9gF4ffDUVws7trKtAulT1jG1zAKPlRkkGhDwE0ImBpAeETo0AwsGZnactxBeZRt0b/OInnKMrQ77rXMRnXMcCepe4uKyxnWJbEGBbvLPXlFszcOUI50UX6OMJ71TnuH37SgSf+bBIHmLyxy9eAFDB7odhaoRbShqKhR/12zwmz0elM7eq+LCdqaasIMmRAJXiNiW1rrHr9gZSOps8K61JcgMYoB21YLUPeKmMTCiByQg7CvZY6ALJBGsDJdtwoOjGlSEZjMQLTOae0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vu5PRkyMD6N8d/zNQMU+kUL1newoZFTLNsqPmbzpqQ=;
 b=YLmIKAqJO8ZSfWsV243m3DCYBGASD8nTMrNl8FJAGWPw+9tKL36KfVZdiYO6p6QQOIZ92Ltwp70DeDKbOPHKk+kRaC84ku2BD5IbXgxpm2a5wNRwRajykKAWJs5gK4cW3fOtW4xkhp7g7DBuNPj5N0xMNHNqFrC+weQ8wqzJPVRRdTx4NJf43amHzLZRdSt4fI89kMeZtT7Pf2Bi47k82l6cYu5q4O/N76Thny9qFk8QOmoevqODEA4bIiKu6vfAByyP5m3ymnHb27U5IaM50+9AIb+M3Y2TpXngCIKqm6IC15aKiBWXDZVSUtbTV1HkOF7ZBh8zbnr0XB6OhdPgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5544.namprd11.prod.outlook.com (2603:10b6:208:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:55:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:55:24 +0000
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
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7F7DaQ
Date:   Thu, 9 Feb 2023 02:55:24 +0000
Message-ID: <BN9PR11MB5276859C11057878722F30988CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5544:EE_
x-ms-office365-filtering-correlation-id: 631cd0a2-8c94-4ddf-f23d-08db0a491797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rczVKXURl34ciN410De91ytOJFwhOyKo3Sve35uI2bLSrRLqkcoxH/n5oNJMomo3rbJJ1DK/WFcA9y7Nksm4oQSnnWQghNn+CCZ6RoeOwPZggAuUJklDqHq+V9AFy0C7bWfcql9hMUoAb9l4LGblCQ3gfZzwaYciVT10cASC7MI9+Rd4Jnh2KTruttvWmfiP+x7Y/Hsp0k12HMDEcSQCjgDLSzK3HmJNl3brdO6R0v8xwjgF47g4g3eE2i6dwgA05RhnTMP/7iuEmryA8sjMWYTALzYySnzEj/JyvM8f6MoK8kknkM4/mCw6EENaKyu0OpqDOtDC0SkLcFQejfXQde6I873YnjcMekrGxjWw8qVF75AZ5WHLrqzFwScoPOODYkbblco2RGzSW5jHYI79x0+l7fFyyAEWAtHDcFpC+QmBB8bR0jTyuhZkWm3fUuhSscOYYQIoFnwkFDvgaUGaats382Y05QZkNmOU8bXjaTDvFH70l5AJEJl9rG44UTbFdPuAqVxYZYumUEAjpFYRRP/TkiyFaEg6hT6SeKDSj+JygqUD5KC0xYD1NWIgE+zNxzkwlYAqqb0fuLQd77E7jpmcZOtaJMIr4ckYhGzq1xPn8Ak9Nkcb4OKMs8VmPWKy2LKTwjpHlmswl9k1gX+Zlfs3pIuHj+atoB2/Lb+107YY4xKqSAQgNqwBDv0sZn4cWWIfnF3BN6IjqA4LyCLIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(83380400001)(55016003)(54906003)(2906002)(316002)(76116006)(110136005)(38070700005)(478600001)(82960400001)(38100700002)(71200400001)(122000001)(26005)(66556008)(66946007)(4326008)(4744005)(8676002)(41300700001)(6506007)(8936002)(5660300002)(7416002)(86362001)(64756008)(52536014)(33656002)(66446008)(9686003)(186003)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85K0fO4lA3cRxTSjz3B0Va1I8XYFixVV8vMnceuMW0FikxpSu6EGO0EdthbW?=
 =?us-ascii?Q?xeFKmdZLcA8HNS8LpqhIslsAf2c6c432/qi6l6d6x4p+zuLRGQxCGexMPMkH?=
 =?us-ascii?Q?+CEtcW/9XVjOBRbf3ZqxMMD6HDvzJ8CZRpdI2sA8wNN3n4ywyxxRPf3cHeLy?=
 =?us-ascii?Q?uiYeoJybwif54iEiLdGiDaYlvuBbuYYme50m9aQeqULpxo3pdg6qfcQi6zHi?=
 =?us-ascii?Q?JDeA793lba4LD2+8Z9Hb3SSN98Xu72Eryvcom2WQw5IG6w/uEPQC1H50wY34?=
 =?us-ascii?Q?CAlRyK1eXsNka5WWxThVMozle37kMVjCXjI/stt22nHRMGFxQWyPL6khYUgR?=
 =?us-ascii?Q?rMaoBzXEtKFP+FcAmC/+HqoQfHz0U/okaiUolouKyKgpox1IegItk+7gc8Oa?=
 =?us-ascii?Q?mCwOqv/fBjbje70mQQjhbXz1UOeN+lJtZwKn7ZeGp1k7hYnZ/84Mgkb1WpDB?=
 =?us-ascii?Q?ggCAwUQgPXmyYh2uZylVN6VHxgePrveMB2rLOj3X6shE/rQTYI2kVr8/HBj2?=
 =?us-ascii?Q?3GMAfqn2F4eK/b8qVvipNhWbpzaxwx1tq0CfwGF+ohhfjGhVSlg0YebiJkCo?=
 =?us-ascii?Q?vkiiaoD5jkr2TgJ8xZTDQlEgEcM/MHa9IDwb6/8xo5WuCyTrIqOB+yrCVbbI?=
 =?us-ascii?Q?zV0ST4KwQSjup7tVj7DGkm30F38u/FoJ93Oekwks1OdVXQ71ZwNRk63BHom2?=
 =?us-ascii?Q?tx2UITw2Nmn9/Fw1SAxU8ViKubfKpTx33ZaPqP5CxGE75uxwG4MZCq8h5BUZ?=
 =?us-ascii?Q?BiLpkYn2yincXUwEkw1R+twyqCB6F0nxoufxHhq8E5E7eOIqONCcqeUqkD5N?=
 =?us-ascii?Q?gWNjqf/rnA36tjUUyARUTZSyB/GnFqt+3XPDvvDGhxuf8tQFhQdIAy0sLYz2?=
 =?us-ascii?Q?86Pe35+zjdKpPcVWlcgIa4r0HMLYbt8wKE2EdBYgOGiUTD212Ot0y7iZUo2x?=
 =?us-ascii?Q?EFGH2D0fUZ4P+NvRDOeqcTzduGcEDYr1y64JPC8JgqO0d9yCycwkMoO3I9yT?=
 =?us-ascii?Q?Z7RflQ36YwJIaTPAtRA7ymsYWLHeT/h0gyOcdoH2KosXQtm4ZHJ5ha7Z4Zyd?=
 =?us-ascii?Q?XEH+ak1NiwEO0A+tjWBGhawvkButVqQddId8Fi9J9XX2NF6MxJSq8hc20tK9?=
 =?us-ascii?Q?yQVcUgI2DVjbJYkHl6xAkHFzOEHnkaTllt+psq7cBSxCL5Hh8yq73umvmfId?=
 =?us-ascii?Q?Ii/oe448heH82stSk9FClwwGVH2LzZt3xD1FSFcQ5KllvWxc89q82c74uuL0?=
 =?us-ascii?Q?pz0WWxNxXGI4NuzNL9YUVqYRUzgDvHpdGc8HwTknE/pTJYyMPAWSpvbTWQ1u?=
 =?us-ascii?Q?r4EnEdQKvt6ZSw/cMHVU2NPeY7gl3FUNn9Z0exQsQZ8kwxpWhJsI2x9WAa2W?=
 =?us-ascii?Q?Ch5dUam75EHN/Soo4Uv+6kkN3KTF61etpD4ca7jlWbjyEAY8ts7WILLFjuTc?=
 =?us-ascii?Q?rei8oVqFi6uymj9iGYMDSEn9N8NBdgnUCi8VEGSQPoAE0udpOqYjPDUYpPo1?=
 =?us-ascii?Q?2PgAzCAZuSXjz7j5PrYyk/NRXkvZNkGnzvLAIeT2B5jU5f/wqVKz3Wz4wY+1?=
 =?us-ascii?Q?+lIWG7gA3cub93nzWTs9GpqVC4toBU9WxfK3Vv5w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631cd0a2-8c94-4ddf-f23d-08db0a491797
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:55:24.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOFnR1Ol2c5RvXzlWS3nOyQzBw3Mjpt2QsBVO7rtx9UzW2nzEY/qLx0YtRUrMKL4Ms6QUhKe/ma6ge+61MiHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5544
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

Is there value of allowing NULL new domain so this plays like
iommu_detach_group() then iommufd only needs call one
function in both attach/detach path?

> +
> +	mutex_lock(&group->mutex);
> +	ret =3D __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		__iommu_group_set_domain(group, group->domain);
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain,
> IOMMUFD_INTERNAL);
> +
>  static int iommu_group_do_set_platform_dma(struct device *dev, void
> *data)
>  {
>  	const struct iommu_ops *ops =3D dev_iommu_ops(dev);
> --
> 2.39.1
>=20

