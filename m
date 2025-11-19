Return-Path: <linux-kselftest+bounces-45988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B62C6F632
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1619B347DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052FE34DB60;
	Wed, 19 Nov 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9oFDX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203427466A;
	Wed, 19 Nov 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562751; cv=none; b=BsOk9ySAhRyLCXZ9nN7cwhX5u72qdX+xoweLKBRq67+H7bJbR1xUX/5Qi3TWULzpFxfIWpAxQ9HRf42pXrrt99sMRsRIyBZcizOWFSKaKREX5AjzncpHixBnm2YlrsozRgMmNYBY8wUi5elhN7OywGCye+/5Pp3lIaVDkQrnyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562751; c=relaxed/simple;
	bh=Ob1I778JtaWUzduHLtEdpvWZJJtQPya1yflPRwJ06eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD15qM/XZ227Yc8a7btCPEkv+97lYXae6mTh9i81pnicRar+VJKtTP60w3yNSEWNXD1zdSdNeDtbLsdpoZa3mVNRDFUPM5c4EN5uKL2ySRrRxmci99oCDR/I1gdGNQ21uk/weLspvqRtwyQqbqjwnUjKkaK9Qqt/MXkrdENT3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN9oFDX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D78EC4AF09;
	Wed, 19 Nov 2025 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763562751;
	bh=Ob1I778JtaWUzduHLtEdpvWZJJtQPya1yflPRwJ06eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oN9oFDX43MbMGJcMgP1WaOvEsCz0Tfqz9R5JZehIUEen/GRewxuS00Ka7hKVVuJf3
	 dezBuLuQpB2irPzG2rYQFR2GMlRNssKM0rHbI0yhDw2Or9XB+PA/Oj/Ne2OWRtib7m
	 2taxhkWCGuk/NSvsAV/CR9UWIgCYJTr26FpFvPU6/M1lsWfinU2Rtw5dtVkHL9ytax
	 rHuxoVMU2bNBXlSFehsYLjYbIcW6xTyp0anINK4xZoSd5BbJJpmapY026aqjDWfOqm
	 9OSMOIe6q0DHzGRc9g4SQ6ufYA33uuKj+UdMA+L8o72Z1AjYT02BDj7n5bTKQqqtc9
	 LfnvAJMr1y/eg==
Date: Wed, 19 Nov 2025 06:32:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
 <krakauer@google.com>, <linux-kselftest@vger.kernel.org>,
 <matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 01/12] selftests: net: py: coding style
 improvements
Message-ID: <20251119063228.3adfd743@kernel.org>
In-Reply-To: <87ms4icely.fsf@nvidia.com>
References: <20251118215126.2225826-1-kuba@kernel.org>
	<20251118215126.2225826-2-kuba@kernel.org>
	<87ms4icely.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 14:40:41 +0100 Petr Machata wrote:
> > @@ -163,7 +162,7 @@ KSFT_DISRUPTIVE =3D True
> >          entry =3D global_defer_queue.pop()
> >          try:
> >              entry.exec_only()
> > -        except:
> > +        except Exception: =20
>=20
> This used to catch KsftTerminate, which we use for SIGTERM handling, now
> it doesn't anymore. I think it could legitimately appear in that context
> if SIGTERM si delivered while exec_only() is running.
>=20
> IMHO it should catch BaseException, like ksft_run() already does.

TBH I haven't thought of this. Are you thinking that we shouldn't
interrupt the execution of deferred cleanups when SIGTERM arrives?
Fair point, but I think we'd need more code to handle that properly =F0=9F=
=A4=94=EF=B8=8F
Right now we ignore SIGTERM which isn't great. After this patch we'll
no longer ignore it and have the whole test exit. Neither actually
catches the exception and sets stop=3DTrue in ksft_run()..

WDYT about leaving this patch as is and doing this on top:

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/sel=
ftests/net/lib/py/ksft.py
index 83b1574f7719..5a667ad22ef4 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -268,7 +268,12 @@ KSFT_DISRUPTIVE =3D True
             KSFT_RESULT =3D False
             cnt_key =3D 'fail'
=20
-        ksft_flush_defer()
+        try:
+            ksft_flush_defer()
+        except BaseException as e:
+            stop |=3D isinstance(e, KeyboardInterrupt)
+            # Flush was interrupted, try to finish the job best we can
+            ksft_flush_defer()
=20
         if not cnt_key:
             cnt_key =3D 'pass' if KSFT_RESULT else 'fail'

