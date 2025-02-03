Return-Path: <linux-kselftest+bounces-25580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6AA260C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378AA164E56
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538C20DD7F;
	Mon,  3 Feb 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="GAfAJdAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29620B7EF;
	Mon,  3 Feb 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602156; cv=none; b=Gpu2gc8Wjq68fkNWYIa5G+XkGlI4fkeKDpz8Sq8ljPT/ybQ1PaOi1+CBP+oQLrGzryXH4BxC0tSfd1LQjjJH9AAzFlDyNYjiRT0bLg/8Q17IO6XLRKB1B9lAmLxe1iP4Qk/EKFH/qI9I8FFkAO0cM8LdEuf2k0WxbYDdXoOrAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602156; c=relaxed/simple;
	bh=+5jShTae/ZxTL8acCh1/3qYlsuDGOSQxtQIi9vyhqgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfvg1nlxS+PPuUEJpqD0xZ+Ep+7NFy7vuNajPxMXq0eZid15X5GOvo7aEU2fTfao7BBUXMEPxP1JZ30Uw/ghyBuiJPnZ7KBM7hZ9lynbg7LThC8QAbyYlKSP8gsjz3Wr8Qkd3T54lcPDOpPx8Nvj5KeHJx228loGD/rh7y/B0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=GAfAJdAj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602150; x=1739206950; i=ps.report@gmx.net;
	bh=+5jShTae/ZxTL8acCh1/3qYlsuDGOSQxtQIi9vyhqgA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GAfAJdAjgMAZnA4JDJp9jl1mMd/rLGEf77qtb2+rVq7CNSgPTaSA6pY7679PHXDP
	 rZfQaCrOTE/5HpofOcSbU9SQMoReOvaOunpXwRqY1oYG0yMBbmkPKZ4lLdA1f/kHD
	 67OAXxJltpLVZez4iZczbTHTbZ1QKpRs7jyIKcXa1XGXXBFakLxGDAYrfj7YhmebQ
	 8a6zOPxDWvjfEhCWijADS7d2MqZBZAQmGEZDvt8jlzVAIGaZqcSCtJIlHXkLwTrRE
	 Qwl2ovtu6OqfRy6gE0UdMx1ERnl8KNQ857MIg7IulqyaaLjF8C+7wsgrVs/xHS7Dm
	 95/IoAHOf65WhBGzMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1t3xvj3Dhq-00bSm2; Mon, 03
 Feb 2025 18:02:29 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v3 05/10] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
Date: Mon,  3 Feb 2025 18:01:56 +0100
Message-ID: <20250203170201.1661703-6-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203170201.1661703-1-ps.report@gmx.net>
References: <20250203170201.1661703-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:r+HtfDgkwVIrcyySDucUmq22DfL5nhLmejTokGW04e+Ja5dvMGr
 9M7rpYOWCxBMawfZCC/S6xuA9MkIEaKCyhtUU+g/OALNwQvL2RXFl9k/eDBMM3YFvyukSPb
 hd25nyIJt8pSx3a8nuMLZykpUjbuKOn5EwUb+IDu/290u+DijNdmsHOyGKgd4QwXAcPaFY/
 izbrxfIlDfBR5hePwHmAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bgEDliBuouU=;xWM7m9lmKJ5GwTkghKegH3n7nRU
 XALvkfMXQ7cWFLQoUPWvZnUbSvV1J/UYuyjaD+MFZbvt3/buzb+2HySnT42nsBA9Oer6WmfZu
 VQ94WBei2aeNqj2vod9K/QUOd84O0F7t2deT1F2JzrO2qZpF0Y1yuhI2aY99Bq7yY8BT69EuB
 ph1Lm4Ih1fa8nKhJ3C6q+mHV2szppptyaoi5XS91OwPJ7CoQPQZ5xq/eo0PenSqyTxl+e0EBz
 f+UXaSZz+2xw1ineENOoPk+XJpwtI37SKYaqT33HP2Hn5wG1HQIBw7EwS9Ljql8CTaxVnaoYN
 VHJNyO4T5PNZ7ceNQ4+TfkxsiWXViPgxjElWnIbLJhu3rMsrkTudLeyQCs0w9r74NQSTHfn8M
 Uc3L7s7347rbXzqISJNgQWEibf8F7jD900m1bCRS2HOTRur4nF/A3rOuCWzsviv9buxJDdoo3
 HiFpL0mMgNCEABDOelbrsXWCVIMR+P0Thz886D7a0VJWqV7b2XCurJm1f4jK7YmU8zoVFD61r
 8JnZkApHwmVTrk0OE7USGcs8j5OYLAMmnvEVNUc4wPZBxAovz6DcCLvaoADqeSi5mIdzD5ozl
 0ArlbwfcJc+erxVXWbAy2NbKEAd+VgECY5YKkT580Ei9li4oeUq4gWzl7RN1w9xzpNI6OmVRW
 G90BBfwAxzZTHXOYbT3Tb22sxPGvqmO+nQr2nNjcxKcX0PLjy/+XSPVDz9ug+egEDki7TH7IS
 T6iyH24uyFu8m8TasLZzxiUQFpVKtUYA+KybIM4RFZqw7m9L33ueb7EqxVonKAHdjLvVPyfZW
 2T9ZcrzPSOpBu8/fPDxmw29Liq20NFMn/Ao8SpOSbT8wkd2uVnAe2oaLf5i0YptFAkGs9mCq0
 TM7fCmfYEUQSfvljXLQN5OzTfOGv9SY9MDwvb1hgGBAYcCOn6rt6P27aglztY3fGnrapQZLCH
 hGBeMwDtcONhgabThNpHf+Jw/RWXezlgHcrhM5WnY5sm7TLGS/SmkeY9D4rbZwJtaVVFcvERb
 XLRuqnECv5uTv+MQH5C4ps5M49iY+8HMP6+sNMPPDdkS8GXwtE+iBozS8hChGSHZR5qaWF7Ec
 oqg1lZNg+Gw4pjTm/0hClHM+j/vumUq92mTj/WRIq/b5dAiHYKM+SLjT2bWOgPlWvpWsZsrVW
 BcLn2VzhrV4k1QLtuYM9aKmSI2hQHKbPsP5F/kS4toXMi1NFsxPnNzVmCTZHc+eU/cDS0c3Tt
 Gmpiy7r+Y5193GWNRW7oJQ8ThcWkxPUqLF6e+4QDCA2QdOmY3GM2yYd6j1LADlizSke1qKU5K
 7es8VoX90Ziohy5V2qpzyfLsK91rGE7xf7+J5Yjq2FLlIE=

R2l2ZW4gYW4gaW52YWxpZCAncmF0ZXAnIGNvbW1hbmQgZS5nLiAncmF0ZXAgMCcgdGhlIHJldHVy
biB2YWx1ZSBpcyAnMScsCmxlYWRpbmcgdG8gdGhlIGZvbGxvd2luZyBtaXNsZWFkaW5nIG91dHB1
dDoKCi0gdGhlIGdvb2QgY2FzZQoKCSQgZWNobyAicmF0ZXAgMTAwIiA+IC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0
OiBPSzogcmF0ZXA9MTAwCgotIHRoZSBiYWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVj
aG8gInJhdGVwIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMCIKCS1iYXNoOiBlY2hvOiB3cml0
ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudAoJJCBncmVwICJSZXN1bHQ6IiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCglSZXN1bHQ6IE5vIHN1Y2ggcGFyYW1ldGVyICJhdGVwIgoKLSB3aXRoIHBhdGNo
IGFwcGxpZWQKCgkkIGVjaG8gInJhdGVwIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJLWJh
c2g6IGVjaG86IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50CgkkIGdyZXAgIlJlc3VsdDoi
IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCVJlc3VsdDogSWRsZQoKU2lnbmVkLW9mZi1ieTogUGV0
ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MiAtPiB2MzoKICAt
IG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29y
ZS9wa3RnZW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2Vu
LmMKaW5kZXggNzVjNzUxMWJmNDkyLi5jOGE1YjRkMTc0MDcgMTAwNjQ0Ci0tLSBhL25ldC9jb3Jl
L3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xMTMwLDcgKzExMzAsNyBAQCBz
dGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAkJaSAr
PSBsZW47CiAJCWlmICghdmFsdWUpCi0JCQlyZXR1cm4gbGVuOworCQkJcmV0dXJuIC1FSU5WQUw7
CiAJCXBrdF9kZXYtPmRlbGF5ID0gTlNFQ19QRVJfU0VDL3ZhbHVlOwogCQlpZiAoZGVidWcpCiAJ
CQlwcl9pbmZvKCJEZWxheSBzZXQgYXQ6ICVsbHUgbnNcbiIsIHBrdF9kZXYtPmRlbGF5KTsKLS0g
CjIuNDguMQoK

