Return-Path: <linux-kselftest+bounces-13689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26B93001D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 19:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428CB1F2482F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F8177982;
	Fri, 12 Jul 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipzjd/X7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B6176FD6;
	Fri, 12 Jul 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807009; cv=none; b=NHmZSteqZNuzr36fw//9U1PP2EJ4f7kzPM6hyh3FEg1IaSyA7Rj/hGwgrTAnC0aTEmtTaJ43z6KKbgvNjLG996E7ADBu3H2/3a64pWO8ZKjeODuEjIxUE9LWtB5AAOCYQjtbPXclKQViKhDQyYc6SHe1/+LA5/i33UyUhVCXPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807009; c=relaxed/simple;
	bh=3eIayu+1UjuqYkXeZHl62aeqtdNVS59QixTFOllGIwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPb9oW8DRC4yTIH9kur0BJ8cbqN1u1kJuKriInQDif4U9slN4OgtWgTqmR3lzJIdIlQ70BaAXl7scX/jW3Q5c/blHJVIdY7AnQc96SEB1L4R4J4JKlXNzoQkZZmswo+KWLciTcMYhczzEOLjAQBsE2WNrZN492qWbogHKKLm1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipzjd/X7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af8062039so1862411b3a.0;
        Fri, 12 Jul 2024 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720807007; x=1721411807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvJqMz2g+QWTR/26uvM7LO7+R0enQZRj5mYnnkzzRMo=;
        b=Ipzjd/X7JjVHinD/8km7XAfv0EgGSbe1cfVeFl4jjNxx4wT+agHmBw851TnH+xVoPz
         o4eNr4NTuZjv0wJtMD0RE9KHuCwue3aQ5Ys+P9OgpIL4JGDDzlQRNS33E7KToyNDYXuW
         q3WbOGFnL76MDba8lKKR5uW3IE4++jKe+CVu9KQXcZMny0RduamUFeh6t3DvB32+gj9L
         gXSNSXU41qRSyU81QUb2I1EEyKTCW7ySFnAwpfudd3Er/EISxf5MvPapZ+svYkaMNFMi
         iCWiY8Ru/jivVs6fWPEQBQDDujUBj8pUVJX/jV8T0Q1+78ZJnokiTFQtS39XIjPkeZxM
         Y/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807007; x=1721411807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvJqMz2g+QWTR/26uvM7LO7+R0enQZRj5mYnnkzzRMo=;
        b=Ywg6dcK/AsWSV1jeHGJ8A67EuC4EOebfvISZB3AaMRlTHQtTPv/wtltuEyTkxWiz/J
         zXSZsNykXBh6eRqehjoXprC6CHBZLMdRwXHgcQDrNaEdDU1VYWIQyIRxFPCVVQGlX+bb
         rUuZVAhvTDGkEiy5E6jD9r3mVOajhFaLVXEYtZ1UE5KxGuRzCiYYnuSHpPHUkT3hIfp6
         60UA7VTSZzaMaCT/i9gEQiy9eNL9h8SZwyCC2L23HobD0GNgnLLSje53Pvv+uI1cqmHV
         wcPT3K2p30QRw2JyY6XuVcSQjDJ19oyU0OZl94vVohUcR3srSoRdHAOps2QFuGz7rLOi
         4IDg==
X-Forwarded-Encrypted: i=1; AJvYcCVR/keXp1KMeOZijsQFg1SOyAkD6qjLb1ClPCugZprjyZvKsZI8I0DyN4bgsWy+OwiZ8hKo0S74XfYpO7jKYogaCXg/rTfWaQ2E4EuerP3OQ9Mny/vl1J9SNqw8razbvit1CDNZHUjOFhfjrevcS1iCQ2Im7OGe6bJcXlVBGQmuoIcYDtHmTUaXZeh+7nGFQZzj2Gb9Zf/QfMrGTjGCns8EmS4lAWmBiKBxeDBhvgc1CxnRH/qZgJ6P7qdrAgdGNnwoy6+PRafrkA==
X-Gm-Message-State: AOJu0Yw0XEvYXRXp4aghGx8rm9p6kn2OmbF21k4vmlklqwxK/ztjUFI9
	+q+8yE5iQyfIIkdAXdYNR/SfDC6phvbB4ebzEIU9199VO3wHquoL8fUuNg==
X-Google-Smtp-Source: AGHT+IEQhOEcyJo9nymze7EJcWUmb0pa0RPK5Sh5riMCUcRm7lnBoF6POikeGeyiWKlGRHtmtiu3qw==
X-Received: by 2002:a05:6a21:6704:b0:1c0:f080:ed5b with SMTP id adf61e73a8af0-1c2984ce612mr12926893637.54.1720807006607;
        Fri, 12 Jul 2024 10:56:46 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:500::7:44ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab8041sm69662725ad.135.2024.07.12.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:56:46 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:56:41 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, 
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH bpf-next v4 11/20] bpf, lsm: Add disabled BPF LSM hook
 list
Message-ID: <qjrf5c6f24b6ef5tpvpz75uxp6ro6mhos34ovssinv4yxjwyz3@nvs75o5sywgx>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
 <20240711111908.3817636-12-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711111908.3817636-12-xukuohai@huaweicloud.com>

On Thu, Jul 11, 2024 at 07:18:59PM +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Add a disabled hooks list for BPF LSM. progs being attached to the
> listed hooks will be rejected by the verifier.
> 
> Suggested-by: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Xu,

The patches 11 and higher are mostly independent from lsm refactoring.
Please send them as a separate patchset for bpf-next.
While lsm cleanups are being reviewed this lsm_disabled list can be
a bit larger temporarily.

