Return-Path: <linux-kselftest+bounces-6549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1377488AB85
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD63C288AB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CD12C7FB;
	Mon, 25 Mar 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olLbVQnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BED12B16C;
	Mon, 25 Mar 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383479; cv=none; b=I22R1LEr58uehzetsWQQa2YwbaE8IqYStw1mgEWOZkNdFVDO4SHkI6e2ue7ZncbuxsKa+n19UlS4kxI9oZ353Mz0/7ZlKOY3S2NPpCSQ8shGLEBkuVB3maK1hIIILWGiBzNNhq/V1k651MN03PVl7MYydM9T2eTNpdTCfMKyTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383479; c=relaxed/simple;
	bh=IDZmVTQL6FUPF4VXy4kvhrE06bFthcPgs9kXAUa4MHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+zOB9H8AbdKZmGiF4eyQI1cth8c2eYF1KzaIOy/PzhOc6iG4WYwNsxceKF9d8FM5KNHyWGg1+9b+dwaZ66MlIlqwyxtmykNlT+cOWmTrjia/CipKdS9X1Pzk7HOk6xWSJ9ZU7RbCOZJsQnTN+00XVE+7qyIF+iLY4wXraSNoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olLbVQnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1196DC433C7;
	Mon, 25 Mar 2024 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383479;
	bh=IDZmVTQL6FUPF4VXy4kvhrE06bFthcPgs9kXAUa4MHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=olLbVQnO7TGptxzycuqWSNXMlKEHChyw3zRv46MXcNhG+rA4lTdWrWl1p55ElHepQ
	 LLd4jgr2KR4jhrjUtvXYUfu7scQNng9XgK4kos6NVaei3IUfMdEcAxuoBK+0eRBcYX
	 HiQ2h/cZ5godDGLrRp6KN3QVrUUK70k7nGyYk9aBnR9ZNJNteTnSdMPfcoHX7fiuFd
	 WR8pYa1ht+0Kdyhj+QL/FwKlq8wKY7h5usqz6ItdcSmaZOHoMiUx+7qKIajX3+eYD1
	 1P5S7MRnrcRwaIfDgPuPGyFfJnmUcvtqxonsRC/Mlz+IVV/a6dgWoI11bpWZcs26I+
	 Aju6CICJQAWxQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 16:15:51 +0000
Subject: [PATCH 2/2] tracing/selftests: Default to verbose mode when
 running in kselftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-kselftest-ftrace-ktap-verbose-v1-2-3785199809da@kernel.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
In-Reply-To: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IDZmVTQL6FUPF4VXy4kvhrE06bFthcPgs9kXAUa4MHw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAaOvbRVid4KdhaOgoFVH1DkequIpxxcu0SW4Fv5d
 efPO+peJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGjrwAKCRAk1otyXVSH0DT3B/
 4o3VAA+e8nn0hiFSXN4UX8I2TMbL8acEu2QQIzdscZ6Hm9SoRI6ksxZ8fu8/7a+JEhPhKL0z/yYYsW
 K4z3InUL1ZUWoavhgesdozrbtaBDRDayXXZgcL0op5eaSwOJk1yGD2kS1rp4Eqpvokuua+5D1Kf+qf
 rO/etGks1AFPnn4qQboUAKX6gr1j6erXjqG4jhuSd28c+7CgS9ojhHvDFbz4X42+R+lgdU8bwGLPIw
 FewY60hhYn8c26Va7vDNHCREvWEoNNUz6zGKzVZxTzU2ln8tAWyFAbPVZ5OHewsrvoWooJR9JW32WA
 kelLkuwOuNi5IuCvZX6c9qAgmiJQDP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to facilitate debugging of issues from automated runs of the ftrace
selftests turn on verbose logging by default when run from the kselftest
runner. This is primarily used by automated systems where developers may
not have direct access to the system so defaulting to providing diagnostic
information which might help debug problems seems like a good idea.

When tests pass no extra output is generated, when they fail a full log of
the test run is provided. Since this really is rather verbose when there are
a large number of test failures or output is slow (eg, with a serial
console) this could substantially increase the run time for the tests which
might present problems with timeout detection for affected systems,
hopefully we keep the tests running well enough that this is not too much
of an issue.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest-ktap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest-ktap b/tools/testing/selftests/ftrace/ftracetest-ktap
index b3284679ef3a..14e62ef3f3b9 100755
--- a/tools/testing/selftests/ftrace/ftracetest-ktap
+++ b/tools/testing/selftests/ftrace/ftracetest-ktap
@@ -5,4 +5,4 @@
 #
 # Copyright (C) Arm Ltd., 2023
 
-./ftracetest -K
+./ftracetest -K -v

-- 
2.30.2


