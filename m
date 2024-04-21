Return-Path: <linux-kselftest+bounces-8584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E88AC0EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 21:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116AE1C20A40
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D134086B;
	Sun, 21 Apr 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0nfp+Ph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E33DB9A
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727054; cv=none; b=dTB0RYPFGOH9DS2J8ZIFaJPBpcxGqxa75ppOh+BdtvALTuOJgDYwOISg0gKzWENol+6fQjnKJFKWBcnV2IEG7EPdnNQhhkXKMOV7EWtQYTNnNLe6tsFLjGS1o8KUlOwxA2EYLWbBT5ch9M0zO7bx+QooTynGjCLgFQJJjRTSAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727054; c=relaxed/simple;
	bh=+/8QEE9YePSg/galLpFrDm4GY3g598oBFhiLGTRLf0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiG8i3vvE2ifZ994mf3/DuYt/P40tAuhYnpbo7/i0jg0g4VZwhQsPYpwycncEn7EgsvFwU5cwSK0QYZLURWiQRGXEuALoccZjwa/SyNC9qiUeDsyWRHSC2Q3BeB2OU8MwDvWaK9fqKicJw97k3Gjl5EBIEC3XDHjA6cBCQIeNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0nfp+Ph; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so6815a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713727050; x=1714331850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eze0LsHzPJ7SDHFDA7mSkhV7oL+4KuAEW53gwAGUEn0=;
        b=M0nfp+PhitIw6ITMeD8BSq9JUIrKh5bONiAPHc8OY2JjsRhwQvF6SBkWh9uf4OPSOX
         oNRUs7Ml1Xcv+KEZ/JvvbSGGIV3RIYrUFjWt11ducUfVzFcOLxmJc1ZOKNnbY8gO+JKz
         VWvSy51UKTmL1OYQEc8cFm883lW2zgY8H4zF2vqLhMEZuhlKa/UjMKrifCltaZtOFB3W
         YFiasmCrAdsTpddH9SsLVdD8hy/P9OX+kRLMafwhsSg3LaQ09KSmc+0gE5lHjOCk5mT5
         HnZU193RneLW0C16eX7FEzGJsFZg8fOV4RXSc6Y+qO+D4ANUcL7A6+6J48+gCuCDIzl8
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713727050; x=1714331850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eze0LsHzPJ7SDHFDA7mSkhV7oL+4KuAEW53gwAGUEn0=;
        b=L0JcqHXjmfalWSvn7egWkPXrcH/5z47YfxvI9PK1o/DudevpQt2YTJ45giyWVGwCeK
         AdDdW3dEe3GZlFql5vGZCMNZErzNE2zCT+TfaVyZijf1vNZcPrLM43lfTsRSFnA5YDPf
         DYjkdUxc+tTibElI0DG/YwA4sSSn4Zdr4L+Ln6rfdEelbcQcBRkExnZkY4br7BO/YQZ/
         xq2bEOKKMh+XCSk8W+ZSOLwjhXl2YuIJe+00DDXgZ+GISA4r0M1ic2Bp0LGqtWQ3CzQe
         XMQXneHIHL3tlpjcFRqG6GkH3/Fzc4UZKOa3VvKVb3P80wVOryDGdwLyeKJTKi9EkegU
         z3+g==
X-Forwarded-Encrypted: i=1; AJvYcCXwp5ZrmYVSg54Z3Bc5sdDB9au1FpwpRf/FxxAEP5kELh6JLUGdkDZARxXmE3LuKhDIaQKQknNS47WRGHfDbRp+XrqV9khuC+srJHmXSqzW
X-Gm-Message-State: AOJu0YyAaG26JenroRFYLdnnO2RBEjE5kJaVPkYyuh6lXVK3BtcQy+Vs
	9JWtZzaocwa1v7V0FfSfCXjO+sLcu86wBxeUDeorfND0Y+/DPLVvxyCR/DaMEQPWYTGQDak/8Aq
	Wb2dTUWxG+dI1Ol/8hFbYpvWEe4VD6bo+J1X5
X-Google-Smtp-Source: AGHT+IF39jxMUkxtZgUhyXYhczCnLxgPMBrWmEVVmDip7RrgTHiI0P9fFfVq/hyxb78FF6LRw4+Y57GRQ7DNMkerZjI=
X-Received: by 2002:a05:6402:12c8:b0:571:d30b:18a0 with SMTP id
 k8-20020a05640212c800b00571d30b18a0mr153361edx.0.1713727049828; Sun, 21 Apr
 2024 12:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420023543.3300306-1-kuba@kernel.org> <20240420023543.3300306-2-kuba@kernel.org>
In-Reply-To: <20240420023543.3300306-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 21 Apr 2024 21:17:15 +0200
Message-ID: <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in qstats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com, 
	linux-kselftest@vger.kernel.org, dsahern@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 4:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Having to filter the right ifindex in the tests is a bit tedious.
> Add support for dumping qstats for a single ifindex.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  1 +
>  net/core/netdev-genl-gen.c              |  1 +
>  net/core/netdev-genl.c                  | 52 ++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 76352dbd2be4..679c4130707c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -486,6 +486,7 @@ name: netdev
>        dump:
>          request:
>            attributes:
> +            - ifindex
>              - scope
>          reply:
>            attributes:
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 8d8ace9ef87f..8350a0afa9ec 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -70,6 +70,7 @@ static const struct nla_policy netdev_napi_get_dump_nl_=
policy[NETDEV_A_NAPI_IFIN
>
>  /* NETDEV_CMD_QSTATS_GET - dump */
>  static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTA=
TS_SCOPE + 1] =3D {
> +       [NETDEV_A_QSTATS_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
>         [NETDEV_A_QSTATS_SCOPE] =3D NLA_POLICY_MASK(NLA_UINT, 0x1),
>  };
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 7004b3399c2b..dd6510f2c652 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -639,6 +639,24 @@ netdev_nl_stats_by_netdev(struct net_device *netdev,=
 struct sk_buff *rsp,
>         return -EMSGSIZE;
>  }
>
> +static int
> +netdev_nl_qstats_get_dump_one(struct net_device *netdev, unsigned int sc=
ope,
> +                             struct sk_buff *skb, const struct genl_info=
 *info,
> +                             struct netdev_nl_dump_ctx *ctx)
> +{
> +       if (!netdev->stat_ops)
> +               return 0;
> +
> +       switch (scope) {
> +       case 0:
> +               return netdev_nl_stats_by_netdev(netdev, skb, info);
> +       case NETDEV_QSTATS_SCOPE_QUEUE:
> +               return netdev_nl_stats_by_queue(netdev, skb, info, ctx);
> +       }
> +
> +       return -EINVAL; /* Should not happen, per netlink policy */
> +}
> +
>  int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>                                 struct netlink_callback *cb)
>  {
> @@ -646,6 +664,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>         const struct genl_info *info =3D genl_info_dump(cb);
>         struct net *net =3D sock_net(skb->sk);
>         struct net_device *netdev;
> +       unsigned int ifindex;
>         unsigned int scope;
>         int err =3D 0;
>
> @@ -653,21 +672,28 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb=
,
>         if (info->attrs[NETDEV_A_QSTATS_SCOPE])
>                 scope =3D nla_get_uint(info->attrs[NETDEV_A_QSTATS_SCOPE]=
);
>
> -       rtnl_lock();
> -       for_each_netdev_dump(net, netdev, ctx->ifindex) {
> -               if (!netdev->stat_ops)
> -                       continue;
> +       ifindex =3D 0;
> +       if (info->attrs[NETDEV_A_QSTATS_IFINDEX])
> +               ifindex =3D nla_get_u32(info->attrs[NETDEV_A_QSTATS_IFIND=
EX]);
>
> -               switch (scope) {
> -               case 0:
> -                       err =3D netdev_nl_stats_by_netdev(netdev, skb, in=
fo);
> -                       break;
> -               case NETDEV_QSTATS_SCOPE_QUEUE:
> -                       err =3D netdev_nl_stats_by_queue(netdev, skb, inf=
o, ctx);
> -                       break;
> +       rtnl_lock();
> +       if (ifindex) {
> +               netdev =3D __dev_get_by_index(net, ifindex);

I wonder if NLM_F_DUMP_FILTERED should not be reported to user space ?

