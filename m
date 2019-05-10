Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5041A43A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfEJVDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 17:03:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46940 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfEJVDI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 17:03:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so3817467pfm.13
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2019 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9Gow6vM42aJp56wjf9r7GBUU79udYOMt8dacDWI13Q=;
        b=UVBj/OwFLiTzum6IDgk7LUVfg4GiBlqfYvJJl4E6HY2WxlnZ0tj+8Mbyp8HNH5SRIF
         xlPqFSE4NCYZBHfO7irbMEN+Vg+YxVQx3scJ2UAuP3Tk7DRfDauHCWrKS0qfq1K4r+C8
         3DBrBuEM2rpf+Pk1qNBmlldbVkgMKr/w1GTH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9Gow6vM42aJp56wjf9r7GBUU79udYOMt8dacDWI13Q=;
        b=C4w7ZUrrY3LUyy4gJ2/yUfiW8yxtFu/KBNhT/lrYUJWd3ePVuF5u+Xns7uiv53U2hF
         7Rx6alx0Ynit7EVZDmfmDc3+r9/X2ZNl7PWFn7nFUTH4QYDtagPWuNsc1UINl1lEIBY9
         LLSW0XjX/wwYHmgqlMVESCxcv4Oc1Lkaeo0N9Rco7hJTQq3Ee+BeDL81urwekPgjcc9L
         5nhWCfa/CtX/y3cURlRdJFGrpx6bGK185dIHRryRoX/gIao6FqQLQjEYwT2YTtjBBFPj
         rjeijVsTGtY8TrBkyAibe+JqSK/VWrSq+icUpiEHdjsrbyhHbDJHp85QtJzI56JNZ19e
         UP3w==
X-Gm-Message-State: APjAAAWbFsc3WXbW3rTCSxgx9Yw1wI+Plq2vfkr6Xi7Kiy8iOK0woKDU
        jnzauerDigC9STREY5aGsKWMEg==
X-Google-Smtp-Source: APXvYqxx7K5CBGqKQ/c/VTttlOFyb3tvfg/8U27VnQPYkICRqEywBVXgF7yTbE4iu6TL2YhtYXVtAQ==
X-Received: by 2002:a63:2118:: with SMTP id h24mr16498738pgh.320.1557522187805;
        Fri, 10 May 2019 14:03:07 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y8sm6523333pgk.20.2019.05.10.14.03.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:03:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH 3/3] kheaders: Make it depend on sysfs
Date:   Fri, 10 May 2019 17:02:43 -0400
Message-Id: <20190510210243.152808-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510210243.152808-1-joel@joelfernandes.org>
References: <20190510210243.152808-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kheaders archive is exposed through SYSFS in /sys/kernel/. Make it
depend on SYSFS as it makes no sense to enable this feature without it.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index ce08adf0f637..f27138a8cf28 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -581,6 +581,7 @@ config IKCONFIG_PROC
 
 config IKHEADERS
 	tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
+	depends on SYSFS
 	help
 	  This option enables access to the in-kernel headers that are generated during
 	  the build process. These can be used to build eBPF tracing programs,
-- 
2.21.0.1020.gf2820cf01a-goog

