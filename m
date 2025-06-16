Return-Path: <linux-kselftest+bounces-35067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B487EADB01F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FC3A311E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB8263F4A;
	Mon, 16 Jun 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBT/YZQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05D2E4268
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076675; cv=none; b=CitUHFeCqdNPyccmuw06d5UofAQWL8YsPV3g9s+k+Rfi3nxolEJA2Zg0YTKMZgIBgzclEysU5jPTLpobEpNdZ+6TooqNVlPzKgI7JaNcP5krow9XBB93FkwmA/Top4gU0aJGMthGVJO+w3j1IiAjLfn70Y7B6VKrGZqIxiFu+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076675; c=relaxed/simple;
	bh=ti3HZQBPBDth8TxEDDmGd8bpNEAhX/+srtBGU6m9zTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sgo4CNvgkJWlkl53rYI2OyT7mhLnZqXwKSdi/ngiGd254uHNOYwpEBYSYWQk68BOuAL5Lb8/Nxfc1fOcbrcWhviG++54lwzKZTjhsYMd+KhIcM3pUrbISNFwKV6COyIB0Sq6Hd3acSMK4tDliictDxCSGPaWNH/hoYp+AEZU8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBT/YZQp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6095de12d62so1293329a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750076673; x=1750681473; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eB+ko6TbXpJvzykz4uDBeKWxiBLwVjXwLtVZDX1dyn0=;
        b=jBT/YZQp+Ew0jQshQRXnu9LiU5zpvSr9WdSXYQOZcx5jnBiNAzAeI6A9rhVpamwYoe
         twrNhzzC6VhKOh7+2FeAnCgIwhBECD6ZTV/tJ4Y5oEDVEqCjKrZRl0S15S5XS55bp7hL
         w7g47qvTMMoaz9b2422B7sQKpJOdV0LMxn/U62yunYBJpF07k5/WW1oLtMxkmd4Q1/Nb
         uTFr3qHqGL7nuJ98c9BlWFZ2/6c+vOTu929pF/E0nIGcIFpHGUHsjThRK512BaIT2LAu
         DopxFrCnsFSm7v2wo3X8qpzRHBhEmsXtMHZ7QF0+0Aa8wjJNJxbz2X139MUjMxla/Rsl
         CE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750076673; x=1750681473;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB+ko6TbXpJvzykz4uDBeKWxiBLwVjXwLtVZDX1dyn0=;
        b=rXA0v7yVlYpu70dh27sj/M9Ne1ZZdm/8OIFxiEzCMVVKcYnhwK2Or9bPrRed/PIhh2
         87v/4tSYFXkjleiJyj5MiwQ8mTu7Mgs39bi4aTbTKNiMdatTCLeLEgx8NNQwHlf1g1OC
         Efxc09vuzZJb6LYMtaUd88mMOEC5vxoKmtJaNJEuUISX2hwVCrqQg4Ez+lFSBSkHm5aQ
         VCpQlvpG80/ZJc92uVzjRKXQPgrnxFgNcIc5sHRvWD8WR5w9x5Uy4NicjdWU5/iZSOYH
         NadAyGPcYxILIS+gGZuA1CPZ42hn/q+dkGqTyOHFMF5xa/BhGYaioatLWkL2f6ukljfM
         YWkQ==
X-Gm-Message-State: AOJu0YwSwWjUuVDCQXBWsipc9Y80Te9Y2VHt5tmqSHm023yC+jk4GpVn
	m2woHA1pANAmLPQ3jQpsborZqLFFYK25tbHb56R0qwnYg6YIOPJkVqV8
X-Gm-Gg: ASbGncuCDbS8EXnrh/5CgJhBCyqi/wha+31zDR38X83PIBIurQHxg9A23NX7StKjMWb
	RdjDew4vWYsbXShLRCAhDa3K3/tmoy4TmEqVD1M9u2FSSTBWQkTuyyZ7zbu2KQdx4VVsBVvDI7n
	NspbfGzsdRJBZqurcoSo0Gh1btjLIyDtBj0gsFt8tNtg56e0ZYyN6E2ivN8Xs7wXjw6E616pJWi
	IfAZ0LTW5lHpAeT/mT7TDg86zUd66cDftZTqOv1NH+jq0cp2LwmsLavOqfl0/RxCDsippXVkwLS
	MTyzV4yZ5nuTflipkZxEe9wLznYW3U84zGSSaXYL9DjuBwm15SojvO5KBadJ2g==
X-Google-Smtp-Source: AGHT+IFf70hqSFEWAMuFypEc8w40uEwStePVbrlV72vrCLlxPpuZmMDqNnw48pmBuSi095QtPGPEQw==
X-Received: by 2002:a17:907:3cc7:b0:ade:9b52:4d79 with SMTP id a640c23a62f3a-adf4c6f6e60mr977801966b.1.1750076672613;
        Mon, 16 Jun 2025 05:24:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8978f8esm646098466b.151.2025.06.16.05.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jun 2025 05:24:32 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	skhan@linuxfoundation.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] selftests: print 0 if no test is chosen
Date: Mon, 16 Jun 2025 12:23:37 +0000
Message-Id: <20250616122338.32678-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250616122338.32678-1-richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

In case there is no test chosen, e.g -t non-exist, the following message
would be printed at start.

    TAP version 13
    1..0

Change it to print 0 if no test is chosen.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e..9fcf76f0b702 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -144,7 +144,7 @@ static inline void ksft_print_header(void)
 static inline void ksft_set_plan(unsigned int plan)
 {
 	ksft_plan = plan;
-	printf("1..%u\n", ksft_plan);
+	printf("%u..%u\n", !plan ? 0 : 1, ksft_plan);
 }
 
 static inline void ksft_print_cnts(void)
-- 
2.34.1


