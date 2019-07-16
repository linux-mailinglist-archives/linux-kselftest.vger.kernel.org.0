Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9886A588
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbfGPJoA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 05:44:00 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33894 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGPJn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:59 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so12056742pfe.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2019 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
        b=CUY4X28sB+ODqLkExBF1TPtKPBrP8z61MsztlmFA3r3gT07JFbpBdEO5woSX6qXc5N
         7BJpPco1WgRlDYy/qo0/eQlbH81eSVuboFms9Vfai0ZrWDbY3TxcYEjJ862ij9z1VGEB
         1XEk67DEtl2x2z0HdpX/hfuCpUB44Qgi9Z5nNVY0IvyFXpJdsd7uca/G6oZFZDgCNkBl
         9KwMhzPT+UvSiWeRn/CMWIFt4CB2a/Hi+EdyU8gaY+ftONCJpCEIb11YwL2UTJXycDAy
         5pyhBy52Rf1DEP5nqhHWDX5FpEAPRVHHNegfFxUpAFP0dG/QMJ9n8t8pRQ9jJ7cscePK
         Kt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
        b=lN/H13VxxgeHrNVpkY2JicN+w1laOMRc+ZkRxyKrgGzi1c+eQHpqMOVjIcc81P7+rs
         B44M1dQwbYyRGZ/DW4f1uwI1zOjiyJeeAmYKUm250A2XOmg7Fir78u5ZwuN/wp2gaQ03
         f4dDNnvzBLGkFHmjwJsEEy1jDsEjP36Q4Nptjal2arDk6Uy+Y7K4SvgYnPEc3hVengg2
         QDmUw+A67yO6vVZTpQpHTCQyfez4e1Ep5Ya4gDuG0oYJWNdK7V/6mJ89ChzuWWhvYheS
         LvKOzl2TE1aLJ5zUO18gfuOhQY+UFc0Qu3VoQSNQk1OLjM9+BRd85w4DujVvUBXTSgGp
         oXTg==
X-Gm-Message-State: APjAAAWfAZ1Fqz2yC3WYIILXg3DQRZA9zPVcvsUZ4bKN4eXtI8eyGsmZ
        FIbIug6LJZTkgFmuU1emotX/8G0Tpz564glpVAZj5Q==
X-Google-Smtp-Source: APXvYqx6tsQcpzZYDcAwRrqh43EK99hhlzkdZq0K9nskPImImgYN/CiLbSuAKeIKHVdKNAnHBHuOTFF9uImlQQjUAKlIJg==
X-Received: by 2002:a63:f401:: with SMTP id g1mr33239239pgi.314.1563270238515;
 Tue, 16 Jul 2019 02:43:58 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:43:02 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
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
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section,
and add Iurii as a maintainer.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48d04d180a988..f8204c75114da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12721,12 +12721,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.22.0.510.g264f2c817a-goog

