Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E035963C153
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiK2Nml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 08:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiK2Nmg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 08:42:36 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEA1A6;
        Tue, 29 Nov 2022 05:42:32 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h193so13020965pgc.10;
        Tue, 29 Nov 2022 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxRUZ2jEWiw6HK0oQ5GGMn2fmZj+o0TEDQ1eNMlf4Ik=;
        b=dzUA9sKyDF9OoQ+ug4D9nMG5RgGUGRP/pBnDPatsVJ+7U3JG11wUiXy6bvUpEuk3Yo
         8dEbvowJGBvOxG7oztP2is33RQ33nDX0GuRZBRASoN3f7crlTSI81M/SDdGtNYncydvL
         xYX9wU7ivtNMe9k1uSjaAHkIarg/i96HLuxSQcouO0tIy0HGGX7YxJfDwzEiL7EUfHvR
         C8tUBgvtV3OZk/K1v7rAIt0diI3pWU/HgD1cs70LAEaFQ+hQCUobWksYYlWcpz325zSV
         AQf9ie6JqkdIwVBh/tOwEx5Tc3a5hmmOXaOI8tXW8lTet4ZxvVqN27AmXI4pNffrA/Ur
         h/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxRUZ2jEWiw6HK0oQ5GGMn2fmZj+o0TEDQ1eNMlf4Ik=;
        b=4TgnUsFti09he1Zerxje+M0PK/LKWUUzNzX+u8Je/OiqyHTqEYz1m8Dbd63tHZjVu1
         Kgd5rX7M8h5iRNUavBtu3x1U9yJFG7WltJcURZNOV1gkA+nlb3IsOlOYwioVT5/06NK4
         W12+t1K0RDx8sxHzJSxX1HSvoc6wTwr9ejKfiVKiiNcQxj84LsT6UsY3i8lXsxUHUE5u
         mBX5sFx5PvE+IH7ouewyq97ble2Pxp1VNd8lVVErOQiqwB/hH2pNTDzykXpm6ksgNcEF
         ffVYQ+sYUJ9k3klbKrB86ljP6KsckePF9nWlxYWpaifvZZwt4LPkFTBJJiNDWoIj/HRy
         oGwQ==
X-Gm-Message-State: ANoB5pkagh5VgEJhCIZhAfT5kCWgdVteZlBjtOT535gXYJpfCXrAksXY
        0L6R0ANxrYTutiJXIeOwvTI=
X-Google-Smtp-Source: AA0mqf7evwkAd5Nd7XTUTtVhAKR3Gd+LPQ71CHiPlcQXSeTnlVGiWRu4ZcIXc6SKJjH5JYu/q0qY3Q==
X-Received: by 2002:a63:e4a:0:b0:477:6cd0:9a04 with SMTP id 10-20020a630e4a000000b004776cd09a04mr38141363pgo.433.1669729351325;
        Tue, 29 Nov 2022 05:42:31 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b005636326fdbfsm9977154pfr.78.2022.11.29.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:42:30 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 0/2] bpftool: improve error handing for missing .BTF section
Date:   Tue, 29 Nov 2022 21:42:15 +0800
Message-Id: <20221129134217.52767-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
 - remove vmlinux specific error info.
 - use builtin target .DELETE_ON_ERROR: to delete empty vmlinux.h

Changbin Du (2):
  libbpf: show error info about missing ".BTF" section
  bpf: makefiles: do not generate empty vmlinux.h

 tools/bpf/bpftool/Makefile           | 3 +++
 tools/lib/bpf/btf.c                  | 1 +
 tools/perf/Makefile.perf             | 2 ++
 tools/testing/selftests/bpf/Makefile | 3 +++
 4 files changed, 9 insertions(+)

-- 
2.37.2

