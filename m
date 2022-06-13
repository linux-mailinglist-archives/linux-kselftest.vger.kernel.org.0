Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D530B549928
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiFMQKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiFMQJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 12:09:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430ED1ABA54;
        Mon, 13 Jun 2022 07:02:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CDF121B9C;
        Mon, 13 Jun 2022 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655128928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dH96i6OHzwC4qIcatlfFaUeHgKDc3G4KvUuOT69KD6U=;
        b=jKmUvylV66P3EkHqBQvMGTtVkWvt3Wx/VA/PZBaOos9trJT4344bWhR6bLjSmrFKY20UEl
        StmiA+zFdv2T74AbHfLh2YLHX7k3Vg9sqDrqaSJPEgdZHIWaU5wTS00B0KEGoy5/XNqkFT
        UQXWzd05W3OVdfDU/9WRQ8W9KcenvM0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19BF0134CF;
        Mon, 13 Jun 2022 14:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id soFdBWBDp2JROgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 13 Jun 2022 14:02:08 +0000
Date:   Mon, 13 Jun 2022 16:02:06 +0200
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
Subject: Re: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Message-ID: <20220613140206.GA6910@blackbody.suse.cz>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org>
 <YqYlOQjKtQCBsQuT@slm.duckdns.org>
 <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
 <YqanEZZooeZwtutA@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <YqanEZZooeZwtutA@slm.duckdns.org>
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 12, 2022 at 04:55:13PM -1000, Tejun Heo <tj@kernel.org> wrote:
> But how would that happen? A lot of other things would break too if that
> were to happen.

cpuset is a threaded controller where the internal-node-constraint does
not hold. So the additional condition for cpuset migrations is IMO
warranted (and needed if there's no "fall up").

Michal

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYqdDXAAKCRAkDQmsBEOq
uVxRAPwMiG5QiY65xj/WyfY3nCUyKyx+lDQh6bCpufc5IIQORgD9FIrNztTt7lmR
ic79LsvKPERP5RiY2PezetNtf5xH9wA=
=VnhP
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
