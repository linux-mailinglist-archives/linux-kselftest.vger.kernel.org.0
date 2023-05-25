Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBE710D87
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbjEYNrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjEYNrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 09:47:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE6186;
        Thu, 25 May 2023 06:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BCD645E6;
        Thu, 25 May 2023 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB94AC433EF;
        Thu, 25 May 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685022439;
        bh=txQ5zlsrdnMnxEZa4hcE4oM0dqk/k/0xGttE4gv4vuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBY/mCjHNmtvp6sCY8jWXZvEFZvNQ5tTe86GNp+3m5xm8t2redr5meURzjyaNGvld
         jWyMtWgV9oJEkeepnF1e7dh5MRXVzHKdktQBruM69izJCmuVLjZTTKOY4i0Vb07M3A
         npALEadYtkAswGhkBp8Vt+LC1ndve1AhQx9QcmQBQMtKC4rR91zZJpM1dIj0+nAOBu
         MDbiume7VA27h+1QiU8ElNjf/Zgt5evHfsqexSNwQyB+zcL3EjLWfHRR1N2wCWEoU+
         Zq8WBCA2yEF+8gFMD9nEA/oiv2qbjjAQQUFPkf9Gic2cb1JAzteZQd6y7UzwVxQPCd
         iFRHU39dv6UjQ==
Date:   Thu, 25 May 2023 14:47:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <e1473787-fe35-45e1-8897-551f99277122@sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
 <CA+G9fYtZjGomLjDi+Vf-hdcLpKPKbPmn4nwoPXvn24SG2hEJMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6VXOP9bxHNDN6fr0"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtZjGomLjDi+Vf-hdcLpKPKbPmn4nwoPXvn24SG2hEJMg@mail.gmail.com>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--6VXOP9bxHNDN6fr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 06:49:36PM +0530, Naresh Kamboju wrote:

> On Linux next this fp-stress BUG: has been happening *intermittently* from
> next-20230314 dated March 14, 2023.

A quick scan through shows no updates related to FP in the few weeks
preceeding that (quite few arm64 updates at all really).  This all seems
to match the pattern I mentioned when this was originally reported - it
does happen sometimes but there's some very thin race or something which
means it only comes up *very* rarely.  None of which is helpful for
figuring out what's going on :/

--6VXOP9bxHNDN6fr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvZuAACgkQJNaLcl1U
h9Bm8Af+KoGKn5HyA41KhSsXyRJWRNoRm5FXAO2xsxJQdfFcmGnVddDr2VcZWIg5
LpeUp6ZIuEsxW/xiqhw05hPgK3YnVV/kLizGSl3q3l9m9n2JvWVGqbBlwhBCcmYO
AzX6a9OFlH55hffJtp3gcGaHzLmSx+7+nfIuFeZ8UCvPjILrPlddyRctBvb2Ux9x
+finmwzrTxuUJopA3E9FWu+9Wm83CCcOhMerOXlkaP+q1WKG8XoV05uzZUcYzpyM
fApg7yFVqSoROQLABaFk5/EuPc+x3tVB1pa26WdgCdXERqtuXvRhlIoDKFxJTyN+
IYlAO+UXxKFd1dQox7m6XQCw0aT1YQ==
=i6L5
-----END PGP SIGNATURE-----

--6VXOP9bxHNDN6fr0--
