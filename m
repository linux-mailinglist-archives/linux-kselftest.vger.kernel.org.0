Return-Path: <linux-kselftest+bounces-19087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5399147D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 07:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C42EB20EE1
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7746F305;
	Sat,  5 Oct 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO8C2kHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57839FC1;
	Sat,  5 Oct 2024 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106191; cv=none; b=RSmPeDmxiKKvGlfLjdPJMeB/xgvfO3ogSzQavNfMDUiZ9X50qcPf6v8aBXbySO8YpJ4n8QUgE2vrMYLdMp4gorpU9mNI7fXo+PSXZ7HdpHBWp7S+HXdNSszKhdrKTvCK+4bCqbMw5IvED1VFDRKSrFrATJkGZwS4V8ruCilU4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106191; c=relaxed/simple;
	bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3yvgVhaSM+0x2wdXMOYxylgCbJz5ROOgYPlNjadJnL7GkVn7S6rVmJ29EYK9yBE60bfDXD0O31sPAuEESCdJW7TSzI0whTxZqUHpNIznRkegIbLnnpHQB5tjq4HccyiRvYxAb2jdckLg+73rf3Spx9Q5n33dIavUs1xGNILp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO8C2kHk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so27363935e9.0;
        Fri, 04 Oct 2024 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728106188; x=1728710988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=BO8C2kHkck/XIAiDooBGUfTU5TCAS2jNKrGvuhvNfPiaPr1UzVvJEcKFsZGjizR7ay
         Swj8lGdw56ZY5kD+yokXL3JAhwiDM2BLp/+8Z7en5vme0BMOOyMDAvMxqSasxuXc8IGT
         Z+jhNGizLWZFpdFnKDrqbDi1oRQAwmiWhyQhGNppOS5k6196A01aI7M6JIs024THh5mS
         w2DEVIJXvv3UNimkF3GlbhKJ0ojOdNUWq1Bm34MCyhf1KyD3nmdwE1bcWaOmqfwTbSoH
         GiakDJKe/tt1IqqdW5hWKeIolAbeqMnDrAkshuCwJh2rwNjDxi0YFMPTb8pWG7hQOYhV
         BF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728106188; x=1728710988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=rHuxsnJwZvEiWxhqelIynmxUPuDRYAgeR6qU8vDfbml0/4B7F71M9N6GlZ0WfZzaqz
         jJ3T1GqxfoSVijdKQmRwjLNOli/T7eXATzIR5RevxFGShxPQhvIzEK7FAprhbfrNBXSC
         3TeL+t4i/rAso0DlDDfg5o2Yn0B+5eeXqcwoI7F3kWeOJd2Ya7FElzxwD9gshN6777xB
         g+00cBAoctq7CPwrqKx7USRR48leJkDoq5eo7fNNh29+ULgWo2v4H/YJU4lfMU+3fQZu
         2etdGMETEMjaljiDStCULf1zyvh8q/fzvJnRcrQQlT8DRaNNook5ihieXSWLlZdxZZcU
         cO6A==
X-Forwarded-Encrypted: i=1; AJvYcCVR2DXay07PsKQjOLtvvYoOqlYnPkOZPBK1+euXR3Lh99YorvjPaEQ4iFdkD1bUXi+BG7NeUslogkGUy/M=@vger.kernel.org, AJvYcCVfrFyqnZ9DMdxJNx0QuybiN3HthBAoK+CYCq4wHTkKuelhxrCB5PxQGaAT0l/dBhrQc0Ti0j77kOzgiA==@vger.kernel.org, AJvYcCXU144Lcb1D7TLD1AoPe18/FI+sJTbPIY7iw3UfESXHaq/69AGuwLUGCYppGLmI57ko9stRxaGCxA9PtNn/S42r@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjAJjEuehJMQ+YSM8DKq2isUee0HnoeVftCcS//AOsjafExiR
	ZXtu8uDOI0opPRdQTczcRVg1oqGgSzRM6WNfqUnFaiDjUBtWQyCF
X-Google-Smtp-Source: AGHT+IHs040QHXHGwc6YYq/WXRpFdCqLNZLLjxrMiIvQ4JlAVjsy5SjLx0mIEOB7wUcbyIykPy43Ng==
X-Received: by 2002:a05:600c:4ecb:b0:42e:93eb:ca26 with SMTP id 5b1f17b1804b1-42f85aa9258mr38062385e9.11.1728106188083;
        Fri, 04 Oct 2024 22:29:48 -0700 (PDT)
Received: from [127.0.1.1] (ip5f5ac341.dynamic.kabel-deutschland.de. [95.90.195.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm13103105e9.45.2024.10.04.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:29:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 05 Oct 2024 07:29:40 +0200
Subject: [PATCH net v2 1/3] selftests: net: add msg_oob to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-net-selftests-gitignore-v2-1-3a0b2876394a@gmail.com>
References: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
In-Reply-To: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728106184; l=629;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
 b=IlvSfmfV/hWgk/JqrXQ3SjlT5PHzqi2dhcaOBgH/hnjY0Q5lnayClcUZBbMRsl4BKvK8A1hLp
 z+VH61R/vTHCES+IvlkZB711aY8lOGsC2B7o/zKZmuVzYJmOWlNBjf1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This executable is missing from the corresponding gitignore file.
Add msg_oob to the net gitignore list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..9dcdff533414 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+msg_oob
 ncdevmem
 nettest
 psock_fanout

-- 
2.43.0


