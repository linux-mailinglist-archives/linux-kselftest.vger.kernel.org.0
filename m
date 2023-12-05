Return-Path: <linux-kselftest+bounces-1182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017D805B2E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB79D1F216C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4EC68B66;
	Tue,  5 Dec 2023 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOXYHOvJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E70ACA;
	Tue,  5 Dec 2023 09:33:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCQ8ZES3xUVa9UQJbJkFSfbMMu9o+wPNddZ8aKCb/bTMlT0Gxj7ul4jcp4/+ZRuAokFN6mlZD8QMbwHJi+JEFe8ZZPJMh6ALosswca+eV/WmI3i0nI9Pt0OGzCcE6BJf9Ak9MZ+Z+AJ3R0UNG1kQTJw09SeqZpYGoSX9FX3HKLgkaklLOAEKngFeCrDVnn8twIy+7XUu7HhFwGutlwRzGPq9NL7y+TfIpG1QAuUBsBLaJIkzfO1xJOHQx7AMfnIKCO0CugD3BDVhtKq4nv4m/bHq7lNXzRuolFZuHu7yeKIT9K7yTd6u5ArXx8P7BzfWQNlIiKaVFKif8oO5uOp8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSSFQkGjCxebzXrGirArb1ftLbCoMCoHa2QKVy1RPC8=;
 b=E2l5bYYW9d7lqL+7nmehtfEUiEtiImTbb9LEzg3vIFnauS1JhQV2ZvyJB+e1dc+uqgb2Xs2pQ5xnqOZ4CAGWAVZhhTlcMDs2LiF8q9uxrQrqrZ2yNLStWzw/+c0Zs+Ekg3e8sz6ppVPcc7dBVEY8GrfHnE2sNiW49n4oAIAcuQgEYukcOftpK5qtTsdx3wcJONdiXHd3OtDLNc8fLbDWUz0DZ+f4s0Pb/DNJ4fNnqAvvgB10Ufvi/hXL6vSP6RzmOMl37tu3Uhpzfrvf9pXLqGraXihp5aXuFlzyaMpnmFgMf7d8JKaJ7IcMAK6/3ck+NBPokzKP9VN93hKnSJZAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSSFQkGjCxebzXrGirArb1ftLbCoMCoHa2QKVy1RPC8=;
 b=HOXYHOvJDmh6+naASUZ4hyQHFZDjD6kryOxiwGZ47Yc00yJYr7GiKEb5d8YZwBecE2mvsLrOwMah4vUGOmSxkGwwk+CaXFjwY/aCAsib7uvNNn04GCZeE1FQ40b8vOSnMCMeaw/3h78x3Gr8jYgzTYwdLOOqc8de1YW4BRJ6CJBI2HTJinhPhgJ+x/vHAftcB/8GXkNYeWojmvCbKuYL9dacgbtRTIlEC1Gazwat67Sm+iBZDTpbcBH5EBynr5F/nSH9bK5F5n5ZcK0/jYFcwVm2bNwynExMmPPyuIxiu702kXL0zsR14TO6MBIlBZWSCY48PK+zvVrZtr25riSQsA==
Received: from PH0PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:e::11)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:33:51 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::f7) by PH0PR07CA0036.outlook.office365.com
 (2603:10b6:510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 17:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 17:33:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 09:33:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 09:33:33 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 09:33:32 -0800
Date: Tue, 5 Dec 2023 09:33:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZW9e6hxyDmkK8bfe@Asurada-Nvidia>
References: <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
 <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
 <20231201204340.GA1493156@nvidia.com>
 <ZWpaTD9dVge+suyv@Asurada-Nvidia>
 <20231204144850.GC1493156@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231204144850.GC1493156@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: cb559ea3-8dac-4ae7-3f91-08dbf5b85885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l385PzBUkGY2EcdrsgCSlrWHQ04Nl6SaeOGfAONtzRD2FtY3YvJ93Q6L2U+K9pKk+BMVyPV51tTexwr/Ox10orHcZRxbXWuFSEwVaWS9Vpp1EbiwnAfEIRZRrNlcBKAVzCYkLnUEPbbtfPOA5aIjkOkiDB+rIJc77abpXJWjHJgRib/IEnAs0ko00f48uaA7mdVdc9E/zZHXnWXjZ2H6v45sJXsrd0FQogRXZ5yRWYhRxFZOukbjQz/tXvBcJRbIwa7seUF7hrLItqj7pTZOA3AU1BnvnruKFPn2UfyH5XEdcI8ty8kKtfKl2egY7W7bkpaTbv4Q8s05V0gV/dv1FBq3OcB/0lvNyQG/54WjlFzTezLYTemTxAAgKFHtvJlN+7K2F71L/YB5aFZZiODSlelLA0qfDhcCX+fCRtU92GYbNb3StKhspJlRKx0FzWmJZU+ZlEyA8/t3DJcZj4PiO8eCnrJSty3AEpY+/3p6BMIDtpckQHgrf0TkVuAP4kC3Kc4nXJxxC/28deqGFVw3QJ34gDTgNm/wzy7MHYbLe/Fs+cKO/Amvmiq0wYZA4CxKZuoobFd/Qn6FmDKQdTk7uo7KXOlPRDNe0oaLMZ8p4QGNjxiNwSWCyi5oNoSMvvSimeWefDg88korSTWaet4GSPxCV6qaVaJ1zUCv24dek2xP1JAN1HvXgQXLnP7rby1bp/Y/j1mpGGalP1bhx7Gw142N4wrs8Td1REp1N1leCTc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(8936002)(8676002)(6862004)(4326008)(26005)(9686003)(40460700003)(316002)(54906003)(6636002)(70586007)(70206006)(478600001)(41300700001)(4744005)(7416002)(5660300002)(33716001)(2906002)(86362001)(36860700001)(40480700001)(47076005)(82740400003)(356005)(55016003)(7636003)(426003)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:33:50.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb559ea3-8dac-4ae7-3f91-08dbf5b85885
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297

On Mon, Dec 04, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
 
> > Or am I missing some point here?
> 
> It sounds Ok, we just have to understand what userspace should be
> doing and how much of this the kernel should implement.
> 
> It seems to me that the error code should return the gerror and the
> req_num should indicate the halted cons. The vmm should relay both
> into the virtual registers.

I see your concern. I will take a closer look and see if we can
add to the initial version of arm_smmu_cache_invalidate_user().
Otherwise, we can add later.

Btw, VT-d seems to want the error_code and reports in the VT-d
specific invalidate entry structure, as Kevin and Yi had that
discussion in the other side of the thread.

Thanks
Nicolin

