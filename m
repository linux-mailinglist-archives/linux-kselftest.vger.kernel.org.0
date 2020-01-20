Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917E6142E31
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 15:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgATO44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 09:56:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:45734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgATO44 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 09:56:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5B61AD00;
        Mon, 20 Jan 2020 14:56:53 +0000 (UTC)
Date:   Mon, 20 Jan 2020 15:56:48 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, alex.shi@linux.alibaba.com,
        Roman Gushchin <guro@fb.com>,
        kernel-team <kernel-team@android.com>,
        JeiFeng Lee <linger.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, Tom Cherry <tomcherry@google.com>
Subject: Re: [PATCH 2/3] cgroup: Iterate tasks that did not finish do_exit()
Message-ID: <20200120145635.GA30904@blackbody.suse.cz>
References: <20200116043612.52782-1-surenb@google.com>
 <20200117151533.12381-1-mkoutny@suse.com>
 <20200117151533.12381-3-mkoutny@suse.com>
 <20200117172806.GK2677547@devbig004.ftw2.facebook.com>
 <CAJuCfpFqEUVFXsjD8XcCKsGXKTf72r0Ek5_1yqu_k5UZAssKTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <CAJuCfpFqEUVFXsjD8XcCKsGXKTf72r0Ek5_1yqu_k5UZAssKTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2020 at 10:41:29AM -0800, Suren Baghdasaryan <surenb@google.com> wrote:
> Tested-by: Suren Baghdasaryan <surenb@google.com>
Thanks.

> > Yeah, this looks fine to me.  Any chance you can order this before the
> > clean up so that we can mark it for -stable.
> +1 for reordering. Makes it easier to backport.
The grounds still need to be prepared for css_task_iter to store
additional information. Let me see how the preceding changes can be
minimized.

Michal

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4lv7AACgkQia1+riC5
qSjnlQ//WGljOTcfv0L0yWBKqXL3O0PLyuPdsN+7v3R9YLMlZy1NE0YMJjm2cbii
cC0lB8Lr4kg8R1IuUh8Iks+eIFNGMmBRzxChxzm4DTEPkB6i775f67ELwxWw6xFD
H/oHvQKfvQUt3r/vVfyG8bRsJvpLjVViiRq1fy6SkX0UgVuDcchKFYOUaeaJAcB/
d7JRVvtvyV11ruAKx7nK+GTBhCLCdgcqh4ZTKEc2dtB7CWp7JCHKbyw5Y/sic/zc
XDilupblbFI6zerlS6ojzptQbuMPdZ09dG/e2xJK9K/crVaE837opkVISg0MPzrc
eDdXKz3j5P/koE5nvwfv+GCuZ1hIqn8asmmrn6hwl2RMeb0I6ah4hVYTEbPJ/d8v
wB9csLCQDFJx/meZfuESumssrCofS++SQfsQR43lR8oilNefg2j+EZgcOHOfVYY/
iHu8M3RR1ClosYvjNIs0sU/i+9s2jGZpCfA0P0WWbSLPMvMSt/Gx+TE8iiHAaztb
G/lCm1cvWIEWcXbGvRG91YjKDWMxqTpV9ZceIyEMKQudqpYyTFQr4QBhdE+djb1r
e6+88ykq8nYxT9G1SDcYCA03OyouKIm5TBfObcdvZptAh2szrI9cATC3lEz/Dj4f
cfvdIA0PwZgLaccFAIc75NAY6IQJhcK/t6rqsE2fxiEofvrfiXI=
=VU1C
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
