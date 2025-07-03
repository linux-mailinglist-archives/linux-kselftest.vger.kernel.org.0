Return-Path: <linux-kselftest+bounces-36478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E48AF7FF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0156E0631
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849982F94B8;
	Thu,  3 Jul 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="QW5qVGwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304A2F2C57;
	Thu,  3 Jul 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566896; cv=none; b=P7g8KvJVBuxsDyGvpS4pUx9xVJhftEafe8tTzO05kN0ahZ/YqlNaFZZ1yCA+Tu7l5gS4eCRcJxVjBWnfIKapuGqYGsVYCPC7iNgt9TLjXQWyQ1pQySzRtjc7aIvf/Q/Zygj+HrCPaf2PWKUaOIuTEqJvcDDLYyOqhPW900R9t6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566896; c=relaxed/simple;
	bh=06IeWF9g6Lb/SjkAAwsA/jpMDxmYsB7Fb6EiMaWIDz8=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AeoQ4Bd6qO4kGa/Ncut4bIapim49idZUO8g/vZF6aJuqJbIFKbj7V3XJr5zJpkEIsbLkdMykYUcjsCiOaQMfKsRetAhxy5IncIjmUcmiUceoupBmaFq3HuYf8dEw5a37QF6cna7808zC4zEBMuu6YjqNO8TX1LnWleKnmIdigr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=QW5qVGwH; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566893;
	bh=06IeWF9g6Lb/SjkAAwsA/jpMDxmYsB7Fb6EiMaWIDz8=;
	h=Date:From:Cc:Subject:From;
	b=QW5qVGwHCDUGU4UUj6IZGMufAeyWhcUAQSjuHPUXDZcURwGz2dSgu6Mr+qkjS2nVT
	 s+uUcyFoKFsQvnK9P3+Og6o852nJpDKUjMknmlLON4qW+FKRuasxn1G+DVaNVy80qF
	 HxjuTOxsFBJ03ydPX5h+oxEKBBJWXmgF6NkTB9LWUNejLE0CbPdLCKaC9Hw4VKkLzG
	 4F2SJzWs+NctD+Vgar5aSqPMXlRzxOcxfN28+x54CEGXmbaNzjtM+dUQgKRK+yvGEC
	 zwvCTZuwCzWiLx6gqPQN3XdjDQGYzxSe9Ul3bLUm7uwyoVfbOYiNgKs36ucGefqFrJ
	 6CvjWRebfxxtA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3455494E;
	Thu,  3 Jul 2025 20:21:33 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:33 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/powerpc: fix "for a while" typo
Message-ID: <mt5r57q2pgllk3gy4ayasoymkdeqocqbdlkm3mw3mb3u7h34ms@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kbtponqicmp274g"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--7kbtponqicmp274g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/=
selftests/powerpc/tm/tm-tmspr.c
index dd5ddffa28b7..0d64988ffb40 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -14,7 +14,7 @@
  * (1) create more threads than cpus
  * (2) in each thread:
  * 	(a) set TFIAR and TFHAR a unique value
- * 	(b) loop for awhile, continually checking to see if
+ * 	(b) loop for a while, continually checking to see if
  * 	either register has been corrupted.
  *
  * (3) Loop:
--=20
2.39.5

--7kbtponqicmp274g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyiwACgkQvP0LAY0m
WPH+fhAApqheEM4jQWQXOKaysF1B5Qibd8R0hWrB88uMXBRia/CSYfa4ZePI1+0D
mB7pe+lSIRuu6uQ1ZfHtrZoIKEVe0a+bTPU1BN7vdOjaLb6xn9dtgLhPZMzP0Atw
apXhRayZTOeUmFSwzCj9xrpExIRQiAnfN9wiXxcYgnRnkOQ45z7aOib8yDiq4IRA
qWcPOm6l7ONolQleJ+aQsL2ETGSNRyy2qmgOFLbvN6jEJH+rcioGZurKo7f1wULw
bqxIK7KuL8pVCaDQIf3xnl6et9aY76CNiXAWtlzfhtDSkgfKIosjA6PhlSe6okkj
gMHM3ooWtp5RTfZ91Dlfu9udxVvmwA8leX+22FbBoCCO4h467fyLXD+VsuYFPtl3
DRndFOA18ryQitJuaws8lLIhxIrVwq6p+hApAcHAI/pWG/agoPdYwh0TK1m6MOVS
Tbxg9Bejvw8Jzw7QldxM42xyKDX3FGZ2+Kiu1WHvu745RDFaqRsynJqh1BMtQ0GI
cLMME8tGUs3lmQEG225oyZkmIZ38jzE+wL0pu5QACEeWB+qXReYxzLIwKEpJgG2I
MX1sLLB6YMEkbNRYu225jZuOGvfgV+wQ28Xrbx+H+RizWVQXhnIWijs/YTiEaRpf
VPMW2MdOoVnIZ946db7bE7uEdkGl7gz+jELAMILMnSkclKTWze8=
=pdeB
-----END PGP SIGNATURE-----

--7kbtponqicmp274g--

