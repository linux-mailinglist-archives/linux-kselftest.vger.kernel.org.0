Return-Path: <linux-kselftest+bounces-41860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A2BB8597B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044021C0098C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2C30F804;
	Thu, 18 Sep 2025 15:23:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7230E0E9;
	Thu, 18 Sep 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209013; cv=none; b=DK2atUWxDEJqp5hsDzw8D/ADnFB4JGXEUv2Q/bKIWZo+qUezbwLNqvoaP9SxVIMNMPUcnyCHi/41VmYpjqE3yye3/cAFUd+KwmDXuKOSdJwpNvnOm8b1HZCLW+wAYmIoJCQq5vT69u/ibCuwCAqwmwVFzYvjk9EYpK8pQYSDyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209013; c=relaxed/simple;
	bh=NHZ2ORArzxNUylF6vygV6kCOeIu2Wbgv9ac/4epvHK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBLM7xgzqceHDdN92Mn3izVuOd1zXzP7KdGxC6KqCEB72HWF+azAD5A1tzp64M5nqATnub6yDBU5wM2jm0hmZwutl01Qw258SF8Ws3TPZVQZo/m7jl7/RsSc50hWFxuaKhaYy/cR3PlYqQCA/8zAzc6en8hsw74oHwKcrumf6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B88C3B756B;
	Thu, 18 Sep 2025 15:23:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 6C22E20025;
	Thu, 18 Sep 2025 15:23:17 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:24:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <20250918112425.23d4d379@gandalf.local.home>
In-Reply-To: <e8e8b5e2-35fe-43cc-ba41-c84ccba189f7@vivo.com>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
	<20250917153055.6fee814f@gandalf.local.home>
	<e8e8b5e2-35fe-43cc-ba41-c84ccba189f7@vivo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: fqyhtzmk4ch6fggf79z9gc37wtq3dwu1
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 6C22E20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18P1hRjLcFAJR/HlcDkMOBrSvLYf6Ril7w=
X-HE-Tag: 1758208997-146052
X-HE-Meta: U2FsdGVkX19KLlcfuUHlnoX7WA6C2lDCWiD1hUjNLxixnDz/qr5at9WuFIcm+IE0hVWwHrzDnHtL/FhxnH6Lc9flXhRLnxNC+3Jfx5/CuhM0gcDZCq2qZmbp8fBv5MXvrlbsGHKFyjKeGbR/EivgAkrA9auX3H+7PRBDl9PZVJVtH+Nv39QCqMkBNMz0Dw2fpF+rmQ2sMhN/5kNTLsdxV7gA4YvTEde3iwnB7rz1txvHFxJMs/fmjcVj9NMspXvvSPah+cbky9LCU8jjwf2WeARwDTePM7z7Sq4KFBeX5xPlAm8ApHORE3uXXqzKxVBcDjJNQrE5yTxmBwC5bf3AvlJtPfXsEK7c

On Thu, 18 Sep 2025 20:33:22 +0800
Fuyu Zhao <zhaofuyu@vivo.com> wrote:

> At the moment, I don=E2=80=99t have a solid real-world example to provide.
> This work is still in an exploratory stage.

We shouldn't be in the business of "if you build it, they will come".
Unless there is a concrete use case now, I would not be adding anything.

My entire workflow for what I created in the tracing system was "I have a
need, I will implement it". The "need" came first. I then wrote code to
satisfy that need. It should not be the other way around.

-- Steve

