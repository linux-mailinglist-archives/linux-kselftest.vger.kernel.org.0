Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45545287408
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgJHM0y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:26:54 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729788AbgJHM0y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl33SjlAxXADF4f+Vk68tLJ2WFfafd69dsfcEwz18yR9m2+upCtGVbM5OVZJpMF09duYzERGPvhv+wLWYStC+1wufZzGm5KRNUReXI/EQXHWK8mNGkkO5hgsqdINucjhGxZAiHgn9QqGZTrbCC6OmCHwCsnV14SCMBjWmiRBbbYrCQrF/Oe9dIbLUeST052bUdCysGMXVDIOmeKZ+wTX05hlgBPpWSlAg7RNARua1d2u3sn4soKfN/GKR1UKIFnnC6+gC1IQOwemc7NtHIwil6wGg4zcYyIfjdAepbpM+3Px1GgsgxwKd6+gMjIu91Tg+c2DhJJP+HxCOHC1DtxAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKp60xQyditJ7GN8HPw5GGIuPPNNXNLTH4LaUBsuNJg=;
 b=j+/eem1b0NLx1wGMLBog3yYHu/rU7SiFzA6AlQuUPectlHz9tfmsXDNZZqZc9ELvLlWqNIiE6nnb+kCsz2wpVWa/NYzlXa/gLfd5r74Z+iRSfRH0AcCZdIKSEte+7FOnb+MTHR9QqVG8QCNBYPmEZ0mp/iBtlma67/H5DcEiDpq3t0XEqWKLeuAs9cQ4e4pAPLo000Pg0cuF2tWVKrZ4RYYGjD58JgTrnPGn+Z1wV/Nj7oWPaKwe5lEqf6B0Sbgf3ViW4wnaf4vj3DgNtCA62hWKrG0tlWwIpzkBHoVGGwgIjgZ9Unv5iI6lawWHFMve6i6OXCNpcMWyY1VO6OBcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKp60xQyditJ7GN8HPw5GGIuPPNNXNLTH4LaUBsuNJg=;
 b=UGq0M7OSrGJ4xkf2GrzO+EJZP0nKzW0SqUH5qlW72Bmym6GhCsOem12Q65VnGBwSRR08hT7S0ll3q4nm2YSMKFfZNvKZbrDCXFFk4TSmWYToGWRMf3oEmh1uJvVuBMJLoHPnyv5ftiJpWxupyjVprNs8LUJgzHKThumKOwaPya0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:46 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:46 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 01/13] selftests: filter kselftest headers from command in lib.mk
Date:   Thu,  8 Oct 2020 15:26:21 +0300
Message-Id: <20201008122633.687877-2-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.2.17]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 412874ad-c140-449d-e02c-08d86b856c4d
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347BA28248CE4EC777B5970B40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUxC7E7yuRXEPkvKl/bZyPhWQ8rTz0RYH5z2TtZpRN6xIw9itZaRZN7K8+z9ijbCi9kQOm2vOsFjzE8dEV+eqzCPNjiN8uBFPNDJWPRanpF+u/dKQSwvp55Z5cArrWPllXE3QnqbHH4rznzsWIwxaklLM/W9i/n3OoM9lWdWASnmS6L3pf29BR1ITeWWkXUV00kq1vP0rikpcHEaQHxRytouqIFHyTq8wrn9PUfVWsz7GUe2SiPqSQUSotDeKt8UQeE2fFyYmkEDd+lF8C3LNteaL2XB2PvOHlqF2HCPjp9O7Tv5KsHHT1c4+YYoRd5TuymDeY/DoCgAPYqqYRNTbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cmHGNn+CsFoxLLYkUj7Q95nRcBMNN7QeKUj79shQuhJ2WGEI10hOuMxQGF5nHCGqQRR6qDD6lw8w9EqykPUv9g3ERd7iQ33hJvQGVM3kHQGmCPnqvWeAcSNl4X8/Yt+xKLz5a+PRagwHpysugCf/+w+XgEX40QqLISV03Qu71bcwdEEYomTuayJ2ZeJmESh8GZ/bC0zbXvb2EbzEri2cmCe3yHGZSlOrl0pib3gKw/ftMnnFk1gd6lYOgCOmQoa3FW2h5VbUL65P5rhUNWd7oLgI31wlUCZO1UfBt2WxcWqHXQnx0+8Rqpi4zivDaEqHQV0bOu6zqE3slIMTI+e5aiEgQ8Ru/Yt1lwf9vukU3rErfF/OSvekkLKMRBRg1uLWI6PxgAFceBudvTliEev/x/SgEmONbU/EDgYlm86nPxCSci350bb5bxBeR7haz6INT3Y935heuPtg1MYacnSKe+a250+9ISaprJazL3/uxrEoNOdstF8cOSNEMII1r7eJdyrhbq47iCJS7sLtmcau6mZ/fIbBw/O64Up351rgfkMuy32ifGEOL2e+/VDXSKDfupl6dJflstHkvNM+6ZojK6+Inuwo+MIPKOQAMB/+IER1fzuJcmtBBzlCiLsjVGMw+cOVF7IXJKthEOVicxDIug==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412874ad-c140-449d-e02c-08d86b856c4d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:46.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQMGwD9kRPtnQs8hWLkKyUMGGxxf2vjWJEmnfyzdKwCW4+yzJoOZqUT+FD7pVJMUcGtxjZShSgSILjOT6D3EJ5saFjhXCHMw0F/XxM+6+cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 1056d3d2c97e ("selftests: enforce local header dependency in
lib.mk") added header dependency to the rule, but as the rule uses $^,
the headers are added to the compiler command line.

This can cause unexpected precompiled header files being generated when
compilation fails:

  $ echo { >> openat2_test.c

  $ make
  gcc -Wall -O2 -g -fsanitize=address -fsanitize=undefined  openat2_test.c
    tools/testing/selftests/kselftest_harness.h tools/testing/selftests/kselftest.h helpers.c
    -o tools/testing/selftests/openat2/openat2_test
  openat2_test.c:313:1: error: expected identifier or ‘(’ before ‘{’ token
    313 | {
        | ^
  make: *** [../lib.mk:140: tools/testing/selftests/openat2/openat2_test] Error 1

  $ file openat2_test*
  openat2_test:   GCC precompiled header (version 014) for C
  openat2_test.c: C source, ASCII text

Fix it by filtering out the headers, so that we'll only pass the actual
*.c files in the compiler command line.

Fixes: 1056d3d2c97e ("selftests: enforce local header dependency in lib.mk")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7a17ea815736..66f3317dc365 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -137,7 +137,7 @@ endif
 ifeq ($(OVERRIDE_TARGETS),)
 LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
-	$(LINK.c) $^ $(LDLIBS) -o $@
+	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(COMPILE.S) $^ -o $@
-- 
2.26.2

