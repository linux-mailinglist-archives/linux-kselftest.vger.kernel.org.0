Return-Path: <linux-kselftest+bounces-3707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7148415E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6430C1C22D42
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEC5103C;
	Mon, 29 Jan 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRmpPfhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A494F1EC;
	Mon, 29 Jan 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568346; cv=none; b=tmstdAgSRz6SDWs+OWxzchPGcq/wLPm40Ftgw0s5xcM0sSCalfEtLDnQwJwKgC+J2fRmvto1Du4xVFTy9OrqamNmbhzDMrXRNt0VPFk4z4ARGdLA+7IUzRCNzr8N/lfVKlWc59KhMGkcitU881F94oM7yq+PCEsZrs+yskkJK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568346; c=relaxed/simple;
	bh=d9dASAYZVxsCcMrrA/Ez2Y9axsArxUPAk21y1cr8mYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6ke1VSIbz0mGI5vptY3wG6+kNL2bY5Txh7QLqesvGKo8aSaXUOIwKKHACFjbHQoIpfihgSaolONkOplZSD9kOVylvxM7QOyDICblwu4xZfkJZQ490mDpoOshRkeEPRz55mTCJF2eO7PxLkguCciyWa8GQKSXRZtjTJv6i4GXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRmpPfhH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6868823be58so24888986d6.0;
        Mon, 29 Jan 2024 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706568343; x=1707173143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3JKWr6vkV83y4YZraciKQHHZz9sGV8OXuuwrIDvmCQ=;
        b=CRmpPfhHeb2MVT5LgN+Rtf+JVikIrJ1J8ryvIvg1CVSEckk9wZ//NHuqm6uCr6m2d6
         KehxIHiLovW0yddXrjZujJ4YnUm7q2idWofzbvBYogmVgVARlLU/bOKqOuvf8uJGD6SK
         +xwTRqeKg+9vWWimC3vmxvy5oHxV/zHLURdqv0giL5C8dojGUG3d2LvzO4MaNZ2BQdV7
         F+tpP5dWhHYYx2ApLxuTWzDsQB75EQwUqNs0PAr/IfK8/r4v8gGTINzQLfeBGyGKGP0D
         zqnmT+1xkKhhDTAfUMvcmem/kZ90d1T3jBIVTbP79lvkAFQwBEuPdnmNSDQE8Oz5+/U2
         58Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568343; x=1707173143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3JKWr6vkV83y4YZraciKQHHZz9sGV8OXuuwrIDvmCQ=;
        b=iwzPSHDmpmZ9HSJ3n7AeiyorL2huI/50AVryRDsPXWzll6QafPkMnhUPkDVT9S/x8g
         k3gbEo2RwjJnVB6uU2oMfDQpUBMhFHf4/nx3PVxQOIj47MlHxVWANjNwqvyNFOsvZm23
         IAlXJJYrkZagOwWFE2QQgVoGmV9f3DuIg0gFIEXkPsCod44K4zYBdXJPVHsVAjvb6tfH
         uaaf1tSssxyTf6IQKKd4wjicE+l29ZwiJa25y7kelyUdCzv4pR6CZuGt7qGIecY1rlKI
         mZ9NZtpWGQ87Iwbq49HypYPWyGjvCGVFbG2hvuSugasIVIi7HqgkIdBhioiL1NJOjqyq
         o+dQ==
X-Gm-Message-State: AOJu0YytXIks2aWKY2fpMeAnM7bilYSWIwX/5nh9LVARvTjHKcbqAwgO
	jOQvy37260hNKyoDXX1EERh3yP4RzI7CwOE5alcNPlEJ5QIvngiaHWTSjumt
X-Google-Smtp-Source: AGHT+IHGfpYkQIuBr797vwJUdfDqHN+zox8xp38LBl6covm60K0wtDOMjuoBeTuxSaVV/2VRXP0wFg==
X-Received: by 2002:ad4:5dcd:0:b0:68c:4942:b0b0 with SMTP id m13-20020ad45dcd000000b0068c4942b0b0mr2981525qvh.100.1706568343643;
        Mon, 29 Jan 2024 14:45:43 -0800 (PST)
Received: from localhost (fwdproxy-nao-116.fbsv.net. [2a03:2880:23ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 12-20020ad45b8c000000b0068c501d0766sm1260449qvp.41.2024.01.29.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:45:43 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] selftests: zswap: add zswap selftest file to zswap maintainer entry
Date: Mon, 29 Jan 2024 14:45:40 -0800
Message-Id: <20240129224542.162599-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129224542.162599-1-nphamcs@gmail.com>
References: <20240129224542.162599-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it easier for contributors to find the zswap maintainers when they
update the zswap tests.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fecebfc4c0dc..5f60faaefaf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24396,6 +24396,7 @@ F:	include/linux/zpool.h
 F:	include/linux/zswap.h
 F:	mm/zpool.c
 F:	mm/zswap.c
+F:	tools/testing/selftests/cgroup/test_zswap.c
 
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
-- 
2.39.3


