Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3106E28741D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgJHM1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:30 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:26784
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbgJHM1J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USOX/FM3rT1K5O82ng9+YAMFUsCPY3nE0quhBhzcao5pgBcOvtyjZak6GmKp4jgT3QFso3Q8kqbJCFCo4pt2KFtIGXHcQqCrZWeP5rxoSl9G0CQnTvb2kESCo15WiyjvAX6Ti2hK6QJrmdO5UcVROPad2FbS0nqov4NDeQJWf1c42vdLklYmVVGFTvg6VaLOflYtH7v+la20mQOayQviEXhaZXg0lwRAEt3e6EvX/bsR+K5yNO9M1cFGI2nXMPiACDWac/WcRff/UAfO38Ksz1t3rFnbDgC0ilMs+rY2UT7sC2I8i8SwXSjaukA6hIN+7iFidCzLi+UK5eqw5Vw/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypHvSsx2GCU4572+lphuc3QT/H03/2XRKwYtEq3vtQc=;
 b=QbZ50WzWi+14sSuLXeQ1Ug3DcSgA/2LCH1O+2UIZUCWeNj/ESAAsRnwg1LJrq6BqCsSgtplF1cFDeXuw38cdWb5FriydAlgjMkmZ/Bkjg5LV8D4lAlK1dVOfxrYWBbR0x32zuf++cHJsVjrcKqiTy4SMU/i2Z0eDCcX8CRKGBxYP14KzVPwOczsUM12UywjFtZ9o48+ZGcYRHsRLdfib49z6nBt3UwxqlAv6FRkYLRye9S9rIApVypUc/mUD/q3ZGLbZpPKwbZezDS5f1C2Wx+7CJojdofSme+sHtTacF51inC6Zc2VIQr+224oR0gmhJ4f1AsT1i/WuWBW8EDksbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypHvSsx2GCU4572+lphuc3QT/H03/2XRKwYtEq3vtQc=;
 b=nRhFEtOWk5+xoGDLzQshcTPgpsVRG58upg2ubHhGtvmUOVUjJteY9JHQNGyPr/GQTkZjV3xqIBMQZnsXKY2AcgcVgiFNAHAGTtbiFJPlfxcR3hC0DWL0OX0Rt5HEbsBmGPMM50/SgzOfOnkYQ665OML8IipK2fMCXA2pf001ywA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:52 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:52 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 07/13] selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
Date:   Thu,  8 Oct 2020 15:26:27 +0300
Message-Id: <20201008122633.687877-8-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [131.228.2.17]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b3d12c1-f8a5-4ddc-ddfa-08d86b856fbe
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB23474DC91A8CF1039245E85FB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM4yoFuZH9i7bAvW//W699697kvXr9aDhittUoZP/vat+Y+V/8XrCzy6qscYWRnK+P+FrraPP/LqaD67uAeMYhpFt4HXKgoPjCGzJ9QswNN7IbsCAs8fbVfi0Izu611/dqwT4LNbIy4A4wJ4hnyz/L3PJn9gdTgkkmmkYo5eMkUfdJ8JHhfCgaf8CajYLY2bdonlQ61e8wpmiccJqwtnPJRbPmcfO1uPBO3yVvawLX7Begv2Gp5C9h0txhdRZQVUL8S5t5vD2LFYOoGEWpZHP74Y2kOJURbJa5f4OZBL0ZuwgYB+14oBAvyUsj1/H9Olg1lBcm9gB6mOK5oMOZFpeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(4744005)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uc0mlNQz+cuRG7CLCxCrBkej3JmuloQ5jHGACBt7FTOGfkYPwHGKrarBiNnT6ifJRnzx7iVR02qIin/MwaCQs6AobSUy17DiLyAv1mnd8KA8SPu0VsE/cr+loVwpiEXAOjzIVqQIt9MdT/fdSLFwQB/s7TTWuytOaXFLvcpqTSnozLCpl3cJjuqd98vbmAKK5mNHCMOGhR+KaShEUEcV8yfXbYhAf5iM94970EOhwutJskGshDLZs2uE7/Jf2ToKJgtttpiWQMf2f/RdzSdfX812+j+LmzMazN+6gALgDokLToSrAeTsDUaULAZ+VbiUyPL6iXnPbi+wZ1jSoGhplVoq5exo7sY2NR7mTGyKgq6rtfYTj2xb4xk5jm5ykWxKPY9c3KHD90CRsx9HGrco1XolASsmtYctcBAaApBOCAOb+ccPf1DrIeHJ8w0hcXkD7N/ufNBmKqc9JIcGsmrfCrXaV9KnwY0N7azddGo6XATU9JMyZROdZ+K+LMYy2XGzJhs2JGq1MZtLv5y/OMm4QCKQQXcXwbXX6Or+WkXour3hInDasmrcUVX3PS7En+qlA2HFKK07gwqTfeyyoMLQTWxpYMvkqZGtZ8s7rjYbIdV66c2kAOJZDv97GVOm/D5wF3c4Kd7b79csjPso+dBVlA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3d12c1-f8a5-4ddc-ddfa-08d86b856fbe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:52.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjoQYAiZ6k7guD/S2dHGyjEE2n8Y+N+BuUtmkXGqzWKbeesfifjdyQ2u9BnqdnHx1VEB5S+lmPgxZbYy4fn+n3orClNb2V5lhB9lbuDpxjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kcmp syscall is used in pidfd_getfd_test.c, so add
CONFIG_CHECKPOINT_RESTORE=y to config to ensure kcmp is available.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/pidfd/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/pidfd/config
index bb11de90c0c9..f6f2965e17af 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -4,3 +4,4 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_CGROUPS=y
+CONFIG_CHECKPOINT_RESTORE=y
-- 
2.26.2

