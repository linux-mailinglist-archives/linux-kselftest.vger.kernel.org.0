Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88954AF94
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbiFNLxw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiFNLxu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 07:53:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3B366BA;
        Tue, 14 Jun 2022 04:53:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D43451F953;
        Tue, 14 Jun 2022 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655207627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enED3+mwpyEj3HYd1xYYpNVTbgUm7frMywot5/XVq7k=;
        b=MKNAdTBQZJDywcGSMhM7eKVDS9hIFTqkt9SPhb/KumTuThcjnWgew5g35qS1WfIN35FvMH
        +jmoTfwK7Sml47xjNTXbVEOEhtfUIjQJ3l2yz4rYR/B37fK1VH4zw9FonngffORHliRegZ
        t1BTLwB3rgE1pXUmN+ycYXWzqtGXp5U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F0D139EC;
        Tue, 14 Jun 2022 11:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OdGjE8t2qGJdfAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Jun 2022 11:53:47 +0000
Date:   Tue, 14 Jun 2022 13:53:45 +0200
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
Message-ID: <20220614115345.GA6771@blackbody.suse.cz>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
 <20220613175548.GB21665@blackbody.suse.cz>
 <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 08:00:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Yeah, I don't know why this part is different from any other errors that the
> parent can make.

It's different because a write to parent's cpuset.cpus is independent of
whether cpuset.cpus of its children are exclusive or not.
In an extreme case the children may be non-exclusive

    parent	cpuset.cpus=0-3 //   valid partition
    `- child_1	cpuset.cpus=0-1	// invalid partition
    `- child_2	cpuset.cpus=1-2 // invalid partition

but the parent can still be a valid partition (thanks to cpu no. 3 in
the example above).

Do I miss anything?

Thanks,
Michal

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYqh2xwAKCRAkDQmsBEOq
uYpOAQCf85csUj8650NOSj8/SYGx1Rke2TaokzgsJH1Dl9CDigD9GRFyEDBK4gUH
O3ICbyDSHByTv2ncDcIRjpX6QGMWSAM=
=mVZv
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
