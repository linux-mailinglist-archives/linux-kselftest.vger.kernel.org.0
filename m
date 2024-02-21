Return-Path: <linux-kselftest+bounces-5142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2885D38F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F51B1F23A4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7A3F9EA;
	Wed, 21 Feb 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzScccO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C93D3A0
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507698; cv=none; b=GDUSmrjscq+AQpn0coxIgUaMul3P6ik3GsNtVILrSqe/haJVQ2J6qg8vHGGBys9elM5coVQb2dnQWB7ktJcfZreDd/Z3YENd8m4HoLWSkaTK1Iis2mmv3Rz1FW+c9DSjm1Wax71Pg9dbq6UpRyKScbt8y/pbyTu0PkyIiwZAymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507698; c=relaxed/simple;
	bh=AyL+J0FmKPt3EGU4p+x7TFB+PCgMwrwT1HRvusvK3Wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uL3ZDtB7OkZXEQmUXsW7Q883NjfuuT86uqIndi9jTyKxeJOr8dzILQhJjrTDCmYIw/BJSXiCxCa4raU9fevZ/q1ORQkSr2eM9DcOC2WlbtPD8o2JRmj+DtnEG7Pqg2Oe6/bCnyckN4jL9MlwTMZxX/9cTnK0rD4jml8NoPKvG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzScccO8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso11389606276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507694; x=1709112494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sajAUUIIQYuGe8qQNpfUtUdwcf5MUYWJWHx5st8lTqQ=;
        b=pzScccO83Xqt5YTyI3e8KOZjqvik1l3KJrlFrrJH9Ta+LErh21Rdrqy1ZQsGiWUMp0
         7eqXrCzrT1wkFDRx6bJ3GWZiuhLcR7Izj5Tl3tqJNl+B08Y1tdqG2h68HAH3Yl8YoiYq
         mdhkd5aPMNUAv0IRlUAoIIjj15DmcQ81fArdFxmaiatAUjGi05FpjR3GMqMzJLqDYbgM
         d2Hn6NPIoeVoPDOOZm0u26msaJfIreaBE94aplRS5P5jkrZbyhHkV8tVIjYshQPk3K88
         e23VTomTKSwjqoRLfyHjmBT0HJKCOSPNH24VjMaIkawKs9oOmfRNumUkDMPCHP2thVFp
         0grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507694; x=1709112494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sajAUUIIQYuGe8qQNpfUtUdwcf5MUYWJWHx5st8lTqQ=;
        b=idp6f0jT7ov+0hU/V2AqvOvzuwIW7BQk1X9DTOlNONXNKWdQBdwGVnoMLN2ulUzF6b
         +wlnKV53Cd8eC7zRoAX9W6esGx0AbfGTyhMfkTNKS8z5DQMUZ120IN5E0PkiDiSm8Etj
         vRMkPkIZJMvPX/9S9+q82qqXdtqwHPViZUew9rDvFYXe2XIuKZui8H9P7Z+4r7lngsr/
         YifBndjEc6sCFT+xwBXE5LDWdzdtRyhjZuJCMhakjXM7ij0Rn7/nrgTOIbWnoGTx9oI6
         c7ItqC398pX6ADL3qaPzlXBriNY4N0ApoW+/W8fRoGHDNrGH08q6e0B0nuyOoCm9KHsB
         JKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSQrRnMl6KzIBh6WYN0aKRXzHWS0X/Ae82gjqYAcFC27RUKQY5wJOg7Oza4xIx0/EmYcfp+RMEoXFCsg2hdwGSY7UtYTBC17/S0VjzGbW2
X-Gm-Message-State: AOJu0YwLYpbC3SLE0BnljEGxPbnapgyFO5tQazw3LRQ74zt3zbwxZ5kj
	6w7RzLsqNiddsdPmi5Avmdoaugp9jd9+ZeNDUd9fmvnUmzyVFKSpnJHU+1U+SWh0jEQByAvklfJ
	ouSdISqyKow==
X-Google-Smtp-Source: AGHT+IHXN4IhYXj6gHEWGA94Amz/iLtPWuo+Xnyc3GcMGDuMyWPS0mpLGyU+Di2N0vYTLFyOCsPHpf7g1H0Bgg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:b192:0:b0:dcd:88e9:e508 with SMTP id
 h18-20020a25b192000000b00dcd88e9e508mr4406327ybj.5.1708507694045; Wed, 21 Feb
 2024 01:28:14 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:16 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-4-davidgow@google.com>
Subject: [PATCH 3/9] lib: memcpy_kunit: Fix an invalid format specifier in an
 assertion msg
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'i' passed as an assertion message is a size_t, so should use '%zu',
not '%d'.

This was found by annotating the _MSG() variants of KUnit's assertions
to let gcc validate the format strings.

Fixes: bb95ebbe89a7 ("lib: Introduce CONFIG_MEMCPY_KUNIT_TEST")
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/memcpy_kunit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 440aee705ccc..30e00ef0bf2e 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -32,7 +32,7 @@ struct some_bytes {
 	BUILD_BUG_ON(sizeof(instance.data) != 32);	\
 	for (size_t i = 0; i < sizeof(instance.data); i++) {	\
 		KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
-			"line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
+			"line %d: '%s' not initialized to 0x%02x @ %zu (saw 0x%02x)\n", \
 			__LINE__, #instance, v, i, instance.data[i]);	\
 	}	\
 } while (0)
@@ -41,7 +41,7 @@ struct some_bytes {
 	BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
 	for (size_t i = 0; i < sizeof(one); i++) {	\
 		KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
-			"line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
+			"line %d: %s.data[%zu] (0x%02x) != %s.data[%zu] (0x%02x)\n", \
 			__LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
 	}	\
 	kunit_info(test, "ok: " TEST_OP "() " name "\n");	\
-- 
2.44.0.rc0.258.g7320e95886-goog


