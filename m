Return-Path: <linux-kselftest+bounces-30641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A13A86E44
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88700174B0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F82036EC;
	Sat, 12 Apr 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7bXo9Un"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03301662E7;
	Sat, 12 Apr 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477610; cv=none; b=k4JBP+iqWED0L9dTaK6NCvNwcJI9IqXVB6oYZmVxfD+4SkMQDYqC9Yyq4b1d5xzLwF/8S+BV8ec8pWv2dDnjDT8leAR/xKVjCy1lLt3fhUw5JvFhQaWFg+X+dvS6ouKOZJTc5PQkfoPMk36kq+NgcPwGMjYTBHDYJtVWfrXUkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477610; c=relaxed/simple;
	bh=xFYhN6FwRAsyWFqlpeGlTcvXCPwLaEf5hlQEci9C0+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRPxORjKnDFSSu/zIbp0821T6MwWHophCrhi30ryGGEI3M94qOByAF1P7+qIQ682Wlf6kr++8dUjszIMvgQyWaFvci0NQy/J9ooEwbRBWzYifqwV5/x+eiswn3L5luQixy9fPgGEagg7VrRVOfFJuuwAGZh2kliXNH5zO0GvI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7bXo9Un; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7369ce5d323so2490060b3a.1;
        Sat, 12 Apr 2025 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744477608; x=1745082408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWvWft/Ilf3Ni77MiBJ218Cck/EYMRSjxeQtmM2Wmk8=;
        b=D7bXo9UnXh9O3jOVfE4wlWRhkoiCUga7MXJCA6nyR9AN5RA5x9uUb9bgGnNSUEkBwN
         /bK6fr4B6bQArjdqpLzNGOgSgV2DFilvNZ51sqMJXzzorBAXpNiN2zHGe/2o1sHlBUvR
         wk49SFt9VlrJZQ5NLfM9M6DZNVj2+OXpar/ORYXgUfk9V4on66PxmVJq6w21TpyrUgSj
         kL8HkeskFECOrSnchooqt4dBPIgh190gX8XFHzgnl/Sj81GspiDq4Ts6Cj6xoZRnvkQz
         WbbhLUzn1W8rDvwS0TGZtGWCg9smxYwPhsWARRDtMa37tmJA3DawnQ2o7zvQDGYXiNus
         4rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744477608; x=1745082408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWvWft/Ilf3Ni77MiBJ218Cck/EYMRSjxeQtmM2Wmk8=;
        b=Sjo213MRdZoy05jigNCHxJKcc9Z0iZ1ESXe+5Dyq43kmI+H7dLoYCBNAeiY6orh9K9
         +O0Ruc1uTWwkEz5Mj8Qpl/Rji4Ju7d8h0swouo/fZ/wHrveRFHtLcIs8Ne3Lf+MT0U0u
         2rZ14L9AaEiYLUBDOPCZ7rrOYeVf6/LRxa6qMzVYUzVyri69Wz91j2mxNuunALcpqmfL
         p7NOsp1VothFc8trowi3G+Y8VMp0A2eUjxAq36yG1KOhjjx1lw7m2/83LOrl5j0OuTbD
         JF4alXDyedz5VIuk+n13j1TXhrNbTTcXObs7hsa8I6Sd4zGRb4ZTaXygq/Liqsug6552
         VSSA==
X-Forwarded-Encrypted: i=1; AJvYcCW4cF4un2UQQTKzLqlvXeTVanjY7MLSuiV+2lf11lrZ/2yLlUxsz9ustbTTXjRrDrCEVV/bc+NOmS8Dm1aXmLAQ@vger.kernel.org, AJvYcCWj36nswBjzg12RLh7/de+sokovwDBPkxTZpm2CoubRcevYrEg5TkM5zqyvcsY5WdDHuGVHjrUazOIlWN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9qyu49wpw1HSPT9JDQBfLb77vMUcOVuRD+EgzXrOa/qrYrec
	pcXpKkqQ19I0wzYcB0DVc1VoXxc4r4J+3pTmXqoOLHUfsq8J1tJp
X-Gm-Gg: ASbGncsOa1AxOLPyEZszznoVyNzulRmnLpJ0z7XiXPMFx4PhDLbMo5mHtcUL76sr6BT
	ATjOICC41Rui1nDzGQiH7oK0QrRj3Ie3SJxvPkaOaVVOQv5EUagCT5atUuGsaMM5olh+h0KKslm
	bxDEA17p7XfiJ9/97REjddsw5ZZBbOo+6VEK99Snj2DaxkAePVeokWOOv0RNIvmKA0Vyyk3kBEC
	GTZUd9ga9+0IHL90TjMzdJFWQ+FJ04SW/LRCzEPEyHd+iOP9Fst0z+pJbyWQvqNcDtm+QBvfUXK
	qL0/IWJTJftZXOEwWSCZmi3W349MaCQjjEAlMis91FyF
X-Google-Smtp-Source: AGHT+IFF9kQVXw4HN+npCAkPkNtd1zKYV9lEhCojLLriVZO+7NCdzgR6hv2pjLwmrj5MuNCYLsPKyw==
X-Received: by 2002:a05:6a00:1387:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-73bd1202f32mr8107832b3a.12.1744477607784;
        Sat, 12 Apr 2025 10:06:47 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c20f3sm3610710b3a.39.2025.04.12.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 10:06:47 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test to access const void pointer argument in tracing program
Date: Sun, 13 Apr 2025 01:06:26 +0800
Message-ID: <20250412170626.3638516-3-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412170626.3638516-1-kafai.wan@hotmail.com>
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding verifier test for accessing const void pointer argument in
tracing programs.

The test program loads 2nd argument of kfree tp_btf which is
const void pointer and checks that verifier allows that.

Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
---
 .../selftests/bpf/progs/verifier_btf_ctx_access.c        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index 28b939572cda..a6cec7f73dcd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -65,4 +65,13 @@ __naked void ctx_access_u32_pointer_reject_8(void)
 "	::: __clobber_all);
 }
 
+SEC("tp_btf/kfree")
+__description("btf_ctx_access const void pointer accept")
+int ctx_access_const_void_pointer_accept(void)
+{
+	/* load 2nd argument value (const void pointer) */
+	asm volatile ("r2 = *(u64 *)(r1 + 8); ");
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


