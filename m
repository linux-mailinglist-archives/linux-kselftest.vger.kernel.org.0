Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ABA620518
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiKHAth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiKHAtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCF2228F;
        Mon,  7 Nov 2022 16:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/gzhV1YzQcBHQWeovaEqFISPam/zrGcBTToIJr6RJ6z+UXf6frwGvAW0vqqSxIglFJSEzBxqgS6OJ5ooWNiOUFqNrfn/I7c6+/d3RlsR5rtR8rTwImwtp0LpUufzDaFlbRh27dIzkIJM1Mb745bFuwsFmoFZi6RwCpwpElr0AOmBeQn30vbKK8V6ZsK/7Wb6u/W4yfp9uIjhLBRDGBYKEH9CV4e9SUcuR1J5AS49LDWeWiQqJ5Pta0Vkp01HmWjzCrw1dqFjjr7VJtVDEe+i7TH+prV3wUnMGBgxNEzdIEZ/AmkqMyxKTHtOxYgkz3XGYfPWU5UKVnVV26zcojVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTJTaYVI0lUakPXpPEfg7RRE1GqA225EF/K0M2C+vmA=;
 b=jvSSdlb/ZVPuuhyAvT/7QgZLWgKkHIVfnvRkneGHEBfGxOsatp3o+6ViB2L6sOWPQvXkn6jKRutrNxeOnjD9ad90fluGbcz6DO/MEKTvG/zj4Jq+aUgGm2n7vqcbJ0FTz/mcA+h5qAsUY+F4oGkMGQmGC2jCZMOWNoOAwwmsP6hgeuuYkbsfbrMSmmYDIX14znn/Y9uRBA8utUrC/34guVggnkHZxunvKnf548cRerx3+1rELga7TbqYH4QCQYFFMthAGizucHjkbco4AOGC4xRyPhPjJalvUP0WNmUK9Za1Onxo/Q9j4SIhYoDmfZLg2xQ3bHdOWbJ1EgnIIJOqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTJTaYVI0lUakPXpPEfg7RRE1GqA225EF/K0M2C+vmA=;
 b=tHIrFvU8aZ6WUygvPuMF/lQWUEPmNDCI8sifxpZSSoTJRJAgL3MukCrDlSu5uWTPzCGSH0rTefnS13avZFSlsJzRTX7MuZXbthALsUA/Tpq3KbgpW2mit9qfj7MlAkT4f+U4BaE/BmAM7Oaa4DUkwocKucRdkg0l1gzmOczN4ZS7AH2IOftiVWCsY5ZEzYaB8SrP05Cy1NIUegj3BYofAfCg9zfNxF4LIVc+S1oqTsZrfeNFMiynkQa2Okj8okFtK0WYh1oA/t2oRMsQXlUrVarWpL8zw4TiHbeMhMJgjV0drzf4TGTLfmfXJLAuUWCEp/xPRVfJQgtiKHb7PHqaJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: [PATCH v4 06/17] kernel/user: Allow user::locked_vm to be usable for iommufd
Date:   Mon,  7 Nov 2022 20:48:59 -0400
Message-Id: <6-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:208:15e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dd690d-aa81-4b97-c2d6-08dac1230dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71pMDsI2GcyhqnDgmPANpezFzylQHPsQwa4FZ+3t8rbQby9fZVrLLeQEVUl3UAgQMZ6g5Tnunx61NLmpjyHeSGpRnNikfnEpGz5sq0vtDT4hTqFaJe8tGsPWqTQmWBe12fdupAkWr1FOBu0xkIVMNC9SLZqIndK71UGwhBH/ONfkMHh+yy/M3BVjfxOmkZ1jfJMjBywoA96ZW2/Ihs7kSr1WKhqMyUpGWzL80k3SLrukTb5pCf5lKjK8jfLHkgI+DRQ5ueyreKKcan0eF5YySJujHuTcgQidS+kBuyLZKCu4IT4UHKBrHJgKgobLdEAmXkhcOFDu/c5HhcfPmvirEwFO1p2fbnCiAXP7PmIPUhkL8DVGE04fxVNJe3xrrgnYll7GSzWE+k6GSjjFqCbYtCzO36iqFgifazg3sRo/iJMoQ6HiIrXI2SuK21lhs3utK1D+frbZI8VbQlkKAj2fYJLOyzlszcVhkHb64fi868wUvQh9ibZc0ykbts9dScDyGxZMwI49Q8lQfTlxyhkxkGiR1KXjvAH9BdrgUVkQEdG0vPOzkGsNY0Zk0ehvnDVHD3P771dQAmv5Ua1ks1kj8rMXdML8bYfV0hPKpa6r7WV1mrq7ksi4Nj1USrOFyghUdRdmv1EEK13f+h6KrxW55+M7NDopAvcOyDY0uD7Bte4Jo6lEhSZuyfErTBEgXaIy5QzF0x7E2BdYEXT7nvWhC90EU2ya+x2GQwype1G0OqnxnZHwavic3fbYU/NGB/v3RUNLQbCwOYQ7GUDd2auFTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RBK56VKcbsQxtpLW2ETwdHf57s047qxtU6RoMVtEbaFTFBsj6woOc4pMQAO?=
 =?us-ascii?Q?Ufx4GbOZ6mf6vcCrlnyW1fJqFvka/06d8ZHZ0sPgYjpu0NJ8gKuFoT4Lkyrp?=
 =?us-ascii?Q?bXXr1nGH8nSy1N50IQ18a20RFD7H43Oq+LXpZSC2cMwQZMhcZ8aVlaJrjFlz?=
 =?us-ascii?Q?ieC/t+c80dXYtezh8TK5zZmVcZ+sfQ6YCzXAnIvIjxmjpy5psGllmyRuGgkb?=
 =?us-ascii?Q?3Y8ovEPZ9YIK34TmREeTt7PZtPVp7GzmNt+Ffut8qyupob50ZSeQFONkEmmC?=
 =?us-ascii?Q?X3WSScQZte0bkem0qEpopDYX4dFnGyohMjwZ2+6kMs4vZmZcNo0e4D/xPNLJ?=
 =?us-ascii?Q?koPecKbvRvhW1ZcL6vDwHwsDlwX6TE9Y2zYXcTdHuftgoRP8/26VyiiMXc2T?=
 =?us-ascii?Q?KxsnQDNvH13ZXpEmLe5Hii2VHRpnMtmFb60vwighI0udYUkpv9EBEgzuzvla?=
 =?us-ascii?Q?s3y8ktN/MDibNJ1QG6bSejr/DMWazN1Y0aSVrmbIHWPsHzX2eL05y+WVsHMG?=
 =?us-ascii?Q?pl0kRy1hoalU1JagOgaFMT11/0qI9gWHzIgy0PLvs0TtIXhTAYnO+l2tulir?=
 =?us-ascii?Q?2UUPo0XogM9WSG6bFsaEWnLwUOYWERPOwQvdK9DxZ4/qdwUAmtYHorqSDKHd?=
 =?us-ascii?Q?3QjPpE35intchtJf68s0DVMH9hBfihUHIldIC3BR0cponZ2DG+ck+F1cCeKP?=
 =?us-ascii?Q?OImb2lE5HxqzLFqouf9T/6po7rW5D2p9M0SEyuDu6wrgHxR6WruTPvc2aOBj?=
 =?us-ascii?Q?uxIHIVcXDhjrGwOq5bLe705ZSK+tz0aCtkZe5PXTXDA1MyANgyn1Hp1hSJ+G?=
 =?us-ascii?Q?LdENQhixRkB0HkSrzi26nQGGDiqvmqjsrclvQUvcbm4X6V6R9NyscsVzx9IY?=
 =?us-ascii?Q?CouyJ1qsLn66/P7UgVCp2lSUPYahahGcM29RhzBNNIrUmPWinWoPJbEpViw+?=
 =?us-ascii?Q?I60z0uTNR15ZQIjK3gT1QFtF3unKCOBnhoKsA4FX2g5AjvsO+mB01b6+5Nbm?=
 =?us-ascii?Q?bTK4WZuHKGLr+BxBmhpUQU2fRlIX68wdpaWVd9z8bAES7Mbca0x2wCS4zjE2?=
 =?us-ascii?Q?pbzSPZEx6KGchlzejJ0xSMyAFcHg/JzMpqRd3IPV5F0eIG2DnZgEMKtH5tFC?=
 =?us-ascii?Q?869HLKgtuLhPMI6gfEiWotOL71rER1M9iFBXEGqt8tsRAdQe15REyJVMrNTj?=
 =?us-ascii?Q?J4ECr7+cnm4o4OoCOPU2j+jkHF1Fo36/WEkNfpn6x/VGLeoXB6LNDm/Oq/fM?=
 =?us-ascii?Q?XdHuJdG5+/sS23WTWl6csAcrss4d/aHK+vo5kMCu/ztH383jclhqDV4lpUCr?=
 =?us-ascii?Q?805NwFUO3aXBDjZUVbm9eaVCBcbJ8es/7l4OHUIEoiJseL2RDVy+CJOH8fRt?=
 =?us-ascii?Q?Qw81drxP6WXyju2Kzts1ZWoYHXhnTtalIATr6dxIr3+tIPtqwQtqK68rltbw?=
 =?us-ascii?Q?CVgBP1XMENbTIjUGM7wTch68iybYGfK5DVvumRKQXR30YGMFcUNgY9x2vnCP?=
 =?us-ascii?Q?TlnI5e6AjpkxCOCS9Qnh3t+sDLdVtqwXhvRSpchj7gX9ls+htKcipf6TJ/P7?=
 =?us-ascii?Q?pnjQXceOrxwPhdR/B/Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dd690d-aa81-4b97-c2d6-08dac1230dab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:12.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48oSQCX3UesDYM/S6gArL2+n0sP7X7k/9/j9RhFaAkpp6o8d56QJU4tveMF3CJ7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
2.38.1

