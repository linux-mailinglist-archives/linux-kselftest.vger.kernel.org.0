Return-Path: <linux-kselftest+bounces-42862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37612BC3194
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 03:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9545A3C254C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD528A72B;
	Wed,  8 Oct 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brTwry31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA963CB;
	Wed,  8 Oct 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759885578; cv=none; b=Kb+JMKl58zZR8PFFFre/w/NL10O8QlZPHNXA6aiMXeA/W1utLuoLyBzAfSbm9ho5kNh1C71tr31TUZphL9B3KxCbE9ea+O+Z79wBSobq6TwLdldulOZZN9VtAG6L9B9gth/L23yQaDk3gUV6ssmrEmQoIJ0i8fRLcorJsdiqjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759885578; c=relaxed/simple;
	bh=b2QR7rAkEeRXVWZAYkoYdNvI9KgEwZEWE8tXc7shBAk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n2iZXan73MpWOkgH4skSQJWi1Mux/OH4y9RHbx9XEj2+9a4U5TPItPZWlt1KDzG/FioEsde/Hs7FxBnHAUv1rt+a/3PLYcrnq8V1ebK2914TnjXlXXKwkM3PBV78eBcUv8hd8u2fnn5bFcI2F22MeATuSf6kgRAP/Ic66/cBgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brTwry31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1232BC4CEF1;
	Wed,  8 Oct 2025 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759885576;
	bh=b2QR7rAkEeRXVWZAYkoYdNvI9KgEwZEWE8tXc7shBAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brTwry31GxoRDxZcHwwNJlf8Lzb8IFK1LrPmW2JQ6ueJjrmiLTwB9a3NHkxoXKe3L
	 n6zVEjETTQX2opE4YqYHhexSr2Q05+tQIzpNZ2bE4YD2gvcQDL7oB2PonLFk17U1c5
	 q+w7WpKB/UsPvEJ4FE2hbqQ8ZXch+lunrSEhgg0NnhtUnlTYzV84Owmv1Q7mLjIhII
	 Cv1Tqipo7jw3aCAp6MbZ61j+F8CTB5sWn+2GSNWdmFGmJt8LO+2w5dpafzVhqXGE7/
	 tpBQAuz03cnahUkkURfm8IdXU7oNf0FQReXNH09tSStmNnAgoT8uAIcSJrIbLEmzJ1
	 fn6iXXqf+KndA==
Date: Wed, 8 Oct 2025 10:06:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 hca@linux.ibm.com, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] docs: tracing: fprobe: document list filters and
 :entry/:exit
Message-Id: <20251008100611.6fb5f0b9d49c9d0c403e2670@kernel.org>
In-Reply-To: <20251004235001.133111-2-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
	<20251004235001.133111-2-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Oct 2025 08:46:55 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  Documentation/trace/fprobetrace.rst | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index b4c2ca3d02c1..629e2d7402bd 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -25,21 +25,36 @@ Synopsis of fprobe-events
>  -------------------------
>  ::
>  
> -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> -  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
> +  # fprobe (function entry/exit)
> +  f[:[GRP1/][EVENT1]] SYM_OR_LIST[:entry|:exit] [FETCHARGS]
> +
> +  # legacy single-symbol exit
> +  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]
> +
> +  # Probe on tracepoint
> +  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]
>  
>   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
>   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
> - EVENT1         : Event name for fprobe. If omitted, the event name is
> -                  "SYM__entry" or "SYM__exit".
> + EVENT1         : Event name for fprobe. If omitted,
> +                  - For a single literal symbol, the event name is
> +                    "SYM__entry" or "SYM__exit".
> +                  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1]
> +                    is required; otherwise the parser rejects it.
>   EVENT2         : Event name for tprobe. If omitted, the event name is
>                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
>                    with a digit character, "_TRACEPOINT" is used.
>   MAXACTIVE      : Maximum number of instances of the specified function that
>                    can be probed simultaneously, or 0 for the default value
>                    as defined in Documentation/trace/fprobe.rst
> -
> + SYM_OR_LIST    : Either a single symbol, or a comma-separated list of
> +                  include/exclude patterns:
> +                  - Tokens are matched as symbols; wildcards may be used.
> +                  - Tokens prefixed with '!' are exclusions.
> +                  - Examples:
> +                        foo             # single literal (entry)
> +                        foo:exit        # single literal exit
> +                        foo%return      # legacy single-symbol exit

So you can explain it in syntax formats:

Single function (including wildcard):

  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]

Multiple functions:

  f[:[GRP1/]EVENT3 SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS]

Where,
 - SYM prefixed with '!' are exclusions.
 - ":entry" suffix means it probes entry of given symbols. (default)
 - ":exit" suffix means it probes exit of given symbols.
 - "%return" suffix means it probes exit of SYM (single symbol).

Thank you,


>   FETCHARGS      : Arguments. Each probe can have up to 128 args.
>    ARG           : Fetch "ARG" function argument using BTF (only for function
>                    entry or tracepoint.) (\*1)
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

