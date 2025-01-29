Return-Path: <linux-kselftest+bounces-25365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25913A21E9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B044F188B409
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8741E492D;
	Wed, 29 Jan 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoYhiwKW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EF1DEFD6;
	Wed, 29 Jan 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159403; cv=none; b=NWC6kJD7rj4md8yxbUPZXnmsdkDT3StK4k9rIPM8RKGE8ymg87yTs96vQhhXJwXhhJbroaqA0lusTnjXIMDh1BPKamQSogXDDWPnaQEg0v7a/uRdk4KB7wbMYQ0Hgx0J+HMyftV0EP47EDjtJEMKrxrjTQVrDUgZYKl7Te4kmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159403; c=relaxed/simple;
	bh=c/TiNvwooN3OUjz6R9/GdMWx4hNJHCwDmJuf1a2GToM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzX4HgFhbhYEadaqNczNfdKvGcx5vBoNdyvcYa+IhPPkuqv69Y1b/b0mLBKITOUR/bgjY2vFFNvrd97xIdBTL5JBTpawG1xU+/Kx/jFIftF+eSLx1qpSVGWu9CpUnTw+f9DBKratajCj+JNvfN0OQmxkbDi6324+08t8js9qDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoYhiwKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142C2C4CED1;
	Wed, 29 Jan 2025 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159402;
	bh=c/TiNvwooN3OUjz6R9/GdMWx4hNJHCwDmJuf1a2GToM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoYhiwKWX05kHDzH+cOgp5L7GvD0vAmU139RUDYsYE6+Pq54MuwAyMSITV3iuNoiG
	 McQlrD5DHEiXdITcIAUMboVMprOEWmJmIh5v7JChcg+V73xbFL0VbqbOG9HcmB+YqW
	 WtJ2Csbvd2lc/S/w+nCj/HNFk8Pkb79+877bewYRi9uH5iZSJKshqQ9UHPsuCxG1Zb
	 67MaC7J4jqY4Xg1furrPTtDMEUJBciEOcPSqSLkJX8jud7gT89YDjM6c90bMKJwVlv
	 g2qF8POyuhinOLHFdEa82IcqcRcq+/z2JtmxKUr+hDqHyekPOzwQjReG/FmGFSiXYB
	 sirhCENHyef1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	kernel test robot <lkp@intel.com>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.12 4/8] kunit: platform: Resolve 'struct completion' warning
Date: Wed, 29 Jan 2025 07:59:24 -0500
Message-Id: <20250129125930.1273051-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125930.1273051-1-sashal@kernel.org>
References: <20250129125930.1273051-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 7687c66c18c66d4ccd9949c6f641c0e7b5773483 ]

If the <kunit/platform_device.h> header is included in a test without
certain other headers, it produces compiler warnings like:

In file included from [...]
../include/kunit/platform_device.h:15:57: warning: ‘struct completion’
declared inside parameter list will not be visible outside of this
definition or declaration
   15 |                                                  struct completion *x);
      |                                                         ^~~~~~~~~~

Add a 'struct completion' forward declaration to resolve this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412241958.dbAImJsA-lkp@intel.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20241213180841.3023843-1-briannorris@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/kunit/platform_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
index 0fc0999d2420a..f8236a8536f7e 100644
--- a/include/kunit/platform_device.h
+++ b/include/kunit/platform_device.h
@@ -2,6 +2,7 @@
 #ifndef _KUNIT_PLATFORM_DRIVER_H
 #define _KUNIT_PLATFORM_DRIVER_H
 
+struct completion;
 struct kunit;
 struct platform_device;
 struct platform_driver;
-- 
2.39.5


