Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16187759196
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGSJ2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGSJ2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:28:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D01BF0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31590e4e27aso5985855f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758923; x=1692350923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=SJ3Q0B0A3Ka3GcM2fsrRRu1ABrz3qH5VgmkgNyaET96MSIOytg/OiEvrePd6F8G38R
         3hsF8hHq1GaxCVrvDR4njcuc8XDEMSD/QU52mvwbWVqCXXmsKizJdl+1vcFeg5dH3uBE
         D18W8vJhf5Pzs3smkfJc1RF9ftkSDd5q8XubHReffV4Svz9vwql31AQfXLIFkFFQBuJj
         bYk5O0F0zscjX6UwNUMlxOWG8C5eRgR5yrEBMczGh7d0S8+2q58dK9PNv18cDwHv9txy
         3qf/p9NX9okmwlwyzKiHN7FyxZqgYiG+vQW0XUSSQzLohGIejHdnf/JD5laAtmUHJCGR
         BpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758923; x=1692350923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=KIr5foakw/R5d3aqvD/qn0zgh0ZW0CbYrkxm8ZKhyPmAF9ZV+/By3gS3hrEXPJyWJR
         93ntn/qTuBucBs9l+i8zLnZ8rpKPBMGRRT1qtr5iLRppl5pmB2T/TDlNrH0YFkS99Dz+
         KVts0FVA1b3/SlZdwLTq/3xvY3eRLfSfVzuBqHidVLRTxN79VNVfivb5elgXvrvI/2mq
         zkdVqgJYw3bKoKuySPEG6VsTjqhGjb38YLk9PAv6RSKuId14/m+v+uozyZoXRb9/GUce
         9YDISEA0+/1w0kj/nTAo2xeoYv16S0jLtlhvKlQEBJmYgWr4GSQ0/aFUH/CVp6ZZzBDW
         Xkfg==
X-Gm-Message-State: ABy/qLbHLhwc8y4G0tPsXRB6Fu4vNSub0X32jVLXUD8g9Kk8qQIGvESm
        UctCu1xVBn+a0WLQ2SGIpjHPRQ==
X-Google-Smtp-Source: APBJJlGtFawbZBqZERUAV75DJCPsKZRCyTCDL7eU0AnTNqHeGvVdeQGCV9GkZYMhye2U0gW5/Sl8MA==
X-Received: by 2002:a5d:4532:0:b0:316:cbb4:4e49 with SMTP id j18-20020a5d4532000000b00316cbb44e49mr3584324wra.1.1689758923173;
        Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:42 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 3/4] bpf: make an argument const in the bpf_map_sum_elem_count kfunc
Date:   Wed, 19 Jul 2023 09:29:51 +0000
Message-Id: <20230719092952.41202-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
References: <20230719092952.41202-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We use the map pointer only to read the counter values, no locking
involved, so mark the argument as const.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/map_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index b67996147895..011adb41858e 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -197,7 +197,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
-__bpf_kfunc s64 bpf_map_sum_elem_count(struct bpf_map *map)
+__bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 {
 	s64 *pcount;
 	s64 ret = 0;
-- 
2.34.1

