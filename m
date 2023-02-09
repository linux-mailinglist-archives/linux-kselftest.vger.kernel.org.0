Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81F0690E16
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBIQN3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBIQN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:13:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7128D00;
        Thu,  9 Feb 2023 08:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPlTIkFWKYT5DOHclmZiPOEUscp75sMFvH/VVkSaa1PQOQCAo1GHGu4+j52Xs5i4kLHsZ0HkTkLjiDIYgj68Qgg0euNyBX4YtR2zaCvcHOJNqNsCZy7tgrCYzESYz/kpDQ137HGLLzO9kyUhYVvfaEiYB9CvWu1ra5PMnJ3rpDdi6RLjVmiXZDZWggiw+Ty4yyLBa9zfDo8ldSgKMvCkPB0ZAh8SFtRb0vn4sLU8rgmI+5Y7y4ljmxPouJOGesEY8V4r0s00FSmSRKRa1d0safk6tfcz2YBffwzC6NtPKERXz4QuaiDeOsi88JLGIJ3W1yghucGryjikmiIy/kNg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjybDoFwTPC+HW+o24q0Yc8jxnxcbk+SX6kAWQgP4Zc=;
 b=Xz8nZ7aRhXZavL2tKhYxzw6jPU1oF0ZzI/X9B/Xw477spH1zLgDNsFbpIhO13jOKHoVB497AqMiIk8w4TrXjwTdqwbYVGCfgasa7syP8mmCA4eU3nrE7VG3T6A4HNaYA39m4ENzeD8by+V7fjRAZ3Ci9NNm49jpm1yBSh4MS0AASDMWvnPXUzZ/aCij0gEQ9OgaQMdVp0NbeNq0vaH0l/4XfYviCfqAscOwDVYlRSnwXmfLFbxbG+L9F1CDmDrF9Ht5ia5DLPX/0cHnjZ3187gmmuuOcmyWs++bu6TDG3I844IPVvt4J0Jm8gasoQlMX2JJGPqC6qiTHb9/UvkIzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjybDoFwTPC+HW+o24q0Yc8jxnxcbk+SX6kAWQgP4Zc=;
 b=VSXvKi3AA7Gnppu1A4x/p4/eTvStKZi8O/iP52FkH0pAbV+l8SspO/AFJP1NEI/JmJGTCbSS2pOXrICQA2etIKGigdr7AlXN4WBg4gklVLvQUlcaVWWh6LtjJoWHlhG+MwS6YdR27EM4roywtQnVGkEWfrA0v20qYPrl1n8o3PjlpTwTNqhKUvugK5bnMyliWdTyZuUVHJtXFIMXx2I0Ev7PuBmbRbtS+q1peE0PzSuW6Lw+AIuiJP5Czv0dMzBPUuzbnWW/XseZYoO3D6H5n1c/GVsnqnEe+ICqihvn/JZQ7MkIdlO5tV9or+YEAMpHT/Z16s8F8oh0SJauBfmF4A==
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 16:13:23 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::97) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 16:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 16:13:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:13:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:13:14 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 08:13:13 -0800
Date:   Thu, 9 Feb 2023 08:13:12 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: Re: [PATCH v2 00/10] Add IO page table replacement support
Message-ID: <Y+UbmJ8Y1lT/mKSl@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB52766A6DDAAB9E80A5830D038CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766A6DDAAB9E80A5830D038CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb1d9a4-7857-42d4-ed08-08db0ab8914b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhFG7Xx1tmiOw/ayHo5k3uKGuaoFoRi0u+6ST0df/N4T4uPYXOl2FsDQbjIGSHMsFFDFsSPTvX7lXJHt/qMTlh3AoteFUjDaBBFKuKYddQrEwZPKCbzzW9Ec0idNnLV1DOvMByI+cSMrtmXU8VdYQ9/kGf2li5str9y9lbrF2/tnLVcIRtQHH6C9l9PZrbyU3ir8AWFe5hoZ/+HgrvJboXR4jhliFpKuTgrUzASVWVmnyoJNo1LpCXYJWfs5+Sd6l+staQosm460K87oAjMFEkw3MrK1c+jqn4ymPhsP+6kAKDCVjsN1RdrINQHERa6Ib2eEuMtffBVitJb99sjUtj0xhfeGXvn0ozkl9aPUPdLeCjiovaqig/ZLpdr4pchTKsYjCt+XDogpE90tD/nIZYgOzaBBaETIgpeaJ2nBo4a/Wv9lG8qQy+O9RVlub4iGqRdHNN3/7jXedVnHGwxa3lL7DIeQqsLa4tnrUZHRce2YhAgnFp21tBrsm/OeZwSyCrSOuj1Lst8n6+9adP/OWORGU9SVfWYTdhS8x2A8BYmckAuGK8Mi94BNEzvHvABZBBsDezNylKnyUi6uYyahbJAnY2YeQ8P/PPtFltlhizGG3LCZzcp0YhEbPiefrNdGKgbMTmFTNd0stZ5KOYCWGEeq1oVPEHKcxwYcW6qrpszeVDDdCsr6CNZE33mw2wFTY+56RCObZt02k2IbuYxR3g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(9686003)(186003)(26005)(2906002)(7416002)(5660300002)(356005)(478600001)(82740400003)(82310400005)(8936002)(41300700001)(55016003)(40480700001)(47076005)(4744005)(8676002)(36860700001)(336012)(70586007)(70206006)(4326008)(6916009)(33716001)(86362001)(426003)(54906003)(40460700003)(316002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:13:22.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb1d9a4-7857-42d4-ed08-08db0ab8914b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 02:50:39AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> >
> > QEMU with this feature should have the vIOMMU maintain a cache of the
> > guest io page table addresses and assign a unique IOAS to each unique
> > guest page table.
> >
> 
> I still didn't see a clear reply why above is required. Please elaborate.

Hmm..this piece was directly copied from Jason's inputs before I
sent v1. And I thought he explained in the previous version. I
can drop it in v3 if that makes you happy.

Thanks
Nic
