Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E8549DBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiFMTbF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbiFMTaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:30:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7073BBE7;
        Mon, 13 Jun 2022 10:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C34EA1F912;
        Mon, 13 Jun 2022 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655142950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzS01aA3Xyy9CDel2JXDJs9iyrs3QpwSpqahshjzX74=;
        b=cqnjztUqJrCHTfw9V8Ca5DYeE4hhSffVbVP2M7yHzGtkufmdle7iK/rqZUXXVJWwvILc+6
        EdHXTnZWsO2XWqTSSZiB36tUtLKfOeQZOLoNGPczPNYP4F54eWRp6cXpT5TwvRwJNGCBjJ
        lkBJEdxZ0YrWvHlqX3P3gIIFXIfUN6Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66504134CF;
        Mon, 13 Jun 2022 17:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kb/iFiZ6p2JHEwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 13 Jun 2022 17:55:50 +0000
Date:   Mon, 13 Jun 2022 19:55:49 +0200
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
Message-ID: <20220613175548.GB21665@blackbody.suse.cz>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <YqdzuSQuAeiPXQvy@slm.duckdns.org>
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


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 07:28:25AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I see. Is this part even necessary? All the .cpus files of the siblings a=
re
> owned by the parent who's responsible for configuring both the mode that =
the
> cgroup subtree is gonna be in and their cpumasks.=20

Do you mean such an example:

    parent	cpuset.cpus=3DSET (root)	cpuset.cpus.partition=3Disolated=20
    `- child_1	cpuset.cpus=3Dpartition_of(SET) (root)	cpuset.cpus.partition=
=3Disolated
    `- ...
    `- child_n	cpuset.cpus=3Dpartition_of(SET) (root)	cpuset.cpus.partition=
=3Disolated
?

I don't think child_*/cpuset.cpus must be owned by root.
Actually, the root would only configure the parent, i.e.
parent/cpuset.cpus (whose changes would be disallowed to the
unprivileged tasks) and the distribution among siblings would up to the
whatever runs below.

> Given that all the other errors it can make are notified through
> "invalid (REASON)" in the mode file, wouldn't it fit better to notify
> cpus configuration error the same way too?

Do you suggest that a write into child_*/cpuset.cpus that'd not be
exclusive wrt a sibling would result in an error string in
parent/cpuset.cpus.partition?

Thanks,
Michal

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYqd6IgAKCRAkDQmsBEOq
uTj0AQCj12EX4WPcqDcmcwMKbJzlpJ02i8IqULaAkdHb+ptGcwEA8e1nvXYC0yDJ
hezmngAtFbdLR+r20pDT8tTEBO6BKAs=
=xTZE
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
