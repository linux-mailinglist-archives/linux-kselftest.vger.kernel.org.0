Return-Path: <linux-kselftest+bounces-26516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26DA33D38
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6970E1698B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB52144C8;
	Thu, 13 Feb 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="heMV3P+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E41214237;
	Thu, 13 Feb 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444437; cv=none; b=Y0vvs6facmLK3lUspORCZayvL3+UWAfO9qaQn5rmKN6XyzdBnqk2bTWwYO0ar3GyHzRuF7UEXV/thA7ufJ5NYV3ZsyNc678Pr7g3zIS5rsKTLoha8rYwx7b/bLWiL7HvqapIpl6A8rqaU9mloS+hED2kABxXMTaG3HArq0eUyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444437; c=relaxed/simple;
	bh=+X0MNgRk3mNbD1TbMgaodCutKV+2UVKiJ6vYphSz4Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJGBY50cHevx1cHQwz+B/sm4NQpkps741btY97UE5n73rzj9N76UWwr3hnRHg1MihwY1dlEMMsnqcJhBmt9Dqg+zsXBQKt160kFUyjIPFKXf3fr4Jzc6N7siWjeLOomiCam9oexzSRsfKHcsTLEVyO9DSbNFAwiNiGwGxE5Xbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=heMV3P+Q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444430; x=1740049230; i=ps.report@gmx.net;
	bh=+X0MNgRk3mNbD1TbMgaodCutKV+2UVKiJ6vYphSz4Q4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=heMV3P+QDz8SKWsirgj7sWlWItrpojFhp48JMQ1e2qhNeTOv+xuVYB8bzDN9XCPP
	 A6I6ERAW2NHfxd7RQp3RdRbsOFr6UUQUCAafJiO/oDXSiE7soA4RZSPZ+eFHw4aZG
	 WN45M/V9Km8u70G1NvN0asDAe6KS7HAV3SDidduPgk/1yyxET14XpXuqNxKfXfIg8
	 3bvM4ZSGPN0ABlUt9mwUItwP5qrlWpNGKIPghsltqYrXIlnjxfc+/6awRlpQwRdIN
	 zDd3WTWsvD3puIKIflQXfVHwqKozba4SPBUnCC+ImTkvDEx7t5/pgBqvX8/jjhAxU
	 5Ht7hu9G5RAvEH0Vdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1syW6H1lzn-00ge8f; Thu, 13
 Feb 2025 12:00:30 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 2/8] net: pktgen: enable 'param=value' parsing
Date: Thu, 13 Feb 2025 12:00:19 +0100
Message-ID: <20250213110025.1436160-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213110025.1436160-1-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:BP6HeLVZ5oyJDvLOc1P8dzvfcnVJySB4u6BCgxKDrji0hRla7/m
 Z7sKmBEbfGLQhB8xzbtX10YTF2tZs0+Gf9bR2EnGJfQVpELIGfenr0ExIgjND0gnYdWMNmc
 oo9wdS7dIv0iB18V+//u1L+3fOS0TZ8ttLqefWzjlkpDNB/xrOm8wX6mrVazC6wphM6xVG0
 4g0RqplMNBdqY8T9/iavA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Wzz/Cm3Pjs=;qeomaO+OG/eMZK5VEAeo1vLxK0V
 0tnnvR4AX7yOpYaKSrBXuksBe0vhqb/N5AFp3gtxZ7MfXbWMk/kSEx0LFNMO//SjXspeZWpc6
 Cq5akWo2L3HWdGgfjSgmWRxOx6rfacVExe8YXrsTPeL7eFw7VRrfqRNHxVGKcGoFtBjzK2o21
 9tdDfdzcLo22c4Cd7wbHRtkMpeHPU6Z958OjoXcxUlCh2E8YtIlWDOLUTamJvl1sHYZ9NhYzD
 Gv8pnW5xTX9JrBL3n5AA0Sp9No/GL/FViFa9RQp+So/dTId2AuoUNJWvD6X79lRpp9fu08XXL
 4hNWNi2OBTSlZpQhSrlOLWmHUrj1ehvMYTv81lcCYpgM6ap/tTIxI67o7h+7Uz347KmS3VMTS
 79tq6YfqQPAqntix34eAi5yHdrN2q9cJUWN2dhgW4DAVFviqM1+hEVrhPy9TBxrucV3KUoJbx
 6z7qjgjYPgncQi7nk7loMadJ26d8cQ0BxZqEMXEYhPxY1SWYJ9hiXitdexCFfuLJdeDj2fbIN
 p9AkDlL9u4eOYSi3jeX3TSWFJF5bydHBhlkGFV8jz9DRgb4avzYG68a9TzsXR9wV7o2FN2TnQ
 jVMkt7zdeOgg4oOSPHa2QTLpYStatS/F0Tx5CY+jEQqCjqauhZC1wFaZ2qfF3mx2plrmLBfbX
 GClPatlKShdznFJ3xwripwmvN2E1pjUfv+OLtkwHdrDuvcOs2Wc4bBU7mAWqfC7ZGEJcPCxu6
 2gReHE60c190NVnH9V6AidtPNdp0ew/WqA876xI7JkcA38huknsdH5RXxU3Tk/GyC1MpySvqX
 uOEJJ9klynzn04hgUJCDngfAOP6sjuuhPlu2R5yPhAdcv7DuyYv7zQnFXixGAcku6ZBrkqaoc
 X99ouYqMpAp4ZrHKGe5M9uBYgE6e7N3JGVNJ82MzUIZcbjniWXP/VVdylJ2TFfSRZ6fauw5ds
 BLLl7ncjCh+z2UTd/E660o7DsG0XBwrMGFoHsDzM8VNG7oKDeqQq6wwAaUW0dBVcKgosDwfyd
 ZgYLTOns1Jkm9D1ohu/QCTItaWVeeM2vTKeswTeMWr9zcCl+ffVe8i9K0NyE+k49QTdWz+Tqq
 prRbnooFkQIyAvVLD2Z3ecyd9bIQbK0pXekrgZs4lcr5Nwgr9LAcH5sDpH+oRRj6d+idrjtyj
 Twwjlm9+3zze/UVv/OjSpSta0LIrWOEdO8MYlvpVa8foIjYcYHlxUEKGf1/DQT1YTwuddMTgg
 /IoC5HyzUaoBzNTKBYl6DSwKPwEUMTy37mDVnxXXNIvBhwikqckx04m2A72mu6vj4miOO8cG1
 34IQcuvJxXGxQqErplDHSNvZDBWzhgacuo7CfilBls7UD9Y2zdImN9ZlGuTtYAS+2XyGZBhfX
 PiLISPHGO+hf6Imsmwa8YWHL32D++O1Mc8vYu1iZzrDW5TPZHmXwGH1ooa

RW5hYmxlIG1vcmUgZmxleGlibGUgcGFyYW1ldGVycyBzeW50YXgsIGFsbG93aW5nICdwYXJhbT12
YWx1ZScgaW4KYWRkaXRpb24gdG8gdGhlIGFscmVhZHkgc3VwcG9ydGVkICdwYXJhbSB2YWx1ZScg
cGF0dGVybiAoYWRkaXRpb25hbAp0aGlzIGdpdmVzIHRoZSBza2lwcGluZyAnPScgaW4gY291bnRf
dHJhaWxfY2hhcnMoKSBhIHB1cnBvc2UpLgoKVGVzdGVkIHdpdGg6CgoJJCBlY2hvICJtaW5fcGt0
X3NpemUgOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXpl
PTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZSA9OTk5
IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXplPSA5OTkiID4g
L3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPSA5OTkiID4gL3By
b2MvbmV0L3BrdGdlbi9sb1xAMAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJl
cG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQg
aW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+
IHY0OgogIC0gcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2UgKHN1Z2dlc3RlZCBieSBQYW9sbyBBYmVu
aSkKCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHYxIC0+IHYyOgog
IC0gbm8gY2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9j
b3JlL3BrdGdlbi5jCmluZGV4IDQ5NmFhMTY3NzNlNy4uNGY4ZWM2YzliZWQ0IDEwMDY0NAotLS0g
YS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtODIzLDYgKzgy
Myw3IEBAIHN0YXRpYyBpbnQgc3Rybl9sZW4oY29uc3QgY2hhciBfX3VzZXIgKiB1c2VyX2J1ZmZl
ciwgdW5zaWduZWQgaW50IG1heGxlbikKIAkJY2FzZSAnXHInOgogCQljYXNlICdcdCc6CiAJCWNh
c2UgJyAnOgorCQljYXNlICc9JzoKIAkJCWdvdG8gZG9uZV9zdHI7CiAJCWRlZmF1bHQ6CiAJCQli
cmVhazsKLS0gCjIuNDguMQoK

