Return-Path: <linux-kselftest+bounces-44063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068BC0A56E
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3584134A1DC
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B82877DA;
	Sun, 26 Oct 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1COdxsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E52580ED
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470666; cv=none; b=Y/9U4rLOBqoxjrwmjXrgZCFOhspYnc2reBm2iRH4ex/OWEUYzsp51T9VB0n5Q8lhtf2FIHGlL4zcfckfMUMgS1dbcFnQbPyz0LXn0ONbAQsAIBDtJV43TSc5D81BXgubVBHdMCOGwL78EFQ8eNIaj3oPRdclv+8lVKn/j97JbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470666; c=relaxed/simple;
	bh=Wsp8cxVy22klAhiDGv9P8tZ3IPZ7LUZzLpg3S21IfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpJhzfbad7q5PvZbwJCk0x3MMWxTa67MRbkdL5PuUxUz3m0BWyjvezljTiMOjRyxxS5sh88pw/oT7VdL9JCQ5gdstMrGZZouKJndDrX8DRzma63NuhRsmf/3hLvOwGXb1I+Pl0cgGX9L0xojdS6wsOhNaykL7G6X5SOgKbLo4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1COdxsR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a4176547bfso773377b3a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470664; x=1762075464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=f1COdxsR66WLD3OuqEA0Rq55Q7m+WcTFWN3K+XEtNYrDT6OAAOlsD/RryqO55LiNrl
         h9P00xlnr0e6ApQsFX3yaF3HsJhF5bQ2oUPa+aBI9Th+4aEUVvaM952ibhXm4BXcUVzk
         U/IBNL+sWV5aWsObI6N/v+T9LMQyMpC6nZ3hCpJM0pPwBHFsVVR4f8+d31buzQ5R3U85
         URHYHd7tZTqdSeGex1E4Ivc012NwgEV7kcSFXr/R4yk/kICCWRgqAAz+dsig46dFRvc/
         kuzS/BkiVeFd6dhUmt920KNpQnJ2cupgas2ECn/k11rYoOK7F7rDyxBG4x/7GOin6u4z
         19BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470664; x=1762075464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=op/ie+ONR62g68RVBOv2/IRuWc46QQCDM8NhGMRA6MzMNuc90joidBkL+tMyufsrWW
         ZGBghUOIwR7tKGC0/3wqMyxW6h2tRte0bkk/r8eIgosPph/RqWrY4dCmQTZY8OFJnOTf
         SoZ43o02B8D1kDhpwXYxP6KvZ1foVNNcOoy4yX5PLi65v/eQiOCHc9Nr/EwKcR7AGg+G
         j50UYTPzwpt0T64CIHzATgeubj2jnzQ3icJtzY8a1kFlYZXGgizVFUVUrNEACw3Eu9fO
         pXFD+iV+Cea/O6YDJMIZ9/FiA0Ax/BId1TL8a02ohmFyOWwukVcBMXFykokH71d6NJZw
         XiGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJ9o7KB8VjF6l0g85lr1dq32hzh3hMi48LmO55kxlJO3NXS4fm3yHHaSBtKbJNzAenmTQbgujl9VwgzPN+DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYxAA9BrC6ja/cj4Ij1wK5QkVKb2bwdmFDtcJ3JbcvRZN0QYz
	TI9i+Pv2ZWUrZMOvA4J38a8SviElDmvvowUsRPpWKVSYQo5SMqqdNSNd
X-Gm-Gg: ASbGncscnUzasRJpRL7vrJqjl44S04GGcsf0ZcZfS74N3t/4Tv2RSB/Ggqat/enKBIP
	OEbPzayHiaBB+KuZRT528AJSTON0y7n67e+OKMb4l/L61HSY1ffeuQC6t32biWk53bCisle6CC/
	rdStpixnVPVvZmB/ndgrVIWX/RpE3yOY9aCInheU3Wmq9qwQSVeaxLjlC3yYfbCWSYrDnnadqH1
	91kC1zIoO1fe4QJisyo+uY0g08yTZGWbmOtlL7js/iN6U/GKFNzQJzrfYjmBA24ra9Y4awxBhEb
	17weBV6gYf/PFPsKXQAkimhr4TOTMK85arDTUVnn5MZSfGkQfsXrpibDC8laIbJg0I5PAKntbj4
	hJ1RvFq4ReD0BTqQo3QkJfdf8dqQKtPV/A0l3rx+fAHPNjnsukCE/crK+2ymKJBsjI/Y+E0KrOU
	/wxg2/+UWhXrdzYejJBrw=
X-Google-Smtp-Source: AGHT+IGvbZctqDawrbvVj/YWwiaibKLUONAPApFbeuXnBVOb80OZCjV/x8ZAeq0wItW2If52JQqywA==
X-Received: by 2002:a05:6a20:12cf:b0:334:a681:389c with SMTP id adf61e73a8af0-33de967f61dmr10026226637.15.1761470663538;
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bfaa1sm4063316a12.7.2025.10.26.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com,
	xandfury@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 14:52:32 +0530
Message-ID: <20251026092341.2896-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102633-dandruff-clang-e91d@gregkh>
References: <2025102633-dandruff-clang-e91d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


