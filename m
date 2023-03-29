Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620126CF1BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC2SIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjC2SIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:06 -0400
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41AD4229
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
Received: by mail-ed1-x564.google.com with SMTP id t10so66640702edd.12
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP7fzXbhXSN7Ty9wbiAQl7kbA4rMdsvSYTII18zPk8s=;
        b=ATX9XU+HBGGxsEECzUbAvUJoaUp7fq2m3zz/b//YJQdB8nYjBPfmBGsBIZy1VWA69C
         HOtLiGMDFXtrp251BUC8uuI+jqfbkWpuxkWx5tJXdgaKHq+0vY+RTekviWenFhZzOEmT
         Ue0TkmuDkXwGCwu3JHikcDTFc0InRXv47WCKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP7fzXbhXSN7Ty9wbiAQl7kbA4rMdsvSYTII18zPk8s=;
        b=YDZEU1D91ThfR7UsZMIjah1gwRVxZkGnmNyrwz5QaaXI4fIYCAXR4yhMK8d9+wkn2G
         +qFNk2lMXC/RzCV6NgZ2QWg4ryM0Cz2VveYTVZHZ5OVLYGs28+oC9gRK/df8XMOw0hDp
         vjzt/bVgBnDOy8KZIQIgv65y1HmytpflOJOBMpWWf2yT3e/T9wH9lyV9E6Yjn7u8OgAa
         F6UW3NNj4GHBclU1aLnpsI2Y/re6Ava2lsBqFRrBxOw2yjnUR3n90rXrVRKsBDegoFmP
         mcgGUL/8c/ycnjAy397T4GxmigMidXYBAdtSOItndE1F6vH7497Gb/0EJ5iN43DsZ9zU
         cG+Q==
X-Gm-Message-State: AAQBX9dnYS+NpeT7yLo69hSBjjRBxwIcksCVgl8SmS3EuVQZqSdZaAlp
        8O34P7lpwahZ9t8kT0B7FudJAiEpTfQZBFnc1flIh+tX570l
X-Google-Smtp-Source: AKy350YvWlz1e2WjuGCn/zBJU22CORmNL2L0daOgmAIK1LGoOSmFs9rLKhk0fTclz8aZ+4FYU54u7vUoR8BQ
X-Received: by 2002:a17:907:d386:b0:87b:dac0:b23b with SMTP id vh6-20020a170907d38600b0087bdac0b23bmr22156821ejc.55.1680113283167;
        Wed, 29 Mar 2023 11:08:03 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:03 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 01/10] selftests: xsk: Add xskxceiver.h dependency to Makefile
Date:   Wed, 29 Mar 2023 20:04:53 +0200
Message-Id: <20230329180502.1884307-2-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329180502.1884307-1-kal.conley@dectris.com>
References: <20230329180502.1884307-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

xskxceiver depends on xskxceiver.h so tell make about it.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4a8ef118fd9d..223be997f15d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -612,7 +612,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xskxceiver: xskxceiver.c $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+$(OUTPUT)/xskxceiver: xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-- 
2.39.2

