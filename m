Return-Path: <linux-kselftest+bounces-36368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B1AF691B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724BC1889960
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9828D8CB;
	Thu,  3 Jul 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOZnA5jX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B5289E16;
	Thu,  3 Jul 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516790; cv=none; b=Dh5ma6OkFjqePvCSgUGR5KpgGyXknYD6lWAh2vNa+LYxXnnVANe1DDV2u8vVnAD2J5Bs7Yq8CUWfiBxl0NcMqKmBOmwOlewC7gbtso/LSwVJaUsvwuMVxay5V/6h4spuGOKO2an6s1eRhZmj7Xbo3mAG7i11UHXgBJ8dViZM0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516790; c=relaxed/simple;
	bh=s2ZxLGzwoxGD/jOJK3uRfwiCV5DjvnjPAwkn2CNF2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6qn6EhfeSkfpx+llIfqfXUAhDdHYFNSbIKAnbtvN3vz4CJN6BK+hXGelhR+8e8qmVRpfaOk2uQngKiTR1YgGTzyDhzZET5z8CkbNiEdwnm+OzTCT6oBPMimaIixjvaYnj9buOs8SV9oao2YYU0e2TXWIrLBLAfkJLEnx6ltm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOZnA5jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF35C4CEE3;
	Thu,  3 Jul 2025 04:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751516789;
	bh=s2ZxLGzwoxGD/jOJK3uRfwiCV5DjvnjPAwkn2CNF2EY=;
	h=From:To:Cc:Subject:Date:From;
	b=bOZnA5jX3uAlXlky23KBVcoGGUEesAK3/cERxdUWg0zXDcx6AAflqTHRkwPqqCQS+
	 e0LXZ6k5Fn2af3sx/dxy9bMi8a//HE9NETu7/1vFsYD0lwQBJXBYtZlKB/loiz5GFa
	 8BwuVVqP81tc8HewlJJtMz9WJx3rGzz+kwB1o7A3xMlIuDvZ3ysM4L2atWxttrYWO4
	 2J9IU7o6z3Z60UDOdR2A5q1XOtSdePyl3FoPtaApu/hHhLkMlN8yvZpo87vehYw+jy
	 zKcg6E1UZZNVbRByiaNuIkoSb3n4zgHJWulmzfPD5yHRLixUP0+xDW/KMdEgZgFgvU
	 GkyoWvIGkf/5g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fixes for filter
Date: Thu,  3 Jul 2025 13:26:26 +0900
Message-ID:  <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a patch series to fix some issues on the trace event
and function filters.

The first patch fixes an issue that the event filter can not
handle the string pointer with BTF attribute tag. This happens
with CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y.

The second patch fixes a selftest issue on the function glob
filter. Since mutex_trylock() can be an inline function, it
is not a good example for ftrace. This replaces it with
mutex_unlock().

Thank you,

---
Masami Hiramatsu (Google) (2):
      tracing: Handle "(const) char __attribute() *" as string ptr type
      selftests: tracing: Use mutex_unlock for testing glob filter

 kernel/trace/trace_events_filter.c                         | 5 +++++
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

