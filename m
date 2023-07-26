Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFE763DD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGZRjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZRjC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 13:39:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C6268C;
        Wed, 26 Jul 2023 10:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVq2pITEePFrze0O5ItbXDdggmiQznGNe3/sWI37q/aRtJhd9UlyIw5Mtu2OcqDFNGB6AHjyPaHC2i36bti91CD+Wt1LKDDBKuX/kPBrmzvlGV9uqLJU0lqGPr3+MAEXolkbBmNJal22d3agdjh4zAFm2T2qKTdnnf496K56GoIEljRYVlRNGmi33c5QQT789k7iop7wus/y0x7zrjzNTMyohBd4QrRVg/OVTZw9VR0SB5zmxeZlES71S5oFtT1s9XrGS10a39bK2QIT1sBmiGXOik4BQB2Zu4sg12PG6an2FRRIfl5/kni4jnVN6/7AzV1nX6r+6jWIS6++BXfXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R9Q1aIWYbfpfJHLcAPtpLnd1OxtRZ44gjxL5/d/5YA=;
 b=RDXJJ8gfMhu3XycxqHq2XH7sYNQ/7Z8g/4B1qIQLYStldOTe38tCrNhcRWbgoAK9tJQJ0wJ8o7MaeP+1SA5WZDw0Zv1jvLomUqwr6YqZtVskp6x2yMf2n2YxAN/NUksXhaSJCzlWeIGXJMnYdF7gCL3oJp1CM2Wbm2BSOVw2TfRyUVdAAFvLGlrltKTQviJRBic4uHfIBNhy3rizo20Dd5Lb2eGUcGO+YtE8kulVlCH2+B0VRRsta1F8C1+8LPwvpQL4M/Yf45o6Sw0zgiszbLq4/bpl2jsfaBKnOl3ylxLGCHi35gXg++FLP5ORJMEvtTAT/TLon/57SqZBPVjKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R9Q1aIWYbfpfJHLcAPtpLnd1OxtRZ44gjxL5/d/5YA=;
 b=kHNFe0NtBao47ECMesvB1UWH82e6utr4gI7EOFHsH2rT7lH813eClbTrzJgvHMH0WfREYaAGtnNRASLcnEKv5Teb0Lj+w8Z4E0PEoGztIVqPYfGRj0Geb3cyzOwnUXmyIBGhnpWtUmwx6n1TiYNfTj+gd71X6HFmm2Q/cy+k1893vVnWvx5drdhaGXdqpP/ShkSNcSwO1lGG6s+ucPlFZ7nCbf/qpvnk2tvisY9hcl/9DvQqny3SdrYMhuSKQgo1eKsE6R4RfCiPTvpIwTu3poTHNonjB+zTVinXQFap2XWwF4+PkdFPNKeNeG/W1MoxOAH0btQxEP2doaXH9zXcwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 17:38:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 17:38:57 +0000
Date:   Wed, 26 Jul 2023 14:38:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 1/4] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Message-ID: <ZMFaMCpLHi2S6UOi@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <064227abb779063c328fd79afc7c74dabdf2489e.1690226015.git.nicolinc@nvidia.com>
 <20230726113349.3dc1382c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726113349.3dc1382c.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc09748-01a8-4b44-3c7b-08db8dff30b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAPOY/pIEdQCYCR4MCmH1kGuKr7PvT4wzFiK+osjYajrg4oBNV+ibGll+yTL0nUz7TUn+q852VqQfhDHo47DbPyxk5/EkWb/uAMfgD6LpNyGKb8SYouHUhid0b2jtyfKHl4R4Zitca0T2I9Tng4XWCi6HkvsyxBsL4r5Eotg278wRZyVqa25wSkruycicFVR6mI19JRxB/O0oj0Ps7KHkf7kPd/AEpaRDfy3KXQLjQD0pEAnTjbWI2DoMlRl5RNDzueJkG/dxKPK9L7lflXMTuKiU5p9HjaEs1rFH5NchlwYBtZXebhF2UCFYdAKZ6iBbJ+g0mZJfb9vkU9ndX5xysHxG1kY4Kqw3yVT+FoOESOALQVmczdxjyYGVN02/d7jrt8zlbMcztf4yIOmtVXj8LQkLgDcndo6qdqeckYDfFyEc0xeMf+7Iu/W6mnQPcY5j/pp2Ao79UGiRGOUd2VRr/cmNQrU1dWimZSF0ZIQABMcKcc5MUD22suF60X1uaUgxOx1UZ9m9xbI+gAOs1CicbVoYO1ggrDRl/E/k5JxYN6zUbD0qHyYegYKTFIUJeXf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(186003)(6506007)(6486002)(6512007)(478600001)(26005)(4744005)(6916009)(8936002)(66556008)(66476007)(7416002)(2906002)(5660300002)(8676002)(38100700002)(36756003)(41300700001)(4326008)(316002)(86362001)(2616005)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/p+bc06i+D2u0t4Bzpf5Y0V4jY1qhToDMgQ7u00zpVRj64GdqxmI8CdnaUAY?=
 =?us-ascii?Q?PDzcDluV9/WI9+8nYm/SdNc+pTDpCmoBQJEfX88NkDddzyjAN3aTX/IaKS0c?=
 =?us-ascii?Q?SPqWiWDb/04AafwKd4hnLQjntI/MRomIBxdLTzu6SqvCycoa350r2aICnvFr?=
 =?us-ascii?Q?BXkMu+50gJ1dHbAWSJDUVPQxVU2jDE7K8uZpUCFUTGjdgl5+FaeUHFZweYPJ?=
 =?us-ascii?Q?ig9FGc8xAkL91dd4mZDdjrn20Hl7ff/58cYtFC8pxQ96Ue6a6iXjw3xTj9SK?=
 =?us-ascii?Q?apIvWQThCwzHYjcoCOkMq2IzEolMZG9AMpoW7RX+PmOzJz+ZdCblFXkmno9T?=
 =?us-ascii?Q?sOM45/sC0qIZ3LwOe/RC0aLuWBEFN5F0fXuDyP51f20MK67yzSoY78P8DV8r?=
 =?us-ascii?Q?97jQjVLpDuznhioP/Cqeu0zRBgWER0oe99S53kAyg80ZsI+NKDGBl2C/t+YM?=
 =?us-ascii?Q?qo5aV/M1tuo5Zb6qUd6NMc0AdqWuIvPEB8bHCJpkBJWGcnFz0hVxZUgWTybU?=
 =?us-ascii?Q?Exw74hqEX25xyG5bBDmV+pG1NCcUPO4/fxstUEOfUL2U0ZzNykjZJ6F6ba3I?=
 =?us-ascii?Q?dVVX5Db1NezlHYbH9Wnz5mmidVzMaG6xbIkfnwIKIjKGzjZAYLUTQoPoE/Q6?=
 =?us-ascii?Q?zIv5I9btIi1ZBFsSGgwdmih1x0cS87DqDK9CtBDyVi3nwnncNNBEMYOwj6ZF?=
 =?us-ascii?Q?br0soXtlqmE8+AVB2YaC+r743JCdrPZpRvAxglb0vCP61b/CLBz2GXHu27SP?=
 =?us-ascii?Q?pMeV6W5CXF3dQhA3i5eSf8W6jDJFiKmpnnHxi7JA+Yxl9J+5M24V8RviHUkl?=
 =?us-ascii?Q?J7DDFBXSj+JpbfwQzLqt60eiPe+4m8Bvy/bTN/Opup1buA80ypZO5UqgLADt?=
 =?us-ascii?Q?vFb2TTLOHZeMJgetTvN4+9hQWf74aj4wkqABdEDazDNAZZVU/DhRfyo6/DHv?=
 =?us-ascii?Q?2siiEV1drLjcYf6FPKKc7R876KW2N45oDwMiXZvd+jGJMJr994kdVFLZ9rCz?=
 =?us-ascii?Q?8KKUf5WN6G3sXuxOVdTSExiPEits43Mr24FAG2Fq/L9pF+yJsYBDPK1ePVOo?=
 =?us-ascii?Q?9kM7UM5PcGffwa7U2mNvzcWb/X+KqTySIRZAdn248tt3LW7CU9VI44HsnE8m?=
 =?us-ascii?Q?an5l5PgDcF+x54oi4Em7dZSKpYGNuYG8oexbCFyBAzuj2YWX+hErOG+vz1Zl?=
 =?us-ascii?Q?nrDsWdt5pmJSZgAOd30wgM9xb9ZE+yEQWBZy3liuFEmsFXZ6q1G3rU3cNuet?=
 =?us-ascii?Q?PBiVcsCVjUZ5M5M7VxhfeVCW3Y6L0w1qtulhZNvKRaE0R3WtOlR7LRsbJS0E?=
 =?us-ascii?Q?anwJtTKhW/rPLl7IMbs0ERHkAuXBMCresrd1pAySukDrhfdlkAL3GKXtlmhP?=
 =?us-ascii?Q?yxNTW03HvZURm7oV7rH1UwHadkZmZKbN4RUzNvGTWcJbA9vCY8+WxMm+iHvP?=
 =?us-ascii?Q?mHkzRlYW6pWj0RVW7y9Wvn9L4xHmtsUdbGo3WZf85jasKkawgDy9gYLhNwMA?=
 =?us-ascii?Q?1KvSQZlRddQKDXSI1b1GOpaWhN2CKs4+E9re7VmmcxAL/i+WauBa38f3g/Of?=
 =?us-ascii?Q?3OUEcgDHbMO7gYt36eAhrusWvyWNijSKNzYK+Q3k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc09748-01a8-4b44-3c7b-08db8dff30b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:38:57.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: timEHOnTyU6dpZg795gJAAG2INYJ8dstuQZBNeLNrdnC10Z55ZntVLRpVhIr24bN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 11:33:49AM -0600, Alex Williamson wrote:
> On Mon, 24 Jul 2023 12:47:04 -0700
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> 
> > A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
> > vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> > range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
> > 
> > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/vfio/vfio_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> I assume these go through iommufd.

Yep, I think it is next up, thanks

Jason
