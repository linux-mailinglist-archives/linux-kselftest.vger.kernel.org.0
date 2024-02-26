Return-Path: <linux-kselftest+bounces-5446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA8867D90
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47F81C29360
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8836131E46;
	Mon, 26 Feb 2024 16:57:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B31131748;
	Mon, 26 Feb 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966664; cv=none; b=OeD5MeNKEqYjGMSuOXISscCSEcIyRO+dit2MNsMYsC+1no0RZxDhtAkBQPz+mZFdOORHpMn5wZoeuwGJeAe1LXcPXfm7M3of5/lwGtuq/WvIEXR2GWWEcLkTDq4IFUYPbH3Y5DL0nxgzuyrBr5XIARFZBgrv54waRVll/x+leas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966664; c=relaxed/simple;
	bh=HcRKm6vApqzrzvFikMkQEsVjpTXQNlTNc66ff3SA20M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVYRyjI3c9cEizL4vCl+AOIwLmIe6Avmfhh00Km6jMLuuuhgj19hM64fKqU67L3umTqAopLKZPKAYdq+2auwTNSCfUVAZSbI92fn4MNQLp3JUmH9F4An096iEGVs9Nho7dEGQsq7REE/ExKqanFfnuzRveCH1JKYyqj4rmbr+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C3FC433C7;
	Mon, 26 Feb 2024 16:57:43 +0000 (UTC)
Date: Mon, 26 Feb 2024 11:59:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Limit length in subsystem-enable
 tests
Message-ID: <20240226115942.1213cff4@gandalf.local.home>
In-Reply-To: <20240226150938.7f0d8fd639bab79199d8556b@kernel.org>
References: <20240226031816.88715-1-xiangzao@linux.alibaba.com>
	<20240226150938.7f0d8fd639bab79199d8556b@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 15:09:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 26 Feb 2024 11:18:16 +0800
> Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
> 
> > While sched* events being traced and sched* events continuously happen,
> > "[xx] event tracing - enable/disable with subsystem level files" would
> > not stop as on some slower systems it seems to take forever.
> > Select the first 100 lines of output would be enough to judge whether
> > there are more than 3 types of sched events.
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Hi Shuah, can you pick this as a fix?
> 

Yes please.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

