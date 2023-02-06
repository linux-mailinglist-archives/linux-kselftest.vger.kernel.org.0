Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8C68C846
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFVKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 16:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFVKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 16:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245683DC;
        Mon,  6 Feb 2023 13:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321C1B815D2;
        Mon,  6 Feb 2023 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DF8C433EF;
        Mon,  6 Feb 2023 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675717815;
        bh=WTPWDMtcLIf05UU9kblWGdi5v0JvrRBmtqEqzSdP8sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/TPbNufKGtKPHmRUZlDLLPO65ZWPCoD6Qk2DPX7yo96f/VTveQo7Vrv1Gnylliao
         sY/XPaTdBV0pvIvxbHWO7t9m+SxXUO86u1wYk9pYPnzYJdRR7incWuXol5W0+ANmah
         m8HEveP3IrH3Wb4L3/jRQyH0vJnX81SPvuBJ5hHtnrXQBGZhcOI889R3u4UH/UhcCs
         iqsibiLSll6nZ/sgwJQsB10VnSES8AXFa9rFxsLwGZFSF0WV3ndZR1HDrOXSqYgmYn
         7C/IniSxPugN+VZnb27BphMy8+zkjIEe+B9vQBXZ9vVDIsW+4pkydaJdTFS/BEu8Gt
         mOPo6xiJpYwMw==
Date:   Mon, 6 Feb 2023 21:10:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
Subject: Re: [PATCH] KVM: selftests: Enable USERFAULTFD
Message-ID: <Y+FssQB6i+mf1Z97@sirena.org.uk>
References: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
 <Y+E0MuGJ+hE3zslT@google.com>
 <Y+FDtDWnG2k0wqlv@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cb+rn9loKq1UP/FO"
Content-Disposition: inline
In-Reply-To: <Y+FDtDWnG2k0wqlv@google.com>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Cb+rn9loKq1UP/FO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 06:15:16PM +0000, Sean Christopherson wrote:

> What do CI systems do for HugeTLB and THP?  Those are the other config options I
> can think of where there are very interesting interactions from a KVM perspective,
> but where KVM doesn't have a strict dependency on the feature.

> E.g. x86_64_defconfig selects CONFIG_HUGETLBFS=y, but I don't see anything for THP,
> and AFAICT TRANSPARENT_HUGEPAGE is default=n.

Most likely they'll either just go with defconfig plus whatever's in the
fragement, or they'll lump all the kselftest fragments together (which
isn't ideal but cuts down on the number of kernels you have to build).
If someone's specifically set something up for KVM they might do more
combinations.

--Cb+rn9loKq1UP/FO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPhbLAACgkQJNaLcl1U
h9DNjwf/dqdhDjZSE3EXDPMFI1zdqs9HXxnBgP5sBbUePj+J8ZGyb6FhEh9fUoy5
MsMdizWPL1diJqWPUcdaMYQebAumniVvWneIcd1DRpxN6ohl+0sfIltDc13/EIJv
+NJxCpCTvgBT+2+bq/udf8EFJqCrm3E9PmFPI9yZMmLbAMy/Rugm6VTUoAuqIXBC
khM1NGbs0+Oe9hGCHyNO19TCD8FcLvohDNPJc3IdBDkB5xqoorsNG645jW5Wfll5
/dLpZE6BIedgb95zg+B0ebgdKmpZSrMae0xZrQ1quMRvSREvi183Mwa8vkH4XTOq
cOhBFOQaSdabBDfnUzUJ57rVOJaI3A==
=+Lj3
-----END PGP SIGNATURE-----

--Cb+rn9loKq1UP/FO--
