Return-Path: <linux-kselftest+bounces-42775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F4BBB92EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 05 Oct 2025 01:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172AD3BE0BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 23:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72402566D9;
	Sat,  4 Oct 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPemoOJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568B254B1B
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621836; cv=none; b=WSjeC8fJKtrzNQfp/OBUOGCMaBxkrTveg7AWOjIsVrTowiQp6UhFbxkCfm+CpgUJo1WsaMYRcf/b6TNooFk7XFH2hTsYmWQzaVHSVtO4TNEWPOzsQKpqcjPDfMxCOknvCn8jPXyJH9ynJFERDHQW/2S0p0HYygMQB8BylUxEmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621836; c=relaxed/simple;
	bh=z2ogZjxuTKMpoCR+MQb93w82gXJuW+Rka1YSqoLx4LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvYmesS04L5IVuUGF+y/j0GEcMb6aoGIz3wys/aAljd77yqwIXen8KGNnm5N68Z40fq7FfECk/gqGT08bG0vnVZwNz9zTRukv/EOsHNttUY3gE8CpTvbL5mW3zGeeKiTanMH1Vzjm4a5UaVYVDGrriR1nNnXtPmG3CdFDTv/rTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPemoOJA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7946137e7a2so40688396d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621833; x=1760226633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=FPemoOJAyHihAj7y/qFgGq20d3xX6mgGMln21Jd3Qp0yV+wgtHI4M2DR1/2AsAPLbm
         hFMsBpLNXg01/z5srVi2CFWrhu3lNOLPI54yGb0yUMqP10IqjFFPIMYfx4EX5suLrcRs
         YkUQpOWmrn9toPbYvwuIavPJVuXtXpMAAgjwtEAtivi3sS/xdLMZb9XBFxQ4pxEHtfhZ
         eU2tptPMhKoSg/G6UiZaM17FuKKd9VWisXtUHfqoVScn09R4hGqUIEw4RErCNV/x+4MT
         1QG72udVg+yUC27R2D+weDAE1tbSXbQigXpVOCHH1jIyUwoDTMb7S9TfAGaYiVk/SFhS
         uiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621833; x=1760226633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=HsFkGShp9biVGjJ6PIZ+0Oj11Yfs/pHE6gL5+hIzGNfMlysMz6zy89WP1ITQ4gdKsy
         J1igkmu19E0NWNUJaacPw3dnrpTyySNo05JVv6xnrPobko3a3X0DDraW6Xdq+QHP/JXF
         HRuD9BpU5LTTdhrd3RPVMhMeHYq+x4fNtYc3yWXpYUKOYgAnXhxT9b81tF28A/J10Svs
         Qt2ltguIf1JqQTidK3go0BC0mxjn7jeDuu5rSTr7b6OrI6j6RT5AjpCJ1NK+p/cQvhlp
         Htek6THkwSC7WbytqrFuIxVfobwfwr1r4B+LWeVUQIfXDTUk1BQ+ogJntHo0UJ7+EFog
         kBEg==
X-Forwarded-Encrypted: i=1; AJvYcCUcCxsH0EoYhyhhjZRk6EOS5q+b1AI8UCdQlbkce9no7Z5mH7Can4mdZdaGY1KO4hJ7Bl7v+eWjJnCsT0komr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqwazZkJAkWgckVzMSeQ5Ac6HEYmp9y1qwdF8nZJdylCnlngQ
	fW1QezaRXzMPTPPxrkpD2nuf015GqW5ZGVLy1D7dFMeD7Oza0XE1uArIaMYVZxgf
X-Gm-Gg: ASbGncvsjYIX87EQBxVQFnqioCW4eCPLVFEHMUUvO5ekbt1+Vhbnmldli0lwcH4dIqx
	rWJcZe9ljpFvdbXdzvJC4mZUdfnjpZRGcn4bCSWRV6kJCtBwB38Lfli1XyV2m6FjRewXPXYxI0j
	pns6bTL2AYxuN690VSqw81Z6JcAcl2tHdlCLMqGUxjuNs7u+SVM7g/yhtQus9AdWJYysXkzn5aj
	3+Im1dAeRMepr46aVc8MRWV1OYtUbRsAN9+/DZ8YNmchd2pxwZuc3XU8klFRIgLad/5BQ5hjnd0
	S45Cpq/gR/p9fPfAPQ3w8IwpeOy9PIZIEagDOOyhQ7tkz4IWthRhzMYA3mva9M1l6I2triieQ6O
	kQEUQ3Xwt72V1An8nabBo1tMR7DrbnjFm+Qarv/AMBc0Ct3ILeWTTtQjxAlq7322pfIJFwgznZT
	luiU1fK1NXKtDEC8/K3HHnzWN40w==
X-Google-Smtp-Source: AGHT+IEfRMsUaYJ/XAJjWbILMrV1deJg/SxAXLDq4HjDEvGxveOHDphSf6WABh59w/bzNL05Mif4ew==
X-Received: by 2002:ad4:5d69:0:b0:818:54be:2381 with SMTP id 6a1803df08f44-879dc8303d8mr89763246d6.42.1759621833194;
        Sat, 04 Oct 2025 16:50:33 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:32 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
Date: Sun,  5 Oct 2025 08:46:56 +0900
Message-ID: <20251004235001.133111-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..ac0d3acc337e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5524,7 +5524,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
+	"\t                (single symbols still accept %return)\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
-- 
2.43.0


