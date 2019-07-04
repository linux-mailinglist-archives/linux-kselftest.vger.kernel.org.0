Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303DC5F0BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2019 02:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGDAhs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 20:37:48 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54924 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfGDAhr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 20:37:47 -0400
Received: by mail-pl1-f202.google.com with SMTP id u10so2251567plq.21
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jul 2019 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XlrqH678HDR84yo41rM73BaaQaGuXs9XZZneq4FOZeY=;
        b=ffmju7yr7gRfaJbHZ/EKKmVncl8VlWULQaThQY06zll3+6WpQG6lpGZ4OPQmMivptS
         8hDYradWvLpP2Ynet+Ye7uV0kLczbf6RFD8mFVTANX2yg7wM9YbXidQ/FQZgq07MWegb
         OGw9om8WRHzmMMnObSBGoIx3ybtRj+V2h+ffEXd5lxF3Nc0UTcEdl8L3/UVHObrq7Hpr
         pb1JvhsO78qMQnHwg/Ed80IloOa6WYSoqzkmmaIisIDaOlJlxgcTtQcFCed7VfZAR09f
         b9pzfPkA2sw/PBcf5XMV0Aycvwei2GOmUX9h6Qyralx5M52IFq4n3EvX8Bsm6682vUXZ
         cuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XlrqH678HDR84yo41rM73BaaQaGuXs9XZZneq4FOZeY=;
        b=fjAoux8SH4Gpk3WUs4smvKNiNCg6kjWSgC5dPPy4UjAVTXBLznKyRvRyuXaF5PDONR
         c453YEXhj6/lnKxedbQZ07UdYMCZqCWRWeAA2VPxvswJTRMw2Z11VNfSW0ZjROvkzRK3
         etnSK1X9jSt/blD/k4lA+b0UR8XUEJPtAGS4JCyKLYYIK8n9LmMyvdRnBUVYRcG9x9dm
         LUgxYlF4Z2e1dAN+MBiXTTUf4L8zjT2foN3/FMY55gHqYL+MazJSHeqOcaEzvaP6LrWk
         iwxtQaXqE+e+1ncvjARXP2p9LO5TIlDHu/Swd23oFr0Xblde+m5eQKuPXyt6YEP6dllm
         +igQ==
X-Gm-Message-State: APjAAAViK5WQgbInx5LaYOm4hFdsMn0fwflnE+q4h7AcPC0YSyA+zaaQ
        hmRegYeC1ZHJltymNn++jwCJbstPv135WxT3ljwrjA==
X-Google-Smtp-Source: APXvYqzEyrStQtoN+0MmqxKcoxkpwGwMdPWPCVJ2v+rt7FevA703DgZaVQugKeZ2rVGA0cnHCH+IEhNvyiDaQ8b6b05Cdg==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr39423299pgb.133.1562200665901;
 Wed, 03 Jul 2019 17:37:45 -0700 (PDT)
Date:   Wed,  3 Jul 2019 17:36:03 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 06/18] kbuild: enable building KUnit
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
index fabc127d127f9..44e0d730dd5b6 100644
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

