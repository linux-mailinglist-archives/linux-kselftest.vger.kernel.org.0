Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1570766D32
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjG1M1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjG1M1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:27:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D93A423B;
        Fri, 28 Jul 2023 05:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeULRmGB/LzXM63eNZkTwqcZYO2mrswlo2wCyU+/cYA5VCQI/EYJM2dt4EVkLR0MzmLEqz252htZ+kvDSh2dyV2oahclq6Qo2wWP0vTrbpudBMJ5zZQuZ2gZG885hY1hkOVyIyzvawJimmsqTXYDPVsqINYtwBBOYUTmgIC6BkN4JJUKGucnBwNJI1yyR6yNiEVw3YUCnfpHrGs0dwcs3alPOHjtZX8sUTkrdqWOhxbO5cr4AIRFZM0vQs/2AVqUTs7Ae86Ip+0g66FfAp/V2o4ZdZrneI0c7OXz3qBGys7B6L8RmxDjycOzfb6qEvBLMdu9JdMin/APXjoJEl+1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5b9p7DUTiyfh6Cc+BLrMyCwxW5YWJ2x/nIeK1D9muo=;
 b=ng7UC71aWAsC5fUEmvrvve0pFpBlfj2GrlFr+jKV85bng4IPDcOjO6AhmPqmfYAhGEbPtgMsCbdbSAhJfTFqksln063DM1DbqBR8I8Pm/gJNirQm3JFwsHRMJ/99p+y10NABktuxCORnevDw65JEI6QveuJ9g8gcrIcxzJqj5e08d/cDfx9HeSwQ7NPwGZGXtkuEu7dCQZMAjo68CcuI0O4oTagM20/naQVsjq/TmyNtQCn1ECx/bL43AO38rV9idE5a76If2BKY4tqPT0aaheFc44WvHf/6drJM25dcVAQRMCwyqtBWLAIbMFeqch0wGxusLK2NMJ/cVwc8Z+azEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5b9p7DUTiyfh6Cc+BLrMyCwxW5YWJ2x/nIeK1D9muo=;
 b=MtspXj8m8/UIhW++9jR6MjYo0PKj6gDrGIL2uVwpEw0oLyJIHHOF2yq1pvVTbarnmHtx03rRSnvXulUBOjbnqZzV2iLuj467eSTx5lxbnb2QgQ3UTBtUyXqUNVEE7cwwgT2iGe2DAiSDFdxxTcV5v9ZA9V4jIvKvuqd6s+sHzBUHDcH3WvzRuokWgTyzru4E+VxNfg7HFiKnKJbBeeaAjCq9cUYNe6vPtq/w7kGrfnjIqKaaqXQUsHtSxUI6EVG+r5I8SpYFcAznmV2RuX7yIUwvHfafGOcsjbZE74XMszG85GX9YX/6z9TGokF/4P+8dOhTguRlsIBFh3P3D/pUyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:27:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:27:04 +0000
Date:   Fri, 28 Jul 2023 09:27:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMO0Ffl5Z4qJf3VK@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com>
 <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d97193-d9fb-4a46-a81b-08db8f65f37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9e9RRlCshlXHmG1Dy7YgwT9k6bMxFSy7/Pn7hMsKkdbdLtjfs1YusB0SzIBggKPF1XiU6KdjksRS3q+gcYmFhdyRhGeDo3J0iGEPtNZOteDVgNN/nXvBGrsNZ0dbwneOBfDG67CCkjhV2pyZjA0+xOF29ssIrSFHFDmYtdtThXhNgKW1JYPavhSXCz3gJSYesFYsqvbTp1tn8n6U5PaA+lCZu9p9OEsCSEcmOe90vY3S9V5Q5sjxNcsgVTDbEOlVvKqY2Y7M03O06fwugeXASyTb8W8TF0O8bqfb5KWLAOy9YZW3P8Nd1CwhkQaBog95u85GjYJi+oRKLmOeOvfYU+dJWGaSQqdelBzPdSeoVc0km/UD1bRkQC6ZvDgxkxcWsbFKirRvxnMaKpzECpj/7K2h0qGhRkVZW0P5XCf6Wj/jpsT4nIpZyGU33fo9C3COCIoCV+mNjVBXL6ET31I+mkEjWorKe0XVyRW8U5IekaRwpvpZah4RI7UwG10QfTfMtsoy/giEu8TaGRmaTeUiNLXyBPeUVj0KuyAL2l5bDUtLKHU0MDxvs9zL+2FTHVz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(478600001)(37006003)(6512007)(6666004)(6486002)(6506007)(2616005)(66476007)(26005)(2906002)(6862004)(66556008)(8936002)(316002)(7416002)(8676002)(5660300002)(41300700001)(66946007)(6636002)(38100700002)(36756003)(86362001)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wy3ksSLkCkWu3/5mpmpmCl/udjx99oWtFYyMCkD47SeisaeDfnw5ZAujnDxu?=
 =?us-ascii?Q?U6DW3i6hI7yohhPsnEZehI9U29J89aTr7OvBSjOat/UGCCWupvSXtBo2Sj0n?=
 =?us-ascii?Q?+vBqnQPvJpyafaDVzt208QI/kSrrvRwImDx/3O9LWQZw2yrgyNerDa07sAD0?=
 =?us-ascii?Q?bkcbkIcdzxnN7TZkmKM+vGkZBk4RWQXoRJ2YcieC9zMVijn3fQONkr1LmfJc?=
 =?us-ascii?Q?8QNj22L5OmwJlPPE9Kk4bZHkDBWM+IEyHXu+BBRYRPJboG4p0+DkVKnIQnEv?=
 =?us-ascii?Q?UwdGXx5GLzBkjR+Wndp0dMauWjUWwaEAjCYHkSfBHobk5+Au0RvjMPzKfb31?=
 =?us-ascii?Q?31lZEPosbXk1YEci4eYCmjQWYdXWLaiNM2ACD5EcC/UEbAKMyTNBiBsNaRMD?=
 =?us-ascii?Q?wbJzFa7zgtQx3BYL2K3BFDyuLclDqci3ecj3F0QT2RlWoUU4S8vHSQxUI6DW?=
 =?us-ascii?Q?LoXs81OU3th+RQR67HwDeY2Tc+AF8DaO1lzE2Lvmtcisoq/vSJwstU2f/mbm?=
 =?us-ascii?Q?xzC6UWm4ddpNt+mFF6JkIYkXJn9mqII1PlRlj7y4r1bUta9kQuQLk7pPgz+M?=
 =?us-ascii?Q?8FEr3hKMGurldJpQLOwsk1+JyU9LNepsiZY7GRZi++VRyk4hb5hOktEsF6qW?=
 =?us-ascii?Q?YGpGoDEPSDtj3zhr72vlrO01O51MWOPdXLTXx1J2gAr5E0nEmA1VG0f2aK9S?=
 =?us-ascii?Q?uQIo71+RBFmAk4/95UQtJHw+ITmgS3o8XWVPxO3ZbcKZ4+L9sV2y6St4Et42?=
 =?us-ascii?Q?y6uGiJXyChlNcXOGZBUg9Hbnx02MwkLo0T/JusY3vLueHGDE8grZOKaniZ3X?=
 =?us-ascii?Q?DkQWuuZDdNwlrIA9BHAQ1uPIMY21CN383VkKBh0eVP7tfcb3gzLhfUb/zvK9?=
 =?us-ascii?Q?z7SQJVFrzep5gGs4rzOck8PG3vy9EMhKGhfD5hzkPK1Gk5x5hUDboObzXEjJ?=
 =?us-ascii?Q?hSWtUuV/E+6EL1UJuwI6M3rxyZvDswphVtdTLmfa9kkBwicPrK3/K4Sqb2X0?=
 =?us-ascii?Q?JkFHmt+ZdwhPs0XVaASh1qGfeOHSj4jfcMjM0ugI5p5ypF64FYACIJdXD1Vi?=
 =?us-ascii?Q?pkUJUlWRNqcApThyqNnji9FRxFFESVIzp3IfYz6GZ66S8KNMZctCHc63V7Y+?=
 =?us-ascii?Q?B9wNjZf4PWepYd9Byxx54IB93Ml6CfYLoHIzeB/NDxU418kJUWHJJTWdp5A8?=
 =?us-ascii?Q?e64L8ql0pMw728JRS5AvKpxpmns+0yJeJe6vsi73H6iFtI5xmvjUIZFFpHpY?=
 =?us-ascii?Q?eFbhaP9U7vQ5w7IQoBxvckU+tWNGBteUyBKOzf8Ovr+Pfn8g4R6HDxgaavHQ?=
 =?us-ascii?Q?LFgJSlOXT44utWA0cUT6zMQluhUw9HBEc97JPoB7xJ7SceH6q4OmmiTexUGG?=
 =?us-ascii?Q?suHTjrO4e4yHJRyALYtYAylf9Go3rh9aUi7I6TRSWCWA0pcp5k8//e9YIZoI?=
 =?us-ascii?Q?BThs1ckwEGbE3iQRtW3vKMm3pKgdPvrAFd5KOrcNVMPcXxIKY+BXmp+YBYsB?=
 =?us-ascii?Q?5OPKWqe45Hxts9AQfJfxaaI5knZ92fk9u54PMItC96d4VN2J6z6dNjboBpoD?=
 =?us-ascii?Q?r/sC9uoTeT3VSwaggaGkrmloBH76jm0yLFQxmbKU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d97193-d9fb-4a46-a81b-08db8f65f37e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:27:04.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF05ka04lTE/4j4JOwYZNTcBNYtj066PalT2zVZ5G444zjH2CGCQ7+0MOMQjOwkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 12:04:00PM -0700, Nicolin Chen wrote:
> On Thu, Jul 27, 2023 at 09:03:01AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:
> > 
> > > I just realized that either my v8 or your version calls unmap()
> > > first at the entire cur_ioas. So, there seems to be no point in
> > > doing that fallback re-add routine since the cur_ioas isn't the
> > > same, which I don't feel quite right...
> > 
> > The point is to restore the access back to how it should be on failure
> > so future use of the accesss still does the right thing.
> > 
> > We already have built into this a certain non-atomicity for mdevs,
> > they can see a pin failure during replace if they race an access
> > during this unmap window. This is similar to the real HW iommu's
> > without atomic replace.
> 
> I was concerned about, after the replace, mdev losing all the
> mappings due to the unmap() call, which means the fallback is
> not really a status quo. Do you mean that they could pin those
> lost mappings back?

At this point their shouldn't be mappings in any path with a chance of
success, as I said it is racy already. Not sure we need to fuss about
it futher.

Jason
