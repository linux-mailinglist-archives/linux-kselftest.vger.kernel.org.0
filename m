Return-Path: <linux-kselftest+bounces-9724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD708C0322
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4DFB22857
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B269127B5D;
	Wed,  8 May 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCM+WFPR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E612AAD1
	for <linux-kselftest@vger.kernel.org>; Wed,  8 May 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189516; cv=none; b=tAqoD4YEkpI8h9vdz8BSUEoF3fvxsEc+bykmjDpxK2MI7BeNfll3/AKfGV75G5JV3NPNXtB5LenKUdsEjf43QGii8vINFfbE/uixb0197Yv6V1MR+bXdzMgX1WIjYa8lCHvIL9Sm6ej5HnOYlna2RBkIpm4JXEK5gv6oYAOB06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189516; c=relaxed/simple;
	bh=5xDT7DTBCjbbpPDtqZw3zek1av22h4oXew+hsl9hZOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bk0HrkAsUR6Z0l867Cf33gDSYu1PJkmLSQpw5WM565KV8eQLngGLvmg1hPcUAfQKWbVR56XOfzoHkX6eJkfsXcdRMKIVBBNSBlBjT3XAfCS1WXA1gk1lxHfh75HqgErX95BCZHZSZEN72Z4zaTWmenltnTFeCCFPxtTsUnIJXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nCM+WFPR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so28020875ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189512; x=1715794312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LryZi+4xwYKtyQkC5nMcWsfEgNGSH+ki5if1tY9mlg4=;
        b=nCM+WFPRZqK0n4KYwKTC1b8m6FM5oyeYQZTwxokQ3YCgYXM+mUFSC+4EvK5pOzaXCZ
         eVQkOcuUr6vvWaWxylVrvp3mYYwm7FHP/DKtbhyfocIN+AoUs3bfGis2eo3an2FMt4ND
         PaooO3ZMWyXWXvvP+/AIIzWj6/bTVMTZ51qoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189512; x=1715794312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LryZi+4xwYKtyQkC5nMcWsfEgNGSH+ki5if1tY9mlg4=;
        b=CD4BTGKMhi64Wby03/Nu48H6PI89YbvBbMj42AyUw6tnOEignHdxPneNeTECFkeOjp
         gi3KyYeOhgEQqoGOz1w+EOWWJRM8Nm56EEIeTUfwZ94kw3iHYM91Rkw/3wVfezqg0l5L
         kHXY4e0X1sTHJofuLuq7icjgWNnH0kLI5aZplvI+UdWuP+4as0VW7aeLPgCdCx0Hd9Gi
         97yQlFgyLLzdVDm/mSh2ppmXWgn/ibGMJjgZnnLAUWqUrl473nIyM+Ne20iXC4yaFc4D
         XR9d1Hw+8CwuOylMUtKC6fSzvuRCWhrPwi1Fq0IdAzS1/edJNNoH3xPXYO8yBsre6FI0
         qQow==
X-Forwarded-Encrypted: i=1; AJvYcCWW/JxK1Njqlhq1iKAc4bXmj5zGkpLC6aPZ5wK+c+qbZcons4ikPhK1GT0vAAURNFJv6NPRJCXxCbK92QKayufT85b6fXZQ7c8Gjwby9S86
X-Gm-Message-State: AOJu0YyO+5vKUZ832nA4FZMdv79cdGa4ihxOwoQatFAaJy7ZtBb81rQC
	LBHj02CdO9XVSIeBqfuJ3TZrUoXCVq+itweGLkPWV+X+Xu/qzWEMvhSB8nPbYw==
X-Google-Smtp-Source: AGHT+IEBz3iujEGHUiN6pMwCCHLnL29pazXkZjYSQaEFT4k7Uon0fGO9xIj8pPF7qEuotMY2ECs8Zg==
X-Received: by 2002:a17:902:f681:b0:1ed:867:9ea0 with SMTP id d9443c01a7336-1eeb09959b0mr33516135ad.57.1715189512079;
        Wed, 08 May 2024 10:31:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e0e977f655sm12119608plb.159.2024.05.08.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] binfmt_elf: Honor PT_LOAD alignment for static PIE
Date: Wed,  8 May 2024 10:31:45 -0700
Message-Id: <20240508172848.work.131-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5xDT7DTBCjbbpPDtqZw3zek1av22h4oXew+hsl9hZOU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7cEADvYffN1IC7/pVMiNzZAqfw7Siu+Vh+L3
 X1eDIp1zK6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZju3BAAKCRCJcvTf3G3A
 JmkbEACfFPYAlzDSyubCWagkKZa2qIhZ6/mp1d3/SgVGYzBvGQnXlJun4QXlTonBEGtFOXgxdpl
 ZwxYMmMKIVUgMU9c1MH/KPPOBmIaWpU9jjz/QrbWsNuu4VmFN1Gj7nl22S/nVG7HWsVv0jpC4lz
 7Sqs1+HpviNBmb8g6pqStPU/D/Yi/UrYqEonlqv1ZwHATGOK38l338xxyK9Z1ojBFHo1X+Qcb7c
 TabR6GmdvbsmsUrMuBJ+grnobY0qs11GQoQuOcHeLRQ0l8rLh3QC5Byrc4BU/2CiJQ5uschDVvy
 ZLOgpYnBNtypoT2jgmSYL7W0U3m9Tud5jZMJo3nWeM0SWGFnQxCFIA9/G5yUPoXUDs/ChAO1ZFU
 WmAvz4xGhA2LFIJew4hyv9djB4hMTzOjgCmEWb5ruq86U/vV5xXGTw6p2XIXfGNmTJQ8A88U+aO
 DT+IWPlcpvcH2bIaabMPuVsazNTByLLuKaC4hWlxUsbcT2V2sFysugeQmnBu1AkmNPic8F6E0N7
 m8PIo0vEubdPVFgKmSjqbnq+ggAollnp/GowN9s+7GGpWt8CYdw2JCLUkpz8ZjuqmT4TeBjspib
 +V6QOz0laYM4paS0xqONSlvrmCyanG2EFHXRFITXzG7F2xE/cH266l5bxOaoZi35b3UzS9Reeop
 xZN+QDCi hUsCcdA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This attempts to implement PT_LOAD p_align support for static PIE builds.
I intend this to go into -next after the coming merge window so we can
maximize bake time. In the past we've had regressions with both the
selftests and the ELF loader. Hopefully we can shake everything out over
a few months. :)

Thanks!

-Kees

Kees Cook (3):
  selftests/exec: Build both static and non-static load_address tests
  binfmt_elf: Calculate total_size earlier
  binfmt_elf: Honor PT_LOAD alignment for static PIE

 fs/binfmt_elf.c                             | 94 ++++++++++++++-------
 tools/testing/selftests/exec/Makefile       | 19 +++--
 tools/testing/selftests/exec/load_address.c | 67 ++++++++++++---
 3 files changed, 130 insertions(+), 50 deletions(-)

-- 
2.34.1


