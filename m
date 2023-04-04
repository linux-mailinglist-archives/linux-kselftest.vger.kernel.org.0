Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79E6D62BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjDDN0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjDDN0I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 09:26:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43335B3
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 06:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwudKGpy56fobC1diRBKAI7+2jYvV+7ArwxFpmYrWB43qghCl5r8h/rYl1ZCmJR2H0tPl+fXN1UwOxn+wdDpAlUNvS9ULAhVuaqzZHh9ycKQBOPsP345gFEGRdvb8e1p0n00H+1faUFkYPsEd8QKiU7Q0KMJypaibGOCP1kbqB/cGcmLurVUDDzW4j8EmtAWFTqMay5I90NtJivX2vuw3SOH2SUgTtvzo1qBiy7YwPfY6hEoPm5Em3DjRglPQeRevvF8JW44gLv+mNqMY8AY7j9QxYdIVLRzT7/zt12prtBu4+mmcHBkVgbBH2GlAFL9rqC5C0/USLzsgdTLfkkytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpPSy7UlMx1QPfUQH0dVB6AK5kn9eUrf9BGuMZoetEw=;
 b=DTDFLbI8rHp3Q7XL3SQeVNr6wIRaBtAnye3Ek1OgqtaC8h5SzAeAX/1IgddQ+ct4LdM8StPWKRysvt+d4j0nnarDsb9zKoPHtC1KfNPWnzH1Zy276N32IQWIi2Lptc7qJjUUNX2AtQESe4tlqTyaYNKzupu5e2+GOR1SPch5sicu3zeplTijHPO0uVRZ9yCl6ZT6VnNcTUzGZTotQ3vKg5eIApNMWmAZbj3pmK8Ho7EaqbwOnsASf4DASqcbZgayaxZnowDNdPOx2RdQFU48ANXV2qV7KgajXf2B7IyboUA2Nnez1woV9ShJB3XLG99Ynqe1t0Xw4R20k8dNV/4x+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpPSy7UlMx1QPfUQH0dVB6AK5kn9eUrf9BGuMZoetEw=;
 b=Nc3Z6qmOGEdC4nwAXzO/FvjFl6XC3IMQWxoFLFhFCMB3myQMt2xGnt0Xa4npRsmGIcAvBlRjdmJ5JO8zPyF85MBq4gkbsOVLTG3bFwrW8eLaaZ6pEAGC8uaAoiA7hAxOQmiig2/oBHS4E9FJn99j/n0nc9jpYP18bhIaMMpL6Opn77LI3J9fS+IA+bpfJK44ibpwqXNwOvsKbBvVl1qXsFFgHrDaKLyV8MT/Rq6KnDgus1AOY4Hy7RH++wR36yPrF+H5aDunPY7JMjS45rA+YRnqr295WJbaz2zUi8bJrHq64zIu6OruyIQSv9/Gquzcbq4Mvcn2xgiyF91ziX8d1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 13:26:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:26:00 +0000
Date:   Tue, 4 Apr 2023 10:25:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/4] Fix three syzkaller splats in iommufd
Message-ID: <ZCwlZyRwGBleXeys@nvidia.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc7453-4e4c-4576-fb3c-08db351021e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzMRJB2bheMd+8cROqgiOSv+OmuXE6apJJPP6uIbtcXoo1kOYlQEhjVObla7zhWFqA/1RCBhb8FsrDZS437HGhwnjy6kHGf27bi87ybRly4xcAnmaqGUQpM5m0XYForj1bEsjtdpmUO3ub4Gl5Xb8xexmlF5VLswD7jXKX1KBNzvFl6APWHIjD3gqtAYpxJbR0uh/GFslb1pDIF5QM1BMYb90ASWBpJMbOAG9Ajzo5K9ltMuGdnbkBJhJhv+k1C+ofF5izNK/RL7flROpz3/YClA5ssrRPaCjVnuVuehgzHgNDL+J2iImwIZAOtEufAp8Tg38HdaBFkJnHJlQ0NNHBx4rwlNZaEoFBZy0MGdFB2hXBcFYUdCKsWuWHzIBgxoyfQ00uzG4p5+q6aXahnfzkyqAZP3syKx1t3za/2D/577J3kBdr/5UPkvOZrsAi123LFOqu2QaSOtRZjWP/CZ8rV+bjvS5IJmqWeSLi5O8Z8qepQ0LtS4L4Va7HW7dUMuhu+bcvRlBQd/wFaxS3MmTv3xi4nER5VQBlC9SofP/YPQ7TA3vOspOu4apDK5jj9Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(83380400001)(5660300002)(8676002)(66476007)(66556008)(66946007)(2906002)(38100700002)(54906003)(41300700001)(4744005)(316002)(2616005)(8936002)(4326008)(478600001)(86362001)(6512007)(6486002)(26005)(6506007)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RI7FYaSYv5oWQ0dkLjGqkgjVg1xeZfX1oukzFMSoxGl/OKiAVfvSDgYQJRfO?=
 =?us-ascii?Q?2XgPT16hG/mhk7pg0v2H6i/hXcyeH6Qd7KRC8fwsmHyAjee15eDzroTtJLCd?=
 =?us-ascii?Q?w6rZooSCjwPhkqXlSJpn+roGerdHE2ho0PywUOAZPTp3ARDgZCHt2QSxEkt1?=
 =?us-ascii?Q?mckkdRgvj63mJBho6bXtSgRjBBnSyVhBQ98BEBFqtPe9vyduWdzFOcnSb2ra?=
 =?us-ascii?Q?gNEUBT9+CLalyT84dPEnP4Y34ChgldJGrSsbo3qJX5dtYB053KFuvHUVYvZi?=
 =?us-ascii?Q?YhvUZ3QUGpkFfgUwvgnV/DcF8ahtlgeEaZ4FpBEljpBg87e/3K6TW0/Vkby7?=
 =?us-ascii?Q?+ngPlN454kIifScyex3s+vdPckqgedQTmZZk76FYN1VqR0OFxeJZs+ptR56o?=
 =?us-ascii?Q?b3nyQpY43gS1NKpgEJ6GiKHKK9CZiRc+EXcKKFgg2SRghskJPsQkavdM8dJe?=
 =?us-ascii?Q?E/eWWXLooIZI73LA8W3HHDLoEsnOrqe303QIxbXbUkTfXs7EAktKkGZ1Y1kR?=
 =?us-ascii?Q?njUQazAvT/6KS6oAMY2t+Zi78VDWhrzwq/987dI8sSUxYkAVOXiJK3siO7PK?=
 =?us-ascii?Q?N3XUOs0XQs6iX9lr32IFNfQD6v2arDRezpJZS1vV1Jk9c9stu1JdswkobK+m?=
 =?us-ascii?Q?u3CaPJzjtIJs5T0Vmg697Ki+kMoLtXcH9MFck7uWTqsM19sGdk4DsL4UZkrE?=
 =?us-ascii?Q?ZITFUt0s4Yvth976jvIyN4tR/U6ZUkX1483/k+8LEzBn4EQaHtRtP2JiOL86?=
 =?us-ascii?Q?a6qQ4/w93vQu0WMi2dYDpuIAvya8liuKr/dE71BHauV1zmMfmPkliJqhLLUq?=
 =?us-ascii?Q?TWX7vYZ7qLgPCOAi6Avk2Oqf59/rA0FC3WPgiqUYREGUZTA9jo1tkrY+WxXW?=
 =?us-ascii?Q?Pn/TfTBaCdCPiD+VIPBRl9RsnOZldRLvHBmKbWgfB9ePUlXHSxBzI5Rjregz?=
 =?us-ascii?Q?HJWJzKhwYx+Vit/ezXMQ4eyIxAGAd+GT/uq+v9thp9rUyZWgj2ON2KiOycZR?=
 =?us-ascii?Q?xlvpxA1dbxEVt8XLHhU4DHZCeouVwm541I4JnKdQpBXy01+jFMWLzt/Fa1qe?=
 =?us-ascii?Q?vH4NKwPMADr9b8n2ymNASTon5bd3bVYslgriwDcAxLMmwY1fgArVvk8l0rq1?=
 =?us-ascii?Q?/gJ2/OXREz4k10UYmkWzqnqDUKIIvN3LgZ+xcnD9VdAcXmmBI0FToMI4JXUV?=
 =?us-ascii?Q?8SbyEhYXE8ScIsEpWPkKHMK1WjYHGIqkR2rimW1X38L2OdPYYOHBiAXa9t+h?=
 =?us-ascii?Q?5HHlg16DSb44V5KTzHlUjNKanD4meEvt6oGSA8wW+1o6p2X8CM76/DVGHPKL?=
 =?us-ascii?Q?/8Qa2u5TvdCiE9E6/H3iFMKK7EkvrW3XGakE2BYpWkYCNdAflOyywZRX+09F?=
 =?us-ascii?Q?sO6iP8t8DpjrBQ3lqACpYtrPZdtYOd/WIlqjdME0iPkVF5VPtEhz59WbTJl2?=
 =?us-ascii?Q?+HdOKnScK3GkgN4afBtZIciMa0/KqJz5snfdFiP1uj71AezasXP3CVLAl020?=
 =?us-ascii?Q?xeuOPdpRe4A+tDcBPj2SN97yCk/FF3lzAP4sdUSJK9tGN768zD8NjLtLItng?=
 =?us-ascii?Q?XFcwOaecl7kDCfG+hOTZ5OqTBGEuVnIJ8QnhZmgg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc7453-4e4c-4576-fb3c-08db351021e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:26:00.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDKkZ5uhTPdNeBl8C+CeCRotrP/4TTr+v51Y3YNf2mXZlnROXHQFm/BR1jaQR+u4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
X-Spam-Status: No, score=3.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 31, 2023 at 12:32:23PM -0300, Jason Gunthorpe wrote:
> All related to the pages code, and the latter are reproducible with a
> simple test.
> 
> Jason Gunthorpe (4):
>   iommufd: Check for uptr overflow
>   iommufd: Fix unpinning of pages when an access is present
>   iommufd: Do not corrupt the pfn list when doing batch carry
>   iommufd/selftest: Cover domain unmap with huge pages and access
> 
>  drivers/iommu/iommufd/pages.c           | 16 ++++++++++--
>  tools/testing/selftests/iommu/iommufd.c | 34 +++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 2 deletions(-)

I picked these up to go to -rc

Jason
