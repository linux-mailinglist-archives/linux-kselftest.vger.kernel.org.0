Return-Path: <linux-kselftest+bounces-2620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69D82317C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AE4B23887
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3BD1BDED;
	Wed,  3 Jan 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMjtf5Ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651441BDE3;
	Wed,  3 Jan 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMTt5RAT/pWIU8vovVsY0hjUV370EB8wUEGlT1Lb4U0ajP86Cz7dZIcr+CAx4AdTx9tIDC4D+JsK99i97wVqgk18rru8TX876/bggifacxAXLeHYnJSFECQxh83G88fQAZRneVRaC2m8tAT+7+D7zDA2b7HdXoqjxuGFie+FTeGPk6WhF4+5fdhpISlNmZZ34pwjm0oW/yv+7s9UeSs48mhiK9fHAz2xQ93rO1/pcJohC9n3ORt9se/7yonof7tDcpUxgPoic9t9mRrufwV13aqchbMvzCrqQiL+xIziWCmQDaCnmoqx9M7PtXmAIuOWnK0GSM7wmuiNPZglF+N22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlRf0VoX2QLx7emLII3PqB7MCV2hzfQ3wXHn4xCO9ow=;
 b=MqtFxa6hAcvtnozfHc9onWK3Ie856RhWcx8zlnONjZzayhrxGEKWzo6AawXJshb3CTSLUuD3OgT4n2vPcYJ7MNMnfPncEX4jSZi2I0yv2oqpT4vAz6aH69HTszzl1KGdulOJq6zBVMGQG8PD+m2M3TBx1bS7Bl+dJgZq2LI+VfVukwyyroHJ5pFKSt5nyQxhyGZh+J4oSg+ul90QdQeQZhrIZ2OW/7v4Y+exlCig+n43iB5YcbjgrVMfSv5Tj3Ac8ZZS+AOkNUwLO6KS5qQyi1Ae6SFE/CsGd847+tHsRcVHbaH70p5UfO/AvHUlfVzA/GywRCDhxmk+H0SB/rH7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlRf0VoX2QLx7emLII3PqB7MCV2hzfQ3wXHn4xCO9ow=;
 b=YMjtf5RaIeYR263nrfVwOwn4HRGIKxn4rp/cNIte3LE92ZPK8cOUtWx4LndTd7Nrqw4wJcqrCeEEfxy6bDcdLakdg4Agwevsvdp3aD57guorhZfa9hl7VtWMd1Gid8QNysgk2V8ThNg0z58p6edgTZeKs9LuapijlD8Arig6qG1tzjz8sccos9ibJHrrI1N4EKK9XsC0Y4GUdqq/EnH0zypI9hlnUhw5J7qFunDUXXwBfCJ91elDpslVO1JwfOS2qUK8/uerbOlzuQt/wljf/5QBJ/BGc2WcAa28I9NYiCqR6SxdYbCC/ZLLDpHJ0iHmgCg6LE5KSI4/sI7sQghBag==
Received: from BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Wed, 3 Jan
 2024 16:49:05 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::ce) by BYAPR02CA0013.outlook.office365.com
 (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Wed, 3 Jan 2024 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 16:49:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 08:48:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 08:48:49 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 3 Jan 2024 08:48:47 -0800
Date: Wed, 3 Jan 2024 08:48:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
References: <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103160108.GP50406@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad75a7f-f85a-449a-47c5-08dc0c7be542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7IBUVdaWpM0ZXrDinSO3RGGXCPblENaI0ryDzxNLqhAafUb6gyBs0mkRuRGJwRNCkjLh8o+VTN9FDL3jmRvOfu1cHYkoJVWw2QUro/JftW7tvZAtjIPjriZG1yIdls0sT4psyLbEqFWSKsXR6hHBnwBJgoQiHogAxk0drecb8RwUpkpLWzKmxAR7LLiAmWhhHQErI2xRBryTIiErlJcb0F9gRBg3fZMwhQlzYI8dlw4PGdu4EWYCjePhhklI4+5uupJEMdgsfcGWEiXirDo3rJHcAsLZOQg3sT9g+XSU04YXcffNqb20HJTeOsETabbfWBWwSuoStshParHdKUuTKnz8yYWWjbaFTm8yowT6uzpgp2oJNa1eNejctFWiEeRmOr24Z9fSDo9EiQe6+ZHyT244auHzzP8AE0FGLlqAC5WbG+oifSZLGPqRWs+uPEUGTMfBy61d2lZZ+k0hhhmATLRjYPHKdPbNREQgNzjgOLyNml0o3835wCPPsF7uXwSZXKYDJATtgjBcPn2h2420nFy1f3G4rkpocb5xFajFbd41Ef74bDZy5c6SQ/wwJ7Sa0Uu5rHbQeaeP9cHeH4rMf65LjK3t0F7VVeUAVCaJd7stVClxzQkA9NmSk5tbtCBlwwwBQXcmAY4XsQ/QkrhXhaBCqhmAiCv/DkEUYDgVQAhx69HboYJyp29CCpslj8egeECr5QRbFAf2cE283JTpIqN33n3++mTi/4kr+/VmSEM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(53546011)(55016003)(40460700003)(9686003)(40480700001)(66899024)(47076005)(4326008)(6862004)(7636003)(316002)(54906003)(5660300002)(356005)(8676002)(8936002)(36860700001)(82740400003)(7416002)(2906002)(336012)(426003)(83380400001)(86362001)(478600001)(33716001)(26005)(6636002)(70586007)(41300700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:49:04.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad75a7f-f85a-449a-47c5-08dc0c7be542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

On Wed, Jan 03, 2024 at 12:01:08PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 10:24:42AM +0800, Yi Liu wrote:
> > On 2024/1/3 07:38, Jason Gunthorpe wrote:
> > > On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
> > > > > I think I misread Yi's narrative: dev_id is a working approach
> > > > > for VMM to convert to a vRID, while he is asking for a better
> > > > > alternative :)
> > > > 
> > > > In concept, dev_id works, but in reality we have problem to get a dev_id
> > > > for a given device in intel iommu driver, hence I'm asking for help here. :)
> > > 
> > > I think we just need to solve this one way or another.. Even if you
> > > use a viommu object you still end up having difficult coupling to
> > > iommufd
> > > 
> > > Some:
> > >    iommufd_get_dev_id(struct iommufd_ctx *ictx, struct device *dev)
> > > 
> > > Callable by a driver (using the driver-callable function
> > > infrastructure we made for dirty tracking) Is really all that is
> > > needed here.
> > 
> > yep, I noticed IOMMUFD_DRIVER was selected by intel iommu driver when
> > IOMMUFD is configed. Maybe such an API could be compiled when
> > IOMMUFD_DRIVER is enabled as well. This does address my concern on making
> > intel iommu driver depending on iommufd. But still need a way to pass in
> > the iommufd_ctx pointer to intel iommu driver, and store it. Hence intel
> > iommu driver could call the above iommufd_get_dev_id(). One possible way is
> > passing it when attaching device to domain and clear it in detach. However,
> > this seems not ideal as iommufd_ctx information should be static between
> > bind_iommufd and unbind. But we don't call into intel iommu driver in the
> > bind and unbind operations. May need to add new iommu op. Any suggestion
> > here?
> 
> You can pass the ctx to the invalidate op, it is already implied
> because the passed iommu_domain is linked to a single iommufd ctx.

The device virtual id lookup API needs something similar, yet it
likely needs a viommu pointer (or its id) instead? As the table
is attached to a viommu while an ictx can have multiple viommus,
right?

Thanks
Nic

