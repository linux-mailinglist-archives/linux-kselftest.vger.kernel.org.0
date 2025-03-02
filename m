Return-Path: <linux-kselftest+bounces-27979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1FA4B3D4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2119A188F579
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3461E98FB;
	Sun,  2 Mar 2025 17:36:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A9C13B
	for <linux-kselftest@vger.kernel.org>; Sun,  2 Mar 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740937012; cv=none; b=bmQqkKHP8EVmVEFU5WpRL5PhQzZA/pE1UBzoS0TMFwTKfqrL3Jz8PULvT/7y3lyPPLZVd0Y4z0yh2k4OsM+E2J9S6nWB6tBOrHp015OELRaeqdUZvAR+du6E98y9u+V3Q8gxsIfb/ErYOJ4ycJhAFrpk1ZMSVPNS6ko22K129Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740937012; c=relaxed/simple;
	bh=fZlCL3tgFWd+ewz/ksj/DhebgJDZ+jizwASouF5/ng4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rF1vkKkBDVYMQDvcb/8vgFPtOb3U4yo50DSDox3S2kRSpwpCqde5ZcZU8xZuvquRDUaEO0qug42xEq+8AwzGAEvBHj+ca+K5EYAA03lNHAtqC4ydpPB0L+S7AeAz+a8j6k+SrHiho7dJotaZcxWSraJm67Hj7r4d2cGjgwG9Law=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tonF5-007SoF-2M;
	Sun, 02 Mar 2025 17:36:42 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tonF3-00000003rL6-12qI;
	Sun, 02 Mar 2025 18:36:41 +0100
Message-ID: <7286c87d1ad7b705d123f23ad213ec40a9f23351.camel@decadent.org.uk>
Subject: CVE-2024-56741: apparmor: test: Fix memory leak for
 aa_unpack_strdup()
From: Ben Hutchings <ben@decadent.org.uk>
To: John Johansen <john.johansen@canonical.com>, Jinjie Ruan
	 <ruanjinjie@huawei.com>, cve@kernel.org
Cc: apparmor@lists.ubuntu.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Date: Sun, 02 Mar 2025 18:36:35 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Z2ofoIoxQj9X1BsaAHHv"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-Z2ofoIoxQj9X1BsaAHHv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

CVE-2024-56741 is supposed to be fixed by commit 7290f5923191 "apparmor:
test: Fix memory leak for aa_unpack_strdup()"=C2=A0but I think this
assignment should be rejected.

While a user-triggered memory leak may be exploitable for denial-of-
service, the code that was fixed here is a part of KUnit tests.
KUnit tests usually run a single time at boot, not under user control,
and can then later be invoked through debugfs by the root user.

Firstly, it is intended that the root user can deny service through the
reboot system call, so I don't think additional ways to do this are
security flaws.

Secondly, the KUnit documentation at <https://docs.kernel.org/dev-
tools/kunit/run_manual.html> says:

    Note:

    KUnit is not designed for use in a production system. It is possible
=C2=A0   that tests may reduce the stability or security of the system.

so I don't think security issues in KUnit tests generally deserve CVE
IDs.  (That said, the help text for CONFIG_KUNIT does not have such a
warning.)

Ben.

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-Z2ofoIoxQj9X1BsaAHHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfElyQACgkQ57/I7JWG
EQnXoQ//Utms7NmGWZ5h2MUx5gI1gYg65pGmAs7q4RNtBsRw0RASrQtmIRKZx4Wg
kc4nlmB5Vl1xnigli8ukg+OjgpXJVgmtoL5Q74Ed6ru5BpNx+jHrHBVPt/3YSCoc
miObFDjPBdlbJ9W93R4FrK4guJIYo1mgjxXRm64cMt+c+cjN5KlVEXsxEPM08JHK
T0TsBzoTM2r6gmx7jfqckAExdg5ZuwmgUsOqfrpwHtkd7GmgVcT/B2Em/1ojkgn3
K5ZsEFuyAMDIK2qfeFZx+O98yPf5zW75yjffemerOZE/+rzteSaDpFA/4JXll9q4
DniGs+xfz0K4nrg+yEwVp6jEkaNss5zAEEPvo05H9vsB3jnbg+dloflX6ufJRLFy
8jYVTDduc4Q+tTqci21ws2Sj9pVJDTUxvQWS4shQZbnA2keaCz3yaiCOUdYI4/js
Jcl0LFa2UVzCBTNGzYzMaUVkqEeIwe3WINBI95JrsjsyDC2lbOFNs/AD3NHPpERm
db2jdFy0Wc6J8q/m+G7OCs6K+9HrEO850G/QgCS3Bpx8yMIxh8DViXDmHLLtWjtk
jjmHc0RKo67bySGySf3YkD9rwVnmoapGGBkd4HMcOBwiMpPaQcsJDVRjqcfipigl
DC9rHF9FTeTE1/jjMs9WYcS92TSKwevJrUzvJW0QGUpAPDSViu8=
=gStR
-----END PGP SIGNATURE-----

--=-Z2ofoIoxQj9X1BsaAHHv--

