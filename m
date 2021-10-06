Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AEB424868
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbhJFVCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 17:02:15 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:20768
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhJFVCO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 17:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaYJFKCDExQsKblQmNDSOxRy5DQfpBdWeObMgwHgc55DiHMd2tZXfeerZ6okWKr8MDyseiLeaqF+zl8gDI2qbr2l3O5ABgNKLr0fGh4O1hA+VC+CfI7IRwiCiAZH+duJ+AxOcRQAtPeIMiDAuNQT9876jj6/oa2bHnwpFe9Qo3Fbmsxwm0S3hQYU1c6ha5gvg7zbTrr7PEwLA7IaOjaXaxOeMFy/Ty5WR1BPGSHvxzBod4Kh8htig7Klx2vxZaQlMEaig5oW2J8L26ook98hn97uMAJN2gNzr9NKX8DM329gnA1FMwfZOQOjVvEfWNSEi9hV+4lj3OyHVboK/HStpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo2vuVuBt78XL2gCB+rMeHvP5D0GQJlAQXXE/8ToVX4=;
 b=Fjw2oJSmNantivXXuyQ4bTkHfNTvKsDAReCrKLA5XHTTvoLfKHxk/1XHQMmLBNtU7M5C8lxeD0IPmUqi6i+M4qqiMgkSj8ypjMosKS/XJ3hVvnGmYjrti7Xh8EskG9IoAQytgBoa8cYiwGxBnBgUdOMTIBe2q3SGHVfiAYSVtUdSQHVGSq3RnYABsliN/qbINL6/Kh0NbOOwCtVZRHiOwfKYb8vpz2+SH4wcXPzboEj3Osi27UXbus2fOQ4E8zb1PU8puKPCE39WWduUuqSPp3sXer5/zhphxcLWvJemtgTPbQHshCbuRvr5UruGvyDpht9M6SxIByy/pJCr/XRtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo2vuVuBt78XL2gCB+rMeHvP5D0GQJlAQXXE/8ToVX4=;
 b=g4fG4AwyJm3278Y5UB9ygoZ+bV5A9y85LM/NxWojvIdj3w6azSrXa7Aw1m1bOqjc87ZyxPt9N4w9SJDHt0nsce4bH5twtaMy1KVHA9fMdc34SiZV0WMfG+Y1oEEJmntpdJtazpxRfhchD1iMGsXbmu5RNeyTOgEhAkg39DMdqKk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3943.namprd12.prod.outlook.com (2603:10b6:610:2d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 21:00:19 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 21:00:19 +0000
Date:   Wed, 6 Oct 2021 15:59:54 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 04/16] KVM: selftests: add library for creating/interacting
 with SEV guests
Message-ID: <20211006205954.64ot72jkcdmhptsx@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006202805.12360-1-michael.roth@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006202805.12360-1-michael.roth@amd.com>
X-ClientProxiedBy: SA9PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:806:27::15) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0130.namprd13.prod.outlook.com (2603:10b6:806:27::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 21:00:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a249d36-486d-475a-5095-08d9890c4dd8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB394348397A84DB6BBEF3067395B09@CH2PR12MB3943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O63vRs/YdZISA9z0DAblLbtbE+zzjjYtj4hOanVKBTeoEVy7KFPN6Il7s4uxInqbiHSByOQ5Q1/XDQh4Z8PkCMGckR2vmAi8lxM8+uM9aSLs6qaez8IQZB7oUeC20CD2yFyOW6m/zdmCMTwhigKgllVODdfCmNbNa+zuVbMXXD7j7eHDmjr06FIfYRDoMHZ/u56rKDV8YUDnZnJLK9Wt7aRkUPnvVCQTykjhKz3LZyb/SJlMz3VtKCdGgbBkT4N36PeobjZpLKlE92QgNOWl5SRSsAynEGoGLtf5IhdVBZ7JRvBCMpIs078tRDOEGHh6s6z/owwiKWABy31nBOQf56Rg1cCbPYNi6eSKlTceYptxoGRnxCFK1p1Orz8/sv9jy49qm8usptcx1G3pNiA5W4z1unm0pgDeA3admv6AxK9hjXMPeZWtUESTicogsMtXoH8AS4+6XLH5WTzY+SJxWH5y2VEXfCj2Hqmiv2VL8YS5PzlPQg+gfXxFMnFaTOEMsrAWPf7duz+PE7GVwnMfEsynJXHDsv5WzVHisA9fUuqwy2CsxKuDyVaOlAvy3eWPjsCpKpZRgtEzeGpwhuuJ/Vx2C/wwBFL9DKncyP8xaAcpO8+ZXPSJOx1unZd16iH8C5Td9x7ET3oURJ0rPDCTAMwMyTt1GTRJSekdINLdPBX5Igxdf14bDhF50/ubZG7oXCNX+zjYk4p132S8qOrI8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(44832011)(66946007)(1076003)(5660300002)(66556008)(66476007)(6496006)(2906002)(54906003)(6486002)(36756003)(4744005)(6916009)(52116002)(316002)(7416002)(86362001)(8676002)(8936002)(4326008)(6666004)(2616005)(186003)(38100700002)(38350700002)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3arkl/XJW3cPGzgKj06/UZawD2w1ALyapLRmvOsBR2PW0SuKVxI5wPbnixcX?=
 =?us-ascii?Q?hirg48cUmmKO+0A6PwVyyiE1UAXBZhAxlYfrAIx/ut11TvK+qXEW+ipSNF6O?=
 =?us-ascii?Q?7v8iqQcgO08f7IfjA018KA0ucuqYz4FzCpbiNuftjjpq0QO9KgXb/08mW1YL?=
 =?us-ascii?Q?5HIAJ5+vlnNHvzHPReKKSuQjptTtWiTFbYNOKpzlmuChwaT1MFMCyMsHUYIf?=
 =?us-ascii?Q?BZ4v3AYK0ZTZ7NZxgUdkp/iHn8qa5zjixtA1A6iw+ggfoKaHzn6y0s+fIZxl?=
 =?us-ascii?Q?9YNw8mYJa/8GD6nnUfhR1sQLGMllRKvKc/6T8PMVNMDZ+IgAoHio/P6PSJHo?=
 =?us-ascii?Q?CBn6IVC7MDWOMygpy6z7XPXJha1uzcmkTk5kGJxgnclGCCI7ijAclaakGVcW?=
 =?us-ascii?Q?muPyYwe+1FGjykoTZ7sEYnULIqNPN24oVqp3ZhTvmxAvR3HRuWK68zOH8dHA?=
 =?us-ascii?Q?XrbXt0fgswKEU6gW+PbloKUR8Oy/jfK9tSTyWWhqlfo9YwXghi5B/dQmAKU/?=
 =?us-ascii?Q?84x4bXviWTPglgxwtA2vD2OXMsKaHSyCVniOSg11b6W+KMXlI4Dxk3cg9FOg?=
 =?us-ascii?Q?iY8QrOQAe3iF603esRraPfgVP3bdETEKA53rXBNvgWQpXj/lzti2jNOcolVR?=
 =?us-ascii?Q?nQVSyg8g77xuGGge4GxkMFYtwcfnuC8qhJgBNVZKr/MJqZiiCO8gv4x5AcMi?=
 =?us-ascii?Q?VTi9Q4kI+0rRikENQymohOnXN94iZ+FysQ7Bvxg3AHGf4ExioihoUzGDZ0bL?=
 =?us-ascii?Q?GKqD8GSFpDdHxrOzT8Un/vnSHyDJ1qXX3Rf7L1ZbXvMmB9UIEivYjupE/+9j?=
 =?us-ascii?Q?kgHvS8srxrq8B4ZoREA7uOp/+qblgYpdnR+Vxr8fE1NahNrSIm43qb+Uwxql?=
 =?us-ascii?Q?153/3DnH8gy43p1JUjsgCHx7Ifd39Zej6KeFv7NTM1qbmH3cLYTdivj89CWw?=
 =?us-ascii?Q?5GeGKuUZi+yZSdk+cs3IunDxIkxJA07I6yDBwKmedFupD4kvQzDfhA6dHcjA?=
 =?us-ascii?Q?yW6nzbq9y7VA+PJutbgLRNUbJQyQcCnSbwQ3kyIKBpF2sS3uMr26ILfpWKAK?=
 =?us-ascii?Q?KbDScSczX8Y4zk0rg/rtL6Mq3cTPPq31Ecir+EZGanB5tYFemPdQyI8f427e?=
 =?us-ascii?Q?PwLHQCqKuogOk4BJZE+06K//H5aT2tnnsH7zIU9ylo4LJVuMM7OUG6JsDtyO?=
 =?us-ascii?Q?tgT+Y5Nu2hFvNLhymx8Mb7IPrQvcDmQ5lbzLyhsVEPcuW4tY15QzCFCBiONr?=
 =?us-ascii?Q?kiuG4Tnop+A8WE5KlSLIA+qnG5RBHHneb4Fgop14LInEetsrXNijgBoHeS33?=
 =?us-ascii?Q?jAefCu9fx+81t11xWYkl8qyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a249d36-486d-475a-5095-08d9890c4dd8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 21:00:18.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QYv5E0OaZEDTBp5Og/oTWrM16L9976x4iBkyLunTQncdtHzxcgNfhur5GOpast/5GzP14pq5v6c/qSTT78A+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3943
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 06, 2021 at 03:28:05PM -0500, Michael Roth wrote:
> Add interfaces to allow tests to create/manage SEV guests. The
> additional state associated with these guests is encapsulated in a new
> struct sev_vm, which is a light wrapper around struct kvm_vm. These
> VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
> under the covers to configure and sync up with the core kvm_util
> library on what should/shouldn't be treated as encrypted memory.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>

Please ignore this patch, it is a dupe of 06/16. Some patches got caught in our
spam filter and I messed up the numbering when resending this. Hopefully now
all the patches are present.
