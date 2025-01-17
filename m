Return-Path: <linux-kselftest+bounces-24730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB69A1516D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AE37A2DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134D537FF;
	Fri, 17 Jan 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="tX2rjs78"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DEA10E4;
	Fri, 17 Jan 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123395; cv=none; b=kuu+b4/KVrcWDHedgLuV3rz+VhMY4Q/HiYiIf6B7f4rpmPhBNWhwnctfmYfNlW7QQALsW8H9pl6tILaNdMxYXUFrxzzq+d8RKDc9EDR++lwPnhlno0s4s5fA5Bsmvtsy36wx5C0njGfgKAots2k+gEQMwKLIYmAk36r6MEpkOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123395; c=relaxed/simple;
	bh=zePMm7z1lmEuzvXHCgfD9fFBz0psY1GxnVYPHbjAYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neZuZnekQtyKnTGO/MYSWxDN/Z3EkakYCjn9dKgsxLy15+lcIZPC1F3golAGuR9WtGVYFvpCMRqmwEt4L2cx5WERaj9HN+Wtfc03DjQjTeU12Lv3qRh/7FsKPeUELM1th1zmlAEMGBTnI6lz8VWbmu44uoniOLOVHAgqtlGmqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=tX2rjs78; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737123377; x=1737728177; i=ps.report@gmx.net;
	bh=zePMm7z1lmEuzvXHCgfD9fFBz0psY1GxnVYPHbjAYo8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tX2rjs788J5ST9BIu1bYLbM4QYBvbijyYK4f6phhTixUUvv+1HO1Sv4Wz9Hjcy1R
	 6IMx35OEMo6QDJqyu2+Ud06D4PEwPxdqXsqbeu68xCD5Hx8gULaunzpJTdLQOBd7u
	 rB4uw2k9W+YoiWU/Hifo1u+MMObZjjcjX8OyclubB50ZMrH7dXI14ydCgDaLrJZfr
	 GhCCetlepr5tFe9jyJqgoJ8k0FITmhTyYALQBGDZ3vb2lx9s2xMtAkipoJl2OF+86
	 NHZWtQW4CGsVL3Trp4i3bQ8DOBpxI4gn7+KSABk8vMtJFFDNDJfHwAqJtNYqAqPxH
	 wxSR3sGiBvAdF0bUog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.138]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1t9rue0KcX-00f2ha; Fri, 17
 Jan 2025 15:16:17 +0100
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 0/5] Some pktgen fixes/improvments
Date: Fri, 17 Jan 2025 15:16:08 +0100
Message-ID: <20250117141613.691452-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WrbwOVpR+6srgF4a+mdZUp/Kmr+/fv1oFHixgooVcVeTymeO5gx
 SXtB7hTeeuUoExSe2rwKql3bxd3jrQVrTy737oEU7Z0gvgMRDx+aTwlLolYuoODClMLPuqs
 VLPefQ/96Bd0dTgZx99FZQ8h6RvokjCVNSXUx6oARIHr4Db0ldH+AbcwI+fiuEJNq3IQImd
 k/l74HmANCuysR2CDqA1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mzsRtgXD9zI=;2fx2afTQAlSrvIxfYkmAPMCnzZf
 M7DyNKi/eGlclH4vfr1dtNXk0r6PBFoZdb3CiHv86I5hSUujw+kMISzO+oTHgQnKHPCeCP1PJ
 i8SjVLv8a6nkngnaPLnDsqOG1XODH0Bmgajefr2Td9gNLSU/vamGMFDG64c5Kx/McmTzFAzKO
 kUCyrd+jb2iIlx6AinK32WMTuhNHJrOX6UrQWdrbfi2BEh87WKXVcbas3FjGOg1snLqrRALXP
 Jumj/38VNnn9qtA7vwJzhStFK3b+y7kwsYQ+1gKYWHQt9AP0QYbSda7qYtTQjxHZTM47pP02u
 P2Xpdwhyz+gQlWzZiTWWFmdYrLp1UPoLW2Fbxb+sYJ3Es6tjqZ8jYm7WVMvct0kdanfF+rreZ
 cag990eJgPQKWvtPGnzcpnAOg/nD6sEdkCwyCYUaz4UR4sD2GgsWU4Vu0Km9BaTCbXdBHu5wO
 X/YRgpR+clqmrrEsBA6AhsLtuR4bZq5dJJ3xFGEzUVhjFMhqGCBSpSg7RzW+fd9xZb0Sdjdi4
 x3IU5FnRVdoRNOVPdwwtHl3oxMAbPwb6t40O3Hl0Wdqy6FgPhUs2ZnhC3Hr5rT9LJIOIOuwbw
 Cxms7zdH7he5DmAgKFLbK4tPuKUCSqOQbOEJI4vJ7CiHpqWT3758z94hcVgaKgGTIKL3beSp9
 2f7V9v11PDKriHsFfAjTY/daX+/BARNulQTEJcDtq9NJg9QxtdTeHyhfmTbS34h5LgM0OsrO3
 cn0cgsCcBvfgzXRKeREd+Gl/lYksBH7Di91rN5WOOAa1OId/en4B7gXvatjr5rNy8bebMfmne
 w6M+bo08+CMlxr0Tx+qNzbsUXp/mN0rsToK75I6OsJIZxla8JX79WkRkzKOBLKuoatbhzvHki
 GZeXrYqwVOhWSoj1WFwaxRNEeym/WiYWUOGvtP+X2HdUqnJjcHofs+QWhIxPQ80Es7WqhGaNX
 jvSwUe8vEoc56DEoso/mF17avStrTezan5cl80dvJFelKgV7w0jM6/NcQNitqs69C4h1lXafP
 Z0QGXSCPadK2ty1ohjZScm9cMmYlMqAJCoz1mdDo1T3d/lI1xgcyoGNB3iVJrnnuTBXjb0+bR
 Hylhrp7W+4VoHciO5Uk40PzHdsiyUk38Kh4ysiveBu61nU055lXX7vx/xuXtX/3CZIvggb8x5
 SUb2qJQVomXwHKT4cWM+8Nhft79XgRhgs4IQInoeflsN+E9QIiY+R+Ygh+6DinBs=

V2hpbGUgdGFraW5nIGEgbG9vayBhdCAnW1BBVENIIG5ldF0gcGt0Z2VuOiBBdm9pZCBvdXQtb2Yt
cmFuZ2UgaW4KZ2V0X2ltaXhfZW50cmllcycgKFsxXSkgYW5kICdbUEFUQ0ggbmV0IHYyXSBwa3Rn
ZW46IEF2b2lkIG91dC1vZi1ib3VuZHMgYWNjZXNzCmluIGdldF9pbWl4X2VudHJpZXMnIChbMl0s
IFszXSkgYW5kIGRvaW5nIHNvbWUgdGVzdHMgYW5kIGNvZGUgcmV2aWV3IEkKZGV0ZWN0ZWQgdGhh
dCB0aGUgL3Byb2MvbmV0L3BrdGdlbi8uLi4gcGFyc2luZyBsb2dpYyBkb2VzIG5vdCBob25vdXIg
dGhlCnVzZXIgZ2l2ZW4gYnVmZmVyIGJvdW5kcyAocmVzdWx0aW5nIGluIG91dC1vZi1ib3VuZHMg
YWNjZXNzKS4KClRoaXMgY2FuIGJlIG9ic2VydmVkIGUuZy4gYnkgdGhlIGZvbGxvd2luZyBzaW1w
bGUgdGVzdCAoc29tZXRpbWVzIHRoZQpvbGQvJ2xvbmdlcicgcHJldmlvdXMgdmFsdWUgaXMgcmUt
cmVhZCBmcm9tIHRoZSBidWZmZXIpOgoKCSQgZWNobyBhZGRfZGV2aWNlIGxvQDAgPiAvcHJvYy9u
ZXQvcGt0Z2VuL2twa3RnZW5kXzAKCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZSAxMjM0NSIgPiAvcHJv
Yy9uZXQvcGt0Z2VuL2xvXEAwICYmIGdyZXAgbWluX3BrdF9zaXplIC9wcm9jL25ldC9wa3RnZW4v
bG9cQDAKUGFyYW1zOiBjb3VudCAxMDAwICBtaW5fcGt0X3NpemU6IDEyMzQ1ICBtYXhfcGt0X3Np
emU6IDAKUmVzdWx0OiBPSzogbWluX3BrdF9zaXplPTEyMzQ1CgoJJCBlY2hvIC1uICJtaW5fcGt0
X3NpemUgMTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAgJiYgZ3JlcCBtaW5fcGt0X3NpemUg
L3Byb2MvbmV0L3BrdGdlbi9sb1xAMApQYXJhbXM6IGNvdW50IDEwMDAgIG1pbl9wa3Rfc2l6ZTog
MTIzNDUgIG1heF9wa3Rfc2l6ZTogMApSZXN1bHQ6IE9LOiBtaW5fcGt0X3NpemU9MTIzNDUKCgkk
IGVjaG8gIm1pbl9wa3Rfc2l6ZSAxMjMiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMCAmJiBncmVw
IG1pbl9wa3Rfc2l6ZSAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwClBhcmFtczogY291bnQgMTAwMCAg
bWluX3BrdF9zaXplOiAxMjMgIG1heF9wa3Rfc2l6ZTogMApSZXN1bHQ6IE9LOiBtaW5fcGt0X3Np
emU9MTIzCgpTbyBmaXggdGhlIG91dC1vZi1ib3VuZHMgYWNjZXNzIChhbmQgdHdvIG1pbm9yIGZp
bmRpbmdzKSBhbmQgYWRkIGEgc2ltcGxlCnByb2NfbmV0X3BrdGdlbiBzZWxmdGVzdC4uLgoKUmVn
YXJkcywKUGV0ZXIKClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNDEwMDYy
MjEyMjEuMzc0NDk5NS0xLWFydGVtLmNoZXJueXNoZXZAcmVkLXNvZnQucnUvClsyXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTAxMDkwODMwMzkuMTQwMDQtMS1wY2hlbGtpbkBp
c3ByYXMucnUvClszXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD03NjIwMWI1OTc5NzY4NTAwYmNhMzYy
ODcxZGI2NmQ3N2NiNGMyMjVlCgpQZXRlciBTZWlkZXJlciAoNSk6CiAgbmV0OiBwa3RnZW46IHJl
cGxhY2UgRU5PVFNVUFAgd2l0aCBFT1BOT1RTVVBQCiAgbmV0OiBwa3RnZW46IGVuYWJsZSAncGFy
YW09dmFsdWUnIHBhcnNpbmcKICBuZXQ6IHBrdGdlbjogZml4IGFjY2VzcyBvdXRzaWRlIG9mIHVz
ZXIgZ2l2ZW4gYnVmZmVyIGluCiAgICBwa3RnZW5fdGhyZWFkX3dyaXRlKCkKICBuZXQ6IHBrdGdl
bjogZml4IGFjY2VzcyBvdXRzaWRlIG9mIHVzZXIgZ2l2ZW4gYnVmZmVyIGluCiAgICBwa3RnZW5f
aWZfd3JpdGUoKQogIHNlbGZ0ZXN0OiBuZXQ6IGFkZCBwcm9jX25ldF9wa3RnZW4KCiBuZXQvY29y
ZS9wa3RnZW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMTAgKysrKy0tLQogdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L01ha2VmaWxlICAgICAgICAgIHwgICAxICsKIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wcm9jX25ldF9wa3RnZW4uYyB8IDU3NSArKysrKysrKysr
KysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNzEyIGluc2VydGlvbnMoKyksIDc0IGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wcm9j
X25ldF9wa3RnZW4uYwoKLS0gCjIuNDguMAoK

