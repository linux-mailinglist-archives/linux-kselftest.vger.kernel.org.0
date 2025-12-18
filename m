Return-Path: <linux-kselftest+bounces-47719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CECCDED6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 00:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0530D301A1F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7827B34F;
	Thu, 18 Dec 2025 23:25:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53597213254;
	Thu, 18 Dec 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100345; cv=none; b=QouVVD2dmvGSM3YA3kMdfa4Vx6mMSucyqLtjOZ+mJ2mHp623nr8hI2kiaReehjasE8iUGAh31ItB7kxZDYFYFOVmQybB0d3IQh/JfrASfnpqlJrlxOuSf7YU9zBatt1rmnWnx6uGosZR3UV53K6BLP+Z/c8mJmJJQsSCMTGusyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100345; c=relaxed/simple;
	bh=OTn671XMgYuXjAtnUcouOHCMitNC0bXt4nM0sMJU4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY5sP8vGxSibvmc7jQz0ELD+7LZZqY64F+Xl0HdsFIKnaMvjoyhtyz3JlUikVPdwAUZe/HcD+YQCrGsvL//9EFpdj4Hp5xpXlgb/5nSXkJ6Doj9vFI85uH2Ae7nGEGNUmj7HbKfRmVhZckcY+v00p2Yb7huT53PgiLimwEnDYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F18381A035A;
	Thu, 18 Dec 2025 23:25:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 17EA22002C;
	Thu, 18 Dec 2025 23:25:40 +0000 (UTC)
Date: Thu, 18 Dec 2025 18:27:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yipeng Zou <zouyipeng@huawei.com>
Cc: <shuah@kernel.org>, <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off
 names
Message-ID: <20251218182719.34334341@gandalf.local.home>
In-Reply-To: <33503bb2-6248-426b-a614-9f0f92899d70@huawei.com>
References: <20230818013226.2182299-1-zouyipeng@huawei.com>
	<20230821111358.7540bdc9@gandalf.local.home>
	<33503bb2-6248-426b-a614-9f0f92899d70@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: z8iwgyjtbn8s9fipu51d75domkjz3ac5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 17EA22002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rbHhhFT6vuGi4TD5NE6/HgwQO9BitxFY=
X-HE-Tag: 1766100340-759922
X-HE-Meta: U2FsdGVkX1+lrM8Z9kYuFzTy5vrZ+uLkrs/ZFs4qN5kEHY0wmObHdpOQjxwSpJ6NtAvUwHuGEGQolqpxpL4iGILlSxGW4N8OIoVx6dnYQYUDAf5D/RyP7AsvTY0P5HHqRJcKA79NlfPTeJCNs1jG8cdo2hopJ+mA4nc6Z35sZkCwiFeuDiq9AarKMJBlnkyK7wI+lDcfXYbZLdNENd9y/F34W216C9bDJdWNG3Luyl4yZYtpr0XmaAWiyCjRSUPJp1mhNep5W2NL5KL7yPpzX6btfBbU602ciDQEnPr5TcusgxajazWX8fEMjT9ksQooPuOmQrmNVOcl3PQPyEVKVeK7Cu93NAKGJflClz3bAYEt/tYC+bqHFHFzl97xStftXdmPDVIpOHK/o6KvCQM44A==

On Sat, 13 Apr 2024 10:47:14 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> =E5=9C=A8 2023/8/21 23:13, Steven Rostedt =E5=86=99=E9=81=93:
> > On Fri, 18 Aug 2023 09:32:26 +0800
> > Yipeng Zou <zouyipeng@huawei.com> wrote:
> > =20
> >> The func_traceonoff_triggers.tc sometimes goes to fail
> >> on my board, Kunpeng-920. =20
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >
> > Shuah, can you take this through your tree?
> >
> > -- Steve =20
>=20
> Hi:
>=20
>  =C2=A0=C2=A0=C2=A0 I just notice that it haven't been picked in Linux-ne=
xt.
>=20
>  =C2=A0=C2=A0=C2=A0 It's there other issue about this patch?

Wow, this is a couple of years old (noticed while looking at the archived
patches in patchwork).

Shuah, I believe this is still needed.

-- Steve

