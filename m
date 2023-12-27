Return-Path: <linux-kselftest+bounces-2482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98981F203
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3443B2271E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9B47F79;
	Wed, 27 Dec 2023 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eFv5YW7b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BB47F71;
	Wed, 27 Dec 2023 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1iuGMQhDmqNplVv3qQhxLxil8+fiO/JvnUEGHudV57I47pTjVryLrV8XF3uaVOqkdiWKeebyA6x45V/aryGkvwqfGQEr4BakO5JyGDFskmk5n52o1WX/CIO+um7k2LIeN5C4jBGm4eQnwGVZ1QDdTOtq1HShiVmW2sDuEEzRNk2p/P0PZymP8R3ebddN49iGiGVFHdUIs/o96mJ2fCOUrbbEoVxtTpeSMsbPC6QJx41fZ5eaXEK16bVzct3dpicbFxxp7PKuJfnrKez3h7zcmjHdRdWEaBeFCaiuydHXDEXHwa/FXOj+HhAk+GNLeQMCfPRiV5K6zTeXlDxaTmpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWfHZhRNNoK050z3FabuK22xbGjyx5w/opmiAJflg50=;
 b=j6pN1Krv1k6ZBCMVN4MVcgnRPzeLqkAXp4dzlv8L4nELFxi4pMewT/AfOFw+KR7dgdUsC3BZqNcxyf37vfz6i1fgKpZhaWzoJgsVBiW4tikon9BJmGA6xZs+NEsF7GGCFaJp4mV5DZYsx9xXCzYfALxH4CNl8/eSHWb/Yl0Ft5F6oAA5Pa/e5JyKzzYCkLqf2queEOje3uEHhUQHBjBXJNgW26vOkkqaX2ZezGvOhQKoYlPpa0s7cfSr2vkGPG7IijrbKRVpo4YglK5wvqwkwqFfEtkcu3RhgaOFyJH3aICzRSOtbK+GuSVGU48ynga503PiU+Y5Ts9gR4rhW0JcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWfHZhRNNoK050z3FabuK22xbGjyx5w/opmiAJflg50=;
 b=eFv5YW7bD5bEsuzYeJ1su43ZUuNk0HP6A8dgk3pm1iVwvfLJNUDEfxFwhJHSoU/aFaMWITtdkH4TlrmMedH41V/R9WshJ7AMZn+xKlPVgEhR8BUrkBIceRrvW1OFTB9bGaMwyxCWW+nBFBvDL4wTB6Z8kYRMz9CXkxdbSjnegrT/a+5e8ibD/FSYnoFUkxgJxyhPEiRxH8kU4ds9K8MFjGniGdjwc1iF6UMzwEwN0CZczGs/i57oaS24EGB8GD4fPfoLaxmTwq69oMWRODITzI9xyYtIrq/uUAsWY5Z+QsQSi/fX6xv5ztG0Xt8SmrE9gIbBUlqbXeFoBRnZtHsGqg==
Received: from BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 20:58:37 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::dd) by BL0PR02CA0136.outlook.office365.com
 (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Wed, 27 Dec 2023 20:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 20:58:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Dec
 2023 12:58:17 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Dec
 2023 12:58:16 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 27 Dec 2023 12:58:14 -0800
Date: Wed, 27 Dec 2023 12:58:12 -0800
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
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>, <j.granados@samsung.com>
Subject: Re: [PATCH v8 00/10] Add iommufd nesting (part 2/2)
Message-ID: <ZYyP5OXxsIjIzhKt@Asurada-Nvidia>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231227161354.67701-1-yi.l.liu@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: c434ebd3-9b35-4967-8ff0-08dc071e9876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iSAjYm/AbOB7Or5C8oEk7/aw9hzJ9i6zfuZ/zeUotzfTpzCZMTiL4ugTNPF96nJ189xtmh4iXwC6/e/RsLpIzdJma9MYo0yw693WklK1uMNkaGcsdgyVqdNpTXGKu5y+k6I7Hk9c0qJtl+Mv0IH0ppv3/1ghfzCcUI1q7KUNeZvWRd/SbK/9kedVSkCXX+Ilo9kp5ER01QVpys3N9csgbYbE6LYqgZqRwWZs3iRZ0Fh1OEEDZWWwrv+0tzU2kX5mFY/Plgm+ecU1j3wV9tgAnza0wLnUxdz1iT684EOJKCS7HPWjMDNbmTK6U+NyY5cQSatvEc/9c5uN8sjWHCTc9UXRDiODDtuL71dEKP8B6RiMQYfVLk9XCsho+er9W77pKeSUmrvMwocMWwfJcMWvkT5GpGjNJapxCvp+iCl7844GNjDIo+EIcd0xL2+zkDnllJs6kZIGRanYNONAgHoLM1hCNye1G/YM+W++P10nsUX50KRWjjIF3olRhPEFG4raJD19YxgQCgB6nNUvfG6vDfC6z27poNwixua8Yt23CMmPCMbDCIh+/stBuj3KF99WA9CKODjSSkost4SskSyJkVMo9Mbc+XP+8SFCoWf8Ggf3e8fRqsv/1LvsgMClbR8LjpxrF8fgZR872gMSDp9od7dv3IwmN4nCOBl6rpk9yJx2isrz+VP+IvViGdv9tMo8N4X0rNP+b9751YfzVy3U0E9dhMD7ytVghyI0enqtYSBUL9g23/K4Fjm/lfqhxOLlkNNimg+K9zvuXO3Z2IngOh4WChP09OgXvoCptYzNLTw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(9686003)(83380400001)(36860700001)(966005)(33716001)(356005)(7636003)(336012)(70206006)(70586007)(316002)(6916009)(82740400003)(54906003)(86362001)(478600001)(47076005)(40460700003)(55016003)(426003)(8936002)(26005)(8676002)(4326008)(558084003)(7416002)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 20:58:36.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c434ebd3-9b35-4967-8ff0-08dc071e9876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

On Wed, Dec 27, 2023 at 08:13:44AM -0800, Yi Liu wrote:
 
> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

This branch is still pointing to v7's iommufd_nesting-12212023-yi.
Likely you should update it to v8's iommufd_nesting-12272023-yi :)

Thanks
Nic

