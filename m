Return-Path: <linux-kselftest+bounces-48582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE7D06FC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 04:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D61301276E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD57296BA8;
	Fri,  9 Jan 2026 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYz/BA0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD6257825
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929295; cv=none; b=NRnMuyt90pWNGQlfIZhSG8g6xvGaa+OqtZeTa7wvXStfeAC3cjFR+lQVHEYYGOpJdANWJ4p8hWIVLOCQ71EGlx9qBFzDNFpEJkfzbV0Ttzu5P4Ib6UsKAmLaHZ5k/9R2WpViLxxIt5ialQXTkasWLB35+YUvHTgIUyjZFKgEv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929295; c=relaxed/simple;
	bh=kWS5tTopYKaYJ1BcbzxRgQBoc0MZoxNlw60BQQcaDZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqXLEmryWcEymANkm3csnNJgJnfarPzOoKSZnZ61uIC//R+PPZI2mLHX9Gb1VMgiPqQ8umZ+j41V65DngHYIaXotyybquhp8dZ0Z8RgbS9+2/KFp4MCYMe4rR6uJeOr2ukjfDUNGjovdcCIzxqn32js2DjzREMiQOSjOXREnaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYz/BA0P; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767929282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viLl8OWkqVDAtr8Gv96r7ncFOA8X08RNHplLEAR/RZU=;
	b=tYz/BA0PcokAJy2Cwwci7FwF+E965IG9nNdpSwhq2h6rAkjTq5mZ2aEmA0LtGWJufqe2mk
	nXJQ4Guk9lFDdWesj6LbtO/yt01PW9LOZzSfXEBy9hf2ARVBWoj/mJOc+XYNx//pPRfLvv
	1XEdnfvRFD+KOAGoThf43MIdnaffhS4=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: rostedt@goodmis.org
Cc: fushuai.wang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	wangfushuai@baidu.com
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
Date: Fri,  9 Jan 2026 11:27:47 +0800
Message-Id: <20260109032747.25042-1-fushuai.wang@linux.dev>
In-Reply-To: <20260108165247.3ae2f21a@gandalf.local.home>
References: <20260108165247.3ae2f21a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Anyway, Fushuai, you can add to the top of your commit:
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> and that will make the From and SoB match without having to change your
> mail client. I usually have that. Because Linus doesn't like my patches
> having my company name in it for the "author" but I have it in the SoB to
> give credit to the one paying me to do the work.

Thanks!
I will send a v3 shortly.

---
Regards,
WANG

