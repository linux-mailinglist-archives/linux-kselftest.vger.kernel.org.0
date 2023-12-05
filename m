Return-Path: <linux-kselftest+bounces-1206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19E805E56
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168591C21089
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AD68EB5;
	Tue,  5 Dec 2023 19:07:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFEC6;
	Tue,  5 Dec 2023 11:07:11 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 8EAE680216;
	Tue,  5 Dec 2023 19:07:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id A9AD62000E;
	Tue,  5 Dec 2023 19:07:03 +0000 (UTC)
Message-ID: <fcc8a2d856dda4afbc85e70a36fc9ea903adc922.camel@perches.com>
Subject: Re: [RFC PATCH v2 04/10] docs: submitting-patches: Introduce
 Tested-with:
From: Joe Perches <joe@perches.com>
To: Jonathan Corbet <corbet@lwn.net>, Nikolai Kondrashov
	 <Nikolai.Kondrashov@redhat.com>, workflows@vger.kernel.org, Andy Whitcroft
	 <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>, David Gow
	 <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, Mark Brown
	 <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Darrick J .
	Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
Date: Tue, 05 Dec 2023 11:07:02 -0800
In-Reply-To: <87zfyomq5k.fsf@meer.lwn.net>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
	 <87zfyomq5k.fsf@meer.lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A9AD62000E
X-Stat-Signature: emow8chkcraonx6hmx9yhg6dhhfzokem
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/qFp5G0qSbmPP6+lif9x4ZnxYocVdXgWw=
X-HE-Tag: 1701803223-598303
X-HE-Meta: U2FsdGVkX18rWUx5pJuurBCzXwT2MwvGCoT8XM14M/m1OUdcltE1S6uGNSIEEKx2c06JZtaxt2aCAAhfOocZPm+5Y7b7g4JqIQdmolt4UdYW/gUpxl3PtVeHg8l90oGvHH8vaRkjTaMZIbAIKao4Iggc73O3he56oU8r2eTO5XTpOXE6mMKo+nGnwDcTtBNEGwZTEkfrTsfoi6PKhUCLI4igKjysMj9v1CkOArML176gVMf2iDxyZlOw4c/0dOiZ3cqopBPH267lCHk3gcB3YXunI4N9vuCQhJ78752iSYWdKRPWkbhnyz9gjZMiw9S32Pzk/RvB4rM35dFyqrrJiI0GTZJ2e8aS

On Tue, 2023-12-05 at 11:59 -0700, Jonathan Corbet wrote:
> Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> writes:
>=20
> > Introduce a new tag, 'Tested-with:', documented in the
> > Documentation/process/submitting-patches.rst file.
[]
> I have to ask whether we *really* need to introduce yet another tag for
> this.  How are we going to use this information?  Are we going to try to
> make a tag for every way in which somebody might test a patch?

In general, I think
	Link: <to some url test result>
would be good enough.

And remember that all this goes stale after awhile
and that includes old test suites.


