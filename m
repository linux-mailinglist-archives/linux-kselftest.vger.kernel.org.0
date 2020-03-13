Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4DC18521F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCMXM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:12:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37880 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgCMXM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:12:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so5019505pga.4
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2JbZxMCwj9yygU/wyDgBKZMbpIm9EC3h34COxFARqI=;
        b=Kkqs3BLuKJ3D6MBEWIMmzbsZsRKqE7w7T7wwPjwk3xFWEUOjqvHR025GoCMbDW6eM1
         eQMYGMtHgnODYRLvpte18+iNvz69QZDX1ciukmpF8PyPxs1AemNi7GFWwpb1JtmuRQfa
         iBZLZqY/+f9z51hptUJUq7aPJKBZi1dRothXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2JbZxMCwj9yygU/wyDgBKZMbpIm9EC3h34COxFARqI=;
        b=PE+DeY6Q/OOswuxcZZfIlCQ6SgU7IXetrS/L7zl8/JpfkJGPW1n95YxV7sVFq2DGTZ
         9miMBELAwk2FKtYVZHjtm3aymO6OlWS3dbwZ+LXMvbzO1pFujtWnwuV2xyjpZLDz1Lgi
         gB90YrqIZlLsaBf1JVbuOpbhcu+4j6mJZEfgZ6X2ei2+ODDNV1DbWkqj53Nt+UNy29ft
         fmo4+gTFkCZG9tYiWLvo9fQKOCISRz2xzQAHZwycPpHFq1o1MWrQNA4UxhGBJLnmExp2
         zDvEQqKT62vAhE8zFDHyPIRjH1sbDjbXtVkJAObPqKzVez0j911UDF7H9L9NulGFN/SQ
         nLBQ==
X-Gm-Message-State: ANhLgQ0FxvJNMxwpUffnqoMFWdtj8M7RqL7wiHVALz3EPNl77bOTHPLq
        /jk8/E02FzQxPq2HX0CJMvOpD+ehx78=
X-Google-Smtp-Source: ADFU+vsOPRsmmYcwqJ4TRGhHMQesl1WVSQjt29N6D6DzjeWdpqjtSPwAhRNDk2n87LF8Vzp21Y10dQ==
X-Received: by 2002:a62:e409:: with SMTP id r9mr11685548pfh.119.1584141177491;
        Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i4sm1422000pfq.82.2020.03.13.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] selftests/harness: Handle timeouts cleanly
Date:   Fri, 13 Mar 2020 16:12:50 -0700
Message-Id: <20200313231252.64999-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Repeating patch 2/2's commit log:

When a selftest would timeout before, the program would just fall over
and no accounting of failures would be reported (i.e. it would result in
an incomplete TAP report). Instead, add an explicit SIGALRM handler to
cleanly catch and report the timeout.

Before:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	Alarm clock

After:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	timeout.too_long: Test terminated by timeout
	[     FAIL ] timeout.too_long
	[==========] 1 / 2 tests passed.
	[  FAILED  ]


Thanks!

-Kees

v2:
- fix typo in subject prefix
v1: https://lore.kernel.org/lkml/20200311211733.21211-1-keescook@chromium.org

Kees Cook (2):
  selftests/harness: Move test child waiting logic
  selftests/harness: Handle timeouts cleanly

 tools/testing/selftests/kselftest_harness.h | 144 ++++++++++++++------
 1 file changed, 99 insertions(+), 45 deletions(-)

-- 
2.20.1

