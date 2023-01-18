Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41547671EC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjARODd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 09:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjARODJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF069221;
        Wed, 18 Jan 2023 05:37:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C3D617D4;
        Wed, 18 Jan 2023 13:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE04DC433D2;
        Wed, 18 Jan 2023 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674049056;
        bh=HGzfvkfYSTPSnzYZVyaqSBkhU3uu+h0QI56B+tzbxkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQHx7UFFMqgGKyxUR/pJy9Wh83qWOfvIm9y6rYMP12ZZL9YDOhj3uuOFJay5k51m0
         0/v3JpygGfJYHqSG1BxUM9kIxDQH3utDVXbfsyre3be1z4AkrO4gIJwGm8E6R7c84V
         h3H1JV80jFgC6LOkG1Tl+d70pEWim0ePns0t98FGTjo2ll/tQBsOqlcAdYjNKeYglh
         FHKz6/lckN+NRRO+BZ7TeNhTYZWhnhHtXiU/5+T9CaUaeKXql64KdnjTFFVYZM0P/g
         QoJMQC7IFXVeTDSCHK7ncso8STvEGvAdWD6ahJr78aG98fy4VWqDCrChPdCrpEaJv/
         +YVftjEg6xkVA==
Date:   Wed, 18 Jan 2023 13:37:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix build of rseq test
Message-ID: <Y8f2HA02BJNYUYc7@sirena.org.uk>
References: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VfswN7vzsG+wDUcA"
Content-Disposition: inline
In-Reply-To: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--VfswN7vzsG+wDUcA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 07:24:19PM +0000, Mark Brown wrote:

> The KVM rseq test is failing to build in -next due to a commit merged
> from the tip tree which adds a wrapper for sys_getcpu() to the rseq
> kselftests, conflicting with the wrapper already included in the KVM
> selftest:

Any thoughts on this?  The KVM tests are still failing to build
in -next:

rseq_test.c:48:13: error: conflicting types for =E2=80=98sys_getcpu=E2=80=99
   48 | static void sys_getcpu(unsigned *cpu)
      |             ^~~~~~~~~~
In file included from rseq_test.c:23:
=2E./rseq/rseq.c:82:12: note: previous definition of =E2=80=98sys_getcpu=E2=
=80=99 was here
   82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
      |            ^~~~~~~~~~

https://storage.kernelci.org/next/master/next-20230118/arm64/defconfig/gcc-=
10/logs/kselftest.log

--VfswN7vzsG+wDUcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPH9hsACgkQJNaLcl1U
h9BKzAf/ewqrQ7FHj5QU4fi5/qdtg84hoiwVIwQQrts8rswRNLLGdqza9Px/W3Yz
XbCMaaYohDJ3UvrjlISJXVUKfyq+Xz1GwBj6MOg1AT8EyTt1px1WDIkLt2na7Fhl
8KVCl5MFVGk8tP5k9oa5khIkPeSHmJJQjKEiLbhNwABd4smhCLR6GgxRSAMAxrVL
ybJzWX0uQvK0z/vJ53XWdjTCPRQNfFtMHU0iY+yazw9VeXHVOjLzUEqfiAoLtAzi
aVG0V5RwZiLtjZC+M8UpP6unKtrUqIEtWXhCNcNwRE+YcFF4G7d0PiV+3CDWWu5T
vH/tTOphKcbCd4dHFSZib9Q0ZflLLw==
=btjG
-----END PGP SIGNATURE-----

--VfswN7vzsG+wDUcA--
