Return-Path: <linux-kselftest+bounces-40360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D9B3CD3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CFA2070B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377C2D062D;
	Sat, 30 Aug 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORPKoL7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DB279DDA;
	Sat, 30 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572012; cv=none; b=Y548D6J9YHX0O+MiNvCMXG9Hv+sR8LKEFygrSSxrPuExhHlUd1opfGQVDgjQqyZ0+CAoH71ylPPO13vit5WGmrrmrzawYiNOX0vZXuh5HqdbmDleIa378advYf9Fnd8J0snl/cZkhRrECTllcs0BFVFeH7Ct/7vwrQFGBMtWSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572012; c=relaxed/simple;
	bh=eVLUazY+ItHIJR0vrscV6RbFVMYNt9c6JoHVbe4PzSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrtXOC7N1DvGiV4GtX4tmVF7wgBMk4X2OWv1NxGzY92P8rY/116L9CdsYUw5KqQZlPLBCKElQgXP1+8D+kNqAlGCk4fEAUXQXX3SUjWcxlLfCs3WcLTOOcR1mMG/rUEXvIMCZxQTY4NKuMGozbg353F3KU+Q3XI3uBOkgGpXVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORPKoL7g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-249406d5878so5810765ad.0;
        Sat, 30 Aug 2025 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756572010; x=1757176810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umXY/sVFrobJbUWoqmBQ/Qv6pKkoNjnUmJcqq9vp6mE=;
        b=ORPKoL7gBzevB9+TdqVk2Kx8HqqnSLj39cqNW8OM2ZVDUwuQj+QdGUOcNkeJGhty+h
         iuTAJ/SISHxmcjpn5vTVvSy+QoNRQhLlVJF8oTsa38Lt6AXJ9jaaWPwdWnru2Yp3uV5r
         Ra1QVCQGV1l0KGylAnsU/enUKGWnJqWVRBnG7pPmr49GwIty758E1uY/bU40X2EMTIj5
         6ZVW4+I7gNK9L4xNBhd59fMazfeYpMlb4fyAwh5GXtpOCzhIVljEfpP/hb9hdgAf6Xoe
         jpT43aZI64nKJ2LNBjRsE7dk81x0iq5yYLuI2iTnzLk+EJp9vSJwOcoBOLI/LRvrO7/9
         RTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572010; x=1757176810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umXY/sVFrobJbUWoqmBQ/Qv6pKkoNjnUmJcqq9vp6mE=;
        b=kRaokvBkpCwHDGEFW69YZK/7I1QqaJz/DujJo8SoVrOxAd0fWBKlGXQwqTo22kLNiw
         tzfLDgGEUIZan4FeaxEQXN1F2MTTJhKE0jfpS4qGYQ7XLEYXXUp2UyMNM8D/OmgHG6U6
         ra1a5erjqrKbLhqTETubDxbK6EJhy8lVXlvCOJfj8XIkClHmbnCrDR6Qi7r90CVxsxfy
         Lt5uHE6QvNggm57ToMG5qtGouYm74wddBOCIPYrj6Jhit7ksee7eyZh5mkjP1Whkf8Mp
         TGyurcRxZ/Dua98YNPuTqI+R9DGpTosVCpFTHnbWwp2KtyNuPgtCOoGIBFR7lvCu3ypp
         u0gA==
X-Forwarded-Encrypted: i=1; AJvYcCWLmIeuGCim2QOCgaVAIdkEHWeEWODYYGvl4Wd8kDTMh/A8muUe7gfVZ5z7Ztx4/Qrjh8LYIAFL8iDaXPXsL8Q3fSQP2GBF@vger.kernel.org, AJvYcCXTs+GDQcJFfB+4eMnNB4QiYbhjGRCskWCF5KeNszsmiURhHTtY0RFOllEWnLNpJ9FwS9T711Efo6HYHSY=@vger.kernel.org, AJvYcCXUBuYFbnWVDvZTsUpi87cwOU71FSIdIxt3SePnLYqz7ueeoqZGS9iX1QrNJCLjWBGPhMqzVlCsDtJvSqZZdhmL@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7HBgu+Wjkz6v0AuHgmNf5klaBQLYcYklpcLvIlCGupyx1xN1
	FJk5eRSxvgbcgWOKeaVYUtElP01NLy87sX+8lKdVSN5DLViob4soF3lP
X-Gm-Gg: ASbGncvNYPQJw1oaOM5qusFWkeGy2Eh21EsNs01lYGVbmCOOLjhbxEREmsqgq0LuKIU
	EiJkSA4TRcwYhMiwJGtDcHxIWYEzXnvxVIWrKthjukB6ZtPg4vIo3HP4Wrr0XT0twUbiSWXcFiU
	zeBw7eJWG77+tsqiFYMCR00UDwWIIgwCGoMgU5hTEvOtQks50NHOYlEP+Q8ekJDPQOD9whzhGNH
	FYfdStx4PclysIaJkroW2MjKxmkK17QPVhAgrxKtopGpGCcrZuXJkXl5zmTMKw8QWPEAXcILfeR
	fAICAwh1ZvCIdkhqvjwcSLqIyavCnq/IFAc6CYYWX/ntil1G5iZ7ZrXY0WAKwphuJHCfOXDHnbT
	xp3gS/C7oKFq5nBVoG6umlKVjpK/Ssw04t9bzSBPLu74utByA3yR5+9uB0Kd28W27DgARhuykP0
	D1uc/twHIuqeFJZ/8yCA==
X-Google-Smtp-Source: AGHT+IE0qvn0lpqX25l+3cOwT3j9bj2TKFinqvBV0K6OyVVKM3QLpi3xCHtF0y/H1wsrzDBxclGbMw==
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id d9443c01a7336-249448de13fmr29396525ad.13.1756572010388;
        Sat, 30 Aug 2025 09:40:10 -0700 (PDT)
Received: from server.. ([103.251.57.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm56975555ad.14.2025.08.30.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:40:09 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: reddybalavignesh9979@gmail.com,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com
Cc: Liam.Howlett@oracle.com,
	davem@davemloft.net,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: [PATCH v2 1/2] selftests: Centralize include path for kselftest.h and kselftest_harness.h
Date: Sat, 30 Aug 2025 22:09:48 +0530
Message-ID: <20250830163949.20952-2-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
 <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compile flag in lib.mk, to include the selftest/
directory while building.

Suggested-by: Wei Yang <richard.weiyang@gmail.com>

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/lib.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 530390033929..975840bb5477 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,6 +199,8 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+CFLAGS += -I${top_srcdir}/tools/testing/selftests
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.43.0


