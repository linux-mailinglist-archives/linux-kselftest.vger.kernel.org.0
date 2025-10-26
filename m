Return-Path: <linux-kselftest+bounces-44056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7362FC0A140
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 02:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE5B434BA82
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E792222D2;
	Sun, 26 Oct 2025 00:25:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38647221D87;
	Sun, 26 Oct 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761438327; cv=none; b=JRi8gN7k/ld4nT6Tpwq7D7wz0ZitRR9t1ktvvMl8CalCheYOe1dhFQG4PD2Nml/ZqrUjU+KbuCzTlAXj/DHpsvoghcQWJptZuqRvWjkdywq4H+elb5hzpypBSA39he/fJxJtgrB2daGBahuJVIusjksUtmiIZE2sUUgkNwJGExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761438327; c=relaxed/simple;
	bh=NngNYQPp33+uptER8AxTWZ5xI0sq3aqpnbiX6AXmjhg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Jx0wZeUpS1qDRkwElgzk3DMwoLicoM9lO/zsk+zWjZcx3QoaWFSWsckzdy6Zo7hwN/Xlq9bavVUNW4KaoLqSNb6oMeCH15zw9+IIyPEXs8GGyb7Dn6L/rdeGwamYXJfHl030aUTN0L3/u4iqOWeGrk8dRZN15QXV2RbKYwTWhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8C392340DC6;
	Sun, 26 Oct 2025 00:25:23 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: olsajiri@gmail.com
Cc: bpf@vger.kernel.org,david.hunter.linux@gmail.com,kees@kernel.org,khalid@kernel.org,linux-kernel-mentees@lists.linuxfoundation.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,luto@amacapital.net,nirbhay.lkd@gmail.com,shuah@kernel.org,wad@chromium.org
Subject: Re: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
Organization: Gentoo
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Sun, 26 Oct 2025 01:25:20 +0100
Message-ID: <87qzuqik5r.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I tried to reproduce it with a small testcase and I could reproduce the
error with -fcf-protection and not without (where I get a warning that
the nocf_check attribute is ignored b/c of no flag).

