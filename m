Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605556F496B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEBSBW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBSBV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 14:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161E83;
        Tue,  2 May 2023 11:01:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 344D9219DE;
        Tue,  2 May 2023 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683050478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0f0hUbsvSFR9UE93IS6I2zL3LHIPpph9neOljoj1mE=;
        b=D9fKqMwcb2qgqBv1yX/t/aA1+iNYzYkHC8ljzAS23401NpcT72tQ1UUPhm4T5mPjk9LeE+
        FxS1WzcrgEP124Sgfj6zwUF1ZRXILfcmvYFjj+j2XPhHdmpSxxPdVltqCYcH9Phq3Z/J9A
        KJ1Ekc6Yu3tQ+vei+SkgSkXSJTszLDA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0312134FB;
        Tue,  2 May 2023 18:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U2LJOe1PUWSWbgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 18:01:17 +0000
Date:   Tue, 2 May 2023 20:01:16 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
References: <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dk2c7how7kjjrmdw"
Content-Disposition: inline
In-Reply-To: <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dk2c7how7kjjrmdw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

The previous thread arrived incomplete to me, so I respond to the last
message only. Point me to a message URL if it was covered.

On Fri, Apr 14, 2023 at 03:06:27PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Below is a draft of the new cpuset.cpus.reserve cgroupfs file:
>=20
> =A0 cpuset.cpus.reserve
> =A0=A0=A0=A0=A0=A0=A0 A read-write multiple values file which exists on a=
ll
> =A0=A0=A0=A0=A0=A0=A0 cpuset-enabled cgroups.
>=20
> =A0=A0=A0=A0=A0=A0=A0 It lists the reserved CPUs to be used for the creat=
ion of
> =A0=A0=A0=A0=A0=A0=A0 child partitions.=A0 See the section on "cpuset.cpu=
s.partition"
> =A0=A0=A0=A0=A0=A0=A0 below for more information on cpuset partition.=A0 =
These reserved
> =A0=A0=A0=A0=A0=A0=A0 CPUs should be a subset of "cpuset.cpus" and will b=
e mutually
> =A0=A0=A0=A0=A0=A0=A0 exclusive of "cpuset.cpus.effective" when used sinc=
e these
> =A0=A0=A0=A0=A0=A0=A0 reserved CPUs cannot be used by tasks in the curren=
t cgroup.
>=20
> =A0=A0=A0=A0=A0=A0=A0 There are two modes for partition CPUs reservation -
> =A0=A0=A0=A0=A0=A0=A0 auto or manual.=A0 The system starts up in auto mod=
e where
> =A0=A0=A0=A0=A0=A0=A0 "cpuset.cpus.reserve" will be set automatically whe=
n valid
> =A0=A0=A0=A0=A0=A0=A0 child partitions are created and users don't need t=
o touch the
> =A0=A0=A0=A0=A0=A0=A0 file at all.=A0 This mode has the limitation that t=
he parent of a
> =A0=A0=A0=A0=A0=A0=A0 partition must be a partition root itself.=A0 So ch=
ild partition
> =A0=A0=A0=A0=A0=A0=A0 has to be created one-by-one from the cgroup root d=
own.
>=20
> =A0=A0=A0=A0=A0=A0=A0 To enable the creation of a partition down in the h=
ierarchy
> =A0=A0=A0=A0=A0=A0=A0 without the intermediate cgroups to be partition ro=
ots,

Why would be this needed? Owning a CPU (a resource) must logically be
passed all the way from root to the target cgroup, i.e. this is
expressed by valid partitioning down to given level.

>         one
> =A0=A0=A0=A0=A0=A0=A0 has to turn on the manual reservation mode by writi=
ng directly
> =A0=A0=A0=A0=A0=A0=A0 to "cpuset.cpus.reserve" with a value different fro=
m its
> =A0=A0=A0=A0=A0=A0=A0 current value.=A0 By distributing the reserve CPUs =
down the cgroup
> =A0=A0=A0=A0=A0=A0=A0 hierarchy to the parent of the target cgroup, this =
target cgroup
> =A0=A0=A0=A0=A0=A0=A0 can be switched to become a partition root if its "=
cpuset.cpus"
> =A0=A0=A0=A0=A0=A0=A0 is a subset of the set of valid reserve CPUs in its=
 parent.

level n
`- level n+1
   cpuset.cpus	// these are actually configured by "owner" of level n
   cpuset.cpus.partition // similrly here, level n decides if child is a pa=
rtition

I.e. what would be level n/cpuset.cpus.reserve good for when it can
directly control level n+1/cpuset.cpus?

Thanks,
Michal

--dk2c7how7kjjrmdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZFFP6gAKCRAkDQmsBEOq
uf5WAP0TD4xZbzbRrza4aMPH3HGxMt5QxQoqQyFnCnecSe4ThwEA80+zGnGxZQv9
yMROHtPHn2tZGEg0+1iKitQk/7QCnA0=
=hh88
-----END PGP SIGNATURE-----

--dk2c7how7kjjrmdw--
