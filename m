Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E368FDC9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 04:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjBIDN3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 22:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjBIDNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 22:13:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77459E8;
        Wed,  8 Feb 2023 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675912396; x=1707448396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GmK8XrYfGcYc4h7Gp6kyx3fTJqBk14F2m/EWMKlqxbA=;
  b=JswahN+zxnuZomx48GH0/6/PKfLXzb371saLXNwA7wVjIGbl0lQnVdvf
   9mcWOSo9XvSUfAq/gTVOdcrTBBef5hR+eAGa7hilRpLh5ljzmL8zdBeFo
   kSYImEFndMOYpYFodrAw+WGtcFCksznUDPoANPkbWa8cJy+qF6uL1TyUq
   R3dtmWc4zoLqP1YyAuWlcNCeFL5BWElFPe1xh9y1oJr5nZifxXpQYHJpX
   qdlRADWkPjX7GOUnII1yfSaN7qGP/8btP8HX23WYPyoVF+v8jMs/Gltoh
   7zdpFA2qO3H9m1fifWXgd4sgBn++denRDYzqZB/EdrykgsBQcZaes4JXE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416220139"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416220139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 19:13:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810175815"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810175815"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 19:13:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 19:13:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 19:13:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 19:13:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS3M9m+4a/wB9BQKoMybBLcGJMmpWKePhl26yvnUGOURMgHeGkBVkOq4jiPocAxUSrnPtYSMSINnLmjAcact/v65MVCiQxeRYw9ktK7QGAWstZ0GxFOd8SFjC1Bafuq8ATv0YBvUYi62cq6P9d2BvJ+mAU1IRnVYs5BcAfXgYByfiQZRxw5Fa6sKEinLUGMD/q0sCdkBOxUkBbXnBA4z1ONrPKFKcNnTAHBVoY4adSZQ/+YzP5KthWDTCE5z/yDa3idGb0yKWtXUTZ+PYnE23rJBaqQ0tgVKYDG2kRz3LXzcb7fVxrPMTtWIgTqrevMoXa4HGAlWEmF0MB1XQfhEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwsMGCN6pas7sKyRc466zolMFgV8sd8Shxj67yswHLU=;
 b=I7+/SJblE9Z2E20Om7OvegMWk7eiAK4t/vNkW6RTEHqO+C/2h4WckkiXL7dAONmJAbibA3JqKZAzzlzO2zBwc1HH3NctpihZq+I+gqwuh5ngZXUOVwvNPFd56xICevj9fTt4LtmvQPTM18wg0IjUdnRBYvnCW7x0dX4mHYPPNg3UVHfVxG+EWfSv3vXRxqMtuX4xNiYDqxPAGktnbyE4INMHrk48NQg8PPGhtkW8JQsy2xvD+c/d+Mtb6Q3jp86iNDSBm+peEUX4g6Qf8UQXR2GOUbD2MxFGY+uCf/Nk3VanPWstMjfZ3cKb4gyq+E2abZ81ZiZIcy06kb9wHSnYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 03:13:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 03:13:08 +0000
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
Subject: RE: [PATCH v2 05/10] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Topic: [PATCH v2 05/10] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Index: AQHZOzoOetEnDUz6KU+y7zqlV4tnmq7F8F9A
Date:   Thu, 9 Feb 2023 03:13:08 +0000
Message-ID: <BN9PR11MB5276AE27E37866B82A6E03608CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: fdc264f3-a263-46d1-ac1d-08db0a4b91a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9djNwiF1uNfhLBAsuHQ+7GpZ6mqOzqCs9Y97gnZis0E/Evm27TB6tsQhTgKoSasKKsVRRXkWUZqlk/qYzxL3K/UIII7o1VG2G3go4+hxh/AbQxY5XT5uoWX83FSvGj7G7vA4kKssvVrUAJun6SsRMdBeKw3H3hOvU3wIz27CV5F716RyDJrEeYIOAfNUuL09VlTYmQLwz0IW4YX8/6osVDHY6jwV4ZuTHlUMECL+9aZ2/6rTlYOmw/0MhlK4LeB5LhT9MNvZIAZWe5KELynSleaXj6qq7qkxpeHlXhTQBqd6vke1hwXtBg2mIE0PLJfGzvXb2Uz7JgL/h4nHAC+fzOnyc3FO5lGWtD2GN6ksq0RjfDEEFTNv5NnNNAmKakp22coEKvYnBv0eHR5wjhLS4F1VVB875KZIQ0xMmwBkxUcIi3rQalF824LYhxyubpDooTFj4cB6DLSXbm9rNphy5zubTl4hZ61XfTFRwnNvKYHPmAFJE5tBT+6bAQAjGpzl4Cg3IJx/J6pVtz7p+jrtBSv2nVIDwy3WCJBomKt9uIvKAMxU1pWFdLb4FfGgAFJUajcx79JS3MXpPUsYkuNrivl0HsgZtQgvofQ8Qoi/jlmNBT+P1Sw1fGZR+ugsOg0igjfrOXhAfSpr4nL0PVHdPMvLiRQnD4/YOPyfGbnXA1+Mj3s4MGaDAzFT+oGYKeX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199018)(38070700005)(55016003)(5660300002)(7416002)(86362001)(52536014)(186003)(8936002)(122000001)(26005)(38100700002)(9686003)(33656002)(83380400001)(76116006)(54906003)(110136005)(316002)(66946007)(41300700001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(82960400001)(478600001)(6506007)(71200400001)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ukGjc64Gc1e/YbMLtLvm8q2fTP7M3BdnX029TBOE2ev+ah8pJbAp5FLk6PWf?=
 =?us-ascii?Q?Aqou1d5HOKMp9nZUBKz+mweGtHvrBIeRN7BnBwriOO4wbmpyZ3jjXPrd0X6A?=
 =?us-ascii?Q?0MT6ErLPb0H9QlMYfJdvNLc/raHiXDY6IZOWqrOxiLri7US9SU10VAycr6uD?=
 =?us-ascii?Q?616+M6kVZfz4imKyFHfldhSsONdyOU+2frxng+xTFZwrjTbx9xQH8Llj40i0?=
 =?us-ascii?Q?Y4jkXht4xVoZZvRA/zfgDyrYR5RJosgbdPrNjkC/oTRu5BOLdR4VqPw17Sp+?=
 =?us-ascii?Q?bRS3qa/FaRE6m3s4CnmKMZv2ri7dCubzyKr49k0/I93WU6uUjnnOErx7gdmF?=
 =?us-ascii?Q?r5y5E4ESkeG2zUS3M9+wVkcB1JnOjAtpvKbEGUv5/kILuL07Eyl7p4aV62R4?=
 =?us-ascii?Q?eC9sz3aMEu3QHuPViyoKwetphu9jL7gm4Xyp5klBrtH0UCy4/oS6qXpOwY2a?=
 =?us-ascii?Q?Adta9grfUQhlEhqFkmNSlySEnEeU3zqSUJDq7FUSdKlvmQre7WBF5Ed5kMxD?=
 =?us-ascii?Q?m6r9p1JUcU/DFvwoTt5pD9rPtlRDHbj0Ot+Vg0/8DfkJl7kqC/p6FF5Z6NzF?=
 =?us-ascii?Q?j1Nv8JaLeNlFbNXY64qImEP7scHP5Z3aXlTWoRyn0jSGq2hHhi4bXEcbvDOM?=
 =?us-ascii?Q?zR4FKK7ibHgyhBr0TFj21m6BOP5in2fgkNC60cz2CvfTpSLWQMD5I0tMItuA?=
 =?us-ascii?Q?7mzea00zmVZk3fESxnct/1XrGUHefjjiplSHbuFKENbwU3glKximnunwsChM?=
 =?us-ascii?Q?dmM2i/UobViURaNQhuCggOmGiOvWG8qJCcXJnlZDRShLCuNNyCIb4cZ9rPIQ?=
 =?us-ascii?Q?LI1cAzEG2VIDGIuRBYYWHpl4FZ7ukZS+dizVkpHCGRLcCAwKz1lv3TYzi0w+?=
 =?us-ascii?Q?j7oDuah4qKblaU2uPGlfEXXAnH97jykbtlXxZ1hy5YrLCCaWk1f1loyzpSJQ?=
 =?us-ascii?Q?A7GjYloe5ALzoOWEAkKxFaudqOd/RrZBA12adgKF7+jvgwV+9gmmyHJtemGR?=
 =?us-ascii?Q?zefTjJF5F64NOXtEDTc0Nja853eoLxP9vXt8T7r+witKaVWQsKjyjHxJO49i?=
 =?us-ascii?Q?w1P7eVrA57u8fsaw6mBhK3KGkueioQZeQ/sCTA66ME+L7XRSALl3zm/6GwcF?=
 =?us-ascii?Q?iqdX3PDs0fGXyRs6PNjMBsKKeIkNa5/eS3QhFGKulI/xwxOfCwqhfdWyDdjg?=
 =?us-ascii?Q?v3eYsw/zBS4p3b8czqQndEb+4O1qCQrDEc29SgYDgUqa6MQU74bEezpIRCog?=
 =?us-ascii?Q?n03o2QSp4bjgmLkMlj8mGNhz5w9VREDq20C7eC3cjuK+ytIXOiqZe9F9GzTC?=
 =?us-ascii?Q?CaR+V/Cz6XKmb+2H4FhoGVReUWyGWPksiB7dzZj8s0V8IrjUVB6+HJ5Ph45R?=
 =?us-ascii?Q?KeXMjs81SUhUWxSsLmc3rFut7/N4ll3f7t6QrleJYaAWo7UAYpYrViefzKJH?=
 =?us-ascii?Q?HSHl5RKgB4A7xm/m4UlTKhuEUdxVJFQA9GEEHaeimbA9LPup4tHaopRHKEfx?=
 =?us-ascii?Q?Wm3vjChPylS1QDZrC90Zc3oz0pPs/yAxJOrUtNzvkjLb2eDbel7ZtGFmXCjg?=
 =?us-ascii?Q?YWm7CZc5hQQ0ZSd26LUP7zOU0/dOKkv2QAOA6olw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc264f3-a263-46d1-ac1d-08db0a4b91a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 03:13:08.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9f4aDWO7QMwbXTZYuJoKNuZJqA8NjAScxFrQ4notNgNdTge+LsLS+VL1xRzg7TbPGoCxt7X0zoUDRvQGOwpSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
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
> Support an access->ioas replacement in iommufd_access_set_ioas(), which
> sets the access->ioas to NULL provisionally so that any further incoming
> iommufd_access_pin_pages() callback can be blocked.
>=20
> Then, call access->ops->unmap() to clean up the entire iopt. To allow an
> iommufd_access_unpin_pages() callback to happen via this unmap() call,
> add an ioas_unpin pointer so the unpin routine won't be affected by the
> "access->ioas =3D NULL" trick above.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

move patch10 before this one.

> ---
>  drivers/iommu/iommufd/device.c          | 16 ++++++++++++++--
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index f4bd6f532a90..10ce47484ffa 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct
> iommufd_access *access, u32 ioas_id)
>  		iommufd_ref_to_users(obj);
>  	}
>=20
> +	/*
> +	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
> +	 * iommufd_access_unpin_pages() can continue using access-
> >ioas_unpin.
> +	 */
> +	access->ioas =3D NULL;
> +
>  	if (cur_ioas) {
> +		if (new_ioas) {
> +			mutex_unlock(&access->ioas_lock);
> +			access->ops->unmap(access->data, 0, ULONG_MAX);
> +			mutex_lock(&access->ioas_lock);
> +		}

why does above only apply to a valid new_ioas? this is the cleanup on
cur_ioas then required even when new_ioas=3DNULL.

Instead here the check should be "if (access->ops->unmap)". with
patch10 the cleanup is required only for driver which is allowed to
pin pages.
