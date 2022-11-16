Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53DE62CBF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiKPVDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiKPVBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2202.outbound.protection.outlook.com [52.100.173.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2820983;
        Wed, 16 Nov 2022 13:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6sEveLR2Lf0v7WGBomyeqjm0lLxwa71iV4nRFj2W8A0gdz/00bpaGyqSdFB4hm91vuNtLuLuEB1mv1eiDGHmLniRnm8MnR6xX0JZP1ONUOkqh3fDEydSktz6TK5muMuiXu8RzAFtqznMTxgX/CKA1q5ml/EWMBK50uc9NwscpFIO7AvpdWycTOA5I6KbbMvO4IK+sabXl9aIQDhTFD+wKo8zCB/Vb9toxjpiY6aReLuatagywREqynZsYOwSconXUj7ndZfQWrBpMBYX15HJRND10iIO+k3v2mDDDsg8edYL/u+laY7bVny6r/LqvVLJZHin4HIE5r0Ny7SelNTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV28FEZTqbctOLcHUG5kOg/LcRY0zgYcPsjphutGGCQ=;
 b=C0BNsc4PrJ0NX+asDKcy82hI9U23glnko9Eap6VDxEt0QGaMiDwTuiUalhnDZZoQdmbcjS/R/TfAqP/koZIG+9pxOyofSKk47l6tdpZ7YUXWD/7a2+McJPC03gL/xZm5wIZKqb2CN1VHVbEsz/J8WeP40EdT5v4pbXitdgB3oA+Svkp1A4sz0M7AnbxnkKiJGq/ULUKYNACE+wHlS3gpAZPqYp9INNLuOQmDAeuoPT2lptya0dsHVJj9uH8zlxQb5erhjZ4yDuasUD+OS+HNP+Y+I/mH52u1l3KpHVhnlCP4VJSa0jYIm9cI/BDQRqr5pPsms6nYEQeGzQpx5EpmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV28FEZTqbctOLcHUG5kOg/LcRY0zgYcPsjphutGGCQ=;
 b=r4cDn3sWQNdD2ztxiv9F+u3KQZwd/O+QO8MfmcpgG5cRtmXlCunD4EToM25O3g5F27xOA1llIo4k31RPgQHjPI+sjKromFeJ90JQlUeInKAOgqim+QZWK7frVpra10TKbpFWVzTx2UemS30Lki8v3mJxmhKQHemtXTIQMxRQsMDM/LtNzumzoc31ppv9xrLdcS/6h2Y20cO5sJdY9oL45hbvixCIJxRmXP1vYXW06iHNgK0pSE6uaxKTyhWVXqO+V80u5JhEpNfILeA+vNdyX9LmHsKo/Q6nP5VCUXx86ZIk5KvV/Ctiu+ivFpm0NaKvcaviDELry13douulZLiR/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:56 +0000
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
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 00/19] IOMMUFD Generic interface
Date:   Wed, 16 Nov 2022 17:00:36 -0400
Message-Id: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ec1655-f904-4cea-1b2d-08dac815a7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zu2kljoVVrTLaizu8AehpaMMjxjjTiFUtKIHPsg6w+XnILnnQwSeG077anzO?=
 =?us-ascii?Q?MoP2cWnltXByCa3eoNVi/YDINzRj6gyLLQ94DDXrt2PA5jfDS1bUv9hp9Z4q?=
 =?us-ascii?Q?tYxC2icLpYo0vS8MJsE4Z/ZwZX0uW/qzrA36zuGM+9UvA9f2L3zOsMAJjwRK?=
 =?us-ascii?Q?UlnTuOz28pVPHsyIZXqIaqTRZidKU+Bf+5YmxnyajUyFWAJM6zgIGsZDobgf?=
 =?us-ascii?Q?ot6RwmUV5XKSlT2S91i/cpfDOtqmMoIOjzrpOOk0uEr16l7GraYUS+WnzcNs?=
 =?us-ascii?Q?t4lPq14tNRc62+ezKpGC+eBIjf3eNe4FZDesc11AscULrhTP5rxpqbgnjm8W?=
 =?us-ascii?Q?N4DNE6AVbz9UGZCytutZP94q5WvgTB5dqiH2sobPgoYhSZf5Sk3hlN4ulYmI?=
 =?us-ascii?Q?ORrjFzqDCrPzaMNFUXFQDJS6MQlXcC/5BwBGDwLwFWqHx6WqvwWPdRku5B8q?=
 =?us-ascii?Q?lEG8FOwEQo1H+v8UmNQi6lfv2i7R2J7nMEcUB/kmYwz+fBAJQOIbEX8hE+nu?=
 =?us-ascii?Q?h+4SKtunjfH7WmRiCY/NT9Nu7bA0eWeWgK5PCbfqwl+3m3q9YMPpBZHG0xu6?=
 =?us-ascii?Q?C+6zo3Og+NVJ8HYRFNzdu9TM51eSM8G77zg0ktY6njuzUm6YY/lNbOftCovH?=
 =?us-ascii?Q?22w2SAhGyAGiO3GYK+a6Bm1PYA/D3cRDsM23o/0/gLBIQMBhrKW29eBSNVhw?=
 =?us-ascii?Q?YGWV6o2fH9pipmk2WCqBiOcXTFSsNzNe8pkb7oH43/0A665SY4KqMyUm2Vgy?=
 =?us-ascii?Q?Y5uYqJHb3nEuIhAIiqVdSXhujJvl0DTh6os/1CGtOa8lJVA3FqF9wvYggLXr?=
 =?us-ascii?Q?86LgEFNMufa96hQvG+/vi/wm8famLcMYZUvPuIguAEamxHomDpZrfpEOQoSE?=
 =?us-ascii?Q?1QnT06uxsiqj0AfJlarF0RPVFM3FaonVKd75VDzCP09IISZYC9z210DuOoD4?=
 =?us-ascii?Q?Il/gbUAl/S/l7w7VuuF/l4/SEQA2LfMXaINWPO5ie73+ARuHKj9/pSS9hiJC?=
 =?us-ascii?Q?+iXwHCHyENYwrZRLvp845WfqS4IDDUeTMGYhTXyUtceHpnBpSRFKMrB5AYDX?=
 =?us-ascii?Q?0IB2AbFJl/nzi6apw4URV84zJU5zPcfP3E/i3dWc2pT3KagFCNH8GWFivKvC?=
 =?us-ascii?Q?SUrpwzElF1l+09TbgVBnh31IDSEcqIDGtJDfFEC2OL/srpnRYZMsgAcoHy0w?=
 =?us-ascii?Q?IKBIw2AnEftBh4TK0ILdwrD0ZrJjvOLUWz4wJFimkav+lBlSKv1bkGw+g3Pu?=
 =?us-ascii?Q?KTQN8CY5CqXDPIeH2hd4BTvqb6MHA5skM95z7IqkEI7U3DBzN5WtD9D9FVNt?=
 =?us-ascii?Q?9E+Og6W45U66PMyqpSumarusV9QjhrAhCOW7UcAqlqcGCEfK28qq04peR3Mb?=
 =?us-ascii?Q?ljZq/iMBtZwqWNppbk5hqtpdcEzjqHSVb/FWsJgvoFZ/+ClpNnPjTwLq7Xxh?=
 =?us-ascii?Q?QzbJGlfvVwAvTzuAD9QUh64IdX0ZMlLSwMYeCO2djSkqwIsMdCEMuE3SKvT3?=
 =?us-ascii?Q?f0icKgCRVvZOTSGhMXUZ2KwlVFJBReP0WJbb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(966005)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(30864003)(6512007)(36756003)(26005)(4216001)(41533002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vN1TuuJD6t6ft5lPnlvrjbHzR29mkFrN0dTelpVbaBHLNhuUb02L7coLkkF8?=
 =?us-ascii?Q?cszh+RTq0O1ZMWKXfhVoYTVcK7/kJvEdpOqYoirJNrg4DIgO+kyTb0FFk4ED?=
 =?us-ascii?Q?rXcO5q0i8DOi7K+OXgiRHBHBfHvF/pc1KMOOSHmDO4CgjqrVDXcOdpt4BElX?=
 =?us-ascii?Q?q69P5QJCCI2Vr9x9UpkuH7U85iyiy8QdoSjnnvFvrMTI8rziFrWTJ0gxEUhQ?=
 =?us-ascii?Q?HyEd1hMsutN9Zc0lEJqZrSxo5XjoiJGx7uGDrUaudIkKVjjB7gxzAGshmRgU?=
 =?us-ascii?Q?0i0EVwOkO61qG4Kpsl3aH+pCSbGDA6jAef3qMasTc/CfvpRDMsAs3adyPO99?=
 =?us-ascii?Q?6RwrUiO+DMhvlPFjL1PZ38f3+EXsSrVjQ76cE7I/v5e0JhWChRb2Pi2B8eca?=
 =?us-ascii?Q?Y4hGa3x1p5ZeQwZ5TEpHZaI+Asr5UG0ZBqhy6UTPeOgPOvUL0LUcWVc7U7ka?=
 =?us-ascii?Q?fUWl6J/nsccRB+epLXm4/yM+jPSrWi0tcAP2Dr1HOWnpgiRh4TgG63GPGyiO?=
 =?us-ascii?Q?qho88i4A1GvAxNjzs6buu3c8JnV6xCsODQbL3bKZQMEom4Ya69z9P78H5Nld?=
 =?us-ascii?Q?dqKKAZzoG4ygp+kFmZKZHvHoTBuJynSUKlnUGxReipqGa8m9K7AFCHPMUIYR?=
 =?us-ascii?Q?YmcUEYOkOpa4vMqs4Dou6IXlbNpWpgDu3ktfbsbIoAasIswmtW3S/Aw66HRj?=
 =?us-ascii?Q?dU8LrsD5awu+tZ2zgUNXxHoYgbmbS1yqh+ZM0y8s4Ep/l+idksrcaZGlbJ98?=
 =?us-ascii?Q?tONO4pKnO3/nszNfe0Vuy7RCSsXxH5cVVaTzhEPGDVZRCZjaLkKA5seazvEW?=
 =?us-ascii?Q?Gsf/S0KZgSZj4TVdTDougn+oGpZ0iHJ7gZM+4drmBOwfoR076bhYZwrvdCoO?=
 =?us-ascii?Q?qUBl9dfOkS3WZhbn3HvbnJHLGZ/1JtN12tz8FTh665tGuS9RSZt6aYgVNJ0w?=
 =?us-ascii?Q?qe3+5hZ+nbVo492NXaiF+c2Svcey5i+8NMUIL42wQa/8ZVxZ4TWTtnuS47rk?=
 =?us-ascii?Q?c9Y5gr7wSWHV5x14am+6tyRtV1c3SJ8DMMp7Mk48tdsY4ZOYkowUusmWWTLV?=
 =?us-ascii?Q?vxO0aSY8nn8d7C7qrLchJd0PUN3lvj4I7NR+SqVgtUteLZWxV8HVs9pZqkdg?=
 =?us-ascii?Q?KgkH+BRPgd2p6Xj78pz0TW2b+gs+77PltjVrBABm8rZx/zUxUou12NeE2IT0?=
 =?us-ascii?Q?oLeQYyKkMqG88hBvmGPSYRaUz5LyWLFPwh9YLIK6hpoQuW3FvprjmcH2sWmZ?=
 =?us-ascii?Q?Y/nPTA+VkO4HHSUSj7zGXAQ6y08UCYZ4OibXC2f3LE0d+IhLsX74tU5YbBgD?=
 =?us-ascii?Q?H7Hye1svILGcokbdrs1hDOnAUr0Wpj7RjkylXN4LwachkVEXPnVZdDTdWRi9?=
 =?us-ascii?Q?DkSVUF7kEicdkaTCwYPQ3ROePJ2Dle5oHl4Ii5IcwQv+5q0El7iLOzJHPhX7?=
 =?us-ascii?Q?WLCrSTwT2O9E9eyxwpwQ7HbrT94eNsUcHQME69UVcmp2jEkQEuBQ1mQXfbJg?=
 =?us-ascii?Q?khcsYkoOjsLp6IyySqx/1+xQjyW3xaxIo6fkGxjqNiLQDvUNYwaXMG0gbKq5?=
 =?us-ascii?Q?cD3kPGK9bC0zRTzXba4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ec1655-f904-4cea-1b2d-08dac815a7c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:56.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IegPCrkdyM/oYSl+WwBX4P4vKX/Fedc/EJ9xNtb9LEc0HIyJz6LlUqHV5q7mYL1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Spam-Status: No, score=2.1 required=5.0 tests=AXB_X_FF_SEZ_S,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[
This update is primarily collecting remarks from the mailing list, lots of
doc fixes and it is now stably in linux-next without warnings/etc. syzbot
has taken over and is running now, the remaining static tool feedback has
been collected.

s390, Intel x86, ARM and all the VFIO mdevs have been tested now.
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

Syzkaller coverage has been merged and is now running in the syzbot
environment on linux-next:

https://github.com/google/syzkaller/pull/3515
https://github.com/google/syzkaller/pull/3521

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd

v5:
 - Move WARN_ON in __iommu_group_alloc_blocking_domain()
 - Fix rebase error of pfn_batch::npfns
 - iopt_pages_add/remove_access() is now iopt_area_add/remove_access()
 - Change iopt_pages_access::refcount into an unsigned int
 - Lower mutex/etc into iopt_area_add_access()
 - Match VFIO error codes for some map failure modes
 - Block area split if accesses are present
 - Match VFIO behavior for pin/unpin when the IOVA is unaligned. Round
   down the IOVA to PAGE_SIZE and assume the caller will take an offset
   into the first page based on IOVA % PAGE_SIZE
 - Increase VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL to U32_MAX for s390
 - Enforce that access->ops->unmap is set if pin_pages is used
 - Split the test code into several patches to stay below the 100k mailing
   list message size limit
 - A few code naming changes for clarity
 - Use double span for IOVA allocation
 - Lots of comment and doc updates
v4: https://lore.kernel.org/r/0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com
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

# S390 in-kernel page table walker
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
# AMD Dirty page tracking
Cc: Joao Martins <joao.m.martins@oracle.com>
# ARM SMMU Dirty page tracking
Cc: Keqian Zhu <zhukeqian1@huawei.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
# ARM SMMU nesting
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
# Map/unmap performance
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
# VDPA
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
# Power
Cc: David Gibson <david@gibson.dropbear.id.au>
# vfio
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org
# iommu
Cc: iommu@lists.linux.dev
# Collaborators
Cc: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>
# s390
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (17):
  iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
  interval-tree: Add a utility to iterate over spans in an interval tree
  scripts/kernel-doc: support EXPORT_SYMBOL_NS_GPL() with -export
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
  iommufd: Add kernel support for testing iommufd
  iommufd: Add some fault injection points
  iommufd: Add additional invariant assertions
  iommufd: Add a selftest

Kevin Tian (1):
  iommufd: Document overview of iommufd

Lu Baolu (1):
  iommu: Add device-centric DMA ownership interfaces

 .clang-format                                 |    3 +
 Documentation/userspace-api/index.rst         |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 Documentation/userspace-api/iommufd.rst       |  223 ++
 MAINTAINERS                                   |   12 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/amd/iommu.c                     |    2 +
 drivers/iommu/intel/iommu.c                   |   16 +-
 drivers/iommu/iommu.c                         |  121 +-
 drivers/iommu/iommufd/Kconfig                 |   23 +
 drivers/iommu/iommufd/Makefile                |   13 +
 drivers/iommu/iommufd/device.c                |  774 +++++++
 drivers/iommu/iommufd/double_span.h           |   53 +
 drivers/iommu/iommufd/hw_pagetable.c          |   57 +
 drivers/iommu/iommufd/io_pagetable.c          | 1212 ++++++++++
 drivers/iommu/iommufd/io_pagetable.h          |  241 ++
 drivers/iommu/iommufd/ioas.c                  |  390 ++++
 drivers/iommu/iommufd/iommufd_private.h       |  307 +++
 drivers/iommu/iommufd/iommufd_test.h          |   93 +
 drivers/iommu/iommufd/main.c                  |  419 ++++
 drivers/iommu/iommufd/pages.c                 | 1981 +++++++++++++++++
 drivers/iommu/iommufd/selftest.c              |  853 +++++++
 drivers/iommu/iommufd/vfio_compat.c           |  458 ++++
 include/linux/interval_tree.h                 |   58 +
 include/linux/iommu.h                         |   17 +
 include/linux/iommufd.h                       |  102 +
 include/linux/sched/user.h                    |    2 +-
 include/uapi/linux/iommufd.h                  |  335 +++
 kernel/user.c                                 |    1 +
 lib/Kconfig                                   |    4 +
 lib/interval_tree.c                           |  132 ++
 scripts/kernel-doc                            |   12 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/iommu/.gitignore      |    3 +
 tools/testing/selftests/iommu/Makefile        |   12 +
 tools/testing/selftests/iommu/config          |    2 +
 tools/testing/selftests/iommu/iommufd.c       | 1627 ++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  580 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  278 +++
 40 files changed, 10385 insertions(+), 37 deletions(-)
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

