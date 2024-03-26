Return-Path: <linux-kselftest+bounces-6616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6D88BF1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5FC1F3C0D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13B54BF0;
	Tue, 26 Mar 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xn1P/ON/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA39EAF6;
	Tue, 26 Mar 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448230; cv=none; b=rRTglPNTEuxAOZ4rpzRoP9iV9M5yTDuAP6zaWJDztSyRETqPloJENa1T2c38pypyr+5ISxEXCq1vfL8bm7db6jgpEwKEZ1R/jtM/HEQ5DgEA0dVAekQAind3ZavYKlOXCB/giuMMTpIjGaNytqMf5echwE30YCrgc7I8hoPsWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448230; c=relaxed/simple;
	bh=pdDzJ4I1i10nF0ugfqTYvU9sGjwwKUbQsBGjybZ+7q4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9JvaHxi317Jve+4Kvq9WxNMbXp7Be/0oYzMbICcUCYzSCV/NyCW0SKjCPdtYW9cnZzqgshbCyimjjrn2f1UtLSJdsJX7iGLOD+6cZhW6lQojw9WUvQP4yac6GlG7epoq9auEOvHWxtzZ/sRq0tHDffad9admSeq2qFNAHaMwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xn1P/ON/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pdDzJ4I1i10nF0ugfqTYvU9sGjwwKUbQsBGjybZ+7q4=;
	t=1711448228; x=1712657828; b=xn1P/ON/G7JzntbIFaE/yxzQ3kNCvjqKRKyK0ju8LI8Ntm8
	CFm5+VgPEnxgsDGjIZXoCYrg96AcuQU9i+Z6d+VOxrVi1D1tBo+nzoAUpm3Oza+K2ZNft3AWR8ztc
	5UyD+dsKV1NRovCtOABD9pBhnW3M/YSxQVw/UrD8b0o6BeawcLHxl2Lqxerr1ewfXn0nJJa/OhJhL
	/1ivTposcWAQD9/bnWk13kMBWjeFqMUq9nj5rIv0XNERGarDtT9YRnyroGze125FYG5fVXcdZ1qBj
	6fZjhoatJEzOvMXoTf+zypQGBWCHHfWhxX/enbO/gmnm1KvNFs6ulydUo8bsLohw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp3rY-0000000FdUT-0ht8;
	Tue, 26 Mar 2024 11:17:00 +0100
Message-ID: <3088ef70d96eaec0f33c4588581cb0f23a790b05.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED
 for --alltests
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, SeongJae Park <sj@kernel.org>, Rae Moar
	 <rmoar@google.com>, Mark Brown <broonie@kernel.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kunit-dev@googlegroups.com"
	 <kunit-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:16:58 +0100
In-Reply-To: <20240326100740.178594-1-davidgow@google.com>
References: <20240326100740.178594-1-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 10:07 +0000, David Gow wrote:
>=20
> Johannes: Does this conflict with the CONFIG_NETDEVICES / CONFIG_WLAN
> fixes to all_tests.config? I'd assume not, but I'm happy to take them
> via KUnit if you'd prefer anyway.
>=20

I already have it in my tree, so I guess I'd prefer it to stay, but it
also doesn't conflict at all, I added the lines before the existing
wireless ones.

johannes

