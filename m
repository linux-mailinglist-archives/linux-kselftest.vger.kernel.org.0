Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720276CF771
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjC2Xfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjC2Xft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 19:35:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807112D;
        Wed, 29 Mar 2023 16:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RryMmsWV6gdfMUGBW1LU2DeOt2tTZClsw0b6GS6z3DdNKV4o2bQwhPEooMVuLMlBBUhzvPmfjW1yA2qvPSGcpc8qqLHj7DQJQ/C61vNJGzyWpSGW4c4qSl7O5lVVIYJZL0JSQN/axBtSDgMJwnuUOGi4dbKFIegCroGfXjypFSQnc3dPDAQWqhGXG6UbHlqKzplbqqhSKGqVtGhmsrN05T9vlowV8n3yvan3mrCcRkFQt0DySuAhSWlF112mKEqN/hNRVfFFkdqq84l+Gg3r/1+otoYXPS7WUU14GwXydvRnDtTvcma5gSRPGDKHZhwsFu2y2+i6GNlW4hNefqJwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23kyaiAUao+zuPQ+f9aPdnrW3jppzJsPaz2AriRAV6Q=;
 b=ThNhp4f/BuG6HJSfFBQiKbjpgQcIUnAq+X+e9FA4baeGEojjptRTsTsKZjF0vgsVg5fRB4WU+bX8wQJmkr+HU6WF/GDexEqT+SCtQvzCey/Lwv1FUqh/o52hmsd/MnpT6h4yD+tnPyf2/YaGtXov5L000v50L6ByQiF5ybsjJkdjmwWEH771CjNy9Q9yk+xf0LZzZmSQcLNSz03LrIZYJ0k/TRkDKtA81hyHHh8pGNzI9Yf1x6iUfGvnScSk6NqGYGw5vsDr7CmBCdqXTsChqznxo6d9QoXkNMbvUeboKxR+5QL1f3LlbZ5mZN0C/anXNEyjhpQYUBr0uoEn1D1ZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23kyaiAUao+zuPQ+f9aPdnrW3jppzJsPaz2AriRAV6Q=;
 b=MVJbcE2T83Zwb4AtSeqvnpQ8xK2gsnur6F2B0hQ9DiSrhiBQtET06V6MBgedIUlLJn83Ob4yWM0e3DdS2idKxg0UFKr6OJZGdWloaJ9HCyuA43E4HpwiqE1GXxt4h/fUchHla8iizJQGwzxt99XLt74z9weUR9LhwrgNyDYPIyosBD4/3REs51slQumtrTyUdlFrFAVlRL0C0e+vLG6iCfANcuDBQ/3JB0wGyz9VOX44r30pvx8Enst5UBmUoe0eE/GJKf1/GgAXxHEiQIZtycZKYjeYvNtjNNv0GQOqHaIoKp82HQdAz4LEoBI1yUUcWPCdUbni3LFIVw4by5ezrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 23:35:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:35:46 +0000
Date:   Wed, 29 Mar 2023 20:35:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 00/17] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZCTLUTHiYzexhFPE@nvidia.com>
References: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a27b432-34b0-41fa-00d1-08db30ae51e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFvU1rmxlTqCu15ESUhj6g2zXMqSNc9OKo1nz3V1q9i5vBQUPe2yZEeRdHQZwmSQ8IcOQdj8UnfeBSbWgE4XHmK1IPMJm1+n44GUMPQnygiwvpfyJsJlYkyy7f5JKRDyvpkY0xxFuw5wxZgmifMIBwQ1MH3IG0o30gyqHJKfiOOzDyM5Il7C2q0U9sYzGkfkZ9AoP8FByWRIh1PtKsDQD5OjwtQdJnosH+z45P05McK9CRqqMY/ak0wufUfZ/TnVZJrz2UcWsvBk/GtKqKDtrfYnCSp69kmfSmddRYmPCgbFyBGXqWjg2/5F+SX6D9wSEiqXG+Sje/tiNbjj4dbNetpeNTfU6AxMp7ogxCAcp5+RvjW3MioXD7s5DAKzFix7PCVGaWRvhjs6O6yzrlhvgIYno2Y4xJr8RuM5mPKgI92VEVXQRoxxXSzJBbuJ6dFUvl7sSrA/KwGnllUXHQlcx7TYOfcv/A1OOLkoaUaAEADIMsuC6bIqtxYOfpatxgKHPWzvi9uOwfS/M/bogCL5iVIsnK51D2eQIxSieNFa4NBwbR6H2cIDOiYlt3Kh0GXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(83380400001)(8676002)(4326008)(36756003)(5660300002)(86362001)(41300700001)(8936002)(38100700002)(6486002)(6512007)(6506007)(26005)(316002)(478600001)(2906002)(2616005)(66946007)(54906003)(66476007)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dpk7JsgLfpUAwfnE8hUzlcOgYGeUlUIoxAMvNy8kUxQZ7lvPgLuJ4+tH9Yi?=
 =?us-ascii?Q?0hPnKWyElJb0xxJPKcyTr/botGV/RZbE5Sa4/8G3LA+LoOv9i/+4GIAWKb0I?=
 =?us-ascii?Q?uM4W7Mub0jQ+VwnqNfcqsHZHjh6OawItwUib52n3qfsUPrjjN5hxHpFN/6FJ?=
 =?us-ascii?Q?HhCwQ66ml0j+iSQdeBmg/WMhZBKZ1Cvpe2MR/D4iPdm9PxlrD4oydHLQORo2?=
 =?us-ascii?Q?ObzCfm2GYmhjpcyhYJKmngM1SSF5zuuuCx3CsBYcJlwAv7aYIPnnOPB2p2Bz?=
 =?us-ascii?Q?MN1P7qpM/REvtNJuJLhW+N3CQvEho8uLPX6fWhTZZzJmdsiQoybsm8gbO81x?=
 =?us-ascii?Q?BSeGdeVMVVmbM5HEJxQnntDPMRkM4wmZX8+R3AtfYJSyKfEry16/escyRkDc?=
 =?us-ascii?Q?gnInHYlGRgd1RaNqUbyvHoISZiWHMjZ5wP+0sCThWL71u2AObvAoGcxyG0CM?=
 =?us-ascii?Q?Vcp9DZcvQgbimuLXFo9+oTxtkOxsGi6XbhDQjGRh49osEYKD8cTI6gWEN3EK?=
 =?us-ascii?Q?sHlsXovvqkzpQrL5xw//aSFqJrpvq3wWvAa9ycIuFjZQYcYbpp/lEZCXvpWF?=
 =?us-ascii?Q?tqsAe32r8x449euQJNbKSAxTndw4om/DG7Rp8ON6LDSezF9J9f50w2sYAZif?=
 =?us-ascii?Q?mJwi2w8toho6ySNKUySnLkKueF8BqZkBY/BFAKcaiwzqTzoAqvN3OwBwAMXA?=
 =?us-ascii?Q?liquXF+0lcCEFqqY3BGoCr6WbyiYbAe7BVk51G12wZM2ebSriYwcEHf9RzYt?=
 =?us-ascii?Q?rpSN2coyYRdKsXKWKxCpNyPp2EKn5f0iH+x0ieQIJsEjT6MmOi79aThQvk3O?=
 =?us-ascii?Q?fnAMzsnQ1Y2dkkhxkyJHj7qndBxdNHRzD+uLVMawHRJYy2cVMce7fLLpXYLu?=
 =?us-ascii?Q?/IPAFD9V3DND9TmBSoRQZCYawhR6K64Xdg8BAOx6EvfUqyN24fmXo/YIhbQz?=
 =?us-ascii?Q?LR3G/Apd7sft+kXlN/6NJXfQSQQRjG6CmGyevRgNbpPABUDHlXe2eqEWsMPf?=
 =?us-ascii?Q?Wp3PmtHEpeR8Q+SjwCqD5xWgY2HJ95r+2l6TMg17lcSDJCk1kKTiTRn5iEv2?=
 =?us-ascii?Q?Lcm0CF5GQrg1H3ylE6o0/gKaj8sokjwUkovMkmNEVuKPiLHIJD/35gE9vSbn?=
 =?us-ascii?Q?6OXo8dwIa8tGOqX7sPjTK6uCEPQUHLt4VfERddDqx5G0U2D8L+RzF9gOgt8G?=
 =?us-ascii?Q?BTCx+aQfljnT2RODw0EcDxdeOfvEJNaEyskLa/p5QqDJoRkch/fJkzCaaI/5?=
 =?us-ascii?Q?xueJA0ABjwzneqsOipayLqg+rnoZrz3XHi4cHkgcfvQXCuXxajgbJy5mFbqk?=
 =?us-ascii?Q?Zb5GvOtmb31AUqvNBMEaglCy6cGOwAvk6GpS4XIQ2iSnSb/T1FEMIjKKrJkY?=
 =?us-ascii?Q?zlUNPAiUDqwNcJ8lkH9A2vWWPiAvaWDqCuyNRg0iJx2tlrEfSx0vWFDDt3Cm?=
 =?us-ascii?Q?GNWNWFjdgZH0MQyQBkzsjYsxSv47E/btYeV6EMk8Yg/vUHIOnDwE+XTHOS5T?=
 =?us-ascii?Q?YXp2VS8uHH4Y/imOrto1hyfzquMDeOn4ilxg38Vv4ngrJAl33UycqgXL/DqR?=
 =?us-ascii?Q?CXtAPJaqAn4yLzKjqK/zk8IiAuFCbldIM85fxpz3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a27b432-34b0-41fa-00d1-08db30ae51e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:35:46.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1lKAVsf2dDHtiHQwSVT6reustUaDY5GMOu//mzldZoPThLiyG7MHJfSMAFTcy14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 03:37:54PM -0300, Jason Gunthorpe wrote:
> This is the basic functionality for iommufd to support
> iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.
> 
> iommufd_device_replace() allows changing the HWPT associated with the
> device to a new IOAS or HWPT. Replace does this in way that failure leaves
> things unchanged, and utilizes the iommu iommu_group_replace_domain() API
> to allow the iommu driver to perform an optional non-disruptive change.
> 
> IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
> used by attach or replace. At this point it isn't very useful since the
> HWPT is the same as the automatically managed HWPT from the IOAS. However
> a following series will allow userspace to customize the created HWPT.
> 
> The implementation is complicated because we have to introduce some
> per-iommu_group memory in iommufd and redo how we think about multi-device
> groups to be more explicit. This solves all the locking problems in the
> prior attempts.
> 
> This series is infrastructure work for the following series which:
>  - Add replace for attach
>  - Expose replace through VFIO APIs
>  - Implement driver parameters for HWPT creation (nesting)
> 
> Once review of this is complete I will keep it on a side branch and
> accumulate the following series when they are ready so we can have a
> stable base and make more incremental progress. When we have all the parts
> together to get a full implementation it can go to Linus.

I think this is reviewed now, so I've put it on a side branch
"wip/for-nesting" until we get enough to have the replace series

Thanks,
Jason
