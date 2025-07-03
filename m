Return-Path: <linux-kselftest+bounces-36440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBDAF7788
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658A2168757
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061DF2EBDD5;
	Thu,  3 Jul 2025 14:30:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFB2EACFC;
	Thu,  3 Jul 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553050; cv=none; b=boVNWAePF73ATvJqOq6vR6nb+0Jnhw7m1bc4Uav/Cu66zngBme1VxQrFx6y7LOL7hDclHIcdIRvoK7TqO8p2ihWBbeh+RQkGBjJg767YjhuZ9gM5lFKPjTAdduUqUQIRvgMH12oTx/+w7u7+amxwdrusrkfLJwJLjninuKzufoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553050; c=relaxed/simple;
	bh=QCDlh0Vaygw/d6wzedRQv+1TXjDO7vZNOcSTY+eDGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGJnHIqFc9ajLvwwaIF8NKNkq6eogRTK/w4BfRUYEOBAtf69CplJUqnufFgT4MQoGiVE/ERWHx8MOjhVS9YmoLN7JefKycIzOioB2SbPF73Pyp/JFr+DU5uRo2KI57mToODqwx8sFbuvxMHvaZcoVncfI6uGRS/DYWyT7YWoplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 13D4C1A024D;
	Thu,  3 Jul 2025 14:30:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 317BE20028;
	Thu,  3 Jul 2025 14:30:40 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:30:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing
 glob filter
Message-ID: <20250703103039.3559a7e1@batman.local.home>
In-Reply-To: <175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
	<175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1jk6k9jkoy94d7jjx5e5yfqymssxfoow
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 317BE20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18T3YfGisIz3TD49b45GA8kdWmzSzbPB3U=
X-HE-Tag: 1751553040-397062
X-HE-Meta: U2FsdGVkX1+AL6FMKd0d2MG5zVhJXMA/yaUH4mKq1IgO3kZjG4UZJ6ApUC97NunupFNHJXEHYMjIQXD4t0DxXSGcmbgx3uE1Jr1Y5YR0odWgtYZY5+Cf3k/rWUY9JX8uYM4pwoFa2yaLeNBO2f8fVF7kxlA96LUw1P6UUdhuxYhq9zlfEZ0SVphqJYWVzSeP/SbSSHN4aokOtjlQfAMwqt69H5oPQpn8Gje9kbogcYwEZ3IPsuEdKiYxv4rVBUAeAamXLWFji5HwQD3PjaYFndPZR72ejzlP3nrUW4Ir2UgR2/ExuBb5OOihV1+g0V6lJYLX6Xb+evWjxy8U0YPuyEbagYmllTbxp+pTc89PGZY27f/7CfpyFFE4BNeaMj33QgNpK4/TiCyLVYY6rfo2rA==

On Thu,  3 Jul 2025 13:26:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit c5b6ababd21a ("locking/mutex: implement
> mutex_trylock_nested") makes mutex_trylock() as an inlined
> function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
> mutex_trylock() for testing the glob filter of ftrace.
> 
> Use mutex_unlock instead.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

