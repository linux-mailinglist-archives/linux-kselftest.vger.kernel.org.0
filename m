Return-Path: <linux-kselftest+bounces-26126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6FA2DA68
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 03:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B226E7A2DC8
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F72F22;
	Sun,  9 Feb 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXARCNBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BA28EC;
	Sun,  9 Feb 2025 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739068600; cv=none; b=MGIF2Rqz6RYSvREHP3/43zUCfvN35QAU8gPuZ5PJV5nRJoAhrgtxrJxdxAERVjK+TwgtG8h8KBzAfKubyY8YEOdejk1NUu/lZT4vob5rtOMJ42Ukh0wxhGf8639uELn9IVGofoaoRPHQoINzlVrL+JOg+YoI3KSsKtaby5jeTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739068600; c=relaxed/simple;
	bh=pS69x2HAuQdB5WvJUFht2GfCqUjziWpMjHIUcXpBMZQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ugFsJVVt8+3WlL8xWhGFthHGRVjoKoV2mNwmiHs5ZvN8MYu9BT7HMWO+qUwAQO+zN1zGtV3U/5crHclgI6ri+tyAd8SJUnvg5Eis2AWUiG0S4jSZ3HqIkEFr2Gsy51b3wGNesFXTVqaQ8WNQo/dlrmzToN0zgI6w+t4mEcWoqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXARCNBP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467838e75ffso43973931cf.3;
        Sat, 08 Feb 2025 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739068598; x=1739673398; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c91HWZy1fFlDgVz0qIHWmpnAmmBH8HnmyKAc0GogYB8=;
        b=hXARCNBP5vYad0CRZMavwrIPdbZLM54e2BKBsJ7bGGoHXEjkR9gGx+f7kx+4rstP/j
         yfdeQAZdF+yEvFW5pZoTyrhtBzdWj4GEXweYEAssfwB9cZ27yxpkMPoAo/wMPGAO24uR
         +vx1pGUyJyGVbi1eMNhFLhdM5T0vu/EBQuMGCyT6M6H78xAccHBgsgBcVFdNa6t8chV/
         mK73rHHJr7EVHZGRJAJGciuiD/AZ94BNsRlCZ4n/Zk1c/hexueH8NoqnSlNonoeYCrFd
         lE3zQFRjyV8ew36V18BcXZ4+dIwMYnE361aUVGWdBxE17LNwolXuQpf6moOJLytnuJyG
         mM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739068598; x=1739673398;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c91HWZy1fFlDgVz0qIHWmpnAmmBH8HnmyKAc0GogYB8=;
        b=kMffhsqZZ/OX+INkxPpEsgfoASPSgc436pGBFlTAIioF/TAjHUW5wFWQ9HnzJdcPu2
         YnGdXa6NQvoNLvFpW5vQ9rqHKKGYOPBV1S02Kg3eqW1PVho6uMntO6pBX0rC8Wp0ZNkN
         1qUEqEtQzoUFvdr/8NfSZEPscWZ6ZG9/EZR1Sq4bzFrfprNYJn8v0r92f7bt+CHWyz6x
         9h/J+wXux95fXd0K2DJ94p3wu7mr5wMZU6wi5X2Jw6BbhiSAfOVqIVewujy1vPn3kKxZ
         GO8KZcHkqjKIRLI1L0wy90J8IBowI31J/KdncI8miOLoUrVazFfpU1DOSKtYHpjO07EL
         0bFg==
X-Forwarded-Encrypted: i=1; AJvYcCVj/NV+tQb989EqNOOss6nxG545X8YXvEcFxEIAJaj0vpePOyziJWzjVYa6RDllwjF2RNJuaAE4axCpzys=@vger.kernel.org, AJvYcCXxR1mg28YYlUQg6JhhfnYAnwcAlkDs/F76EnSDLTDn9xYln2h5upv1xRHeRMmjHbHFfuvX1LPSHjODPR5hK3Dz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GIO49AlYMthVzpZJtTPYG9QzZE3qhcQuzQEPFxkvI2N2sE5Z
	5bH7OqyLZt8CwM3psfPfnN0k8eq2XqO0jJPwKQkclifKKDL2w9OFuF/ACwGo
X-Gm-Gg: ASbGncv/e3Z8HkUtG6ta/wXpf0X6SqL/acQsYo565Dc1lsjfzFqA1fPBUiR4rRuRu0a
	Dz3PvWykmy8ZGUSkhNiPn2ubNjc5rfTjFKsbuE1z3wZ6t/sPRh56HBGwaqxsaco8MKQgxpIHjUU
	kNAHCVpYglhPxg7NTei6xV7BabIqEI0ComJBJjllu/pVe7n8PUuQQzXbYaNw9jdslCJl10yLEGA
	rPjkUTHNfvq1VwfuPQeNy4sPiwyVXR3PEzoPVKZ+Fa0jTUNq8Xm0r6gcDUJtOKYW9ILdC7di231
	SV+n2gUsbV8nxstUyyqaVLkM0HkTr9XwA1XRVcqSWb60GMbiYvFCjhnnJw==
X-Google-Smtp-Source: AGHT+IE5Rj5g4p6RW6TyFbdKmS/l+asLvxM8qVlCkNFu4snbUM1SLLePMINQHVvRngLLyItLy4wjgQ==
X-Received: by 2002:a05:6214:d69:b0:6e4:3fb2:538a with SMTP id 6a1803df08f44-6e44572761fmr150702436d6.42.1739068598267;
        Sat, 08 Feb 2025 18:36:38 -0800 (PST)
Received: from [192.168.1.105] (c-73-176-204-61.hsd1.il.comcast.net. [73.176.204.61])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e449e0d2b8sm20387276d6.23.2025.02.08.18.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 18:36:37 -0800 (PST)
Message-ID: <77e0e915-36c3-4c95-84b8-0b73aaa17951@gmail.com>
Date: Sat, 8 Feb 2025 20:36:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Eric Salem <ericsalem@gmail.com>
Subject: [PATCH] selftests: mm: Fixed typo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixed misspelling.

Signed-off-by: Eric Salem <ericsalem@gmail.com>
---
 tools/testing/selftests/mm/uffd-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..f23c57d9d1bd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -323,7 +323,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
-			*errmsg = "possible lack of priviledge";
+			*errmsg = "possible lack of privilege";
 		return ret;
 	}
 
-- 
2.48.1

