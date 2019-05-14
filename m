Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB861C27F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfENFq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 01:46:59 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52805 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfENFqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 01:46:33 -0400
Received: by mail-pg1-f202.google.com with SMTP id n4so10786100pgm.19
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2019 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HjiBfvhYdSI4+vO6yGbKNMYX/91rl9h+rC/QUu27sIU=;
        b=kUh3DaXusTGq00ECIt2FdVjSR5hTcVAgEW/f3abE9OTIV3vedKUjIsJP82BwSYuDMp
         ajh9BeuTVkFUCZSkbYD6zCtkB/ijjnbHI8zdSNJtT+CGF336L03RwCHwki6ix8qSCFiK
         ovu0lH+k4NwqnQswnPFVtub3BVfheE7LTIAahgDrQedjMUuf0hujcw+ed7PNw6Ul/h8w
         d2FhT4ak9bBnCmLQUjkFagPtJQzt6PGiCogFLRGv5dDOKZgrc55jgA1xcucKesoTlu/e
         In6JMpz5OdCUOJ1fwUU7uzzVONZYnZOz5G5brU0LJD69SwnIrsbkgSd0nCYkainva/SZ
         6pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HjiBfvhYdSI4+vO6yGbKNMYX/91rl9h+rC/QUu27sIU=;
        b=P9eff0pNfd2tfm9F+qwPdKsRGtjWgL9ep3psdYqeuwOloW+O6Dh0qv3lTUR1rgucjK
         NJMWW9/rLtQU0kfzZnGcq529wAE4PMA8tgO44bCwFQ2AEiMMMyddegdbRcMn9aSnJyz5
         7md5P3OD0WKbhSdLFmI5iaYuQrCIkZeK0vb11BADuM/3fda0hG52w7L9D+NfkJ9K75L/
         9jK6Oj/iFBlOZJFaLDM6NQfV1PJ5sZCYkDgfD4agjiztYN8C/SsJ7z9YvatTUgejNLo9
         2T/yzZRgJm8xPHTmEUT70/BdQ/tBh3xpx+OpoXAVblkK5gTDrpNfJSqIVoXcABTR+6Es
         BMuQ==
X-Gm-Message-State: APjAAAUSiccu3eQEOhVsUZaH2jowRpYFLHczvF/VTHO47j+6t4GTAVu6
        3xyqtWT2XjAw0n2r4oOaVOWQfP4NwVc5REWPyh0PGw==
X-Google-Smtp-Source: APXvYqyR/hpN79mq7mgSPZUvnCj5MN9msH/qzh6HWF+yjkWYNICdwiwYjZa5jNJGIkB3vivRUbS6veSuwKm0wCCRYqFrOg==
X-Received: by 2002:a63:1d05:: with SMTP id d5mr35695236pgd.157.1557812792681;
 Mon, 13 May 2019 22:46:32 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:50 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
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
Changes Since Last Revision:
 - Added linux-kselftest@ as a mailing list entry for KUnit as requested
   by Shuah.
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c2fce72e694f..8a91887c8d541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8448,6 +8448,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0.1020.gf2820cf01a-goog

