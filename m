Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314B722FBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjFETXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjFETXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:23:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD46A7;
        Mon,  5 Jun 2023 12:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3an4SVSFFVeY2tz9GHbOHj7QpEtKwVKblum4nmvW3S8MOKuIaHvgsoROxmjEhIGmLLqroi35lC9FCQXz94gfJdKpJiYIB8R3jusaRHMTyRfVN7Sh9qOyBdFOjPMG3g7r/rkxpi6Hfyorj0NJz98yBDDApBnKtHF0QZxpHCWrPfmSmN+2aiv1KVysZng0uPJdsrO6c5e7sx4TqESxy6IxtneZHBLyqlfinMJ49X47zmHHSm14Ul7TCm7L+Ckj7K5P78xM/al98omF/76r+ZplaIYjC0sEciDnxCTtrzqAqF0JtPgiBKbDE8XNyJsERyMCpNGxPVCarvbJYmA3Y8Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdVO2oaAnbLIxhy1/LPFA4+3rUipzUg+xGKns6U7YJ4=;
 b=mZJKzZMIbS76zgeTM/3q5SlrEH8Bgkd5gizYwaeAcMg7rg4ETHDqLA+CjLucLHiYVZiMx5OxxrCdg6ovmMtV8TcZZ8BGED3lwCOB9raR243Zuljebf1E4OoZkTYqjMpkB4d3Do9tBGNATaQMhqlPjo853XhHGbIB6Uk36HKgokROED2IRA0O7T9Hoxk9tP3CLel5wGmSO41la+1eWE7tmk7LFwJHCpPwlZRbJ2awF8vIH85mYvAPJm5u9CpTV+MXhL7lGuzL3o6crQ/QGdxY0l0LbnnP1hp8ECcM917IO7UKs0yUVC0+9Skx3U+PzmQg47rHCLAzHHA8HaM5bsSUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdVO2oaAnbLIxhy1/LPFA4+3rUipzUg+xGKns6U7YJ4=;
 b=TT4w9RPXe0xwhf9oMu7S0m1KX8WgwyFUdoTIf0SQvlYCZmwvmr8XSfcUxB8TrYTDXu0c97pGtX5XV3cjN1geAnQuRjjIQdRC7mHOEQFUWppAST3sA4d5ggVTG6XujsST5EL+PMZNWY3YksrMIRlpBkECfsTuEsNPfemnosGcskXlo/4WbKaGDvZxhoKN0+lp4mNcNOTgGpkRjV0wEnsr4JJ0gvndWCaphtnAHjAUtgMz3fCBz80EgwK+VCNhi/cnya6MQL3tW0SjMe0qEIbjyeLyMcFrHhQimJ9wdKZhkVjE6dciT1YXYGrlfPEMhMBt2XlHwAHE7SRDK4Q0XZDS1A==
Received: from BN0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:408:e4::29)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 5 Jun
 2023 19:23:47 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::4c) by BN0PR02CA0024.outlook.office365.com
 (2603:10b6:408:e4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 19:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 19:23:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 12:23:37 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 12:23:37 -0700
Message-ID: <f036d110-f43e-0787-fe77-86fa5d062b17@nvidia.com>
Date:   Mon, 5 Jun 2023 12:23:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 03/11] selftests/mm: fix "warning: expression which
 evaluates to zero..." in mlock2-tests.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-4-jhubbard@nvidia.com> <ZH4CvMFgu7IFFMwk@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZH4CvMFgu7IFFMwk@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a59ca0-2df3-4e6f-dcbf-08db65fa62bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2gz3Lf5ewge2SRWBQVMk9zRLoIs8Cbt61EvVRSbf3WCMyjAfomTga6VBKKp5j5Y0V42zJoiSFurLm6d2djekLRaofifWnTFu6nfZCrIijMHgJtKk1u3Pf13yyjEtU/BL73KoawjBj31MVZqzejff9dvTgfUdgSrMdeIfKYx16GRgi1/hmneBqxZOfWxSLOa7LmhWR333n+ETq4sWIYtUBVgO+zzRIrLjLIXsZ0IPfq9hn7Zst2imAMf1bhA6vp0v4hl3KQFCG7p4XvD8/+pr3OcqDrKZwq7vMfs9Kep9ZC/Xu4wvjCHG7HW7OhuO2oS6Gz9IPysbsjLuwGJl8QJFXa6oGQu2iaN/fidrETa9UoAALr4aQknXYGR6TEK5/x4iHTM/8F8niR+rM0ioRf7mPeTaRGM840I+oNwPwoqZFBx/GySGqJ+kup5Uia4ZcXGl+7BWJRAMD9MP66KIVlZEoh1l26eLuBxDNYY6cwLxVOnSwI83madBc3z4ZpduxSXZV5HwxNmTNxq7jOek2HVwWLeSoZzH2gagZu29sQrrxv218yy/8K4z9KnI3dhGnjmdU/kmYJnOkPh/b3JyZayl6UeBA+9ZtOThjesL1BSDitfudy8O99/5ouQmoMh7YwSmexDtxcA6fFCzk7pia1j+GGwDszfmjvtyBfqdfHwcnzCTqH6Q2p6sjda2ayUdvDW3hLoeyqJwpsNVo+vzoNCxD//B/EySbS4X44/tZXhlRYKyYij9+J/27w5FG8yfhIENeqkRKm/vbsc/0wwLNB4sQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(316002)(54906003)(82740400003)(356005)(7636003)(5660300002)(16576012)(478600001)(2906002)(31686004)(70586007)(6916009)(70206006)(4326008)(8936002)(8676002)(82310400005)(40460700003)(31696002)(86362001)(186003)(2616005)(36756003)(16526019)(26005)(36860700001)(336012)(53546011)(426003)(40480700001)(47076005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 19:23:47.3799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a59ca0-2df3-4e6f-dcbf-08db65fa62bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 08:43, Peter Xu wrote:
> On Fri, Jun 02, 2023 at 07:15:50PM -0700, John Hubbard wrote:
>> The stop variable is a char*, and the code was assigning a char value to
>> it. This was generating a warning when compiling with clang.
>>
>> However, as both David and Peter pointed out, stop is not even used
>> after the problematic assignment to a char type. So just delete that
>> line entirely.
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/mlock2-tests.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
>> index 11b2301f3aa3..80cddc0de206 100644
>> --- a/tools/testing/selftests/mm/mlock2-tests.c
>> +++ b/tools/testing/selftests/mm/mlock2-tests.c
>> @@ -50,7 +50,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>>   			printf("cannot parse /proc/self/maps\n");
>>   			goto out;
>>   		}
>> -		stop = '\0';
>>   
>>   		sscanf(line, "%lx", &start);
>>   		sscanf(end_addr, "%lx", &end);
> 
> I'd rather simply make it "*stop = '\0'", or as David suggested dropping
> stop completely when we're it (assumes that scanf() will always work with
> number ending with space ' ').

Actually it does not assume that. Rather, it follows the documented behavior
of strchr(3), which is:

     The strchr() and strrchr() functions return a pointer to the matched
     character or NULL if the character is not found. The terminating
     null byte is considered part of the string, so that if c is
     specified as '\0', these functions return a pointer to the
     terminator.

And we have this code now:

	stop = strchr(end_addr, ' ');
	if (!stop) {
		printf("cannot parse /proc/self/maps\n");
		goto out;
	}

So, either stop has a valid char* in it, or we goto out. There are no
fragile assumptions in there, as far as I can see anyway.

> 
> No strong opinion here, though.
> 

OK, I think it's kind of a flip of the coin whether to write this:

	stop = strchr(end_addr, ' ');
	if (!stop) {

or this:

	if (!strchr(end_addr, ' ')) {

So I'll just leave it as the first one, which (depending on the
day of the week) might read slightly clearer. :)


thanks,
-- 
John Hubbard
NVIDIA

