Return-Path: <linux-kselftest+bounces-5410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A698623AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AF1F233A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0444363;
	Sat, 24 Feb 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fVAsJOCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7143F9E7
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765500; cv=none; b=bOdjYQvft+BSE4YhoYty8cdG01QD7SIz6a4XkhK0nKHi/lspg+EKNk5MFX0pRhoKGz0qRWc8f94UCc+8UeWVJIeu8+lTFCAt9kSlUn6j1V59ChS0tvlGIVDUTEv+KdIGJaY2w9eAOgaPRwGJfJS71AqfFKoL0X/1SjMt4rEVv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765500; c=relaxed/simple;
	bh=W2t1gDt0S4a1/HW/6/kG7xzEKfo9X9H0YdqgUGLKJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESU2mUt7gxTqB31dAC3F8cIEnl0U5HE529/z0fR/KMg1MPpDaabs2T72+n6fSr2rRGSG+9CSKYAYqeyMlJ5Gym9ASMmUmcE3dCzf/tpOrr4yBq5Mh/K8UaQZBvqfy0W5SmeTasTrR8G3E/NDQxx/fORdIe2yr5zR0OF1Uxy+lCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fVAsJOCx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41294021cd8so8450065e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765497; x=1709370297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x86i2bLvLQ8s2ekOK4n+eRSdBkIkaafdJNLN4ekEok0=;
        b=fVAsJOCxmCUI1Kxw29LiXfG+xui/HzyYCAVQpMHLm5MC0zVM88loKBF6sVav42jEwt
         o8NUDMVCz4AiHIblhZE3AulVB1kXI34JlvY+v32TitlwKxnjN+E13eUXZzWXGdyBF6V2
         m1OaGm3Fc1XoK+V8F6t8F1lcLRsJD5cO9wco/Yi3KUq54yBBKpEukTkCWNGYh80Exfim
         mrCifyxfaSfmbzBlUMMkFqNNxk/br5T6fCct5AL/VIK60RWNvqRwWBRMn8pOq+XQ8hhv
         d1E9mgOXkpVeY2pT8XFLSv/v50O3gphVy2lxtgxTSzssbJNhU8u6rdfgwbKkXicEUHFA
         CVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765497; x=1709370297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x86i2bLvLQ8s2ekOK4n+eRSdBkIkaafdJNLN4ekEok0=;
        b=u8iicSC2QhAZXphKqc0G2ywBOe0JbBNxxDZFEPtOrI+QJOpQetqJ45AcHOjVst10sV
         EK8LH1c0zZLQDqTVm/rABr347Oh6O1GSJqsP9wDO/VIS0/KK2bi2/CMfdCABtuEEtv18
         LOmiQNKlU4Z9wXpO2Vdq58wyXQZVgd+ebE7PzKEXIsL+IquK9IghJEJd/r5pRbuH/1hU
         1N/Q0K8Sg2hDoqIebWX6QqMU0SsivCAi3gwn9uWFwIkk0DilWWEirNPiyKW9mDUhZVgB
         jJ4/MsDyB7dqM7s3n/WPAgF1CI6v5ri2Gu4gb24rfuHH1Dn0n4ToKIL5d7N4Z/Df6HNC
         XQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5HVKxj0k7DiN0zxWX3Rb+fu2xxXGEGBxaKZD3OHIjSxq5d/eydo5mhKEQ5kfxeBuZMYfmNvRM1fuWF9i2bQkB/fOdZEm0LVWhdXupChC
X-Gm-Message-State: AOJu0YwmtkeYSP9MhO2swEdrp9EFJQQ0+fForD6AaQu962gfGOjVx5kK
	Z/kQ2UhfTGjh8O+WyD1VKyKEL9err5lTr/s2zF4ho7iNATENjKfEk+fDeST79Q==
X-Google-Smtp-Source: AGHT+IFYZFhVl1THeVUMtDtrUqkTWkBH8i6j7z/8R1v79GFRQA5Oh7V1BKlSbHwyMZa1VzUzVFhfWQ==
X-Received: by 2002:a05:600c:4f52:b0:412:8872:e8f4 with SMTP id m18-20020a05600c4f5200b004128872e8f4mr1491142wmq.1.1708765497395;
        Sat, 24 Feb 2024 01:04:57 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:56 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 09/10] selftests/net: Don't forget to close nsfd after switch_save_ns()
Date: Sat, 24 Feb 2024 09:04:17 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-9-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=1645; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=W2t1gDt0S4a1/HW/6/kG7xzEKfo9X9H0YdqgUGLKJyM=; b=HrtiK7tVw/bjSYWfjeueAiyqfvuMn5IWHQgF7i/oeeqthLP8sDdHMXQ2ky8sLEotB7YM5TdU3 8MnzdiddrQEDEnm5kK5GLfccXOWIvziIgaef9UzqhAamDJrH9nnxroF
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The switch_save_ns() helper suppose to help switching to another
namespace for some action and to return back to original namespace.

The fd should be closed.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 92276f916f2f..f80120bef3dc 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -142,6 +142,13 @@ int switch_save_ns(int new_ns)
 	return ret;
 }
 
+void switch_close_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWNET))
+		test_error("setns()");
+	close(fd);
+}
+
 static int nsfd_outside	= -1;
 static int nsfd_parent	= -1;
 static int nsfd_child	= -1;
@@ -296,7 +303,7 @@ static bool is_optmem_namespaced(void)
 		int old_ns = switch_save_ns(nsfd_child);
 
 		optmem_ns = !access(optmem_file, F_OK);
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	}
 	return !!optmem_ns;
 }
@@ -317,7 +324,7 @@ size_t test_get_optmem(void)
 		test_error("can't read from %s", optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	return ret;
 }
 
@@ -339,7 +346,7 @@ static void __test_set_optmem(size_t new, size_t *old)
 		test_error("can't write %zu to %s", new, optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 }
 
 static void test_revert_optmem(void)

-- 
2.43.0


