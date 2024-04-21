Return-Path: <linux-kselftest+bounces-8583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8D8ABFAD
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A168828178A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BE18044;
	Sun, 21 Apr 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7C7xHwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122C101DE;
	Sun, 21 Apr 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713711596; cv=none; b=D5JobiZY/RZifZMi6htn6XPHWVk6HuU2romx35LXsFN3AWnmMy+zN9cYG6yfg2dfVouxOXjXwwGU9/eZMw6/m+YBf9ztGTpuZ/V7EDKuTAa2bMLMu3+FkfhC+xfpHxNHV5OXWzHCpefPFP+HxyFX6D1USs5eMRoZRBK8cmzHijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713711596; c=relaxed/simple;
	bh=0oHyOxyJe89t+eFluzMBl1X02mgr03UnWbGysWYg+S8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MDADdh5Ni+vYC6cXdyDs6n8H4xdXhknlJ0sYe7+HXrTy4iMCKX3YTuwTh64vsyKQx7jSNSqrvbXoUvExMaXFNQGTOJMTtCe0CTy4juM8tNjs7FZdOOBh4j/I+AT4cfDlWakSO6DTxWkNBAIgxLc0HCu+n8uF0Wg6HiXqoPuKHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7C7xHwd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6969388c36fso16088296d6.1;
        Sun, 21 Apr 2024 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713711594; x=1714316394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppCs1gVFA6/mDvzLlpSI1Fe+HMDGRm5Acwq7gckfLBU=;
        b=Z7C7xHwdW7CGxVh6OxETw9Fk83eWj4bpNULppHbD/qzClZqyC4u3+dgtYhWYJuCzre
         B3mchdBecB5Nzsnww3l68kanHMrxhiiB/EHXPiQ80FxygCRUzrOPcusfsBXK1GKYHKS3
         6EgPnkR2uIpm167UiobuzKP2Ra/yDyQ1N0GN/FnbvLAOBxZFGIVz97FVn4zjnFsU05Yv
         WqjPP7K7vK9SMvTMAYW2lNWVFDX6nNW7ntMqNULh7HsNkHmj0EKqOp9FgvY72BWYuLbS
         y3KY5gVkBgXqfFU30MnHPxEY3ORLUZ+UARCE03Dg25RQ5fL2UFbooEOA7mY8SKOi7evz
         D4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713711594; x=1714316394;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ppCs1gVFA6/mDvzLlpSI1Fe+HMDGRm5Acwq7gckfLBU=;
        b=CceVj6Lac/RQ+Vk6y9NGqAtA4hwNJM8cCuvd21QTGF5ynzNbF8mTjYAnVxRWyExEET
         ZkTfqzHWaY9Jlg3nwJDXAS80UBOYdQ5GFrwGvNrZlL/irg8InhDQc2H+c30kPb0UieMq
         KHhfKtsDYiyja2Pt5fzzntpdH/Fb11jSxLIVu58ocqoheGt3DEqJVjT1BYALAKbO7MRa
         PBhOxN5SZ3crPvhDNa0dUt5gjidJMQczP7kbRPVOwwxWyq6cFDbNJaURRkcIfz0y5pQg
         Ve3kHuZCq71pMiQ4fsL5gdKHWVIBg0hbA1g5628L4E+W7onpNxr2HQ6vj2LK1lF6uQVH
         DmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVYWzVQCte6G6n23baByMYi95YWtM5HoEqBRHb7FJ9EcNKTAuoWcXx+G0NSsIwgkHtW0aPyBfBX+dORmloBrIR/fCRmkoAitF+CVFEIq17
X-Gm-Message-State: AOJu0Yzck5Ahc/er8q1HbpaExBCaV1HWk+laZcIZV64YC/v8llo5CLMw
	sE8CgGgmCllaBs/6thhD6iej3kyhUm7Hskb4VMIPUx1pwK9XDlKkvQpbdg==
X-Google-Smtp-Source: AGHT+IEo6gIDelw6Rc1Y+DLRxklx3Roldh1J8aHJ8VL38fOKDdeM1KMgLtL49S9951UaFlYgThXvtg==
X-Received: by 2002:a0c:c344:0:b0:69b:3923:94d5 with SMTP id j4-20020a0cc344000000b0069b392394d5mr7451933qvi.52.1713711594282;
        Sun, 21 Apr 2024 07:59:54 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id w5-20020a0c9c45000000b0069b27dad8c7sm3413677qve.101.2024.04.21.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 07:59:53 -0700 (PDT)
Date: Sun, 21 Apr 2024 10:59:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662529e994190_1e22622942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240420025237.3309296-8-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
 <20240420025237.3309296-8-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 7/7] selftests: drv-net: add require_XYZ()
 helpers for validating env
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Wrap typical checks like whether given command used by the test
> is available in helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

>  def test_v4(cfg) -> None:
> +    cfg.require_v4()
> +

Probably every platform has ping. But since it is not a built-int and
this patch adds cfg.require_cmd, maybe add it for ping if respinning.

>      cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
>      cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
>  
>  
>  def test_v6(cfg) -> None:
> +    cfg.require_v6()
> +
>      cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
>      cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
>  
>  
>  def test_tcp(cfg) -> None:
> +    cfg.require_cmd("socat", remote=True)
> +
>      port = rand_port()
>      listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport STDOUT"
>  
> -- 
> 2.44.0
> 



