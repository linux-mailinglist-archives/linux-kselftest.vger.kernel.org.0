Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3B7911C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjIDHJc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 03:09:31 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FDA0;
        Mon,  4 Sep 2023 00:09:27 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RfKWQ2KsXz9sT0;
        Mon,  4 Sep 2023 09:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1693811362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cq7qOZE8xlGiGZJPTa8yzpYZ1oFjZWMPNorQyVEd/Xg=;
        b=LDCQEZVL0xpuZmPp1oz1O/PrYOZ21hPWBxqRc4Q6Au/AfG71IKLuV1NhN635Elh/nQTX7j
        zjLu379c2FzrJtB2pxXNxRqBWW9LVFKSHx4zPU9MnrZGVWwxTkinJ/Kkmny3h+JOVmOmlZ
        11iYEFzePn1nolFhGHj76p853EtiII8ssmRyg0UtozDlf1qScHpkYqfuxiUXKYitkKyga+
        TZ73c4jLGPrdgFtMFlbQzJVGd1Iid7kHBh9wY8gg4R6oT1G1urbcf9D9SL5zw7pWFC+D0b
        +HyFq7Y5NdknCZrbt1yM0qHEQH4oQmxIfBOt/V2NiDICipNOhLVfcGrZCWAxZg==
Date:   Mon, 4 Sep 2023 17:09:09 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Tometzki <dtometzki@fedoraproject.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
Message-ID: <20230904.070506-tidy.dividend.mousy.flasks-BFYX3RqFch3q@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
 <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
 <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nnx76nxb2yfdk3in"
Content-Disposition: inline
In-Reply-To: <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
X-Rspamd-Queue-Id: 4RfKWQ2KsXz9sT0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--nnx76nxb2yfdk3in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-02, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 1 Sep 2023 07:13:45 +0200 Damian Tometzki <dtometzki@fedoraprojec=
t.org> wrote:
>=20
> > >  	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> > > -		pr_warn_once(
> > > +		pr_info_ratelimited(
> > >  			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEA=
L set\n",
> > >  			current->comm, task_pid_nr(current));
> > >  	}
> > >=20
> > > --=20
> > > 2.41.0
> > >
> > Hello Sarai,
> >=20
> > i got a lot of messages in dmesg with this. DMESG is unuseable with
> > this.=20
> > [ 1390.349462] __do_sys_memfd_create: 5 callbacks suppressed
> > [ 1390.349468] pipewire-pulse[2930]: memfd_create() called without MFD_=
EXEC or MFD_NOEXEC_SEAL set
> > [ 1390.350106] pipewire[2712]: memfd_create() called without MFD_EXEC o=
r MFD_NOEXEC_SEAL set
>=20
> OK, thanks, I'll revert this.  Spamming everyone even harder isn't a
> good way to get developers to fix their stuff.

Sorry, I'm on vacation. I will send a follow-up patch to remove this
logging entirely -- if we can't do rate-limited logging then logging a
single message effectively at boot time makes no sense. I had hoped that
this wouldn't be too much (given there is a fair amount of INFO-level
spam in the kernel log) but I guess the default ratelimit (5Hz) is too
liberal.

Perhaps we can re-consider adding some logging in the future, when more
programs have migrated. The only other "reasonable" way to reduce the
logging would be to add something to task_struct so we only log once per
task, but obviously that's massively overkill.

(FWIW, I don't think the logging was ever necessary. There's nothing
wrong with running an older program that doesn't pass the flags.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nnx76nxb2yfdk3in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZPWCkAAKCRAol/rSt+lE
b5gWAP4/tAjH570jwrKkdsMIvm/7W9rAOvo1QLnJCd9r8MsX7QD9GDs3+9jWfNMB
lIppOxMkHE1/QyB4f/KzZwzay2OayQQ=
=/tpV
-----END PGP SIGNATURE-----

--nnx76nxb2yfdk3in--
