Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB46287406
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgJHM0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:26:48 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729756AbgJHM0s (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC7czX0A/yEbfmd/u36sWrpJCAbywdvF0zIFjklYyvKDbcAtxs56lTSaUiEmtCyFdzHxaUOuHhDjhg9KInydfsPGcQkOKbb9UByQyomUciw64DGOTfYtkKuDkgy/SmCPlV2ciBERkcxPBFCfx39gbMtuSvTnsjrYIFRyPDrJ/vKCzbIm+6dzXJMiczAfQuJrVlRqwRVLWKpZ+2Rd5LT/BykFyaHs7UiOAyDq0YieFjLZCk8uec5ttmFd+6RDu1w0fKnXRx2y5wj2NQxkQUv5hNR7N2B07SfKVZOlETQaMYXMPBJakFEq6nfk3cs+zg0dqtABHqyfFhJeNLj2HX2+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBVARjCtKyW6zRgxDzqdF5102dQg2Mnh06GT4y5bjjk=;
 b=nh1iLbxiZ8tJZWXCyEZTWHJU1vuv7lAJbBKITjnde8TX7ludJMeZE106ZEL5vEZel0oDSvndnRSeCW4TxdI/oJ7quNSooxV8i4rZx9LhTRQPyZMlOeCip3Ce9fIP0S5hjlc9YW1Eadwt1UCEpJwA3wyUzYpRCWXJGZu6ZbQVjtZZpv9TaaUQ/SGaiQ7UAUJ3yEmpleE/dbUHcENZj5V1E+5DkKEQppwF1pYnrfcWbzj4gLu0QaEE/VN6bVfG5Sx77j2jkpimW0T1pNBcK26aF3BHRFF/2Vkwv7l47YFiXiPKqxV2E8rT8a6bd1QJG/Fohpaxt8cJHT+h+iq0BQ4kcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBVARjCtKyW6zRgxDzqdF5102dQg2Mnh06GT4y5bjjk=;
 b=J8/JlEvBCMws5h3WyrIJagWkmxJXumNXiv1Hv1yEfg8rvkPrkX99rf1YGPgHLIU7Nw8naV1N6ZLu0G/q78+k6ghxBwiTi77C1faD13EkyAYNZiZSYF6jsHCUDyL35EMh/MZUVjn8AQn9VfjXgRtQvFBKRtBxYBbkUylMkPN8PMU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:44 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:44 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 00/13] selftests fixes
Date:   Thu,  8 Oct 2020 15:26:20 +0300
Message-Id: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.2.17]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 598650b5-25cd-45e1-fa87-08d86b856adc
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347A295BDC8516304B7DD06B40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q92wHAZHDyo8Jl/lWL8nT1ni7dHdIy7h84Qnun8HeK/yI0BJCmm7vX+AtUfOK02E4r1BGdevJo2KQLb8k2Ym+rw+YrNxqybrJwExWeKnUTxfBkAjt1vvz1bcHGS1BfQjZNSAk1Bp83JV8N2HpsPSOYYiEPQxMXIBPYSveuVJP2lap+INTNt65ildueFdOFmgbvytBR8hj0JkSh3s2jRnrK70jLx7gQp6XdJfZMsxN3/PXbltUqMD97yfz85dIe2becwUEw2DKmLC/ru2f+Sj7l27Mo0BMcrh4Qp0bEOkcfC5+9L6ApAVAtA0rFlwRZ5mzp2nWrlliUDU+JSv6nk4uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2SAF23qb+KcqiTIC/pv5QTxtLqOAqGnKvLF+3GZQPr4i7riYqKTi3UsbQxNl5MF17auG8toDwni2tTwTyQlDlGrQHQBzj6js0ILceUXVmga9emyOFDy6ABYWOr/tNrF9np2W7n16RrLg0mrU4fNKRT8A9QM/byMtIlqaDNvWPn131f/wmx/7cqxMYMzJgIzbXQI9O+JTu2PME727V19yll2j7h5GmKMbUUCqVj8/lx+9hP9FoU7mUvX6fXs9R4cbSpFxgeaEAG26349RIyvqka/eaY1qY9UF7OtbpjqPNUr6FC8DXIcgDT4f1X9MlxuOZi0R9fOrqN+T4LYsZFWqcC6gS2mqOebrxVD9VkMZ/34ZIAsS1HRHSMDwP8WR2aomfBOXSuN16rOwJt9yW/13qQXGR1NXnrPbxu4tJvKYpOzRvqRjquPvG1CcFz4w43MPGkHrc9g0wE053YF75YxV8gaYgjQSgi1Vs98FXaFZkR75IqrdsKk9YxWC6JF7EtcXL7r2HpNEsVS7qoOi3wE2c20h6zZcc+x25/wvytIZOukGXFIksKWTkDgjWamU3o1K3/OYshrjDrddhqQ7v6dgD4vd2TJvHNSlMNOI+NlxA7Wp9Qq4Xk4cGDMrLp/aSSVTRxY81/KdgUolwesr1FEHMA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598650b5-25cd-45e1-fa87-08d86b856adc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:44.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jeOUYvxxNFgT3MtB8mqBg0n54lJUu3GNtxuMkktyuz+zHrN1lKg4ZH9ESMBWwTYPqQgPwvBE0sAPJRWOxfNZr5LrrBW5E77vR/R+f5DIxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, small fixes to issues I hit with selftests.

Tommi Rantala (13):
  selftests: filter kselftest headers from command in lib.mk
  selftests: pidfd: fix compilation errors due to wait.h
  selftests: add vmaccess to .gitignore
  selftests/harness: prettify SKIP message whitespace again
  selftests: pidfd: use ksft_test_result_skip() when skipping test
  selftests: pidfd: skip test on kcmp() ENOSYS
  selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
  selftests: pidfd: drop needless linux/kcmp.h inclusion in
    pidfd_setns_test.c
  selftests: android: fix multiple definition of sock_name
  selftests: proc: fix warning: _GNU_SOURCE redefined
  selftests: core: use SKIP instead of XFAIL in close_range_test.c
  selftests: clone3: use SKIP instead of XFAIL
  selftests: binderfs: use SKIP instead of XFAIL

 tools/testing/selftests/android/ion/ipcsocket.c           | 1 +
 tools/testing/selftests/android/ion/ipcsocket.h           | 2 --
 .../selftests/clone3/clone3_cap_checkpoint_restore.c      | 2 +-
 tools/testing/selftests/core/close_range_test.c           | 8 ++++----
 .../selftests/filesystems/binderfs/binderfs_test.c        | 8 ++++----
 tools/testing/selftests/kselftest_harness.h               | 2 +-
 tools/testing/selftests/lib.mk                            | 2 +-
 tools/testing/selftests/pidfd/config                      | 1 +
 tools/testing/selftests/pidfd/pidfd_getfd_test.c          | 5 ++++-
 tools/testing/selftests/pidfd/pidfd_open_test.c           | 1 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c           | 1 -
 tools/testing/selftests/pidfd/pidfd_setns_test.c          | 1 -
 tools/testing/selftests/pidfd/pidfd_test.c                | 2 +-
 tools/testing/selftests/proc/proc-loadavg-001.c           | 1 -
 tools/testing/selftests/proc/proc-self-syscall.c          | 1 -
 tools/testing/selftests/proc/proc-uptime-002.c            | 1 -
 tools/testing/selftests/ptrace/.gitignore                 | 1 +
 17 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.26.2

