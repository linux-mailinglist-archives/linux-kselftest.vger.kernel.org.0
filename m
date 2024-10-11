Return-Path: <linux-kselftest+bounces-19525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD49999DFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD99C2854AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CF20B214;
	Fri, 11 Oct 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRz2EOxE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DB20A5E3
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631885; cv=none; b=JVu0lJWaXd5172UJRO+9L1H/zapZsKZqDvxGFl1y+qGIeZ9sk49D8lFPatFv3S+HpRRZehsfiTK7fuFTud4REeuAT8+QqN5fQPIzgpKhIR2teF98GLH2TY9inCD5qepi1hgTgCJod/ADTcr6mhEstfF30YL0wN1zwVDOMYBUKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631885; c=relaxed/simple;
	bh=Xe26Bp8gHEAiwGIs7RHL/NO77RSdideardrkLGG2ZOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oiZckYI9lKayUT09CS3k6/K4XBtWoLboEmrz9mL6Zhfxw//PbVUb1fPQ/XZPbWTUAwh8EoRNDzEuAKQ6KYJeNaQDCDtII2imqtJmbcT5H1A+suBI13BWtBKVhScGqoNG6fZWrg38qQXobs/0IqmiG/oNKBdq27/vKTsLmC1Xz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRz2EOxE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2acec0109so30566907b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631883; x=1729236683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieo7ZHNuo7RJzAqC+Thl/FRfm1f3ThfajYdgqPFwDO8=;
        b=GRz2EOxEwwOLL1Y1HI114e+YWm2alx8yV0E3cGt3h4aI4B9Y4w+B7Y5aUA4Nr6k2nu
         N4hR1pGTuSmBQFZmhGwPcU4MwrzvGB781AvH+XS9dsvSZaSm8wTyGOgmwpHDDS4BH6jc
         tL5VNhdmoDGDoUR23/FTaqufwVt2bfYWixB+EuLSy5RW/kHeceDIpxoIpbVqOYK+qL3I
         yao9DNm3uh5GsY9YPSFgbJH4TKbhg3uC9+6OHHXLyYc45jWKD/sNlNGxBxjjRqoKYxCp
         u83XZGrv0qhG5W4NOjs1OGKyEumVBQoh366++MaV6DtqPl+/xgxiVa1v6ws4jSo2Z2gC
         UDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631883; x=1729236683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieo7ZHNuo7RJzAqC+Thl/FRfm1f3ThfajYdgqPFwDO8=;
        b=rj12G4UKrWOuT3aDaJpwsteR3HftLxQGW3StfzcUdl9+e/ReuiS718ymchl34o5mJG
         +lxyqgxh+wCnUilqAqvhZ3mqYuO7kD23dVfbGQMPZJd1wIKP3Vj/pU4IeiEcaF2BMsfx
         d2F7c6l3hgD+F4GhmS0fTSGdOhWEEfQDPNJXFN1sTxQH/ZJOznYG4Wqi7/A0eew5+2Yh
         4ebowv1tPWCFaw0QLZEHQILwc7Ru4+JdTSES/BlTk9kvN4fPwiLv3iUMThnJH7Ex2RYr
         WsloZ5A1Q4/ejtr/ktCeZEYLJC9F6nkWi/2jFxXDtLlonp1s0e5pjHmIOJ4iw7tbnSfz
         OkKQ==
X-Gm-Message-State: AOJu0YznfyiX5Y6U3iP9QXCP7Lzfw46o2UBlRSTZUtaBDt8eOIng/0d4
	h/RtJR2BXcEjLBgNiCWK+up20YPp8ECmQ0nniBK/QIeqeioB4MJMgzZzVHmVfjSTlPf3+dhZEj+
	ubdbXlWoAEA==
X-Google-Smtp-Source: AGHT+IGG0g8IxhAAOBToCYFjY2+/Nqb4qOh7xXJ3HzDIkyIPWZmvA5SROzdPJywLrzQPXDDBI1zKCIOhPFL/Kg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:c09:b0:6e3:1702:b3e6 with SMTP
 id 00721157ae682-6e347b368d2mr364247b3.4.1728631883040; Fri, 11 Oct 2024
 00:31:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:10 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-8-davidgow@google.com>
Subject: [PATCH 6/6] unicode: kunit: change tests filename and path
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, linux-fsdevel@vger.kernel.org, 
	~lkcamp/patches@lists.sr.ht, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, Gabriel Krisman Bertazi <gabriel@krisman.be>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
[Rebased, fixed module build (Gabriel Krisman Bertazi)]
Signed-off-by: David Gow <davidgow@google.com>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ => tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ => tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
-- 
2.47.0.rc1.288.g06298d1525-goog


