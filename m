Return-Path: <linux-kselftest+bounces-14038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24090939957
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70832821DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2313D248;
	Tue, 23 Jul 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgWwTqvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02413C8F5;
	Tue, 23 Jul 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714127; cv=none; b=YHN2dQJnFKIFT5+YwCCFjLUHVgO2gqZDBNUGh6Vl8wFK7bEcEh7cwYk7pfnRZ96bLn74UkflOZhcCHKa2hjRZP/5L3d7Ly1rGOpgn6LenDC73pncxMj0J+sb92TIgWLljMMLodSA1ICaZId31zKqLuM/noS4FwQZxj5jrka5C3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714127; c=relaxed/simple;
	bh=EOFGGSh/CdGTM4ZTodj/tKVj4mXB22If1uqXT2K79bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foD6cW1BFcxHZspZSbD9PmfRJt35SlgEzR7SPhJluvFotGBtu6FcrO0942lhYm/bRfy/4Cif5ecVCN12qPQYXvYwL+CpgdAXXffjKWasCvna9q9DAJcAG3vd279TFgR+vZtq+EYo666ojpmU+kOm9XB1P6ATbUjlKHn6dVAX1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgWwTqvw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc569440e1so3174975ad.3;
        Mon, 22 Jul 2024 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714125; x=1722318925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGYS1rUXoOuTM3rprISjfGYQaW5ybagqy7kbkfRMNRo=;
        b=XgWwTqvwjwQAbgT+NWeeZ/kbWanhlxXuB/8p6WDp80FCiQqcFgCAP0y5ePVZ6SK0JP
         psxAP0eHLf9RMdGCVgLxQPRRfQW96FB5LiTDc6v04K201XLQWtguD13UHD6TCJJjz0QD
         AmBSldh2ZhVKhAL/1/TmvCi7XUM72gM1P15sBqqBAljgBqKJXvME55BFrtQCzRhsCFod
         /9uBIZme9WJ4yO6RKC/OUk8SsxhDqgTTulkdGrHTwOAjWx1K59y4pfvR2kR/22Voba92
         TRKGduKOfMcLSkmrB/ktIsqPjJ31EQKJAEW1sctiaUJ/pvUpKj2+VG/jWPfEbe0lMjaU
         IQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714125; x=1722318925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGYS1rUXoOuTM3rprISjfGYQaW5ybagqy7kbkfRMNRo=;
        b=CcA2QpJE8MotKq8/BfXoLjxvH9Vqp+K2X0S+ix4VEtrxAv2uYy56qw349n+cE0s+lq
         6Uu2sxiuPohzUB7YVFvUHmE3Ap/S+/0/uscNV7gZoe/S1+PRpanfyQqqUklHwAku9K5V
         9RghuwClsO7gyh8+3GrlihNr/9fXHirkvsQomrrWpxtb67EvHHGquRMEYyYKkSFfZ8nJ
         p0H2tjZsALV2EbuSdTI9JTV9R0VvVwJEPNbfJuCPjH5xFAF8jWIGcetSd34PMIUMm5kP
         Ul+Yc+B5ZeJGdoTPMR76n7NxEClKe4trhW54Q+7FpXVQTcxzNjvViOK5jp3ISgCmGO3I
         4A6A==
X-Forwarded-Encrypted: i=1; AJvYcCWIEgkx5fiiq0mavXaEGwA+6kBM6+PbvaqAJfeiCOl1EfX0U635lcDhg3T+uk397RxcO20PNsqFG9chGuaFHu8+keK6mn17Bk8oJOEHBEnz
X-Gm-Message-State: AOJu0YzQwmyRVEx4Q1BBBTXtO33KiA8m/LKfE7B2xcKMg9QB22sZMq4T
	AEaYUTYg9sIag4VEBwuF2lfjSoaSDs5SmeyMJIr2/2df6hu/gEA/IkRyFyB3
X-Google-Smtp-Source: AGHT+IESBtppoiIyhYC2rcRc3ZayKUecAkckQmZIDFYC7ueHmYcIQEf0do88QBzuMPAmV3oaoBAMuQ==
X-Received: by 2002:a17:902:e88f:b0:1f6:93a0:9a45 with SMTP id d9443c01a7336-1fdb5f9feb7mr17418495ad.36.1721714124778;
        Mon, 22 Jul 2024 22:55:24 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 01/19] selftests/bpf: Use pid_t consistently in test_progs.c
Date: Mon, 22 Jul 2024 22:54:28 -0700
Message-Id: <c6447da51a94babc1931711a43e2ceecb135c93d.1721713597.git.tony.ambardar@gmail.com>
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

Use pid_t rather than __pid_t when allocating memory for 'worker_pids' in
'struct test_env', as this is its declared type and also avoids compile
errors seen building against musl libc on mipsel64:

  test_progs.c:1738:49: error: '__pid_t' undeclared (first use in this function); did you mean 'pid_t'?
   1738 |                 env.worker_pids = calloc(sizeof(__pid_t), env.workers);
        |                                                 ^~~~~~~
        |                                                 pid_t
  test_progs.c:1738:49: note: each undeclared identifier is reported only once for each function it appears in

Fixes: 91b2c0afd00c ("selftests/bpf: Add parallelism to test_progs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1677f6f1eaae..091b49bf671a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1738,7 +1738,7 @@ int main(int argc, char **argv)
 	/* launch workers if requested */
 	env.worker_id = -1; /* main process */
 	if (env.workers) {
-		env.worker_pids = calloc(sizeof(__pid_t), env.workers);
+		env.worker_pids = calloc(sizeof(pid_t), env.workers);
 		env.worker_socks = calloc(sizeof(int), env.workers);
 		if (env.debug)
 			fprintf(stdout, "Launching %d workers.\n", env.workers);
-- 
2.34.1


