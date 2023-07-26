Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79192763D30
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGZRE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 13:04:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75219E73;
        Wed, 26 Jul 2023 10:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeW3t6uHt2kKXssaoVegJXi1o8cVtwK+x//H7dFJuBgGkdXm+A5D4vm/5lbHX0EAhen9CPJur4aPMJVoHVFa+mRGzyAWBtN6q1XkghRlgLKZ33co4+V3tYrBs4LwXrKjxtlQTcqxg1rzWLKe0Rv5BmdqP11pfOWQAmAt4XTNPOhRyWcF7Dr7Lezqe1EUs0zywV0HhXxfGMvU0Fmn2l0DufCSATojqi8hrOhUvHQjasb3py7RJ22TGto5BA89EGJ9mPocjT48U7rRtnrLgLLPF/lcJIX9mwo1VW8h9G30d1VRQxavsz06upEM03K6Nm034amRdBFP73UdGi7DpQeIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mldf4yAQ2arIuQ1yfb3bn/uWFZ4vIC5fQhERUvNrbH0=;
 b=S4u8DPtSDDrMpCZyqU7x/ydZcB/VQmRbFjvdLmzFT/UCfBabQEYOcatSyTTc4Lx/YZDHwPW97ytA1xHZDmfz+dAQSUEz9MWsAydnnRhiq5a4PT6IZ1TmPTyM91lBQ5A5A9qzaZTIFVMd82qh6zaoDRT6ORepMx6Pdtkcw58FuMDBfWAIBoq9vX4dTsk0O/t4wLAz6zEqpicZWzmEjxDdp8Gz1KD6ozHo6aQeRatbsG3OXDmFfjZ4tNkk5O0XEYceAp8PB/UUlyYTCi4v1aAt589VoQ4LbZDDBm3qtf71lVzaQCFiyYFP7Yeci7r6NMIFJEaTbg/dLigeK0L04b1fUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mldf4yAQ2arIuQ1yfb3bn/uWFZ4vIC5fQhERUvNrbH0=;
 b=bp8SaoxwyUXIAgKW7MzISVV0HmWsbbzhG1/bmf6ZmipZToaVsuxnulHV5wQMZvdjvWQZOrQB8VPYWgDbNZhj7D/BeHhys30PAtq7PrL3MJPDAOmamgEVTf3luTMPV3IeAi4r1yC/WSbS3K3RDSBVy1n/dQQW30kPLiQYWbgDZXouzAXyT3FskPANY/yZEUoVCRLdNhhKFLFW3dk1nAh4EusfIx4vXUnk5tv7Yt25YcLtRY84lvebYGRz2x1i4fQSfqhdBHIeWD7Jp6hrNJVGtNiQlbfS23zdamQhyiyJT4h1BRRKrRGdqQTz5C2uVlmNBa8X7k53iuoQOA5B2nnaIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 17:04:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 17:04:55 +0000
Date:   Wed, 26 Jul 2023 14:04:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 4/4] vfio: Support IO page table replacement
Message-ID: <ZMFSNgZgGVV4LXDC@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <182b79f3838f84f220ede6089a0326b6f3f44acf.1690226015.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182b79f3838f84f220ede6089a0326b6f3f44acf.1690226015.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:208:23c::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: e58e757b-627b-4fe9-aa0d-08db8dfa6f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x7rJqb0CdM5fOcvjxJotgyUYyDr1JkcnyPolPy8ToefgUjmiSTowZHJhJC0v/RuWz7ZxC8Yw7qPmOOUYpfqKB683pzB6B4zxohCsI7XrnVs1BeA+7WiMDkrfmyP704XIgtQsxV3m/wee8dhvpi94YAV+THGXAoQJTGIRlFmoM6xkD3/4y8N9ju3z03/P/rmG7465pZeE7/4QZw1zZPb073EKZTzZiFVa7xo/BZ2G2HK8zjyqFbTw07CIQffTDfwINiN4g8EBfGdHg01TWJzjjUko7+sU22rQNwmqOGt3I1dqNbg7md42ijmE6WjrAVvZaGXIAlJAktTKuzjfNzAFD9/KO0VnEXQ3t/uHGrDjMcJ69/x5jiVBZ+sDoKDxgjStXVepyviAMhg50Ii7OlsB5wHO7yMQIkPiGNw7/Rb4JX1kCSTgTxdLLdKeq3SNSixReJaHQYoxOjiUFpvRCmPnBhEHqLZpGyHV6rs35eKUiPpPL17vE4CGJ+sCf6pzmiTPZhk4ZK/gBqOV6NPqm17/4v/pI4yeKy7iPr9gF8bFS4+YHIhKfzWPPlga+a7YeLT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(36756003)(86362001)(2906002)(4744005)(37006003)(478600001)(38100700002)(83380400001)(26005)(186003)(6506007)(2616005)(8676002)(6512007)(5660300002)(6862004)(6486002)(41300700001)(7416002)(4326008)(316002)(6636002)(66556008)(8936002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOt0tT8ze3Xyfn3SXYU8bjnNgtTUtFzgbBVRg3yKyK2HZxgL0XVmjw0/Y4l/?=
 =?us-ascii?Q?EFg7OI9xBTfyIf06Lfw6bFPURdY/ZAe6t0maLrQIRlTMlHFNOL1veVA7nHx3?=
 =?us-ascii?Q?IC7jl4QAvoIkpWGkckL36cCOBHpuiZKNJtkpSjFy8khYOcH10NrgCeFahJQ/?=
 =?us-ascii?Q?UHiqf/sxzkOBLEHEkXbZ5SMhDC16WDGylnYrC1Vkonb00qG/mod70Aw9bXd6?=
 =?us-ascii?Q?c+j3MoIXk6heR4m53qkdrMLhm55avjYlP4FilM/Ec+Txnb5E1IO5ODsAJ5wL?=
 =?us-ascii?Q?2Uiiu1YlIu/7rLK+GqGI+NRBVYNgEkhFdKAR0n2oGdedGvSEloxjFmzWeCcu?=
 =?us-ascii?Q?aZYahjYY8r01IJJPlKjHXb94KWOmZmd//P3seyvXTsxpwgvZD2JYTT5Hoqc2?=
 =?us-ascii?Q?OthCdUZs9yRfza/U9jgcJyzdhaOZNmjxnYY5OOCnOx9aBYNEZoiNDfufSQD+?=
 =?us-ascii?Q?DVXLapeYidWk8yNDxu0p0W2KRyw3912pC+N2szvGPPUEMz1qIBdtRf1lb/jW?=
 =?us-ascii?Q?N3u4T7JwHJmzC/fpGA+CoTHtsgmRGsJD9fQy7ZQdhDbQb6XMHi2LAAvznhaw?=
 =?us-ascii?Q?Lu8c7QczSHP5H94U2Upgv7xwwnzk1lMRcp+IeW0+nBIg0fx+x51iFHdd1jk+?=
 =?us-ascii?Q?74M7LX42ow83YrGRCDyb9qefKuXFckFzdAksG40M9aSZZZeCjc8Vv9I7mIEp?=
 =?us-ascii?Q?3vTJ8oqstRNSuOQl+dduyWVgf7uSOaEr18yn7keOVefj0NklKVLwZYdF2+Is?=
 =?us-ascii?Q?Tql3+QvoAfzwapIwVN7wbuOKhj9NDougXR7n79J4Zc3tKa4CZOzMeaVbLaGH?=
 =?us-ascii?Q?qNKzMuK1IkVjdT1XEwSOiptOiCia63uVFWbI4usJ5YRa/C65gpzbMGK66KqG?=
 =?us-ascii?Q?xr+XFYGNhLfaxdx2CkMJr+NsZuE4KPbquRlGnYVagpyTGT7ctRaxD47ZRVzS?=
 =?us-ascii?Q?rYVEpBajNJ6Ic8G3UmZ1b1OUIiDXFuMY8HGZlrKVKgCAvMy3/omkisCRKcbu?=
 =?us-ascii?Q?QnPPt7vYNYPtbHhLh0aczRChD63v/5gpD+latl9JLzl4lGkpGnLR3j6joW8e?=
 =?us-ascii?Q?B5S/1DtjNVkHg+muFum+fdH7WRN+u4eTdtMHnQEl5IK7s4cxOFL7JlZBPIjV?=
 =?us-ascii?Q?dthvF3kpAXsypHNQDfiVYaaP9CJJI6kZFoS8+3zcsJQeGnpgWUXNCrFokBvA?=
 =?us-ascii?Q?PqNbNHc0NTaKhcpSShO+vG09Lg7NAiX8kLd5wkwCYFXQBLxiZ1zudPtip3rz?=
 =?us-ascii?Q?ZOuh8z0ZPL0QPDExBY5EEJ3/wkfNqZSD415Xj8/Vbc9W4OdlLs5OXI+ygsAx?=
 =?us-ascii?Q?92+UZmH4l5JP75llk49bBHlk5MSHuHd1YiIr28Ywc91TBTo7phXN0Ln9tnbN?=
 =?us-ascii?Q?OgVpZQt7Q20GxAGw1zlQr/qI5QDw8ULE7n7N5y9E2oZx+2YQS9x//0KgvXjl?=
 =?us-ascii?Q?2DQL5dCTe/Tt9DrELHQHV94lwg04L7xm0emBkaryQzDLaDH43NS+hMdEeS8s?=
 =?us-ascii?Q?OnwVBs0q+6bj8Lul+osxZ5Y0JMrCvzFBm7I4E4tyogF8Kv2YCBqruSTp5nYe?=
 =?us-ascii?Q?1/n/tQ+owTpP+pNvHEvi5Q9cNidJdTOM6OVM5y3/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58e757b-627b-4fe9-aa0d-08db8dfa6f42
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:04:55.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae/0RwLHBJjJHiffRzirBiGQ6RraNXgLlCzClUocZN/z7hhy7Ok8/DZJhCD64RsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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

On Mon, Jul 24, 2023 at 12:47:07PM -0700, Nicolin Chen wrote:
> Now both the physical path and the emulated path should support an IO page
> table replacement. Call iommufd_device_replace/iommufd_access_replace(),
> when vdev->iommufd_attached is true.
> 
> Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/iommufd.c    | 11 ++++++-----
>  include/uapi/linux/vfio.h |  6 ++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
