Return-Path: <linux-kselftest+bounces-47902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A341CD7CCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 834E9303F0F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197CF293C4E;
	Tue, 23 Dec 2025 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="5xUHtJH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2Ec1KiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499E2877FC;
	Tue, 23 Dec 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454714; cv=none; b=EGp1Mz6o6aUt9TosJtufCupuUxVCiy/1Xs4i1MpaxQd6jqY/ZkETloVZbbVyOiEZW4wPHHhVEf5ywjg6arcIUCVIbnfFHmXnFvDLwtHmYGjIVXsEtNOmMxe/39V03xXkqgVnTBUq2QSpdk+Fjk3gQZ3OdkfXFdQ9bg0nMy20BUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454714; c=relaxed/simple;
	bh=tUEvr0/Co0u0vse8P7ma21iKNYtFLdtzVh+AL+wJtE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BTPg2q5fm6CvRJX/eugASNWevhwnhmeLIEJ38Gmn2r2Nb+7jjbFoXmG0wMyjF+jS6D0Nx8FPPpvsX/xbET2vC3+rIVqrre++jFNyavpEQq6WrvUUQdgmC6EmdC+t2jJA+aDF5yd0vTj16zpZ/LKygTTjS0Eh4nkybRAdMfumXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=5xUHtJH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2Ec1KiG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59091140003A;
	Mon, 22 Dec 2025 20:51:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 22 Dec 2025 20:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1766454711; x=1766541111; bh=jFNUbjPV5/UHQI1W+VN1TgnZttCAIh16
	+fOoBkxzd6I=; b=5xUHtJH+1CLRKDlRcClN6FYkZ+LlZxMg2xRSp12McTV4uzQC
	7n5MD8CpykRyJq/+TU0LZ4aKYEbFnWwzDffhmm8b+xmx3gzKFvsFi7z05qr7PY8i
	pATy5KyQomCauuEjdR6OHHE8i/Ffl9qv7ddeyVlRD+dMcghVqRIjdZnJVyWa3CIX
	RnpeDyNJtuV4aBxG86Tgh4uHyHV58yN55krddQk1AaSE5EYqbCyYl3AnOr9mA5UP
	YKt75l1rHyvKkq7FJtHPALVUVhqyXuZCDIjJkz/BcCJPXH77FOWokzdbkaGeunB5
	tOzPBE2045MxjqaroMnmk8uO9KkTH3QOHP8uJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766454711; x=
	1766541111; bh=jFNUbjPV5/UHQI1W+VN1TgnZttCAIh16+fOoBkxzd6I=; b=c
	2Ec1KiGfvZ4BqgiNaW3XabeeekkYRH181KYrhxbDcR1dJTLdOIlJkPBi6y7YqXJQ
	by5SYyW4CNWA940CqNZOxXlWVV7itB7bHuq7+R/yppksYErld1HubjUe4/kr+g5+
	2q/X0f5CcI+f7gsiBLWcPoUjw3JjygjSLG5UtxV2NZLSs9SslL9k94hNOnznivIn
	lLDExIkiAUDI7dpIw5vf6LpFXeCzZFwvmAd8NbUWDeiQkPebUkInagJx+VUNJHPW
	TWoCEwqaO7JpDEJfQ/deELN61Tq++aFap9X48hB63y8py/qiSuZYRt0b5rjbcbZa
	bkkhoT+m0jJRu3CYVS5sQ==
X-ME-Sender: <xms:t_VJaUn4AdbAolhSoR4MWiUBCqeuwUIxhFczPX_bR0v8Yslss1O5Yw>
    <xme:t_VJaexrZKRKINKYEC5GJuCyTFTLvEz6KNOqnX_ogQGWHrsFo8QA6LGiXXwN69KUq
    NDPFMvhg2-jnu9QahdlIbQkvod_cvkE1mLs_-FfoWcuqYoolx7zIHQ>
X-ME-Received: <xmr:t_VJaRpyUGvNrHrcELTEboTgmRvaeQROQr4l56VCv89QSsRVY-CSCGs6LsnjeSXHaa3s1KJpnDZ_z-OVBKxl-IBGbyCFGzu1bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggusehttdfstddttddvnecuhfhrohhmpefrvghtvghrucfjuhht
    thgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqnecugg
    ftrfgrthhtvghrnhepjedtleegueefveeiveeigfejgeetffffgfegiefhgfeiueefjedv
    ieejkefhgefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnthhishhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t_VJaV71ibLYouqOimDSC8bIqjW0hhevjmF2B8_SN2Cm7_wYGhv7Jg>
    <xmx:t_VJaQfJG5m9Vlk4kqzqsuA_afzXMMfJJIwqfCfh6m86Q1-9tlPfwA>
    <xmx:t_VJaS5QlBoUG4rh6ZyCDNdYTh-8tuXr9gOO9PLDMH_heiUDsKqQNA>
    <xmx:t_VJaftLTKdPPLUh7gcjur0Ei4WZYsWy6GPxsx94SskpyRd20WoVww>
    <xmx:t_VJaT4JQQtlaUdf8y5dmCaw2C2qx9Wz75ed8PqXL6sdI58RHdXNebHP>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 20:51:49 -0500 (EST)
Date: Tue, 23 Dec 2025 11:51:44 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/hid: run vmtest.sh's pytest with verbose output
Message-ID: <quelho6omol5amea6drxjimrf266oj5f5ytksfdrzhfjap2sxt@no267al776jc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This way we see in the log output which tests were run and which ones
were skipped instead of just `....sss.ss..`.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 tools/testing/selftests/hid/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index ecbd57f775a0..fc21fb495a8a 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -349,7 +349,7 @@ test_vm_pytest() {
 
 	shift
 
-	vm_ssh -- pytest ${SCRIPT_DIR}/tests --color=yes "$@" \
+	vm_ssh -- pytest ${SCRIPT_DIR}/tests -v --color=yes "$@" \
 		2>&1 | log_guest "${testname}"
 
 	return ${PIPESTATUS[0]}
-- 
2.51.1


