Return-Path: <linux-kselftest+bounces-37021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE0B00885
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B311E1CA07C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220042EFD90;
	Thu, 10 Jul 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDkyG1vC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49679DA;
	Thu, 10 Jul 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164859; cv=none; b=nwjyxSYSA+KNpZ8HO7+v/cqQSML6PszqBjmtVuIvGqwDlcs8l+YmVxetmevBGJjR5VSYgu6IhJysHZEk8ABLr9mbFQ4B2Wqwl4/O3FMt54CuaH0bOi8R2iYi9zDnQx7Ytr442IpPNKy3eejNmaGtOkgsF35Zck8P/6CLqtQywe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164859; c=relaxed/simple;
	bh=wJfHiC1sS/a+pqT1rA1w86mgM8wbsreE1TALkPLUtAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwtz5PP0NWhAPkC/SdFfTm+V154UXWY3tDgXBZyAKTpe94XhpRDUM++xGyueriEeLMTabBiQd7FRwIn15lF9hN5wQ9MTGmWziLGY0B4RQVHvhnwkuknEzEr1g/8ih4NALSPjiAkF62fpusRFuUR25p5EAdDsTiAeiQ2/T5R/HtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDkyG1vC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7494999de5cso794020b3a.3;
        Thu, 10 Jul 2025 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164857; x=1752769657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6cWi0yuelDXwHOA5/MfrC7UNYQF2AtXYZA07h+2KSk=;
        b=DDkyG1vCQvjXua9Fp4ZO4laxWBlBDJdBRAhEKHuzuxVFNT6UFSqwJzqDfROXk+R973
         y2WdcUfkREAEZ7mnAVNeUc8zaLHh6hVdGIjwvEcA/R/rbXmJo17ev05zpvsXhhAQEDKW
         XyO8liFxmtyv+LngLZ2NvQbMIPH4jqRF1VAEgyPpulpCsjrPvWm0ev8/puWPGl51QRyz
         wrkUoS6pM3bW95r3crOTm91B7J44hFrPkrPUuXWX2izjKrSBZssYlqZf4eUIaNExwkOY
         TFUSY56Vbfq5xu2zyz8tkxEfDDyzC69WrDPtyGHYeNDKxLX85eFBghXRYfE1zPpjviue
         RHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164857; x=1752769657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6cWi0yuelDXwHOA5/MfrC7UNYQF2AtXYZA07h+2KSk=;
        b=tG9VqQoE6IchX/a1QxTYLWLY62+oSul5PxnfqpIl+j1x/FEWz1KfBiV2MYc6K+NWZ2
         1CftA6ROF+qs8295Ysu8Yl8a5SLGHRWJ7ESINYSWrxH3qeV7hbh2bX1t+Fj+KhbUqgvB
         LeG60XWdYL2knoTDgoR5tXiMKAgq+eS76JM7okqw+fD/sRqRpcoDR34omLFwihcwo/+O
         P6a01JaLsa3LvJktdVNWhH8F6I/HtnQbT8qX91OMMgkCGqI/wKtPnFdVsM4ZG/K6wBl9
         rtGiknZjYwdeMIBPwwBossOvzIdj/CYF+dr70gM6o69AaT1t2KmJd87+gpt+wAXs0WxY
         00vA==
X-Forwarded-Encrypted: i=1; AJvYcCV1NWpHlBo7lGZu0CQjm1fAJiIu4W03lkT6FW0i28CajDLmMVafA1xwS/C5ngndsrLZ4GhCYUBZ+0gP+7Uc3X+/@vger.kernel.org, AJvYcCV9RboS4G7sqzC6qmAf4GIKDrOy9PufsoMfleT02cF5KDatdVWXPjcu9bX1T14vkc5lDXO2M9KExBdzIhuG@vger.kernel.org, AJvYcCVxEAWmPqXozHm30nbPXtFgcmuPvoaHxBkbJk5KukTqwB2Ak5O9MtCQHhtPkimmheE6dds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDclkKdBy6kpueSrbnyr7xWNCys86OiWkNql4WVrXi0F7zJ44C
	DQWzAa/Tc0qf9dyGtYAgm26LBr1z4NMcp9TSBra/KeItMjU6bF0Kzxo4
X-Gm-Gg: ASbGncsmYTt+GWx3URf8UfAzvaWnHJt97JBf3EkWduiXDzenNgPW6q7pWnkhAsd2+j1
	QExViL1f8xUXbDR5QkABzvsKVrTGlNwo8DIlY4cI7UHG60OEFRGZCHKM0io8Np09VBH+1EBwONT
	rfTXfWjb8NdfH+dumvQll3nAb75nLag2Ly2ED3wuN/Ws4Roi7ilzaKO6jddBchf+UYIrIhDvanq
	ahtFw3XLxRyi3BRIZkL0/vIlsEPyKVJkfyTu/QOUfgrOxpI5GUFxPFWS6HWyrLbv5hUL3jaW59W
	Ix6sJFSgJiXOwJU0QvsjBydvlMgBTRvQQesPXDVZ9t8sJTJbc3C6RzfiTtMp/6iA0xJ+Z6IgZA=
	=
X-Google-Smtp-Source: AGHT+IGV/3TNUL0pQNBdMCIDPZiCGA3FM3Lt+7GvKHPRJlgBxmCPUkihESVw+GEZD/YPYOnf21GB3A==
X-Received: by 2002:a05:6a00:ad3:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-74ea6411205mr10643585b3a.4.1752164856902;
        Thu, 10 Jul 2025 09:27:36 -0700 (PDT)
Received: from ubuntu2404.. ([60.176.129.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f25269sm2690418b3a.107.2025.07.10.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:36 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mannkafai@gmail.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: Show precise rejected function when attaching to __noreturn functions
Date: Fri, 11 Jul 2025 00:27:15 +0800
Message-ID: <20250710162717.3808020-2-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710162717.3808020-1-mannkafai@gmail.com>
References: <20250710162717.3808020-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show the precise rejected function name when attaching fexit/fmod_ret
to __noreturn functions.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/fexit_noreturns.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..275d82fb1a1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23942,7 +23942,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
index 54654539f550..b1c33d958ae2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rejected.")
+__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
 int BPF_PROG(noreturns)
 {
 	return 0;
-- 
2.43.0


