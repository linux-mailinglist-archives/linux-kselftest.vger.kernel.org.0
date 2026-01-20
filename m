Return-Path: <linux-kselftest+bounces-49475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E39D3C367
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C593666ADC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822183C1976;
	Tue, 20 Jan 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI/5sZdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE43BC4C4
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900536; cv=none; b=Kiy8cGbNJKCVHi3ZeWWA15RZANgEC4kXsKTst07bSvKfo1YJD2JZPEoicMe1VMxcaj9rRGTgDv23vUtQLBusoTpDfP9uZAgoYXqXI/C1/xTc7D0vAUySBHF0cOAKnoAAdVpwDpGxP7YCLB7D47Ry7/+9pL1TplhybrMKvaBNEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900536; c=relaxed/simple;
	bh=D6LBuB5PX8Kd4CZf1+FbaPqPfV0TTpjHteNVbX70GmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfGa7kn0koi+NN/uTdZysLURgZZXS+IEchUUoMkE06RgruxkMjLK/ToLet6wmT2O2stQN7R6869ktl6LaxZfdFmHOm9vxvGvCJIGsij2sFSa2eEPdk5StxVGPEoUwT5XqER+QgTYFMBNOx2pMG+E8mQdC1tHmtVoWJCgwhSkINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI/5sZdE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso4248927b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900534; x=1769505334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ny+PQpdgO6hHDxqMIrR6HHnMRszhUy601KxoCXluSw=;
        b=fI/5sZdE+bXpcpSX/1mNDk0K265XTKp4HBLXWN6NF4n5B6FBW9gHRb7icwkmE15ZAB
         M84DGVAIki5pvGCT0qp+cs4CmuYa45zbQyEDUt51MpiTBbIO8aH0karDt+Ly9B5w837h
         llKOo8p7+4keH9Sxim1ApWr09CGb6wuiJv9C1Pf3akmuBQE1CrTncJm3yBEpO3oi0ssm
         I7TuByu/oT46Da6S+pF/xojjaKz/+1eAZJJExuMKesKFWUFUQCX1AMdrrUftaKuRgU48
         84Hpu9fwd1ZJhECu3VsFW4K1tod3QWZygRsypPgXy/F8gzD8bQqD1rCh+OngGyOyFdhH
         oVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900534; x=1769505334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ny+PQpdgO6hHDxqMIrR6HHnMRszhUy601KxoCXluSw=;
        b=eQv+8yX7hIuguAFW+MUPusfjF4bmpgXYsdqJDmleIxCbiOFOuVdcd5WvHwulBpISca
         7wDBwI/dTgLazHV5zVR5e6Z99UT8A5/xEs9rcDQSFtdNyFCsmhjF+rNF3cYKXtQ6m2u1
         hyVP/g/1ZV4WT8lrQQgsmbzRV5pRIhsiNobLjkkw4hO1ustLaEwOZOcJePuPGew3nQ8w
         p8gZskaojE6JVt/ycOT6bIj4vZfKPCbo+pfyHnBKDKDb1lHmXMiIkekZhgPaF2wIVctb
         qBd77grae6i9qgXb4qfc8ZHj2oTkFk8WjH5csFYK+vtfU2H3fDX8iFxC5Tvd78lQuvpv
         opaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEu24IxSWtzZ5oROHQMAOEodt7p3IWP1gMsev2vfIniPOLzUVa+6yHO0h76lbHBkIV5Kxg5Jd1V/xJ0xtVA4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgRwLXEPCHUHZTOPzQS9F2Istt4vaMYQ+hJjIvVH2VhB5jomt
	FSehuBAse27kCods2Q9nUwvOCcoA8qnNUAlxzyGkPcmR/KNPlE/FZkY=
X-Gm-Gg: AY/fxX6QuKXnYKFegwyhC63z0rZiE18VvlAoFx6hbUC0fjJzD0EurWp9XA7KJUTpKKU
	+jPI1DYS0jZBxH6kC3xaz9RFrGC3AGCy1D3JlATjfwp3j1vdPAXdoiT2vdeolSnCaJzOnsYnuLz
	T5XXnEknUIMYGK4+KeKW1k/MoSYmo5hXLuPNRdmSj1x/N6oIE+y03L9XIbxBigkjoRKnCA67erN
	XMO6ctXM9sLCHnJ1AXQat2YmpddAMOggFs8x4fQ1Wpg34ZSJmREujaNqqatsN7MAWIAErm/seNF
	u9Wqrs5hNByWQ/BhjFiCDZuI2T7nvztsw/Cn3ToQViRJYvY9tx2NIdcTdSqlKVShO8V0F3tMCOG
	i7sY5rOfqC/X1UD14vECyOlHAFvdcArP59AbO994ZmmcLnythaeRiNGYpb0pI7dC9eU4ctw==
X-Received: by 2002:a05:6a00:3d0a:b0:81c:632f:2ff0 with SMTP id d2e1a72fcca58-81fa01b9053mr11906026b3a.22.1768900534315;
        Tue, 20 Jan 2026 01:15:34 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([2403:27c0:c03:258::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278056sm11571169b3a.34.2026.01.20.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:15:33 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yatsenko@meta.com,
	bentiss@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] selftests/bpf: wq: fix skel leak in serial_test_wq()
Date: Tue, 20 Jan 2026 17:12:02 +0800
Message-ID: <20260120091201.1718-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wq__attach() fails, serial_test_wq() returns early without calling
wq__destroy(), leaking the skeleton resources allocated by
wq__open_and_load().

Fix this by jumping to a common clean_up label that calls wq__destroy()
on all exit paths after successful open_and_load.

Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 1dcdeda84853..b32e22876492 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -17,11 +17,11 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
-		goto clean_up
+		goto clean_up;
 
 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-- 
2.34.1


