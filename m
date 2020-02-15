Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D957C15FE22
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2020 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgBOLco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Feb 2020 06:32:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:39455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOLcn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Feb 2020 06:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581766354;
        bh=pOPA4vdkKum60vU2Sw008KD8mzmXUtj1ve/fnDeNt4o=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Qf0utu9Er9uCdJjAwIzlzWlVbbgyK77QXdz28zP1NE6MmoSGyV4BTiZDEAUycMdKC
         ChVzDBXeqTF3HN0gASznRlZucFRzgNYRHRFa/nHVwUQU1UUixmYr11MGwpE5pFWC4n
         5sKGsOezwDtIFumElWLBjjs4JNIjnGKo7MAag2eM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([146.60.76.54]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1jGQM11c2p-00HKFQ; Sat, 15
 Feb 2020 12:32:34 +0100
Date:   Sat, 15 Feb 2020 12:32:31 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        Tim.Bird@sony.com
Subject: Re: [PATCH v3] Documentation: kunit: Make the KUnit documentation
 less UML-specific
Message-ID: <20200215113231.GB2031@latitude>
References: <20200214235723.254228-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20200214235723.254228-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:rGamt5ZN+2JamTtxWa+949Bwc4ai74Nlldylw7ATa7hNww9D7BE
 /bziJu0IK7eIOEiblDQYdQvIiKXW/z+dRk/GH/2ESakG545IBuzDzYU1R9YY3ttXbj9r2P7
 IYOjeUjc2quFYT6rlom6QWid4LXtrAm8OSawzbeqiKK46W2hYLkL3Lu/UzlqENMmcY/rN7S
 DPjN9jGvI6ZMj+Hdd62OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l56jit/555c=:OJcEhGVVIC44B/SxTchbcX
 Fr8/OnlUjSULPzJDoaXWtq33lqaLjHW3/2u8N7nVjjkVNOZoyw4ryZtXv7ezG8lbiDk1F5e2b
 mNExcqwEkFKiGjtnTyHU1icDXMbf/D2OSsTi20uBf0zNGBW3/p/gX+vwzeZZ/+rBbd+XG3XbN
 btjhXaZPCqQQSKSpz4+kAR52llMT7pw3jkYlBaKSo391QF+qDQdX6qLFJip+Ss1OtuF2bHzAz
 7Uylg6+/4Y+mDNl6HpwHnQyYtbqvAe4BJD9Dfof2CQNL3pGrhMZxw9A0CdY6i0VQ/vigo4w5j
 2qZIIQCeSZBvvmFmTwHeSCZHErUSGFWFKoRAFEebxz1sW6aYS9Q9boOakVKf3OP2Y/o7wSJrA
 gvjPQW/4Ptz3LmkfnzqNDyuVzPBw1XoJrmKcBbE3ZAFgndf0IGPU46SykodQ9nSNuL0X9BMlh
 PeRDhtWBRu1VKOyh3E4wmMjoExvS8nsykk07VmioJpZIJBVou+IW0KEfhf+fZWBh+vd/ajGuR
 N8tyx7flL1sSZKhc6YBzUnyY1FZzpEzo1O3x9ws6zI/dxLL3JpesUZ6tMyyhUMaUuI3ghPBgc
 /qiBS5Zaj392Vot3z0oyKGLFQTAogoxKGVz2d0SakOSIy8tS8VV+2wV89sjFmkl2VrLHERI14
 3123MROhEXUYAlnl794FwZWXMmRJD5uRI3TqaCtghfhjtC8ByYR5pRBTseUdD0EGP1AJxRk1P
 mmvrF/ldCS1zzWQ97X7t8hjeBV3cCHzg7ODv/U3YWCtfxKmMi0YfFXuOCFm8pahxg9wy121Eq
 wXL1iG3dlT/im9vzNj3zLMjA3AbhkPM3xrXjD9WllZBd2WxG//uNI3FdX4MgEDzYkI/Dg0rP2
 jxeM800TA1zyISpGmKTtUo30Sup1bzhYAnYTRDcp/j/Hqdqx6cAcya4mD/7EPhXAg4Bkr3m60
 sHx4MeYL3LRg+nNNWfJRuCNKVqOJjTEbcB3zDvMYWcsbDfr9xLsCKrJZVIrn5lMM59zGOGVDY
 FJmbACqTT3wdV7mDfuSGCDnRZJOGQMv6dQMZF1NnEmRMghHEWKOnDAzulZhIbMbIv5M6EN/9s
 mocio8OP8kgpsfFziQOu35hb3rLIJy60Bwr9yLJqCykRsgCPjEKyswx/2PwVDiMolJ146pf/T
 bFxILHzLeHppk5AVvPys5F1rs21pULO/v0ZQCuseO9SehJf/MxXRW2npjTp8d67Yigt589/ry
 2XUOug4X8C71RUIpp
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2020 at 03:57:23PM -0800, David Gow wrote:
[...]
> +To make running these tests (and reading the results) easier, KUnit offs=
ers

There's a typo here: s/offsers/offers/


Thanks,
Jonathan Neusch=C3=A4fer

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5H1sgACgkQCDBEmo7z
X9vbGA//YSsL2+AzYJ+tyrjnjNWwnhgSigy7m6uufz/KqC0eU8Sfs6UXO+GwwnvD
SoqCqelP5QF7zyeGZT3mCFfl7XbfcIzK1xTfyxEEr9MBvCQRKDvXjxQbNS0rahAm
2V0YppxFHu05UNrc/FNpEsCvHoYQwd/91N8iJkIIknAPn/lcMdrJQIjqXuuuyCQd
QmawN8LZOh7dZwAxjIGCXFlP5ip7gHcLKzi+my0gtCs2z7yYrUm9jBNZfyut2Lfd
VUVOP7sYqXzMc0P0WpAd/5f5ivwKortWo6J2wK++trbpEIXjMvqx2dR1DA9n6SKb
eGYhCDzEdxhlw7bU9DPdT75yo36zk8HlWmFxvC7Cg5TSoqbJEHHSQDRUd2VSoNVb
ACRLtvGtpOhd4s0aaR9uPt1Q6Fs2c6vqAh3hPSEM8684rB+71A8R3U+KcSj3Zjus
b8KnOsIGIV8Vwt1/q99AXXMrGrQ2ggya9i692yD8VvCBWygA96CZ42bdUwMKSbjn
dcWIe3bL16ZXDRrf3CeNDNOQ3znkixw1J4aaRJ31PxuvKZGX+q9RerhwVf2ICtut
5Aop/DS1pULN6D5Mcm3FPDk3Ank6c4h/pTtgsVXj3PjB74WNr5Iyt45VqBd0UqqG
FqmVBpkZb6MKSepIXWBc7kz9RwPmW4hVngIwt9a/KRXBZCmwshQ=
=awkR
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
