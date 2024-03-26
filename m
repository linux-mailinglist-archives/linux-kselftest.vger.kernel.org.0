Return-Path: <linux-kselftest+bounces-6636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BA88C87C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C501C64AA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FD13C9BB;
	Tue, 26 Mar 2024 16:05:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AE13C9B4;
	Tue, 26 Mar 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469133; cv=none; b=BD+ZMbKEdcb8lmfhK29Dm/ogDx7onXoN9VxgKrRlVSgtCnzDIRTWJslHgH0U3TNBf8jmMdksRXCAiUxfxTD6rVDOm23MLzcOreC4tvepIKmcpDz4sKz3t8/BmBlOI4gg1XJpC7Brx9C+kmpkZi/huym0aIzjZJZ4SDP6P6u3pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469133; c=relaxed/simple;
	bh=g0s1dB0LXhq1sZH2VQQ0wVJ2jxGJiYzVo4rcMUpmffI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFcvFs+ANAptkJWRmAECnugks4kv3ZQCv6A91JULAodoJP86ErhLCFwokBxeR+dCRNUn32FVAwHuYc7oikghiOVliHpnjWQnh5kFpUVUAmvE/bIOBOCc1HhyY9VUMSrB6jN5yv6SWwp1J2tT/AAWocXB5HKHzpO7NDrQFyXAD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10791C433F1;
	Tue, 26 Mar 2024 16:05:31 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:08:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
Message-ID: <20240326120809.09574951@gandalf.local.home>
In-Reply-To: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Shuah,

If Masami is OK with this, can you take this through your tree?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


On Mon, 25 Mar 2024 16:15:49 +0000
Mark Brown <broonie@kernel.org> wrote:

> This series aims to improve the usability of the ftrace selftests when
> running as part of the kselftest runner, mainly for use with automated
> systems.  It fixes the output of verbose mode when run in KTAP output
> mode and then enables verbose mode by default when invoked from the
> kselftest runner so that the diagnostic information is there by default
> when run in automated systems.
> 
> I've split this into two patches in case there is a concern with one
> part but not the other, especially given the verbosity of the verbose
> output when it triggers.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (2):
>       tracing/selftests: Support log output when generating KTAP output
>       tracing/selftests: Default to verbose mode when running in kselftest
> 
>  tools/testing/selftests/ftrace/ftracetest      | 8 +++++++-
>  tools/testing/selftests/ftrace/ftracetest-ktap | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240319-kselftest-ftrace-ktap-verbose-72e37957e213
> 
> Best regards,


