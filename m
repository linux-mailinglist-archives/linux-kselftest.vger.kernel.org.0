Return-Path: <linux-kselftest+bounces-39836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904CCB344C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FE27A870C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D22FCC1D;
	Mon, 25 Aug 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VqTUePK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD852FC886
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133861; cv=none; b=Te46aVNfVi55ihBdCJZwx5JG1wPk7aE/PjcK6VIUEO+nJm56tUatMPXkpOnK/xauZLL9F84YSXERI0Pu67ED90ZI5mBjHHwojwYtbWhQGLb4XsHbqTpYWzSV0zEIqcCZOMWt6JDlI1QOdC1NKXtPnrGHWdumoUZFrJd3hV4Ki+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133861; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9sRQvQyRD+w45UDTpEe4360nzLdLlEjarCoJD5CaB5hLmKtLP6BdIypyN+NUHIJjXBFky1gF9mDSorB4HAXMwDzg5icjc6jDlq6MMOfXSReOFLl7acXwhkxnHO1EUxpMPksmYtcikFp49n/SDXKAo4wRrMUG5wy6SIVOoh7k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VqTUePK+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so3886188b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133857; x=1756738657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=VqTUePK+Ti8hEY7IFvvvAeFjp+G+fICLnxFbV2iCeOrggd8SC5+K0qAxjW0Ye7rI/9
         DVR7YZA1539ptNqSnUJUhsQMErEzMW0AzaqQ/63pcFp0o5qPBIZniamX+8ChMNvQ5TZe
         2PcsjaPloqk2RrNd5cuLShdre+AIzlVViRq6RNl9s/acucVXT4BTmag6DNJoK2i6AXRD
         3Q2fJb06R7+wYxcsU+5SXLceGPUv56pdd+xgsE1zjwhbmLTp1fAht9KnJprqYGxyRQ0v
         ZIVJBDDPIv/Q9hdtlQ+a167K/EjI/fA2GHl9E8iWqK4PMR7MaW0rS3AjRzlYgxSEjdN5
         Ae4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133857; x=1756738657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=eOiQZ8pP25i5+M0hTTZx5ierdbzMraDazPT/3SI5kQIyim6lE06tY7cN92MpuA5aTE
         vZBTQe8Z7TcJ/iXak4YwH4ubdp8z33pqCeni1LwroE1gUbfiKYeSHmp5OtTdQMXCj9lo
         ThDBINLEcHno4d1oaKmUcGxLpogWzpC4JeDcYr37u/KYKErnauqihtwSuH5y3qXFYeu1
         mcyUyZULaIBZ8yM3clIfmhIyEG4ux2V04AN3y4VzXE2qK0hjWqYT61HKxlxRcchQJkbS
         hmbjX+Nu7f+5v07B319cGYCYjpx5XeSGPYvgfUaDhzy8ct2xHGUhqcfsXE0U5Unr9XRv
         PisA==
X-Forwarded-Encrypted: i=1; AJvYcCXN/JCtNm+4erUa/88t30XIhBxycbC9nu4oXdZmDYS8rVzCozPQ1JNWkfZvBVpDhXlaTbjauxyyU7PO+hzzwlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBnYnnAU95sfA1FRN3pTXc0Ye2kb8e2Dqzd6tIJYYUqZpa76h
	yurWapXmp3a8JgPda20pqCqOfeVn6HlWIykoERgeSsZlKqr6MkoU9753YNp+ZTQQo2w=
X-Gm-Gg: ASbGncvO0C2I59y0lYBVTALejzzlIPq6r7SAfqgPlf2qwoeFSluosYf26B4SBjg7+20
	QBR/SLVwapggnHEDOY7AGCIwMri51BRqleSTegtvxA0haXkDTiLROAOC/Hzpn7OWJ0UYodydwbA
	YntDRYWbu8cB5ywQWM6O1CoU71Lus1t8OPyuBfVFCoPtdYtofDnvhQXm/wnpk4ZWd28IYR6kV52
	lsXalwQ1JktLcm+vGrwbpCsuL8PazsYJmo7KL2xWNdshE4AOEilqzDnK+2njUbBBJ8J0eMnXe7f
	PvD5We/EjvdFvzhfQG0HUFY2BAdFuyg6erWUYOds07XFYYyEkIsill8VGhmxpUeG9yJsXBBWTwJ
	acb2ZS7LT6N25nk8pAlVjftXeqRD1qnfsPB37gofyxpZW7A0+fKiM5m54ByrN
X-Google-Smtp-Source: AGHT+IHPWyaefTjVEriFn6wD+uKtAOPue43MQG2E+07bD3h6ezfyNYQoVQXZCOE8Earcz4MwE2e68A==
X-Received: by 2002:a05:6a00:2991:b0:770:3c63:5906 with SMTP id d2e1a72fcca58-7703c635b38mr12867003b3a.14.1756133857394;
        Mon, 25 Aug 2025 07:57:37 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:37 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mshare: selftests: Adding config fragment
Date: Mon, 25 Aug 2025 22:57:05 +0800
Message-Id: <20250825145719.29455-3-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshare test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mshare/config

diff --git a/tools/testing/selftests/mshare/config b/tools/testing/selftests/mshare/config
new file mode 100644
index 000000000000..16fd9a3ca12a
--- /dev/null
+++ b/tools/testing/selftests/mshare/config
@@ -0,0 +1 @@
+CONFIG_MSHARE=y
-- 
2.20.1


