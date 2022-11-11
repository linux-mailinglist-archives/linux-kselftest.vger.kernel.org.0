Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E765962580A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKKKT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiKKKTK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 05:19:10 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754D6BDC0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 02:18:18 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=MXwgRxHed8kXp886D3KUWJ1KX0JGtIdPyxyTrr5DzLPczGNH3QCaqwGjSPGxHSe57l7py3urEcdzqy64tp9r60DiyV1XkSke3Mwbr/mWAS8q/TAIXCGamP0G1ocLI8N8h3PlZVO+M9jVqKSIvizI0ycI6AECL4Ju/FbKekfgryVWg5a16e3P4+hNueQnct1/KjMpP+wKE87GDeDV4h30+jbgbISlPNJZ1mz8miFzUUZn0ybJ2XtLzfkeIOMQHW3bIwdzKa7D22Ne9MPeCgdcu84E6lqQ+hVzxKxxMKU3QTAlvQg5P0BRR50GuehkDhu9bCi2OB1zJBJRSPjXStRIuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cM6czr1e8SFgcou+sYUryjCSVeTjZskIyzqHkz98LE=;
 b=Tgco8yrqbyDRJsB2+aCSOtoR/0aA0wdIMKP3VJ7G3jyjCVRsTfKRpKccQkKlhl89EWWvC9FuAqc0YsY+/g7mijxn1d1yc2fQyfjQNiwKdR+wP2rKTwq9LVFu/Z/K6VNaHY7O/tRMYdwfqPkFodDmK3zvH7z91HO5rCR2tygjiyPWmxEhzo5mWntucaeb3p2nNH4C/BDWAgGmoitTKSUDDOBRsWLhT6fXlgMILLdgAfGUkGOa2LSwJ5QOY1JcINFEZz7/j7nir6zNRinVHOOvvpsSSazirm006IwqB7/q+vWRkeuWbIr+bBJvuuMad5i+X+SKawXchmLGbB4pv3XNSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cM6czr1e8SFgcou+sYUryjCSVeTjZskIyzqHkz98LE=;
 b=cTPgepCWVSOfgoEvLiIItqmh2mDF3Zyu0IC/mSLuffmHyEkwo+8bmubnwu7E1Z/5d+Xaf9dOy3QNUAYVKHHwFhE7PR+GDFqFvBjdfxqlW9vKUzvtOvy8DQ5A4TWXHnGrSbeh02Dk+CX+Mo9gA4JDqzeQZxn/E70OBRoYM3sDxPE=
Received: from AM6PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::34)
 by PAXPR08MB6448.eurprd08.prod.outlook.com (2603:10a6:102:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:18:13 +0000
Received: from AM7EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::60) by AM6PR10CA0057.outlook.office365.com
 (2603:10a6:209:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 10:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT034.mail.protection.outlook.com (100.127.140.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:18:13 +0000
Received: ("Tessian outbound 58faf9791229:v130"); Fri, 11 Nov 2022 10:18:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8b7149628fc5619c
X-CR-MTA-TID: 64aa7808
Received: from b2266b446584.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0207E35A-54C6-4688-826D-402ACEEA87CC.1;
        Fri, 11 Nov 2022 10:18:02 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b2266b446584.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Nov 2022 10:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ7ceghq5iGmZBZ/wprOpp0WZ2LRidBnvq7N2WgcSawPUokwV4xJAgCZ9wr6/H+LwIIDdjX9l0KAmANukqEZduocFLUNxxSNAm2VcCmKXcGM4lBIuww2p70Zgrn36dESh9KKurJ9080PnePj0LjTWEGBX5Yg0VYMpbDibJ0phy0bkOVTRTl250iVBK0LUe+08HEZbcbfXnkAuRwYXVn73yo9al2fWNwTOCIhTM9MeufJn6Ioa61ZvyhpNTuIp+hJ74KCybqJG8vOf6NyN918v70HqtpOB8v+Fr1Gq+FIT0YmLWvseWbea80QO00eKovhqGVjzcmUJ2UzokzwCiLdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cM6czr1e8SFgcou+sYUryjCSVeTjZskIyzqHkz98LE=;
 b=BPnMRQjwq2Axbo6maZJpTWXkYms2Wv9KG7UbVFctPWdmVpfFzej05AZiH78lJcS0zBlS2xVA7jpaR163OCcbLUwGk1SpDR+G/R2bMQ9rnS5ZfHFPpcUJDaIrHM7i4mclxZKdADGisnfbQAcD+MH/6txh2LCxmvSbVRxbPuZG5RFsKRRBmZT3ssZWF04OGB8H94j7n5mthM0bH8lCIAfBfV/S2z04aNRk7HzoyZfmsBboZYqHq2bGN5+XXOd5NJXAxQNn47phhF1tcrkG90GKm1BNrL7MUtEPt2CYHabMgIlbb2amD/STg/sJOzZSxLEPSaoQXQLxy2az8MVaxcqVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cM6czr1e8SFgcou+sYUryjCSVeTjZskIyzqHkz98LE=;
 b=cTPgepCWVSOfgoEvLiIItqmh2mDF3Zyu0IC/mSLuffmHyEkwo+8bmubnwu7E1Z/5d+Xaf9dOy3QNUAYVKHHwFhE7PR+GDFqFvBjdfxqlW9vKUzvtOvy8DQ5A4TWXHnGrSbeh02Dk+CX+Mo9gA4JDqzeQZxn/E70OBRoYM3sDxPE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DU0PR08MB8066.eurprd08.prod.outlook.com (2603:10a6:10:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:18:00 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 10:18:00 +0000
Message-ID: <ac30884b-3c48-4fb9-d649-aaf5863e4505@arm.com>
Date:   Fri, 11 Nov 2022 10:17:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 04/21] arm64/sme: Document SME 2 and SME 2.1 ABI
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20221101143336.254445-1-broonie@kernel.org>
 <20221101143336.254445-5-broonie@kernel.org>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <20221101143336.254445-5-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|DU0PR08MB8066:EE_|AM7EUR03FT034:EE_|PAXPR08MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00af57-18a8-41da-0c3e-08dac3ce0ad4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X9sN0KTl14Qa62WAa7gEr2ete5XphbOW06jOSeC/JKo0bwT5Ehyf4CK+gjIdj3of6n3TN7KNOYesUsSyfGOx+Nk/28en+BKNnLUxYLbqqBXzdEAoV/sQHF73NT85SJ0VwP58cZTWg7J6amlp7hRIKK3N7eLGxhheHN3vc1xpc/ctX8jVBXVPG9ZUSARpLfOV7nojDu7GcOXsbdTdqwBn/5/Ht7litBbqYr6E2N3DlDKhBqeTLpEgu24j08p4MTotwQtpqOdcf6GwuOGPRKR5lT6drSlxNLFFFemuZlXybfTEJPjAOiBZ6l7ckWEo/aheC7gf/LqCGxqiyk2ddjAClghpr6fQYE7mKGUyWK/MI+2UGcUvpSKs0WH49bq5gi6lLRUrQbSWbS4cpoZBAJPI7mNrAtywgeyYxx44iuJfkjbNeLmsZ3eCvz868rLBC88CVWHQUu6mShLjIp2Vg9W8h/AqN0A677TQPBkujbRw0Qns4dvkkw/l7tcPv72PuBruNHEuLZ6kVE6jAJvTCPfbahWv37rXiwqKCziVTDJaIAB2yPl6ZKu4ZUZouGF6ayTyrOEW9oRebxNoj9dfJJQdFvQwD/l8fMnsJC0XQSVnyiGpkq7/1/6BBODGhwsn4tdL6kiF5cr2+RiSvTENYDx/GlxVLBhQOaDuZ6cU+gNSNo/5ypenLWa3Xs5ACMZdP5LGIl/vGW1IxwASZPPC3Ma6P2YARTugsrHK1zHMmo1x0yQASP9VwALDuWWTyGRnaUylqZ2PEqjmTkDRkwll4TQZlyLU+EEbgFDYX0Gy1ST0Vqg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(4326008)(8676002)(6486002)(110136005)(54906003)(316002)(31686004)(66476007)(66946007)(66556008)(478600001)(6666004)(53546011)(6506007)(26005)(6512007)(31696002)(5660300002)(86362001)(2616005)(44832011)(186003)(83380400001)(2906002)(8936002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8066
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b7ab18c4-630a-4d4e-7d2c-08dac3ce026a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8bgG2gM/W1z3Sk6ymEO6/4vYLt3P6EWOkbUzyFPAHiW8yNP2zX68DGbWP3nYDoAsPEThyJlfMy78QWb6QehDgJHaQ5Wqy5VSAbOaCfD5rvGQaHrJ6q+xpcZRy+EA32ItYZhYWD80bHDqgXI8x7oOP4TE6lqzBSvNNsywM0bt/i5jfcVkNf7FkeM103apnEhO59poksUWJaW3m72xy53Ew9eQL/YRUUbzyG5m4b1FxKeuZSuqbzp9ivxSzzEsEhTyd9TG8QidzzgNXfHA7CB8ZRAUD0/t0F9406wtONhKG2n8Q+nBN1lzvkC04xEoySS55b5jii4GPyet1RL9gcld+006LZlWlwOd3TdIZa4I7CKPePFUIOIGawOswsYi9UJyoujff45xndIR17hj2o+jW58tRhAPKuUVbvpHfqOHMP1vnwcX4bYvpYqMHR5ars8uVfyCuZ0Fc/WBYeoQLtmnBwnX2AiPCmltG8tURFsOXflsR8gfdNLdfIZx9A91hSKdBz3Cihhor5zio+W7No7gz3vyZoJWeSQZV7x4FtKZ83hDUXaRdDe58PAKSmOC/ThPafXgOHFAfCIu2rwqURD/iREJaqR1bucUwwPf09FGhOzAagspoFkOc6fhwpftyvs26ZnHAuJuUMBb2+BotS2XPtIn37PODAaV4FjcqgEv3Pj0bcGS8iCFtATRg6JchdIrn3yPgO/fYLRdTHAsaORe+LK3wIIZcgbVGjSyIhgOCYzJ0bMGm9KGz0mpJUzy8+lOVuAafx1Db9y/GMdkqZbgpLGC7zaORSIKbGyOBvdfDVQJtuNtqTTRq7t0eFiJmI+
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(110136005)(316002)(53546011)(54906003)(8936002)(41300700001)(26005)(70586007)(6512007)(8676002)(70206006)(4326008)(6506007)(6666004)(478600001)(82310400005)(40480700001)(2906002)(44832011)(6486002)(5660300002)(36756003)(40460700003)(36860700001)(47076005)(356005)(81166007)(82740400003)(31686004)(336012)(86362001)(31696002)(186003)(2616005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:18:13.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00af57-18a8-41da-0c3e-08dac3ce0ad4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6448
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 14:33, Mark Brown wrote:
> As well as a number of simple features which only add new instructions and
> require corresponding hwcaps SME2 introduces a new register ZT0 for which
> we must define ABI. Fortunately this is a fixed size 512 bits and therefore
> much more straightforward than the base SME state, the only wrinkle is that
> it is only accessible when ZA is accessible.
> 
> While there is only a single register the architecture is written with a
> view to exensibility, including a number in the name, so follow this in the
> ABI.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   Documentation/arm64/sme.rst | 52 ++++++++++++++++++++++++++++++-------
>   1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
> index 16d2db4c2e2e..5f7eabee4853 100644
> --- a/Documentation/arm64/sme.rst
> +++ b/Documentation/arm64/sme.rst
> @@ -18,14 +18,19 @@ model features for SME is included in Appendix A.
>   1.  General
>   -----------
>   
> -* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA
> -  register state and TPIDR2_EL0 are tracked per thread.
> +* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA and (when
> +  present) ZT0 register state and TPIDR2_EL0 are tracked per thread.
>   
>   * The presence of SME is reported to userspace via HWCAP2_SME in the aux vector
>     AT_HWCAP2 entry.  Presence of this flag implies the presence of the SME
>     instructions and registers, and the Linux-specific system interfaces
>     described in this document.  SME is reported in /proc/cpuinfo as "sme".
>   
> +* The presence of SME2 is reported to userspace via HWCAP2_SME in the

I suppose HWCAP2_SME -> HWCAP2_SME2?

> +  aux vector AT_HWCAP2 entry.  Presence of this flag implies the presence of
> +  the SME2 instructions and ZT0, and the Linux-specific system interfaces
> +  described in this document.  SME2 is reported in /proc/cpuinfo as "sme2".
> +
>   * Support for the execution of SME instructions in userspace can also be
>     detected by reading the CPU ID register ID_AA64PFR1_EL1 using an MRS
>     instruction, and checking that the value of the SME field is nonzero. [3]
> @@ -44,6 +49,7 @@ model features for SME is included in Appendix A.
>   	HWCAP2_SME_B16F32
>   	HWCAP2_SME_F32F32
>   	HWCAP2_SME_FA64
> +        HWCAP2_SME2
>   
>     This list may be extended over time as the SME architecture evolves.
>   
> @@ -52,8 +58,8 @@ model features for SME is included in Appendix A.
>     cpu-feature-registers.txt for details.
>   
>   * Debuggers should restrict themselves to interacting with the target via the
> -  NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA regsets.  The recommended way
> -  of detecting support for these regsets is to connect to a target process
> +  NT_ARM_SVE, NT_ARM_SSVE, NT_ARM_ZA and NT_ARM_ZT regsets.  The recommended
> +  way of detecting support for these regsets is to connect to a target process
>     first and then attempt a
>   
>   	ptrace(PTRACE_GETREGSET, pid, NT_ARM_<regset>, &iov).
> @@ -89,13 +95,13 @@ be zeroed.
>   -------------------------
>   
>   * On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> -  ZA matrix are preserved.
> +  ZA matrix and ZT0 (if present) are preserved.
>   
>   * On syscall PSTATE.SM will be cleared and the SVE registers will be handled
>     as per the standard SVE ABI.
>   
> -* Neither the SVE registers nor ZA are used to pass arguments to or receive
> -  results from any syscall.
> +* None of the SVE registers, ZA or ZT0 are used to pass arguments to
> +  or receive results from any syscall.
>   
>   * On process creation (eg, clone()) the newly created process will have
>     PSTATE.SM cleared.
> @@ -134,6 +140,14 @@ be zeroed.
>     __reserved[] referencing this space.  za_context is then written in the
>     extra space.  Refer to [1] for further details about this mechanism.
>   
> +* If ZT is supported and PSTATE.ZA==1 then a signal frame record for ZT will
> +  be generated.

I noticed we refer to ZT0 as ZT sometimes. Should we use ZT0 throughout? Or maybe ZT, if it makes more sense?

Otherwise it can get a bit confusing.

> +
> +* The signal record for ZT has magic ZT_MAGIC (0x73d4e827) and consists of a
> +  standard signal frame header followed by a struct zt_context specifying
> +  the number of ZT registers supported by the system, then zt_contxt.nregs

zt_contxt -> zt_context

> +  blocks of 64 bytes of data per register.
> +
>   
>   5.  Signal return
>   -----------------
> @@ -151,6 +165,9 @@ When returning from a signal handler:
>     the signal frame does not match the current vector length, the signal return
>     attempt is treated as illegal, resulting in a forced SIGSEGV.
>   
> +* If ZT is not supported or PSTATE.ZA==0 then it is illegal to have a
> +  signal frame record for ZT, resulting in a forced SIGSEGV.
> +
>   
>   6.  prctl extensions
>   --------------------
> @@ -214,8 +231,8 @@ prctl(PR_SME_SET_VL, unsigned long arg)
>         vector length that will be applied at the next execve() by the calling
>         thread.
>   
> -    * Changing the vector length causes all of ZA, P0..P15, FFR and all bits of
> -      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
> +    * Changing the vector length causes all of ZA, ZT, P0..P15, FFR and all
> +      bits of Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
>         unspecified, including both streaming and non-streaming SVE state.
>         Calling PR_SME_SET_VL with vl equal to the thread's current vector
>         length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
> @@ -317,6 +334,15 @@ The regset data starts with struct user_za_header, containing:
>   
>   * The effect of writing a partial, incomplete payload is unspecified.
>   
> +* A new regset NT_ARM_ZT is defined for for access to ZT state via

typo, double for

> +  PTRACE_GETREGSET and PTRACE_SETREGSET.
> +
> +* The NT_ARM_ZT regset consists of a single 512 bit register.
> +
> +* When PSTATE.ZA==0 reads of NT_ARM_ZT will report all bits of ZT as 0.
> +
> +* Writes to NT_ARM_ZT will set PSTATE.ZA to 1.
> +
>   
>   8.  ELF coredump extensions
>   ---------------------------
> @@ -331,6 +357,11 @@ The regset data starts with struct user_za_header, containing:
>     been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
>     when the coredump was generated.
>   
> +* A NT_ARM_ZT note will be added to each coredump for each thread of the
> +  dumped process.  The contents will be equivalent to the data that would have
> +  been read if a PTRACE_GETREGSET of NT_ARM_ZT were executed for each thread
> +  when the coredump was generated.
> +
>   * The NT_ARM_TLS note will be extended to two registers, the second register
>     will contain TPIDR2_EL0 on systems that support SME and will be read as
>     zero with writes ignored otherwise.
> @@ -406,6 +437,9 @@ In A64 state, SME adds the following:
>     For best system performance it is strongly encouraged for software to enable
>     ZA only when it is actively being used.
>   
> +* A new ZT0 register is introduced when SME2 is present. This is a 512 bit
> +  register which is accessible PSTATE.ZA is set, as ZA itself is.

accessible WHEN?

> +
>   * Two new 1 bit fields in PSTATE which may be controlled via the SMSTART and
>     SMSTOP instructions or by access to the SVCR system register:
>   

