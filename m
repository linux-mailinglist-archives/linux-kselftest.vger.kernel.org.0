Return-Path: <linux-kselftest+bounces-5680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD0586DA16
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E94A1C20D68
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7145978;
	Fri,  1 Mar 2024 03:35:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74644370;
	Fri,  1 Mar 2024 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264147; cv=none; b=pyF8C7z56fMUbo1LkAyXEPuhLKCHdSzHXOu47g5NW7h9cNz7SGj5PGdLAQoTo25E3gzXUyKNAuTBjiKVeEGXJHm0FGK/+KdTbcDYzDop1BXWdCwCLTRsmE67rGNSus2K71zv4wEfphwW1+O2RGuAZS/sdCoZxVl/b1wF+kJIMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264147; c=relaxed/simple;
	bh=D0F9N7V6bNrm67XmBRCW7h6InZODiMqzg32okwkZAKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDa7hm9kGRXMjueDPZpcK4n7sehxsOiW2dpgp1lGy/uCExu1URJ9/MEre0psPw1Ud+tz017OlS/8KIQ4+/3vslWaeDd4ukVTf76euVd+KuOr3ry7FMvzUg8thgMyoEKG4le17voExVi4zqpr6zLjfM8Ys0dfRyDJ58hnZY7nagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76150C433C7;
	Fri,  1 Mar 2024 03:35:46 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:37:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/7] tracing/probes: cleanup: Set
 trace_probe::nr_args at trace_probe_init
Message-ID: <20240229223753.0e6dce81@gandalf.local.home>
In-Reply-To: <170891990355.609861.2805086066595778818.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<170891990355.609861.2805086066595778818.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:58:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Instead of incrementing the trace_probe::nr_args, init it at trace_probe_init().
> This is a cleanup, so the behavior is not changed.

The change is fine, but the change log does not say why this was done.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

