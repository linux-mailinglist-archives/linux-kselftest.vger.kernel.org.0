Return-Path: <linux-kselftest+bounces-2861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981AD82B356
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A576F1C221DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7250277;
	Thu, 11 Jan 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqoYB0PR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA55026B;
	Thu, 11 Jan 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv5+9/2B8rXt/viSX/MawHWJnqgjz+/DIcwxFI2mYV2kkxI9O97luJkQCvNgZxfS4+I+JgQVjp/8czFcUnvqztwYTRuxAr2X9t5M7Wqi/kv6QpKruhLWu8aBQxaW7pviw5xo/mZbWvWSW3gIeTjajYLpx+2CvamwN9qcDfQMsuBSnpo8yWOdPjUS6+SgjpTH/Ut7ogKjeMOaB3LyWrjLGjp9Ot0GgyF7EyHUqs8fxlRqX31X/FzwNgTsJxJDLJVbigS/BKB7UK34RTIJCi0GEKCuOvgFGGi583b9mFfGwRbTbsk8XhoElhH56Jfp+Aelb6MyS+Sa8cayGFU8PlK7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43LlNCtu65PZ0WtH5CDq3vnqa74slCEv4Qab7RgO2NM=;
 b=QhfNNEiZz+8n0Tgj3q2F3rTS9S9kMISFJCNPbQ16O1TwbBWztnyNzc5bBkD866RO8a9Ot1UIiJWmCjWy1M6vLmnDvk0M6r09WVw/FVd1Caw1umSONlb8mQoH2uiun1EzfA5+b8lpoVncutQ+n57UgSQzcBNRK7BPSKWf+l9wdjHY+Sraq47dXM8COV3iSoyHWwgt7QgnHbRyu6mb5H/QzsKRwP4Su5Mq829vjDvyawGKLnLfv8HtbIwD6f8TpezH7c9lTO5SESXNIfAhpYh5d8CnYDURqs48xu0IqL4JRagCW/Xk5nlCJz9/OBl3+IuulLmaGX3EXYksjdJh+r7jNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43LlNCtu65PZ0WtH5CDq3vnqa74slCEv4Qab7RgO2NM=;
 b=GqoYB0PRrRk+QkJkzSYuVoHkngwAxlOtUCBSMxL7j89XLn/BUWrXD4QZkpgGsvz/aMFNKXT+y63EMjQZRrBAtTfWXmGiEaMXd8Vje5AGO80wpE5yhMOczJXcT4XyWXVUSbPCtV4S48lrEuU7Qpe1xzNHFElIT4yeGWp42oBtXKT5QbB0yt7csZyvZ+1TxXILssyHfzZ8TK2NgR9c/O5sAwoGaU8UVEy8zB6FYH2NR452exfVANRmJk42eYyBwzsIl6EC8NOGRL2YFVw7S4haz45OPyeVFsyWrupvWJKACOGc0iZdSWfSgFha4Q1mxosB66LBP3aUlXU3kjlZLNy+rw==
Received: from DM5PR07CA0075.namprd07.prod.outlook.com (2603:10b6:4:ad::40) by
 DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Thu, 11 Jan 2024 16:50:54 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::10) by DM5PR07CA0075.outlook.office365.com
 (2603:10b6:4:ad::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 16:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 16:50:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 08:50:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 11 Jan 2024 08:50:47 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 11 Jan 2024 08:50:46 -0800
Date: Thu, 11 Jan 2024 08:50:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>, <j.granados@samsung.com>,
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v11 6/8] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Message-ID: <ZaAcZXrhhQPhKTHq@Asurada-Nvidia>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
 <20240111041015.47920-7-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111041015.47920-7-yi.l.liu@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: add25741-69e0-4c84-54d6-08dc12c579f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r1H9MrnJuAxe7xQinXwmTWAstQk9OXCVLjPEGuXQWuX5Plb6YCp3eIHIU8YgnaRmhICHsnjwT9/ZiKTrzrhSO1YrJpApU0aou/PS+E6sAuLPCh6IJTzPIZkKH0xWhzDbNjDU9VdPLqKfPpgShL+uepPVK1ylDr+If98+5mKZyDJNMy+8Wb2BE7AzHOX7SWqEOdVMM77XPsTdu5e+M3CLkctwmWh6OIzZ2QYHGwdVjMcyuu75h5BAfm1bLJj+JP1BSPhLCE27CUPeHX5NnPP2PtJoQeKZAeNPMLU0b7LytsOV9b2oGLf2ZDiBEJV8vVlFqAzhwdXaLQHTPZJdPcQyOdLp4hZKckdCZ/830gYxhBz6nCDEbh0DwweL1nCS+LOwrpZKsqcXNmVGZRDNNPbdjqnIeGoDwngCgfqwXn6ZRfoBHOpIetzioVD/h8StI7uesC7SrEyE+wod3KBCGSnJSeey9x5UuGp3Usd83kYx9ZgrfVN/Q207jbhFeJgWMdguQCbLED8arjRbjgRsVF624c88ohKrNlIK8vGdRee7rPC5U1aAoSSehrK4NQ79tbEeee1dX4EpPMfWNKx4btxjxRb6UbyC/s5iX3k8p5cc6dLSTB1lU7yx9ifUlFOHVcizAHYVIjbDMx0Y5Yv7qZe1dkh6osAu3N/HVEWkWM+tvMT2VcRrFqk1Dtl9gsZgLM2+fPfVcHO3uBm7oqV0F5gVjFZNqNoN9BC23w7esf+U7pWSCTzKdl+3c0OdMAe1cxat
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(55016003)(40480700001)(40460700003)(83380400001)(9686003)(26005)(336012)(426003)(86362001)(7636003)(356005)(5660300002)(4326008)(47076005)(4744005)(7416002)(82740400003)(36860700001)(8936002)(6916009)(316002)(8676002)(70206006)(70586007)(41300700001)(33716001)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:50:54.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add25741-69e0-4c84-54d6-08dc12c579f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

On Wed, Jan 10, 2024 at 08:10:13PM -0800, Yi Liu wrote:
> +#define test_cmd_hwpt_invalidate(hwpt_id, reqs, data_type, lreq, nreqs)        \
> +       ({                                                                    \
> +               ASSERT_EQ(0,                                                  \
> +                         _test_cmd_hwpt_invalidate(self->fd, hwpt_id, reqs,  \
> +                                                   data_type,                 \
> +                                                   lreq, nreqs));            \
> +       })
> +#define test_err_hwpt_invalidate(_errno, hwpt_id, reqs, data_type, lreq,    \
> +                                nreqs)                                    \
> +       ({                                                                 \
> +               EXPECT_ERRNO(_errno,                                       \
> +                            _test_cmd_hwpt_invalidate(self->fd, hwpt_id,  \
> +                                                      reqs, data_type,     \
> +                                                      lreq, nreqs));      \
> +       })

Nit: spaces at the end of the four lines above that have string
"data_type" are all misaligned, probably because of the previous
replacement of "req_type".

