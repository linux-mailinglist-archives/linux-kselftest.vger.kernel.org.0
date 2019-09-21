Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A40B9B63
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2019 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437493AbfIUAUI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 20:20:08 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48641 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437487AbfIUAT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:57 -0400
Received: by mail-pl1-f201.google.com with SMTP id g20so5457027plj.15
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=JOe+XfR60TVQqjAO/rFGpvwAcA/DeU0SVyM/HI2Zhgf+PtyQB0/LAoxlOspG28eTUB
         KN9jxB3mTzgH/VAIVLmulJHeZb79W2QD+ooJERsLdgQedeMWn7VcN7Es1aYnH0Gkhhwi
         IWLHePrpOKcGs0YbMH6P+d7N9pQmEfolkxrEGwDrz/ATDZir+fRfFHmN/SDktuIu5Rh2
         YIeerHsfSRWFqIBf6DnJxi13eT3crcKMRNm5YJ3SiPsnPe1bj3g68f8sQWHI3XdZy9LM
         zpm7N5ugYQFlZqq0A7vg+AC3kwfWXBikM38GfptB+DWaOMSZABTa2cAcFPjPTvyX4Vkh
         9gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=dnkIXZYWaI9GSDAmyziC3BjWkNHmK1gDlGA2KcL1VR5pEpZ+8HNwTVnWyawwVJjTXc
         aR9L4r9beTqKw9uGvlVyLxrqu2Wih8t44vR7Wl7AkgwdQuNEtgWgDt6E882falvXdsmZ
         nNG8FFJfhA3De0o0c9I3IQySvv/aq9F7yQY2Cet2eKhUDG8jbCPe2plptcCa93f8liD3
         s1s11cUQ96FPXpTSJcwgifSX6hvMkYORRYsl9m2X7VTAj0T6oDaYhkiYDNxeuQNsIQW9
         Qkmba4YL65TItiQmE8svfrMVHzTXzGav/I2SKSwd4RbZrCE8GWY3ip6aINsOgGEA7I6u
         d5HA==
X-Gm-Message-State: APjAAAXinZvb8TGx2DSPdUQhSC0ggKRnuO6s0M92T0/X7cYBX9gDv+2i
        3b+V9xf1vUi5eUeqNuV5aL9AzU+lUP+KPFgiayhUdg==
X-Google-Smtp-Source: APXvYqzXl1Z5WO9dWeLbpxv4VzPzrj0gpja77fNZj2M2QIzsJxEJrlfVmtKghEGLDfEqjyLta/fW30aIAzXg7GqHAbqviQ==
X-Received: by 2002:a63:b954:: with SMTP id v20mr17995160pgo.140.1569025194919;
 Fri, 20 Sep 2019 17:19:54 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:54 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
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
index e3d0d184ae4e..6663d4accd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12983,12 +12983,14 @@ F:	Documentation/filesystems/proc.txt
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
2.23.0.351.gc4317032e6-goog

