Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE83B2F65
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jun 2021 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFXMyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Jun 2021 08:54:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFXMyD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Jun 2021 08:54:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C59AA1FD35;
        Thu, 24 Jun 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624539102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OStIT+/k9HjAMVEft/RiVSrSrqRUKVMppJc/bLZhAsc=;
        b=h1TVxq0gwwlLbYqvb8tWbr/SwshfATjxvexZQDFL2biMzuzXxMfRnglO5nSJ12QdFh3lZZ
        FArNIcJjJMRUX5Blw8IDk3onyywNZfB2DYPVTIBceONow2v4WnuszUCeCPzCtPz99jrNKs
        yidy5cAz7L/uV6PBm7+zmb9Z1OtOTTM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 68DE211A97;
        Thu, 24 Jun 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624539102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OStIT+/k9HjAMVEft/RiVSrSrqRUKVMppJc/bLZhAsc=;
        b=h1TVxq0gwwlLbYqvb8tWbr/SwshfATjxvexZQDFL2biMzuzXxMfRnglO5nSJ12QdFh3lZZ
        FArNIcJjJMRUX5Blw8IDk3onyywNZfB2DYPVTIBceONow2v4WnuszUCeCPzCtPz99jrNKs
        yidy5cAz7L/uV6PBm7+zmb9Z1OtOTTM=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id p7OQGN5/1GAWSQAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Thu, 24 Jun 2021 12:51:42 +0000
Date:   Thu, 24 Jun 2021 14:51:41 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
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
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 3/6] cgroup/cpuset: Add a new isolated cpus.partition
 type
Message-ID: <YNR/3fydXvAi3OsN@blackbook>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7y/hTF6KceCxU12n"
Content-Disposition: inline
In-Reply-To: <20210621184924.27493-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7y/hTF6KceCxU12n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Jun 21, 2021 at 02:49:21PM -0400, Waiman Long <longman@redhat.com> =
wrote:
>     cgroup/cpuset: Add a new isolated cpus.partition type
>=20
>     Cpuset v1 uses the sched_load_balance control file to determine if lo=
ad
>     balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>     as its use may require disabling load balancing at cgroup root.
>=20
>     For workloads that require very low latency like DPDK, the latency
>     jitters caused by periodic load balancing may exceed the desired
>     latency limit.
>=20
>     When cpuset v2 is in use, the only way to avoid this latency cost is =
to
>     use the "isolcpus=3D" kernel boot option to isolate a set of CPUs. Af=
ter
>     the kernel boot, however, there is no way to add or remove CPUs from
>     this isolated set. For workloads that are more dynamic in nature, that
>     means users have to provision enough CPUs for the worst case situation
>     resulting in excess idle CPUs.
>=20
>     To address this issue for cpuset v2, a new cpuset.cpus.partition type
>     "isolated" is added which allows the creation of a cpuset partition
>     without load balancing. This will allow system administrators to
>     dynamically adjust the size of isolated partition to the current need
>     of the workload without rebooting the system.

I like this work.
Would it be worth generalizing the API to be on par with what isolcpus=3D
can configure? (I.e. not only load balancing but the other dimensions of
isolation (like the flags nohz and managed_irq now).)

I don't know if all such behaviors could be implemented dynamically
(likely not easy) but the API could initially implement just what you do
here with the "isolated" partition type.

The variant I'm thinking of would keep just the "root" and "member"
partitions type and the "root" type could be additionally configured via
cpuset.cpus.partition.flags (for example).

WDYT?

Michal

--7y/hTF6KceCxU12n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmDUf9gACgkQia1+riC5
qSgrew/9Hq4FG5rOCmGFt93pb5UT4E9slWA9EWdsCCpq97TsB9YXl8KsEYana9aP
4ZCRW2ySHqn0LpjKlgbYruhXX9IICNAOr6KHHKW8RgKTPnBHsXpwuhQhDJdDLQ54
U1DGX+WfTTuTFM8dO2VJcdSHl3c/7xxr1L5rp9Z3Soetzp219w6p/SE3WDZYW1Q1
ur+Yq/Fjl6x8YU/7U1c18sHP1H7xTw9yC94NxZ/gwhyJzxxR8LDWTvTr9ZJcN2qP
ywzJbuhH6dcZrAJUYbR990SryS1mDDD8nZx5iZJC005oR4m5Ce7kahU/lmv5Oe0n
TCgPjA0idwjXED3pCeARRVdl6nuFmi+hXO9SV9HpLwoDVTWF2F2g6wb49g2tkIwK
0BNtpYv2F0Mg0hmY3wCJH5IDBMkJemNgCUj+SRlwngJgYRbNcUvLmCloapbFLsC+
3JziiJqkeOhlAIfpMYHsEXV0OHDkYLuHsf5cZ/We2qFoY955niGZti9EE+rMfh0V
DNMwk7vmSSCffEFOzwP0cwGiyF6AC83JgX3eEpPAfArt+4CReEYi6r0gmdD8VYUG
8ezyxEa9/zVgARjzB5U7/7r2OSquhmEg/uKhRs/XqeFP53MyAaJnPWIEXehyIsXL
SgRvceYyw+U0Pvm/oYplJF8VLNIadWNzMOK9yqQCnNx6y9ogShU=
=SVZh
-----END PGP SIGNATURE-----

--7y/hTF6KceCxU12n--
