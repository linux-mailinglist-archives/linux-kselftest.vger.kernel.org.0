Return-Path: <linux-kselftest+bounces-46162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A807C76D8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 15D0B2C141
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426302264A9;
	Fri, 21 Nov 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="FlFMV5H/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0x3uaho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F954723;
	Fri, 21 Nov 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687263; cv=none; b=VsZP//FnMAPTAfbIzxvE/lCxCNgzTJTawSOWv6NvV/P+ad/EdTO6RJiJmUtRegBer+wURiBLLjmz8CxFCNHEzd1hkN6NiUEZYHpioxV3HLlwZsbK6mo5lSXCSwF0GuY8FemBLO2URoX7xyI+bbHvHh+29LjeMCV+n5XN5kR18kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687263; c=relaxed/simple;
	bh=hdB0XIlSnNJubY9+q5MXGJlA71PuZwGpMtjISl861Dc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jK0AE2iqnmFEtOJ6iLT6km5jcncB9ndbGNpyDBuBgzakS0dGvk2jk+4k1X1fxGMiigGWfImr4xr/EScZGQL9mQGZEvZKEPlCKKNdtiKJAt9jswAQXLvv8W9xGl9leYB/MN1yNvoESO/hm6wCEhMvGaH88GRGECgdHjuaySENMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=FlFMV5H/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0x3uaho; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0F7B7A0035;
	Thu, 20 Nov 2025 20:07:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 20:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1763687256; x=1763773656; bh=tr
	MtgmYQnDAkU6r0QxWV19h6XdGeHiauPYR9V8WTHQ8=; b=FlFMV5H/Kme7Ika/EW
	ZLJdU6Td0Z8fpIjZ2o8byulB5Ge+Sxcdb8CWUcBmjgjEVtekZnNL9POAlcwvIjza
	qEnqFsXEnS4Nja8azbkBesarBEUYdKI0d+33oMF8mKn6vrL8O79gRxj0yK1KmsRC
	MqvS7ekzDqN4S47Mh7CN04UhmUytwATAfgPOEaoY64HW3CBU1o7vQNBS0bp9pEuu
	FBS+fc2sFO+gu4BUy04ds/2aR9nE8YrniIUxTs0rZhDFjOwTIUF7QQPbX5RLEMGj
	fOv1bOiHkbFG8JS2bGCdnjuk3j6B0szP07/KTem08Q42uLuhlF1SQJGifZ2sHhXP
	JxFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763687256; x=1763773656; bh=trMtgmYQnDAkU6r0QxWV19h6XdGe
	HiauPYR9V8WTHQ8=; b=I0x3uahoyeuXLAskB8WDeDzk+XY+h9waNcD3SuaMnWnm
	gXcqQGMfhdp8MDY10Mbal94xSmUPSznm3kZRU6pORkWLer9NIlsSADs8KTK2a1xf
	P4+jH/wrFnwd+hZIHdXRDTwO1na/34ufyL5wcjkKbBHzrSuQSaCrCwaupav99LqE
	7ZbEVmoR6U0L+hj+HT9zJownkIM+GCj8Lcbs1Ktpy0oKn+ri8l4VC3p7IRea1ScJ
	b2hFkVi6dgn1yBmHuRayP9TZxqg3ZdEm5r9jK9/9ctRMR/hu+NbNghyuFBlyIaLA
	5lFR52W6X9pnRN75fO+vhpNI73GcemL7vDFA4sM3Mw==
X-ME-Sender: <xms:WLsfaWNC6zHDk5uYOO50l0mnotMNvIXNcH6jTnmzFuJ13bfM4toDPA>
    <xme:WLsfaVbstb2wJ4eonsHtyLCr-1iJr2LoLAs7nCRUbbkMH8t1m4S7U6aZ3lDTcKpLT
    6K4CvTN_Bi_IxS6A9XfQIQneh2bdBXRFxqW_fWZx0LtdUf_fyv5LsI>
X-ME-Received: <xmr:WLsfad_gGXV-h-_9TFDX19qzsAbRpCuGGVdqy74QsdwO6LoRqVkv6LZsXrl6pnOE5TSZsl0xDvyRvRGa0Yembvwz371GPCi1tZqrttR_YM7VYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrvghtvghrucfj
    uhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfelfeetheeghfekfeeuheffteelfedthedvfefhiedvhffh
    heejgeeutdelgfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhitghrohhsoh
    hfthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthdpnhgspghrtghpth
    htohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgrhheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvhgrughimhestghirhhquhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    hsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvght
    vghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthdprhgtphhtthhopehjihhkohhsse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WLsfaeT_bENLbpSKcdSMe_oFO_odu-mwVhS3yFsVHsxVxfPMOUVQoA>
    <xmx:WLsfafcEJrWpdKU_ELKK10dA1giBBLU8ZCE3f-uknNVotlpN3JQbEQ>
    <xmx:WLsfaYQIzz-7O_qk04qMwB2CyRzsW55l4jM_YTcmPxKPxinpPcA6Qw>
    <xmx:WLsfaTIQm9rDazRueKsUHpKnfrrmTBWJFGLMqPZV7Pzzkc7fFJkNxA>
    <xmx:WLsfaWKo7fjgqqLj3hEFyc8mxSSzBSwJtCMYqypY5xUU78qMfGNiXk10>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:07:33 -0500 (EST)
From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 0/3] HID: multitouch: set INPUT_PROP_PRESSUREPAD on
 compatible touchpads
Date: Fri, 21 Nov 2025 11:07:10 +1000
Message-Id: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG2grQvEq4qLY1GajpcEPFO9uc
 HbD8F4DocokMHUNKl0sfOwqtu9gzWHfCDmqgzNutAreXDBzxFJJ5KxUQkQfvDFrTNbbAXSpLfH
 zv87L+35iJfjUZQAAAA==
X-Change-ID: 20251111-wip-hid-pressurepad-8a800cdf1813
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452;
 i=peter.hutterer@who-t.net; h=from:subject:message-id;
 bh=hdB0XIlSnNJubY9+q5MXGJlA71PuZwGpMtjISl861Dc=;
 b=owGbwMvMwCT4yLquYEv6h/2Mp9WSGDLld4dyuS6Lkt6davbzx6VIvs7Lbx3Pr92+6CBPutkUn
 8RF5jpTO2JZGASZGGTFFFlsdJxvutRGWrx3DXwNM4eVCWQIAxenAEzkWhbDPONYnztMfzt6/mit
 OW077+dmBhYnHoYFW0zvc+k5d+zZeDL61No4w49+a1s9AA==
X-Developer-Key: i=peter.hutterer@who-t.net; a=openpgp;
 fpr=3C2C43D9447D5938EF4551EBE23B7E70B467F0BF

Note: this requires INPUT_PROP_PRESSUREPAD [1] which is not yet
available in Linus' tree but it is in Dmitry's for-linus tree.

Nicely enough MS defines a button type for a pressurepad touchpad [2]
and it looks like most touchpad vendors fill this in.

The selftests require a bit of prep work (and a hack for the test
itself) - hidtools 0.12 requires python-libevdev 0.13 which in turn
provides constructors for unknown properties.

[1] https://lore.kernel.org/linux-input/20251030011735.GA969565@quokka/T/#m9d9b2e09eae5262cae202a5b917b543faa6fd996
[2] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Peter Hutterer (3):
      selftests/hid: require hidtools 0.12
      selftests/hid: use a enum class for the different button types
      HID: multitouch: set INPUT_PROP_PRESSUREPAD based on Digitizer/Button Type

 drivers/hid/hid-multitouch.c                       | 12 ++++-
 tools/testing/selftests/hid/tests/conftest.py      | 14 +++++
 .../testing/selftests/hid/tests/test_multitouch.py | 61 +++++++++++++++++-----
 3 files changed, 73 insertions(+), 14 deletions(-)
---
base-commit: 2bc4c50a42f8b83f611d0475598dc72740e87640
change-id: 20251111-wip-hid-pressurepad-8a800cdf1813

Best regards,
-- 
Peter Hutterer <peter.hutterer@who-t.net>


