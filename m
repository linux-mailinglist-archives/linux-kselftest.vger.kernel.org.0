Return-Path: <linux-kselftest+bounces-25984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E8A2C153
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5DD3A3D84
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16C1DE4FC;
	Fri,  7 Feb 2025 11:08:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBC1DC9B4;
	Fri,  7 Feb 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926494; cv=none; b=Qp8sgZxuaUH3XE5Ax2BSKO252KOxD4CW2fPh+ErZ+/R9ElzUPy7REt4DvYz36wyxtOka7U9oFGeeryNZk/As74n9KpLUp1zt+WcyFErKD8KKBm6ZWg+J++EBFe+/ta2I92AIzn2EwflQqkCTbrU6Zdn1GlfDvJMA9btZzVqkbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926494; c=relaxed/simple;
	bh=FXr2YRk6o0W+K1SCzkVuQ0zPA5u33Pz/k+U6e+ZtLAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OgqT7u1VglyfHpH8v7fp4UjvnxsKiq8z0nWz/nqAOMYLMaKvN3PA2OyMjXPCuBdh/200GkUx8Nth26Vfo893REKuX/XHMr0jwg0oFQUqtnUsfPOhIX4HxUrksiiyHHcpyk9iq+Wb3cki0YUyCWq4LavYf75aylMooJbeNwD7YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso460109666b.2;
        Fri, 07 Feb 2025 03:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926491; x=1739531291;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsRq64kyAjVQMzOmw5odn/YZS4WeBKPCs8/U4hV6uus=;
        b=mxg2bak1AxC01BMKNyZ6GBkZswbSHVk0RTZPLxubzNlUU3bpFvsfUxHMIE/t0ln3gA
         V1omY03iwUIO6w6kQAbYynGINUFkvER9wa1HTEtPtTWAJH9ybIo2uUNuwHZghn7F1220
         QHotgtsQqmpF58GEf+7oicVD6G+p43xE71/KCb7ZlnhJ1soeAzKWKEI3eB1OBdrHTrcd
         NIitE9LSkG50AqcL7MuUDCHpzPR71TPW5tnVlDhs/NourLwtmJYNEH843X/aI4RZin+k
         OBUafd9rGsI2AgOdOzoB5/3sr9zjYCH5VqLdYm44XmNtI4c21k0zUVh8F35I/R41VSJM
         HKUw==
X-Forwarded-Encrypted: i=1; AJvYcCW828JxGzGDUg4wum2FGfBGG+66IfK2qIttsFLPtnvLHYqk/9lMNmNG/bdCdlEEyi8l7Ck+puXBrocHitQ=@vger.kernel.org, AJvYcCWlQpY51UJflz1XgXwyHC0HVS821YqWvwgzfNObWe6d8okA7vz4LOy9Z3aru64zmgJeAHlqXHexYlUEV6hp+FM9@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2soaP4bpjLVDp2Dqg9e6c7f9lEXTSYDSd2NwsCpbo1QwRk5J
	f/vg9MKSynuPzLUmOkutBrQYbAx8L1+S30LvsU/vspH0k8b6BiVg
X-Gm-Gg: ASbGncvVDGvaj1iJFwQCbqolbeweaseOiRslmem6h/7SpCUbfPnc7mm4C2hIBtKhF6E
	4S3lhsXjO9W9Hj0CYryly9Df6uLcYBMit0xRxh4E459G4JMzZU3RawGk9FapAdYdlXTfPp6Se+o
	+/j68ixzkUzKQZUzgkbwRrSyQSVMt4nKZO9xhKi95K1DQaKiF0hEufnfaAGFYM3acFkpc/cmyHV
	b1gUd4yo9k1VCs++W9oO4hTB7nV0MZouIth1XN7EvrdVK836ElFIu1jHHiEpu50mrB2XTbqYcoh
	wvB0QcU=
X-Google-Smtp-Source: AGHT+IHcITL5To976uUv3g6/PFxfYoR5rQZeHW9vC+BYgEFLYDJUHScldAXv4hpMHHGpz7GOQsUrGQ==
X-Received: by 2002:a17:907:d08d:b0:ab7:992:7f42 with SMTP id a640c23a62f3a-ab789ba47famr300315966b.34.1738926490752;
        Fri, 07 Feb 2025 03:08:10 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79298641asm24762766b.90.2025.02.07.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:08:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Feb 2025 03:06:42 -0800
Subject: [PATCH] kselftest/arm64: Fix uninitialized variable warning in
 FPMR test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-arm_fix_selftest-v1-1-0d6eeb04299e@debian.org>
X-B4-Tracking: v=1; b=H4sIAELppWcC/x3MUQqDMBAFwKss79tAjNjSXKUUifrSLlRbsiKCe
 HfBOcDsMBalIcqOwlVNfzOi1JVg+KT5TacjoiD40Prg7y6Vqcu6dcZvXmiLI8Nj7IemSf6GSvA
 vzLpd5fN1HCfBGjmnYgAAAA==
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, broonie@kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=leitao@debian.org;
 h=from:subject:message-id; bh=FXr2YRk6o0W+K1SCzkVuQ0zPA5u33Pz/k+U6e+ZtLAw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpemZuPdqekyA08fFjtglkBR14jqQw3Uj6Uk0V
 EAK6v/62DqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6XpmQAKCRA1o5Of/Hh3
 bX/WD/4rUdj3lsA1jPbgX6PH+CiNh71KZM+IKE24sNk32JMUs0ekeLZIqNltEL+R9Vt33IPTvjs
 5EWNTIH0TnOI3gDcfbUYRqdBgGivRJ6sYdUYDHMqUhR5/7V+Q4/9uKwsludJfdhkIKvA/CpmGzV
 L+9NUd8J6KOQ2nlgOYGxCKSJrkvdB6CnnA5sHNCzv103BMpU8E+OlKCIWsZANEo9gEOr/0BhHTg
 WoZ79a7/0lFzdMWTrSiTlbboRvuuedd0tQdRqUGkIXtexuz8pQ0KK6ePj9BhZqOYnDkVsDbMppC
 dYcC62SFQRmj++AsQ1KUSJFQAjzBP5Y/GgG1PX+0iFFp792oiAeMxloI03+V/2VdY9iyHA3WmIj
 I8qUVxtvyZR5Wdc4V1VBPHwtJpcGwh6aJIOg9azqse2usQP1At+Wb+LuQCO8GOy6QtOVb6RX9Rw
 pLIio064AMoa4Fe8J4IEbNtqv+gqPIKfBLI7vQ7tEf0kNw5RQm6P32Z6q1ipgOfsfuHO41srbTQ
 ZlYpIogzy7ClYAN4ka6zqpqX35RyKi4FI76SZ56LXT386ReWB/l/O/zKb+JrjdeZ/+AJ0JRScDx
 VZAWI+tTR5dqYaDwPOUbSoHfZY8oHnrxXayVAc9IWftE3fhOjWQEp8HAo29XsN4dThRBfPniJR6
 zLrtjTZlKFbZN7g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix compiler warning about potentially uninitialized orig_fpmr variable:

	testcases/fpmr_siginfo.c: In function ‘fpmr_present’:
	testcases/fpmr_siginfo.c:68:25: warning: ‘orig_fpmr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
	                         fprintf(stderr, "FPMR in frame is %llx, was %llx\n",
	                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	                                 fpmr_ctx->fpmr, orig_fpmr);
	                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~

Initialize orig_fpmr to 0 to resolve the warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
index e9d24685e74194fc4ed1aebdcfd4c6edd3488e1b..26818860b223d367955d96e12d423fadc304700b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
@@ -40,10 +40,10 @@ int fpmr_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 {
 	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
 	struct fpmr_context *fpmr_ctx;
+	__u64 orig_fpmr = 0;
 	size_t offset;
 	bool in_sigframe;
 	bool have_fpmr;
-	__u64 orig_fpmr;
 
 	have_fpmr = getauxval(AT_HWCAP2) & HWCAP2_FPMR;
 	if (have_fpmr)

---
base-commit: 0d5248724ed8bc68c867c4c65dda625277f68fbc
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


