Return-Path: <linux-kselftest+bounces-37765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C203B0C9B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DD17A549
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B752E175E;
	Mon, 21 Jul 2025 17:30:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3582E0B6D;
	Mon, 21 Jul 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119008; cv=none; b=T9qR7A3hAn3YtwjrbZlMKqTUgnfNG/6TjjMRpD7Ah8ktrpuDCjW4/bBQCAAAZ8gTsLnGfMQPpcvr095yz7Sg5S3AmhkFi4bohQTY86QlrubjX2725riiontzoNVsB0/F1Z7/R0mTf3On6+tuOhoOsgrqFthAsyeQFZJX00xbQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119008; c=relaxed/simple;
	bh=F7maQntHBPrJOJLjnzlyFAGLjbw/d7g5uW++1kP44vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoeLv/agf91GX9O3ZrfHuA//g8cvQ5vdCJ5AfG73x77Fbe5IgWr6a8XgSarqtZ64FzKSpJS0GT2mbs/vNx8zCkMCfZJvMNZ5Du4YOmwS5uyyIcbzk+FIFafwrh8hxnkwefI9VIwP/R7tThHdEdHOKlxL6Ljs0LfcwjpPx64JUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 149DCB5E03;
	Mon, 21 Jul 2025 17:30:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 0FAA230;
	Mon, 21 Jul 2025 17:29:57 +0000 (UTC)
Date: Mon, 21 Jul 2025 13:29:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Yuanhe Shu
 <xiangzao@linux.alibaba.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next] selftests/ftrace: Prevent potential failure in
 subsystem-enable test case
Message-ID: <20250721132957.5184cd68@batman.local.home>
In-Reply-To: <88286bd2-a833-47e3-a0f0-896fbdd3fcbb@huaweicloud.com>
References: <20250710130134.591066-1-wutengda@huaweicloud.com>
	<20250710153409.3135fb17@batman.local.home>
	<88286bd2-a833-47e3-a0f0-896fbdd3fcbb@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FAA230
X-Stat-Signature: yssnn1bek5w4f8twbwp6a84n5tkr9cr3
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189Bj2Mf4RhqEdtHJSWyYsHXpwTyP6gX5o=
X-HE-Tag: 1753118997-575904
X-HE-Meta: U2FsdGVkX18DopyuBuxu403tiBJ+SMPubd2Jnikyp/tWroxX1tAefMOJnAEEpFPre4BDuZwRyx4IFcgjzWGg8SnA5uAyucnl0wXAG203pE8Fp4NDhxV3zjWakjA3+x2vlZmzB1hezH4p4nGiC6P8npYlkHZPzXw8NMsnnjqVFLUh4DrSJ+kzV3LvVh3xkiBUb3VgAECTCIUlfbzWDLNtVOUydoFtZ30pnVaHob9hnLi+a59jY8KKI2czyX7L9ncEj+UsXKXQdIxqV6gW9hk86eHOwMGeDrqb69A3b5ZU1QQv2K7XKtd94mRpLe0IkyiZFWXTlo5SaPeCI0oo9tsZjgIoBaXpAT/d

On Mon, 21 Jul 2025 09:54:22 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> I noticed this patch hasn't been merged yet. Do you plan to merge it soon?
> If you're too busy, would you like me to help submit it instead?

Nah, I simply forgot about it. Let me go write up a patch and send it
out.

-- Steve

