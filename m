Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84767C8777
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 16:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjJMOFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjJMOFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 10:05:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF2CD6;
        Fri, 13 Oct 2023 07:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlnjfqxhPFtDakbUW/LpLCLjtd/etr7hAq+Zz9ey26YNcjjtnbag9YNzFBwO8ILf4yeHyZrz6SJNvbdqQK2B4G1oDAFRA0OrcVEU/DB+Eb2O22uRH1EdNrVLbcTM7kpAtqocfNyx9rBxJe4+BPGFrG3e96bVlHF+pESGXnl8E7wLPLzf5cJ6ijaokO2i3CUc9+QeOtnfpnl9tJIUdVfptfjWECHjPbLWVVKi6nOrepZJFv913H+YgaFs2MTS1FeZ7mCnOkIqqRB46bQo8KBsVv+dBLvvMepIYmDEAxH3t9SKfXqToz8BOGuDZX/DQCJ2PCmhy3xgrgHdFq2k9Q++5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxdeAnXwdJ9Ow7zvNKdWFzKTYHy13VNdgWCSKcXrewY=;
 b=EG0TME2SX2r5Kg6STiMgndxQDE+4kG/SH04tNCqz+7LgVbZ5HR1MqYO/DzHiyKJZtGQ9q6T3dHYjETSa1+1KpvzD4wMqmqQ/gncp7nr61a4LAZn/nNIRkjelYXVPChQI4Y68UhZVC2CupcLOV5riyCwSKEyLqVb/5PJOkaKYSMdrCRYNsZLufbxsKhYjrcCanmZACXqdbj3Cl1qd5P3qf8wCuAkJh1vuQydtGOpB342DV4FJUJ7o31wXIv7JfG1mj6udKWtqOojyEVZfzkcC2EFWn/qzzd0afuLkzFvrY1+xBWTC2s0TEcTqLaOissrga909zJcsWYVXdyIllCaY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxdeAnXwdJ9Ow7zvNKdWFzKTYHy13VNdgWCSKcXrewY=;
 b=PoxmVP97pE7mZVozwFvPdhwO3XYqESZEeTwgBjhqVfzRrO0oJCf6imE1YsVrXmsD4Ax/ZN97W1w03agDgyiV7PdDIHGGi8vt6WrIOn8LiaT6XtWy4m490sP9icOOBlIcrVMv7rujlQe7Prium4XL4aCWbviMGG6OmWwU+04t4iRHmpqHSszNaPNc83CaJCYnA3i2VveeY7BuNIkFZ7l5gT/s4DevbMgzuWp7cq/8i5qRuv/99H7YZKv0J42CL5MwWYgMcIIo51Wz7kEALxDEc/XpVcx8YtCRslTs3I9uSmFMuPOUYTMfAYrHaFLtYmngGLinp+SzHKK4sXaogyWA2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 14:05:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:05:39 +0000
Date:   Fri, 13 Oct 2023 11:05:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Message-ID: <20231013140538.GS3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
 <20231010184932.GT3952@nvidia.com>
 <20231012190931.GO3952@nvidia.com>
 <BN9PR11MB5276A55B59EAE44DE058DDF58CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A55B59EAE44DE058DDF58CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: ee892394-a32e-42f9-e59a-08dbcbf57ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNVeq2ocIAVGfhrEakHVrQtK+NqkSJLxkMU1vq7tpeQ3ht7eE3Cd4ZkFJWlz7eYhdHJ7FJOgJZGI+4qBGzfRbVKa1ztdHla17iBYEbXbbLqSKBjX9PA/MtiE+w+sTBw7J4LS8YJb2O5uysi1KZZdqgw23ORo+PWEAswRIYOHfU26FV2Z2y72rK2fdYSwb4U0ffSS+3X8P5CZfoMdR6WdlBTBOcc6nn3JPXUW5uJhOw66qjdUUEyqYzHra7DNcYJMwnv3wfrPCTV88qjHtz5g6EO7ThV9+MKRgU720q0cj+fct3dZ/Ux1apZHAjhiZz0jm6WVPBDFAd2RQHZOsI0yc9i6xheL2Ugc43F/z6FJMv+toHpUSydYrNVqFpjSv7936mNm3bKdBYgDk5435nHJspibc45IvYSn9uKvcNcpoo7Ajz/GmSsIfski/KQhBXub+HJBtkfMzcrI3tm6jZFJErqn4Xztkq7Zs59tg4bvkpy+/v3ZfTS3w6eoPH027EuSlUjx1chpuxHhrfPRwog/b/szYswTCkq0ZO1EZ6KP0xQTwdEte3fYU7o5/F/EtVEn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(7416002)(2906002)(478600001)(6486002)(4744005)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66899024)(6916009)(36756003)(66946007)(66556008)(66476007)(83380400001)(54906003)(316002)(33656002)(6506007)(26005)(6512007)(2616005)(86362001)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAIX0muRG2e0f+NsnZ6Oe2P7HENXzxBiU6DR2phlZQNvGMqR2MDTrZxaW0lD?=
 =?us-ascii?Q?w87tVjnhcxduWjKD7eaTlC0i0sWQZpQA5NqBoEl1EeNLtgwJ52O7kODpJV9a?=
 =?us-ascii?Q?t8d2Bh9oPmlGmosOWfb/RYQ/nNmIpg6z3Snf37/fQKnSwQgr385cdZSQoghb?=
 =?us-ascii?Q?rciON1Imb8u41+V0mcIYS3j2PN8q/UQqEWt1LMr87mttMzpTDAHKx4wS4RGh?=
 =?us-ascii?Q?XWFiIwLA4nCDwnhaOXFrBHqIRwAdEWC9L2ctoQn0DqKmVZD9NhGIf5QqS5FG?=
 =?us-ascii?Q?6HCMPmwiK1DNL3ARXurgVaTAZua1orNsee7Aw2Gv2Hdb/a1egq7ok0Mrrpr3?=
 =?us-ascii?Q?9pwJavuTCWgyd+5E4d65/mgrKPhvx78EKWuV+kH/y3vSQTA1F9lxuLA3EURo?=
 =?us-ascii?Q?21Ql60TF/Kc9DVdbYYupkZZt/JOkzcPF6eQsmEoGF8ZZbpiHhlM/GExNl7Xz?=
 =?us-ascii?Q?pqYBn7MXz7DfeDPdNoM61diYRf8blHzP+60tcYN3GGNwStVZfPi4ri07BNc9?=
 =?us-ascii?Q?tvFzv8tmQ7uce1ufxvZJcOBvm7rU3SvWb99BBJFstjgHWKn9WQyQo7wpU7w/?=
 =?us-ascii?Q?uNOFF0EXrtbD/rbi+lWYs9crYnsduYmt41KfHRIoDYRjSUi2Ir3tAnaZFEBs?=
 =?us-ascii?Q?7nxriH6M6PAlQlZlrLPUENCljVG1+ksZs/MLkQiLhjUjdsN7EY2Uyo9BjVmT?=
 =?us-ascii?Q?7TWIhEZJmtals/tUk4DzqN5W51/MnZYIBk22MFIUmMtg1ib3SU3sOsENm9iJ?=
 =?us-ascii?Q?xyCfnq9YR8PQSNBJX7J9cMEO6pSEDzSuum9sFsCVChZ4KN5tNqwIiTFPT8HK?=
 =?us-ascii?Q?za+hBry7Bx8bF2MPxaPjmNtDTnIj0ZVSKLRRe8MPvPbiD+mKjQMTevhBvd1Z?=
 =?us-ascii?Q?BzUfAf2a1N7YqbvySBZBxVYMvC1iVYzuuAhYo8JXQANOIw8Zxvi3B+dnAivu?=
 =?us-ascii?Q?KpfZRRWPSA7+TcxoYO12kx2+T+D3NERRStO8A4jwWt+kwad/qV9K+q4P4VlI?=
 =?us-ascii?Q?r7f6l8sy+lUXzJe/cCwJgA5PLVYkhT7YuKMyx3R2k6aurLT3DkmHO1L1xzrW?=
 =?us-ascii?Q?MuCuPYsnuBtDGUwFbT+2b0fcva97IQ3LU2EmfmrIswXjqvD5Dx2xmO9DpCuQ?=
 =?us-ascii?Q?BWj6utWqQ5ZbPT56Nd1REpa1XLyV/8Gnf6l7iYzwWZPJlzjVYbFO5gI2G0cB?=
 =?us-ascii?Q?KzvQR1OrZhACosLj1WoMEQbuSr5fhFMwYgZsBtIG8868rgAmx5GV8r+lxBWk?=
 =?us-ascii?Q?LK2kKQ4BnAcIXstKRX21FJCGD0qd8EMwGyriYvwWm+l+sAAdl7oyp5KzYgqM?=
 =?us-ascii?Q?gVsPRQMSD+U4J2mNNJBmI4SLTb0M58HihdpvSkuZ1ppWRE99Q3igVMudtR5N?=
 =?us-ascii?Q?E+j8cBYENfeytMzfa6ej7TxN3a2bmUugEznRr6a/EyUyAghj36qU5ElPlwHk?=
 =?us-ascii?Q?auAdUQcOQhHaaJ3rtdJ0i4sGSgnbHNAzNRSKgHvPSJ4NCm38JSH9wojuLFKY?=
 =?us-ascii?Q?MPEyddRc9lxu6K+yAXKIfEqWuC78oAA+eRH5gtLMZAnV2MRo3khon9l8ypNE?=
 =?us-ascii?Q?ReIOrgvwk31TODIZNQMKAdinVbxaYizEAi52g8Ir?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee892394-a32e-42f9-e59a-08dbcbf57ac5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:05:39.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA4NSsTEnRDVwmPRUNwSx3CJPlziRDc1UDuVy74PFlNWstZnkMWx02p1Izm2Tvml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 07:13:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, October 13, 2023 3:10 AM
> > 
> > Also, we probably should feed enforce_cache_coherency through the
> > alloc_hwpt uapi and not try to autodetect it..
> > 
> 
> In the past we had a long discussion about this with the conclusion
> that user opt is the ideal model but it's fine to stay with autodetect
> and existing vfio/kvm contract for coherency detection until we
> see a real demand for user opt.
> 
> Is there anything new which changes your mind to have user opt now?

I guess, I was just looking at the complexity it brings to keep that
working.

Jason
