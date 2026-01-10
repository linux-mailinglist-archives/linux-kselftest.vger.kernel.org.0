Return-Path: <linux-kselftest+bounces-48668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EDD0DA09
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 18:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A79D83011190
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC427FD7D;
	Sat, 10 Jan 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnJ1J4d+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507A24DD09
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768067028; cv=none; b=o4XKqxOYPfRa5KLWkzZUpHved7nToJWmdtSta94Ob9QtBrpL0F5f6Tgjqb2+UjMV+KbDvoLQJeqPVuZr4l+9lNMQ08V4A6OxPJT/c30XuuFqF7li20lbMsBbyDhWGuGSv86JVckx80lrqeUo0wi4inWWgz4PholrxAGs3fg2iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768067028; c=relaxed/simple;
	bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLJBybQ9ChU+dNx0CKB6RDl+rrjylCcXRz+2EC+PKIy0lJUvPKQDuLVfWZQTCgzIV/EQ3LgHeCF0IGHDrBfk6+fJnhLPc66LxM05JBrTORMZNAT9BFSCd+NTgyDNOOT4mpCiPeHMUfF9tNzlyvtxTmWEXAOfFs1A2ys5DhBiEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnJ1J4d+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ffc5f35b54so27649801cf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768067026; x=1768671826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
        b=LnJ1J4d+1KkF9tIbTRrdvGqkqClHkSijJV2+weIVhmoPnEd2JR9tUCEtDW706mgJ1f
         AftM25k+5mcTpHcj9udNKeMRb0YGmAHBXMo3Dgv/U5MzGxBbRLN9/BSh7dBhKYfwh+WV
         AgcNvaqa0QY6Zc95RDeUbhSe+A7VePhU8n2tco2US5c2DuSD2mDMsTHQHUN4riUQSXqN
         7RSRnVTs+Smqvp/Dsnh1NA7YPvx92wKjYg/TmXPTk84udpi7WbW/YcQYxUJ84z54gomc
         EUE+/RuKtTCwImxHqquG3E+nQeVq0JLpCl7t6+bcYMTC2vaQIZcQQewZydU6+X2qsTU6
         TkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768067026; x=1768671826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
        b=hZ7/L3VoFGCAfRfGOnPUQkPdcaPB31gqatoeakGarKzG/FQwpu4zKBl/iiB6cYOCMe
         2ZQ9tiyFVvnkc9itmkGv7RvAk4RMDxAsmiDcaz6mSIpFJr81XctejtxtbF5VC5mARnYo
         8ctPdsM74UfwpEP1zDdTwO4JxQP+VIrruSTIUTBst5nkm32WY5YjTwaAQXFHgXa+fyI8
         X4fEjhWmYPy7Kwyl+OA9zV+nglgu6CuYCwLauptgLrNZYzB/78ZOhmg9W4VivLx5n4qN
         LXLdTKKkbAxKKlUuhSase93H5EaBUdXjut4p+pGa44eigW4cYDZ6F0fd/YePP71ei3+y
         JUlA==
X-Forwarded-Encrypted: i=1; AJvYcCU1X+xyG/3f+RLZhZw/Ate4rH6wRrxEsY4D4BqfIiraHzH75JGhpu7Ap0a77JTiXguCllo/JIBhHVySGhRa5Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMBpwQp8NMdQ0OVlZk6XOexazQvdThjtJWAw77nkij7jJrJod
	L4GbTESyhDcxcrWY3dbE+J36mQHsFOkwuwa5J0imn9NiQnm0AivZf73b3trWZQ==
X-Gm-Gg: AY/fxX5rLa9FwQeMYnpomciC/k/B97H0KZDTxPkJIVk6/y3McYSEKCs3M2oRwr3XhnW
	L6x5a5szVtbVU7IdokIVxwSAnALMV32KXluZrhSjC1zRErQiXnB3rEon4iKZhSa4PU4QRzcEoxw
	Wa/rpzaH7oh5/i1lpdmq3oRt8iIXjxH7GD3RDR/Kgk7u/bBKAQGDnLOivWHbDde8ZrSzb0z0uxi
	34IWOFArDDzTB0Ue2+8n0fUB/G1zx4f40vCQcJq4kyaSBaid34TOqKKIKsVC8EyJthkzT4c9zw+
	QiDKTyGy7HMFsU2ZfcDiu5LzsGIiWaav9hGh5wgQVSPpqLNLgTT3mZ2FpMcBcPQNWLiRicok+0u
	WH5c0f/hPD90nQnKqFE0FmC/wztLT1or/YldVyR7pJoqHtm2qz7N5NI+alpjP9hWub9P5RGeRHc
	wcB76iOMxG2inuFCE3zynxYsM7DyFNech/x0ghEX3hpG3Bs4I6tsNEU7ORWrN18fG8XnYow9FzU
	7Qe0xPLlQ==
X-Google-Smtp-Source: AGHT+IE7ltzgQjoPiBN4Yv2Js/6C6/LS6t10HZYVZxNM27qcbS1X+Y/3pfVEOz+ccq0rpo3AXUIhkA==
X-Received: by 2002:a05:6a00:438a:b0:81f:4ce8:d641 with SMTP id d2e1a72fcca58-81f4ce8f745mr183507b3a.37.1768060842363;
        Sat, 10 Jan 2026 08:00:42 -0800 (PST)
Received: from server.. ([103.251.57.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f36f88f4bsm2513245b3a.36.2026.01.10.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 08:00:39 -0800 (PST)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: jackmanb@google.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	david.shane.hunter@gmail.com,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	reddybalavignesh9979@gmail.com,
	richard.weiyang@gmail.com,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH v3] selftests: complete kselftest include centralization
Date: Sat, 10 Jan 2026 21:30:27 +0530
Message-ID: <20260110160027.128949-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
References: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Brendan,

Thanks for the report.

This issue is caused by my change that centralized the kselftest.h
include path in lib.mk, while the x86 selftests Makefile overwrites CFLAGS
with :=, so shared include path unable to find kselftest.h. The fix is to
explicity add the selftests include directory to CFLAGS in
tools/testing/selftests/x86/Makefile.

I have already submitted this:
[PATCH] selftests/x86: Add selftests include path for kselftest.h after centralization
Link: https://lore.kernel.org/lkml/20251022062948.162852-1-reddybalavignesh9979@gmail.com/

it has been tested and confirmed working.
 Tested-by: Anders Roxell <anders.roxell@linaro.org>

Once that patch is merged, the x86 selftests build issue should be
resolved.

Thanks
Bala Vignesh

