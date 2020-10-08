Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2528740C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgJHM07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:26:59 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:26784
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729905AbgJHM06 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsrmBylTypfevSD/NbDERe+RRq4HRWj/eNSvf1wLckXRfiWoUOqN6sEoOKhIrHUwmjOE43K5Vy64TZ4hxanY0c/EZOz2O21nIXBU+tjd09faQqew2itID7fZhnqBQjPDr8NIPZ3atsWgYHBkW7zc8I3T0lyJcauGpUdQcQfykxS4paHcssJIWcinrSXK5oimDB6roL6zgQwMmQN59uy5fYUFYFjqZ9oOuzBXAYfBiJ8AFE8EiIp4Zm00q+a/r5wn18QT8MwfdVYO0XVrxJ3+Gx4yaVOske4faK9Ta3nTXNEbQ6kBcSif9jI+ZaAvtY4diOOZom82TgTzKtK2g6jGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Ij4JZQTP+SMyeW7V2X8gYK0jZLbhhSdeJ8HwMThQA=;
 b=cgCEiUrAYalYXeyZScW58vcStkc0LMLXs6Pvc4y1KvQ4rpsTDnLRKv6RRVfd0dZUJdW9oATf/AzWHmCl0t98m6qA+pxzhmiobaerQa5QqRhrLtVTEgnfBRX6W0iYK71OkOJSwe5JoT0A0QPXhjyCNmOxU4w8tOlnABzd0e8JdGnmmcHevPS9RlwfIOtzuHIUAHQQDmf45MvCAmcm3HhFiU4/oRRAVanuwQDptWzpYee64zgbT5PeDjUMsmmb6TLhcVYS3AbwZ+MFvfpYxziwoJd87md9hMFMGDn6mzVo158e5Tk7vtRqzBOpCQJ7n5QbhQfPapwWh3waywHO/dRgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Ij4JZQTP+SMyeW7V2X8gYK0jZLbhhSdeJ8HwMThQA=;
 b=t0kYL3VjarCQR73sJEEsYbWvF+Q0BsvPmjfnHB/YIR3UFBN/cQpoDsMbABPGw3tFNl+7GA+yvVyxHCGezBYPu7cFeO63x+LJxabb+TTGqLjrsdHo3lEvGzK9abNBKUWkqMxcUApEfKAQStVPjnjMsTsURw8P2ZvowLJ7y2gXdUM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:49 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:49 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 03/13] selftests: add vmaccess to .gitignore
Date:   Thu,  8 Oct 2020 15:26:23 +0300
Message-Id: <20201008122633.687877-4-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ec58bb0-20bc-45c3-27ba-08d86b856dd9
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347F189A04D2D380872FD8AB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdzxWMbCtMCxUNnPnK/96QKXdiz3igfn6KS6fjtb9h3NZKO+grKaj875WIp5CfPxsxkWpd+kYWz/I48agG/en3uDWBw5jrtWVpBQLaq+X1VFVZc1V36BacJ177JjKwjISOFoBcRSgfDPo7j/UkFtSib3v/4kpLmmy2MHYaBPnVP8n/pTMULcOQvrN68JLIdgZvINFq8qEHsyAUhFixKCWcNWb+gsJmeK0bU5iiFIvpvbfbUuuunMPU483hhpXKcNwLkbyghRGeA/KPxLCyO5AOuoi5QXDwtNNtTmSIaJn324NdA3v7c31FvP65cs5Q254BLXKw+2KBzlFQGBYi4Dw3Be7hBP9wsvAzczBusLpvcGwGQiaNGlAIhj5GAORU6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(4744005)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fkOBcmo9hnHE77+7n29/fQhZZJyTQXv+lLCtQ7Fi9VThms7FAefp0ADX8lLxVebAdyTHzsq7MonzOkGA6t4pEFC/50H7O9zoYHxwa6yvKX6LYZSeUjxe+WZwMRjNw9/rRWVzEmWPBgn9RL98faN27ET+duCmNh5TDVgEfgVkHpXoouHb8CrBKB7BkeEGh/OK/HI4SU394O3rwhsUYbzjZgVjjn2eO1x2rEt0HpaP4UBDrr5bfWP56RY1TlS3tt8DYHxCNdpXfZavgNXMso4fD1eGqS7bwmfsVf0RHSmR1uwSMR44rc7sQ/rOEkRcgK6m10aoEgBqpwCrA1NyAZ+MJipuXCKu32VZMdFfmwSrHABsysYPOIZxuajffr3G7YDIJCyxgZNwSyVZ3AtWG7NJ+HMmstWah92co2QOjuPcDlb0dpZulpycL+UbKH/8Ufz+l6LXSL/JcghiBadPz7GyN7AQbxuSkmvCtCzrVy8TpTOf4G3YrKOpggfYt581wk7qAxLGIHoUtgP1fnmKjWfvNyeIyLLu+vsZTHL9eWEzNCKjBP1nwHqnZXwqtC++L0v+jRe+v82VIRmovU8cPwxnZKeOWGbp0qY/ny9T2LyIDBPV2voSTzOZv6d1QboxONyTPxfBgi4ZVyhlWtYsZDfv5A==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec58bb0-20bc-45c3-27ba-08d86b856dd9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:49.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JYp/QfW8IkPyNIA3IZiHl1bjpDr8GxK1UWdEGzklIsSq6vIwi786BxeFeqfrgpwiWbux/Mm0KV/w0Fg4gJVmA17lwvA8+a4FXQQIvzi2vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
added vmaccess testcase, add the binary to .gitignore

Fixes: 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/ptrace/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 7bebf9534a86..792318aaa30c 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
 peeksiginfo
+vmaccess
-- 
2.26.2

