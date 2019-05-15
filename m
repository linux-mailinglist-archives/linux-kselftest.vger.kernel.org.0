Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB61FC47
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfEOVgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 17:36:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44545 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfEOVgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 17:36:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so474717pll.11
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjB9LsovF8lpor6w+CVg9dpdpQizlQADdXWnWKh0+Rg=;
        b=VYyAWbWi7W7y+gL1aVVELgMHHzDwCnQoRhq01306PoaSmD2u7UqvAOGVFr/KZMuRCm
         Ad56tj2pg1vt1yOuEEChvUVluDdPThEqtHcqeTOoLtCbGuWm6Ayjuh8w7xMROHdTGo2S
         wbtlJxG2lTEdzsemWMiOsQy/Y140eT1YBdVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjB9LsovF8lpor6w+CVg9dpdpQizlQADdXWnWKh0+Rg=;
        b=NOng7HjJ3jH3LhTRzNZMDJK2qyLbZuUCXm80avJTFgsrOENwBTLpffus91YKln+Dr5
         arZ9s/pThCNcqY4Raq3LXGlYkpYuUELF79SuLOVFn9gc5kuxoaOyZkVjlsWfsur9VVGS
         mPgV07qVHfClxP/v3IduHyk/aKGeg4f6R7ys3M1ba/IhvoIfl4hcMDoVJFXVg846hdNX
         7eUlBJUnD/FoxmNpmAe8nRd/M5BVHgYHL4K/m5JiwVLCSgRhJbOeaI3tYnc9buWM/utm
         +GJp9uAsWeKkx3kPgYXW+p4M+5msm2wGG8uACDC54V47aLhuYGP/OAyangKcDeRmsGy/
         Q7AA==
X-Gm-Message-State: APjAAAX1wVA5gkVk+FXkx+Lu8V9cHp6FnY2/pL27SXBYvhJPUFBclowq
        xiKhPVmZQuUZWUzPQmAIOpeQgw==
X-Google-Smtp-Source: APXvYqxHN70es4b0dCS2R1CKfqsJmikP3jLaCFw6mu2/8pQd3QzrWRXNHoRuaFwwglq5MBBI8QPEZA==
X-Received: by 2002:a17:902:bc85:: with SMTP id bb5mr46246086plb.310.1557956173660;
        Wed, 15 May 2019 14:36:13 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3695279pgb.39.2019.05.15.14.36.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:36:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH v4 2/2] kheaders: Do not regenerate archive if config is not changed
Date:   Wed, 15 May 2019 17:35:52 -0400
Message-Id: <20190515213552.203737-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190515213552.203737-1-joel@joelfernandes.org>
References: <20190515213552.203737-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Linus reported an issue that doing an allmodconfig was causing the
kheaders archive to be regenerated even though the config is the same.
This patch fixes the issue by ignoring the config-related header files
for "knowing when to regenerate based on timestamps".  Instead, if the
CONFIG_X_Y option really changes, then we there are the
include/config/X/Y.h which will already tells us "if a config really
changed". So we don't really need these files for regeneration detection
anyway, and ignoring them fixes Linus's issue.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/gen_kheaders.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 581b83534587..9a34e1d9bd7f 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -31,9 +31,8 @@ arch/$SRCARCH/include/
 
 # This block is useful for debugging the incremental builds.
 # Uncomment it for debugging.
-# iter=1
-# if [ ! -f /tmp/iter ]; then echo 1 > /tmp/iter;
-# else; 	iter=$(($(cat /tmp/iter) + 1)); fi
+# if [ ! -f /tmp/iter ]; then iter=1; echo 1 > /tmp/iter;
+# else iter=$(($(cat /tmp/iter) + 1)); echo $iter > /tmp/iter; fi
 # find $src_file_list -type f | xargs ls -lR > /tmp/src-ls-$iter
 # find $obj_file_list -type f | xargs ls -lR > /tmp/obj-ls-$iter
 
@@ -43,10 +42,18 @@ arch/$SRCARCH/include/
 pushd $kroot > /dev/null
 src_files_md5="$(find $src_file_list -type f                       |
 		grep -v "include/generated/compile.h"		   |
+		grep -v "include/generated/autoconf.h"		   |
+		grep -v "include/config/auto.conf"		   |
+		grep -v "include/config/auto.conf.cmd"		   |
+		grep -v "include/config/tristate.conf"		   |
 		xargs ls -lR | md5sum | cut -d ' ' -f1)"
 popd > /dev/null
 obj_files_md5="$(find $obj_file_list -type f                       |
 		grep -v "include/generated/compile.h"		   |
+		grep -v "include/generated/autoconf.h"		   |
+		grep -v "include/config/auto.conf"                 |
+		grep -v "include/config/auto.conf.cmd"		   |
+		grep -v "include/config/tristate.conf"		   |
 		xargs ls -lR | md5sum | cut -d ' ' -f1)"
 
 if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
@@ -82,7 +89,7 @@ find $cpio_dir -type f -print0 |
 
 tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
 
-echo "$src_files_md5" > kernel/kheaders.md5
+echo "$src_files_md5" >  kernel/kheaders.md5
 echo "$obj_files_md5" >> kernel/kheaders.md5
 echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
 
-- 
2.21.0.1020.gf2820cf01a-goog

