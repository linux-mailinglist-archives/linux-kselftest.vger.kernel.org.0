Return-Path: <linux-kselftest+bounces-28662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31FA59F40
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6D161F7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF743230BD4;
	Mon, 10 Mar 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Qg4kWn/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05A1DE89C;
	Mon, 10 Mar 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628282; cv=none; b=CRx39y22lyYVkbd+tXAqJHFnQ/wf+SkH/CGrC9Dfz7QyOUg0PBeOlJI46BgYGR+mvPekzVA2E2Ar2bGCcWHjuzHQ10gCW7sWCNiWQq9iJkntHY7Im5C60U+T5YXAGcdFnRF09aByc0FGyNTgjM6NVxuG62tgmHSyIITLZ60q+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628282; c=relaxed/simple;
	bh=1vkGvBEOz6Q/B2bFqUA31HdG1T1e00TEWKWPHwa9jl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGGdwa3L5COBYaRyam49gQZfCJcXkIDfgQeV2YcgZgEOxVhtHsF61spToHSE8ABfWvIIio81Nl6ILGuwQhfwlMhuFXPr5UhawJ8BZ1U1sX8RrbttzxsnJwF9NLHC7ug4CibrksfLRyk01eNnbCDdry5cJP8f6c8E3jvzyXvfz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Qg4kWn/h; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741628270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S7X1uYzLr5dyGvOKwCnpRfnCW5TB3lrvdrQD/ki4R34=;
	b=Qg4kWn/h6cREYrRIP2Rvhozt27vq72lEDldtwoO5gbhsMO1Nb5eLw0HOOZtrg0OWPWuRQr
	jZKTere4m+Y3cHnE4SD5RzhPKCG4puidDnUIKCc7QLIjJ5ikytrBudzjfUwr9Se5/9dnvG
	68aWCyM4Gq3EpXChGL2w5UAshB7Uwsw=
To: stable@vger.kernel.org
Cc: rananta@google.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y] KVM: selftests: Fix build error due to assert in dirty_log_test
Date: Mon, 10 Mar 2025 20:37:48 +0300
Message-Id: <20250310173749.11260-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all.

Please apply that forgotten patch to fix v6.1 KVM selftests broken build.  

Origin of the patch can be founded here [1]

Regards,
AK

[1] https://lore.kernel.org/stable/20240403164230.1722018-1-rananta@google.com/

-- 
2.30.2


