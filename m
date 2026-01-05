Return-Path: <linux-kselftest+bounces-48222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CECF4F2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ECEB3004EE9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94B3385B5;
	Mon,  5 Jan 2026 17:16:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43F3358D2;
	Mon,  5 Jan 2026 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633370; cv=none; b=tj0NTHQTEAiR3zpYaj3Q7+ibFoDkXPoZEHsNP1i3qXz/SQQIOwhaWlgo+NhiRb1YNHRvq0Bqx1SzmHxcKI9WYo7ampOlQKfGehVJZ1baMNdIc27sYDkCXZOO3ib1rZ4Kyb9IXpdM3ULZGXXdlF9tNApqDniyypVs5hqX159t4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633370; c=relaxed/simple;
	bh=N34XKakxs6/O9rPTyYFJNREr00hdJWQFIAVMU1fqeZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLIKn8vGQO0fD5wlaM87J0askfMuGAwd14IiQ7MDMrsLIOUmqpWlIV18xaol5A8uHgQU6uorU9ZotH7l74KH/x8XD8OQS2klKmV9TBmHp2jqEfzC7c/pp10A6VgT1qCILk70x+xhha//WZZyqv4hpzYEWPYUtarvvzlmIzZj5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 32B71140220;
	Mon,  5 Jan 2026 17:15:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7A54F20027;
	Mon,  5 Jan 2026 17:15:49 +0000 (UTC)
Date: Mon, 5 Jan 2026 12:16:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yao Kai <yaokai34@huawei.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, <rcu@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Shuah Khan
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Tengda Wu <wutengda2@huawei.com>,
 <liuyongqiang13@huawei.com>, <yujiacheng3@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <20260105121611.470294d3@gandalf.local.home>
In-Reply-To: <34ff0ff6-217e-4574-a3b1-af74b2f40937@huawei.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
	<20260101163417.1065705-2-joelagnelf@nvidia.com>
	<20260102122807.7025fc87@gandalf.local.home>
	<20260102123009.453dfb90@gandalf.local.home>
	<68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
	<252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
	<34ff0ff6-217e-4574-a3b1-af74b2f40937@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bojkfu6sef3sp1fn4ce1uayiebrkwyxn
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7A54F20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fzIDrlSXVZ9QJZI5xu53yQ0GLhBXbUuw=
X-HE-Tag: 1767633349-836369
X-HE-Meta: U2FsdGVkX18IrKdZUeho2SOfke+R7g8EzvppcaKgp3oK21dmdorGJ939vVTAXb22/1UqSNTPYvftzQHeigSk1HLeGtPthSq9CXtIPiUMliELrwpDssomD8A1/H6Bq5Oy00V5CKHSfkfpzUOPXP4on2P3IcUy40ioCRiNIwTnaYKuFyXca7qeZMuXorKymLL2B0fP1B8QZUUh/QpOUI5WCc5U0wQVU8p922IxhUNrZw7g8tr4kodcKe7XK/VzKBlcf4sZ0iESM3bIviFElY5NSBBzqnDdJtC2ZdzSHbly5xonnXnxcCUyjH2smBz3rBHXpAnYlh958yQBQ6ILfJMwHTcq8EzK+mIz8O3vUkfhlP7l2kLTMXVenw==

On Sun, 4 Jan 2026 11:20:07 +0800
Yao Kai <yaokai34@huawei.com> wrote:

> Yes, I tested Steve's patch. It fixes the issue too.
> 
> Tested-by: Yao Kai <yaokai34@huawei.com>

Thanks for testing. I'll send out a formal patch.

And yes, I agree we should do both.

-- Steve

