Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67EC704DBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEPM2G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEPM2F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 08:28:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554105592;
        Tue, 16 May 2023 05:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUxuA1ZDkO3z+poriBWFSxFwS20KYJ+UAXVwQQemkLtNIpd3+AmejRSghlFj6hZWOupw6mcoVPdiIk8pRwMN9kJk4qwZAOj2Ls/WfSQJk17LkFdIVe+gXMVJMIiYKMacpct3EE/RDMKTH8fhS6RBTGXjWSdu26xJz/v8SGBUTfdZa2LggpnsGbIE8Kvm1yFsXuNhkffVD06+LABxbxwEnAvxVhjJ0GSwF3vd0o7ViPzwfwFH7xqPK6WKxJnt6O3EoWocvbj+O3887lBWVqsBJ1iXvmc2eQ8Cb1/0CPFC328bcR9Qnnu6qd09L/88tKh2CP5KaFESO+ZI+6pr/3hP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xf8jMWQTsHPtUgv9GqZw9m+Br8kUGE5HBOsjLNVr6c=;
 b=CUFgQH2h/W63rMWXgoh0aTRGPLz/FzH+oVMYD7Ski7a875TL6bvjhHkn9tjSP7qNKjOPam5QvQoPGNzSzEk8Tn52RCWP5tpj7QiZbtAbbGhGDcqqhbX5psIdPVV32hxY37DY2sV/N/DkeyQf+uJsdYP3foT6brmHYIxfwm5Syj7m3ld+uV5LQaslXPqmCNGXwBVh3epDdP0T32cQJa4hFrAkLmpD83HQZ/F3QhZuH0/kfJ0QYTvTWkaCnOr+IJszzQwJOtsHH7+8qJor+oaaKZyACwJ9mx+mt/i+MWSBlYDeJXdzouQZPTscWiIn9SE76Q//gFOY6stOAP/2JRay7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xf8jMWQTsHPtUgv9GqZw9m+Br8kUGE5HBOsjLNVr6c=;
 b=gIw9nT14j2rq8kJ0kqxqmtWEODsiW7DEAeVH1RubRbgPowCSO4f5xZkT06dMmp0MStSEztCh6scdj5AdO2QH2Y24qkSMmlEScb10qazC7ML4rQ6bTXS7lUpn1fRQbWuiy6WBL12t1Hgu9xDWMpqE/FMtv6o3ARvfVAFTpIW56RgHqNfHMlT0aH5Y9vu+O4ghu8JDBDhV88FpaY79bR18obX0h41GFYCO7wU06/mDfFMC3PRyzsHjkfbCSPVnjfbuhFxN4W6ZS7HUSRefzXTMwHuyoAGSx7w5jMwRTex48egzinwOEyoXxdK6p+dFD917jKs8OZcGJjEGdaiV/2lphg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 12:27:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:27:55 +0000
Date:   Tue, 16 May 2023 09:27:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZGN2yvhpIvrvu74r@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: a61c4060-de79-4a75-a191-08db5608f9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JngvNuJUk/0kVbQfpwqYPIeCu7VfBFc8ezdie3mnwE/o4gtRKcWVsikEfBks3gDQxsVNw2wM9IUzFEagi5L9ws52vBmo945oEx2yQp6QjLWUMt0l16TOGnwgFtvr/EexMqsUgO4/NFvJLVylhyrMM/WbW7D8OuCSTdVU7VCSe7PBWVtYF+JFiM8wK6AFNqCQm2RRtvaZ3R3ddMTcD0UQWLWXx6Coy+kxVBy+j2ThSbguW5OxXAQOqtHYOViJiC5Sl1wdrYrTpxScSwGTpmSZYqjXmc4I3Iacyyei6FEclxRt3Y13I+QebBTlunJTduEjIFTyod2v8FbK1hkbx2+epbosC70BTSfy7pS4YYz2yXxdADZJfj/KxoyYvcUmxyQYM8Sf1KitIoqScxdSnbNRv8T1lpztfYdFnlnfocsiVxgk+CvUuQVxPEfSu74GzNqguh8/N9Z9w4VjeRHe/x5hqVuo+IGrUa9s1KTbq73P4PmA80pRxOp4uW9RhK/EWKvjSj8Elfo/Uqc9aDYpYYy5UFCe+YAdzeOH8lzKPiel4oRCYV0pMpnupkoiPeYxaQCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(36756003)(54906003)(478600001)(8676002)(8936002)(5660300002)(38100700002)(2906002)(41300700001)(316002)(66946007)(66556008)(66476007)(6506007)(6512007)(53546011)(86362001)(6916009)(26005)(4326008)(186003)(83380400001)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bQtRM4u2Br6OkUx1X/BTvlpDl52halOOz53L1cbQKBa4osesiMxfU7vF0QX?=
 =?us-ascii?Q?1Q3fKkRYWv+WeCITeVfiIyYv3bfnTu4XNqeokyF3S5v6jq1jKUXgptNp515m?=
 =?us-ascii?Q?uElG+kj7Y/diKEZug6bXdeEZetP8bzWmgNFxiA1erwrIDTux8l62A7pSa3xt?=
 =?us-ascii?Q?x/FHnzqU6/Sgai/BDIEc3wSxMDcRp8KBNGGwTBIhVlDRFnpM0/Exlex03Eb1?=
 =?us-ascii?Q?Atl9+JcAz//10KYlnbmx/cYOtBVdBvsFt0OE9amOnQbGPUWYz6TUHlDRyPkd?=
 =?us-ascii?Q?aUsQbetNatUE86APRcftdn0k/RGSTrXxLkk+ldCxIZoOK8V6fvYJr+DVXoWw?=
 =?us-ascii?Q?pahFwsGtlEH2sPrEFkPOZ2kxYIPz6FUxzG7acWwyRznordSlkAiv1+gbK0Tm?=
 =?us-ascii?Q?oSAmrYjda0teIm/8mqMNeF75uQt9xQsC9e9pF1CumwuZbL8+KkCCqQmX3LCn?=
 =?us-ascii?Q?9bxHdZXQHY6D9vku0gNWJqVb+VyeDH5GHRvVy6Ell4lntUZt/NlCdyEPMGNF?=
 =?us-ascii?Q?I0j0nTaEiR8eBfQ4GTE+lwYefo9Me1736xukT611Nctz7FH5C9mjqS0zpzl7?=
 =?us-ascii?Q?MLYfsw4VXaFRf7ijFbN+ezSddd+xJzsIYONP4KHRpnZde1tsdzH41te0p5nJ?=
 =?us-ascii?Q?ogofvLXMaJhg/QNOvNXrkT9WQOC2rpNCscCEOyhTt5sumNoNjV+/4nTC4OKf?=
 =?us-ascii?Q?B+d4ZfqM8KiRnuMBypHDGN9h2oY4tiLMiEsCCxv3juGbRGiBJh2RVCcuNB/I?=
 =?us-ascii?Q?38HUR96aDoctFrhi8Ee/Gh/c1co9MQwGp2RaomGVFKfL24I796Z/YK99eAfX?=
 =?us-ascii?Q?O9ZmXRrDY8VdGcXTTyS/ylj1+Sd7K4AsR3Vgb/f5MuLrfe2vBxChvfr1S00y?=
 =?us-ascii?Q?da0mJmjNJEOVVy5q2l8tls6Fd45Tp+T5GE0QZBot06Dm4gVBfbfZuzYml4hw?=
 =?us-ascii?Q?/mzGwLulJFCrqHA390RF/1oPzUdfnDqNp1sB97KpVSoBtkq8nCzkjva4FHIN?=
 =?us-ascii?Q?8xbgXtlcr4A8U5EAmlDZ91bValmVCEg8OhNvo+6n9PrWC8UZRJ3Ud/fRGgYX?=
 =?us-ascii?Q?gdcnb+NrJDgveFdMJ5KkYe+NzNoAIqCowlN8FI4pAeFMcwrPpw/1q/iZVR7R?=
 =?us-ascii?Q?JWcN85s0HVmxpzSCmue5/XKgBlx/Gw7km2KJewvWuqr9n/tm5B1RsXH7UAwh?=
 =?us-ascii?Q?NJU9iD9fn42ecrf/ZVdhc7PQyawjYO8j1tGBBSoRiTE3Agdv/uO2IJdfnpCo?=
 =?us-ascii?Q?LTI2EqAkfUQEeE/8BnAJ3nkfUFETqe5ucbLlc2vEyYtA9czzg3j/7wVm+Ptj?=
 =?us-ascii?Q?CVuMcsum0RRyEdN4KQ+0maaJa6Zg2fxDo2Ksd7lhUQCd7bUNhhvmgXkkPBZN?=
 =?us-ascii?Q?FE5+g0kawYU/Ke5vLLkcGWDb8LESC4MZ43OeNmS4vT3bkueP/6sH+oBzchhQ?=
 =?us-ascii?Q?BaLLggpUamKeuzndbapARd2cQ3mEDv3VWmR8A/k1m8NqE6dJaKh2rlfTLbdu?=
 =?us-ascii?Q?UgsoWjBzJcPG6Bn/JafF+kjmBgHnbbgp8bp0md4qyNEUZHSV7CA6GOjMCEbz?=
 =?us-ascii?Q?+KycGsbx0KA+hzTf95QmfNXf1Ywb5+kwSZvYutzw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61c4060-de79-4a75-a191-08db5608f9b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 12:27:55.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjJSwYr/wicHk5g6jHydrkI8Y+7qPgH6KPEce4dNdOXSD/yJuS5YlwljwN9iUooP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

On Tue, May 16, 2023 at 11:00:16AM +0800, Baolu Lu wrote:
> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
> > The devices list was used as a simple way to avoid having per-group
> > information. Now that this seems to be unavoidable, just commit to
> > per-group information fully and remove the devices list from the HWPT.
> > 
> > The iommufd_group stores the currently assigned HWPT for the entire group
> > and we can manage the per-device attach/detach with a list in the
> > iommufd_group.
> 
> I am preparing the patches to route I/O page faults to user space
> through iommufd. The iommufd page fault handler knows the hwpt and the
> device pointer, but it needs to convert the device pointer into its
> iommufd object id and pass the id to user space.
> 
> It's fine that we remove the hwpt->devices here, but perhaps I need to
> add the context pointer in ioas later,
> 
> struct iommufd_ioas {
>         struct io_pagetable iopt;
>         struct mutex mutex;
>         struct list_head hwpt_list;
> +       struct iommufd_ctx *ictx;
>  };
> 
> and, use below helper to look up the device id.
> 
> +u32 iommufd_get_device_id(struct iommufd_ctx *ictx, struct device *dev)
> +{
> +       struct iommu_group *group = iommu_group_get(dev);
> +       u32 dev_id = IOMMUFD_INVALID_OBJ_ID;
> +       struct iommufd_group *igroup;
> +       struct iommufd_device *cur;
> +       unsigned int id;
> +
> +       if (!group)
> +               return IOMMUFD_INVALID_OBJ_ID;
> +
> +       id = iommu_group_id(group);
> +       xa_lock(&ictx->groups);
> +       igroup = xa_load(&ictx->groups, id);
> +       if (!iommufd_group_try_get(igroup, group)) {
> +               xa_unlock(&ictx->groups);
> +               iommu_group_put(group);
> +               return IOMMUFD_INVALID_OBJ_ID;
> +        }
> +        xa_unlock(&ictx->groups);
> +
> +       mutex_lock(&igroup->lock);
> +       list_for_each_entry(cur, &igroup->device_list, group_item) {
> +               if (cur->dev == dev) {
> +                       dev_id = cur->obj.id;
> +                       break;
> +               }
> +       }

I dislike how slow this is on something resembling a fastish path :\

Maybe we should stash something in the dev_iommu instead?

Or can the PRI stuff provide a cookie per-device?

But it will work like this

>        dev_id = iommufd_get_device_id(hwpt->ioas->ictx, dev);

Where did the hwpt come from?

Jason
