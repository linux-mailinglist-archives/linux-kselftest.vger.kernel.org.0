Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00862587D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 11:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKKKin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiKKKim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 05:38:42 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1512659F
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 02:38:38 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=c553lYnO/xE8/A0UtX4ANqKJlQeK+ztauRKZ1LMdjh57sTEe1n7ajyKZEGDxWHNjlXXWmRmIQAhc5tNkQ9U3oM563qcoWk2/mdeGwA/hukbfFwgfx7Y/E6JHo2TTTZavg4o3e1iChzqFxicn2O646a9Z8wmsobCfIJ7wPRawR2sJW2r/XoYCMvXB9XtCz6oD3Ku9vXfGO+XmlkoyhuID7cEYYomwCvv15agQJmZnqfDkA13EVSiB2Sor60osqrY19PWww4keIfEb6DiQwrGLa3BAeg2zSDXQmly96ROOztmvmYeZKlCzEy+UJxqxMnn/aChWVcy9kPgJ3WFIVj8z4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUac0vCTLBq5AgYyz0ESmQHJxSalYxhiQZqu3idpCMg=;
 b=AEPY3eeALK0WavDgMh2Fvec2X08f3Eq4kH80Yhj2boXYuFX1Zt/p/5+GtNXWzUswn3M1keZ8HCxp0rgkqX/TnRhO5S2SHUfqlwEy3IHDGJV1SWWyYxL0IelhUJtaSzMtL6p5XPyqyJD4WdFpLXc+Wbh78+M28I04TfdjB+hFc3hazgm2zQpgUK+4SBWu+j6rWsYipboGCvD4v3BFordIYWy5Kum4AddFLEDTPZdiTI8BdmOLsuxYM8MidRQ8LwBpfyLcq5TCeLlZwDdW4hDMMTpJrVhlfPRkPY9jvcf7gg/gXnpE1bm2h4uiLeuxSuW6rdb+zDh+x+7VaiWHICLQ8w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUac0vCTLBq5AgYyz0ESmQHJxSalYxhiQZqu3idpCMg=;
 b=Jwm5y20NsNGVV7V45IO2n4VcbgbHgIKpn7tz7ODgSNV+C+CvMT4atj2FKQ5ga0Tck7onFKnzIVXto4Ep+ImhVH672TsI6w7OYTp8I6ROaY0BKn7jQrsrniXUM1LU+GyrPfl2veIMDPYRBIbrPs9AwvhDrkFdaEIPtPqlJ1HTo7U=
Received: from AM5PR0601CA0066.eurprd06.prod.outlook.com (2603:10a6:206::31)
 by DU0PR08MB9654.eurprd08.prod.outlook.com (2603:10a6:10:448::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:38:31 +0000
Received: from AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::ab) by AM5PR0601CA0066.outlook.office365.com
 (2603:10a6:206::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 11 Nov 2022 10:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT003.mail.protection.outlook.com (100.127.140.227) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:38:31 +0000
Received: ("Tessian outbound 6c699027a257:v130"); Fri, 11 Nov 2022 10:38:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c15c773ee1516dbf
X-CR-MTA-TID: 64aa7808
Received: from 2902886cb62b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C2B8B758-B6A6-442D-A72C-123C11F2C5C5.1;
        Fri, 11 Nov 2022 10:38:21 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2902886cb62b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Nov 2022 10:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIqQDWYNxA6pSzU1NzvLfGXRcOej7Y9tcXQF4DYCqci92pXAVjO17FDejHCT6SS9OSFX9kvJRr75NVrBBe7IVhgljDC60MVUYjiGHcYjmWlJZMHToH1nAlN0v3baWpRFgVz1KUyqVKcsMkq9tGF8L/G/YPYAEF5GOMfjt1sqQlXjuaMgh/dr8mgk9/QpUcm+jDs88wHAPauDAcFhkwIeaQS5TDv2woFzm5O3sjpVkEqEwq10DpNw+7/63es+Bw8sR31V+kirgEiLqBsYOfe2Diw+lmyb4Gbte2U5sNaiIMWpWTJNC3p5K6ZLyZQuCmYWnZNS8NlYgUVGWeExjPTUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUac0vCTLBq5AgYyz0ESmQHJxSalYxhiQZqu3idpCMg=;
 b=A2AnRiAVKxbuQrTxOFfFL7r2tRBXrTW5f66VjKHvvoMmPHmqetq4M1hKHnyCgTcaP91XJUv5nxuG5T67JcaQ7aft0F8a+Z0XQBDO4SUtZGdEtMtJWlFk0DqBrRmjA8klfAMZiyyWPKjeJR1+Yjl9ae29o0vNpBeLm2W/ApNBqEhy9V3ldHR7Rkk0wrWsXoP3PCbIEaYeSMzMftZawRF+d1LgjjxpH0J7yDau8dSVo15ShRPQ3VMaexoJn/SMgpnRoMSS8R14sHq4EsnFFkiOhTB8OEJQQUPKmmkOlwa1nCzQZFc3lwqnsQuauW7GUf0B/pEPt+QVVOBbFBZ+yUCvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUac0vCTLBq5AgYyz0ESmQHJxSalYxhiQZqu3idpCMg=;
 b=Jwm5y20NsNGVV7V45IO2n4VcbgbHgIKpn7tz7ODgSNV+C+CvMT4atj2FKQ5ga0Tck7onFKnzIVXto4Ep+ImhVH672TsI6w7OYTp8I6ROaY0BKn7jQrsrniXUM1LU+GyrPfl2veIMDPYRBIbrPs9AwvhDrkFdaEIPtPqlJ1HTo7U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by GV1PR08MB7873.eurprd08.prod.outlook.com (2603:10a6:150:5c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Fri, 11 Nov
 2022 10:38:16 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 10:38:16 +0000
Message-ID: <b8129bae-6917-dd42-7e11-000bacca3669@arm.com>
Date:   Fri, 11 Nov 2022 10:38:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 04/21] arm64/sme: Document SME 2 and SME 2.1 ABI
Content-Language: en-US
From:   Luis Machado <luis.machado@arm.com>
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
 <ac30884b-3c48-4fb9-d649-aaf5863e4505@arm.com>
In-Reply-To: <ac30884b-3c48-4fb9-d649-aaf5863e4505@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::12) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|GV1PR08MB7873:EE_|AM7EUR03FT003:EE_|DU0PR08MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: d6365567-fcb7-463d-54ce-08dac3d0e0c1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4DCeKxrNk5scnfeob3iGSRcuRTftwkyzIrCbpc4M2ZNetUD/UAyfFtEsFBNOzeveCzZ3NHQaaA6+8rbaIIrMX5DnVYGf8tmnnfA9oMFlGuo44paLtVkk7jffPHXWAbVo2DLgmnqr3114K7UxDPIhMn9+CFbjyzzlLl2D3d/ZqVOWbpd7XYm6nj7UHJq6jQwvcjEa6BW0Led1BFqhG6U8wOYW9IlSghFDvXPQ0/pDq2vogyB0kZh687FrrJU7dNh1595dVwBxfRB31Ryk52Ia0DCNUC70hFhGY1JzckLo1+qDNdnkEXAn68GRzbPJBv4hV0p1JK9udzGiUhLZtxirY+JSWivHQAzmRvSgff+5INbQ+qRlqsPwwAyv43P07kNGxIJ7naCH30CnmgZ6oORlqM6d7K/Tg/FnjYryPX4Jk0edjKkMhuDFVnFntdsDWdVqjg6+WoJ6p8pCZEtrsJ4ARsMKVtYSy9khh4j/9j5MCotyBoByyNm5kNLnzvSydsLZEIfE4ppDbVmDWduPdzUyY5VM+ApJUDfwGuU0/lfkJ6Fhu0oe5U/Ve07bJmBsRoQWoAvf/ZnAxpcOQCAscUcygEZpOeUzVnYv2DbyVwxhEyGu99SoLnsBurnssoJt+3hfMnrYQdXZLiqi9pWt9Ebg4IUcOVUylqD0dZeQ++SYPHwuQAT9H/2ARC4B3R4Jr0DpFDKyTStNQ0uQ02zhiYgItXbggdtVDAis04b83kTWaDYcJ60fKlorY1/PFqgAeIyWowVFkBgElCyQ69NV07rCsu9CoOmwFEnDRW4rh2FjoGE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(66946007)(4326008)(316002)(53546011)(83380400001)(66476007)(66556008)(2906002)(8676002)(6666004)(6506007)(2616005)(186003)(478600001)(6486002)(31696002)(26005)(86362001)(54906003)(36756003)(110136005)(6512007)(8936002)(5660300002)(31686004)(38100700002)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7873
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8408cf8f-c387-4958-ca0d-08dac3d0d77a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXvXO3b2tI6hbuUpU9AyPlwl3/yupI52vJJ09muA0c0iDWnbNQtgVmNBbl3/mBiuaFWSAb/ptnUBjCcf+r3b6AbzkmpTKWEd9DGW+dV9bDOCVL/Hld2d3PLkaWxruGWXGTGwwrZgEhsSPkD/pJwQrq4OwpnhbViFu/fUtp4+FYaF7CFZXerX/jO9Ebun97D1nIVnXKVUsBvM3N8JNNIoL04PJWi11EqwdJUKlEvYemp5bzhPBDJQoDQpUbGJvSdkWVYvgTBm7NEpeVOUhE6Yqdl1uVhrdrGBKCfEpHIgnAcNl0eHV8AEZTpED0yzplsJoLnPyW0TWUn5XwmUzYtwKx5n6BLVBD7qPJouQyMN5CupTkxI1bYaIjw7x1oKGmHHtSKWPJJXDGZMfyWhPaQ3xxwYJEebto7pQNbey6dlfBKj35OJv+wI+DnNXwkvIUew8otNCgUz8FzHl6+ejyPGt3nByiVO4sZ6kK8n+x5NyTA1g47844joJlqHWPchJs7+n5AcV39rLjnSveLE2FUMyoDaATRMRbQczg40F5ReBivhi/MYyUtmr9Z1yF6MLELGdq7KBIXzOG5PNofpUr9f3rI1BvBG6NnXJpMVlhugMH+dbSBSKV0cVQ89PdRHa38GLsZB3n68wa655/EDxmYHRXYNo3mHvfcW88COjXmHRfUlPRvzaAKU3TJAF7VHCmoyzbn7T9HwEfPyRRGsJu6ir83XsiXpM3OAqkaiolQU8ubft+IiMFFtuMprTL7kFawu49AO0ksMBd5Rm2tfYg2oHsy7DWU8A4+sNzyKkSP6iJyaa4XVtemMgocYML6uRdd8
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(8936002)(5660300002)(31686004)(70206006)(70586007)(41300700001)(8676002)(44832011)(6506007)(82740400003)(6512007)(4326008)(53546011)(6666004)(26005)(40480700001)(356005)(6486002)(2616005)(47076005)(81166007)(31696002)(86362001)(36860700001)(2906002)(40460700003)(478600001)(36756003)(336012)(316002)(186003)(54906003)(82310400005)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:38:31.6945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6365567-fcb7-463d-54ce-08dac3d0e0c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9654
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/11/22 10:17, Luis Machado wrote:
> On 11/1/22 14:33, Mark Brown wrote:
>> As well as a number of simple features which only add new instructions and
>> require corresponding hwcaps SME2 introduces a new register ZT0 for which
>> we must define ABI. Fortunately this is a fixed size 512 bits and therefore
>> much more straightforward than the base SME state, the only wrinkle is that
>> it is only accessible when ZA is accessible.
>>
>> While there is only a single register the architecture is written with a
>> view to exensibility, including a number in the name, so follow this in the
>> ABI.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>   Documentation/arm64/sme.rst | 52 ++++++++++++++++++++++++++++++-------
>>   1 file changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
>> index 16d2db4c2e2e..5f7eabee4853 100644
>> --- a/Documentation/arm64/sme.rst
>> +++ b/Documentation/arm64/sme.rst
>> @@ -18,14 +18,19 @@ model features for SME is included in Appendix A.
>>   1.  General
>>   -----------
>> -* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA
>> -  register state and TPIDR2_EL0 are tracked per thread.
>> +* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA and (when
>> +  present) ZT0 register state and TPIDR2_EL0 are tracked per thread.
>>   * The presence of SME is reported to userspace via HWCAP2_SME in the aux vector
>>     AT_HWCAP2 entry.  Presence of this flag implies the presence of the SME
>>     instructions and registers, and the Linux-specific system interfaces
>>     described in this document.  SME is reported in /proc/cpuinfo as "sme".
>> +* The presence of SME2 is reported to userspace via HWCAP2_SME in the
> 
> I suppose HWCAP2_SME -> HWCAP2_SME2?
> 
>> +  aux vector AT_HWCAP2 entry.  Presence of this flag implies the presence of
>> +  the SME2 instructions and ZT0, and the Linux-specific system interfaces
>> +  described in this document.  SME2 is reported in /proc/cpuinfo as "sme2".
>> +
>>   * Support for the execution of SME instructions in userspace can also be
>>     detected by reading the CPU ID register ID_AA64PFR1_EL1 using an MRS
>>     instruction, and checking that the value of the SME field is nonzero. [3]
>> @@ -44,6 +49,7 @@ model features for SME is included in Appendix A.
>>       HWCAP2_SME_B16F32
>>       HWCAP2_SME_F32F32
>>       HWCAP2_SME_FA64
>> +        HWCAP2_SME2
>>     This list may be extended over time as the SME architecture evolves.
>> @@ -52,8 +58,8 @@ model features for SME is included in Appendix A.
>>     cpu-feature-registers.txt for details.
>>   * Debuggers should restrict themselves to interacting with the target via the
>> -  NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA regsets.  The recommended way
>> -  of detecting support for these regsets is to connect to a target process
>> +  NT_ARM_SVE, NT_ARM_SSVE, NT_ARM_ZA and NT_ARM_ZT regsets.  The recommended
>> +  way of detecting support for these regsets is to connect to a target process
>>     first and then attempt a
>>       ptrace(PTRACE_GETREGSET, pid, NT_ARM_<regset>, &iov).
>> @@ -89,13 +95,13 @@ be zeroed.
>>   -------------------------
>>   * On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
>> -  ZA matrix are preserved.
>> +  ZA matrix and ZT0 (if present) are preserved.
>>   * On syscall PSTATE.SM will be cleared and the SVE registers will be handled
>>     as per the standard SVE ABI.
>> -* Neither the SVE registers nor ZA are used to pass arguments to or receive
>> -  results from any syscall.
>> +* None of the SVE registers, ZA or ZT0 are used to pass arguments to
>> +  or receive results from any syscall.
>>   * On process creation (eg, clone()) the newly created process will have
>>     PSTATE.SM cleared.
>> @@ -134,6 +140,14 @@ be zeroed.
>>     __reserved[] referencing this space.  za_context is then written in the
>>     extra space.  Refer to [1] for further details about this mechanism.
>> +* If ZT is supported and PSTATE.ZA==1 then a signal frame record for ZT will
>> +  be generated.
> 
> I noticed we refer to ZT0 as ZT sometimes. Should we use ZT0 throughout? Or maybe ZT, if it makes more sense?
> 
> Otherwise it can get a bit confusing.
> 

Reading through the rest of the series, I noticed we're leaving room for more ZT registers in the future.

>> +
>> +* The signal record for ZT has magic ZT_MAGIC (0x73d4e827) and consists of a
>> +  standard signal frame header followed by a struct zt_context specifying
>> +  the number of ZT registers supported by the system, then zt_contxt.nregs
> 
> zt_contxt -> zt_context
> 
>> +  blocks of 64 bytes of data per register.
>> +
>>   5.  Signal return
>>   -----------------
>> @@ -151,6 +165,9 @@ When returning from a signal handler:
>>     the signal frame does not match the current vector length, the signal return
>>     attempt is treated as illegal, resulting in a forced SIGSEGV.
>> +* If ZT is not supported or PSTATE.ZA==0 then it is illegal to have a
>> +  signal frame record for ZT, resulting in a forced SIGSEGV.
>> +
>>   6.  prctl extensions
>>   --------------------
>> @@ -214,8 +231,8 @@ prctl(PR_SME_SET_VL, unsigned long arg)
>>         vector length that will be applied at the next execve() by the calling
>>         thread.
>> -    * Changing the vector length causes all of ZA, P0..P15, FFR and all bits of
>> -      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
>> +    * Changing the vector length causes all of ZA, ZT, P0..P15, FFR and all
>> +      bits of Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
>>         unspecified, including both streaming and non-streaming SVE state.
>>         Calling PR_SME_SET_VL with vl equal to the thread's current vector
>>         length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
>> @@ -317,6 +334,15 @@ The regset data starts with struct user_za_header, containing:
>>   * The effect of writing a partial, incomplete payload is unspecified.
>> +* A new regset NT_ARM_ZT is defined for for access to ZT state via
> 
> typo, double for
> 
>> +  PTRACE_GETREGSET and PTRACE_SETREGSET.
>> +
>> +* The NT_ARM_ZT regset consists of a single 512 bit register.
>> +
>> +* When PSTATE.ZA==0 reads of NT_ARM_ZT will report all bits of ZT as 0.
>> +
>> +* Writes to NT_ARM_ZT will set PSTATE.ZA to 1.
>> +
>>   8.  ELF coredump extensions
>>   ---------------------------
>> @@ -331,6 +357,11 @@ The regset data starts with struct user_za_header, containing:
>>     been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
>>     when the coredump was generated.
>> +* A NT_ARM_ZT note will be added to each coredump for each thread of the
>> +  dumped process.  The contents will be equivalent to the data that would have
>> +  been read if a PTRACE_GETREGSET of NT_ARM_ZT were executed for each thread
>> +  when the coredump was generated.
>> +
>>   * The NT_ARM_TLS note will be extended to two registers, the second register
>>     will contain TPIDR2_EL0 on systems that support SME and will be read as
>>     zero with writes ignored otherwise.
>> @@ -406,6 +437,9 @@ In A64 state, SME adds the following:
>>     For best system performance it is strongly encouraged for software to enable
>>     ZA only when it is actively being used.
>> +* A new ZT0 register is introduced when SME2 is present. This is a 512 bit
>> +  register which is accessible PSTATE.ZA is set, as ZA itself is.
> 
> accessible WHEN?
> 
>> +
>>   * Two new 1 bit fields in PSTATE which may be controlled via the SMSTART and
>>     SMSTOP instructions or by access to the SVCR system register:
> 

