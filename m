Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2B74AC68
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGGIAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 04:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGGIAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 04:00:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03686E6E;
        Fri,  7 Jul 2023 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688716841; x=1720252841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IsbVTnjxTAA4Ei/f3eIeXb4EV4uYOt03eZOtimba888=;
  b=eKfRIsKzqseZZplibcN70z4vYJT2xxwrypptviNqyCv3+MQFLqV8DrKx
   2GUpZr2QzpNRO5g74BmxvzPQWwMcJogtYi2K1BbtecpiFjBClcBYeYDSL
   HWqBN3A4zCbwOHhmRWWtX8uZQ/kn+J0iFkqbYEsC3xwKEFaAIDsjuYorn
   ZuFOgSX6dA+Ve/lT5XOpojEoZ7uVN4BUzxN0wrbMkNzpVrOjgwzLhF9ds
   jpSkcZQkODJyK67P8FhTyvaIj0ZMFRua8CnWaXchLWmrqWxhfshy8h63p
   w+oC+uF7s8lDAsC/TgZMtluCC6azs3UBZmWD4vNnBEU1vIuQcDLgkccne
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363869560"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363869560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="670071904"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="670071904"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2023 01:00:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 01:00:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 01:00:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 01:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP5xTnSN26B5IRWFfzh6ppHu44qBezOh/YkG9c9UhNQHjuGbP5TwcYuXM5FR3moat0tip+bSpSma0zdMJhjxg5/O+k8f5xeGgJ6zCj7euBU2judND3Kcul0y5A98JrcXuL8oSoVFsVHtEE4s39+Iiac+S5DlDknHgq8RduX5+Jbb/JFAnDRvsaeWfB97EjxZJhBAK9/q2rdy/OfbVpH7epXUX9tHd4YyGwSeUvwhXLvAgOWz4on+7T3cmBdYzT14Gx+d/D1PR4sb9GKXss1f89TSLuWOCqeFdTIfiDAXurdW/cpK7PQBVKt4b+f4SWA7/AzaO20p7UW3SuZXMsm9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXqX7jojQZ5Iyr9cI+l5K/56BB4ItngPaEMK7f3an0o=;
 b=degVHEueDt5tijEyfRK1o6D1uWkIhdUIN2TqcJxMtRwMcHKGO/ScQ2DDGgI1hu6HtHxjDlvzeNKlMBbabPCLJVBMKTrqYFBfga8JDKRGWhR4xlbzGwLPindbhOmgV5yApQizrgKf25GabsaQ4AICtz1Y+qSUCYZGV2siZwaru8/8Zmj2CXMqlJaQl9oxka5iRdl6SZHI7lOIhURKqPjvmOAwMoEkjJtEr4pOpgsXtAYrm1EX0DbXcNuPg4mwOtx9/csZhR5dDMKFQdpPUcNCSaDC8agohkXO+WeEf4ltjsFAqw9Zc/OQqq5QWkmJa1euEhZU3/XrWpDJ5c19eeVP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 08:00:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::806a:6364:af2:1aea]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::806a:6364:af2:1aea%6]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 08:00:37 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>
Subject: RE: [PATCH v7 14/19] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH v7 14/19] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZhzWxc9AQGNz7uk22Gbzehzlz5q+uQpiQ
Date:   Fri, 7 Jul 2023 08:00:37 +0000
Message-ID: <DS0PR11MB75290ABBADE3CC8C12B1AEDCC32DA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <14-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <14-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA2PR11MB5004:EE_
x-ms-office365-filtering-correlation-id: 01f7aec7-7bc3-4506-8547-08db7ec03fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npH2Gp1rGG+z5c+8mUhnzXwyRogJGdG9qdjwpoJ35mp9LH7nnK3hJGn05HY9HTTfGM6+p6bZSgyftFcVm2i5XnsMExtNvjNBWCksO7sZvFADsgqIy+YbBj/nhp24H88XbvuOBbBKnOJMkGdzmGvMK9dFRRX+ISJI0vL7nRjhcK9xqx/0QrSpQlmGkFElHQba8dr7DeHPbtECt/3N0vlAfszNgfCS1ipsyoIAF2LXTf6NWEPfArK8K1ImTnXB8sY3qrUVv9WPlf7sx8FDMV4Db7aHbczr+bgH/acyajZQ5Howc+90oSLZMm3lvvGTo1ubgolU9jMKrOsA6mRak/BUdOX2LT19mN4OG4vlsRmTSVOBcj3zG6O5Xolya3VS17zJnr78dqqSR2P7Wbl0jATIDytVnION2hlRTQ4dSzoi5HAyvzURZHJSoomp1ZuuoYLyCL6MJgy706ddWl528L56w++dEWFcE/idGr5EYH8gEreGz2TKa63hqn2nb2h+DWR5M/OkXnxQRSzBxGwJif54l4Ti9PHBcARwGchCvL1PaqfA0ELMDLnSkhvJYxY4nkeZwu+lV2pBZCDouNcyaIXUqPTt0DhAppuBLpc5qvJm0IyRsKSU0ZrnSboABFSg7fQC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(54906003)(110136005)(76116006)(71200400001)(478600001)(7696005)(186003)(26005)(83380400001)(6506007)(9686003)(2906002)(4326008)(66556008)(316002)(66476007)(64756008)(5660300002)(66946007)(8936002)(38100700002)(8676002)(41300700001)(52536014)(122000001)(66446008)(82960400001)(38070700005)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?deK9pbKeJSrC8lGnIeCHV7hBviaucQKlRxW2p12gmWhuLTJxczE03h+IeDL2?=
 =?us-ascii?Q?enG/NgEDjAa3/nvaokX192nfN9CANY3/VVZYQTk7gMap8uzgDTRd/ZwNEn40?=
 =?us-ascii?Q?fYBQwqEKBUPMGAzO9GO4OHN3Kuy2pUGiHQmfJ/MIA0cJGWh9s0pFGUg09s39?=
 =?us-ascii?Q?u/CDVrS+txpsdfakpKDXUFpFsjvCkDwEX8rmB0/14/97XIX6QAFSHjTZWn66?=
 =?us-ascii?Q?a52ucnz8VrCZEgenIKwonKzo8myWMXJG8IGo8wUS6NKLxI5Z3+pqhEOBmF47?=
 =?us-ascii?Q?3vFia+blnMDCO64jpV5ixsmMizn1z11QRiJiTn3K1TuHQ6teC2Rb/tbuuidP?=
 =?us-ascii?Q?bvG8A64gB0anpjxCIqZ1Da5/7zRCyG0IPw2fDNULWN4Ts79igjgzHZUWdtMf?=
 =?us-ascii?Q?YEId9tjYWqb0l7yVQ7mQVTe5wix4/huLPL776/yISVshjpSLvnvv7Ih6m0+V?=
 =?us-ascii?Q?fpbEgu90nFuTl+p0oAPFcSpJ+hfrxcz/rIgKqPxEuuV82Sc118tkduMYIoTc?=
 =?us-ascii?Q?adrD/sH4imJVvFr9sCz8wTtAHbjSjsgnWBVdDs7ZzVdrDCTMWsYeoVQZP5b1?=
 =?us-ascii?Q?MfkRd5gpyP+Wh4pyXFw1t3pREMb1ILJdN0/W6RqrHVv34zZgEGECKXtnqzw8?=
 =?us-ascii?Q?KFJZ16wC27+kDZ11Lj4bXhkDq7qFUMtPBarqsoKWgL4iOcQ4yi9D9o2IgMFW?=
 =?us-ascii?Q?eAuv2OXVpMUYp9GwX/ZT7f4ztH9ioU+roNZhBmbnRBEa0WkSyECqU3V9TFyl?=
 =?us-ascii?Q?X8Jw3k6NpUnNIZq7Cx1HhOw2gvoeD0tolf+/4xPL9nu4KILklFh+I3LaXDqP?=
 =?us-ascii?Q?RcGK29If/Vxa2qhArUauO4xhvM8oVsu0O7GSqACMljJHmQizfyRVOerEgkzV?=
 =?us-ascii?Q?DhzJgq88kvXRt6shynF6CPZ+It0vpFBj8J0XDa2lyHnUiZwLa2hH2phGcnOv?=
 =?us-ascii?Q?jXSYz35H06MgaZkO0hcZw25jIvigHZ9YzBdQfv65YepgYU9n2LnFfXjvPLcU?=
 =?us-ascii?Q?8RJSaIzECaoaITGbZhod3fJ0jRUxT9jPNQqEKgBWyqPxXINCquK6tawJdI2y?=
 =?us-ascii?Q?1pylKFWJaFm1j6HIQLaQLqrUTG5e6udvZUg4hsWiK/GqawfFgUaVyNkboUSw?=
 =?us-ascii?Q?bx1rI3XhWjWvIZYhNnUV7Jq8x90Csdwnxuy4xlgRobRk/TRceRPey36LyBFh?=
 =?us-ascii?Q?+Tret5DPNMX5QWyHnURdsu1ciDdFt85xAsLXu3sJtMVxI2Xc76VODbHuTUCp?=
 =?us-ascii?Q?MghE2IT3rikxq88VkzCfBq7gnbJEF3LAali9AZ3b4PAGXo7z4RN0eNUR5zig?=
 =?us-ascii?Q?i+yIWTVHV1jmr2lvAMoT+1FtxkxgZN38qWLxi70u9gUnC/TDQLV0SgorY53h?=
 =?us-ascii?Q?x24+CKrsff+GHXjX+tuRGy+C8uHqAiNaen2/d5zWG/mnuTPS6OOuXjq57cEK?=
 =?us-ascii?Q?im1VPOk1FapHqOP5cX1ZVehMMx/9sqWLISHIlyBkXCYDkFbZW8l2r1XIG7Vl?=
 =?us-ascii?Q?fZHAfJ3+skGsOfwHacELg6W2KACvmcR/2cM8buJ64SMZbD4ZJfK1aFwuzgWW?=
 =?us-ascii?Q?Noz+m4KAOOuNWQ0jr3c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f7aec7-7bc3-4506-8547-08db7ec03fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 08:00:37.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Xrym58rXRfbAUPGVY6BEdEsw80BuQ74RSEqe5Ya5m36EGMgQIwJKMcapJM5heggAYHTHpP+J6jQmmIGt5RpYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, May 15, 2023 10:00 PM
>=20
> Replace allows all the devices in a group to move in one step to a new
> HWPT. Further, the HWPT move is done without going through a blocking
> domain so that the IOMMU driver can implement some level of
> non-distruption to ongoing DMA if that has meaning for it (eg for future
> special driver domains)
>=20
> Replace uses a lot of the same logic as normal attach, except the actual
> domain change over has different restrictions, and we are careful to
> sequence things so that failure is going to leave everything the way it
> was, and not get trapped in a blocking domain or something if there is
> ENOMEM.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 99 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommufd/main.c   |  1 +
>  2 files changed, 100 insertions(+)
>=20
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index b7868c877d1c1c..ce758fbe3c525d 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -4,6 +4,7 @@
>  #include <linux/iommufd.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include "../iommu-priv.h"
>=20
>  #include "io_pagetable.h"
>  #include "iommufd_private.h"
> @@ -365,6 +366,84 @@ iommufd_device_do_attach(struct iommufd_device *idev=
,
>  	return NULL;
>  }
>=20
> +static struct iommufd_hw_pagetable *
> +iommufd_device_do_replace(struct iommufd_device *idev,
> +			  struct iommufd_hw_pagetable *hwpt)
> +{
> +	struct iommufd_group *igroup =3D idev->igroup;
> +	struct iommufd_hw_pagetable *old_hwpt;
> +	unsigned int num_devices =3D 0;
> +	struct iommufd_device *cur;
> +	int rc;
> +
> +	mutex_lock(&idev->igroup->lock);
> +
> +	if (igroup->hwpt =3D=3D NULL) {
> +		rc =3D -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	if (hwpt =3D=3D igroup->hwpt) {
> +		mutex_unlock(&idev->igroup->lock);
> +		return NULL;
> +	}
> +
> +	/* Try to upgrade the domain we have */
> +	list_for_each_entry(cur, &igroup->device_list, group_item) {
> +		num_devices++;
> +		if (cur->enforce_cache_coherency) {
> +			rc =3D iommufd_hw_pagetable_enforce_cc(hwpt);
> +			if (rc)
> +				goto err_unlock;
> +		}
> +	}
> +
> +	old_hwpt =3D igroup->hwpt;
> +	if (hwpt->ioas !=3D old_hwpt->ioas) {
> +		list_for_each_entry(cur, &igroup->device_list, group_item) {
> +			rc =3D iopt_table_enforce_dev_resv_regions(
> +				&hwpt->ioas->iopt, cur->dev, NULL);
> +			if (rc)
> +				goto err_unresv;
> +		}
> +	}
> +
> +	rc =3D iommufd_group_setup_msi(idev->igroup, hwpt);
> +	if (rc)
> +		goto err_unresv;
> +
> +	rc =3D iommu_group_replace_domain(igroup->group, hwpt->domain);
> +	if (rc)
> +		goto err_unresv;
> +
> +	if (hwpt->ioas !=3D old_hwpt->ioas) {
> +		list_for_each_entry(cur, &igroup->device_list, group_item)
> +			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
> +						  cur->dev);
> +	}
> +
> +	igroup->hwpt =3D hwpt;
> +
> +	/*
> +	 * Move the refcounts held by the device_list to the new hwpt. Retain a
> +	 * refcount for this thread as the caller will free it.
> +	 */
> +	refcount_add(num_devices, &hwpt->obj.users);
> +	if (num_devices > 1)
> +		WARN_ON(refcount_sub_and_test(num_devices - 1,
> +					      &old_hwpt->obj.users));
> +	mutex_unlock(&idev->igroup->lock);
> +
> +	/* Caller must destroy old_hwpt */
> +	return old_hwpt;
> +err_unresv:
> +	list_for_each_entry(cur, &igroup->device_list, group_item)
> +		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
> +err_unlock:
> +	mutex_unlock(&idev->igroup->lock);
> +	return ERR_PTR(rc);
> +}
> +
>  typedef struct iommufd_hw_pagetable *(*attach_fn)(
>  	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
>=20
> @@ -523,6 +602,26 @@ int iommufd_device_attach(struct iommufd_device *ide=
v, u32
> *pt_id)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>=20
> +/**
> + * iommufd_device_replace - Change the device's iommu_domain
> + * @idev: device to change
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
> + *
> + * This is the same as
> + *   iommufd_device_detach();
> + *   iommufd_device_attach();

One blank line here would fix a warning as below in "make htmldocs".

Documentation/userspace-api/iommufd:184: ./drivers/iommu/iommufd/device.c:6=
65: WARNING: Definition list ends without a blank line; unexpected unindent=
.

Regards,
Yi Liu

> + * If it fails then no change is made to the attachment. The iommu drive=
r may
> + * implement this so there is no disruption in translation. This can onl=
y be
> + * called if iommufd_device_attach() has already succeeded.
> + */
> +int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	return iommufd_device_change_pt(idev, pt_id,
> +					&iommufd_device_do_replace);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
> +
>  /**
>   * iommufd_device_detach - Disconnect a device to an iommu_domain
>   * @idev: device to detach
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 24f30f384df6f9..5b7f70543adb24 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -466,5 +466,6 @@ module_exit(iommufd_exit);
>  MODULE_ALIAS_MISCDEV(VFIO_MINOR);
>  MODULE_ALIAS("devname:vfio/vfio");
>  #endif
> +MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
>  MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices=
");
>  MODULE_LICENSE("GPL");
> --
> 2.40.1


