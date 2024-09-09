Return-Path: <linux-kselftest+bounces-17510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8266971100
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD361F22A2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B41B86EE;
	Mon,  9 Sep 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyYxgvd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9C1B81CB;
	Mon,  9 Sep 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868636; cv=none; b=pZOxfwsBL6EM72yrIM6cDozqD8KvkhGkOhn9fYwPzEHXFxhcNPFjpUFl49acmfi6Hl2ASeBY1N5j7DukHDpVXJGmX4PmeK+/FjftwTOjDBdeCmihdZHXPxbgnpi0Ntk9ob/wkrsmnfUqdQ6lD0r7Fo1SKnLN9Qmr2P4HkNl9kkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868636; c=relaxed/simple;
	bh=8tm+lcdAFkZHPiu0E0ltAWkkidqC3z2DF7qr9c3wbtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAIA3PCkpz//9uOTG9VEx3DmmRLAG2jKwsqDXF7kdZoNCHTyC5aUFVez55g9Rx1s2jxZGjxXWgYm0xgD5pOIoCqQz9GlHRBdxwt+ep8YgQ6b0i/68UwOKE8JrLqoP22S9zK6+CNX+uyZ+OthfGE+QW2gr6Dwv9HYntzC64ZxxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyYxgvd5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371ba7e46easo2647992f8f.0;
        Mon, 09 Sep 2024 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868633; x=1726473433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/MFlMnrTNocZP8/Uv97NsCue+ROk0MIWVg6GOd8r8g=;
        b=VyYxgvd54evCEafoNlAuhgUWcHwCr+YMQvF7blHA7eFVTQtgV0y/8364KesUo1RCNp
         S65Vq8KhizzLSGDNSYhRnL0vH3xzZZlebIRlL+x5dnUBfE8QQrKHB3xYgb9yk+w1wcxW
         f+m9WSmMOBeQ86toGvhPYDlk3YXuG+BAXglV6hNVkE8IwttBAihnPjQhN3r61gOTr2Hc
         426n2ukOFI5niZpOA9CZvJHlOyKrAq2zy4BTPREBPFPci6Q008sm2GsTFTbQS1YL5jbp
         n0A/rt6RP5H9xSqJGGhZ4VPFuty+4LpPtwBGHiyxxsmOk4tqQLGeaQwHQI2VNV0y/ORA
         gGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868633; x=1726473433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/MFlMnrTNocZP8/Uv97NsCue+ROk0MIWVg6GOd8r8g=;
        b=eLi4LDgpJbHeSKWsHmn7U5rCBOzlF2fwyELC4m3HOWeFMfiPKyyiOKLpY23ApoQbGL
         Pbx4XrgoVOyRXM50+R7CzQSGDj6bIR62brAo8DAGrY+9D+QBMjMmIhyUA2d2pJ2oBjir
         8phIMBY33efQwaEVEBvzmBRNOB6EwDBIoWgucrcMBArzYQx6ruQzwVXwZlaCT042+/Ti
         pAkle7otZ2sQQV95FWeeTN1TfPvTsSlbCSWQbpIsUV6OOTxxRtB1PBbj5ZZ0t8W1Ji3e
         PULUUpvtet9ZdADiaji0NfB656SJiYyMjyoowvq3iPA5uI5Vp46sTsSeQcW0EhNex8Mk
         EimQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ohpZrJtt3xyvFNPPyqOIUG+GWnJJgLGeEHMw+/81BVie35NdmdeBvnSWbyur/tJylCrrii/JzL65P5k=@vger.kernel.org, AJvYcCVEmple8Eo4jWQ0HKilsTuNnCNtmotaEV2kfLcE3JNdJPKS8mb4C653t+d2KRMeqgrJKtjrYYAUrpbIZuPe@vger.kernel.org, AJvYcCVukEOvplq/5RFJvDVI5s8skhNoMlDv26xpgOIcCHRct81Jl4d9FLfcPj6JF8rWD1DBEuqEmg934wtkgw==@vger.kernel.org, AJvYcCWXLfKh/HgMWLqbhSGwVkbTk1QqYBQ9AyP1t4K8N13bnA1789N3nFEecYnNw8/o3Gb1hjSwHoTFMiUvxa+lWZY+@vger.kernel.org, AJvYcCXNiJXVHwXyn34/7qq1ACZO5YCezazgkcWHhN8rXE6LLs7ywDJYav0seLN1s0Xt53U4u/IlQRrhX4cbKSFCXQ==@vger.kernel.org, AJvYcCXYaP+4OTY01SBmART7T+y9FysJJxL+lvNj2F3rYwO7iU905C/K8kl7tROX9t1K0HVEzJg=@vger.kernel.org, AJvYcCXy3EeU54mnzUVC00o/W6PegsLftJ3hY/4hl+9GHRdXr5Ixxg0Zhcyod+3nHXDnleZUXdZT95h9dXpDKJzv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsp1JVzFRsIZEDBjHV53qnjIej0uf6OFxsUsXIr685h16ErCVG
	4aG8087zCvv0ni2iUeT1u2664PiMAfMV1Y2l4CfEBnDBh8a2aK+IojRI6lan2h0=
X-Google-Smtp-Source: AGHT+IFm2UQfjMo+cDUf0j3lnU/Cm4mT7+HmOHGv2OWxiL1EKdqFzUE8umAkuhmwVoyX5BX+6CelaQ==
X-Received: by 2002:a5d:6184:0:b0:368:64e:a7dd with SMTP id ffacd0b85a97d-378896a5c88mr6503932f8f.53.1725868633211;
        Mon, 09 Sep 2024 00:57:13 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:12 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RESEND v2 17/19] netem: Include <linux/prandom.h> in sch_netem.c
Date: Mon,  9 Sep 2024 09:54:00 +0200
Message-ID: <20240909075641.258968-18-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <linux/prandom.h> header to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0f8d581438c3..2d919f590772 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
+#include <linux/prandom.h>
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
-- 
2.46.0


