Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C78640168
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 08:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiLBH6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 02:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiLBH54 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 02:57:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD6F1EEDD;
        Thu,  1 Dec 2022 23:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKCJ45atwmgNytSK9z5EHEupMBtvblHm4NE0BAhEBNgSF8FMmK7Wfbw9vDzztXkcCdLcYNGrtByYSY+n0+Q+5xRVADbQV8AdlYMpgwvNpSrRD09RdIh77RmE0ByPkl0o/YRAy0vQrKbmddqOLGMOHA6d/jeDGIlsl7eH/eOvcDRk7hHQ5oY2MxQ4iXCKeYbShCkIzoaeooNUqpvu+K8KF2Ie52ay4v1NyYO8bUa7wLCUesvXZgI7L95CFMZvSSyYSDt5e3L2VxTmuKtSptgnyzzUTbztn7VtIR0siz+2fQuyE7asSA9qBRZK2qlv4UOvKu/fj3D0g/CHZvK5MHJafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTod65XI2QTitKx4hdrCsBGQtTb8gbVpXQCCcUo1LZQ=;
 b=RTA7KhcOoRDTMJsGXXivob2u7iEVGFob18VardGHZIpeCGAZZBJy1hMcGa5IPrrsEJo9S64qjqVIEuhxnC4Qelopqf5o+kcARNJfbsUiiuyYEAmz1GnE40roYvjJC9NObnoMqEq3Kyx/UJBEYsFOKPFK/abWyOX7ZfK0UgxeMPT3GBhnN/rHAWA0d1Zs2EAFoldvZ2v0uMlSfr4nOu8jPWqzJ3/l3OeAQM/3LhPPN2mW+iOnf7Heg2Q8343PgHsoRn9w3X7xXKjC3wSlqHXD2BOxNBfWPsZ9G3Hp1oVhEc49sHuptQLT8IHIQrSFpNpMb5CDFZ/OOaIz9lqgxQP79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTod65XI2QTitKx4hdrCsBGQtTb8gbVpXQCCcUo1LZQ=;
 b=K17eu5oipM73CTrwUQ7ojYT+HURJuVZlD5FvsqZklOcqletV5aLutXLtcnimT+brboxGAVtFSDgvaXWGD2GvQrO2aNqaDVRsv0/1Nhd+Euisp1h8n4Vx4UnhPNdmlx1D0DjGTGzTALhfK9/OUmyRLk3cpBNcioiVO+KfVSKDmAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 07:57:51 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 07:57:51 +0000
Date:   Fri, 2 Dec 2022 15:57:26 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 0/2] Add speedometer new test cases for
 amd-pstate-ut
Message-ID: <Y4mv5tP9OQ+2Tnw4@amd.com>
References: <20221107011127.1818705-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107011127.1818705-1-li.meng@amd.com>
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d2d28c-575d-40d9-395d-08dad43ae94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zT7efHkNGAgc5dMdl7C6sy7D/UO4QgyvzYx7ykYNOvwXQQkXJPjCOzQCgHubcrbc14cKLWV92NS2t2nn+VUKtAmllgunFvFKSEYf7rmMKFwBeLqFCha1lv49rgdBh8KWPRzQHD0jluvmuY7lwkgvxJ/vyQtJSbc6B8HoMlKh55INHZb2SXIKtftyQMjgySV7vr084emdKpBHjT+N1xl6fOEEN9cbN6iecTHPfBktRjdJ2J3uw2k5k4hcyGa0SMs0tPz9UmUgrxwhm46RGfT83Nu95hvG7EEzdZIifkLk1k73XXmf0VIRJBDGTORxcfMcIR6pX55whBKjQ+W/aVu7wwuEC5MGxPggozmK0bkK0d0DRP6U+cMp2Hq8WbG5itWkoUHN3711nPvsvCao/FWQM08qW59R8TxihFAEWuz9tkqgonRZpwNJk+uUSCaNnt8DihSj7BUCV7GKwduLSlhFfKXENwNfwVy6GB+witnW5PwylCjYcMJHBf2AJOilZjHAcFKAGFCkl2dM3r++ALuROnutAFmVE5LlthuABSBZE6o8igOdYJAXscxz54MM506JRGR9DGvFj7mPw1cZF4zDQjc67DvPqBYnsaZO2e3UhcAopDq14D7NuOcZYLvN4HXw7w9vkZ6sotyg0rg3NvgsP/c0UDp5OIGITs8fw5UCHiQcIaBHFUgAKthOT5K6niJP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(2616005)(2906002)(54906003)(6486002)(316002)(6636002)(37006003)(36756003)(478600001)(86362001)(6666004)(83380400001)(38100700002)(6512007)(26005)(6506007)(186003)(66556008)(4744005)(6862004)(5660300002)(66476007)(8936002)(41300700001)(8676002)(66946007)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQTZZ8POitO9gUHc9Y7vKOWOBp1TNM2Cd69Qwi8AEBWECXdykaeiVUkZatnK?=
 =?us-ascii?Q?UQhq3St5ACPf9XAVmFJEukc35ksxoJPb/R+gIcnqfocKxhrkjwR8nj6TBMpz?=
 =?us-ascii?Q?LGYF6sdCvCN2CJQBG2oBCWu5wR4pknYYWuYK6lVsgqyAXiKiEJechuGlVIca?=
 =?us-ascii?Q?XKJ9Rct6GFgBLnUqYTbIgb1w/17zP7GNHQLFujQoT4CbSaN2L/eAi/OoWpg7?=
 =?us-ascii?Q?yP7+PMs2YWxE7CA85tTrKeU5OFT59H5cJvpHlu1yIj5Ah0LnCJlcyr1i5swJ?=
 =?us-ascii?Q?uQ0GHXreOncTDgFHstt8ZW4NlWPur+8glgsY1YhxX4begbySnvK2PbMwBt5q?=
 =?us-ascii?Q?YY6EPWODrPeWPjQGG5Zsl7hLvTIJOYKF2hSc713D/OZsltizyBrPc/T5C4Us?=
 =?us-ascii?Q?JeWEP2jpzS7BVOIqawAQeP01koU8mE5z7pe/Cmmu+hxLY4zUQPy2XkrUpTMd?=
 =?us-ascii?Q?dkIugCSH8a2sR1qcVGIXuHQIWzHdFlLLyOrigrrxOrLv5NoclLDh4b4QoKgM?=
 =?us-ascii?Q?0Pn8werq3xmd1AjX9N3on8r8i7beI8FsP8rbxKikhUXAOh+MOI7w4PUELvCx?=
 =?us-ascii?Q?/NMidVdD/lkQLp6PvDf4PIMDmyRi0B8BXn6fnIwKUFplv3TlDC6i+i3YLlb4?=
 =?us-ascii?Q?nM98sdtclXxO6Mj+ykpZHTYMACVIhK6ztbeN1lPaWWQ/SLHhPfxQX8+WlhZ9?=
 =?us-ascii?Q?iYP9O7RoaAOWaPBt2R7lOEPGjFkq6OTwcfmAVaaiAnuG5deKSXbrREXVXYuk?=
 =?us-ascii?Q?eId0ZcthUMWCVVtApjkP6glltn/pr/NqPHyVJmTWqLvGjV1b3dtlJxSPqm6E?=
 =?us-ascii?Q?Mul1n8sxzcJ5R4v6ZQzjpZHDEqoBDsiWYA++4jcLCrAhSYXnTctnAiwJESzq?=
 =?us-ascii?Q?BNPZXvtYu8vSnDqI+Wv0fg264PU5NP568ofp9IEgeYc0upJLbdsr/3ui4n9v?=
 =?us-ascii?Q?ZCipExNu4GButX+83d/KDkzn+xOAv6yEK1W1iYVPbbljU0VwGYbku5jwNV21?=
 =?us-ascii?Q?Drfq+LCX/hplD9gXUcBPNlG3k6v3ynW5mm3CRS61W7VrvOSUdrYDxQErmgXy?=
 =?us-ascii?Q?l+X6iwMcVq1yKdSCkIu+/2tuwumC3kvo5NH2BesdoW9EhBVTpUlJh0ZkmaJH?=
 =?us-ascii?Q?8PIjY0aqQBnNqRPbIaq6sHbuITizYPjZsUroJBkKESPnctwDIwFblsoxDwSD?=
 =?us-ascii?Q?pXxdvEVYh/ucp5v1Aj0/ktu01wypZ3VVbtnqtXViKRjpZmvx3tAxssesPcBA?=
 =?us-ascii?Q?77fp11tqJVT8o4BphnVduCtFjIjtxMrfL86FtwCJF2tY60+1QbFXdi/ZdZjJ?=
 =?us-ascii?Q?6RGxvHevck5s/pWGXAHaCI+Vb31XZIrmcdIL5YgL6OFrdH+YKdKPXmZYJNtw?=
 =?us-ascii?Q?BohrnAbuzpxo+xLisvoOn2kxCRMojXlGG2ENxF1F5nKYiWSrnUpJWGMf+jml?=
 =?us-ascii?Q?dKDnZpbbmoxiRCiUj90JUW1n1RNOyWytgie2eVxdgrNMzTTXF1PZp2KmkOOM?=
 =?us-ascii?Q?TuSGqnikotM7ifjy+J//hUI6cvIOQogMhwQD6mNyDI09PlkeKqWb0Z/FSSs3?=
 =?us-ascii?Q?M3hAUBXWwQXXc02HMO8D8UbVAxydrMvkgl5mSrr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2d28c-575d-40d9-395d-08dad43ae94d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:57:51.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP4Sl/wPfzp0JguozmPFJgd2KRE/dCbklzixaV4STKkn1fRO23JrWppnpMbqtXL0MSAVxHMj71ByG17o6ygO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 09:11:25AM +0800, Meng, Li (Jassmine) wrote:
> Hi all:
> 
> Update the patches base on the latest kselftest/next.
> 
> Add speedometer.sh trigger the speedometer testing and monitor the cpu
> information.
> 
> Modify rst document to introduce test steps and results etc.
> 

Jassmine, thanks for the patches. Let me verify the tests in my side and
get it back to you.

Thanks,
Ray
