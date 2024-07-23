Return-Path: <linux-kselftest+bounces-14044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE1939964
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9C1C21A0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305C13C8F5;
	Tue, 23 Jul 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is59cTEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F2367;
	Tue, 23 Jul 2024 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714147; cv=none; b=ublbc5NYv/nKwBrvxEIcpcJObvEEfsJMS5xv+75UbpohCXjtyLDwJvJO0pl92y4bWCEXuMNhFVzdZpn7knr9x0OfbS9aEe6lwmdfWlPOX20h2yB5queBn6ppQFtW+GLmA3osZOBv/R8RMwnELzlnHNCnDjJXzRpPndA12D0SYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714147; c=relaxed/simple;
	bh=/cmqZfrgReeBewXMWmHgSVeYjKwo7honBt9XJsxHT6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaIZPhoqhfV0eC9ZfF0XuI5ArUZk+xdsA9HAuO1bx0oK7vzJo5nP6/03+q3fchtVZ8Xu68JMTwpHGljexqe7bINxt/bOuRZusv62zWziTtNTvZD1LWJwuJTX6IJKoeY442Vk9JReRBpBgdrU38wcQ+6ADUzEoeRtdcnjGqTX34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is59cTEH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so2716013a91.0;
        Mon, 22 Jul 2024 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714145; x=1722318945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv4InJDtHX2aTNNjGgaEfTodG9sY1/Fb2dykPRkWYds=;
        b=Is59cTEHJlzU36o6QvaNH551o1xgNgiafDKUr6UWUW1qHIBHGtJ80FtSlX6EAcl4TH
         GU5X3++yzhjE6JCUEfYoVkswrRhUHLl+9EiPdl/ji4RinnmRrbnGluMNyWGeUurDgC/f
         aqNc8RIawdDIPzMPzqITHOwU/AAQYPT0sulsmLenvGBVSnKE/ThLrSAX+ELvSDjZqpyb
         JoQjYs9/hNx8dolkbzNExGmEFKOl2fpVDrYlYYdhWzGt0yK143S6PULPycBab94Grt4f
         iGT2hbCOg+SgkFvZIgtBBYR+Q1gLJCOYuHKeq8GZxOSectvK3PPrBqFdjNIbN/B6ikcG
         qa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714145; x=1722318945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv4InJDtHX2aTNNjGgaEfTodG9sY1/Fb2dykPRkWYds=;
        b=qX6CGutzFFkJNWm7DhzvYRElVug/cQ5zgaQ4ArWKCHFMepWZMoI3ejFLMsG7M4S7uD
         U1apVi0/RKQyy6/Aq5su095ELUz76p1hwzPP2lVDz3bPUtGqeby1eEh8I4o0IIzht7KN
         BGDvLfYIRkcoD0vPNrXSxKuGa6S556WUrxjCpx7lznuMoEtvK91bQaw+rg7RzIPWent8
         69Pc7CSDUKfVOTGEBu3HXwHXag8Sh/ahmPNl930An0XKp/4Ag/9QSt8R/Aa59KvN+bYx
         D8spNz/Y2ohcCNrYhNKztIFc4EiYpVMFY4PQq47wNWUgHzApJUZfhT9rpuI2YqEcXIHp
         MTOw==
X-Forwarded-Encrypted: i=1; AJvYcCVPLM/8CxJAI9ckxT05eF3tovBkVqWYZt5dZGVH0TkZndURfx7ZoA/eewpu0Q+Cmr7OJhGEdqbkc36prjxH0nmJKIYGi/O1VXkhSnWsUd5N
X-Gm-Message-State: AOJu0Ywv74E9DWS53Wdup3yndXWBA8jCCUuoJ8bIulJVBiM7nROCry/c
	cEjtw/l981qJWZY9sYVoAAhqDaiiCogDRDyaDLbsVRIaQHDis/jr4PEVYhbE
X-Google-Smtp-Source: AGHT+IFvEVhGC9Qy4mZpt7sE244M6J1kp503e7DWYkph1zlx5j69pwgzBfJQOIxpO8VZS38p8gwhgA==
X-Received: by 2002:a17:90b:1110:b0:2c8:da73:af82 with SMTP id 98e67ed59e1d1-2cd27412c23mr5180374a91.10.1721714145467;
        Mon, 22 Jul 2024 22:55:45 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 07/19] selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
Date: Mon, 22 Jul 2024 22:54:34 -0700
Message-Id: <bc4dde77dfcd17a825d8f28f72f3292341966810.1721713597.git.tony.ambardar@gmail.com>
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

Add a "bpf_util.h" include to avoid the following error seen compiling for
mips64el with musl libc:

  bench.c: In function 'find_benchmark':
  bench.c:590:25: error: implicit declaration of function 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
    590 |         for (i = 0; i < ARRAY_SIZE(benchs); i++) {
        |                         ^~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: 8e7c2a023ac0 ("selftests/bpf: Add benchmark runner infrastructure")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/bench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 627b74ae041b..90dc3aca32bd 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -10,6 +10,7 @@
 #include <sys/sysinfo.h>
 #include <signal.h>
 #include "bench.h"
+#include "bpf_util.h"
 #include "testing_helpers.h"
 
 struct env env = {
-- 
2.34.1


