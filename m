Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE068A0B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjBCRql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBCRqj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 12:46:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153EAD31E;
        Fri,  3 Feb 2023 09:46:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtLksh7vOQgGtf31ivqC4ND0/kyfEO180ZAJ7TTnBxsblzyrvEmuU+oHk2/vrUCJsR371OK5KsLH3jyeYpsV/4iA0vd1kyI5oPsl4S0UOd5SU5SAwKmUNC5rH1ko0zanTrsjxVMI24EMpLwz/GFXZ6jp9AIq3VUeQt1wSEk1q7ILa+Ac8Pa21QwQSgBiDALyZ3jFXh3lqnx9JXMmxLZ8uJYyyrcpW/rdfifusIbHwB21R/JcRDfxXUJsiNsh9QHbkJXww0bWUSowLTQZaFvtL+ExazlKlIRkJByhUwm8ZgUHr1kmq7JERpnTV964AGpJSiDClyfxWGsD0u0zimThKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJrmhelMPnRxfMmki0FTvcMqf5qShXOb++SMdIPRJpo=;
 b=HgOsiAfPSCsDFSdnrG0kkEwsQimeYIL91TKmuRZ9PRO7+o9kos/zL0j03JIr5rKFFLjh7p85HAA6sfWgbBCSX8EpBt6FWGWwf7yRrWVKLYq9HrrrS9YzqUH/2iKiJs9+R5Z0MzHZDRBK53gGYxyrpzIaImn1y+n19ALenju1l/nG07OyiWinXmeGsGvSipKsYsWIvp1t8FgGNvNzDRwLGrD3RadamolQYyzPU5EMJysbMMt9IJRSdvtVgSdTfjp62/k0/xa7QR0ROsZF4PoQGLYXz111yAeazH6WGwHIABnhEWUmJ4qfyCjJBbX0nJ5medzwrH1OJp3aZi+NCOH92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJrmhelMPnRxfMmki0FTvcMqf5qShXOb++SMdIPRJpo=;
 b=GbixTQZeaKpcl/jLwtAdC+RCTrc6Y5TXpaqYoADbY/mZ8U6WKxn8anj/1NMoDfqWpVSB+Ab+VqhlqlvHCdUvT8N9PML3QVCHyc05pechKORp8modsBiFBdnclM2eyZOpEvZauXoaRCbm/yyXOCMq6jqlPjUpo7zDpO8nI9XSho8DQDWjLVJyw6EY7nCAell60mYnIRqTZDppUTferuh51YPAlUu8yZswdqjPtqVTuXWwGpT86nIoS8AoYTpG0JPGuATGv2vo7PoLOvzC0Ivr7RQY/ex0ccvOLVJzMY8MkIGo1GrWNIj99mYRspep6lNsPzYs6a9xzPhfYqn459AQ7w==
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 17:45:21 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::6e) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 17:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 17:45:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 09:45:16 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 3 Feb 2023 09:45:16 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 09:45:15 -0800
Date:   Fri, 3 Feb 2023 09:45:14 -0800
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y91IKoDq2xrWp1Jq@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a95ce12-519b-4573-a524-08db060e6bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFqLcrtn/q/LYiialWHKyTmNAMubvONzE3I+vnoIG1X+J1WyC5xXijXy+z7tmlcmlebmMRqGC8oVL9UZGzxmMeKuWZA5vcK7lAhA+O8f+/pOnjjg0/sYSvYeuiO4je3eO1KQNjrgGX46UcvlhIFsLA4Q27o/xT01Yh5eo/r+6abBGqUdfm68E6IgNLTuIYUTYkpGdhZTI/UNkJ0jxlryDmp7cf/8M5epbyugODVDC55FV9VAt7CEt9ClaFEGj6MK2nuECT4Ma/6eX7kmMD8O8db2hG9QtTuGkVZ9bSEwjJPhgCzsR/KXXrYjcJtSbH7sD/aIoYzw7tia/gE9a/EvYftNXAQpL2PFSPTK8h+bf5WUIqEMXy8Iz+uf0WL0ibkJcZRrPhIaXlHIjAN7bXH3+5gCwxD3VBJlHbSetzxh9V8EsiPWl6VjPMnoW3fm1IiSZ9AJNkJh8RxkKg4nykY1CKyR9t8wxDIk0L9yk51bbTEb67XXbWxMh7oZYG7jvRVsn73yc5+UkQI92jd41yHdNSXJt4XtOxySJEbb9zp19RkB3VY8nvwP3NIRQvG962yf9VRcIZKu3ayMbsbbcZyxqnYI0+I2Ixn1IxSqADCaYLMfy4tZvQL/goQAh9aXdjvGiLUngsKNmbnjXUnemVFRz4Cunu94bqnrb2EJQJKYBgi34NU7Sy5vy3Xov18gtULYLm4/otBwNvUBEGtNljxndA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(41300700001)(55016003)(83380400001)(426003)(336012)(47076005)(82310400005)(40480700001)(36860700001)(7636003)(356005)(82740400003)(316002)(54906003)(478600001)(4326008)(40460700003)(6916009)(70206006)(70586007)(9686003)(186003)(8676002)(26005)(33716001)(2906002)(4744005)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:45:21.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a95ce12-519b-4573-a524-08db060e6bf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:

> > +/**
> > + * iommu_group_replace_domain - replace the domain that a group is
> > attached to
> > + * @new_domain: new IOMMU domain to replace with
> > + * @group: IOMMU group that will be attached to the new domain
> > + *
> > + * This API allows the group to switch domains without being forced to go to
> > + * the blocking domain in-between.
> > + *
> > + * If the attached domain is a core domain (e.g. a default_domain), it will act
> > + * just like the iommu_attach_group().
> 
> I think you meant "the currently-attached domain", which implies a
> 'detached' state as you replied to Baolu.

Hmm, I don't see an implication, since we only have either
"the attached domain" or "a new domain" in the context?

With that being said, I can add "currently" in v2:
 * If the currently attached domain is a core domain (e.g. a default_domain),
 * it will act just like the iommu_attach_group().

Thanks
Nic
