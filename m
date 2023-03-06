Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498CA6ACF22
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjCFU1y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCFU1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:27:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF59146154;
        Mon,  6 Mar 2023 12:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJDVYeRM18eDqapMzaxA6OFQOpAcm/t0WjTyhYLObcpn9sb8IFm5iq0kUVUDjZKjFNz5Oc/csJSYEYl7J+X4IFOedAXYuxJRFpFG+WUHo+K8O5XmLoHg6UqJyyXnmIYvm1Bdxf8laNYHGKUgHCn4b1aEWwCbywSAZHZZkT7zmK31flwqkSBQQuIXCxsyyFNnRO35qYirFdOXjXgiwo7TJ911MwATdap7wLdDK7AhXwiutKHsPuKtz37skMHcQgcKJrgjVmBCYyrMWn3N5hXLhcpo7tb0I1cQkcFvvFPxnhSzfGffJ521Nh/pnd940RcTHGupzOBxS11ryX8GumyrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic+ak8KNb+20y4Ln1JbmQqc6Sv8sMy9bn2CiyGFKuXo=;
 b=jf1nTTGPoyfDtfrPBwrsbaf8/Id8GByLPblETToPD1dJt3WwaQIl5Oss+aZIYMEwDHQpwwR65GfbT56IfMhPSB6W7VUAivzKl0skzl3gpyJ3fwnpA2wcuCWqasFUJzV51tbd0JeOzFr78wenGB8lY9VwuuLa50dyP3xViWDbBuB330x0aCuuylfSJ5cB61IfhNqgcp1WHZ3PE1zLlbVgDbg+W5wEkjen13ktHDmn1l6FfXd8x7yN8MeAbe3we7Y1LxLpg2wh+z2Wq8iiJvmKjylhYnolrxbySEj7Bo2ULXDWIgZUgEl/411vVe/iOH5lDZJvZ2iJ+0ydPpP60oQnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic+ak8KNb+20y4Ln1JbmQqc6Sv8sMy9bn2CiyGFKuXo=;
 b=tn1fywlsq+aV1K6pvly0qE7hxe0Sr3qmSdMrvomvv6lMteeAsgW41PYvBkEW8cxIf7KI/Gfu8Mqnjwa6kT4y+TZUvTY8M4f8qqs5Q9TQIYANYhpfRw2iiznv/XYW3nK022FB0IWyDt8iZd8Xbhc6XCWCCrxv+NZfgAxVxk2pqrJZJFbE1WIIz4UfBTiOb7PTZcAETFfVoMb7XjLnmu12tsaVLRLz10IdvPG7j4JnW3OiCJXHOEk5/RQqeSGmEwkQkOJ6uxGoZBlUnpzLOzqw7ASw/dmJUFccwXoovcuihcR7McHVdHn3YKRzVw7QaSFodhv7XbSXQtvj9spUlRvqLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 20:27:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:27:49 +0000
Date:   Mon, 6 Mar 2023 16:27:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 05/14] iommufd: Make sw_msi_start a group global
Message-ID: <ZAZMw83wlGRsRhH6@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <5-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52768AC4BE475A521ED1CD1D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768AC4BE475A521ED1CD1D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0050.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 990dc872-0577-4016-320a-08db1e8140b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcJ5LMIs3h4sK/V3oregJm/9SvMn6S+plAHoe5GcRO6MBhgSVfqdyG54orQ5cv7IsEhvPrHg5Me1bZeY3YNZCtmXCVKEDMZChfKyINTDOK+1lgR9zOLXf7s9pp1TYO0R/oU0uE2Qzahnn21W1lIbuxb9MbYjufmTwIgqvwhR/SYinpSJoqnMQ8+6+CZdN9U6DKT32Qci/j9kBriqL/ILMcLs1UV+YwPt3wShYbeuYtwE7Q+ljBTR/eZoGrLAEXXikxwrtkfUodf4mQK5cj8v7Dx0Tmh57vt6dc6aV/IXZRC4qNxkbCNGmHFJ+KaE4Zi9f8iWuNd8OipRlpxzDbRIglMr/CU08fQLai8uw0Ld6+BsALliLOWzJ8mH/7KM9w4du9oEB653DlT7RGp13g2I/zBlYpJtJJrYkUGAAO4cEnU4PlzrzyvXAiOTWPXi3fp7602Ia0Ta+hEWci5A9bMnKQdGojrSeuwgdqGQDeRMf1wUGwxHLpCmc3G0N1bskFYMqnf10423SYZUpII7QL2yLVztdi0MQG5THUjRZ+A93mO+cS59+JVlEdbKYlJH/0xAHRG4gYVTT3CFLTrHqd/pqf34VNv6oFHQo7PqhxEqldGjMJG/4FUUHl2LSpSzL8xTMNhnrfGz7ml10bme8oZkzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(54906003)(36756003)(6486002)(316002)(86362001)(186003)(2906002)(4744005)(5660300002)(8936002)(8676002)(4326008)(66946007)(6916009)(41300700001)(66556008)(478600001)(6506007)(6512007)(26005)(66476007)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPFf1mb/ROD5Othiikf1N7alGWrfuePwKQhHFNmQfYa41eounQNGRIRufqNP?=
 =?us-ascii?Q?vdpOdYZ/XoSylEjKJpJ52EhBtKhxoM5yAqsTdOvm/IY4ITelxqLqZzhhx343?=
 =?us-ascii?Q?2QGDjehKqNtOdB6v0/kPA3CXsNoK/hGX0/+cmtWNtLMHcI0gUwFg/MN/P6DX?=
 =?us-ascii?Q?rEqvnxxYT+8xatwgarffB9L+RaB3JKhhFTQ0hScDzsqNPuMjCCLo01+laZnu?=
 =?us-ascii?Q?4LqaS7Vv0DBb4i2ew2+wS7mFMUtzNEF19DRdU2CbJFju6g5ufJ2UWI/3j8DK?=
 =?us-ascii?Q?cinvI1eu/SuLK2sVUKXCca5YSycLy8IQ3cJ5RImTAFX+kpeerxtOYO6Jfx9o?=
 =?us-ascii?Q?1yY9FyGiGCqWkXVArmgxIdKnHMWVoIC/nQMbdj/Uql8O94SwKz4LSSBuTJ2q?=
 =?us-ascii?Q?TUgInedAzabaae9DYIYLD7Ex9Tjn8eDFO0EP9J95aqrcJeZc8Qc+xlRoR35H?=
 =?us-ascii?Q?VgpT08jYMWb7aoMgkBAuWN0vQBsrzHOm/agIZlzIW4EzlWLsX+2N//UZ+TCU?=
 =?us-ascii?Q?iSGgkmS0uF2dmm8LwDyZBS4HKNB/qNn52IzbYDYcsjAbwIjcZvPbWQUC5Y49?=
 =?us-ascii?Q?AHysM6zbfArDxOkMqims/l+0OS+VIk17ITsdG8bWbmFtclie7wdt6lQkDUnu?=
 =?us-ascii?Q?aZn97bQmKCVU1Oykzdt8g0OFf+60BGIYb3KU3dwyYTd+BsvGv7cNN/HYGxwy?=
 =?us-ascii?Q?M1EQAQwR4+mzrOdVsfZI2w9HU6FvgBqZnWajuTEV++zjzMvkwqFNGUTRrVV5?=
 =?us-ascii?Q?K85VXO/pT58jpsCuXkkWTHa6LkLrpiGy6rMDhu6LaSPGmDY3R7w4+CCu7iOf?=
 =?us-ascii?Q?35H/vtnLWuGHVeDIXaeRvrPEqHkzE2pugMmueqCmuNDvAM3BZPpwwYp2x8q2?=
 =?us-ascii?Q?CmMaTcM89MJ1fA57lLuAZXUgeHese6bGE1yT05fpT7uM4VBisQZWVokwnNgY?=
 =?us-ascii?Q?9Dmvf5uskZ1tkOKzQOQlMsYmBKYGRzF4Uu2M8nhXCemlWKgQCnwKwZ73HcLK?=
 =?us-ascii?Q?7hIe74xwdeHZNuzx2lrdHOMcgNiilgqxnw5s5b/apRa4lnRdktZkCF3efq7T?=
 =?us-ascii?Q?pm/vvuNz4dnBNnKOmvaZKg3t6hAFbzUlgu8vSSf1xOU1qA2d/wEduHLjnLhp?=
 =?us-ascii?Q?pKfPzkkmG7cI/kfoplc57DgVrEMHBDMAFSzllS/QbBypjcc8io3OwY36uDmb?=
 =?us-ascii?Q?9OM7GqvUSK9GReZUEvPS3iJWOQS6fcT53X3XfsyXd3LyGJo4zq30rZ5Mrf38?=
 =?us-ascii?Q?KO3SVt+1ZeeNZ94/DiHhMvWVO/VUEyIEr+mk04qjPGZP5QlPNcDrxO3YVEVl?=
 =?us-ascii?Q?pyuGJsYM0MzGQYX6ReAlMFSWIz1Ddc6+KUUCYUZFr9PJJHwMDXq1ta07OPvO?=
 =?us-ascii?Q?V62vECpPFBp5uaRp/vO/t+DGFXW3mFEED56xTccr8opapYaQGPKuiFgetN8n?=
 =?us-ascii?Q?QDhfgzPHtxmWAqypAi0VnzVO8VWW2vupcVZiHgO89w6XLoaVQ30U1Y5GhKER?=
 =?us-ascii?Q?5/8e8qVqvADS3rU7m+QD9fyfKU+jMrEAq4r/NzbMUphj9MaBdpyQA8cQkeKK?=
 =?us-ascii?Q?fDAXih6VtWKBJY4/wRtSAXnlNWC6CdSDMLMSJq4F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990dc872-0577-4016-320a-08db1e8140b5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:27:49.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zf8PkuuCfow1/6dE5xRazAuh8wY8opCMqGQIBd9MN9Y+As7CwtfzQ3Y0bCWeN8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:09:46AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > 
> >  static int iommufd_device_setup_msi(struct iommufd_device *idev,
> > -				    struct iommufd_hw_pagetable *hwpt,
> > -				    phys_addr_t sw_msi_start)
> > +				    struct iommufd_hw_pagetable *hwpt)
> 
> Assuming ARM folks are OK with this change, better rename this function
> to be iommufd_group related.

OK

Jason
