Return-Path: <linux-kselftest+bounces-49542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMibAwzMb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49542-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:40:12 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD66499C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8572586D161
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24D43CEC3;
	Tue, 20 Jan 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNhRKUeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556542EED6;
	Tue, 20 Jan 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931186; cv=none; b=lr4jgOpXsoKEjn0eWmH1D2kl/wD9ztJ0ODho9AmvVbGwlsZR+odGtrnIc3x/sBpuhTMvANstPxE1lc/z9sVBpf3tBC51BTblhC8zrKRIji+tqyhlTHUsk7GNTQKgeMgCc4A3Pv7svDv11xZfV+81afgW3+5337z9Vn0wdqYfsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931186; c=relaxed/simple;
	bh=TBRtgmjrWAjuHKUcUNVVb7dFeVlm8K/wDFyukeuO4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckp7cHQevhPD9X+A0FiHWr6DvEHD+fsxWpi+rfPzDMK+2yy0zdSn+Meonhsf+H6jyK1CXJGoCQCKrZqXZMzV68+CV/d94/uiLz+b131Fbl9FBWIh2h+0HNnlIYsO9zXsXiDebWe6Oqent4qaMqIhwUwrQsmHc9FKDxvI2yh8YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNhRKUeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C96C19425;
	Tue, 20 Jan 2026 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931185;
	bh=TBRtgmjrWAjuHKUcUNVVb7dFeVlm8K/wDFyukeuO4yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNhRKUeBDn7HI+Rf4DnqVFcGEjTt+0wEI6/IYeAJiUCBHmIWokXFrZn66wnsDkvH3
	 vfYVkodq5FbsVrJ0N8kngkIzwi820ZViMbFcmgdPlWGCmuNsnIjU4Uz9QMSV3T8/9V
	 s1V2Ap5zlzr41jcOI39ugYO52ab0iWLECdqHdeXLAbbSQbwQBP9STm6fSJauGBK1Lf
	 LS3ZJ8EEwYSD8oJ+6OIIyrNA3KsQ2xqBoWOirw1+32T7EFXzfv9X0i7qBoGeQD6w1v
	 Q1mjvhDfWv1z92xh7JgnHoLxjSrIGM7vsnQuFgcbg1+Osn4AR28QiDXkIPdYf3LybR
	 xV4p94jQcpeGA==
Date: Tue, 20 Jan 2026 17:46:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	nao.horiguchi@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests/mm: add memory failure anonymous page
 test
Message-ID: <737310eb-05e5-4234-af67-9118b3f395ab@sirena.org.uk>
References: <20260120123239.909882-1-linmiaohe@huawei.com>
 <20260120123239.909882-2-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ObFgKhUWYWaLUrs4"
Content-Disposition: inline
In-Reply-To: <20260120123239.909882-2-linmiaohe@huawei.com>
X-Cookie: Leveraging always beats prototyping.
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49542-lists,linux-kselftest=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,suse.cz,google.com,suse.com,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-kselftest@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-kselftest];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 6FD66499C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ObFgKhUWYWaLUrs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2026 at 08:32:37PM +0800, Miaohe Lin wrote:

> +# Try to load hwpoison_inject if not present.
> +HWPOISON_DIR=/sys/kernel/debug/hwpoison/
> +if [ ! -d "$HWPOISON_DIR" ]; then
> +	if ! modprobe -q -R hwpoison_inject; then
> +		echo "Module hwpoison_inject not found, skipping..."
> +	else
> +		modprobe hwpoison_inject > /dev/null 2>&1
> +		LOADED_MOD=1
> +	fi
> +fi

You should also add HWPOISION_INJECT and likely also MEMORY_FAILURE
(which it depends on) to the config fragment in

   tools/testing/selftests/mm/config

so people and tools know the config options are needed to get all the
tests running.

--ObFgKhUWYWaLUrs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvv2sACgkQJNaLcl1U
h9AeOgf/TpiwY5cSu8LPqhvpbJnimocDBJ2K+sADzVszT6mIF7B4Un4ISFwMtoN5
1LFLpWadwOpWZm+fAu6aj9z6pm4gXV/h3wvKE4rhgvCmLopMxaYZs/ZPyppookNb
wwh9UsnigPV07m6pqg5BFpwzdNj2QqOKJP+HWCNjCwvOw5FgDMhOFUhdnzCswd1B
Yn0kHmRW4RGceobzLmMN2CoYk4zs4gk97NjX2dNAUUwtSTLftMVQswUX0CnEaUoS
wRPA//UIgzYgIl0yTmaSwRMlCeGlE8wZz8cDX96cEOXBLH5dTPZUzs9KXgwGX8E6
rEt6r2ADfzxEDWkdX92JQvkkjIBlRw==
=wRVM
-----END PGP SIGNATURE-----

--ObFgKhUWYWaLUrs4--

