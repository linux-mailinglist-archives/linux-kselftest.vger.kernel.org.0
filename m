Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3879598076
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiHRJEG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 05:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHRJEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 05:04:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD33FA1E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 02:04:02 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ew+I76Yyo3js/ET0ipqww/EyrhT/mMHocq6D3JYKwlbC+VEs1h1i47qsbDEyi+FSHY7i81VnqC1c/Qlmd9Xorwll1xwWBe0w+34yNNI/mrCgS/wXymB6aJgoqclWa0Wtu9tKLEQ8YWqdH4L2IaCwWtN9I46TJ7px5XdoXcBIjViA/VCurjGCZjTNqcfFT7IBOL2mAu8sNbd2dibqFTey/jRtujOKNA+/7RbZ72MK3a2u/S/uODki4nKl9IfA+ntKTIWMuGqhBbWKRTBnUQBFfxGk7uX50t4wxk/hbsJoFoen9apzTf0J2QMQNZxRTa1UYvU5NXnowlhl3nWNWXUi9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjzFs+ubVOiDGclqcxvB3a4aB4LNv+TzUW2fRXk9cr4=;
 b=KYg8KhitH1WX72WAQzigO+7v+FCiR8083R8nVXKkBpiUNIEdopA/gyfKffs2S46fucnEWxczlGBhVvthP3ZwEOubj1lfhD0b5bO8kkzAuLliIVPKSOFwuBkLL2/7evpSAgjvFdbjkHEAxyc1w3KM6Hu8MdbwoxZfLg+IWOdXOmP1HutOPSsyigfs8QG0i1uZt0BRWbrXJzeJKJ0SoDOwtK2U4B+j41Ll8dxuSTrG8biNhNjp17t6pYVd+Wr9+S+DAv71MGj/ptdvqZ7P0egcW7CJDOI7Nf5267PFwMohpwvzIC+cjGKM4eFzjOgavoABGDotfN5aMtL+AYe/G7aCXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjzFs+ubVOiDGclqcxvB3a4aB4LNv+TzUW2fRXk9cr4=;
 b=7M244uyjK3Tmc51bHo3IfyaQwlwz871nYgv6kouKOrMMVUZrl5Tl9WpE7JQl79UsmoIEsqIkS1GA+pLuZJd2Vr7QHAmzGBpWmRB31fe8NTd5HFahYavs8asosFCDxQ894rOKxeb42dY1qg1u+64osaX+drXi3/yikkg8cUcYHug=
Received: from FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::13)
 by HE1PR0801MB1964.eurprd08.prod.outlook.com (2603:10a6:3:4e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Thu, 18 Aug
 2022 09:03:58 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::a0) by FR3P281CA0042.outlook.office365.com
 (2603:10a6:d10:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4 via Frontend
 Transport; Thu, 18 Aug 2022 09:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 09:03:58 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 18 Aug 2022 09:03:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 723f0624d983f68f
X-CR-MTA-TID: 64aa7808
Received: from 2ada5e48dbf4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B30559C0-1F01-43CD-9A5C-67CB2CEEA311.1;
        Thu, 18 Aug 2022 09:03:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2ada5e48dbf4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Aug 2022 09:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap3BV/UH4ufP2/bkS2CRV2m5O1IihC+7pnAS89CJJFpeOiq2sHnRDbdTVPHrrisMLk7Sh9mJVZMCGcg7YKgrzO7j944GaQbd5IqzsiypLJM/hTCZuStf8iiBulhbHASWQdSN3IsG1/UssQrF97gstJUUciB43MHMqJ7b2is/p0oEWJt+rzdM1w2aTGhnD9wVmA+Cmavw7PL3pI/BpRT7Ib5I2NjSBfSEY7LJ3gyav5Nyonu4Q+KTKj2F3qQp47BL5LLpgSHqEPOAntTSxn/rNc2rcYOpH8/hVeswolqCgf5lN/dBDht5wnby/kui4ATWiHjGBYWMC6CLPyhYnho77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjzFs+ubVOiDGclqcxvB3a4aB4LNv+TzUW2fRXk9cr4=;
 b=SnqUrhcckIqPZpUomEc2DuqqJHN0hesj5DZJYodo9elJDxoqeFRgaDgrSfAHVJi/YhTbanfy91eQG2cu2dcu3XpSaWZQA+DNw+/GNLDMTRW8P4trIIUSUmtHrfGH4aH8dzL+KEplt/2IaFpw7Se4HVglSE1ZD4aAR3ItCc4P0v96VaSzQAe2ofprtm/awHx/jzXhIrGerQ8cl636A+133Z8W9XHMgLrJBQLqjg0nCOjixv7i+MwmKy7lcPBzQNjoVIMvHTJw8QxYQQOWBG0H1ssE8z1n95FKkwlK1bXR7p7+Nwj9kzslsfzzKTSCTjXb9i/hRfTd7H+iU9H3Mz/3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjzFs+ubVOiDGclqcxvB3a4aB4LNv+TzUW2fRXk9cr4=;
 b=7M244uyjK3Tmc51bHo3IfyaQwlwz871nYgv6kouKOrMMVUZrl5Tl9WpE7JQl79UsmoIEsqIkS1GA+pLuZJd2Vr7QHAmzGBpWmRB31fe8NTd5HFahYavs8asosFCDxQ894rOKxeb42dY1qg1u+64osaX+drXi3/yikkg8cUcYHug=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by VI1PR08MB4079.eurprd08.prod.outlook.com (2603:10a6:803:e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 18 Aug
 2022 09:03:44 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::cc64:9170:b12d:de8%4]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 09:03:44 +0000
Message-ID: <08a76a19-5e9e-6943-802a-7ed26edf9240@arm.com>
Date:   Thu, 18 Aug 2022 10:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Add test coverage for NT_ARM_TLS
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
 <20220815133034.231718-2-broonie@kernel.org>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <20220815133034.231718-2-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0346.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::22) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b8c6661d-8d91-4760-6a07-08da80f89605
X-MS-TrafficTypeDiagnostic: VI1PR08MB4079:EE_|VE1EUR03FT003:EE_|HE1PR0801MB1964:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iDu2VmF9t3jWHIyTv8zbBdLHlPRjJHlTCYJMLtFhwl8t2rT2tyqnnPt4Nhl7gtQh2F04n1nK2AJhlU8wHeiRx57uGHZ3c2YVt1b0lJLsMC/U3VMCRD4Am8gbWeQ9S0bJr1NMcOPZn2aO/+daPlKETsbvRfj1imyIBw3HJwB1G1HpNBPVurjkTrJ6fv80fsbCynfPfh0337ig2FrFZFqwBxTIWFQO5/kJHgaFe7aBQy21mfJuSjAbS+kLWsKEzGq8YIjaiTCswwChPNvgwMl06kY/5a4WeZzkXP1H+XSs7sFeuv6/bgyeFdThOT+o2h28yUbmCCTfzL6AHAi+6/Xtn2//FRG9FUWGXIYzO1oxknRgg2obW4SzkPNuMPamsZFL4nURfIOTY4v3kE97gNLXxJTautZUPlpqxRt3NxX2dNKnPISxh3kmJWRbRlYqdEUawE5xdiGkuqXpHjtIVAwuvxLKpb0Kx9110tx253I4dQQEcqdeiZdG9p5zi1/9Ov2YqFfp6OEpdfRnqZrpuqZSbWmuQUATrquQb2+XV42NNIlFH27qxp890r4C3y7SB5rxcrM/5TDiZr4aPQbclc3VJvTDdkudXQTUSvp8T7g3vWYtX8AKTreQTzj/VvdhtGjCtCs575+oce/Qne8rt5T0T+AE5qo+0nLo/Dshh+juWFafU9IKpghYWUAenUQnJ97+RkEWTkTuVbHgGogLe82SNjAgAFi/RymSE1jRuxCcGpYq28uvCb5u2mkEUOHBVamNZGKBbpWjyEYBQvlZkFG7yrUJCQaSpnKuumw6+9HtXek=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(5660300002)(478600001)(2906002)(6506007)(316002)(6512007)(38100700002)(26005)(2616005)(31686004)(36756003)(186003)(110136005)(4326008)(8676002)(44832011)(66476007)(53546011)(31696002)(6486002)(86362001)(66946007)(66556008)(83380400001)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4079
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 632261f8-116b-4238-a2bc-08da80f88da0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns4lJ9ZkdEkMYlZ11SOjb/Dyep03EU9cgoZ09jNoGEyJT0fRtXK9oOi5chlkDkoPLvRVaAY+sI99Hml1v5Nk2/bC+gOhT7ulVfAF1fb4NIFdJE39BDxUc2au41QctTg3RqgNM8uH2MUB/dpZF60S0IelU9vfeGkX/V1GR2G9hYgkZIjwQG1L/IcNHk2I2or7bnJ5RZSVIG13WV+s1k+1sMGHLrU8ERPARyz9YFTr8aZphwycSuh1JVAYlAcIX+iQcNoQD51g3z6AI7XJkVDMvRt/PgXTl8o4pi4Qi1LuWBFMrZ1Fo9jdX+V/eX1XFsjtyq3UWBm2R0PvK0p36myWoQX6wMbLGqmmYFhQrYqYEi2szxhExXYXX6i+AnZhseSZTv7V/bqOUsjacePgEXQImc9m2f72wlK8d2W4Jjpb8Vgs6eft8eQxXUDfBnG/VAGStoM7wP/FCIyUSojYzCUR+V59LF8HVnwUNbsWiywHWYfRMshWgLJBxVOhcWhN4gDP64chnnGGwpCeCeEQs0k0sZUzK/RwzZ/Plo5oGDI60Dmb2bdHN7LYcFznZ6yK0LoihldiuBpCCm+dY6yLwY5Rwb8LZQ8MryhSmiv9AfQLede42BCTWdfbmVBwEdgdmDw8GuYFhvoL6n5NSNCgid7sDmZGwR/W4Qgo1jI2aarRmGSSlmvNDgT/f0q5csxerdimUi196k3JLLdkmoiKovhvddCtWSb9K0ya1gwIPZr9zFEr+n76nq4pXlHqmzHdEpbwp8pv7puEHUHrDrkNAsUHzt0I7z9tJhy6ICkcgAhz3gU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(5660300002)(83380400001)(31686004)(36860700001)(81166007)(82740400003)(336012)(186003)(47076005)(2616005)(356005)(41300700001)(53546011)(316002)(86362001)(36756003)(6506007)(110136005)(26005)(478600001)(70206006)(70586007)(6512007)(6486002)(44832011)(8936002)(4326008)(2906002)(8676002)(40480700001)(31696002)(82310400005)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 09:03:58.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c6661d-8d91-4760-6a07-08da80f89605
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1964
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/22 14:30, Mark Brown wrote:
> In preparation for extending support for NT_ARM_TLS to cover additional
> TPIDRs add some tests for the existing interface. Do this in a generic
> ptrace test program to provide a place to collect additional tests in
> the future.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/abi/.gitignore |   1 +
>   tools/testing/selftests/arm64/abi/Makefile   |   2 +-
>   tools/testing/selftests/arm64/abi/ptrace.c   | 165 +++++++++++++++++++
>   3 files changed, 167 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/abi/ptrace.c
> 
> diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
> index b9e54417250d..12607c4580c6 100644
> --- a/tools/testing/selftests/arm64/abi/.gitignore
> +++ b/tools/testing/selftests/arm64/abi/.gitignore
> @@ -1,2 +1,3 @@
> +ptrace
>   syscall-abi
>   tpidr2
> diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
> index c8d7f2495eb2..445ac2dac4ee 100644
> --- a/tools/testing/selftests/arm64/abi/Makefile
> +++ b/tools/testing/selftests/arm64/abi/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # Copyright (C) 2021 ARM Limited
>   
> -TEST_GEN_PROGS := syscall-abi tpidr2
> +TEST_GEN_PROGS := ptrace syscall-abi tpidr2
>   
>   include ../../lib.mk
>   
> diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> new file mode 100644
> index 000000000000..4cc4d415b2e7
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 ARM Limited.

I suppose 2021 -> 2022?

> + */
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +#include <sys/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/uio.h>
> +#include <sys/wait.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest.h"
> +
> +#define EXPECTED_TESTS 3
> +
> +#define MAX_TPIDRS 1
> +
> +static bool have_sme(void)
> +{
> +	return getauxval(AT_HWCAP2) & HWCAP2_SME;
> +}
> +
> +static void test_tpidr(pid_t child)
> +{
> +	uint64_t read_val[MAX_TPIDRS];
> +	uint64_t write_val[MAX_TPIDRS];
> +	struct iovec read_iov, write_iov;
> +	int ret;
> +
> +	read_iov.iov_base = read_val;
> +	write_iov.iov_base = write_val;
> +
> +	/* Should be able to read a single TPIDR... */
> +	read_iov.iov_len = sizeof(uint64_t);
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
> +	ksft_test_result(ret == 0, "read_tpidr_one\n");
> +
> +	/* ...write a new value.. */
> +	write_iov.iov_len = sizeof(uint64_t);
> +	write_val[0] = read_val[0]++;
> +	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
> +	ksft_test_result(ret == 0, "write_tpidr_one\n");
> +
> +	/* ...then read it back */
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
> +	ksft_test_result(ret == 0 && write_val[0] == read_val[0],
> +			 "verify_tpidr_one\n");
> +}
> +
> +static int do_child(void)
> +{
> +	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> +		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +
> +	if (raise(SIGSTOP))
> +		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static int do_parent(pid_t child)
> +{
> +	int ret = EXIT_FAILURE;
> +	pid_t pid;
> +	int status;
> +	siginfo_t si;
> +
> +	/* Attach to the child */
> +	while (1) {
> +		int sig;
> +
> +		pid = wait(&status);
> +		if (pid == -1) {
> +			perror("wait");
> +			goto error;
> +		}
> +
> +		/*
> +		 * This should never happen but it's hard to flag in
> +		 * the framework.
> +		 */
> +		if (pid != child)
> +			continue;
> +
> +		if (WIFEXITED(status) || WIFSIGNALED(status))
> +			ksft_exit_fail_msg("Child died unexpectedly\n");
> +
> +		if (!WIFSTOPPED(status))
> +			goto error;
> +
> +		sig = WSTOPSIG(status);
> +
> +		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
> +			if (errno == ESRCH)
> +				goto disappeared;
> +
> +			if (errno == EINVAL) {
> +				sig = 0; /* bust group-stop */
> +				goto cont;
> +			}
> +
> +			ksft_test_result_fail("PTRACE_GETSIGINFO: %s\n",
> +					      strerror(errno));
> +			goto error;
> +		}
> +
> +		if (sig == SIGSTOP && si.si_code == SI_TKILL &&
> +		    si.si_pid == pid)
> +			break;
> +
> +	cont:
> +		if (ptrace(PTRACE_CONT, pid, NULL, sig)) {
> +			if (errno == ESRCH)
> +				goto disappeared;
> +
> +			ksft_test_result_fail("PTRACE_CONT: %s\n",
> +					      strerror(errno));
> +			goto error;
> +		}
> +	}
> +
> +	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
> +
> +	test_tpidr(child);
> +
> +	ret = EXIT_SUCCESS;
> +
> +error:
> +	kill(child, SIGKILL);
> +
> +disappeared:
> +	return ret;
> +}
> +
> +int main(void)
> +{
> +	int ret = EXIT_SUCCESS;
> +	pid_t child;
> +
> +	srandom(getpid());
> +
> +	ksft_print_header();
> +
> +	ksft_set_plan(EXPECTED_TESTS);
> +
> +	child = fork();
> +	if (!child)
> +		return do_child();
> +
> +	if (do_parent(child))
> +		ret = EXIT_FAILURE;
> +
> +	ksft_print_cnts();
> +
> +	return ret;
> +}

