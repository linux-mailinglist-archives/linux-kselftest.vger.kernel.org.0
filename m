Return-Path: <linux-kselftest+bounces-21775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EEF9C3C75
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2321F21259
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459F1714B9;
	Mon, 11 Nov 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFWlgv4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293E157E78
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322456; cv=none; b=WyAUB10YaepIEGHNPRfngEypiEEc8FaF4ZkF+KxzyO+8etFuFk0Ya7EQYQhNv0/RfBB2wOc9ayKmSPuTnfNfLKzCWu6yAvVhwNb2nw1s+RD3wBpxheO43l/MBSMWiZx0nsjGCdp6gS/ox5RW/YaNZDw6APLy7OCIK+bWyEH9wYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322456; c=relaxed/simple;
	bh=OowcFAz5Dwz/C1seGeNFxtRG1mxbi5v5LtbKYioHDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kHFWFVVIsJ8qpd3l96h0EKFO4R6c2Deq1bp8LHdj+QMEWiBQBJRr0bOrFCc5NraMEGSGnWheuSPgVsi6QNu6KIROZbFMACFHODB3FuuPw/e0bO0GkOoRgFDVqf6d4f/RY0rdaELKXTZz2PCI6kJ9VKwnph17EhM3Gpd37/TUA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFWlgv4y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so177317166b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731322453; x=1731927253; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQneMUOMjSH+Cp2gVnrl7p/sshIVbnp503eWg1V6QLc=;
        b=dFWlgv4y5jEjfnjNP5Rxf29H+bSS1HT7f5qxixeRk/Pf0OL0idbXp/folesxxMZxGz
         P7BwQpdNvxTjeLg6qURBwHJ1bqb52ywYZIy4vZSaDRoWcfGllCMDiI2/35YawF9CmOSM
         sWR9yakxxUra4El48sVqaNhO4Ut7X0yev+aQK+u6ho5HlVEOti9ndAgYY/cyl+1UktvJ
         asuRT6sCFBui7ExBvOwyBeAWM0O5/+exEl/Dz5v9sb99WB+NcAIzBRNMJdxnm7OTfyKe
         HH7xbZ3EMiv6PjMz769Pg4j4EAbNe5XTNv6ESo/og7iBdYWtAELOsijGlELMfacT2QXa
         FFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322453; x=1731927253;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQneMUOMjSH+Cp2gVnrl7p/sshIVbnp503eWg1V6QLc=;
        b=kYpbV2D//HN8FE7M9fYLs6dnTI30pNbit5EdJLzp2t0P/eHrBuUbp2U/rLREEu4n8P
         xroxHgupnY0wxuqHDkgI3ENJ6kFf5RPJW1VaFuYmNFxtqIGHri5a/bl9vxot2l0PMF7L
         ZWO39od3uVi7S/IXjNcVpsm1w9Oe43sGY0fL/9SLshZ+v5R5g3XVWRnTi4VszU0J4Mpt
         4UFF5HlNB6NjEn4f/s3dXMmflbhKwtCkVecS3pHSekIvugsG7SRInpCfwxsPsLHCW6ju
         qUG4FScrdNbEl3YvBZoeImH8HC3KAMAkHudVotDUGPznKJXaEhJU1X4QLZCUYjXDYLSO
         5N5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaHduGl6OM1iW285PAfJQ7L0m3T1Ebc3WY6r7d8PwAb0nkqCg44dcb+OHC/Arwp8+rCxJVeBMel30v+uW5Y5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBofSRe1EiUvURGwxaCD5/wCXsRoV+mYeU6RByQpzHpktKqMK
	QfkuW/gz2dDRRsUxZSPLsgWdoqEI0oaP07dfWrLrY+pc5c1E6ZJn4lZlxa7AZc0=
X-Google-Smtp-Source: AGHT+IGGNGfUJKhCO6MzCsxlQnH5pxc4VNoNzngtjkm0QZ2t1Vi54hvYQhkfEkzTtVc4Yp3e4sQ5dQ==
X-Received: by 2002:a17:907:1c11:b0:a9a:26a5:d508 with SMTP id a640c23a62f3a-a9eefebd194mr1111771566b.9.1731322452841;
        Mon, 11 Nov 2024 02:54:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abe369sm575830366b.83.2024.11.11.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:54:12 -0800 (PST)
Date: Mon, 11 Nov 2024 13:54:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
Message-ID: <b31a16ef-382f-4b8f-b4d5-1c4d93803779@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Kuan-Wei Chiu pointed out that the kernel doc for kunit_zalloc_skb()
needs to include the @gfp information.  Add it.

Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Closes: https://lore.kernel.org/all/Zy+VIXDPuU613fFd@visitorckw-System-Product-Name/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/kunit/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
index 345e1e8f0312..07784694357c 100644
--- a/include/kunit/skbuff.h
+++ b/include/kunit/skbuff.h
@@ -20,8 +20,9 @@ static void kunit_action_kfree_skb(void *p)
  * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
  * @test: The test case to which the skb belongs
  * @len: size to allocate
+ * @gfp: allocation flags
  *
- * Allocate a new struct sk_buff with GFP_KERNEL, zero fill the give length
+ * Allocate a new struct sk_buff with gfp flags, zero fill the given length
  * and add it as a resource to the kunit test for automatic cleanup.
  *
  * Returns: newly allocated SKB, or %NULL on error
-- 
2.45.2


