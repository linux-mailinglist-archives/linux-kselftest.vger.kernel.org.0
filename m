Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30A4151B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEFQbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:31:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46192 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEFQbL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:11 -0400
Received: by mail-qt1-f202.google.com with SMTP id k20so15879679qtk.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3tB4TRcqPwl6IgCCTq3FyKBtrVczmpENbbiRumQIu5I=;
        b=C5Bzseg2BAkWez5di4p65TqBX8PhS2fPXqJjrcuborrGzdIMmjBkEGS1oepu/kO4gi
         ZrAiwZ1YbirX9TOQW6iDBsdtMTgTZyQlBla9C/k5+v0DS9Eu7yTQTxvIZJRaIMRpa57h
         rZkszsH1RsVjkBjXJm8Nw6zDYrexUGyc9BNsDlgeAocqmj+aaO1LdZJjYgfxEDSFYcJj
         gjdVUEcQ+veFKjzDustw9+BWdSodbg3cE0gzjdewRwKOf7czWg4u+rE0852iiQixBdas
         JIw3pQAvoPC6IfNeEfBV09Q69TtafbxIB+dc/sgJQwlLGyiy5Ze3tqDZ/eiYCNwSry9q
         rXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tB4TRcqPwl6IgCCTq3FyKBtrVczmpENbbiRumQIu5I=;
        b=mca4XVou96cwerXMu3qsKNJMQAvbOTcti6XjuGOZMiZEXbmuFvLO8KY+w6ekptiXxO
         zqE/kR1l9NDOt921yOlNgYpdV3jukdqhOuZDor8GK6mmDm8VBLACzTHdFN9M879e62Lb
         esBgEpQdQpLTnNhXXARE1x4JWB6UmlE2+NhRmOKxdu8NMQ3ij9YxoIqJAfzvgL3tHLNj
         8rDRojlqbs1IwwSbpWiPRwFG9d9iCyJ2Pwy0lRMO3RamTwcOv+hMPt4bQkR0szANPPZe
         JcGuKZdmlWp5yV+7y1oiq6nnYKmNWhf1F9mLOfQ5m8geXnx6/6+cL+c/+i+FFLIxjg5y
         A8SQ==
X-Gm-Message-State: APjAAAX+6f8N2p8PLc8dU4xHVWixGVUnAfp0KW5XJwih7PzNsTnhN/Ln
        /GLXpkwRQDSTV99FPzxv+A/5ZX1NPyk5CMJF
X-Google-Smtp-Source: APXvYqwDoIRoTGaFyeue7qd81SpE5xeykRQrED4HzbPSjcVVRn6t+xvIGHOhvH8ghp1kYB1swN7rJoVGjZYp31y2
X-Received: by 2002:ac8:3390:: with SMTP id c16mr6277321qtb.315.1557160270425;
 Mon, 06 May 2019 09:31:10 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:47 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <67ae3bd92e590d42af22ef2de0ad37b730a13837.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 01/17] uaccess: add untagged_addr definition for other arches
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..44041df804a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.21.0.1020.gf2820cf01a-goog

