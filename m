Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7BC781B68
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjHTAJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHTAJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00D17DDC2;
        Sat, 19 Aug 2023 12:50:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so19445695e9.2;
        Sat, 19 Aug 2023 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692474621; x=1693079421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSB6bHkjwrLrFphZRXjaDm3kSiCaocff/7800VaCd8Q=;
        b=gxUCaWSEn7y8qaC48/Ir3tNWSAROgPfUfqvIKkyE+gRVYZPhjJ03GFaN+8tnraN79e
         215Yp1dgiehqEmpGGHGLDCCF4SDEwTUC/z7HLOhqLD5zrsNj/7LmI/7ma4NblW/opOqg
         bQFVrmpiGSmPbZ2Yg5boXNgBv8m4wT+bVWuJxsHz+UIKd9LGyb8pPUvqxx5qco3gv6Wv
         n6HJtAo55rpgB+aCczFTOiZFEvKDbrcwOFP538A4l/z/0wTDZZib2RxZhOX1UDGGUmz4
         5L54+7N/YAfeV7+rfPelZlkEAV8A/rsDlOmoiH+oQI4x8PHykbo9JIWuT9PO/jpJz2WJ
         +vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692474621; x=1693079421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSB6bHkjwrLrFphZRXjaDm3kSiCaocff/7800VaCd8Q=;
        b=ByVdfBkFb1V/b7ojVxLHNdEhCsgRdoWJ5hs+ksmTyIPbMoloJQN+go4HpaUvhxMQ+z
         JoriyaGJcmtGKKkRQwCZe4zJozDJ9iD9xaV1iP67sHRsmert7u55tHkpRd9+bq/ibvXm
         nsBWVn5QDGiF+gQ4/7KPuQfv8s0hiqKdQKG0kghhT9xq+KmnZS5BFN0b3Pw5o9TSZYUu
         pidUR3pIZK46ZpzGlWP5lpkhTA/EAlmBH2bQRdw1zahevARujz7SM/JLAuLK5cOZhaTB
         pHpN12mkjId/AO7QkgoUUOqewmu7nz+i32N/wiHTNGdKZlpBdxKAAw8q6jDOIBS1DgZF
         IRDA==
X-Gm-Message-State: AOJu0YyG8tJB2BXTeRIUecpCfnCUzN6Dia1Zk0SnL/smGb0goOEV2dd8
        viUMVah8Ngfa6lwEHoiPx/4WI8RMIpx5LIe3
X-Google-Smtp-Source: AGHT+IHahhec10BYrPqz/QP1HfNcaB3/uicy40ATMZ7BLndPcptrIvIFgo8k7y6MTcL3w2uqTpqEmA==
X-Received: by 2002:a1c:6a16:0:b0:3fa:98c3:7dbd with SMTP id f22-20020a1c6a16000000b003fa98c37dbdmr1935691wmc.41.1692474620596;
        Sat, 19 Aug 2023 12:50:20 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([5.194.84.172])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003fe26bf65e7sm6861382wme.13.2023.08.19.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 12:50:20 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH 0/2] selftests: Introduce common min()/max() and apply them in net tests
Date:   Sat, 19 Aug 2023 23:50:03 +0400
Message-Id: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The first patch introduces a common definition of 
the min() and max() macros for use in multiple files under selftests. 
This avoids the redundancy of having scattered local definitions 
and prepares the groundwork for other files to simply include kselftest.h.

The second patch then applies these new macros in the selftests/net files, 
replacing the ternary operations. This directly addresses several 
coccicheck warnings, making the code cleaner and more maintainable

Mahmoud Maatuq (2):
  selftests: Provide local define of min() and max()
  selftests/net: replace ternary operator with min()/max()

 tools/testing/selftests/kselftest.h           | 7 +++++++
 tools/testing/selftests/net/Makefile          | 2 ++
 tools/testing/selftests/net/so_txtime.c       | 7 ++++---
 tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
 4 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.34.1

