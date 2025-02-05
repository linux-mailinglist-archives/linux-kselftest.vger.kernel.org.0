Return-Path: <linux-kselftest+bounces-25835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C49A28B54
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D25168B68
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29A1547E1;
	Wed,  5 Feb 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="ZHckROfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED4146D57;
	Wed,  5 Feb 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761129; cv=none; b=bI9Swh1jHYRCWXvgQoo1ZCgW++TgpzcWD2ZKtAgi0KLy3YLz8t0cOIjH9h7YzCdYvlBuWiX+JJW7G3Mq5vcyqmy/by9Hi4mzDRafGLvX5GjRcOoqH3oCdx0khV8WX2hKpQ86BlfNDQbDBESmLla0DFaXTQWROyKtuY6BMZfkta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761129; c=relaxed/simple;
	bh=F47ANIYhyoXWV4unHnRxiU6I2QiEzt09oLu/8VsINmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0WqGkn6kWNY+A32ZDXu4lOqHXNWQ7JCkA3bgYrzyB/wmfrkde0BJ9I9hTXO0JDobr8CE8qPkShZaIHNgKeUeBAzxGmP50TQFYlfzln4mzvTegoCoZ0i2hwY/IQLYuJ/OjmC7UqX0CY3yYYRUhNCRC+wSM32uMQkwnHjrYVsrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=ZHckROfl; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761123; x=1739365923; i=ps.report@gmx.net;
	bh=F47ANIYhyoXWV4unHnRxiU6I2QiEzt09oLu/8VsINmU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZHckROfluVDb9WlnZTEmwIRUIirzsJA8kMZhaepi/z5Ukrg0tirPdCZBbMwybeti
	 reGK1s9FNN4W+ONLLUM0yF7q4mtW20b2esbqy/LHbDwz9bQOsrk236rkmzIIMOoap
	 ZOJfYMDrObiBh8VeKavXe57wcclmSuHs8A7+U7WvLuuzn89I0J07ytUfbEgAQF4u7
	 yV7BrayxwwLypqm/7eUHIve9QYDDOEzLekw4kIkr0GCSZYzK4S/ErFf5d16ODHZQP
	 MEyAZ07ixLCeTUnU9YDMx1VvkbnQ2nKGJs+mjER1t5pFAJBnTGT6sUQN2GyrKYkLC
	 HUR8AH0unB13XhD4RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1tDECp2gjQ-00cqtu; Wed, 05
 Feb 2025 14:12:03 +0100
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
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v4 10/17] net: pktgen: remove extra tmp variable (re-use len instead)
Date: Wed,  5 Feb 2025 14:11:46 +0100
Message-ID: <20250205131153.476278-11-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Jt+b+gD7lYNc5LUFBg9Q64lLcVzkdnCcxE/WtLwIaEHCx6Xx4Qq
 McYibjWL1mt3S51bxkba9puN8jSFg409PGO01kZzaukuHh1ONqOwnCqy8bcpWTj/4U+B0Yo
 D4c0yb1LPmzINGM5OGfIcwT0FfKWKAeYTEvLehAGg/w5b1ezdI3Np4YvXhPWSQpHCI02eo2
 9vRziRM49GqoUMF+1Eyqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ffpwATl7uA=;DhJAjFIxSFcyNdvY5FAMtCIbWVd
 v7BOh8T/mOZIQugGNxrQPGZ46zomUC3Sd9QtdG6gtJ7zCdVai2RNvu5KtwiqIzZKgYJfTPaY4
 h6xZY0aIgFLaObmCHvg8JqL5QYh69tLMaCJtx7j/wkcQ2Wx56ou75UiVLT4xhaxNT75eGkfUo
 WwCzQblr4v5TMQatd5a4OdgIBYaO+k+QSejDZytKBlOiDN+cXcWYV5zLxu7JW2lxWboq0KPiS
 ZiaF+wbX8S87f22qSL0Mb40CUz8hrOtRC2UXEu6RG1hjTKRKSqkdi0Z941MH6oDuOIjBMIDS5
 Gzk+eruFAzxUtuQ6hCHh/axQJhymfCyt0H8PWLjBjspbdKAPH5JUj8iuglHVaxW5KQmVZ3idI
 2zx/WW742QRuqAKatGdfEW9gAE23Rio8+sH8gV97/+6pva8EByqM8ZM1RDDJGkIP9qRCXzbvO
 qurWhkFd59YtNXiWo7iBk093a7Vd/1tQCENgeZGa0uCMIwcsdq7Zzm8e6mnD9DiTKNswBoMoi
 69J4S4t8i4+AE4NFIJ36xRjw0gNMsOtE/OG1ETR4pcuMNxiMkLHWt8TkXL6dmaximguN5jSL4
 3Kya79BBzAL5amtwWCUdnZ2w2K/OPafwLFTeeLm/YzAoJ7br51idzRf+4LggFLjyjdq3PMNzY
 BT1nSyI73nTbJOVqTOJoReJ8E6q3v11PNqF7bQPJk8sxE0QKEJVIVKor8uGHOt1rgJSReF0z7
 vlgab7K8fsDpYpngKg8oP58PXlCKF4ANjfBlrTHxVaLjw1XElRWV8lkefjWVHl4Y28jWlQwlP
 sQoHpBGvufc9ehHVku2okGDsWXCItfcXdlemJuUQxUKUp1y3+seKjVZ08tM6XqWfw6FpyU36G
 7hUoFpIaOONvwuJHFs2sJHfR1Dp//73v/yaE/v7BtG5v4cqNxipIExEfSOOv9QqKNmzlbSivf
 DP37Dshxjat3bwVxFciKce2rUfECpURUZGhO/x+dADwzvn5nGsRjChtYt7C22yHKvqpgsNlxT
 IOoS6rckYkz9iujRdP29llXxJA+em+4i2gm8rM4C3PshImKMsuLbCcJcrC5eSgygQ4zGOz6Bc
 482+hV3OuJsrH9Mg+8BW/r+mIP4ACzW6HDeSOfZCniG07+MEOr0DKzsjY568Z6bZ0jFTIm25v
 TAkA9eBBVVLrYUpf9+6H6wjLNfkmxJPT8xIXHsXseoV233a/XU2LxvfmYx8Wyv7/P0dTRJVg/
 rbvVgqjmt3R0/PXJjeuVFz/QB2z+stRKp4jLXnGvuel52jgbqhpT4+YuT194okLUmsMUTeTpS
 EIbYHQU4uotCOAKeWHVxRvq34xFUDRk8JqPFkedQDSDw5M=

UmVtb3ZlIGV4dHJhIHRtcCB2YXJpYWJsZSBpbiBwa3RnZW5faWZfd3JpdGUgKHJlLXVzZSBsZW4g
aW5zdGVhZCkuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5u
ZXQ+Ci0tLQpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBw
YXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBi
dWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgOSAr
KysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRl
eCAyNzk5MTAzNjdhZDQuLjkxYjA2NDczYzkyNSAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2Vu
LmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTk2Niw3ICs5NjYsNiBAQCBzdGF0aWMgc3Np
emVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJY2hhciBuYW1lWzE2XSwg
dmFsc3RyWzMyXTsKIAl1bnNpZ25lZCBsb25nIHZhbHVlID0gMDsKIAljaGFyICpwZ19yZXN1bHQg
PSBOVUxMOwotCWludCB0bXAgPSAwOwogCWNoYXIgYnVmWzEyOF07CiAKIAlwZ19yZXN1bHQgPSAm
KHBrdF9kZXYtPnJlc3VsdFswXSk7CkBAIC05NzcsMTIgKzk3NiwxMiBAQCBzdGF0aWMgc3NpemVf
dCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJbWF4ID0gY291bnQ7
Ci0JdG1wID0gY291bnRfdHJhaWxfY2hhcnModXNlcl9idWZmZXIsIG1heCk7Ci0JaWYgKHRtcCA8
IDApIHsKKwlsZW4gPSBjb3VudF90cmFpbF9jaGFycyh1c2VyX2J1ZmZlciwgbWF4KTsKKwlpZiAo
bGVuIDwgMCkgewogCQlwcl93YXJuKCJpbGxlZ2FsIGZvcm1hdFxuIik7Ci0JCXJldHVybiB0bXA7
CisJCXJldHVybiBsZW47CiAJfQotCWkgPSB0bXA7CisJaSA9IGxlbjsKIAogCS8qIFJlYWQgdmFy
aWFibGUgbmFtZSAqLwogCi0tIAoyLjQ4LjEKCg==

