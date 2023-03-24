Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642966C84B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCXSTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXSTk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 14:19:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08F1F5FD;
        Fri, 24 Mar 2023 11:19:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D76133B68;
        Fri, 24 Mar 2023 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679681978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsXEmpX7jt/HfXlKrWUvTT6ogyq2n9SaBj4U2OfhPHc=;
        b=CBx76FguKcCbaNh++Rix2ar8jnobmAuieXUZZS19lXDeHSnKBM6hwUD7+5a9uveK9ryyEf
        cEjIxxsPM7+BmtmM34Of1N6aOCJDguL2vO59qwvH6JFhwoXcNxefhwQ3UGdqCSYq5lQvwt
        IPytjsmPLopWx/Ekf7gZ/Rn4Z/z8its=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A370133E5;
        Fri, 24 Mar 2023 18:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ek3SDLrpHWSORAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 18:19:38 +0000
Date:   Fri, 24 Mar 2023 19:19:36 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Message-ID: <20230324181936.5sf6xjc5a4vacuku@blackpad>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
 <20230317122708.ax3m2d4zijkfdzjq@blackpad>
 <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
 <20230324143247.GA27199@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bnv5nqjb4an3p6ze"
Content-Disposition: inline
In-Reply-To: <20230324143247.GA27199@willie-the-truck>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bnv5nqjb4an3p6ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 02:32:50PM +0000, Will Deacon <will@kernel.org> wrote:
> So approaches such as killing tasks or rejecting system calls tend not
> to work as well, since you inevitably get divergent behaviour leading
> to functional breakage rather than e.g. performance anomalies.

What about temporary performance drop from 100% to 0% aka freezing the
tasks for the duration of the mismatching affinity config?


> Having said that, the behaviour we currently have in mainline seems to
> be alright, so please don't go out of your way to accomodate these SoCs.

I see. (Just wondering what you think about the fourth option above.)

Thanks,
Michal

--bnv5nqjb4an3p6ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB3ptgAKCRAkDQmsBEOq
uVhEAQC7JaLVG3zxtIHj/KOXOqyJ40tnjVLvv86k89k+Kuk2HAEAuSkfis+4/XkR
nNuhu2FzjdRnT33UwUPZMqfuKUBGeQA=
=Ns6p
-----END PGP SIGNATURE-----

--bnv5nqjb4an3p6ze--
