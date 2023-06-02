Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C76720A65
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjFBUie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFBUid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 16:38:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E7E43;
        Fri,  2 Jun 2023 13:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6SEXgzAduki+3jKqWuJNwFILCnx9GELyxmGJN8cZ2b8CmFLnFURI1csyV01KBt+cOSjOd84Sh89FcXw56Asi3KHJw/R7f159Yzm9DlXfg7MMS1l03yceUdexue0R361P/TT9BAmLSDPlz1ZfGhkNN2effW3jiRRgnwDsTwrh6JFG6acyliC0QHzlRVeC+6ZjyR/KFc/eglUU3Xbn5IIcAF3U8ZSa2/rSc3r3AxgmnmYtzWbgNSqPphLqQMaQmHsgX1fNexsd+sLZPMSgT3WKDRvfnxkFKA1rHwA4Y3zt0phB9vpq46oV3fjzhAK88LbQfnUc+AiK84TVJK2kT74vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfS+amfvbbtv/GkOixS8iB+N/oETZdF4OlJ7YIdYTAE=;
 b=TJ9xdb37/UWw73iaWJYjkuNAdxVF+/VBHvDCrXIbnLXdj8cYE3Rhs852GlqqtgtW7wWjilbFDob3q9IryLNQkpJfEIZQVKfolwqgrGK9l4bXIYIJb3pwQGV0nhhUku8HmEnAgxxtBQVgfdsXzhYH9rwNblrVSFnd/vN2wBSSobEkxG8N5fiI31ZbOl8ImXMf9F/PvHFrIaumujETuXEnKnutKmlxgI3fYwf1RzPCa1dF8Y/Jd2WqPwmzjqFRJggZRJz/ggzRs/C5+ZWVpHExzoLt40LaNjAjiWrsxajX9/uVZ2K3GfWqatI5gT21OCzUP6eso+bRh6tgGcthJqadhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfS+amfvbbtv/GkOixS8iB+N/oETZdF4OlJ7YIdYTAE=;
 b=fBug8HOebQavJ1KePa3LO9EczVfLeAFr9WsuYdlWGEqq4dIjERshQ1Z/FSWo5hvPiWU+b1qptBCIWfDPfwHdU21AgrhYXyH9i4Ow4G4HkNFYuo68ksl47Pou0xqwZqHjdimoL7bh954Kj2LVz0QaO3z5hwvn2gqDLz4givEkZFKjnemoNo2sievl9Dxp6z3V0ltM6O0KW6Y5wxlB25jYzKm/cJSQrh85lMfOixlmSl8YUtw8woOq8KZEgdrxGb9ULPy6b9SUGxdXqxlDq/1sxVIHnjNQk+mvfwRD6BG3s2FDOrDYYm0dRafbw3k+JUh9txrTzM9thpjkMD32Orx02Q==
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 20:38:30 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::e4) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 20:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 20:38:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 13:38:23 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 13:38:22 -0700
Message-ID: <6f845148-e180-822d-a54f-e2bb844d54f8@nvidia.com>
Date:   Fri, 2 Jun 2023 13:38:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com>
 <ead7d0db-6104-1d62-b3d0-f9ebb767af4d@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ead7d0db-6104-1d62-b3d0-f9ebb767af4d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b8d0f0-40f5-4dd3-80f2-08db63a9537b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/9ffEllIPuZ1idk5ZqVS4IJKjaryHxWqu5MLTXATsg7NQHZ9+3U5XC6qc5+xe4IICewp1nFWm8HbRdWzdsRnxTidNZKQmg4UzE64Yn6rQGOy1rx6ciVjrYe2BMLQ6XN9SnInNfC6heiL6pbdeEEQesbTRuQuFIEunNENCfore8fXgKakzKLKRC2SpiAKIMomm1Nsvcr5n2NJu/in4upnwm3cIbr02IIJrXySBYbTdBWy6Rd4jWQ+TRtoaGcJT9nDmzRXqOcPvF+AtDZDAGHP9hfDJEhDk/dxL7KB1K3imY7LRe1O4M/x4Ab1LkSgRURNZPN7eUpmaRKSXuayfW6aGrQkTj+XSUf/9hAUfXWmQppVt5ArRKfU2T4o/9elrIPPPHc5R2Qo4dNLowc3Nl8tVEBY2rdx2luCKeYs5OYDHc0DBu4mGbqRYFAhf1dQd7EqjPpyzWH9k3THhSGmQiypP15jn2FTcpqFslpFKUdkdR3ySH/gHjryzc+3yJ7xbxMRoGF4AI0AtU/LkG83GfsD1LW0ksQBz9Dl5JImwD1ocZbkx1d07egdDAPXBxa6EwWM0RviZ1lb+ied6WObaCf79XIpV/T6lPtKMDqEG7ER+YGrjpJcCXq0eGgOvKdW7KJO2u/CAxVwvIJTK9XlL87aNjzcQp7M5tXX52CD/h+PKCuRWM3meHqDRMuTBLJxV7NeBymd2tc6nCanKOKdB/fkJjJrz8Ye/C86yANmmI7vPtmCzLjVtPmKvorNcKW3psiN5kr5wZ3vU6XF3fBe8cmTQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(47076005)(40480700001)(2616005)(53546011)(36756003)(186003)(16526019)(26005)(83380400001)(426003)(336012)(36860700001)(40460700003)(316002)(8936002)(7636003)(4326008)(356005)(82740400003)(70206006)(70586007)(82310400005)(31696002)(86362001)(2906002)(5660300002)(8676002)(31686004)(16576012)(41300700001)(54906003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:38:30.2407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b8d0f0-40f5-4dd3-80f2-08db63a9537b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 03:05, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
>> We cannot depend upon git to reliably retain the executable bit on shell
>> scripts, or so I was told several years ago while working on this same
>> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
>> lately failing to run, due to lacking execute permissions.
>>
>> A nice clean way to fix this would have been to use TEST_PROGS instead
>> of TEST_FILES for the .sh scripts here. That tells the selftest
>> framework to run these (and emit a warning if the files are not
>> executable, but still run them anyway).

Actually, for the record (and I'll update this in v2), the above is
inaccurate, because run_vmtests.sh aspires to be the only TEST_PROGS
item here. And I see that the framework does already work if-and-only-if
invoked via Make, as in "make run_tests".

However,

a) Many people naturally expect to run test scripts without
(unnecessarily!) involving Make, and

b) Based on some experience in building and using various test
frameworks over many years, I'd claim that it's better to use shell
scripts to collect and manage tests and test scripts, rather than
involving Make. Make is a limited, specialized language and is better at
handling builds and dependencies.

So the "make run_tests" is a convenience, but it should not be the only
way to launch a test run. So we still want to fix this up.

>>
>> Unfortunately, run_vmtests.sh has its own run_test() routine, which does
>> *not* do the right thing for shell scripts.
>>
>> Fix this by explicitly adding "bash" to each of the shell script
>> invocations. Leave fixing the overall approach to another day.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 4893eb60d96d..8f81432e4bac 100644
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
>>       if [ "$ARCH" == "$ARCH_ARM64" ]; then
>>           echo 6 > /proc/sys/vm/nr_hugepages
>>       fi
>> -    CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
>> +    CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
>>       if [ "$ARCH" == "$ARCH_ARM64" ]; then
>>           echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
>>       fi
>>   fi # VADDR64
>>   # vmalloc stability smoke test
>> -CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
>> +CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
>>   CATEGORY="mremap" run_test ./mremap_dontunmap
>> -CATEGORY="hmm" run_test ./test_hmm.sh smoke
>> +CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>>   # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>>   CATEGORY="madv_populate" run_test ./madv_populate
> 
> Sounds hacky, but if it gets the job done
> 

Yes. It's also hacky that we can't just invoke shell scripts like normal
programs. This limitation hurts my sense of "things should be more
perfect!". :)

> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks for the ack.

-- 
John Hubbard
NVIDIA

