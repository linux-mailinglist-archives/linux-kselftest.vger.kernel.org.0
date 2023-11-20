Return-Path: <linux-kselftest+bounces-323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9347F1472
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400A4281597
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E81A728;
	Mon, 20 Nov 2023 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nhkh5mfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6352191;
	Mon, 20 Nov 2023 05:30:54 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rcn)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B1C96602F1D;
	Mon, 20 Nov 2023 13:30:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700487052;
	bh=iuC8R+5m6mgEX//giJTOK5COwXslXfrFu1ShOiauqs4=;
	h=From:To:Cc:Subject:In-reply-to:Date:From;
	b=Nhkh5mflnbq9vD2Ip8UWv6EX+Mm+PUlWDxy0xMtcWSp3lfe3tTaz8lPAH4RuZXmkc
	 CMru9KJ5wnuHIyS9d5NfliuoU4k+3bQUPbDYt04unu3xC1dMn8EZvak0atj2G/Uj+a
	 oOJEUFhVqJnyoHsOoZV3FGF2JD7EhZfdDfUOmR+2s0YtufNojMakFi2hy/pTO3w1CR
	 p1g2x+dBCZ9DXWqoPAKg5OGwNPs3RDsanXBPAO5+34ORFBfRA6guYf//WPIHldF2G3
	 YnH1wVhP8nyRkE89MUMDWl4iOzbMB/KwkTqyQ6OLU8np/bcWh4Oq9JM+OhE0b1cbNb
	 INkpv2IM0goZg==
From: =?utf-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org,
	joe@perches.com,
	apw@canonical.com,
	tytso@mit.edu,
	davidgow@google.com,
	rostedt@goodmis.org,
	broonie@kernel.org,
	skhan@linuxfoundation.org,
	djwong@kernel.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	vkabatov@redhat.com,
	cki-project@redhat.com,
	kernelci@lists.linux.dev,
	Nikolai.Kondrashov@redhat.com
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
In-reply-to: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com> (message
 from Nikolai Kondrashov on Wed, 15 Nov 2023 19:43:49 +0200)
Date: Mon, 20 Nov 2023 14:30:49 +0100
Message-ID: <87sf50imba.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nikolai,

On mi=C3=A9, nov 15 2023 at 19:43:49, Nikolai Kondrashov <Nikolai.Kondrasho=
v@redhat.com> wrote:
> Introduce a new tag, 'Tested-with:', documented in the
> Documentation/process/submitting-patches.rst file. The tag is expected
> to reference the documented test suites, similarly to the 'V:' field,
> and to certify that the submitter executed the test suite on the change,
> and that it passed.

I think the 'V:' field in MAINTAINERS is a good addition to document
what developers are supposed to test for every subsystem, but in the
case of the per-commit "Tested-with:" tag, I think the real value of it
would be in using it for accountability and traceability purposes
instead, that is, to link to the actual results of the (automatic) tests
that were used to validate a commit.

This would provide two important features:

1. Rather than trusting that the tester did things right and that the
   test environment used was appropriate, we'd now have proof that the
   test results are as expected and a way to reproduce the steps.

2. A history of test results for future reference. When a regression is
   introduced, now we'd have more information about how things worked
   back when the test was still passing.

This is not trivial because tests vary a lot and we'd first need to
define which artifacts to link to, and because whatever is linked (test
commands, output log, results summary) would need to be stored
forever. But since we're doing that already for basically all kernel
mailing lists, I wonder if something like "public-inbox for test
results" could be possible some day.

Cheers,
Ricardo

