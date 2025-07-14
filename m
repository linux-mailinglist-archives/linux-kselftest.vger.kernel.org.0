Return-Path: <linux-kselftest+bounces-37241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E6B03E3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0FC1A64A56
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BF32512E6;
	Mon, 14 Jul 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSmkUx2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646124EAAB;
	Mon, 14 Jul 2025 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494678; cv=none; b=AjVy00Va6CfJUAF+ICdJ8HqXzg3rN4jxPB8Bel/vk3H1h8j6F1vD2TK0t45una+ZP26vLFeranvsUcvBDkvrAqBJjdFp7ek8vOB0A2OzJ1qyGKX1RoZGAG+ZkzzzM9NZf65NBHLeO2RUpY1nMd1z5PxTB5DJ73cTe59ClW7rXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494678; c=relaxed/simple;
	bh=H7oTJFuFIyERsBW2ISyPbfXtY1Ablg22jLepeE+FjN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeJWs5iYzRkBc7Lq5utZmpesWYr57Ko0mR55I8QIzM1EgbGQvd7+3z54W19SCB8KUdVVhL1nRsxup6WCHrmL5CEomMa3VhltxzYDtUwkZ6AtDj9tqgIpFtTpBfHVLePu1Tm9u9A/xUS11IOP7bZYAvzCnDkQOqOUBGr+EEFU6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSmkUx2D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23aeac7d77aso32519465ad.3;
        Mon, 14 Jul 2025 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494675; x=1753099475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HOL4OxklywxiGA5iGidxlIY2WERw1fjUeWMUL/th7g=;
        b=WSmkUx2D/ZtLGNwz26zVXriNhBrSG4jC7FgfUiPMKkphr8WLrj/zdMaS9Gfu8PhsX8
         laV2wRiLO9Z38MEmtMfHhIdL5+TYJk5XjBHzCCzx9Wzip5c/bE6SBV0UeJZW2OJQh/MO
         Q1YENhOJFc9iEuNEHJ44HmUgMv3acVhL0UmqgXYtDlCNFiLEaZsPAQv8Go3lVhcxaYBa
         Z+CFN+NNNxIgCycM7DvWcOKtgkLQjrFR4qbbeJB7gyi0AdPrIdVPPPUDP4NiDvWKSx27
         2rI5Nxd8OjH/p0wojB3LKe00zgkYO5KqfOEypAUHJR6gi83S9uTAgC44zGTyfgi/UFNp
         +BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494675; x=1753099475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HOL4OxklywxiGA5iGidxlIY2WERw1fjUeWMUL/th7g=;
        b=q98BVRZxnusyQJfqi0AvIhvUqrlG8x1S4XmGWoB07+eBrOS/O6kPtJQqGbrdTj200b
         d3O64LT/u5/6kn1PhP4rKSYLL9vXru5hzAUpGEUVUSw7iUcUI1wEQknyDO4o3/MAfcVI
         PWUAedO8+vDztN6I15IzpVj8LMghgTVNLqmJz665KmNYYHeyru1yvxfhNF7JBv42DNns
         ckBZYhqLMhhjhwYJ58E7cmFQm6pH0CBKXQNglPf4PJN3yNbXJCqs2UJATfNUkMukTpmY
         wnqY2VIx48uJFVvUSf3OkuaYjvyM61KnTnspfVVyEaXmCmqTeLRotJ+iu3oOLSpRBAT6
         pNQg==
X-Forwarded-Encrypted: i=1; AJvYcCUAAXzx5J9rd888Clu6peyLEoKaGB2g2XDofoT9VpKHHbvnxPUSKn3gMhtPWEtrxfNro9g=@vger.kernel.org, AJvYcCVDWSpuElTF4YlFbSeiWwOqeW3Q/xw+MkT7UQCen6fx0hAxgQlEadMyXozOMfDz89sj8FRrdAt+r9o/gvko@vger.kernel.org, AJvYcCX0lVeyhyOJ/T9zd+utqW9pyG42p723LQz6Vp/LACTpBURPbjvp2xUwBGg401imK/n9hZup25PB7TBjp6MMmezb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mm+0K3bRqNk+DWirOj/ItHE8M3T3TtIepFwunJc+gZcPiN2s
	g6aACWNubaOUPTWGJpQ5EolEqDgiMINTnIwcLekDUCySe1xgBGXfVcRo
X-Gm-Gg: ASbGncsqYmdnD9jC8VgjB2bc5wuDej5NkfW6RZgOI6dtC4ZXlNwSmG9YI10dXhJlKTb
	lOtY5OcXFB/jgCmFJAOm38AwwW/ulzQOhsx7B2T6HHZH8IJwLMwt5QzDJ4s5GssahSsrZrttE+g
	oVdgMZbYjAscZ2/5Ft3HquXYqmIQTxhavSGySrWMyJ9VW6zXqX9cwQZF1KRkusMqJ0+B9RxNLur
	LmJjXk/+5PuZ59xsekYsXLgAYauJRITMdnjmD41lpztuYe5rrGTq8dQ8+nGBFeDN1nPKzUx8tiz
	jIKAeb+GtBczzh3Pc12RcuDx8juALf9Ucez4tshlRkFQGicezWwlruPLXjTt0ROhZYtZOLf2IlM
	/J8rf1v9WBDaPcYW4ge/eUrU=
X-Google-Smtp-Source: AGHT+IGvcE+Uo9+SjSTryk+Utr4kLRnWYxF4cqz82SFWAFSEkRbgN7g7SO36Q1K4EQXyhIpV7bA51A==
X-Received: by 2002:a17:902:e5d1:b0:234:8ef1:aa7b with SMTP id d9443c01a7336-23df08394b3mr143544155ad.20.1752494675192;
        Mon, 14 Jul 2025 05:04:35 -0700 (PDT)
Received: from ubuntu2404.. ([125.120.99.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359e4bsm89612895ad.215.2025.07.14.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:04:34 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v2 2/3] bpf: Add log for attaching tracing programs to functions in deny list
Date: Mon, 14 Jul 2025 20:04:07 +0800
Message-ID: <20250714120408.1627128-3-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714120408.1627128-1-mannkafai@gmail.com>
References: <20250714120408.1627128-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show the rejected function name when attaching tracing programs to
functions in deny list.

With this change, we know why tracing programs can't attach to functions
like migrate_disable() from log.

$ ./fentry
libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
Attaching tracing programs to function 'migrate_disable' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 00d287814f12..c24c0d57e595 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23942,6 +23942,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return ret;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		verbose(env, "Attaching tracing programs to function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-- 
2.43.0


