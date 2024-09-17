Return-Path: <linux-kselftest+bounces-18058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D897AA0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 02:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D007F1F279F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4A4C7C;
	Tue, 17 Sep 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpAA4R5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F192182;
	Tue, 17 Sep 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726534285; cv=none; b=ZG6wv0lZ+XJTjACMzU0ZPhJXoqD7lrEk8AoUC2NXP64r5krILYZVI3zPse11t97sXqivAPfUozlgOXXziLyPfGOt0eOXzqn/pEfRfvC+pwdIipAVMpAHrv8KyWnJWUebH7qS7zhGZ0HEPAOV6ldVKFd5dXnVEkW5XfTX3/nwE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726534285; c=relaxed/simple;
	bh=/CKHssuqPd/LJ6GNrVg70tSbdo3ubYcvqgaDoLRapnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPsu3fgkR68eifNPTv2paHVdeoA+zZH/R+i7BTB7q+UPTkboZ3ugyQJ+zY3qBENgZ+7T6L6x2LsDsZc3AjXGObcufO1qt2MmtAthJoyhPy86L0p1048i/Mxj1+zMyms8xzhfd4YFrLeZwVaBrkdaueR9c4Bt06a4GsCpGybRUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpAA4R5i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2054feabfc3so42595495ad.1;
        Mon, 16 Sep 2024 17:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726534283; x=1727139083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7TjPr8WhZbkfNCkq0lnz/iF1dHuV7vAvY2Yl+o6W6Q=;
        b=JpAA4R5iPqzKPOzbgwxnek7w/b5FlrjsS3mBWXHY7WsLKFB1gxlfDi1cvFLy6XwEmb
         ryi6Z4uvX/etA0gi/3uYPndHDVF6/a3SpZd0vDwcy4O0Rme59xfU3gLMoKoE0nk65S9k
         onbClO0mcyEpqFFzVrqp6gImv3+xgrq3lSU75edvbftflUzZQ+v3wFiVgZovxqlY9bho
         hTNJ4DtqtVD0+qLh0Co4X0D9qF9Ueowspd7Us6oa119l5dDK38Kc8dZPt7s5VR10EM8K
         6dOf8MZriymBpgvK2KzNJxZozJrdz9/wqJGdgMexUE5w3SmMawKkBaL91qlUDnKnEpTv
         sZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726534283; x=1727139083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7TjPr8WhZbkfNCkq0lnz/iF1dHuV7vAvY2Yl+o6W6Q=;
        b=jJ2ICxdVVJfDFz18em4dTwvd+PCxkQrd9pqNiuP/bytM4XyLIGJy+cGalp1ZAW4Kv1
         GW6WYyJCVKlmJN0g2a1wOW6b13CCsT3q5GNe0gwW5+AWUVib3yqxcrA/7fwmMTecPGCw
         Du1PdbRqFrPgTwFmV3jAzUn7Xpf5skocULKyeSksuc7jUQJcK6k7niBUKla8249fc6SY
         Vsn6Wc6h7EmGMc2tmPKHQ6xzNdxEp7uFvfq669MSD8njI9CQyYBp2HVQqjo8EdBfSQpt
         vVBRjd4cVW08liVA7+iC4/flCfvRZgeU1U4fmoJiz58nKkiHtfAdOGQZqgFvsaH+MQG2
         H7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUjqAX/cvGNmZi2653CUBDH6/cjfotMPOsdBRiqXqJkOTMv6o5OChNkJebAwsUOm9m3aNPh8hH5Gw9byYjDdGFF@vger.kernel.org, AJvYcCWmHQ64pxvkt5vGLfDJhhA93T+mVrJSgmfn8YL636yXQowU//a4y1VnM+utL891qwsGhVEA7Z82gLIyVFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfP0e+SKwRvslAHsysikKEgt+i+GofDXq90Jc0PdBAud6LEVj
	JB2PJIIIMbB/lVXrIeR/e7NCOh8X/fDCjhSOA/04KhJyNcoHR3QE
X-Google-Smtp-Source: AGHT+IEEjsTLVn20nrsstOtt7APujE7tqoGN756Sgi5yMfMifzWEzA+/5OAdOnBt2/gCL86GmMDFQw==
X-Received: by 2002:a17:902:cf09:b0:202:5255:357b with SMTP id d9443c01a7336-2076e414bd6mr250846465ad.41.1726534283400;
        Mon, 16 Sep 2024 17:51:23 -0700 (PDT)
Received: from arch.. ([143.106.58.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fddsm41714925ad.82.2024.09.16.17.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:51:23 -0700 (PDT)
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
	diego.daniel.professional@gmail.com
Subject: [PATCH v3 0/1] Add KUnit tests for llist
Date: Mon, 16 Sep 2024 21:51:15 -0300
Message-ID: <20240917005116.304090-1-arturacb@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is part of a hackathon organized by LKCAMP[1], focused on writing
tests using KUnit. We reached out a while ago asking for advice on what
would be a useful contribution[2] and ended up choosing data structures
that did not yet have tests. 

This patch adds tests for the llist data structure, defined in 
include/linux/llist.h, and is inspired by the KUnit tests for the doubly
linked list in lib/list-test.c[3].

It is important to note that this patch depends on the patch referenced
in [4], as it utilizes the newly created lib/tests/ subdirectory.

[1] https://lkcamp.dev/about/
[2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
[3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
[4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/

---
Changes in v3:
    - Resolved checkpatch warnings:
        - Renamed tests for macros starting with 'for_each'
        - Removed link from commit message
    - Replaced hardcoded constants with ENTRIES_SIZE
    - Updated initialization of llist_node array
    - Fixed typos
    - Update Kconfig.debug message for llist_kunit 

Changes in v2:
    - Add MODULE_DESCRIPTION()
    - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
    - Change the license from "GPL v2" to "GPL"

Artur Alves (1):
  lib/llist_kunit.c: add KUnit tests for llist

 lib/Kconfig.debug       |  11 ++
 lib/tests/Makefile      |   1 +
 lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 lib/tests/llist_kunit.c

-- 
2.46.0


