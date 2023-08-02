Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8209B76CF27
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjHBNsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjHBNsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 09:48:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8FE4E;
        Wed,  2 Aug 2023 06:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2cMegOUy94Ac1fF6bG+EiQGQnA5/XL91VlbKd/LLsByoFRWGulfyCVEDzuhmTNuZ/lC4sJwC38/7XR+QaxUrQq0D8eztGEP8EfQUZ+o9RZo3yoTuHRlMCUOfN4X4GE41ZWEb0MmkwKHldaWNpvEkOonUL8vyoVMxwwsgrqjp5tKBPKbVZhYnV02RVE1w97VSEa46xazOKDeSk9gOOgzSWWfLN+f/llV+3XesLLpvYxdK0ovYyoeW0IK7rfZ4anqttY0vWwVFOs7xYavnxpqDWtyOghN2YJ0Mf2B2LYjVYxjJiPpvjo2p0O4WfMeBrN+4SaGlb+4teSB5YPsHQzkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ciXvUz1N3/DaB5j8fIipqGuDjxCXUzpaOxuf4pGbb8=;
 b=ZW9Q7nEc4jxvpKrB/QB1Tieyqgpp0RaYOWfBsdThuy+BHxwkv1vunnV0A5G3ZEs2zuoM5366JrVid/RbEUuoacBxHpBmYblzEVLJmU7AClAXcEDPJp7ssa8HtZOAGhKVNIkmN3c/jIjf9ZdCgcWQbCsg6kEzt6lHhK84pt5ZcrswT88z6EyRDqR58AXrYMpGstObN1uvSUmqcOQgoClLl9ytalkA619rpnWty+UYijTNxZB8w7kLj+XQQfx3h6w32C+NWou3yboYhKEgFgSqZiabMDwwL/NuwmzBKvG73qcUKgoVKfF6aCQ4lxIBjLvh0uGwqfBBYo+1Mc8f001p4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ciXvUz1N3/DaB5j8fIipqGuDjxCXUzpaOxuf4pGbb8=;
 b=pOljG0+ZA3LR3yHp0ZBUN9ilqfJfiVpdq0c4L/WjFJCikYIZlKszOMzt7cev/V/h7MbRGDu5gzmfvq7JR5ZT/U9Wd0Fn7xHIF1hO2pDsWOWVK9R5e3JbwMgDSGJMrRd1I/KRgT+r47lpyhJiv/jg3+zPtG7Mqv+edHpnzn5/a9MhRLAn8b2mTHJsToeomidy6JBhywzil4hTCc6azn6FPPbw4o3QkGTA17sN0IRgAZm8whkMz7jyoK9sHhWhpP68OS/XpkHWixn1mU4ZnnD43ziUyt8XfM13cl7Z7mqY+kE2QnMRvC2w0sKePQDKhvLNOD+FGiTGU2Z19epxSjLwUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:47:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:47:57 +0000
Date:   Wed, 2 Aug 2023 10:47:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZMpei2/CffaW97iU@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
 <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dbc00a-6056-432e-0959-08db935f1468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJhqeixGr8mqot8nBc/Jn5Juy7cajg7pcKhSYX8/oY1DlitkbwqJ7CxRqXy6U/zCtpp+oiihf+fpSeoNM9Gx8va8ARY4/iJDtWQSzIn+dGCkstb5jrrncyUHG/jDwrV4TQbcXhHhAWydhcCW2dM+v4ucsdqwlwBCRtmde0yuy3tU11iMDOkmReM0mrKpJnOkTOomNAx5jJccMQLqN3DImvxERvT4obOAP4l85U+TYsUBrXKHNmh2i3V0t4Sqq7Pnj0PfLEjxfMqc4ZUnjk1OlqB39H1jQCB4eP6Wl3r6ebP5fkzSUyPdMsT6jlYY9xg0eVGtPrYWjyBZqiKEnswv0fAtBULFabmKQP6pOoppR7sjVYdzQqIQho1544d4FQr+5VRnMVntOz9PRQ4iA0g69xly0CBovD3ksUt5498IPlHQXe4D5t0fAzyumqOrfCy/0556BY5Nb/Em6S2OLfzl58Sx4/WcnP6xk1YvO+Kb8X2eHFrDxQUdYM//SRw09YgkvPDzMs35EIX9PliG2XancYOUejgBwLHFc5NQCpsfKYGF0TNexwgkf/zJELkQd82S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(5660300002)(8936002)(8676002)(41300700001)(7416002)(66899021)(316002)(6916009)(66556008)(4326008)(66476007)(66946007)(2906002)(26005)(6506007)(38100700002)(2616005)(54906003)(83380400001)(6512007)(6486002)(86362001)(36756003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVgYw+1CyJa/6HXRt4Tt5buoMWs/5UKH6dnJ65mGE7DMjEVR45GsFvIEbjtj?=
 =?us-ascii?Q?1GotXp8k5OmK4egWccFbb4cw0j1xPJqBIQI0WETc+NcJYHipHYkbyzoA9Wn9?=
 =?us-ascii?Q?vJWn1KHAa1Xo8lyyBOvb71Eo7QS2rhALdymrWiWCFyffcOJ3GdMiJQvSKKKq?=
 =?us-ascii?Q?0mR6gqQdO/LJG7YoYfU6U5NU7JtIqpkLV+6KO3AAavju1LAkGTzHhGEyCVMh?=
 =?us-ascii?Q?v8PjPEtekSbxFgR2SOTA+HlmR4rE2Z4COvCrp1PsHUTLeTO0heDHLeiYIYup?=
 =?us-ascii?Q?1ohikBzRpw4McTqm8nIxpzIuy1Zbss/6/P8Ds6Mx61qx6pIK1KB/l30aE6Q1?=
 =?us-ascii?Q?j2tSuNgRTEKA/5ywSMqGcxCBVwwm3R9vL3AA+UZBuaP08qK1RiL+KhkJ1MpB?=
 =?us-ascii?Q?JcdIrXfv/V+KBWXc0EQ8XM5zKymiHALnEsl+5pXQHHNYnXeEdTorvzF3FLUo?=
 =?us-ascii?Q?g3DAy3Y2cW1V2Z5YmTFvCJFUPfJDCtoUSC6OE9mMsZQvYp7OJJ66cBnpqkGS?=
 =?us-ascii?Q?ROwTMEYFbPvFwKAG3FOYCBJ5rRJ5PEAVxru9RJkJQBRZbJ7sUdeQn+Bhv2Op?=
 =?us-ascii?Q?TvyQ4uPEjv+a+1d5Gm2KBn2pVLwxSnxxOqMzny1+yZOtBPhwSCIt0CQg2E5+?=
 =?us-ascii?Q?Qx5myTZbogObBuqEiZTfab1kwQJCUT0//Mu+12OB0w8+QNoyjj3B3HdxvQP1?=
 =?us-ascii?Q?6MkS8NcnfX514WspJwMtMNfbKSXnpmQ4q/9sHxQQgvoX+WvQ3Lqm1hxhkG1A?=
 =?us-ascii?Q?KPwPWYkRrAQhYasZTbdtAfjxrnnNBMYLr5iFZS9OQRcm0ERphsMAwwcTHdUv?=
 =?us-ascii?Q?AwF8/+OrEWeti85adzhQ2NzOOFmuKEU2FrAawHKt2q7njJjrNuQ+AVQP78Ph?=
 =?us-ascii?Q?WHeoIGB/JWm2z+U2eGjq5zVufeVKXunSu2U7hK6ye7Xwp7cEH5l3UeSULNef?=
 =?us-ascii?Q?Lasie3jhLad/kN6gjBeqSpODb700XJRZFXl/OA6zPzwJPTcBNU0wEeMuQ1BH?=
 =?us-ascii?Q?AKtKJbky3jXTpYIj85zCDvpewDPiXHkLvGqJQkCfpFUOrRYOs2zqR4tYr6lB?=
 =?us-ascii?Q?rAxtjbr88mRBictLkvLD2bTBesMNxfteq+y9+SCZA4Pr7a/5CZBzhARdSAOX?=
 =?us-ascii?Q?qjWLjNi1dyE8WJZf7/L2pPtk5w9a9uofkrjKHI1cc78d/nXtYjGGXPutsfGY?=
 =?us-ascii?Q?N8OUv4hgYH7pqu7YeOFgiw771RTYBY2ThUodkkwGnGInibwQB2trN4wgtBMR?=
 =?us-ascii?Q?/zrDslNSHMhcn7oYS5kqRNqqPP/rSaNRDs6vbnKJBkhmO5MfVjv0yxBO36/T?=
 =?us-ascii?Q?bzqWicfSTgN9628jXV0YRLVzfudQ+rMS5N/imkcRfsbd6ssn8pL8Ca3oWlHA?=
 =?us-ascii?Q?lhFpey8Rnb7MRGbbvY2XeHMngtVOqzz5kD4wz6wOJVP19uM6UJDZGdsQpcsj?=
 =?us-ascii?Q?jHjjdOzuuaFT1pgfb7QVxC9xsr+N5ViVGHnfJtRG36uZvfuWZBpdb4ywtZ5R?=
 =?us-ascii?Q?Mkl7/v+shAXTq4e1ly+DcqWK2/LVwjHHQog8T2tBvDRXhPk+gsQL99IP7FAq?=
 =?us-ascii?Q?2PuwGMG7ecYn5fj1lRUA+F5g1vRDO2sa+wgtYxJs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dbc00a-6056-432e-0959-08db935f1468
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:47:57.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZo7w2o+j+87oOa9y1Yf/ajHdfmQT4B7AR0y6eamKfeQ7h6MBZXGMf1G+O5EDuBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 07:41:05AM +0000, Tian, Kevin wrote:
> > +/**
> > + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> > + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> > + * @flags: Must be 0
> > + * @entry_size: Size in bytes of each cache invalidation request
> > + * @entry_nr_uptr: User pointer to the number of invalidation requests.
> > + *                 Kernel reads it to get the number of requests and
> > + *                 updates the buffer with the number of requests that
> > + *                 have been processed successfully. This pointer must
> > + *                 point to a __u32 type of memory location.
> > + * @inv_data_uptr: Pointer to the cache invalidation requests
> > + *
> > + * The Intel VT-d specific invalidation data for a set of cache invalidation
> > + * requests. Kernel loops the requests one-by-one and stops when failure
> > + * is encountered. The number of handled requests is reported to user by
> > + * writing the buffer pointed by @entry_nr_uptr.
> > + */
> > +struct iommu_hwpt_vtd_s1_invalidate {
> > +	__u32 flags;
> > +	__u32 entry_size;
> > +	__aligned_u64 entry_nr_uptr;
> > +	__aligned_u64 inv_data_uptr;
> > +};
> > +
> 
> I wonder whether this array can be defined directly in the common
> struct iommu_hwpt_invalidate so there is no need for underlying
> iommu driver to further deal with user buffers, including various
> minsz/backward compat. check. 

You want to have an array and another chunk of data?

What is the array for? To do batching?

It means we have to allocate memory on this path, that doesn't seem
like the right direction for a performance improvement..

Having the driver copy in a loop might be better

Jason
