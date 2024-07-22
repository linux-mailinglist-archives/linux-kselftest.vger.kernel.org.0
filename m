Return-Path: <linux-kselftest+bounces-13981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4E9386D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 02:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E86BB20BCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 00:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874F3234;
	Mon, 22 Jul 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ2/j45P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0723BB;
	Mon, 22 Jul 2024 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721607563; cv=none; b=WOzAyTTlvvgqT++TsFwTkBq0XJJ4NeZoJRhL/uWGrZcRI0x/NL45s5pOg6Au2+7d/hBbkg5g23RyH/to0ITx6obHjelS2nA+DOpVxS3Wa3qknklUWCRaBQPQlHoMOam2NKoalDPnhu2KrPAAddsw6/Yo+uw56yjuQX9NumSPwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721607563; c=relaxed/simple;
	bh=3QnelwbS+SJ8QvUlG/2JW5a+0Sqe5Y96CsZTE1a1HlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fT/SAaYyqYa20JPaCb1nI45kmiwun7PCdD80Jk8LvfTsgTLzMqRNcGM+Mf/v6d1UhRcCnL4LStNAf4NZ8pDjI/og/KfWhUjOgBy8am0Mm/fNQktVIoVLH8FXh9knU4jcZkJB/cvkSXnqkqYUUdXQG0AcxRHEtApw30L0Kh2x6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ2/j45P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2e68f5a8so98515b3a.3;
        Sun, 21 Jul 2024 17:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721607561; x=1722212361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+Hp3V9epOpNggmYY0jt3ZQHQAMSFsFqhPLXSckEz00=;
        b=iZ2/j45POMYpNKmMIHj6pRDdrVBICcBuAFOFEtglnt0ehkEwxah+xg1eiRE9ppq03d
         LrjwctSJOAlHjAwQ2QFzGtWH43wdRtEv23hnim0/7A27Ie55XQe225Cp+A4GZh0oZTvn
         nTm/q41p4Z0jHWuB2mkQKwIQnGfevzo2487pEr7hUnUNmt7Q54owHZ1WlB570bi+1OJx
         d/bhorSwHNY+JVpjHIutCaXNg3azZHV801Mn5kde/N82RyCWAITb8lDtaFxiRYT6x7xF
         5xVqU5hcLYh6XWbXUaaFiuDcLF9IRAtgrwOIf7wYLYTEfZGcKHF9bsHn1qkaM/rD0sj4
         v6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721607561; x=1722212361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+Hp3V9epOpNggmYY0jt3ZQHQAMSFsFqhPLXSckEz00=;
        b=mwGbFt5eShpHMzEHrzrqzwGK3AlaaZiAUUiCoHlX0Cl1NVx4Wbr3p37pT8ZW+mV3RS
         7hy1GcUYh3+GoaoSjWC2YpSCa17rXn1tAUFcdW/TDognhgRBjkJY+5qJ3S/z94/B6hbP
         lCC/Ou/g/z2MYUTAh/qioNlU6D/6qI0rYRyD9pZVL61Op8NhxO4kO6hOyCJu/6iJkFjL
         esGHn4SH5zU4csA2N/M3xPAhcgIzknGCuEx5rEPyJFHVfBjKGecH/xoFOqMT2l5B2AoW
         vHROGj7fzy8wAoi/XukVUyfghbpj9JwIeL2h7oH4ekijgfMz8uG9DSfsNaEbW1WuCQ2Y
         DdWg==
X-Forwarded-Encrypted: i=1; AJvYcCWlZh5ex4A7twB2403J8PG6GMqSe830Wn+e7g2T8av0rGrKGTIdUlOPnG3WO5SBmQDU6Nlm2dif+G73jgCoQBEPEk+shp0DJqx9+97aTGJG4rtExRruoDFd1yqODV90EwQZ5FtRm0tZ5EpVJR4h
X-Gm-Message-State: AOJu0YwoEwbJ5XSEBRcnSjyYLIVGE0bH7Eai/Ap0yp5D6EO+XZTGuzXN
	OeK0hCKWQO99S9vtACRIBbrHhJKiv2ivwQK9dkcuGg/Zo+/xaIbg
X-Google-Smtp-Source: AGHT+IG3zuxtz2wDMguMaY9bh0QXLns/7YvRJHbsB5ToIadeeJRSYCsxcM3YhbdbwvW+e2w7KliSXA==
X-Received: by 2002:a05:6a00:1789:b0:70d:2a5d:867f with SMTP id d2e1a72fcca58-70d2a5d8981mr2107349b3a.21.1721607560916;
        Sun, 21 Jul 2024 17:19:20 -0700 (PDT)
Received: from localhost.localdomain (201-13-77-175.dsl.telesp.net.br. [201.13.77.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1370c6adsm2377736b3a.56.2024.07.21.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 17:19:20 -0700 (PDT)
From: Diego Vieira <diego.daniel.professional@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: n@nfraprado.net,
	andrealmeid@riseup.net,
	vinicius@nukelet.com,
	diego.daniel.professional@gmail.com
Subject: [PATCH 0/1] Add KUnit tests for kfifo
Date: Mon, 22 Jul 2024 00:18:03 +0000
Message-Id: <20240722001804.8120-1-diego.daniel.professional@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: diegodvv <diego.daniel.professional@gmail.com>

Hi all,

This is part of a hackathon organized by LKCAMP[1], focused on writing
tests using KUnit. We reached out a while ago asking for advice on what would
be a useful contribution[2] and ended up choosing data structures that did
not yet have tests. 

This patch adds tests for the kfifo data structure, defined in 
include/linux/kfifo.h, and is inspired by the KUnit tests for the doubly
linked list in lib/list-test.c[3].

[1] https://lkcamp.dev/about/
[2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
[3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c

Diego Vieira (1):
  lib/kfifo-test.c: add tests for the kfifo structure

 lib/Kconfig.debug |  14 +++
 lib/Makefile      |   1 +
 lib/kfifo-test.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 lib/kfifo-test.c

-- 
2.34.1


