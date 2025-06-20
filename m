Return-Path: <linux-kselftest+bounces-35397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA8AE11C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B105A1A23
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E391B4132;
	Fri, 20 Jun 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noBQMtfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917DBA36
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390106; cv=none; b=lbxH9PwuYqXmm0VUb9dyUEk3e0/cQ9stfOPiXqj/isVLvIdm0H/UhDCtyfJUIMPUVP5/IKGyyXLwvif+L/wt4u/EZaam5ilpKH0oa5w2QM6Jj9AgWwRYoCkGBSZfTESV0C0JTCZIbelB8wfkC7e2Wk6UtDfniQHk9o+Ffm34pEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390106; c=relaxed/simple;
	bh=Y/1KP7rl8AF8TILRxaxxvAJHgU9/9CyPH+LK2Os/yAs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JZR6sYLTYLu66C6NAigoU2vjYDyyKB3JMsCaNg3VvyVQ25qHY9/7rZJFsOjJeuuVWNjkFgHTNyAIt+PnvlEGZCjNnsrtmFBIWgYRYYc80aOnkwki9R3xtdqtXZbBoeDTXXu7YcqIPVw8aWTW3X/cwNZyrf4LAAFeIpQbDHfvQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noBQMtfL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so242815666b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750390103; x=1750994903; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+L/f/sgmum2yxxRy8qf7K8qiYAdflz6R/HVxVw/Y/g=;
        b=noBQMtfL1eqxcG6qfyusozkVd6ONIYHsi+APFdoutSwRsiVxcP2Xs+0RVIBw36JwZi
         OUQXTAY4FYsbepC+P7acv2wRcO7d+Hda0PvuNyKUv0xYC3fEHhnWWfqHya9/PzvXUowp
         4Y/xCjhFE1APXm/ms+N3A6V+Tpe1V+boClzhClip9NQhKWvBw8IFBhPGs5jbYlZ9w9iB
         wvw2QR24lzELGTfnwadlJmjvddc7rlEsW2PWnFpAmNu41Yl4D22zMq87g5gupBTcu48c
         D7XNuHadJnySk5iZ3a4krf+vrov5vqW3iFfaxTohZfxtreAQ4rkM4m91M0lg76Ubk1IE
         6dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750390103; x=1750994903;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+L/f/sgmum2yxxRy8qf7K8qiYAdflz6R/HVxVw/Y/g=;
        b=kOb31dawY60CPzSHNrooXzCj8IekDqfe6KUBSzN3OYo9UYiTikiQ2ime371yYOqrpH
         BTTXwNL8aB9NwDu3am/mqjeJjn3tEE+ODzXWu2nWQFS60IFgllQ7ZCw5norG+mMOdCx3
         f2XFr+gPQd4w7zaAAbzGGAjOW1aisqzCT8/SVuQWlzKJakUhNYDNS1CKxc7L8YL1dYHc
         ieBylJhGJjN+I1rOj6r74AECqq+i4U2zUmeEg7obmgL+0n5M4jpzW8fDB0rL9/5Sw9A1
         ebZ2HYau1+oSu63SCij+afQNvzfoNI9sn57iwCg4shHOk3ZlcABNK3ZnRKXJAg530DXu
         rnqQ==
X-Gm-Message-State: AOJu0Ywg/k9QDiMKKHBsjblpdy1DqDToDBJA975muDhzmV/ILmm9hK4Q
	BzlNyQP8Er1q/TDhtRYW936QijWWHVGBFTvhXE4dRmfENyXQbhIjNS+z
X-Gm-Gg: ASbGncuiP+1dWJzlhtmOLf/1Y1jis/k4Ju20/235Ezcvc/pML1AuG7sNT/8wVmtA8l1
	d/TPtO+NY2XCGOx/RmWJqldCp++yIH8ff07H9v5BeYyFs3kLzOpTMU4ALWehBZShtHe5Mc6bP2P
	sgo8AlKHd4iPtaMlJHoUQvGcP/XACbrmTVTlwuFIdQwpaY53BFeWaa+JhUIxvEMPr5hKOwpgl6I
	/r0kSDgnw9/tGXuf4qiki3g0Sg7s/462HYTkUqpPTY2E4c3RuwaMGxmWOrDygTNxBiUwQ5Z2Crq
	h7PCA243emcrEDpa0sTQkqRadjaw3hk3agEuLY8KHCg/gMhso8Yb6Q7NCUHQDg==
X-Google-Smtp-Source: AGHT+IG2ge21kP+dhYsbxCE54ZGmZSuSYry4kQXYQj/5ltMM8CoKAVnbzCWYnFjlDvkfTiqJQ2PkEg==
X-Received: by 2002:a17:907:6e8e:b0:ade:6e3:7c4 with SMTP id a640c23a62f3a-ae0579d30abmr111477966b.23.1750390102537;
        Thu, 19 Jun 2025 20:28:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm88366066b.38.2025.06.19.20.28.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jun 2025 20:28:22 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	usama.anjum@collabora.com,
	thomas.weissschuh@linutronix.de,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 0/2] Add kselftest harness selftest with variant
Date: Fri, 20 Jun 2025 03:28:13 +0000
Message-Id: <20250620032815.14543-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

We already have a selftest for harness, while there is not usage 
of FIXTURE_VARIANT.                                                                                                                                                                                                   
                                                                                                                                                                                                                   
Patch 2 add FIXTURE_VARIANT usage in the selftest.

Patch 1 is a typo fix.

v2:
  * drop patch 2 in v1
  * adjust patch 2 based on Thomas comment

Wei Yang (2):
  selftests: harness: correct typo of __constructor_order_forward in
    comment
  selftests: harness: Add kselftest harness selftest with variant

 tools/testing/selftests/kselftest_harness.h   |  2 +-
 .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
 .../harness-selftest.expected                 | 20 ++++++++++---
 3 files changed, 47 insertions(+), 5 deletions(-)

-- 
2.34.1


