Return-Path: <linux-kselftest+bounces-26943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36BA3B5B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FED17D1D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7D1EA7E4;
	Wed, 19 Feb 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="TyK2bPsi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4F1E8855;
	Wed, 19 Feb 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954743; cv=none; b=chpwIlCx6p8jT9sf5m+iuQ1CTG3vG8tbFg5mgTHEs+FdO6HP4a+VMSg62bjU+3EwrNK5hrteAQjtR7Rrpo4WeZzoAi9CoN6PtNTSACQQ8Tt0l5PSZ3gwQnfTLo0m+/a8k+rYGHAtRr7mMbMlspJ9KSiSDMKMF+rwA1hl1Jav8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954743; c=relaxed/simple;
	bh=bPlIset1Cccp4N8EsQdjsT+NX9VOlH00sH1KXjbVGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOLp5+uqwe6przebnlh3B2XUK4+cYeAQWo8elO3AX+gjoG7447yYwrgH2CocvBCYxa2u3m42fluYcLQHt4qL7wBpOD1PU3rLsk3pkYflJ6/2ymm/BoX/VOk9hkdy7Zx0FkOxGWnAS0SOd7Ki7LQkUvMzdX37CCQO6W9CpSEqnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=TyK2bPsi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954735; x=1740559535; i=ps.report@gmx.net;
	bh=bPlIset1Cccp4N8EsQdjsT+NX9VOlH00sH1KXjbVGQM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TyK2bPsiqU/UOouoeR4gO2clG2P0ZHx9wvvffQxwQDQIQwO4wRP1muj5DABxahtF
	 N0IJ0ERcgJpAR48ObmrPQ1D3w//mpS02FvawpRNp60lbX4P047604NXA5Rul3Av+x
	 KTBNDjpkm9xiiEkF7gih4YcYkb0NvK1+p16oNYPhzqlB7piv51Ou5herJE8XASSSV
	 0N5JgsRtSec2qI7ECvRUaczJPhf8OR7U9hDS2gQ6sR0fzwMIIUoA7318PEGV4jEgD
	 g1FvdeYoQ4DzRecHaNpG3EWvokspjT3+v85Ll2nWczJuZheqjgRMALdz27f80R23p
	 PFqI8m18qrZO6okzWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1tLbpg2Bih-015dmT; Wed, 19
 Feb 2025 09:45:35 +0100
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
Subject: [PATCH net-next v6 6/7] net: pktgen: fix ctrl interface command parsing
Date: Wed, 19 Feb 2025 09:45:26 +0100
Message-ID: <20250219084527.20488-7-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:XfcRQxFIU8PrIH2M93skfLbMwg3ByFhQR1jcgQ6hXkYZymy13pS
 B2QBjOyrGPg/zHArp/6qMDpE/00VmTK08kjPh/PYOK/+N0QKZ0gHuKtOp6h/ApiVK6K1rO3
 pEqmrZhqECVfpnKKzxVlYkQxsRoqm3iF/a7+HzLXEWyFe0c0o4Y8hIzddJ3Rg1hbttk1WYK
 fBi3ebD1Zsf8wL+raIYZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0FJhXZQ86c4=;iP9rLL39lkNgodBJpuCv65y8e2u
 ug6BtwrK+NcR3xGxZR2IWQa3I2GCTcupZtDr4Ha8pqP7PGGFH1ACzGIrUMov9dP5+LPpFS/HB
 Rk2N8uhs5erv8RyEDgsCyfWJYga9gGDG4jyN8EPRJ9RbQpE5T6rDTTI7Vs3ZN0p2QOdXyrTey
 LmWXdZfOnM/mx9AKf7T/NffJTRLd5og7G1cGs0aQOGhtxOUc4PsRTfHocUUS5ysLUh5i7kvpx
 m+s8JBxb8Bry+hryHSbrORDfQjZawL/eP7EzTb4S4g+cxbnMghenLXGCh1VS/O9Uz8DN81pJp
 BJXgIwRGwnTOd/N0JPMITO/B53kKDThbtG9TGtVJet3bUZfPvHHz1taridaCLOi/rq8T5jAhy
 AG6sQsR3M/aYEVjc846o6edTH3ggKn+ThUl98CjyjNk2OR8fZvEzo1ewucWlkrtIa9W75BKnM
 YZhdckr2tBcUgtXE9eE670o6UGdj9gJLY+3IbZ+RNC+rQdIACHtXIRhy693NRqJ36BznpYcoS
 P9UoQueXxDaX9imUFh2c+Os9/gWzpMRfkqe+2o5I6xvxl2BsHpgWNiL4naRA15hVbYlTbDbkB
 urb5xXrtuGuuoXFa7sGM18oO/K47YXjUxK/9q4LSYoJUpeDVH4SgudjcuyKR5blpxmSugIH87
 g9qn58R7i8gFEOXKOAUl2Ax2hdpSmr5Sjgf/zOSxabvH5l4i+Gp/n7YqYT2+LGl8pVX02SNAp
 sqVTWy1XC+7PFNxbskB644iXMCfoT23XJZxVyXIutXcqNYKytRnboGeOwrcm0QnE+av11M2o2
 mieFoP8qLrGSEDaGAgk/pk63tzv7BrrHxV1aa//ii6sXsIS8vgw+flQgrDt4TpnrFKh36chuF
 cSrFiK/PwLOSFfuEUfpMLnBtoYoZlxubvRYpd1nD6ELFKZm2lk5TYs5NSHCi6Ui6j83OYltXL
 YKx6JgCK3wwBS+AM6H7mWv2eJlcLNJ2AO7GGP9wGmTiOGBVYODklgvq0TgbR3wa86F7akrIMc
 sz2iMj733/5va6a8LnFhWR3rruox70M7nQbKEwq+rztQx58SGSzoy+W+GY4wz1qFQKiyf6nI2
 XMQBQx0+24IXkCTuWLzkclHzK6xOCtKEPU2A54n3ZhYl/9HZIDY4NgFGNC/zK0TfXqAXWhKFg
 jQ6EakOBUGfeOuX5mS37lCceQeQq87aWO/XbT3R4ZBTVSLMjF/reQyzyfYDXgvbLLfIjAv5ea
 XsvSQn9BKaUNXEA9sXbyYVaLNyj0Qvt+g3FgiKBDM07dDc60DLuj2nQlVUjQhCT+7H6VZvqJD
 gF01PwpKOxMQtPJbsefkaX/ZJCObv53Adsu/Wp0O/6/pDtzhZnBB1EO8vw4/PC3gZ799/USVl
 HHJ93JrUCptJ1jRVCFww7p9fbUyB/jHYka4TqV1RdDbu/9gTlZAUnJmSdK

RW5hYmxlIGNvbW1hbmQgd3JpdGluZyB3aXRob3V0IHRyYWlsaW5nICdcbic6CgotIHRoZSBnb29k
IGNhc2UKCgkkIGVjaG8gInJlc2V0IiA+IC9wcm9jL25ldC9wa3RnZW4vcGdjdHJsCgotIHRoZSBi
YWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVjaG8gLW4gInJlc2V0IiA+IC9wcm9jL25l
dC9wa3RnZW4vcGdjdHJsCgktYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1l
bnQKCi0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvIC1uICJyZXNldCIgPiAvcHJvYy9uZXQv
cGt0Z2VuL3BnY3RybAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBn
bXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0K
Q2hhbmdlcyB2NSAtPiB2NgogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3Bs
aXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4p
CgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2
MiAtPiB2MzoKICAgICAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDE0ICsr
KysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMK
aW5kZXggYzhhNWI0ZDE3NDA3Li5mNmUzNWJhMDM1YzcgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3Br
dGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC01MTcsMjEgKzUxNywyMyBAQCBzdGF0
aWMgc3NpemVfdCBwZ2N0cmxfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191
c2VyICpidWYsCiAJCQkgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCiB7CiAJY2hhciBk
YXRhWzEyOF07CisJc2l6ZV90IG1heDsKIAlzdHJ1Y3QgcGt0Z2VuX25ldCAqcG4gPSBuZXRfZ2Vu
ZXJpYyhjdXJyZW50LT5uc3Byb3h5LT5uZXRfbnMsIHBnX25ldF9pZCk7CiAKIAlpZiAoIWNhcGFi
bGUoQ0FQX05FVF9BRE1JTikpCiAJCXJldHVybiAtRVBFUk07CiAKLQlpZiAoY291bnQgPT0gMCkK
KwlpZiAoY291bnQgPCAxKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWlmIChjb3VudCA+IHNpemVv
ZihkYXRhKSkKLQkJY291bnQgPSBzaXplb2YoZGF0YSk7Ci0KLQlpZiAoY29weV9mcm9tX3VzZXIo
ZGF0YSwgYnVmLCBjb3VudCkpCisJbWF4ID0gbWluKGNvdW50LCBzaXplb2YoZGF0YSkgLSAxKTsK
KwlpZiAoY29weV9mcm9tX3VzZXIoZGF0YSwgYnVmLCBtYXgpKQogCQlyZXR1cm4gLUVGQVVMVDsK
IAotCWRhdGFbY291bnQgLSAxXSA9IDA7CS8qIFN0cmlwIHRyYWlsaW5nICdcbicgYW5kIHRlcm1p
bmF0ZSBzdHJpbmcgKi8KKwlpZiAoZGF0YVttYXggLSAxXSA9PSAnXG4nKQorCQlkYXRhW21heCAt
IDFdID0gMDsgLyogc3RyaXAgdHJhaWxpbmcgJ1xuJywgdGVybWluYXRlIHN0cmluZyAqLworCWVs
c2UKKwkJZGF0YVttYXhdID0gMDsgLyogdGVybWluYXRlIHN0cmluZyAqLwogCiAJaWYgKCFzdHJj
bXAoZGF0YSwgInN0b3AiKSkKIAkJcGt0Z2VuX3N0b3BfYWxsX3RocmVhZHMocG4pOwotLSAKMi40
OC4xCgo=

