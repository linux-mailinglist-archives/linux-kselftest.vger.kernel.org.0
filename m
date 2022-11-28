Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8DC63B12A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiK1SXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 13:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiK1SXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 13:23:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D42FC25;
        Mon, 28 Nov 2022 10:12:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G84J1CWu2ucezmQEXYxtPyTs4fuiYPZaKRiFFhYriCT6t0cRDa6K4yKH4/ZbXEGX/LgoQgyIUMNIrmT/jDIaNCN9T/xijvASyPcUaLsOR8q3X1alOaM0Qej6+ElPrFop15rUsp9kSEQRZLSd+uNuUwSdx1OlTsANntmWO7By2zoZJaCL0whjh8HpCaExcqgAWrfmj9Q3Xufe0OR0SaguxRHRODJe8APyp9tdj0HarQrbn/O1zwnxYpFyjkfSVFmRiLZkf0ZyVb2f7bOi4slGNholP7BN4b9RBpxpDbgCuYc4qyQH446BDQOMEqphaT3jTId0hnO0FGZJQ9UztIgICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk+GwIfYbSKSknGITfUtrXOscYNVrK3r4UCNIZZImj4=;
 b=ghsbGKlbkInr2ashU0oAmFVOjYiy0VT/JCnyWXBjHrSWxpZDr8t0IWuCs1UkIOyVNd4YgppH4TCJRtp0tpl0xzzhzQc91psMGyTz/wsaRHpqawIxh3BILEBQoY0ci3gqkIsa3nix1G/YuDEZEgXSsvhR3cWe9H9IQ61s5ZrU1PtraV7pmIp11aCHW4RCUb6I5Ob9Aj9FkUcZUGgRoTDNAw7cT/JFWl0UwQan3SP8eLE6y7gM48RwwREFSfhQkAk20FQlP1UDXM5wkQmR7QiuRxa0DCjDeqABhgMolOrYrPN7Ly+ObuzcPKMl5NEZ+nxzO4MxcUbZMomh1WynfrqVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk+GwIfYbSKSknGITfUtrXOscYNVrK3r4UCNIZZImj4=;
 b=BZjyEDdot1BEJtHto378witcLF1+kXKKaXPqwDv3vksWy7xRVP82pQ6KdsPf2QNTQIl2c5ZkiS/SP+D0W1OGtA5vZ19XPqpFQ3S8L3QT6+r8aMke7ODM1UJGfrt3nF06YXNk6qc0kBymXMzzGbslOyuCTw4CuoFiNT9AQJLe7Rvq4fjQLKFU7qZkXlOjvt/ACNxRIfRxORCZt4PfBf43c3vb1u/WauA7Qn3JQnjkGnKqTYOj0wu8/IX8P7jGrF4E4OnwrUMNCf+XppbggiB2RjiyNcW8FEGu0CwseRlQt5jCYA49sFJiqxgfCnrwLAIp+CZ3eo4ISW3ZDPmSDLct9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 18:11:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 18:11:58 +0000
Date:   Mon, 28 Nov 2022 14:11:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y4T57JSB9R1w8VrC@nvidia.com>
References: <11-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
 <BN9PR11MB5276E400C99C0933E00FB9E18C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276E400C99C0933E00FB9E18C139@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:208:256::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9798b138-ec89-4279-f17e-08dad16c09cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8mFZKMO+ddv0+zWXuFVkegKQ9/MWjmzCgXjkjB7/ZMp9r/tMn0F0wIzTMRfLvEMtK3gH4iD/wYvv8zZtoPV5nU7qMUrP43WfdjPxFtQqh4vdb1/EIPTeGv0dnky5Ghgft3xPIL+oBX3pfoXkN+k0ZTczANtTXXikQBEjk/IK1LNvjY5mUHa4ErfKtpKX3BP5rPHvwIArr+reHxB6qBfEG9MnnLmyMgkugXYinTUwvOZPCbVNioU6PFqBoz1hbEcXl1WDjObVG10vAHgPqcRY1CHWrckx+zT6dz17D/hRs6oGM3nyLDBHvxd/ddjMkCvgRTn8/oojeSM5WYhKCc2UjZoYdDCNODS0aE84g9yjrW0J1MnSCZAvg047t/7nCl2olXANFrvdf6utlR9hbjPZJvZxvH1j+Py3hiqrPpntnHkcrviZ12xwRug3rn7g37ovURDUsODiZk1uwnG2UMsaQZSo9KXxS9vaUHdnRlCFIFzNdYWr0uY9N0bY6pipSPNyMiik/8XI5G9XYc7tEEisvm30Y4XUSD84518m0hkG3uJdVeoNtaDYNDk8iy51XbOYT9r4syD00mGg9mOdZ7KrFWPXvJ9oygY0jg3zBSf9Qp/6R4A3yk2BOBfXVYeXAZT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(6506007)(6512007)(54906003)(6486002)(26005)(36756003)(86362001)(186003)(2616005)(7416002)(5660300002)(4744005)(7406005)(8936002)(478600001)(6916009)(8676002)(66556008)(66476007)(4326008)(41300700001)(66946007)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVaTWo0TkJjazZqdXNjNzhleGE0N1Q3T0dmcFlhVG8wR1NZQ0luSWVkNWZ4?=
 =?utf-8?B?bzZRSGhzNWlZejBkUklWODJyMXBiUUZYa2k2Z0YvbEFRWUQ0aHVkdkpjUFZp?=
 =?utf-8?B?R1JwOWZ0cGxNaHVTT01XK1VrZVBhd1lnenA1WWNPdXZYcVExTS9Ub2YrVHVm?=
 =?utf-8?B?ZlNGWmQ1Tmh0UDJyQmZ1cTVhUWlxZlEyRWxNUjN4cXlSS0RrUjY2Z2M5Z1NP?=
 =?utf-8?B?c1d5UlUra0VJQVpBRGhSMkhBWW85dEpzTHh3dnhxbk9TckJNZThYNmJGMEVM?=
 =?utf-8?B?VFZIUnVrTm41U0xTVW1qYkFUL1o2SncxdS9KQ2xEQlNNVUEwcVdRUVFDci9h?=
 =?utf-8?B?SVF3RlRuLzhxbDRtcTFhbWNYQ0kzcDFpWnNlQ1BZR0lJUnZOYkQ1R2tHTGEw?=
 =?utf-8?B?VHZiMUJoZDA0TmwvUnB5U0lRNWhoaWxRMnU5T0ZvQzRrS3VKMVJ2dWVRaXk2?=
 =?utf-8?B?YVpGTVlpa2p6clFmTGcvRkNKNWdIcVdRTHllNVVwV2JlcFEya3g5QVVPcVBk?=
 =?utf-8?B?bjJ4SUMxY0F2Mmh1LzJheWhiSGRPamtNTEJHRTVoS2E4V293NXRzRm1xVDQv?=
 =?utf-8?B?UUIvMmMyNi8yMlJHdC9qVjR4UStuR2xBbm1pZWFUY3NwMHhKNHNURUx2Nldk?=
 =?utf-8?B?dm5XYU5JdlVteXl5L3pyem1OR2pxZTFBUTVzZitoMjNIdzBuZ21ZOFhUWlZB?=
 =?utf-8?B?cDdqT1BiWWJNZmRreXVNelVibmczcm9wRUIyVnhPVzFaZjRGbjMzcldMN3ZF?=
 =?utf-8?B?WUhyeE1FMkZJeE5JYlMrS3NVTlhKaGp0MkFsUS9sNWdNMnBvUXdUdysyZHIr?=
 =?utf-8?B?NEZiSnlkbkROeWp4OHVTaDNwWWdtYksrYzd6TWhlbUI5QmJDZWFPSkJmQ1Ns?=
 =?utf-8?B?V05JWUtnNGxIZmJmK2VHMFBEWDNMLzJuYm1PK3JwZ3p5MlBlbHVTVkZXYnVD?=
 =?utf-8?B?QW55ejRtb1JSZkpLd05ndGRtNHQ1T1dNN0VEVmoyWGs2MkpNNnJEUWRaUGFu?=
 =?utf-8?B?WFVQQUJJRUV3WUh5QTQyd0dRL2d6Uy8vTTg0M2hhNHJTQVBjeGZ0SGNpTmwz?=
 =?utf-8?B?WnQxY1duYlVRbGxIbnVzZE9JQVVIVGZNYWN1UFRNMkJtZ2pDV1UzRmwxbTAx?=
 =?utf-8?B?MEl1R09JZzVhaEJ0YStIWTZNMHRvV2hkdzc0SnlvWm1XVmtmUThkTG9aZzFa?=
 =?utf-8?B?YUI1a1VlMS84YjlhMTV4YXdVazJ6NjYyWmp3eDBncU5jU3NqNHZjKzRVU2NB?=
 =?utf-8?B?dXVScFVQYjN4RGMraGNwejBubGYrdnQ5QmFnVk9YVmdtS1d3M0hPeVdsM3VF?=
 =?utf-8?B?SGJjcVlYNXI5NGpvSElxZUJ4K0hqQkxyRlVRVjhjaWQzUTRZRUg5S1R0OUlz?=
 =?utf-8?B?Wi95UHhHYVRINmZJQjNoQitiRHg5RTZ5dGVzNDdYenhZOG1qd2p0M09XSEto?=
 =?utf-8?B?S2E0dFVxMmIzN0I2amVyOUJ5YVAwdkYwVE9UbmdHNlo1eFBNcG14QVJ4VExo?=
 =?utf-8?B?RTdhWGx3Zm1YdTBFM1U5T2taSFJHU1YzR1RkYmdlYjEwemF6T0U0UXlNblRy?=
 =?utf-8?B?elpMWVJJZGUvK29MSTk5ci9WSjJqRzRTOWs5RVA2eTFUaFlqMXFpVEt0enU5?=
 =?utf-8?B?UW5jZmRBdjM2aE1YdXVsRjJPc1dCYi81TiticGtYdzVJOVZGR3NiakN2bGxs?=
 =?utf-8?B?VDd3dzdIRVVOS1pTOExXR3BUajk2Q3JFbHlLbmF5RlBIeTdyZ3lSNzR0QStM?=
 =?utf-8?B?UGJVN2N0T295Y3NjazFVSE5OZFRqaXkzRm45VFh5dmQ1MWs2TjJJeTBxUDJH?=
 =?utf-8?B?dWd2eWJUVDFwZXlKTEY5VDBhTjJLTmpMdnV3SkdzUzJXNE1IMm5iOTQ3Skxq?=
 =?utf-8?B?cEtiQlVJU0x4Z1RPVi9SSU9KZGd2UjRxSjVxT3BtMUl5eE4rcEV6NHdiZDVu?=
 =?utf-8?B?QnUxN3grcVo5V211YjdLeDJNcllZQzJDaVZBaThsVDVYakZ1RVgycDdLM1Zy?=
 =?utf-8?B?bFBLOVI1VlF1bGdOa2xwcU5FRlMvSVhlVWdZSG1HellhMGZxT3prdjlQV0lC?=
 =?utf-8?B?cE9qcjhKSXU5L21xUWR4ekF2a3BwYjFjOEpaUVRMS093VjV0a0tuc21vOEVK?=
 =?utf-8?Q?YTjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9798b138-ec89-4279-f17e-08dad16c09cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 18:11:58.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxMxg77kxldKm+4+0yle6zk2GrZaY5zKHjnQasEpOFqXYPzzOGMPS4XdpMHRyQC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 09:05:48AM +0000, Tian, Kevin wrote:
> > From: Eric Auger <eric.auger@redhat.com>
> > Sent: Monday, November 28, 2022 1:49 AM
> > > +struct iommu_ioas_copy {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dst_ioas_id;
> > > +	__u32 src_ioas_id;
> > is src_ioas_id == dst_ioas_id allowed?
> 
> I suppose so. iommufd_ioas_copy() simply gets a reference to
> underlying iopt_pages according to [src_ioas_id, src_iova] and
> then map it into [dst_ioas_id, dst_iova]. It doesn’t matter
> whether iopt_pages comes from a same or different ioas.
> 
> The only restriction is that the src/dst ranges don't overlap.

Right

Jason
