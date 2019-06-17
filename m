Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2455147C6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFQI1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 04:27:03 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43550 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfFQI1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 04:27:03 -0400
Received: by mail-vs1-f74.google.com with SMTP id w76so2032356vsw.10
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2019 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x00LgSmLKToDFMVzGBRd3p5tkepZRYMdj+2oyEasIr8=;
        b=QRuUpR7fe5b6KQBbrm5CJpf+ld0Qdmum4wKPR1jUB+VQRr9GS6e7oJ5ulOSoALkGRP
         ovpTcXb4G9btECrBBzgf45fxCMM2GXv30izjPgnZKuYLFrpwe3HXhZDQB73XVrAejJxD
         IgfII4Z9jaY8fPVzbtqxbOwVsCvGiB0RF4Mffv1td7BVKS1Kx0JJZAXyrkGkivyiYA63
         hsgbC0KTmy8G9zVu3WhXcfLq7dYt6rebWJmZYOhXohOw40uDx9fx1rlyjCam74q3M300
         OpJon9kmObZYZt7VkAjWX8Hir7yRWcNZaLM02mxdF6GX3sH1HnSt2LSrmWpaGI1AehdZ
         m5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x00LgSmLKToDFMVzGBRd3p5tkepZRYMdj+2oyEasIr8=;
        b=uLzMNIbwEhZwuHRio783r8dbRV1Jw+6RiifyVBI861ii4OTmFgH+zrxsIsSf7jyJmE
         Aodzalc8/kob6NupFMS3Z0yiOw8ZZT0KRHiOlTO3S1JPbhGTmKrY2FxYX7o2ivB4Nniy
         nxEIk/Rj2KCfrCmHYLlpAP+EuD1Pv3yDHgWE28ddqTqxYL4YetWIw4/Bz+XRiWkJgprq
         K3ie97SR56T3pjOeHPekxIK4A83lIvcE+1LLV0gFptIgxhmXJgeYix696Sywe6lY6gPK
         /AlLuDC5ypmQJFV9tlVGQuNOdyeRmpDBxlgAjfr6PEkk1QSa/+w1/Z3yLbNsHPcF1986
         2UQg==
X-Gm-Message-State: APjAAAVtxDGx/Qo4NvuHrEs2Cb0aJy8hKvkiltLQ6j8RVAvA3R5Fh298
        B8Izfw83yn9EGe/ew1CXAgCAHW7YDjqJjUDbERKGAA==
X-Google-Smtp-Source: APXvYqw0AQqNp/70EN0nmAb/HcpHOuljd/qoLNtxJ0Hn2/jd1Zqa5j+kjBpA0VFAeCRj9jxoqQZAwaaDKLUcJqXCrNqWPg==
X-Received: by 2002:a67:6d44:: with SMTP id i65mr58904024vsc.106.1560760022147;
 Mon, 17 Jun 2019 01:27:02 -0700 (PDT)
Date:   Mon, 17 Jun 2019 01:26:01 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 06/18] kbuild: enable building KUnit
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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
index b81e172612507..4b544a8eebee4 100644
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

