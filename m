Return-Path: <linux-kselftest+bounces-18642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AA98A33E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09DB1C211BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3119CC2E;
	Mon, 30 Sep 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxnBRV00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9319C540;
	Mon, 30 Sep 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699858; cv=none; b=E3F403grfAK8tgcx/5xKEnpnqX17PU0/JIUl03P1j8h04k7Pl4faxKlWeFhUPdIbWCsZZa46Jltn1wBanQXigg3vrhR0WU3Y/wNwDuQF8uirh5j0vJDv0cP6r6MchOQ7FKpxkozHPdVzRQiCtY8PUgS7iZ3spww7zexqyU+qMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699858; c=relaxed/simple;
	bh=tjQh285Zc+G9Xm9tSEh9EovHMoX5eFJh64k3SUZLibA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4rfGi60NkD1xzyK6DIIPc6/BErFrnKyU+A3mxCgQxUsG5+dip96qkCUf5BlDVrWHeS6K5iM6fcZScuwLH7asWkG/ohFBPbUxM9t3oIxwJ6X+5QaqZW7MsJuePGpSznA6vKmiK1plGYdZCAVQ47vUIIebnvDkumgnLaICPpljTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxnBRV00; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so40078205e9.0;
        Mon, 30 Sep 2024 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699855; x=1728304655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0+j8HZP1cVf+QQUDZOhjhaodRPqf5Kzd1FP1uUxc6s=;
        b=hxnBRV00bnxZXi7Rt/x9shr35Na6wfQFg6KGQ0BKdbZMu1QmH0hK9/BbFBcPmyRoaz
         52vH59w8qCudS2ywsuv8w2RQoUYoUJKiNnYWr+EPUK/1kzGeXSbxvg5l7sofO4FAb8WF
         YHGfYL3WGJZBeWYTckyDgubwrUfsFS0l3U8AnSliNJjHEhTVEYjb0WoFdDdElUiiOq3L
         5kqGL4qrmtA0maWRLc6nhEZVO/N5Xz3zPg09s+zEtkfC+a4AjvLaFlB/gKwzyKv9VM+i
         esz4GQADaYl/0EMDgE9oHgR8iZzwz++cisocuuA7Yf6HzQMtep/NGTJINZ+ky1ddqKH3
         SLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699855; x=1728304655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0+j8HZP1cVf+QQUDZOhjhaodRPqf5Kzd1FP1uUxc6s=;
        b=oSyPut9FuQas8DjUzcB5Jah6nQkUtEnyJGAFIlPbfa4Rj1LS1HvV5BHWxP1BV9dqn5
         W7cirkmoYKFjEqfm8CEj+ypaeBAIALHvnEqb1PlmaFacH5ZWv3XNNhCbj6nR1KTENRm6
         JpTV85j0lDj0Z4ViJ3+HlA6SGv9GPGvJjvqZ8syCAVTV2krmAAXklbo1X4c3nKo/nuUD
         4I0PjHekzoDQ+vbjupLW36//sGIdX7QWo6sPV8HVGmNQkZSfzuEEoq4EI7MQm8kziCBW
         y1XOuaQa7QDqa+zzB5zq0tSFMsnb7BlUBtYEet19Mv0VqOOnO1aT8xabW1xYSkn9LfX/
         7lyA==
X-Forwarded-Encrypted: i=1; AJvYcCVTmTdMSqKQfVcW2NFXxvVQVfYwRZJKqb7HC/WKq2RLYl0KM/HZnL6U4Nw2LI9TzJbTP28Dyftkcl5ktXaw@vger.kernel.org, AJvYcCW+nPqAS7cuqRtNVZ3oEnstIe0YaKHTu0DeWkQ4ylY4Q2YaWLVNaIVp2OYLxVUi64oRmJz/jKjCAPbEHVvWIZ/i@vger.kernel.org, AJvYcCWEnDkBif+Go5iJjgmpQiOSFlkClzTlryEevms1oE9MNtOHivmE92JuU8tQ5XgG1WckgA8=@vger.kernel.org, AJvYcCWhg9unkSKmoeLmQOKoUwmzZ5RD9d7dq26qh+WBsksqH2RNxCzu8KZPNgwiaSQA8yv4UO2cuXOEpfq851p2wA==@vger.kernel.org, AJvYcCX9rPe8uIcDtSo8DUpRMkRtZkTrvEHNqeajV7YriZL5krAEoQyyTAsXi36tRvwrSiul7NcSePs8CaDgsiw=@vger.kernel.org, AJvYcCXCkzqDm8SwT4dH0raMw25FTCUZ2H20qpvZJOvwCt1wkRCGwvofsvKtA7b83Okm2Oc/mIAhfdiCGr0lMA==@vger.kernel.org, AJvYcCXkgjl9JnvujxsgZ9qps1idZlxQOqxvU+BzkuB1yaGXdafH35nxWdcyD7NhoFA4wqMKY+FtH1CeGwi8U+2f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3TVSIeS0ug+XqYcbDj+nKdwk5TB4HedOdNnmfOB/MlN6Qz1i
	+ctSDSpZbnWN//UDVqzTbXjw4/QfitjYNavztYGa8MI16c6rod/KxU2fiMl0YAY=
X-Google-Smtp-Source: AGHT+IHdC1cyaWvS05r5143QqcQIcUYzzrxVQfsNi8sq552bi8Bx4Z/Dm3LJ5ZgNcGYz44ssbU9Czw==
X-Received: by 2002:a05:600c:1da6:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-42f584a2dd7mr90988995e9.30.1727699855019;
        Mon, 30 Sep 2024 05:37:35 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:34 -0700 (PDT)
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
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v3 19/19] prandom: Include <linux/percpu.h> in <linux/prandom.h>
Date: Mon, 30 Sep 2024 14:33:30 +0200
Message-ID: <20240930123702.803617-20-ubizjak@gmail.com>
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

<linux/percpu.h> include was removed from <linux/prandom.h>
in d9f29deb7fe8 ("prandom: Remove unused include") because
this inclusion broke arm64 due to a circular dependency
on include files.

__percpu tag is defined in include/linux/compiler_types.h, so there
is currently no direct need for the inclusion of <linux/percpu.h>.
However, in [1] we would like to repurpose __percpu tag as a named
address space qualifier, where __percpu macro uses defines from
<linux/percpu.h>.

The circular dependency was removed in ddd8e37ebaa1 ("random: Do not
include <linux/prandom.h> in <linux/random.h>") and it cleared
the path for the inclusion of <linux/percpu.h> in <linux/prandom.h>.

This patch is basically a revert of d9f29deb7fe8
("prandom: Remove unused include").

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/prandom.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f7f1e5251c67..f2ed5b72b3d6 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
+#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.46.2


