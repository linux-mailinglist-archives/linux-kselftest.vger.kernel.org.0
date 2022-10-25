Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB960D30F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiJYSMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJYSMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2235.outbound.protection.outlook.com [52.100.165.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A88BB2752;
        Tue, 25 Oct 2022 11:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URWG3c0OOgaySNhXW7nU3D6BSf5wBeHI+P5QD43CVvnCkMf8Ips3rEpPrDoWCLq435T9uzmquXSSIEoqzIRFoOj3lXwJOCrAacAmxtjXD2UDYCBPN8JMah9oxUBFmlXDUU4DvQfrpFgum9C2AekZnh1Jj3Ja98OWILIw+gWJTsSDBAl/8wYqoJrD705qClr0kzagb20zoH1oEnRDLVbhYu2fQKgeUE+HTd0UJZElY1RH4ogzQ/+/0+zlB1dJKvXtbUbZIaR/BecREmutVfnU590uS+aMlE+f182aZtgwauxPINHKoEkV6VZLtxohZLIf6pw7Jc/j4MCZL0fnckUwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ66oSABGrHauPXfgPVtIOhEIxXg4avTNqbrnSOUqQY=;
 b=JsiE1hVuyDhharogC6Hhd9G13ZDNfsDihk1ouMSDDuCMy24wDp1BeMblXeTUnG3u8MNwXu8RKnyVLAmZpA5MrULsL/60AJ2t0xHcHveF20tmP3GXovr6CUAJNnvqmS+IBxRSzrQnOb1P3awpGC0cP8mtMHBKz6y+tF944H9D2vnedhPJsOoe1to/ydiOMlxq8pugc4rIY0fYYlLtwXFQyxHo3MRPBeh7B3gDQ5wnMnTONEkj6oDHWDb9Qvr16nkMypyQPojwOl0KlBOMHmqWo45+Bc6hVGCmYfXu0NeqHNzBc9IAwvenJLUIVNk8HHARHWzxocO8/Iyot6rwqrKD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ66oSABGrHauPXfgPVtIOhEIxXg4avTNqbrnSOUqQY=;
 b=YOSPGl4jGvK4vkM95S+tvjhNlBALBszBalup7vWNJYFtknG1WIQSKF0htZodhTYG4fTB2RGsrB77ASCVvTOcKMrJZu3/q0pzC5TfQds4bBi80PN3aqy8QyGwt/uz45JHGRhs4excixAtaUxpZhndYKFJux4VBt8L9pm5mU4HnSAexTVCsa6yVh/0EXH41PlfBBIRPEpEpVkwbZdIrE1iv1pif2WDMDdVfXERRmcsX7qSNWzxZakSsPULcDVdMVj60/K647Fmkzm4+7UIqbMvFY+VssyKEjA/YQRVjgdSsAYiTLEb0uDqlelM9pvDmbP1TdU9apxIot7tzToZdIIs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:25 +0000
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
Subject: [PATCH v3 00/15] IOMMUFD Generic interface
Date:   Tue, 25 Oct 2022 15:12:09 -0300
Message-Id: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ed026c-10fa-406a-f2fe-08dab6b47829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mDVzpvpnBj8sPug9Md9xKJPVGh7lxUf8alL2OXuApvkWGAJafn9vD5rlN2aS?=
 =?us-ascii?Q?xl8GxuUlZRciKdlvCXM4lBKEXysAwlQq+1JfgQHtXiObOyTV94rRiB/bcFWu?=
 =?us-ascii?Q?J9q9aIBot3DMSj7akQUxBtysbX6kCn9Iu5qzD65PyTVzL0Ssnep1JZdSeiOT?=
 =?us-ascii?Q?9g22OsT/J0LmTPmIwMLdwnD3q6WcUGnCfHJZmZ9iv9y1wLanJVfp5wJpfT49?=
 =?us-ascii?Q?gkrfACE8sFoWbziT95AU4hL+7jAeJwEGDklXucX7QwhqmZVFg4BVgLs+8Yt/?=
 =?us-ascii?Q?TxzbP/xkijOmVaac/GDwzsGLgzUKMBwgYFErO04bRfl39Ssn9sKkk8kLxXTx?=
 =?us-ascii?Q?Y4ruCO/e49oQSgCgZNdad5vvuQbakzw/5yAsSLC6t65p2pFf2gh8ClMfXEXo?=
 =?us-ascii?Q?+AVuKYfuVMy/g9PsPaQwMFBL0CvsLbu/Mpu+/mEZPq2KR/ayCu9pTdryDwxh?=
 =?us-ascii?Q?AScrJGwo+/VI6pGDIcvf6zq6tnebiRq0koYJOi3XpHf7YWkIjbYw+tPlqTN3?=
 =?us-ascii?Q?7TxMO81OIQiLwnkMUkCTRkc1gzE3z2dGs0x2uWchPdJn0tLZOx8L4ksgiF1o?=
 =?us-ascii?Q?fJx6O05xna3GwUJ9+rtJLL418Y4CFOYb7orrjXf/6tX7uiyyL6wE51EfKOQO?=
 =?us-ascii?Q?xk5MN8WdLSGR0nG+dMGsYNLQOuHcm6fVTVNFVwPIzjD+XkRuEqYzkcOshQUD?=
 =?us-ascii?Q?y6mOaIoAbvrR7ZBIof1LhJoI1TCU5y2ln9gywKYII49R2QoGYyMnSF+cIQTc?=
 =?us-ascii?Q?WqwX3N0TFXjcKJ047o7Edq2U+22HwTYp/psN1f4NmUP3SR7jvq9z/1Y/L6aE?=
 =?us-ascii?Q?gx3VAXEF5Anc4wJdO9RNqvRzaOqs2Z4r26a4Y0dN+fSApMBNyntBhXCFZJrP?=
 =?us-ascii?Q?QP4mFN+C7bumb6Ii2HwBb2Uz/yJqlq3a5SKZgFSi+83xi3vFRvykZ/kO+J7K?=
 =?us-ascii?Q?Fgnqes2rPXeczdNAjXQoMhJZZ6aUGlA6k3P7I5QhizPKR6mHKzZgDD25vuB/?=
 =?us-ascii?Q?bwHoE6rcIRmwf+L+8KuRGgLdwXeaR6YyKEyCAYalbmLTlgY8ejfR7btTOvyk?=
 =?us-ascii?Q?H6NwQw9XcrtjE/hTxfedH2jfyKRzubTYi+8/1FCI8DdR8wBd//FALg5ltfT9?=
 =?us-ascii?Q?9/+5nTVI6HxogEjS2TRDZLdT1nDbgiKnajyWXpiFLOzlcTL7XCcPB2bLTw6E?=
 =?us-ascii?Q?XDJKUetMZCHNyTjd4O+klhJCppBqq70uAb0KjB5Ll7zDN6HEJlKUfsS4lnS0?=
 =?us-ascii?Q?GaYtzbd9fsLv6Jqm9pXElGoB0zpIJP6n/E83bqOb+f6eDKYPfqChv8gr1fz8?=
 =?us-ascii?Q?mZQanUBo1mjLtlTCDhmP7NMyr2a/9obIoj7uGgBWqglad3G/Oq2h9X21ZlPv?=
 =?us-ascii?Q?hdBTKWliT7YlxCzlII1/U0iVn7HjD+77VGd51oUggt8CdX+P42gw1QjrIDEA?=
 =?us-ascii?Q?ZSRuCXgmfy/RQ+OV59tE292k3X9p2wJ9Tm9qfT3fU/ohSPUMvTRJjDwyKS98?=
 =?us-ascii?Q?aZaUpZCyL8aLeweZYhyiIx++nXAArQMMbZgb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(966005)(86362001)(478600001)(4216001)(41533002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EYCvBZaATLqJfeV2FKY5VDcu7WlCjtbryEF3BJnUNxlwTjnqMdrWdk6Qb8y8?=
 =?us-ascii?Q?0EHVsjEg4yfw90jWU7WIZEkxjdo7Dk6qYNsJ83OTyPfeCLIRBnMHreHGf0Qz?=
 =?us-ascii?Q?AzYWFmjjh+JjoA+y22TgoPEomOq+GwswVYNwDrQsOa95VIplkR3CPlRjIi2e?=
 =?us-ascii?Q?/ovps2jettZTUS2CrcgzJHo4HYaVDNrpQNbLasGkdqDHIaqOB+wk7kVGukQR?=
 =?us-ascii?Q?iNPF5MRZROkbD3OzcfiGJGWShoQkGso53ZYiaikBMeKuqCNOyvwr3K5aLfBe?=
 =?us-ascii?Q?XLVAokKBOH+r6d5OBfDcpEHZmbRvSwHPQMwHW4NSiU1/QTkpsD4Jjqb8Vtzn?=
 =?us-ascii?Q?wWk5IwLT4/0pSzj9/1ytLBtDvQkCo2A3NBg7RQRkqGiNIHLPdtK1q4jRXRCR?=
 =?us-ascii?Q?hIqiSQzpS/skxE8BGGbKYz42f4wInqxWhwF8AmHe9JduvWwDpwnFbHKYjwBa?=
 =?us-ascii?Q?fbDEj7id3N9Y8J30MUlk+XDT6q8+Jmr6/lQ5+upEsMPs6iFsMEJ9wmkqVDDY?=
 =?us-ascii?Q?VK93zW2JSuWDHUY5RbX96DQK4lJMsWKUGGxRdJ8PcURtr/MnENKbT1mDp4No?=
 =?us-ascii?Q?vZ4Xf4C/hxIk1M6F8vH8LKY8l0VZ9zO0iEDgpLjsskQKq4Vf+VC5esT8Rtq0?=
 =?us-ascii?Q?ceOKZz8HYoP3rmfqXM9UoQ+L5PdScyI8b3H3B4NDyZ0sUpFam5DEf6/RHZBa?=
 =?us-ascii?Q?lZb6K2C2MS6s2fAOcXpLOgUgPn27O0FKIuYyZqMmKEHAMDQMrHflS9Hty41Y?=
 =?us-ascii?Q?QlUh1ngdW4YJNFzrMUWzQ/WTigyNj7eNahYU3JxFf4g+rDo7kYrQBeWm6hWZ?=
 =?us-ascii?Q?nvufXFhaZTU+LNNzV6J1ntxRU+Znf5auUqwadUOzH7MCwNgEf74GfUJPEJQY?=
 =?us-ascii?Q?kYoF9ws0vZ85LYUHPgF+AwUpzxT2LnU+5YYGFL3UNX7LzmU80BnnDSUvHFUy?=
 =?us-ascii?Q?qJpBdy3mUQ+wTtYCDzaCkCum0tgngpaOPK4sc3fBNmppo8EjH8XpGpBBCl79?=
 =?us-ascii?Q?Mu7hH0i8g1iV/J4Sek9lr4cth4TrLLjl0rULh+bYpdDMV7NLIr7GEf4076Ma?=
 =?us-ascii?Q?5CuUgvaIrnIiTkV8Aobk8dVMuNdwOdGqgfSexdx4uamjeSKnWwNoXCSn6lfP?=
 =?us-ascii?Q?2C+kBNp4aqJMcsgu4+nh1nSRJxxMtfegvg2FKGmgD9lQm0AZvLvaZuil+RoJ?=
 =?us-ascii?Q?PxI9iURm9lQz+Wgu9JNsvOgh7gxthsz9n633Qg4Rpcgs9FwIenJE+WIN9GC8?=
 =?us-ascii?Q?304bCx/4Y6SI6Q1SRFFJQ5p9NLuhqkHpr6lxag0VF9asjThPsFHnxWzTv0ag?=
 =?us-ascii?Q?Ci0DbK5Ws6MBTQce6i99IFFuMgcWo2rGnUE+bJfvAlKnKisFH4KVNyrIauFa?=
 =?us-ascii?Q?K4cp9nT49DlcBxM7tOYKSLAGWYLZF0jsGkXZbJMKLbiO+/Nla0Qp1IlPMbUQ?=
 =?us-ascii?Q?EX4+QOO58RniVzvoQ4R8lio70PT1WZz8vwOO+xfWg/VkaNlKv0pimWMLtV0z?=
 =?us-ascii?Q?I/olmm/3KyTzuL1garGr+rPDfV0V7eivZd+x3VNoJHoNHtlYf2toUhT+8Drm?=
 =?us-ascii?Q?VteQ+9KBHQ7oIsb5d6U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ed026c-10fa-406a-f2fe-08dab6b47829
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:25.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojLj3bP1TsQeWSUB1sU6rFMP49nWEPGKMVlo7q4f5qs+9iFD+DC/01+BGOVbnrZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[
At this point everything is done and I will start putting this work into a
git tree and into linux-next with the intention of sending it during the
next merge window.

I intend to focus the next several weeks on more intensive QA to look at
error flows and other things. Hopefully including syzkaller if I'm lucky
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

This is about 215 patches applied since March, thank you to everyone
involved in all this work!

Currently there are a number of supporting series still in progress:
 - Simplify and consolidate iommu_domain/device compatability checking
   https://lore.kernel.org/linux-iommu/20220815181437.28127-1-nicolinc@nvidia.com/

 - Align iommu SVA support with the domain-centric model
   https://lore.kernel.org/linux-iommu/20220826121141.50743-1-baolu.lu@linux.intel.com/

 - DMABUF exporter support for VFIO to allow PCI P2P with VFIO
   https://lore.kernel.org/r/0-v2-472615b3877e+28f7-vfio_dma_buf_jgg@nvidia.com

 - Start to provide iommu_domain ops for power
   https://lore.kernel.org/all/20220714081822.3717693-1-aik@ozlabs.ru/

However, these are not necessary for this series to advance.

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd

v3:
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

Jason Gunthorpe (13):
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

Kevin Tian (1):
  iommufd: Overview documentation

Lu Baolu (1):
  iommu: Add device-centric DMA ownership interfaces

 .clang-format                                 |    3 +
 Documentation/userspace-api/index.rst         |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 Documentation/userspace-api/iommufd.rst       |  222 ++
 MAINTAINERS                                   |   10 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/amd/iommu.c                     |    2 +
 drivers/iommu/intel/iommu.c                   |    4 +
 drivers/iommu/iommu.c                         |  116 +-
 drivers/iommu/iommufd/Kconfig                 |   24 +
 drivers/iommu/iommufd/Makefile                |   13 +
 drivers/iommu/iommufd/device.c                |  744 +++++++
 drivers/iommu/iommufd/double_span.h           |   98 +
 drivers/iommu/iommufd/hw_pagetable.c          |   57 +
 drivers/iommu/iommufd/io_pagetable.c          | 1143 +++++++++++
 drivers/iommu/iommufd/io_pagetable.h          |  240 +++
 drivers/iommu/iommufd/ioas.c                  |  390 ++++
 drivers/iommu/iommufd/iommufd_private.h       |  273 +++
 drivers/iommu/iommufd/iommufd_test.h          |   85 +
 drivers/iommu/iommufd/main.c                  |  417 ++++
 drivers/iommu/iommufd/pages.c                 | 1803 +++++++++++++++++
 drivers/iommu/iommufd/selftest.c              |  711 +++++++
 drivers/iommu/iommufd/vfio_compat.c           |  443 ++++
 include/linux/interval_tree.h                 |   50 +
 include/linux/iommu.h                         |   18 +
 include/linux/iommufd.h                       |  101 +
 include/linux/sched/user.h                    |    2 +-
 include/uapi/linux/iommufd.h                  |  330 +++
 kernel/user.c                                 |    1 +
 lib/Kconfig                                   |    4 +
 lib/interval_tree.c                           |  132 ++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/iommu/.gitignore      |    2 +
 tools/testing/selftests/iommu/Makefile        |   11 +
 tools/testing/selftests/iommu/config          |    2 +
 tools/testing/selftests/iommu/iommufd.c       | 1715 ++++++++++++++++
 37 files changed, 9145 insertions(+), 27 deletions(-)
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


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.38.0

