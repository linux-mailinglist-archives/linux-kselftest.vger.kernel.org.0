Return-Path: <linux-kselftest+bounces-605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5727F895C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 09:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E49F1C20BD2
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3339443;
	Sat, 25 Nov 2023 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="A7+eJJOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A14133
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf6373ce31so18701365ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901796; x=1701506596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wItB+PKNO3hEPBQi2nWGljT56dVv5dpK/TMccffm1xE=;
        b=A7+eJJOHV4FYPhX3BvVFbgFr8IQz2aEf+nyW6RrsjFANP7WaeRG5j+/qc7OaqNZDVq
         VrDqPpjSiRL2yMnhJUh0S8SLlM0ARw5vihf4IGq9xmvTvXDWdea4R5xt4qT9XrXG/ULI
         FIqLzD4sObronjXYSMMdB0xzQVK4zKAsKJbpsxVy8zmYuuM5bCYMwqb4r1g+rismbrHW
         IlKcqrtS7kVuiQiWNTGHStVoJRrmNwxoJVcZn2NaxMy/LshngjGzqViabGer0aTxYYLM
         2JTjvtOuPA1O3BgoRkplAQvf6jQZ/06T/6PefkxFhFNZ9HJzZWHy6HR92LwnaBzcOFSi
         OZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901796; x=1701506596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wItB+PKNO3hEPBQi2nWGljT56dVv5dpK/TMccffm1xE=;
        b=GSCImwfWT1PezQsB1zrYqLdBogG3p9s7QDyLjtwbch5TlaKqGwnxHZV4hvUkwvwZrt
         zQC6NOVp8yi+rPsrO4rZHsS6AAT4gq92MSLIezaf1V6HpZjmupOq1EuBZ3MVPQIViSyZ
         qBvF70SINGa3d07TupcJ9iQj89PBVZgPMMYG76CvhaogP+SBxfx6yHbMEcvPEowmdHZ6
         i8gfJnsY6ZyOrPcG+K9ZS2rVuUiZuaWTnY0vvISPv6YS0RRMinsYrsF+7R+VOAQBrosi
         if/ZmGANRYsuzVu9PMVEVjxJm3HaTG0WvvKUgrzCdsjlcBkHbQwT9iGHQ94l6uKNhR3c
         WSBA==
X-Gm-Message-State: AOJu0Yx0yM/uMuma6BkV7wpVWKYkZuKFkbGXRNshTodMdguytX0aPCNv
	qFrErOWqeyoj2829WmXdMgKoGg==
X-Google-Smtp-Source: AGHT+IFxiQz3BsHEBO78xSibjA97oPp4WKGwp+0jnIwsj/tgRFBbBaOp+jEnT/85fbLaPzY/Qm92DQ==
X-Received: by 2002:a17:902:e88f:b0:1cf:6832:46c with SMTP id w15-20020a170902e88f00b001cf6832046cmr6577902plg.6.1700901796260;
        Sat, 25 Nov 2023 00:43:16 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id t8-20020a170902bc4800b001cc131c65besm4432871plz.168.2023.11.25.00.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Override PKG_CONFIG for static builds
Date: Sat, 25 Nov 2023 17:42:51 +0900
Message-ID: <20231125084253.85025-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A library may need to depend on additional archive files for static
builds so pkg-config should be instructed to list them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index cb9b95702ac6..9af79c7a9b58 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
 
 .. code-block:: console
 
-  $ LDLIBS=-static vmtest.sh
+  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
 .. note:: Some distros may not support static linking.
 
-- 
2.43.0


