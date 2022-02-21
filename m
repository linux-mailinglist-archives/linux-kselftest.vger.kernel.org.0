Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9A4BE995
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Feb 2022 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiBUQHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 11:07:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiBUQHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 11:07:44 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20048.outbound.protection.outlook.com [40.107.2.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107463BD
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ1Te0Z2VY3QLKeCul5toqF5YfU1gWf69/DM2WNyGzo=;
 b=UD/pZyqCXR/H3MitbHZtA93qcTa4+SsS+8ITI6fV5J23HzY1E6r4lOdok1hrwBRmu2fpDu8EPJD156RSs32dS6KqHFx1d8rct96ZoUtBJRSKOajgL5HtqqTAUd/qz4Rg+hcClxGXkgbB4C5u/o70EqKcqz4a1lo8l+QMI6CiLrs=
Received: from AS9PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:20b:467::20)
 by AM0PR08MB5025.eurprd08.prod.outlook.com (2603:10a6:208:15e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 16:07:17 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::d5) by AS9PR06CA0143.outlook.office365.com
 (2603:10a6:20b:467::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 21 Feb 2022 16:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.20 via Frontend Transport; Mon, 21 Feb 2022 16:07:17 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Mon, 21 Feb 2022 16:07:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8392cc25391f3ad1
X-CR-MTA-TID: 64aa7808
Received: from bb7b34e8e996.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 41416247-60D3-45E1-A68F-198D43274806.1;
        Mon, 21 Feb 2022 16:07:10 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bb7b34e8e996.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Feb 2022 16:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADSITfUnNyuJPDPD4z1m+PXSmMivXmYjqWvub7f6kOB0EEpI+4kfHdbdsn3RN8XQfW4+TFU58/Ut1mVb9mV0qcW1cbauZHWdsIg6IUENA0Et/2c/HCtAR3xDDCgutua69TvMKEplbBEFczrABG7WQv6GWIAHKG5jdUFmTZHNHSJNiua/SsaNjRedG6IULMJshbV2n+ulIPbOrxuBZRYOVWBiwuJcH6vUyrr2q9sjEX9mRLwLX2Ynlh5X4xOM0EzxD4Bns/VTQ497vp5KcOyss9xkeXsjZd8Xsar4RyQ5TwPV2jCIzh7hMTTcCbu27iv4ch4DM+yqscaRfFnIvySRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ1Te0Z2VY3QLKeCul5toqF5YfU1gWf69/DM2WNyGzo=;
 b=ViE4ndqyfeMqZgeUYTeU7wGFaRTZI5ZfBuyuZwkR5doiIFYffaN+Vfu4MnTphldFxEAmPGsV8bCHGmnHayuHt5cRW3VQMpbaoZyxjucfLsIFGyyHMt8dwhE5bNNUopEwABqypYJATFJPv8uUfa8ZgtCfrzony6bF5jQ1Pmm2jk/yPHR68lumg473MslUhiYik2BhWLj69tN7RdIPGwHt/Y9k9TD3C5eS6E35TAlU8jeNW012kKoqx3oi6B77o3okJy/0UwaXB7ltdxdXzp7ejf9ddL7D+iFZX4lcD8fqt7FjXgNE90D0TEmdbV+JQEr1hW8czcIHQNVHYT5P7a/Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ1Te0Z2VY3QLKeCul5toqF5YfU1gWf69/DM2WNyGzo=;
 b=UD/pZyqCXR/H3MitbHZtA93qcTa4+SsS+8ITI6fV5J23HzY1E6r4lOdok1hrwBRmu2fpDu8EPJD156RSs32dS6KqHFx1d8rct96ZoUtBJRSKOajgL5HtqqTAUd/qz4Rg+hcClxGXkgbB4C5u/o70EqKcqz4a1lo8l+QMI6CiLrs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 16:07:09 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63%7]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 16:07:09 +0000
Date:   Mon, 21 Feb 2022 16:07:06 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 10/40] arm64/sme: Basic enumeration support
Message-ID: <20220221160706.GK2692478@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-11-broonie@kernel.org>
 <YhOihgeVRTztfDqv@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhOihgeVRTztfDqv@arm.com>
X-ClientProxiedBy: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e77ae4d1-9eea-4602-b07e-08d9f5543b84
X-MS-TrafficTypeDiagnostic: PAXPR08MB7247:EE_|VE1EUR03FT025:EE_|AM0PR08MB5025:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB50257EA6E6FD3425C6722E2CED3A9@AM0PR08MB5025.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gJcJRITGicRibPCZLT7r64dJPQyOMcXGiGlfv4LfdlFjG/zrGfioUt/+tA/RlDY39i3LeVywuS0Ms7J3tQNP80gy2ETEjK2TIBBO4FjpP70iRPxkdxZytMwh0mY5+2TAuvK11nPVqalt/tm76Vakd813SmHwozIwjXtRH3lcsfubJrOfnT8Ea8Y9g86zyoE9PSCCg6uW3IR7Hi+64DSh9SoQ85AlzXdSzpenU/SmBt+5g2a0c6rEtmUZESJpLQ3nn8eBGewRHT5ixP/w091nVIXHfPALFaLmitp4dWn5qS4SI9rmVY0xS2acWx+DRJZtZ0vBq8D0cp3aTMS7T/uauhIgiYtxux1Ivp4xZV1piUp7DPEP4MbMxJ4Y3MDGbcZy/cAHMca3fuRSdE2VnG5MZGuqnu/1LQhzJ+GwIAzbVtlH/SKUO7836dQyR6pNj53BhnVbAi8+scPWyKq+I0uXm64hYTSk5hUZGJ5+DquzZzyl1AoLSY5EkJ1IsRmmMglOBH23Cr/Zjaw6OVDKvWESAdi6nzWCldXmcWlZ3B3hbBYnMO9zIW0ILRbu4CqlqzIFnrCnVop3a0erJHiOQsAOaAeIMJRrQAaS7BwBYqxAGPYw8DQJYkao5upe87b/GPuxexPPxshOZAAtNaAwbfCIZ6s5EPjGvSQrEMHvDDBd5sIf7gWT4iIw4c88EQRj4WkjJ92wRhLEVkvO12IfYUsJUw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(316002)(6636002)(33656002)(52116002)(66946007)(36756003)(37006003)(54906003)(8676002)(86362001)(2906002)(44832011)(1076003)(5660300002)(6862004)(4326008)(2616005)(508600001)(6512007)(26005)(186003)(8936002)(66476007)(66556008)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7247
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a6ec36e9-1e36-45a3-6760-08d9f554361e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrpCaFpFT2OS1T5T3+FciX7UaN16SpziwQuJZ6sWmYhoDUv8qmcZRmg04v6Uyp3QJJyqqSViJQ1YdgakwXcP9vpKH3GyUobISCv7WA2f7Vs9+hW0En5ZEkjj1CJ4D0wusPmwrI8xOrjcUVpzGXXlWHL9ctAYM1KCQy5gab4KYghOOt0vWRVAHU9rMlLZ7jkWRzA/pNSLDLl+6LpFHKlHOV0LttHdFYMEMrxjBxS4kz/+oAXqFydSZaRxErU4hPj8Se0deF8hpyXco9RnkhoeOiMqmLCmjK4Rr6u4YwSsjDWlIdecZ2P83Fzo/8q0XlsHRlrK31jqJWjbUqDf3HMw4VYf85WlpEar4CPN7/4lrMCW2PZaMP70NYs2HoWVPbnEbVLQhRkcwT/XPfoxw0tsY0ROPp5gyG+GfKVgaJ1J4CYK01FN1mtegrZNo9YrSsm7N9j9oaYSI3yGnMbuQNJA/K72F8Fq2hez2cGs9eEHEzYWo8TsbE3jHdJV/fiFOuMtPhaf2+Aibp389UKLVRCQYPS+TzbgjDwpn2nwNRl86RqpxgstYqr4JTAUaQjJRU/6uKpe0YKS/bV0qAJVC4F3IZ+vf1XDmLHJXlxgDAM7VlPVH76sPLbteinraC2XgNtlHmLdlC33kXYo5abH0tExFd2mWpBlojg4Y0aqtvtHF4g20YtWHArxj+ZLcWXofo2W
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(37006003)(6636002)(47076005)(54906003)(36756003)(6512007)(316002)(44832011)(508600001)(26005)(33656002)(336012)(6486002)(186003)(8936002)(40460700003)(81166007)(8676002)(6862004)(4326008)(1076003)(70206006)(70586007)(356005)(82310400004)(107886003)(5660300002)(86362001)(6666004)(6506007)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 16:07:17.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ae4d1-9eea-4602-b07e-08d9f5543b84
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 02/21/2022 14:32, Catalin Marinas wrote:
> On Mon, Feb 07, 2022 at 03:20:39PM +0000, Mark Brown wrote:
> > diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> > index b72ff17d600a..5626cf208000 100644
> > --- a/Documentation/arm64/elf_hwcaps.rst
> > +++ b/Documentation/arm64/elf_hwcaps.rst
> > @@ -259,6 +259,39 @@ HWCAP2_RPRES
> >  
> >      Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
> >  
> > +HWCAP2_SME
> > +
> > +    Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
> > +    by Documentation/arm64/sme.rst.
> > +
> > +HWCAP2_SME_I16I64
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
> > +
> > +HWCAP2_SME_F64F64
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
> > +
> > +HWCAP2_SME_I8I32
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
> > +
> > +HWCAP2_SME_F16F32
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
> > +
> > +HWCAP2_SME_B16F32
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
> > +
> > +HWCAP2_SME_F32F32
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
> > +
> > +HWCAP2_SME_FA64
> > +
> > +    Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.
> 
> More of a question for the libc people: should we drop the fine-grained
> HWCAP corresponding to the new ID_AA64SMFR0_EL1 register (only keep
> HWCAP2_SME) and get the user space to use the MRS emulation? Would any
> ifunc resolver be affected?
> 

good question.

within glibc HWCAP2_SME is enough (to decide if we need to
deal with additional register state and the lazy ZA save
scheme) but i guess user code that actually uses sme would
need the details (including in ifunc resolvers in principle).

since we have mrs, there is no strict need for hwcaps.
if ifunc resolvers using this info are not widespread then
the mrs emulation overhead is acceptable, but i suspect
hwcaps are nicer to use.

do we have a plan after hwcap2 bits run out? :)
