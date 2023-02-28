Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FF6A5019
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 01:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1ASD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 19:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1ASD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 19:18:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55B13DE5;
        Mon, 27 Feb 2023 16:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+4LgMc0zhpNNDELfc2xlf8fo6tCijsZTg3NyIH0wQhVWvLqRKXoji7xv1FCeER3Hjssx4D1o8w4Ifmambe17sRtC2HgkdhQJqHd/EujcoQZBrVMKjOrpa1ykMalD9LKor+2BpibKpj4H+IBMingkOQNPtmFu3MwGwKEqs/U5d2gCSs9odUULpxN8VNdA03qMGMffJZ78oT+ZGUM9FoHo3vLU6htCPJ7aZdeGUvlEbdCn8TPB9pQuZJzy40GqccE87LTMtdeT5bhZq7j0liStGq64UpNOtl8gSHxnVLSCtCRvUma3fkO6RtmI9aUNGx3Cy6FkAx+KGDQWRnSkiFaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H15CRLyaxYSA/YU5L0tz8pFa9Y0L+wefwgiVMwnOx2M=;
 b=U7LUVjsyJw/zyX6kGxrOKX9BH5HPCfrQt+gip2EKR0COh0YKGWsLw8tX/Bpm9SYoRhvGjzMbUK5/ecibp7ZeBdfmKNwXhXAsfrT4JbRuU3puha3Y0Kt5eTUOHbVpp1zYJ2rofmnXHbxE+ZekdqEeAOkNeXK3u5J7BB1oZvG2AOHTsBzcDgPFTAyCB+QPg+5gnoUQaPELFE4FJi4JFEU2UqV0m4LEyd9LqS0KckLdJORPqTeay/fxYP2qss2Y/n015+J3XZu3P7hIk5Oi/ZVpAj1iJtlgT/s2x38wMU/jxw5iWu9IlPb5ySMTybgqEyAHERqeEyMARJUe9RYAFQKWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H15CRLyaxYSA/YU5L0tz8pFa9Y0L+wefwgiVMwnOx2M=;
 b=DrIPrBnvXtBbBJqSD9tcQdKO5sk42wj+YyfTLg0zjMLOd1HHPEb7t/qUhQvH3IT/39c/EjYJuqGeDnSZt5RbkDuKHIh0nHAEnJHKi90EmJYz0l4FlkcxL9pwS+mbpihVvchVrOEeAZwgc+CvIxAJF2hvgicgOWw2lMHG9Uiv1iLuCKXsaFgo9EBjzrHx5eMS/TzpafipW8y0PTVLHFUbQW/lqDD/GZAMtKxKuqirezduTb47nxjlYAaPpnKzLP67viG1Ddu6qiScBdlYgj1nxOoH4i+cQcqHmemn4Brd/c62d9XwXJAXvdNb919NYpc5g9OVdpnuYZtgLCdju4W4Wg==
Received: from CY5P221CA0073.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::10) by
 DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Tue, 28 Feb 2023 00:17:59 +0000
Received: from CY4PEPF0000C970.namprd02.prod.outlook.com
 (2603:10b6:930:9:cafe::3e) by CY5P221CA0073.outlook.office365.com
 (2603:10b6:930:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 00:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C970.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Tue, 28 Feb 2023 00:17:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 16:17:49 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Feb
 2023 16:17:49 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 16:17:48 -0800
Date:   Mon, 27 Feb 2023 16:17:47 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add a selftest for
 IOMMU_HWPT_ALLOC
Message-ID: <Y/1IK4kVz07xiY8G@Asurada-Nvidia>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <14-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <Y/uzM8PD/XY0WI7f@Asurada-Nvidia>
 <Y/zGCLb5aGmxWPHu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y/zGCLb5aGmxWPHu@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C970:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: b27cf57c-f0c4-4912-f496-08db19213f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DmRfPG+Fhqx4nYO1u0/RbvIFmCfKktUyQkQQGo5jSqQCNG/qgbvj+VcTEB+sW56Qb9fKfbRC8aNZeGs4fMJkqOz2SiMkn+W7xdBCYEC+dXc+kIFlwTxwNUPfzQbYLZV7tgMs7PI8ezzv6Oct9Fd+Q+Rxf2TX2qKAVdVoAghMnzfF6XpXuYLWypghagxOco5fgpGYRuxjQyAYPLicJao4qc5G4kb4W7lDWdI+ISeWnH85lz/hek4FPxz8TsVN+oXuqkEqYtGJwQgOo11f9yaUydsF4yd+s3GMabBGQIJMatVT/gKLC9mtFkx/65LWtbRLSDpWgISkKsErF5LREwtu65TYMOCRLWeKkr8pVP105LEDp8E0JBDj5ujFm0cqWhPfWPZQ1JKEy8+emfEqi9E/or/904wEvdYlgqPLq8Ocm1sJQGljF/7LXb3WfcSGS7thQikq/6Ty+k5sXJYCbiStXvV/4Du7kLFan3JbOJOb4gYIap4j7V3Ju+RCS+x2xq2qZOul0iuknzinxL93Gwrmje+TxoS5vqO00nfDCSwqdd9bPi5msHL/V1so9zad+jwyPaV8N/9kMFP2Pr61C5Otdlio3+Zs6TE05ckhr4urg9NX1m15KezSpCfvgUX+YGYQAkLHjNjboRUqduvUAPdMIAWC0C2REcepjRKPsEPJPiVo1+Wp/gm4ybbbteG3tKKGy4l2VjSnV6OKx8pMit2PQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(9686003)(26005)(36860700001)(186003)(426003)(47076005)(82310400005)(356005)(7636003)(55016003)(86362001)(82740400003)(40460700003)(40480700001)(336012)(33716001)(70206006)(4326008)(8676002)(70586007)(6862004)(8936002)(4744005)(5660300002)(478600001)(41300700001)(54906003)(2906002)(6636002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 00:17:58.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27cf57c-f0c4-4912-f496-08db19213f55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C970.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 27, 2023 at 11:02:32AM -0400, Jason Gunthorpe wrote:
> On Sun, Feb 26, 2023 at 11:29:55AM -0800, Nicolin Chen wrote:
> > On Fri, Feb 24, 2023 at 08:27:59PM -0400, Jason Gunthorpe wrote:
> >   
> > > +static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
> > > +					 __u32 *hwpt_id)
> > > +{
> > > +	struct iommu_hwpt_alloc cmd = {
> > > +		.size = sizeof(cmd),
> > > +		.dev_id = device_id,
> > > +		.pt_id = pt_id,
> > > +	};
> > > +	int ret;
> > 
> > Can we do "s/device_id/idev_id" to differentiate it from the
> > "device_id" being used for a selftest device object?
> 
> I renamed the selftest device object to 'stdev_id' instead

Cool. I will pull-rebase.

Thanks
Nic
