Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376E1644D5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 21:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiLFUks (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 15:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFUkr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 15:40:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC1140CE;
        Tue,  6 Dec 2022 12:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihPzS9h5Q8R6NRCLRsObX91pIRx2a5oo62fAu0BZiUfzwlIOJigXu+dZKqFmzdUF7LpmD8W2opsha6mhqj3L/BpE6o+A9qRfJUYdf+wusQwOTabT0qXfg7SImHA+z/ODgy/BE5PO9pEJG12Cy2SRxiwZOPT2u3xQZNjMnZi1Tm0D7eMwdSeh5zBCTeeQek7RfrYKRpvouTkqJWlWTy/tMjlUVYmWGE3e8c+Dgn4H3QregijnAPrztZY15ZyMG/fNmwNiFVvU7RDaQe4ZTo9SYwJe5a/hvjxh3S5NavCSM1BhfO8Y2KPdMxo6A/5B0NK/oGtGqxKsQlfbTIQdlTTLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0wekwp1a6rNUH6SWTHVNicB55w0GkDfuKpM8iFmFxA=;
 b=atXQKztPnTF4Z3uyy91jLpuiGHxub2nvN4znM7JMcYJ8FVVFM2zEjysTD4o5SOnjV61ARbVI1eMlonpVTvNVw0pyP+/8RmAbD2r/H9LHAKGuVBUuGMXb+uhmByUiWueNcjzQwklg1lg7lnhYjplAgM7IeQqBHSz88IcaaRpV/5SI757zFMRQqpqmwCR1vX+glsjTP1iG6awzXB61Num3D1wvxUebdbX/CX3EU7eRFzgAcBMmMZU183v04KnLMQ14/enzXPS2/gir2hE5NT5mJXhY2fSVNZ97eHfmokVT80DkAY7x1OpO4n+63sEsE5pG/pyuK2qDtwoHxRsHaLk23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0wekwp1a6rNUH6SWTHVNicB55w0GkDfuKpM8iFmFxA=;
 b=LsI5ZPQa9eNIivowCLzXG893ZLqK543ZSEQz4Uxx09D9nxLANfrYhI53xO9P7sJlqZia8o67q9sOG6pFx16TW6H8DGtCukQlcPmL8f1Nl/GKHIMxTRzvmRq3FHDRlu6ymEKpTT6En/OWz/sGMPeHpSSj2TwhV8hv8m1B3Ny2h560TdVIQGNzTGmJzNlDDBYwsaIsifv7tbKyurNEDe3vqVtxxfLph9eUz3ogHF4DcuBCau4QCGCPjYW7iEPeqq5oTlx8mTeTRvUQkBoMN3/7Efybh/QvIXwamZyFtBFqR1OvNSTya2F/CO6gjy+IHvgFT8oGKeiSN+OqELYDccR9uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 20:40:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 20:40:44 +0000
Date:   Tue, 6 Dec 2022 16:40:42 -0400
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
Subject: Re: [PATCH v5 14/19] iommufd: Add kAPI toward external drivers for
 kernel access
Message-ID: <Y4+oygRGw562mbT9@nvidia.com>
References: <14-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <44ea1bad-500c-b4a5-c2a5-e7bc79de2394@redhat.com>
 <Y4UEUXO09YeKhrtt@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4UEUXO09YeKhrtt@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 346ad5dd-2bca-4394-9575-08dad7ca255a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqX5ON+rQR6+nBnQldQZ+Mp14tN36bC9RgPRKKJyq8HOFbFYfYJeOZWImB5a0DxaOCObsecwnIsVmvhc6OuYIbUTD4wTtK3yyxso54Q4gu4nVoSxgLn6/1cEty1vVxh5M6uyE4gNbMnawbO/4J7G8IrOtWgC7G/G4EpuLTNRvLyVOSEvdVFrPfSJEN/+9kNNHHduMWswAj5Fd5r5E15bxeSWNSzyxllxBcmErfw6yqVqcBXqgjUHaV2hdnFmIKSnlaDRIJ7JEyUcXtSCI8VOuTbEnTb+FN5wTYISr/WmjetxULFM5uG6pnBOJ3bB+BSAkg0ufETh0LNe7czdsmCNCqx5C7e4Gq0NIXg9wBteQhNquVDK1qzHpNGGDXfNA9K7NJ3Z3mnQGRMAlzDBjCFN0knjtmDQzEMyRYPMARuVznm/jHJl2KdgIkLenc+zFSf55uQfb1XbkRmCT8n8LZWHJdwvsA4kVCkEoU+vPgnR9olRWbRQ+Or4l4leTjtNv+0TI66aob4UZ8+0gGN0duojwlFaVhR+bKCshEhUC+yA5puz3sCc3JPTwLfhPc3MqcUxmsXE4zZNzpAiswjxbGC9w+oPc4FYx/6m/C14cmg8BnrXw2XfeKL89sCRMHmaDJBp1dVA8PPUxoTpKLYBG0uMMYXc3F5w5gE7sQ1rmwuL2EGDqEP/ptbPtd2qO459A753
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(83380400001)(186003)(2616005)(86362001)(38100700002)(36756003)(41300700001)(66476007)(5660300002)(8936002)(7416002)(66946007)(7406005)(66556008)(6916009)(316002)(54906003)(2906002)(6512007)(6506007)(478600001)(4326008)(6486002)(26005)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E7iqhzl5M4IAKeEASLto1y4IMfEHKy+zk/JRrOkOKjJpSj25VRo7B0nv2irT?=
 =?us-ascii?Q?M3tDqra4MUbDbBBCOYwoOmHiUbEKuo7zJqcWc7Eq+Utn2Ugs/nOP8ersSGLw?=
 =?us-ascii?Q?dJvIfOQkfOAZUbmlD+oVPIM1SIzLerBPNxKEUZwwGLda99XuSUUcb69AYKBe?=
 =?us-ascii?Q?vq7NOuqI40e+d+ES4r/cNs015Kc7spqWeDlC4Qn2P0Wq+uc+gsIYNJFWcw6F?=
 =?us-ascii?Q?OeMUcKTeEretgP7yg9SkwoHOCTomH/5KU1uJSYqFFywAwdiNW4JTmK1PvYb5?=
 =?us-ascii?Q?m0P8gVRupoN8nO4QimZEkkgxLCSjdtXtUsnvr1XBnm4HppupcymVyE2n1RhA?=
 =?us-ascii?Q?0MGoOmn+s7zJi6BR4cPWMSvppKLsFWNKVXag7O2h3btmVwN0tp02OQ/RYVrV?=
 =?us-ascii?Q?4/fO5TVeZGdFxICd1+/7MstLK+a/cnQY+pF4nN0MeAqtWPlVTAzFZFzQwhIr?=
 =?us-ascii?Q?35v/pDH7hJSXU0XfTwxnOjaq0f+uP/ZeY5VXwMtjJT7ytCEnZrRwgIHEKoPT?=
 =?us-ascii?Q?zZJHqyihoyQAQcqbTm1wV+rHiFSPGDx0VcCwN/5Af0IYhWE+C+s+PEAxaJWR?=
 =?us-ascii?Q?2BMDHMCyUV4V7XWMo/mSqDUsiKhkIFdYkzKfqgMstXCj0qCyygCWXEEY2ouY?=
 =?us-ascii?Q?PI0yMouSaJMvN6NlV6fcFhZ5M7TmeEO08DhfvToNDdHMJMqeFVrYRBRxDtzH?=
 =?us-ascii?Q?ghVPt4sjsvb8vYdExeHdWVQDrMhdj0X2TU2W6mXN5mYAXp3M3us7AZHz17+f?=
 =?us-ascii?Q?3EBce83RVYLv8vC9mrcUMnNpqEZk2luvdpzx8MC7UrgPBxMFzhi4GZNRp2d7?=
 =?us-ascii?Q?xses3JK1H38953YOk4f9iTgSIy74Ek54WwIcpftHPxk6r3iviDFtrS7F0Sin?=
 =?us-ascii?Q?+EgAN3m9L4kes1gt7rn32PN4X+4YkSc9UZXfW+ovIeWRYdc5u6+GR5BiTITW?=
 =?us-ascii?Q?wWPp/qKLXTRASlE5aV9seHbq0vFL5V37IRk3yUNmyn3zOPyUy2QGWtzbMC60?=
 =?us-ascii?Q?sEZTA4re4oF/5dOFHNnzzoONR+M680IWOhK0Vybnd7MUSll4wJnzvu1VdYtr?=
 =?us-ascii?Q?qR2ie3qJYbJXa7aqUoaKe9BKVMpyGwkQoDHnm1vaL7yn5otn6CaUltwez5TY?=
 =?us-ascii?Q?kdoKIGAY3Ru/rws3RSLz1Yz5pR1FX8aJyymZxsYKornlVX0CoPMdmZ29Ax8x?=
 =?us-ascii?Q?srIWwp5PARivvibQoOjHWUdsFljEYpZGRO5nWzCYqowQxnwHb7qhRz4w8mkH?=
 =?us-ascii?Q?8qbMQdKJ2544bfAxub4NiPpe1xNne1vt5VrTiCijEMz3Xf5BuOI/wdWJvcye?=
 =?us-ascii?Q?qLN43dEvLjqWTMRN1hcG8FAa+ofBHoW1TEL/fEHWw72wW17Wi+JohmtCxFC9?=
 =?us-ascii?Q?s3918Xs8I77guKGFjo/kDaec5A6HvJCI/3SzeX6bw3gW4WiHpQl4LyWyxRUV?=
 =?us-ascii?Q?fZBrczqfOCcV2MVgM1LYUuwpv2o1n8IzrEQV8XrGcXyHO5Xl1YA1utLLP1zu?=
 =?us-ascii?Q?wKVAQwQS7XY4CDq6zQoZSFCFa/KEcJVUgEiUjTBZFmCKXEildLoDhSpdRp+8?=
 =?us-ascii?Q?UmBIQGA/WjqlDOmdJ3k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346ad5dd-2bca-4394-9575-08dad7ca255a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:40:43.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E83aXU8kSsjL6MCR6SCulojgkpTaKawY1kx3ZhEyqLETjjKnJgy3kTXa23fcoipn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 02:56:17PM -0400, Jason Gunthorpe wrote:
> It is basically saying a driver cannot write this:
> 
> unmap():
>   mutex_lock(lock)
>    iommufd_access_unpin_pages(access)
>   mutex_unlock(lock)
> 
> driver_close
>   mutex_lock(lock)
>    iommufd_access_destroy(access)
>   mutex_unlock(lock)
> 
> Or any other equivalent thing. How about
> 
>  * iommufd_access_destroy() will wait for any outstanding unmap callback to
>  * complete. Once iommufd_access_destroy() no unmap ops are running or will
>  * run in the future. Due to this a driver must not create locking that prevents
>  * unmap to complete while iommufd_access_destroy() is running.
> 
> And I should really add a lockdep map here, which I will add as a
> followup patch:

Actually, it turns out we already have enough real locks that lockdep
warns on this anyhow:

[  186.281328] ======================================================
[  186.281647] WARNING: possible circular locking dependency detected
[  186.281930] 6.1.0-rc7+ #156 Not tainted
[  186.282104] ------------------------------------------------------
[  186.282394] iommufd/404 is trying to acquire lock:
[  186.282622] ffff888006e57278 (&staccess->lock){+.+.}-{3:3}, at: iommufd_test_access_unmap+0x2a/0x170 [iommufd]
[  186.283211] 
[  186.283211] but task is already holding lock:
[  186.283498] ffff888008059a70 (&obj->destroy_rwsem){++++}-{3:3}, at: iommufd_access_notify_unmap+0xb7/0x240 [iommufd]
[  186.284000] 
[  186.284000] which lock already depends on the new lock.
[  186.284000] 
[  186.284496] 
[  186.284496] the existing dependency chain (in reverse order) is:
[  186.284905] 
[  186.284905] -> #1 (&obj->destroy_rwsem){++++}-{3:3}:
[  186.285234]        down_write+0x34/0x50
[  186.285438]        iommufd_object_destroy_user+0x1b/0x120 [iommufd]
[  186.285771]        iommufd_access_destroy+0x80/0xa0 [iommufd]
[  186.286111]        iommufd_test_staccess_release+0x5a/0x80 [iommufd]
[  186.286454]        __fput+0x1f9/0x3f0
[  186.286650]        ____fput+0x9/0x10
[  186.286834]        task_work_run+0xf4/0x150
[  186.287026]        exit_to_user_mode_loop+0xd0/0xf0
[  186.287271]        exit_to_user_mode_prepare+0x7f/0xc0
[  186.287519]        syscall_exit_to_user_mode+0x4d/0x1e0
[  186.287768]        do_syscall_64+0x50/0x90
[  186.287958]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  186.288206] 
[  186.288206] -> #0 (&staccess->lock){+.+.}-{3:3}:
[  186.288598]        __lock_acquire+0x2092/0x3c80
[  186.288837]        lock_acquire+0x1b5/0x300
[  186.289037]        __mutex_lock_common+0xf7/0x1410
[  186.289299]        mutex_lock_nested+0x1b/0x30
[  186.289561]        iommufd_test_access_unmap+0x2a/0x170 [iommufd]
[  186.289892]        iommufd_access_notify_unmap+0x196/0x240 [iommufd]
[  186.290259]        iopt_unmap_iova_range+0x2c2/0x350 [iommufd]
[  186.290604]        iopt_unmap_iova+0x1b/0x30 [iommufd]
[  186.290889]        iommufd_ioas_unmap+0xdc/0x1d0 [iommufd]
[  186.291170]        iommufd_fops_ioctl+0x1e7/0x210 [iommufd]
[  186.291450]        __x64_sys_ioctl+0x11bb/0x1260
[  186.291707]        do_syscall_64+0x44/0x90
[  186.291903]        entry_SYSCALL_64_after_hwframe+0x46/0xb0

eg trying to provoke it by deliberately wrongly locking
iommufd_access_destroy()

Jason
