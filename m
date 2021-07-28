Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F63D943C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhG1RZ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 13:25:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52168 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG1RZZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 13:25:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE0541FD69;
        Wed, 28 Jul 2021 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627493122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4z+d2ZwNRoqxW73+AMa5bSmFlzTgfCxptCbaDT+hb/U=;
        b=W2eTPAugUxJczVRyP2sMAeHaks8tARW0o11sV3lPJ0De6/bEmVKvCzl4+lxdv61v3KWrj5
        qmfjL6DjgtwwBYcvLbmzBaJ16HGAXTAH21b7yrUV2xli1avXSggtcKoSyfogCik+fm8eMY
        qyYSjIVo+fZcp95VHyImHRtliCGiGuM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 783ED13318;
        Wed, 28 Jul 2021 17:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2vE2HAKTAWEALwAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Wed, 28 Jul 2021 17:25:22 +0000
Date:   Wed, 28 Jul 2021 19:25:21 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [PATCH v3 6/9] cgroup/cpuset: Add a new isolated cpus.partition
 type
Message-ID: <20210728172521.GE7584@blackbody.suse.cz>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-7-longman@redhat.com>
 <20210728160900.GA8905@blackbody.suse.cz>
 <f1afbd9e-d16b-c972-c3c0-022a05cec2a6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <f1afbd9e-d16b-c972-c3c0-022a05cec2a6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2021 at 12:27:58PM -0400, Waiman Long <llong@redhat.com> wr=
ote:
> PRS_ERROR cannot be passed to update_prstate(). For this patchset, PRS_ER=
ROR
> can only be set by changes in hotplug. The current design will maintain t=
he
> set flag (CS_SCHED_LOAD_BALANCE) and use it to decide to switch back to
> PRS_ENABLED or PRS_ISOLATED when the cpus are available again.

I see it now, thanks. (I still find a bit weird that the "isolated"
partition will be shown as "root invalid" when it's lacking cpus
(instead of "isolated invalid" and returning to "isolated") but I can
understand the approach of having just one "root invalid" for all.)

This patch can have
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmEBkvoACgkQia1+riC5
qSjxqg/8DOuQ6BV0vUCrSyyP0k+Wyx7QwrY7UHosDiAVrUYlzfd0NEhckQf7fDr4
faf5/E/Y0t99oRaBYnPqtaqUjtiUUB4e7L/uTxrfGaeOT2SyAHjq5QHtFcdSOHgz
OfinfqEGFuMQLo2vbWtuKaPs6avaPT6443FT/WpG29FHkB7wRPuBAS0f3USLQ/F4
/GqawCdjKCZ4pP59LQpb5jSELNtQKaxe6MpZJ0tcj9JpFgnR6XZcwmxe0FP2hHtY
JzcnXUfMW3CU4yynukd5rEwrCiVS1T5w9XLh0d/MrvbamMEfwBMY8hoVH3md32X4
oTVdlW1IrKkm+VXoW/71WTzKTlkXof/MxMe52QigiOj25g+W/R2CTAoaCKVY5Ou3
RgQNljmvKmN7kh14Zc469PLC8R8t+FYVdMM4xmK+HjbFOBAaymWx6eUHejfQNba0
sgulNpYQjzeR+OBqqt7NI+KLu9s1yag6ZY+N2bUtOWxsdMjuU4vY0yWuHw+SnrTF
itkJg/NIkUmFccnq1ToOAxHyC5vA6ux8rUDBPnJduXr1czXZKi8zoy31h4uq6CAF
iWqDZdmi9dOB9A3rbjOm8BP0vHrs7s3tSLc0c4tu6VncM0mosp6dDGC8RCam3YCG
mnFetTKvSLbNBN/6k3f6nKLX6AGzNHs45EiSi7ut17NMVk5/5EU=
=i07x
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
