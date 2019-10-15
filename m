Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C193D75CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfJOMIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 08:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJOMII (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 08:08:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D9E7B12C;
        Tue, 15 Oct 2019 12:08:06 +0000 (UTC)
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tim.Bird@sony.com, jani.nikula@linux.intel.com,
        changbin.du@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
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
Message-ID: <f4157a18-6c2e-9854-40a2-dd78c9bde5ea@suse.de>
Date:   Tue, 15 Oct 2019 14:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH
Content-Type: multipart/mixed; boundary="z434XuCeAEdMMPGCrDECpwMF4D7beqFx1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Message-ID: <f4157a18-6c2e-9854-40a2-dd78c9bde5ea@suse.de>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>

--z434XuCeAEdMMPGCrDECpwMF4D7beqFx1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.10.19 um 13:54 schrieb Matthew Wilcox:
> On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
>>> My preference would be to use 'symbols'.  I tried to come up with som=
ething
>>> but 'symbols' is better than anything I came up with.
>>
>> Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
>> imprecise as 'functions'.
>=20
> I suggested 'identifier' because that's the term used in the C spec (6.=
2.1):
>=20
> : An identifier can denote an object; a function; a tag or a member
> : of a structure, union, or enumeration; a typedef name; a label name;
> : a macro name; or a macro parameter.
>=20
> We don't allow documenting all those things separately, but it does cov=
er
> all the things we do allow to be individually documented.
>=20

Yeah, makes sense.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--z434XuCeAEdMMPGCrDECpwMF4D7beqFx1--

--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2ltqUACgkQaA3BHVML
eiO7bAf8DqpVa41x8h+LyR771/7XD6R9SM1oSqopIn1EaGndzepL2obOpvv7TM8J
xdFUMac1FMD7pBfjtTfs6Ax/+KSIBGMJQxiiiGhsZ2Z9RXIiNMJpVV0pFwkEBCic
Xwxmem2Hn+LhB98tlmtb1rUid5ZEWIqxJn0HEfOht/Y7iu+RZUfVre1GHP2W5OG+
KSJSTG5ZwTIBzXvMS++NOh0kJWyzTiKY7Gaxl0ck76UKp34bdsTqFNVlOqNgfdiW
tEmx0i6R/9ZZp3HGgsbN7waSqxjcYWI4M8sPApl7aPDDpTZC2ydWX1J5qzmp9/LF
uRn+WrOCEMHCMSPfYsv/311cYx9oLw==
=fbgk
-----END PGP SIGNATURE-----

--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH--
