Return-Path: <linux-kselftest+bounces-26948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27265A3B5F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F253AFE90
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73F1F4194;
	Wed, 19 Feb 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Nr+fv+cV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085F1F2BA1;
	Wed, 19 Feb 2025 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954755; cv=none; b=CEW0Da51PR3kTwqjH7KvQebThf3j8E9DqJMaJcXIr2YNYMxbePdi2P8uWN/MRqvyXqadUBGsGA7/ULteaeh9LT0UFeYG35taR48zTnKpsZLe6ATJM4kWgog49/OAvxunzwy/baH0k30jG57Ri9kFo04bVkwQB17uphiKJXU0c44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954755; c=relaxed/simple;
	bh=xuS0Zl50G3GWKfmYQSecd5rupPs7J62QHeZ7Mh9w86Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBCFK5aQHvMgXAUwDoJBodgjH5VL06GWYVqF2CUBgAKNTnOclWfM1B/rsL7NNNRCHACJJXNxYnHUe3K9KVG4qThQapFVoBPGq1kbbiIr828DcsZ8QBp308lUHncV3ugl2H0r/j0AZUL6bVtdJuSgrerBOJa36kuf50XGpAsp3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Nr+fv+cV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954735; x=1740559535; i=ps.report@gmx.net;
	bh=xuS0Zl50G3GWKfmYQSecd5rupPs7J62QHeZ7Mh9w86Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nr+fv+cVJRqTAVvBYYkx0z7sUNEn4E5AlFuetPP2a3o8VMg62iUnGpuYL4lXKnlN
	 LtuP3hfx4+MY2S/FgXjqYV7ucK2awfyw/dS4wmF7lsZH1wJnSAW6dfFLHcndBctbT
	 auWFn17yXQPAKQ6B396omdpHeso2j44VikWTHfRxNnuggxouC0abuM36C0qOwEWkw
	 ekI6EYT3tolUn1Yc2PgPvIQo9MinJMxOzkdsssFfRVFPMLIAi1O8xm5GPOk97TTsH
	 eLuMbNk1IzFTX7uC0XEXHiM4jmuLBbKycec8PRs5gWEK38ayQ4OWeeUoZY+L44GNk
	 5fBzUIwjSgwG7q6PWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1th4oF3iIf-001wJv; Wed, 19
 Feb 2025 09:45:34 +0100
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
	Peter Seiderer <ps.report@gmx.net>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v6 4/7] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
Date: Wed, 19 Feb 2025 09:45:24 +0100
Message-ID: <20250219084527.20488-5-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219084527.20488-1-ps.report@gmx.net>
References: <20250219084527.20488-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:bn8wg/13MmuwrARvlbX19TYS1CNjJudsRGJKdX45YNWG/DD155B
 /JhaqeZ5bHUe6oolf2JBm3KixiBT9oxKOawOvLn9YEmnV9QN3kE0AYsF1cdHg6i03Jv9c9H
 cSlVSz134xBi4vYjaxtEZEBFkRocIRdLZ1YkbUA4k/ZXjbUmj3UKKeSERdPNCFg9MH04BUq
 yI3Mi9PPtja7Xlo7hPt7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Sj/uWxKfzw=;Np5UVHXeDK38oWshFAt31bAvLIP
 /9aBT4vBbg0BuRyJveVB/5W0of8JZGXU+AnWUkg2ypKmD7szzNNHZcR9FvuVGlhoOt1WpBr+m
 MT1yiySA+/0PYDIvYwT2HhfMsU7Ew0NSlnV/85S3CcTl5wVclhAW61nbSaLaxy9zlYghPb1h3
 Mo8rkr7jtRFSfb+U0A37yQ7Cx04ipnkBq2YN1nbzZj8rK4oGo+R/zF0KFAd7X4poSvRg8yc6Y
 pDZR52nhHzoQ8wlrhf9GzBfwkDiRLpRE2JBrE03UcUSvcblBtosvmPduP4GEPsCD71DIjPuer
 sD5fSO6lpIvSz+Bx9RcvYAvVRJo/0pNXhbkARM4FMc3uJ8vxR2RceQzQ2HM+qTSxWwQtijldA
 Ic46wV80zk3mWvjmp/hLUx+YxoWp1WidE03oSLVjPbOuffkgLO36RZ3q+nJnzvnbwPkbf24jd
 AKWSNA544OzgyW5CLvYw+0LPEP/5uohR94wefnLv4o85ncMTo1PevuSuLgQ2IC+70SulspAvR
 64iZ2Ax7l3UUfQ6zlY7u3lCdFv+Kx5pvQjaJRU/W8svWsDyM4vK1nEEpbHeCrxHTkr7FRHdCy
 S6K3/2bBlsSaiXybH8h44x442sofPIAhArcbQf/lglgPXJqjhCH0qxuKwMAt98vhRVmII/SLo
 OH5IU8KMZTQyXn8Om5NYt1dhzzJYR8wiFNAyxSCGS+mpv2wl2YLBkIThU9pFeSwK/kSlChYKh
 pHA3bASSxshcHgivR7x1Qqv5XTqN1zaBSE84lqxBpA+j5VFshVWuR51g4kI0uRkj8TThQV4f6
 W7IBVXQSjvhW6JEcSu8HgjVRK5YsS4MhkqECiF0Js5C4FhUHKlS51tFYDQ6nrtpEIY1ctNv8q
 vMhWVKcdInMtvvaZ7F802HOIh5abgW3TEXznVeXkBIYIzK/2zysxf2bINERWhguCXvJtIU243
 OfomEzRCJHqiVeUUiz8dHH+/5N2CbnYNllyJZfWZFLVjyreRxqA1E3AwVmS+dMiQasAk4sSD5
 gwzqpgbbfIqsJdaHneT8jLUR9YEjLhaEGnRczxNyaIsrUEz9CKFfUtYXPYakNnn4rxLWcIfvp
 53K1X+/0tk2SEhsRv2nLLfo5RW/j/zycBLuZONMroPERcgkawLOYx0QyLuNQxV0lyLwO2A2tK
 CiYRdJ3b5StLroDK3yAuCJkFpExZctwG2+0ztY7UsAuTc4EOIplc9E0EvyXtRj2U/bApY0RRu
 R21D2qo4PNsjzCcUeXMKKo7qvhB6s8IlISSKWlC3if3VjqpKXfpuIL7xU/ufnqd55oauwrrNv
 oA3vfkFYtvy2uVPVspdYPu7DQ0e/3GILNaNs6c+Kmwy2UvC5NxpNsDl0tduOtIL7DJMHLirqr
 dLW2nwNhyk3gCHQkVepeVpdlVx5SsG9a+NFqc2tGicCoeUovFiiXP0vCPdZz2ClOemTyykUBQ
 51xtpvA==

R2l2ZW4gYW4gaW52YWxpZCAncmF0ZScgY29tbWFuZCBlLmcuICdyYXRlIDAnIHRoZSByZXR1cm4g
dmFsdWUgaXMgJzEnLApsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcgbWlzbGVhZGluZyBvdXRwdXQ6
CgotIHRoZSBnb29kIGNhc2UKCgkkIGVjaG8gInJhdGUgMTAwIiA+IC9wcm9jL25ldC9wa3RnZW4v
bG9cQDAKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBP
SzogcmF0ZT0xMDAKCi0gdGhlIGJhZCBjYXNlIChiZWZvcmUgdGhlIHBhdGNoKQoKCSQgZWNobyAi
cmF0ZSAwIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAiCgktYmFzaDogZWNobzogd3JpdGUgZXJy
b3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9s
b1xAMAoJUmVzdWx0OiBObyBzdWNoIHBhcmFtZXRlciAiYXRlIgoKLSB3aXRoIHBhdGNoIGFwcGxp
ZWQKCgkkIGVjaG8gInJhdGUgMCIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgktYmFzaDogZWNo
bzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2Mv
bmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBJZGxlCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlk
ZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY1IC0+IHY2CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2Vz
IHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVk
IGJ5IFNpbW9uIEhvcm1hbikKCkNoYW5nZXMgdjMgLT4gdjQKICAgICAgLSBhZGQgcmV2LWJ5IFNp
bW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEg
LT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25l
dC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggMjhkYmJmNzBlMTQyLi43
NWM3NTExYmY0OTIgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3Jl
L3BrdGdlbi5jCkBAIC0xMTE1LDcgKzExMTUsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAkJaSArPSBsZW47CiAJCWlmICghdmFsdWUpCi0J
CQlyZXR1cm4gbGVuOworCQkJcmV0dXJuIC1FSU5WQUw7CiAJCXBrdF9kZXYtPmRlbGF5ID0gcGt0
X2Rldi0+bWluX3BrdF9zaXplKjgqTlNFQ19QRVJfVVNFQy92YWx1ZTsKIAkJaWYgKGRlYnVnKQog
CQkJcHJfaW5mbygiRGVsYXkgc2V0IGF0OiAlbGx1IG5zXG4iLCBwa3RfZGV2LT5kZWxheSk7Ci0t
IAoyLjQ4LjEKCg==

