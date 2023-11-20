Return-Path: <linux-kselftest+bounces-322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A275F7F13A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC6D1C21511
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6310A3A;
	Mon, 20 Nov 2023 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D813F2;
	Mon, 20 Nov 2023 04:40:43 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
	by madras.collabora.co.uk (Postfix) with ESMTP id 224BD66022D4;
	Mon, 20 Nov 2023 12:40:40 +0000 (GMT)
From: "Gustavo Padovan" <gustavo.padovan@collabora.com>
In-Reply-To: <13fe4866-0522-4690-a060-160fdab9f54b@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date: Mon, 20 Nov 2023 12:40:39 +0000
Cc: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, workflows@vger.kernel.org, "Joe Perches" <joe@perches.com>, "Andy Whitcroft" <apw@canonical.com>, "Theodore Tso" <tytso@mit.edu>, "David Gow" <davidgow@google.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mark Brown" <broonie@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, =?utf-8?q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, "Veronika Kabatova" <vkabatov@redhat.com>, "CKI" <cki-project@redhat.com>, kernelci@lists.linux.dev, kernel@collabora.com, =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <ricardo.canuelo@collabora.com>
To: "Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1341-655b5400-1-5f647c80@80242238>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/3] =?utf-8?q?MAINTAINERS=3A?= Introduce 
 =?utf-8?q?V=3A?= field for required tests
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: quoted-printable

On Thursday, November 16, 2023 09:14 -03, Nikolai Kondrashov <Nikolai.K=
ondrashov@redhat.com> wrote:

> On 11/15/23 22:38, Konstantin Ryabitsev wrote:
> > On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
> >> Introduce a new tag, 'Tested-with:', documented in the
> >> Documentation/process/submitting-patches.rst file. The tag is expe=
cted
> >> to reference the documented test suites, similarly to the 'V:' fie=
ld,
> >> and to certify that the submitter executed the test suite on the c=
hange,
> >> and that it passed.
> >=20
> > I'm not sure it should be a tag that stays all the way through git =
commit.
> > How about making it a cover letter/first patch footer?
> >=20
> > tested-with: <suite>
>=20
> Yes, that would be better indeed. However, checkpatch.pl doesn't proc=
ess cover=20
> letters, and so we would have no automated way to advertise and nudge=
 people=20
> towards testing.
=20
At this year's LPC, there was quite some discussion around improving te=
sting information, so this patch of yours lands has a great timing. :)

All your are proposing here is pretty interesting both for developers a=
nd CI systems, but it seems that a "Tested-with:" tag and checkpatch.pl=
 validation will take quite some time to consolidate.

Would it make sense to split just the part that adds the V: field to MA=
INTAINERS and submit that as separate patchset together with its docume=
ntation? That way we can enable subsystem to start annotating their tes=
t suites already.

I also wonder how to make for subsystems that will have different test =
suites (eg something in kselftests and an external test suite). Would a=
n alternative be pointing to a Documentation page with detailed info?

- Gus

--=20
Gustavo Padovan
Kernel Lead
Collabora Ltd.


