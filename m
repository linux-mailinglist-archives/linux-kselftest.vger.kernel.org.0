Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F764FF8F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiDMOeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiDMOeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 10:34:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE085715A
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeX6CdcDvBFz75ubqUKjPtDQHKTA8YoXmmKNPHcbXSI=;
 b=B0uLTzgK14Idum1BDximv5h2CcPSp/Cv0mQhHlHl7LsPwaI5YZSNS25mgDbxxPN1iaGV9MnqtoZ/aHooDRBPYbEbdhWJNKPyMICeYDHj6pg2p+chQ9G9eDUyt0+Tnn7D6g2PkjaeQza1ZpUWHBt4jsckyTsNKkh4jFtC1/+7dqU=
Received: from DB7PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:10:36::16)
 by PR3PR08MB5596.eurprd08.prod.outlook.com (2603:10a6:102:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 14:31:47 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::f8) by DB7PR05CA0003.outlook.office365.com
 (2603:10a6:10:36::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Wed, 13 Apr 2022 14:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 14:31:46 +0000
Received: ("Tessian outbound 9613c00560a5:v118"); Wed, 13 Apr 2022 14:31:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b8ace3b9ad138d0
X-CR-MTA-TID: 64aa7808
Received: from 1cdb946d2832.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3D74F195-8975-42AF-A94F-B26CBC81F1D8.1;
        Wed, 13 Apr 2022 14:31:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1cdb946d2832.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Apr 2022 14:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeAM8+ed2QIE7o6gz5bRyGEFpn+J8OzriyP+by8n/fY1YOSw5UMPyEpsuT7492xW4xJJgUVL3IvyeWcdAxkgfaZDpMHR07UoVuhNjoGwFlMIP8Fmd8Xdq27GYNwyIBl1RhvXWcLEfSR361vzsYgnG6YfZHXpxq7Aq7s3wAXNLWkKSsPXlIRG17eszLviHWX9KfiZOJuBoHHTLchNrDt1otT+0O5J3QmIGyBEOxKmgYgs3Kh/fCSK3Oy9txM9+QytwXoc/1Wtn8Wx63JTEeqnovTlhDEwt1GM7IWbEeBnwSPeCSqW7w2/bgGTG7gBsQZ3Ci54oP4Ccxu0oIRASjIPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeX6CdcDvBFz75ubqUKjPtDQHKTA8YoXmmKNPHcbXSI=;
 b=EGNAG992Sf+4hrfBPMu9ktz6dIp4yIklkQZci0EdGiGg+ByH2CZnsqgDhM4a8y5eQHBOVE0tPBCt2mv1pynmnzv4kSC/MilJB6uxvfb5DLGRr+9YaHcfRwJeIpCnO+gUJUZtlcfRfSyovX8ecqHWkZb3I0MyoAs9OzxQ5/nRaZGtuq7FC042/Ri54yTsfAo1YpBeeJhx2U73kXjdQ3xoRtYGOk4Q4M6dBX8MHPj6G5Zeb2KesirFYAHzr0vpQUfb9+3n+s39ml1RJi3bTrIhL0gpF5UxsSDWQj/F0JKwZHGaVjuaQ3ngokxNwdBt2RIakHCIgz8YFLUR1YXPEIkiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeX6CdcDvBFz75ubqUKjPtDQHKTA8YoXmmKNPHcbXSI=;
 b=B0uLTzgK14Idum1BDximv5h2CcPSp/Cv0mQhHlHl7LsPwaI5YZSNS25mgDbxxPN1iaGV9MnqtoZ/aHooDRBPYbEbdhWJNKPyMICeYDHj6pg2p+chQ9G9eDUyt0+Tnn7D6g2PkjaeQza1ZpUWHBt4jsckyTsNKkh4jFtC1/+7dqU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 14:31:38 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::6092:f7f0:3af2:fbca]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::6092:f7f0:3af2:fbca%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 14:31:38 +0000
Date:   Wed, 13 Apr 2022 14:31:24 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v13 04/39] arm64/sme: Provide ABI documentation for SME
Message-ID: <YlbevBvj05ys2vlm@arm.com>
References: <20220408114328.1401034-1-broonie@kernel.org>
 <20220408114328.1401034-5-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408114328.1401034-5-broonie@kernel.org>
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8fbb9f90-3046-4d90-4fcc-08da1d5a56fd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:EE_|DB5EUR03FT061:EE_|PR3PR08MB5596:EE_
X-Microsoft-Antispam-PRVS: <PR3PR08MB5596B59F364EB370693DACD7EDEC9@PR3PR08MB5596.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RMVwzZIbWpB+8UwgbZBZ8t/b84z5dpul/dkFbgDtCbrDsVzYVMPH2DNjkNaeWtJPdRm++2wX4K55Ba0xAHKtK4KGjwqaokj7CcFZH9PoBeXryYhXbzTehQDN4Tg86uUvQuAi1a9L2vFGgI9VlD05FiWzv+419jCwj2Hxpabk1PDy7ABVaLuZvHrkehVYY9FdMhCD/IRFCMbK2XJ0EF1U0na5aLKdw4OmCBoCeUKwPzA2DK6qDlmna9wVDZAZEoFBcWSe4U9OP0a7Jj/QMhMbmS785Gih13WDaQ5aDx1M/Dk88uDh77RpJoArIPjLRQWbor3qxRYAP/mG8fq4zTuJFUkejkkbBonQvmWzWhBEE/Kv1XrEv9wgUP+Gy7pwpDedKC/ZRQ8D2Jyic9rOQ5eq1+B64Qk1gmJpP14qc0TbLPEatEyqrUc4kaMaXS2evdWQWmTHlmREBzRMdQZ/ycvaplnT+p+kQ+6NSbnJ4Bl72Ut+1yJ3yB0g26QyQ1t2W7Ejq6jZr4gKouL+ZqboMEXee8dYmaM/jQuLJqyOWFdSIQoDJLi/pg40ynKOFTec8m1XcXwsP+aYM4xLoMcAtr92lQ6OPpekNT6HPIUqOsC2BHDjhdQXaDg7H3ksCNNNfDkJ5kToDisO/HjgKswfcDPIgA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8676002)(2906002)(6512007)(2616005)(86362001)(26005)(186003)(6666004)(36756003)(6506007)(508600001)(38100700002)(4326008)(66946007)(66476007)(66556008)(8936002)(4744005)(5660300002)(44832011)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2c71a9cc-23aa-490b-ac83-08da1d5a51c5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WUEayvdJpEoAR87Rx5gPA2ep3Kl5PxxMzRCEgnqwcflIdtwpt1N6BEzyQIftkzplyuD9ku381gbWu6XkioFDNsyklsl8BABxVVB8SUYgjtfk/4bddS4Bx8B9giiM5lOBJtkIcq5rOxVueDhjVO0YNk6Afg7URCHL3yAhdR1uXichI4d6Zk2CLwhLGJ6Tn4B7/KiRY/64bZ7NzhXYkMdwFqljD9l+UL9vNDGJXt4H8JYZQdzfey6+NRxhV7CCBqHlOteW+Ig+xOyk7hT0J7RdN7y9M2Nj9ipV2NVSEF+18ro7rj9CARa5lgH0GWG304ugQWuMt5Kn28RJmN0SQ0pdjYQZ3G/NIRKHgK3BK2lNQSXY2CvbvquPlg33A1Qyz2+ghkdSDEVRQlC+wQK3Wa1O/LrCdK9D3U/UCeMTtPnOev27Gr8Y7rUeVzl8F/hymkKf/1JfMJacrO69bEmD7IbG9kdZsSgElT99w5fNjYnd95lazWMi7N5PTkgq9LeChniRY4nDKGc9iF15xjYIAe90pnJU7g/TpDli/jJqF1kbrCryhFXYaJCzWaS0HpNwuZ24wyGZDkV3DYjSxZrjLEHLxv6+eZlJsXOrDBrygEM0WsmIy0zYR71qd5hTOO+s+uyInIyurM35SKIDSWdxdUjWKvyj+gfc2IyrBQtyd03Iwef/AA0cQs0jyR7XofhG06F
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(8936002)(6512007)(81166007)(186003)(107886003)(2616005)(6666004)(6506007)(40460700003)(86362001)(36756003)(2906002)(70206006)(6862004)(4326008)(8676002)(4744005)(5660300002)(44832011)(36860700001)(70586007)(356005)(47076005)(336012)(54906003)(82310400005)(508600001)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:31:46.9894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbb9f90-3046-4d90-4fcc-08da1d5a56fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5596
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 04/08/2022 12:42, Mark Brown wrote:
> Provide ABI documentation for SME similar to that for SVE. Due to the very
> large overlap around streaming SVE mode in both implementation and
> interfaces documentation for streaming mode SVE is added to the SVE
> document rather than the SME one.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

looks good from userspace pov.

Reviewed-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
