Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBADC2401
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2019 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfI3PMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Sep 2019 11:12:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731276AbfI3PMi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Sep 2019 11:12:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 168C9AF7E;
        Mon, 30 Sep 2019 15:12:36 +0000 (UTC)
Date:   Mon, 30 Sep 2019 17:12:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        khalid.aziz@oracle.com, cgroups@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
Message-ID: <20190930151233.GH6694@blackbody.suse.cz>
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
 <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
 <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com>
 <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
 <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com>
 <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com>
 <CAHS8izM3=ZDNukx5xhWmeJT+78Ekfff9J4s5Vqkqpx-DtH=C-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline
In-Reply-To: <CAHS8izM3=ZDNukx5xhWmeJT+78Ekfff9J4s5Vqkqpx-DtH=C-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Thu, Sep 26, 2019 at 05:55:29PM -0700, Mina Almasry <almasrymina@google.com> wrote:
> My guess is that a new controller needs to support cgroups-v2, which
> is fine. But can a new controller also support v1? Or is there a
> requirement that new controllers support *only* v2? I need whatever
> solution here to work on v1.
Here is my view of important criteria:

	1) stability, v1 APIs and semantics should not be changed,
	2) futureproofness, v1 uses should be convertible to v2 uses,
	3) maintainability, the less (similar) code the better.

And here is my braindump of some approaches:

A) new controller, v2 only
- 1) ok
- 2) may be ok
- 3) separate v1 and v2 implementations
- exclusion must be ensured on hybrid hierarchies

B) new controller, version oblivious (see e.g. pid)
- 1) sort of ok
- 2) partially ok
- 3) two v1 implementations
- exclusion must be ensured even on pure v1 hierarchies

C) extending the existing controller, w/out v2 counterpart
- 1) ok with workarounds (new option switching behavior)
- 2) not ok
- 3) likely OK

D) extending the existing controller, with v2 counterpart
- 1) ok with workarounds (new option switching behavior, see cpuset)
- 2) may be ok
- 3) likely OK

AFAIU, the current patchset is variation of C). Personally, I think
something like D) could work, I'm not convinced about A) and B) based on
the breakdown above. But it may induce some other ideas.


My two cents,
Michal

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2SG14ACgkQia1+riC5
qShedQ/8DyEdvjT0PcRMLE3EjsjDi32g8BDv8aIV1H1UVciQZIM+BFvPycHsjJ9N
XwYn3bspedb10o6wm1Luj6LhXjVht5dglPSrmhTWp4E5YrLqP2AqKPt8p5ZL4pTq
L64SrAHXo5qFq85CDnSQkFgYXmuPEkM9NCdLN3Dt30P1/zr6mrt0vhPbLNwJkgdT
xsTp2UObM12TuEJxsnb2F6nirZLa6RHQ3utUjDZUsLbPOgnb+WbTgLyCNwHFnqUk
bInSN/vrHcn52yYefxWuHW1VdXXV2vpjqcQG5CdYjXEzpKQxnysI+IiYxpv4kw6Q
FQpT5nQtCVVr2EHj9LEsk9vgks2Hcfsb87psTIL0rxA4HvxiutPcDHBHqhcs/52o
2ozl8p7G0WXGYQ+bSeTBJ35O/qtTGibw1YELSkpVhG742SrzMj9SxdhtFO7dsdeY
uk/HdATsAPl3kAX1fOhUSmIcnOL9ECAO0pgcRnmsyPdXEDUWwaiji0tK9Q0yP6Wu
jnFTX3MY/Nq5FhJzZ3QYvCUxc1n1LgzW9STMUU5MuTN9NYXC4AlZnZhMqduDH5HK
l0seBNntlNnaI4lQhbWl2OR0cXTDN88Nv2bF84LBI01F4N2D/NL97p69jCMYxgUx
5EiC89zRH0RUxb8RX+NeMG/OMd0qxTNFELjONXX1D5fpzLqg5Ao=
=ksZu
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
