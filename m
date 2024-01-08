Return-Path: <linux-kselftest+bounces-2727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EB82798A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F4A1C211FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98AA55E52;
	Mon,  8 Jan 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqNGgoPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921F55E45;
	Mon,  8 Jan 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55745901085so2785822a12.0;
        Mon, 08 Jan 2024 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747157; x=1705351957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8bFyaBTWGO9YtHUlCOAC9syiZawhLxoZiiL7FBJDXo=;
        b=iqNGgoPpML2o07UxouiH7o92H2mRes/gUTTYuYhHqk9r0pmQiXxK6z8dReJ7Y2m8C/
         nu7BW9T9tlpHiWkexaU5WLqZxqDjWHFF2dxZyvshwT4nA/9ZuIunJB7hnCr88jakNRSa
         3VGshDmk/Fq1Nw2SW8KCIA/+iSnG4KOOcpwqBieB+xNRgPg+iELgD5JEbUQdZ8uxkWQ5
         rD3KLL1DNsA5qOlv2MkSbPNgTQDirJ86zjrqFXRiGzJBHeByZm4N9n7LVNevK15m9qTQ
         wzGYmYymPXUDooIiKcCy8yfY8vAQQXh3AziZg2tb0Y1nMeBNAtLpe1TQXcyDfDIMnK7H
         vWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747157; x=1705351957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8bFyaBTWGO9YtHUlCOAC9syiZawhLxoZiiL7FBJDXo=;
        b=xEFiW2MJJ7Gj/ih9MBLAWFoAfiSYMxMmdzYpXahCs7xwBXFXYANgD2fcnM6WKSru7r
         bbFqkcuZeWxzYhwEjBvKL8fiEFjV/3VrJvay+98/DODQ8P5vwbL3eQdbIikkowGIarND
         tejyOQxeFDql0jFqFhGSFXmZur31f8Q9mRRSN6mppCOd/iPPzVF0cQ/+mYT/T4W6h6p6
         wa3cef8tw1REDU8RxFNC63vUCkccA7IO8P4wzWLibWgzMLNJWC7tqGCPnsDPNnk3b0/s
         kwt0e9phMfesPpViSvn/hAVkC/gxTWxWsuJ/7Z6hZCMGwlZRYb12ZcQDuNOVpdzLXqtX
         G54w==
X-Gm-Message-State: AOJu0YzuaOte9G4zYifbbXt4dc01f37xfX5pdSMKGGGyFbpbYgEjHfyj
	5deCnRnnSKav2A5srAUV3Ks=
X-Google-Smtp-Source: AGHT+IHkPlQbCTfVkOa1+Z9mPBmsAVl+28FS9fBT+EHVdi4HwpaWqFHpDxZzETVpBjbsT2PlzOx6/w==
X-Received: by 2002:a50:f617:0:b0:557:d5c1:a4ae with SMTP id c23-20020a50f617000000b00557d5c1a4aemr743628edn.47.1704747157544;
        Mon, 08 Jan 2024 12:52:37 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7df0d000000b0055422adeb00sm201966edy.33.2024.01.08.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:37 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v2 04/15] bpf: Make bpf_for_each_spilled_reg consider narrow spills
Date: Mon,  8 Jan 2024 22:51:58 +0200
Message-ID: <20240108205209.838365-5-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Adjust the check in bpf_get_spilled_reg to take into account spilled
registers narrower than 64 bits. That allows find_equal_scalars to
properly adjust the range of all spilled registers that have the same
ID. Before this change, it was possible for a register and a spilled
register to have the same IDs but different ranges if the spill was
narrower than 64 bits and a range check was performed on the register.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d07d857ca67f..e11baecbde68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -453,7 +453,7 @@ struct bpf_verifier_state {
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
 	(((slot < frame->allocated_stack / BPF_REG_SIZE) &&		\
-	  ((1 << frame->stack[slot].slot_type[0]) & (mask))) \
+	  ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask))) \
 	 ? &frame->stack[slot].spilled_ptr : NULL)
 
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
-- 
2.43.0


