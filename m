Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAC6423A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2019 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGJHRC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jul 2019 03:17:02 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45258 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfGJHQ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jul 2019 03:16:59 -0400
Received: by mail-pg1-f201.google.com with SMTP id n7so914660pgr.12
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2019 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=BlZBqRR1qRdimox75W2P/i8C72pSin2IGTFtfmWWoBCvv+dsuvBdZ3/5aEpQ89PXk2
         HuskMyBFp2JqOQVUUEK0hsAQ0kjZkM8S/FywQuU6p0ypQLPCs+6NoLDj1kq51PvEuYF5
         qrdgV1mMDoflgBNJCXAcSwSGNYJkMOXfQvDOfH0JYLVQXGZ1i6UKi+51vZvxngVYRCqi
         zUJQpdHTuvjJ6rn5moXv9JrV9XiIipdlgDqKiR4V1XRaP/xyAV9wQ3bDfUgimZ4sWrJO
         BOrrvDOkdcB9a2+X4Dl7x+F0dFrJO/wdly+nhX3UZItJ2/G7J+HtrefxGaobvJsGaO8S
         dzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=sdvJ5KBghr9I65E3WvcbsJLKI9nBbaGNpgyfHB4SY6X4w8UsiyjE3fgIPJrZcJ9/AI
         CY0qmjh5+yAZic+9R0IthStQXEBK6t88LhEBy85upBzvCE8TkFvGXFRPexJTViAb7z9d
         YxuiB6cc+ppDPx983tABfrgtfx6nhRC1iQvSOEPGOooJjbW1frzue3UuoQFBQHZ2aGPG
         KCxNZEYyDfewc8dO0qQpjtxbzTldrQhgLBP5RT4+G79UK5gXnXaMrVp6IBh9DIsPp53X
         Uov4dPOxzfY4aNR/2J35lhssAkGgZ+P5cBHjpKPs2u1ks876jxumWWLOa28+FMiuYsOT
         JQBA==
X-Gm-Message-State: APjAAAUbjuVVdt4V3gzwiZUlBYUwykUP7zXRQeMoKxs2t9PoDFBOTOit
        qwXwbS7psg4KmRwzsvzWQt9k4eXKnP9y2W3zBdtJnQ==
X-Google-Smtp-Source: APXvYqy3gEnvLtzenDeoBpvruwM86/d4R4MSA4rfrSkFPoe3MSdS+t35zDjs7EFvAtglaLFEtGooue6BA3jgPd6GRUh5Fg==
X-Received: by 2002:a63:d0:: with SMTP id 199mr35409907pga.85.1562743018345;
 Wed, 10 Jul 2019 00:16:58 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:15:06 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012c..48d04d180a988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8599,6 +8599,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

