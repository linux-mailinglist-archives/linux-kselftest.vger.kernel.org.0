Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284365980AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiHRJRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiHRJRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 05:17:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1767447
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 02:17:32 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jDZDG3OXuEPXLl5m3aKWEtbo+o3tJyX68lUqzW0cZZqenMfK+1JKuHImyYBmxyfHTjTCPA8Un3coW5Xfgf8nsOpYaBGD6F32uuDxV/JSusY7vU1EVb0BUzFApG1kubgBr/7PyPQ0DHwbfpYOG376WKFdZekLG1qC9wOmSB3J3CMKCNbS1MWQaBddJD9902CEinCbPVtPTvCTFgKWAwtgQ7XmcVxqb1pYV7HsgLSiQqucwjU0BCly4X4gXB4tmQMTYSCQvm9+HCebLUdJ6cAybPKCJQrp269XkGHvmrwaihd/eRJanabn621WITcjf+KOj/I9NPz+TqHnbWTnygMLsg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRfvMPkNnp0O8F2eEDigXOp5sff8pKuKCwTmgTZTZ7E=;
 b=n50dMyjq++z9iuYnU7AGvpRChfuacKO/4kEpxlG8ETLqQ8phJHPqlJnlrW4KpEBN6HYVwBVTOXz+Ou9zNHINb/2xHPo5evWknIo67ZPyTkZ3zmXHn2oUG52SHlAybXcnMyfmCcNQDPfuqEQRyM62Iub+Z/HMnrDLpikQT7QFdKg2RzSOHmvx+mZruUD77F0nMpHBtmqoILQzduj4DgSf2J/exLAaJe57eIIQ4xuea2inszmPJdp6wAGkBaZm+Jmxjyqz57GGC8CT5Fx8eGhHOHF9Mt99LeCmhlXSNhsQJqjhiIW0RedOtWzGRZCjDjc8W49MqYQru0sXl9uZTnaCmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRfvMPkNnp0O8F2eEDigXOp5sff8pKuKCwTmgTZTZ7E=;
 b=j2y2Z5ZTKu68HmV5k3OxIQDbjM17M7gnPsk2sZrgC0wbjgLBRPIiUFufMa2iI3KU6XREnANutoVOcx31n5wmoEhkievd0enQtMYQKN1sit3Qefs/gMKDGbDRYcWHeqaLvh6/Liyk9H8MVKwo7O9Ed2NgO1YlYOmWy2YYuJxktfQ=
Received: from DB6PR07CA0090.eurprd07.prod.outlook.com (2603:10a6:6:2b::28) by
 DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.19; Thu, 18 Aug 2022 09:17:29 +0000
Received: from DBAEUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::b4) by DB6PR07CA0090.outlook.office365.com
 (2603:10a6:6:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4 via Frontend
 Transport; Thu, 18 Aug 2022 09:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT052.mail.protection.outlook.com (100.127.142.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 09:17:29 +0000
Received: ("Tessian outbound 6a3290ff1310:v123"); Thu, 18 Aug 2022 09:17:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d36c7bceda41d64f
X-CR-MTA-TID: 64aa7808
Received: from 05333a289a21.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7AF9E397-210B-4DA5-954C-E4AACBC0288A.1;
        Thu, 18 Aug 2022 09:17:22 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 05333a289a21.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Aug 2022 09:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwaZy61BMh1HGwrP/ScXUhV/e/xHbZheEaKdX+oyF7b3jgw1IiJbScvIc2GCQinz/XKeTU5WKjHDka+DqIfe4PFEYsFxS4rwTY3AVY3GDlucCObdXAp03maLIo3dWClLU5eJSClIiV5diW0Ak0EUZh7ySdFAWnGyLzus44oYRLA03y0/rw5ffp5YMwTazu0a8QVKBKbtCrRGced3I+2WJ5qb8DWjshwjXu7jbXC9KdhNa2pka7PZHEHMK1+VhxLVs5lfry8ENtRO82+qc1NCxxtVAS6rGeWFBF0asxAze7P1X9C3v2gZ6WQrMmxwluFldJiWjVRW/I8bWMbwz8dGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRfvMPkNnp0O8F2eEDigXOp5sff8pKuKCwTmgTZTZ7E=;
 b=MQBR2XjHR+J2uTdD8t0OA9xtr/h4wAUKxBbdxesRY+yE21BiPcJLAC/y+ifZZ1e6M8xN2wqGVEvJZ+ADz/orLdH+830Vs5WOM1x6n9tqMNm146JWSOXHxq9ZmUfX96IkJHnUZZXf6FtOG8+3tTrE5eTG2Uo+FhXo5zaZr6PT19tiPz3dzTIlx3WMjLIbWePwQJkuspjaXSmdV0kap0yPyJ5uDnKT7tqWDv7JAAYtnwMOzoPkFR/B4FZt9+oDogS4/aqzwMgcgnsR+OlfP9d4yWmhpZ5TtrQKZUl6pyF1De7Cs+NgqFwIJDy+vH7/bZOTBfAm0kPVqdxUvA9shavNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRfvMPkNnp0O8F2eEDigXOp5sff8pKuKCwTmgTZTZ7E=;
 b=j2y2Z5ZTKu68HmV5k3OxIQDbjM17M7gnPsk2sZrgC0wbjgLBRPIiUFufMa2iI3KU6XREnANutoVOcx31n5wmoEhkievd0enQtMYQKN1sit3Qefs/gMKDGbDRYcWHeqaLvh6/Liyk9H8MVKwo7O9Ed2NgO1YlYOmWy2YYuJxktfQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PA4PR08MB5902.eurprd08.prod.outlook.com (2603:10a6:102:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 09:17:13 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8%4]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 09:17:13 +0000
Message-ID: <4cf1c8d9-4aa8-dc1c-a568-69d86b706a60@arm.com>
Date:   Thu, 18 Aug 2022 10:17:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to
 cover TPIDR2_EL0
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
 <20220815133034.231718-3-broonie@kernel.org>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <20220815133034.231718-3-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b0f2e2ae-3016-4ea1-75b2-08da80fa79bf
X-MS-TrafficTypeDiagnostic: PA4PR08MB5902:EE_|DBAEUR03FT052:EE_|DB8PR08MB5388:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ilrMvTwmqCCM0JXTw4RzGZqBBidwO/TaP9t+hbetcsL7UDGIeRsKtlWuu6ux+TrsJcNpnt1N6G8U5Q9e37DZRqJORlnCgpU9uCJXuplp5jqNQ2fbSq/VocWkortKs/wp+CgjgoTqnpHYOUoipvlrXXCLRLhDTF4pzPC94SQlAr1q6tXrrELZxqqFN1O1XQ78nikVgYKi4CY9LNMpmRDrB7dpECLB2AbxXFjiBmQUvnVLdocaO6N9nUeghnYvisB4wHj7kiZWgjgQIE64C1e1xhK6QWFoZxFbizIjmtHH/nfMpATur5zEi+J78khKKMdFgkgbqXtLwS3wzG4aSBpqJXi2S/wdkyLDYcElCITimF7De+90Lzjzuly2mDMog0tN57/v36ItE7a9fDHE4wwXbi2xk3hlFMb5zClhkiVxhiKtJyVcRaKDeOPw/xx7yjbHsl4kH/eJwoCtvshafUQO77OL94PoCp1ixGfwYCi5J9/W2lRWPmNt6VHALofj2J6u1bO3Fn9AhUPxxDvTSCWwR/L/5j1QdMR1OrwgKPePdSIUH7MwJ1f9W7O4HNH+n3E1WVBAQXYtUUQvM+1AllrvMMyiT2ZnYpF+ehE4l2zC78z/3xBhQ+Sw24BWTkEBYtHg/PnLB/64RWPPJMgXrs90hhGRHV1rlPlDsjYsj3CvqHiiYOQUqTx9oKt2ofHZcIkL/a2+QMBMSFz7hPdS5jWwsj28szqiQbcovFoEgVOxKT9/0T/4S2W0SXAbIwSZl43vI7wSk4oZWAt3eHwcI7dkbUi0ZUzGD4wcYkEUa9V/OpU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(186003)(6512007)(6506007)(2616005)(31696002)(53546011)(26005)(86362001)(38100700002)(83380400001)(110136005)(6486002)(36756003)(8676002)(5660300002)(44832011)(478600001)(66946007)(4326008)(8936002)(31686004)(66476007)(66556008)(2906002)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 758fa763-a099-487a-5c70-08da80fa6f83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH207HQKTfHR/ljAYlzaQbqsnt7gwPFtpaxCpWz5X9BOtYVbaechKzbuONQfFbgomwL3CcjN0T68uwFJUHDujWX4hKzn+1LL9Oi5sH+ci2i4qA9ANnCS2+2JFPkncIuw15isUF3pZESacO43LodSlvT5kbHC7HIHodsAvekHv+5z/DLgCtKsFA//EE1yjG6TqFYeE3aC2giGYU9sZhEJRRC7G8L8zI6chveNmPeAqWOmZ8mx/8MqxFZaB1238a6yeT3Iglp3Jh+x9076NnKNAH66l4h+7ubDFH0HpENMq2PoQcZhUUHfaZ2nZ69ZT1zLbXxBdw6JBGD+v8jb02bgXPxrH65KDgxmxMaeiZ4gM7b5Gtwx2FiiJvkWOnwe76F8jfIWYm4q/Y7H1jLOeX7TIzjaxMY/+WDsvNnbImDr4idBgjiHGFFb/1rIoD2lsPnchEqZ04md1dnsTXLe+U2OBRclN/JPeNgL/+wglfyIHJgERZ6UodtYM6CA9DoCTSgAYbZkFcXGX+nKBleXMsSpd5YYsBfxic1T59qmUztUYr03ghiponGAQs2d6FdYTf7mj3v4rSOi7qlYhytNCFCIl9rHZcw6zPgRPQpaHiWDsxb13mThdZhRLH8sRG7P5OibxlOhG9zY0FqfP3ZhJVEYavqkzhd3r+DxKRdTOVn2H+lVu2r7qz4FdZVitzXtlTdoIUS4V6MYuYXwhKfPweDk/2QA6FK1uesIuGZKgn2bJJxFmL7FX0Mc22xmtbbxI23RVGJeGq+LufzFoBIt7tNLFGGBGSF45MPUys+/DKclOzyw5w8FA1OkwjtISTh2rRSO
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(36756003)(5660300002)(44832011)(478600001)(40460700003)(40480700001)(316002)(110136005)(356005)(41300700001)(6486002)(2906002)(70206006)(70586007)(31686004)(8676002)(8936002)(4326008)(53546011)(31696002)(336012)(186003)(6512007)(2616005)(86362001)(6506007)(26005)(81166007)(82310400005)(83380400001)(47076005)(82740400003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 09:17:29.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f2e2ae-3016-4ea1-75b2-08da80fa79bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5388
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
> In order to allow debuggers to discover lazily saved SME state we need
> to provide access to TPIDR2_EL0, we will extend the existing NT_ARM_TLS
> used for TPIDR to also include TPIDR2_EL0 as the second register in the
> regset.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   Documentation/arm64/sme.rst | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
> index 937147f58cc5..16d2db4c2e2e 100644
> --- a/Documentation/arm64/sme.rst
> +++ b/Documentation/arm64/sme.rst
> @@ -331,6 +331,9 @@ The regset data starts with struct user_za_header, containing:
>     been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
>     when the coredump was generated.
>   
> +* The NT_ARM_TLS note will be extended to two registers, the second register
> +  will contain TPIDR2_EL0 on systems that support SME and will be read as
> +  zero with writes ignored otherwise.
>   
>   9.  System runtime configuration
>   --------------------------------

I wonder if we should document a bit more about the use of TPIDR2, its states, values and
block format when TPIDR2 points to valid ZA state.

Would that make sense?
