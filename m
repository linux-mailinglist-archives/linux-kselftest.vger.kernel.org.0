Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40A287417
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgJHM1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:20 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:26784
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729961AbgJHM1Q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfn3DyCmi/r7/36jeTCC/OipGbas3dmfUDWta8RtsU1NJ++Pz4Kjqs/w6Y0XgIxZixV3wnvfZQbpEBWvOLu3oGYPhbKj/7ofAx7eGg/pQPIA8A9k2HqFTeeIanEC9rx+U+44Q+4IkcA7D0slyqbID+HTnu4tBWbVdpngfttoSF7WwDqirMM/Pl0QDfq/QrKvyNw985pc1WU3H47ZTNFYlX4fD5LQSeFxhl+OK1Jus66dgifjGJ2EerTLpp8yH4YbOKp5yt3Dif0WLVwpjsJgPoaNLlvZoKQ/I3vJTER6ZFVAxpQ08bgiTIqY9EHKdM+reTkjEXqKDi6AZifdo4Gt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWEzzSLgew6kygfuOSXNyd6+o37SD8oVguO6NM9KeeM=;
 b=TLlZMpihE2kCv5v7jwNJlIFI07mE7s4mOn8Vrlw54tdR1bqvOTE+EDvoX90NoTGshrdvDv8D7KQYBta3gnrC8QSc3Dc2qi9T2Y49I+hfPAZCM2HDXIiBaJyO0mUmYh4X4lbNdVTH+QY4Q/H6N3fxmPHhQVf93RpTUcEEf53CakujHsRyNaWVrGzctORCA73z6ZVbY0doFcbxh7K0sDmLgcrpSVFAaLK8nzTeUJDmyfO5KZgLAON7c00xIxoNLH41oPCi0+raHrleaq2P4Kzk3RuLvXAXBwauFKz8NM6BQKCkB+mQrwLLxFFjCW59ic88cNNx2i0pADEzUjHs9OcWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWEzzSLgew6kygfuOSXNyd6+o37SD8oVguO6NM9KeeM=;
 b=usEjmF6equllb3Lszv6aJkBVoCH4e86lOsFCB9cNjk4MCR0VGe0nOaE3xT9SEYKnf04Zd/pHQDb1O+pCICT7IfjlFVxCpjSn+kbTfWQjYemMDbtCUzE+j91iRlkg/1d291kf7EVEtoHKoWPYCUTWwptLN8HJF8eq5Maxe3z7E78=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:56 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:56 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 09/13] selftests: android: fix multiple definition of sock_name
Date:   Thu,  8 Oct 2020 15:26:29 +0300
Message-Id: <20201008122633.687877-10-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e14ee1d-3422-4fcf-4058-08d86b8571f5
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB23470E020DDC6DE0B36D6E7CB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IVV1VDK/ICGq/0jBSR87Cc0YotB8Y1zxwBZ7m6wtq/NnXvF/yV21YfqGsfcYTLId6FThGrsczyPQUO0gjRRvWPbnep4a13gt2gUVNTOjWmpU3zjUKjVs8G+x9Pg093TUqJ5dI+UZzODuhaq5nzOd7rbmD7HovPiVX91Ku+gdZe8LTZVzZe+zFUYt4x/OyKwPfGBAdTP2v6H0TLXxvA7+I8H0oGN7OcxJ93Vlxq8yLZHatknSrG4FUEu9EwO6rCd8UbXrAZQ6vpQmTh72l8tSpCGDftue6lLxTJ8Pqxu+sPTFQYZnAT9FuzasBPOX8Mw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(107886003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aqV91e0XTBTkH1TOQwwf65qKXy0m1wmxliYBlZ0AB+zrfmt9OrzlBTY4NW5tRoypAGU/Svit38uRzHPBHgaP/Duh+0ZLglCbE9tLPXZYjOTqtT+DYksXRIlqwkKeYgT2o2qmQMizo6rOgzqHf2yGww2z3Jr8wcB4OADxr6BB3jmxlhL4a7DGLJXUt0sZdjeXmd02gDWX4ffLXhS1hbFuzuWpUDPAaPJdyA03NGuIr6+C5ni+8JmM331LlVIiayJKV57yNPyOSPxQn4APrrWW7pM9991zrIiWUS5KsByNiqd20mHZtyiDT3D+9u+m71y86KNEodUVKqlxo6luklVeEYjzKx/o7dCvEvm8OAc/u8qTFy0z/Hp/7x52ms3wXwzl2snYqhyra11G1kphz3jpJ4Pca5Wn1MWLSBY1eX2SYX8fUZ1K5J0ilTjvUlvogd4VnSt6mLScVPWuBCD6aLep9vo3Dl1Ss9iLwAu4Q6Jcl5+hc1/LTDqRFV9gL8bqpXcmMbrOBqi9Vmi/Ml3a6mXOawGc3l6bHLIIlotj1KkqUxX2pxxXd0svh5zwtT3DCC07b/oIbVMJQV8DNeb9uoKJAgbL0QY8ABs+ypqd+PHV9tMxUXk/IdIBofhVPJv9eiVrOytaaOVcaUHPrfjyZSx6Pg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e14ee1d-3422-4fcf-4058-08d86b8571f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:56.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e4ZuWHFRoLjpb2VekPBQhIUJ5JCFsPJKydMC3zdktPkLI0s1JbQpW59yTajhPPSz4mkvKlvuJvLa70MbLjs/uDC92Dpd30kkWNcgACz90o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix multiple definition of sock_name compilation error:

  tools/testing/selftests/android/ion/ipcsocket.h:8: multiple definition of `sock_name'

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/android/ion/ipcsocket.c | 1 +
 tools/testing/selftests/android/ion/ipcsocket.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ipcsocket.c b/tools/testing/selftests/android/ion/ipcsocket.c
index 7dc521002095..67ec69410d2e 100644
--- a/tools/testing/selftests/android/ion/ipcsocket.c
+++ b/tools/testing/selftests/android/ion/ipcsocket.c
@@ -10,6 +10,7 @@
 
 #include "ipcsocket.h"
 
+static char sock_name[MAX_SOCK_NAME_LEN];
 
 int opensocket(int *sockfd, const char *name, int connecttype)
 {
diff --git a/tools/testing/selftests/android/ion/ipcsocket.h b/tools/testing/selftests/android/ion/ipcsocket.h
index b3e84498a8a1..ec5efb23e7b0 100644
--- a/tools/testing/selftests/android/ion/ipcsocket.h
+++ b/tools/testing/selftests/android/ion/ipcsocket.h
@@ -5,8 +5,6 @@
 
 #define MAX_SOCK_NAME_LEN	64
 
-char sock_name[MAX_SOCK_NAME_LEN];
-
 /* This structure is responsible for holding the IPC data
  * data: hold the buffer fd
  * len: just the length of 32-bit integer fd
-- 
2.26.2

