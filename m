Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757E6D4406
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjDCMDu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjDCMDs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 08:03:48 -0400
Received: from mail-ed1-x561.google.com (mail-ed1-x561.google.com [IPv6:2a00:1450:4864:20::561])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2810C6
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 05:03:42 -0700 (PDT)
Received: by mail-ed1-x561.google.com with SMTP id h8so116364384ede.8
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680523420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEhFH3i/UwokEBWEnFizsJMKXzUUnazCcIuMHjSUIWg=;
        b=JRKD7i5ofEBBBwN1rr9ZJ4rltMmLTN5+N90B72SQpxTxcUzm5QYxPCLA8g5znY3GDM
         X/Ftqt2CtQcAGU7lczGyi2Ueo2UdoH7SPD+WaYDJqT/2qcWuPtLhvc+rONta0VIjNaiY
         gYQC4Nvfx/gORPLjADX6rboXcSQlg0YcJeQRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680523420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEhFH3i/UwokEBWEnFizsJMKXzUUnazCcIuMHjSUIWg=;
        b=h1I5Af32zFVlLUeWriajCJybMvwjLqqcHxO45irqtZ56OHecDQftSgFRXcl34xFnI6
         gK/WC+UUMWUcL1th8rcz8uF1Vgu4E2NdN+LcGTmXXmbGg7FzUl/rfm9z2DYrTCd0TpYS
         ulpGd1cBOr1lvHRKoU0eUO9jj9H/BG69KzDPnca0+y5dQ+vgysDLErzRf1Yc+tQ5Ss3M
         kqgnNvcwohaFeFOg+ELYp/hWtgek6XGF++QTXwUK0TChnB2I5FA9CjS9NZo/JcWCnLym
         9KGQEidJz3k069YeSSeyNczqKQgFVgo2DpWRbS3xoOshjl8u4VLeOSGtqPO3PS4Iknr7
         z1IQ==
X-Gm-Message-State: AAQBX9df2q8y+Yci4ED5u33tWz4VOYyD0h0cSEcY3g7VUDbIhY3ZJPXb
        k48+QteEgCLODEbdWjy/sQTQJfOXS4nzFk1KHp9e0T+ijRHF
X-Google-Smtp-Source: AKy350aC1Z27TBWahgyLAlPNFOQN0NGQ3GkcUo5C3SCWAMWPZr8GlCYzTmvwNXxNefVb8BmPmUJNxXXz/OAa
X-Received: by 2002:a17:906:9f19:b0:93c:847d:a456 with SMTP id fy25-20020a1709069f1900b0093c847da456mr39125962ejc.22.1680523420485;
        Mon, 03 Apr 2023 05:03:40 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id bn13-20020a170906c0cd00b009307ed403b0sm3213731ejb.176.2023.04.03.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:03:40 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf] selftests: xsk: Add xskxceiver.h dependency to Makefile
Date:   Mon,  3 Apr 2023 14:03:18 +0200
Message-Id: <20230403120318.30992-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
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
index b677dcd0b77a..b55d828911d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -607,7 +607,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xskxceiver: xskxceiver.c $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+$(OUTPUT)/xskxceiver: xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-- 
2.39.2

