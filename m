Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B860D331
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJYSMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiJYSMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A0AB5FC0;
        Tue, 25 Oct 2022 11:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrrVBzgxyrB0SQ+NMuHpclOZyC7k8Cq/6CSN00oCOWJSwbHVFcsoI/HnvmPZU+m/BA+UwRImh/54zZlw1q8AxA2oNX65tdip2X0CoxHTzPBmibKT1nye+QErKmujUH+XPoaU7slk1ffWMIPdU1qTB5dXiEsfhzbHCILqk+antGNqwyYs2/KkemgpXH2wl7fU4/OohTxMb4XT7XtW+5o5cwhi8w9W+eOK4JWRBAeVARq5loE5JJMEq63HyvPhmQ+78FKgtPV2/q9jjS6GuNnwSs+Ql/B+OE3RZqHnJUeIJRIZNG0HeJipCIGnyPtHrXcMw6x7qc6hyHsUu9crR0pB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssNLW6WIjdo8BK3ssiRjC4j7bSywGnmUSiIk+8z+AcE=;
 b=go2LASC5zXULEZzS2hNL9ueYTHy6YB3HGCkA5lco2sfoXIB2fxaU8hvgXx518DorX970SJ7IOqWKH5h0MOoRLhviUwKBD0n72lkO8X1qCKtnviOC0nkmWUIogec6OcBMCxXSsW8TBEuQ8yzX15HCp3oq8c4uK1YzD3NtOTTr4Xy22rkd2B0vzckb1ooExkDHwD/fWajIN3Vy9rrJUk+NchTpZSi1tXrtYgSgc6wjZgxJZNZbAc7BLo/HlFUuEvAvszkZrat5ZcosHO6xOaYduuUko08u8+jLdiNVRMCSn5wIpaQ5OQp2ESmxt8rilTnm6xlYneKFPvkNAVEI5Jx8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssNLW6WIjdo8BK3ssiRjC4j7bSywGnmUSiIk+8z+AcE=;
 b=ecGGZ4U+XTsPE3K6mdkQPH1ItxTgWsk57M/tnbcJuLSoqOIk8BvbrzNySSn2vCLqorSzyokLAOOBO2wOw+oPFRLW40Kojf5swMTDm1cw2rTHfB8tQALheSNGxlx3CxRMd7qlYxr0TC7StbzdJBUDQL3dAk8C61NKoj1of3SBRXrRyqu22E2R0XIRyBsIXKY+VYE8no15vac7BWOtUtHMVDXSBvnRjiwioJfkkrGbvhpzY+bf/AF9jPZZ+us7OlvTV5/8hQ3VdaIngoZZADtLLvbsty3EX+XXtZuGDdElooV0S0m354mf7vJIKSqrEOkuF48D0hazbrb4KXmSm71XLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v3 06/15] kernel/user: Allow user::locked_vm to be usable for iommufd
Date:   Tue, 25 Oct 2022 15:12:15 -0300
Message-Id: <6-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a00e902-b524-4620-2b54-08dab6b47911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hINN//2tgFJm+sb7hbOnDly5bdV9SeLx8myyxMbJYlwnlqwygcERFyt9gCwVoLKVdzdEwKJDhFuKibWRxV1+R2Ll7qJI5AbzRJaKX7Gw+YdS3PEe3zZYxX4eecmtS60mis2VLFMhvLtsazXej5Y8hc5F4+KccJNNc5zBad5zMHpIsNJKp4NF/AMDFV2DGoftNsTu/tN335mBfXpkP1jQip3xGQND0niABOQ41yHMn+faHDVxDfr3+/K67iSA6idjVLm0Kp/kDldyCNc1LLGWyQuo/6Bm93g9GKqtdy/wT2KQZ0ls2vMZ66blPnKC2o8iRmSER2YtmhEE5u1ltgjlo6HQAwiTWmuSLtcbVh0vZNVlmE4OhEmcW/0OXvewbwBpqtfzFCSF+32JySC/XMhy4CXzvrWP3mAYFXRp0bM/2cLVb+8GJ7vzV4oL9RntHHW9qLrfNQOBN4l8qTt6OWQDnpbfSvhN0e9cW27N/Qxi9BJkdIx+fRTZ1dmqCRu1EIngg3GZe8ABzIZZxJ0cSSpkDt+tC49L9DmxTEbiw+dewvoXgfg3uFD8Jf14+6a8nzA+ZzIOhNt39Q5/Hhz028CO4cu/D0nDlklpqf/mI3CY4WkeU9WrqCnQ3B7mEu5waxDce5Zfs7ssgyFoTCM5HX3fb8c3xOfZT/UPI3L8g9sDil6pgJv5fdD/KpK0mYTCJO8KNDcNWpZBpN7VCOA/413aaDVKVlMIMvo44FBdytegMMY4aTAc7OPJfUIV0Fu748+FWtEAd4AW/p3ZNWbuG1g5kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(86362001)(83380400001)(6486002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7py7ddWGpwxz8Lbn6izgW1Cr67d3iF8Z26/ORWyTE0rwcmq5V86tKVnsAyYV?=
 =?us-ascii?Q?8gMDi7gnZMXe4O3wM4YkHaAaORb5rTm6jt8LnBAkTo81dZZ/4htzbQ5kVGzf?=
 =?us-ascii?Q?K38ROGmEMlAcQBE4j4Q0CfAi35Jm11+b7+L9s6elmcSv/D2DW2f+GR0wbfDM?=
 =?us-ascii?Q?di1f3G39ZOQonV0bcurClsqmE64uK+MGnH4oUv8s3m7sZpLW/RGDT78NF/eh?=
 =?us-ascii?Q?1D6dMNe0TV2cbwwgar5j98VkWLlZMH9hSBKK6tj7i5pDORafTPguexRFyjYN?=
 =?us-ascii?Q?rR/eBFB5Gq0cHBUtWL/zsoWt6qti3JWahidGTkQ5RFhQrMgZ4KzUU1VpXOt6?=
 =?us-ascii?Q?2zmQxBwauFED6Xz7kjqgFZ47VFMP32d+tWa6Asse7LwG/MKI0F8aux1repJZ?=
 =?us-ascii?Q?kyWwcNB3b8vqpqAR82xO7GNEt+PqRiHRUYQNdRrAW4GeUZSnZgBh9aOF7Diz?=
 =?us-ascii?Q?3EsGaw5KvwFAJ1fKHq5UjW+pYUDwQKYCbhxMZkY21Aw32lwKj+B8XwOtZuCB?=
 =?us-ascii?Q?yhXZ63CZSrQkP2xESY2tUCBtXa3qPSm1OcXjgbH6VlVE0VKiLiGgDSIGHvMH?=
 =?us-ascii?Q?sOfGDRIJkTPaTJVBrt01GOgIXNWTDmnDCknNHIL9vPTSQRkFSDBu1xnBvOnA?=
 =?us-ascii?Q?i9Em0oFEzfirJkj9TAMZXmFW4xsXB1+OwzJLe1YzRKav2VbLRJjUroVBL1dH?=
 =?us-ascii?Q?1vK0LSjOEuMNamb0cM8SozIqkgjHIX44czPE62SGiw9FGJGozUy2jEpTZw8D?=
 =?us-ascii?Q?3VqywZIXM1uqZJbj79clRkD917aXc0kbU4j4Z8ecy3gUuROGMnIwlwbSaTj+?=
 =?us-ascii?Q?LA7bzPjPTK0MJxwNvbuyxcn6C79PYCJxaGEkzGtI5Ky5ZEoYlNmW3wBN5JcV?=
 =?us-ascii?Q?JDUBX/hXlcTtTPnHOUGoNDKhfU6lLE2MewMpmjV9ayY5Cci/I5u6RDmwJEYZ?=
 =?us-ascii?Q?0pVJ+mK9qPft0oAUVFuP6hVJPxb5f+HHHo/PaDRHCqOxaEWxn/qRIYStPGNB?=
 =?us-ascii?Q?2x07lw+JLtUOgQZYzjQHALf7mmTh2kXjXwO/M87I5p9yyKLcZAkJ5RvXSMg8?=
 =?us-ascii?Q?tfyWCBjux4NSklm5sq77dgXaOXYge9PBWAD/YBx/KwBlp1lxAmonfJqIY2lM?=
 =?us-ascii?Q?87bewC0hv6SxzOOsT6tdzII3CQvjkbdlgaNwmYMj1mgfbz/dA8tZWohKOODy?=
 =?us-ascii?Q?3LMwvxUsHMG+uHfiaUjnbCvU1b+dnqgAQJ7h/p3I3Z22lLveddZaOhRF5ZhR?=
 =?us-ascii?Q?A1eLpFWz+IneV6FhLUF5N6GiRhYa6xWd7IM1jtctHWWhfe5sJ3tOlduW9VdW?=
 =?us-ascii?Q?OANkk0IxPXtCP3veOpmuxbaL4vdiNO5RhkLVDUebxqbRIBERPC9MgUJbBXfX?=
 =?us-ascii?Q?XeCP+H85Jf9J2zWGvFa22NsFEsQBuMBFsmmQ2AgJXsXLybUtLzvkcbrOhUAj?=
 =?us-ascii?Q?v+R51jC9t+08trd5CH57fi67QgWTJzgK+8EItGAaJQerpAhNKUpEiryQA/CA?=
 =?us-ascii?Q?eshQ8CpEsPNe6JfiWZNfpp30/ObwJ/nxDOQ/sG91v+oznjXPwpo+0deQjqFd?=
 =?us-ascii?Q?SS7ukeWL4EBeREQPgHE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a00e902-b524-4620-2b54-08dab6b47911
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+Y20O/4/3IITIUy82SI0Nc52ptIcAbZQwNg8cUSNq4OwG1pYeIxfwjlWvkbwo5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following the pattern of io_uring, perf, skb, and bpf iommfd will use
user->locked_vm for accounting pinned pages. Ensure the value is included
in the struct and export free_uid() as iommufd is modular.

user->locked_vm is the good accounting to use for ulimit because it is
per-user, and the security sandboxing of locked pages is not supposed to
be per-process. Other places (vfio, vdpa and infiniband) have used
mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
is only per-process and inconsistent with the new FOLL_LONGTERM users in
the kernel.

Concurrent work is underway to try to put this in a cgroup, so everything
can be consistent and the kernel can provide a FOLL_LONGTERM limit that
actually provides security.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/sched/user.h | 2 +-
 kernel/user.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index f054d0360a7533..4cc52698e214e2 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -25,7 +25,7 @@ struct user_struct {
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
 	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
-	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
+	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
 	atomic_long_t locked_vm;
 #endif
 #ifdef CONFIG_WATCH_QUEUE
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539a7..d667debeafd609 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
 	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
 		free_user(up, flags);
 }
+EXPORT_SYMBOL_GPL(free_uid);
 
 struct user_struct *alloc_uid(kuid_t uid)
 {
-- 
2.38.0

