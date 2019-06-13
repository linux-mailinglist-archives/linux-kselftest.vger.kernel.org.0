Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27243B58
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfFMP2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:28:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfFMLc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:32:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so20374118wrm.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=TbGt75o/WSp1OSUJTHNYCciigYJKAYY6solbnb+OPu7egwRHpZFyTp57t0BC1acpgS
         TAPKFVoWfjLIyWlG5lM6ccnEx04BY1qZTdskF0iD/gBFok1EC4Jb4k98qIWfHxkzKXFg
         UCMZerFSt04ZfSvT63r76NMFvJdbfCUTVST3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=THdZvwRUZg/SFbAAq0jZQ0hdK6WlDwsINr5hLOaOR9qiBFLaiFW1BT/8vwLFJo/c1f
         MYHWswoK4ACBiZhd1rr7FTdhB7tNlp6csXTArW1wrCR2Ke22QCslBYOGrVX82zwSII3c
         VM/Doj85VGFDn0cyHwHDNSqlRrnrtb0HSU4nnfL/68ajqSAz+wR54i+eKdcxTM2okfQQ
         Yb8go60Bo5ADCyxu5cYBDacsbE2R3gd2Ofs451JuMWfHyTmvXTB9MhdXyK1/il1EoedN
         I7inUmWeD1Cp2g0Lp5jNW/AzeZ3w31hX+Eao2bsGrpqWehtawj5AJ9bP95IjNxe98IP2
         DQdA==
X-Gm-Message-State: APjAAAX38fe4GYxwDYhjAUYXRpoj/ZREPjRR61tM7H6n/w3l0sjQOVcd
        C+aWITTVsF62KktJPgN17mAB4Q==
X-Google-Smtp-Source: APXvYqyrdLnXSnjStU6hbkGo3KfeeAceiBKHAZw2YLa7AT/MAbzkQIg0WRzmMIvQXvl4kd3Mo2rHUA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr5748511wrx.196.1560425577814;
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
Received: from localhost.localdomain ([147.12.216.9])
        by smtp.gmail.com with ESMTPSA id f2sm2646740wmc.34.2019.06.13.04.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
From:   Arthur Fabre <afabre@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH] bpf: selftests: Fix warning in flow_dissector
Date:   Thu, 13 Jun 2019 12:27:09 +0100
Message-Id: <20190613112709.7215-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building the userspace part of the flow_dissector resulted in:

prog_tests/flow_dissector.c: In function ‘tx_tap’:
prog_tests/flow_dissector.c:176:9: warning: implicit declaration
of function ‘writev’; did you mean ‘write’? [-Wimplicit-function-declaration]
  return writev(fd, iov, ARRAY_SIZE(iov));
         ^~~~~~
         write

Include <sys/uio.h> to fix this.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index fbd1d88a6095..c938283ac232 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -3,6 +3,7 @@
 #include <error.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
+#include <sys/uio.h>
 
 #define CHECK_FLOW_KEYS(desc, got, expected)				\
 	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
-- 
2.20.1

