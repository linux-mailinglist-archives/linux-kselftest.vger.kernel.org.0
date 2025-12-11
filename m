Return-Path: <linux-kselftest+bounces-47410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CFCB5EBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CDE9300BD95
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885962989BC;
	Thu, 11 Dec 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="n88D+1K0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E524EEBB
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457190; cv=none; b=anIbNm13wXmzpWAyN/mWurc4FYX0tsBMo7FtFoDUFDkcTH4JwZFHODCjX+Mxqs1znEBW/7EndG2OAvaxMBbLw50F8AzmAduD6EtkEDiT7lbb5tUzFuh/lNELJ+w+Sgu4u9mk3Ohvo7ASfIiGhBJ2Oj2UvI8r2gP0MGQvE2BwVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457190; c=relaxed/simple;
	bh=y8Oe4vLCK+gvaA+vkhHnEt2h+oHNHXjU2/SXbofVRP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRqBoQciLF9b2TOYNvWe3ErGpVIB99ZmcIPzO7q05iJRfdd4XrhiGmMpGSU0GVZJiuOmd51aQDGoZsQDQHz+lU5yylRImweOqbmNq9VFLQtlLeTOD69VTgASU/VPoMfguUblYER9+h+XBqwkYUBefLouI2pEad1YIbM9YV7oLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=n88D+1K0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E20D3F7C4
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765457185;
	bh=VmuJHTrbV/MEf7lXlG7Ebt7ZxudHn8yfNFUL+6OnGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=n88D+1K0LrhNkkceZJ2ekuF1E0ixfYMnwRY5Wd2JklmDBmsVqOxFwxTnKQoandRTO
	 wCa7PHjmaIKp2+xiSfOGpYybSgSQBiflv+6GUTjXBM74B0q1nzDD33khqOKISK++fe
	 7mySIwBMHOP/C7NfrFP9UGKjhMLTjVNKjZq/kCipQ0cBFa9WwqjEu8ZBpLMIB9D26t
	 9ApQt4x1EHkrS+kBDalmuTLEldHq5D5VMjxC/QxkRhcLoivwUl+I1Z9o9DcLBAP1h/
	 tSvIe426KXWSE4iC/DnB5wKro0xtD72aC3eBT4DBQfWx6cBFngvBmLGNpmqQMaSSVe
	 tJqODlz1y6Q8ELDtFtsDBKBb337thUvOEI447SaFiWRWg8voaRLQjL4nO/cNDEttwl
	 n8bdXXiBViGHm0aeKKd8cFxuvgd4hZICNaTcpJ7YwY8FrIX7gq8Rl4s0wgQOFis6wG
	 jphUtBKcwse5L6R0DFq4+/ZnnUMm/VBfjL8BBeJyDVXUiU9EsP/OxS3VmTkk3du3+p
	 I2Mnm0gCsWmtgy+kr00dFB0SyBLHQxc6KFsM7mgIjAXTAw4t8UEYukyGaM9uN4K7+g
	 loXu32Co8IIoi8m8pRmB8fCV3q+JNCPO/Rd5pEDQ9SJjSAzmDZifsiQyJgnlID2slZ
	 CKUauZkrff7PAfQSsu0uxCA8=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47918084ac1so441535e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 04:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457184; x=1766061984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmuJHTrbV/MEf7lXlG7Ebt7ZxudHn8yfNFUL+6OnGoU=;
        b=gRc+6o7BOpbISMYbTPuBAcpaZim018l6AOSjd3SLsym4KlbhJlI2udUpGULEy3YxZg
         iZKnwEs+oakmHrvPNOaVqID4o08e88pRAn9umH59V7q6sEilmgZlI6tFuEYzDTtwV32M
         DubK8MkibWpwo/0/hG093P1QxgFFgeeLa6FwRLfwmjsjsQ5/Ls5ZMmBeJ6x5hzSc9ucJ
         ugM9UNq4yniVjrc4gkmLTWSoiqA7OwFBsY2qzB5OV5jbqfZ3wtI5GeRP/NT5PXzSFr9P
         Xp8anUPoyh038ZreoZcBoVQg782gEyIAuiDImtzwoCZ3T/WVaobeFGCxrmu33WYSPGyc
         pvEg==
X-Forwarded-Encrypted: i=1; AJvYcCUsE7MadGErmdKb1su4HtlD7/SgdFdhy9/+DAvLgESF7whOHkBxkUCX341vg1fvRwl4GJ7ZxsDCFm6jheBsWPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qKJkYWDn1e5pg8IiccKsyiSupsNQjhzFExDLhgKGQKprB3mb
	LAawb+vsW9MeAWFfs1+hxp/mDMEn75H+oYg+S5H/fbsaC58IOvmqKeaOB9g/FPtJCU+mP6GSQVj
	VYkqfi28+BjIcUcaivOLgLe3FtgjDjq1ncbMVpwdFlXGVNeYmNpAzRDLXdyaS7NJkK+/1M22unS
	2S9zDgqRSeiA==
X-Gm-Gg: AY/fxX7xXbPSEIUlj7Ir+i8Nj29F7pVUO52SaUvHg1dNegzQxHbH3fMGLPsNTncMadp
	cfNbZ3emQsuqZvIvJPLKm/MUL9HmjxP9dvY+hB4rgjzJUSIWlMlQn3IFJx0mLjgneLz3kAx5NUO
	dwxkK9bYqh48z0The1fyBBNsftgrcrsGCRYUMMlktil3PaaprdehZDh7Q/tWjwz9K8nJYjN726M
	NprKiaZvhFUDZ7HhdrimZ0YUH+kIsrKSzrgef3qpDSfnFw8HgnpKlkrl2SCv04qy8VAnwji6PW1
	X5Pvcl+Kb3wvQH3vMpCnoT6HDmpYt6p9d8GKweZQcF4p7cgosBVokimEU6cXkPEpm7KQY4V4CTm
	VcII9p/rMLE9TCnP+Q9vzdpsZROoP6eXW+XI6KSaLQa6h5yyPtSYbht0r/61/X/EorF3C8Dg6pE
	wqvGr6Dw6RND3ThMUOabdggc4=
X-Received: by 2002:a05:600c:5252:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-47a8384c664mr54699455e9.32.1765457184531;
        Thu, 11 Dec 2025 04:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFcc7xzT2wNXcFXxSP2pj11tgej1qTJLKVLNh63bMddWEf2XMlzU9AlQ+d8UUleOWVVNSvrw==
X-Received: by 2002:a05:600c:5252:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-47a8384c664mr54699255e9.32.1765457184135;
        Thu, 11 Dec 2025 04:46:24 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf57022000e6219d5798620e30.dip0.t-ipconnect.de. [2003:cf:5702:2000:e621:9d57:9862:e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0d6f2sm32075905e9.13.2025.12.11.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:46:23 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
Subject: [PATCH v3 0/7] seccomp: support nested listeners
Date: Thu, 11 Dec 2025 13:46:04 +0100
Message-ID: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear friends,

this patch series adds support for nested seccomp listeners. It allows container
runtimes and other sandboxing software to install seccomp listeners on top of
existing ones, which is useful for nested LXC containers and other similar use-cases.

Expecting potential discussions around this patch series, I'm going to present a talk
at LPC 2025 about the design and implementation details of this feature [1].

Git tree (based on for-next/seccomp):
v3: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v3
current: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners

Changelog for version 3:
- almost completely rewritten (no static array on the stack, no nesting limit)
- more testcases

Changelog for version 2:
- add some explanatory comments
- add RWB tags from Tycho Andersen (thanks, Tycho! ;) )
- CC-ed Aleksa as he might be interested in this stuff too

Links to previous versions:
v2: https://lore.kernel.org/all/20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v2
v1: https://lore.kernel.org/all/20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v1

Link: https://lpc.events/event/19/contributions/2241/ [1]

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>

Alexander Mikhalitsyn (7):
  seccomp: remove unused argument from seccomp_do_user_notification
  seccomp: use bitfields for boolean flags on seccomp_filter struct
  seccomp: keep track of seccomp filters with closed listeners
  seccomp: mark first listener in the tree
  seccomp: handle multiple listeners case
  seccomp: allow nested listeners
  tools/testing/selftests/seccomp: test nested listeners

 .../userspace-api/seccomp_filter.rst          |   6 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/seccomp.h                  |  13 +-
 kernel/seccomp.c                              | 129 +++++++-
 tools/include/uapi/linux/seccomp.h            |  13 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 303 ++++++++++++++++++
 6 files changed, 438 insertions(+), 29 deletions(-)

-- 
2.43.0


