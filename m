Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079A3688764
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjBBTOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 14:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBBTOv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 14:14:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8122A0C;
        Thu,  2 Feb 2023 11:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYiZyLdOdY+0KM1aXTlDosSI0Ov3cQVj0ZD193/yiTQnO7/QXPx2vWXz6kExMe4LyKWNMZISlxhMqmF1bspBK6DjpZ0UzCwT817XzASAoFOzx3eEAyd+G86WHdIuRBHGNpaBUsyMQTqNKHKNzLn/GbBHgU/4Jd881/HL6D6kEoAnBI0D71EJtEwi9vkyzJmbZjJZ5r9bspepU3hhb6FRhLgDXj/PgRqq5v5u3nfIIQPv+FxfVanBPTcC/DbYfKW8Mu4OFgAdgk5LvCWoCRU8GqEjUvPkoWMYueDFarKIW7vzt6TeZvXWMkydD9mcWjklfTg6e437ug8RMCXM/zCmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayK3m7LFcRxlCJnKnJ5T+qisd0sWgO95paTqhqMb8Ig=;
 b=A/IcQntpvtgcHwZahQn4q2vs3O/hFu2Ryw0UA7sHMvyy3hSh7u0IIF4Qg7h5ySD5ellGvJnC/AjxtGr/TJqSRty+lxF73mYTfTKDicYx6PPFMTXij49U9/9JiQetZAX3oLjlx1Uug48dRx7RdRnW7wkaWkKIQjA9OaTVXhQrAFLxczS0CMx2FQT3B7j1sLH4szFmmiYAEQ2vuJf3Nk0g20g/3r8pEX1NLVgyM0YVqmbQZDz3q9tsVNWd8QMMtWxzFgTu5sP/Q9cnS2njK+QLKx+zRP1E+3G2XyCkd8lDHrWjWes/l+O/8HuDIAkb+3Nswr2ZgXJFgNeNGMd6ffKigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayK3m7LFcRxlCJnKnJ5T+qisd0sWgO95paTqhqMb8Ig=;
 b=EFa6cj9xp3GmeJ5cikCUNpuYja4esq4jV9jIBqzaXTyZa+0DwYxXhG1aWi+IAaRukcYN+8OkXE+u8NvwNHSfBuikdBL5XeLl3Ns7SjUWvg5ZUV+4a5z1mR1vB1LdSUVyDe4THIeKgl6VfJq0wo4WybxXWz1LQg/xkeEBUZLLYr1iWbfE8ZB4OgOUMT1NXYCoxKjNrX2TkbpJVrKJnsNZuzYb3K95AmUBvHOF5Rq7psgHH5Ps3tzUlJm7tqXjU2xlGSl6wcGKYdLaamrPoqrdYq3PoYU6/PQShpzNPgV2P/jVYTJVunYnmjGrtzYCDdkuZRBYtRdzxNViJUFFud9p7Q==
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 19:14:48 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::8a) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Thu, 2 Feb 2023 19:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 19:14:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 11:14:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 11:14:35 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 11:14:34 -0800
Date:   Thu, 2 Feb 2023 11:14:32 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>,
        <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y9wLmBZzkZk2Mkh9@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <d5147b2f-4698-b39f-e956-84db122e9822@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5147b2f-4698-b39f-e956-84db122e9822@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 379f8396-f1b4-47e0-390a-08db0551c060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvA6dib1McixQM5sYotFV4L3ZzY0yyulQElCH4/TPjJ06C7eYFlHV0/MA9xKSpRbzb1GjokQDj1/8Hb3fg8JyqYSVx3XCbw9XLn3pw+9fI5rCcTmr3VIBu8SJPXpk/MSNh/zVDqRr9QhjR0/iUZLdiUAqSBsy9x72buyYcgROUcgbEnUEgB9+Xe4S3gq84l6JQkSv/1HgedafrQlxTA/HNW89KRXDK+SyVVqmBZoXoK6QlOHnwJTbZxeHLatWBwaOtZVHs2Mq9AqaBmaPI5h1F3Jv3xHIsYaq9zYhMdFYLLjyE2HFML27LWsOCc23QV54XH2xQZJ5VS0E8Rb5RDmt9oJDRAGpT+aa9kHkvIl40R2e/gz5L+HSCCQpIYMvHvmbWpblTZp7L+3v1hGFh394iJuriCLsMGU8yC3Dikl79BvRq3CUnoVBuf74ByfmoPHdpxhxu36mgLO8EYrS4IWdwi7AUnLeyEbyyYLLEr1QgNBlhAvVcHHg0r2JkBcl6mpD4GwMVJTlf0AU4cA2tmXPJgvygiSqRxVs4n8IRjvMGa9vIG49zHjZmEZgMTlJmwgupWn+R5Lj7bm35gxHVon/NrHzFjldb5bKgT6zZZXcx0mn42/Tbprkzl0dESqCgdAJ3299frdJnNGxrQt42pz2baxNceri4bQeafuMrby0fC6Nivr53ndD2jYDrHOurgH2ex73gZ36WAEF9W1PD97pQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(33716001)(356005)(82310400005)(40460700003)(86362001)(53546011)(186003)(83380400001)(26005)(6916009)(426003)(336012)(70206006)(70586007)(9686003)(8676002)(54906003)(316002)(4326008)(478600001)(2906002)(7636003)(82740400003)(7416002)(40480700001)(41300700001)(5660300002)(8936002)(55016003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 19:14:47.9047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f8396-f1b4-47e0-390a-08db0551c060
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 02, 2023 at 06:21:20PM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023/2/2 15:05, Nicolin Chen wrote:
> > +/**
> > + * iommu_group_replace_domain - replace the domain that a group is attached to
> > + * @new_domain: new IOMMU domain to replace with
> > + * @group: IOMMU group that will be attached to the new domain
> > + *
> > + * This API allows the group to switch domains without being forced to go to
> > + * the blocking domain in-between.
> > + *
> > + * If the attached domain is a core domain (e.g. a default_domain), it will act
> > + * just like the iommu_attach_group().
> 
> I am not following above two lines. Why and how could iommufd set a
> core domain to an iommu_group?

Perhaps this isn't the best narrative. What it's supposed to say
is that this function acts as an iommu_attach_group() call if the
device is "detached", yet we have changed the semantics about the
word "detach". So, what should the correct way to write such a
note?

Thanks
Nic
