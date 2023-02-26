Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C036A33A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 20:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBZTaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Feb 2023 14:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Feb 2023 14:30:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0FD83C2;
        Sun, 26 Feb 2023 11:30:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV3qcnu13L9ypHoMhl5zv8Q0R3zg+Epfiw+9p6xJY5d6DoyQ6azi0UIDvyoF97RTne07CFenelYu3A2kGuPLGEm3vRmm+0NKcM+/vb6JbO3veChLh8nWJr9OG6exc5vNdTFXnPJoqiHL235xIuBpSyE/wgHdgOzpNBGsAGJUMQXcNcXa0cduStqbEAvzC9pNxcxcHanJQpxfx0TtqK8G3cRtmibLHHTbyYoKtLNFF44lGyEvyYk+zJ7WQd5YDVLjWcTwHDTyDaZG32+BUqNpzvMj5e4qbws15QGePrr9WAIZsOwMcFhYTilixMF9ndjgvAWh2J2fLqRDrggKEcQslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsDzIOVPhX8PyZ6/OeQbZx03fd8XKElli2fH2sGfHZM=;
 b=NE+aqpHA5BAc/lw75S7po27lAr9/gXFqZlGEZjsetxDPWq9g0N9kWclDt+5VfdWbzUYZJAG9P/zSdMPP54y/rsyOQhpVfHdb5nK7lx5iYPpWPAdRXyJUZ2GJAhCJCwpfrCMAwXoiQQLX2cljYxiEuNX2rBptM3xy9y2Y8Xhyi0mhOoQOlkzQqdli0X+pI308jx/zy2CfSSN2CcHwKWKZKDXC/qTHfHc1Mo0GWPX7Pox8jmgKwiGRdBMB40VRo8FQ9e+0XHRfHGapfOzZN8u5IuaWS2GZg27ILjTJDQS+nxNDeZcNrbUrJQw1LtD2Ufj2rJr6ucV8mp5NwwZjVuRRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsDzIOVPhX8PyZ6/OeQbZx03fd8XKElli2fH2sGfHZM=;
 b=YwtcsaZBPmsydMZm1g2KuSr/5s7UZ9OYBBsi4oFk74gaxluRGEZP37nwN7VPMFfEw57RP8K3TgcrcgyhpYjt5ntayzYqC3izUblWc7XszHtktev8GhBN9aw8ZWtImHVaPPFRgcjj578r4gJ0HkchPkhbjbFIBdJwskKBeweUsVquY9XLMXMEcL1nDwXp5UN/sE+FiS69woEd8subPJzY5uaaA47H2U2ybxlp2anLyYyUZ0vezL29vgzCszC3RKLeLn9t1jgFXhW9/NT/yZ6K0/8f6kWNPyvwDMFM0mOAcYUR6UqSrCQntJ0nYy1qIyx1J45IDMxDFh2LzeSD5Nyydg==
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Sun, 26 Feb
 2023 19:30:07 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::64) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 19:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.14 via Frontend Transport; Sun, 26 Feb 2023 19:30:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 26 Feb
 2023 11:29:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 26 Feb
 2023 11:29:57 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sun, 26 Feb 2023 11:29:56 -0800
Date:   Sun, 26 Feb 2023 11:29:55 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add a selftest for
 IOMMU_HWPT_ALLOC
Message-ID: <Y/uzM8PD/XY0WI7f@Asurada-Nvidia>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <14-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DM4PR12MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: b21acfa2-4135-4a88-be91-08db182fddfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksyKj/SfNL7pLgeJv9PwdslG0ueVwaxpkgFhRpDjMHVacgu5qCYyzoB3ztrfplJSmFuHiq1iGuKCJLTGJAj0SxvGIyHOUVaV/NQt/p+B7yOQNrf9EHgqHnOlcO36EXqsv11g/QRsUB5hSv3KXdNpdgZcRLf1OSs5thYrUN2DKSvS4DfFqYgrTALOlBUS0Hexj3qFYhp00ux2u/9EJx8uMGSi3TLsbBKhMGtyFbCxWwGRFO67UnYoqoiP7Z+vlMSp5qD8SARp2byLzV5ugPG+hoa2ipWnuYXSxLPSGXBSjmaMT2L8vN1egTiEraKqwbr/ZUqeXVKUFroskg25MDz6UuyYCddqcAaVZc3hJKhwrBPsc2JwpU05rYkyiWFZQ8TX9/zziek6amspqzwlV/o5yMNwxb1Z+PcnEYuQp9Qv5fxZ2LPetdbya2+XoMxHvVe1hqS9gN9PdOKAiHWY8ddZJqV/tYsMb6W/utuw1PY/s9l1TIiTWAj/QQc96ETxRAQv5Yx2VGTSaaqkY3wPLq+r8u/Lg35VouumxuLP2DLAdCs8LOdwU1FX7y68vbQaFctrsq2lKS/CeWPUUJNclRBRvuJZsjEVrUfWIEw/2zhhb49OBbGB76Q94gExFIocEH3/Ao382AYahrFWntFzhTWg3Lk9f3RoAhmnS1thXMwNZ6LqKP02WaHeXfL2t7DbqcF+BwBztDQjpj1YfkF33EjZTNFC66Ldlb2+RDdX/uUA320=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(82740400003)(356005)(82310400005)(86362001)(426003)(47076005)(54906003)(6636002)(336012)(478600001)(34020700004)(36860700001)(70206006)(8936002)(5660300002)(41300700001)(2906002)(8676002)(6862004)(7636003)(70586007)(26005)(55016003)(40480700001)(40460700003)(33716001)(316002)(9686003)(4326008)(186003)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 19:30:06.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21acfa2-4135-4a88-be91-08db182fddfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 08:27:59PM -0400, Jason Gunthorpe wrote:
  
> +static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
> +					 __u32 *hwpt_id)
> +{
> +	struct iommu_hwpt_alloc cmd = {
> +		.size = sizeof(cmd),
> +		.dev_id = device_id,
> +		.pt_id = pt_id,
> +	};
> +	int ret;

Can we do "s/device_id/idev_id" to differentiate it from the
"device_id" being used for a selftest device object?

Thanks
Nic
