Return-Path: <linux-kselftest+bounces-29434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65EA693A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724688A0BE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B611D5CF9;
	Wed, 19 Mar 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VHEtRE82"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CD1C3308
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398347; cv=none; b=fPKiGUhHM7aqDQnizYERzazycqrookrdsIPZSklmUjytLcHA5DMBCQp+a7TdwwioPwPpIrdQJZGwchhJnaAQTrdzHWZI55AjgSCgYB9YMh5J6j98a3E+m1JldlW5+rUTSe8YQeOB+03CYzqXxl0rkKFYMKeDXL6Evid0RZ92Ce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398347; c=relaxed/simple;
	bh=DecHoeVvuZPf1798B6ofl0KEVe3MSa1ULHgC3f/pgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twqEsUUtGlYOTpBzBqFk9tnKKPa4CLpCiUhDF9Fvq6rSXdc4qA3mqkmaCHqez8YDC+swxHHwX3qETtUfgF7jjaHhihaGcvpCKOfWTNaYMSd88kDnKbmUMQsvKE5cjNd5ufCxNBB2zjhkPQ6qie5Wv6CRJgX+1YSYhEn4tVGnLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VHEtRE82; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22359001f1aso27942945ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742398343; x=1743003143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=VHEtRE82dpW80KhRY2ibVphmyZxSCwFrNEb47iibxNFEoqgYfCoeXH/9f1C+JxXAbT
         PkNtN2RH9ixJHgDd4g2ZrCjIHzNSfTmQkkSzMR6hR2OcmL3z96OUpkeVdVjnkLkJRjuH
         YqVxFgFMdB3x7wAuV0MHrb7qir5rwBztA8CPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398343; x=1743003143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=FDoXCA27zBIv+GElRNIDH3alMUV0YQFurTtCJEhan6jVAcEnb1rdMMcTGCnAkW3frZ
         A4xNRH/Cn4PMdjrLOVTIlVy4umx1wVTILRl1uy6e22ddmep5SMOi0Edi8uMh9RAnp6Sj
         66TU2utvcV62AwIneDSN0aFx4KaBbQtMfc1qn6Y6alX6v+APtqdUmSzgbX3ImxQEEZyL
         KrV0GDjm/56V/ycbSeAeLn1COjo8+qqZieuU0AK8aEjDL+2EzZOVvKWgor8lXzg6Sbrj
         YaLWHt+0NTnS4ia5JwOxm5gUI6v0qa49hFeW+QRLLqrotVB7LXzW7E5AUDXu3WxbVBXF
         CpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNzIYGOf4ghK5FlRPmoHDkFPK4BwsTOF87bMn/Xi9A19As/RykohcHC37cWIZSbrPEwzuaQ82cj1hgDETI4ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfHnQz+woIQZKJ6sehKuJiHeHVFp+0+0nkW7Itei0VJUbTGoP
	nu/ewWq+7j5hK0BP+R4aP3N56oj+4XqrDGINGFkS4tqDLNI3+VwEj1QkrPbWyas=
X-Gm-Gg: ASbGncvE/K5Av8FKOdQQpvbDxetpA9PzYMl+chZvygC1pv6N00Wv0NloLxozeexkB8j
	RVhW3dDTwgeEmyhT6kAhdkafpwxJ1+CJDjM/Mqo8x6XqqaX8gBQFj4HhuCuan5trTZndhujwoWo
	4EiH0UOQHYfPgqi20DNT6PA7MGpVFhUpU/X3dWCgqSpK/M1Z7rw1RHuhaR9U7Nx26Zie7kxbcVa
	cZ2HPsNHj4efKI+Z7hPrHWoam9bsWc98uIhnjTRGfmqBDG9jpSQsEgtYfGcTcLzFQ2RxpYsTO3P
	1zFozsv0ZybUs7Q2rVMarMgr3dDH9MQrF3Q7LbfZ8jj6MENkGLTDSTPXkBmgQ1URF2JVFgQjH5Q
	hAXHORnce1f7w83jPqwwZ85NS2RU=
X-Google-Smtp-Source: AGHT+IE928EvL/A0pSVSiRkpQ590uJxm0F/MyNYT3ARIPaWUxA9t+V2zDq6An5Z8ZPQuHl4hSSFFbg==
X-Received: by 2002:a05:6a20:a111:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fbed315b41mr5956837637.36.1742398343445;
        Wed, 19 Mar 2025 08:32:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96e58sm11106959a12.78.2025.03.19.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:32:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:32:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9p6oFlHxkYvUA8N@infradead.org>

On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> > One way to fix this is to add zerocopy notifications to sendfile similar
> > to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> > extensive work done by Pavel [1].
> 
> What is a "zerocopy notification" 

See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
sendmsg and passes MSG_ZEROCOPY a completion notification is added
to the error queue. The user app can poll for these to find out when
the TX has completed and the buffer it passed to the kernel can be
overwritten.

My series provides the same functionality via splice and sendfile2.

[1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html

> and why aren't you simply plugging this into io_uring and generate
> a CQE so that it works like all other asynchronous operations?

I linked to the iouring work that Pavel did in the cover letter.
Please take a look.

That work refactored the internals of how zerocopy completion
notifications are wired up, allowing other pieces of code to use the
same infrastructure and extend it, if needed.

My series is using the same internals that iouring (and others) use
to generate zerocopy completion notifications. Unlike iouring,
though, I don't need a fully customized implementation with a new
user API for harvesting completion events; I can use the existing
mechanism already in the kernel that user apps already use for
sendmsg (the error queue, as explained above and in the
MSG_ZEROCOPY documentation).

Let me know if that answers your question or if you have other
questions.

Thanks,
Joe

