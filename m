Return-Path: <linux-kselftest+bounces-1377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80953809125
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2BD1C20AD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06484F614;
	Thu,  7 Dec 2023 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QcfKhdrk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E021708
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 11:19:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so1830172a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701976788; x=1702581588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqNljMeu10jeQo935R54vZ6RNgIIhYo8bGwZuNpxXu4=;
        b=QcfKhdrknHq8e6jK6RVLpxIGMtEh7bCRxkfJFFg5kjvaeiXjFg+WIT6EzbRai7Eq7q
         r2bDCOZsmmu+/wr+kcgK1uRu/bKZESakMzqjTyV7Io12elmmJZjpzowz/LwYzfp5KNEW
         Cp7cDjL7P2xTkK8clrdEpOQcPqcKaI/rrU0DDSZzsw+iGJeM32N5Vgs37jE4EU3Uh27k
         AtV9bi56iRbpf4ly/ptViDC9Eb+CYLZoFugkqG76oemY7EwcqKbfOPs5NJ8HdxKd7v9g
         N7Wu/HEZmRKwueGf7mj4Q5rFbrRWnfVqb7ui7JAkq/Wk/v1lfIm0EvBQeVEOzxNMopX+
         Folg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976788; x=1702581588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqNljMeu10jeQo935R54vZ6RNgIIhYo8bGwZuNpxXu4=;
        b=bTUih7hM5X0n4b7NXRgccUyFwHIlfSQI7I/ZwiesfnaR9jkPwjYNHg8OXkH+lgsDII
         QEn5vRGhiLZ1cZMsv6YkVVfO5x4717qVlh6EpDqsqVb7dOVbDllmZVgHlWl8EkIgZy5s
         z0e6/jmJr1T8tddnIEgMyxsLaDDdok3qvp19GiuwcKdTGc7KSe6hBKXAQaGPWHSuIKe3
         BA//IpSsK8qLXd3CeJlx2mW+DvqmxL3j3AbIun/VHRzv2bYOA04aaInosu76ig34Tyum
         c3TiACaanK1lZH7xNcDkizLIAkiBYIuumuqu+G8llA7i7aKww1tXoBMebBUW/cFuT2jp
         qUPQ==
X-Gm-Message-State: AOJu0Yy4FPzWZZ9T5OzIY680eu6tfXJhP5/YPIaY8bZelkNbBdWd/jvM
	BGJocJ9+LeVJF7tnZPu1juJ5zV8YQ7vC6rMXtgA=
X-Google-Smtp-Source: AGHT+IFBIOm0w6M5xLYQMgu5ASfsSFBsRFtnFH6mDk0C8McQSxHcLqmHPgbqxDhYSlhlK7QDsnXq4Q==
X-Received: by 2002:a17:906:a84d:b0:a19:a19b:4268 with SMTP id dx13-20020a170906a84d00b00a19a19b4268mr1051351ejb.211.1701976788270;
        Thu, 07 Dec 2023 11:19:48 -0800 (PST)
Received: from ?IPv6:2804:30c:915:cb00:89a8:6d94:ec55:e0a3? ([2804:30c:915:cb00:89a8:6d94:ec55:e0a3])
        by smtp.gmail.com with ESMTPSA id sa25-20020a1709076d1900b00a1d8626d650sm97674ejc.208.2023.12.07.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:19:48 -0800 (PST)
Message-ID: <57fb9f30afbaddb09def96aac11c45296a59a277.camel@suse.com>
Subject: Re: [PATCH v3 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
From: mpdesouza@suse.com
To: Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Petr
 Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org,  live-patching@vger.kernel.org
Date: Thu, 07 Dec 2023 16:19:32 -0300
In-Reply-To: <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
	 <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com>
	 <ZWn7dEzVWoKxycmy@redhat.com>
	 <alpine.LSU.2.21.2312061543280.13051@pobox.suse.cz>
	 <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 10:20 -0500, Joe Lawrence wrote:
> On 12/6/23 10:05, Miroslav Benes wrote:
> > On Fri, 1 Dec 2023, Joe Lawrence wrote:
> >=20
> > > On Tue, Oct 31, 2023 at 06:10:52PM -0300, Marcos Paulo de Souza
> > > wrote:
> > > > The modules are being moved from lib/livepatch to
> > > > tools/testing/selftests/livepatch/test_modules.
> > > >=20
> > > > This code moving will allow writing more complex tests, like
> > > > for example an
> > > > userspace C code that will call a livepatched kernel function.
> > > >=20
> > > > The modules are now built as out-of-tree
> > > > modules, but being part of the kernel source means they will be
> > > > maintained.
> > > >=20
> > > > Another advantage of the code moving is to be able to easily
> > > > change,
> > > > debug and rebuild the tests by running make on the
> > > > selftests/livepatch directory,
> > > > which is not currently possible since the modules on
> > > > lib/livepatch are
> > > > build and installed using the "modules" target.
> > > >=20
> > > > The current approach also keeps the ability to execute the
> > > > tests manually by
> > > > executing the scripts inside selftests/livepatch directory, as
> > > > it's currently
> > > > supported. If the modules are modified, they needed to be
> > > > rebuilt before running
> > > > the scripts though.
> > > >=20
> > > > The modules are built before running the selftests when using
> > > > the
> > > > kselftest invocations:
> > > >=20
> > > > 	make kselftest TARGETS=3Dlivepatch
> > > > or
> > > > 	make -C tools/testing/selftests/livepatch run_tests
> > > >=20
> > >=20
> > > Quick question:
> > >=20
> > > - We have been building with CONFIG_LIVEPATCH_TEST=3Dm to generate
> > > the
> > > =C2=A0 test modules at kernel build time
> > >=20
> > > - Our packaging filters out the selftest scripts and supporting
> > > modules
> > > =C2=A0 from the general kernel RPM package into their subpackages
> > >=20
> > > - Tests are run as part of CKI or other manual tests by
> > > installing the
> > > =C2=A0 pre-built packages from the previous step
> > >=20
> > >=20
> > > After this patch, we would need to add something like the
> > > following to
> > > our kernel build, before packaging:
> > >=20
> > > =C2=A0 $ make KDIR=3D$(pwd) -C tools/testing/selftests/livepatch/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^
> > >=20
> > > If this is the correct way to build the test modules for *this*
> > > tree and
> > > /lib/modules/$(shell uname -r)/build... it might be useful to
> > > document
> > > in the commit message as an alternative use case.

That's right:

$ make -C tools/testing/selftests/livepatch/

is indeed the way to build the tests without running them. KDIR will be
set to  /lib/modules/$(shell uname -r)/build is empty.

Yes, I can definitely add documentation about it inside the
tools/testing/selftests/livepatch/README.

> >=20
> > So if I understand it correctly, you would like to stick to pre-
> > building=20
> > the modules (not in-tree but now after the kernel is build using
> > the=20
> > proposed way), package them and then install everything on a system
> > running the respective kernel. A valid use case in my opinion.
> >=20
>=20
> That would accurate.=C2=A0 If this use case can be supported, it wouldn't
> require changes to our CKI / testing scripts, only the post-build
> packaging bits.
>=20
> > My idea is to abandon this way completely, take the selftests and
> > build=20
> > and run them on the system right away.
> >=20
> > Both should be doable, hopefully, if we wire it all correctly...
> > and=20
> > document it.
> >=20
> I can't think of why it shouldn't continue to work, even in a future
> where newer livepatching selftests support older kernels.=C2=A0 (We would
> just have newer selftests sources backported to test older kernel
> sources.)
>=20
> Are there any test cases which truly need to be build on-the-fly?=C2=A0
> Aside
> from testing different toolchain pieces?

We would like to use the same selftests to trigger testing on different
kernels (adjusting it when necessary as you stated), without having to
rebuild the kernel. Miroslav may have other ideias about it too, IIRC.

>=20


