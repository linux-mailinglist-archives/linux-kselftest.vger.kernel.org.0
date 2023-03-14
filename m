Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E486B9C1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCNQug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCNQue (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 12:50:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D49E301;
        Tue, 14 Mar 2023 09:50:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9057E1F8A6;
        Tue, 14 Mar 2023 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678812631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6k/rQNu/3JyQ0BkZUFMKmdlCm0FllNjLs/p7eJHqbcg=;
        b=qAycucas010i4uea/GBqMOUweebj+BqtWiQY5kdCyAyeeC5Nq4Jd4YxHpuyx/9ulQeHhxQ
        5ZXX+V+S7NJjDJiPZ52HRgXL4afacwBG2RW/BtBSsdsIaf8n47HyAhXn4eYhv2C4Bvg4y7
        S1ZnBDCq6m40G47JaT0JjlCoN0PL8FY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 615C113A26;
        Tue, 14 Mar 2023 16:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id otCyFtelEGRscQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Mar 2023 16:50:31 +0000
Date:   Tue, 14 Mar 2023 17:50:30 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] cgroup/cpuset: Skip task update if hotplug doesn't
 affect current cpuset
Message-ID: <20230314165030.beu2ywtvqa3p45ta@blackpad>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unrarqlmrlmuhj23"
Content-Disposition: inline
In-Reply-To: <20230306200849.376804-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--unrarqlmrlmuhj23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 03:08:45PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> If a hotplug event doesn't affect the current cpuset, there is no point
> to call hotplug_update_tasks() or hotplug_update_tasks_legacy(). So
> just skip it.

This skips "insane" modification of cs->cpus_allowed in
hotplug_update_tasks_legacy() but assuming cs->cpus_allowed is kept in
sync with cs->effective_cpus on v1, it is OK to skip the update based
only on effective_cpus check.

Hence,

>  kernel/cgroup/cpuset.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--unrarqlmrlmuhj23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBCl1AAKCRAkDQmsBEOq
ub7vAQDuvydF9uT/t92mbXmbdJFDwYtaoBzZSBR7muvk51dYZAD/VflSkqUiEoJf
DK7RTVV/JCWxbff4B8Ud16JHw7PsfQU=
=Phpc
-----END PGP SIGNATURE-----

--unrarqlmrlmuhj23--
