Return-Path: <linux-kselftest+bounces-39680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02CB31AE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF26034BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253633043D7;
	Fri, 22 Aug 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="QfahnD8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245543054F0
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871607; cv=none; b=AkkxlakKZv1YDcAj2wPDjHuVuv8bplbL4Bz8lIFRhChj0mqcm+MdkeppNk05ytwWnkMUBPsH+NAqseQCviM8eAeRhTtDymBk1CEV/JWBjumQjFFY+Mcflz+tvVJ64WJUEfeG+RP84HoP6q/vx1zgTGhKRLUUiXt3ZaIvnA6Xwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871607; c=relaxed/simple;
	bh=7GdxcZbU6PaP3ai8T+WsCSFE9EyZ4hyCn6eLLUXVL90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nktK7EGve0XDQEcAXGgajQuEoEFAKW/+8Zl5/yKCaD5acFfQo8rOb1P+R9HcwA7CmscZn+O0y+OQbTSetAP3zp+ajeWsUa+LfgUFJxveJ401YsYfosgir+SSvOFG0arsW8TVWTYyiIB3/7q+3mv7WZxyQnaWXQwvLAoBEEadfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=QfahnD8U; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755871603; x=1755878803;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=ChIAGY8iOJZjjV4o3t9lWmIPlIy3alLDkrcvmJ1FqNg=;
 b=QfahnD8U1neuyYqvyHzp7uIm8tUGwHz4UaA9I0ZtTW3VoLx+FQhLuy6WevmMXslIInuzu6aUYp3CVvAbrePhZqb6w0hw4TOgBNcAhGmuSMHEtdzqqaq8D73xcszJf8Sech0GZGuIlqH64nS8s0fBU49I9ZfuiOy5OgFnUmC84quJIPVuQ82lv6YTUM5JQRo9AMq4r1DNctQVpzBXh5IapqMHeLs3rfk08vYMhIBDMjRjDzp7ZL7QnP/A+ftRKviBBGBkE7QEW3oedKH22wM6VqYD/kOelfcoUFjGJo/r45p/ceP5fifZQNCZMljLNk1JdvA3LivdQ8alD47jYNJ/QQ==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 6daba92ea63ccfff060124925e5e264487e90b9321cf65b2c1448e79f35e349c with SMTP id
 68a87973ca5807a38b37fc89; Fri, 22 Aug 2025 14:06:43 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: liuhangbin@gmail.com
Cc: alessandro@0x65c.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v3] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Fri, 22 Aug 2025 16:03:39 +0200
Message-ID: <20250822140633.891360-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aKhqmsheZAqThrSu@fedora>
References: <aKhqmsheZAqThrSu@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Fri, 22 Aug 2025 at 15:03, Hangbin Liu <liuhangbin@gmail.com> wrote:

>
> The Reviewed-by tag should be here
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks again for your feedback on the previous version.

This is v3 of the patch, with the `Reviewed-by:` tag now correctly
placed above the `Signed-off-by:` line as per your suggestion.

Changelog:
v3:
- Moved Reviewed-by tag above Signed-off-by tag

Best regards,  
Alessandro

