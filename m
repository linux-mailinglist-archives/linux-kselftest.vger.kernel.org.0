Return-Path: <linux-kselftest+bounces-43375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FFBE8757
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 13:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2D19A0B89
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D02D73B4;
	Fri, 17 Oct 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZBqarfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E127B34D
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701939; cv=none; b=oxb3h6p1YkSfr6MYi6gbC7a9Ekempj3BZ7OYnjm3jKkqjixu2PMzoGj75zW/HeMfSV4EYp3sLm0rGccQ3jA+KVGUOJgsjE6RyqP+7KuculgkDVMM3auFV5iSA+nNq4GBug0XQLm7ZjcjqYOGyusvj9wVWVdl2WdVPyvL9zsEscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701939; c=relaxed/simple;
	bh=FOca5tTbFWcePAHAl7Eifc2AqcyrN6pW9+HT0gDqUKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jckLeIv1pd6wqUDOuedAdbv4zGT0o9zFp/dtDNxts+lsjWRxVy41ypgFiuE4qkTXa5jVGjZYWTYOzgVAYh7BAZQa7is9MSPiyOL0d3MSwcrQ2ZXV+u0zam8yiu7N2WHATxvDy+/zunziEuzTiX5mIbU8YfRUcn7up8jIT/gTA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZBqarfl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760701936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OG8S2hI/eYRMbUZLperrVpe30F/q5Fz9fS8hkEhL7K0=;
	b=MZBqarfl4OeLo0bxtUH8yuWvJvwe7WBk5l3WgSYsiVY8GPZM8k7g6x+9ptucdEp2sVBUsb
	8Nw6WkmScSuY8tAKg++YD0Bu69c5DwSe+DE1E60G/MSIB9b1NAu43qYVazd6FnimtCDqzJ
	rRnowcQub81jl0HWvmO1PYWl25E5VUQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-RYk5Gup1OZWjnU9IFjMxUg-1; Fri,
 17 Oct 2025 07:52:13 -0400
X-MC-Unique: RYk5Gup1OZWjnU9IFjMxUg-1
X-Mimecast-MFC-AGG-ID: RYk5Gup1OZWjnU9IFjMxUg_1760701932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C21DD195608A;
	Fri, 17 Oct 2025 11:52:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8549A30001A2;
	Fri, 17 Oct 2025 11:52:08 +0000 (UTC)
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
Subject: [PATCH v2 0/2] selftests/verification: Add initial RV tests
Date: Fri, 17 Oct 2025 13:52:01 +0200
Message-ID: <20251017115203.140080-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Changes since V1:
- run stressors based on the cpu count on the wwnr/printk test

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
 .../verification/test.d/rv_wwnr_printk.tc     | 30 ++++++++
 .../verification/verificationtest-ktap        |  8 ++
 14 files changed, 279 insertions(+), 14 deletions(-)
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


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


