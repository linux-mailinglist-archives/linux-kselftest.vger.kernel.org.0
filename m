Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC428740E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgJHM1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:07 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729906AbgJHM1B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq3Cg47IxlBVKPGY3rOM7kQl/kuZr68/fOzYdBGspp04/2eYvll/klSfezJYQ/dQvSoSz/nhzDTpOIcQADUip37AtHskk4y8ei0qkDcfWFKGqoAmnFzWhgr6lIaDZGR40NY6RyM7DrO0JmgOftV8wviUcFgA7nBGOOAt1CGlbK+ARBev6uXZkeEadFSMoBpX4Czza6CBbzxJPuSRMTstJ9TtmhY+vvJvDtkAIa5QXfzJjknxV80mTjda++KohdHdnbj/FmZWYlDZect/G8R42qkiHrIWlw44tblml2PmoPxmDRZSo0G9K/urJ9wWSlmMGCx/YGHlGg6nbF8kteXYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhTeGiiJ4MI7ZtW0ASf3HiLt+cVMes7N34HUFqBKQ+s=;
 b=cWJl8z7il9FFev+inGMgxiMWL6tk7tZ3MX4TZh+QWZGwgCRA6i9F4flMRb/EXl+WH7gJjWpYr/CJxAEUbJzB04G6TKiSgDtsGI/HNv+J6W63F6NQXzCI13nOLWwxFT7sBUMCPyT0jR5DqWF03FEoGmqPGe+nShW124Ho4ngKGJMb2WBLC7PVtA4fZyLF8RsWbK9PZrLafH9uOzD+hojEKrdC2tmoXeyYmN9aSJtb7C1lDKSpw9yTy27Jcib25MeJsEULzv015zVuF76jafG/7X4fehZHZ5eLg7cK+yVw37wMj0YOZBNM7k8BFdZdSHH3DHVrbYeKpAoxNz1gHieiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhTeGiiJ4MI7ZtW0ASf3HiLt+cVMes7N34HUFqBKQ+s=;
 b=FAudHZ32ppCGqQ3JSKAyBE7HGUQ8uf0Hh4PCjxz9UU16dBxuKvRYp5tdZS+v+V6gTlZObS7Emk2I3LJ2jq/OamRsucL8zwUPpq+CSb+qMfXUmP40bxH9MfdVQaZyriIsJK4F3F6PNiYzisWFRuhXjAtWy7WU/jGnyGQwIWgfc+U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:50 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:50 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH 04/13] selftests/harness: prettify SKIP message whitespace again
Date:   Thu,  8 Oct 2020 15:26:24 +0300
Message-Id: <20201008122633.687877-5-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bded2a68-4517-4b8d-93db-08d86b856e57
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347F228741F8C18214BC394B40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ks9ekCxHcBlsN5SST3Z9pYZR2g9oiTzJmNh+LEwt0rykv8TbJVkYdxVrl12qOhV7GH5DfWxYzOITwQwTeRBZmx0S1CToT8NC4GV619NX0nUeDV4Y5f2iFXXabAaZsme0liOJYehXx6IAh35vt+P2p8Q7hgQLwXLUgl8NgQSRiU/pOu3oxGwS+swTHQvV8wkBQkRt2kse1MK+XZGmWyiCe+QrsCtbjFJXDmOr05s08uATjfL/QKAIutdH+dCZVFUQDVEkMjQmnwK6uWOfhkPF657PFW3EPTXuE0I9fEVIk+3IupCs50IiAnwToGhvIJPzkJyp36DpQo6KumpsJ3VqqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(4744005)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: w3Zi2OJNWs1cj29+n8/TkJazihF8ljLX8Gjnyp2NpWPKvm12wNV2+hBkNC+O6NJxa3wI5+xortQSRSjjrdCDufoQWnFr7cJpbFxPa3WrGxUURHpd7OfHy+PPt1XqL0fgGHsdk5gPhy2PusAZ1DUCGBSpyY1uHUCQqzTHE1mZ4LWU3OUE6LxCDGdqKlpwvYW35dAflbFT3cJeV94uatu1NePmyisRPB4mQvt2DVkD1FfG3nEzXT8/xiVILYc8KYBPEFPJd0gRjIF1/5wjYuRI5JF+3p8p9kxwLbrVnnag/aFhtu/V1hhwWlflg7h8/ptW2ZAGcj1U+tltIcUxaf59xbcCAVWFuJjEBzEWxB+RYw/rJSg2qyy2em+82nR0RDQhjTF4CrdtYMOvhI6R6Yw0O8E5VUZrW3HhDpEtTMQnTPC9c/HVPoYMTnTlwHNMLb3mXEVpZlqu672vBoQKj73nchcEZgHXqu+YpEpNgXpcl40sDXqzZAktaoHnStLkD/C97DVXNiu96scq2v33bzsbhSveueh27hsg9+fgu1fWSaY0WqPCzecYylNBOZgIkKV3P+AAOdl6dfMjuE3rd4zeYaBGaiUwC9X6+Nz+L7hY/Fa/RzucZBf0fFf1GlhaGkieYYGxtFrCn9BkiD8EHNeeoQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bded2a68-4517-4b8d-93db-08d86b856e57
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:50.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NCGMmeQpU30MILKgC7JLmJVMmIWAHr8PxYGy0qUPTzZtMsQ2Uxoqqe/5sm6yWgq0gsavjXXZ2zUzI8PmYkERgCdiIo7h4KaIrYRqr6KcKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
replaced XFAIL with SKIP in the output. Add one more space to make the
output aligned and pretty again.

Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4f78e4805633..d8f44f4bdb3f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -126,7 +126,7 @@
 	snprintf(_metadata->results->reason, \
 		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "#      SKIP     %s\n", \
+		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
 	_metadata->passed = 1; \
-- 
2.26.2

