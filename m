Return-Path: <linux-kselftest+bounces-15023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4A94BB89
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2AD1C20921
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0BB14A4DB;
	Thu,  8 Aug 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="bsYr7oDx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB31448D7;
	Thu,  8 Aug 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113931; cv=pass; b=OQd0exsgMaZ0Rmd6beogfXZfxunCcxPICJcvRqKwnpVKn2J5ryxpthU5qDoaKVOJFM+GRrfWHEBeCm6umy8VtBBuEwWL3eIykVbIsFXA3A2YqepkzLhdoi0yrod9yrK4GWittdVUglj/WMObXGYpQE/XQeptuZ0z0dLDq4xm2ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113931; c=relaxed/simple;
	bh=tzJh6V8U7ktztmiZcXG8TGGcEmA14cBAyKDC7eoUwF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRTOEb1yAki/aHsgflgEYJM15E3+lrt3bNPANCgkaKq2JZzZhFx4dWeeJfLIy7JgPy3tnVmJlFW0iugkXPJJKLQtAzXB8dvLjhtqFQ/v8T1LGZO1JINN9TR6fu7DSaIO1l5uM7S9yrPzR49w7gKv/vALmByP9qMVKBgC6yQxR0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=bsYr7oDx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: laura.nao@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723113914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZX1Z0U/wKaZUi7Y9bO5bcYwzwqlhDF+96UwSRew6a9QsWL3HdrpzoudPDqRnVB0iTXjW5egvkzudmiEhHreDSksTblurcOSxfKrIgdGWdym6/g3VJCZkx/ZSUtBNIIgXqQfyCnb6MKGej7FviVNnsbkOc+2TzK6c0shxp3qIyR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723113914; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ImzYMPWJt3gp3X9eDVJ3gAtm0zj1XfKecGOdA3mAkyU=; 
	b=UoB4saxU8ZctYOkVaCKqR1TWv37NvtfMudWx+B3RHLTR573cdtGYEu3027XfmIjy0NilVTaXdIcE6pe0HrKLKzHFU//gqpHVH8tn66FxSi9cV70/o8DnIefOGLp76HGYCXxIN2cCFBtv2GOyl/KkB75wa7T0n9xBh+QXNru8UN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723113914;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ImzYMPWJt3gp3X9eDVJ3gAtm0zj1XfKecGOdA3mAkyU=;
	b=bsYr7oDxQwjcpF2H7RWcGpq6vtXStk3iZq8FhnaxtUY5YHKVINr4CvvBMTjJw5C4
	LNBJkP11kU6BLp5NDhex0lCtLDlr+dgHWuRvtMCiFEdB6+NJdiXyBYeaUGd1yMaOUVG
	QhRjpir1jEF+mml+8y4CQL1webh64uBT1zjFj1+E=
Received: by mx.zohomail.com with SMTPS id 172311391141613.748118648028026;
	Thu, 8 Aug 2024 03:45:11 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mhiramat@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	tim.bird@sony.com,
	todd.e.brandt@linux.intel.com
Subject: Re: [RFC PATCH 1/1] kselftests: Add test to detect boot event slowdowns
Date: Thu,  8 Aug 2024 12:45:34 +0200
Message-Id: <20240808104534.17994-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731092534.16213-1-laura.nao@collabora.com>
References: <20240731092534.16213-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/31/24 11:25, Laura Nao wrote:
> 
> It looks like sleepgraph.py is more focused on analyzing suspend/resume
> timings, while bootgraph.py measures boot time using the kernel log and
> ftrace. The latter might indeed come in handy.
> As far as I can see, the script doesn't support automatic detection of
> boot slowdowns, and the output is in HTML format, which is meant for
> human analysis. However, I can look into adding support for a more
> machine-readable output format too. The test proposed in this patch could
> then use bootgraph.py to generate the reference file and measure current
> boot timings.
> 
> I'll look into this and report back.
> 

After examining the bootgraph.py script, it seems feasible to add
support for generating the output in a machine-readable format 
(e.g., JSON) for automated analysis. Todd, I've CC'd you on this 
discussion in case you have feedback on possibly using bootgraph.py in 
an automated test to detect slowdowns.

Some points to consider:

- The bootgraph.py script supports ftrace through the -fstat and -ftrace
  options, and it parses the kernel log to get initcall timings. To use
  this in an automated test, we need a way to provide the necessary 
  command line options. One approach is to include these options in a 
  bootconfig file embedded in the kernel image (as per proposal in this 
  RFC). Shuah, do you think this is acceptable? I haven't seen other 
  tests doing this, so I'm unsure if this is a proper way to handle 
  required command line options in a selftest.

- The bootgraph.py script tracks timings for all init calls, which might
  be excessive and generate too much output when integrated in an 
  automated test. We might need to limit the test output to report only 
  significant slowdowns to make it manageable.

- I'd like to get some feedback on which key boot process events are
  more relevant to track; depending on this, we could use the 
  bootgraph.py script to monitor initcalls and possibly other events 
  tracked via ftrace. The script currently uses the function_graph 
  tracer, and its parser is designed for this tracer's output. If we need 
  to track other events (e.g., kprobe events), the parser might need some 
  adjustments.

I'll be discussing this at LPC in September
(https://lpc.events/event/18/contributions/1700/) and look forward to
exploring more details and alternative approaches for an automated boot
time test.

Best,

Laura

