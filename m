Return-Path: <linux-kselftest+bounces-5803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA8586F5F3
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBE21C21908
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45867C56;
	Sun,  3 Mar 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlgxNmwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD05A0E6;
	Sun,  3 Mar 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480907; cv=none; b=hOAnwTvFfRjyIWDmvorp7NHlPY4EaVWqR0/FKjD/aDQvTeN45Mnl7yN6E0Xj5nTP8lZCNtKOGHgk7H1IWZi5Yo1CiOXo1UOAph0cGVN8FqpUZ2kY+Txy/czrc8SCRtizWZGV9PGbj15H2mU0FcTnWMZo6T5ZTrsAwZn8Ss/CQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480907; c=relaxed/simple;
	bh=nLO2exXHSWbViJf+T8mA8tkfEsJX/bkWxp3QzPBeDG4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EfLnNn0th3vJ+qGkij0UmUVkcYxCV5iiCcWkWeNqn3bmJauYF5sEaoPmbyhDijEOWvymGJ1WvW7ryDLoiJvSSGp4lpoktWpFuqsOtBFdTsWbyKo6ZSwpQ3kaRg0gL/NCi+cageywUqGuwA7lSvAvuFX1V431LrEa0+nA7xo5Aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlgxNmwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F45FC433C7;
	Sun,  3 Mar 2024 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709480907;
	bh=nLO2exXHSWbViJf+T8mA8tkfEsJX/bkWxp3QzPBeDG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlgxNmwDshBrhp2F9+AhsjUWAUrFy7uWOcAl+FSVqvWk/ArWfavTRR3G+eHGs85cy
	 oURhlI6P5k1qroMHSslyfMizvCjuLoZZpfV+Zei1rgBEhQVLzZJ3QcZRS9ZuM/WGqm
	 MNT85PZsrmanPWABjNU29Dhr9/biGJxvq1q95AhJEuzfFy1Ad2fGNZPoJFwipnnSiu
	 9MtMlIulKiTgbm4aRa/IlQqOyhIb/cFshnGTFx+/R3x6M9++Z7OzTmuNmRky8yGHlu
	 0MT7QXMb/4MVarLqjQCeBcnePh1oUQsaoFOfcq2kv0jFp/n1H32DdlzZB6KszIZhK/
	 VEt213AyyN+dA==
Date: Mon, 4 Mar 2024 00:48:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/7] tracing/probes: cleanup: Set
 trace_probe::nr_args at trace_probe_init
Message-Id: <20240304004823.5c475262a5b0117a4a60be89@kernel.org>
In-Reply-To: <20240229223753.0e6dce81@gandalf.local.home>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<170891990355.609861.2805086066595778818.stgit@devnote2>
	<20240229223753.0e6dce81@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 22:37:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 26 Feb 2024 12:58:23 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Instead of incrementing the trace_probe::nr_args, init it at trace_probe_init().
> > This is a cleanup, so the behavior is not changed.
> 
> The change is fine, but the change log does not say why this was done.

This change is to get the number of trace_probe arguments while parsing
the argument strings.

Thank you,

> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

