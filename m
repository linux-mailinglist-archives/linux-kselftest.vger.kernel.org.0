Return-Path: <linux-kselftest+bounces-20832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B369B3A24
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43EC1F2216F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475001E04A0;
	Mon, 28 Oct 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA74rhsc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393391E00BD;
	Mon, 28 Oct 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142539; cv=none; b=gPyE5x9xMBHuXrCN2ZafynzKJXnyaDUeuvA8Wix0jgqmkQvQeNjO5G4FvktfFj68UHMsYiUgeutgLxog+q6TgG3OFuFEJrGsrJ5HD8cBzewwjnM5rXAnsJiYzyadi/RGEPJKwu5rU3ZibmzF24u8lU8rz3SFWpH1hRzpINvgW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142539; c=relaxed/simple;
	bh=juzQed7nnXh+FQnf1uqouJ8jQ4RVUNqP8gGoG++nFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNh+o8PI6/DtskiDx3fhnBY9G+z+3VtNyqOCtqDFB5E5ezt/e1R8M99A/9JCkU+c3sIjF+EodmHhscqghjjMCgC1YUOvXExNkB/qmgCIS5L6O776mFcALdS/4UwwiJ3WhyqGjzHvTFnjLxuCyDHS7kTbUqD1d0VZTVbaPKm/5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA74rhsc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155afca99so38974085e9.1;
        Mon, 28 Oct 2024 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730142535; x=1730747335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1qbuAiPz5TYKAmQptNfnQHz/yYjYib15fW/6alYJUk=;
        b=eA74rhscwCl5RCRcalmmCIzCBz9kOAmF33UxXcbaRfuW2NarXhgXHBjnlRkuWUWFb0
         ggvgJNQDwFniBxtUm4+8ALp16DGOKOThLy+pCX4tIb+1TNoxQ0MSOjWTLrs2o1duOtXj
         jXXFxZXLIoR4pgtv0+KvkFbYO4EQ9KWhG5SI+aQImZvmy5JfAdaHXH12eI7uUd/yT+1x
         S2EGKhVCIDsQlaDb0RVnEtOmzc3clxgwroPisGcdcfioMvTBqowdSVTV6b5AabNTY3Ox
         rCZvpogujpBHW238aWEpdup/fcnoUMSPPW/p2yhHRB+QQ4R7bBZBDZ+oeIS9WV1v7kM9
         TZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142535; x=1730747335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1qbuAiPz5TYKAmQptNfnQHz/yYjYib15fW/6alYJUk=;
        b=gdnKxermY16IORiX+aQ20TSsuv2GveE/C0AyXSVGPsdFYrIeSO+79uUmRnKy90tXpC
         LF2wQ4cBUCGGCQrKKl82VP7dWjHzKb2mao/+0aWb0NgZB9U3Ba2GR10b7IssPsL6zWfT
         7eeNg9obM53xs+rYIBZhjC1Qct/XJger5RCLT2JIgv/uOky//VE5FwV6/qa1BGoNC0mu
         AFLSH6y6X/27BuOljMDaxKKjnMSow/3x+nNTwUWJuJogZlwEWdGAz+B/GAzfK2wMg++3
         awDuHRV3yZozpljGUcJQBY0QdjP6q45lSHsAuloPv8ITu46WgvYitcjSACepC87U2SRt
         e8rA==
X-Forwarded-Encrypted: i=1; AJvYcCW5hF5Eb/d18/WXUFShAoznIYqVF7s/5HIDHESV+qsNBp17qLJA5YBKxk2G2hs9LrzcvCq71VW7cM+iTQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cqOENvWZOF5ow6mWKDTT7n0Xjl1T2NP8GcaNpftxxD+8IYaI
	Ap7M94wDdG8gTUWaUpIgwRjggMAuduxPg6NkS1TGs5FrgFGOUKV7aVgt24an
X-Google-Smtp-Source: AGHT+IE49DgskR1ez7rSfoCNGrbCKwXf7v29Y/KIZ6kGw5w58kLv0cikWgffbUw81ct7hTpk7S/FQw==
X-Received: by 2002:adf:cd0f:0:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-3808139040cmr591580f8f.2.1730142535350;
        Mon, 28 Oct 2024 12:08:55 -0700 (PDT)
Received: from localhost.localdomain ([78.210.79.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c69esm10314398f8f.13.2024.10.28.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:08:54 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Alessandro Zanni <alessandro.zanni87@gmail.com>
Subject: [PATCH 0/2] selftests/intel_pstate: fix arithmetic expression and cpupower
Date: Mon, 28 Oct 2024 20:08:42 +0100
Message-ID: <cover.1730141362.git.alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address issues related to arithmetic expression compatibility and
cpupower operand expected.

Command to test:
	make kselftest TARGETS=intel_pstate

Alessandro Zanni (2):
  selftests/intel_pstate: fix operand expected
  selftests/intel_pstate: cpupower command not found

 tools/testing/selftests/intel_pstate/run.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.0


