Return-Path: <linux-kselftest+bounces-14277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0593D7BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E1A1C212BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9817D358;
	Fri, 26 Jul 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B0wnUgTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DA18AEA
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015371; cv=none; b=BGvAG+41vBGikSuS9mc9cp5NzFSi1dnIfYIsrfYhLcsLptr4doshKal/zAGBLMatBAlYonGU6c+L/8C1F9RSBhMMf0i6oJhqvPoJ3ljFQ7v274h3OrQZUK1RS+22EUfPlwnyC9O5J+BcV/vv2YOzQzTtRr7iZ8GerrOCE02HBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015371; c=relaxed/simple;
	bh=P3XyIo3R4arE45x8ffW/mmiyN4CSBGFSQO01bTvWo8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cp0uTXid3yH9wgGktAIz/yPepNAXY8cFitPisOiNUAWD8P27rJv7BqIjYjetnjf5NAY+x6Nz/fkj5viWlVs3Oyf/mevtZrufj6gxttdMMzX/UNxgssvNuB736paOCqSw3Xu0dV/pi0WyK3GtSrKAt7yfs7Vxal2CCFBTsBGglvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B0wnUgTg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so210417266b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722015367; x=1722620167; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ho3v43VUSeiXA5xt2OR6F6u287xxMm9s+P8qGJiEG2w=;
        b=B0wnUgTgOW2AVpThET/ZEPVIN7EF4O4k3XBoMoGhjmA702g3lEtw/SAsUZVDGLg2/N
         5izsB0iaYIMJ/ysUkg17m7BdPT8fThbvU90k81+amEcJ2DK4P/eX+SwCQ+C8Z1elM4jE
         X9nQHonEj3tqNvUqk3UblsxOaCGZ2bDNM98jurh/Ikl0w+Y3e+bV95ygNFiZ4MWhlmLl
         SZJT7BYFEAu9qZpLel0JMrbBJk/OTb0JO1Fjwq4HeO16amIap58EE1o3QcWs2VUofo12
         QVOY0yy4BBuKJLCLLUKfOfVtsGS+NeancbiawEyhRpM1uzNCkB2LvAlqqLlad+rQSEC2
         cYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015367; x=1722620167;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho3v43VUSeiXA5xt2OR6F6u287xxMm9s+P8qGJiEG2w=;
        b=P51oDrD12BzahADOEVzkw0PYLTcINt6G0Z0YviiH88QcXmsVM4RBZeP7UY+aYmh9rC
         zyrvw/1DXtVY3JYi4ar7dkGW6cj5F8zo4T++o+V+qIMnPV+pPoIKo6BR/7LzPs+3FQoI
         GbAQmY4Kr1KSVtmcFmJIK/PRtFnlOjEk/Z/PUF2mVLJNcYaktiT48o4o9yEZmKWtMsW6
         aYwa2PsWn9qYHWln5q2ef5l0Tk3zRubZ3dEfgjoI5OsAip3kNH3695tso7VdafMB7e+F
         Y34WP9G79VH1lCPKlg5iL4mxG5/ijsBEdBHAgzpYykTgiZLA7aRltl4uXK8rJs5zvZIn
         pR/A==
X-Forwarded-Encrypted: i=1; AJvYcCVnY+8o5+WkY/cWWHkUJF/X/En4QJ6jitBHGK1nXbaiWT2/oL+e4NNK0RxyKXzWFc5GYENAkVrY6UT4nFJjU3zXTjLCHi7mhGDww6Hhd3RQ
X-Gm-Message-State: AOJu0Ywevupzd7D4kWxIXWpcMk1qPBF9W+INfH9U9GuKS/5Jow3tCq67
	hU8ZUG+X7xMMwmAQWEp9mS682SketBDLz0I8qB2gp0cvlkQZueTgOugTIzb9fBk=
X-Google-Smtp-Source: AGHT+IHAAs6rashs3VUJdqFq7L9KZw0J+O+BWPDkdi/7GTQuTGrXRGsfwBjXUcOXij9YKstTeHW0KA==
X-Received: by 2002:a17:906:c142:b0:a77:e48d:bae with SMTP id a640c23a62f3a-a7d3ffe7145mr20773366b.28.1722015367224;
        Fri, 26 Jul 2024 10:36:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadafd9asm198150266b.187.2024.07.26.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:36:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 0/6] selftest/bpf: Various sockmap-related fixes
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
	(Michal Luczaj's message of "Wed, 24 Jul 2024 13:32:36 +0200")
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 26 Jul 2024 19:36:05 +0200
Message-ID: <871q3gkqd6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
>
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.
>
> v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>   - No declarations in function body (Jakub)
>   - Don't touch output arguments until function succeeds (Jakub)
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

I see this depends on your previous series that got applied onto bpf
tree, but this seems more like bpf-next material considering it's all
tests, and a mix of improvements and fixups.

