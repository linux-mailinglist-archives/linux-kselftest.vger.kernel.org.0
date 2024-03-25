Return-Path: <linux-kselftest+bounces-6547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8588AB82
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C111C3D2ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A614CB37;
	Mon, 25 Mar 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPB3dDB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA741A85;
	Mon, 25 Mar 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383475; cv=none; b=Wpr4/AD1y8VN/QGHsk+YpvnkRccPSxl/HqaTDr2zZ4J+pJI7khlKWTAg4Vh7ZiFHPNgdwubC3F+7+RZ7Eey0QHxjty0e2IrIh3N06SscvBZJLOF6qgP0NZz7T2ILz2lVrp2CCQJIZikzWj58q9uNRvYXRgb+K6V3bHrXEDUbIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383475; c=relaxed/simple;
	bh=d8LARACfnquRpxUsYeteRURYDSj2tOGCZwlTBTxdixk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h4IKEsJD7BJudFDfC/spqAnhW62XS7mxn5H+T+nGLUZMeIB0ZxC291zdHFoJDa+V3eI+Ku0nSP6OD+hrVKdY/H6xlGULdYpjCIZPQKhjMtpZvfY2+DpN6Phuax8DekhAppFskk3qf7LOpQfSzzsXfGU2o7wp5GICaJ5V0zvjzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPB3dDB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFA0C433F1;
	Mon, 25 Mar 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383474;
	bh=d8LARACfnquRpxUsYeteRURYDSj2tOGCZwlTBTxdixk=;
	h=From:Subject:Date:To:Cc:From;
	b=kPB3dDB9/JuMhfVeH0Ic2u9UcxixPymt1LwUE/RgcJujGIvkxfoVIiw91BJZudMoV
	 7JMXlazSv4+JHvmS4bt2e5MdB23JUnfjFB+1jHK3vyKzkdBrqroiTOQsQkQTVBgPHT
	 y8rdC3hEK0OC+cAkKNOWX4FN5Q/bGOcf37+uGj0FPjpPqQbKmyU0PLvZzUyi7EgzXr
	 0insZRxjgoE4E98e24JOcMrTaapTGqR6NeM0hLEPaWG22eOlzbq20DbPuBFDiDaoBP
	 Je2hY2H9XVKLTSdFTaXchuaGAdZOnIPUcGvSSD3tBdfMux1dMeDPgF6+wQJ9flHXey
	 hqR4C4Cf2twbA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
Date: Mon, 25 Mar 2024 16:15:49 +0000
Message-Id: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWjAWYC/x3MQQqDMBAF0KvIrDtgkpZgr1K6SO1PHRSVmSAF8
 e4Gl2/zdjKowOjZ7KTYxGSZK9ytoX5I8w8s32ryrb+3wXU8GqZcYIVz0dSDx5JW3qCfxcDRI8T
 uEeFdoHqsiiz/63+9j+MEbmoH/28AAAA=
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d8LARACfnquRpxUsYeteRURYDSj2tOGCZwlTBTxdixk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAaOthF+NZ9+e9WfJ08NlmbdUWMzywsrAN4vMy4FD
 KyPNduuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGjrQAKCRAk1otyXVSH0LEYB/
 4pKD/4WfQ6kWqz6gWfkXSAQOh+VNI/zMROqw8K4SSUEfrOAMY8c0adso9m3oj7lfWRR67YIqmgxzSL
 mP73DyMc/bXFN6cdqSyYzUzujXHMlbOeEl2v/zggBq1kMFwp9DAUMb6eOHvS/OkOWCURzQdi/5XGtf
 Z5S0KduXN2iI19BpC2ocBNhKuVNSOghsxIZ9oXWoUFNZMUhnn+vCVRgI70tGm02BiMKan7sGURqTo6
 yAFwOi86XFWMwgsOBVnE2HvdpJ3vK4c6nXXPHxDdfBoxvyJCoUQCAuJ3QcAosG1vnh61rv4WUkjNwS
 OLmN+oA3kcEr2Bf6ZMrHstGm5rYD1F
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series aims to improve the usability of the ftrace selftests when
running as part of the kselftest runner, mainly for use with automated
systems.  It fixes the output of verbose mode when run in KTAP output
mode and then enables verbose mode by default when invoked from the
kselftest runner so that the diagnostic information is there by default
when run in automated systems.

I've split this into two patches in case there is a concern with one
part but not the other, especially given the verbosity of the verbose
output when it triggers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      tracing/selftests: Support log output when generating KTAP output
      tracing/selftests: Default to verbose mode when running in kselftest

 tools/testing/selftests/ftrace/ftracetest      | 8 +++++++-
 tools/testing/selftests/ftrace/ftracetest-ktap | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240319-kselftest-ftrace-ktap-verbose-72e37957e213

Best regards,
-- 
Mark Brown <broonie@kernel.org>


