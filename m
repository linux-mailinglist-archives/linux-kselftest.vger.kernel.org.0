Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF736BE928
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCQM1N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQM1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 08:27:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD15849E;
        Fri, 17 Mar 2023 05:27:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15C7F21A68;
        Fri, 17 Mar 2023 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679056030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NHGqTJTnUqNOxZp472cVknzLVo5SZVLbcDm4mbJepYE=;
        b=rJdcWQzdyPd9a/cihTdjKLylB/F971V//4EK68lFcSi6+QeE07wyMRp1v6doKHg+S1kGH+
        QzehHDeBxhchvhFxoFakWGODWsO7/LFV6j32hmil6vGLW1R2ShqimpkaxQO06BQr0oUgjT
        X10Hf/7R/l8wZNHqXg3ME1xb63WNxHs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D187A1346F;
        Fri, 17 Mar 2023 12:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 94c1Mp1cFGSrNAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Mar 2023 12:27:09 +0000
Date:   Fri, 17 Mar 2023 13:27:08 +0100
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
Message-ID: <20230317122708.ax3m2d4zijkfdzjq@blackpad>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkiro4aaqlim764r"
Content-Disposition: inline
In-Reply-To: <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wkiro4aaqlim764r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 04:22:06PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Some arm64 systems can have asymmetric CPUs where certain tasks are only
> runnable on a selected subset of CPUs.

Ah, I'm catching up.

> This information is not captured in the cpuset. As a result,
> task_cpu_possible_mask() may return a mask that have no overlap with
> effective_cpus causing new_cpus to become empty.

I can see that historically, there was an approach of terminating
unaccomodable tasks:
   94f9c00f6460 ("arm64: Remove logic to kill 32-bit tasks on 64-bit-only c=
ores")=20
the removal of killing had been made possible with
   df950811f4a8 ("arm64: Prevent offlining first CPU with 32-bit EL0 on mis=
matched system").

That gives two other alternatives to affinity modification:
2) kill such tasks (not unlike OOM upon memory.max reduction),
3) reject cpuset reduction (violates cgroup v2 delegation).

What do you think about 2)?

Michal

--wkiro4aaqlim764r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZBRcmgAKCRAkDQmsBEOq
ucYMAQDoDiiyg+tQDkv5bZDwLQd/3BXqchUmoOd8JRUt6N8NbAEA3Fmj3clZkURa
n/kLtf6/Db3HtQYwAN0g7e9CJjWZPQE=
=QJAy
-----END PGP SIGNATURE-----

--wkiro4aaqlim764r--
