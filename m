Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF752E3406
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Dec 2020 05:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL1Efw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Dec 2020 23:35:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58303 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgL1Efw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Dec 2020 23:35:52 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1ktkFR-0005R1-Px
        for linux-kselftest@vger.kernel.org; Mon, 28 Dec 2020 04:35:09 +0000
Received: by mail-pg1-f199.google.com with SMTP id m23so7387015pgl.6
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Dec 2020 20:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xDaj2aGFc8Ryio1B37xmDRbgZ25x8BPX+LqRqApW28A=;
        b=CCClfLHvKjuXVUT+AoIol05G8C5kXMmBUYVI92ONO22iq0RdbvpKbT2OyjbYaVqAmG
         4AluSEmjeUgZuvhx9HlmuvA0wIYhiyFLkbyOmgcYsUUgVNG3uzzk0sek5V6kx/woWieN
         cMWK3jt9rRnuDvy5jztVt5BGwQoTD4pq4RDpsr4sns5tiCoM1YgARkJgcqdRBWxKqdij
         82hLOts8Ns33MNiAtpRWEEJdEmKi2g7QlTYjOQ7bl0rssJ/gI34U22BqwxAh3CdMbxU7
         Ry3le7EasRNczsEiSjUEkdQZXfnxTu0NF6VIbYx6eHVIH5Q8epzd+lL6xAQxDkyHeMBB
         02iA==
X-Gm-Message-State: AOAM531pBfMQy0yXo1DjByNDg1+twMmyNfdBX7/p3W1KDCdbIk4k7jpP
        LhvCkFTQVZzg2vxvdbgUk9HxjcNBs6DA3Pwt7nhy1sWSfLwK3WtIbYS0NdjP+wOz6VU89hXJZnB
        bJ9TXo2Fyjx7M2MSgxt6qiDAogu6nehH0YKD7qV3nQASj
X-Received: by 2002:a05:6a00:8c7:b029:19d:afa5:34e5 with SMTP id s7-20020a056a0008c7b029019dafa534e5mr39739017pfu.30.1609130108308;
        Sun, 27 Dec 2020 20:35:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAvOE6o0cTX5MNAozIzz9VZuWmqcjEVnhGxLPmH3qElG3qiwVdIXI/yBMtB9j5uKel2nyJxA==
X-Received: by 2002:a05:6a00:8c7:b029:19d:afa5:34e5 with SMTP id s7-20020a056a0008c7b029019dafa534e5mr39739005pfu.30.1609130107999;
        Sun, 27 Dec 2020 20:35:07 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-38.HINET-IP.hinet.net. [61.220.137.38])
        by smtp.gmail.com with ESMTPSA id a1sm34567962pfo.56.2020.12.27.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 20:35:07 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     po-hsu.lin@canonical.com, shuah@kernel.org, paulus@samba.org,
        benh@kernel.crashing.org, oohall@gmail.com, mpe@ellerman.id.au
Subject: [PATCH] selftests/powerpc: make the test check in eeh-basic.sh posix compliant
Date:   Mon, 28 Dec 2020 12:34:59 +0800
Message-Id: <20201228043459.14281-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The == operand is a bash extension, thus this will fail on Ubuntu with

As the /bin/sh on Ubuntu is pointed to DASH.

Use -eq to fix this posix compatibility issue.

Fixes: 996f9e0f93f162 ("selftests/powerpc: Fix eeh-basic.sh exit codes")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/eeh/eeh-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/eeh/eeh-basic.sh b/tools/testing/selftests/powerpc/eeh/eeh-basic.sh
index 0d783e1..64779f0 100755
--- a/tools/testing/selftests/powerpc/eeh/eeh-basic.sh
+++ b/tools/testing/selftests/powerpc/eeh/eeh-basic.sh
@@ -86,5 +86,5 @@ echo "$failed devices failed to recover ($dev_count tested)"
 lspci | diff -u $pre_lspci -
 rm -f $pre_lspci
 
-test "$failed" == 0
+test "$failed" -eq 0
 exit $?
-- 
2.7.4

