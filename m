Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF95D6A5BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 11:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfGPJn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 05:43:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33817 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbfGPJn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id h198so16406670qke.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2019 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
        b=agf+GEiYnsYgxKD+eX5Zr5iEIqArx1Ez38XIbM2zUwF+jCw6OW0eiE0IgwfAqlYXox
         CAlVrX0S8SSRU55Z1c2rRDq12LD77C9G+XVjbkBrq+fkTqHfsXI0imV9hRWG2ZvAS90m
         2c2uu0Q5uOb5hjdGFavlWbaLRn7upGPzUKOzK02UL9T78K8BX3ChJODaDGUQANK3tPoP
         aanOhJtLspMRoBYoEfxxmcWUNqIwsdubLyUHNMtGnlY+Dn7tSIfvpJ5APdl+8eBRmxio
         MMVAlOANOtJkxj5KLwb8vlKV1dJwolhgVqeUMfvFcmaoCLbrxapgKv6CSKy5nEgrqNu4
         rBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
        b=jWbdFQbogIAD0v8Jydqo3UjERsTvvBkjM1mKphc+jVNw7sXEhijCSbkWPlOjvZmFX0
         S/Cyw+Zi2OMWuecVXQegZCLR3T67dMuwJVDwSD+5bwKw4ZK6a4uNHGsm0W/8zC1pDaq3
         xg93kJCWAhua6jyG9bRuL78RoAW4PzRScBZGPnOfSTs61zrh7sglwGkUmwsB43KCz8du
         /Wp76GPvf2MoO04el7og2sp91N5akKw+hFEngvYIIusFfRN2ABl6AuFa23Gjp7EUDth1
         C31bSu68GjRx7v5LYlVepGttkYdz4K2pSn0Yt2DmMmtwtqU/w4d2pTCvdahVX+jc/rn4
         9lUw==
X-Gm-Message-State: APjAAAVESmMluarYqK0JKHRW9Gg1jcZFoMJ3EUf6+XSUevurbeqyeUAU
        fjeRQDBKLft4Q7vhPr0esWNNFLi3TVYcCRchH9ds6g==
X-Google-Smtp-Source: APXvYqzMr4UyHcoIfs203SmG1cldh3k+yn6h1nFlHx/9asdbVsmVxWorXsh8GDjT9ds0pMy9e7bEiUsj6ezLI7PPblj01Q==
X-Received: by 2002:a37:4b46:: with SMTP id y67mr20389260qka.66.1563270205950;
 Tue, 16 Jul 2019 02:43:25 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:42:50 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 06/18] kbuild: enable building KUnit
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
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

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
index 3e4868a6498b2..0ce1a8a2b6fec 100644
--- a/Makefile
+++ b/Makefile
@@ -993,6 +993,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.22.0.510.g264f2c817a-goog

