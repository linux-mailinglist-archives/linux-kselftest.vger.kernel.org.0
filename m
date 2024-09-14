Return-Path: <linux-kselftest+bounces-17986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB19790A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527C3284334
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522F1CEEBD;
	Sat, 14 Sep 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVUGYYRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775711CEAA6
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314453; cv=none; b=Js9v/+eFYY1LuVcpBDVIXqf3MgL6SDYUeqygPjG5Glg+CFd9DMMLfaoWfdBOSYHPmwM8pyScXLHihG3mHGKqfbY/31CDpMyS9kysuicIFiJ1grWxyM4ghE0RHFraXoOfjMvdUjXKmK54vTxdGfWc0hXDFgPwE5uVDqsb+7tMUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314453; c=relaxed/simple;
	bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0GM5G0KO/B6vVJ8n3jExVrRsWTyz0PnV5pD2jPKEnqtDjMUX2x/HZR8RR7T3gHC/jbpODobNqeuaH2b00xoIQ3J0f95g3SMQ4nybTqz5mAIyNRtOpFHUI+tJMRhcfGc6++w0pUZrms9rpZID5WBOGNxYBXChdmQe04Riu6B734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVUGYYRJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so3968063a12.2
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726314450; x=1726919250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
        b=bVUGYYRJB+tjaOi/otyE+1z5FiCPABKtvQ9C+0n7Jep5qmUKVbaKcIhpHu+LNfh82A
         v6IGk4PHiH1TeC3MIJi7Wa3IL2TGcx5uyMnEvfOmqv1370DzyTDFH7454JRs3rzrasvS
         eWGl13CDix3fGmEKe/8J8rcZPAUlIxtma3W0bEBfSnT0JKT4fTMKQPCOTJCq5foO/Q3a
         l1aweMMQHVUFc5FXwCGuAk8OAATeica1M8hBG6BdMsuFGR9bab5NYZurcw2E0OhWv+zg
         Z/OdqtKK2YRupLY8QJfCTJMBRhDr84aXQRryVLwKxO3MJKqFE6BjgWnioDPIygvFA0kO
         Jvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726314450; x=1726919250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
        b=on9Tl9jkpP/Rw0tIkT4FzsI236ivMGxDRxLdHmicXiCVfnP6M91tKmeTpIgJoNx6O1
         ysDWRa1AFbgZF1NECKtXOR2Ad8t/1R5M5pawZAs6DSpklHwDMqOv6Rotipzp+cNdpg0K
         TCp2cwabEGpBprqFWK3EHF9t3dZcOAel7+XMhsQp68YdL0Dr4QvoalokrvolCr4WbDPj
         luNgXz84Zj2Fn+Zs3YTX+xlZqksuk3QdcOPn4Dj5BeA4gTNqEZdzvuoS1TlNK3kHxnYs
         17l85hR7ztj1miCchzwjQpyBiJylsLfiGN06DJGEsf/Ok+U7RIlqryicdLOASZHAngzg
         4PHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM3eUtbsieW6nE8PxWHM1bjQbB7HWwI9UzYiU6MrosivJeBJz+nd1EEwZy+QqdgkM9dgPjIapwvI5RdwbYrGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdd+vrYII5hXztF14mINHSoFZ6/rw9pTsfV93Y+s9aHqmN3J7
	1PYLUMZxmFd7KO32iM+zbc8NA4Eze1COhFUMJyM404XQ3OTbLJvcTGrDlbKZe2phN/kUiEHi2sq
	Abkr1gGxTJw0BsyHNrZD5mIzc3XuOLqxheUtO
X-Google-Smtp-Source: AGHT+IFtdrSxlO4oLPwyB3rc7pgzSuSRHZMIf4+9ownvSxFM74FNtfppj59QZ9sJ+X03DfBTWg5uNF5t1+P4iaYK+H4=
X-Received: by 2002:a05:6402:4012:b0:5c2:7699:fa95 with SMTP id
 4fb4d7f45d1cf-5c413e1ff4amr8494152a12.19.1726314448521; Sat, 14 Sep 2024
 04:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com> <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
In-Reply-To: <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Sep 2024 13:47:17 +0200
Message-ID: <CANn89iLkmsLZHfp=K5Ho9_asVzmv03knj1n=aap9G+xhRaeBXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix bpf_get/setsockopt to tos not
 take effect when TCP over IPv4 via INET6 API
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, 
	alan.maguire@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 12:32=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.c=
om> wrote:
>
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.
>
> Bpf_get/setsockopt use sk_is_inet() helper to fix this case.
>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

