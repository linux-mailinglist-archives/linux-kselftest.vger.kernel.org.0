Return-Path: <linux-kselftest+bounces-28572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87DA5889A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6302E3ABC32
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1E1A9B34;
	Sun,  9 Mar 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE5lZA9i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5321714B2
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Mar 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556745; cv=none; b=RNE4uZtZoY7f089ga/VmYGVUg0K0prrk01arLPDSLkaZ1wQqVzdbFHEjXOM8oGxRV+GYP1H0t7hTJ5qYKuOB2Uayuezg33rGjeR8VFJPo9cKVnwHSjlAWgGcUlYGYkiriEkNxK8FXEx+um6OzIKFozNrBx8aVKIpmtCku8phpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556745; c=relaxed/simple;
	bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnvihaFmRrR58HRmuTQ6vV2p8ISFBdzCrX8l8cJ8n0ymjcSV/mYf6ggUNIrMmzCiRCKCjV/Fj2+oxN9qUvsU1sJMRib3wCq2PYSq9n9lv1BhlXoXU8PIr3A+Q6I+qC5B9hojSN9S6hT+80GqAojHFKNq2WJHGnW+HouLkwT+SI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE5lZA9i; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225489a0ae6so140545ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741556744; x=1742161544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
        b=TE5lZA9iFD24JzzmrNSbFvr4FS57DX4Ih/goDyY30lyo0Ck4QLwjKNAZjxl0SsHnOU
         JoJxjr9o3vT24H5FMqO5Er7tk98SvzKiltgjQM4cBLxZSuAwSEuwkl7pFnN/xHKUtUDA
         wtizuB5acniRxhYpYGs8l8yawslyy+YfU5wRhG7QlbyRmyfv68E1bhDIH5MpQljSxpKM
         +hX+g1VD222S6V451EHXdna1ez7p+7dUVyrjUfYmSnmJ6Vj81AmNn5IhiA5qoCsA3xeB
         YVgOm555gsRyPNxtQwsOndhbd6l+s1qnOIq7rbCfyY+LIijc1v9pvYKLbNaNZVLrx/Al
         W+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556744; x=1742161544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
        b=HmwVEbEdZgcwmNoXPavlTAukRagOL5HhR9Ktin1VWBZMTPGIJMg2OClWVu5p57n8p0
         b0dY3LWkAf8e1QYRuwxN8BMhEFF8n96CY64eytk/hkiwIqe9ZzMU3gSmAyBZ/JH8yP4L
         TrWd6C9bTAulezKw2jWoAawdZdRFC1ba4kEdPVsYrEhbW6ZUxBRYXsWnlaA8aabY6mpO
         wfsT8rT+riq8Fqxnx5laWNQaft9G++tnAcMUyLJ1MCw7VBEi2aTHz0kwetv77spcPRGG
         cEVY7wGxr3r26Mp6cN/FIpZi4Xzd4uGKYhcq8AMqLrtZoDS8rYsjnD0nM1eT037ar+bm
         j2JA==
X-Forwarded-Encrypted: i=1; AJvYcCWmhv+EAeXPL9sqM/XVnqhBJOAqZMJnNZ+nx3pxxRW4cG6YR/aw42Yz+hhUjR4XPtOMngPRJ87CnkozsWDiEyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIs51NQA7t0GcTP0mopbiETsISH0d8W5gqRlyvwvZ1mJr3jQl
	BFUZBjga9VXQ3qdDAOnQfRMtqPrzswnVarLCPmefo7LjRQ00NnuyN1+OGGX83MQEsv5G3xrN+Xr
	3TPBJ9/jStfwveVRZavWtJQ+VPJpTqzOkgOkj
X-Gm-Gg: ASbGnculv90L5oRFNzxJZ1nwbiq3L1++PvHwP5If2k3k/Hq1H4wrmGLVHwDSFIi7oK7
	Qv1aCPMHXSOJfaIuGEaLZ2SBRmx6cu4N4lhDyP8hlRH7xXBkjEkWO4K+bSgZBmfT/U50ZtCA0Om
	sopygoY8/OnEpK3clCy4TuRatcbnU=
X-Google-Smtp-Source: AGHT+IE2p+jDsD0j5SnKQKAip/If8+BtHqBaY7NIMLZUZReCQUCINAqK67F79wf3FLZVxZCUEpde7fx/HaA1cATafu4=
X-Received: by 2002:a17:902:d490:b0:223:5696:44f5 with SMTP id
 d9443c01a7336-22540e5c2a6mr2765455ad.12.1741556743264; Sun, 09 Mar 2025
 14:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-8-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-8-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 14:45:30 -0700
X-Gm-Features: AQ5f1Jo1n20Hcbf99zGlYqtQvtZAYKwrLd33MKVPaIwpybZWFt1Sr6yP1JEeOLs
Message-ID: <CAHS8izNe4NBbTtordf04uE_+4fz9ut8rcgmNTuCiiZtDdy2M0Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 7/8] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com, 
	skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	somnath.kotur@broadcom.com, dw@davidwei.uk, amritha.nambiar@intel.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 6:43=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> When devmem socket is closed, netdev_rx_queue_restart() is called to
> reset queue by the net_devmem_unbind_dmabuf(). But callback may return
> -ENETDOWN if the interface is down because queues are already freed
> when the interface is down so queue reset is not needed.
> So, it should not warn if the return value is -ENETDOWN.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

