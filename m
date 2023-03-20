Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E969B6C16D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjCTPJl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjCTPJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:09:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBAF7AB8;
        Mon, 20 Mar 2023 08:04:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64CFD1F894;
        Mon, 20 Mar 2023 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679324675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwWqYXOi2JWUeQesBva9impsRBcN0SMjROswWsfpc4s=;
        b=r8Ym2XCbihrsxLtFN08w06AOIshHu11IbK2BZr6ABPHC7XQk0y0yK4mY8d81jkGe3H0/Cg
        lsmCJu73Fn24TssqB10M9LUnvuQ3AtCZSk4r3zEmQlIbFacyS0/YKpuAR+VVVD9U66RiN7
        G/cFWEmoCSMmZbkRpEUr1vD4mv0gFA0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B2A013A00;
        Mon, 20 Mar 2023 15:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DDuBBQN2GGT+OAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 20 Mar 2023 15:04:35 +0000
Date:   Mon, 20 Mar 2023 16:04:33 +0100
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
Message-ID: <20230320150433.v3xcl7rqsxz4x6tg@blackpad>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230317151508.1225282-4-longman@redhat.com>
 <20230317180157.uqlleobldg53pgj6@blackpad>
 <11b5454b-42c7-fb0d-f071-c46712f76f3b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3azguixlje76xpd"
Content-Disposition: inline
In-Reply-To: <11b5454b-42c7-fb0d-f071-c46712f76f3b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--g3azguixlje76xpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 02:05:32PM -0400, Waiman Long <longman@redhat.com> wrote:
> A cpu will be in the subparts_cpus only if it has been given to the child
> partition. So when it becomes online, it will become part of the scheduling
> domain that child partition. Only the tasks in that child partition will get
> their cpumasks updated to use it, not those in the top cpuset.

Right, it's actually the difference between offlining a CPU and giving it
to a sub-partition (hence a removed child (or switched to member) before
CPU onlining). It's clear to me now.

Thanks,
Michal

--g3azguixlje76xpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBh1/wAKCRAkDQmsBEOq
uX3wAQCFD+U7rIP4rxH0pPPjBiVpGL+85S7rzdSIW7hL/H4DaAD/VJF7JKo6+E01
gtBEpTVziKoADESQUhA8DJ2KYUQIlw4=
=n3My
-----END PGP SIGNATURE-----

--g3azguixlje76xpd--
