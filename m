Return-Path: <linux-kselftest+bounces-18023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008C979C51
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFFB1F234E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375113B5AF;
	Mon, 16 Sep 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyslfLXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0ED12D766
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473420; cv=none; b=tol18IwP71BRaYrgiPUWp1qPKGOAfIfU1jp5xFUvwOgfhv3KBdGVb0k+tFo+S1V9QLdGUpgkoB5VnStDOq+V4EUf3R6Mtqmh5JX6CtjB+4yDkY5FaLqEncR511j11PLCGdZKcfByfrdmGYkPmfWe8NkihajXeP5atpNpaPvnW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473420; c=relaxed/simple;
	bh=hhxrIv9khiX1RfOrE0H/8k446mgPGdGKEs9+pui5JV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4RYQxmnC1Map0TBrZTwr5iNHbURr9UcVzyhvcEipVVuDud5MjeXlmh6mWolCyH+HXbEY4HQSn2GWePPXqicmDTHqBXAdBseSvSit/IIXEVjHCLAlPpOAyvBSb6Xzw8Uj2JKq0JMAYmgG+Y8VzwWV8Vcjo7TdPIW0eIJJD/bB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyslfLXi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53567019df6so512092e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726473417; x=1727078217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHqTL9vDvOZZy9QnUiEJyUF3wHvGDGtFLKadEYFtbOc=;
        b=PyslfLXiQHG4WhLjYGWeWoFjqORX51Z0ha99il/aN6U9VkLqdG7s10vVEdYRqro+V9
         Lrv0XcWT2Mf7pLyylNuR2wdkfNhnqi4fafTlYD6SWWC7HTIkxv1+PN5TOmgWioNzLUig
         AzlUfCVpUbQbt2Z/nyXLh9iyQFsLF7uYItJmw7YeJKhvKAUkt2HdYSKY6gfGW4TPhDXe
         BNWoaXCmDFzqHtvB5D09iq8I+2CnuZ99LANf6dV5bbqI0pzNW70wmSyMuC+d3LPl0Zhe
         CToxx4sjMXq9bDZIsnxkzMnzQ9qerf4Lljl6KFGIP6bO4zrWdHb5Ex/MhjlAorGcOXDX
         1fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473417; x=1727078217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHqTL9vDvOZZy9QnUiEJyUF3wHvGDGtFLKadEYFtbOc=;
        b=XfKLc+uu/qP+9Bb5OzsTD2EeQVXvlnzDM+J+a9TBo6g4MC4GiWH7X0W5ah3AVmVs43
         JwkHAzDwKCaew5TEZpNHEpixT4o71N44hB72s727teQxjQXY5f6liW3FQWecViixeseO
         4I+4Ig6DmawehnSmIa0rGJ+SFBMYTt29jHUs3r8msD3jeb/rVlAnU3/RXrC/D8ckk4ET
         GA0/0UvSY52MrHZh4y13VkhvWNdmr3vsM7GQykby1L72atldRvWevwHTc7RFlUmSNgRd
         g3lwxWnOOt1trpuP0P0rJIMOMwKq0NDHG3xQrTrHtnzHoyQTrTYf7rBbHZlVcvAISOK7
         6pQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1P5Qm0kW/kyIxeWyD0pgQXNCKZmkmPo2GMrA6bl5VFAsyBQGJRq3TvmEXM+FocWpeUTH7A7EbSFqT/hhhvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqg21Yn8mdhDHX9h75A9O17RstjCKAsiMAUil7SpVttbg0Wm0o
	oyEvHlHmpS7Q3HtsT+8jqP6NA7wZW9S3b4MKUFh3Peci2suNDLV8l+GGgnupH9hJ3HtHzPBrY2N
	k
X-Google-Smtp-Source: AGHT+IFXzjEuV/tVax8Sc2ZfcCB+uYJFgWibtigRv636eDm7VF6ru3JXrEirsMP82sZ8xKiM91fgqg==
X-Received: by 2002:a05:6512:401d:b0:535:6a7b:9c03 with SMTP id 2adb3069b0e04-53678fef731mr2260577e87.6.1726473416604;
        Mon, 16 Sep 2024 00:56:56 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368709684dsm801618e87.148.2024.09.16.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:56:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: willemb@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: Makefile: create OUTPUT dir
Date: Mon, 16 Sep 2024 09:56:55 +0200
Message-ID: <20240916075655.4117151-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross building kselftest out-of-tree the following issue can be
seen:

[...]
make[4]: Entering directory
'/src/kernel/linux/tools/testing/selftests/net/lib'
  CC       csum
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
cannot open output file /tmp/build/kselftest/net/lib/csum: No such
file or directory
collect2: error: ld returned 1 exit status
[...]

Create the output build directory before building the targets, solves
this issue with building 'net/lib/csum'.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..05c143bcff6a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -261,6 +261,7 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		mkdir -p $$BUILD_TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
 				SRC_PATH=$(shell readlink -e $$(pwd)) \
-- 
2.45.2


