Return-Path: <linux-kselftest+bounces-46879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68777C9BC07
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFB964E3594
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCE225A34;
	Tue,  2 Dec 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWJGiUt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B4217F2E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685208; cv=none; b=fcF7cY99S3DWtvr5aiC4YDxj2rwPh6dCozObJkzWlQJ8P2K2OuRQsjPZNJ4TdVY//0MjfVJt4AfGI1jLxs8b8VwfXk8MXWDy2NiYvlRyZ/hsbwcb68vuQWQbTyxWG8fTcCepzfcmqA/ITAe12vvwppJo31QZJxaThp8Td/fBdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685208; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0ONDw9/b9ECHhiTp4hUpKv/2S7s7IVwVMNJmHkpI6EOH0UdkxltqpbE/t9GKpKzvkwcITz778/hQJqohXJbzEKfFVrfWWXc9YXK6b6RhEiPx1FrEEZX82+mpTikwng8NCj2W2+CRQW+sFo62WpBWuYQeeryM88hVQ2ob3kIr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWJGiUt1; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso928832d50.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685205; x=1765290005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=iWJGiUt10jZa2RDY1pcrGAQvjNpGXz5+epqdPY0SngFhOQiS6APy+XIF+hP8JwU/OF
         9guqfNVstXTMJulyPoamVpkTvRIMrYSG6iDRt5X5YY0/h0Hq3ln4jeVgLz+By9LzvD4f
         q9bjPhLVCtWekxB03k4HgC0NPso/G/xq5j4lVK+q7LiEZb+YQN2HwY24Gg9wR82r4IFE
         mgZOwsxvYOtGvOX0pKQCSRqPQG1CctPPH7vEplgffWNxhOAcBIoSkwqv1kJ4DtcGEdVM
         cnPGM8+RK8dD4So+D6bTxc2gHRilJslikhbpK8IBW9XO7/0ZFGN2cFAdxrP7eiv7grrv
         sfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685205; x=1765290005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=w38GGdM3LMsRV+5gRE3D9IhJbytOL+7ddUIXWk0UZzj66USwSDN0vKqHratX7/p13K
         OOn3xNmYrAxksdyq3Qzb/KljHOI4mQJEFXhDtALWo9BehzqD2Dt/XytAeF0nh2/GBwYu
         BeuMpbuXdlJgJARgRHeWljJc9L7O2R0foo96Do+VKfff+5iArnMPjaFGyAU6ssq9No8k
         AUIQIRWbr6rv1Id/RP2V6sGDKEimB1EmK7cgqXCfbISmJkC3Hrt4StFN81tJ1Cyx6o03
         i54TLPx3VbSqfJTe9zrDAi7pshXHO6DCe+4YZz+ddOXE5gSJcUhGRekzQDKGLS4gJ+ga
         piww==
X-Forwarded-Encrypted: i=1; AJvYcCULbiEFzO2QTOSpsbc732a7f3UH6MEdXygVjTmgvVhSfCSFRZE/FMdPIePRu5I6xP1mnmtI+Ks4I5b0u/CRTT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaETo+2zrsgMWP/oUkOnByTR/5K9CVG3bA8Dw7eFgG5d+deP8G
	ydBRwsid+61iaKM/ii8QE+aqECpdRvuuGIGN2yJhaQptu4UmIPdo8SaD
X-Gm-Gg: ASbGncuF/bUkf1fAnXXhHumoPS2qDqLSwwxx+x9XYNchXAXpHaLiO6SMB/p+7WtQbh1
	S8yCLpDfy2PtWCWecwmbx1QaRGlmDJSdRjkuRDPdGt4WSQ4aFKAWnV3teXiD94NaBUENP9BHTD1
	4IO6RRrtX4Ziw7EKl72j/JIwIIZvu2IsTUa/jcL9T5Cj1WA8JtAb0kS/wOExQy2it/MfazaPoa2
	Ez5qQppPX17GhCrOx4rC28cL8/rMcdrVyWQJjW+Gin8UV6NRQsPPxBshAJJwD3RA44UtLGmZbgj
	Fs/HfRxDTUVu0LsxjcZ+eokwQz/Ub3ffBocK9eTuU/gqdWO4KGFUNN5ROaw51lc+IG1K2GLRbH/
	fowAu8b4H7rQUSsz8CQhrNMLBv4Bal5Wf1xinXDm/0pEfDUI1DkGSTjaikcmGuFuj1QgNfiEo8p
	0S6/x0zk/IX1jvLwBzCjFTkK2UFjwsKYn8bENlUqy7QwyQSUTml9U=
X-Google-Smtp-Source: AGHT+IHnEicOTQPX6opDgFi2vp+1s1HztND01uccNXaYM349XugzEkvCl/XXLQPgtSoOfH7kYyl0Dw==
X-Received: by 2002:a05:690e:12c8:b0:643:1ef1:9613 with SMTP id 956f58d0204a3-6431ef199abmr25478296d50.15.1764685204701;
        Tue, 02 Dec 2025 06:20:04 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.19.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:20:04 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Tue,  2 Dec 2025 22:19:43 +0800
Message-ID: <20251202141944.2209-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202141944.2209-1-electronlsr@gmail.com>
References: <20251202141944.2209-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0


