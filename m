Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED592479
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2019 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfHSNOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Aug 2019 09:14:52 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:42985 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfHSNOw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Aug 2019 09:14:52 -0400
Received: by mail-yw1-f73.google.com with SMTP id p2so3035569ywp.9
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2019 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oNoDUi1hsmNzzodU0R6ojKZvjIC3JQAmU+NA/+7Uaps=;
        b=ouW48h7HGbpdNdCReL1nk2+dvRXfxgklc1nbCP+Q9JJOIGCVyS3fqahBo1S2d8316M
         OZxTJFVIgB1yHxwjdFezXxDGLz9wKstEmjea5fp8x0waRP2D4PtWy/8cEd94ITbDy+AB
         ohMM7RCZVEao1hTKwgkNZsuSnXQ52npfKzrCB8hagDJHWUZyqV94tepmovte0/cp0h4L
         SvPXvaVH6Kvmqsu415sDgkqDdnh0pnuy5EbzAZl/JGrx9UiwjWAucl5+kBCOYUeFDUvr
         0QJUC5x7f/83eUXVQvxdzpHaeshvsSjN84YEl5sN0EdVOxlMEIgfFzUzZo6IFB3/q633
         zoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oNoDUi1hsmNzzodU0R6ojKZvjIC3JQAmU+NA/+7Uaps=;
        b=HLU4TGTl4HYXsuTJobYxRgEpbZ2mJw47mzkUjAKN3WEFWpW/OrbnzZgUEQ2fdHy/bL
         4Bk7sELglF2YhnN4ML/KB8THLVFDAhj6mQILQg9YLtwtkFCppmRpJTLOQ7x5mJVnAgIv
         L3nbUwc69gfP2SnWVeOQe38AAK5EloAafjcqV667jjSRc3+oHo64cU9Gq8GpaE9qvdu/
         G5KCfSCONbhAW22ZU/Z2DzxIZWi1H4AFYNmvmN84peQ99aBrhYcAclwideZU8dqKLqrj
         WhD2tFnEMUJq484Vn8ip9tJKR79FdTiOTotGk7apwvrZI7BF91HpTaUgkMg1oxc1dd8k
         ErFA==
X-Gm-Message-State: APjAAAXt5CnGfSD0ipcZaOO+NiEYAnaRmjjmWHpQmOQfgpKnkL6fUOMk
        6Hu3fWVakAlPV6LPNyh/Niw7gjRCv3qKSEvA
X-Google-Smtp-Source: APXvYqwFX5U5jD7RsGf0G3vM/9ehnT3AiWsZaEFsyMkoc/hovIoyUTjRlHyWf2f4E//56cQouSUIEdq8hx31clIz
X-Received: by 2002:a81:6c85:: with SMTP id h127mr16796224ywc.111.1566220491100;
 Mon, 19 Aug 2019 06:14:51 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:14:42 +0200
Message-Id: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH ARM] selftests, arm64: fix uninitialized symbol in tags_test.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix tagged_ptr not being initialized when TBI is not enabled.

Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/tags_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
index 22a1b266e373..5701163460ef 100644
--- a/tools/testing/selftests/arm64/tags_test.c
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -14,15 +14,17 @@
 int main(void)
 {
 	static int tbi_enabled = 0;
-	struct utsname *ptr, *tagged_ptr;
+	unsigned long tag = 0;
+	struct utsname *ptr;
 	int err;
 
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
 	if (tbi_enabled)
-		tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
-	err = uname(tagged_ptr);
+		tag = 0x42;
+	ptr = (struct utsname *)SET_TAG(ptr, tag);
+	err = uname(ptr);
 	free(ptr);
 
 	return err;
-- 
2.23.0.rc1.153.gdeed80330f-goog

