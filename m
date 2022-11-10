Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E466244E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKJOyi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJOyh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 09:54:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE1EE03;
        Thu, 10 Nov 2022 06:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyVy6IdjJc+nGzeb1tgCDoZBGvEfyoJwRY1Xf1+nM/P+sUfFh4mLB5cmN0SfV5ZFkurtqlj9YKGaI5kY7QSLbdykcTo9YCKuhFSbqpsrcrXW3Hng6A3tDEWqQ7+mQkydJvzDXSrwxWY3t+0eUBwnAy9AhTlBXY9ODmAEdZfZRoZ1PZj45/Iwsk5EGqLy+4sZC9DQMr2YiumlgzZHwAmLGsrHjYLOT2DdonRC6PNKZQcb6/oUGrDZipnf3pZKNGrnvDv3ePsiaM5EXzW3JVXGP6AJ4z95sEA98U9gqcG1ClKerviugRLqn2G7FUEmS4dXvzGZNmA6dXVmQfzjm0MFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj4TmsQPf9RJJqLRYEWv/RAKSL9UG9dfOP+BqU/daY8=;
 b=CcUxMZQWWY5iP9hAFQvWnjQVK752B6KZgT7eela6SzVewcrYFOFn2gKipO2QFLfRpHJrGnXWnuN7F0ZXqE5Kau1iX4qYNyftgSM6HM/ADA3LD0Q22nqMtCC8Z+YvxqRE73Vdi3gt6XXRCVYMND83lVECpeDztq0K/Nk2MLWP3sTaAfRvCnItI4046U4kgAw9EpeHl09UosXz5WIYvXYNGybj+zSjAowF/ORsp+2nJqZIb1lBPN5FkAcm0xPDJCkeOQk8BTtp45TY0FoBlLGnrh4PcoJui0g9nFR9lxpyFyxlTvfdlDXTf8eGBGGIdJ/+82HcZ2SLUoj5svZoZ6KTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj4TmsQPf9RJJqLRYEWv/RAKSL9UG9dfOP+BqU/daY8=;
 b=hULVvjM/S9dQwXK7+cl8zTZFjYKcCLdLnCSmWlauGEj20QW8YQfokN/SDjSXyGILyYWBbNozncs59l0V30hpvURcWVtThICbefkqbYJM6B7WzvfCYzT8U1EurcG6mLFs8FfUWvm87Wvs+ITGuTsUP4xSaO0Bd4ifzIFS1vH7sI1Rq2SAnmEmkkrYXms1d+GBf+Nqc3QzRNL58wqk7jzIXCSaslb8UTVSx/UPmCWTajq3cBkmTs1f++eeyWbYcm2fcLVBeU61QEOYi20erlfuiCPileb70OoJ0ylNzybxnt/U0R/wjMUN+6zRtMEnU4kXZFx1kPaAKsKkB6ok4ZXuZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 14:54:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 14:54:27 +0000
Date:   Thu, 10 Nov 2022 10:54:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y20QotPsxivvV53l@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8nmhnkl.fsf@meer.lwn.net>
X-ClientProxiedBy: BL0PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:207:17::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0d34b8-db76-49be-ed69-08dac32b770a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pE3/3KZklYlHHVDdd3V19BorOqhABkuXx7jB+oBVj02Fg/X5emFjeNMPzXsapdHc0Xe2e5MSRtc5yW20wVHbylV5K6gC1sv4obdgVdwIR8u8RMv3gbnnLgCxB0aGIy4sb2Sb8pAkxsWsZoths7m2JikQDx1AI4r8OFRE17RMsIa7hW1Won7gRr9Rne8LUU8bKHbl2be3haNnbMdy2CxiQPnAwu94lwCOCvClm+QA4GtnAMcCnw9NdFNenDjek72whk1WJB9BHM1km6BvxRlfISAf8F2lAcrOeS5RuB/mz/TP5PzRZQRQArGnd3hAz/y+K0BpVSbGs+SBrg1AxzV8i2qULZsDWyhMk6bCUuAVSg6oaxb0sycQ0G6fg1bflMr/UPnTlfUgpzf90AXDUwt9hlNyPqf3LE1cnJkk89ylAtF/Shg4oiGt5vYShgtyd2831I0/a8nPp9I1Mk2DhB2EL6gMfXiINHZVJ0SZNKP/++1YBv+Vgye38Us/JTCIf61d8E/ChcWF8reaFlVLHB4aR35/jMoCXJZSnXIW1vMej/KjgWSh5ffjZJXv5kIANFLLrSAbqQYu7Nl+/uddgnfgTm++sWuXhrmHEwOtaBlIyvvKDypT3OGyMo5QtWdUVeV9VB+44nRjcGtWluP4PxAIYc08bfsVV8lCI1mr+M223IvV85GG7aokI0SI4n1Y1tQKv3LHCjkqW7c7xxQyA8qF2IdwDB8bz4j8VkdZGn8NEXIafrl07sDFz/FWH11iAJ9YIN5ZkOqGRbXUd3BzwEVMiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(38100700002)(7406005)(86362001)(7416002)(478600001)(8936002)(6486002)(5660300002)(966005)(4326008)(66946007)(316002)(66556008)(66476007)(8676002)(41300700001)(54906003)(2616005)(186003)(2906002)(4744005)(6916009)(26005)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4jzD4wAodg6TTtvxAQmU+PjAfyRJT2XfJbBj4ItZVbtvZQKH6oIwkZ/n3/9?=
 =?us-ascii?Q?Ix6UBNcm0LEoElv+g58HV3PzYLTCW5wysssAvaP5RAic8+8r5C1uTIIw2PVZ?=
 =?us-ascii?Q?VdwWlXeNOIq0ELyTCw3x7wTl27L4x+5o+gp9kXKT2VFhzjbDK1TByTuYPnjJ?=
 =?us-ascii?Q?NoPeBUhVGOEKkyUA7ZNLK3z89F+HHcMa3Y0cXTZNd3uSS0K/IBcHmtEKp8it?=
 =?us-ascii?Q?hri1eFPLd3LBwcC9MIkZCGz8rgMLcKophm6piPunbM015N/M7qu25jI/Qe9K?=
 =?us-ascii?Q?sRXlAKadbVLICb1caQ2WbGE1sIepjJfty2i0ibdloUdvrMvHC+L78V5fLtaK?=
 =?us-ascii?Q?C/ZKgaE5GD85ndhcQ/5Z5l9ipceW4XqAyVLebYcg7wJ2EY708RXsBOZJiS0L?=
 =?us-ascii?Q?4+HeS2fDpKBWHMeXE3i0oil/KN7sxcf1aV6oqMDsH8/vT7V1/Mv5spl26gdT?=
 =?us-ascii?Q?en57t4QNFLmWKNXEXBYvqfF0gn8MbKV9J7FsZoWSTS8IQaPpkFOLDXc2Ar43?=
 =?us-ascii?Q?CdbMjPKFh3t+Balea1dsAadSdQQgzZ31hBVN6MWTDvYzf6DIM7uFnK+4KRgu?=
 =?us-ascii?Q?15MWLYzaaTjcmFtdnKrehVnwn1Ef9ShNGA3mgAbbrJYV7m8A8CkeVW6BfRtl?=
 =?us-ascii?Q?VChHiKr2SBVtVt+08005EgG/OTnonCQvB0TDIRdpqmp7loo79stHr+4eH6bc?=
 =?us-ascii?Q?AmRVmELaxydfzHQ8CSE9FtzmCU4MNhivtej0vQvfRVn39tTNm0QA/v3Sen4I?=
 =?us-ascii?Q?/0zDg0NKkddq5RyVUlYgEZM3eYDYN9XfsxQCKpkqP8pBA6+OxSacWvNW66Nv?=
 =?us-ascii?Q?6KNOmRKJa6chV7IWBdT3Azk55G/9TOIDZkRDAbYL6jtlcub/xOEGMNrUaYl9?=
 =?us-ascii?Q?TAuBOmCuvmk3YbrlEXKHUWWSCVd16z5tbhfFZUmpukma3CWOVWif1i6wFarX?=
 =?us-ascii?Q?9SLahTEeMtmOctQJsaDoo0s6i5ay+EKuXDZWhgBuQdVTeqljb8FjokVbpq0w?=
 =?us-ascii?Q?pKmMaPOb3kHvExDliuXBf36V4KwJ5p0dN8raCmxsuwKrKurwLofmF2OdaOIO?=
 =?us-ascii?Q?UkUGsw/KKkeu1m5ZeJhsqbWAJrmPMKkQeVnlQebaILGCbQfX33c4muc7Dxxi?=
 =?us-ascii?Q?x+1jnmMhf/rhHTGx5Z5Qx0i9Gy9LD/+mMmKksSzoisTZeQZtA1eMTLNOY8A/?=
 =?us-ascii?Q?QVMCPcl53TLUc+f3mQxDJgX9qKKlRX43XMNmG/4pjSore/HdBkYRnMQ5iEFw?=
 =?us-ascii?Q?lI6ciB9ZCaZi8A2EgzxaGOFC+ksFBdBvhpnvDGPIcF+B2tJX0PoHeLxib6x9?=
 =?us-ascii?Q?mhkTWryTEMTpn4SaCLz4Dc52F85UR36FhCFdHOFDDwbKyGWIyFWiAm1czDLT?=
 =?us-ascii?Q?XsBlKQ77bBt5pgyEFUswFIEJiOXBlIIErBcqDUH6ViXOsc2Cft2PL2kc066A?=
 =?us-ascii?Q?JJKy3EgFJJNiEBcU/d0Rxz7bJxG/6IvelwL+h1WRKVysrQU1Vx62ynVlqrdG?=
 =?us-ascii?Q?3W8ALbb2phCBb/2Xb9ce7DU0lEPwiYq+oadc6oPe5Zs1huSwRButuT7YN21t?=
 =?us-ascii?Q?yAIRWjk0sQSROqDvXxI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0d34b8-db76-49be-ed69-08dac32b770a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 14:54:27.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p1TIGZm7WeQ/SSF7jTLDZcBrTD40ggnBcj7IfuoZtSxWgKnXP4tQMIk9BUx6O8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 07:49:14AM -0700, Jonathan Corbet wrote:

> The *real* problem, methinks, is that the directives are added in patch 4
> of the series, but the documentation doesn't show up until later.  So
> the real fix would be to simply move this patch down.  Or just not worry
> about it, since it all works out in the end and nobody will be bisecting
> a docs build.

That is half the problem, the other is this:

https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com

Since even after the whole series the EXPORT_NS functions don't parse
properly. I'm going to put this patch before the doc patch and ignore
the bisection problem.

I'd like someone to say they are happy with the perl :)

Jason
