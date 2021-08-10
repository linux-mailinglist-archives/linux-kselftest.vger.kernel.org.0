Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901D3E58F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhHJLVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhHJLVa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 07:21:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FDEC0613D3;
        Tue, 10 Aug 2021 04:21:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l24so15091202qtj.4;
        Tue, 10 Aug 2021 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BEkKNIfF5NMAPc4pKcTWNJLBpM+Ct7HuPUjxUSEGO4M=;
        b=EyOiaIoc8MYJ8LO49gXt+3AWGIF+XF7UBjw3UVqIPXRnIBheH3t9LIX3YuDwQzai34
         KjX8v2H3s9KKsc6OzPaQbNQy7EjeQfIB9xTA67/3F5z9x4jVrbqa9lmIxlf4PPo0kQbB
         uRVv9VDwLl/sD73IH5DsVJir+DzuAK5whH0adfk+jnomwecwPZtryYwL0M00YJGjKrG8
         nB4+cYC+2eUEAlKEYnOgLbB6a+atSYh3827LBTet4Gwg9RR6rtX/tjStGnCgW/A20av3
         wNN4GXJExfu/46YDJqn+Tzk8EHao9xOgzE2BCQd8+DFNK5THXw5WaNRRRKp6W51dbts8
         f9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BEkKNIfF5NMAPc4pKcTWNJLBpM+Ct7HuPUjxUSEGO4M=;
        b=GlxB7/8FmeWUpK+GI4QdRpdldJLFQzr0bQuDW9HMOJn9mPiH3LMC4WaJbR/8NRSA0m
         SaW10gl27JlLcn/uXwMab9YhzOFero7XvFzS0KXCQ869IC+A8vM1ctylhchvOrHJJnyZ
         TTdKkqlbnXl0N3ppatocnGh3T92XY9vjfS7BXSXzjJsRdEcWOnGFxGVsLeiC6xISikrO
         gnV3hJKVu3xRHZou0cYM0HVNNymlrOsxUzLfGLMLUZq299NEiUS8Mi/Da40zVFpIoXNk
         iClPFEMR3q51odIxQ00f0tpSZBNrfSofTtmonMgeYSe6NZjr+rKuw2QW3MKZvJLwrfqH
         0O4Q==
X-Gm-Message-State: AOAM5305b0BvHsp4YAF5WrpfFxPstfYcBUgXyqPBm/lHvB5SY2blN+7K
        Unrb48iVpEtFFLTaAKcj64k=
X-Google-Smtp-Source: ABdhPJwV9xDaR1sNxVXMaHLYlK/6LDYyOYjr1EC2k54UDiSBPVSZLdBeSnMqAAtCrOgg2WoyZmvtMw==
X-Received: by 2002:ac8:5e11:: with SMTP id h17mr24783204qtx.213.1628594468213;
        Tue, 10 Aug 2021 04:21:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id f24sm2134438qtp.1.2021.08.10.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 04:21:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] selftests/damon/debugfs_attrs: Add missing execute permission
Date:   Tue, 10 Aug 2021 11:20:50 +0000
Message-Id: <20210810112050.22225-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806004226.47nyd%akpm@linux-foundation.org>
References: <20210806004226.47nyd%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 04edafbc0c07 ("mm/damon: add user space selftests") of
linux-mm[1] gives no execute permission to 'debugfs_attrs.sh' file.
This results in a DAMON selftest failure as below:

    $ make -C tools/testing/selftests/damon run_tests
    make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
    TAP version 13
    1..1
    # selftests: damon: debugfs_attrs.sh
    # Warning: file debugfs_attrs.sh is not executable, correct this.
    not ok 1 selftests: damon: debugfs_attrs.sh
    make: Leaving directory '/home/sjpark/linux/tools/testing/selftests/damon'

To solve the problem, this commit adds the execute permission for
'debugfs_attrs.sh' file.

[1] https://github.com/hnaz/linux-mm/commit/04edafbc0c07

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
old mode 100644
new mode 100755
-- 
2.17.1

