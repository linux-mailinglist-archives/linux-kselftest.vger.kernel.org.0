Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7A1E4D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 00:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfENWTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 18:19:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52497 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfENWTl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 18:19:41 -0400
Received: by mail-pl1-f201.google.com with SMTP id 94so420559plc.19
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LOpQHtMM9lkxZ3+zFYG/wx7bpu88CbluXaSS1i/z+Ac=;
        b=Fq8WRyqIYWpdTGMYVLvCkTGSKD8Z2FJf4PX4Ws7ngpFbumOIi4AEgCaBcxQHl9vBTk
         wOmk5uiOFSUaxdlWkcvZYoDYkUPWNuA48K0vxGlot9nXqgmgF4sdHWCZYVMuzYGFqvMv
         /ziGDKEhk89fl+740B2Vl8X0fW84HVhdPh1En6fvA0eFNDb7sTBllY7EBb/G0PdLR0hE
         jWn3s54110HNqi8JsTRlgnk+uEMAYzQ5UpqOl8mP4uTizIpxWVcJCwPMnYuIQXgPvPTa
         5q02P1vmYts6PYDa0vDgkvGPlrs+I3tEM96B0HcEW9WK6XPx5mg+YxpT1atT4xBzWnXT
         qwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LOpQHtMM9lkxZ3+zFYG/wx7bpu88CbluXaSS1i/z+Ac=;
        b=VazB2GS/nQeLh4tICt7rxcuetfhgTyYGUWZ5ckSPuv/Tnvc9JIrBh61Ooqrdm1Zj+U
         Sc0j86hsJr65XBy9ujEVqwYaFP1AZJcqmQyYexs388zuB4KJPTsEBczQSScOlgtXd6Yl
         XlcKBLL3ZFCIfgLrelU0eBsbl9q1NlBPXa3Ma4HPfm+f/ZJdkCaI6f3S+/lPEl9qux+3
         hLIcwch/TyqEegGNs+wzR5ZdXaxBI4BoV9b1D1NL6HNbYWztMGqYKc0sSCtC6ZIihCH+
         4BeROhlLYH/0sO9TqwySO2dX0R452rCfqiDTJdZcqp/0I4wAAMMzcVln7UwBEBYyx32c
         qm4w==
X-Gm-Message-State: APjAAAVB56K9Kf94OlhFsmyXsdFjEX9dxnMbtHGRzblJyojJ/VVOipPW
        IVhdDUmZNh2ds8yVZyppRje9nDd237P6gC2KS97d4w==
X-Google-Smtp-Source: APXvYqzvhjWcVBl7teSOYO0Weomw7ZPsaZc176diTQHc+VwdeSwD9N7LDv+xGJoKRSwJoPxpkNRYW5LakfZamQUKLX7jeA==
X-Received: by 2002:a63:7552:: with SMTP id f18mr37941231pgn.234.1557872380177;
 Tue, 14 May 2019 15:19:40 -0700 (PDT)
Date:   Tue, 14 May 2019 15:17:09 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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

