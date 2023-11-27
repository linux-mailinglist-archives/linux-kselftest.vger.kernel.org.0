Return-Path: <linux-kselftest+bounces-672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49F7FADAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5773F281E2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28546555;
	Mon, 27 Nov 2023 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzCS4G0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499BF137;
	Mon, 27 Nov 2023 14:46:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4128515b3a.2;
        Mon, 27 Nov 2023 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701125212; x=1701730012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oCTGiSWgB9NsXiyG8nsZcknofook+2izslwvO0IvTU=;
        b=jzCS4G0sHsouh0ifFdwoiS3GlA2BszjlZHS3kCWqxN+eQSTkHaEQ9PpIPviCQzzTIg
         qUYBXHTJW0gshTMQQMOJz9QVwfFmgtYMldKODHPY9MFAP/Rt8bPtGJ08IABkvlb63LWF
         oIY7j7Rj/UvlFeoyim3THydk7Nh7MRxrrsfexmB3s6PcizhdpS5R7rD5/6zleNVoIBrT
         zTjp4DpEszp20UQuckI8mE+/yEsrLm1d+qDwh01RB4CUgOraOxE5P7IIuXBfOqNlz882
         jIouhs0PJNx+3zlhvtnzetvKzuMVmR3IARHNYxFrQmEARdcWZuntJAPLO1oit33D8r6S
         7JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701125212; x=1701730012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oCTGiSWgB9NsXiyG8nsZcknofook+2izslwvO0IvTU=;
        b=X8RXYdE+0gaqHvNZMXaEB+sBOzSUt111ehoKPLmAR0iwn0qMFurKZQQsM0YlIEOb8W
         dYFZaS6TqOuA6yKNKQO6TFdI6rrs8nOMOTKPv7IT2Ba/p5HxrbyCqbsMtrxWCrdBP/4d
         7vAP24K0aYTczhGNJzEotuGTZGwKlyHAO98cwAGGvUm1hN0mFBFHzY1+HbHyQjO8InWq
         WRaNAK4Qro/ZTDYB77coAq/2hsXsJmjoYzhZjUPXn0C7AQT8AvsxUfyRZJP0HBdSioml
         LwN+N71q7f8YWPaXLdN+Hm8LNf9jvF9Du9WBdvbyr1MwbmD63ZIAPc+uGuDdpzajPdLv
         k6Yg==
X-Gm-Message-State: AOJu0YzocVgzfKMqWQgseYZyTBAseV5NY/ljNeBxxDA8gWPv/VCbNGbe
	TUtCGAZwZ3TfLZuJDPlA9QZd9rLt43I=
X-Google-Smtp-Source: AGHT+IGKeqtz/gytGYQg7Gh1zFzW6bXH0N87MgWSyLX0d4AxerflPbMRaTGFF8CtCxibds40VZi0pw==
X-Received: by 2002:a05:6a00:2d90:b0:6c9:9e11:859d with SMTP id fb16-20020a056a002d9000b006c99e11859dmr14050165pfb.1.1701125211462;
        Mon, 27 Nov 2023 14:46:51 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00218500b00690ca67d429sm7615145pfi.100.2023.11.27.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:46:51 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v6 1/6] list_lru: allows explicit memcg and NUMA node selection (fix)
Date: Mon, 27 Nov 2023 14:46:50 -0800
Message-Id: <20231127224650.2636224-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127193703.1980089-2-nphamcs@gmail.com>
References: <20231127193703.1980089-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original patch missed a list_lru_del() -> list_lru_del_obj()
conversion. This patch fixed that.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e80669d4e037..f69d30c9f50f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -234,7 +234,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del(&binder_alloc_lru, &page->lru);
+			on_lru = list_lru_del_obj(&binder_alloc_lru, &page->lru);
 			WARN_ON(!on_lru);
 
 			trace_binder_alloc_lru_end(alloc, index);
-- 
2.34.1

