Return-Path: <linux-kselftest+bounces-48459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF551D0098E
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8513630021E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF594165F1A;
	Thu,  8 Jan 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac5v75Px"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B521DF736
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837907; cv=none; b=PBmAj6Bn2M6vK0Q50LDbc49YA+R/jBjh+n8OvD5ifcBObF1YPfO5pOCIy0c3mrJFOqE3Xh8nmbzRNPjll0dBzyH4dxi7d/6B3WiWxe/lVS58ZboxsxtWSR6O4DguG/FesNKgt3/UjOIl5U6UZC/AuS113BMkr+ns4EFbfVZWNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837907; c=relaxed/simple;
	bh=wBeBmonGgFiCCCkuhfYiGKpWT1vbJJ/v1ghfdCv4+4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olb8LLRJmdeNY5V+gaeYPTqJbqQbqs6NM64MPdwQM9yRz1DDrEEvQ6+HulBYrppyfN8vvx+l1TiPEB4EbNDhpCTRT5R0MXKRQzLsQfYWU3eUVBDpgboCD4jz4KrdTcpK/wV9PdX7w2EtjuU6cb+7SE8Er41tHYFOR4s5jrFxxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac5v75Px; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso3795139eec.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 18:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767837905; x=1768442705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EiI4bUC7k1aPYBeEZacAnlQaKBQ93VS31it66ACRm4=;
        b=ac5v75PxBrvam0VLnYYF7J/teFg7kgvDx+pjpYR5uT4y24tHXy1NLjuKh0pqvMZY+g
         QANlgyxQX7DIFRDjeVKMlZnIylle1sqCSZ+LlrP/EuxZweRqteW5DJV74quLRwfnN+fX
         Bagp9wvDgEnGmb4jSuBpV4PujAIdhsBhBaxGJ4hWEbaNH7bLlTZVAKb7EoQ9UKqc7Shi
         0i1qSjYtRXdzQWjkNgwD9/olKszIglW9CDDrS2ClDSczcigKAehiTb8ylJaNk1UVB5mM
         zt4O06Ie5oHASbB3zmxio5XhQ60XvdObnNC5T5evD5z5wkBIRjVYnDSe3229lq2j96zj
         5nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767837905; x=1768442705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6EiI4bUC7k1aPYBeEZacAnlQaKBQ93VS31it66ACRm4=;
        b=J09nDnYfrgP8yTAz6aGbeu22jNQ8jDHjSuASugyxULmE/lexJ9COd1Ycf1R4lOfZMd
         6hkvaTM07x/EwG9feJKJIsuS6D6Lur3xSB90A4KUdfL965ukNo9jf8yPJONUjoXW0RwQ
         Ij9/znaAjZF2d9ccJxahAWlruUx+Cp52G+dqkOoolEz9tV7h0SIL5x0CLd15TNlD7caH
         Us5OYnZvj5FPu3DLzTpjT0pzuYeWvWUstFm01skNPlyAAJTXUTfbLSwFuznCraaZZVYF
         sXYBAHW0Wck4un54Z8ut2oXueb9xiUwl8+CKtXKUkrP/nFwS4cyE8EMBdpiezxGhXRdn
         W/xA==
X-Forwarded-Encrypted: i=1; AJvYcCVUMYg4/JA+U02LcIe7zCq6TMreZhbScezekDZa7r6TPcktOPMnxstzSwYv/TTVFgLurjmqHU2SCvnwPYlbOq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7RA9YP1HusTGCDq41RE5HoyXuj4wWtqPlGOAIq8BpEz5+wyt
	GSoC4VUJoSD6I25+Vogr92hvtaaSqTfgb7y8raPKfTkSMcOFz89l3D9W
X-Gm-Gg: AY/fxX47t1ElU4OmUYX8GNeNMz09P6GOViPH3kZSIajpuyhrSA/H/VBUTRJbOg1H/Ch
	4bW0mlBD5yu2ne4jkoYvfDp+jL2ve1yp5OyIUNyMpWqi5MJtn7ZkBYSF4+c0IrKjSwZ79V5xciC
	KZHJItxOu/z0bROIuxD+/zwsQAz4dUN5Ly4Qqdp2r5AbbCVOVuTL6p0W7mWaquMjUfufeJJ1EKv
	S2lDlWjCOu1tLN13OLFF6HNOVVhCqp7AUNHuCZC1aqXlZEa91JpHu44XiMK84Oz0jfgEflP6O5+
	MTVy0mNe2TKkicOIJ8dY5JZz9vmCWZSKS3MSEQFoJfBhpMNUIacdPdwjWFfa509q4/CyrJSyD+e
	rheEBbLt0apXWCGSZtjgTYF3xj/MG9rjxI5iVOrdKnYwqo1hvhoaB6CdHMy49RGV3Rn7itOPDSE
	dN
X-Google-Smtp-Source: AGHT+IFPhAbvKwIitO1U7vmQaIFqARcl+mHpOZz4NyI4VsagyZi5EQYcTiGLUETDH8hR/OBFlDAyLg==
X-Received: by 2002:a05:7300:c7c5:b0:2b0:4c6c:9ff4 with SMTP id 5a478bee46e88-2b17d2e3395mr2610609eec.41.1767837905340;
        Wed, 07 Jan 2026 18:05:05 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53fbsm7955574eec.12.2026.01.07.18.05.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 18:05:05 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: kevin.brodsky@arm.com
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH v2 4/8] selftests/mm: fix usage of FORCE_READ() in cow tests
Date: Thu,  8 Jan 2026 10:04:50 +0800
Message-ID: <20260108020450.44953-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107164842.3289559-5-kevin.brodsky@arm.com>
References: <20260107164842.3289559-5-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input
> value correctly") modified FORCE_READ() to take a value instead of a
> pointer. It also changed most of the call sites accordingly, but
> missed many of them in cow.c. In those cases, we ended up with the
> pointer itself being read, not the memory it points to.
> 
> No failure occurred as a result, so it looks like the tests work
> just fine without faulting in. However, the huge_zeropage tests
> explicitly check that pages are populated, so those became skipped.
> 
> Convert all the remaining FORCE_READ() to fault in the mapped page,
> as was originally intended. This allows the huge_zeropage tests to
> run again (3 tests in total).
> 
> Fixes: 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input value correctly")
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Hi Kevin,

Thanks for the fix.

This was indeed an oversight on my part. When we previously discussed this
refactoring with Ziyan and Lorenzo (and the community) regarding commit
3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm volatile
("" : "+r" (XXX));""), the intention was to switch FORCE_READ to take a
value. I clearly missed updating these specific call sites in cow.c
during that transition.

Sorry for the trouble and the skipped tests. The changes look correct to
me.

Reviewed-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian

