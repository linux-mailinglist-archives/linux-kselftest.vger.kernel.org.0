Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DB617CE99
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 15:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgCGODF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Mar 2020 09:03:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40812 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCGODF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Mar 2020 09:03:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id l184so2569676pfl.7;
        Sat, 07 Mar 2020 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gaIKPIrwCubYADjJu7sbLJYt1zqBedkAptVOYUeebnQ=;
        b=eJVYKpjGNQy3/0jAQG9Yvmmju4EmftP6llatDBOOPcGbKy29auxZvmVwQ+G9vl+BQh
         93rUD5+1vFq6visDWWmiC7Hx4uhVCIQY2Qu4KQLy2aL5Efusmn+k09u0fN/XZp7KSyDK
         d8cZ78hOaQ8blzha43rIxWxmspnIv9+GBLWwSn/xN2kqMKKjr8oS1nwHqiCa2GnGeUyS
         2YNtFB7VqTWNYKuDcGzNGuNFhn/ckhJwOYVkmrvFJMUB0z5mFFrptxFj8P+s7aoIzdlM
         K/Hscvl/bkXTyhS1LJ2gpKGziIJvN1dE9RW/vLY9cuqPdO1OfpKVv3t6HLGyfejvvZ0T
         9A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gaIKPIrwCubYADjJu7sbLJYt1zqBedkAptVOYUeebnQ=;
        b=pX5PfM9FF4PkxhuiukJWZLfMUvpcctu3Blsy497DeL1nn7Ss+wpOguAyAmBvp4OQqn
         F3OOJqQ6FCdedriUEpjSXSTF4wNQ4Vnbi8MGlAwfLceLi4+xbk6jrqF1iz+cUBKpcXNg
         LwqueUj3xXjAXkTQwGNyv/xmCeJQLsIRW2b0U5TND+DwBu/OgtX4xsq/5iy0REVDMNPl
         NnUHS2Jf4vhepCcULni5ccA6ZlTbN3Bdk5iy4TLi0wNtVmmDNLRttv7peGtdHWkfc8tN
         6lav2qufAVX6/EH0X5T+AhP9lvUC3LtdTDCgL5HwMZw0ykWIKVSyCL2DYn69vqW8/S8A
         wbAg==
X-Gm-Message-State: ANhLgQ2UCfOeC2FAQY2CDmN4/902eVSIn9qcxRC/iGlYZv9P6kRJvkX7
        aEegRM5qEP4KVYgXf0Uxdrc=
X-Google-Smtp-Source: ADFU+vtakTVmkQZCG3qPS+GHx36ySsFGc0kyS//oaXdR0rjV9BOP3tvZHFnoLHR0yeJ5lKrymgCgTw==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr8260708pgn.46.1583589782835;
        Sat, 07 Mar 2020 06:03:02 -0800 (PST)
Received: from localhost ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 7sm12607320pjm.35.2020.03.07.06.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 06:03:02 -0800 (PST)
From:   Leon He <hexiaolong2008@gmail.com>
To:     shuah@kernel.org, sumit.semwal@linaro.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>
Subject: [v2] dma-buf: heaps: bugfix for selftest failure
Date:   Sat,  7 Mar 2020 22:02:45 +0800
Message-Id: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Leon He <leon.he@unisoc.com>

There are two errors in the dmabuf-heap selftest:
1. The 'char name[5]' was not initialized to zero, which will cause
   strcmp(name, "vgem") failed in check_vgem().
2. The return value of test_alloc_errors() should be reversed, other-
   wise the while loop in main() will be broken.

Signed-off-by: Leon He <leon.he@unisoc.com>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index cd5e1f6..836b185 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -22,7 +22,7 @@
 static int check_vgem(int fd)
 {
 	drm_version_t version = { 0 };
-	char name[5];
+	char name[5] = { 0 };
 	int ret;
 
 	version.name_len = 4;
@@ -357,7 +357,7 @@ static int test_alloc_errors(char *heap_name)
 	if (heap_fd >= 0)
 		close(heap_fd);
 
-	return ret;
+	return !ret;
 }
 
 int main(void)
-- 
2.7.4

