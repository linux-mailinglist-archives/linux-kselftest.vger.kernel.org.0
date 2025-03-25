Return-Path: <linux-kselftest+bounces-29792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8AA70CC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B30D1899F26
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669926A0B6;
	Tue, 25 Mar 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dpLTqJz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3B269D1B
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941211; cv=none; b=tFwGGOyMbVQuXwFuLCuOpdtM8SJisj9UAQy7eNyjAsywmIVGWcNtffV7jypEEWreQi4JwI/5S+qOotrezZ38pthaHACQ//gWGGuDElgJosUuxhNggAWE2RwY9EfWQbop3gTK6dnveY9iMM6fN2ZMxBtiQ9ufRzGazh2eKfxUieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941211; c=relaxed/simple;
	bh=NeRkZlcvaCBRIUNhcAknsxh2pPI89exFKSolPCOwHZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXvK+fluE2bNLrZMkl0CnY4uzqEpvnau9GQqEMCUdGV4WAk5+FFT4lLe1iI9iivIQhUCN7phb5XQkEnS9QHjG4px0jREP+xwwN23kiglFQwD9fB2m+t1Zk3sE1KeAUhdwNgV/igvFmBZwjs27TG3JWS+ryaBO0nsoKrIu+9BrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dpLTqJz7; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-6f6ae4846c7so59752867b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941208; x=1743546008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=dpLTqJz77dNB2PodaHyDQmKAThY6hSgYyHc1wGnQhVzNj4cRGZ1fSiocj/tpNOb4VE
         ohxLDKa0NYyYGiXyqRxd8ltvM7nNq3FsXXfpdWrU2qnpuwv2x93r90B222FN5s7UGYj4
         jiwItdje7ozCLsXKGb+NqfqnWyuBNYO2xCDAu0oH1mOGc2NE8v8TcXvGJsLABJq6wzZO
         Fq3cZxJFatqh+FBdw5xlTabbCXpFWACN/YpeErCq0nJpbEPbu/1yCjC3ks6XkYqTbPO4
         QsHeb3R9DamnkkR9X6AlMoVOtlqsVJeXNlp+KFuPLpy1hCF2dB5tFGYJA6ISgNNL4qW4
         ArPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941208; x=1743546008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=YtBnZpY8WpWN318D+4AxYXHVgT2x+dZCUJ8NvXdoeEhMMaYFeSGs8Ceruy2g80S2Ns
         xVtAly1286g2+34LzA7QSv1GX7PYqvdjkELv9o8JBOSeezbU4094XQF15If7Mgb+3BxH
         MYTSZqXqay/PtJxLLnAgGx+a8KPwPv9mV5RfO3NnYgPIuD/AJ5t5S/2Dmf2+QkgRR2lc
         Q0YnLcjPUErRYIAfiTA3/3+bTWtypo4Css/HEKZ6TnWJgSJbydbmDFRIS1SXv1Y3BO6Q
         tAkoCCYx6HD6z4rBxYBiMyeAV8MxQq8ksOU1XEi2Y1kDHi+4X92OMGgapWxYqszwnssp
         Nd8A==
X-Forwarded-Encrypted: i=1; AJvYcCW9qk9ZGLJ1uFshoZ7far+46wzPn0gTnEdh1dCqh/OaOmVHxEJ+YnHJAHUrozGuXk1rK0kf97dnhMgqqM9APTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6eQsO+mmuToeCNk6dIN0FB/U7OmiFk8GO6TCL1m/OHHlmero
	s8Khy3x2qu6a+Gp1YyxMuQayVf9d0QxPMDIqDI97bfKSdXHzItoJaTYC+kr+CtB1/GpKHf9nNuv
	kE1KVe98C34HyIbiK3rGQ3v0F+W126JsDXPt4mrDBy4qg4QD0
X-Gm-Gg: ASbGncv8d85Ty6pVP+8JkQmUlJ6SjK9yvgPp1QY/nqN8dhJsmDZL2Jj+AeAzLQz7NUt
	q3zp46q8apaKqIWbO6uoX1BkGroAPu2BNTgFpLxxzQltNEvRUXDp4+zdOXUZyvQwCPlXzdj9we8
	ZpGSJ7iBsnzJCits4TuPG7HmPFTcHu2y7yju4i5cPNbbK+OAvKkoTuqpVMh5BmemLuiGJp7mNtE
	7mX1jdD4ShYXWr2JzU468OWLh9optTF8OIS57vSANr3oEzhfgEwR0NwlLNdp85V6AeuG00Q3ldp
	yWUX964uT3jGJeTf4ksgXLH7BPyN7pwIDso=
X-Google-Smtp-Source: AGHT+IGkV8dFuwx5r2yLmkio5J6J8fr4hQ3tR+zgbUM8xz8jKTp4WzA8Bx5pOB3XzpAT281kk+7kSZkfNhRd
X-Received: by 2002:a05:690c:a8b:b0:6fe:e76a:4d38 with SMTP id 00721157ae682-700bac5e14emr258757897b3.21.1742941208289;
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba82d5a9sm3786797b3.46.2025.03.25.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5B1ED3404E1;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4E772E415C9; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:33 -0600
Subject: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

SIGCHLD from exiting children can arrive during io_uring_wait_cqe and
cause it to return early with -EINTR. Since we don't have a handler for
SIGCHLD, avoid this issue by ignoring SIGCHLD.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index ded1b93e7913011499ae5dae7b40f0e425982ee4..064a5bb6f12f35892065b8dfacb6f57f6fc16aee 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -890,6 +890,7 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		exit(-1);
 	}
 
+	signal(SIGCHLD, SIG_IGN);
 	setsid();
 	res = fork();
 	if (res == 0) {

-- 
2.34.1


