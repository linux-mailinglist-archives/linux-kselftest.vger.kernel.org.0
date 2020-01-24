Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2F1483DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391843AbgAXL34 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 06:29:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404121AbgAXL3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 06:29:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so1546791wrn.7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKV/95Tqr8ROSRylR8JvM121PLnBe6Qd7B63cuI3StE=;
        b=qfNpKKm07hnqLiriIGmOr8J8e8KK/BT8LiD/HbKtoVjdqQIg+L8LRXe//9Ho80yqRW
         7AvncSW3NSitZvir1vo58IpBYDCnD/EtNFepZo3FhkZ0iiHhpaSH/KB/OO9e+S+UblOE
         8hor5p0V7rrRFpupNxhkSJdagqdnZoRD7wTMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKV/95Tqr8ROSRylR8JvM121PLnBe6Qd7B63cuI3StE=;
        b=GSsAhA0A/rG3IarSXtVGxTLOUm3Vb93tgyq3e5SdLwOfXDiHJ+PVVUzek4G04YHvTq
         6SYxM5kfUApg3B0y7/rQOAKJAUmw5BTxg/jBgtAq3p3MBoFaRu1RRCikMtwDZbb4zPOO
         l//A7Cwo8vupVlD79UirbBFiQD0i3s5pE9io23M3mFuefaqjQ+g0uzDOEei5DzkWGHv7
         kkwQS4w9SG1b6AzRzBdcWEf+mpfeSnfGMijGkaHpRzS11WUuHdPLpVuAvdgZQYp+YutQ
         Ojf2juj/vIFifRoKE6P+DKfSy/toRLyVwpmU/ny6A3LZfHh+S4MHXk7uKmWBelMCk3hY
         4AiQ==
X-Gm-Message-State: APjAAAVjC40FfWQmcGT+xnp05odTaGLsmhwGfKiNzI8iYanIdfdu/B0k
        U9lMVtJm574+ZL8Sr5fjSLy4rQ==
X-Google-Smtp-Source: APXvYqxbVdXusdBMhELuISik8LOouZ+0LdsP7kXq8h43aLT+jdhkf6tMvHQYoAN1zRAngTNzB02TJg==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr3804339wrn.404.1579865392024;
        Fri, 24 Jan 2020 03:29:52 -0800 (PST)
Received: from antares.lan (3.a.c.b.c.e.9.a.8.e.c.d.e.4.1.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:614e:dce8:a9ec:bca3])
        by smtp.gmail.com with ESMTPSA id n189sm6808688wme.33.2020.01.24.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:29:51 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] selftests: bpf: use a temporary file in test_sockmap
Date:   Fri, 24 Jan 2020 11:27:51 +0000
Message-Id: <20200124112754.19664-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124112754.19664-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
 <20200124112754.19664-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use a proper temporary file for sendpage tests. This means that running
the tests doesn't clutter the working directory, and allows running the
test on read-only filesystems.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
---
 tools/testing/selftests/bpf/test_sockmap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4a851513c842..779e11da979c 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -331,7 +331,7 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 	FILE *file;
 	int i, fp;
 
-	file = fopen(".sendpage_tst.tmp", "w+");
+	file = tmpfile();
 	if (!file) {
 		perror("create file for sendpage");
 		return 1;
@@ -340,13 +340,8 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 		fwrite(&k, sizeof(char), 1, file);
 	fflush(file);
 	fseek(file, 0, SEEK_SET);
-	fclose(file);
 
-	fp = open(".sendpage_tst.tmp", O_RDONLY);
-	if (fp < 0) {
-		perror("reopen file for sendpage");
-		return 1;
-	}
+	fp = fileno(file);
 
 	clock_gettime(CLOCK_MONOTONIC, &s->start);
 	for (i = 0; i < cnt; i++) {
@@ -354,11 +349,11 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 
 		if (!drop && sent < 0) {
 			perror("send loop error");
-			close(fp);
+			fclose(file);
 			return sent;
 		} else if (drop && sent >= 0) {
 			printf("sendpage loop error expected: %i\n", sent);
-			close(fp);
+			fclose(file);
 			return -EIO;
 		}
 
@@ -366,7 +361,7 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 			s->bytes_sent += sent;
 	}
 	clock_gettime(CLOCK_MONOTONIC, &s->end);
-	close(fp);
+	fclose(file);
 	return 0;
 }
 
-- 
2.20.1

