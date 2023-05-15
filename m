Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1AA70211D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 03:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjEOB2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 21:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjEOB2h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 21:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987AB9;
        Sun, 14 May 2023 18:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E961560B20;
        Mon, 15 May 2023 01:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14340C433EF;
        Mon, 15 May 2023 01:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684114115;
        bh=I20Qcx+0QMlKTWmytfbz1TfDFmdsrpzG804q+DcMxT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1Y2xdQfgmvkV3nlC0SWXnCZv8HEt7Eax23r2n7MNPoTbqzv/MyK3LUaH4mVX9nfx
         +WQQ8nB54nSKvq1alqJITAVnLKiEL59gzUn1tQ4DT3DnCvU+WQyRwne2QkaBN8vvLa
         OIAXkd3qBS/l1upiwA5SBn5NKWo7K0d77fqqUzJN0fyKqdri3RrGPA803A6g8riOtT
         FpHDa+Tmkmkr1ZuLD+LZu8lcg19G+ucHnotuRi5srfdmH75F/m9MIoWJ1cqAXZNyrZ
         MBPgJ3eB5XhqUpwVvtqGhIR8w6JYa8J7WrDw+mOOY/BifTtXRGuJEYqw1PV00I+loP
         zd4xXi4/X080A==
Date:   Mon, 15 May 2023 10:28:32 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: ALSA: Add test for the 'valsa' driver
Message-ID: <ZGGKwA10shGGUr87@finisterre.sirena.org.uk>
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
 <20230513202037.158777-3-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tubSUVrD+xV4Inh"
Content-Disposition: inline
In-Reply-To: <20230513202037.158777-3-ivan.orlov0322@gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7tubSUVrD+xV4Inh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 14, 2023 at 12:20:37AM +0400, Ivan Orlov wrote:

> +uid=$(id -u)
> +if [ $uid -ne 0 ]; then
> +	echo "$0: Must be run as root"
> +	exit 1
> +fi

It is not an error to run the selftest as a non-root user, the test
should be skipped.

> +modprobe snd-valsa

We don't check if the module was already loaded.

> +if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
> +	mount -t debugfs none /sys/kernel/debug
> +
> +	if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
> +		echo "$0: Error mounting debugfs"
> +		exit 4
> +	fi
> +fi

This will unconditionally attempt to mount debugfs in a standard
location and won't clean up after itself, if the system didn't have
debugfs mounted for some reason then this will leave it sitting there.

> +success="1"
> +arecord -D hw:CARD=valsa,DEV=0 -c 1 --buffer-size=8192 -f S16_LE -r 8000 --duration=4 out.wav
> +
> +if [[ $(< /sys/kernel/debug/valsa/ioctl_test) == "$success" ]]; then
> +	echo "$0: ioctl test: success"
> +else
> +	echo "$0: ioctl test: fail"
> +fi

Would it not be better to have a C program that actually calls the ioctl
rather than a custom debugfs thing that may or may not be wired up to do
the same thing as an ioctl would?  It seems like other than whatever
this ioctl test actually does this is all just a simplified version of
the existing pcm-test.

--7tubSUVrD+xV4Inh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRhir8ACgkQJNaLcl1U
h9DDEQf+IjmNUuTXgXNfQLkMLf76FazxTesXhLu7ittBq9lGs7S5/GQaJ8QTMgzC
TddmGnsS6C774id02yqhg4QU04zGQQ66amxkeAcdylaQZlK8e7U4UwKtXHq4UTDU
X79NmH2oYOE6keq6GYZ7r1KsmfOMD0flHA6+vuq2Lak8PEHms/OlHvQtyNmA7DTE
YUYAzmBzh+zGmq5dbWloNGsJgmdgdcXh6x8eIMDiCDiCo4JKekDXNlY0f/G7wLuh
3U5d9Ud/q2VmgXeCMLkCzKR7o9F1p4ym3MLLM2Up9GevfInfJwTih6XyvtW8WKyR
GdU4RbkyizlI7hiqcmOyBJR1b0Ypcw==
=E/Qm
-----END PGP SIGNATURE-----

--7tubSUVrD+xV4Inh--
