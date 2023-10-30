Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D007DB920
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJ3LkT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 07:40:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8FB6;
        Mon, 30 Oct 2023 04:40:15 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=E7/y10YlhxXSpqoWuM64dN+P4vinrrbK+fDrwTwTk5O7/qik6i1E+4UNu0ycnAmOrF9xyCfR2h2fMbrvCmuRj2EnSmBO1jPnqywGB3AjYaVqSLPMBwAVH3OPigJHPpo0G4aLYIyjIAE0jhlZyySsRorEOpwd13LOWjwxOtFEyIAHzM+KY6FAbHvBfChgT/iHrM21pHnTUgjST/TZcqivRPIRJbi15cvH5ElqrNa3ro7i3dKi4URR5119wnV6ABgazRITE4zECJeuEqbQJI5M4LfAR9/Pz0qbjW3gDs3QA10YmnRGWXo7z6WlbTkDvqp9wuryHlb0Y5oPHz+LRbSP1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2PM/v4p6QCKf2M22j9tmCkBaTy+Rf9uvZkFqyrq2jk=;
 b=Cyl0YGLW7j3KKnkv6uM7P0/W6OkF2n+cEk3WGIoZRWZ7i2mpbu3HxwBVR3mvqtPgnGhJmVAw8Nd5uqynrVo+ngFD6nOgMxjKuX8oA/yMVudzzh7ef3OQULr5zJ0XIPTHhNPq89BuxAuVWTh32fAcibJM7dLIvEtQtyfB/6Etuf5upVDaLD6leiTc74QixiSShJ6l2oxba/7YYW0GCjUoVeYvlPBwULF80yjGSxvl8f7b4nq5jWtp41py6gJwtQXjosXaXAy5YSn2h9RHtQID2PTTkY/zKsSHYYDzGwiMRq1G2wqCgn/2+3CfN+wqJ5Kg9EtMwJqyQuP3I7e6SFT3AQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2PM/v4p6QCKf2M22j9tmCkBaTy+Rf9uvZkFqyrq2jk=;
 b=Qq14oXJ0vG7Z9puOkjtxO+u64RT393upOLmSNX/weSDPg57gVAjkZbK52EBVKwIrZk8/a9uQxilwglZuewjplxgaoC63ZHLp2+CSBthV8u6fUC3p3Fpu+HoeSr7975dOa68DaHYHlHU3wmq9FkGB9x9e/dRbzPVibuLQ5JfaZBo=
Received: from AM4PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:205:1::29)
 by AS2PR08MB9571.eurprd08.prod.outlook.com (2603:10a6:20b:609::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 11:39:48 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::7f) by AM4PR07CA0016.outlook.office365.com
 (2603:10a6:205:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Mon, 30 Oct 2023 11:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 11:39:48 +0000
Received: ("Tessian outbound 385ad2f98d71:v228"); Mon, 30 Oct 2023 11:39:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8a55392f2e01764d
X-CR-MTA-TID: 64aa7808
Received: from 964b6751b1b6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0B38B494-77AB-455C-9761-C37977C230D5.1;
        Mon, 30 Oct 2023 11:39:37 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 964b6751b1b6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 30 Oct 2023 11:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3mvyeQkRF6QCQK86QK/R/++HmtsHYCsL3oFbxtKt0akLRRZvR1y+zRDyl21EieJE0bYAwfroiqExHMPBQV+WT2mV00/6EyNjqsWG00XdJjhp+2Rby1tYHAkOp631Zrr/FG7W/LtbU0HQ+ZJn+5OnFrj+omqKvkDnAj6iYmqFPHud5NxF3lx2/z44UYF+hR2BmPTryLVlXQGWlR6w6pwMZrdwKEmAzj992ygnd2SlqvJq6L635s8CwlOwyBL3TvzmG4+vXGcmQmGkuJW/56cBdcin+rY9ItfmzsTVb2dlBsVW5FeFcEHh3xZ/B3yOg3p0/dM2uvzgCpQNujxYsKZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2PM/v4p6QCKf2M22j9tmCkBaTy+Rf9uvZkFqyrq2jk=;
 b=EKzvqIJAj9wQ+C+hQpayf74+T5DLLDeyfeqVCtMywZLuwg16GT0r0xFKnzs4Y1x/ogoZqysfymmrNLhlc4LRObsjSYtNb7tCfaaMqV2+y2SOkeoKfBn9+185qYj/hTZ4CKfCKm5N4C0/XjPjNnk2tHaKggqW1zMTnShzX+CQBbQCjkEBJ9FW7fPx0V3fjX5k58WOGOOZbWu2R2tEe2PssOb8Ebiyrs1ZjbQqE/EV9ApNK1ZM2/P+AckJCtLyjuqx/LSm8rKiKupV3kPayRxYvYdwCVf9d08fGUuaSc8A13n4krXzbiDw+SJMf/M4zcMUXtXuerlcuwFBg0X2GNXqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2PM/v4p6QCKf2M22j9tmCkBaTy+Rf9uvZkFqyrq2jk=;
 b=Qq14oXJ0vG7Z9puOkjtxO+u64RT393upOLmSNX/weSDPg57gVAjkZbK52EBVKwIrZk8/a9uQxilwglZuewjplxgaoC63ZHLp2+CSBthV8u6fUC3p3Fpu+HoeSr7975dOa68DaHYHlHU3wmq9FkGB9x9e/dRbzPVibuLQ5JfaZBo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GV1PR08MB7708.eurprd08.prod.outlook.com (2603:10a6:150:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 11:39:32 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::a991:ac53:e218:e554]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::a991:ac53:e218:e554%3]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 11:39:32 +0000
Date:   Mon, 30 Oct 2023 11:39:17 +0000
From:   "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>, nd@arm.com
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZT+V5VlXg/PsIfpM@arm.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
 <ZTuj565SqIb9KjQr@arm.com>
 <ZTxGovqKdhA5hYMz@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTxGovqKdhA5hYMz@debug.ba.rivosinc.com>
X-ClientProxiedBy: LO4P123CA0383.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::10) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GV1PR08MB7708:EE_|AM2PEPF0001C714:EE_|AS2PR08MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a6f3bc-d80e-4ec8-a58f-08dbd93cec27
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vse0kB4yFhg2Xbe+2Sp4mWIXbEsJ4uG9NpIaLAVGq3cU9t2jgfkkB/5gFEGuB7fFu3/+IuaF1ANtmF7n5LKVxI4KwUy2rntXyjwn7u9VcvkXmYdYxkA9PuY8ST416f8qeORRcE0VAaOlTU4HlZa9hQ0SS0DZxec5WwsaN4y/wivC8rVQEUiB31XEcpImFkzNcU9+j8w2DKjFtB7fb012AhvUadnUBmTHqm465XOlgzNYhMpywKBqoyTZpoO0l83U3hQcB+/KY3gaoxU5FMKjxpBOFG7rbGERi69TDAoo0lxt+Ks/HVbbVz2dH1VDx1rsA0OIRY0irbA3IC4gbrz3Q+YJtcJrFMPt4JXDdZQcIWKPcdv4o28l+k1IzbAi0VN3aXw4qzYpQ3Bau9pPErcjF3umlFzAeMPzTCN69C/X9vV8s8mLmlyOi5voZYS0nw3Xec5l4KTmSY0pOmln1vx+1Qm2Z3JYh3RGR+/6l3LJaVIkDvJ+7YiFzMg4KGtwjqKBHS2rZxOOgZlc7cEJdJq2xO5oVCuUJ3iReXryCXIw1aERiFBXCW7kNFlf9v/0t9PH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66556008)(66476007)(54906003)(6916009)(316002)(38100700002)(6666004)(6506007)(6512007)(6486002)(478600001)(2616005)(66946007)(26005)(5660300002)(41300700001)(2906002)(7416002)(8676002)(8936002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7708
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a1c4624-f69b-4485-2a72-08dbd93ce1cc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G73Rm3RgQpDOPh/BTIQfCvB8UVKWnVGs2Op4ikh8kjMpv7hU9f4Pu6c/BLRG9DD3GRUxsrXyfrDZtludliqKPJfmee4u9Cx1a/c/dP4pF5yAdrn1nJXobWkYHVj6BrLxT7Glkt59jrExKPevHIRbB89vP3qdNyCdtjx3zFccDnuVLuyXq5MeRxWXgCE7U1wa3GoxAAn8olZH50zUzikVqRWXPpyprOEc5pi2kztrPKENoXeHP9K1/aH2FZIc+TgT5q/sI6X7OrkYONZ4UtYNq1H5z/S8iUIzbTMyLIG00wMqWR0CXOUK21Rzz1fYTE7Ywv9YHJe/lrYOLJU5s+MMBlpH0poMUxcD+bcJPYOZoh9C86UIchdAxNgc0bdH5CATxSvmk471sDej4W8l2cIiuToNv1pBP92dUZBrX0j5NfkynJuGbSAkUrsBFE9lf9IFddQWf+xJtFnY6GxX645r7Q2UR23Bi9JdVCVBZai3Q+oSSK0wHiSisDUydOSsVDRXmaGpDUdvLjr82b0gdWfI8yEHZRKbhNwVqWJomKQRMXuoz65ccG0TpSiv+BadAD63+kdWiBVuWyZ3cHIDUrJ13dFl1KyzeaV1gNixe+XYslZ453hOmqGt3nR9I4hOwS7m905NcWX2OAd7CKJy+Bdc+7X+t/IufhpToPzgz70Y+8yaLepoPUq1XIgkyBFGVs2tJHDTauxQlXGHN7XT7VVN6KS97JPQTwrK3HRMKnR1YoNA4vpFp6wHvz71IAPRuo8
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(6512007)(26005)(40460700003)(36756003)(40480700001)(86362001)(82740400003)(81166007)(356005)(2616005)(336012)(5660300002)(2906002)(478600001)(6506007)(36860700001)(47076005)(6666004)(8936002)(450100002)(6862004)(8676002)(6486002)(316002)(4326008)(54906003)(70206006)(41300700001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 11:39:48.5249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a6f3bc-d80e-4ec8-a58f-08dbd93cec27
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9571
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/27/2023 16:24, Deepak Gupta wrote:
> On Fri, Oct 27, 2023 at 12:49:59PM +0100, Szabolcs.Nagy@arm.com wrote:
> > no. the lifetime is the issue: a stack in principle can outlive
> > a thread and resumed even after the original thread exited.
> > for that to work the shadow stack has to outlive the thread too.
> 
> I understand an application can pre-allocate a pool of stack and re-use
> them whenever it's spawning new threads using clone3 system call.
> 
> However, once a new thread has been spawned how can it resume?

a thread can getcontext then exit. later another thread
can setcontext and execute on the stack of the exited
thread and return to a previous stack frame there.

(unlikely to work on runtimes where tls or thread id is
exposed and thus may be cached on the stack. so not for
posix.. but e.g. a go runtime could do this)

> By resume I mean consume the callstack context from an earlier thread.
> Or you meant something else by `resume` here?
> 
> Can you give an example of such an application or runtime where a newly
> created thread consumes callstack context created by going away thread?

my claim was not that existing runtimes are doing this,
but that the linux interface contract allows this and
tieing the stack lifetime to the thread is a change of
contract.

> > (or the other way around: a stack can be freed before the thread
> > exits, if the thread pivots away from that stack.)
> 
> This is simply a thread saying that I am moving to a different stack.
> Again, interested in learning why would a thread do that. If I've to
> speculate on reasons, I could think of user runtime managing it's own
> pool of worker items (some people call them green threads) or current
> stack became too small.

switching stack is common, freeing the original stack may not be,
but there is nothing that prevents this and then the corresponding
shadow stack is clearly leaked if the kernel manages it. the amount
of leak is proportional to the number of live threads and the sum
of their original stack size which can be big.

but as i said i think this lifetime issue is minor compared
to other shadow stack issues, so it is ok if the shadow stack
is kernel managed.
