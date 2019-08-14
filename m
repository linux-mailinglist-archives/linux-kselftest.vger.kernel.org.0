Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81BD8CB21
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 07:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfHNFw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 01:52:57 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:44911 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfHNFwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 01:52:55 -0400
Received: by mail-vs1-f74.google.com with SMTP id p3so3673255vsr.11
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2019 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
        b=mrsDShuTPkFleL/bpmmXLkqRWbGmCMe8eWyPKi8hXeRHkfVigWiAfCHpwD0hVSNcQQ
         S8nAwpSJBRDPldfYj4A7LBO4UErIGmgWKtbD3fPOSJ8H7nCd/iPxnlPTIuqisNCKz6dC
         xsqwzZjYKmcmc7B92vl/XvFCGelMiL6GF0SuWlPPsM5ByxumhuWkotPV9MRNYd9m6gmA
         41b1pgks2iQXJT5XNQ0LJ/qDuqTcu/TBD1bxU5cZhhvfdMVwqslpNg4GK4pDZxQJclKo
         YFYUxYFw4pCByCAxMdSAVqLOIIhMW50yvVPgkfJcvVzsEdWGh/78tRjbxOIRrK9JqJzG
         JBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
        b=iv8oL/WRwpJdQqWqo/0vdQmS4wx9FKJ0iqarA8zKNLkUWf7IdU8ya1soEmFrceMjtJ
         EkB66apO/iBLp3mLM/JzOsL9nVxhZb8bEfuNNj8ZvR4TfMpz8BNhXxa+BjY9mzJ/Fchp
         7ZkIbS8/OKELZ7dHovZhcDvF8RJ6WkU2r2h5SpLkWGILgi9qrltaOGNzzZywwPtJMBTc
         nKhcxiEDpr9/UQaM3Zw7aOebH+ut8tflll9Wka5ei4rYtsKhymxGmBr2X1cXP7jI7M2Y
         Ay3mGqnI32Y7NQmkRjamARzejz0xNoyReClP3P0rXfys1Yv49C3QynQuAYz2fUJXVk3Q
         B0Og==
X-Gm-Message-State: APjAAAXFxIOj6iEVm8grlBv0MPNtJkw76bI60CKgA10z+m+elTwNGdZe
        tiBnPeE+XbUICLNMOQyMn5kfuBzulQ9r81Rif86MLg==
X-Google-Smtp-Source: APXvYqwhfu0AdithZ3Dc34TPp6G9Q7271SINMDP2+L5uhJIlb8Si5QLWNAsthlY+87s1BKFjJAj5DJ6UsNfmB4wPi8P2YA==
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr18276120vkl.28.1565761974094;
 Tue, 13 Aug 2019 22:52:54 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:51:06 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2c343ee3b2ca..f0bd77e8a8a2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8799,6 +8799,17 @@ S:	Maintained
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
2.23.0.rc1.153.gdeed80330f-goog

