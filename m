Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F963B6DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiK2BJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 20:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiK2BJo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 20:09:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C114323EBD;
        Mon, 28 Nov 2022 17:09:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6IMB5VPjakjg4v9m5E0ONMc5z7FyBny9cJpo0f6ZgZR8io0++5SIVM5B0xdE6B5IKqq0s1qiG6mP0xbMcdv7dvR2cdXuJZriYK500xfUmx4hZhYzplxUPRMWS6zzgNAkRRdOEAPTZ9vpy4RXPiS59n52UAT7AodHitt+ebcZmFeEIsjohIq7ZoEf+76+qfLFXmGh8JpUVN803GMi0PfJWetroy1YQfqi+ZCqmL43VcCOWj3CERJ5IGrzy2hke7Ueyt1Is0abYHjOtZ2/fB2uwq9wXMBAhc81n6WPM5C/S2jg1hHyX7Xlkn/CACAndhK4XnLJNq8z/u67XC/w8rAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOAjxUiASnvobPSbMDiKn73Arjy3PJLPQdh2Ss1kOkQ=;
 b=iJN/B87I9VrilhpetCHcPmD8/hANJe0Z1FROc3Cg/Kp2mqn04mYKQbhYrhT032n6O4+zxMJEjtaApYMLJbv9komsdkY8DCH/QogaCbB7MyKEl8jmr1nNDgWjOE2Xc2PGZDM8HYGOsAzJ34oCKrdZFu+7LcRcwg/4Kt85ljJF/q1qRZCUzLb56i1MAv9vONapa0C2sCvJxIGBIZyBw0nZqAoplZyK4AnO1vXCoVGKmT5d8LTD86ta7XpP5W20tXxGyC86kLTVA3FWnQJfidSG9Npn1WSkYHUz8dPXFERL99UTdFfkN+R2NtM447UgQy4i6/Y/8ue9Y/JlQDh7RFU/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOAjxUiASnvobPSbMDiKn73Arjy3PJLPQdh2Ss1kOkQ=;
 b=olh1yBl5t46TgmmKdmiWF6dEiNblcsu7jzNNgwkONpiwLwWnChxuNE652N3XXNWOTr2nbSqxDEntMdGywAkGrd4iYvuGAvmWMIVtjEcBVJwi7SzELVAD+X2+ox1R9oi583OD8iXu2NsPEMm9HXL5TBaX14GEHzsoCJh8jELdt/bX8yeYUdgL3f3hQI6BEB75Zx0yELROTwVfgIUIOL3vCWykSj75dIuKyDHoZ72eTkZM60hxANAibAKnTv0UgaB5MEXZLmdUBRODhlOVgQi5sZt6JppW1id2D2/w8wwdw2YSpOPKUuUGtW+TUTQM2xIk8/IIWZnyTH9EkFo8UC/vyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 01:09:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Tue, 29 Nov 2022
 01:09:42 +0000
Date:   Mon, 28 Nov 2022 21:09:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
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
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y4Vb1Fs+yCJAtaSh@nvidia.com>
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
 <Y4P9VzpCv/DyHeaD@nvidia.com>
 <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
 <Y4S1hYFm9HaP0KdR@nvidia.com>
 <722b8767-daf9-f5b8-8ad7-0d9cb22d4b7d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722b8767-daf9-f5b8-8ad7-0d9cb22d4b7d@redhat.com>
X-ClientProxiedBy: BL0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:207:3c::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee3af9c-de1a-4c35-8c88-08dad1a6649a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNW74lFY6ox0g1WNftKRvxfwY1wMkzWY7kfp3KKRk1HOUrhj1rSwO1GGfmVcQtVqJr8JRli6HQiLumMw1QM7nCAnhjP2+63Pn4hicWmm7htuz5Z4yF3a1NreYxuf8NLTdIjzWQTpNtXfDOYJveZtjjkkRrlKKQl12LXX6F573nwMl7vMhjo8hMHggYuvX8+UEVA+sdmFXKsO5tjy4VPPAR+YbvRLTb5LLRcMe5LypmK1aE2WvGfbjr0dS42bZZC/EhKFqZwI3oHSKiMmDPFmFAbxopqrlQYBDymjWzD3CCttFex93arQwBsEebbmNiIJ9L3khBKdG8sELL3G4zWTzZ54s+QuLdclPlRbPj6GDEw0dZQBEVqcpOGMJKOhbNriXs3ywIvj4eX3gYg9zEqbJWp469SYPI0KpIVi1pKk9H1r5oszK7DT+1o7V2PmE641J5132r1LlZ8Io8GniOL9GLgdOGDZjQo2rrOoeOBCAmR2q6zb7/W4ar4weAEl7FKcYYprRXNtwr0+dgg8gH2QEwgnbDRk6Py5mWmBqqDAhQA+kusPo1KeWcxueDlZoASCQHJum+2qx98i1lBbscpeDHMQ6SwZ4c0IhcrLy/rdGBD55XK8/y6zCOHkMcVX4fUP9gZyREpzNT4tIiop1h2uemXpBd0rB4eAZh+FSXYIFAsdP1qfQ5kabrpNyrHE14C55XT9bCpFbF+jUDWfPkiJUAK0uLyO/OZsxgJitDtdxJ2f4XN0lDb1qAsWGDPrL5c2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(478600001)(316002)(2906002)(66946007)(6486002)(54906003)(966005)(6916009)(36756003)(38100700002)(26005)(6506007)(86362001)(6512007)(186003)(2616005)(7416002)(4744005)(5660300002)(7406005)(8936002)(41300700001)(66476007)(66556008)(4326008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kpb6F/FcT3TH/HMBAVt4SY0+v4MeQQ16xJr6GakjDQWbUVK3lO0yNqY27fIB?=
 =?us-ascii?Q?2GTZj08x3pyzzDNFi5yJ3FRsPeXFm7v0dG2WlzR6jmLGyGRv6+4JInirNHxf?=
 =?us-ascii?Q?nW9Ygj4ae9R+dw1U2WBc8yfr4q2xmL1aUO4XsvdDQK6hVKbvXi0Trzhzlyi1?=
 =?us-ascii?Q?XjVnwy4sTq4JqVdmK+x4vVCPifsaeNlg6FLf0i8cITL1lGTxYAXfMUe5nxW3?=
 =?us-ascii?Q?GJAYmIDI0+neNcDhck3RIhMcjAWSJlT4hKQNsBKXHHueI3hETnYws67+QHfJ?=
 =?us-ascii?Q?6ngO7to7ZneO2A1BalZ2X3L4m+050Xwkot2jcXSzRbIVjS0YXEejQiUPSicx?=
 =?us-ascii?Q?UT8rTXbPXkJyVcBLlXzRXGGq7M1IpPq+myzYnFpcBmNDBo+YS09wdJur3DS+?=
 =?us-ascii?Q?EDSCUFz7Df4Xf3HwlcVv+5EtVxEE/yaO2rkv4j91NhkWJcPUfTR49L1633ba?=
 =?us-ascii?Q?F7BMgkCOyDSnoWZs67QmsV/gGwog5+RgCz+Dn19AfXpK+5Idma0P5b3pmUn7?=
 =?us-ascii?Q?/sPjOW8UhAbz9IXNyG5i28GygmrMIUEmj4RXAGJhZXdpFAoKcP/IOSEdTTOd?=
 =?us-ascii?Q?hHZgqGe+goOR8Yzg/fgcu+nEc6etp16WMyUNbY2bmkwfn1U76tECo7/jkvV5?=
 =?us-ascii?Q?HN/0SqY6AZxcXZUA/IlP+G7anEPjZzyH+otoexfVWZAmkFi27nbwmN/kFvAC?=
 =?us-ascii?Q?cAu4lsmSPiY7eNI+LXOHZrVnkJCZ7U8+FkDM6un5HWEBlnrcFs7PI+012Znc?=
 =?us-ascii?Q?Hb2B/B3BQ9ufx2SuN4TiJru9bMIPWX0uvsrDffOJk1/pGxw/a4WvG/sIZGsb?=
 =?us-ascii?Q?Zz2LmSQpGbeZzAv7I52Z8DKHFxK0gnhIZUSsOBcn07daqg8AbQBrJHnxJ9YY?=
 =?us-ascii?Q?W96TBH8CeUkYrGr6Q8DQl4WlRkE4SQULT0OBHIXObxGDNT3vojlA2J1PfSAh?=
 =?us-ascii?Q?eB5gra0XXT3CAhMTsN40x32DdvmEwDGLjYCfh+zlPnI7hbMgi0V+FAA8srk8?=
 =?us-ascii?Q?fHAXvLAeiu92B/g/4N9F7704pMKNgCa2MEmVpENpftqrllumakdkT6477Qxs?=
 =?us-ascii?Q?/xtX9pQDbYjhERjhIr9ytPLhCx6q4GuRuuIHGdYyahResJhaCIjVlPntJRdg?=
 =?us-ascii?Q?pms0180jmI2KDB2EtiotYfuuJx2e7LbpK9LDzJ40hHKFO+vFHdxHYDyukiMJ?=
 =?us-ascii?Q?58Zm/pt7KzVceocLcQaQvUtC4+DwxE2PbK2/uCZo8EkuCtR2tIGbBx+Ynmba?=
 =?us-ascii?Q?r80eXB8wQ3uOsFQlOhzu51OfEhZRPLbNRaJdmY68OZcRRXlkDxuxlFSCJ8yv?=
 =?us-ascii?Q?eax5SFpVwnu/t13HHYPDphVslkNwAF1tIFiq5b4Z3yFPFOegwx30W04oRrsg?=
 =?us-ascii?Q?4mtE1pYlGtdBXvEU2l2W5GPeCv3cpoGs7hCUaqDqqnGWtmo1xEXrEAWDHU1N?=
 =?us-ascii?Q?l5GMSZfqLIyi6Ci0T/xDPb8HDo4gxVGxeAKCnX2h5OLkAAUOuSbB38RHrH+Y?=
 =?us-ascii?Q?3fhCPk6MApi8k/NGsOWIk6JQowkOeQdkMhWRHF1uyO+uXxqd45wxBTrtX6EI?=
 =?us-ascii?Q?L4TXfwtRHKe037zBdmw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee3af9c-de1a-4c35-8c88-08dad1a6649a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 01:09:42.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70clBP2BwuLcZMtSw6ItQd3iwM+36opf7lpqMQ4JxN28ODuvBBxmkyDaKXRgsFIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 03:17:09PM +0100, Eric Auger wrote:

> > The fact that ARM was allowed to be different (or rather the x86 mess
> > wasn't cleaned up before the ARM mess was overlayed on top) is why
> > this is so confusing. They are doing the same things, just in
> > unnecessarily different ways.
> 
> fair enough. But that's a separate discussion that needs to happen with
> iommu and irqchip maintainers I think. At the moment things are
> implemented that way.

Here, this should fix it all up:

https://github.com/jgunthorpe/linux/commits/secure_msi

What do you think?

Jason
