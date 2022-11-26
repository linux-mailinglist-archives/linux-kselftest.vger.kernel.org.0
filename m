Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C363959F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Nov 2022 12:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKZLN0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Nov 2022 06:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZLNZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Nov 2022 06:13:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276B17E02;
        Sat, 26 Nov 2022 03:13:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so4752767pjd.5;
        Sat, 26 Nov 2022 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgpVMC8bvZTlVaXHEo2lO+7RGlkj48k53uTj/gB9BCs=;
        b=dWThtiiKNBg5x2ryV+rTL8GPxB4T+txtD78vZMjaEmKoHmpFR2YpON19SSHeaItbAF
         OaUjP2df/qi2zy8CoukO4z4CSrsYgeWOKtLbzjPhnm1c6qeVLyur+Y+8QfE/SzYvl9Ru
         fb0EMXbbkoRE7LwQLeGBLKWjAiuH8BmiCWxKe8LCdrJGlluw0kqOPbWLqDf4PHISwfoQ
         xDO10hDu0PFMQ5J5bm6rUoLIWZYVfjDhVP9OVPff4C5YPvZgXYJgbb/5L+Fvv67Yc7AP
         HufSP3ZfjJ0eMhgxV+xqdn5lDCTTk+89ZEmXOlpsKHfECHsEf16P0p8PUI5nh7Wyqk5J
         nA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgpVMC8bvZTlVaXHEo2lO+7RGlkj48k53uTj/gB9BCs=;
        b=A16/3YT9D1tndMp8uKb5xhvkFxiANELT0W3sXD/N2/uTjcJ7GQFz1gv4Cvp0n1CDOn
         kAsCmDzGFb1hxOJ1t2TMJODMsTYzmk/A5BD8SY/9LEhfJHxWNcJNGBsTqKS2tQ26S0Iy
         SPzpe5YxbfHMLRZA3rTT7fmyKvBkpy5IH8PuszNN7EvarM1mdc7jaNdPXDaR0xfOMshd
         NgSFbczzAabg+s7eJ5R+k4EhKHhSkDVPEKS3cyVG3koIzDupZtjKcsYYubfrhRREFFEv
         CMtzLEYeD+i6VrW/M6DAH2yZhUxIft+nHZfOm2uIJIHJQX4d500RiTlLzxXcsjGhBWa0
         EGyA==
X-Gm-Message-State: ANoB5plgHQbJHJGYSstrjAIe52YkfJ7H6uyL9HH9AaVyew2GTE6H6kvU
        oyLPBQOLW1U5lVlsH0m/GtM=
X-Google-Smtp-Source: AA0mqf7fCEIjOQBE5SGQST3jU4rWrs2OdbQjaTmUtD/8qr8kil9aTcd9lbwAn9QMhT4Lv0q+EdXuxQ==
X-Received: by 2002:a17:90a:460b:b0:218:8a84:aeca with SMTP id w11-20020a17090a460b00b002188a84aecamr38895752pjg.63.1669461204167;
        Sat, 26 Nov 2022 03:13:24 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056a93838606sm4555639pfc.58.2022.11.26.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:13:23 -0800 (PST)
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
Subject: [PATCH 0/2] bpftool: improve error handing for missing .BTF section
Date:   Sat, 26 Nov 2022 19:11:45 +0800
Message-Id: <20221126111147.199366-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Changbin Du (2):
  libbpf: show more info about missing ".BTF" section
  makefiles: do not generate empty vmlinux.h

 samples/bpf/Makefile                 |  2 +-
 tools/bpf/bpftool/Makefile           |  2 +-
 tools/bpf/runqslower/Makefile        |  2 +-
 tools/lib/bpf/btf.c                  | 12 ++++++++++++
 tools/perf/Makefile.perf             |  2 +-
 tools/testing/selftests/bpf/Makefile |  2 +-
 6 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.37.2

