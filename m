Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CB752B7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGMURU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGMURT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:17:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771E1720;
        Thu, 13 Jul 2023 13:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLvIwQGf9NdjnI8RgZpsVQxfCnc3I0w1uP9yFhNk/8Hc4IWeiyWc2r0+zmqpyR154pPvXRQObrfzoCu9No9sCeg4vRAlr5Zb+AymtNl46Xt0MD1/WK6gflGS5XM18uJIvVhIK3ia7f9Yukd+PpcDeLu8AW2BU+P694eKtOhIAAp7fukZVb2l5SxATmdOiTfpkaHqU0bRPBGc44qgM5OqEpkvVFgX/Bgp3zhcsjnRvz7qdC9rv5Nq72I+j+JlAX7PQed8i1kGu4q1eI3JJvNA448C5ciRoKnBx+amgu7iLVVCK1WIL1F3HnMFjANIm6zd1PP/1+hgxKVhZmvNYd49Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59PHylF1dMHNG9xQFgM78n5wZZ5nxiAKTufou4MQTGo=;
 b=HRXRokChwNJ506dNA49BTmKmjnFkd5ycr99h4puaMKiFuYtvAtk2UnjXOTfmJLMakaNKi7Mv6Q7qAJV80EceN60Uz0dwm/7WAImTwjEfN8kIVWtYzywkvwnB1ZoVOZHrBndu5EeIvfQUTPULr57Nrn9MwDB+Ia3fGdCP3RGoXBpEsUzKZJKJpX5f7fOy7CBHb5IK0PFS7FEecfOiTmuisrlFRy7n8zzUYsT73kFz9LCBNPCZ1KN4KJkqJ72qve6S99SD+Hmh51Lzazy0lE5FNF3+tJ71ZjovcJa4upF8TUeXOKSW0j85njc/AyJFQq5pX4oO/IUe14hF3kXsfa0oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59PHylF1dMHNG9xQFgM78n5wZZ5nxiAKTufou4MQTGo=;
 b=kH0KGBmWSjMb9DdPpH1F/ajRSzkfGlEzKUeKZFTIaAljpKQJEwUxMhnltYgFwR5GQNtc+h/OjTluG2Aszte0Y8tMi41xiKM/hhG8SCzoCajh3uxGxODFZASWc3W6H/wrK71Ebg4omdKwNovf+FkY8cM2Nf/7oMeeV9RCHuKAA2g45X6kkkADZgJeB2dSR20s4LbU6mCjmfeFCKN2ls4dRInWfY3kv6A39T2qLo6Zj1NA6v+EMkN4WGCr0yOdBdUuUQqKGePrjsScmk1fNPfIRmxCXpKmuhqAQ8jIr/AHBHsMgLVEVV6/c15Og3GPeMnBCU/6My/y6F6mE3MFdFxpYQ==
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 20:17:16 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::57) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 20:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 20:17:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 13:17:04 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 13:16:58 -0700
Message-ID: <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
Date:   Thu, 13 Jul 2023 13:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 83644ebf-14db-437b-5545-08db83de26ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OO2XGqEgv9Yw605hLhoLxDllhi9OD7VDfsUc8EE2O/JbFkJivGqyfARzgBUKlmcmA7MpcZgVWKo8YeFR686FzsMfSriXKEjz88hkSXFl7aGTeJzJcX3Gb95tAPX5y4uXAc5CKb6+2WzkQBd4lECXNXFA2JiY0jLKsy7+CnetPj8MNmC1N96q0lLo8HGyfK2Bcr2JUuoqgS6Uumlz1PRU+zxaVGmDePp0Zfh8FgXqXoRzyMXwFf19S9CrPGH49oloxdGSKsjujBmfKtly8wml9gOps0bsxjerpWM7Mc0gzhAtDMmzx8WiaBccWAxiYlsqtYL34V8tLeUj2Qd5li/2HeHb0z4hGNSfWMCJCpQAPb4Ju6qAczHcyUN4X+l5sjaRVim7JbYXtp/Bik7nd12O3zVURqVxbRSLnJ8zjlqUzFX/OZ/JHqLqWqLCb5mhKSPrsDSPsszvIwfc4MAIUubHrt8QWGP7PY/3tu8ojHUYySw7FmXl8hsxyJ7PaGejR0j88S1UClyxicXMv6mew/OBfRL6vAiQUlIlLtixoenilah+Q1M+8sS+2uhpVaWqQiFBeOL7RCgU8t3k2FbC1lh9gP+UafGZoyw2RexOBSthD0L0E4qEZUlSNhjQ03+8/rSEuXrfOFBAwVYD52sx0h4do8j4snqO/YGWwuioZe5glZ0izBrdzfuAMvf+vQFr6MpEtIPV6j9KmqBGEv06sClatpwWJjlw7XqPPT7ygte0Jux5e3VyqM/kh0aPUwJd9q88jFwj7W2NDrrKG1AvBHr+zHzoIQTvlJP/SZlulNPaC5f+kzkAs5S5xRNWs01osL0dEBBaxnjMYIE+/H3V8T5ZnA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(966005)(40460700003)(6666004)(47076005)(36860700001)(186003)(16526019)(336012)(2616005)(36756003)(426003)(82310400005)(7636003)(31696002)(86362001)(356005)(82740400003)(26005)(53546011)(40480700001)(7416002)(70586007)(70206006)(4326008)(16576012)(54906003)(110136005)(41300700001)(5660300002)(31686004)(316002)(8676002)(8936002)(2906002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 20:17:15.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83644ebf-14db-437b-5545-08db83de26ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/13/23 13:02, Shuah Khan wrote:
> On 7/10/23 08:04, Mark Brown wrote:
...
>> -kernel_header_files:
>> -    @ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
>> -    if [ $$? -ne 0 ]; then                                                 \
>> -            RED='\033[1;31m';                                                  \
>> -            NOCOLOR='\033[0m';                                                 \
>> -            echo;                                                              \
>> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
>> -            echo "Please run this and try again:";                             \
>> -            echo;                                                              \
>> -            echo "    cd $(top_srcdir)";                                       \
>> -            echo "    make headers";                                           \
>> -            echo;                                                              \
>> -        exit 1; \
>> -    fi
>> -
>> -.PHONY: kernel_header_files
>> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>>   define RUN_TESTS
>>       BASE_DIR="$(selfdir)";            \
>>
>> ---
>> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
>> change-id: 20230710-kselftest-fix-arm64-c023160018d7
>>
>> Best regards,
> 
> Thank you. Will apply the patch for the next rc
> 
> thanks,
> -- Shuah

Hi Shuah,

Actually, I was hoping that my two fixes [1], [2] could be used, instead
of reverting the feature.


[1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/

[2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/


thanks,
-- 
John Hubbard
NVIDIA

