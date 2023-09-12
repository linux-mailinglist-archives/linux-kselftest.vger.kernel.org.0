Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F079D020
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjILLg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjILLgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 07:36:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F721984;
        Tue, 12 Sep 2023 04:36:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B8C433CC;
        Tue, 12 Sep 2023 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518561;
        bh=FqyK1BBfRLxXE3aS+KCLZUV0IHoSshxhxsTtCpFga/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHSm0DOn8kCR71h22+DVN7pWsxUEWPCfx006wI8cyge+zBf2j9/yzKoL3s+cFCVBw
         jgzsjORHzZbcz4RGDimOgLBRK07NlkDY6XjrjYaN5WmScumACQHgguBjIY49vbyPyc
         NflPTHh5QXwGuXcHAECKjKFBOusbiFzfB0C2DbC7uMuZZTgQHjR6G3tot+k+nPK0vz
         NbSYx6geZMTfU2tvbeYmMxA6WJyD3zMZQjOxeEe/JtbGjy17BuxVYwO6R9jWzvhbt0
         vx8QaJl8CoE82b2peOCs6XCWQV4FyM/yPYu/AP14X+auQY9J3+92sBQFp+XuU2dgp1
         5SoHJTl0R/p5g==
Date:   Tue, 12 Sep 2023 12:35:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [FIX PATCH v2] selftests: tracing: Fix to unmount tracefs for
 recovering environment
Message-ID: <468132d9-462b-44c9-81c6-d06bbc73a27b@sirena.org.uk>
References: <169448103881.242465.4589561134225171701.stgit@devnote2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hggetOCeUKitESj+"
Content-Disposition: inline
In-Reply-To: <169448103881.242465.4589561134225171701.stgit@devnote2>
X-Cookie: Victory uber allies!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--hggetOCeUKitESj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 10:10:39AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Fix to unmount the tracefs if the ftracetest mounted it for recovering
> system environment. If the tracefs is already mounted, this does nothing.

Reviewed-by: Mark Brown <broonie@kernel.org>

--hggetOCeUKitESj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUATRsACgkQJNaLcl1U
h9AFeAf9FHvPr4s7vtnZweJsIdZb05i+6Edv6cr3cgnWmKkZ0WxJFnO6DoJLatE6
xetj04aMvA7YzwMXMqb7ryzK+Acmm1K07a58q6OckbUxSuDTfS2RHtWPHtADMjpI
fPxe0v+ioaE3vXg/IVYbCFLTN08LaWBDxzQ+3xMqI3IrBJVxaCjG+WIMVePMiDX5
OIKYxTLzdG0FIkwR0UCVOFihbmLVcMycoDYMpvWcSuDKDIXhyoKFjbE3oFun8VmJ
c79DYlcgA71hFqxRQ/PxfQLSAl5vqpa0zKdxoSYr/dJSOuHwJ0Ixa566FOmYSa0G
54roHYlY+A2io6Y/ngqEsyC7mCX/mg==
=tpLM
-----END PGP SIGNATURE-----

--hggetOCeUKitESj+--
