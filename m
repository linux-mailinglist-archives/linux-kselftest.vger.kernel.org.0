Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0D691507
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBJABF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 19:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBJABE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 19:01:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B993E082;
        Thu,  9 Feb 2023 16:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMZ5dMLlHdvGL/FuNuJWpxvwz+jsVP8+HHn6RAGXZdXbMlorW1ihhP9N8Nmsu7bnmgoWAcyEnO4vnMFXRyCNmdMSFFI6TSULIyuDadZsaa9E3IDG3WDJO0Pcr2PzWnVjhgp/+M+mZjHhy2LLuJ1k7XonyUVktNYs0RTGM6PQcbvglkEZtEtfoejccv59elv5aL3D0GeBcDKmQMhpm9mmNv7Y0OgEKX6QwFZowY9Vc8L6HZEwG3JdhD6fYF+7OprCcIQTzG0o+JZoaIQw7X0I+qLPALsZvaNC472DwO7VITw6r1lm7jmyEGiJll2hRyick6abfVG0olw2ppn3h5Fn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jfCIiXPjS6zJVAjfPLlzPY4/jqpA1Tf5+nDQpCD/SE=;
 b=XruCfTqnMEvO8UtldFe+k8saTahmX/AantCSqcXdNdxFvk00a9k6YcrdBM1uOxvmhJ/z5F6GSwyvIVbZ1HAPQ6IrFYUXFNMmgtIwMKmOz77o/NxdG0t3wHR/aRV1TJxigyb3THnUOw4Fu1+EoTe9nlkWcUk9BZ/zjyX5lxgG/GxznaZ6DQEMIfccBJqQVPz9KMsNcTqXkaZs22OnvJMEdIlWiMA1kMhKAFF6pi9d8wl5hcDKwRCuNevX7DqmdexdWitvhUmg0iCTczDQyDFXppZr2ovEDScTK54dbaRhVzjS4h26UNz3V4zGPfG7hRXRPOjhPvuaTSIjA1Df6v8Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jfCIiXPjS6zJVAjfPLlzPY4/jqpA1Tf5+nDQpCD/SE=;
 b=D6A3fU+gwf4InJoilTBaCtllMzP96sk4Giec23ygjqKX+2m1gQDuD9mAxZ9/FWE9VKB/xbjKEbQR1qvAi6alS3KL59CVh9GEAnxKzaHTIKWqvGN2My1aJ0d4dPSPi7ZqkugQ0JuFVCxjS8Tl75MXu4Agakhw7KJ8L9JXlWoy8qSyMRYzyUBwfM0su/rfkeY4eA5HRNHpUP6Gu/Ryj+G/vR3lh8JbaBEAoeJII59BB/R5mZIn9lZ+PQsFCXzE0me8dPkvHp23kJSUH4Fg0HjtbDEa1aCCx17mIkhcsXAJ/9q/fqFJRVEazf36LEDak5K9HKQomkqZ1Lbp7EQ0aGLswg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Fri, 10 Feb
 2023 00:01:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 00:01:01 +0000
Date:   Thu, 9 Feb 2023 20:01:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+WJPH3pbYLIs2iv@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c66e62a-139d-499b-c3a2-08db0af9e506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PC9M6ERFnlt6RT6/XcpJ+lHnzhFqXPzU2NPMRN5Ylj9m0zBCZOUCuJmHl+2ApqlQ1jJ5KHpln5zdnOtMTVUzpPy5tnY3w1AxfvAec9C6Zfeeds67zdlUjva//s7qvu/fTrVd3QcEeYS7VD1W5yPkLVjO+SjYCX9wm+dHFeGT1h0nbJJs3cedM4L1wOewtIw4msoGVddp7Qi4P5KcjY9Nc2gNwHn5dNOE5/5EEYoJwmBYlMIOeADyMHN0IUTKb1uVZMVI9s3wznCSFoakSMQhifnNlCuKDbFvk8xI6dz40SMgGem4KEqWdLhbk46qJv9YECM+jghSbuSBuKtf6L0g9WhNT7faLkSqMebY8UDOZ3Evc+j/qpF1cEjetqwtNi0hWGx3KYNBhsaWkxOEzN12ZKJs3rqeo852lXCxAs7BwlyZXn8TdZpwN906HzlCKCp7yFpxu8SbgW0N+EiA5plOwgOA9+i7pThwdYxhgfUZSD3HieGDKGCVoXOVRPj+whnzZ4UpSI62RtEEUDd5/FlWN21CXtbFLygqlklyeiQsb8Vf7Nc2hJB3TW4pVZ1Hh1JgE2oJdDGoObtL9zUnvdDGmxBHEw2vdyRuBZuRcJgkgQPJAuxrSCKf2gvfLdFaZzkHZJKISg5gz/OLWImwU4sZV6e4+6ltMfZunAHdd++ULR+wUdfE/pNWY2nxOqCIliE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199018)(2906002)(38100700002)(86362001)(2616005)(6512007)(6486002)(186003)(66946007)(26005)(6506007)(36756003)(66476007)(6636002)(83380400001)(54906003)(316002)(37006003)(66556008)(8676002)(41300700001)(4326008)(478600001)(7416002)(5660300002)(8936002)(6862004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OR1occMZ9BTqFKd2JbUsoUuEALpoaGRDGwCzOD9fooq6BsaSNReRzLuG4U+s?=
 =?us-ascii?Q?8SccrwIp7wv98iGY3TIn005DB2QD2H1eCbONw5qoXJnevMgr3OvcXwcKyEel?=
 =?us-ascii?Q?I+mUmrCreTF7eAvNq8ARVBbfOKgwSCNRiEavAFdRrPF7fs4E+bkzGqFOB5OA?=
 =?us-ascii?Q?ppobOMZzqLBquSVPLT3V3WHrAi461vY7MXW/tG7xqhhtT+s1NhfPq0QxALdQ?=
 =?us-ascii?Q?O9y6APhpvoGDA39iqie7S/SOhla0OY7irBlAqXpmoNLLQK9POGQ/aoiJoDTS?=
 =?us-ascii?Q?VO7qBFRsrtaUvzpwEpwMwSKz1KEA+tDTjMykN8Ex/Rv7E7iQELP4AkZX3HDw?=
 =?us-ascii?Q?H6VGF0gXlQNeUkB2JchD9jo/ueRfT8oWtt7coSXLohOUPHL/EhuK/2qE3WZB?=
 =?us-ascii?Q?/JAF84+8LMi7+fJYZY4Rd+nMcI6/EQavqaEDDfn+qu4VVBkJRzNOIN4tXEYM?=
 =?us-ascii?Q?2kcv5JCZH1ZJNGBGuEabaNJ2XTNLK7jr0fcYAoWzKA2dbQwaTaom+A7uT1NS?=
 =?us-ascii?Q?kwWZe3cLm6nKWJVbiNB2LloaS6eQGrpl+1iFDvrTzDd1wd4QG76kXK7c+2xy?=
 =?us-ascii?Q?TkITFEGuGmR0SUnD5LkmOJjTZuKFMF313Py01stEYSfOAy5kYXUsWAdKQHto?=
 =?us-ascii?Q?0Rl0+mIEL0WtYxx2RORpUaUrvei/hhS7L7kQc9He0zNWkfg0LFMlfQJgjU4B?=
 =?us-ascii?Q?DJRlHu9nPB7EXtigkDjizuYKOxXFNy1Z3gAK6FZtj2O8hJ+Wj0RY5QSyYU99?=
 =?us-ascii?Q?/whaaPoc820Emu8ZrcyIXfd3cpxkoO+cAx7EeIfErnoBBrn7s8PG/gCJukMj?=
 =?us-ascii?Q?mgMOMMjgRmUXxIEM8t3vCDnP/JmpqWPfvyON2E3QhOsaIk5KsjA6bb/AkVlS?=
 =?us-ascii?Q?nz9sp7dV2nNI7J1Rq13ADespEaNKjeMwPOHBzsbqaWHMtWDEKUw2cBCPPdHN?=
 =?us-ascii?Q?gppcXwiwJat1nmfOj7lkO6uI+n/2L+cf1PlamnCKjW6w7i01uUR+ddkaQkvM?=
 =?us-ascii?Q?7M+sNakjQcoKQqLfb7odNJ/hhC3fEMXlecZi74FvCyns1r4jfegFDpAK8ihj?=
 =?us-ascii?Q?vTRH/Vn346Hq+5wBapzP8gHokYR8SbbQr8hia+cYyst7lUMOlH7X5ZXVvhLW?=
 =?us-ascii?Q?JlWrA/K7LpXjYrCKolk0Z3Eq6jUCNVxLwNrK4StL2I9RBQ5u6FtGKEKdr4h/?=
 =?us-ascii?Q?cnM9XOenjy0N2U4P/tCLK2fmGyyVdaWHPVJYQavKa2U65y+aXA6deQosZmgO?=
 =?us-ascii?Q?zcc/yOGhEFIZ7ah9NZK+kiGgF8T8NHuKdZV+QVv522xVK1GEy+EoeXuf7xdo?=
 =?us-ascii?Q?9ZQKNYqFfdItStK2SGAUBpbN54kChfiof9KEa3tYuXS5aYhjYgsjrIaN0PDa?=
 =?us-ascii?Q?LpRM/oV9cBXVHPohM6b1B2/v1gPhAhOWujt7Sf8sDBj9rMtVIJP6K9WuKFPE?=
 =?us-ascii?Q?kJ1Cwgs1rDoEsPtC4Y/qZvbSMEEy/BEJFGtLsRfVu70uxCtzNNucXx28rN1A?=
 =?us-ascii?Q?qZOEtdCjqVW7RIs48y4mmdqTjUTED0GWecfYuzAAueoUqyED0FbRNWDqZkcH?=
 =?us-ascii?Q?W6Ri/nXz3ZXTndEyX6LeJxqVlLMS8GdIeamFh2/t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66e62a-139d-499b-c3a2-08db0af9e506
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 00:01:00.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSrIT5fqbrsckflnsTJ+mptT0fS7vB4PwP2lbZ4D33Q/rot3RFQMUmlJx5Pe4FOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 01:13:07PM -0800, Nicolin Chen wrote:
> On Thu, Feb 09, 2023 at 04:00:52AM +0000, Tian, Kevin wrote:
>  
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > >
> > > iommu_group_replace_domain() is introduced to support use cases where
> > > an
> > > iommu_group can be attached to a new domain without getting detached
> > > from
> > > the old one. This replacement feature will be useful, for cases such as:
> > > 1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
> > >    table with a larger table (PASID=N)
> > > 2) Nesting mode, when switching the attaching device from an S2 domain
> > >    to an S1 domain, or when switching between relevant S1 domains.
> > > as it allows these cases to switch seamlessly without a DMA disruption.
> > >
> > > So, call iommu_group_replace_domain() in the iommufd_device_do_attach().
> > > And add a __iommmufd_device_detach helper to allow the replace routine
> > > to
> > > do a partial detach on the current hwpt that's being replaced. Though the
> > > updated locking logic is overcomplicated, it will be eased, once those
> > > iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> > > allocation/destroy() functions in the coming nesting series, as that'll
> > > depend on a new ->domain_alloc_user op in the iommu core.
> > 
> > then why not moving those changes into this series to make it simple?
> 
> The simplification depends on the new ->domain_alloc_user op and
> its implementation in SMMU driver, which would be introduced by
> the nesting series of VT-d and SMMU respectively.

Since we are not fixing all the drivers at this point, this argument
doesn't hold water.

It is as I said in the other email, there should be no changes to the
normal attach/replace path when adding manual HWPT creation - once
those are removed there should be minimal connection between these two
series.

Jason
