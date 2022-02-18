Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958784BAE1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBRALM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 19:11:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiBRALM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 19:11:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1F58391
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v207-20020a627ad8000000b004e0bb852117so727301pfc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4GwV0UbQb705sFLySkVzCAThIA3EfMwCC5LKqatKq2w=;
        b=X6XZEVMjv2lZXcUUO2jKjlrunDXYs7/HCQObdkmNlLSbyef+zYZW1mXbwVKDh1JlrC
         H11/DRRbdoeRaU08uihVlIO54agTGWuSI24fdNkaoC7ZW/508RzzgplyJWRCETQ6f72i
         S2fTLXNiWewqtlA8QViPjXFxBIV7UQy+DcdW0RCHm8h+gTnQy1b/ytnYsncTcCx41m/0
         S6xy4XB4oFtjCAYPXeSolZ9MyvHEKN8ajH6/5hhBr6M/K9QjMBi+gKWmgkSN/9w5ps/+
         nwmCkzGFFn6GlSs9nliH/bVbAUkxJcFYtOVTg+jn66YLmxdQRC8cvtmFK1iJ1/bGDtQn
         MtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4GwV0UbQb705sFLySkVzCAThIA3EfMwCC5LKqatKq2w=;
        b=YKkfONvNpIRRb8NdiMkKlLouZWO9VQirc6sfa4hMnW1qjj78wH71Rfj2BSN+ElScOC
         WH7e1eWSmEksgu3Y3p5rR3S56fTisDQlrnQNMNp8ZAFKyDSx+uyz6AKWFPvm1tT2KQg6
         WGQ3VOs8VndYBLt3G76mxOxo3i/Rop5b2dnNVkFSB8Qn6zH1hKtlLmXKKBagVyzVnuT3
         cHQ0mwQtnsQFBGlIGTTHk5KEXmqok+QEL6UF7vKQDlIkhw8xpARjfmZgj4oZp6tHeX2P
         vzQVpdw4LiFD5+czePkKoHNVCEoWQVXxT/R9BuL13uTlgijVR523DcWlAWZyVKcY0A5i
         Ec2Q==
X-Gm-Message-State: AOAM5310jRs2fTSO3UPIyYANGMoaen26cvc7Vl1m1MvsspwiQ/lOanCs
        fsFpM6cM5TUiAapeaBBg9f0Z4slMqnWJ
X-Google-Smtp-Source: ABdhPJwQP5bHgoOzpFp3TTtpGU/LXL4rOWNuhpg9rKWtCDjat6Uh/iKyoXSWAuOJoZxV9sgnw0uJkIKAZySB
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP id
 a15-20020a17090aa50f00b001b8e6adf63cmr199719pjq.1.1645143047006; Thu, 17 Feb
 2022 16:10:47 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:10:17 +0000
In-Reply-To: <20220218001017.3500673-1-yuanchu@google.com>
Message-Id: <20220218001017.3500673-3-yuanchu@google.com>
Mime-Version: 1.0
References: <20220218001017.3500673-1-yuanchu@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 2/2] selftests/damon: make selftests executable
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The damon selftests do not have the executable bit on. We fix that by
setting the x bits on the .sh files similar to other existing shell
selftests.

Fixes: 9ab3b0c8ef62 ("selftests/damon: split test cases")
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/damon/debugfs_attrs.sh                 | 0
 tools/testing/selftests/damon/debugfs_empty_targets.sh         | 0
 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh | 0
 tools/testing/selftests/damon/debugfs_schemes.sh               | 0
 tools/testing/selftests/damon/debugfs_target_ids.sh            | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
old mode 100644
new mode 100755
-- 
2.35.1.265.g69c8d7142f-goog

