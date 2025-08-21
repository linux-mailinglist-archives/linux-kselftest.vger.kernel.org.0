Return-Path: <linux-kselftest+bounces-39507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74ECB2FCFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E17E1D015E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAA331DDBB;
	Thu, 21 Aug 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="dVCNL1V2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6930F809
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786115; cv=none; b=UjSQOAO741Lsovr9tCXxVPm4FIpU5semmVRCkOV3RAK+W1aV7wNvCc9vLDFcG4ZYqWpHpHI13wNcI8OGCESew5ibSyCXP3TicdLEZ6NiVvWCqgGiobyCB5MFCojFYNmw0s8Tg23N/vLRNG120IaVACll1E3gE7f0NYqF+uCTlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786115; c=relaxed/simple;
	bh=fI/vBmYoPbL2e7jrvLhjIJBCGy37cdY01TiUpHVOgfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzUcf4NnvoTmuPgbjYSEifkV8aSbYpY/NONNm8U1b9vj7xuGlIvYLLTlISwTFU7qOtKbo6jqld0vmCluRJZz+Ug5iDzF57eGRUga/mEtylsbMTdgWUDLUuG3677ZtAEbLEWs4ABKUXyOGkRDsOb0FT0b3JFvJ7FKD7UJ6Kfq68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=dVCNL1V2; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755786110; x=1755793310;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=fI/vBmYoPbL2e7jrvLhjIJBCGy37cdY01TiUpHVOgfw=;
 b=dVCNL1V25yxu824yG3JHfcq7Y7hYdifh/4QQMBWlXZNG3Qk+r+/S2CMcu6Fs6fvoZNqCcfWiur/QLTU+TUAJflANfXgM7NzEC+Uq8Efez6q+YpxDh101ZbzqHgaJFHOTJTWiTxp25hUFfddWUGiAG0wNcc9/QYRWqNMXppJCUvkYcQZZXTggirsa3v6ZrJHQs+2iIU6u9DJvuBvGj3g8Rn6578IPNEbmxs25GMxdHD5J3i1SSyAEzF8ddvMWAkX1zHwYsw/bLuLoH5AFYo7ckFlkv7VcDa3WypI+mLVKEhGIw67CfBYx8TMAN7q9B+knli8664LQKFb2F+lTnkzNNg==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7b15455cfe8dbafdef49f89608815e4823a50a73c49b1f725c695bfcd1e1c385 with SMTP id
 68a72b7e03c0e2ff1b44b96c; Thu, 21 Aug 2025 14:21:50 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: alessandro@0x65c.net,
	linux-kselftest@vger.kernel.org,
	liuhangbin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Thu, 21 Aug 2025 16:16:50 +0200
Message-ID: <20250821142141.735075-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
References: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi,

Following up on Hangbin's comment, here is the updated patch with
adjustments to skip tests gracefully when missing tools and iproute2
capabilities.

Thanks for your time and consideration.

Best regards,
Alessandro Ratti

