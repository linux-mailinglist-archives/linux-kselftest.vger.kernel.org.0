Return-Path: <linux-kselftest+bounces-17758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3094697582B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4A52833AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406BF1AE845;
	Wed, 11 Sep 2024 16:21:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF92224CC;
	Wed, 11 Sep 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071697; cv=none; b=MAZ6/E3eiS8NRd6wFVGwbqgz2FyIwj5r5sk71WEBW3ngjNsM18sEcnEnotgPL/T6LTgewZ4NBK247xYnR3H4n/v6hIJQOXcRDeh6Sd+ovxcC+igFeatKnoOYbTdVsCHZbwBO3HngGghVHHWiB1KlzgzKL+pJhU56N7F/Z/PMT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071697; c=relaxed/simple;
	bh=hRR9dXMQ5Vo5rZtuvafz2w9lH+QJ9hDX119W4gRXFTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZAzWT3/M+A6weEGDEoKgZlG8Lnnc18LmH56eM+dB7UdonATGmhxE7CQu7kLruXcqFWEp3zrmkKrsQf23yQREyLL/UoRWfXeky+lcnfGX7z58yYXAlzmOzvOXIu5yqvLYuJtM/mU/YhViZIfuEiPfK3Vwb7kxL5Ly9SgOuJsxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC6BC4CEC0;
	Wed, 11 Sep 2024 16:21:35 +0000 (UTC)
Date: Wed, 11 Sep 2024 12:21:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page
 bigger than the system
Message-ID: <20240911122138.1aa07f1c@gandalf.local.home>
In-Reply-To: <2df38d7a-682e-4af5-be01-67adb6fdd5b0@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
	<20240910162335.2993310-3-vdonnefort@google.com>
	<20240910124555.180428eb@gandalf.local.home>
	<bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
	<2df38d7a-682e-4af5-be01-67adb6fdd5b0@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 10:07:40 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Once this is fixed:
> 
> Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I'll add it to my for-next queue.

-- Steve

