Return-Path: <linux-kselftest+bounces-45085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716AC3FD4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 13:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B67C3BBDC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E32798ED;
	Fri,  7 Nov 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jiP0aSTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AC45C0B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516868; cv=none; b=S0M5NYw0ZvKlhRzk+Tg0Tm7peh9rTrgN0qQWPKKSfS2LsBws8osNJ9HoGrMkk6n7K5qhu/1cMnoga1y0p1zEfT5vD2IY6CHvZlieZ2imF2zqe93uh+BhIJRg+vZLMi1sz0wJiQmhyUFZoOVla3uIeUDjm5fGvV5CDrxQ9jR3giE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516868; c=relaxed/simple;
	bh=53FxiJ2qQpY1dafOedja4bq8nuIV5SHVfyMnsMguH1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=La4HYWnVrjRwMdgHTpgbwqNuYBAKfrgwA6BFi150435dI7p4e1LQddGJi6ApWT6s/GpaHEnOKydzhHSsR4tyDYTdBEyw5AGf90zeGZ3m1fqReqv8hgH+QzRaZyPI4MA0scPaQ0OM32EurBRSxr31MZI1ycRdiUUXQjMVPSOlK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jiP0aSTQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so1144429a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762516864; x=1763121664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUsVfRHnhaTc6L0mfrJ+S8eMrRvLqjKV9gyOwEzhVzo=;
        b=jiP0aSTQhjUnZZiq/Imd+J35NHxKl3C3rZ420Tufrz3qqJInPyaOMzu++ms2YSVRmT
         Zw9W0Km8UR5lIJsZoGhB193gQ2Ugoi1LFonVe9eam6aVzHqTWsv9rpIzBqa9N+EVqen+
         JkImJ7NEdlTk4TZJxhHsg0NfOi2l45JxVa2ihjBbH9kDWvCO5M8+4DUaIr+RXmDDwDbp
         sAPu/eIzaQLfQcZZlTgr9gPoKn/LYIL9Z9fgHR+65O4Y3oyoO4hERctncBr42mikwJ+R
         PtoytRv6/1IqLJDkk2X/m/nZ4sFFR5uXBubyeKXtvMkSgaXlNyBhA8IRhSQNJpLa2exx
         uISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516864; x=1763121664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUsVfRHnhaTc6L0mfrJ+S8eMrRvLqjKV9gyOwEzhVzo=;
        b=f+Kqh5xZqdCAgkk5wDiBj5C4OKwMrkwUxLl6Yk0DCyxzq8zWsA50hjxU5j+3Tlmwc6
         CztkWKg3dC0vBorC+/7Jn5kgMak6UElDj6QpChoeWVttrP2owlqgiicvNXiMt+b+Ah77
         +hTLuoJOn9Os2VWm8IrHt/eECdfnNX4MMjvQT499+dfxzjCsNG34ZEFlU/6JKgpm3KWN
         HuYhCYHNycwvK1nRHjzch9hJgyNzbfR14XMcbSS2aDx81Y6UTfFWcCA4dgSh1f2PVf3k
         +PWb9LpDXiLaK0AHEkq0JpR4bLgmLz+rAL/0JkRJDt56ggbmChY20uK7BN7UoT590q9J
         4Z0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOE8uY/YPai2Z6VJ3DJNk2CrB6Cj5SBmPz8IbANsZGzXuDbSl+mxtfGrSsl8FfHuoeabX3B0xkA+r+KmVCMHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/8H2lHxDtcAfphGkY2EGRjzI45fvULnqca0KD5RkOS0M/ZP0J
	dGBcXSi98BZqY+3HXLRzOJ54NlbCEC90HGce8XBJENQaP/nPby/W9zH6Znyc4re3BkEeq6iMINN
	5tXn2fbm2ln9W2hKcjbmO4lDGcULrzXrHIP87936/8Q==
X-Gm-Gg: ASbGnctlcgVUwIPfh8Njg1UjwPbyCN45e3SbPvpMBGkPZMvYEaoEl/W2loMOptjrqwS
	O3KclgKJmbBTVKkRfUHypw/rcF0ATDIkuymFkTq29OY/6KU6BRWda35oTgTy/ZlSCzNGu2pqVNP
	ym+CNEzizQEz04C7dp3pcdk76Oeb/l3kEcm4jnnd7RGaAAJJUsZvosZ1ppj3Ty4eR/4fDvvi3O3
	UpwnQgTU1fRiBVZxyC5+BlNOIiOTtdX0KBnuDgJKZN97KeZXhz27QCgSrivJKFgApOR
X-Google-Smtp-Source: AGHT+IF9pn2F0a39L7q6vQA1QNL5mEmZPkN59pguhs34CMH4Kd6QJlTFZpAj3QhY1fmeJmLCWP6NNkx5xTN4CeVBEd4=
X-Received: by 2002:a05:6402:518b:b0:640:9b62:a8bb with SMTP id
 4fb4d7f45d1cf-6413f063ab1mr2470983a12.22.1762516863928; Fri, 07 Nov 2025
 04:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
In-Reply-To: <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 7 Nov 2025 07:00:27 -0500
X-Gm-Features: AWmQ_bkI8wIkZ7GC8hYGylBjaXrBxtU3ZeBWwhoHk2_ITShMsozqrZ6SHuSvZSc
Message-ID: <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi, Pasha
>
> In our previous discussion, we talked about counting the number of times
> the kernel is rebooted via kexec. At that time, you suggested adding a
> variable in debugfs to keep track of this count.
> However, since debugfs is now optional, where would be an appropriate
> place to store this variable?

It is an optional config and can still be enabled if the live update
reboot number value needs to be accessed through debugfs. However,
given that debugfs does not guarantee a stable interface, tooling
should not be built to require these interfaces.

In the WIP LUO [1] I have, I pr_info() the live update number during
boot and also store it in the incoming LUO FDT tree, which can also be
accessed through this optional debugfs interface.

The pr_info message appears like this during boot:
[    0.000000] luo: Retrieved live update data, liveupdate number: 17

Pasha

