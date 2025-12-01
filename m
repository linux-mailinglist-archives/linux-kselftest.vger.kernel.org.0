Return-Path: <linux-kselftest+bounces-46841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB843C98E7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46A2B344DF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E521A457;
	Mon,  1 Dec 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLnN8BBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDA219E8C
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618433; cv=none; b=mcxsd+v3SyZCRfRx+VFtUXKFRimBuoBUxKwb0lREVrUHNUsHyYMplK6MKclWAAUN2QWz0oxC4aZb/DHnnkD2lPZ0N2jLCDPDDa2XLGN8KMMnfGwc7eLnoyjw9PpBMIehxwaEf8gI8SiZmbxN/0LPN2NrBvropk2Xxni/JzOk/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618433; c=relaxed/simple;
	bh=LJRlCtDhlxqTwP8EM/U7e3Hdu1O1z2s+L3WXm2KX0sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFp2aI+mSKJB8UvXTaNj3lqmgWJSm9+JaOzKTTADi9MD1/5EUwePPzWlgJ9JGJp74C3IvKnC/cqz0eCQ8B69bD3N+a3ftcGNSvtsba8ngHm30LZdAqxKUGokJXNykshIXkpqPzNr8Hx5K70rPyUH5nz6Ncx1c4FF0wEphOxRZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLnN8BBu; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e19642764so3315610d50.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764618430; x=1765223230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdF+wFbCafRAav8E0rs7m4ujJw3Abo7ahiUQFexsiII=;
        b=LLnN8BBu0YKEtr2/ZyO4u1WZducwwH+JoykPRtt4EzxpA/0M2H6QLj7wVznvYm6V5k
         +no51ha3ICkeKjaU8Qe6Z8zZSBtMb0PceGzX4nWbTe0m9we0IlROI240j/2BX8q7bPZN
         URm2Hgu8BY39ZurKGl/f0rGUF9SaT3SSI+BsvG2SZc/Hg+BDOka6oDcKABqBKown/bsa
         kUfwU/B7bazrk7T1vY/+aGLXIROTVYkE+HvEyuSt2CuTb9Pby27r0QkEL3HlVif9E0i4
         rPMeOL560jXPouoePWxGaJYb6EFK91Rez9zftcy1gM3x172KSSOGNVrYDK0D2B/wULxz
         pJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764618430; x=1765223230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdF+wFbCafRAav8E0rs7m4ujJw3Abo7ahiUQFexsiII=;
        b=xF+dfXpo50cDTq/L61ydn1LgpGIndct5AP3InnjUUfLhhpTxmY9XHELaTQEDoCioLx
         ddDBKYfRsTRAOLBIHVNRejliIJkQWLLv87FLQp3gTjqCuCsBVggaYxFmhSc0iUkd63sQ
         mBStiTidkjOnn0fOd9oGZoJ5NAxeO5QQalyGTzXF0U2zmlmRrxxsUg97hn+pHtO4FTPJ
         a/JGFBrJTj1TQGFJU7wQlOL3C6segqSSdZy6axoVMchZ1irdhEfKNMFWxYZHP41RpsJc
         usmOZhR2A1ZFK8pUYcil+hJNwMFps4bsc+jwQwhr6mgS2/A/zUL20rOeOuuxSKSahXwv
         4+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVTP8bJeuI9BlhmnEJoLi+ocHg+K4k+gluF2VSJ5CmFSCZ9J2rIprXvLjfkuj5i+CaKwhPMCuH9eSWWkYeHFuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEaT2dss21+hQDP9y7CPtIne13Q0WnGes9aOpWfEeut0cELtxO
	S2anAcnsEF0S5yjTxGx07HEjfrdQokZIgo0KQRjz17oC8jbsPgXi7Nb5vCuuf08bNcrXpFNRfBx
	0/7G0vv5mnw7ZN+i8XWhjCJe1u6ImPNE=
X-Gm-Gg: ASbGnctXHMpHQPmNrQ4R2sbLrYYjlj32AsXDKKzNptwJP2y7nab3TbdARmzPLwKGh8R
	CEjMHMHNfg9uvQ5+VTEIQP4RaFDD2JsH9iRdnrfvdiivVrh8dmKYeE/vbaHx/ntgNaHwhyfE8VA
	kYduYn+21/KUj00QUOgpaNzP9LUhz4UXCJxFnxYnQz0fupGAsRi3pe8XkvMjI4c7RRr/sla8/fW
	6PzxrWCzg4ksoK6RHMrXNPKoD6GAVJ8y8lHFvBBWdyZs0Vh+Xdrx7pCnJF6dAlDaJLRUQ==
X-Google-Smtp-Source: AGHT+IEbgJrieBu9v966cDiQcL7TS6d+UQMGUfGhVLrpWM3ttYa7ssWW1Wzu7PmnjZr63p2JscrE5eIs4MP/V4pxTu8=
X-Received: by 2002:a05:690e:1347:b0:643:2169:d6cf with SMTP id
 956f58d0204a3-6432169d875mr20321328d50.66.1764618430320; Mon, 01 Dec 2025
 11:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
 <20251201102817.301552-4-jonas.gorski@gmail.com> <aS2j_BsYHJ3MT41o@horms.kernel.org>
In-Reply-To: <aS2j_BsYHJ3MT41o@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 1 Dec 2025 20:46:59 +0100
X-Gm-Features: AWmQ_bnfISX0h5mgLmPVNe3UZpFo3rQtqHEc0AW9QXkE-jpTVrrwCpNFWKYfZWU
Message-ID: <CAOiHx=kOL9h_PE0UyzcV5wT-b+6pGvZh-joyRR4hzRLCyHOvAg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next v2 3/5] selftests: no_forwarding: test
 VLAN uppers on VLAN aware bridged ports
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 1, 2025 at 3:19=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Dec 01, 2025 at 11:28:15AM +0100, Jonas Gorski wrote:
> > Add a test (mainly for switchdev implementors) to test that multiple
> > VLAN uppers on a VLAN aware bridge for the same VLAN do not enable
> > forwarding of that VLAN between those ports.
> >
> > Since we are testing VLAN uppers, skip checking untagged traffic in
> > those cases.
> >
> > Disallowing VLAN uppers on bridge ports is a valid choice for switchdev
> > drivers, so test if we can create them first and skip the tests if not.
> >
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> > v1 -> v2:
> > * new patch
> >
> >  .../selftests/net/forwarding/no_forwarding.sh | 89 ++++++++++++++-----
> >  1 file changed, 67 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/=
tools/testing/selftests/net/forwarding/no_forwarding.sh
> > index 694ece9ba3a7..c8adf04e1328 100755
> > --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> > +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> > @@ -1,7 +1,7 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -ALL_TESTS=3D"standalone two_bridges one_bridge_two_pvids"
> > +ALL_TESTS=3D"standalone two_bridges one_bridge_two_pvids bridge_aware_=
vlan_uppers"
> >  NUM_NETIFS=3D4
> >
> >  source lib.sh
> > @@ -90,6 +90,7 @@ check_rcv()
> >  run_test()
> >  {
> >       local test_name=3D"$1"
> > +     local swp_uppers=3D${2:0}
>
> Hi Jonas,
>
> Should this be as follows?
>
>         local swp_uppers=3D${2:-0}
>
>
> I.e. default to 0 if $2 is not set,
>      rather than take a substring of $2 at index 0 (which is all of $2)

Yes it is, I fat fingered that (or cold fingered?). But since bash has
no abort on error enabled, it just chucks along and works by accident
anyway (there may be some complaints on stderr).

Best regards,
Jonas

