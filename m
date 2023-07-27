Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD7764E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjG0Izp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjG0IzU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 04:55:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1316A6F;
        Thu, 27 Jul 2023 01:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a83mGDjDnvEVbSywTYKlT/igLppNzV3tdA1sefrrqD7gyNYxXXXK3fc/NtL2LoAjPTvboD+7Cmdknpl5r0W6abjQyog8qYEi06VmNZKIlhWzVvtnlX+b8uhUAMgYj2GOouE8zJWJMr6NjgPYB6T0dpKWe2DvJ/IHpnj/pkdH6yeb64lPJ+/0vpvX+sT3TUb8tHYZRz0PXT1y3IzgIp90mgON/STpoJqEi2sC9BfieqEAmPItPxpKce2ltIWwbgMMbG4Id8dr/W6Xx2eYgojBg2/at5P36/30T4j7e2R5nStdHU3Nkhbrt0KBWtiNpLdCKOuMq+mcrK0pV1RsTdNwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAKWSb5v2yj+bm0yXnxZDsBo+xDnWlKcWxp2Z7ZAVmc=;
 b=EbCtSiF7h87A1jYUBnwcy0hWHcpy+4x9BeId5M37S22oFlHKcZuY0TCzVVbpjZ9BLMwyRoHkyiM+AA4uByBS8q/7+R+kFGgndk9Yt6mb/MIluSRF/InQqE0KySITihyRqRsoOncvm4UOJQwUPrC7c9YGoxtijLzbBuzkwBQjOMDiOLwxaRY3IvYwFqGggZ70wsqCmS/4ren4J5SdJ4oxtdx22MVHt1gPBmte7v2VQmDGCXqAtE/Ocrdcc+a9DMTipH0A0FXtZrSoY80vQXQtou05ELr9Q+gVMmslkR6nhNvkkwRnYkKHTihD813dGfDkQD+LSfiJ8xVxTJfqmwHhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAKWSb5v2yj+bm0yXnxZDsBo+xDnWlKcWxp2Z7ZAVmc=;
 b=ZNgeRC+3zMYgXaBZFCXKYCPrVGm995aV1QnBl3peXC4OAiOfDJ87x6bE+Rjhy0z6uM/NZYV6vpzXgne8dWkTLLk0fUrWQ+pHteNUxsK0+XeZxHEYJrcoyOtzjdP+tHfQC77IYFEdj/K+APYHMd5bu8AiGjkd1Kifn6wrNWJMb5aK5u+H+0JLqbhRsNNt2MNaJvRueaqXFtX38fiPu95VHlp2G8imWFHZRmSEwK6FMkCmqqnQn8JBgO2QXrxujjOBMdFnWraTx/oQN3dgTK++t+sAO1W7KHDtNmkJCo3wwNflqv4W+nm6lpPn4yVWv3CAiU5XwU4+ZQ9f9QVSm6xWkQ==
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:35:49 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::80) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 08:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 08:35:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 01:35:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 01:35:29 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 01:35:28 -0700
Date:   Thu, 27 Jul 2023 01:35:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZMIsTzdVlwSHMrly@Asurada-Nvidia>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-5-yi.l.liu@intel.com>
 <ZL66TtuWZXhxWFKP@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZL66TtuWZXhxWFKP@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 4631be4e-6614-410a-e4db-08db8e7c7ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rax310OJ8PRiSHisbpZMsM+nXRs93bUQHBOY914ZrhPKVoHC9nrHeTuv9TL4viS9VPiw+QU4+9vZwA7VTZ+/+8zrVBT/cKp9oKvahFxGA0MpAXFPT/nwY4cUlXdHxMZoC1ToJj6IuD3/3ziyR2oNk6XNHgQf9qwJ3JPtQKyKMPM46fn761enzJvPT0JiKhioMWWKdA9XBUcypFs3fLm3HkPQ9xRU3mpAgPdvK2uRyDqYZHm8sovUevxvr8/oF5xpwPtGnPjIFlh/ZBwV67wpTUWI4qFuaSKsWHb1ZZqoZwWBI6ixWkfAPES5t2Tz1dq+pxhBLboIMkON63w9RpbzuZoWtXYbR92u8GQVGO2Hm5uMt3yuBD4zp6VLE3e04Q7jJsf50RKqzDwQyES0VBjQtd40GEa6OSLEArtNxUC7dyhhC0o3nWX1ye5D15m8CtI30lNu8PTt8qegC79l9SEBPn8o13SUqUtrBNrlja7o51SC86VfDj6fvFTSrnhhNXSovIu+oT1W8hZdRsYT4gVKNo+PxAFpfO0Hq0faXIXcJ843Ogd3j0nEMhhjATJBpLJh8C54zjPLPbksWvU/RWBmi7+THaBCJbyscy/y9JJxNKXudQKeK6IZ1Sw071AsKvrKGw8rVFB4+mW5mTv37n4i/1AZnvCmyOeCJi2EnC41zo9sOjk9k9TKsmXXxMw/UwrbKwr5u6Dm8N0WowNFIj0rGAGqppgbmH67pqUqNPfR50x8p/4bJ95ED3ANQ5DPVwsc
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(356005)(7636003)(26005)(54906003)(478600001)(82740400003)(336012)(186003)(426003)(47076005)(6636002)(4326008)(9686003)(36860700001)(70206006)(70586007)(4744005)(5660300002)(7416002)(40460700003)(41300700001)(33716001)(316002)(2906002)(6862004)(8676002)(8936002)(40480700001)(86362001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:35:48.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4631be4e-6614-410a-e4db-08db8e7c7ad2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 02:52:14PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 03:59:36AM -0700, Yi Liu wrote:
> > diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> > index 70353e68e599..f13df84f6b42 100644
> > --- a/tools/testing/selftests/iommu/iommufd_utils.h
> > +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> > @@ -348,3 +348,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
> >  	})
> >  
> >  #endif
> > +
> > +static int _test_cmd_get_hw_info(int fd, __u32 device_id,
> > +				 __u32 data_len, void *data)
> 
> void * data,size_t data_len

OK!
