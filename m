Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED66BC8C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 09:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCPISP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCPISO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 04:18:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419BA7AAF;
        Thu, 16 Mar 2023 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678954669; x=1710490669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oO1jpgjoT5YaamSNiLRYXDePLug0FnwuFVkPX/tD/kU=;
  b=cQky4X27bhc7SoUEepquO8qhzW6J3W75Ao0EAvDTEM1v+U0ojTjHEAD1
   EkPI4yWiRPn6ZcRIgg6T/12hCyxG9ArxE2i2Fo6x0g/u6PesUHnir1hMe
   9ny784m2Ef2GrDwYtxDqe1r845ylDoZDDgsRTyAPqUqmxhJLRNwlvmx23
   23Zw2wiK6zlPFZiYdWNjTB73cNT+92rS0s1/gkMOVRrtfBwRxYqPKPvcL
   nzaP9OpZHj1IKHJsH/hPOO7bq6TTLuUEJ/9mN5/+L/ffq3ows6m110d79
   +dpJNCZ9rHfu8hLKyAc/eA/1tyCRq8MCcBC5Jmkwae933+Wk7SCNfLzj6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424194796"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424194796"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768843560"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768843560"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 01:16:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 01:16:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 01:16:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 01:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNeNe+dHgKUva5U+HGod9oOvSNev1gKrPk0ybdf3yBesWZZ19pgZhxpOFSEQyjgvuMIcPOnVip8MPFdQHdebUFfHltqFMZoxHHDJWzfVhSj33C7bhzVTPHjsYE4hGSE+zy9un1qs0EompLl7XeRTIgf+RvNCHRKhbkQi94Tg8gnp0g/3bYSxcUiLWJZOO8+0FNkXlWZYpxp5LyQ2Xn03r6/vysgTCg41TmHvVZMsy+bxu7zD/WQa9JlxXgV/SLEJKwAxyxNNGJynTS7M8tKq9ELBt9/I+DENvI5u8tIO98Z0tw183BWS6leugY8LMqr4MiX7fD6OtD0+TtXyCIL9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuX1HRJaqHdr4WgWQZOtnJ7XmshuFJka1hJrETCJL7I=;
 b=KreXIRGTxtaUZj/cKkP8WIF5WZozH9pjvqJYrEdaxCdCcpbB+EquQFdyUOCPvMItH4ISeI5YG+XZsInFQy21EmrHpRxEq2q3mcBm27Ga9JUKq2pBjn6Yaeaau99aq9OWconY4lgNuVaQpNMq9P1frmndq1bfQAQ/UUaN5H0uZhD2PgVichS4K6xaCyRkdyXAuaMgowt+enRwOJGU9I6IVRyrMg/Z6YliR3m1W7aEPG7wqJ3c7qe0dvf/vCzKPOYyn3hSzMJ2/8FpWJhbL6kiEBMqehSMMz9zbGjIm+0vwUKeRsdDhFCRd/RCYLQwaKcaKSjcdC6mdeeBLcjJbtNoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 08:16:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 08:16:35 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZUlxYm6GOmk6wmUW710g04eg+cq79GCcg
Date:   Thu, 16 Mar 2023 08:16:35 +0000
Message-ID: <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-3-yi.l.liu@intel.com>
In-Reply-To: <20230309075358.571567-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 28cfea90-0660-4a7d-ca48-08db25f6c243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Anf907dIVwlfi5pp3yJ28QhyiOkBHi3aKvP6DqihGYOHiWaYyRZktIoNFHn4ZrVQh2QiC9uRHZ2sIUbSbWCO+2LWKje7YbaKXO3jIFZrD9u7vjvQ5+e0fnWuILOvxDi7Ze+VQU45aD1/jwKWO9NIso3o2IspZrYKcXaixFfPxY9m8pKpTdlFwY8kRG8BHQ0xhxKRwW7kRrJqvJVOYwaROP+nHKOhRluIx8die+acnzR8P4XDiYT8uFvExeEFwlZAJwkrUmu5HdTeBkCw9JGD8LpSgK7+I41F53tyW+2SiDta8FizMmRa9GNs15F+mSfoIspHEyCLJOkqEIGBA7Fu79+9RhiOlAGPkWDZj+vUf6Nh9vxdbwcT1lAqztqCEZ/MSN4vKzFy8HDri6Ejf6Q3Yd1aCxW4JEcAX9adMnXX1PNAIv7LDzCnvImwYgwlp7aiIx9CDgi3kAmikjjbMcAr5Hw8HKXf5HtvVPKS81KsJoWqc1Uo0ae/nNvogXz8NWIA9mLewAk7gKIsCmMb24eHFuXBVPsR3WxvYe3MQlYK5xQYC06ia8KmC6G9z82/a0MKmQvsAtRMpESpIocgOxGvdmsawLDVeW5UsH/UiyB8osum9c26jNBeDJbJR/bJDz8WvNhUJMz1wLVude+9/fJsVwL9OMvzVFG5ojncpezY3ERrKcjhLYvKW+cG/UGRMgtPS9/OtRSBUEIffIsTzU6yJ0l2mcBvNGD3qCOThCkr0FBSSnF10leQRXqouQCcEnJq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(38100700002)(38070700005)(86362001)(122000001)(82960400001)(33656002)(2906002)(41300700001)(7416002)(52536014)(4326008)(8936002)(5660300002)(55016003)(76116006)(186003)(9686003)(6506007)(83380400001)(26005)(316002)(110136005)(54906003)(64756008)(66556008)(66946007)(71200400001)(478600001)(7696005)(66476007)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YjQ5+MdMU3rXNyElva1yFH0X+cMVVJzSGk54MuAtArv79RsXRavxONv2mlv3?=
 =?us-ascii?Q?ncckNsVYz3EQPnHnVIksigT74ePnvnhB+CjXWdHtgXw3aaZ37cn63HGI6/L9?=
 =?us-ascii?Q?YIiLJ44fLalPWfagSt2KFXd0CUXSjc6h/B3nup8EDmdZi6PXwk88zQ5fLu5G?=
 =?us-ascii?Q?mRl6/DTROQSoCixnguhtjksB7p1c2vSkYmF4nSoqB//QwOpuMpNuqLbkdPWV?=
 =?us-ascii?Q?x0mrUqUdl1CZeVYSBdyPZaUUtUbnSUu3l+uXmiYU/KTEo/MUwNkUrMX/JlLA?=
 =?us-ascii?Q?Fg/7CjmRTmjqXq9gMRgD4eINhRBmoo45dOkZN/jIqh3EXXr/O0ttL90DD7VS?=
 =?us-ascii?Q?jsW4396KDtDN2MXTnYKhTmQB7tmvhs21skXIFhhjICv5QXS3GqvjdJ0ZZSjm?=
 =?us-ascii?Q?ULaSWWzW683e50InJD+YO1HviU63RTeYsrFGuYpFhjbLRXp38q7VedLzI8jV?=
 =?us-ascii?Q?co3qwZXr6rsywwj/lqhkz/I+XHRURZpJfhUaiqw+3sN+jtmlAcq1u+VAWEV9?=
 =?us-ascii?Q?3bi5LPbFbzRrM9dLpnGCWOfBfoOyTTGmEnIC/O6sEmT89HK6tizvzSRJ1Rb+?=
 =?us-ascii?Q?qAKvM2ETtJNF+dPw8D/M3KAheMXBNh1Riu1MTDcelxVfTT9RbgT2k320pXXg?=
 =?us-ascii?Q?65N5yzbMQhVlHeYa9FLeyjdbgYamVVVTnpaNZQrVTa+pWiEkXXmwwNmBmd+O?=
 =?us-ascii?Q?/cxnYno+xLmkhF17FzO7T3AHfF/Bg0636Ll7zCvIT8cRjglAUXm4hdgIUtsc?=
 =?us-ascii?Q?xNCeabb7f/G3N1JiRAKTkGavij0h/yQSq2OqAgK13HziPpTyR+QkEMSjEzm0?=
 =?us-ascii?Q?wCrTn6Eo3qSAsW56rB1A0vBNkPwq0cl+ew/NVJTH9GR0UojYFlYYTT8RfLCi?=
 =?us-ascii?Q?6MsW7mM2KXdsEw7nUoCoXpvq90aZ7agdM23fau9JL7qs/0OB9jffsfZPoOPC?=
 =?us-ascii?Q?ZKtbEJIxyovt+xgDv1Rq9rPQs3khfT4teWDRHeQO/6fjIdx3YZdMQfG9ay9X?=
 =?us-ascii?Q?HJRl4a90+qKnpU/r2rzvYboni5ZGL1PiZhWKxjLlbqqU7op1ehIXVUbRrkPw?=
 =?us-ascii?Q?SGmcZXE1bfwi6l/udf4lk9CMwcuikZALR5i9Lxy/67/6AOxoS/UiT9SZGPnJ?=
 =?us-ascii?Q?jU+h0FNwg7PdEXF94AYJd/jAB3FRl4UGZW85vC4NFST2jafu3uM1YiWVs90C?=
 =?us-ascii?Q?xcPSUgdHOLA3jG/4sDsWRbX1lmXRY+yoXpFR9m9ZY3DBqYxAV4lhNoNLcEjF?=
 =?us-ascii?Q?BhVZtZOQ1p95oKN/xIf21KiwKj3UmnyXoqro9EPbxKeZx45kH8YzXKYojvFV?=
 =?us-ascii?Q?kcX9uQaeMk63fmZJlzPGUoitcVxR+NgYqWAqL97iTsNZP7sUny4cj+UC9/ZC?=
 =?us-ascii?Q?uXdoL6zQXuUEfz7dk+cQj3eVNzn91nFzCwXmHizTruPMmvMMjBjDbmQ0qmvQ?=
 =?us-ascii?Q?Y830UIScH+R8A7Q/hypoyHfTV8fajG7Ijf0h8C2mkMyLKiaEcF5+Hz7WODBR?=
 =?us-ascii?Q?zNCBD9HXPOGxYniNQXjfvdYg6hdfrv8vOvXzeGwvnUE7oRl1oQdNwpPCvEqr?=
 =?us-ascii?Q?15onFcrzko48y3Jyfmn1G6WMH6ffDbiD4cxC2LJG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cfea90-0660-4a7d-ca48-08db25f6c243
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 08:16:35.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yirhpbO4Pvqyq2WwB4esYVGjJAvM0E/lZqRzOg45syO+43VnU9Ntc+GNj2jEUFJKSPbejfBSG4k4JDvZOvAiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, March 9, 2023 3:54 PM
> @@ -222,6 +223,11 @@ struct iommu_iotlb_gather {
>  /**
>   * struct iommu_ops - iommu ops and capabilities
>   * @capable: check capability
> + * @hw_info: IOMMU hardware information. The type of the returned data
> is
> + *           defined in include/uapi/linux/iommufd.h. The data buffer is

"The type of the returned data is marked by @driver_type".

"defined in include/uapi/linux/iommufd.h" should belong to the comment
of @driver_type

> + *           allocated in the IOMMU driver and the caller should free it
> + *           after use. Return the data buffer if success, or ERR_PTR on
> + *           failure.
>   * @domain_alloc: allocate iommu domain
>   * @probe_device: Add device to iommu driver handling
>   * @release_device: Remove device from iommu driver handling
> @@ -246,11 +252,17 @@ struct iommu_iotlb_gather {
>   * @remove_dev_pasid: Remove any translation configurations of a specifi=
c
>   *                    pasid, so that any DMA transactions with this pasi=
d
>   *                    will be blocked by the hardware.
> + * @driver_type: One of enum iommu_hw_info_type. This is used in the
> hw_info
> + *               reporting path. For the drivers that supports it, a uni=
que
> + *               type should be defined. For the driver that does not su=
pport
> + *               it, this field is the IOMMU_HW_INFO_TYPE_DEFAULT that i=
s 0.
> + *               Hence, such drivers do not need to care this field.

The meaning of "driver_type" is much broader than reporting hw_info.

let's be accurate to call it as "hw_info_type". and while we have two
separate fields for one feature where is the check enforced on whether
both are provided?

Is it simpler to return the type directly in @hw_info?

btw IOMMU_HW_INFO_TYPE_DEFAULT also sounds misleading.
'default' implies hw_info still available but in a default format.

probably it's clearer to call it IOMMU_HW_INFO_TYPE_NONE.
