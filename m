Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDA682D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjAaNFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAaNFw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75030113F3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:05:38 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C0E541AD2
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170337;
        bh=cknCzfC+eidNxevjQ90DRMfzc86MKFXSFIXJJkqDiTE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=j72PpgS8KHiXfMa4PgmXXj6wg3GXgwgWM0KnksLebD0b7uTajB+GD+YbvMyQU01Vg
         /igt5AcSrvLqKk3otcpnI0e92lr4TMyKgKMWzOU6ddKvFzAEFFdF0hoQEDEGKqu4yF
         FsrdiiuCDkZ1cCSF//t+hMdIdGIyJBwOSmKQ2vaVwEilsdoPHpePWf7hdqgjmu/C7J
         LR0UUJRCzEi8jFA/XcAu4vnkfgsItGbNT4m+B6IFF40/55zPOgsGYhZiL4B9o41dXo
         LAjO+G4ZSlCw7VxLZGnCsKDWq7PiBEIoipFcL2aoHwaDzDeirWLTPOBDt4AP7J/7Ya
         Sx25bxoBkzm8Q==
Received: by mail-wm1-f72.google.com with SMTP id bg25-20020a05600c3c9900b003da1f6a7b2dso11273144wmb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cknCzfC+eidNxevjQ90DRMfzc86MKFXSFIXJJkqDiTE=;
        b=vvgVKCRNBrmA7mDGvjn07mDaPxiAR7S2fIUDjIitRl/atZKnxfngosEic2RyA4gEaE
         doCaLIJ5LCRYfmw5hNbD4vl0lDeOn0YbMLwSrzjNf4rYt9GYbo6mAhow630Yo9r8iYUe
         MZ1mJanRybbHO0XbYQO7WeWqMTUnjYu1O855CuHluaBoup1Vkc+wIyuGvLkmDVon6XJt
         kHgkfj+/coU3Z+CDRrjttfFO4gAKpGLYujr+Swwj6Az2GXOFmTh3y/ZVaDw/UgdPg+qG
         rEB0boCLJ9j8ySIABxvkZG3dHKCbx4GLLtXQ3mAdFV0PfJ98xLtxmJZ95RnaTcwZ3U9q
         ux6g==
X-Gm-Message-State: AO0yUKVuLj/wIaNJI0DKrKclqXrXpjpyXeJK615JU44Y8+Q1fiNOsaH8
        8ujsHYYDtt9yJhmuDQchyT77OxcsoBqXUu+WncQgb/Z7tzQaKOtjv5416xNsAyxVAaL1FWpv/VZ
        jktmqHcZi8P1UqJom8gP38wmo0FseyguCL1GuezkeaIcfXg==
X-Received: by 2002:a05:6000:69b:b0:2bf:df72:fdfa with SMTP id bo27-20020a056000069b00b002bfdf72fdfamr3214604wrb.40.1675170336517;
        Tue, 31 Jan 2023 05:05:36 -0800 (PST)
X-Google-Smtp-Source: AK7set84uQ9tAkQa/KFTfyH55HgVWiAi7a90Odkg3hQqGTzB5NUa4s4qv0fVF09UC1ty6PxizysYdg==
X-Received: by 2002:a05:6000:69b:b0:2bf:df72:fdfa with SMTP id bo27-20020a056000069b00b002bfdf72fdfamr3214581wrb.40.1675170336238;
        Tue, 31 Jan 2023 05:05:36 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] selftests: net: udpgso_bench_rx/tx: Stop when wrong CLI args are provided
Date:   Tue, 31 Jan 2023 13:04:10 +0000
Message-Id: <20230131130412.432549-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130412.432549-1-andrei.gherzan@canonical.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Leaving unrecognized arguments buried in the output, can easily hide a
CLI/script typo. Avoid this by exiting when wrong arguments are provided to
the udpgso_bench test programs.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 ++
 tools/testing/selftests/net/udpgso_bench_tx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index d0895bd1933f..4058c7451e70 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -336,6 +336,8 @@ static void parse_opts(int argc, char **argv)
 			cfg_verify = true;
 			cfg_read_all = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index f1fdaa270291..b47b5c32039f 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -490,6 +490,8 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
-- 
2.34.1

