Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6485E60B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIVLPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiIVLPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 07:15:31 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F39E889
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 04:15:27 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mNx+FpuvbZpjyn0Iqr9B6DOmJre7xSag7KIaB02l9izp1p7S9jBzRfmr3wCiXvrw0LIz9HwiHJfxSvflcutuzSxH5NsRmJj9R//Zg7G6fCGpNzEZgfU6t3lm1PZfdCoBW1rThjL2CD3fgQoB47o369DcYZfvHaE/L0q5w2IYGDfxLMSb/lxnh12hp/zpLtVrkVyIuK6EDqD8k5VoDkwdPnj82tZjXK1cTY6GhUqVsAxIaTEsSNFrdBPyu/L187Dn+rbKhDxfYEcjnsbt14dKI9z6O8K7u8TW3p01srkeqp0iJKacvsxs67HDhNHmSpu4fwJr3REpg1DK4OBskFJdaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khaNBbMdRZGVhf/UOGIOGGdoI+MO32HGQedhPppKox0=;
 b=Fg9ggPKbFtU1DrytN8SB1sR4Y9OqzTFquYZAS5Gw7ov4tpk2F+249xcaSAI/p+U7blLKN/xoOVrys0j32rjZQGIcWdpHuA+RSjJi/Ygybxa0z1V7RxrsrUeTqlKEGQ0CrVyo3gpqT08eZgJ5M4SsfA2jwSKUnw7ZJRU7u7A6B4N7ASVY7eTLwEjTJgL+c/+L4VR1kjst5ebidR61YyhvA/Tfel/JEY/ZA4+EnMXgL91Prk+bAPT18UR2xUJIsT9ex/Ya4oxkujP65vqHxNiGiuZQ1fqalqJ55AEJgw5GuI67Dbp1B+jStjuTwjc83BIw7DiB//0B77grzWKZ9ZXn4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khaNBbMdRZGVhf/UOGIOGGdoI+MO32HGQedhPppKox0=;
 b=qQ3j2DokGo8NsL33X3G+CnqLgRjj56d378ub0JACUsdk/DHx0BWzqLXwYjgd5Kfb7YNZhP02nMwQnIb14nbGFVcYeQITB8IhVF6Eo7Kno/zHupw3Gvvagn27GQe4J3qB+FeiTJKpamFOZI+M0w6ppZrQtio1KZGynnDH/gKBos0=
Received: from AS9PR06CA0354.eurprd06.prod.outlook.com (2603:10a6:20b:466::9)
 by DBBPR08MB6202.eurprd08.prod.outlook.com (2603:10a6:10:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 11:15:23 +0000
Received: from AM7EUR03FT065.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::23) by AS9PR06CA0354.outlook.office365.com
 (2603:10a6:20b:466::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 11:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT065.mail.protection.outlook.com (100.127.140.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 11:15:23 +0000
Received: ("Tessian outbound 88978e6d60db:v124"); Thu, 22 Sep 2022 11:15:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4cabcedcfe77814a
X-CR-MTA-TID: 64aa7808
Received: from b394edb63384.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A0E7D358-F2BA-4D5A-9172-088AE375FB60.1;
        Thu, 22 Sep 2022 11:15:17 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b394edb63384.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Sep 2022 11:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp5HoX7xBcBlOX/CedftrRONfMK52EU7IkingFxP+mTX5Nrc7sDKjMJ5VF6+JWHs1QrQrk5nJK8jNLXRukb1+mRl39aO2/zmsfJ5s8r9lqeaJlb3oVVbUpwWVfl9pThdm7ECEFT9OAkmV8yfBMN130TynH64cvMtmDT82ToFz4nMkg7++QJncv8zdcz9u5qhnqukJBvJx/Q7JEh8Wp0Y8cHCEnqnD9nyzECOYEDsJ4wtHQFXG77kXt1hYVrF4GBuPbIRDfLFH1zNwQOm2b3yB3UlbDSh9ympIphrjwnmoJQ1EYvtwF4xTX3LKCMy/AwC/ABpZXraNs2fUNI1u7MzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khaNBbMdRZGVhf/UOGIOGGdoI+MO32HGQedhPppKox0=;
 b=AFCL5q8AhloWNZ3iGM61qpbbfIm2vVNEwP8liKqd1DZ8aBQ07zLyq7IE2VXTl6AAChJCorraPHag9Xj30WzyITzDKOL0W+pFPg0Xtr0KON5yXXYABdC4dBGgkVkZSBjDtjIWpGg0j0yle+hPpRzhLXL682mlSmaRol9OKqQG9ajLjdTIhAY/LxxdrfFz8R5Yhb7tm9CDWHEhRjHsz5+LViZISRwjvhxnKlaRbxYYnd9zujyioJjRS0ej6lRWTrG8BNzfsNbAz4kRYrCnqWnRVG/ezN2eB2Qhg7T3QzArD6ma9rpVmw1mj1Pv5fBxPhDpsfQ8uO3MUyWGs8km9vbA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khaNBbMdRZGVhf/UOGIOGGdoI+MO32HGQedhPppKox0=;
 b=qQ3j2DokGo8NsL33X3G+CnqLgRjj56d378ub0JACUsdk/DHx0BWzqLXwYjgd5Kfb7YNZhP02nMwQnIb14nbGFVcYeQITB8IhVF6Eo7Kno/zHupw3Gvvagn27GQe4J3qB+FeiTJKpamFOZI+M0w6ppZrQtio1KZGynnDH/gKBos0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 11:15:15 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::c5f9:a25b:a5f2:6094]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::c5f9:a25b:a5f2:6094%5]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 11:15:15 +0000
Message-ID: <f87f6a6f-d137-9a81-fa44-5a6bda2991fd@arm.com>
Date:   Thu, 22 Sep 2022 12:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20220829154921.837871-1-broonie@kernel.org>
 <20220829154921.837871-4-broonie@kernel.org> <YyRlm/koy30sze9Z@arm.com>
 <Yyhj2kEtJcSSngd2@sirena.org.uk>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <Yyhj2kEtJcSSngd2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|AM7PR08MB5429:EE_|AM7EUR03FT065:EE_|DBBPR08MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d91397f-6fa7-4c0e-8c41-08da9c8bbe73
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pN7nI4BlesXhwk8iV085MG96+cz8a49kmaSATEdf6rMbILUEIlUSeDR+yHsfaOwy8rXFbp1X5871gOQXL6XEcJ1iGgM02tj2SJMAJXGyRkDjgqRc29kzRHMu3iQRfuXNOblPJcsvnV3yLJ5iwtnjxdqDNSBiG6J4pfu3SIgOZlHUyH4LSeIqe0Z2ix85LaTp6q7fBabwQTPYbmKjUiSg8ApFRnMWknFJXveA6b0gxeEDPmdKXT+PHKpHLGIaCR9rF6Rab5XJrzk2gNa8QsnOl64B9pjkOo1JjZ+Bf5UY6s5Ewo5PXhPqD+VWsRwc368Zp6eSYEMQadlKJoOuJjSAyJWYDZus/baX7dCsGZ4uMX671jWeOvSRewh4jThBjhNNiP+Sv3u2o2OAzUDaTtEs1DQIrsfte9AvK9EFx92Ygc7Nek0k6w1poyyLIBBkU7qUQEY/8Rn+hy3z744LiF4ryuo1BnszqNY75/mn/S8fbn3SpPkeGdHQaYtkY33FrK9icqfUTZnfGMqctSuB4/auww/uqlXmQwyLNvSOuJdkXtY1BBDFChOw+tPNY68BnofSeMCGsUclSubI2m13rbIhbZkaU2kqtTp7y8xvetjETy9lAH8DEX3fu0YHjoAm3GfU0HYKYQStVmO4BZOMVErTzQ6Uv7WmEqcZMEHs6p8fQxD6pQUJWsj9FlhuelCd5wRehf2AMSetbNeJjKRXsl+YJ31ATaGxRrxc12RU3TYInOSq7HN7wra+/ngZiVmFmIwuLgCGGVAFRP1eCAdCJ5OhqD5u6r7VPjriTVmGiDA+M5E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(4326008)(8676002)(66476007)(36756003)(66556008)(66946007)(110136005)(54906003)(6636002)(316002)(41300700001)(6512007)(2906002)(86362001)(186003)(53546011)(31696002)(6506007)(2616005)(5660300002)(44832011)(83380400001)(26005)(8936002)(31686004)(38100700002)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT065.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b3c8957-b672-44e5-19bb-08da9c8bb97d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teuvtWyEypFOdXeFyVF5Xtyd6oDPNPugiHKEcsTu3uETbaSJ4UI+tunmomiSBCKcjmz0S93dAAi3xoNQhVsq37g1tDCORjSMHHHaePd0lzqmqeogkvlGka1/gMZNjqAZKQX2Gz9smlMsnX0Yr/35RRWFGFXarjjebSVqVbhnXxeQjFEuxlDjE5QOVzRF499wVN/rhlBhm7a6G7KO9+UaGm5v6OwokMV9SyzZdU+hw1eSdqnX+WLIi6aiE/AMQ2pxHUHon5Rzyd9WKx88rOq0hzy1xWdNplapePInILxUZ/w35gsm+Fx0laA6AYd8CfSLnhtx/pBw2dsS46/Bc8FVq5etipnoRR3k+C3Z1sCd/fWHOOfds8ccnZolKIaw1ffyL3IwGEPYNoNWsRE07a/nybw/6d86NIquDLDE690GBT260Kzho20RA2C5iTOhcTvZYYfxB/ZnkwtEZ4VwecW2aWclU2BrLWxSqWNMBGIUZNh+nyfz8Je1MswcTQXbSULwhtb3Y9jafeYKCSXJdXqIE3Q7wYFaVUR02twUnsEXrPIuX7HFErjcanI0CtXv2aDSWAVsdYiR0veQ2eusFwZaI3rlWhkB3vS3ZEZSrUjwfWMUaonrrFJ5y8KJLcS0D7vnUjoEfYQVgDskPS9FB86+M3OwW5wyq11rb003K22PjMgMobyvuqRnv3IqP21xjeqopzZhTtdlmW/hWNksDcSLA0vUk/KbFl1jyjUsiBzsWWXltPO9Aoep4E6Mt7iXdXzFt5Wuv/ZMPxj2FUFhpXagI5UaAPTrEKWIzYjrhBKcfovHLXSNSa9iZkvtRgaeX848
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(356005)(36756003)(31686004)(81166007)(86362001)(31696002)(36860700001)(2616005)(44832011)(6506007)(53546011)(40460700003)(82310400005)(6636002)(40480700001)(2906002)(336012)(6486002)(478600001)(83380400001)(186003)(26005)(6512007)(54906003)(110136005)(70586007)(8676002)(316002)(70206006)(47076005)(41300700001)(8936002)(5660300002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:15:23.5352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d91397f-6fa7-4c0e-8c41-08da9c8bbe73
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT065.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/22 13:43, Mark Brown wrote:
> On Fri, Sep 16, 2022 at 01:01:31PM +0100, Catalin Marinas wrote:
>> On Mon, Aug 29, 2022 at 04:49:20PM +0100, Mark Brown wrote:
>>> @@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
>>>   	},
>>>   	[REGSET_TLS] = {
>>>   		.core_note_type = NT_ARM_TLS,
>>> -		.n = 1,
>>> +		.n = 2,
>>>   		.size = sizeof(void *),
>>>   		.align = sizeof(void *),
>>>   		.regset_get = tls_get,
> 
>> Does this change confuse user-space? I presume an updated gdb would
>> check the iov.len to figure out whether a new register is available but
>> would existing debuggers complain of the new size of this regset?
> 
> gdb seems happy as far as I can see, it is possible something would be
> reusing the read_iov for repeated TLS read calls in a context where it
> was only pointing at a single u64 but I'm not sure how realistic that
> is given the idiom.  I did do a search on sources.debian.net and didn't
> turn up anything that'd have problems.
> 
> If using this as an extensiblility mechanism is a concern we need to
> bear that in mind elsewhere, and for this it's either a case of
> providing another single register regset or trying to do a generic
> sysreg read/get (though that'd be another regset that's not idiomatic
> for the regset API).
Older GDB's assume a single register for NT_ARM_TLS, so they will always
fetch TPIDR. Newer GDB's will check the size and act accordingly.
