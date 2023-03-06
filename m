Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224AE6AB45E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 02:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCFBnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 20:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFBnO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 20:43:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291E68690;
        Sun,  5 Mar 2023 17:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2WPYEGDjjCPQX/el8PTTWJAmx5q7llTQmkUIExfz0jKpHCUGqJAkAbY+07vs2984Z/qV6X56TwD+AefW4Y7AarieWUdZ+OIDuCgzuS3zQnPYeNWsUMWEVNXafXN+ANBA11SCpNI1uewTJP04W9MW6JQX69AJlQixMy0qoLsjfB1OyEirZXX/7+hmvLV3hZlW+TfQLNgkuVO/E83w3eR3wRkRtM+nSkVdePOmhmSM3Hkp770gJfBcJ25ae/rWiAsZzUdc6aKMGFMLE89vERV+12+fmrwI64NIXMl/rKzdv8zlO7ZZ6tUQZrSsAsgTwPA5OV3kJV+/+qrj6zxL+o3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvtvSx/uh6AlxSan61JQq44g22aYPAMmcgGv7y4ikVg=;
 b=UrekO6N/qj/bzqfab7Ng3hDNwaDK+ZwrM/cyFbneLNDsfNxdCcUUXuRwH+cLGGZlQ8vWUXQctMG86qwymvroedxYUemdgfBI+X/Lz6X/HwBnbDd3qR/XrkzuDleCQdQxHP5ctUVxGwJb9/r2Ve57bJzd0Wn7VE91UVUIuhJ5ZHu2rlZJdqOKc7GAVYGOdWvKcRZVo/U5VCO+zXA/Ztikh4TVOdZDBhq4c6HyEqaTobQhgi49Wri7SwSsiEZv9QiPDNb3WzouaWGai1XnxoK2tpstR3qKGj63TYhv96UPhOtcmDoRjDJxheKQY+UlWW+edqE7lY2jE4jDU1+PXb0/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvtvSx/uh6AlxSan61JQq44g22aYPAMmcgGv7y4ikVg=;
 b=kAcpF3rSZm9iAkf70b8JdkrnILKuncWvdNQHW5qMhxqiMvLbIljiEx8tzp2fcgaE8Uz0W3RjpYizwQES2C11d/ckVqXiYAh14Pqte5xBqqKDZYEgYJftztzySB+3qF4xoClhp4KUNrKFolp045n7v7ShZHjoEqt+YAsi6/J1TRWKIGZjHJulJ449ppl+wjx3N+t2Gy1m1AWrfTYHc383clUNlQwb7N9iQc60/b8JyXmaYlOAq+gFS+IuHynD2U0hpa5i7/GblLHgingforQC56KXTuz9NkkkogJoAF5MfJ9yBW4porOyGJwXolxCtS3pjBCqQ8lmOKbwsk0p01UZqw==
Received: from BN9PR03CA0729.namprd03.prod.outlook.com (2603:10b6:408:110::14)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 01:43:08 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::3f) by BN9PR03CA0729.outlook.office365.com
 (2603:10b6:408:110::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 01:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 01:43:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 5 Mar 2023
 17:42:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 5 Mar 2023
 17:42:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Sun, 5 Mar 2023 17:42:57 -0800
Date:   Sun, 5 Mar 2023 17:42:56 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Message-ID: <ZAVFIMCHBcv4pJjW@Asurada-Nvidia>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b766dfb-acab-4034-3f6e-08db1de42353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/pchhz792icxvXx4+sSFqKu0tnKVDp0+zi7I8QMCf+PfdCRkrCJQr850lXSZBLNUEdl1cr+lVfDyVfJJz2BuKYigHwwTFnMXVYaFSfHMXRd0DnMBbgQCRRp3r7r1Oq8jd4/MVzkaB2mAJEn6ph8iaSlWlS5NumruFCDQRejEOSogR57CB6cv0pCRI8qbOyzwOQdO5pvbHaWlfzyY89vDzZOqhzuLMw47HuG8+k1GAWYKND2wj8bC27219vOGKyc/2ZHnXtfPt8xePKNOVYFDhqcU0LMVfzPe63lvW3BXBY59ouQ0+bdzpLRsXC7HqKFVEpJL5XtXu2aIlTyrkPOTYs5oQj6bq9B7/AVlw1/aDsX72Uob1LaAeLkC7QLRAYj1Am85NZk3xuLkghvJ+Yddeq9533MfbWxLYU4c1xDGzyB6YT5LFuqKnPu22d0+Z2xBt3cahOvNDU1deTqsT7hQAUCD5+V9dht3VCFZqX+rawuGiLsbjQJt6vPWC+qXwnUo8Y8h/wmDv0Lc+DhWVPuP0+cufa/JOaEh70MJYv3KZ0A3KyRvX47wEBv2kIthNReoiZk2eiaRAd+x4ofALERUJUmd0trnWK5XYKAxQMfuZ3uF7HDXVqr0NsdnPxwG2rGb9s1s4vsmn6Y3PQ2Ga6h9p33keq1PutxrucEVzMxm4QWip4HjAH36V8eiRnEf+eVXUu4BluX5uGwyjQApbVNNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(4744005)(6862004)(8936002)(5660300002)(41300700001)(70206006)(70586007)(2906002)(8676002)(4326008)(54906003)(6636002)(316002)(478600001)(36860700001)(47076005)(426003)(26005)(33716001)(186003)(336012)(7636003)(40480700001)(86362001)(82740400003)(83380400001)(82310400005)(40460700003)(356005)(55016003)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 01:43:08.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b766dfb-acab-4034-3f6e-08db1de42353
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 08:27:57PM -0400, Jason Gunthorpe wrote:

> +int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_device *idev;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
> +	if (IS_ERR(ioas)) {
> +		rc = PTR_ERR(idev);

PTR_ERR(ioas)

> +		goto out_put_idev;
> +	}
> +
> +	mutex_lock(&ioas->mutex);
> +	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
> +	mutex_unlock(&ioas->mutex);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(idev);
 
PTR_ERR(hwpt)

Thanks
Nic
