Return-Path: <linux-kselftest+bounces-333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195227F19C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4676D1C20EE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D420B208BC;
	Mon, 20 Nov 2023 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q64fjgR0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCCBA;
	Mon, 20 Nov 2023 09:25:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmYhixCcgUWUNmchSSemRf2Gqbv+XOu4Da8Cpe79a5R2nk2n/8iYmvInzrwNjfQmIuvxiSqb+shrIhLhj5WQXZUgAQ/aEydW4bASe/95r4yf10Ph3nf3hjD87eiNd1iSJjotJcgFkzYFaZUb7RjaVTyvAR4pVUlg/W7MGzJi8JtzPEkqOOVC+sx9tRRwr8LW41X6pPjxaiOqSChxlSwSzSo+Fu8EcOe7L6DR73cIq+plIUNSr/7XyT+/qMD4zqTl+gp7XRE87ZK9FW/2xGuiv70z2W1AOoLcgLYyvV4FmnpnMstLMFoewHgzesBt3kBNLrUyL8soPJylmpzCLQB+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KTcE2P8rRPX3ABCXVh/tcLAyVOsyE7muUJvu+G6fUA=;
 b=GYAsoRI4HSLdEAhRAc6VnOg+lksBXTWSZj03NDMhK1GhWy/IvExfwXOTdZzHYHG7n46zHqhkywg/IjpNor+2Dy4ojy02fF9V4XYC+hqRaVgKfMWaQxdxzmOo3gq4s0av8ZJGxvG/2o+fIKErpE0dyfiaqt0IGC2f8E/BmpfzoY+oDveZz6E727gmRcvyJx4MJDHlS9Te9Se8AMIpy+tnIcp8Vst2MZG0MJ+JNQ+rRa9JjJHHJ2FJLPRR9JDuJMByS8/NOIx4sOpNpQgqeddKFQVumvbJ2yzJ1sIPVOBD3llWD8LEhOPkfcF4CCk3YX/rNDTDoTj0+dWtr2CZRtF7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KTcE2P8rRPX3ABCXVh/tcLAyVOsyE7muUJvu+G6fUA=;
 b=Q64fjgR0xnxcXUIgu0caR2UQPcbiz8Qlsvpvi0aRR9al4XqSsLUWQY81iCNVXBPQpLqMmB7CDVYBvO+Atq2W6bj4Y0zB0D7UV46+9Jnh/+vMvJro/7aWvtUqY7K7ygtA711yqxl44i8B9mnsKbYZe8VtX3jC3JeqXBR3yusyvUF4S3hmNpwTOiFFpQU0lcv6WffINneO6VvP/lG63OB1IpypexpXd8FcY0lsfBKBxqBw9Qaow96WTHnWpB2aEAe26GrgVO8GyH7hmDErDK2IMIWyIiXNE9pivb3445nYfL70p/A/IQWDomRHHhyjFas0ohIKebxARUT6JCx79bbkdQ==
Received: from SN6PR16CA0060.namprd16.prod.outlook.com (2603:10b6:805:ca::37)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Mon, 20 Nov
 2023 17:25:24 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::8) by SN6PR16CA0060.outlook.office365.com
 (2603:10b6:805:ca::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 17:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 17:25:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 09:25:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Nov 2023 09:25:10 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 20 Nov 2023 09:25:09 -0800
Date: Mon, 20 Nov 2023 09:25:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
Message-ID: <ZVuWdEwYw+9uAaUz@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-4-yi.l.liu@intel.com>
 <BN9PR11MB52763299F886D4A534D6E0BA8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763299F886D4A534D6E0BA8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|BN9PR12MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a24dea2-455a-4b9a-b0be-08dbe9edae55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UAP/Ow5Dn8OW/i2x7CWw8xpp/JVAFnmc0/lVSq2qXZxgfuZSnk6bYVNVBoAZyvZ2ZXqx75CgFPqCAwpafZ4OtDDDiE7MzBKrTa58llyUDvx8HuECs8Y47WVAx+HnfBNVjoDqm71/nyXaJsPZmfWasWsONQ2PrEGGkatsoo5RzFRggva9AqjvVnZP6FL73an9oa1YhZhTaZVyHG+wVZOkXydSIV+GSNfoVkF26+XunD9XfGHZYerf1CVqbw3tfzNOORP2EiEmmNQ9ZqzGKLB81wtjvOt/u3SQBWX0mXm3ZEyMlgEflpcCDBB3ZnqcVu+rIPJ1qiMCTotDwOKq7LULNN5TP3YLw3ee2mVNlxD6agce19oKNtvc+F6Upio0A6Tg3mlvS39hU3J8b9KtLCWoyFkxVK4bROHW8JGLKdpnf+1KLx6f+kfqIo47Ev8dDATzNON/nuFJ4KhvClvAEuyMYqatrRh2WknqxjBHeuVz+rcl3zCu6/ArnOlQHE6f1WtzkiLxSZCaGKOx2bosRSw7LyvH6SrP5poKfS6Y7TQoUE88IH+XauYTYpamk6JE7M4zStDrklvsWGVTyMucbtiVPnD24PGOs1VZPk1yrLsAok0qJ3j1wrV2M8qbDrOiMxI8sDu6hlvD3fAKAzOrUS1a7ZKgjclh/A4Xbc/VWp9CNXUHksvlkWJJojPBFHHYBjFMRyMvb+mIwquYTpBYMIR7so5gn3smDK+h1zxfJxgUe6TTjZyEZSAWgDOhraOqUOOKsXNORtpY5/YAhxi19+9/nw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(4326008)(2906002)(4744005)(36860700001)(8936002)(8676002)(41300700001)(55016003)(26005)(426003)(70206006)(70586007)(6916009)(316002)(54906003)(9686003)(5660300002)(7416002)(478600001)(336012)(47076005)(40480700001)(7636003)(356005)(33716001)(82740400003)(86362001)(40460700003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:25:24.3023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a24dea2-455a-4b9a-b0be-08dbe9edae55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241

On Mon, Nov 20, 2023 at 08:17:47AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Friday, November 17, 2023 9:07 PM
> >
> > +/**
> > + * __iommu_copy_struct_from_user_array - Copy iommu driver specific
> 
> __iommu_copy_entry_from_user_array?

I think "struct" and "entry" are interchangeable. Yet, aligning
with the {__}iommu_copy_struct_from_user seems to be nicer?

