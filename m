Return-Path: <linux-kselftest+bounces-7205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1431898BE3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF1F281B76
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283612AAC5;
	Thu,  4 Apr 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uoYLWTLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8595224DE;
	Thu,  4 Apr 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247252; cv=none; b=WhpO/L3eG8BmLKIf2/fkl2DG6Cg4fJPnRTu/1IVE+rjzW0qsU7GSyQ6YdFlObkMcicXjcFRh7yplGV9cW0i1LDeOAZLhySwkY+z3XVW/nMmS7FDDfmB93uH58FIx7FTkhGk8QdpJd13a8LQsbFezJbmAJzDXUyNizOvzpuc0QP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247252; c=relaxed/simple;
	bh=UUiZipEEAobiO7PS4UAv/nMDLlJTMGONEQDPS3ap/14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbtQ0fdKH40vj/eF+PPuV9ZmnVVLyXvGjwUA7EYW6UZVgmpY6/lTLDdPShzT4KAh+KSAML+DoRUkgwqGnkHftZauviVRQ1c6nqksZRDV/CNH8/Y6icLhxw5eKYUpuwKZU0LsFl3/MxUojD1+Cvj1PKZa8CGczR94ontYO5fBhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uoYLWTLs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712247248;
	bh=UUiZipEEAobiO7PS4UAv/nMDLlJTMGONEQDPS3ap/14=;
	h=From:To:Cc:Subject:Date:From;
	b=uoYLWTLshZC5vsrh5QM1FNAKKvY2Oy4coxEmM3VUMh5wSaI3dAf4duzwnKfZvde3s
	 QLxOkaplfRvUpS2q5WELklv+KOAY8P/hHosBP6auRavnnSQC+O6FsFtwqyi8FRfHE/
	 v8EL+go/6vPo+A8tMrksy5iKRGWBdbyf+Dvdx9hXm766CfqCaX9J/qErdLu7dhvvAd
	 2V8LX+i1WsvgYhXcLcqchQfLwRs8LFzNNUmhoskaIPWnCl+vFOxXbAZtt9jCml7oCq
	 GiupKWuxr43RjQpok1ppX8/Oma0MWjDI7jwaBN4G8K8w+MVXVfC1kt+owi0u5nRREG
	 13X6Qf8bGJAwQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C941337813A4;
	Thu,  4 Apr 2024 16:14:04 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 0/2] selftests: add ksft_exit_fail_perror()
Date: Thu,  4 Apr 2024 21:14:31 +0500
Message-Id: <20240404161433.114497-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, ksft_exit_fail_perror() is being added which is helper
function on top of ksft_exit_fail_msg(). It prints errno and its string
form always. After writing and porting several kselftests, I've found
out that most of times ksft_exit_fail_msg() isn't useful if errno value
isn't printed. The ksft_exit_fail_perror() provides a convenient way to
always print errno when its used.

Muhammad Usama Anjum (2):
  selftests: add ksft_exit_fail_perror()
  selftests: exec: Use new ksft_exit_fail_perror() helper

 tools/testing/selftests/exec/recursion-depth.c | 10 +++++-----
 tools/testing/selftests/kselftest.h            | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.39.2


