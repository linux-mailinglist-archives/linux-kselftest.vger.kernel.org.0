Return-Path: <linux-kselftest+bounces-1300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB6807543
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556DAB20E7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C93DBB7;
	Wed,  6 Dec 2023 16:38:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826FFA;
	Wed,  6 Dec 2023 08:38:21 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 69BADA0B2C;
	Wed,  6 Dec 2023 16:38:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 2D7D832;
	Wed,  6 Dec 2023 16:38:15 +0000 (UTC)
Message-ID: <9b45b0ebce3457c22aa456779aa1a5244b8ef6ad.camel@perches.com>
Subject: Re: [RFC PATCH v2 02/10] MAINTAINERS: Introduce V: entry for tests
From: Joe Perches <joe@perches.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, David Gow
	 <davidgow@google.com>
Cc: workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andy
 Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>, Steven
 Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, "Darrick J . Wong" <djwong@kernel.org>, 
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
Date: Wed, 06 Dec 2023 08:38:14 -0800
In-Reply-To: <f64c8105-5373-4dfb-b48c-655221accd19@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-3-Nikolai.Kondrashov@redhat.com>
	 <CABVgOSnCNJcEfVp_k3emEHziYx55ecNaEj4fsbcfgrsCN4CrNQ@mail.gmail.com>
	 <f64c8105-5373-4dfb-b48c-655221accd19@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: kroygpjwrrhmfbby3zshdpwxhfr9u8nw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2D7D832
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+IOS3ZdHvr8a8X66m+MeCbXCj9j8xWnI8=
X-HE-Tag: 1701880695-471838
X-HE-Meta: U2FsdGVkX18i9DnZhCHnvQ+nJljdsVwmrzI2HxMcynS7xf3zsfDuYLsTd4ARfUueGT4FgzTxg8dPrvvp+OZOvnTI2upgFRqR0ftIipkkxv/hDcb3E5J3XJryckr0JLiQlEWDqEdi5Dqs7Ath/IUl0ujuRCIV9iNzhAw7HRN0d0xcbva6bCQT3WphV8fOTuPXL4svOzF8nXB8c1wKxk+KGUwmxJuaHunoQBtqj011pPDYulj0tUdsJKnxiRzOV8kafwHdZhODfv6+ESFwuYQc9LgI2nNFwmfnLxbp3iZRVCnIsGqQKRpRZN3ovA83UHN+

On Wed, 2023-12-06 at 18:23 +0200, Nikolai Kondrashov wrote:
> On 12/6/23 10:12, David Gow wrote:
> > I'm pretty happy with this personally, though I definitely think we
> > need the support for tests which aren't just executable scripts (e.g.
> > the docs in patch 6).
> >=20
> > The get_maintailer.pl bits, and hence the requirement to not include
> > '@', feel a little bit 'off': I'd rather get_maintainer.pl kept emails
> > and tests separate by some other means (either having --test _only_
> > print tests, not emails at all, or by giving them a prefix like
> > 'TEST:' or something). But that is diverging more from the existing
> > behaviour of get_maintainer.pl, so I could go either way.
> >=20
> > Otherwise, this looks pretty good. I'll give it a proper test tomorrow
> > alongside the other patches.
>=20
> Thanks for the review, David!
>=20
> Yeah, I don't like the '@' bit myself, but it seems to be the path of lea=
st=20
> resistance right now (not necessarily the best one, of course).
>=20
> I'm up for adding an option to get_maintainer.pl that disables email outp=
ut,=20
> if people like that, though.

That already exists though I don't understand the
specific requirement here

--nom --nol --nor

from
$ ./scripts/get_maintainer.pl --help
[]
    --m =3D> include maintainer(s) if any
    --r =3D> include reviewer(s) if any
    --n =3D> include name 'Full Name <addr@domain.tld>'
    --l =3D> include list(s) if any
[]
   Most options have both positive and negative forms.
      The negative forms for --<foo> are --no<foo> and --no-<foo>.


