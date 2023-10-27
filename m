Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733FE7D9E2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJ0Qt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0Qt2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 12:49:28 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F7128;
        Fri, 27 Oct 2023 09:49:25 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NX3IcZVKEVi8ouuYJ3MQkhSJn1M6FZgzWshfVZpi5tQh/zF6kyNo4VHUWQa/ElXL4KigjrWfiL7o0I3S7s8fnhsjTaYkQkj7Ok7cjWSMy2FOHxu1al3ARcQORJ2Hoy1PnA77rLLYInWH93R7FMJ2yMFgpUkYvAez0pE6qHi7PlEaf/m8kMoVu2voLeAjZkEVlgVtzvORxtIzi2VuzFIJinn31UHTmaMhV3D9aUjf13mUSSDo9BCyTOeTZhs5GTRHg/trCgB65Ovk2a+oUsae9IkExaNrOGLFn9xypWuBbDEp9fy95l7CGusOpCmbCfG05BSEEa5wQuWoYiZkjeNCBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REGPJ0UNPsyvT3yuPN461JpuNmHrOBp9GSduCUHdoZQ=;
 b=SD+zeptVwrWBLuxEjGFQ9wVMFKBb11WsYq4sNO2qpgpkEIo8KrKDYZ7EYghhwKod0UYLeK8PvZp1TOwywTLjotJce5EJmzI/i3HfeBWDhYxiz7cesfolwh4Spa1Bqym+PQb1jqtJbmz/JuZWvUoRoAglZ++iPLrnPKs+lf6I92FeXF14PtzpMJ+hL7GvHlaZwvT0iWabr9Llhqy/B094m3t2GURF5q6HpdMZu2GgBbpTbfiPIyrdV8lmLreFVya99F6lOVe8hl2ChDUVp6Qm2ld+e8BeYP2LzdFdm5X7pL5rdfjKXQ+6GZ0evyWCCdOczA7oFvD55Ohl29J0QtmiNg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REGPJ0UNPsyvT3yuPN461JpuNmHrOBp9GSduCUHdoZQ=;
 b=ECtQ8FVh4XSr8iXicMA/+31lzOEUplCIh9wupSevn2DicnsfboexpicxtbVPPsM3ykIZ4UzuHGR0PcNI4lpG3KFkkb71U7Motq+xLtSyIqdMeDDpPKJMd5aygiGeDHfZpIghZ1IZGRxmMABqT/YKUd1Z/GCrSh0fdBQm2wFBSZc=
Received: from AM0PR03CA0027.eurprd03.prod.outlook.com (2603:10a6:208:14::40)
 by PAVPR08MB9625.eurprd08.prod.outlook.com (2603:10a6:102:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 16:49:21 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::d8) by AM0PR03CA0027.outlook.office365.com
 (2603:10a6:208:14::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 16:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 16:49:18 +0000
Received: ("Tessian outbound 8289ea11ec17:v228"); Fri, 27 Oct 2023 16:49:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 126c18e29d26f69e
X-CR-MTA-TID: 64aa7808
Received: from 9370c5c6f176.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9C995D1B-B0EC-4E37-9831-ACB7358F55C0.1;
        Fri, 27 Oct 2023 16:49:11 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9370c5c6f176.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Oct 2023 16:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crzemSv4y3lSc3uUxZfJMR1E3H01bSeeuFiITx3FBKwtUxpfcFXBt7SJMNHLzRQB04GgNidRUn+lbP3OUjl0oKw7e/5D5FjUmWxyJK/0OOBK1JdPzsPw+pacIr9zHihFJ9LZj21lljhzgtKtwOIXklVB/wSGSVsGZiHpQfQvC9ldzjgSMqo7hiWfI2CTM0mOfVfHWj3codwgNjA3vAQUYHQIwEKzEnq2Jpb+ekc//sODoGEkisRrYz3njJdEVT9xACjZL0FUxW/eMR1xuLIyyyx2ac2+GWEN8O79Ecyzs8Q1vEnznfkF3KS+UyQ5ovj52sU7VJqhf3mkvhB1wd9siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REGPJ0UNPsyvT3yuPN461JpuNmHrOBp9GSduCUHdoZQ=;
 b=d+5W/2EQ3/pjSP9r5vLlAGbdLSdUPkkFlM7MISbkozwa/CMVl/PQprHorH4Y+aRYnmJ/3O0MAdXPf1fEiUHYLYjR9Nc/OsJ3mmhLOPaEkN9DxwRzyFR/c95C3RUjttXu/XIW/ph2WOTytuSd0XVz9GwJiLQDpqi+WpMLf8PK5uh8wXueIB0xyCSvoPbb1bXZBZvY2+yOWlGwWC45oro6NR/YL785enucxRzdkuhmZHtvL4rDPhwf0MAxikH6SrHLWUJM3jJJHe/6JwKu+/LfB2DNIrtha5iABus1O8CXi0SMcn5kQOi+nXAQa3q5C1AkS4XOctmaxoC2WrJaNU4i+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REGPJ0UNPsyvT3yuPN461JpuNmHrOBp9GSduCUHdoZQ=;
 b=ECtQ8FVh4XSr8iXicMA/+31lzOEUplCIh9wupSevn2DicnsfboexpicxtbVPPsM3ykIZ4UzuHGR0PcNI4lpG3KFkkb71U7Motq+xLtSyIqdMeDDpPKJMd5aygiGeDHfZpIghZ1IZGRxmMABqT/YKUd1Z/GCrSh0fdBQm2wFBSZc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU5PR08MB10801.eurprd08.prod.outlook.com (2603:10a6:10:526::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 16:49:09 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 16:49:09 +0000
Date:   Fri, 27 Oct 2023 17:48:55 +0100
From:   "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZTvp94vCTD6YzEfd@arm.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
 <ZTuj565SqIb9KjQr@arm.com>
 <b2ae41fd9a9f05269c7ffcd10565942acbab2c16.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2ae41fd9a9f05269c7ffcd10565942acbab2c16.camel@intel.com>
X-ClientProxiedBy: LO4P123CA0396.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::23) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DU5PR08MB10801:EE_|AM3PEPF0000A795:EE_|PAVPR08MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfe3d0c-4887-4567-62cd-08dbd70ca9b2
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WBlYqX6E74TM5ERqrDaInUrT2Nq2LNMdMoI43xdEcl/Y7Ye+7ObBNWGP5amA4Z1urMpHLhkdftNfeX6zAyyqxEC6C0Ubx2VsfNYvPNV90KXpu2ILcaBlbkap6f+j1GAMGiENM3xQeAfR2prXZaAC2ywGa3g1jWGeyf0qCw+QS5rJ474EVo+wHK1IJfbvB64zGuE15p8CkjUmPQg3xPV9EvIRf0UsEOJuq0+ca9wCAURTZa36Yxsckx4nuTTESCmcuaWLq3dDtj63re666s90wEQTFLAfofWlFXZ5JMOKKIFCFE6+I9K5tJhH0jaZAlmcGgBBScba96NqpdoLOhhvBgaR6fNibIAKhKgZLQ9aBfmKGMoWrK+Dib376CIOAeFR63LRg3he7RXDFMZueHguiLKG2NGDp+ubsTVzdc5YLZWkygHejLU8HYrb458JE+6eKDHhXsdQN3DENrnrsECpB0i1QHezIG6A9ZcbdFO17x4zVK47n8McbQYjhdC73iYmOABmoEs28u3ExFd4E+tLHxkLs/AyaB+V6dCB0bHx4iqr/AbkEPI9CH+J+Wd6HoMD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(41300700001)(38100700002)(6666004)(54906003)(66946007)(66476007)(110136005)(66556008)(2616005)(6512007)(316002)(6486002)(6506007)(83380400001)(86362001)(5660300002)(36756003)(4326008)(7416002)(478600001)(8676002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10801
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7ca05481-7c32-4f03-f309-08dbd70ca3f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WQIVg/HhqK7AjQ5caKiJ4ryHHa1WsiM4FjZhELmNOoDQtV/ardJQGHKPwGzGFLHTqCifCVjX2E4UsUcLYUbyvccxRnZyX/FJcF57VRws8IiDxzqv88a2cMVm3cImMnkZ+rxgQYnc+RqDT5WKFzetsE0stPMRwenUncpZWJNDyStX1QIWqRgoghNUtKTnTpnTkj31OiLBoH3xd/z665t/ezpEVNlEkFe++N60g5V+FRD6JCpTFViS3nr+frSNYyYAzPTuu2BhaLtWQwLQo6gLKslc+V14QPWNM+TwReWje2h9lLAPRHc3BH6lEyY804/i9hHLAYyDEkfrMWuPsYeQQuyohYtfR3q1YKdzDBhWMk8jnA/g82LzdR6MTQH1t9/cxXdDKD5uIE1nrpSq+jRtzc00Jbxvj2zsNhuLmogyZk7CSDKjTzcb1q8TdLZuJUheKsC6tsXOfAM3omVp31hfKOdDf0WbHWXOQvMryUpuE4VpwS5A7oJ7P6NmrtQdECAilJqwN6tRZZABTdFMcjUE/2VLQEKsI/3Ck/tZl2h5GxSFlQYeD8XbwjbjCRFgu2gyB8JfUS061Te7r9aEoZE6MxkUGQ8LuCmIpQo6uarP5L2uW8z8nVSOgRKaKSi0ZFY7Eu3rv6b5Kg1keKswxa8WSVEh+g4TQdS+XgnjjeKDCnVVDxh7x1crLuFKTJrtQb64p1LxlomQ6aYs0mSQLD7zrv8+FegJLT48jmUKJi+Ptrlkc890JM9pTUjPnk5RcHr
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(70586007)(36756003)(6512007)(478600001)(6666004)(336012)(2616005)(107886003)(26005)(8676002)(4326008)(8936002)(5660300002)(2906002)(41300700001)(6506007)(6486002)(110136005)(54906003)(316002)(450100002)(356005)(82740400003)(81166007)(86362001)(47076005)(83380400001)(36860700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:49:18.8426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfe3d0c-4887-4567-62cd-08dbd70ca9b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9625
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/27/2023 15:55, Edgecombe, Rick P wrote:
> Do you have any updated plans to share around your earlier ideas for
> token schemes that try to shoot for more compatibility or security?

not really.

i don't like that shadow stack overflow cannot be handled,
so we have to allocate huge shadow stacks to avoid overflow.

i had ideas how to handle overflow with sigaltstack, but it
is complicated (unwinding, longjmp, swapcontext,..) so
"allocate huge shadow stack" is currently our best design.

the compatibility issues i see:
- dlopen of incompatible lib (multi thread case)
- makecontext shadow stack leaks (userspace api issue)
- huge shadow stack runs into resource limits
- hand crafted stack switching code needs updates
- minor issues around sigaltstack + swapcontext

i don't have an alternate design that makes these go away.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
