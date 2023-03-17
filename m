Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A826BF04A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCQSCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCQSCC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 14:02:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8519FE61;
        Fri, 17 Mar 2023 11:02:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 772E321A80;
        Fri, 17 Mar 2023 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679076119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTRztahqz2rOmT22cd3MICikvHbnMvBL2SFE1d0xF/k=;
        b=nHJ3DUisVXwoFt+d4sENGkALy6IoVXBFrRHQbK6f7gZyEBjikHruO6aebIRJmR7ThpqKl+
        pVlmQw3G/NfjFekKSnlsuAthfqPaxn9NQzlPmp522sjb2U7MTDQFd/1N7brxvSGJsS3HeM
        OVpvDR8tpZs0nM/1zxIzFbwTeng+ebQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A47E13428;
        Fri, 17 Mar 2023 18:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hd03DRerFGSGYwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Mar 2023 18:01:59 +0000
Date:   Fri, 17 Mar 2023 19:01:57 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 3/4] cgroup/cpuset: Include offline CPUs when tasks'
 cpumasks in top_cpuset are updated
Message-ID: <20230317180157.uqlleobldg53pgj6@blackpad>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230317151508.1225282-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3ht7kwhkaibaz3y"
Content-Disposition: inline
In-Reply-To: <20230317151508.1225282-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--u3ht7kwhkaibaz3y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Mar 17, 2023 at 11:15:07AM -0400, Waiman Long <longman@redhat.com> =
wrote:
>   * Iterate through each task of @cs updating its cpus_allowed to the
>   * effective cpuset's.  As this function is called with cpuset_rwsem hel=
d,
> - * cpuset membership stays stable.
> + * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mas=
k()
> + * is used instead of effective_cpus to make sure all offline CPUs are a=
lso
> + * included as hotplug code won't update cpumasks for tasks in top_cpuse=
t.
>   */

On Wed, Mar 15, 2023 at 11:06:20AM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> I see now that it returns offlined cpus to top cpuset's tasks.

I considered only the "base" set change cs->effective_cpus ->
possible_mask. (Apologies for that mistake.)

However, I now read the note about subparts_cpus

>         * effective_cpus contains only onlined CPUs, but subparts_cpus
>         * may have offlined ones.

So if subpart_cpus keeps offlined CPUs, they will be subtracted from
possible_mask and absent in the resulting new_cpus, i.e. undesirable for
the tasks in that cpuset :-/

Michal

--u3ht7kwhkaibaz3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBSrEwAKCRAkDQmsBEOq
ub2TAP9pF4P+p6q/Gyv+MLt5FYYDbFOYq0Pln5sL5iINLRsTkQEA2xdCNEw02ygM
fePZM8YSHXzb3KeNhLsD2b3PaS9m+AY=
=s2yK
-----END PGP SIGNATURE-----

--u3ht7kwhkaibaz3y--
