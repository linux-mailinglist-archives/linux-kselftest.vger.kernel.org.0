Return-Path: <linux-kselftest+bounces-13979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3CC9386B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 01:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01211C20A79
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 23:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6012E5D;
	Sun, 21 Jul 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MethI3wA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49841078F;
	Sun, 21 Jul 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605428; cv=none; b=e2CgaYuZP6yktfnmF9NADa/AZVe/vyDfOhDfEUkpQh250xDM3nMJt9RKPGwfge1y5wQV5ll34qvaNL+N1uLmS9qeIH5fRFN9LPCwQRYqFGcjMk5Cs8cjCHW+zOu8bQYJBtcoxl7Ee+j7LTwfAWuJQK4mwXrYStpcAxgnvg4qeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605428; c=relaxed/simple;
	bh=+/aaU6GJ/Lu7U1gERjfH8A3J7w72cf++uXh7S46Kn10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4EBF8DbFW8+ShXTREFzKj8pAvQlQVvhAMlkuJdZcHtkFVdayjHEfs8bDdfU7yY0MjWHfw+qBfbcZN7A29Mep+ccI/RWyIE+lUyeeGlbnaTQqSSxto+xG9xpfSX9pMdhdPgND6VqmpAEDm3GUuPLlhCnYX8JU+C/O/y6HlNU9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MethI3wA; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7035d5eec5aso1955565a34.1;
        Sun, 21 Jul 2024 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721605425; x=1722210225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMApZfgv/jgpqS86LHUnflRfg8idEre+6zYQkKuk9Mc=;
        b=MethI3wACirXfqKODaWp2mgFuE1jWLoj9F5v8DQAJGVVMqL5OcTJMMzKWLzo2e01OO
         SdfQbTHr3Eynlt2HkWpHXYj5FAWNmvhcuBEKZznG+W+WWIS9naknnpYe6zgNgGXS/cdM
         sR4Wo2ZVWT6BhbcGKTO+uGfFcV+aEl5Mbg3nKIe/a4WbsL2NyPzzP24SVtI+0K3a8YQ5
         K8Cr4BOF4F97lz7pQP2H4u2YjqzVu+fGQAC+PZcVIeAY1L1mwKxnOJ8WIhDofQvXOvip
         eFk+AGbfR9CzOfyymrdPDElq/LR3L8S1OUaQeVt2Gn+bpfH01oPOToRDUK9vR364z8j0
         rhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721605425; x=1722210225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMApZfgv/jgpqS86LHUnflRfg8idEre+6zYQkKuk9Mc=;
        b=ESdyy/JpyFQ9YmScHaZ8ffn+Q6SVU/tX/xMOABDEZVnGcCj4du67ONsAHoBmCxUFvl
         RkmGL8HBabp6GF2Jtf5WfafghcxaeQlQd9YS51RL9FV5Mf08vOfWHRjAFM8LvqVpPFOx
         c6crFbPeX6wPzgoqiXSqWnDnrwSpa4vgEad3RZ2gCnpii4i76C2iuTMm+PVOb15Db19s
         0SAmRhGq6K7e5D9bHgEvuneW38J5zR+mx77OWP2qz8wl+afEEkbGa2Jf0AQgsUg4fqS5
         1JvKvsnj4KMwj51YenXU8HbFdOcdHqfRPSbs8FCj7svyQL5z6TV+tlJgsT4BpVnqVgID
         kv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs7LoHZr2FNvjHk5p4uQYXqt7B6NuJIx7m7pleniav9PwWeR5IGY6aP7DzKyiKIRg/C4Yvrt6Ry8vXPwTmkC5HY862D9PM9kIB8MTZ1bTY9QeGODbsvuBez2kptSyLYQWTzepGHFfLv4a21deh
X-Gm-Message-State: AOJu0YxJ62/dQRAQzcFaTdIm7/LQCzVGTLrhJVQt/CG81pQhOF909ZdC
	0HxBF2k883yrj95MMbQ0pkfH57xVLp/myjKNXycGNO0RYBuAv0RB
X-Google-Smtp-Source: AGHT+IEfLlpu/8UOOLXoACSJjG6+YSvZHL4nkSmcVLHktT97P0nSjpd2gvgYyaf6nFQK4Q9CroBCYA==
X-Received: by 2002:a05:6830:6c0d:b0:703:6882:4c0c with SMTP id 46e09a7af769-708fdbe7fe9mr8373335a34.33.1721605425187;
        Sun, 21 Jul 2024 16:43:45 -0700 (PDT)
Received: from arch.. (201-13-54-228.dsl.telesp.net.br. [201.13.54.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d19c52a62sm1733025b3a.124.2024.07.21.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 16:43:44 -0700 (PDT)
From: Artur Alves <arturacb@gmail.com>
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
	diego.daniel.professional@gmail.com,
	Artur Alves <arturacb@gmail.com>
Subject: [PATCH 0/1] Add KUnit tests for llist
Date: Sun, 21 Jul 2024 20:43:16 -0300
Message-ID: <20240721234317.7935-1-arturacb@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is part of a hackathon organized by LKCAMP[1], focused on writing
tests using KUnit. We reached out a while ago asking for advice on what would
be a useful contribution[2] and ended up choosing data structures that did
not yet have tests. 

This patch adds tests for the llist data structure, defined in 
include/linux/llist.h, and is inspired by the KUnit tests for the doubly
linked list in lib/list-test.c[3].

[1] https://lkcamp.dev/about/
[2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
[3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c

Artur Alves (1):
  lib/llist_kunit.c: add KUnit tests for llist

 lib/Kconfig.debug |  11 ++
 lib/Makefile      |   1 +
 lib/llist_kunit.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 lib/llist_kunit.c

-- 
2.45.2


