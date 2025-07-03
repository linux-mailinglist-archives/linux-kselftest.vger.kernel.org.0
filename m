Return-Path: <linux-kselftest+bounces-36439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE96AF7790
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D4C7BA9B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C202ECD10;
	Thu,  3 Jul 2025 14:30:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90092EBBB7;
	Thu,  3 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553022; cv=none; b=i/gVkJzIZvZhp0VFsnupyEJum1R3CiNCsVvZPwbVZPQWN2dARZ/q0OG8gn6ZiPfkHE3TGIcsZ31JO2V80yCCuLrotRgvttlBIZxxx7uH4Z3XbT2pyxR0mX47lEGwuMMsZExDGsgPyTG9sOxaenvEyhucX1kCCjakCz80LH5rFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553022; c=relaxed/simple;
	bh=iT5wdTPtTT05Zvme6nev472oJWo2SHintu4IzMCzQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkBYJZ7JUYbyv7+G8iWyRmFNIyDp0rZ6LBlkh49LOX/4qswLEEaf+1wTD/degZBq+ONDjth30dV+Zid9I+O1gOGBa/KihxPwHjjfbYIvWBx8L9SwEq/Vakh+sIcYfCOvaL/5vX9On7TETAYrWpokHrxBLiZFyrHzEYVLK8VKpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1CF6A121B66;
	Thu,  3 Jul 2025 14:30:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 3262A18;
	Thu,  3 Jul 2025 14:30:10 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:30:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fixes for filter
Message-ID: <20250703103008.0086bb77@batman.local.home>
In-Reply-To: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6c46ktuzxx17auoub1guzsao9kakiiwo
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3262A18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+QmiWMNgwVUBBGerzOCgRGrRzN3IHpN70=
X-HE-Tag: 1751553010-501758
X-HE-Meta: U2FsdGVkX1/xDOO7/4mkJB3tKQ+uaVxtBbIxutGlHsH3nxfG5E+vxFNv68ThwdXMiSiBSb8gnQGDh3AzNzawYZjzMCA0WEtMzu+0bx1//5aJ4qHVKM3ZGvbcBCWiVovGNx7UsNUG3DtuQbMjTqhkrxS01mef046kjNJLYM7sz/tR1Tghcxj8q4+YgjKuPltlap2R0Nl2uprb9kGcvDGS4YDAlrAr1tddl1J73PSBdy7tpyiGoWDRqM7kvxcg3MHjgd1T+ZvDA3deuj4H3xJcfs2b3ypHUBu0IHU5FtChm8nf9TUfyNJv2tmeyocODa7fyHDTFF+aJ6Uf2+6EJDlKh11tyQIk2hgZ

On Thu,  3 Jul 2025 13:26:26 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a patch series to fix some issues on the trace event
> and function filters.
> 
> The first patch fixes an issue that the event filter can not
> handle the string pointer with BTF attribute tag. This happens
> with CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y.
> 
> The second patch fixes a selftest issue on the function glob
> filter. Since mutex_trylock() can be an inline function, it
> is not a good example for ftrace. This replaces it with
> mutex_unlock().
> 
> Thank you,
> 
> ---
> Masami Hiramatsu (Google) (2):
>       tracing: Handle "(const) char __attribute() *" as string ptr type

I can take the first patch.

>       selftests: tracing: Use mutex_unlock for testing glob filter

This patch should go via Shuah's tree.

-- Steve

> 
>  kernel/trace/trace_events_filter.c                         | 5 +++++
>  tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)


