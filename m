Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DD64FC98
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLQWgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 17:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQWgB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 17:36:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B3B482;
        Sat, 17 Dec 2022 14:36:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9508576pjs.4;
        Sat, 17 Dec 2022 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHEiXf8m3ynm1qnXenv73EgPAWU2TYeSlO0zoKS2tIw=;
        b=MROxCfXkBZ8ljulhphkiBQ81hSbnwplA/vM3btKcOgC6Adt7Mrgr1TzUp8B2T6VFe8
         9vzGtap4aHgvvtfwjDRS7t2Tkwly/E9Ij4iyY8XBvJogOFcZPXcONE8lFQNeFXOTWXAr
         7D2x/1qStMKhv9etxAymtROiCFQy/lf2tLTz3Nazj4F4jHI/rJcyx/yRoz+P9naNwxIn
         e3/zVO3ze5fOggN28JZwz8ASNd8t0ktkr9dRWfBU+3Nz29xvMt9Q4uA7ReJXw6a2whUA
         H6iOQs58EBJhJLxxKZU9hAw63iqQ71nmzbf3TPHsbujt5+8GxwsyrwfeO+LNqFxhbSNm
         cT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHEiXf8m3ynm1qnXenv73EgPAWU2TYeSlO0zoKS2tIw=;
        b=Chv0F6BrOeXoToWg0HfiZNWhCLy8BGPAxkwp6l38IJDsh6bT312QC3dntOt20qavp9
         woExEPcDmFebjyU09SbanPxQW+ff0XFVfBmp1PPRJNPqW2tlhvoDMcV2zoxvEtart+if
         WpOKuEb51eD8EHey4Lb9MgTeXDS8Fv9LRbE3JR/egsP6lJQLmvmJGNNwmZjO/k68qqd4
         9pmB2d1RoAO47NKju9WejrT+PrOMCwKAeu9orf4+FN+NVp9OBhKwUycTHLoEk+2ah3R9
         IansumIAXJzSE7p58XgFM06V89CRpOdi6uEOUIZSNIOVmR/Hl/CnUwXY8b9o/ycStz3G
         dACQ==
X-Gm-Message-State: ANoB5plSQG8Uq8yBXL9Jkuu4ppxoJY9EfRbX7v4VvmiL+TUCBGshts4Y
        KJoQh6ez/gWD68CDDCosX2g=
X-Google-Smtp-Source: AA0mqf5I30Y42tIYNsbMPePLQ0diPQyPoR8HuUCfg2QwxTr3wrfF+9pkaVZRjpcK6nTEWy7VYdKexQ==
X-Received: by 2002:a17:902:ccd0:b0:188:7da8:a970 with SMTP id z16-20020a170902ccd000b001887da8a970mr43575603ple.8.1671316559298;
        Sat, 17 Dec 2022 14:35:59 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001801aec1f6bsm4031660ple.141.2022.12.17.14.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 14:35:58 -0800 (PST)
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
Subject: [PATCH v3 0/2] bpftool: improve error handing for missing .BTF section
Date:   Sun, 18 Dec 2022 06:35:07 +0800
Message-Id: <20221217223509.88254-1-changbin.du@gmail.com>
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

Display error message for missing ".BTF" section and clean up empty
vmlinux.h file.

v3:
 - fix typo and make error message consistent. (Andrii Nakryiko)
 - split out perf change.
v2:
 - remove vmlinux specific error info.
 - use builtin target .DELETE_ON_ERROR: to delete empty vmlinux.h


Changbin Du (2):
  libbpf: show error info about missing ".BTF" section
  bpf: makefiles: do not generate empty vmlinux.h

 tools/bpf/bpftool/Makefile           | 3 +++
 tools/lib/bpf/btf.c                  | 1 +
 tools/testing/selftests/bpf/Makefile | 3 +++
 3 files changed, 7 insertions(+)

-- 
2.37.2

