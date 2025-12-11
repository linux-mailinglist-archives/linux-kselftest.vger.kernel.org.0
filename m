Return-Path: <linux-kselftest+bounces-47409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFFCB5944
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 11:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA8C3011FAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE93064B9;
	Thu, 11 Dec 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S87Qr1jl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3627F171
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450773; cv=none; b=U8O3MfnUvm1sf0R42kOLqKtKVDBHXmLiQBxdbBp5HHCy3J7A7OQw2BcWgp9K2LyrRHgGHsrCPAApT6OYhDw3tT2VkBtVoba+SfP4VljjBhr8Lmd30ebgoIjEwAk3kjMljoyuJEVRkUZ53fJKKCb32ikmNt81rMTuSF4E2MrIdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450773; c=relaxed/simple;
	bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0h4KtQLXvRwgeLMYGR1vEyuA2Wwe6RtcakN8bfdki9yRf2yCiJZGQi1OGNzkNFrIz73WeITfApZOrmtZf53Njm7FgoHDFfTPP+eLPjkFt4vH9nflegI0hjQgx5B4mjBOiAEMqWcocOSL7JdPUMSdGb2SKR7ajZbIRJ4/ML/jzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S87Qr1jl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so455815f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765450769; x=1766055569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
        b=S87Qr1jlec/3pyKFQL9bwWOQkTT1wxZsAQLf4xOuIHuuglodvjpv6mltihDbsUKdl1
         d120e+SPFOv+iFXBOh2Xb8z7b+eDKWOzPPjlQelbiC7E8gODcRr4gkmpJ3C1foMk6O30
         23aaL0BcJUruvIcXVgf2iez6nmsJXEWq6OGcyIzjr5Okr3e50TWa9BGjAI/b8eXYf4hn
         6dWNazaoZ1/RdhtoM145hFsd+fi1468DsntPewMLdGzg7B8O2ubyZlmQeVMjJF+MynW7
         8brisp3FDBkSoE4i3aHDuO6ihFEXvL3LOwfMucR/FRMbVT9oHS6gAp/L7A5yh+BejGKD
         Ga+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765450769; x=1766055569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
        b=seSaVdmMXCgSlfhlN5mZH6GFxr/U4YKkciFDTaCY91L+TkKGEBTw2T09oK408rGyBy
         awwbtMCpNaThHiM18JRVrbG04NwOlFVlEPWOFz7NY0PW1EbKPHEd7XNw6klS+4HNfjXT
         743w07NKJ19hMnZsr0nZG6r//+Eh1P39KRCq9fbjEj22bZ0W6keeHICDWjzb7IPvzVgz
         sgxr967BS3Xa6fEd1/wS6m6+suEAvI4pbSS+y75a5DxqLmUTI6O/HOoliymH/A0Fr/fu
         DvLq+PtnUdhvVjlrPIZEQOWp9+td27lMgy02ST849+kFaaFPp5NwHo/cCeR9Uit2Po5w
         WSww==
X-Forwarded-Encrypted: i=1; AJvYcCXunZX22oc+Zo5Lxm19SNXD3QM7/13TnKW9ZVLpEjnn9OWWTc7dRbnfHVK80pMRtZwQoCnNK6aLUktOWmkIfYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+JaCxIyHOUFWtZjsNn4YgJT30qw5Sl/ToZEXvnoBbrqPbfXz
	hfk3iMbFxIK+sDkHnQgA4dHfKGjTFpcBceTw8KbBk93ts4CUvSmCWl5I/nUbo/6hW+0=
X-Gm-Gg: AY/fxX7LT1KMObNuP3Hp/wx5jf2wqKgrggIKW7CgIv8J1Nbv5fFCDuNx3PRu60TirdY
	qOGy0pvpNAR08w/376sdxXnMOr4yLdOG2q9pCzJHkBWEtWyAz685LX+ZJLiVq4rT4g2EtcDt5bh
	3uassc3/lmtmlfjLnaNQgFIFyneGd/CxG7Jf0kmWQXyLDoD0KMlyfaZeYEJSlSb9uUWt/Saa2ap
	k1CNkDhUfAou/XxlGxjbD40IhfFXavRDd+b1ktsF34UpWqXDyUA8AVRs1YZgkYkHJ2InL28WXQv
	FdkCXNJ9CM0KooZp/qiX1kkc94OMRPeu/OmifqbwWxPR8ztcXLtcX9aMzk8/TYqkA7Cy7RhLi5M
	wglFucnZ2Ur6Og9j1Lo8BPB4N5XtveLW/hNgKxnzRSAauB+TR6dhXFQxN07UzRGlxPwwtuOHwk8
	0+mSE6iXvR6gbswOYj6VYPXFK2efWFbD8=
X-Google-Smtp-Source: AGHT+IElxuz1/bTQLy/0cWVW28q9/npQ2QBgwkAFmGpoBGs1i00zm7N9I+fkoLidNO861vpqoM/X5Q==
X-Received: by 2002:a05:6000:2509:b0:42b:41dc:1b61 with SMTP id ffacd0b85a97d-42fa3af7d51mr5942608f8f.35.1765450769201;
        Thu, 11 Dec 2025 02:59:29 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b750sm4792704f8f.42.2025.12.11.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:59:28 -0800 (PST)
Date: Thu, 11 Dec 2025 11:59:27 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llong@redhat.com, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <in2stxqa2swky4zwzlrm4h5vuz627ruedhq6zqr22xqwv5di7c@vcwc3z2sczx4>
References: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
 <20251210101108.969603-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="afui5iqoqigvmlf2"
Content-Disposition: inline
In-Reply-To: <20251210101108.969603-1-sunshaojie@kylinos.cn>


--afui5iqoqigvmlf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

On Wed, Dec 10, 2025 at 06:11:08PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
> Regardless of whether A1 through A5 belong to the same user or different
> users, arbitration conflicts between sibling nodes can still occur (e.g.,
> due to user misconfiguration). The key question is: when such a conflict
> arises, should all sibling nodes be invalidated, or only the node that
> triggered the conflict?

Any serious [1] affinity users should watch for cpuset.cpus.partition
already (since it can be invalidated by hotplug or IMO more probable
ancestor re-configuration). Do you agree?

Then I'd say it's reasonable to invalidate all (same reasoning -- it
doesn't matter on the order in which siblings are configured, I consider
local partitions). What would you see as the upsides of invalidating
only the last offender (under the assumption above about watching)?

Thanks,
Michal

[1] The others may make use of the proposed cpu.max.concurrency [2]
[2] https://lpc.events/event/18/contributions/1978/


--afui5iqoqigvmlf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTqkDRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiprQEAr1ThSDOLEr1kSXQnDyes
WlVu/BAmdv4fFacLcZvPWVMBAKSU5cJlMmcsNEV4epuZr6dpVs5BFraFguJjSTSA
qC4J
=lO4i
-----END PGP SIGNATURE-----

--afui5iqoqigvmlf2--

