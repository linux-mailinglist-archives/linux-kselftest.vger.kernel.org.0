Return-Path: <linux-kselftest+bounces-24938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DDA19432
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0034188896E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2F2144B0;
	Wed, 22 Jan 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="DvWObkag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D8214205;
	Wed, 22 Jan 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556896; cv=none; b=u+PR9fT/cAa5sX58oSTwsal17zOsE9/lpYTTBGKo9OcQzTTuUUcdGNzmF6mulOggqk5vFgX5RGq3WgowQLhGCNHnq591KZ5ISXLcnUEg8xLHOP+S2kDA3VVgpjwRjAebeptWWOzfdlqCPGBFARm3eZcrmmSyd/9TBRvW4FCmhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556896; c=relaxed/simple;
	bh=V5UmF8gW4RvXtY10lRp+LF0r3060eq4XPbZN/wKQ6yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErfdyrUN7KRKVkYVmd3NanH0FIubEZ6kPd0RyPGnsYNGs+VUke8q/he2GfiY0htPGkGin7VE0GHa2SaJPSdncsAyeY5xYWO7e9xu7KRLSt9S+bqp2nCU4mZWpMjZ2/kUB8buXJMFPuTTyzY/ocTZ2Sl7ej8WAG9CHCoFaRy0xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=DvWObkag; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556890; x=1738161690; i=ps.report@gmx.net;
	bh=V5UmF8gW4RvXtY10lRp+LF0r3060eq4XPbZN/wKQ6yI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DvWObkag++p4MqiVRxNngw+nvfllVXGjV+LzDCSYll9G7w8U7sCSVV+MKTIrL1DM
	 SBF8yDLqNixADGGf6tRvfegqFiN5j88tDxxi8GvSRFVB3CQfYLB2zvbuSUahcopPa
	 GQNqtmnZo/dHdlrtN4N4VlilUACnwADJ+6RNDTEQcsN46lTXndCPeGHOlGwtQqR4b
	 +xjB0VngLjoXZS6qTORnlKBQQ2k25yvNePYYGwUYHDaSf9Y5r3cWZaWyCNoNR/fH+
	 BdoSirPopUm/RQkqLVx3/j1o16+5ZL3RqYnhjzp4aso0TTj8w4O/O175dk8t8vbLm
	 xcWdKNtVY32GGTRUgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1tqNNZ2OCZ-00T62t; Wed, 22
 Jan 2025 15:41:30 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 3/8] net: pktgen: fix hex32_arg parsing for short reads
Date: Wed, 22 Jan 2025 15:41:05 +0100
Message-ID: <20250122144110.619989-4-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122144110.619989-1-ps.report@gmx.net>
References: <20250122144110.619989-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Z9HGwG8S3ratyxebtluKy5iOM0nXJSHOOlfIQYuQsThz6hs8Kt6
 bkXSkLQaCQFDQ3CYeNGNHNDuMaMkZac/mDS/7vxVWCKts85tNsMOuA3EeGH1eyNVBbFxout
 Q5VZ3froBcQ7POSXqRpiMJEFNN3BF29gBLk3kEQvQ0Hfo+rA0OQPCs6lg903WPjRGsyw9Lp
 x6WAFimHktIBX1dGr+9hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pfo27eJ2jCs=;YuPh8Z3S1TDNvuoGaDRu+xx/U8R
 LP9yS1UoeTuu2KZzUSecWoLtsOl6bvhtIlx3qAjKrxDWmw8B0VcUPLkEcfDbm30DiiiHnP1Ow
 0NlUXou/kzaHkC2afg0Z2byZ9FHyFyCapcqwV9IsrOFn1fd7GiM8Lu/Dh47fYLZVg/ScFoldt
 +ObcPAhyPW9ZQ8BrmTCJgpF3aQJprRgGQs1RM1EjirIQXs3KrwH4yuTLnDVameNvXiQqU0GpT
 MWhN7ZbZNg/cHCxuKrAefErnuapcHq95lBXnrWtp7DQ2O/7vKSmTnxRZvKvWO+doY+FtO5XJ4
 5NYg8WIUuO7bcUUcxzJ2f9oVazrB14pt9pI4PEFSWCsXJ6DcLh9qI4C2g1ni1lXGvcSn3MKlN
 2/gyyadNyxEph3Cqq2HloA6b6igUwhxiav/Ctu6TKHN2GFC8uhGvTSni7oprxB8AXVfwZ+tvi
 zPkRGYfpa06L3fpSi1p1mBrisLzJFFTKmK6LCRQqZ8S2yC3ZAWt9kOpFmnz2+rOF+VlcQBol3
 S5DAGjzyalvkC9T+OnPmx3fvcYYwq+LfSKi6MsMmGHU3upW2pGkU5WG9YDhl+IVBvHDo54Hqs
 +QMDR0QbnFflUSmeRL9CnhSXSg6lz4sKRxigIHEWFBxNZzeqyJ3KLW/5uiCkkehmnrwWd1Q5c
 ADgEaLlrf+A3Ya4KX+qKSU8KahDbXCciFtK15e3t0xERQcjTjLLxkChoYeyiTbFHnATYjw4az
 Nfwf5UO2Oi7ogEcJCRX1zJO9eXnafIfop7sgBMJuQw4+Fyaizo4gWeb0Im0xdfx4I6LDdyMKi
 P7gYVSa0bazXPSg0J7SPknJwen2n3CNitvxbiLa3k7vrNv1Ezk5RWeg+igayH0VKkNEdR9dJ2
 90dqK2iILxnrn5koSbcGTXnsMMsELP/tw299xQo0XUsftEjErfIw59jQnV4Ky0SdwTr9jAULC
 vwF13gXDlQucuv++EwA+sR/Fq2X0kLqVEIZItHbGXXNwWjU1MUTDLfefrjvijSmu8lYnC88is
 6IPXxj/CeEOuogcogCxMbeuQvnzbIonhnWfGCJH5opEz1VJe9p1b0vSJNZ8kIfK7yMQFVr8g6
 /U81k46rqGQ/FfSzwQZSuxurfcf2PBDgn+eJN5wCax6Fg4NVcLdHcgN+qzZeqrWOG83Byueq3
 bzCoOTN4UADpYO5BUQ+jNi2x+WLjki3RpkPeVuCYb6PfqZHc9JATvfowLk431LXZkHzc+33Jp
 yGFNDB0ueTDZFK+F7CU3jf9NJQ0HJcyhhbkKFUWWXITYqW3Y6TJaRfZENbooP8ampkcVVVr1E
 79dYVq5BFwPafLcpSqfMRGjmvhElxoQ1HqHwoAt2Mo7EnU=

Rml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcyAoaGVyZSA3IGhleCBkaWdpdHMg
aW5zdGVhZCBvZiB0aGUKZXhwZWN0ZWQgOCksIHNoaWZ0IHJlc3VsdCBvbmx5IG9uIHN1Y2Nlc3Nm
dWwgaW5wdXQgcGFyc2luZy4KCi0gYmVmb3JlIHRoZSBwYXRjaAoKCSQgZWNobyAibXBscyAwMDAw
MTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZ3JlcCBtcGxzIC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSAgICAgbXBsczogMDAwMDEyMzAKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDEyMzAK
Ci0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvICJtcGxzIDAwMDAxMjMiID4gL3Byb2MvbmV0
L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBt
cGxzOiAwMDAwMDEyMwoJUmVzdWx0OiBPSzogbXBscz0wMDAwMDEyMwoKU2lnbmVkLW9mZi1ieTog
UGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MSAtPiB2MjoK
ICAtIG5ldyBwYXRjaAotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNyArKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25l
dC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNGY4ZWM2YzliZWQ0Li4y
OGRiYmY3MGUxNDIgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3Jl
L3BrdGdlbi5jCkBAIC03NTMsMTQgKzc1MywxNSBAQCBzdGF0aWMgaW50IGhleDMyX2FyZyhjb25z
dCBjaGFyIF9fdXNlciAqdXNlcl9idWZmZXIsIHVuc2lnbmVkIGxvbmcgbWF4bGVuLAogCWZvciAo
OyBpIDwgbWF4bGVuOyBpKyspIHsKIAkJaW50IHZhbHVlOwogCQljaGFyIGM7Ci0JCSpudW0gPDw9
IDQ7CiAJCWlmIChnZXRfdXNlcihjLCAmdXNlcl9idWZmZXJbaV0pKQogCQkJcmV0dXJuIC1FRkFV
TFQ7CiAJCXZhbHVlID0gaGV4X3RvX2JpbihjKTsKLQkJaWYgKHZhbHVlID49IDApCisJCWlmICh2
YWx1ZSA+PSAwKSB7CisJCQkqbnVtIDw8PSA0OwogCQkJKm51bSB8PSB2YWx1ZTsKLQkJZWxzZQor
CQl9IGVsc2UgewogCQkJYnJlYWs7CisJCX0KIAl9CiAJcmV0dXJuIGk7CiB9Ci0tIAoyLjQ4LjEK
Cg==

