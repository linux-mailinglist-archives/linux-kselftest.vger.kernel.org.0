Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE06D9797
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjDFNDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjDFNCq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 09:02:46 -0400
Received: from mail-wr1-x463.google.com (mail-wr1-x463.google.com [IPv6:2a00:1450:4864:20::463])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8029033
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 06:02:39 -0700 (PDT)
Received: by mail-wr1-x463.google.com with SMTP id l12so39423095wrm.10
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680786158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OurEHAluO0z0/iX0xySpGmAc9WM9TpIWEufWnTv6GLE=;
        b=nINqXF48TmWh8tUDIa9jsFNlnAshXBVNu6+nFuoPBC32YqKpMNMC7ls2YFFOmEkaXw
         akdcSOvhOtuymRuQc30aqFrkB1YVDbPeN1cGn36igFJrYri9D1652SMD15zhKPzJtfl8
         Vj5+fz1doXqLs4MeJpGtXLSdll14RWHnGYOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OurEHAluO0z0/iX0xySpGmAc9WM9TpIWEufWnTv6GLE=;
        b=pmH1qmH5W41Bb9FM3cQwv+x1gj4X6UNe96TLmBh1E5iNQotNZ/u/Qk8dEYSAUXowqE
         gJMNkiq6N+JO4f/1rOSM3r5VQtbnOLYOBuwJjG4BosvJD+Ztna6XZItVKUj2xYPjlQ1U
         n3BO9ijuA/+t5J+GGL+Aq7v4NAZjgj2cTkmgUMVo5NN658M6nd7oHwNUTMCLRnaoKk3m
         8K1438SmUGAbkls69IGr55jp3vSmevOTBH6cvbhqKnGOZ8HYT3O/VGtmiyORtM50camc
         7r8tZ9fStglzot+B73xmJoLvzI1/PwaDUCmnIoU6FA0Bkb0MhdRQneYr+XocD0/m4MVz
         FM+Q==
X-Gm-Message-State: AAQBX9eaOFsC3sccZ+GbruAdRsIzWeYEt1OdMRIWsVg0Hp+r54Xt+FtR
        1wvo1azWmLfqVFLvt9HtsiW+IxA+TBe5G9BJYap1aB20Kd+3
X-Google-Smtp-Source: AKy350amCx/ZHN/ecGGK/EGkFHzUbsahyywUB+wgapgCN80VOuOIxFCr8iRxuHuNXV6z4WWbWZU0PIJfcs6h
X-Received: by 2002:adf:cd82:0:b0:2d8:908c:8fa0 with SMTP id q2-20020adfcd82000000b002d8908c8fa0mr7080509wrj.9.1680786157994;
        Thu, 06 Apr 2023 06:02:37 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id s3-20020adfeb03000000b002e62dd5b3d6sm65625wrn.3.2023.04.06.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:02:37 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests: xsk: Add tests for 8K and 9K frame sizes
Date:   Thu,  6 Apr 2023 15:02:05 +0200
Message-Id: <20230406130205.49996-4-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406130205.49996-1-kal.conley@dectris.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
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

Add tests:
- RUN_TO_COMPLETION_8K_FRAME_SIZE: frame_size=8192 (aligned)
- UNALIGNED_9K_FRAME_SIZE: frame_size=9000 (unaligned)

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7eccf57a0ccc..86797de7fc50 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1841,6 +1841,17 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
 		testapp_validate_traffic(test);
 		break;
+	case TEST_TYPE_RUN_TO_COMPLETION_8K_FRAME:
+		if (!hugepages_present(test->ifobj_tx)) {
+			ksft_test_result_skip("No 2M huge pages present.\n");
+			return;
+		}
+		test_spec_set_name(test, "RUN_TO_COMPLETION_8K_FRAME_SIZE");
+		test->ifobj_tx->umem->frame_size = 8192;
+		test->ifobj_rx->umem->frame_size = 8192;
+		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
+		testapp_validate_traffic(test);
+		break;
 	case TEST_TYPE_RX_POLL:
 		test->ifobj_rx->use_poll = true;
 		test_spec_set_name(test, "POLL_RX");
@@ -1904,6 +1915,20 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		if (!testapp_unaligned(test))
 			return;
 		break;
+	case TEST_TYPE_UNALIGNED_9K_FRAME:
+		if (!hugepages_present(test->ifobj_tx)) {
+			ksft_test_result_skip("No 2M huge pages present.\n");
+			return;
+		}
+		test_spec_set_name(test, "UNALIGNED_9K_FRAME_SIZE");
+		test->ifobj_tx->umem->frame_size = 9000;
+		test->ifobj_rx->umem->frame_size = 9000;
+		test->ifobj_tx->umem->unaligned_mode = true;
+		test->ifobj_rx->umem->unaligned_mode = true;
+		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
+		test->ifobj_rx->pkt_stream->use_addr_for_fill = true;
+		testapp_validate_traffic(test);
+		break;
 	case TEST_TYPE_HEADROOM:
 		testapp_headroom(test);
 		break;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 919327807a4e..7f52f737f5e9 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -69,12 +69,14 @@ enum test_mode {
 enum test_type {
 	TEST_TYPE_RUN_TO_COMPLETION,
 	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
+	TEST_TYPE_RUN_TO_COMPLETION_8K_FRAME,
 	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
 	TEST_TYPE_RX_POLL,
 	TEST_TYPE_TX_POLL,
 	TEST_TYPE_POLL_RXQ_TMOUT,
 	TEST_TYPE_POLL_TXQ_TMOUT,
 	TEST_TYPE_UNALIGNED,
+	TEST_TYPE_UNALIGNED_9K_FRAME,
 	TEST_TYPE_ALIGNED_INV_DESC,
 	TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME,
 	TEST_TYPE_UNALIGNED_INV_DESC,
-- 
2.39.2

