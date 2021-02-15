Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75231C2E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBOUXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 15:23:43 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:38162 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBOUXm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 15:23:42 -0500
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 15:23:42 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Type:In-Reply-To:MIME-Version:Date
        :Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=THNeaVhQfRNHaV4Gi16tRl1Y+6uruUekobevPOEs+6o=; b=FioPIkE2vyOVSEe8mMUwdzyS2
        DBTQBX7s5MsaQyo0gLiPvy/6rfwH8GHdAAHw+j+we1bH63zhmCFXuqJQ1hjyxCsExHzUwWUnr9Nub
        c8HDlr9iO6NSaaNdDbL2cQV8wxhoMUlH5VXGi0/b3TTaabXbqjpZo9p0iDQCxgLPVlR5c=;
Received: from [10.69.139.110]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zfigura@codeweavers.com>)
        id 1lBk8w-0005zX-VJ; Mon, 15 Feb 2021 14:06:51 -0600
Subject: Re: [RFC PATCH 03/13] futex2: Implement vectorized wait
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, pgriffais@valvesoftware.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-4-andrealmeid@collabora.com>
 <87ft1xw123.fsf@collabora.com>
From:   Zebediah Figura <zfigura@codeweavers.com>
Message-ID: <477b370d-575d-717f-ee49-9f1e30c737d5@codeweavers.com>
Date:   Mon, 15 Feb 2021 14:06:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ft1xw123.fsf@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YD7FITWQpxMwPzGaESCaFtGIqW9Tn7b0R"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YD7FITWQpxMwPzGaESCaFtGIqW9Tn7b0R
Content-Type: multipart/mixed; boundary="im3c95DtmoEvwc5QqgD0T4deWJ2XtLRrs";
 protected-headers="v1"
From: Zebediah Figura <zfigura@codeweavers.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernel@collabora.com,
 pgriffais@valvesoftware.com, joel@joelfernandes.org,
 malteskarupke@fastmail.fm, linux-api@vger.kernel.org, fweimer@redhat.com,
 libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, acme@kernel.org, corbet@lwn.net
Message-ID: <477b370d-575d-717f-ee49-9f1e30c737d5@codeweavers.com>
Subject: Re: [RFC PATCH 03/13] futex2: Implement vectorized wait
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-4-andrealmeid@collabora.com>
 <87ft1xw123.fsf@collabora.com>
In-Reply-To: <87ft1xw123.fsf@collabora.com>

--im3c95DtmoEvwc5QqgD0T4deWJ2XtLRrs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/15/21 2:03 PM, Gabriel Krisman Bertazi wrote:
> Andr=C3=A9 Almeida <andrealmeid@collabora.com> writes:
>=20
>> Add support to wait on multiple futexes. This is the interface
>> implemented by this syscall:
>>
>> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
>> 	    unsigned int flags, struct timespec *timo)
>>
>> struct futex_waitv {
>> 	void *uaddr;
>> 	unsigned int val;
>> 	unsigned int flags;
>> };
>>
>> Given an array of struct futex_waitv, wait on each uaddr. The thread
>> wakes if a futex_wake() is performed at any uaddr. The syscall returns=

>> immediately if any waiter has *uaddr !=3D val. *timo is an optional
>> timeout value for the operation. The flags argument of the syscall
>> should be used solely for specifying the timeout as realtime, if neede=
d.
>> Flags for shared futexes, sizes, etc. should be used on the individual=

>> flags of each waiter.
>=20
> Given the previous proposal from Zebediah, one use case Wine has to
> support is the ability to wait on all (instead of any) of a list of
> futexes .  I suppose that could be done by a new FLAG_WAITALL passed on=

> the third argument of the syscall.
>=20

I don't think that such a feature would help Wine very much. It doesn't
fix any of the correctness problems with the futex-backed implementation
of NT primitives, and given the rarity of the wait-on-all operation I'm
inclined to believe it won't help performance either.


--im3c95DtmoEvwc5QqgD0T4deWJ2XtLRrs--

--YD7FITWQpxMwPzGaESCaFtGIqW9Tn7b0R
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEENTo75Twe9rbPART3DZ01igeheEAFAmAq1FkFAwAAAAAACgkQDZ01igeheEDD
pgf/UZsRTKEYS9RdUKWBLnklrrwp9A3vOUZ753KcizEr75b+hmvxO5uWSrOctvw2d5376d4kYLN8
yXqo9+C3PGb9FhjxboVA/JhDxhHnNO+aoZFZj8qTYwdNUKUlu/I9ysXKbwWjqbb+DHejGcX8uMUO
SYJAgMGG/VIOOnSAsnq/rxPFzw36phMy/Sygi40Sz7l73U3WoRkKcsvAc8uPxKxXaGJpzBekqQww
6i1mTp/EwLqp2+2ZisaBMr42zVz3MgBh7NSDYftIZR6GRYdtcEw7uuCTs4bEX85lEWeTQL9Guw9x
XtcG+qOetL86WNk9rfN565MoMUjCqlPWGjwqXFFzTA==
=Vw7p
-----END PGP SIGNATURE-----

--YD7FITWQpxMwPzGaESCaFtGIqW9Tn7b0R--
