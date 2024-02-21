Return-Path: <linux-kselftest+bounces-5092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1085CC73
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110201C2287C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828B1DDC3;
	Wed, 21 Feb 2024 00:00:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B63D8E;
	Wed, 21 Feb 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473637; cv=none; b=aT1CE+u0tdzA3f4HQ5uSk9+YyrOHTuSsLvYTemUwwumGCz8/eZ4AKmcIwSoqus59ciyKilIHrefG8RIZiuLp2L2DEJQguTH+w3CT1ZfJH4clI3m8ZEaAK/wjJCPtiFpTiAKwNObyV8nyl8eI4UntzqiyIBgOzMBH2TgXsVnaXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473637; c=relaxed/simple;
	bh=jA6XQgMN2vtaIUCCpVYoVeNT7CEDAqvQvk1Os1hpi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2xHR5cwYKG+McVnoY+KpZvWGdqKx3TZuBYPN8N9P+40zyrOBMmccJ2KXPT2zJ4VuagMSD5y+cWPrgua7nVT7hvO6kA0rE5kxhYs50im4iQZuT/tCZk22GqV0FFUVxtcZ7ebNtO6lmZK3cqom0fvMaMPlUH5CBF1ftMayDnjf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F5CC433C7;
	Wed, 21 Feb 2024 00:00:35 +0000 (UTC)
Date: Tue, 20 Feb 2024 19:02:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest: ftrace: fix minor typo in log
Message-ID: <20240220190221.0f7e9f3b@gandalf.local.home>
In-Reply-To: <7459e07b-80fb-4eae-9414-3dee68cfd173@linuxfoundation.org>
References: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
	<7459e07b-80fb-4eae-9414-3dee68cfd173@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 16:41:01 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Steve,
> 
> I picked this up fpr next for Linux 6.9-rc1

Sure, and you can add my:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Shuah,

-- Steve

