Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363EE6B9D23
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCNReT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCNReS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 13:34:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E492470B;
        Tue, 14 Mar 2023 10:34:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBE621A9E;
        Tue, 14 Mar 2023 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678815253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DupMteheALIYB1G+k5H2NhRA08uOKiRKtdEEzOCrJJQ=;
        b=k0qqRYbdVDScAcQj0BLGPYfF2MNBj4I4FWvzeXohYfytIiiAVBtL/2rsaGxdMQHe0A9/zf
        rjPH1AAdnOU8/n9XnRqmMXAJDTrNjxRPM1gSb6G5pxHmFuX38e4BZ3wDCrxeSxPb29mD1p
        1pr7kbztFidXw/9STbEoEPDpUM8CwAw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25E7913A1B;
        Tue, 14 Mar 2023 17:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nVpGCBWwEGQQCgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Mar 2023 17:34:13 +0000
Date:   Tue, 14 Mar 2023 18:34:11 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] cgroup/cpuset: Include offline CPUs when tasks'
 cpumasks in top_cpuset are updated
Message-ID: <20230314173411.fqaxoa2tfifnj6i3@blackpad>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qe72pixdf4dmzhs"
Content-Disposition: inline
In-Reply-To: <20230306200849.376804-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3qe72pixdf4dmzhs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Waiman.

On Mon, Mar 06, 2023 at 03:08:46PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> -		/*
> -		 * Percpu kthreads in top_cpuset are ignored
> -		 */
> -		if (top_cs && (task->flags & PF_KTHREAD) &&
> -		    kthread_is_per_cpu(task))
> -			continue;
> +		const struct cpumask *possible_mask =3D task_cpu_possible_mask(task);
> =20
> -		cpumask_and(new_cpus, cs->effective_cpus,
> -			    task_cpu_possible_mask(task));
> +		if (top_cs) {
> +			/*
> +			 * Percpu kthreads in top_cpuset are ignored
> +			 */
> +			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
> +				continue;
> +			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
> +		} else {
> +			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
> +		}

I'm wrapping my head around this slightly.
1) I'd suggest swapping args in of cpumask_and() to have possible_mask
   consistently first.
2) Then I'm wondering whether two branches are truly different when
   effective_cpus :=3D cpus_allowed - subparts_cpus
   top_cpuset.cpus_allowed =3D=3D possible_mask        (1)

IOW, can you see a difference in what affinities are set to eligible
top_cpuset tasks before and after this patch upon CPU hotplug?
(Hm, (1) holds only in v2. So is this a fix for v1 only?)

Thanks,
Michal

--3qe72pixdf4dmzhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBCwEQAKCRAkDQmsBEOq
ucEEAP9OI9c5kJhqB0QtHzHKrGbCZbzmTOwe7E5LB65IzTMi/wD/VLC97u3WoAMa
Fjzw23hqzv+JPbXpH+rkk6P0gvPDFQw=
=tWCP
-----END PGP SIGNATURE-----

--3qe72pixdf4dmzhs--
