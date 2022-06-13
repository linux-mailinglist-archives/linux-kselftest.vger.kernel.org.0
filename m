Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53C549B56
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiFMSVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiFMSUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 14:20:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC0EAD;
        Mon, 13 Jun 2022 07:24:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8666221C43;
        Mon, 13 Jun 2022 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655130294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0QxbXQTWScLBHdZkYfR8jKfBuUw2/vlOoxDD3FnCzX0=;
        b=CMvjzQmOEJZmJ+aCXYUtYR6cV2a6B/yT0U+mHCBSEypUkXGJFDyWBPHB0Z7IkXFKBXiRob
        WaN/MSCTSa5yUU5jEZUlmEXKUyG+tp45OcGy7/VDzJHcTwEDmzJg2g6ueidLXSqAt3+sjI
        8jYUsq6TWTWCGAp7ockBvOyJRSK4p7w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37AEF134CF;
        Mon, 13 Jun 2022 14:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P9iuDLZIp2I6QwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 13 Jun 2022 14:24:54 +0000
Date:   Mon, 13 Jun 2022 16:24:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20220613142452.GB6910@blackbody.suse.cz>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <YqarMyNo9oHxhZFh@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2022 at 05:12:51PM -1000, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>=20
> On Sun, Jun 12, 2022 at 11:02:38PM -0400, Waiman Long wrote:
> > That is the behavior enforced by setting the CPU_EXCLUSIVE bit in cgrou=
p v1.
> > I haven't explicitly change it to make it different in cgroup v2. The m=
ajor
> > reason is that I don't want change to one cpuset to affect a sibling
> > partition as it may make the code more complicate to validate if a part=
ition
> > is valid.
>=20
> If at all possible, I'd really like to avoid situations where a parent ca=
n't
> withdraw resources due to something that a descendant does.

My understanding of the discussed paragraph is that the changes are only
disallowed only among siblings on one level (due to exclusivity rule,
checked in validate_change()). A change in parent won't affect
(non)exclusivity of (valid) children so it's simply allowed.

So the docs (and implementation by a quick look) is sensible.

Michal

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYqdIsgAKCRAkDQmsBEOq
uQsKAQCuQgJeY8pngbeck33qpmT/9IqMQLfNBYRRLLM9dlUPbgEAw+wDMnZ9MjQW
KY6lhKrvUT5CEfFIjAzZay9tJBO/BAU=
=JcWM
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
