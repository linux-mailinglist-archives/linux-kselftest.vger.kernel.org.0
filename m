Return-Path: <linux-kselftest+bounces-27045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B165DA3D201
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B53A60C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6741E5701;
	Thu, 20 Feb 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieaiYHkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E31E102D;
	Thu, 20 Feb 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035812; cv=fail; b=Fc1AtHyzgSu4Vb4zainjyrex2JRs9BEFNStva6E1zHA9lsYRAkJEoXX2YbdI01CEFE8d5PoBAskR5Edg5bdVG6JOw6rhPQsAYO8VhWaPgWu19qVlFIswn9aXLZk8wJEYDxjiRm6vkHS0PkKUtlvAHnPYjkIrWxY8iajeyDwVrwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035812; c=relaxed/simple;
	bh=rtzwZDKty5Vq4MOKpliucN9Iso4w41KpQqMkhHg1J4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBh0cuSd4E3Eb7tSET6yfg1TxJnAfsxa8tFsW4uvjAxuCxATmNpDnXy5LZn7Q7ohIAWS0EMnqbThxWFzgFJ3nWv8D2ImWwOa2TjbOyrpcVY+2wr7bqKmCGY5CpLOYcpwa+Y/4BBQczm1cgqJaJSh5M/p6yd4VRNQnae/mlvfQSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieaiYHkZ; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+gPxoVcZNhpPrSDbpXk4EfgBZwM5BkfXIETn12Y5f9Vl8YeFdoGe7S89OBv3G00iNWPi3kwGq5VGf5MxHLQ1P6pjrdc1m3qowAe5Sd2rcolwCqyA2tZJ+uSlSszr4LOfnpc8C9Dg1DjH5kUS5ELN8xMxMaunqVh58rkT10baLG20erMNRNcSNWiLFIJezbM0IRFJwJwlXEZF+c9CMS16jh6+qXuA0K0c8fOV+7c+r7Jr3xby+tRenjUiO2BKGjfBqJyLpt+RHM/IHQjU4lJ5luwtvaPUhnvxRKRPf5leEpj8N1cTxsRGL48GxmCNgS+i8+qHgqTPNxpSAjDucV72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4VshHN551NXd67vqkdLkGoHMp+bv3MoP9hgf3lulZo=;
 b=i2hSDsxLRs8dm+JoOqXL++oNOzb5CmL/I7SteDO97aEW/C+X0X+Uqe6X6zmuwFYDC3zxArzY1iDsOHYTr1+Cyp+9URs4LaGQtHEDmQP8PMOWV63eULICN5MASxnA/1XQ7mDKpLiaQ54k+D74/HsnTVL21/Y+nCo/fLsUdGMSQx1rRvAS0gWckRaJd5TQYAtXLITT4nyE2D+P4mQHWupq7bWzaXGRMZcWdcAVsZSL4GAZ26tpsjFdXnlr2pwBf/LXdOQd7M19yzzlUSX8WzmfFhqJe2z73DDoft3SyBiW+A3X10Ij+pl4ND+PyrP6SBMAXEq2T8Xue/7UQ2XOcCl/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4VshHN551NXd67vqkdLkGoHMp+bv3MoP9hgf3lulZo=;
 b=ieaiYHkZwKnOjbAiujJ3Uq7Uuu8k9MFqPa8VUH8kHtc7xojkS6yldB9f4c+O7GwfOTtGRvjuP2yUCYnelmWDPKmtwzIIferc8IVWKT1h66fB3kjqbZFbN1JixbI2yRm0ziEB7ucJ7AP1CyAWPRfU7OVHM5MiM5IEtxirJmZirt5Vk7jwU4K8tdt4t58MKAzx6eQj7eNw/DUjBvt0nVO8AeBXX/CaHxPjrFA4ESDsYmS7TPc+8ix5BM3AhWdDAragY1I0stfLb0rUkic7Mc53YfOY37NjHgZQE5NgTj4sluzIbIpmVxGvWTMX7iGhfrXtHzlqiHNw/Yje7+LPChc12w==
Received: from CH0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:b0::34)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 07:16:47 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::6d) by CH0PR03CA0029.outlook.office365.com
 (2603:10b6:610:b0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 07:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 07:16:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 23:16:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 23:16:37 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 23:16:36 -0800
Date: Wed, 19 Feb 2025 23:16:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z7bW00+W1WkwtOLI@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <d68ca2f38f28c50a3109bc5a84716ca79bc3d7f3.1737754129.git.nicolinc@nvidia.com>
 <20250218170824.GF4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218170824.GF4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c7a189-cc4a-4be1-367c-08dd517e89cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQqwrjZK3oi/x8yX9Q7Wm/fsBGrMtkyT0LXakQM7ULlGXIA5CNc6sHddn1D7?=
 =?us-ascii?Q?/xPMQFNWn4iqnmyfpLbJxpoxwdRseZxqi5sWV9WRFWB+fqLDKF0BnyxGWdLE?=
 =?us-ascii?Q?iJS87UqhGP7q4eNxoTLekzXh2EDc1bOu596mmJ+Rrl950Cin3tNxKMoHmhq2?=
 =?us-ascii?Q?NoPwqpPHr20FLqi5c82PxlV10jZmY9bjHp1dZc9yw5UzmwgZvJtjVc6yOurr?=
 =?us-ascii?Q?Yf1kR/efCGrHr6oNLVMWAkDM/lo6lZWvpmuLmffe9dAPHgVrlW+nok85qclk?=
 =?us-ascii?Q?Lj5usWH61Qj7EwUeXazHFvDMO7DCjOM9hSg7n406qCxr5Kwu3Gzl8CgcscGQ?=
 =?us-ascii?Q?mMLwyb6etxudB4/lefNowofFZgZYeB9OeugT0L4sVq1nPGdnjzGfElA+ctta?=
 =?us-ascii?Q?FRKbE7E+rMnH89wave6h1jQK+4KN07inFsx1Tj4MX27NqM4AgXlhBu9iLBqG?=
 =?us-ascii?Q?lhD227z5CK4dmfu8yuoTFkBXByKPXBbfDbMM6uOURL9Wd+HfGqwoXWBzZlq/?=
 =?us-ascii?Q?Y9lZhaqFw/a7ZNhNfEqwyu40SgIrQ3V2Pe1xhu3h2PTlIf3sHkQLMAgRN+mK?=
 =?us-ascii?Q?4FWdULepKrt/gldEp4v5Fp9Opxkoq5hlTQMrRgbGq3djlEkHlau9kIsscWKX?=
 =?us-ascii?Q?wJCpomBW8jsUZDT8h6bNzIZ4hg6J9bCTPHS/apOLtwhwm0DoVqMOO1O6Wphj?=
 =?us-ascii?Q?gzrwZ4ale3o/VKqlVUULW4zltLZwbsbLssc45DWh86fCuwEoEHfQXBlGpFBw?=
 =?us-ascii?Q?qLORDLRpN7T9QofVIPlwa2MqXEHSKBjOynyCRriM8RoN3shyjZyIaGWw/MRf?=
 =?us-ascii?Q?z4hRJ83TAMo57cHT2axxOvThCYD8ubpMgAonMoPq9yXv+cko8A8883kX0D8z?=
 =?us-ascii?Q?bEXq8RZFdQ/eCPEPWLkHG0WXoLcqnquFByn+O0DJbfISVWX4cfXgxVPKY69n?=
 =?us-ascii?Q?heizQ3qejGTk/WD5wD8bm3UQlHDm++XW5KF9ZTWdWczDh1iwjnA8ln9Y4lGo?=
 =?us-ascii?Q?wg2y3CwubF6GO8Ygr5wx8Z8kPOLFcE/Bl+okVVmZI4z69xNgT07fJ+7NRw5D?=
 =?us-ascii?Q?DJVAi+Zfo133AEpwqZu0/Fbc9xUvcLb3GVgDDLZXc0shIGrQmvie8/DOt+ge?=
 =?us-ascii?Q?/60NA7qbrlQH+rIcMD8pT64v79qgrXTUdYNMFLMtXrGNAkyqSqkEfeON1x15?=
 =?us-ascii?Q?ZvdcyrsfXtisABChAMo6fJtjekLPkP7P9YhvLlJc8dhC77q/5MytYZrCZWPI?=
 =?us-ascii?Q?j/ZOVlzfq3Ul+dShEXtv8V0AnfJaXp5y+CfWrXfhWQkJLQq6kwe93Q+UjSy1?=
 =?us-ascii?Q?TxlJY2OOZzplnjRu/kcF8lQ9xejWCgPPkHYWDWaUTsS6DI2G4jxAgVEiVjtP?=
 =?us-ascii?Q?MJsAmu7jsNXQeF88CD7nqyZdMSCZYxJ1Hfu1DnxSMrIqmcE5jMwUgMtQRRPW?=
 =?us-ascii?Q?VMbfGHGokr8aefRHwATq/NtvIYJzSeyxX0N2xgBkZwHHZS3dWb17Dh7rS9vj?=
 =?us-ascii?Q?W6J3klr9/zrEbK0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:16:47.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c7a189-cc4a-4be1-367c-08dd517e89cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

On Tue, Feb 18, 2025 at 01:08:24PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 24, 2025 at 04:30:41PM -0800, Nicolin Chen wrote:
> > +	int ret;
> >  	struct arm_smmu_ste ste;
> >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +	struct arm_smmu_attach_state state = {
> > +		.master = master,
> > +	};
> > +
> > +	ret = arm_smmu_attach_prepare_vmaster(&state, domain);
> > +	if (ret)
> > +		return ret;
> > +	arm_smmu_attach_commit_vmaster(&state);
> 
> I think you should make this into just a arm_smmu_clear_vmaster()
> with less complication..

Ack:

+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+       mutex_lock(&master->smmu->streams_mutex);
+       kfree(master->vmaster);
+       master->vmaster = NULL;
+       mutex_unlock(&master->smmu->streams_mutex);
+}
[...]
@@ -3162,6 +3172,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
        struct arm_smmu_ste ste;
        struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+       arm_smmu_master_clear_vmaster(master);
        arm_smmu_make_bypass_ste(master->smmu, &ste);
        arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
        return 0;
@@ -3180,7 +3191,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
                                        struct device *dev)
 {
        struct arm_smmu_ste ste;
+       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+       arm_smmu_master_clear_vmaster(master);
        arm_smmu_make_abort_ste(&ste);
        arm_smmu_attach_dev_ste(domain, dev, &ste,
                                STRTAB_STE_1_S1DSS_TERMINATE);

Thanks
Nicolin

