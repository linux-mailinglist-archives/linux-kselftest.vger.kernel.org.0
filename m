Return-Path: <linux-kselftest+bounces-3916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094A844FA9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 04:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0B31F2504E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 03:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D03A8FE;
	Thu,  1 Feb 2024 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGKsgQCy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D83A1A1;
	Thu,  1 Feb 2024 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758042; cv=none; b=ZnpVVxps5XRULvmBW0LVFXme5+r/EBNiCJtAU0rVBRGHmUBk6w6uHkKhEOqSzqD4YPcC4IoHBJwKnFIMk7EPvKgOQs4oegs9lW3zXnGK9gK9W1slp3JATYf4NneQAvnqM0tWI5fBzhX+ehlb0LJJGggvleVoDG8KZ/za/0veba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758042; c=relaxed/simple;
	bh=hG2+PSvAI3WsBVzydgNM+6x1sh/jZST2ajXPP7q9MnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSKKoa5qymfuujoi2XI8W4zEHGTjHvet+h1HBKutupzwTRXu2BN3a5IiQrG6EWj/8HSdomx+K4eCvcqUbN7ngQ6zn+JCxbN0xl5v5ntcCclvQ8fftf2SHlIYOuiOpTSAXYJbws1ChkUe5ypMLl/xfpkeg+UH5/gkZktQRMxMPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGKsgQCy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783ced12f9bso22469885a.3;
        Wed, 31 Jan 2024 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758040; x=1707362840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/6d9JyQ3aGDZno7ndLmFvGN72VRjkltv3CVlEpIaB8=;
        b=gGKsgQCyNSiQxFL0p+HwyzyrnFrqTo/uYAH/54bBISvKrKxn8sqVCxug3NrJo5YvAf
         fJuLcrGm1u6OmYNLTAcdJhtbrR4ruxxOMEyABKd8iJM8K29adBJRpmc7yRyUjtVdt7f0
         wlYY3MC8rYBZ89h9XjGaeML7Q3TPElM3YGvAhhE6poAQp6r4fJLemGE3/NphgyxPGLa2
         ALKfEgV2X+cFUtPFqOGruuDWFo4VNcKQiolpALNtodAKxJZraQSwcVz1RmttvwlkmWBD
         0akyRZfX7oDOPn+mhQUObpwbY/v2SEUNZ2/GyE+7FCE/DD4GpL129VYURa6PRRGJ8Orv
         0Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758040; x=1707362840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/6d9JyQ3aGDZno7ndLmFvGN72VRjkltv3CVlEpIaB8=;
        b=gC8AKjvHvoy0hFxkaTcJRQbpG/Vl9W3zQkZt+SBhmzeayQQ9Mv1ZmeVD5AwIm17ZnZ
         mbmBWsfrM2k8teoAHzCt7tFeRld0RAgkQ/0khU5czc4vNvfwmAkcG7jTYYr916I6NgZg
         4Q2Pb4zr+GmVXkIqR3LR4093jdBMtHJ29z/H9Zg0sSxK99iT4rex5JVq4LXXHEDXgj8f
         JBJFllA6grITugRhvMGnFuQSlHdgKxbSyDoTNMwe61BS1Gx/UQ2JsDlmcP+dsJEIR+uB
         e6gjXaMsf2C/W/9tz1SSPuj6Kn4yJJJHOzUbOlbuTYbODpBgDma/13SHfxYr42PXCoT9
         4JIQ==
X-Gm-Message-State: AOJu0YxPbBnB6vRd3SR9i0OVgI7wWsNk5XuSkN9y1NCPzjf7I/m/W8DI
	dhrNR1EPFuLazXiWAWNQd3bX4NwqbpCmqWgYXT+P+X0kuKnNNdfD
X-Google-Smtp-Source: AGHT+IHFc27RL7Utmjc1Pq/lujri1IbLrCkXvs37G1YNUuJnCajdoRhIpZd0pK9lV7z8xZOTUBO+kQ==
X-Received: by 2002:a05:6214:d45:b0:68c:5a42:41a3 with SMTP id 5-20020a0562140d4500b0068c5a4241a3mr4098862qvr.34.1706758039796;
        Wed, 31 Jan 2024 19:27:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6whcYy++TMlKNQrkTFI8cKX+Wo3UA1hSScb7Tc1JPnBdWZVCGfX5YDvtMENDjCUS2fxggT/fh+nuXMwlq5w+LJOEtZ6/oumbQvZK+XVj3PS3WsyNd6+OKpmte+UqEIHumJAkWvTEd1mzvgE6ALEy1C88UxfMWjofNWhzUZMTk1SJFd5ve21yQaMVwoQqDSrb/fc3wUhG2vbe2oIVPwP6kmW+GPY0lkh4AHPc4JwV7QhwBYr/nqm1AizcFjF6hsHJFwyaIAAK3gRiI6WODGEx9++F/eYrf0L8Pq3/X0tjDsU9dN8GeG7IqpccRSG3mXGAza8VcT5PMZzIMzbvZ9xoSdFiNrDpF9jQJCwL3/XA6rNFfBeO1
Received: from localhost (fwdproxy-nao-009.fbsv.net. [2a03:2880:23ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id lr6-20020a0562145bc600b0068189e9d3a3sm995855qvb.112.2024.01.31.19.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:27:19 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] selftests: zswap: add zswap selftest file to zswap maintainer entry
Date: Wed, 31 Jan 2024 19:27:16 -0800
Message-Id: <20240201032718.1968208-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240201032718.1968208-1-nphamcs@gmail.com>
References: <20240201032718.1968208-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it easier for contributors to find the zswap maintainers when they
update the zswap tests.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fecebfc4c0dc..5f60faaefaf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24396,6 +24396,7 @@ F:	include/linux/zpool.h
 F:	include/linux/zswap.h
 F:	mm/zpool.c
 F:	mm/zswap.c
+F:	tools/testing/selftests/cgroup/test_zswap.c
 
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
-- 
2.39.3

