Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42BF668B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 10:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGLISl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 04:18:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:38944 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfGLISi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 04:18:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id o16so6313651qtj.6
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2019 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=qreLyDZjzSLoWfpDHCemqbAq4PXoCjzSqYvbTxAd3kFq3wcUyd+boew/WgT3T7RHKf
         9DHlYVSAqLvipRWptlYWn4421M2Xu79CzGuk0KbMBlm1rUNK/LznjqA5jW0KnQrmPC1/
         ZdvaHVQI+zq7HWPn4JYjZ3UxDWONOm9Fg1U4Ecy32VB7daAIzd0UYNo8Igah97TpODMo
         MVXHkHxO9A/C5JuWACVZ2C+c1BoQti5W6xYr4Ma7OZ7F6w0tbitEV7BrH7wkYWA0AS6z
         P4gr0KTVRKLs4lFGYERkJWYY15XOw3BkYa4JdcPBUKCPwG5pDxM1xMCqK+sWqXrnX2Nl
         h1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=UPR49M5FfLWGHAgMhnnoG8YiSCdLz5CBv9MW2JazNr24bEqnJMy59ar8NdlztT0jLK
         U162tNXxhPnJgCs6RzeApZJCYDzw1eP0JN/MYA2KHb+23BRpfqAcPOBtJ2qUrouiMkQR
         HvSvfdeDxBkjWyOG9RGe8NY9lXHAAPOZojwoWVbYkDX8m9DRQBr7Brv+2O5chgKEzbSd
         pcLJKH+9UdwxnyQWfzHoDc3gopWT+Gj0IytaTSkLG4C/Ort5CkmgPav+QoC0c100NmdY
         foGIxp7tHgw3IF6mth1tPOMd4TPWP9IdMCzUB3dsvtWmXstTscybnYwo/Lvu2uxYYVlf
         aumw==
X-Gm-Message-State: APjAAAWfUVgmpZOU1gDWK/24IJdsw9pYABbkr5RfYld4PzUDcnFdpH9C
        E/7i9QcK7nm1PcuZ687OaEEuqe+pJruuV2z//OiL2A==
X-Google-Smtp-Source: APXvYqx3AxPNySvREBXGAkzPq2NP7j575Vhr0oMdi/29YJtnWUzDE5tk9+TI4/b/ozPiwUtBDdK31OQO693qoPZNoLH1jQ==
X-Received: by 2002:ac8:849:: with SMTP id x9mr5356269qth.16.1562919516598;
 Fri, 12 Jul 2019 01:18:36 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:42 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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

