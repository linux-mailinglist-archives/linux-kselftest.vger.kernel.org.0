Return-Path: <linux-kselftest+bounces-17620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581B973D24
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB55284DBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB01A08DB;
	Tue, 10 Sep 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmHDTV1L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDE1A01CA
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985424; cv=none; b=lbouslKZPJ7L7eLSELVqv94yawfIGn4wlH7K2dRzMF9+Z6JFA6VlgejOFuRr4FRBW9vlLgw9LfhziCV4Go2D3+vkHypI/H+7YXmsM7upAM6hCFaFA9PSfSGi4VE0Lnfs/j9kU9zvjPLa7/+2avn0QfvtJxsu3CifWGa9Krtd4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985424; c=relaxed/simple;
	bh=GlHp+sDP2l3iuMBGJMRzuH4oTR65BYOzxJ6K7GQv29A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Va8RXuVDbBix+udYbznpmJFgn4c7hTMuAFGCUW4svvuOcObG8kTOew8wZdGLJfHyco/JqQm5h98XvBSCiDAniuZFhmjUhgwxb/yejy5QTi3YB5UCqD38ALkb2/blamRarVMO47YiONoma9cCtTBfspfAlqYC3Aj/UcyAkq2yMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmHDTV1L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cbfc2aac6so6491945e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985421; x=1726590221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebNtXOw1zw+Y/P3jFG4DVeMhgHXmSDzSdOEI97BWEhQ=;
        b=pmHDTV1LBzxEn57OPtZ959cM9yCo6FtV14bdmSYOr0i8OOMznK96DIlafADdJD6h1w
         EvJ+sYMKEw+A2pXMXPwJ09hYcsNOv5YRYXEWFUHFuY/DLt1aw2465I52yWkklKzrCpq/
         OVYh23XTnKW3gfyX2aIjagpvWG4GWghMjqp9oYPJ7xragDC1p5z8zmgnzjlKZ5+C+4f6
         yq2bByUNbO9N/WbNpWrq1hoR752A8DS4WVPfJUqrijsrsq2VrHuesDze5GMRcX3GBPP4
         Validza4xhvrA8IrwCJV1sUJZIgoGNH7XN2wG2F3s2V2ynDecMPZ0tmN4lCvxTM4lb6M
         3u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985421; x=1726590221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebNtXOw1zw+Y/P3jFG4DVeMhgHXmSDzSdOEI97BWEhQ=;
        b=vqvvHqxkmoAMls3+cRjcq78wmvbuPT2HhyHTS3DZOrNAulfhnhITzYmCrwsMWXCi1p
         7hznNTc2DPJ7GvwUE+D0pnzmVJBw2GFoH6p7afT5wPTJOaTmFxYWOhIA18T/HqM42KkZ
         NRPl4PZuXxoXwPv9ftFmDdjnYXkjuu7qEN4klEZcGPjH5t2wRJEGMkqWe1m7PPjER90u
         7otkAGsAaUvcBZNe45i0uS1UGg16iFfJF3WQ4cq+v/9+ScCwFZBU2HthWNKsGuqtv/Ej
         gsd8JYo12TIaSDoEjcDvo6q1hXScw2vVNeh8iASY2VA44wo5sW/6z7ctukTI2Q6Hkt1p
         0irQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVq3p1+dyDgz8aalaCglWRmP5yWwgC6YLiI5elEjzpyAVGzKIetEXZMcGHztnJFVB10aHplyhZ8HKWBS3unWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0050oUxAUM2hTQ80WAm5C6FyDlXYNzfQbPKY7Nz3VhD0rXjv2
	LaK6JF0rzLAHHCjbjPm1FpqF+wZ8fFAko6x96G750u/A9ZPRxSoEMEbVKkfjauw5Oj8pr/ntG3S
	S4fq/t116QARm48TZaw==
X-Google-Smtp-Source: AGHT+IH1o/yd45zaUsI2O3gDVbqqWAfhLEcKZtzUdUtDk58M1Kz36FWtvb8nlXBaGxXyqHyWojvmUOgrKh/T56M4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:880e:b0:42c:b0ef:c70d with
 SMTP id 5b1f17b1804b1-42cb0efc875mr383485e9.1.1725985421494; Tue, 10 Sep 2024
 09:23:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:34 +0100
In-Reply-To: <20240910162335.2993310-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910162335.2993310-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-2-vdonnefort@google.com>
Subject: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire meta-page padding
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Improve the ring-buffer meta-page test coverage by checking for the
entire padding region to be 0 instead of just looking at the first 4
bytes.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index 4bb0192e43f3..ba12fd31de87 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -231,15 +231,15 @@ TEST_F(map, data_mmap)
 
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
-		void *addr;
-
 		data_len = desc->meta->meta_page_size;
 		data = mmap(NULL, data_len,
 			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 		ASSERT_NE(data, MAP_FAILED);
 
-		addr = (void *)((unsigned long)data + getpagesize());
-		ASSERT_EQ(*((int *)addr), 0);
+		for (int i = desc->meta->meta_struct_len;
+		     i < desc->meta->meta_page_size; i += sizeof(int))
+			ASSERT_EQ(*(int *)(data + i), 0);
+
 		munmap(data, data_len);
 	}
 }
-- 
2.46.0.598.g6f2099f65c-goog


