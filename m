Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AA6204FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiKHAtX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiKHAtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2218.outbound.protection.outlook.com [52.100.155.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6D2528F;
        Mon,  7 Nov 2022 16:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBivI2ZOzDZ4RAeNUiUhvDa9NY+wclgDdx1P+/YMZWdjd1WeOp5xgULa7Y3pbOvVZHIH+mocgmJzJd6VwblD8BYnIHYs6YTr+KbwuglVIw45zYGJRceT5xPoyMsoxaYaQRUkyqM1FPZ2a4/j9xOeNRoQLcB7uEXtRFJFyTk+DAj1QpVrrBQl3LwTLeo2F0h1jk+pYcx/NSqJTmOfbnMFlq0442Hmyp0H/PmskFkqO1ZDx1c7VrIqNTYYWTzsEGKRJlbQw63r/HabWfHNW0a0fTjR71VOyfPcv/vfZAK8PIV/8y30SA9bFSZK6JuDr2etmQkX/JR3GeWhD32vbn4tRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vj3CQOvGSipB/xMomnlk1QFGDRvPeOXM4z+ycmEGpI=;
 b=f+gh1YbXtxqUye/i9t+GOkSWSb1xc0/XtB+NNkxRUVvdidQ7+YvcZgunwQwEk8WK0gVYESG0u1A5U9f27oKB+YW4agBBXjMdCEd9MxKh0GWyyleQpxNMv1ZvgAaKjg8qVmyjn2HR2yNlCzDY7bT/nEX5II/J/HBe4WBWa1XtPA34GXxi9kfKT8MjfNcFUkh1RVXfn0gwMY9YjKFnU6UV/o3djZstA7/zUp5L0CZPe8tCGvrfdwUyua2V5D0BejsgWDvbSJ8SsiBcadSVWUZzeUW/nNzjTM11HgcjGsprAOQThhJZI45/HnLOcJvYlh23gHXOvRbRy7Y1OvxakMVgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vj3CQOvGSipB/xMomnlk1QFGDRvPeOXM4z+ycmEGpI=;
 b=IKqRXiS5qm9e8TxACwimWUMwCqiafCkrAEL4xOdDTbUhuZtymyLt3+3LqJ3u13CmWrSY5K3dODdwTWMZebHDVjVWHM/twRRIYGNSqrpgyZOFDn7JTxvHLAnHTrtpIg6yA+JB56NOKHxqnKMRFHlWG3TGtEDJyEEwkbAHz1kBQmJn+KjUG/jRjuyNxSimvtegktYHTgrFrjRKyZGNnEn/Z0SuFoHs5k0gWJ32+jI5Rnxr2iXfdPubH4qSWpbY6o34EZ+i5Fk5GNPO+LgByuO6CcvPFgzAjTkT+LYS7MTGyJwxIDd5s3tzQmW4xP7gGetUKzpCizdB5mCuz11ev5PEYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:16 +0000
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
Subject: [PATCH v4 00/17] IOMMUFD Generic interface
Date:   Mon,  7 Nov 2022 20:48:53 -0400
Message-Id: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:208:237::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea17a1b-340e-4579-54f5-08dac1230d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VhfD/SvvQdPziGLjSGlHwPkUaO7z8bO3cMYUt4xOH15eO3T0LjjmhkmOhdBK?=
 =?us-ascii?Q?xYqHzbGatGL1SVoD2E6oNXUERlEm7rUYgNw+w3UWSNHm3S/r/PJgkGKt/+wT?=
 =?us-ascii?Q?Y+JlVSJbt1wC0rCG96/tkiLdtWh75YtoxQydOHjB5uEEMiUe+VZDGBURqKyg?=
 =?us-ascii?Q?YYtM61p4W4u/60/y9QPHpt6viC+/iDLI+ZSMqu7zDQUgB9YXxLY7vyUD5/1v?=
 =?us-ascii?Q?xzcoKUsKu+baFlXJJvW1D4vEixZ29SOelA4LCFGFEluK5C0NK3RA0O1ZdaM8?=
 =?us-ascii?Q?tJWEs68YbA0pCXNRDlm/sSoGE31SrwUVKkhFJdjk21oLH9RPdZc939vjv5LT?=
 =?us-ascii?Q?9Qd7ul396XUvIsVoqD2Il/jmnWdetL6P3HPM1vbN/Mb2xUJFgxzOlLvVQdHR?=
 =?us-ascii?Q?yqu6da4lEqjmdDPMBlUUUoV/PU4kW8CgRS+qTxBdUjx8/nC92DuQpd/G+Rjd?=
 =?us-ascii?Q?wm1k8/sFqUG4SPNTP34DX4wyUjGk1KWSw9bKKPUYJDU2dHdmUm3stE9rZc4t?=
 =?us-ascii?Q?i3ilBXPz9qnepe7UDISXQjKTV3IZyEAKFijKDtwfvq/jGFMf2JxQJvMRwml9?=
 =?us-ascii?Q?ZMYA88LSTKhqKh9vgoCs/Z/RztmiwiQQvOd9zXDdku5ZsUW1LP0tQoD+OKL9?=
 =?us-ascii?Q?BQ4mVfNSVo7fX2ETpXOUssK2zm3XVxcVYkY/U4ociumGbqdfzSYhVkhZNf/h?=
 =?us-ascii?Q?6ztgXT5KFuZHJ6iH6Wcus9LOE4gR+KKd4y6nO6oouFC2fc/M9DIw1eFtwfCN?=
 =?us-ascii?Q?ullvng2BfX6pwQajryBSeWCx7029anqcgFAMD35NXHAybjNikPcMiGR8A7a+?=
 =?us-ascii?Q?PdkyWGXmL7Cm4wdebwpe4EHRTQtpzPqkFdcCgIqjoAnHKhynPXwHJz7Jw4aK?=
 =?us-ascii?Q?W+LLHMFLHvheVOI1PLqqtEb40MKzp710w/GdYOgSMX6uFEly9ULjWQ9g/g08?=
 =?us-ascii?Q?02ciwtogzb4i8ANFeNtkop/X5RdmAaQ5HB9XuMAadPJ1Gkx4SNpElgxLLzJA?=
 =?us-ascii?Q?MiDkhPURy0KOTeeywokXQJfT00+ypSXyYyNdBfwaeJ/l4dKrT2FACQOnW2mQ?=
 =?us-ascii?Q?8QaKoPzawBfamc6UyJ4pgQy1hvAOOIMA2iruw3/AbllNDA6LEH7LuA1cZQoE?=
 =?us-ascii?Q?4xEC7IeepFRdkJ9JGZNrXSTYPhvEmUVJ8ZNf+lypdnrkmzQzS+RnML35GKIm?=
 =?us-ascii?Q?N4OYPC9Ysfdsz4Y9PvePb/8Upj/2hA/pOwSTt+kIDosSO/g/7BdaZm0NJbbH?=
 =?us-ascii?Q?N0lM4QIJFdmHzyr61L93g62K0/aqfKUnC2Ip47RC34h70+un1NADjHkOTzzQ?=
 =?us-ascii?Q?CLYcydo4NHRnOAyxM+qURc7egWRkqyxRw0hB9J/jbyiUPWwrC0z34ZekZjtC?=
 =?us-ascii?Q?qVterkM3+tpn0wpeql5ce+1ohjuooYoMu0FPLQZc2R1Q2yClBdQGcZUXZyEh?=
 =?us-ascii?Q?RfgJ4qniWQYT8nCQ8owmanrPKfXcxN/EHkGWn0GVfnFukYcfIHFjfPTtaZvz?=
 =?us-ascii?Q?3mSu6A1wNIrTv/HCMbpbQNN8I6YSK2s53zbX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(966005)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003)(4216001)(41533002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWFhTq80fDC7DtHy4K/Dl8jts8BM3o3Ask13cvsBc+qB0wOlKASA8xeHwERf?=
 =?us-ascii?Q?A2jf1JHq50Qwz6+5GFwniT0HoeshviF06bOeRnhXWep72JLNoq8B9e3el3KC?=
 =?us-ascii?Q?J6HEcUM9R77oa4A8S+O1KWxYPjM721St+TsYSWQRzvrwqn01sgQGQOVy+Keb?=
 =?us-ascii?Q?1mpCqtUCN5XloI4l9hyEvUEdqS97IQCJItOewImDq3+c5whDY8+ERb4M0MB2?=
 =?us-ascii?Q?GCCo9Iiwm8KrtIW+mGTMyJ3XiAluG/eeSd6Su3W5rvHYjMVR4HvMMak76zZV?=
 =?us-ascii?Q?w9uTLLFlZHdh+geO0Qufq0g1J3WhKZ2Flic9CD06xrGWYnd/PsULqmrl8XpQ?=
 =?us-ascii?Q?H7QoKK9f5aoEtXOGHPCJ8bVlPwsWQaCKu+/xKsput5I5KW4FcRoxqyZ9cH4k?=
 =?us-ascii?Q?BEPhjstxE9hFPno2SnkrkK0O+yaduemg8YdjG+rpPtp3leLmZUW+XjfPyXB2?=
 =?us-ascii?Q?pSgAu+FwcrDl7eaj0wlIYt+MdH1yYbiViYFGG3qhb9BrkfsFZplRIMDqjXeA?=
 =?us-ascii?Q?hgoxiG1/IkU28GE7lGqndFd7w/uMh3vFRFh9SRqjYUP5mSXqZ4snC0vAIhEP?=
 =?us-ascii?Q?FcoOnp9/ylK+OaL2p2NeVik5Gt3ONtMpyJCc/v0pW3kRmSeFn/mNwkoelKwA?=
 =?us-ascii?Q?2OqXXthkDpD1JPkKvQSY16/xuY1dF5JKSu1pDnE/RfJm2lGgFprjLbHlRJ6M?=
 =?us-ascii?Q?4d4rAGZmnx3WiXcsTYyHq0lFj5QcjmKY/Ub+nrCjDeDmShy0QzVMJlkugRA6?=
 =?us-ascii?Q?0DZvnA3ffn/s34AQNn/w3q+lXrjdVzI8rjZmtU67Q/88+lSg8TBsoEd5mnJ0?=
 =?us-ascii?Q?uLlt4qWLAjDWp9D8rUZj7Vn7fluA1wm3OGCm7seeg7EgW4sroaUV5l+S+SJR?=
 =?us-ascii?Q?8NShasEzw6IW7SkN9RAGtyD7SCTUz6BP9URrXJGobB3HVFEZPrnXRlvQEf44?=
 =?us-ascii?Q?Y7ydAZvH/zoENhUOsMTKV8K0nArr/QvknnA70a33ujeSYHhqPidinMF2qm3y?=
 =?us-ascii?Q?7wATtIPlEYGLouHDiIKqvr54rDv7Uo1sR0M4LS8iXka9Zujn6sIIArqZqLq3?=
 =?us-ascii?Q?GOfGF9RkHzLRM6jP5wOOu/xWvezhPJpTPD0ypQ5Sg7TkJhRtzCZ6v9TXj9f0?=
 =?us-ascii?Q?7atky2XYJy08u5PY8fy+a01gKrFlG6teoyril2OpLasAwDWgk9R1t0TJCj1P?=
 =?us-ascii?Q?4+q2gLvfj2X4SNQ5F9P89YwAjqG21W7zUfrrJD+IcHnl+G0pNHSVcX3QIPvp?=
 =?us-ascii?Q?i+Z27CUO9Iqldb6SAnco1UqYcWobvFteN/ubJWk4hmGM7CuBSxwvjL0BxA2R?=
 =?us-ascii?Q?Ex1hSVN7JCp6Cpab5w9O/ZJPZKg3p7FsCuKN1CYLP855H3W8x6nkhRO7gUr+?=
 =?us-ascii?Q?j3oG4LUu5zja3VSSxsbB1oNaHGAdHOIJEHrC6kUxex4AN+oImYzIWKT+hUGN?=
 =?us-ascii?Q?BBUxp08aC76sTB87p3WHqbNRn3faNP7supkxHN8UFYFcoBL+GMTD2nTmd9VT?=
 =?us-ascii?Q?4ZEo79A51ejCqC7usIFu9lkBel3RUPkYfOOYFPJvwfgwrIm6xKKkilIqFluW?=
 =?us-ascii?Q?SPJSLnvIMnjp/WH0HyI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea17a1b-340e-4579-54f5-08dac1230d58
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCWVHx1iNSGomMApJHKlTR7KmXUitnZZQqajvwilE5sIsN41yfHKMucgesvOVIUq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=2.5 required=5.0 tests=AXB_X_FF_SEZ_S,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[
This has been in linux-next for a little while now, and we've completed
the syzkaller run. 1300 hours of CPU time have been invested since the
last report with no improvement in coverage or new detections. syzkaller
coverage reached 69%(75%), and review of the misses show substantial
amounts are WARN_ON's and other debugging which are not expected to be
covered.
]

iommufd is the user API to control the IOMMU subsystem as it relates to
managing IO page tables that point at user space memory.

It takes over from drivers/vfio/vfio_iommu_type1.c (aka the VFIO
container) which is the VFIO specific interface for a similar idea.

We see a broad need for extended features, some being highly IOMMU device
specific:
 - Binding iommu_domain's to PASID/SSID
 - Userspace IO page tables, for ARM, x86 and S390
 - Kernel bypassed invalidation of user page tables
 - Re-use of the KVM page table in the IOMMU
 - Dirty page tracking in the IOMMU
 - Runtime Increase/Decrease of IOPTE size
 - PRI support with faults resolved in userspace

Many of these HW features exist to support VM use cases - for instance the
combination of PASID, PRI and Userspace IO Page Tables allows an
implementation of DMA Shared Virtual Addressing (vSVA) within a
guest. Dirty tracking enables VM live migration with SRIOV devices and
PASID support allow creating "scalable IOV" devices, among other things.

As these features are fundamental to a VM platform they need to be
uniformly exposed to all the driver families that do DMA into VMs, which
is currently VFIO and VDPA.

The pre-v1 series proposed re-using the VFIO type 1 data structure,
however it was suggested that if we are doing this big update then we
should also come with an improved data structure that solves the
limitations that VFIO type1 has. Notably this addresses:

 - Multiple IOAS/'containers' and multiple domains inside a single FD

 - Single-pin operation no matter how many domains and containers use
   a page

 - A fine grained locking scheme supporting user managed concurrency for
   multi-threaded map/unmap

 - A pre-registration mechanism to optimize vIOMMU use cases by
   pre-pinning pages

 - Extended ioctl API that can manage these new objects and exposes
   domains directly to user space

 - domains are sharable between subsystems, eg VFIO and VDPA

The bulk of this code is a new data structure design to track how the
IOVAs are mapped to PFNs.

iommufd intends to be general and consumable by any driver that wants to
DMA to userspace. From a driver perspective it can largely be dropped in
in-place of iommu_attach_device() and provides a uniform full feature set
to all consumers.

As this is a larger project this series is the first step. This series
provides the iommfd "generic interface" which is designed to be suitable
for applications like DPDK and VMM flows that are not optimized to
specific HW scenarios. It is close to being a drop in replacement for the
existing VFIO type 1 and supports existing qemu based VM flows.

Several follow-on series are being prepared:

- Patches integrating with qemu in native mode:
  https://github.com/yiliu1765/qemu/commits/qemu-iommufd-6.0-rc2

- A completed integration with VFIO now exists that covers "emulated" mdev
  use cases now, and can pass testing with qemu/etc in compatability mode:
  https://github.com/jgunthorpe/linux/commits/vfio_iommufd

- A draft providing system iommu dirty tracking on top of iommufd,
  including iommu driver implementations:
  https://github.com/jpemartins/linux/commits/x86-iommufd

  This pairs with patches for providing a similar API to support VFIO-device
  tracking to give a complete vfio solution:
  https://lore.kernel.org/kvm/20220901093853.60194-1-yishaih@nvidia.com/

- Userspace page tables aka 'nested translation' for ARM and Intel iommu
  drivers:
  https://github.com/nicolinc/iommufd/commits/iommufd_nesting

- "device centric" vfio series to expose the vfio_device FD directly as a
  normal cdev, and provide an extended API allowing dynamically changing
  the IOAS binding:
  https://github.com/yiliu1765/iommufd/commits/iommufd-v6.0-rc2-nesting-0901

- Drafts for PASID and PRI interfaces are included above as well

Overall enough work is done now to show the merit of the new API design
and at least draft solutions to many of the main problems.

Several people have contributed directly to this work: Eric Auger, Joao
Martins, Kevin Tian, Lu Baolu, Nicolin Chen, Yi L Liu. Many more have
participated in the discussions that lead here, and provided ideas. Thanks
to all!

The v1/v2 iommufd series has been used to guide a large amount of preparatory
work that has now been merged. The general theme is to organize things in
a way that makes injecting iommufd natural:

 - VFIO live migration support with mlx5 and hisi_acc drivers.
   These series need a dirty tracking solution to be really usable.
   https://lore.kernel.org/kvm/20220224142024.147653-1-yishaih@nvidia.com/
   https://lore.kernel.org/kvm/20220308184902.2242-1-shameerali.kolothum.thodi@huawei.com/

 - Significantly rework the VFIO gvt mdev and remove struct
   mdev_parent_ops
   https://lore.kernel.org/lkml/20220411141403.86980-1-hch@lst.de/

 - Rework how PCIe no-snoop blocking works
   https://lore.kernel.org/kvm/0-v3-2cf356649677+a32-intel_no_snoop_jgg@nvidia.com/

 - Consolidate dma ownership into the iommu core code
   https://lore.kernel.org/linux-iommu/20220418005000.897664-1-baolu.lu@linux.intel.com/

 - Make all vfio driver interfaces use struct vfio_device consistently
   https://lore.kernel.org/kvm/0-v4-8045e76bf00b+13d-vfio_mdev_no_group_jgg@nvidia.com/

 - Remove the vfio_group from the kvm/vfio interface
   https://lore.kernel.org/kvm/0-v3-f7729924a7ea+25e33-vfio_kvm_no_group_jgg@nvidia.com/

 - Simplify locking in vfio
   https://lore.kernel.org/kvm/0-v2-d035a1842d81+1bf-vfio_group_locking_jgg@nvidia.com/

 - Remove the vfio notifiter scheme that faces drivers
   https://lore.kernel.org/kvm/0-v4-681e038e30fd+78-vfio_unmap_notif_jgg@nvidia.com/

 - Improve the driver facing API for vfio pin/unpin pages to make the
   presence of struct page clear
   https://lore.kernel.org/kvm/20220723020256.30081-1-nicolinc@nvidia.com/

 - Clean up in the Intel IOMMU driver
   https://lore.kernel.org/linux-iommu/20220301020159.633356-1-baolu.lu@linux.intel.com/
   https://lore.kernel.org/linux-iommu/20220510023407.2759143-1-baolu.lu@linux.intel.com/
   https://lore.kernel.org/linux-iommu/20220514014322.2927339-1-baolu.lu@linux.intel.com/
   https://lore.kernel.org/linux-iommu/20220706025524.2904370-1-baolu.lu@linux.intel.com/
   https://lore.kernel.org/linux-iommu/20220702015610.2849494-1-baolu.lu@linux.intel.com/

 - Rework s390 vfio drivers
   https://lore.kernel.org/kvm/20220707135737.720765-1-farman@linux.ibm.com/

 - Normalize vfio ioctl handling
   https://lore.kernel.org/kvm/0-v2-0f9e632d54fb+d6-vfio_ioctl_split_jgg@nvidia.com/

 - VFIO API for dirty tracking (aka dma logging) managed inside a PCI
   device, with mlx5 implementation
   https://lore.kernel.org/kvm/20220901093853.60194-1-yishaih@nvidia.com

 - Introduce a struct device sysfs presence for struct vfio_device
   https://lore.kernel.org/kvm/20220901143747.32858-1-kevin.tian@intel.com/

 - Complete restructuring the vfio mdev model
   https://lore.kernel.org/kvm/20220822062208.152745-1-hch@lst.de/

 - Isolate VFIO container code in preperation for iommufd to provide an
   alternative implementation of it all
   https://lore.kernel.org/kvm/0-v1-a805b607f1fb+17b-vfio_container_split_jgg@nvidia.com

 - Simplify and consolidate iommu_domain/device compatability checking
   https://lore.kernel.org/linux-iommu/cover.1666042872.git.nicolinc@nvidia.com/

 - Align iommu SVA support with the domain-centric model
   https://lore.kernel.org/all/20221031005917.45690-1-baolu.lu@linux.intel.com/

This is about 233 patches applied since March, thank you to everyone
involved in all this work!

Currently there are a number of supporting series still in progress:

 - DMABUF exporter support for VFIO to allow PCI P2P with VFIO
   https://lore.kernel.org/r/0-v2-472615b3877e+28f7-vfio_dma_buf_jgg@nvidia.com

 - Start to provide iommu_domain ops for POWER
   https://lore.kernel.org/all/20220714081822.3717693-1-aik@ozlabs.ru/

However, these are not necessary for this series to advance.

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd

v4:
 - Rebase to v6.1-rc3, include the iommu branch with the needed EINVAL
   patch series and also the SVA rework
 - All bug fixes and comments with no API or behavioral changes
 - gvt tests are passing again
 - Syzkaller is no longer finding issues and achieved high coverage of
   69%(75%)
 - Coverity has been run by two people
 - new "nth failure" test that systematically sweeps all error unwind paths
   looking for splats
 - All fixes noted in the mailing list
   If you sent an email and I didn't reply please ping it, I have lost it.
 - The selftest patch has been broken into three to make the additional
   modification to the main code clearer
 - The interdiff is 1.8k lines for the main code, with another 3k of
   test suite changes
v3: https://lore.kernel.org/r/0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com
 - Rebase to v6.1-rc1
 - Improve documentation
 - Use EXPORT_SYMBOL_NS
 - Fix W1, checkpatch stuff
 - Revise pages.c to resolve the FIXMEs. Create a
   interval_tree_double_span_iter which allows a simple expression of the
   previously problematic algorithms
 - Consistently use the word 'access' instead of user to refer to an
   access from an in-kernel user (eg vfio mdev)
 - Support two forms of rlimit accounting and make the vfio compatible one
   the default in compatability mode (following series)
 - Support old VFIO type1 by disabling huge pages and implementing a
   simple algorithm to split a struct iopt_area
 - Full implementation of access support, test coverage and optimizations
 - Complete COPY to be able to copy across contiguous areas. Improve
   all the algorithms around contiguous areas with a dedicated iterator
 - Functional ENFORCED_COHERENT support
 - Support multi-device groups
 - Lots of smaller changes (the interdiff is 5k lines)
v2: https://lore.kernel.org/r/0-v2-f9436d0bde78+4bb-iommufd_jgg@nvidia.com
 - Rebase to v6.0-rc3
 - Improve comments
 - Change to an iterative destruction approach to avoid cycles
 - Near rewrite of the vfio facing implementation, supported by a complete
   implementation on the vfio side
 - New IOMMU_IOAS_ALLOW_IOVAS API as discussed. Allows userspace to
   assert that ranges of IOVA must always be mappable. To be used by a VMM
   that has promised a guest a certain availability of IOVA. May help
   guide PPC's multi-window implementation.
 - Rework how unmap_iova works, user can unmap the whole ioas now
 - The no-snoop / wbinvd support is implemented
 - Bug fixes
 - Test suite improvements
 - Lots of smaller changes (the interdiff is 3k lines)
v1: https://lore.kernel.org/r/0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com

Jason Gunthorpe (15):
  iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
  interval-tree: Add a utility to iterate over spans in an interval tree
  iommufd: File descriptor, context, kconfig and makefiles
  kernel/user: Allow user::locked_vm to be usable for iommufd
  iommufd: PFN handling for iopt_pages
  iommufd: Algorithms for PFN storage
  iommufd: Data structure to provide IOVA to PFN mapping
  iommufd: IOCTLs for the io_pagetable
  iommufd: Add a HW pagetable object
  iommufd: Add kAPI toward external drivers for physical devices
  iommufd: Add kAPI toward external drivers for kernel access
  iommufd: vfio container FD ioctl compatibility
  iommufd: Add a selftest
  iommufd: Add some fault injection points
  iommufd: Add additional invariant assertions

Kevin Tian (1):
  iommufd: Document overview of iommufd

Lu Baolu (1):
  iommu: Add device-centric DMA ownership interfaces

 .clang-format                                 |    3 +
 Documentation/userspace-api/index.rst         |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 Documentation/userspace-api/iommufd.rst       |  222 ++
 MAINTAINERS                                   |   12 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/amd/iommu.c                     |    2 +
 drivers/iommu/intel/iommu.c                   |   16 +-
 drivers/iommu/iommu.c                         |  124 +-
 drivers/iommu/iommufd/Kconfig                 |   23 +
 drivers/iommu/iommufd/Makefile                |   13 +
 drivers/iommu/iommufd/device.c                |  748 +++++++
 drivers/iommu/iommufd/double_span.h           |   98 +
 drivers/iommu/iommufd/hw_pagetable.c          |   57 +
 drivers/iommu/iommufd/io_pagetable.c          | 1214 +++++++++++
 drivers/iommu/iommufd/io_pagetable.h          |  241 +++
 drivers/iommu/iommufd/ioas.c                  |  390 ++++
 drivers/iommu/iommufd/iommufd_private.h       |  307 +++
 drivers/iommu/iommufd/iommufd_test.h          |   93 +
 drivers/iommu/iommufd/main.c                  |  419 ++++
 drivers/iommu/iommufd/pages.c                 | 1884 +++++++++++++++++
 drivers/iommu/iommufd/selftest.c              |  853 ++++++++
 drivers/iommu/iommufd/vfio_compat.c           |  452 ++++
 include/linux/interval_tree.h                 |   58 +
 include/linux/iommu.h                         |   17 +
 include/linux/iommufd.h                       |  102 +
 include/linux/sched/user.h                    |    2 +-
 include/uapi/linux/iommufd.h                  |  332 +++
 kernel/user.c                                 |    1 +
 lib/Kconfig                                   |    4 +
 lib/interval_tree.c                           |  132 ++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/iommu/.gitignore      |    3 +
 tools/testing/selftests/iommu/Makefile        |   12 +
 tools/testing/selftests/iommu/config          |    2 +
 tools/testing/selftests/iommu/iommufd.c       | 1627 ++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  580 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  278 +++
 39 files changed, 10294 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/userspace-api/iommufd.rst
 create mode 100644 drivers/iommu/iommufd/Kconfig
 create mode 100644 drivers/iommu/iommufd/Makefile
 create mode 100644 drivers/iommu/iommufd/device.c
 create mode 100644 drivers/iommu/iommufd/double_span.h
 create mode 100644 drivers/iommu/iommufd/hw_pagetable.c
 create mode 100644 drivers/iommu/iommufd/io_pagetable.c
 create mode 100644 drivers/iommu/iommufd/io_pagetable.h
 create mode 100644 drivers/iommu/iommufd/ioas.c
 create mode 100644 drivers/iommu/iommufd/iommufd_private.h
 create mode 100644 drivers/iommu/iommufd/iommufd_test.h
 create mode 100644 drivers/iommu/iommufd/main.c
 create mode 100644 drivers/iommu/iommufd/pages.c
 create mode 100644 drivers/iommu/iommufd/selftest.c
 create mode 100644 drivers/iommu/iommufd/vfio_compat.c
 create mode 100644 include/linux/iommufd.h
 create mode 100644 include/uapi/linux/iommufd.h
 create mode 100644 tools/testing/selftests/iommu/.gitignore
 create mode 100644 tools/testing/selftests/iommu/Makefile
 create mode 100644 tools/testing/selftests/iommu/config
 create mode 100644 tools/testing/selftests/iommu/iommufd.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_fail_nth.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_utils.h


base-commit: 69e61edebea030f177de7a23b8d5d9b8c4a90bda
-- 
2.38.1

