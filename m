Return-Path: <linux-kselftest+bounces-30737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD7A88A9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C213AAF58
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830028B4FE;
	Mon, 14 Apr 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NI2KrdVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A019D06A
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653709; cv=none; b=jXnKUaByF7evnH+ZSiNPyCRoe1JgQPcxRid5Ig6udmENhAwUzpIgxIimHQqjiyydrmjdpUrE5Wtif5BMmlkThtYoU3mz6up2sYAfhVo9ast6c56APV65hAVwSGgLfo8QquCGYG+Q+9y+d8kOYNdIUNfd6s8gcvmHJSEk8dFtRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653709; c=relaxed/simple;
	bh=iW3kH2HTEzdUPe3PMacgKc10LLcFWt408tAqpj5Ug38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUFf4c3ICHe0619mPg1W8JaFCJvUW6NCectiv+E012o7uOi3h4680Y20UaFSzRseOTu3f7RRykg3VBdTU7wGMtzpF1DphJPnZs36LX6ifBwLr7H/x4/k5Op3akvoZ9UrUDfGmCQOMMnqlGkBQQzak8c42kLnTiDiAJBlTdNYcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NI2KrdVN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso36971865e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744653704; x=1745258504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBLuWbdtMel6i38ax54FckIfRTO54jFDOdfOeU/b1uA=;
        b=NI2KrdVNy1gI5DLkGdbkUcn6RCAlzOGICv/nFe8gCoFZcs0AIbvZMBAJdEMIg7dSqZ
         P4VcKF8s5+D7Yk2uM91Df38hiLoPVqzd20yjPZWmVULpVm4W4UftlhIfHTozErXjyABI
         2aoN4991rewB8Sh8rLoNS7HsaI26/fvi7v6SfXSsAS8K0SnUX5Yg7eiVZldxhja6ePrX
         3W0knjBG4k09gk9MQHf9h2gQl12pXZUkWcVJeXpRPDBhnRIXgYG47OvqhAF9P++LE80J
         jbImAf5XyujuNEg6hDhCRUVr19fVNE6wfKMgGpdU4Kn4xZeqQpwN7elQhTCdNxAoyD2D
         BsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653704; x=1745258504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBLuWbdtMel6i38ax54FckIfRTO54jFDOdfOeU/b1uA=;
        b=Gwbf133nwalcxHWgRdIiuv8wnLm6K9WnHDj3Lzt0iwkkDMBlBaXKZbV1B1AVGH6JTr
         Cl76UxPJxhv3O6zz3shGo8FJUTkpUpFfDouaBTy4sz4XsWMq4VBBkFxSY+LmAw4vsTFB
         NHStiXi0y+mZxx7qjhOof4LIjwHTu9EM34BWYEJwszCVb09Zd5G7KC4sX8AZGLQom8ni
         BUTEEUeOThRG4rPASxq/QkRZ7sQOAGfAT4IlTyZephiMVz2oR8Ri6s56tWwGr09cUrNJ
         G33yWxiceH7iJqyHsc4B8Js34tsQrPlM1QhwGTtl9OiZRXtIzVTqt0hIYIHfs4TXCuOz
         hkSA==
X-Forwarded-Encrypted: i=1; AJvYcCUy15erx1+6NIHNZvRWVjb0sr/anJiRFe6sg7CG/v230Ynb8R6lCoYRz0oB0BuhtMKkzU7SxjK4ymFMQC4dYOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOmxol1XOf7F1y6hAeUJrtWqG+uNI8yGlB5zo7+HxkmSYrSaw
	o3rhSqOKmMjdfQTZZ7KKBzZ7CdIajl8a7clpqCCMhj9zXQ5hLN/yw9IttCCynXk=
X-Gm-Gg: ASbGncvmXYqDv+EwBDEBX6B3TQzl93XhUwowsVr/th97i7tKf/e09Cm8KFOhRJtvLuA
	eIJINtvD5y0a+fl9yJ9sPwq/mnoeTynF23prOP4HDT+TJ6F1PvD9ha5JZwtdt3jdBTSM+wI9EqF
	e4EcqEGDhjAiEM4J0nMd8niEE/mQWDpSwdtOqFnJ4rJz8lznQUCwFYDu+AZb+0aQcGmU5ke3/sH
	b00b0QZ1wCnZ4ynRv7h0gCFRFCIoGq4NIMLryuxnljskuIKalR7LAiBHpEIml3ktwtMcZjNqtX+
	AMrAH3NXkr1K6tlQaazn48t8ze9q0UBaIMg8gde8vGA=
X-Google-Smtp-Source: AGHT+IEtQycgr4S3+PgCeHikW/Hyvr38HbspTFMfglvu/9qnMU6MbIV/XlhPDnBnlVxtCbAFfxNM+w==
X-Received: by 2002:a5d:598e:0:b0:39c:3122:ad55 with SMTP id ffacd0b85a97d-39ea51f5b0dmr9250849f8f.18.1744653704398;
        Mon, 14 Apr 2025 11:01:44 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae978023sm11710271f8f.47.2025.04.14.11.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:01:43 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:01:42 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <gpzfja7rsb6cy6r5mpfbakx7xp444xskdumooocytwhi6362fk@hdjhr7zampaj>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
 <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
 <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>
 <20250414164721.GA741145@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2v2mxjanhgmijod"
Content-Disposition: inline
In-Reply-To: <20250414164721.GA741145@cmpxchg.org>


--s2v2mxjanhgmijod
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

On Mon, Apr 14, 2025 at 12:47:21PM -0400, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> It's not a functional change to the protection semantics or the
> reclaim behavior.

Yes, that's how I understand it, therefore I'm wondering what does it
change.

If this is taken:
               if (!mem_cgroup_usage(memcg, false))
                       continue;

this would've been taken too:
                if (mem_cgroup_below_min(target_memcg, memcg))
                        continue;
(unless target_memcg =3D=3D memcg but that's not interesting for the events
here)

> The problem is if we go into low_reclaim and encounter an empty group,
> we'll issue "low-protected group is being reclaimed" events,

How can this happen when
	page_counter_read(&memcg->memory) <=3D memcg->memory.emin
? (I.e. in this case 0 <=3D emin and emin >=3D 0.)

> which is kind of absurd (nothing will be reclaimed) and thus confusing
> to users (I didn't even configure any protection!)

Yes.
=20
> I suggested, instead of redefining the protection definitions for that
> special case, to bypass all the checks and the scan count calculations
> when we already know the group is empty and none of this applies.
>=20
> https://lore.kernel.org/linux-mm/20250404181308.GA300138@cmpxchg.org/

Is this non-functional change to make shrink_node_memcgs() robust
against possible future redefinitions of mem_cgroup_below_*()?


Michal

--s2v2mxjanhgmijod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/1NhAAKCRAt3Wney77B
SRqTAP9ceEwBCy9asOHNELiBKAgokXBXGmLAsJ7NOFiKLG7XAgD/WuDqfbDSlDL8
jqWttQx7fV7ktBUPZ6qqN4+sjbp5fgE=
=UgxG
-----END PGP SIGNATURE-----

--s2v2mxjanhgmijod--

