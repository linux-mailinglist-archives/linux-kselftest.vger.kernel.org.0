Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A15981DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiHRLAG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRLAF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 07:00:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C83979EB
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 04:00:03 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Cz2qups20HgfVmCaVjhQYeb+IcTiFBfdStJPIFVfhMvnhP/350cMfPhk2n41e4GQoIpvrrAAxx8lC2iITxq+rQ9G4Oy0+kQuNUhuPwz5iqJqW7wEbAvf1cjCuQUuK4xeohn/o0oZu8yp8qUpUTsdVWOMNh2SsOFYKp0NqDh9vw/+5AzKcvSrgC8iVMbx9KaIZFGVl/Z//NlJ7KI36riNxLcO6TZ8pTPsAUfwygw92CLCeiMrS+n7pqBIeo8+w9CSSJYYYklRrKM+AGe1aeV7Pt8vSoSIpuFE2iPPbGGQ5A7CBqn9q3ZVcwep9aQgvV07EYeUSGcZHnR90ndC4gY7tw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIxgXbMuKoLs6dL1k4zdJXlIsAart9qYa1rqeYjO4kA=;
 b=dTDKWuNL38J7XVOTFPHJ9bnTwQVU3zTEhmGrHKXuaPWmoRWk8444H7PjE+RE6WTaLdJEmEJjvORqO5q5vFl67f+ZitT9HDB4X5BCg2ah7NiDyM4N4d7Dq1dv0EBL8/uS2QxfItRN+DF0ZfTygSAtKnltHdd6mI0dklZlzRuCSskHWG3KgtBxLejCaJJAs1zUQqmkbP1GOnMmyEJPW5Bfl89ONtf7QyK+c23HXoLtx0DY3k+rnCQbrLgYoIWJKl5zrD+aziSzEzIVP/XNU4077dYQgWCWnquqkvGcyq2S05F0hhwJCZGL58FYj1Kz/s4hb8nnkj5xK2f8FMPu5r/pnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIxgXbMuKoLs6dL1k4zdJXlIsAart9qYa1rqeYjO4kA=;
 b=FKJ4pWxPPoDvRmyhk/9Wju8+fWKL5ciwtDqB206KaOQBB+CXdgqXZUk6CqwmwhrKxcxrdEn0P4bnG9uWsCZiqhAttKoIykmwSCaypqKJDTE9j4vB+I+incHgskrvU84ReiLyp0XWbofztmMB3F5ICuUbDWyQEj8PUw4jcAgY/IA=
Received: from AM5PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::25)
 by AS8PR08MB6935.eurprd08.prod.outlook.com (2603:10a6:20b:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 11:00:00 +0000
Received: from AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::95) by AM5PR1001CA0012.outlook.office365.com
 (2603:10a6:206:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Thu, 18 Aug 2022 11:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT037.mail.protection.outlook.com (100.127.140.225) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 11:00:00 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 18 Aug 2022 11:00:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3748cf0c881e10ec
X-CR-MTA-TID: 64aa7808
Received: from 0162c089637a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C1908901-D972-456B-B562-626C24CCAD56.1;
        Thu, 18 Aug 2022 10:59:49 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0162c089637a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Aug 2022 10:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adtaKIuIqHebSEByITzh6XzPTtAY7goxXW1CRkt3f7Gif63IVlEz4bUFKJqVcbki6wgqnIdmrvpVnvdJbKR/o5/kYoHnoI+VH+q93Kp1Bq0OOrG2YXV/5fJgzMsvIAsz+sXujjbff0UYnxnuU+sglJMWlL8/DrN5pLqQMsOWydhDV6CorwvkAf0lWdw/FuKDZSbU5ucwk3L79BR/U9uM8EbClPQ+6+jrNLT0gYQED+KpIo/S3v7cvW8O+3A6/MX/NrcPyVwAIxg/lF3VvQHB8+KzAjWON6sBBOruXHo7yF3vIHGWDlbAX3r+Sd1JDHRLDCnR3ZpUzIspXBc05xi32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIxgXbMuKoLs6dL1k4zdJXlIsAart9qYa1rqeYjO4kA=;
 b=RskZoIDuUcRxxO2aXXq5ugGskSREKKm7WUYGqlDfLsjacVyL/Q3+GjT/3pi7gFRwkzIyUsorY10v5y67CAS8/d5S9AUqDocDyX3uXokIEjWJL9lHOhvA56E9A4tcLEDAFoj4gQA4f7XuQH3IPemD37LKmD8ZMS/QSochv6qLRyKH3z+Q+1GKmW1iw+tZuuCEbWrFog5WUqNEat7WsATVAf6NsakyIq9OnGkR93U10jeuEEKZrzr6Bpqrpnts0AIMkhHvNHz1/2L/14ahAG4Y1QPHv98oWq4+IUWC4mdfbTkluJVDQZRr7+YbadFPxkqbAbU/D5Uej6NW55Hab8Cqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIxgXbMuKoLs6dL1k4zdJXlIsAart9qYa1rqeYjO4kA=;
 b=FKJ4pWxPPoDvRmyhk/9Wju8+fWKL5ciwtDqB206KaOQBB+CXdgqXZUk6CqwmwhrKxcxrdEn0P4bnG9uWsCZiqhAttKoIykmwSCaypqKJDTE9j4vB+I+incHgskrvU84ReiLyp0XWbofztmMB3F5ICuUbDWyQEj8PUw4jcAgY/IA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DB8PR08MB5051.eurprd08.prod.outlook.com (2603:10a6:10:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 18 Aug
 2022 10:59:46 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8%4]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 10:59:46 +0000
Message-ID: <2533a13d-9f8d-9d7b-ff9d-0ce8fc781d89@arm.com>
Date:   Thu, 18 Aug 2022 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20220815133034.231718-1-broonie@kernel.org>
 <20220815133034.231718-4-broonie@kernel.org>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <20220815133034.231718-4-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::17) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bc099bc5-e124-48cd-f87a-08da8108cbe3
X-MS-TrafficTypeDiagnostic: DB8PR08MB5051:EE_|AM7EUR03FT037:EE_|AS8PR08MB6935:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aSu71fPCK3f/UeTVN1jH4OJwM4L3bWrczDmvE8O3CmZ1PPogX9UxcgPvjq/P+zMUjfM6F50+XRmsNFWU53rj92B76n8gklT5AiMfgVPQdcFW4FkuTncCaKMJyNU4dOK/9MPQKFLIXTJfJR8nAq9M5jh2QlvgZh24H5Y9qUOhusz/EUK+LWzyJq6Nc3ytEOgHQ7uZaqAf8IUgzjFUT1jKqFZp2vGJPa+p9XHwlcGpERROY0WOzC+rzK/8WTp20bz0fIecVqxTaCM7qdgRVCLqZQu630W6rJ18/KH9xJKVDigzXQcUH2SqCiqn0RQdGxPuUVHm7B2YzqayeAj9+GmBoUJg1VLMKIeMAVmlfu0Orr5ko56wS8HmmOMfAPAG6J8WCsdLH7PrkfTXpnxjDwK7X/ppqZZiNCUkQ1AROHFzVQpDpx8QkzR/TEQHyvTcWf4YzRyq20sxaTcCoP8OFkb/5ps7/LSLV4bR9PHkTQUAA06sWQTBTjDPnGoFrGRUm/rSkgKUD1CTG73rElzaN9FaZlUHE74KSX9rc+KLtoKvpI1Ky41w9AwWHEGowHHyJoYeFL7m5gd4Z0Jb8IUWXbBmjo3PN0EQPBG7/fzSVRKNFxESOVj/y+IrHYP/uuw1XI0RCfwjbZtOG8HLg5knp33d9Gpm2H0PyZemZDPoT0LqC6TROBSSCMVAcohRyXoYpqMzLwEU78jZcptRpDB8NqNn9QnTd0QWOKGNSFGTXDUpI10v2P6T5V7O8B8KhrsSS8/XLv0guWMxaW/mWU4yK4sUaQZXc+DGb8OARvT1qTKDJPg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(8936002)(5660300002)(110136005)(316002)(66556008)(41300700001)(2616005)(4326008)(86362001)(478600001)(66946007)(31696002)(6486002)(2906002)(53546011)(8676002)(83380400001)(6512007)(26005)(66476007)(38100700002)(44832011)(6506007)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5051
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: da4ebc0f-ab9e-42cf-fba0-08da8108c316
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp8/NzNjERaUsoFZ+iy18uYKdfiL1ORXtpPKexkf+wHd7xlpxFXcOvoT+5vIi8rMMoYVSI7F1I29aJ/meA9oNAGCtKKLVA40HBBtf5pJjcW5gEjQdiZabPsVkHVxVa1d7eXlwPMpwzb5yAXpp281QWQOmA+QVMIBbe/KgB85WONhZTlbMLzSDiFpkJUEqU/kFdu7MsCSl0Z2epDti7EQ3NzR28mtcDZ0KzbXCFSm0wMGbyDpRUCBEgJTBRKhSRXdcPbS3BDkksDRZNLhgIwqGSX6Pefg+L5mmM7RMzGedR9vjBIvMaiEpC/Cmv0PbbzCxDuo5T+C2gHySykJsdfPjJZhweUrq1P70oNsN2BOn+IqIMCcqixQfn8PmUCfAt+fjtnXWtbjajrjCgKHo0AiwdDBdwpMbp1ZFGSnOA5LMvuoxx4wSGjqN6WFP2+1wLCXtBT9bQ1/fSh1DRlLi8KEWYAZ+1w+sMxh4vx1e0/V0bNFXM8dro3BTtAQ4sFBRbb6jv6eWnZBptaMfVuhTQrp1nkNY3oqSd0qstTiNuHwnC6gYrtVOc1LCibeOp5hbaInBR0RN0MJCoNxMlJ5NoyeQfaM8LIHaZfOqodzaMzjSRxjyNN9VCd9Ih5nLZYaHn9LnWsR4HVjTT6ANMLKIA820LfwC4KsCEpsnpP6eXafHoWX1AlS8Zu1VPU7C6vUygp5QhOCCC5aZh3UHHuakoTD0sHI55Qp/fOTScI++VFaUld4ihipWGIQYwlXm9XQ08uqPKCFHM/HVcE1d38mJYIvdHNVDm3pb9p63v6aNj8//7uNZ06D4+K7f+AqTdid/HEH
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(53546011)(47076005)(82740400003)(316002)(8676002)(4326008)(83380400001)(478600001)(70586007)(31686004)(36756003)(70206006)(6486002)(40480700001)(86362001)(44832011)(26005)(356005)(81166007)(31696002)(82310400005)(40460700003)(110136005)(6506007)(8936002)(2906002)(5660300002)(6512007)(2616005)(336012)(41300700001)(36860700001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:00:00.6314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc099bc5-e124-48cd-f87a-08da8108cbe3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6935
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/22 14:30, Mark Brown wrote:
> SME introduces an additional EL0 register, TPIDR2_EL0, intended for use
> by userspace as part of the SME. Provide ptrace access to it through the
> existing NT_ARM_TLS regset used for TPIDR_EL0 by expanding it to two
> registers with TPIDR2_EL0 being the second one.
> 
> Existing programs that query the size of the register set will be able
> to observe the increased size of the register set. Programs that assume
> the register set is single register will see no change. On systems that
> do not support SME TPIDR2_EL0 will read as 0 and writes will be ignored,
> support for SME should be queried via hwcaps as normal.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/arm64/kernel/ptrace.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 21da83187a60..82feabba3911 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -666,10 +666,18 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
>   static int tls_get(struct task_struct *target, const struct user_regset *regset,
>   		   struct membuf to)
>   {
> +	int ret;
> +
>   	if (target == current)
>   		tls_preserve_current_state();
>   
> -	return membuf_store(&to, target->thread.uw.tp_value);
> +	ret = membuf_store(&to, target->thread.uw.tp_value);
> +	if (system_supports_tpidr2())
> +		ret = membuf_store(&to, target->thread.tpidr2_el0);
> +	else
> +		ret = membuf_zero(&to, sizeof(u64));
> +
> +	return ret;
>   }
>   
>   static int tls_set(struct task_struct *target, const struct user_regset *regset,
> @@ -677,13 +685,20 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
>   		   const void *kbuf, const void __user *ubuf)
>   {
>   	int ret;
> -	unsigned long tls = target->thread.uw.tp_value;
> +	unsigned long tls[2];
>   
> -	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
> +	tls[0] = target->thread.uw.tp_value;
> +	if (system_supports_sme())
> +		tls[1] = target->thread.tpidr2_el0;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, tls, 0, count);
>   	if (ret)
>   		return ret;
>   
> -	target->thread.uw.tp_value = tls;
> +	target->thread.uw.tp_value = tls[0];
> +	if (system_supports_sme())
> +		target->thread.tpidr2_el0 = tls[1];
> +
>   	return ret;
>   }
>   
> @@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
>   	},
>   	[REGSET_TLS] = {
>   		.core_note_type = NT_ARM_TLS,
> -		.n = 1,
> +		.n = 2,
>   		.size = sizeof(void *),
>   		.align = sizeof(void *),
>   		.regset_get = tls_get,

This looks good from GDB's perspective. I tried it with an unpatched GDB and it still works as it should.

TPIDR can be read correctly. I'll check TPIDR2 once it gets implemented.

Thanks,
Luis
