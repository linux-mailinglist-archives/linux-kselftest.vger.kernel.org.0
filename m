Return-Path: <linux-kselftest+bounces-14041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1F93995E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EBA1C20D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69B13D285;
	Tue, 23 Jul 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZVqV2oV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD414634;
	Tue, 23 Jul 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714137; cv=none; b=eFsKcCddHVMaXBbtv/iVxVs3l2uVp7xOlTtfNUhKnvH+i4V67wMxom5KM7yQf8B9iwa4YEQGXrZeIBWS8DxnoODhM4WqW+MDVRYWng8aXwLCIc6gaImYeHl1s+RXvC6VlNaQrPzE44XVoh7fP20QAuFZBMq3s5OnCk2V7OXXiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714137; c=relaxed/simple;
	bh=xiObBQ5jb7XnfGSH1kzdorxlvHdwcVFjY3UhapO2kNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M82m5yyT1BcIMKA9GQNhOQunjSnOoD+eztwxycODoLX4QEF/SfKrUTT045eiiA5kamSxAejJ5A+YXWKfmd/IMGaD7mq+0Y8/UToZr5uUTEBLn8lpgoLWckLDrTIQdFCAbBK79JGjUQOSIlBhxe5Sbqa7iuoaJd9lguKkJS9zbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZVqV2oV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc49c0aaffso35891765ad.3;
        Mon, 22 Jul 2024 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714135; x=1722318935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuQrhWzd1UjXmeSYi5wTmCmvLJfO0MqDL+TpdjPdJ6c=;
        b=mZVqV2oVAPF6XqZlDwaiBugRWlKssQDZ7TXfyPQ3NsG/KgYc1ELFmg8o2c4dWzjrsT
         Atl/AUorFgmRoXz5RdLRQzh9Er9LzoaaCsxDWfr4FCdBNo4c10g6v2+8hK2MIIWgoPmA
         9zOIdCbfIIRi8gg76wkmozyTsnE3x/6HD38YR+wPFHTy9iXAT3hWmNASX1ki6txhagKl
         0bkjN3JbhD8UKgCLnnrSceSXHdFChgPCm/CA+/4yBIinp4xL7pWFjfvTRH1k5MrJlOhF
         P02Om1z+uGcSZUUKRKKzJ8G1U/WGWI216PMwRo8haXyIwmDc5tt+kSs/e/YJgaVgqoZK
         JDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714135; x=1722318935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuQrhWzd1UjXmeSYi5wTmCmvLJfO0MqDL+TpdjPdJ6c=;
        b=OixX57zWcTKYviMvFfxiGN360lvA8K0h+MssYjbd/FZZUNQTS5b8PmZg9/CfYFTaeZ
         /72VxPWKsYMXxD0g8B9PvwCmMEzTP85kQX+8MTAVJH+65DrwNBwXVyLObVkZ9tOhru2t
         mXivfkrtSykbipN3Zoa+wRfqx+Jlx8yhhmukXinDc3vOleU1zLO+GyhYxQR8CGUzFpln
         cFJVPlE4MVkSkfG1a7XihXCttU41wrJBdx5r8xshiT8RrSESJudmX1lKw8htHa3crJWe
         /TD8JX+uPdEkdiZcwczdZXj2LVtpef7asknqSxQrjYgpV+2ghKwTV74VxNj3tPqVo5Ud
         oO5w==
X-Forwarded-Encrypted: i=1; AJvYcCULcRjVJmQSFFYrysM3WmpHvaa8kmYHcR8xyo0pmgAttQjP+xh0rNJvmF1gc68+IrzkAzrzZWpSp+V3X+c/xAjyh4CENiz797vkxpcjdN1V
X-Gm-Message-State: AOJu0YwFAThXK1k8ww0gVy+U3SH9ABw/qNke+MzNkMX6O3AawsZwpBQh
	CtFuK9ZPqQe8kxRE0IV4IW0SxEcOOcalXN8e6Qgoo496CA67Tx62CLg87a/7
X-Google-Smtp-Source: AGHT+IEAQc0RzjkOrFcnZqABFAncPUK4CCaUUSy0LKjJZJVcKS1kDWYNe0ICwk/APOGy+IRGcBbmsA==
X-Received: by 2002:a17:902:f685:b0:1fd:8c25:415d with SMTP id d9443c01a7336-1fd8c254f58mr31605635ad.36.1721714134709;
        Mon, 22 Jul 2024 22:55:34 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:34 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 04/19] selftests/bpf: Drop unneeded include in unpriv_helpers.c
Date: Mon, 22 Jul 2024 22:54:31 -0700
Message-Id: <5664367edf5fea4f3f4b4aec3b182bcfc6edff9c.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of general support for unprivileged tests in test_loader.c
breaks building test_verifier on non-glibc (e.g. musl) systems, due to the
inclusion of glibc extension '<error.h>' in 'unpriv_helpers.c'. However,
the header is actually not needed, so remove it to restore building.

Fixes: 1d56ade032a4 ("selftests/bpf: Unprivileged tests for test_loader.c")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index b6d016461fb0..220f6a963813 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -2,7 +2,6 @@
 
 #include <stdbool.h>
 #include <stdlib.h>
-#include <error.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-- 
2.34.1


