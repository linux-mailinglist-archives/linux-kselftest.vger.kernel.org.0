Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456A3D7234
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfJOJ0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 05:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52530 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfJOJ0D (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 05:26:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 489D9AC59;
        Tue, 15 Oct 2019 09:25:59 +0000 (UTC)
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
To:     Tim.Bird@sony.com, jani.nikula@linux.intel.com,
        changbin.du@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
Date:   Tue, 15 Oct 2019 11:25:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm
Content-Type: multipart/mixed; boundary="e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com,
 corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Message-ID: <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>

--e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 14.10.19 um 22:48 schrieb Tim.Bird@sony.com:
>=20
>=20
>> -----Original Message-----
>> From: Jani Nikula on October 13, 2019 11:00 PM
>> On Sun, 13 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
>>> The 'functions' directive is not only for functions, but also works f=
or
>>> structs/unions. So the name is misleading. This patch renames it to
>>> 'specific', so now we have export/internal/specific directives to lim=
it
>>> the functions/types to be included in documentation. Meanwhile we
>> improved
>>> the warning message.
>>
>> Agreed on "functions" being less than perfect. It directly exposes the=

>> idiosyncrasies of scripts/kernel-doc. I'm not sure "specific" is any
>> better, though.
>=20
> I strongly agree with this.  'specific' IMHO, has no semantic value and=

> I'd rather just leave the only-sometimes-wrong 'functions' than convert=

> to something that obscures the meaning always.
>=20
>>
>> Perhaps "symbols" would be more self-explanatory. Or, actually make
>> "functions" only work on functions, and add a separate keyword for oth=
er
>> stuff. *shrug*
> My preference would be to use 'symbols'.  I tried to come up with somet=
hing
> but 'symbols' is better than anything I came up with.

Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
imprecise as 'functions'.

Best regards
Thomas

>>
>> Seems like the patch is way too big. I'd probably add "symbols" (or
>> whatever) as a synonym for "functions" for starters, and convert
>> documents piecemeal, and finally drop the old one.
>>
>> The scripts/kernel-doc change should be a patch of its own.
> Agreed on these two points as well.
>=20
> Just adding my 2 cents.
>  -- Tim
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI--

--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2lkKUACgkQaA3BHVML
eiPfCAf/W0bkytCWyMq99ercABUIKnlOK53TBUZ9NR3Teor0EJtwx1giKdxBOLbe
qAjTTABU3EcEtmCxmmsKLUEyDrBEmK+/T4YDbASwYt9qSRZQ5rJXRY7RrTsiIfkF
TWYe27RbVMt7Vn4UC1f1FsShMPxv6fIrpyNoXtB8cCE/aFSLpdPafv0zNxvHFBe+
SnDdVv+dR767Yhm8etpDlgpFtAD03PTH4hN+ZD9dLD/qgJh7NQiI1zyirt2ns6kv
2RhyIDmEVltSEhgVDCMg+LOZG41UNmIqpjgNEUF1ReeJeYX3MecovgE4mdzYA4TD
7q4r9GeyLGeoqsEUu0A4mGRY+ZBZ8g==
=b8IK
-----END PGP SIGNATURE-----

--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm--
