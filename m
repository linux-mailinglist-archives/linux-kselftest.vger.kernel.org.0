Return-Path: <linux-kselftest+bounces-13104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB119252FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF320288428
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27522097;
	Wed,  3 Jul 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRqbtSN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE81DA302;
	Wed,  3 Jul 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984756; cv=none; b=hVAVU2Xb4VfetCTxCvPDil+HlGX6/FmBOLqEZh7+//v06cpYS5Lu3MMEqqBkLNQTQfsZDfa6FyFDuevFK1W/wD8THgaruVe//ACvhro5IH2+xuWsWM3LX0piYtlVFff6jZJ4zv9uff/N5UffthuNlrQ58JnzhZH2z/KyNy7jL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984756; c=relaxed/simple;
	bh=SwQXQ0b5+18PXqoUUODPuU2WKpArLoPS9E/RQuyvGqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FbaKCUsQokrRVPWDUbNjxluGYI4n46M+BFGgebl4s/k6zR/OqKfXD2Vg2hqvCmNrDHB90FCZTX+xkS8KyRbUmDYtkErDXs2OHAd2Tk81JDOVK0Zisk8nyV6a0piLhWfUZFYvSvqvn9QWwD+8zeakeRiMt0DTbpO/QqER71n/Umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRqbtSN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02FCC32781;
	Wed,  3 Jul 2024 05:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719984756;
	bh=SwQXQ0b5+18PXqoUUODPuU2WKpArLoPS9E/RQuyvGqM=;
	h=From:To:Cc:Subject:Date:From;
	b=aRqbtSN49ymy5pbnbqjCkKBpgM9Y/n7STsxys2ZTpIvZVHjyVhdm3rs+muhIt7b/4
	 d34mc7demMDufGN00vdOiccbJopGh2h8XGgC39qL9kFaLuxuu0PHaP0Fv+Yjr8r4Im
	 GucL9y011HfAF70pTGqNOzmAgSOqqm2laynYiSUMfJgEKcSm5Z59ecFPle+PWLlY0C
	 3oWo8yr+vyhSWMRd2YP8DKpT09yOZWotzN+OBj83XWF/mK6mfifidMsHkT4J5Sa/KC
	 5nEuSsAcK5HwYI36mRhb3TD/MSSXJ214PFy8WgiEr7jKsaYc9J/y7Pj2iedzYTXBjB
	 xr8o5gHyBPZuQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] tracing: Support poll on event hist file
Date: Wed,  3 Jul 2024 14:32:31 +0900
Message-Id: <171998475175.54594.7244942110355338359.stgit@devnote2>
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

Hi,

Here is the v2 patch to support polling on event 'hist' file.
The previous version is here;

https://lore.kernel.org/all/171932861260.584123.15653284949837094747.stgit@devnote2/

This version updates the test program, because previous version will
return fail on stable kernels which does not have this feature.
This checks whether the poll(POLLIN) on hist is timeout or not without
sending event. If poll() is implemented, it should timed out. If not,
poll(POLLIN) retuns soon.
And it tests both of POLLIN and POLLPRI in this version.

Background
----------
There has been interest in allowing user programs to monitor kernel
events in real time. Ftrace provides `trace_pipe` interface to wait
on events in the ring buffer, but it is needed to wait until filling
up a page with events in the ring buffer. We can also peek the
`trace` file periodically, but that is inefficient way to monitor
a randomely happening event.

Overview
--------
This patch set allows user to `poll`(or `select`, `epoll`) on event
histogram interface. As you know each event has its own `hist` file
which shows histograms generated by trigger action. So user can set
a new hist trigger on any event you want to monitor, and poll on the
`hist` file until it is updated.

There are 2 poll events are supported, POLLIN and POLLPRI. POLLIN
means that there are any readable update on `hist` file and this
event will be flashed only when you call read(). So, this is
useful if you want to read the histogram periodically.
The other POLLPRI event is for monitoring trace event. Like the
POLLIN, this will be returned when the histogram is updated, but
you don't need to read() the file and use poll() again.

Note that this waits for histogram update (not event arrival), thus
you must set a histogram on the event at first.

Usage
-----
Here is an example usage:

----
TRACEFS=/sys/kernel/tracing
EVENT=$TRACEFS/events/sched/sched_process_free

# setup histogram trigger and enable event
echo "hist:key=comm" >> $EVENT/trigger
echo 1 > $EVENT/enable

# Wait for update
poll pri $EVENT/hist

# Event arrived.
echo "process free event is comming"
tail $TRACEFS/trace
----

The 'poll' command is in the selftest patch.

You can take this series also from here;

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/event-hist-poll

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing/hist: Add poll(POLLIN) support on hist file
      tracing/hist: Support POLLPRI event for poll on histogram
      selftests/tracing: Add hist poll() support test


 include/linux/trace_events.h                       |    5 +
 kernel/trace/trace_events.c                        |   18 ++++
 kernel/trace/trace_events_hist.c                   |  101 +++++++++++++++++++-
 tools/testing/selftests/ftrace/Makefile            |    2 
 tools/testing/selftests/ftrace/poll.c              |   62 ++++++++++++
 .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 +++++++++++++++
 6 files changed, 259 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/poll.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

