Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585A077D2BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbjHOS7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbjHOS6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:58:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935C31FD0;
        Tue, 15 Aug 2023 11:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4K0PB11dvqK0i0vw35ZpXc4WscncV2e4j3A6nkPkMQPMnmLeutzwiDDEI0iHEk4YaMh2tL9O4t9HO3zT22YyP/EVq9uTTvjEWOYDyK9IYmLfv/jv39ymCGk16EM0IaOYYCFBmgHKq99nz5JWnCvyj4ZAKYp8P/D3INm+RMf6y8YkHmiODOvDFB/gDvTEd4JioolLbGfaAw2TJUa1m+GZVEDe3Vd005hJjPoQL1CMN7l9J1I7D9PxiHdRZIMAADJLo8YXHHwE4srJjN/UNpvkJJ70A8B/YrI4C6QJGmTdlw/QIb0hGy04yQFeCH0u9VkGgD4TWWzF8siDEhK12LSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKqViah37fP3xOxJrV4r6gKm1nQKV/HcX5onmLoDu0s=;
 b=X7N4AIQuREnq2i8MsdrS8CSd7rZ6+OucNiUy9hpyrk1ZC/INqjSi4AQ3Tc4NsZnzcXifX+AcYvRs+Z3xvVvTvzALzO/KPax8sPWViWt3BXq8ltbgnU74B7xaSgBPOC7SyGsqjpsj0SfxKbONRz0WddZcPPsBcSYe0xO8YzZLCMciLweYJn1bdckJyzfMGtgfdhFm2XCTIOy33XqkOF62ZM0yAbPlY/qGcpgP/R6rZFgzYraXBgQDIlV7LCJPajXgcmX/u67FeWnTK6lwKLZuGumbty7UxMqj4eB3pl33m6sOFlbDufGxLwIEO9mb8VXerRYhsuD76iIP5POVWxkmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKqViah37fP3xOxJrV4r6gKm1nQKV/HcX5onmLoDu0s=;
 b=QskNc22aJeFXUHZkhaaVOUYGlVKNf5SRzLW7j1HGvt3YVsSB4VEyV5KTtXKZ+M0EGrpGYBa895h0kQF93LZO2esg5CCpy7YfUETFM74NuU++BiyoxCwhfvQ45kD9+sBkj5HVdkOSa9noiZR9ZrGbpukPiDBROcLEEKv4L46EGXSaGvnXz6mEwaLpnR4HcqoFuCMPJRQ1ZINqP3wqYAZ0Wggyqc94C+f2rqM7Aw5P2lfkAy1kDAiwh2feuSnFBVDoM0LhOfLycCIQ5W4CW0oNcvgYOP3xJTqPkXmCU+leTPxFLYEUgaQ8263OF9j7rR/ha+rVo3ZbKVPLBWaBdW8siA==
Received: from SA1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::29)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:58:17 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::b) by SA1P222CA0013.outlook.office365.com
 (2603:10b6:806:22c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 18:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 18:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 11:58:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 15 Aug
 2023 11:58:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 11:58:02 -0700
Date:   Tue, 15 Aug 2023 11:58:00 -0700
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
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNvKuCFqCCWwIR24@Asurada-Nvidia>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
 <ZNu2XWS0BERqykIA@Asurada-Nvidia>
 <ZNvEAWF8ljWHrcws@nvidia.com>
 <ZNvJph2AHKroujFe@Asurada-Nvidia>
 <ZNvKZWcqrjp34zpe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNvKZWcqrjp34zpe@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f924a04-df64-47f7-4e2e-08db9dc19645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZvqeeMIF7bvIYUY6QLox2Y2nFc5Gxlhh8IeUTJqSy/TG34h4s4U0c+WugGLZyegolV/xyp6vivcj96DqxIdq7i5+EmS4CcQl7uzfIqB1qe05qWcVy/vq3e34Puy1NHaSgytaX7yPmmAzmIiknE3ZrN9fOZ1QWEZckb4Di1ZDp4CMWKO1wdWGcN04L1LHEcsaJGKLhYWvj3wwOuLl0VjgH6FyyUH8f+yuaqSO3BKNdX+Tj29/2svSZateZXP0ueryCeVKDRGHL2O3Bz+xrk9ntdjY8IrGOJxgTrTiJhTa8IvBKY/Ex0d+KWI2lWOFD9UuI52kEB7gNqQc7YQcS+vsRea69QPf3ybgAHSgzwpyGDlfnp3kuJfLVHvVeV4W1Hq9IN5hIkn151Uf7ISh0dWrl3Q8/nqVCfBczqs2eXBCF14Vc4EQr0uLA7H8wHv4E2xgTJqd7F/oPiOghDd1n3AzERwNPVlN4Y1W5r16aOVXpeNbX3ueb9zVZ2rTJhX7t4od0WCLPANdV3m6pDvARu89qbuajQP7cjIphO9Ka4bP6dP9XvwmW0EoN9B3uIgRtCqf/8Hn9Wy34WQYpEqt0oyu37VwAimZoUFJyXRFG5gtAbP6d0Scx+J1cjEF/BCwTsUTSST4n0ZcE9MUMbQy4iHpCm1cPSQjcUmk56lCa3ju8CsAfnpKYiQheZRUtRz27MrjmWQWbY61Gr1qme+rsWU+H1U3HgQZoetJlt2+tkXeIc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(54906003)(4744005)(82740400003)(41300700001)(70206006)(4326008)(86362001)(70586007)(8676002)(336012)(6862004)(40460700003)(33716001)(8936002)(26005)(5660300002)(426003)(7416002)(2906002)(9686003)(47076005)(478600001)(316002)(356005)(6636002)(36860700001)(7636003)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:58:17.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f924a04-df64-47f7-4e2e-08db9dc19645
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 03:56:37PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 11:53:26AM -0700, Nicolin Chen wrote:
> > > 	ops = dev_iommu_ops(idev->dev);
> > > 	if (!ops->hw_info) {
> > > 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
> > 
> > It should be:
> >  	if (ops->hw_info) {
> 
> Hmm, the test suite probably needs some more stuff then too since it
> passed like that :)

Ack. I will see what I can do.
