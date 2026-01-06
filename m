Return-Path: <linux-kselftest+bounces-48349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F286CFB3A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 23:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099F23012DF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0FE3126DF;
	Tue,  6 Jan 2026 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjobh6QU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77E30F950
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737651; cv=none; b=sluGgmGf5zV5FWxAu6y3wOEnpoXK8z6cKougxBb+x69dVDhBD9keiVTBFmOmVd5cLIOcP5vNOQFXBX0E21TDaFHIWHtVPQsq52qIOpFw8HMzVg4So0UCx44lRz2W04sTDQ+Ivwzq+S5Y5zVMlbNX1n2OQNtzswx1r8uFKq/6SsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737651; c=relaxed/simple;
	bh=BKVgYfecIlwaEfG2yIYO31DYcPw5TzZyRT9d/OzC59g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=emtZBLAaN0kqUgxNn3rhi8oZ4QW+2vxl3LtrS4hJ+yOk2lZaxQPqpxQo9imztO6cUBHaG+fc7dPKNRbPBroRQVSfaDoEPvF5b9sjNy1gW3vqb1K4qSSwZv5G+4E6uok+OP7ZyhNgj229WnwNCYa5bLGPWT001pW0jvK1gjCBmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjobh6QU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787eb2d8663so5205987b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767737647; x=1768342447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXTAUGOjyeJOlTuz196szGLfvzOOt7OotlkuHVJJ76k=;
        b=jjobh6QUB9YiJCKjS5JSiCLsJeXUFqsG5JMYxzEkuQjNwWWcaTAu24fGx4DI+boXha
         MCRvD4W06vqO3EE2woQuV4/R88qWeswUeBnzhn1QbHJ5CP+/DfrUt5lq/X3tPTAerqIX
         xbK+FGeJoWay9Xa8B5xjlD8hkhXUSpDDxskTeog0qT0q2A2lf4VLfHn0myaZYvb0lYII
         fARBHrFCmhnIIMOCxTw1DO5OeIxeSpciRqPLl6iwPhHpmHuT2fsYKHkQ853RtCzIq2by
         E0C6fm1SP/36xxR4JYbx+gVPME+2qyHcjE9QsnIwPN+YZOgfvwgvB/1eqaJW8COpCwKw
         8/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737647; x=1768342447;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXTAUGOjyeJOlTuz196szGLfvzOOt7OotlkuHVJJ76k=;
        b=DSrRIAZFdDQuccc0oiTFluH3aD0KzDuhEO2w30rsDa9fpAokulJG0l1r3MRKNYa2m3
         QO8nP8Qoq1tM8m602w4oNONbXIMPmmwvr9H+JkmADYhdMEa60Yy/MFcuOjEGfvTjelbc
         Bqnnn7c5UCBLTy38StqyknIMhEQ6RgdrqoL8Nfn+s0IGfQ8V3+nXSNZFChy0fBZH+f8t
         3H9YP8QgEdV9wlBuCGqZBEUzZ0yx4Q0pPx88NOCGf4L43A/YSwWfhmK4QVvuY8wNlE1R
         UbjxTipC23HzqMFbLuIeqW3UleZIbwswZScgdtF0ivkxu9UpXH01EuUAuy9M1V0iaw+h
         nAwA==
X-Forwarded-Encrypted: i=1; AJvYcCXV3voaYWfNNepYVryuppdldzQVXgzCzi7kKoZW4G+B6I+eBVzm0nXb+DMFv+Ap+ZNAdjje25atBQvaG/+Zz1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCh3X3wEznCmQ55/ocb/oc9k+R/OwnkVTdFT5K1NHF+R0tJAD
	EgzCNuu9OEAr71c/oWYA8eVjy1GN0AtQYopzdgy4tz26VLu05r2WYpmS
X-Gm-Gg: AY/fxX7ixv24Xy6sLbKVW7ujJ0sDFLPiOhs6b1raG5KHiTlm+e9APdpK3bkV4HxsMxs
	eFch5vpwWGpuRDgYRWcKUFGmqchPaHZkySd8BUOYToNXuOlCr1Pv1Q06Y7pQcpHp0Licgbk/1YM
	+tNmdcSbOvJDBQ4hVqOpb7Ppx0K8vLTVzg4DiAVQpLkLvc0QnXKDk6O3nnf16EqJyb/xcDK2I/X
	G6U+hu7DHBuGavD/q8bCmpiPqBIbcJ1dJ4EcZ9MxJJmJOH0aLwSNVviJWXe3dLA8uhD6gwPx10E
	5+ADUswd2GNTRm7Ipwi3W94f+kJmzeJZWf/gguNLFfUC4q1yNqoeUjswJ0O1Z1mKmFxvquOcvX+
	MjwR34Fld8AkilrBi4QIIQLoxpwY/o6bePSBxRpxbiVc6zrWFolB6lPQ/pNUuRS1R9qCDZ4J27V
	1QgkKnVL4n1XPr/BnCKpJiDRxWCGU3wUiRN9OVtmWWTyRnlWZVXtxTv/6Yni4=
X-Google-Smtp-Source: AGHT+IFVw2/A2IyvOueA9fhhC+wh3ph13++iKFZyzR0whc4WRr2nxsaHNxNq0kyCG35wbd92xWDOPQ==
X-Received: by 2002:a05:690e:d8a:b0:644:6c19:8a26 with SMTP id 956f58d0204a3-647166aa310mr513038d50.19.1767737646993;
        Tue, 06 Jan 2026 14:14:06 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d89d607sm1338464d50.12.2026.01.06.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:14:06 -0800 (PST)
Date: Tue, 06 Jan 2026 17:14:05 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xu Du <xudu@redhat.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
In-Reply-To: <cover.1767597114.git.xudu@redhat.com>
References: <cover.1767597114.git.xudu@redhat.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Du wrote:
> The primary goal is to add test validation for GSO when operating over
> UDP tunnels, a scenario which is not currently covered.
> 
> The design strategy is to extend the existing tun/tap testing infrastructure
> to support this new use-case, rather than introducing a new or parallel framework.
> This allows for better integration and re-use of existing test logic.
> 
> ---
> v3 -> v4:
>  - Rebase onto the latest net-next tree to resolve merge conflicts.
> 
> v3: https://lore.kernel.org/netdev/cover.1767580224.git.xudu@redhat.com/
>  - Re-send the patch series becasue Patchwork don't update them.
> 
> v2: https://lore.kernel.org/netdev/cover.1767074545.git.xudu@redhat.com/
>  - Addresse sporadic failures due to too early send.
>  - Refactor environment address assign helper function.
>  - Fix incorrect argument passing in build packet functions.
> 
> v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/
> 
> Xu Du (8):
>   selftest: tun: Format tun.c existing code

We generally don't do such refactoring changes. But in this case for a
test and when the changes are minimal, it's ok. Thanks for pulling
then into a separate commit.

>   selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
>   selftest: tun: Refactor tun_delete to use tuntap_helpers
>   selftest: tap: Refactor tap test to use tuntap_helpers
>   selftest: tun: Add helpers for GSO over UDP tunnel
>   selftest: tun: Add test for sending gso packet into tun
>   selftest: tun: Add test for receiving gso packet from tun
>   selftest: tun: Add test data for success and failure paths
> 
>  tools/testing/selftests/net/tap.c            | 281 +-----
>  tools/testing/selftests/net/tun.c            | 919 ++++++++++++++++++-
>  tools/testing/selftests/net/tuntap_helpers.h | 602 ++++++++++++
>  3 files changed, 1526 insertions(+), 276 deletions(-)
>  create mode 100644 tools/testing/selftests/net/tuntap_helpers.h

That's a lot of code, also to maintain long term.

Is there an alternative that has less code churn? For instance, can
the new netlink code be replaced by YNL, whether in C or called from
a script?

For instance patch 5 which sets up an env, is probably more concisely
written as a script. That may or may not work with the existing KUnit
framework.

Iff not, it would be better if the code moved out of existing files
into tuntap_helpers.h is moved in a separate NOOP move patch. Such as
netlink (e.g., rtattr_add) and the build_.. functions.



