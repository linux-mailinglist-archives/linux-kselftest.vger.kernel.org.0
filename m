Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD286A8D5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 00:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBXxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 18:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCBXxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 18:53:20 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8AFEFB0;
        Thu,  2 Mar 2023 15:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKqe2Q5tmiCXT2UkAEb+PXmg2IViUKQrSxy3uit7FrRnqzNkJjmSLS+OMKz3pQuAXIGefjmfepMEOWrVkjTzNc9IvVMfAJpcN0pazwqf+aXIHTGYfAOIBgM/Qoj9C6C5kcKGmzh1P6bFfCw5UkFmJn/LhHMOBFn3tlKo5//fw6RZhhqKIotxIwxI/qSXOT+WW6u4rMtoBL5fkchb0jkdKRRVRXaj/ddNAzDKUdEb45KreQI6VB3cBqSMSoXj0h73gDNLaLBHOpnqpsKjoRpNsIzBiDAh1uXZczvoVuMemXHHHlvsVIMtdbj0YVMGMd+x9yB5aKWGxDceT63VNeTd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moWfVH4QsSUw7vyFEjfh1cCM8dMMOBnh7IGFqGrTElU=;
 b=PxXIWrblxNBJdQdaNaPOb26kovv0TVa9v8y+prl9fipk28dkKkHhW/l56o9oyEguzid7vFOBX8HuQXeCTmTLKVHHfM3a5A1TVkWqS2Q5XNQRzMPKE+38HiDCa6XevZPAjoJfMALYCsSaJkdW1mcQ4SfFQAJQvF1leavRL+8I8NqPMD+j1gCpnQxKY3oTk3cM4I7zVzkRNnoIq4RhKZFvb9xMicLuTRFMIx4W9+d5GSQ1v6DtpODQGsZlq/hkzN5J9x3IhRhbgw69qBeFYGTCVe/DEAhTSEQAB8Fo4jfb5vcYIIVH0P8E1mGHaHdnc/GFQov6lJKqoj5g/LpN0SAU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moWfVH4QsSUw7vyFEjfh1cCM8dMMOBnh7IGFqGrTElU=;
 b=nuhzwNAe5hnFCxQ1+4XoXVwg4vKz84oseQq0/U4GQKeH23Yjkm1hvECG7V5FnKYcFNcRIQkFknvxRFw1KJur5jm6y7JrRdd5pyYenRBh9NfphtzRNPrzj0QZ6z5mTGFmU5P/GP3Lt3q2Cwy0y2VFusDdbjPAbtGzacrqep/umSnGvpwECHhmPvQELPk/2aeoSeOH80dP6VzlXMm8FDWC8Eknjz8ylAfNqKKi0aPD7EmQgrr7/Fpy6uHXiqSjbqcHczwIAQkapLx8yUh1/S76MZfrD6KEj98WbswAlDiHx13IF4dmbWVPdEGjBf3TojKCwRyExhLpaa0NsPXTHvTkpg==
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Thu, 2 Mar
 2023 23:53:13 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::85) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 23:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 23:53:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 2 Mar 2023
 15:53:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 2 Mar 2023
 15:53:10 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 2 Mar 2023 15:53:09 -0800
Date:   Thu, 2 Mar 2023 15:53:08 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <ZAE25M7ZhKmk6CIY@Asurada-Nvidia>
References: <cover.1677288789.git.nicolinc@nvidia.com>
 <a104b334d3cc148620ac1f2aa465fc14be556e63.1677288789.git.nicolinc@nvidia.com>
 <BN9PR11MB527636AE29756D8A188912998CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527636AE29756D8A188912998CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be67238-4029-43e8-c026-08db1b794906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gpQlQ9ILSuC2/gknpDS1S1a0/ID5xScbv01SWP6UmrVhyDhFJ+/Z7auzn1Qs28FUbMkxHLj9ft9WqPfyxPvZF2z/LXiQBQh7+LiZnpfqJK46R2piCwxBqvJqgXNFVQrdbh0Ak8ucW8cm3xBOJjVncmHYxXBzvtUfTDag5wTGtXkLc2Xjw7uGDzMRjo8a25P9xvUPak5Puh2tHn9PU3n+WQy6IMwo9ysstbz6LVZOXVjsBkGWJdWaYc6VrqcugFugXG2gdN3iQ66JOQaBhv5ncsjnBPvFgVXpzOifnKx0ot/jIDZuKIfCS2xBrO7/Szv1myyEAOcZKjh+IjNMe85sOcScYAm7DhNQlk1+oQImW61KGKuBZT1I0Y+fXKv7DfnCRbLdGuZtMyD03TZzqZAYNqhUtqDi8eZlIWD3dzfKuTFRXzUWUkzeQoPl+sIsdDgIe5GX3mNAt1OmsJXKazIfN+vnRG9FW3j9upeUnZZrbvjzLxXRiZAHV36vZC+lbgEU3/KQFrCDBor1/0vWmYGFY/w7/H2OqBPhdhfGyDVEKIRcXK9fsVGJyFoaI85K2A++d1HFuJ1ePits1pRs96B9bswVxgnjHOmSf4STaDqYbg4Z3UlJek7xlA7aC8sAa7JCoxH9GR/bFAcVN9yokAouScXafIo41LMRl+z+w65bu6uq23GfZd2YeuY9TndAFMS/wPWx45SCnecvuOICq6z9w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(426003)(47076005)(40460700003)(478600001)(7636003)(82740400003)(7416002)(5660300002)(356005)(40480700001)(86362001)(82310400005)(55016003)(8936002)(336012)(9686003)(186003)(26005)(33716001)(8676002)(70586007)(2906002)(4326008)(4744005)(6916009)(70206006)(316002)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 23:53:13.1822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be67238-4029-43e8-c026-08db1b794906
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:23:54AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, February 25, 2023 9:52 AM
> >
> > +     /*
> > +      * Set ioas to NULL to block any further iommufd_access_pin_pages().
> > +      * iommufd_access_unpin_pages() can continue using access-
> > >ioas_unpin.
> > +      */
> > +     access->ioas = NULL;
> > +
> > +     mutex_unlock(&access->ioas_lock);
> > +     access->ops->unmap(access->data, 0, ULONG_MAX);
> > +     mutex_lock(&access->ioas_lock);
> 
> This should check whether @unmap is valid.

Will change to 
+	if (access->ops->unmap) {
+		mutex_unlock(&access->ioas_lock);
+		access->ops->unmap(access->data, 0, ULONG_MAX);
+		mutex_lock(&access->ioas_lock);
+	}

Thanks!
Nic
