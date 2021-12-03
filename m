Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70419467D3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 19:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353197AbhLCS22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 13:28:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbhLCS21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 13:28:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 259FA1FD3C;
        Fri,  3 Dec 2021 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638555902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eV3OmMVm/NWdly/P2YCXm8g5vG08JX/vYpooIV4zaHM=;
        b=P7zR711xL2stvUGx6l6vVCieltuwJ7iV6UsAhFInFLaRmH8OJdSujjmdkyf4YrNrIT79E/
        ZYuQCHGjcPMPXVGMFoAqnhbzDrq9e3ZueDbczIi9W0+stZnoOhH7yqYmjT3d7uzr/o4F3D
        ArNTust0WbmyWA/ziUPunMb3o5HF4ds=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEC8D13EC7;
        Fri,  3 Dec 2021 18:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kezINP1gqmHYYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 03 Dec 2021 18:25:01 +0000
Date:   Fri, 3 Dec 2021 19:25:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20211203182500.GD16798@blackbody.suse.cz>
References: <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <Yaem+r/YZ9BNXv9R@slm.duckdns.org>
 <4a021678-1896-2d16-4075-f626c7ab8513@redhat.com>
 <8f56f7a3-1d4b-679b-7348-d8ecb4ef3d6c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <8f56f7a3-1d4b-679b-7348-d8ecb4ef3d6c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Longman.

On Wed, Dec 01, 2021 at 08:28:09PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> 1) The limitation that "cpuset.cpus" has to be a superset of child's
> "cpuset.cpus" has been removed as a new patch to remove that limitation w=
ill
> be added.

Superb!

> 2) The initial transition from "member" to partition root now requires th=
at
> "cpuset.cpus" overlap with that of the parent's "cpuset.cpus" instead of
> being a superset.

That's sensible.

> For the transition back to "member", I haven't changed the current wording
> of forcing child partition roots to become "member" yet. If you think
> keeping them as invalid partition root is better, I can made that change
> too.

I wrote I was indifferent about this in a previous mail but when I think
about it now, switching to invalid root is perhaps better than switching
to member since it'd effectively mean that modifications of the parent
config propagate (permanently) also to a descendant config, which is
an undesired v1-ism.


> Please let me know what other changes you would like to see.

I hope my remarks below are just clarifications and not substantial
changes. Besides that I find your new draft good. Thanks!

> [...]

> =A0=A0 =A0An invalid partition root can be reverted back to a valid one
> =A0=A0 =A0if none of the validity constraints of a valid partition root
> =A0=A0 =A0are violated.

s/can be/will be/=20

(I understand the intention is to make it asynchronously and
automatically, i.e. without writing into the affected descendant(s)
cpuset.partition again.)

> =A0=A0 =A0Poll and inotify events are triggered whenever the state of
> =A0=A0 =A0"cpuset.cpus.partition" changes.=A0 That includes changes cause=
d by
> =A0=A0 =A0write to "cpuset.cpus.partition", cpu hotplug and other changes
> =A0=A0 =A0that make the partition invalid.

-> that change validity status

(In accordance with the comment above.)


Michal

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTiq06H1IhXbF2mqzsiXqxkP0JkRwUCYapg+AAKCRAiXqxkP0Jk
R60gAQCV8E8cIvOn/Hr5KboWD+7obSggVivpR3LxikBIuT9raQD+OptMUIwAN0Mk
MnWqFSlaobxSAqN0VorYNkJ17mv9dAc=
=q7Dx
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
