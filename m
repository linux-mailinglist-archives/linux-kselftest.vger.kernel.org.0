Return-Path: <linux-kselftest+bounces-46403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087BC826BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 21:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99D5A34AC96
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 20:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A12E03F0;
	Mon, 24 Nov 2025 20:38:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414A2D5950;
	Mon, 24 Nov 2025 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016734; cv=none; b=ScQXcbjVYAatAKZXcoWhBWgRdw/1l3MUaPSjGnd7h5yJsQXaINBbtgGOx28rNfEC5gFg59QXNVNPtvYUIH9VyUB5ypnYNpRWmZj8pFvR4bJ+aC3JMswVHA6yEihHSaq03oxW3X8m9FyBw8/qHK4OqeIufOk5QEBrxhWB76+Yw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016734; c=relaxed/simple;
	bh=X9cfxf7b047w2La7Y2yLyfnrwed3yKipzTXzKG8G3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUueJFO2fg5wzjT7e0HGeEBaJAP5Ai+a7nCSI+h+gcd8O+ZaqYGtaJt6JHeHWsJxVETvSnY/FGc80E8c7RRwFNW6upBOU8sYO3BcrxIuIG+bJ8C+JgSxOprhlqRAuLogG7Ebgkvl7YyUym/9l89/Bj6+BIbDM5M0IdRrY5gLCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 672EB4F2A0;
	Mon, 24 Nov 2025 20:38:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 2D90633;
	Mon, 24 Nov 2025 20:38:48 +0000 (UTC)
Date: Mon, 24 Nov 2025 15:39:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
Message-ID: <20251124153930.336ef162@gandalf.local.home>
In-Reply-To: <f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
	<f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
	<20251119170611.6eff8df7@gandalf.local.home>
	<b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
	<20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
	<f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: on57odgg5a3m6a3jht5oujhyu3o99ph3
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2D90633
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZIMHjPv464oW8WrTgr5epzYaRP++lXcw=
X-HE-Tag: 1764016728-504759
X-HE-Meta: U2FsdGVkX19+rxH/MzqdVH+0EkXf5ZiDesVj7lHYM4Z8oR2m002kafTq+wH2ZQBdDRkwKmEN3PVCYqp6xgYtQvl3MGTChaZMnLtwRUxe08z4l3jB0uokgGke42LGiIlJZuzith9VUkcekyDyeICuWp/x1X/O+vPo2+rWq2Kbz+Gpc+5CfRCPn85M/SqKnU1w+6SIcKh1ZcIcOm+EDEcnCTAldHVLMnSfa32YZlJ2EDEZ+0lna5TqHPQ2nzO0JGb6wQG+AoFjDcR9eZewylMPVpQJ0/c20J5OTcYWaJFg+PnAANFPz1lBOsXUKOnGLAbWdlrXjbvK5rDFc8h7ToygicmbdHhpNoJY+8rGQXJyswCxvIdbqohXBY3a+oY6i+WbKzQ0bhtUnygC2fK/B5PjqYhdycl+PFbDbekMGt+KoBUH44SeNwCPbg==

On Thu, 20 Nov 2025 09:40:28 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > Thanks Shuah! This and other regression fixes is better to go
> > through selftests tree because those are checking existing
> > features. Maybe better to add [PATCH -selftests] or something
> > like that?
> >   
> 
> Let me know which ones you would like to pick up and apply to my tree.

This one and I believe this one:

  https://lore.kernel.org/linux-trace-kernel/176295318112.431538.11780280333728368327.stgit@devnote2

-- Steve

