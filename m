Return-Path: <linux-kselftest+bounces-35866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24AEAEA302
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B141C441E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CED2ECD21;
	Thu, 26 Jun 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYgWDyNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795F2E975D;
	Thu, 26 Jun 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953204; cv=none; b=es6o3k7zZ1GZeB3cmz7ZP6fBQUIaq3nnwvm/mlIVwSgiDtefwHm3/KKwQydmUrgfGVWgQKBNTuIRBbYts+rXlFyBJGZS3qu5l7gArHjO+QdRAU2TVTTMwJgKMfN/3M7jxDmwpi1Nrz8jghXBeFlzblZx8AiG+NQ3t6E5KK1NS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953204; c=relaxed/simple;
	bh=C73WJsGSy+51BG0/EVcFn0MOBCuig+szOU1Mn6jtkAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2yUVP86tYTH3aBwKw888YHLUyrFoU2XnSfpFu9BFhp9qicV8SuWvkdRrfXgs6eeTk6oEHz2NtQMuAIAYhjUOv0FIvnlzb0pDPWFBjsqQXKsPUZ8ctc0l5fmitL7VIromqF6GyUdINZRBgPPTtYW0O8fzgEBq/IX2tbNurflo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYgWDyNW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso991369f8f.1;
        Thu, 26 Jun 2025 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750953201; x=1751558001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE84JnQbxu44C2NaGk36OciY7gwqeDTG2jwAmqGsedA=;
        b=eYgWDyNWGLHhhWG0ZghyQnBKEo+0rMaPIM189VcPxFx3k5DyhB55zkIfG3T8MhOpaU
         pn7uFaC2vMwpdkh4B2QiaiR0n4jOtd3pSp5jSddnV+wMUU+hyJ7iovPJk6SBILGYHaLV
         teM8nt94NtpvBOTgQwB4GHRKB9xqYj84m0VSRdiAIiStfqC37WEbRJsSySn/wFLgxPgA
         OQBg3//a61BaZp0wMw1sYwCgwXnNUBOD3KPNnWIM0bu0FlFe+iQyIBfA+TYXWoNMRvQS
         rvxcw1fvq6tPhmmdiCF3kmXqxm+FN7lEGok1Wj+Ge/b2S74PyCeOjXcOXXNCPAwEh72X
         5/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953201; x=1751558001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE84JnQbxu44C2NaGk36OciY7gwqeDTG2jwAmqGsedA=;
        b=buo8fAzhU3mKu63Ceva1iWsOznq9BbMG4RgqRXqUYvJfgY4zvAhr3u65FMxKwg1BwR
         rWR54A3Ju2fpBVtpg4ILY8zDhZjlcVf9wQDoow0JKGPWiPo15tKwRYa7AuxYLNUnv1GQ
         cUENPZgAEDWCB17l9zIO8EAD4csuu85B5ms3qxA7YWRCVXPIWaAs9C4tHTKa+KTK4mr1
         0ozR2myKsDWPaQ7EWV0wRUFcMY50Nn+A8Ubi3fpyuLuTU+zT2NxTQUcTbqcvzUAT5yFz
         pw0y5cx53TLQJzSnx7Lkkc/7AxeVomtgTKwcxuALbllzLvJ2I6lTGlDvCfUrbofsh3/f
         ja6w==
X-Forwarded-Encrypted: i=1; AJvYcCVq7o3YamSmGDsICKUjZCJMiaHcqUsKG7Bny1RVPsEvhB6RurlbdljNR7cij1Bk8oH0lB90t8zaurSHCks=@vger.kernel.org, AJvYcCW6gGX8O+/E45c6l+pgMGDrODMEgdDYI3S/4vmICRw+ZK6qtM08k5bA0zV85i3G9HAZ29neeLMn87widrToaaxi@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsP7Q10jyBTlWURJeFZL4s0U1u1+3jKioz7ddERyTSBCITz4B
	ezVSSmo+PXxQzyE464YbITmTek9ikp4tbPFbzvmFR8GIMFw5HDxp5A/T
X-Gm-Gg: ASbGncu3tuV9fdMK01IpAsK1OANAJHZeFnrRO9S2yDIfIlwyRxuIKD3o9cYDTgu7bDC
	n18kVGcRhzy115yP/FE9Cjrz6u6vsWq+i9IxVqBPhzq90iwjaTmS3Za+TzUZ5dRc8jt7Ix+34mP
	x+SlysMTMNSAzxfpoPc78HF/9OafVIYNG1xueMV0c5ellfbpx3WbbuVAFb7UZlGazfTGahyl2YJ
	pYq8OMyAKgVsu8VB9U5sMlfuD6s8WSZRrHGlRTWf1BgpVmxKJVm9sl5LAHDacZ5pYvaUk2OMQ0L
	51tmqDTJrKQCN8ui+IxdTp1eL+0T+pPvp/T+Q+Y0l6U2vvmhmfOdkRM5jD1IfNr1RAuqIDvsi8P
	CtT4/aOdKQioCvGPkJlXL+e2HthII0TJeFUKYLUi7eA==
X-Google-Smtp-Source: AGHT+IG95CLelqFabsX5d1K9V+MH0QhrNlpkq1UbF2zKE//jyMJndmyvapX+hdQh5FXyfrj/LZCRaw==
X-Received: by 2002:a05:6000:648:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3a8f435e2b2mr33745f8f.4.1750953200701;
        Thu, 26 Jun 2025 08:53:20 -0700 (PDT)
Received: from puck.. (watf-12-b2-v4wan-169542-cust1006.vm45.cable.virginm.net. [81.98.219.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380705351sm51727455e9.0.2025.06.26.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:53:20 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: mathieu.desnoyers@efficios.com,
	paulmck@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH 1/2] membarrier: allow cpu_id to be set on more commands
Date: Thu, 26 Jun 2025 16:52:56 +0100
Message-ID: <20250626155257.81256-2-dyudaken@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626155257.81256-1-dyudaken@gmail.com>
References: <20250626155257.81256-1-dyudaken@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No reason to not allow MEMBARRIER_CMD_FLAG_CPU on
MEMBARRIER_CMD_PRIVATE_EXPEDITED or
MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE.

If it is known specifically what cpu you want to interrupt then there
is a decent efficiency saving in not interrupting all the other ones.

Also - the code already works as is for them.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---
 kernel/sched/membarrier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 809194cd779f..def6d4094ad6 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -595,7 +595,9 @@ static int membarrier_get_registrations(void)
  *          contains the CPU on which to interrupt (= restart)
  *          the RSEQ critical section.
  * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
- *          RSEQ CS should be interrupted (@cmd must be
+ *          RSEQ CS should be interrupted (@cmd must be one of
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
  *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
@@ -625,6 +627,8 @@ static int membarrier_get_registrations(void)
 SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
 {
 	switch (cmd) {
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
 		if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
 			return -EINVAL;
-- 
2.49.0


