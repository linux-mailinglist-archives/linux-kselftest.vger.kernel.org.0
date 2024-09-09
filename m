Return-Path: <linux-kselftest+bounces-17491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF0970F54
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC87280C57
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF341B29C4;
	Mon,  9 Sep 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux6uKSci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584621AE851;
	Mon,  9 Sep 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865729; cv=none; b=BnAgXKolf4BaF0FOornvT/YVMfBTWxxPMaHUjtqoFe6IWbCq6CcdfzlIbF/QnpD14Acfy3nCqjESZgTJaG/jV7GM4TdPVriYTuXoqOax3lm2/ai5YMeVy31K0XUNSwi6c1MXI0ZrfrKbDCU35EKbo1x8Ya0OnrA8wYBT0HZPhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865729; c=relaxed/simple;
	bh=3uUcilVnojt4+ddh4TttNjspH/Ah42tEMA3oIXy4hyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF0BzZyuBhzbKI/DcOC6DV6gBk9OdmrlJS34Kj2gwXMqmXzgyIs9evlDXyZYNMXrBKWy9cehwCL8xItIgD47ipGLJL6d6gbxENtHWeSj/4ywbQWIxinrKGOtJQFJXcWr/qOh+YLpw/QJHTpREpa1TNs/gObZ+sDt/lYGl73F1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux6uKSci; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bd0da617so2425835f8f.3;
        Mon, 09 Sep 2024 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865726; x=1726470526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diK2vfMDlJNUyXW9lcHoHKMejPsgQZ2jk7i/6JqtmLQ=;
        b=Ux6uKScirvcgEd5Q8isotUgcfYFAjLTRiwUr4Sa40EjhMTMEe7BZBW4/J1cCwx3W52
         Ncjn/o5fCAtrNEBKtisDnD+2OOjAt9rcI/wdJBIFdz2FZrlR+EXi4ryyH0FdivTUbQFu
         K3+DXafIckj4T4CV6yr7yBZBfdzIujVURJnCe3mn6ia2sRirjrbcODnW0+cED9cEDdha
         z8tC2ZZ3Fuo3uJr3hA8gqnJNMOu2dRJy56kk/kfvCPa8Tt4tFH1fGHytX9xrpU3nHbcp
         qCn1xiv+fifo+ELO55wQdeYLVeQGgmpd1nZxrlqJ6jAkjLBzPUEEX33d+YhpnK3cVcAo
         anhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865726; x=1726470526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diK2vfMDlJNUyXW9lcHoHKMejPsgQZ2jk7i/6JqtmLQ=;
        b=kVmr3lb5im1aJEwLgxP7ioz+hABBCzj0dYVcc+Dg4zCZI9jipSeoKCkcuQXkegCQPV
         Cx9IntyvMwRGlVrTZxQlcC17eADkb4FaSagcWzRnSmVucpHXi2jdPYjXPx8NboEcLDLA
         GI0cBpPZJRY+yg5nA3bFeOcpXGj4sUPxC5R+nxpVt9ixrYR67E3XcucL3YANJDKQUk4e
         YKMKSRC+08HzaDo15T7BFnSqfnRxgH5kxo/ZgSpf51JIjemuVA2z+okKDT5kBrWjzEsA
         w0BtxjtAFq6vurXTzJR2J0O0VZUPOiV96z8Ru1jx6knAE/uk+FUssUJA/wLXQKveLohJ
         m6kg==
X-Forwarded-Encrypted: i=1; AJvYcCU6DrEUR/gVXkvM9w+tUGWE+s7glmVs6QBxHbuQ7m3kJWOStN3S3jlolznkbjzbDK6vJ2gMRQWmsQ3C3eUiynru@vger.kernel.org, AJvYcCUiOsX5EKpfk5yWj2FCCTxHRZgJf0PLOCtWuw2ObTZj8lF0ZEX6JoXbsrXTe9EH6vQWWzzRoCrH2UcqEYA=@vger.kernel.org, AJvYcCV5CHS5em+quwNJ4cQg/EHPMgCaR9K14oWniwFSOja5N1WOW1UlrTwpJ+zMIpoD+NfZtnOepl7cT8Nr79p//w==@vger.kernel.org, AJvYcCVtDhFsox0Gu2euccTF2M9sUVHMYIn9ZtxBNbhd2+JikeesRtgIP1hDQXKVqF5XeWmiM5+notXRjj+HNlmL@vger.kernel.org, AJvYcCWdBnWBiaIYP6zw+Q9K0uMe3ubl4WFvI60FP1mSznj7cAbHElH8zdNUBRPY1j2L3SYwtO1ZXq5FOG2tPQ==@vger.kernel.org, AJvYcCX4yj3ml+A0QjqhrX0P1xTOOHuzYO4BYKFcVFfkWP5OEISjuICcLRXrIz3bTQIveE35lZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Js4Jj+uyt99Sxdj5Ty/U1DpHV81Dkvz/4aEPAZLyRw0GEGxc
	IRcRTOUHy42IrA6Gf1PS7rTsjPYwgEcfR9O8mPP0X3/QXGz6z7bF
X-Google-Smtp-Source: AGHT+IH7d2LCOjCEmuJ4w2L75gV8H1NZjK585Hq//GX1VCkES/VJ6SkCqMbky8lLj0QZa/YVXZoH6g==
X-Received: by 2002:a05:6000:e51:b0:371:8f19:bff0 with SMTP id ffacd0b85a97d-378895cc423mr6510141f8f.20.1725865725676;
        Mon, 09 Sep 2024 00:08:45 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:45 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 19/19] prandom: Include <linux/percpu.h> in <linux/prandom.h>
Date: Mon,  9 Sep 2024 09:05:33 +0200
Message-ID: <20240909070742.75425-20-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/percpu.h> include was removed from <linux/prandom.h>
in d9f29deb7fe8 ("prandom: Remove unused include") because
this inclusion broke arm64 due to a circular dependency
on include files.

__percpu tag is defined in include/linux/compiler_types.h, so there
is currently no direct need for the inclusion of <linux/percpu.h>.
However, in [1] we would like to repurpose __percpu tag as a named
address space qualifier, where __percpu macro uses defines from
<linux/percpu.h>.

The circular dependency was removed in xxxxxxxxxxxx ("random: Do not
include <linux/prandom.h> in <linux/random.h>") and it cleared
the path for the inclusion of <linux/percpu.h> in <linux/prandom.h>.

This patch is basically a revert of d9f29deb7fe8
("prandom: Remove unused include").

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/prandom.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f7f1e5251c67..f2ed5b72b3d6 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
+#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.46.0


