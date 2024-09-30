Return-Path: <linux-kselftest+bounces-18640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CA98A332
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351D01F23B45
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8219AD7B;
	Mon, 30 Sep 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYDX6VVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814919A292;
	Mon, 30 Sep 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699855; cv=none; b=PGgx8AGNMmvqo2X1IhtgaX7YuWAZV0utEqnO3mWuv+IlKx7kJbuer6rBj6Z5EOCtngAA2VRS2CDut7ntGwuwlKhJM8AF8w3iVLf2rebuEex4u0Uu7SAkjugwNkJGuqfb6aF9Gc4LJ6AqzdLHUA3Htaqf77iE1Q0qtn4QDdiIuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699855; c=relaxed/simple;
	bh=TsQ1r2D+LRte21c6aH7Y9esjA0tK7jYkKyJuesjuUPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErfMi1hlHemCftZhyAlGy+BFyCFH1fjPX/SI26xl5afs10at8+MScwjFrV9sjO9U6B3CYihzzIXWdoyFjcRcIeTfqTxKWpZFw4tdQDuM4vaOl32HnJ0t0sxuH40RWijWnfpz90bQ5wGOQEqEqQ2QjxXwYhHBijBLFEndsloM1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYDX6VVz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so34209655e9.3;
        Mon, 30 Sep 2024 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699852; x=1728304652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP8C+iJ4JK1Je/p5BuVlufkcfyY44goQKWFtPIGK2ac=;
        b=lYDX6VVzTleUc0FrUfVtkb0tVrSYgnuEA1kT7/ZRrp5m8EiqwwllSfL9c+zfkeK2S5
         ske2sekRtWoFyYUAJweiFUxlYJeM6gAH31XN0XtE3ItU2KU+OZlW5oT2wLjRCRV9KutA
         8um4UbK6h4GikyPnyF16mS9fUsSMmYGxxYDwk6IsBPjb7OPoTjHu2L68R5ikBvo53Ci2
         6A8DxhvjdSeD41TWC5oD56pDXNy1beYtamz5jRxCrKQWr93Pe6bJ4eEu8lq+9mo3oHC3
         E7fK6jmSdKwDo3YgcY7p9ALCqCPk0jNXGqtqL/b+gYCswxZRKa+kJetmQTnkg6CwBM2u
         7qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699852; x=1728304652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP8C+iJ4JK1Je/p5BuVlufkcfyY44goQKWFtPIGK2ac=;
        b=O1Nw1+/tnHlTttZecIcIhs+OzsRWvSFIQPFimwwFKpUiqonLPIaNK3MnfnIHf6JZj/
         EbM/F88LhSiaD3hGmNuWi5HsLwhOVKkvuGLlg8aN8XYTKMYKVbTksjIxji2PCPFA0APw
         7bs5Retmz4DopZ12wR9fyIHGE1ZtpzCtDHQQOgf81KPxKRGgT+XcQ6ARthPUb+65pYOK
         qiihbDjwb4UKidZ/4Zyfu7VcqvaoMoq4z10g5ePYa+ZMSAD3Uf41LHB7CfXOQdz3Q+/c
         sGpZiVW1Ubzfh+3zXoMwqzKI7uP50+g4Z4kgDqMz00W+liR0oSWDHC99EtfaANCnmzDn
         yuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX65BkWuwUhXbQckWr2q2zoiaVAgTjmV6kxj+Ce7RUGL7ZQ9ta2mFEGk+liL9fL3U7W1Pv9vSEJ12QHVotFBnD@vger.kernel.org, AJvYcCUriF1YOGgWCnYSsrDc+q4LTrmkEEiw08+3yULqt9pN0sndmvMQzksVIMcA+rgb1VNYp1s=@vger.kernel.org, AJvYcCUwHOpSDpc54X/CUDgHkwe/xF04EfqfC5OJODYqoB0cJ9s0n7Wy4JzNcXk59dsDnUTSTrTEyKjjaxZdcZq6@vger.kernel.org, AJvYcCWbf8RCF5DMHBlmyVMzVy1H/A7j3AWtPJfJxfL2yZOJdfELHbWkKPXpIGvpyzF9yWukzhZ7NbitHM/HjLo=@vger.kernel.org, AJvYcCXaJ4KmzjrOFf1KJFM6CDNrF4D6O8mph3FDuMU9qtpFhU4Y7y+sVgyfZ1dy2AfZnPdT4kLrR3lropromKOASA==@vger.kernel.org, AJvYcCXcU6A2esLjfNrD3jerIi4U5BFvJaQ6T5mnojjjHjrTHturSnySLanDS/EVTZGvTTNJn01YCoVrQGZfBA==@vger.kernel.org, AJvYcCXy4x+up+O9IgVztwWnEsLz+ig021r8NI0tNNuR68HNCFjJkuBhdhkWLoz3VabFB71VW31pydtDyEIz8xyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrrK6A1QhaOIW9DaHrQ4F9leuR0CO1Os7Sy/IXeCWURt/DbLV
	GsVW7pn+i9JuizGzW6Eu8ScLoTfRb0FHEEAaaZRvLab0aBgwrHgn
X-Google-Smtp-Source: AGHT+IFhXFsuzmbiOuOqLO3F1XUYhHCyK1gMZJdEjcH96x1NbPGi/KaJvtZi9F1OwQRNBRa/x7UBZA==
X-Received: by 2002:adf:f1ce:0:b0:371:82ec:206f with SMTP id ffacd0b85a97d-37cd5aa9c14mr6102871f8f.16.1727699851849;
        Mon, 30 Sep 2024 05:37:31 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:30 -0700 (PDT)
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
Subject: [PATCH v3 17/19] netem: Include <linux/prandom.h> in sch_netem.c
Date: Mon, 30 Sep 2024 14:33:28 +0200
Message-ID: <20240930123702.803617-18-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
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
index 39382ee1e331..fe6fed291a7b 100644
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
2.46.2


