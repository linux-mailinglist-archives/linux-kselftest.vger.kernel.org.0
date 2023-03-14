Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92F6B9E13
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 19:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCNSRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCNSRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 14:17:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0D848D4;
        Tue, 14 Mar 2023 11:17:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D93391F8BA;
        Tue, 14 Mar 2023 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678817870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXfCDy+DyUAKygjyGfiKxYTGe5xfVMSMGVkxJXSrpIQ=;
        b=AOXZcoKpV9w3YCIDuYgTfnHKfE5UBefnEL82dP016q0d+5tyZEeEleZkDzhvXWCbo70DAt
        eFzGFvQRS2krlcD2kwG+1wW3CTSTOlta0N7cRRsLL6/nkTwtwmluvBdmwCRT6Li759RnvH
        0HjdSgwnmIiOZoUPLfnAoNgQkjh6Sc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A168B13A26;
        Tue, 14 Mar 2023 18:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YQ1zJk66EGRRIQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Mar 2023 18:17:50 +0000
Date:   Tue, 14 Mar 2023 19:17:49 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Message-ID: <20230314181749.5b4k6selbgdhl3up@blackpad>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x5gbpgbolwjq6gqy"
Content-Disposition: inline
In-Reply-To: <20230306200849.376804-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--x5gbpgbolwjq6gqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Mar 06, 2023 at 03:08:47PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> On a system with asymmetric CPUs, a restricted task is one that can run
> only a selected subset of available CPUs.  When a CPU goes offline or
> when "cpuset.cpus" is changed, it is possible that a restricted task
> may not have any runnable CPUs left in the current cpuset even if there
> is still some CPUs in effective_cpus. In this case, the restricted task
> cannot be run at all.
>=20
> There are several ways we may be able to handle this situation. Treating
> it like empty effective_cpus is probably too disruptive and is unfair to
> the normal tasks. So it is better to have some special handling for these
> restricted tasks. One possibility is to move the restricted tasks up the
> cpuset hierarchy, but it is tricky to do it right. Another solution is
> to assign other usable CPUs to these tasks. This patch implements the
> later alternative by finding one usable CPU by walking up the cpuset
> hierarchy and printing an informational message to let the users know
> that these restricted tasks are running in a cpuset with no usable CPU.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bbf57dcb2f68..aa8225daf1d3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1202,6 +1202,38 @@ void rebuild_sched_domains(void)
>  	cpus_read_unlock();
>  }
> =20
> [...]
>  /**
>   * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>   * @cs: the cpuset in which each task's cpus_allowed mask needs to be ch=
anged
> @@ -1218,6 +1250,7 @@ static void update_tasks_cpumask(struct cpuset *cs,=
 struct cpumask *new_cpus)
>  	struct task_struct *task;
>  	bool top_cs =3D cs =3D=3D &top_cpuset;
> =20
> +	percpu_rwsem_assert_held(&cpuset_rwsem);
>  	css_task_iter_start(&cs->css, 0, &it);
>  	while ((task =3D css_task_iter_next(&it))) {
>  		const struct cpumask *possible_mask =3D task_cpu_possible_mask(task);
> @@ -1232,7 +1265,28 @@ static void update_tasks_cpumask(struct cpuset *cs=
, struct cpumask *new_cpus)
>  		} else {
>  			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
>  		}
> -		set_cpus_allowed_ptr(task, new_cpus);
> +		/*
> +		 * On systems with assymetric CPUs, it is possible that
> +		 * cpumask will become empty or set_cpus_allowed_ptr() will
> +		 * return an error even if we still have CPUs in
> +		 * effective_cpus. In this case, we find a usable CPU walking
> +		 * up the cpuset hierarchy and use that for this particular
> +		 * task with an informational message about the change in the
> +		 * hope that the users will adjust "cpuset.cpus" accordingly.
> +		 */
> +		if (cpumask_empty(new_cpus) ||
> +		    set_cpus_allowed_ptr(task, new_cpus)) {

IIUC, cpumask_empty(new_cpus) here implies
cpumask_empty(cs->effective_cpus) but that shouldn't happen (cs should
inherit non-empty mask from an ancestor). Do I miss/forget anything?

This thus covers the case when p->user_cpus_ptr is incompatible with
hotplug or cpuset.cpus allowance and a different affinity must be
chosen. But doesn't that mean that the task would run _out_ of
cs->effective_cpus?
I guess that's unavoidable on asymmetric CPU archs but not no SMPs.
Shouldn't the solution distinguish between the two? (I.e. never run out
of effective_cpus on SMP.)

Thanks,
Michal

--x5gbpgbolwjq6gqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBC6SwAKCRAkDQmsBEOq
ubsfAP9GRE14O3/kdwbAKhko41gp/hUwOisMncJ5TvIoeuwJLwEAizS5evBXx/k8
/zPGsyq2q3URP/Rg/A3cwE1LOhlyEgo=
=Tteu
-----END PGP SIGNATURE-----

--x5gbpgbolwjq6gqy--
