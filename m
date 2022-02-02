Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259D4A716F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiBBNWX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 08:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiBBNWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 08:22:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4CC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 05:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9E98B830B5
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 13:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDB0C004E1;
        Wed,  2 Feb 2022 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643808140;
        bh=EIsy59d1uU8qIkHRTPbxWJ+X7di+dVj1ejfu0IGcmgI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XDGq5Tr5MAq0a0JKJvcH5Zn8sH8Xqw2qOa92N0tggelBYIw/M8SPycusVy5/Mk/sL
         wviU45rkpSyTSeRiGryd4ZnUxsAeJmLmtpQ3r7X5B9WAnuUQDwNYghS4XMWBjbMvnM
         CCBaNy7Vf6Nd8CgKpqMlc+Dnc1GlZdNflivxi2T1VD86btEjglnxffLX+bjcFVHwwf
         ZtUaap+jr7CiMnzintfCj577vX754KnmUiNjT40LjBjUZhzTTq4zmOOGIj7YGdl9YH
         cIJnqSKX4rYGQb15nbwnOV6b7OA3VaJcvYT0odZIt7L6m2noqyCsVAyRw7b6alE7mH
         sLAzJn2lI+ceg==
Date:   Wed, 2 Feb 2022 13:22:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: Check for event generation when we
 write to controls
Message-ID: <YfqFiIHaPnvY1+W7@sirena.org.uk>
References: <20220201151551.21497-1-broonie@kernel.org>
 <YfnksdOR5HR0mZi0@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HgO9RPne0YIh77zU"
Content-Disposition: inline
In-Reply-To: <YfnksdOR5HR0mZi0@workstation>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--HgO9RPne0YIh77zU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2022 at 10:56:01AM +0900, Takashi Sakamoto wrote:
> On Tue, Feb 01, 2022 at 03:15:51PM +0000, Mark Brown wrote:

> > +		/* The ID returned from the event is 1 less than numid */
> > +		mask = snd_ctl_event_elem_get_mask(event);
> > +		ev_id = snd_ctl_event_elem_get_numid(event);
> > +		if (ev_id != ctl->elem + 1) {

> As long as I know, the design of ALSA control core just exposes the
> numeric identification of a control element issued for notification in
> 'snd_ctl_event' structure. On the other hand, the above evaluation
> expects decremented value against position of queried list structure
> has come.

> I note that current design of ALSA control core is:
>  * 1 is selected for numeric identification of the first element in the
>    first element set added to sound card.
>  * at removal of element set, the series of assigned numeric identification
>    becomes blank (coded as hole).
>  * Userspace application can always add/remove element set to the card.
>  * the position of element in queried list structure does not
>    necessarily corresponds to numeric identification even if decremented
>    by 1 due to the hole.

Oh, I see - we have multiple IDs here which is what's confusing things.
This looked wrong when I was writing it and I was hoping someone would
confirm what was going on on review so thanks.

--HgO9RPne0YIh77zU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6hYcACgkQJNaLcl1U
h9Aq9QgAg3UsfWD5fQB5Vf3Si8tYogGNaaVLUNospDpGtveAPqrO+DNnoaS+w/QF
yvoWYUXMzUeaK8TrRgawE3euuxl3BCIDJgnU6PkIVuYYNgrBTo94KAGYku+p5D6X
1/fHCC9wrc5Wpvkh8y23KdKbYecs8QglpZBjsJlTvglsAkpdz/Ss5eVLdYbcvzau
Yb+UcmTg1ajTII6UvVCMM05iSfYCNLdWvCGBrW+rnPumoqs0xblAqfp4txBRjTdv
//viPLYzcxT3rv2pGp8NaUHFRf844UsKuLJ55dj1m6S4oAKiLjz0obTBRbgDlXU+
7WYgz1XxhejKbH8JP12MYMb/7so1FQ==
=3AVw
-----END PGP SIGNATURE-----

--HgO9RPne0YIh77zU--
