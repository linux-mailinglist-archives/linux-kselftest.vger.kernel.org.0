Return-Path: <linux-kselftest+bounces-1204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF7805E38
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42941F21503
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E568B7F;
	Tue,  5 Dec 2023 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Fo+15sbo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847DB0;
	Tue,  5 Dec 2023 10:59:37 -0800 (PST)
Received: from localhost (boingo-wire.bear2.houston1.level3.net [4.2.233.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0B05E60A;
	Tue,  5 Dec 2023 18:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0B05E60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1701802776; bh=0ncyxIjUSJwIksl5e6cUcciHfHgKyC4e8TX9/ruSMGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fo+15sbowo8yomUr6wIBKTEQmL3TtCRvRu4rKB4onthQaHuTh1/fMjz1EDhU/YWvV
	 IIrYYDAln9mdLFOp3arOwT1B5YysamfQaAC4sD+Qkq7ZDNm50ipFcTOdzQ5AXguxGI
	 /LgSIG69By2FT41eauThdhJCGhpOZOZryJlCplRTINzomPr6vzAvSz2/ywEUrKAl4X
	 pHCwUyqBO95sRX3Ra0e5tXOa4s/rzd167WA2MuphIKPPxWhxXaAK5XAHgqr4tvj16x
	 2zME5hlJlAK6vXMJrqv1KY11YhlML2vZx34I2sriy8KH0UzwA+ugsoXBj1kaqXula/
	 V0FDF2SN524jw==
From: Jonathan Corbet <corbet@lwn.net>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>, Andy Whitcroft
 <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>, David Gow
 <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Darrick J .
 Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev, Nikolai Kondrashov
 <Nikolai.Kondrashov@redhat.com>
Subject: Re: [RFC PATCH v2 04/10] docs: submitting-patches: Introduce
 Tested-with:
In-Reply-To: <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
Date: Tue, 05 Dec 2023 11:59:35 -0700
Message-ID: <87zfyomq5k.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> writes:

> Introduce a new tag, 'Tested-with:', documented in the
> Documentation/process/submitting-patches.rst file.
>
> The tag is expected to contain the test suite command which was executed
> for the commit, and to certify it passed. Additionally, it can contain a
> URL pointing to the execution results, after a '#' character.
>
> Prohibit the V: field from containing the '#' character correspondingly.
>
> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> ---
>  Documentation/process/submitting-patches.rst | 10 ++++++++++
>  MAINTAINERS                                  |  2 +-
>  scripts/checkpatch.pl                        |  4 ++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

I have to ask whether we *really* need to introduce yet another tag for
this.  How are we going to use this information?  Are we going to try to
make a tag for every way in which somebody might test a patch?

Thanks,

jon

