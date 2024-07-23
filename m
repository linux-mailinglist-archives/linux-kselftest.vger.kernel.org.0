Return-Path: <linux-kselftest+bounces-14039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248793995B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EBB218A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3213D2BC;
	Tue, 23 Jul 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr8AjGOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50713D28D;
	Tue, 23 Jul 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714131; cv=none; b=cCfYLVXxVBH0rGL2ti8JCYJ2OeQ5PepCFOKHQG08HjVToiQRTz/b2K10oJBxBxYkGrgCb2hWirFOkAYcu08C+BtmyFpQGnGglNP+PYtSUe+TdH0K3FM/JXv3RqlSgNJD6rklKnRmHau8kErGcjbgKla3zl4eeVtAptNd0rdx8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714131; c=relaxed/simple;
	bh=U6PSJHHsdoHQeuBdbe1AqOJi7Op40WqZje2dI0wkV7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BayBelGpQrApV5gNntTsTrqYwSFSVSpLwabqI+LadjKmy0XgyFV1GteqWqTLdya06N5DJ3kiU69fCGFnCgUErrR34gq+QA5A2ZKnbZPSHx69VwR25BR/FU1wncqWahs0zUoVvvg5Z4zA3C14PSoS1f5XOISfxiP+08tHh+SxF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr8AjGOm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc6ee64512so26738955ad.0;
        Mon, 22 Jul 2024 22:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714129; x=1722318929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2BWuZk7cm8HTXBQSy2mvZgxSz8YUm7gyJDVbc+WOMQ=;
        b=lr8AjGOmlRmL1f03oNIxatF4WnpV6iAIh04fDbaQ8bfXKn/doRMtJTYghnmwIPUsnQ
         gUHP0ehWJ4u/akWbdATd66DwAdPC1dikKhhkxR7EergKOdfxalTWOkIZMmgkLTqH7nW3
         zEkLSJIqQXv14r+APqjZg0unMSl2L471qOvPetk94WVf55IMefXesuxzdXkinjzDdhvF
         QKaQyG5Cv6E1ohxUxXf7vc5NhLe/RI3Nzgs4mYPM8UbZFr8b3NgU2ERIkMzTPyQEcQGd
         Aq/MX84s0zHy9Tnfk4vcNcZysdwR+ie4Lr0m791UdJh0ch7uSldL+UdkW+Wp9ZhO53zY
         frfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714129; x=1722318929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2BWuZk7cm8HTXBQSy2mvZgxSz8YUm7gyJDVbc+WOMQ=;
        b=vZ+bvIIA7n0MK48r2HF2nrkFC7e9uW5WLTckeScaUzE1HBkgD+fjHZ3DqVQ650Ux4M
         SaeKsQtfux99QsTSITxLsaIN8quYW99sZSkwk2hLN8r+1GFk1zgP+wp7TfdtQjjRBlCv
         2VBVexbGiMiOtbuzOy7ggHet22fiMJCM7/j8ObOT1cTuIAh+O0P6zqvgLKA7973AYc9v
         4H+LazEpcsyDKdgtg0ENC8R74zP8F9UAyhkpAPytk9pe5sXVQOv3Wrolg1vEgL6yabNM
         ptaIu237qYImnsBQVIyOg2vqZKCT960LqZKfrmSqG07C6zHCzAiHDH/OPgGzdS8i9s+F
         z0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXZbBp8V+krONUgaz4n+glzk8RBDd/7/AFMcsOR46Hq5IDMS1qu1GqiegvLIZgKrh4ZdvtqNbXf1quhDtKj64w83agPwgPhBTOhNII9RK4r
X-Gm-Message-State: AOJu0YzP+EpeZ/xFy10COHKHsIaljoCvA4yuCozC1LjL4j0xHcC+jtBx
	WecSXaVk6I9NuqWnu5zDo7F9Esy2760LSUhUJD/FAIHWSkob7W+YC6EshnBk
X-Google-Smtp-Source: AGHT+IFp7G/dlEx9FOB0bLBzldRTnkBU4OEkOzZmYC5r3/vwUR2cl2S4ZiXsvNo6Cqyc45HLdC/HBw==
X-Received: by 2002:a17:902:ce8c:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1fd7457344fmr63321155ad.5.1721714129057;
        Mon, 22 Jul 2024 22:55:29 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:28 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 02/19] selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
Date: Mon, 22 Jul 2024 22:54:29 -0700
Message-Id: <1e00a1fa7acf91b4ca135c4102dc796d518bad86.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast 'rlim_t' argument to match expected type of printf() format and avoid
compile errors seen building for mips64el/musl-libc:

  In file included from map_tests/sk_storage_map.c:20:
  map_tests/sk_storage_map.c: In function 'test_sk_storage_map_stress_free':
  map_tests/sk_storage_map.c:414:56: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'rlim_t' {aka 'long long unsigned int'} [-Werror=format=]
    414 |                 CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
        |                                                        ^~~~~~~~~~~~~~~~~~~~~~~
    415 |                       rlim_new.rlim_cur, errno);
        |                       ~~~~~~~~~~~~~~~~~
        |                               |
        |                               rlim_t {aka long long unsigned int}
  ./test_maps.h:12:24: note: in definition of macro 'CHECK'
     12 |                 printf(format);                                         \
        |                        ^~~~~~
  map_tests/sk_storage_map.c:414:68: note: format string is defined here
    414 |                 CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
        |                                                                  ~~^
        |                                                                    |
        |                                                                    long unsigned int
        |                                                                  %llu
  cc1: all warnings being treated as errors

Fixes: 51a0e301a563 ("bpf: Add BPF_MAP_TYPE_SK_STORAGE test to test_maps")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
index 18405c3b7cee..af10c309359a 100644
--- a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
@@ -412,7 +412,7 @@ static void test_sk_storage_map_stress_free(void)
 		rlim_new.rlim_max = rlim_new.rlim_cur + 128;
 		err = setrlimit(RLIMIT_NOFILE, &rlim_new);
 		CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
-		      rlim_new.rlim_cur, errno);
+		      (unsigned long) rlim_new.rlim_cur, errno);
 	}
 
 	err = do_sk_storage_map_stress_free();
-- 
2.34.1


