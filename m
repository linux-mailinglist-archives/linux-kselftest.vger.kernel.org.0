Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBA7CB193
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjJPRsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 13:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjJPRsc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 13:48:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB23A2;
        Mon, 16 Oct 2023 10:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2PNyKAeVqGqDOHwjm/Tcbglb/DvNmhe3/e9j2ZWj9Szh8Wmdq5eJmHciJNO5VggA6vGIXxIOb8mvHhg6sxx58zaCtMiox3h+Xc4ntRac3gM6zBJkx0EAdYF0066mgGvD/n2trSt2O35O7Zco4fR9KtY0EyFX8wBpFc3ViCqdwjDL9dqiNSEDInviNqaRZGUu47bQN1KwPQCkhNV0a+3CVbtsjEa/A6G5TmQZtAsuZFJR5v+9KX+uodW9BUy9usQS4scK8HzcwXhJ7BRYZ4112P0v55U16wypABsX6WAWouhISBx/kXGILpSKV4dSEr6w6ZZvy5mdF1S6xjts44lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1kgxSnZ95EdQwHQ1kDJ6EncEpmHUcP+BRktEKNMbno=;
 b=KCYVePoy4xPVh2vIFhtCEGE1hT4OyFpyWP7EaDuzsSNyK5T2JchLLQJ0ONx6VZKwOqhuFh6c41oEH71RKRM8EGhLDG58d4pBYxn8hybUdcTAey1UK0cSgWHoxD6MG0hejf1HJFMmXzvjb/xPb1GkIqkjh/siE7bFVDLwbZjucWg52zH9pAeeiDvsFcfGJ+McTeFFuKay1BSne9v/N1OfjjCUKSCfdrIxN0yaIOqB3q7Gg/9Ee0thSHyoT697hEVYp6XQsd26DTRd2C8NlRxo4e+n96VYE/vKUNuRgb0YEhotCsNhWD1+W5fgvDav7DSGUJx2c2/4nKcrbOoKcRCk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1kgxSnZ95EdQwHQ1kDJ6EncEpmHUcP+BRktEKNMbno=;
 b=PJo7jCVaYKY6lUW56N0xjrNXbwBZINxpXPtBNGGuB4+UtVyjrZixP2lXoN/7U+BhEbIBO4eXVoZ+hQ6eE0KKWDkD262OMf0C0+xSx6m9EMOP0213j9GocmyGhGZJJTpgQayDNVOBjWTw4TEj7C+5mCn0499mtmnqRvKV4PUyDu6FscKN3UD6sR9+iyIqUsu8ZSY5QznImvb56rptlpu9WzHf+H99V18Jx5Sr44JIOLdAgd+hndWcrX5edOAALjutVkfKUU4FquaokYf3IfWw/TT8s6Ga1TGROCByK1F1s2honqgV6qTPKZpdr3HG/nmcYsBY2IIIsRprmowOAyYwGA==
Received: from MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Mon, 16 Oct 2023 17:48:28 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::64) by MW2PR16CA0016.outlook.office365.com
 (2603:10b6:907::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 17:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 17:48:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 10:48:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 10:48:12 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 10:48:10 -0700
Date:   Mon, 16 Oct 2023 10:48:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 2/6] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Message-ID: <ZS13WVj4wpHeNeKP@Asurada-Nvidia>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-3-yi.l.liu@intel.com>
 <00163e5f-1a5a-a5c6-baa1-12b2a97e12b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00163e5f-1a5a-a5c6-baa1-12b2a97e12b7@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f4ac71-a7fb-4aa2-c021-08dbce701a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCOf2QGqRi0+WmXm0VHOx/czCbURyvyrnaF1EOcTXrxKy0q42e/6LF6dAFDSZlyEEQzE4a0UH9SrFcYBbLLxHO2LtJVd4hDEzKd74AYG+ibB8cr1tmPKB2S/qzixZFiV42eo7h0HTYC0n73dPhA+X7cl0obxjmqLIcf4jfA7ht/Z86/jwgvBszUnHdcQT+x2+ia3B75umHVxItGO0ZSoMg9bNcsPZu8NA4HD53vO6N/3UC5gYthORWa4kvdWK4qeN45UCZwrF5Rze0KwKZyQq/JetqaQWILEyvVPxFlAk5E7Wu4zD6a2QVUvF4LeP2VYek5ZIH/oky/LjCc5z8FUhHgKQg4jF5KvaLXqXU9ODBqnjEpMJnO8MXqFKj9a4s9uJZh8TGLwxMBBCpYSyiDGNNvPAacH3vG6gLCNYz6kJTiLhEzLNVpzQZfbM9hnO6Lgf/X3nAH7U/K6khYIl8oqtQoAHpJZiYU0qZFZ3UnHosfO/Y3mt1skIjTNy0cV7mzNMKuX2eRwaaD9PfB3eU6leuQhRPxFViB2DpKVmUGYd09iJHtKvK4FyFM0i9ackIOVIT1pV1odC77UBNydHUTNoJNQ5C/B+zIMeRwILiu5aL66rPfaeowYx19+wa5EEzQrKp8okLKRLmkeJO7axLkUApKJnuAfCtpHxmn4bdmX1nBIZx7NZ2xx17zRwKf4n9y2MaMm8yxT4plB1sOEpDUMWY9cLik4ua0QmC2P/xQoie1LRowmZcOWT6EyGSjLHsr09ri0AQiOpywxcW1g3sD/qg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(9686003)(4744005)(4326008)(82740400003)(2906002)(41300700001)(47076005)(478600001)(966005)(26005)(336012)(426003)(86362001)(40460700003)(55016003)(36860700001)(316002)(6916009)(54906003)(33716001)(70206006)(40480700001)(70586007)(8936002)(8676002)(5660300002)(7416002)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:48:27.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f4ac71-a7fb-4aa2-c021-08dbce701a98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 04:16:05PM +0800, Liu, Jingqi wrote:
 
> @@ -88,10 +90,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>        refcount_inc(&ioas->obj.users);
>        hwpt->ioas = ioas;
> 
> -       hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> -       if (!hwpt->domain) {
> -               rc = -ENOMEM;
> -               goto out_abort;
> +       if (ops->domain_alloc_user) {
> +               hwpt->domain = ops->domain_alloc_user(idev->dev, 0);
> 
> Seems a "flags" parameter needs to be passed to 'domain_alloc_user()'.
> Like this:
>         hwpt->domain = ops->domain_alloc_user(idev->dev, flags);

There's no "flags" parameter until the following PATCH-3:
https://lore.kernel.org/linux-iommu/20230928071528.26258-4-yi.l.liu@intel.com/

Thanks
Nicolin
