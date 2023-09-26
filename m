Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD557AF0AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjIZQ3a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQ3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 12:29:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2A2B3;
        Tue, 26 Sep 2023 09:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch2PmERPkgVFPxO9G9eEJW4NQGqjxYX2vxeAbyd2S7IhyvBYJ0N5eTw+CmzmfWIk3GUfIMYBygbrwL1Jtzks9YhNZxeq4HIFIYsE8F/t35UEuG6e72WHn2f/mtksKTpNomKCq+vfX9ykPCdQlBCpXUjPgNWKO++Afc13xk0xGsV43CS1PLTLIjfir+759aEYsTwejm2W8EM1DYQ589k19A/sa+krHb+fhWRbhYWymbvKEKazW5cr7NjUvMle9RmLmPnflT8dLPLydszqukIeCCJaJQUMCVwmNDd6/TVxC4RZGryjLnx++YjQK+PD239CC66vDrUQSAhFYNMGpPUbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSm7SlJrPg1mL1tUxO8WpSf35tOqbovoZrphaO39JQ4=;
 b=SVgqCaGGNuNNE4T0cHHJR6EIZ83hwavRBNf7R37RTRWBMfcfYX6Aa3M5I23sOAAQJZoxGLmqWlIbQ3qy7tWdS+3GfOcKGtcdiGNkDFzMAXFo+FtVWd3aWoBy5Uda8bOQufREkzlc56D1w9T2mLVFaQ9PPWcZHeVhgST/Q4t+uwAOKGren3R3BAUvsSTiMxB74byMTr8/opjTjQ6Rbq36A1Q+/yARZ/MBItW8HM7ZWYimebMXpWmGIGOZCDLCECAPB0A9qEDIRCO47mKw7Kz5kbiFm7ty7HRQFpx6r0kPCy3SpzSzzYkTreIkwZpyZGs6xGU++gUq7L5/HYghOMC+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSm7SlJrPg1mL1tUxO8WpSf35tOqbovoZrphaO39JQ4=;
 b=YIPlAA5jz794dPezFqGZ29A8Xj16Cj0yoOxFVXA1l4DbT8D2gHzvArLIzVfl85DgqeQzlziUjySVw7AOlihrUHQu9DOG8eblvXElhnVfKAwfln9oQwDslZB3B+3UZuYn5l1tdD60TuZymsGbjrU9OJr2leBV8U+oMGFKejqBpCUVZN67g5VshsvX31ev5uKkU/9oNugN4qh/HiXLCCUdd+OEWE+hiasM68BHswA9r9u6S67a70SH7ISS907oW0MOZvmNOGH29hX5gQfoP9ga3SNCukDmTpRgwVTMPc34u0Vf61XSMwTetwO2vRWwu3n6ssDLx/ZDzJVl3/EgEjafdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 16:29:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:29:21 +0000
Date:   Tue, 26 Sep 2023 13:29:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20230926162920.GQ13733@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
 <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
 <BN9PR11MB52765B3F127EE04E4A79C7778CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765B3F127EE04E4A79C7778CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5e7933-ab80-4249-0d92-08dbbeadbcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRTN9nTps73dgWaJwvR7N7CsG9TGIaSlvWfUl+Lvu3eHrvE4FSX9gD+ODg0tQTiWNR2JHRe5PZgz0yna6ZPTUB/gevhfyKH9TQoeER2iUs7P+/Izl9kCCYPRJNntIxvkyQa/fVkJAcyemt/ozKGayaUKz7SOK3yRUzt4dYtm+z1cloVPNKEExbr2Tzf8BT05pBEBXlTydMB9uodrwwg1eIh44mkvKYUwGVPUewzbXAmOdgio+PWvNgrp4cs7QTVQtKDMUKaD0ERDYmMnGomjHkPV/ma5eOZUt1BdzNXyXjKnjm1VXgWYKfbuIz5r7j6tq6x+uLE0lFLdAfDNMnAdS36YiI6cJT8QgvkafMM28zmiSgHrSLQNQfaCGZEb/J9GHDMLXqsrO8nlD4gaD+/4mDG62ASnJ1kKd47pts5ICXHhX4i8nC7pCt7GhWCiS2Vu6ExJqcxN41ca/XTjPX+gOozqsvjvwylvYR4qIGvdIZXuikHfsRX2BwgEmEqKG76tfQw8gdAbq9JE2seGU/vNgXKnkScosoaK9CpAAgrIgieDy06+8ky/0Nuvxk1BND8O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(6506007)(1076003)(26005)(83380400001)(6512007)(33656002)(86362001)(66946007)(2616005)(478600001)(38100700002)(316002)(5660300002)(66476007)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(54906003)(6916009)(36756003)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVlEflHhPcVV8eihy8SrU6I0V7NCqVFSEe98VoKrtfMOXzd23oyly1iWQq8H?=
 =?us-ascii?Q?ept4pxa3uX2wbnCEtsXICDbrPrd10kEI0GArE8z/7w7RxgpxUipoqaDC4nEh?=
 =?us-ascii?Q?4DhMciPVZiSsCPbnGkB4NLMNCwEi6uHLauMgtozwM6VXk18glt09YZQbmO0h?=
 =?us-ascii?Q?0v0h8fM2AOSS1s6+E6jAlnDIb454nigRRb0S9Ky1m/y5LJE/HWJ62dmoCBff?=
 =?us-ascii?Q?+7p1qpsjZ+tNt5gOkJ5XA8em2AUUNapGu93o+589QRNmurUodBIXsROxvNKq?=
 =?us-ascii?Q?rUHu22aiR/Ks/wtg6f/s1feoIT1bx3xJC9C/BRHTsNpZmqB+3P8iDLVRmMP7?=
 =?us-ascii?Q?mQWUN8QpK47rMs0Vkc9pmb55z+nd4UY2EqXmYzw5NzCL0WyQWIu/GDc+zMG6?=
 =?us-ascii?Q?RAiVS0rjh++sLJRPfmqD9GtikqxAQBEIjxVNFQYn1tFgi6i+2r0dyo27zcq4?=
 =?us-ascii?Q?tEdlD32hJz6Ng5NiXQ3NBq0xb8957Ia6qhzNEyLkBKh0/WwzK1AMv9JcDGAa?=
 =?us-ascii?Q?sCsmD04vq+gUFNMo4pDSyOcS1QnwUC8VEadVg28OIYtqCRqiiJ4/BTunEgHU?=
 =?us-ascii?Q?cnIhNu4fypFNQjlqOQ4o5zHobJ0cHjxaEwjetxRJ8IfGx7KbbjM9RJWlwHPS?=
 =?us-ascii?Q?MnBnGDYqGO0aOQ7cI4WAEVDA+Bkm4IJLwwbf7zCgEq/QdDOEpsRQYmNmbmjq?=
 =?us-ascii?Q?S+8K44vgU0Yvr0e/p3Bty/qkDTXzhfEx/lzmj/MdsOu0q8fJmY4qCH49/hnG?=
 =?us-ascii?Q?b8AlOy7jLXoDp7SVaCURvTZhY48HV6WQ1hjsZqC/Kqd3WT103K2Shki40645?=
 =?us-ascii?Q?MfbHEsFIQSjssvzwauYdhYwKS3MAqSi6/P3qUVMsBTA9bzFEi0QBJgrpyzBW?=
 =?us-ascii?Q?C5A4foLXWkm+gwSZ61k812SGq5nVXWynu3wlD6OlBWq+wkpEVlkNXkD/pkqJ?=
 =?us-ascii?Q?EBgF8otf3rKuiIbMxnYDQlt4qf4Ozeoc28P3qfiLc/dEPw0TePFOex1u2zVr?=
 =?us-ascii?Q?u8j6H2XUoBvVlhjAVTKgEQQKjuEjQYC57RFKr6IrRsvZTB8qUrrf+BPjGIVH?=
 =?us-ascii?Q?sn5BvWVeWsQP8patnYstzvXoAK+WBwoqWAm6wmDiJXERPeLD4/MRWaqPHuF7?=
 =?us-ascii?Q?OWfmd1fXDWXW9g/jY2wGPAutG84MV8/af7beYTWwMT5tQOxWLH6AR7fx5EWL?=
 =?us-ascii?Q?+jMo3s9EdA4qFn8+LrSJNppUcdPquRzHSCC8KB4xTb5nXDIrHgv8oKSjlYDu?=
 =?us-ascii?Q?iCCUiNP1686F5ZkgI07Yo+DkirNPrZbTdK3ALwoePB0nY5RtcTPcCePpkLkm?=
 =?us-ascii?Q?pDPmOFHxtI9GfCNccB1D07DyKBAwHrvx3d8wRAB4Ru88V1JtHn6J0qolX1n6?=
 =?us-ascii?Q?swwRwzxd+9mtwfkg8MRmcVz9zVW+m0M0hSnnsD+KW9ylVf6uWkvTx26+MXH9?=
 =?us-ascii?Q?0OHEu4ob7A1mlUlcm/tDS6rU7/HHJj2sPjvfwSUNNKrAEdZJhBMfBrG9jU3H?=
 =?us-ascii?Q?ZMChC1rzFCjMqv0eTp+u5I8LvPBNO+HATroRu8dMiuJwsfZOxpGmRm/GkjMM?=
 =?us-ascii?Q?hs/lcIOPpFfBZ4JOxwyz+XKkDiHBWq5IJUpMVoaf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5e7933-ab80-4249-0d92-08dbbeadbcd0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:29:21.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSiqyPE3midtuK9TwP54pNLYZWdWancUMQiaYwFf9KtBNY0e64vAf2UW4Vbm7QIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 06:37:55AM +0000, Tian, Kevin wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Friday, September 22, 2023 5:48 PM
> > 
> > I could go on enjoying myself, but basically yeah, "default" can't be a
> > type in itself (at best it would be a meta-type which could be
> > requested, such that it resolves to some real type to actually
> > allocate), so a good name should reflect what the type functionally
> > *means* to the user. IIUC the important distinction is that it's an
> > abstract kernel-owned pagetable for the user to indirectly control via
> > the API, rather than one it owns and writes directly (and thus has to be
> > in a specific agreed format).
> > 
> 
> IOMMU_HWPT_TYPE_KERNEL then?
> 
> IOMMU_HWPT_TYPE_GENERIC also doesn't sound a straight word.

At the end of the day this enum is the type tag for:

 struct iommu_hwpt_alloc {
 	__u32 size;
 	__u32 pt_id;
 	__u32 out_hwpt_id;
 	__u32 __reserved;
+	__u32 hwpt_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
 };

That pointer.

IOMMU_HWPT_ALLOC_DATA_NONE = 0
IOMMU_HWPT_ALLOC_DATA_INTEL_VTD
IOMMU_HWPT_ALLOC_DATA_ARM_SMMUV3

etc?

DATA_NONE requires data_len == 0

Jason
