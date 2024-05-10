Return-Path: <linux-kselftest+bounces-9928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EE8C1A9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A1D1C22418
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581C7E777;
	Fri, 10 May 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay3IRznw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E65F87D
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299796; cv=none; b=AjExU8S6ZFeWMdJPCdgjSdKGjak8x/Hy++WnQoOC0+BeGm21mKU3yLeOa2uF+20N4o6xy/BQDygpTgm4JkFOFGBRaD4Y7tPik46IsEvnmxZI69DGtbb54My5PRoX6sCy6rkwMc2nxAlp38iyDyk0OBGT3HFQ+be3EFKP+sOwUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299796; c=relaxed/simple;
	bh=D55ymEmgXz4iQWm3Fzu/fcCDdwZBDQDEGkYQNfW5/Uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F50rd6+XuGvkwefyR8XKuoIHPRNhrJ/Gdsz9WTJpIVC1KMnX/S5aoLoqjPGzNgPKevpwtyKruvxsUbem4koNUSsiTP3iWu610FPM8dJJKgr5TG0ZHPqjX1RDz70iPwlJGefFvaoIbaf8tlh1dZbdjkfPSXMez3BmM/Sp/ZAmE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ay3IRznw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de6054876efso2680043276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299794; x=1715904594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Woyjqf1Jf+ZN0ROzD4LFadIcncJKJRyNekxOoKd72k4=;
        b=Ay3IRznwGFhgxtGCjnICCOsViXPNdWB++bN8DfrIE474kunmXPCLjx8FV26xlIB+gF
         ZHsY3hqN8UMW50wvnOn02NjHkYtYchsAZTs0awdlmckaHYmww49P9wDUkWe4sEMoEfv4
         Asia5amP/3zPhsG0cAsLPSAd7Tj0AsSBk447LymUZCsGctFWRSVa7h9esBLMIqqG8iqQ
         a1PwmpW1UtBeMA49KPXwd/ahbr8kMIwuRiTkWA4MEkt7/6g4Y9M3mExRChHPQrDfPBJ0
         w9Bl0J2YHx4c5G1eEhB0EYadiUsBcISzyqJQfCjyj7LSaWTooFkAqhep6dxmLsEwjjLP
         RMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299794; x=1715904594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Woyjqf1Jf+ZN0ROzD4LFadIcncJKJRyNekxOoKd72k4=;
        b=mnLX6ggaaZRjqmGpNxGBkCHuhtKtUucgrVH1i4/4/pp4l1p+6bN5AI50yKLA+Vq65S
         l3TdQaUHaun+MqJpOjxs0vjolXEPCOUW6neDz0MNZ2gmZrqfMDuK3nU6m+BUJRZlYGi+
         LMWlR0WofRc4fGtCMiIIr0p3U6OY06liyIRP1RrBYGGxWU+4r+QVCJACD79Cdc14LLnY
         bCnimfdLud08EQC/DEo239H1z83/ODx4vafFjZvuoDxoQ61XQcPDVYlaeyOwnI4kLZ+B
         WMxka+wH/ck8RVmH64L6yOZ3iUX+r9zImWCUCjir5VPwXZ/fUs8fekXE9bsO6H4kgkjS
         XFow==
X-Forwarded-Encrypted: i=1; AJvYcCUO/IB4d8MjhWnxhMcmrXxBNfTr7TUbi19dxfwbDVgvfDRcyOcC509lmTIC/szs6gbau29X9rGmu67E63/9aoRwXMiqM8KvX+bXNO0RuAck
X-Gm-Message-State: AOJu0Yx8Blu6NZtStFC/jCmLl0UhcDXym/eJU3s2/PDhrfZwvo54mX23
	sUjRIBrc/m9vXvNAYrGsoE96xI5Ba/lfvozRU/JH5zP/pnXrhNwds3pQQdeud2JS3NeoiXe6IAH
	rcw==
X-Google-Smtp-Source: AGHT+IFaj6bmAeTVTIliFBtquFibuZcld7R/X60oTVpmTPySBxzB4mvpPMdxa4luEXPujDJe9yOplutTGtY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1205:b0:deb:9c81:7a81 with SMTP id
 3f1490d57ef6-dee4f36f045mr285525276.10.1715299794053; Thu, 09 May 2024
 17:09:54 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:34 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-18-edliaw@google.com>
Subject: [PATCH v4 17/66] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


