Return-Path: <linux-kselftest+bounces-594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3627F7A33
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B8281B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC339FC6;
	Fri, 24 Nov 2023 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYM3NfMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E51987;
	Fri, 24 Nov 2023 09:16:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4239f5c1ec2so2152221cf.0;
        Fri, 24 Nov 2023 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846212; x=1701451012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a865Y5eccV4NEfBYguXGSbwXwv2AQMyNfi8KVk866g=;
        b=ZYM3NfMzU2IKiRXqt4cUkA/vadUGPGLwgNHdEUH/Dr9AVQtJ1plcIwaVPk9KMrP4UU
         +wj4FXU8Coi18yXCdxWf/uQatMIAEZP5qyRy9XUn4AJLHkZdLQA+EC/G6+5Y93QZ8/8c
         30TUJcqJpi/4rvBm1gTWMEIMJUpKm1vy/AhyDlYtSc6XCtHFIKHlpBtwQEU7jgrylCl3
         u10ee/ZTUarzjK5+aAy5M145vDER9ye1Cgf5La2vvSGWSC1VMQEhQTWuV7LmxuYhUwp4
         DJ73xpYIL2qma5J42fp5W5Hb+Wt0LX2n+EAAhXPkdofFbCiepZONIt6i+uP8OcsUp1cZ
         TuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846212; x=1701451012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a865Y5eccV4NEfBYguXGSbwXwv2AQMyNfi8KVk866g=;
        b=mNBF6nooZQSnovhEF9wLIowriQG97vC4E2gvkdqwogVjBvos6JGLGiaEacu9Vn8J3m
         Ydi35wxlSGQwaR6nrj7T2CnIxOkqy1kJubzqCbM/XIrTFmkQQLQSVcCibuByrvCB7lh8
         nlQ2Sncotk2Dxu4vCTiEsFVZT4wXcgMKzw6vWkKFn7mycEKWpGkX3vr8XaGe/TdnIQ55
         lnJEPb0ahiSyMlPr3HSZ/DlQa01mc8WO6PwSc6Yqn6Z2H7Z6xL1CqhFUXXlyZrAAro/R
         Pu6Xgq8Yja20mwlP2ZAHiUr1bqWxUFvXojldDbVZlJT7kq7madU5NRxJ5jweqNZ9f6vS
         df/A==
X-Gm-Message-State: AOJu0YwGXNeH8fBs+9I/e5gYoAzwTAcfHZ9C2DhHxi7LjYNE1KeUD+0X
	25OujaRzvYsuiw/NwM4cpwlckJsEmm0=
X-Google-Smtp-Source: AGHT+IE0HeRN63PBpoyZcTtaUbo3vRuh7mcI/BW0ogR+qmamwWOEmndqelPnTfRrMrvrl5t7uNRNPQ==
X-Received: by 2002:a05:6214:4991:b0:671:dac1:c856 with SMTP id pf17-20020a056214499100b00671dac1c856mr5300384qvb.53.1700846211723;
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id mn23-20020a0562145ed700b0067a0a00b24csm1389278qvb.73.2023.11.24.09.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 4/4] selftests/net: mptcp: fix uninitialized variable warnings
Date: Fri, 24 Nov 2023 12:15:22 -0500
Message-ID: <20231124171645.1011043-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Same init_rng() in both tests. The function reads /dev/urandom to
initialize srand(). In case of failure, it falls back onto the
entropy in the uninitialized variable. Not sure if this is on purpose.
But failure reading urandom should be rare, so just fail hard. While
at it, convert to getrandom(). Which man 4 random suggests is simpler
and more robust.

    mptcp_inq.c:525:6:
    mptcp_connect.c:1131:6:

    error: variable 'foo' is used uninitialized
    whenever 'if' condition is false
    [-Werror,-Wsometimes-uninitialized]

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Willem de Bruijn <willemb@google.com>

----

When input is randomized because this is expected to meaningfully
explore edge cases, should we also add
1. logging the random seed to stdout and
2. adding a command line argument to replay from a specific seed
I can do this in net-next, if authors find it useful in this case.
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 ++++-------
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c7f9ebeebc2c5..d2043ec3bf6d6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -18,6 +18,7 @@
 
 #include <sys/ioctl.h>
 #include <sys/poll.h>
+#include <sys/random.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -1125,15 +1126,11 @@ int main_loop_s(int listensock)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
 	unsigned int foo;
 
-	if (fd > 0) {
-		int ret = read(fd, &foo, sizeof(foo));
-
-		if (ret < 0)
-			srand(fd + foo);
-		close(fd);
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
 
 	srand(foo);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8672d898f8cda..218aac4673212 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -18,6 +18,7 @@
 #include <time.h>
 
 #include <sys/ioctl.h>
+#include <sys/random.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -519,15 +520,11 @@ static int client(int unixfd)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
 	unsigned int foo;
 
-	if (fd > 0) {
-		int ret = read(fd, &foo, sizeof(foo));
-
-		if (ret < 0)
-			srand(fd + foo);
-		close(fd);
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
 
 	srand(foo);
-- 
2.43.0.rc1.413.gea7ed67945-goog


