Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669DA339728
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhCLTIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:08:40 -0500
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:2017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234194AbhCLTIO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:08:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAP/hN4UBnQAOiZyk3GppN4v9zpDnbJulGbZo443yILYj4uc0dkZwLI5YP9z68+ptKfGm2rF2O2cnJN5EpHLLU3PW9oRN8vGeZbm8aVwCAiROnbbKuz32uJFh9wPXtrik/xbPN1613JvKui+mhKgENIlRHK7d/wnJp2nwKk0x3CSo5hGDn68hTI7h53cNh2bTl5vFNTqBzyMCNB1MxIJ+G1HUyxNMcXqCElNf1bfpD37aC4zmc7dY/4DD84DCSkSSFMG/LetPNY6pKDHkpDfASVGgTdhCl0OUYWRTAykRc0pM0PrfSSmFQ2RmR5sd1IUnyt++0AHZzBA+qgEYmdWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGICLbHx/cTCu3muIL+ZpUta6SkVL4siDMCGya/a2ao=;
 b=Y//IK7yA8EJOur+zroekvtivcqT8/bERDIUCJbEnCqq1j+/eYlcNofnAwCBqKlBtGZ34VcCX5yXCz9WeG1sNKpznEVAPaxA5Il8gw5c6HWVjQW9ALO3E9qJGhsJ926vBeZpwvjJl/kLNgJVEgBbpV/IAHp/qp//isuVXEfp1V+Bid3JsQzn6Tc7AzmjAbSPN0u46/N6wfqsHu9G30Qlff7mL10Ti/qpGwfWlntz0ZhNWduRVaZ0zNCl0TGuhJcfCAXh1c2oTaGr2ajIaU1zasjQ4+21o2z9rvjbSbwrG7SMXkTkquwL/KHrtfr1pi3ZztXjNSxs3dSphRGUMXnvMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGICLbHx/cTCu3muIL+ZpUta6SkVL4siDMCGya/a2ao=;
 b=M7DXfcs/BsH/epSgkouJwehb2EHHmrb9EOlV8ThRHcOG+FW7A+95VxPeSn7AfMh3/1GvEf3T9L3ipgZxhvwGVi2attGQXtqdeZ/GxUzBg08rCLPS2CyCN3J5E1OJl+yZPktkd5rTAU+Q/+eOnlwTikCUWvcbOGn/losUFuojkWg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 19:08:13 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7%7]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 19:08:12 +0000
Subject: RE: [PATCH v5 00/21] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <652bfb1c-91d4-13b1-b9be-be8a4147d304@amd.com>
Date:   Fri, 12 Mar 2021 13:08:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0065.namprd12.prod.outlook.com
 (2603:10b6:802:20::36) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 19:08:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ed39e6b-e91d-4f81-390f-08d8e58a2e76
X-MS-TrafficTypeDiagnostic: SA0PR12MB4527:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45279B88F9B1D2E73A686908956F9@SA0PR12MB4527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1khyRi/Ie2k11k8gJaLTGQbYYAK0OVHnkyop1/hK8Q/iiEXHC6kJFf9QKh0R06mlvwK6zuJAW8ghgR03i+/uvTOzvenneowJyQJvXSQhN5oRG2aJ/nL5f1Udo3AR55s+kpXn0nIAGyoHhnxXdW0yCfIL59VndH/mMxjFrr4cDBLHPzYhiGzcr/1PQCrnwELLAdZNJhu9PAX8Rm+RmHEXKq0/zqYcYT0akgCPFsUHI8fF5d6UCSNe+gxV3aDmpMTU+0Bfyxgpyh6tspt9vAAz3MnI+H73XSBSWTgZka/C51YwbJ2d7TKzzQ5R/SyQBmagU3QG1EOMuq38XSL8d2faggYUVYaaLq2y71L4awPPGjbHYiMUwwfmfqXVO1hgzFZgKb0RO77QQTn3+l5hswD7h4C8dDgHQ/FmKPqBXnIrp28h05uzvgcPMzeg6gAqUTk5dFLJABixWDgRunb1O09ArOAvwWb1wVJTnZgjI9GUnn004+jVZKEU++Z9/HSRBlvWjq3aED5UNj8y5t2dTRsNkFhmMZ10ADggFz8wSlrm94R8Yhf1wW1nBWASlc3II3cDPJtZIOcJJ4LMAX6DzzhsTXHYPzQpABxW3QtmZ1wZTXJY//JqbEiuTKq/OneSrfFG9uPkPWde8LptJJu8vLR2TVwPz1NO/ZRjItWCcx02VUHg6lxBYz7n5lmaHdaoDcuD2xaZqUpKuGjlqXAC+eSwAda0KbgNJwOQQlXbqMGM9ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(36756003)(2616005)(66946007)(8936002)(4326008)(478600001)(2906002)(966005)(66476007)(45080400002)(186003)(26005)(83380400001)(54906003)(66556008)(52116002)(6486002)(8676002)(31686004)(44832011)(53546011)(86362001)(31696002)(316002)(16526019)(956004)(5660300002)(110136005)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?JOH/sUEQZOp4MWdpPHxCbwdpYPaF0ia6iX4xlc/kPJkJRpwXJdGoHmR4?=
 =?Windows-1252?Q?fYhbuabeOqLhY65zjuX8GW5SbR5Dw8DUzzzKnESzO1VoJlP2yi+2OqU9?=
 =?Windows-1252?Q?Wu/EsuArnxJgYc9WzRsncliWqUgY8oB5IgMyK3iiOjOzoAB5MgG1o51b?=
 =?Windows-1252?Q?7jf6b46zFl5N03OyS5aCXOnUTec7WFQ3iqVzw7XnI4mueSKgSnaMXzly?=
 =?Windows-1252?Q?zLyr/zgGvLeX3U+8pulw98Pv3KPfnj/936ld1VF3/Vqn/Oe788dwSJfU?=
 =?Windows-1252?Q?rDFDc+JnnpUemv68IHxPRXID0I5pGRxxgq5wRBWF4Hd7AS5Tp/qo06LQ?=
 =?Windows-1252?Q?G9pTPruL5n3qQjy9ob8OFZgRUoOqEhkKkvS9o0Ye8MqWKrpRpEhoRdXS?=
 =?Windows-1252?Q?9n1O1GxVp2mwK3ApWCFXAEQbwvOlrbFk9QXNgVAJ3myLFGd3KuTHPKwo?=
 =?Windows-1252?Q?3+xid8U5chiRCkPxyM8y9l7CSKI7kjKuargcqu6/S4FYugQb0Fe+wYid?=
 =?Windows-1252?Q?EEOlEFAymKGpLorYDpUsDDVUGHDRxc8qCPw0REKYrswssMIT7p7aWIXv?=
 =?Windows-1252?Q?XLJJffOHGUNuQT+gxInC76T5OC1Pzj91HabyAplzuk3DQoYPa92Rb8UK?=
 =?Windows-1252?Q?Q2gwS4bJSrl3JeOPWmzuZb4ecQh96V38v+53q2v95/H660yJGd+CMnxi?=
 =?Windows-1252?Q?Bfw+YYtf+25rMUxr0eRZVLpeLR2+C34tn2McfPv8vKZXwi5I1Ku8Y6PK?=
 =?Windows-1252?Q?PjxpLLT4xaydq0K8YNpMozRA1O+W4lIdz9qpZXN0loqr16hNlo/gvYiZ?=
 =?Windows-1252?Q?gNd/thFOCWZvO+vMqHJorJI6n6jpiI0m7i+HDdWzw8prGr6IoBJp3FMR?=
 =?Windows-1252?Q?7ruX3SRCofIzrCPDYTyUZKQYGo4QG4Xk4hnHE/a8qDOCDjOfqrbivsCp?=
 =?Windows-1252?Q?n0UPr4hAgZ4qyzoZ2IkpDKEoJ5P1bpppKnjsxDiz29y5mP2BfQPkhcBm?=
 =?Windows-1252?Q?kduTPXxRis/v1TbxL8c1F+hoTVytIioaw43chZfsOb4bkpLf4q6EcMSP?=
 =?Windows-1252?Q?1XTbH0pVa7Tr06H9ynTtg4333QDfasR96HCfL+Y1p5s6Cqhq6LwUNFGG?=
 =?Windows-1252?Q?a1iezWN97wbGxLuGqiOSLLiWRsIpkrNqm84IRaYuAg6QosiPy0yE0DNn?=
 =?Windows-1252?Q?2Pd/dum1pP94BvtL9rlx4eFTQh4EitORJw0Myv3CdKaVTBTzriNUF18D?=
 =?Windows-1252?Q?EeipzC7Gig43Pz7I9oT2dC7Q1NkE5NAmQHBmifgRnrtqgA0FPKz1R8+/?=
 =?Windows-1252?Q?UDxyKklgWFiUFgvECCWL7xTGPez7waCnnh1kT6BiTjUVblJYCSepAbAz?=
 =?Windows-1252?Q?LTb8xuxzb//Oz4e7bfv2/6vAMoaKYOlugNLRKYZp90Eetm8WYyQnjb0e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed39e6b-e91d-4f81-390f-08d8e58a2e76
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:08:12.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8arg7gkBLIU//+bgN1hJNhG6JdKazacFFdk5NKbYp8TsQ1HQPf1cb4HwAY/5Nlr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Fenghua, Thanks for the patches.
Sanity tested them on AMD systems. Appears to work fine.
Few minor comments in few patches.
Tested-by: Babu Moger <babu.moger@amd.com>
Thanks
Babu

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Sunday, March 7, 2021 8:55 AM
> To: Shuah Khan <shuah@kernel.org>; Tony Luck <tony.luck@intel.com>;
> Reinette Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>
> Cc: linux-kselftest <linux-kselftest@vger.kernel.org>; linux-kernel <linux-
> kernel@vger.kernel.org>; Fenghua Yu <fenghua.yu@intel.com>
> Subject: [PATCH v5 00/21] Miscellaneous fixes for resctrl selftests
> 
> This patch set has several miscellaneous fixes to resctrl selftest tool that are
> easily visible to user. V1 had fixes to CAT test and CMT test but they were
> dropped in V2 because having them here made the patchset humongous. So,
> changes to CAT test and CMT test will be posted in another patchset.
> 
> Change Log:
> v5:
> - Address various comments from Shuah Khan:
>   1. Move a few fixing patches before cleaning patches.
>   2. Call kselftest APIs to log test results instead of printf().
>   3. Add .gitignore to ignore resctrl_tests.
>   4. Share show_cache_info() in CAT and CMT tests.
>   5. Define long_mask, cbm_mask, count_of_bits etc as static variables.
> 
> v4:
> - Address various comments from Shuah Khan:
>   1. Combine a few patches e.g. a couple of fixing typos patches into one
>      and a couple of unmounting patches into one etc.
>   2. Add config file.
>   3. Remove "Fixes" tags.
>   4. Change strcmp() to strncmp().
>   5. Move the global variable fixing patch to the patch 1 so that the
>      compilation issue is fixed first.
> 
> Please note:
> - I didn't move the patch of renaming CQM to CMT to the end of the series
>   because code and commit messages in a few other patches depend on the
>   new term of "CMT". If move the renaming patch to the end, the previous
>   patches use the old "CQM" term and code which will be changed soon at
>   the end of series and will cause more code and explanations.
> [v3:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> %2Flkml%2F2020%2F10%2F28%2F137&amp;data=04%7C01%7Cbabu.moger%4
> 0amd.com%7Cd188e85e961f4d246fb208d8e17901e7%7C3dd8961fe4884e608e
> 11a82d994e183d%7C0%7C0%7C637507257122356726%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C1000&amp;sdata=nHYN3OHv3eCZyC29T4cuiyD8SbGKoISOxsXFJHV0
> M54%3D&amp;reserved=0]
> 
> v3:
> Address various comments (commit messages, return value on test failure, print
> failure info on test failure etc) from Reinette and Tony.
> [v2:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> nel.org%2Flinux-
> kselftest%2Fcover.1589835155.git.sai.praneeth.prakhya%40intel.com%2F&amp
> ;data=04%7C01%7Cbabu.moger%40amd.com%7Cd188e85e961f4d246fb208d8e
> 17901e7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375072571
> 22356726%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gHzm10%2B76r
> NybPHxD2Uf6OmQINMyptbsH2mXU0QYxfw%3D&amp;reserved=0]
> 
> v2:
> 1. Dropped changes to CAT test and CMT test as they will be posted in a later
>    series.
> 2. Added several other fixes
> [v1:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> nel.org%2Flinux-
> kselftest%2Fcover.1583657204.git.sai.praneeth.prakhya%40intel.com%2F&amp
> ;data=04%7C01%7Cbabu.moger%40amd.com%7Cd188e85e961f4d246fb208d8e
> 17901e7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375072571
> 22356726%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vQYNiVeuWVK
> v6Eo8BlE%2BhBSScWbI2bznPmbnAm6esXM%3D&amp;reserved=0]
> 
> Fenghua Yu (19):
>   selftests/resctrl: Enable gcc checks to detect buffer overflows
>   selftests/resctrl: Fix compilation issues for global variables
>   selftests/resctrl: Fix compilation issues for other global variables
>   selftests/resctrl: Clean up resctrl features check
>   selftests/resctrl: Fix missing options "-n" and "-p"
>   selftests/resctrl: Rename CQM test as CMT test
>   selftests/resctrl: Call kselftest APIs to log test results
>   selftests/resctrl: Share show_cache_info() by CAT and CMT tests
>   selftests/resctrl: Add config dependencies
>   selftests/resctrl: Check for resctrl mount point only if resctrl FS is
>     supported
>   selftests/resctrl: Use resctrl/info for feature detection
>   selftests/resctrl: Fix MBA/MBM results reporting format
>   selftests/resctrl: Don't hard code value of "no_of_bits" variable
>   selftests/resctrl: Modularize resctrl test suite main() function
>   selftests/resctrl: Skip the test if requested resctrl feature is not
>     supported
>   selftests/resctrl: Fix unmount resctrl FS
>   selftests/resctrl: Fix incorrect parsing of iMC counters
>   selftests/resctrl: Fix checking for < 0 for unsigned values
>   selftests/resctrl: Create .gitignore to include resctrl_tests
> 
> Reinette Chatre (2):
>   selftests/resctrl: Ensure sibling CPU is not same as original CPU
>   selftests/resctrl: Fix a printed message
> 
>  tools/testing/selftests/resctrl/.gitignore    |   2 +
>  tools/testing/selftests/resctrl/Makefile      |   2 +-
>  tools/testing/selftests/resctrl/README        |   4 +-
>  tools/testing/selftests/resctrl/cache.c       |  52 +++++-
>  tools/testing/selftests/resctrl/cat_test.c    |  57 ++----
>  .../resctrl/{cqm_test.c => cmt_test.c}        |  75 +++-----
>  tools/testing/selftests/resctrl/config        |   2 +
>  tools/testing/selftests/resctrl/fill_buf.c    |   4 +-
>  tools/testing/selftests/resctrl/mba_test.c    |  43 ++---
>  tools/testing/selftests/resctrl/mbm_test.c    |  42 ++---
>  tools/testing/selftests/resctrl/resctrl.h     |  29 +++-
>  .../testing/selftests/resctrl/resctrl_tests.c | 163 ++++++++++++------
> tools/testing/selftests/resctrl/resctrl_val.c |  95 ++++++----
>  tools/testing/selftests/resctrl/resctrlfs.c   | 134 ++++++++------
>  14 files changed, 408 insertions(+), 296 deletions(-)  create mode 100644
> tools/testing/selftests/resctrl/.gitignore
>  rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (56%)  create
> mode 100644 tools/testing/selftests/resctrl/config
> 
> --
> 2.30.1

