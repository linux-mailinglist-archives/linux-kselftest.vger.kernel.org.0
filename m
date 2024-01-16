Return-Path: <linux-kselftest+bounces-3084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100782F2A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970FD1C2320C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA421C69E;
	Tue, 16 Jan 2024 16:52:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285C1CD01
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-CIr4UeMUOAeu9U8zNHxWyA-1; Tue, 16 Jan 2024 16:52:43 +0000
X-MC-Unique: CIr4UeMUOAeu9U8zNHxWyA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Jan
 2024 16:52:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Jan 2024 16:52:25 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Muhammad Usama Anjum' <usama.anjum@collabora.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests/mm: switch to bash from sh
Thread-Topic: [PATCH] selftests/mm: switch to bash from sh
Thread-Index: AQHaSFsmDX3I4Kn9G0+MfyGy1cAOzbDcpaTg
Date: Tue, 16 Jan 2024 16:52:25 +0000
Message-ID: <0d5811eafd00496d98e88afe847fb8be@AcuMS.aculab.com>
References: <20240116090455.3407378-1-usama.anjum@collabora.com>
In-Reply-To: <20240116090455.3407378-1-usama.anjum@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Muhammad Usama Anjum
> Sent: 16 January 2024 09:05
>=20
> Running charge_reserved_hugetlb.sh generates errors if sh is set to
> dash:
>=20
> /charge_reserved_hugetlb.sh: 9: [[: not found
> /charge_reserved_hugetlb.sh: 19: [[: not found
> /charge_reserved_hugetlb.sh: 27: [[: not found
> /charge_reserved_hugetlb.sh: 37: [[: not found
> /charge_reserved_hugetlb.sh: 45: Syntax error: "(" unexpected
>=20
> Switch to using /bin/bash instead of /bin/sh. Make the switch for
> write_hugetlb_memory.sh as well which is called from
> charge_reserved_hugetlb.sh.

Why not just fix the script?
Looks like most of the [[ ... ]] could be [ ... ]
although some might need to be [ -n "$cgroup2" ].
The delete the 'function' keyword another bash-ism.

It's not as though you are trying to run on a system
when /bin/sh is a traditional (aka non-posix) bourne shell.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


