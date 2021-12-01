Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30D5464F6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhLAORP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:17:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhLAORO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:17:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 266491FD5A;
        Wed,  1 Dec 2021 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638368032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fOp73N+RHazrUHrc9GoZ30ZU9IWHl5ZMpNXXLtab7Ck=;
        b=lOHMSLqwKO+hgmrKd7CP5mHIPjlZyI7Yhk3rECaCnHJucYwQY1IISq5BFNr5YqK8OCiDtx
        UnLW2QK4RtUKX76MkQl45OMKHugvm4ZRw70Ao4+17ONC1TViG+SsGNtrqDvdZXELnr2Y/A
        zUsTJ5dJQYy+Av+smN+1VCWSjjlwxkQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFAB113D0B;
        Wed,  1 Dec 2021 14:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNmeNR+Dp2H6WQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 01 Dec 2021 14:13:51 +0000
Date:   Wed, 1 Dec 2021 15:13:50 +0100
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
Message-ID: <20211201141350.GA54766@blackbody.suse.cz>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 10:56:34PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> > >  =A0=A0 =A0A valid parent partition may distribute out all its CPUs to
> > >  =A0=A0 =A0its child partitions as long as it is not the root cgroup =
and
> > >  =A0=A0 =A0there is no task associated with it.
> > A valid parent partition which isn't root never has tasks in them to be=
gin
> > with.
> I believe there is some corner cases where it is possible to put task in =
an
> intermediate partition. That is why I put down this statement.

Just mind the threads -- cpuset controller is threaded and having tasks
in inner cgroup nodes is a real scenario. I wouldn't consider it a
corner case.

[ Actually, the paragraph could IMO be simplified:

> A valid parent partition may distribute out all its CPUs to
>=A0its child partitions as long as there is no task associated with it.

Assuming there's always at least one kernel thread in the root cgroup
that can't be migrated anyway.]


Michal

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTiq06H1IhXbF2mqzsiXqxkP0JkRwUCYaeDFQAKCRAiXqxkP0Jk
RwNCAP97/71glMvylTDowYwhdI5KleBFVwxoUX0JYOli5Z1++gD/VWelsoQUVWOo
1YdBl5Ei0UknFyqYHDcKnBbttGx1hQM=
=h6LI
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
