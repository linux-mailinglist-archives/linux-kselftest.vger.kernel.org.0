Return-Path: <linux-kselftest+bounces-17511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70609971109
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8C1C21F33
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA41B9B37;
	Mon,  9 Sep 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IupBDwyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B91B86E0;
	Mon,  9 Sep 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868637; cv=none; b=jjtA5KIX6+QumdD7R5/fBDVmpXs8GR0+p9KcdGeZbvfMFLUEwNMXYmzN9hSn9FfNuiAcJtzYHsgq+8GWKz+6TcMM1Pk0IsW0+oWi0rpbnN29lhzy5b7DCjspyoVHplDLbSlJjgwvteflFR4vkMVk+GxSVD+brCrhzzOMNeR3Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868637; c=relaxed/simple;
	bh=HWWTAYGm0U7wN66xDMQU4gzK4ub4ZAFi3PYLnXmxLWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApHy+3sNT5+vzSIGFeEg/q82G7qBAaM9NFGeqmSeG4LvyZfvB1msOoZVgV7t2PvOpzdoYzTuLkCDn/bMHdTZTzJmJ5/K6CDvngZ0XNJxoeHMdBW5t4LARsThhhvpr72MTS7X8mAmplD2Rq1HFwq8W75EzPHWrcs/UC2NRDm2ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IupBDwyt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so16826475e9.0;
        Mon, 09 Sep 2024 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868635; x=1726473435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BivEb0WMZmwNev7ojy/Ht/ekf32lny20AzsfLsOF+vY=;
        b=IupBDwytkaNgN0rKlrmRZZBHcIoX84bkEzci8PSgcfMS3yeVl+H3WBnqa1Uyt0ilfs
         clP6lbCGwXuGqveR+TorgLQw6t6zKOCQg8hhquI/RB2p1w99Py9ucTQWeuvk/OiG7dZ7
         zXAGcQkl1IdjmgpYuycRyDvgGvl5YSmwXYiYVtwBGoiOUMNPxsqacmW32MiL1ZR4cVXe
         RoJEbP1o8CX5fxCoRXKRj3Z3qgJ4EaiywulFYaP/rQISZ5lB215FM4sEuK5xlhZBSZzR
         DucJf4So/gRokkzXc3M4KVtCbiZdE6X9i5g1ydOtde/hJ7ZGw+SCrtNAA9JOh2VSM3na
         eMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868635; x=1726473435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BivEb0WMZmwNev7ojy/Ht/ekf32lny20AzsfLsOF+vY=;
        b=QBj9PwMnObQfKW/41It2y98e+FWKKu7xfhT/bAkP9FQS4o4hOwHgmkaem1qZ4VdbLL
         KbuHCGc5cbufJSub/mNsGOHPUDagk20ZgpiB07DUMk52t10iOqo2c44FHnY8XmsN1EWe
         5W5DQAJBHaPDJPjdtKhOWB+nHqG7rLvgpu5M9xF2NUyeFkgX/D4wqR0TooF70R2Ehi7I
         KFVs0QLaC5y8foIDWKitLuOpXRHP5D1auWwb+ZRBmiIhXLm3bDC5irNGdZsqe5r2SOM9
         zr/bB3prad0Aff4pIJcGrYSjSJTKyRBdVReAGedsC3KFtzorX6FZBIbyYJRA1Y+dL9tm
         XxIw==
X-Forwarded-Encrypted: i=1; AJvYcCUWCu+FoaJvD3NxkzqfJ/1dqdIS+5S/OX+vporxaB1R3UX5wwH8tJRx4kSfHJlwLhHSATz29aO/JJhnMNOEGFJ2@vger.kernel.org, AJvYcCV4NiQ9tzCRSHIpYZLmNTfl8JShLrY3WDOjcyj3FFfqV9k3dgGW6GRHLw6AYJAXq9Q3AJ7sGxDj91gH6hT4iQ==@vger.kernel.org, AJvYcCVySCL/m8Wt33djIFbhwodtrqAHxkPnLbSE7NBRu5mZ1xx+mwzTNwsrcXCAWq6aub9XmKcbpRmncNqpUA0v@vger.kernel.org, AJvYcCW+YPxLsNoKyvH79WnewObqptEVzbTx2N0H2gpZVhun6b8TqU5RAVl9fVFOBzny1B7lmd9HuysM2dvnfXz+@vger.kernel.org, AJvYcCX3gS7h5eXfycc/hr3GKYrzrHg2caRwZRS0lm1NxgpIiHPjuG4SxH4cWaYT8BfEv1NyOOInN4C/F6Pfxw==@vger.kernel.org, AJvYcCXU2y7mQ5wEw6i+44d9hZhpZrFT3gFKOtbNtK8nqy17nPnVxPh97tZ5UAPRnlZhvt2NM4RwzTGXrlRMskI=@vger.kernel.org, AJvYcCXgwKH9Q0XOnZWJihv6KNw93ZovJBRHaepgJsf8AjQE4jpZeasK6HBZfV/CR0ECgFwYNTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADqnSeohhz3hZOkWi/xJQHR699b1Apmyeg0tUO/fyOCPymKAx
	ojQkgC48FZlwm3NBghYqOlJambAbW8nHYViNV8N8a38gipGKc1aw
X-Google-Smtp-Source: AGHT+IGFn7bjhhziiFk7ZlVWXk6e2N6wsS1IlnWqQqC142aEHDE+lRu2u+3J5phDWkNcaysihDjQtA==
X-Received: by 2002:a5d:4101:0:b0:374:cbdd:480d with SMTP id ffacd0b85a97d-37889654c77mr5657546f8f.36.1725868634534;
        Mon, 09 Sep 2024 00:57:14 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:13 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RESEND v2 18/19] random: Do not include <linux/prandom.h> in <linux/random.h>
Date: Mon,  9 Sep 2024 09:54:01 +0200
Message-ID: <20240909075641.258968-19-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Files that use prandom infrastructure are now converted to
use <linux/prandom.h> header instead of <linux/random.h>.
Remove the legacy inclusion of <linux/prandom.h> from
<linux/random.h>.

This is the "nice cleanup" part, wished in c0842fbc1b18.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Fixes: c0842fbc1b18 ("random32: move the pseudo-random 32-bit definitions to prandom.h")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/random.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..333cecfca93f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -145,13 +145,6 @@ declare_get_random_var_wait(u64, u32)
 declare_get_random_var_wait(long, unsigned long)
 #undef declare_get_random_var
 
-/*
- * This is designed to be standalone for just prandom
- * users, but for now we include it from <linux/random.h>
- * for legacy reasons.
- */
-#include <linux/prandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.46.0


