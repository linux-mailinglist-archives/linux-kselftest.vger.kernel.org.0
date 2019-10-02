Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C275C87D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJBMEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 08:04:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37291 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfJBMEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 08:04:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so16850106lje.4
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y95OajR8Z4EhoKVV/d/GtPK38UmcXtK59LFx+wA+Kn4=;
        b=OmP5kq+z+zbFpIxkBNzdy160yYdL/tMN7p+YDlhaPbcErQwKwPUXwv2VJg5sUXmyup
         ygBxLJXG5geeSgJTdIEycdXlvcJ4VTiDNeCAcPjC9oX6zR5voiv5Ww3rBRcWuZD7otui
         XmJuS4uPT/e5ZSoyF4+mdfA9VFyOem72gpoqPJVVo9aWJuI2LHax7Cs3gE8ErSWQazFK
         JaESnbyXsinx1R/cgxTvkqrAHVdAH6gFw5ZUBlVLwH3Uwfnogt6FlnURjAsPrds0wVmq
         reyXAR9+mGKS3WAcXU8dMUB8XLZ00ncKR8c6OPrSVvIyojBl/q0L730b+Ns7dEOXDGfS
         0eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y95OajR8Z4EhoKVV/d/GtPK38UmcXtK59LFx+wA+Kn4=;
        b=KUhp8CE2pIGeGcJQpLpNT+QTHiqBQ/KuKAacM7xP3IgxNOIkgiHFJqvifIj9oJRxoh
         kShBqdtZO3BHVciVY6TLusNgW5le8ckfcToEUrkIIXV+81dWylei4CvdRLRFFDF3uXoW
         BSh7kZSHzQLhpk1vNNdPhMNekbBLSFX5riiaWD2GJ6ERribxDB4ipL1JUe39I6BgWuoc
         8KPRGH9QMSNHjaSlLdzHDlMU2qaNEDxN5FhqY9mH4QctfMasM69GX6jMWfLXwO0PQsPN
         P5wNnp8QAykDuv4lgFXCimyIGUm/sp8pCuSSFXZCejeBQlvmPLuZbVB1FAdPJ07oeoi5
         WRGg==
X-Gm-Message-State: APjAAAUWRp9E1qOeivAY2pXrI9/Ll8T/sT3f57oCZldp9Fi2uq8SOlif
        YDPNPIzHjedlcrJG+EzA/rIJgQ==
X-Google-Smtp-Source: APXvYqwCgHv5cQQHT5flHSQGpsA/3qpFgY9BqKRSoHwTcS8bpTuL/U1VGR2qPBiljcvG8ANgpwX2YQ==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr2285090ljb.4.1570017853751;
        Wed, 02 Oct 2019 05:04:13 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id x2sm4833827ljj.94.2019.10.02.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:04:13 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 1/2] selftests/bpf: add static to enable_all_controllers()
Date:   Wed,  2 Oct 2019 15:04:03 +0300
Message-Id: <20191002120404.26962-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
References: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add static to enable_all_controllers() to get rid from annoying warn:

samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:44:5:
warning: no previous prototype for ‘enable_all_controllers’
[-Wmissing-prototypes]
 int enable_all_controllers(char *cgroup_path)

while samples/bpf build.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e95c33e333a4..4d74f3c4619b 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -41,7 +41,7 @@
  *
  * If successful, 0 is returned.
  */
-int enable_all_controllers(char *cgroup_path)
+static int enable_all_controllers(char *cgroup_path)
 {
 	char path[PATH_MAX + 1];
 	char buf[PATH_MAX];
-- 
2.17.1

