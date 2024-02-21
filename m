Return-Path: <linux-kselftest+bounces-5147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80085D3A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA17B23F84
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B085546436;
	Wed, 21 Feb 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOwtwY9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A645BED
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507719; cv=none; b=sBTJBhkSlUbeKk++b0kmds/vTZe1Hhti9xKtool4VL6XwIaPzDZ+N5YrUQA0oOvZfv9mx0RPRkYQzbpmvKo40Q1Xn+c1z2rhcCVe48IVeQFou6Q7XZjzP2p65ng5sZKsrF0qZC4MDim9ibJjjxx1XqODanVEelZ/hMp2mHFkuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507719; c=relaxed/simple;
	bh=w3euWTwzMuy4B32i9R1sF8QJYNBjDCrCALXsWQpTZrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n//gDWWzk58af9EgpIJ1D9+gpApNhyxqfQqmXeEVHXDoNQ1NLuJ8PMeDMnxGlKEbxyEToOFH86OZZ3PyCxX1Ye3sxi+/9Bd0Ttnf8w9q6IE8GumHbAmUI3EX4Pjyw1jOUis5H4i0L1p911cNThRSqJc60VJ5DWIHIOJc5T5eLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOwtwY9T; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607cd6c11d7so94376667b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507717; x=1709112517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYdfpz73mSSQOJip1+ZL+ticY/JfIGD+cYhY46XA/58=;
        b=vOwtwY9THzRu8jN1BfHjuDKN1Vos5s0uKgwfs1S+tsZ60qBH0oisg9p8CN7UdykxeL
         KUhm1pdTTFtoi7qIZYc47tRWnqpRvjwi/E3KJsCmYj/nNP1FIrSY4oG7Y2RS2euAEVfG
         7VG3jClqxR6tJqf1OgD0dTyha7OE7mruVDuz7e1I/Bea6Af8pswjP8eOX1mxTmq7o3sX
         TWgYO6DxjEyxhn1lNwWlCOdQ4bwwgADv9KgQlDHuWO0C4TJZGNfSnLTu03K5KYGWvUlm
         NMuwIyxGA19Z1PJ8a/WYeRuWV0yePTA9Wuy+jwMWFFsI+dGLsiInpDlNdvM8e4kEqryo
         3yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507717; x=1709112517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYdfpz73mSSQOJip1+ZL+ticY/JfIGD+cYhY46XA/58=;
        b=csju66TqWKA2yk94YzsVNaXcVfXBQFWdjV1pAnnGuVdzMt5j7YHGygkB5QevH7Jzoq
         ktl0BJZMrMCkN1FeuR7RBD+MOwmQBQZJwxqe3zHFhkG2kb9YguuVOaJv1LiWS4Hdjkna
         dzxdng/EKNgvir0S+cD55CN+kb3sOgLruZRqJQM/+P7HECc2cjd3ecT1pmpajhItcRaO
         HSUFeika86i16e9cdaAeI9UiKKC7wKWthUrrU2ULWJWF9w3+rhzJwcKgD/Z23n9/EX3I
         gjbeoo4be2LBUJLa36Kt3/Q4F6gLbmdCcXWqbOT9SDuScWzUc6pL0nPUASc62CWaAxec
         QOig==
X-Forwarded-Encrypted: i=1; AJvYcCVGJdBy4/EvkE9o8EiL4ogbP2A6cgoHMmLY8U/7VqzcKpO5asLgFvIZRP9QdP9IZNaORwKmrCSOw5BmZbqLdSmeaCFV1NQ1E9xMAPwt0VQp
X-Gm-Message-State: AOJu0YxJYJjJO5p7wJF3sDn3T25nKKakxvBlz+NTvfrzwJk/xrFoT3DR
	OAW4GbBFMW60Q4yeaQ0YsdaIuDd6zPq2Z6Y7NYAa4C8xaXNSGKIPZVPieiVL/tOdTS/QhhDDVz1
	Bt4G7coCNnw==
X-Google-Smtp-Source: AGHT+IFa/fu29ZmsVki9pPhB5PrTsNvq7jb5hiZUPefFb8PbN6D0cYOdutojAKCl/4VlBY7r3iK54hwJmjuHsQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d685:0:b0:607:7564:a830 with SMTP id
 y127-20020a0dd685000000b006077564a830mr3019910ywd.0.1708507717035; Wed, 21
 Feb 2024 01:28:37 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:21 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-9-davidgow@google.com>
Subject: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in xe_migrate test
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

KUNIT_FAIL() is used to fail the xe_migrate test when an error occurs.
However, there's a mismatch in the format specifier: '%li' is used to
log 'err', which is an 'int'.

Use '%i' instead of '%li', and for the case where we're printing an
error pointer, just use '%pe', instead of extracting the error code
manually with PTR_ERR(). (This also results in a nicer output when the
error code is known.)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index a6523df0f1d3..c347e2c29f81 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -114,21 +114,21 @@ static void test_copy(struct xe_migrate *m, struct xe_bo *bo,
 						   region |
 						   XE_BO_NEEDS_CPU_ACCESS);
 	if (IS_ERR(remote)) {
-		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %li\n",
-			   str, PTR_ERR(remote));
+		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %pe\n",
+			   str, remote);
 		return;
 	}
 
 	err = xe_bo_validate(remote, NULL, false);
 	if (err) {
-		KUNIT_FAIL(test, "Failed to validate system bo for %s: %li\n",
+		KUNIT_FAIL(test, "Failed to validate system bo for %s: %i\n",
 			   str, err);
 		goto out_unlock;
 	}
 
 	err = xe_bo_vmap(remote);
 	if (err) {
-		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %li\n",
+		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %i\n",
 			   str, err);
 		goto out_unlock;
 	}
-- 
2.44.0.rc0.258.g7320e95886-goog


