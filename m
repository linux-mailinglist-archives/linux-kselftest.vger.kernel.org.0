Return-Path: <linux-kselftest+bounces-27647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C21A46AFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702397A8A94
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16002397B9;
	Wed, 26 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzm/OXZ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38072239584
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598108; cv=none; b=CXRcoOM/qqkJ4gSnFj6RS4BDGa+l27kZME9TGH2TrrAYpcSK+dU+qtDpDNFg+flpXRQKxbmCZRTJjGm9RUqvATfitJezY5RgYaNw8OpM3C0GE3UJ1Iib9e0s5MPF/Z52dswQ3EPGQNoRgX5Nfy1tt8XFmCKUW7vOUJvdGSsiKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598108; c=relaxed/simple;
	bh=tmN5JwTaZ421JUVQTXr4tJNOy/0VgsWNPYovSN2FDSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Om7GHe/Kp/iRTQDlPQh8qV1GS7k/wQ6wPEEEv1Gpoyr8M0ppnF7Zwbd7zLzKgtDcSraDv0gkfFiof/hN84W5QL2difINv+dGW19QoVn2X7pyg9XNZCH/EvGvCv6icYMbn2Ea82zav8+Ak4q0kHKUojwgFeId+yqZ3tVHzyH/kZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzm/OXZ+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so414690a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598106; x=1741202906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=Pzm/OXZ+TgUygYunrr38Ff4cgRZlJiJiNBJm79oEzx/i9MN5qv0SyOepDmYspAIIWV
         DFkLy2p9aKgT2LaFlnVpwOaUCbLWO5BpwFQj0mnHjQmalnKuk0+ECQiHFx6jlSV0nEvK
         0WlOxUAKfJQFoYxY3KYtTreUK0Nb+D+xqO4HvAjPCrhq/nUMziPUUn1gks6AwU3d2RGY
         eIFtLF/GXT/yYeGzTTwjXnoLcoP+0hpYlJMPcaEjAz/DDTJYA0RVRVDHbk1tnDOTiDcg
         AT7o1vx1+0V35NKKGp4RQR7jyLF8+NBuz4e1bu0yor8wHTUuqxHHdJcbvb0P/68hDArA
         WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598106; x=1741202906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=iOokq+aNo8byY/8kO0Wn0CvqEpx1HRDD32JCyTuJjh2wW6lmeB+7lJwrgwO72/bqei
         l2o6ZjCFV5VTYHOgMgFa15dBH1qtUojHxurC463YWu3HxzjT9gkvipOjuihVqfPP7ATz
         aDSKvmTaG/DvHRLs6TYECPoT3R8zFOwoikE1nqFwIaWO/JkR/QIo11u8Ar4tw62seuxd
         WOifYvt9MFlILXYX6P974gVCFPkWHdztjWWssUkFDcKFMcAYoeTQQAnRvTbtdDWGVvH5
         3CeXXOCF1vjQZINNC9X2tGnhp20OWp6HVq5058QEGBwvO7J8A5Jm+VM+n0gAoedbXGp4
         ZN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuYcTWTlBLRxKW0hBJKBFRvBED4yppLJ8QlZMm0M7Xbsd0l51Hn5PsRRPfydlZ5vu/e9CYSgVPyhCODEFjmWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8TmSvJX7olVXW8KNrSnEJLdkFnhqeSdXRYFJc2gEbHB3Npju
	JpiH/L1YqGOgf5cgITmAw7zvo3cYLXraIffn02PmWQshRLLT+Ku86f4jFn+aEFigpQrHoqDGUu2
	A8BqvsroR
X-Google-Smtp-Source: AGHT+IH6eAP4Cyst+V85LJmLhx2Rg1bDfnJ+WmNbTdbRluW4pkEzVr68R+e3txlLoA5Mp3lBArRubTvC02kHFg==
X-Received: from pjbtc16.prod.google.com ([2002:a17:90b:5410:b0:2f7:d453:e587])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5243:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2fe68ada3e8mr15762000a91.12.1740598106543;
 Wed, 26 Feb 2025 11:28:26 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:23 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-2-krakauer@google.com>
Subject: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct exit code
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 02c21ff4ca81..aabd6e5480b8 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.48.1.658.g4767266eb4-goog


