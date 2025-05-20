Return-Path: <linux-kselftest+bounces-33427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C5ABE4B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45D71899B12
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33328CF4C;
	Tue, 20 May 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVdvxzw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9A28C5C9;
	Tue, 20 May 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773051; cv=none; b=Y7q1GuWzEEfuoTFZJwRAAq0Tzq+noBEftylQLqMovXmke/KKG7WjcfLyouwU2fPimvExld3EhD+SQGAyntj55LZ5HGBw31YPTcSPMpfRsyFly9QaPw2+EIDog9NquJxUIO+J4/xfPOuw0v5cqvuOU08NKxiWQqxd1T37O8LMpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773051; c=relaxed/simple;
	bh=bcLMozayoGqEz52RybIZIVxk1TOssx6utCvVWOzGK68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQRtW8nkEbJg5mOL8h9cfyvzonmCmQjFXG8UV/5cUQ3YLyFVfWQt8Ce2D5IWvMxgIXfSvUW0nzvBL1fXgcpYblHPJF7htdERfbqCBVCArEhURK9ELsooAVTMITvKLcTsPWz5Cufzpc2iMgBV4MozisqvB9jm9Jh5nppFI/qiZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVdvxzw6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so5692690a12.1;
        Tue, 20 May 2025 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773049; x=1748377849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eLzuw0HTNUjJ6jLhtDsWvEva0lYGbRxIzrs1qJRnlo=;
        b=DVdvxzw623cHNW4QSpA7xqceGOvJ1svjD/nWKuIlEsaRNkQ77ywtw8kZH2+JywdYzB
         Nx6nl872uu/+87hm1J8tIW5hLxMoOcu+cyuRbzOuVoA6f0+AxLbCN3Rzew/8kkWd84vE
         hVE5h3rHUi8NJZ3T6zaDamJVUjJLykzaQJ4Ao01ZuqyOjr4L2Sjw/HP8kYma2AUqOhkY
         XpV0aEjqLTMbpK8lvt0VZ31kTExpSIFZo8nYzfLdBx2lO3uC8PN1Lb4LtJs4pBualnpK
         16jQIoe2yGuMmRyAvSxRmw4cldUQ9TtyXTID2ja6rcxQRkCrujzBYL+D2L0Qtqcf4g+A
         CmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773049; x=1748377849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eLzuw0HTNUjJ6jLhtDsWvEva0lYGbRxIzrs1qJRnlo=;
        b=slM2QLi1x5/R6Gdz2nWrRrvqBWtQgAHUGvGTbW/89TIXxOGvx3+aMuPLPabvHeZ033
         pgWITHSLDPsqWuXLjvL222t8xwk6YvfCnbGGMtVzbaXHtnUZc+RA6wIhKfn+c6IvGKic
         zRO1M89HjckyN4PXUivaz45W0BrTzi8JGsUXa4gtoMOWGSE1CeBpU6GigG3GM3Cjp4cJ
         xgqTs7WPftE8en3tDCNKeew74BQB8NKQmTQEs5va74BkOKo6b0gTk61MLve+9GEqQ3s0
         +ktkQYZWBtwqKT3nMRwg5nLulG7s+kMSO7zbezRAF2SLFl+0Yyop1dlu1BhAI7jYdSVC
         Q3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSh5L2/yyiHdzP0g7EueYWW9p+PvneBAA7tjrVhDzocC3gH9a2EsdjFX4SyhwgFVfXXyzE1U1Jlk87lrB3x83P@vger.kernel.org, AJvYcCXd0LCd8vNCV7FxVcRf/mNvw7Z8ev4dG0MMPZ9xvAzjPWPIh1wyeYgrQ9rXbNIwwtK7LJgDCNkj0i1VXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNbk2gXmLCoA/be6DQDrwMmHX4LjrHmNVDtogk9i202enTGNt
	Q8cpOOOLuvL/7SktmQGP74cWNMkpJtrVCimYzJV7WHDISHBCGWTQ16O2FuLN
X-Gm-Gg: ASbGncsg6wks2De/Gu81uAWsjpQ1x33LYR6M8J0zioWzuZ1z49QOQ5mJRr/08l2zgfN
	EeassQceJ5kJ6s2VKtcEIg/Mh/+/iiEUvGUwVhdv1Wuxbgzu7lsUelSNo/+x1mdLZnKPzAude2J
	V2vvQfEt7hSqzs1BgOukOXwqhzy35YbAql0BbCC8QDagQ6MlgePn8q+l42tUbIZVaScenQG23BQ
	QLC+AbnmTB3H7fivXhRd1GRQ/T+OUAkZg5lvQcxPb+gUepzLGsmfH1594kQc5Px0rRjsdWt6dyx
	rR/6rDvtvFzjd6z9lO3+aovqD+B6MJPkz1uXQKmIacNzhOmOMpmSs0gGCOZb36vBhqnFCyfu9m5
	OBW18bun3se7Z
X-Google-Smtp-Source: AGHT+IEVUmgvjua+d3P0w0PYb33BqOETSqmjOHNLhMRKnH3Q74/tsD6IDoR/Hg1n5IlX3rYVJCZ7VA==
X-Received: by 2002:a17:902:f707:b0:232:11dc:d95f with SMTP id d9443c01a7336-23211dce734mr166616845ad.4.1747773049010;
        Tue, 20 May 2025 13:30:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ed5737sm80021205ad.239.2025.05.20.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:30:48 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	viro@zeniv.linux.org.uk,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sagi@grimberg.me,
	willemb@google.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	stfomichev@gmail.com,
	jdamato@fastly.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: ncdevmem: add tx test with multiple IOVs
Date: Tue, 20 May 2025 13:30:44 -0700
Message-ID: <20250520203044.2689904-3-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520203044.2689904-1-stfomichev@gmail.com>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use prime 3 for length to make offset slowly drift away.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 .../testing/selftests/drivers/net/hw/devmem.py  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7fc686cf47a2..d7f6a76eb2b7 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -49,12 +49,27 @@ from lib.py import ksft_disruptive
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+@ksft_disruptive
+def check_tx_chunks(cfg) -> None:
+    cfg.require_ipver("6")
+    require_devmem(cfg)
+
+    port = rand_port()
+    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+
+    with bkg(listen_cmd, exit_wait=True) as socat:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port} -z 3", host=cfg.remote, shell=True)
+
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx],
+        ksft_run([check_rx, check_tx, check_tx_chunks],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.49.0


