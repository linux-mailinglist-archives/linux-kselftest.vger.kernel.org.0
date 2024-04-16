Return-Path: <linux-kselftest+bounces-8229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852188A7786
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 00:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACFB1F21597
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DB76035;
	Tue, 16 Apr 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZFsERtc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3671DDEE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305407; cv=none; b=l0uSRLWS4q1UCoG2Mh2kXNd8xZRSHHwOjKReRNp/aFTEM9s/WeRVISHDI1mbkpm+W1yPpqskAd8NxfEepVX1qRQEAtgM9ZVcR5uwFd7F62N4sLiHgEIr2HWarb4X6M9qc+EFMuwLilPU68V1DNmW5C1Z5ZSW7aCE/eubRTVGugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305407; c=relaxed/simple;
	bh=WRfn/cAsNNMRbBq4GuWQdlT1whoo5mgh0SJ91YMp45M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBrEwhcKlWVndzo+eAiFWJCXHoef6QEETi5Z8SKtN6iOL3QcG75IE9kNFnLyJ6wV1wCm5bdXjgPpF9ZaidWAM+YJ8mWGUJ5jG7cBlIAmU6tXoTWQmlY/pI55ca+alX53EdAncQlqPDU4mgIzXfoa0jxxZ1zuOzF7VPdOBjxeDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mZFsERtc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so4510613b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713305406; x=1713910206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=mZFsERtcoeR+yD6q+ecfyS+3pRFu1IrSUxDCgnESXNVP2gX3duOq02JoBYd6onKPkO
         QCzTDUlGVfwb63i9R7CsdkZqM9YWeTQnyYrKVvFV29f6SbA56cKAk3yKRQzaaY+bjogJ
         jBhp5wjwY3vGVkiE62AQ3mbu5JxPW3bDGs7Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305406; x=1713910206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=ca7b7zNmodghFpYgGw7LG1b2mA2qitfmM1/CKEGTI2aJ9n3bA3qsJaXemDiAo1FVTy
         V4MXrH8xtXP2wsCCl2yg8Wlh8f0KKWngAHP1Or2annmSpPq9Q9TXd2bQ8RIqrtcUeU+E
         wT4xZxlabsXoQWT7OhxvegWRMNZTHmcndkW6MUb0VuXNtBjIyhDNmHztdpASCL77US+1
         AmDnkU3EOfB+YlY39HFrycK/ZpWxSXmN7QPptNV7eDgmgUyRxKCKQB4puVPcGbqPvt4p
         BKCsByWJs3eRlPhg5R0EMAyBBtoa1y/nNN0euhRpb4DoY466HpmASHMom3aKpOtmoZEq
         6wGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5yduQlZ9CovuoVZRMXhYZUp/1mow3x+7QEFSuO2WQFypq1hJTJhxxqaGW2QCYTEENENhwtS8ZVIH7fHDRPiqJ2KSttq5c7hFVOnP/WZlM
X-Gm-Message-State: AOJu0YwohELOhKILv/E72myNjOMaZAQYelpzIuzerc5XtZCyBFYKmS7R
	w5RPQfDPbDoPcEEuprky9J4vwf5k+SXDWA3mz9XVhXXOqcbwLIf/2SEgS+JUbw==
X-Google-Smtp-Source: AGHT+IFXzTOtdhmzkFf7kvRjs/2yOBCu6yaN7ivsHMPoTYcwF1gpR1l+bDIYrHHeInvIb0cUfNNPvg==
X-Received: by 2002:a05:6a20:9f86:b0:1a9:db37:bef3 with SMTP id mm6-20020a056a209f8600b001a9db37bef3mr8840834pzb.12.1713305406053;
        Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id q4-20020a656244000000b005dc4fc80b21sm8032266pgv.70.2024.04.16.15.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 15:10:05 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] selftest mm/mseal: style change
Date: Tue, 16 Apr 2024 22:09:43 +0000
Message-ID: <20240416220944.2481203-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This patch is a follow up to the comments [1] on test code during
mseal discussion. This is style only change to the selftest code, not to
test code logic.

Please apply on top of mseal v10 patch [2]

[1] 
https://lore.kernel.org/all/e1744539-a843-468a-9101-ce7a08669394@collabora.com/

[2]
https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/

Thanks


Jeff Xu (1):
  selftest mm/mseal: style change

 tools/testing/selftests/mm/mseal_test.c | 124 +++++++++++++++++-------
 tools/testing/selftests/mm/seal_elf.c   |   3 -
 2 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


