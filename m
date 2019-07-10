Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE69A630A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2019 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGIGeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jul 2019 02:34:05 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:49468 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfGIGeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jul 2019 02:34:04 -0400
Received: by mail-vs1-f73.google.com with SMTP id b19so2386470vsq.16
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2019 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xqyprLFtmsoy8kXd9YLO/VFwieDqS65MPOOJ9C+cs/4=;
        b=BV0dE8SvbznNengE0ZbiFjAkJDhECZRlV6y0anjBwPZPZ1QJAxXC1g/NWLJmkwh2dQ
         ymUxDZfk5Xo5TuLgPcbXMU1zelBpG5lRvdeCkasNl4X/Vnt9x4r1W8pPWC4/g+lUwaKi
         8JU4Z1wA6vTfOZEjHhdR9Mlf+yIQ7pF/76uNwAV9V52L6+GkfjA6GEFVHibZRCvNE6a8
         Fu4VfyO8IzEKX7M6CI/FgWBxODziZFM48h2BxhCVoZ3/hlGN10lCqjL51sWnlSnDcy2T
         mBdvBHfYXaqHr68JZPdHCE3Q2egJ+2F4FMM5YKC+b5EV9OgFhj4bqtOQ/+4RJplYTmiD
         NT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xqyprLFtmsoy8kXd9YLO/VFwieDqS65MPOOJ9C+cs/4=;
        b=Qnyw13r9CTTHh505R8BGqzQRqEA1uf7/3D2i9yaIsZs4UshwDT7tWfftGg9jydclen
         sMXoiRZlSJhM7UJ0p6aeZOYkptIHpPWkKkx3k6I5EmVp6slAM6XaxJ7Q2A4PSLlFwPf2
         xa2TPHZBLQP32W3bmqOHx1C89wMMpBV9R6YBghkzpovmlNKLZe+9pPfPskjME9wJHBMc
         hF4ywo71On0L4RzqwhI0eZfFu3yvsyr5XJkPP0rBJJDAj4KptwQuHPbDjMP0mOeCLJp3
         1kMyv0HcXbTMqVEaXTJ/pTAraDaXw820sOBoAq7Hh9DZnzMpZ91dyDyKxHwHGgtM4gKi
         1VTQ==
X-Gm-Message-State: APjAAAXIvtV1w4uMfg+xKBjaYrvrzOFW1ZYlijgdjSiaTDzGu4RmRV7+
        7zN1ErGLS+7hR6x/smi58GruMbewbXo4vea0aXdIAw==
X-Google-Smtp-Source: APXvYqwNJiHBkRfCSkqsV5H5ZuEZsj6nanDgGNZ3VAmzTo0fg8lJCoDeNDmY/ozNQHmnZsAUL9Mc41SFcAh6mWnqjC3NSQ==
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr4416164ual.1.1562654043545;
 Mon, 08 Jul 2019 23:34:03 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:11 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 06/18] kbuild: enable building KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Kconfig  | 2 ++
 Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 3e4868a6498b2..60cf4f0813e0d 100644
--- a/Makefile
+++ b/Makefile
@@ -991,7 +991,7 @@ endif
 PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-- 
2.22.0.410.gd8fdbe21b5-goog

