Return-Path: <linux-kselftest+bounces-11318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A28FF712
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607241C20B51
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117913C694;
	Thu,  6 Jun 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RajqOgPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF934595B
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Jun 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710810; cv=none; b=GfyOpAxY8pqGw0alb/fbSOVFoHmTszZfaYxUJhpb8YdAwUT7WdwvhImYlSczQhFa3/1e6v+X318hnmWjQ4ifYEJMneqQ/5SrO3bpoxnkOgdor63lt8HKouT8LuKaR2Jyl4db3J3BTunvdNAknkkDVMvAuZpAjidhK0/YNgHmqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710810; c=relaxed/simple;
	bh=+FpI6vYpR5bbyxTEbYr9rtFq5rhJFeJhBlUYUqcnlgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7fUx97t8QCtL9jeLEQ7aHlZu90Y3cfqbUdkcshwipGegofgOS2oVGCFyFhfK9+iJOV8227OMO7lcnckxuv9yTw2OosTKkyQe8vwy4w631NRpSRkxhq+2GcQrKzDXeOpsMqoJM5J4xidmGGZmENyMRa4VJfrTVjQKVsBzNW/QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RajqOgPB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a087bc74bso15053977b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2024 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717710807; x=1718315607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=RajqOgPBwv8XJAwhXWZXlVonrRF/YPPRy9ozsRER3hLSkk6xn5+2NkLmVUpYWo4z24
         vkdDuC+8GAi+qh9w4Q8U8gJqytgI1tFDxKjmY07/kt30zRk4SsHMnidS0/j80kJsZYJZ
         e9uYsPru6kO6APku6GR8PEw+6fLvfsvBKhdW7NkohU3AbJ9ua2xvtoDbuMaFPC00pb5y
         4aDAvy4mPm25RQfwi7BHcBrjo2H1pAYX0OFVEOYbCs/fmyHVX4I6gpN5bfjuRB1O1Ov+
         87VlPFsC7ESewPLRCFIkMsnBlfW3xXJB4C9PpcBVxvg+1WLVZzfVBQGLcqG+xHyCgNS7
         2gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710807; x=1718315607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=gNoaLO5w3SJQ2tsc4V30TKpFVzV4vzS4AAmzd/NHLrSMfzDz8YbtWelaBXd1a3f06a
         /N3Dsg0qdd4DdNh6Qe3eaU/JQeYuIFH0WJaoNHdFmtFMM6kN6nVFlWbMP3UxrkYpy4Wp
         TcMUXHmmr1deT5LGbAEZq7Pplb+Uqo94ROw/Eir+82csDutbz3lEcnjAqpNpOBgYA9hP
         35/wDSqP41GxfVpCDOfCUMQpCLnbUdRri2k8iM0yk+zRS4YEDpI0ogFWW3X82zhxZv/W
         78nB8tN+KpTjlQ+c19J9TdCoZQarHWqmI4dkOaxB8ATpNlKQJy2yHqmhPzMarO5sjexL
         rpRg==
X-Forwarded-Encrypted: i=1; AJvYcCW4JBVDvJiFwjxwkRQQw8+4owcv8ZLDyHH+Ufk3GXbwk4nmU8qME4+U4cvDzDAR/AQhd3l91IvQoGlasosNOvuJloMcMzBJW31nRq5Ci/+o
X-Gm-Message-State: AOJu0Yz9JJ3IEnDyyIP+ht0x8QyPTz/gNoLETDBkDJnv3YW3rSNc8jcz
	a5UzWRXFKnkoCLuBKffyOmWtaAL36UiDTgwdb5Ha0LbEbAdMd3aNAi079ZhJOpxmj9N3FxJIVS/
	eaopRRON55zam6S51REKYTxwC4kiFfJJKIPFI
X-Google-Smtp-Source: AGHT+IHr+vEgrNOTl351kbnQRCFUgvkUIF6Lp0SFJ0/CR+WTO6ePRrwS52Q8I6+bzc57ubSMFu7oFmRulMZYl2piscY=
X-Received: by 2002:a81:7b57:0:b0:622:df58:2cf6 with SMTP id
 00721157ae682-62cd568be78mr5356547b3.50.1717710807083; Thu, 06 Jun 2024
 14:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com> <20240411122752.2873562-2-xukuohai@huaweicloud.com>
In-Reply-To: <20240411122752.2873562-2-xukuohai@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Jun 2024 17:53:16 -0400
Message-ID: <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
> default return value, and the expected return range.
>
> The LSM_RET_INT is declared as:
>
> LSM_RET_INT(defval, min, max)
>
> where
>
> - defval is the default return value
>
> - min and max indicate the expected return range is [min, max]
>
> The return value range for each lsm hook is taken from the description
> in security/security.c.
>
> The expanded result of LSM_RET_INT is not changed, and the compiled
> product is not changed.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>  include/linux/lsm_hooks.h     |   6 -
>  kernel/bpf/bpf_lsm.c          |  10 +
>  security/security.c           |   1 +
>  4 files changed, 313 insertions(+), 295 deletions(-)

...

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 334e00efbde4..708f515ffbf3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -18,435 +18,448 @@
>   * The macro LSM_HOOK is used to define the data structures required by
>   * the LSM framework using the pattern:
>   *
> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args..=
.)
>   *
>   * struct security_hook_heads {
> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAM=
E;
>   *   #include <linux/lsm_hook_defs.h>
>   *   #undef LSM_HOOK
>   * };
>   */
> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, con=
st struct cred *mgr)
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const s=
truct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, con=
st struct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const=
 struct cred *from,
>          const struct cred *to, const struct file *file)

I'm not overly excited about injecting these additional return value
range annotations into the LSM hook definitions, especially since the
vast majority of the hooks "returns 0 on success, negative values on
error".  I'd rather see some effort put into looking at the
feasibility of converting some (all?) of the LSM hook return value
exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
I haven't had the time to look into that myself, but if you wanted to
do that I think it would be a good thing.

--=20
paul-moore.com

