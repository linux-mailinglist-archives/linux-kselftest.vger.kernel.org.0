Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE47209AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjFBTTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjFBTTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 15:19:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A341B9;
        Fri,  2 Jun 2023 12:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5ymgvHPqmN/RGVIetBCENn2BJkT9bv10rZes37kuJuHDddORiPhDzs2L7I+MatT7XJOAgHJUj8cFUVT3KSaAYo+bUaU1MSzHz352kWQLkOBqAqavTerUSmKau/wxAnmW0ucTsVzxQVuRT0xUHG/tPAPo3j9MOrbu0NS2gBg2rhk4xuEggG+S+S6iDxxnka+wCq8InV0JIkt+weota4BKYFANMdbTCFhutxQBm3wTQSaCc9zg383Womat3nGnt3ImYtZRcNx/RJqU0E5OfZNpUP2SD0fmy8ULpNDP5kvYzxZTHNQFDrl8EvHOppVro6P4aOtvL3WtULzO2JfJtOy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7kxIXXg25/8QuM1We9D7FNFKVEq0lSQHBCBbqbz9cc=;
 b=Mo8zqtPLxVyrazrghZO5ck3004T912F04MW+PPrQB/rTPqvbGpBp2kGVXX8oCc/4hFCDal+rioJ4i8ImVT0snLtNh+yzulgAvHseuOojJlgdwEya3nVKEHDXxzNlmkpAo64zM0P4gMRHgZHbMcJC4T9itNUSD+ctjIMLbvC6LZNqU7xjFdnLpnbF/322AvoRvTArkhHEsQvJMO7sTh7Ku3xgl7lyO2ivcfl7/KkqiLNDRNm7NytoOSMGRk5wVWBPXSj2HPOVn+lTLApfIjzb+K7AytPh2Py5Md/a2mH4UelGw2MS1V5Z/Tr30Ay89Rg8ehWAhneaTyaLYo3B4VHxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kxIXXg25/8QuM1We9D7FNFKVEq0lSQHBCBbqbz9cc=;
 b=k5NEPgrO5P37s9AAjFkScc0JSxqyfEYfI8iwW9ZDqdIkE3XZCmosmrKvalPaelkcB5zPd4ZgJ8P29qyvMhkIZUwIhBfcMfSOEG5UEIYwUtjowgNrVkpTmU+Jjb8yHpYiEJsdDNj0Wa5cJGzPSjJoHvopd4Vb2v6x+dvDV5Wg4t2YUskKKjQm+E2/X8E0bpGczH4+tVgLm7zW74jdNBAOL3n06+WuVEiN6cezm2YuIi16iYXvfxhWRUY8CgA75taCluxHUI0tcflx1d54Y4/A2Fw7+DcxVLFuewJygLqVKF64S1LXdpeEe/fnd8vW2OfqpqMtdPEBLswjI/1V9JbArg==
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 19:19:31 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e3) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 19:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 19:19:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 12:19:19 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 12:19:18 -0700
Message-ID: <e31f1411-1986-c25d-af74-05ad73a53c8d@nvidia.com>
Date:   Fri, 2 Jun 2023 12:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com> <ZHoL8vJPIUzP2RKN@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHoL8vJPIUzP2RKN@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbe2fc9-cfe8-4c34-8063-08db639e4ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcQpfpNTuWCwStmZg2yxuTiwFQ4uZySHqMut6Dpe3VDsPcdt0QgpWSWVEmr6SOO9ayEBWRVDmszPHJljOLwAMF0yJUJPVHAa7HKnMe/+DW4v5NL8XyF6o3oc1UgzE87BG7PAoU56u4Wnq/mSaZgraZwXQu/63utKjh1xqb2sSvpJ+FlcPYjMvFeFFIEWAvM7fBb88aMuVFGT5xHOMpH5RNoIb2htg/UnVB63uMZJulfmxhtP3D/mcXWbw/y+iZb3bEGAheS5ZAUe8vCVdRt/7LlhekepcQNxZQ+if6jGh2U0YrHLAO7JK510skCr1/vg7MGzZqrJUSCnFs9COdzqX6HtXJJFKt1u9degahNjgHDhkNRyB3VeuyU3AlY1VKb8f6BReb4/8Bx0vOMWHE8CaqJyR7QE0FptYkww9fGzVM04Vp4sDkokx+UYccw9agYVfFTPdrWNISzchsEyrxHVnLRSigGyVXBzaKbSu/KVjlFzRII+qfOgLnbuwYfFa7OIMrP8mluI/8lWooIdXej0dTAG4YGSl7OQl839iDoJJmsdAHz1Cw/8R1blU68Dx5j3TSlIotWfEc4WEvA7y8Cfq0kdGT+PbJKb/64VCMunzrKyxS+c1o1OrUyHGWflQ0S0bjIGE9azXgLoUu98o5dBJkzk7zGD/Q12ADtNRXOH6j+kwahiUKtTeHDhabnYHEdnkQukhppNVr5HAIcJPAsDRQtvuZioJDuDigJYRqsdoqlhTXfAi7/in5lwCOspY5nHHrUdfGXcbPrKvSxdGCe4NQzQ4icWT1Ub+qX0xWfueAkgbm2QImmqp3nJZGsO0K72
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(47076005)(41300700001)(83380400001)(186003)(16526019)(316002)(36860700001)(26005)(31696002)(82310400005)(86362001)(8936002)(2616005)(40460700003)(336012)(426003)(5660300002)(8676002)(2906002)(36756003)(82740400003)(7636003)(356005)(53546011)(966005)(54906003)(6916009)(4326008)(31686004)(16576012)(478600001)(70586007)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 19:19:31.1662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbe2fc9-cfe8-4c34-8063-08db639e4ac8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

On 6/2/23 08:34, Peter Xu wrote:
> On Thu, Jun 01, 2023 at 06:33:51PM -0700, John Hubbard wrote:
>> We cannot depend upon git to reliably retain the executable bit on shell
>> scripts, or so I was told several years ago while working on this same
>> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
>> lately failing to run, due to lacking execute permissions.
>>
>> A nice clean way to fix this would have been to use TEST_PROGS instead
>> of TEST_FILES for the .sh scripts here. That tells the selftest
>> framework to run these (and emit a warning if the files are not
>> executable, but still run them anyway).
>>
>> Unfortunately, run_vmtests.sh has its own run_test() routine, which does
>> *not* do the right thing for shell scripts.
>>
>> Fix this by explicitly adding "bash" to each of the shell script
>> invocations. Leave fixing the overall approach to another day.
> 
> Is it possible someone just doesn't have "bash" at all?  I used to only use

Well, maybe [1]. But that someone won't be running these tests as-is, because
the tests explicitly require bash, even before this patch.

> "sh" without bash installed I think, but that was not on Linux, so I'm not
> sure how much that applies..

sh invocations are for when you want to express that this script should
avoid using bash-specific things, in order to ensure portability to
other environments.

But here, the run_vmtests.sh file requires bash already, as per the
first line:

     #!/bin/bash

...which is ultimately why I decided to use bash, rather than sh here.

> 
> Maybe use $(SHELL)?  I saw a bunch of usage in the tree too.
> 

That's more of a Makefile construct that you are seeing, and only in a
few odd Makefiles. Recall that in Make, $(SHELL) has the same effect
that ${SHELL} has in bash/sh, by the way: dereferencing a variable.

And Make's "$(shell ...)" command is what is normally used to *run* a
shell command, in the kernel's build system.

Having said all that, I will take a quick look at what it would take
to shift over to the selftest framework's run_test() instead, in
order to avoid this ugly "fix".


[1] https://www.bleepingcomputer.com/news/linux/kali-linux-20204-switches-the-default-shell-from-bash-to-zsh/

thanks,
-- 
John Hubbard
NVIDIA

