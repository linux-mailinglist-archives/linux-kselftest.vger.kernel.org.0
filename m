Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85F688CAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 02:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBCBmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 20:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjBCBmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 20:42:04 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E3A875BF;
        Thu,  2 Feb 2023 17:42:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPcv9JL+zYuxf1uFkUvDrfd8R52TgKBx3Of/5vZcklK0kuecxK5T2JMrLbOK3hZLL253Bh9TdP+2Tc/gO9flob03UM/X+aSN1CUImLOrY95htzvlet2+1ptFIhTBXvutheOKGWl0way+X6veMyZ4l9w+4lsZX6pc5d16IzjX46r3VHj9ZmpYh/7YqWnQTqSrYqxXKm5up8rjRhMHp5LwCFaZv301rKQ43CUMdC9tw1E6RvlNXqKRNwmd2rNNgmsmbS+U3tTN3LfA95AjxQVwtoPLi4p1LsJnbLFg2GfsFnym86Azbb7He0PQnpbzA83b4ceS03Zy7smeJc6e8mfphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUMnkjHfhr9zF1Xjh8hLRI3HibDx1bvNnoEG+R3HSo0=;
 b=CyCtZxSPpJjVkMdgAnNBFi3wpJ2zQx5fXqWaeN/LWx0mcGbtzyK4xePzQMT+KUgXllWPmkQnGgqj4f3DZIAYHMeUCwckCFg8D8osbxajaunpO4dGBbOR4qfvHxpdzhqJh8CZ1+HUdN0YJhtFEDHnx8XPMmFi5LZ0uvvt7rww0rzEFmIudbIM4B77thp8BWm4DlfydqKgEDnckcLNx8qcxwFVGRw62x8REYTQEE85yE+egpD6wKCGnlZDnaEdsZ0SapR+hMnNcnp1T+CYauKSAgeQ98/6qfcPb++xyOJWLIt3FyBLODoQ5iOd8CdT0ASMYeqdLdIbAFew5E84nW8XlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUMnkjHfhr9zF1Xjh8hLRI3HibDx1bvNnoEG+R3HSo0=;
 b=rv5Lg+18NrPBZaBcBJyqaAzTXKyE4pltqTIyr/Bj0dLsumIFrqFnYqnyLAAD2OoWDYqUDT7kN2Bn+/O0U6/wldtf0u2ov+nd1DpsAikdzCFYWqzoH9wFs3CBHKlFJaJnZTe/bH3F3Uvmnmi0k0bwp7CjYWxYktzi5iKV0QbETdC9B9CBp9BUQjpof4O0NeE+P+Ee/3/nZdnlwcQaOWAn2y79XSXooWDqhK/+IDrOs23rkB9EabPZ5/Om7h8bf18Y5RikzjRszdyVPE0QDd4zFe5ak12fSKjEi6zbpJdpTmdicQJeKAOmvwzZBNvnn+/9MOT3CfVz9S4LpT/JezG/1A==
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 01:41:58 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::8) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 01:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 01:41:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 17:41:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 17:41:35 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 17:41:34 -0800
Date:   Thu, 2 Feb 2023 17:41:33 -0800
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
Message-ID: <Y9xmTRQH7wjb07gl@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <d5147b2f-4698-b39f-e956-84db122e9822@linux.intel.com>
 <Y9wLmBZzkZk2Mkh9@Asurada-Nvidia>
 <58837041-c0ea-2c65-4ed5-6b2d2189415e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58837041-c0ea-2c65-4ed5-6b2d2189415e@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bc3783-6553-4002-80f8-08db0587d621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HhV2VOXY9+IntXFx5zFNm9Kv47UBnxifIdcO7NtRrmjvtaNItQw51GO8sB1f3iPyu1BaYWLuOEXKatwVCT8iszGwLdLA1GaZWEzdfQfK6vVPH7flssGPfAA+xV7fm5CXeFVWJ5NVmXrcnmYKQVqNwoE+HYpHCz1zqkOyxamKnx6ZzbdG21NYTfUK0f87Bdmxa2c/SG9Q6myhCC9X/cpXdOTvDD9PYgOuKPgIEUeGZyyfIHGuPnnkizKAoBxUH1BZG+4HCnqn08+OHeqUnOgZatmZhVT3mdb6e50y4CVinyd++FjtOiAQhugE+5cfHuUm04eW7JL0mpex0NyZHuNqVJma9fVRZolW71GlECbRqNq0M1mklnUvtvU6WCv1wofD9dW+Jv1CZIwfaGZ02/LXnvy8zRhx1f8gHraVh14W3Q70HieEavICMC6XCWRPPXk3cLR/sWTnh9xGUy+CVtXsKIq/GA6r9ZLa1qQKww5a8GOgOO5uNBsU7Jn39ku5HlF1KGQMT2lktGf95jSpi6QdWPuolcZnMxVbYd6T7Y1hFvBE7Juk35/gmLGLNCPD9QkNB9i0Jv1LpEW+WOfc+VH8jADdVmH5Em3KF2hVySGaBvfOie9hjjIRjtmJtp+HxhHArGafK4awb1eQUg+8kI73er5EfePtbyaaqph/gwHge46eZrV5qDsvhj/Z+IkpyCKmPMXsNtlsplOHyZwraw10A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(86362001)(5660300002)(336012)(316002)(40480700001)(83380400001)(55016003)(8936002)(82310400005)(54906003)(6916009)(47076005)(7416002)(8676002)(70206006)(70586007)(426003)(4326008)(33716001)(478600001)(82740400003)(26005)(186003)(40460700003)(7636003)(9686003)(36860700001)(356005)(53546011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 01:41:57.2425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bc3783-6553-4002-80f8-08db0587d621
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 09:33:44AM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023/2/3 3:14, Nicolin Chen wrote:
> > On Thu, Feb 02, 2023 at 06:21:20PM +0800, Baolu Lu wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 2023/2/2 15:05, Nicolin Chen wrote:
> > > > +/**
> > > > + * iommu_group_replace_domain - replace the domain that a group is attached to
> > > > + * @new_domain: new IOMMU domain to replace with
> > > > + * @group: IOMMU group that will be attached to the new domain
> > > > + *
> > > > + * This API allows the group to switch domains without being forced to go to
> > > > + * the blocking domain in-between.
> > > > + *
> > > > + * If the attached domain is a core domain (e.g. a default_domain), it will act
> > > > + * just like the iommu_attach_group().
> > > I am not following above two lines. Why and how could iommufd set a
> > > core domain to an iommu_group?
> > Perhaps this isn't the best narrative. What it's supposed to say
> > is that this function acts as an iommu_attach_group() call if the
> > device is "detached", yet we have changed the semantics about the
> > word "detach". So, what should the correct way to write such a
> > note?
> 
> How could this interface be used as detaching a domain from a group?
> Even it could be used, doesn't it act as an iommu_detach_group()?

No. I didn't say that. It doesn't act as detach(), but attach()
when a device is already "detached".

The original statement is saying, "if the attached domain is a
core domain", i.e. the device is detach()-ed, "it will act just
like the iommu_attach_group()".

Thanks
Nic
