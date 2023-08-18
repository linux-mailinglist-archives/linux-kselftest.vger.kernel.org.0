Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE6781111
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352543AbjHRQ5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378835AbjHRQ47 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 12:56:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984F2D64;
        Fri, 18 Aug 2023 09:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5wfBvpo91LXlhAGDQHrqTpwOvpb5bUudqSg9ze9ZKRC2fUQXtid/W9L6mjbjJFtPUxPcb1rIagdKuASYb+xihIhHHL3vZbqN/3EILvyh6OZaegMih/+lZp7DvsOJnZzMTvL61smYrjRtic5FAIQLT1TGLmQkx4ksAU0KFBvN3ZH4HIMUaoBFtt8F0ogwsOsNSp1wTKdmTy+tvaYqGepmwqnuFp28edevCFN29LKoX8s4nlQo9CZLo6M8Fk7A7PSb0vC9yKAikCpMODJgULFUqrdW3TRswFoXgaEokGs7+ysdR1gsrP0QvYb4fP4pNzuQMXlodEh8abDiCn1ISzlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyv2u+MO5hS56Dx6Omjits9b0k5qYOLD7cF9Sd2Uc9I=;
 b=Rd/sZQrh7PeTn6NJWJtiV+0Yo9aqCLlWrVCT9AgcUkS/P0+q3GHxFi+hGD48PLLDBa99s/yzlcpTJFt1SC/lIcxhCW8ZAMkRaSugrBVJD6joKZ6w7LvuY5ZEAlnFAiGJcJkW5aaulcUWy40CxD9RomH9FxA/ZJwXrgSeJe0V1lLjVMdS17fAbHPfv7NBFPYpeQS4be4yFGJrxu+lwTWPSdLOR/SRQpz/u6rkenoXa9QFJJzRx+wETd64oVpth0WWfMxUji1cIzsoSidx6YpGsVa7PqRxTIekYuR+hpNrh/tmENaLlPlp8rOVbLeRWdbFvxLqtll2DpSmidDHCJ5ShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyv2u+MO5hS56Dx6Omjits9b0k5qYOLD7cF9Sd2Uc9I=;
 b=fInmnykUX9zSvIIpg8BsqL7ePKwnRT4b0iHRbbkr0BQOS6AtHtSEgOuiXYdcV5Pg11F8SMsPqwU7GKeZu57gM4ZZ7ABOSioGqvWUI3EPkK2Naj1N/G3wqPUYKppD0glX5+VbZ1NqVqVgofM79kVJ5E9y8TF178uVPMYbRkH5w5CD2APKa8dEfa69QY/rrWzpIV6vHXO6kPfcNsO5PLRjdFLN7fgmfW47cNMU4IdxHXRjl9J0FSZu0LEKFqfuU/XU0fekHVlmHjfpj7zFATMqTK+xQ9IXkLafaa+iq0Pi4ModVaPb/nqvR7IJH+kLvodyNuALNfzBABbk7v+j7AHI6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:56:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:56:55 +0000
Date:   Fri, 18 Aug 2023 13:56:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZN+i1pEoN/NsWPKS@nvidia.com>
References: <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
 <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0f7aa7-d3a7-4f71-8b1a-08dba00c20f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuyufBMolYO3jOMB8ouog8hyHOMEnVHRKIwldvwHd9WWvGntX19UdelaIhAwrZ2gmZdE2HApxJDNdd1ShXcAabgwzxhyhUg9fHEb5KtddzAj3K9+lUq7Ru2FdqhrPKECUlh/sQnpDJQwuxJ9mBAV51wDbfQv6OqwctoFn2q5xaxP4Cl/yK5GWm/hEjXB2QhJW9y8zYS7T7uXpy2r+E59AcVQvy9CIurzAVRRe84dhXRpJPsVqaMkxHpiJcYYagpXNcWahz6J5iiGSvjASjXS1Vu+E8to7hjCygHC2Is2E2jUtQr4QUsuD1ODkgUtbVR1BTvmGcvFjVLtBGqC/G94outGSOcawYTT/LTrujzhk/h7c2y23x6dVl7kBTMr09GkQVmmlEl8dgZ7/c3gJ9pjZdu1E2UUppemixy2ULsZ+bVIT9+DHiB/5rs2GcjPtBriFJ+NKXJO25TQd5seMv1eeisItpXcOTl6D8O36BLOIudYFPd4PcTl2/twwgt46Q+GHcNFUUtbNZLv4xLi0wmvsZBKucVmoImHjDOqPQvnpjdJu5NSbUeJBIXO1ILwvh5p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(83380400001)(7416002)(2906002)(37006003)(478600001)(6486002)(66946007)(66476007)(6506007)(54906003)(316002)(6636002)(66556008)(5660300002)(2616005)(6512007)(4326008)(8936002)(41300700001)(6862004)(8676002)(26005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CtImy8Z0NqJD7Sv6+DvR0VnkR3b3rnpPsbN4rn/8U/1Y/gn8lKUWsnGKiTDS?=
 =?us-ascii?Q?PMb2Cuy8ZxAByBJ8lbJpPV4PFpdAFBWzdA2j5h2K2Kjy+9oG2YOtS42dUAU6?=
 =?us-ascii?Q?Ooc6T1ghTBneT9awwCneiOC301/QpGHHTGqbM4dh498em5XmqXskxrbyM6aZ?=
 =?us-ascii?Q?n0K/yLkFhoXNVrt2g48TAQJw0D5gmJ70pspH6q7s8HET2S4FEDs+BU2U1y9Q?=
 =?us-ascii?Q?uVBlgbxe2az9FelP6vgQStosNA9HCGz4STADIRC/erz7l8SL7ZmOY2A3b79H?=
 =?us-ascii?Q?scT3O8jDDfGIIZbf3PHBknK0uzSZBIs+5Seu4n6jNvKR6sNWvDHxjQJX6lRN?=
 =?us-ascii?Q?4lyWt5ucw7b1bMZMuFmw9wFkrMctZcpRbeF+9RsfdoAuF1wK7qs/dR4DNVuo?=
 =?us-ascii?Q?Bi5ykQwFkSmPFSLawWpmPStG5hw79m+F8SkBf2PcGr5atWawB3txOb5pUE/L?=
 =?us-ascii?Q?bC0MQdJFV7HhU8VGBTjLPLLIh7v1PORzgPkUErstHkM+7sQI4jHAhlII72ve?=
 =?us-ascii?Q?lDPPZbEvZvGCtewQFSi8v/dShbah71CKuRLIyuQTZ0fTbVBy115PkXAu54K+?=
 =?us-ascii?Q?Lw0mvFgeNlRStFQlOUXwiiYnFrCg+JGdSNNRyh3B6zgEfoOAl3mpHdHSG3mV?=
 =?us-ascii?Q?s4VMgv1f9pWG5rQP85/qSO5CoTparU954nschp+Qgw/KsjQ0gk0mcVybYQ+9?=
 =?us-ascii?Q?TM0m/2XNFaYaheWqI0Yz82E5+8oaZWgU0a+bKTjd3svPsZula8I8CKRCRJG0?=
 =?us-ascii?Q?TSgj7zzZtcHqv1tmKUJaCWoNw48d3Np7gF3mHzOjsd2aU5ZIkGuDFxSXJ/XV?=
 =?us-ascii?Q?wYkkJ2EGJqzEVBUaRrLoJ//GRUZpvDKDUboQmqPQeYFtI0AnABItQdF5WdQz?=
 =?us-ascii?Q?0DJsfmLVx7GzmvvjRC6wAo5nIg4m0PpMjRlQQIf8qSB6RVNJmdH1X8zHHztr?=
 =?us-ascii?Q?7PhDKOzTunafg/1/a8A9LsVxIW72yhgyYE+DzUCXyWFbZi1SExx92thEuoVR?=
 =?us-ascii?Q?tO9J5EKFrVt3XIPGRCqzvTw/NxdXcgpK3kOmY68iGbx0Wz8gPdZp5YzkY+Rl?=
 =?us-ascii?Q?6RnG5qx1UeI9WTia3+1K9F+bWhJX3hX7/juN/xUWTTc1TKRpONIWx+mHV/iM?=
 =?us-ascii?Q?efvh0Yoqd32I6Fi3y7zey8W7I3fowLgLeBti0yQ2kueEZWgH/ouMuoqjDAPA?=
 =?us-ascii?Q?cmotoLovwHYS/JoHs1GNCaHdjh8+cLKtXPSP841xaWuoSWDw4GT4dpkOXEtO?=
 =?us-ascii?Q?g/bQ0zGLGMrRRtf+bRtA6g2X5iXldjHOiQu/GGqdCEeusXfS1VJ0sU/i8EGY?=
 =?us-ascii?Q?c9Xxzojyk6cAnapre20R+P1/3DI/dIqynQ73FKGbpLbjvxQbXPFLfaVgOGki?=
 =?us-ascii?Q?+Zd3FNZ2YswlMV2lwpX0ucvva0sf8K4FOgHfKw1MoKCEQrXUNx7mNeXjQV2t?=
 =?us-ascii?Q?UFvv8ngl4JieBU5H1Im+QsFmhBiz3qoXuXAtkWyN7w/TwZ7zmkF9lBGqUZ5D?=
 =?us-ascii?Q?Fo2fB3eyDvJVs83h3P77PkUUHcPC+LgWlTq9xKi6/pyO8lZO8FovqsNBQIDc?=
 =?us-ascii?Q?zrMcZDqpX3OLpqz0OpEnJwrljL5RvHXxAdorctYO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0f7aa7-d3a7-4f71-8b1a-08dba00c20f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:56:55.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCYw00OpWdwoTXUZK4QdwnINg3BKY7hyCi06h5yvfRjxiJss9ktYc2a8bWFJH98d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 11:18:46PM -0700, Nicolin Chen wrote:
> On Fri, Aug 11, 2023 at 09:45:21AM -0700, Nicolin Chen wrote:
> 
> > > But if stepping back a bit supporting an array-based non-native format
> > > could simplify the uAPI design and allows code sharing for array among
> > > vendor drivers. You can still keep the entry as native format then the
> > > only difference with future in-kernel fast path is just on walking an array
> > > vs. walking a ring. And VMM doesn't need to expose non-invalidate
> > > cmds to the kernel and then be skipped.
> > 
> > Ah, so we might still design the uAPI to be ring based at this
> > moment, yet don't support a case CONS > 0 to leave that to an
> > upgrade in the future.
> > 
> > I will try estimating a bit how complicated to implement the
> > ring, to see if we could just start with that. Otherwise, will
> > just start with an array.
> 
> I drafted a uAPI structure for a ring-based SW queue. While I am
> trying an implementation, I'd like to collect some comments at the
> structure, to see if it overall makes sense.

I don't think a ring makes alot of sense at this point. The only thing
it optimizes is a system call if the kernel needs to wrap around the
tail of the ring. It would possibly be better to have a small gather
list than try to describe the ring logic..

Further, the VMM already has to process it, so the vmm already knows
what ops are going to kernel are not. The VMM can just organize them
in a linear list in one way or another. We need to copy and read this
stuff in the VMM anyhow to protect against a hostile VM.

> One thing that I couldn't add to this common structure for SMMU
> is the hardware error code, which should be encoded in the higher
> bits of the consumer index register, following the SMMU spec:
>     ERR, bits [30:24] Error reason code.
>     - When a command execution error is detected, ERR is set to a
>       reason code and then the SMMU_GERROR.CMDQ_ERR global error
>       becomes active.
>     - The value in this field is UNKNOWN when the CMDQ_ERR global
>       error is not active. This field resets to an UNKNOWN value.

The invalidate ioctl should fail in some deterministic way and report
back the error code and the highest array index that maybe could have
triggered it.

The highest array index sounds generic, the error code maybe is too

Jason
