Return-Path: <linux-kselftest+bounces-42453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A6BA337D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7F1B2843F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B782BDC03;
	Fri, 26 Sep 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbHlnkNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4A2BE041
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879999; cv=none; b=QXQbKXeMWj6079yDcPCRdta2LeBHykLot0WpaTBsLCPkBzsHLVJGDIUHX7j8yJQvFDxExm8zK6somuMGNrvida4MUuPXpyWnJbOowcB/6aEfAipA4Xe11Tzl9B76+fKDcJQ46/lIFU45ulV4pOvuF6FagI4/o3dLqwod6L9+jmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879999; c=relaxed/simple;
	bh=kfIi6VrIE2lEa92dIkJL1fhpPaEmO6naVvpOiV6YbKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWyHx01lJbA9Y4sroFB/41wlg6Czj0pJAgqGIpl/mMi7Q05xYIsjZbY9+qZfjNkAGWGMbv0eTgqYsb75cXLyjhh6x+S0Q7e4UcRkn71FtLPz6cA+HKHphR2ZfhpLxYrTkU41UAW6SsNBmMF7h794xfDYYBJ1e6CAqs5lr1iNSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbHlnkNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758879996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSya+H0jA/G4MDTH6lvX00akKIqMxNianJVPL7t72DQ=;
	b=HbHlnkNU6S+yt2Itxcmgvozny2o4nvxBbH8800hcldcFQirO/2N0aK2oZjsy2O3o+oEG6/
	rYHoaKxZyTS+BseDvZ/vMZNuN86h9561UqTgonsUn1B7oDhgA+4PIgogbPkXiNfXfLH3x/
	OqPOGYo+K3sks7elhvhD8uQeBhMvTn8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-e4MAtEV7Mj2HfGs7lxr5tA-1; Fri,
 26 Sep 2025 05:46:32 -0400
X-MC-Unique: e4MAtEV7Mj2HfGs7lxr5tA-1
X-Mimecast-MFC-AGG-ID: e4MAtEV7Mj2HfGs7lxr5tA_1758879991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70856195609F;
	Fri, 26 Sep 2025 09:46:31 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.225.225])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84B9318003FC;
	Fri, 26 Sep 2025 09:46:27 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Waylon Cude <wcude@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests/verification: Add initial RV tests
Date: Fri, 26 Sep 2025 11:46:11 +0200
Message-ID: <20250926094613.34030-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a series of tests to validate the RV tracefs API and basic
functionality.

* available monitors:
    Check that all monitors (from the monitors folder) appear as
    available and have a description. Works with nested monitors.

* enable/disable:
    Enable and disable all monitors and validate both the enabled file
    and the enabled_monitors. Check that enabling container monitors
    enables all nested monitors.

* reactors:
    Set all reactors and validate the setting, also for nested monitors.

* wwnr with printk:
    wwnr is broken on purpose, run it with a load and check that the
    printk reactor works. Also validate disabling reacting_on or
    monitoring_on prevents reactions.

These tests use the ftracetest suite. The first patch of the series
adapts ftracetest to make this possible.

The enable/disable test cannot pass on upstream without the application
of the fix in [1].

[1] - https://lore.kernel.org/lkml/87tt0t4u19.fsf@yellow.woof

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Waylon Cude <wcude@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

Gabriele Monaco (2):
  selftest/ftrace: Generalise ftracetest to use with RV
  selftests/verification: Add initial RV tests

 MAINTAINERS                                   |  1 +
 tools/testing/selftests/ftrace/ftracetest     | 34 ++++++---
 .../ftrace/test.d/00basic/mount_options.tc    |  2 +-
 .../testing/selftests/ftrace/test.d/functions |  6 +-
 .../testing/selftests/verification/.gitignore |  2 +
 tools/testing/selftests/verification/Makefile |  8 ++
 tools/testing/selftests/verification/config   |  1 +
 tools/testing/selftests/verification/settings |  1 +
 .../selftests/verification/test.d/functions   | 39 ++++++++++
 .../test.d/rv_monitor_enable_disable.tc       | 75 +++++++++++++++++++
 .../verification/test.d/rv_monitor_reactor.tc | 68 +++++++++++++++++
 .../test.d/rv_monitors_available.tc           | 18 +++++
 .../verification/test.d/rv_wwnr_printk.tc     | 29 +++++++
 .../verification/verificationtest-ktap        |  8 ++
 14 files changed, 278 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/verification/.gitignore
 create mode 100644 tools/testing/selftests/verification/Makefile
 create mode 100644 tools/testing/selftests/verification/config
 create mode 100644 tools/testing/selftests/verification/settings
 create mode 100644 tools/testing/selftests/verification/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
 create mode 100644 tools/testing/selftests/verification/verificationtest-ktap


base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
-- 
2.51.0


