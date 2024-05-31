Return-Path: <linux-kselftest+bounces-10992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D278D5EAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F020B1F21386
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EC135A65;
	Fri, 31 May 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdnhx3mV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5A133993;
	Fri, 31 May 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148612; cv=none; b=sHz/ATdRQwD4mJT1vKL8R/7lDEpWORh4051FbJ+XkYZ7f8BJTP+JZUbmJ9IAkeesrG3ybW7vhYrXa99p5K4zbzwAUvA6uv81SoY1Fdq8aeLosnvAkfBF3Nv8kY8eSzKteB2e3Cy3E6w5UUzq/sr1f8w31X6gG7AQJonAycX2Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148612; c=relaxed/simple;
	bh=Rp8mA1asZ6wDztf7QBipnOaEZGxaR8gps8Opj1bYW4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U+p+DbFsCpwb0VOgguAlYiEW/bcBUJWi3I1eu6tlczpEzStgYIBCNTGimIzlj4KZ/boLLRnWgac7/kcLT0AZXfvOSpVY2hwdjW0aH3XPO6LvHbvsYWNl8bKjxsgUkDKLLzj8K78r60iJz2u9O75tXNlun6Dt9zdC2+7KG/PByHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdnhx3mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5364BC116B1;
	Fri, 31 May 2024 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148612;
	bh=Rp8mA1asZ6wDztf7QBipnOaEZGxaR8gps8Opj1bYW4w=;
	h=From:To:Cc:Subject:Date:From;
	b=Qdnhx3mVVovm/FqmJex3a5//aYOs5MD45Ga8LURUXxiFFfYXRKOpVJDtrsTHlFHL7
	 fKwhPwhQSW3PHt2xguF69VyrARfhzBrdeLTx2fL5L5WuwUR/hYkfSQxPjwhNY9thZR
	 B+IeN0oHh3QMyZNUpTIW+EjamGuq87FmPihPSk1w17J8ugredcqYZKUPX4Z3BXXgCo
	 8w/HMocbhZhJgQSo0Xiu41923oyE4CWMO1EQOo6zOBdRdwqaGmQ7ARgbF42rnwLt9z
	 4/Pr8VTNud4u349nzCgTithq8+7zzxTQrUEoTkfQVrFzctLGRl/EgmObtAMI6vnHrY
	 XjInCJc9cBH0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests/tracing: Fix ftracetest testcase issues
Date: Fri, 31 May 2024 18:43:28 +0900
Message-Id: <171714860864.198407.18416314586430149538.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Here is a couple of patches to fix issues related to runing environment
and kernel configuration.

Thank you,
---

Masami Hiramatsu (Google) (2):
      selftests/tracing: Fix event filter test to retry up to 10 times
      selftests/tracing: Fix to check the required syscall event


 .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
 .../ftrace/test.d/filter/event-filter-function.tc  |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

