Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE146DB4E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhLHSnb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 13:43:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60896 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhLHSna (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 13:43:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0CE3B82249
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 18:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EF1C341C7;
        Wed,  8 Dec 2021 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988796;
        bh=qg7tK4XkdsAtUIRtwJYp+FmwaKvcGXkqB7uE9WmRf7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAHWuE5XulXWELwI5J1v+8rJRzYLKu/th6ertmSRihsiV2kS6Hry3bVhQRNAAV3NU
         zA64K9U0QwdL+Nb0IVcCEnOGxWCCahXJlo2qf0SpNpYUGY5OetqE1P3HF8GuCCCyml
         vcEJCA+OHwsU4Prpkl28xyFFVoxedEhRs/yjrwJCN/JapfnVOWD5d9f2t05OVRNtxD
         FqJQyJw9t9O9hcEjHBaOsZiQQs2yJOA7bi+qdN194wXOgO1a2PRNje4bxZ+TBabqm5
         iT0sKPrbhiuROdJk8MGE7LZHIWfu5839e6AmoFsTx3KTkCzn4XaDCYUysLOF1u68dp
         3k7/K9wso9IdQ==
Date:   Wed, 8 Dec 2021 18:39:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <YbD7+C74DFlZEokt@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <de0c5677-c2cf-d1ab-68c5-2f410d17b66c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aRILJPDDQZM38Bc7"
Content-Disposition: inline
In-Reply-To: <de0c5677-c2cf-d1ab-68c5-2f410d17b66c@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--aRILJPDDQZM38Bc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 10:42:35AM -0700, Shuah Khan wrote:
> On 12/6/21 9:03 AM, Mark Brown wrote:

> > +SOUND - ALSA SELFTESTS
> > +M:	Mark Brown <broonie@kernel.org>
> > +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)

> Please add linux-kselftest list as well here.

get_maintainers pulls it in from the wider entry (the mention of
alsa-devel is reudnant too).

> > +int num_cards =3D 0;
> > +int num_controls =3D 0;
> > +struct card_data *card_list =3D NULL;
> > +struct ctl_data *ctl_list =3D NULL;

> No need to initailize the above globals.

They're not declared static so the initial value is undefined.

> > +void find_controls(void)
> > +{
> > +	char name[32];

> Use SYSFS_PATH_MAX =3D 255 like other tools do?

This isn't a path, it's an ALSA limit for a name that is embedded in a
struct (snd_ctl_card_info->name).  There's no magic define for these
lengths.

> > +
> > +			ctl_data->next =3D ctl_list;
> > +			ctl_list =3D ctl_data;
> > +		}
> > +
> > +	next_card:

> No need to indent the label

No need but it looks wrong otherwise - it's certainly what I'd expect
for normal kernel code.

> > +	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
> > +		ksft_print_msg("%s is inactive\n", ctl->name);
> > +		ksft_test_result_skip("get_value.%d.%d\n",
> > +				      ctl->card->card, ctl->elem);
>=20
> The two messages could be combined?

The user facing control names almost always have spaces in them so while
it's useful to have them for diagnostic purposes I don't think it's a
good idea to put them in the KTAP test names, that's likely to confuse
things trying to work with the KTAP output.  The general pattern I'm
following for these tests is to print one or more diagnostic lines
explaining why a tests was skipped or failed with the human readable
control name so people can hopefully figure out what's going on and have
the KTAP facing name that tooling will deal with be a consistent
test.card.control format for parsers and databases dealing with test
results en masse.

> > +bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
> > +{
> > +	int err, i, j;
> > +	bool fail =3D false;
> > +	snd_ctl_elem_value_t *val;
>=20
> Add blank line after declarations.
>=20
> > +	snd_ctl_elem_value_alloca(&val);

This is idiomatic for alsa-lib code.

> > +int main(void)
> > +{
> > +	struct ctl_data *ctl;
> > +
> > +	ksft_print_header();

> Add a check for root and skil the test.

There is no need for this test to run as root in most configurations,
it is common to provide direct access to the sound cards to some or all
users - for example with desktop distros the entire userspace audio
subsystem normally runs as the logged in user by default.  alsa-lib's
card enumeration should deal with any permissions problems accessing
cards in the system cleanly.  If the user running the test can't access
any cards or the cards that can be accessed don't have any controls to
test then we will find no controls during enumeration, report a plan to
do zero tests and then exit cleanly which seems reasonable to me.  If we
do need to explicitly bomb out rather than report zero tests we should
be doing it based on the number of controls we find rather than the user
we're running as.

--aRILJPDDQZM38Bc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGw+/cACgkQJNaLcl1U
h9ATXwf/RFucHFfZAKm1nsoZEt1MUBOS9jAryVUkGvnvwmoNV+DO2DrnD0dPFQf3
LU3JcjG+IXSQbI0sHEjXAeRz3jR7q58OwcR8Bsd64Bl7znV380FF4bIThuMXy4D5
q1LhgRWA7jCl5t1zChQBoFasomX6QsympY7wmW39IEX5Lu5e/91flf1udLHYGiQe
c9Dgk+7/bO1I45j/ajRNgu6Vsx59mk4E7s45FkPYPPRSkhX8OFGho4yDYEgJsWNn
/xZDb8evoq/r0c2Tthuhozsg0o7JqJz+yD6/CzeBvfFCOeWuu2t5XKNq8nFE7Qbm
5tUFrgwJc6mt/skc34LwU/lXNhP/eQ==
=AFXz
-----END PGP SIGNATURE-----

--aRILJPDDQZM38Bc7--
