Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61426C13F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCTNuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCTNtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 09:49:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B46A2;
        Mon, 20 Mar 2023 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0Y2muKcn0GCVERMwkZsW4qEuwOz6h+7GTkLgI2jETRNOU7Z4TJbOnnWwcsLaqwOZbxO/EApaONBx/62Pp6p1sZQ8mECff+QLyvWxvf/buxWp0F558Bx8BCh5zyVzlEcwzyE3uPgdFcwNfq3ggCok8KAEFy4iAxCRlWBAMz64YBhky6WsyMxly4XxQhRnvdGKYT+jmHt2b4JQi9cmBIV0imBWXkOWaOzif+/Lh8DuaC0VIegZobQBLYNv2i2xQ8tpBO1CYg2iEtJowUth4x8vGoPn275L9zzyz3p81LdQc9WYGaGkWIZdq/TZDSote8fKWZHNuyaOV66ostOADF73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leRUxllh6FDYOR5C6n8bNJh3tyqj+Vp1xLdzBo7kes0=;
 b=c5jEbZRzGBWxdIuYBkjnyV1aSYDSLPan+tvgIhqlqDpgeMn+9/hInFPaD9H6MJAUwZnPRppnRcd6VDZFTVjctQhQyUSTGC7P75p7g9FIT6aOBDXuYpMGyPGT23SxrZ7ZVQRhf7jwHOF4XL2/QvOHrO5YfVjYIhXk7bLEO40xV/U8c/mJo/g5UdhlgCj6pchni6L0CLqDT8W7I5FTZsj8gPVX3amcV3WLnvBhxT29TsNjrcWfbc0TnzE64DDC6fbG+W1yZZWJmOW8zjO3SpsWY8pELVkZagtc5GAA7pFgwDz9nmLXhtpCWVG3CGgGwii31JprJZN3kIQqQax+vdF9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leRUxllh6FDYOR5C6n8bNJh3tyqj+Vp1xLdzBo7kes0=;
 b=HdUXAsjJP5noy/jhlkVcUrQuXR6HJZGp27autRr8kvmvtkXnwor4+t6Hyp2/u/hduWK+1RsxrQo2iL84nKDVc8lQ/7BD+DKgQgMMVZYiFle1THYXrBpbhchz/AB3VoL4mHeimdTN6MeiRaWN61ctF440l1fhuSyXpBXpPxLjaYcMcgkLP+PonyLqsWCxY/2ahG3Wek3L0YiYQyFNFlMoDpFQ0SPSSAeBQcFf+E9MHk3VQnE9hmL4HjDEm0tA+LUpzlWgqZwp/Tf139kz8q57bfDgIs8Ea7SduunJmm+R50uShA94VqnvI92F3VACVaTg2SSurkHYgFUQM/+tMMkT1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:49:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:49:52 +0000
Date:   Mon, 20 Mar 2023 10:49:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Message-ID: <ZBhkf8ugXFPi8dej@nvidia.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082207.612346-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ee0951-6439-4ba0-c725-08db2949faad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeL4kdpmYd8kcoQzyXhXvEH2tLNEodhYiHZAZd7sDAHZAZsCpUi0DHjCFM2htTNsIieT/gDUzB2uumh2LPdQWfx5iRPCwm+QPeAmgY54lTdlwg/QOXcKe2Z3tTVUScivw2MbsaD82kxgEK61t0N+GWG5g6wt82Ir9nZHX7jeTJZ6lCgXa/e0fdK+jFU7eqgP1UQFzcbtK4ScL/QTZt+0UrjzIZnJ3QRp1fxkxJQ/r9+DY7CbYHNTF0kcYPJinb+YYflvBsj8N1IbYQMa2cKFzarrk8InpOSZm6qc2YTjMmRytZOcT9sSsMh7fDtnPDGjQlu9knzL63J2Ko3cT8lFqy1lqkHaBhoVo/J+NYtBS+Rdet9OyCT9ynMGQUT5PDpjfWs1Dq363NZblz4Colp8Yu2Dp6Vd5yEUiVoV20vpdlqYg8Cl/sT7yUKg5DyhLResXhG1BeAocE5vBlZPMJqMtrDeyvdtkmnYNW48AHSbZbMJBnMNIqxBznzQYP1joXrdyc0E/nq0DD3DvkiJLJ6WL8/QIFz0t62mX040nP5rCggdsIog/DMrGdhD8mz88vWhfNT6C/u1wRx9gRRe1Ic4X0mkfxabsZiBzl7OvCP2WglzZeW7vzcbAWmBvQDgxj3jUAGyKjs3TfiNPIsVmof5Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(478600001)(316002)(8936002)(6512007)(6486002)(186003)(4326008)(8676002)(6916009)(26005)(41300700001)(6506007)(5660300002)(7416002)(2616005)(2906002)(4744005)(83380400001)(38100700002)(66476007)(66556008)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8esYvIusAZwhv9R8FuTS5KDIGXutRVZ+RmjWSrG8CsYDHJJ2vxwzPwuuGBac?=
 =?us-ascii?Q?CBL3V9fx7T3s2t2ul1A1RsgHpQzyXAkBUzDKhfINsolDhLtl9+GNjKmzDfqN?=
 =?us-ascii?Q?dZ6+7Mp9NfsCiLf3dPW5d8ge1AaorG8DHLymkQz+N4ukI8k6FjsIIUM/NQtZ?=
 =?us-ascii?Q?zbxyB68ueU/O0kBntUuWlvr0qwjQEHHiPmH/yx2cHYyrdEeDoRQdmdS5siQA?=
 =?us-ascii?Q?m1rrpqnXxpdStnNfUBVxfvpowTIawr8yFfK3aa2TFShnTe/sbpuJTaI61fwu?=
 =?us-ascii?Q?2UazxTDgGe128a4uNi6hNwPW3bTF5JiHnnJ1yPB4Fa6mEuqQxpUH51jiM0OO?=
 =?us-ascii?Q?SAOxZj+YXp1ZnzLsdr9+xvM5AE/cryhSJVd7PP1RL+XESgJokUCOKXcfphH/?=
 =?us-ascii?Q?p/ZhH16AJsx4j+ssRuf7XcssbQRh36CyS9y0nUsOIp1tTlLQWMBXyIr5++Ze?=
 =?us-ascii?Q?hZrKS0PTFtyr1WeQojB22MHLxBSdkYEjsmkoa0LeypOYed8YLbKDH+/i/uJz?=
 =?us-ascii?Q?2Oxvms9HLmM1IT2Odwc4oJiXjAnz4ynrOHM8yXQ/Wnk/LquDh37nMy923RAh?=
 =?us-ascii?Q?eZ8uPQCF8r0pjjKxzeOeO/x3urf/EfLHX7TbtwUiTNRyq54Rg2R6xyEbWEem?=
 =?us-ascii?Q?7/gEWMFDPCwneq+xHTxB3Ls22++skX8M9yZzTap6r2MUO3ck03VglDCjsIza?=
 =?us-ascii?Q?XTQgGQUA5mZ8h96iuxHFrB5D3DmQOdWiUcvvjDi2qfzBr7c3J6ryvikR7ZVX?=
 =?us-ascii?Q?qeErfhX2tWOyl4zksGu2KGSKEq7WBTqpQARDOM1Ed/BtJ05dI0uMqzxbuOb9?=
 =?us-ascii?Q?AijwL3VpEDlMsLzm7KMSkCni0SutLHLoyOpJB6UXROSjqjBzhbbODQaFClkJ?=
 =?us-ascii?Q?9ZRY6a4YZaGNVoLIEgIU2SNZtyNhfHwES5FgSKjR4sVjV6QkWjMbFL7nZW4K?=
 =?us-ascii?Q?7lSL8zdjzM4bHjWqQ7uPsgBjDeI9EZUee0DM/iDRZVgeiJoXa2VNxdpm1dwm?=
 =?us-ascii?Q?Z9uHOnsLs9A7o+IX8wOucoVvE/6Ft25BG/mGqkmo5wFH4eQWsQcL4z6E06mQ?=
 =?us-ascii?Q?6YQrbBDbl4qWEh+Wl81Ps49CHiXkv8zks1dZMzyN2ySUXUo4jswlhgDlV71F?=
 =?us-ascii?Q?kod8VYGYEOEITi+ElKw0dOu1WTMEofqRXu1bSSiRwjj51ARatpawMtXD0I8b?=
 =?us-ascii?Q?gvJrXyTx9q0PET8GgIWOZkVN1D9rU4lfBpz0I71kfuShfInsP/08AujeluhE?=
 =?us-ascii?Q?HTM/QGum2Hl7I6VEiDURU/+9pY1ZEHXcDjGybmRXA48SNFNUfLRpBDafSaZg?=
 =?us-ascii?Q?30OYrOzCISmSdA79BUbXBCZN/6xiUaqELXM8bSP0bXJGQfOfEsSyQXYvEJR9?=
 =?us-ascii?Q?ymnvzh1x0U+iRBMzi4XuLsNxFFvaQYCiFD8A10IKu9wnlzXQE68zn8jBdy5q?=
 =?us-ascii?Q?K9SJL3g9EgP29XSPSXmy+m6bxjLlVhzbVnjNdL7/1iKkRmJqn0il3MCTFHzE?=
 =?us-ascii?Q?Zn7u07F5O0dHONk34bGM2iSxk63wRDjaEy1T/lxt6f02lMrDi3RHK4nB+6QI?=
 =?us-ascii?Q?reLitTwydeLmefeNluKDdpsCjNThbL6nDrCOhIMa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ee0951-6439-4ba0-c725-08db2949faad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 13:49:51.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chzK8X38j2Da18ju56C/iVeZczBLH3d0txiR4xk4hPd+NTniWsTwv8qC7aZSSG1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 12:22:03AM -0800, Yi Liu wrote:

> +struct iommu_hwpt_invalidate_intel_vtd {
> +	__u8 granularity;
> +	__u8 padding[7];
> +	__u32 flags;
> +	__u32 __reserved;
> +	__u64 addr;
> +	__u64 granule_size;
> +	__u64 nb_granules;
> +};

Is there a reason this has such a weird layout? Put the granularity in
the __reserved slot?

Consider the discussion on ARM if you prefer to use the native HW
command structure instead?

Jason
