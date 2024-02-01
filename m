Return-Path: <linux-kselftest+bounces-3914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B4844EE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 02:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAC71F29047
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0978EEBB;
	Thu,  1 Feb 2024 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="chRM3vKP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEBCA42;
	Thu,  1 Feb 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752551; cv=none; b=DyvNUG4dx4eCxNPvs+NLm9KvoRcKFLXAeuk8hibsNFx6cT5Q0MqYHt9ZI8F5u+bdQOH9IIYoCD3A/EwPks0dVuF0Y0tv8LwqwyswxIe+J2CLc/VYelm0l9eXMZKRAxyq0ZQurW4FrjDNiTf1RTjV78wG3sgrvXVlohgCh7xX+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752551; c=relaxed/simple;
	bh=FAb1xu7N0mD7fB4oPNkaXK9r+LVVO3hmEBonp6dyuIM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=POJe9a4CRdLaSvh22dWpnkaw1FUOYWwf2aVsSWKrJJuTOkcnS1KC407wBs1OA9kcu7b2sfeFib64yixPxwkQAa5sc+IaPC9vA/x3GXtM7/wX1R5ZHvAPp2N2DUGIbgbH5/CPZcuDRCY8vxGN6/Cu4mqDdbDQe7E6+s7bF6xca8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=chRM3vKP; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=FAb1xu7N0m
	D7fB4oPNkaXK9r+LVVO3hmEBonp6dyuIM=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=chRM3vKPnLKjxR1g/l1bvuZA5Er+nt+s5
	2B8DcLvp2JUGv7M17p4P31I3B5oOkWjH0yVjdqbyM4OKo2EQAYAzgIGS6KsuxrvaCC3mmR
	iF/VFrsZeU2KoyOfJwB156nIKcI8UudZTA3/Zhjk2cN65GWKn1hj68PjdKHOWM0kgyA8MZ
	8JX7WksOgv8/az9KcBUQxYFHILw/hCwrO82C6GLGaO/b/wALOVh210+AjKpSyE8yct9zD7
	2i5pgl6NJsrcv+NAS6r1ugU0dh/+4t0PX5i+X07FzxRdQHZ9z+Qocd6q8N8AWUFH5VDKuu
	8HmwCLCvTip5rA41MiXEhwk61X/VA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 4380a574;
	Wed, 31 Jan 2024 18:55:48 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Wed, 31 Jan 2024 17:27:11 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22279.1706752548.1@cvs.openbsd.org>
Date: Wed, 31 Jan 2024 18:55:48 -0700
Message-ID: <44005.1706752548@cvs.openbsd.org>

I'd like to propose a new flag to the Linux open() system call.

It is

   O_DUPABLE

You mix it with other O_* flags to the open call, everyone is familiar
with this, it is very easy to use.

If the O_DUPABLE flag is set, the file descriptor may be cloned with
dup(), dup2() or similar call.  If not set, those calls will return with
-1 EPERM.

I know it goes strongly against the grain of ancient assumptions that
file descriptors (just like memory) are fully mutable, and therefore
managed with care.  But in these trying times, we need protection against
file descriptor desecration.

It protects programmers from accidentally making clones of file
descriptors and leaking them out of programs, like I dunno, runc.
OK, besides this one very specific place that could (maybe) use
it today, there is other code which can use this but the margin is too narrow to contain.

The documentation can describe the behaviour as similar to MAP_SEALABLE,
so that noone is shocked.

/sarc

