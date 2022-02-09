Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8466C4AF51D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBIPXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiBIPXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:00 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40087.outbound.protection.outlook.com [40.107.4.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F91C05CB95
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ATT5yzR62sVJ6IDgEjMsoA8WjFRiM8ncXVViN8t70=;
 b=RN0l8B/jfLfSBDeh1uYyUlvdeihjEePBMxA1es+9H6/v8x5S5uejTHaSlp2UX6OtNMyecgU71vgxfaKmNL+7cX32YLsjpS9rjjRYCWsRTvRKaA0A7HMSuprVERKvyARWowCZOujUx5YgApf9DYJxyJOxLMgf5RcVpqCa3jRyjSQ=
Received: from AM6P193CA0070.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::47)
 by AM9PR08MB7198.eurprd08.prod.outlook.com (2603:10a6:20b:3df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 15:23:00 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::77) by AM6P193CA0070.outlook.office365.com
 (2603:10a6:209:8e::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:00 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 09 Feb 2022 15:23:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c47a43504e14e2ec
X-CR-MTA-TID: 64aa7808
Received: from e650ceb7520c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AEA00AA9-0A05-4C5D-9890-99AFA0377170.1;
        Wed, 09 Feb 2022 15:22:54 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e650ceb7520c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K55Sr7vPsomK0C+5MGDrA5hYIDwGNpCawv15CXZIHxji4XuAVWOEzpOaG8+NE45e9RlKSKw7b52UTmoVTx8G8d4qJUVOfIsM78jrKi1NZjaHs+xJA+V5WH42GBBMudXJNbPHNMR26KJQhJ3DdwdENvxwYDF7vNM6AwvhwzSeSc0+ViLHm+fNkOUJP7I7FSv2ilBKd3Y3AoG2nw2fxzxWp84xMDaqPPgvmV+O86nTXiKfwjkJXEM5jXpBSoISTpgLfXd9fN9Or7+jFSiyuCNxCYzZDi3+jolyjUskaO8Zx/bDSJHVH68WRwpYqbI9a3soXc/XQzoGvjUgCGe1GFyZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ATT5yzR62sVJ6IDgEjMsoA8WjFRiM8ncXVViN8t70=;
 b=he+BwBBH84bKNm1covRemQdHwLuP0UZVJgTSIKUqfee0gPcJmzR/fFAhktKQ1//hjoxnVOkTgw3xNXUUPY9D6RPSha7avc1mmmMPXEuIKZy627KDSJYy3AobDNoKLY9RvvKYvbUxunWhgSzuRPrENAmZVwIm0pxqlMwVFWxhy83g1ScOC9EXU/bG2X4MnhK5sONXktpo2Gzxp3kYsO0z2pLtWYqoNCapbs47lcq0KPzmoBBbw4Y3v/p4eCy2AIVn12j02hXlYFdFFYyNY8QsFoBT3n01La2JBX1lqFQnsMek+bHYEDiY0UazqHJStg2akaZvONgjH+Br8ls14rfCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ATT5yzR62sVJ6IDgEjMsoA8WjFRiM8ncXVViN8t70=;
 b=RN0l8B/jfLfSBDeh1uYyUlvdeihjEePBMxA1es+9H6/v8x5S5uejTHaSlp2UX6OtNMyecgU71vgxfaKmNL+7cX32YLsjpS9rjjRYCWsRTvRKaA0A7HMSuprVERKvyARWowCZOujUx5YgApf9DYJxyJOxLMgf5RcVpqCa3jRyjSQ=
Received: from AM6PR02CA0035.eurprd02.prod.outlook.com (2603:10a6:20b:6e::48)
 by DBBPR08MB5993.eurprd08.prod.outlook.com (2603:10a6:10:1f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 15:22:49 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::c) by AM6PR02CA0035.outlook.office365.com
 (2603:10a6:20b:6e::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:49 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:49 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:48 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 0/6] add more test coverage to MTE kselftests
Date:   Wed, 9 Feb 2022 15:22:34 +0000
Message-ID: <20220209152240.52788-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: c36516f0-2102-4e1e-2459-08d9ebe00ebd
X-MS-TrafficTypeDiagnostic: DBBPR08MB5993:EE_|AM5EUR03FT046:EE_|AM9PR08MB7198:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB719875AEE643E6DD33B04031942E9@AM9PR08MB7198.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: obkAsDRl7AnxYkjrwfec6Ko3UyJmBLsxINNb0rtg+6x7cdZFbuJlAQodeYoI+lBR8jkEB6UTcBtzHI+gX8hAF/j0jgFl5ogQgGmfbQEZ9PjyiJ3fQOkPO6DN4KqEVptakhLIlOFhvSUPQ5ADogkxELzjqW9xvUFs6L2cS+QIrL1YEuqvZnu2IOUfd2dldwP7wvhHUHKY7r/BSjoO8qae6/8QnXsb6mCO2GlHnl2MFtF/pdkY0qgiufbQvlSpukSBkN8IzCpH8uJQc8TRBoU2lvpjtc4plbPmJSzsNXO1ZVvX1znuFf77dR11BfDyiue9qKRF7SHneM4jmdI/s7WjvdBclOk0Yu6PjfZsr+LCfnEy6YAp6QRbDvc8iO2z93OAi8gjGADqqBjzHWZFvFwqtiPA9EHPdilhlFYuc9tv5u9YQ8BcfyNO0uU8t5pFmmaFT3Y+y9xxf6VxV8MlWV5vluSZOFY2Z+RqgwHwBliQt9M+OREt5Xd8Oga5O6w4dQ7Kcxkepj0wi1OyfyuO0ykWiPRhl+ZF6CBYosSZ8LAz5o4bh0XW0yQ9ds+P5yTgzzKCuM531kQtEGUKO/mOLTz48+m3OtqpqlR6AlNMEqqckvMWLwOJe1K7/69ys8gsPuhG7n+7vpDBGWDTxJUMD3lj6M2Z0CXndofNlAhV+I6rEUBVa7wtBSVC0NalhQN9YwUcL8iyMFwNAaCPVBAqYmBvVbpoVSw0XcOQuffGBv0MV0W0+UWfbFXmAVzv0m58sv1SVxfoG7iGYbdJFdqTgsQ35V4BBCUtFIz2XFbD4qCrGV7Ai/8YpSOVvGa7sMfsX+f6wcfy/fwkxQx9IQNPsrRzBA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(426003)(6666004)(54906003)(966005)(44832011)(316002)(6916009)(5660300002)(508600001)(83380400001)(1076003)(2616005)(2906002)(26005)(186003)(47076005)(336012)(86362001)(40460700003)(82310400004)(36860700001)(8936002)(8676002)(4326008)(7696005)(356005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5993
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5f4b3d8a-f336-4ddd-afd7-08d9ebe00849
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNcSbe0gCklWPD7rpm3MEm9JEYBQuC771MuoWIIUKjcBbUs+tccHjSNCS/Xr9Yev//zZhdH+iTfIxFIiwY+QC6/WHiQTzfZnvCkDpjX8/yN359cJd5VmlRd5xuYxoMmo1J4+lM3M6LCVEVDmn2q/kdxzSVKqHYdz2h0tMenN6FaFZIecvtFuAu+q5rB47xLGUmATMd3xdZF/rYi5whsm850CTO30l/esuk74qDJDc5qMIQrSyN0vTaPnDmV+NYHg+1VI4VaTkoPghkO1UYGTm9x9r0pzFfWHdtdWxsQbMnh90VhltSlxy/l0B5m9tLnuAp/C3wXyrARh+pXSwETt47KH/0XZjOog07N4PVVgyuFW2kJ/GwMN7riAY+oHdN1cOl1uKFpzLOjQNJ1whX9QUyW68HfrbDrnX34iZHm/1cLepHJeLf5RT1tKWpxShtVEjCG7UhRAoHe9BRMvDlAsGdb+iCYWOyaAMIJ4Fuq20BW3CE0B0FYFuGasJmm9FkEmA8t0GeHTW/wiSEv4If1qvm/e3A8mWUL4sY6WmGXL53xzGsK4NNFeIVoGFSHU3PkNjmDuiOs/lgW+h+Jbb5p09brT6SiCXr0eSw48ROdX7btfOrQDtP49zyMveJBOaxVBiMALX/dz/ddigGYFmviwNXaoQvbHMzzn6scBPcv4Cg4HwFvd6IdHTd56HvoVfN9KDQq98yMacfbr/FNdIhrxCEPmEW2+fF8+iMxGTFIEsu/ffIGMdA/Gf0e76pt797jH6/uZOYRXVP/Wv2pNH7YCrTttRVBdp2zD5AK+rOde6diFZQDJgkcaC+ytaUR60HHf
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(54906003)(8676002)(336012)(36756003)(6666004)(5660300002)(82310400004)(44832011)(86362001)(70586007)(7696005)(8936002)(83380400001)(2616005)(70206006)(36860700001)(426003)(47076005)(26005)(2906002)(4326008)(508600001)(316002)(966005)(186003)(40460700003)(6862004)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:23:00.1489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36516f0-2102-4e1e-2459-08d9ebe00ebd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7198
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a series which refactors and then adds some extra tests for MTE
in the kselftest framework.

The issue that these tests are for was was fixed by Robin in
295cf156231c ("arm64: Avoid premature usercopy failure") and based on a
simplified example by Catalin [1].

They test some combinations of pointer offsets, sizes and syscalls to
exercise different paths in the kernel.

Changes since v2 [3]:
  - simplified error handling further
  - added more detailed commit messages
  - add reviewed-by and tested-by

Changes since v1 [2]:
  - add a page_sz to the tests, for non-4K kernels
  - use loops to generate more tests and avoid long lines

Thanks,
Joey

[1] https://lore.kernel.org/all/20210624150911.GA25097@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20220125150920.23955-1-joey.gouly@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/45ab2d96-c8e0-7b72-a384-c4160b9312ac@linuxfoundation.org/T/

Joey Gouly (6):
  kselftest/arm64: mte: user_mem: introduce tag_offset and tag_len
  kselftest/arm64: mte: user_mem: rework error handling
  kselftest/arm64: mte: user_mem: check different offsets and sizes
  kselftest/arm64: mte: user_mem: add test type enum
  kselftest/arm64: mte: user_mem: add more test types
  kselftest/arm64: mte: user_mem: test a wider range of values

 .../selftests/arm64/mte/check_user_mem.c      | 193 +++++++++++++++---
 1 file changed, 160 insertions(+), 33 deletions(-)

-- 
2.17.1

