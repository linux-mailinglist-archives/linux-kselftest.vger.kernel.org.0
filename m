Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D750D6C3804
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCURQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCURQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 13:16:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77912188;
        Tue, 21 Mar 2023 10:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWOAQ4OXo/oVFyxKNQpwYlBSiQup1+1p4/Y9nBAbClmr/Ctt9BQ5CdNDJowrykxfsCyzsnvIF8xDkdZ+GMxRmYHGRm9jR2ncbub6YZP5eyA5tPP2yPHaHAf8Hfn3Zj2RV9fC1EU8qTpHDiI62UDYhhbDzzl15bsZI7S860Pvli17XFX98ZPEmuNeSQL/khyQmGlbyOxCFCCgm6XEAk+EdZG1esqey8QuQ+PqCEhv2myALhoRkR34ug0U3e3Qnv8NnwnekNxeh9bxZw+zDzbb2GN/3WfI1GmSjTBqvGET2DKBchA50zxrHwG/PkXUxbPVS+FfX7EaEe5VBCCdfVdkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkRLqS+soNV3Elv6K4KWbg5/tBxEmGRFUcUOr6PvtdI=;
 b=OJ0yV/gncjonhQccqmC6FI2asAvH5TGr8ENxiT3HPGtnjZtOv1TT/aV/WIZpVXU432mwrUlWA9AsMqKiXxHBB/AmbFAjNdwIsZwsl87Nm5K+5ELYyO2onysube/OreT/jEG1Wv9i5pzcjEyjW3RF26L7K31+SRUv9JD+oQJ3acR13lQL4ultoaWXv9IiX9uC9oP9Z5szhJLsiU5kxZ4pxYutnX1OPLNX46oIVUn1XNd3vSn6UbnkxZlj3OoFY3ygQcYiJ883BgVQ5HeVo8pBAU6jaMeVOiQvLb8RX9XUQLdstZkZa+/9zI6Ycaa5W7tziR3oDxRilfpNf3giQllFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkRLqS+soNV3Elv6K4KWbg5/tBxEmGRFUcUOr6PvtdI=;
 b=bFag8B/uv0DnmfUgL1OYoLjI1BKnI/S2zhTus6Huh4R691vYUMfOhtfHtc7/wHLAYkD+qpuMD/OT35VJItwRGxMlTklVq2JOODoQtXLBPZGclZWi4GGyYsYfeshwCQG4/ikraIPk4I2U3kb5IOc1x1gRkSGKTR+BSjFXMkqF9WR0G4fMq6etwQskNbolG9EvnBtrNs0D96tFTkTtKkUZHql/FYjR3v1rAxyciWfNchVGEy/Lc30F9jIOj9GCf8qXJ5fGbKqL6yrpcijVcZ+0T6S5ULj9iH0Ay8gFBrgIkNyGe795sgA4jyKx6j7bfOM9J8gFFh94QZsRQfxoU2D7NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 17:16:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 17:16:37 +0000
Date:   Tue, 21 Mar 2023 14:16:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Message-ID: <ZBnmc5HELXkNEe8n@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 995cc97f-abac-4944-4a7d-08db2a300741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83YtRx6Ay26MKAsqSfM1YOUrZU39GWK7BQ/M9dcB+kxKPnCjH2Z3pZgjYWcYv+o8lVFLx+Hf47Dttqndili0uL4nzyhQfP0YqLy6+fALFceR+xoj9f8jEeN/8DQVYGfabTjxpvynno2r6BqIkyFhYL3C4WYk4jSZQN6PIhtDKF8/FIXiN+g3T4vew6wkQKvlteyMsa6/7dFp5dmb6w6v/LSlY3AFc/wWBsah7UzNXxB68Tut2yR4omKqxrxkdaM+66XqLtibo/0mAVyo+k1iZ9ZGyZk/ngY88LwVUFUx5roNaNgxuDjNP7lzBUrrjNm1eoY20fTfhdtz2b9Bw/AnzO6tVjwKHt92nRb2V6S+/d6hkCv7KrTLVzHwXe2JMEiq4DRix6HfFsiOnzQKGKexIK06BObZnaVdBQHgd9bREJTJMfgflNPKNtMKXqgB6Ua3T04wTO+cYOk4T4wDaHq/YviyivryxNwtbXd28iw8OsvpaPE/+HWKC+I7wbiDONPPqy4szkkZFqZ2alKoVF5bPQsnzFAYRWrHizK+ge1jthUwI41F8Qe3uRXlYzYAmbrNWYlNC5rykc3/cuABocMMIAMno01FoG/lv8iveuy0RgtTFt4eczjt+66e3VsLEuFQ9o44D/NDVBlGGzryVo1ehA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(38100700002)(54906003)(8676002)(316002)(66946007)(66476007)(36756003)(66556008)(8936002)(4326008)(6916009)(5660300002)(41300700001)(2906002)(478600001)(86362001)(2616005)(6506007)(26005)(186003)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0rF3HqmrU5V+23BIOh/xRQh7t9BZ8x2MCJr/H81Ge4FhYW5PZ6U8StVk9IR?=
 =?us-ascii?Q?w/WZSfYRWmmP3+WKOPUc+gk2K+jhf9IS7VzFFBd+EPRea3ho+iueExTzKPhQ?=
 =?us-ascii?Q?9H8LMS+SQsmNyrRAHHiWOCbgunzG6B9UiI4dJtYM+Lbjaq8799Dqe/D43VSs?=
 =?us-ascii?Q?rezYKOag09P/8uLR4gvW+GxdsEsjQQxhrbMve2dJcGSQc2u32jO0bPWRUNk5?=
 =?us-ascii?Q?How6QhjFNNnZzMSGL06IpD209i/zW3lUiYmlNYz0ea7kizMXGQArhR6AONae?=
 =?us-ascii?Q?BKFN3F5BDpSsoBPP+h6quNKSbyH7oX+UlCWu61UayqHTj/LS+kUq9bQVg9+A?=
 =?us-ascii?Q?DDFutCJq4tOtltu+sWdVq1TgVLTWOBOGAaJfxTn30sSIH60ylwI9RzzVqs8Y?=
 =?us-ascii?Q?4WWvLQ+GJ6VnvVX/Jijho91ruKoiIWD31fmzcXDPTS/yh2CKo6IY60zK56aI?=
 =?us-ascii?Q?32oexzwfz8/lXSlaulQO2ey0NXlfXQaq5/JcGlIXfpR3lGyUM3BfdURvqX/A?=
 =?us-ascii?Q?RdLe8M6NQNsu8qV7DAll+kxuCc5plE208l/KlvT7aMVN61/iqNLYOv2e9420?=
 =?us-ascii?Q?CS3h9cOwCLVh2AthBxukwOFw85Hq2YPQmrhEodUljPM39mcbKW0AjbyJv2n4?=
 =?us-ascii?Q?pPPKGhlD2HpcytRTKF9f26dbiQeKpWjfL7Ph9INB7wAOSU+EXgC8ED1W51Wx?=
 =?us-ascii?Q?0rFbnOyB8tkbgTuqWpOIfGLy+3aUXYoPgiEi00Q7nfAWU9YLA4WiQ3/5sL9A?=
 =?us-ascii?Q?hoQmEc1nGTWmFEokHmP/s60g5tH7WfMID3ok4k91YtdzDg5mhfa2GfFJrOyg?=
 =?us-ascii?Q?10p59JfOznVVlhGkA3uP6DhO3v3Cx8uHo240tEflNt20IrOf+gXDueC9c45N?=
 =?us-ascii?Q?a4sNO5hNYbUqJNZVl2mScKPpCbVToGN9M+SpLWM0jykZOWdb0KJeQtDB8Z7J?=
 =?us-ascii?Q?e9EJgEKW588lHYz8VXsnexOunRPqyhR87mMRFS4o/6nz8HFAZwl7JcQVGZRm?=
 =?us-ascii?Q?b4BYIUcZpIYpdbCbFLtE/NbYmlEWZ0Aq7okXSkcogZrKnHX981gxJkEOLOAb?=
 =?us-ascii?Q?Br3AWq8+FrGxfPhcbgzr7Je1XoYvQURUS0inmDpGLt36Gd9EBtUAfPH+jef7?=
 =?us-ascii?Q?r4Nm5I9f+zADSoqU38T7F2Wn0WfiUCLsIqXmsbI0LkjiyDYa1kq4+EdInFgq?=
 =?us-ascii?Q?Ymqz6GdmibhJWXYW7UiWoX6xn2ncVu4uzq7+X1BnbfKJaMtCKwaOLAlnhrXg?=
 =?us-ascii?Q?BUJYLy+LGrs1F9T+92s5xyKYxLlVEzczGvhN+iX1woKf8DkwRfgwmoQxcIVR?=
 =?us-ascii?Q?IV1/igm5fwS4pVDv5dhDJVWPiiV7r9Bc6/pEB0amFutQx7U7yu0U1WgsHa2e?=
 =?us-ascii?Q?qz0c1Wuyn4qFIX80igWlDpoM8H1fuFQg6g1mG+OAo/ZV+mmAa+2sx6MzGzWV?=
 =?us-ascii?Q?EqJ71VeHxMI6/qWDQsFOmsG4tSs7Lae3YX0ilCZZmbDEXj8mF+Z8FA6CoMu2?=
 =?us-ascii?Q?jd3bLu6NDu5+MHE4b6+4QKX9ZnGRgV5ru6ravqt/8UQKeuEakjJGvTFZepxO?=
 =?us-ascii?Q?zYHkd/2K+ms1A5OM5ItCbdEkOgNo/YEIsWApml6k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995cc97f-abac-4944-4a7d-08db2a300741
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 17:16:37.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As4D0Io1lvuI0c+9HUCnrdAMVTvgjsXsNdgjTMOAd8FvcQEWffc+hNrUr6txdg2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 03:02:26AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > +
> > +int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iommufd_device *idev;
> > +	struct iommufd_ioas *ioas;
> > +	int rc;
> > +
> > +	if (cmd->flags)
> > +		return -EOPNOTSUPP;
> 
> miss a check on the __reserved field.
> 
> > +/**
> > + * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
> > + * @size: sizeof(struct iommu_hwpt_alloc)
> > + * @flags: Must be 0
> > + * @dev_id: The device to allocate this HWPT for
> > + * @pt_id: The IOAS to connect this HWPT to
> > + * @out_hwpt_id: The ID of the new HWPT
> > + * @__reserved: Must be 0
> > + *
> > + * Explicitly allocate a hardware page table object. This is the same object
> > + * type that is returned by iommufd_device_attach() and represents the
> > + * underlying iommu driver's iommu_domain kernel object.
> > + *
> > + * A normal HWPT will be created with the mappings from the given IOAS.
> > + */
> 
> 'normal' is a confusing word in this context.

Got it, thanks

Jason
