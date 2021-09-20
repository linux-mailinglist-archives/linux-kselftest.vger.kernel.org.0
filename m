Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDA41144D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Sep 2021 14:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhITMYv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Sep 2021 08:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233511AbhITMYu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Sep 2021 08:24:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3D66109D;
        Mon, 20 Sep 2021 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140604;
        bh=JW+A23gvYk0vPFs8X+JHXBSX96yX7HgLc0qfq9D4l20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fu3fIefUDmmha1RG+K6BxpZShjeTQGbq4fWedlc2Lk/wmdVozPyMoi5QYTcdjxwTm
         APBArDTtz2/ik7IAZ4b/lxYD9oJZPFZ3jjEbNnDLgVXYDzaMBsQA1aA33XYTVQca49
         a+rtgVneir6mIZoVqInZqOSjkZ+qSkOZQUXTYWon/13uMI8vNzeNBeU/hEonOQtT3f
         LBsUt0ZrX83f6p2wNZtdjZGqsm/4wHoEoTGMsFufa7+wdcYARmt6jAidwXm7YWtMfp
         EakYLiLXuZXPNOZ4qX0CJhEX0EXRhJJCsUg5Ot88NFd+r+b14HEkJ8oGYofZWA12hQ
         97FBFl+Pt/thA==
Date:   Mon, 20 Sep 2021 13:22:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip tests if required features
 are missing
Message-ID: <20210920122240.GE4192@sirena.org.uk>
References: <20210920121228.35368-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20210920121228.35368-1-cristian.marussi@arm.com>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 01:12:28PM +0100, Cristian Marussi wrote:
> During initialization of a signal testcase, features declared as required
> are properly checked against the running system but no action is then taken
> to effectively skip such a testcase.

Reviwed-by: Mark Brown <broonie@kernel.org>

I have a version of this locally which I thought I'd sent out already
among all the in flight patches I've got for kseltest but it looks like
it didn't make it.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIfQ8ACgkQJNaLcl1U
h9CkBgf/a1gYE9Xf+Z+0pTm73eRYWoKWjdSie4OlAlCC6Zi3CdiDoofY3UgrLnKk
+8L7Ma5+b9yHTi5Ex0ocw61Y0wTp830SJhZc3yUzGiJwVDGK6NeGoQrw4NUvDkSy
8tu6iNFNifB/2CLN+yS7XpUQ0rjUAGKF7VtVf5rJlQ3RIOxGF/p3Hg8Y85k/CqtK
5cPzHpfUX1bSUZe2AOITgue1VI2EkxByBdfjAzDumw+9Llzf86DNz1BsfR8+zV9E
aNLzYJ1xE5sbLhWPjzGB4Hs7nhr0By4/upNIKI7YV0cfu/ZkzGOEKoEAu7xQWrUm
6ae57EbVQPyCslc+BHD41nuD5Bu9hw==
=+gxi
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
