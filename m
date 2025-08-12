Return-Path: <linux-kselftest+bounces-38744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF0B21AC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 04:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A90F2A4EBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F82D8365;
	Tue, 12 Aug 2025 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jarkzxkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D120C478
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965615; cv=none; b=d1QxIImV+EZnqYhTZNR9YS561JqJtIfrBVITk0JQm8IohFfTnB9zLFhap0hBn1hRFA5aS/OZEazfFwFFO2sTpVk8YZYeAKk9pCYR4lPK2VpdTwngfLsGOWHK//5FkZk+gwEKyGD5cFiFCcXGTTFI/RbA+mmkw/bHh6RDKJox9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965615; c=relaxed/simple;
	bh=tiLtGb26xM/rljzOh9bOmP4tI6beFIMIEXOp2amuWtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFvrZxpUJx4JcMghLt2/apJug7I5c5TaPzt5Qz6toLk/CY7ZLf2ByhKdL3EBerpICg93em5QNk9RgNIbhTDfuwHYYGLWTbZ10eY9Pr4LhHQmxhCnVfYwy1hAOZ38SxBNt5yfrFIVL5fIbz8Y/SdJN7yvmwaEdFnj7dF8QkhPkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jarkzxkI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bdc73f363so4411405b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754965613; x=1755570413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiLtGb26xM/rljzOh9bOmP4tI6beFIMIEXOp2amuWtM=;
        b=jarkzxkI/SNBpbLHpfiLuujSyY1S/lWAmn3jwDbzSF78UVxsniUYKIDq8tEO7yjxi8
         Sh6pE6ZxV14IjfHvqmUFfge87sym1ZEcCL+tTbrc3742BYOL2hTkEjSxIti479f6JsgU
         z2t8L/fnF3to9CZyaBpEZYBh3lzYC5Z4GoaUKXsIR2h7DCPZSry5S7eqCOdTdqWlqzwT
         fTTHQzr4HIN6mh7az/GTY+CkqUFVS5aBDEUvfZOwAiHLY0NlVJRUIv5QvexvT9x9a7v9
         N9XH/JbaUwWcNZZ6YNs6L6SiLpdZI48uE/Eke49jX8RU97nbMxmNOHAl212fdJzYbZ/i
         rmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754965613; x=1755570413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiLtGb26xM/rljzOh9bOmP4tI6beFIMIEXOp2amuWtM=;
        b=ZRM1bbuyh1GQ/TRaIJBe+RDE82ha4GiZcyeuKpGE+k8e6+HDxLvTDaoaxtu5e222lu
         p0/QuGFkriC785AVk+yBTGj1uxICznB6LVKh0uHE+9SUnNWlhX92ZJUIC+M7+/bzGrJG
         A5UAf3BWN6P1LDskM9n4sfWErXGzN3FmBLsMs6rIw1OAQamvSSzjCAVuv3ZSIsFd7wUt
         47MS7QpRdUVxIsnKiZibZYs8dpRuW+2rCeNwTztEUiNvxESi/77iY3Ya8dISFtHfJO+8
         7qgxUuPSyecZkOK3OSFaB+MR/tJdJNYOgEvVl5rQYrSRhcYP7tWdJq4dbgEDIUEvhCVM
         rVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL5j7S+V+lgnoPpJVikkopHC/L76Wz/wth3nyNO/NUrZe5S8KlK1G8nwlDx4gEURgbVLRxckNmFvljJUZ5Mjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RGw+qYvAz11VLhksgZa97svMVpnNm+TlETcspjSS59UDXeym
	l1fTGu8sy8oiQ6Sq+M4HLBrdVbMd95KFaMIx8IQYI2S4uMnRoNpjHCuK
X-Gm-Gg: ASbGncsdjaTHIiJ1kNZVx75eC64hmSrmdJNgzP01+pUPVVlFnWJOF880j9iI+phSHyH
	um2nekY1XksCcoEWVwQpaGyoH07jNCjvSgysYWD3Mk88fe3TL+r++1pVdf+LzewqRknhLSu3//H
	Y6mcWAE+vqbGcaIYXJc4YoWzdYlK0hbq9MiKXTXwlDHkIsZf70iK0Z8N6M97088YooFNUqd0Tdr
	6WDyEKn8tycGGEVn6EY2fuKQtmCVA2jGIHuxW4icZ3RgyKBDojtOx8jkGtL8Vnwn5PPQBqVCBWC
	7KPAHLlpwJUs32zGNeF+n3JAbocz2PWVeUnnnpx0dYhJUotdXVki3YUL0sRPVo70bUltvLRjWd1
	PNGFeePK8eCGxBkNB0jUM+392Sn00aYBs0Vqv03d1nN23hQ==
X-Google-Smtp-Source: AGHT+IG7v2sUZNZWdWgrLXeE+EbrQkrLxRlUOY1S9LqGCz+ODOxnt1uAtdoQIuU+xHVE5Tb9DxJM+Q==
X-Received: by 2002:a05:6a00:3c94:b0:76b:8b13:e06a with SMTP id d2e1a72fcca58-76e0df53209mr2731652b3a.14.1754965612844;
        Mon, 11 Aug 2025 19:26:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:21f8:86c:502a:b15c:34c8:7272])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce15sm28162654b3a.64.2025.08.11.19.26.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 19:26:52 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	dev.jain@arm.com,
	donettom@linux.ibm.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been passed in
Date: Tue, 12 Aug 2025 10:26:14 +0800
Message-Id: <20250812022614.4964-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.

> Pass in the hugepage number and do the check based on it.

LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>

Best regards,
wang lian

