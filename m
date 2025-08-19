Return-Path: <linux-kselftest+bounces-39274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CFB2B754
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156BD7AEA43
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAF92882DC;
	Tue, 19 Aug 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5TRrMf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF413FEE;
	Tue, 19 Aug 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571993; cv=none; b=UieSiEa56T3TwkeEZNJMoXe6ZPNGhewyp4huILJC2qo4nTQh4QGivsplc+VEuW9yM4u18mEpze8V4a8r7a/4zrMbvZQjVOIoPU6fVpOpjC2+8YCLBWf3jB4ES7+hyIgH1dFh2BLbwLJkpmOSxRAEYUrGbjwKtTDgPWHx9HP3XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571993; c=relaxed/simple;
	bh=tgyV1NW2HQLsXKIqLKYV0MnhSgElJ5Wcg/cUrYXpdpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gt8NY74ZSd89BWjq7i4hoXOnuZQ1qKSBxGL8PBL/OwglWUBkO54okkcVPUM/l9LEeFs8BRmzaWtZl8N6pA6F227BHaKNxnvhjnITEmC8rwLzmqyO+B7lCjT+Elg1a2TCkRm28KNUKExXyPAnpUl60OdykY1AzDwqZ4wbVQylQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5TRrMf0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f47492so31730405ad.0;
        Mon, 18 Aug 2025 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755571991; x=1756176791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oA/KhYaORoAFTQRuhWqe4L9HbtjGll8ZMWl29a9ElnI=;
        b=h5TRrMf0zm1UYDD1WfVt4ael1WpBORDdyZdX0nHxoA3DGWX7MJPnr4ti6v1W4e5QXj
         Y5j7WCg0zNNGp+SfVCSwY/nAxQDYk9hZrps6l29TYa6Mv9RQNqTPguUUG0eDU4XOT5LN
         vhAJeMiugEyX2tv3idLpSjvf7rDN8sGHHsaYyqAu/M3EPOoH2KgmY3qNHC5UbchqLi46
         IsDcL5lc5mS+MqB6hVM5NTIhi5wfZOAsBXzLRve5h1KVI6fI48/7xsnq+5XoOy6fbWLf
         nGnWlsdqVS8z9+ConLOx/Nx2FZqk4lrSykoCIC+/iGwAeRGXc1ZgInOR1UKqLtXVBh5h
         tyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755571991; x=1756176791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA/KhYaORoAFTQRuhWqe4L9HbtjGll8ZMWl29a9ElnI=;
        b=Y1Sfbu/wehgK9JKw2Fmr+woqG7uCrlXvSsbM3O4FbQ6rKXxwZSAOzK2hl2nkV1qJOm
         wbEerE8XVDCpDWfYqc5gs8d2I7QkEkv3xeZgKLLcHuK7HL6sDhD1RFQtFejwDP8hyoKf
         GIK8ZQGbJSmw2186XEqevg/HR7cg2ke42GMP94FjcNjNcYqvwQdNFYJtBMhbNja2U1Yg
         I4dZJQA1qyF5VMzTTg5YapZ9D8/Xu4euDLjUErCa3a5qS5/q2wyVAAiljoVAAWXjLg+u
         V4RwR5uBNEhhhcxVqQY8JaQ4EF2NLj9GqZq57CRveXqiBiyj9+V4AcAhhgeLTTVTyVnU
         6xQg==
X-Forwarded-Encrypted: i=1; AJvYcCUsYUfieqXtmvZDhhoYelcNsDiOqmxnqdEKLZveTrXz8aOR5mMsNYTs4on1OThljNumWFs1lCj8@vger.kernel.org, AJvYcCVzVoFB1UFYKq595PqwXTgz18gCYskqG9PQfoMQGBnWJ1BRF1OkG89SSqOpO2liNd1CEvDVdTPQ9tPZ+uAu81gg@vger.kernel.org, AJvYcCXotXopwgiXjTrkGg53U9sF9A6GZO0P7Yv9jEqRIHYVFTCUBYmls93MLLB/8QKGNZ73fwZeK9ZIpTrJLq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YQnp4wEloSkv4ElPzISkZqiFn2KGpCalMLQa+JxWBei70p0w
	OrKJnnFKq+1GmB7GaJE6rmAMvWTMeM7mIruF4P4hcSbWj/Ioi6XLC8TI
X-Gm-Gg: ASbGnctCitRFoSF4Au+ppi+0eqLycKafRVXC3QaAkNLiRR5NdqsFWdzA5GdlJzvKDyr
	6ziFM6ZsyLJcfLHJ/FgxKxSMlgyVuN+pBMUqmZKS6+IYb+etNqvdHGCoeXBZuH+Suuftvj7znxn
	SCf0YvmirrmDBx2eymaQfRy+0Jpvn0g1CIQWyf5H1pUAHuQOZBghYjdI/2RK+CtFBcGH3k88AuI
	yKxXPz0W76CzIVDHRDQ3kaB7Sf4jDMhLPNsLRfRDzSGglsVwkOgfji4KyagTUrVPFUc6dwTlCGD
	mvVrIMfoYNOpO5fj5HsG1Fz5zK0WUpqZ66hKZY2BPAlgK1QDfm3HPq6Vn2MiqX/z9YwJZvZ1c0+
	b8iZRLOqZ+L0IDVAGZqUNRNo=
X-Google-Smtp-Source: AGHT+IE/j+uhqG62YzWvU8u3LYd1nHSZLD7+y2KQPDZzMO4q9otsTVqRa/LftUPDL7SnzYjB/VuSLw==
X-Received: by 2002:a17:902:d481:b0:240:3c64:8626 with SMTP id d9443c01a7336-245e02bad1bmr11804885ad.5.1755571991264;
        Mon, 18 Aug 2025 19:53:11 -0700 (PDT)
Received: from pop-os.. ([172.59.160.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f581sm93954895ad.83.2025.08.18.19.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 19:53:10 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v2] selftests/net/socket.c: removed warnings from unused returns
Date: Mon, 18 Aug 2025 19:52:27 -0700
Message-Id: <20250819025227.239885-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

socket.c: In function ‘run_tests’:
socket.c:59:25: warning: ignoring return value of ‘strerror_r’ \
declared with attribute ‘warn_unused_result’ [-Wunused-result]
59 | strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

socket.c:60:25: warning: ignoring return value of ‘strerror_r’ \
declared with attribute ‘warn_unused_result’ [-Wunused-result]
60 | strerror_r(errno, err_string2, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

socket.c:73:33: warning: ignoring return value of ‘strerror_r’ \
declared with attribute ‘warn_unused_result’ [-Wunused-result]
73 | strerror_r(errno, err_string1, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

changelog:
v2 
- const char* messages and fixed patch warnings of max 75 chars 
  per line

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 tools/testing/selftests/net/socket.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index db1aeb8c5d1e..be1080003c61 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -39,6 +39,7 @@ static int run_tests(void)
 {
 	char err_string1[ERR_STRING_SZ];
 	char err_string2[ERR_STRING_SZ];
+	const char *msg1, *msg2;
 	int i, err;
 
 	err = 0;
@@ -56,13 +57,13 @@ static int run_tests(void)
 			    errno == -s->expect)
 				continue;
 
-			strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
-			strerror_r(errno, err_string2, ERR_STRING_SZ);
+			msg1 = strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
+			msg2 = strerror_r(errno, err_string2, ERR_STRING_SZ);
 
 			fprintf(stderr, "socket(%d, %d, %d) expected "
 				"err (%s) got (%s)\n",
 				s->domain, s->type, s->protocol,
-				err_string1, err_string2);
+				msg1, msg2);
 
 			err = -1;
 			break;
@@ -70,12 +71,12 @@ static int run_tests(void)
 			close(fd);
 
 			if (s->expect < 0) {
-				strerror_r(errno, err_string1, ERR_STRING_SZ);
+				msg1 = strerror_r(errno, err_string1, ERR_STRING_SZ);
 
 				fprintf(stderr, "socket(%d, %d, %d) expected "
 					"success got err (%s)\n",
 					s->domain, s->type, s->protocol,
-					err_string1);
+					msg1);
 
 				err = -1;
 				break;
-- 
2.34.1


