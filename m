Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF56CF1E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjC2SI4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjC2SIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:24 -0400
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534536A4F
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:12 -0700 (PDT)
Received: by mail-ed1-x564.google.com with SMTP id h8so66788695ede.8
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2i+01++VA+1j2ZEVCh5fg4pO/m6vcFxbZIQZAXxjI8=;
        b=AW67JIn5aLtRKvQ4ISp3hFmglAQJgsJ0dmDFCEGpxvRu7O0kdMEFfhYAo1KrL0jtEE
         BMvJkF2fGQfHPg7tSVQGmpFV3BH/rXOEUC5oyGEL1xqlqJGQoEDUaIF3h3pT34MUXg3H
         7A5BZv9Sk96kT2f1EEJWJjhsetjVL65RdAEAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2i+01++VA+1j2ZEVCh5fg4pO/m6vcFxbZIQZAXxjI8=;
        b=OPs5KDJCPlwoaAaR4Bp58zq7c4Fmr08/rEBiYH73uRrT+GhW7le49bXXnX828zDuYv
         GZ2hx/VZGYxwxMCwaH5xBGfGgE8c560LA1zV4EV7G/KN/JzPFsxYIP4Iv7qCtLn+RIK/
         z5E271P9TVt3ZSbFOF2vYtMABSFwKQxEnncB66n7k1CNp8MPmPh3uEMvf3xLbVZVtNC5
         /mpoEqeQpEgen8tO0K89qDGX/vTGdpvyd77m+ufHya8AoRHXYSBeqMXXpWGggVGtAh9E
         ripJriAikpiD6vdZMcf0B69ZHloEBFhEQpSMKVCtNwP3yEgA2AqkqUAqmFMfu9ejOX1W
         4iBg==
X-Gm-Message-State: AAQBX9ecO+t0yu6DWQNjMiTDKyyqVxwfm2+drMRJXNKNQ6+nJ0lk5LWb
        BOrDA4iunQtIav+D7QqZ5mSN67OORNdJyF3wGQJ982oa+VE3
X-Google-Smtp-Source: AKy350YnNMkIoPr9AkaT9hzMt5Gkz3gTzo6P2v70cEI9WgKrIZvymtYZd9xVGxZIn2gvv5ZKiNoQ/LZ4Or00
X-Received: by 2002:a17:907:d40c:b0:933:3a65:67ed with SMTP id vi12-20020a170907d40c00b009333a6567edmr23733105ejc.75.1680113290328;
        Wed, 29 Mar 2023 11:08:10 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:10 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 09/10] selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
Date:   Wed, 29 Mar 2023 20:05:01 +0200
Message-Id: <20230329180502.1884307-10-kal.conley@dectris.com>
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

HugeTLB UMEMs now support chunk_size > PAGE_SIZE. Set MAP_HUGETLB when
frame_size > PAGE_SIZE for future tests.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 9b9efd0e0a4c..f73bc6ff5c3d 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1289,7 +1289,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	void *bufs;
 	int ret;
 
-	if (ifobject->umem->unaligned_mode)
+	if (ifobject->umem->frame_size > sysconf(_SC_PAGESIZE) || ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB;
 
 	if (ifobject->shared_umem)
-- 
2.39.2

