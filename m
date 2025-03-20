Return-Path: <linux-kselftest+bounces-29475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239CA69D52
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 01:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A648A0EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939E157A72;
	Thu, 20 Mar 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy1/LmFW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EA2F28;
	Thu, 20 Mar 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430893; cv=none; b=mSsGqAua5uySasBsAX/gyCWD0QTuqDsEpaXgrtRxRCDtY2V731vEOTMJknjhxMiwMKo78XurEvS93ghgDILH/boLokyWoD+EKEnWU27xdsUG7lV6MtKzvO1mehnRJ8iaK+ND5A9KCYfgOPmLTk4CWK0euTEb6kKsBMbXQwFXYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430893; c=relaxed/simple;
	bh=3D0vNnFkQr3KweKAbyrZUGalhQAJd+us/V/1YG9Eqvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+x7Oh8kSg+8tQU+lxKyrJlUlzbQmCGZ11RuAKM7PAEKcoiIXgPZGZs5cv0jSCocdVFGBa/kO6hPOqgZjRPFO8MKAzaVkuVHl9MmBFuu7q+9qthJd+6GjyFY3sJdC22EK1KuPbngVkkNrE1Wcal2TzFvo9mzm9PSo0AjWqzL8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy1/LmFW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225e3002dffso1697215ad.1;
        Wed, 19 Mar 2025 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742430891; x=1743035691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho/T0CVeL8ZM68pRmPpG9+4hTy87II3noiU7TiMadwk=;
        b=Vy1/LmFW+9ywLGA1EOqZ69zdfFSBPL82lklg01wP3XnMRw10WEI+XMP5mQK3LVo7ay
         NFXiFtW07+6UWLWG8ZUpLc8sjrLULagkfq4red0p90QVVDL9hSw2Af6Yn9N2djNPubS9
         UTlyvjnbXAJ7T3KMMtinoBSY3SUk0p78dVjrWLGvS/1ndUMzaJboWUpzeQfPzvQIuGzm
         HkLpiU3BtNYYx2XyLd9+w1JnEbdFaOZQ/oVNwrN85j+tAVAq3zVu4PvWa+MDR/WQC24A
         p24c2fMQ79pZvhta4lNsnLMHZ+b08VITdqFKxIpoKDTEO5toRR55oyEoNf38gKoEMPSA
         ZRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742430891; x=1743035691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho/T0CVeL8ZM68pRmPpG9+4hTy87II3noiU7TiMadwk=;
        b=AXPIo8v0wZWXvktHvsrtgqn5Pn1Hu1Ppp2g1QmDnXPFNgQ4DcX6+2FiubZzgboX5X0
         h9wSLEsNM56YQUiMuG0sFDT4hE5n+G66RWepdaNwQFDcOJdTO5wS7lng81QCLJbQT1W9
         eF1NcymjiU4W+P1vGSJoE0DemIl1zCsRVV9i7CdxMdYd8PB1StHPaqZ3jza9v3iHk8oq
         cNqgh4lWVnN0peaACHKVBv8urp+QY2rkgA7Ux8TA6Tx2j50/XlE8BN9I6bFhGHlm1FYG
         zSkhB1h8GQ4SiVzS7JlWRhsVPuc6z4RwsJYULKPGUCG8lM2Fknhj6K8uVf+J9wScCVMZ
         MVZA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2BWRUA+jS9CtmsnnuOzlrDdzXZoLZ1unadcNmg+jiVubMAsa3lei+pxJEZMhlp7/geFvpouOqUNwx2COoOfN@vger.kernel.org, AJvYcCUr2SJftWL3L3RRd4dus+JqGM7m+I3h8zMhf2URCfTqnZv+KfvYcPX9zfnnqtnbRiaN/CQ=@vger.kernel.org, AJvYcCWouVMHW7o3aYuYs0d+jol67Ew5dSl3oAanNIcI0elMrY09g6bV5tk1UMXg02aDeUszEMU+LTJSoyx6dzha@vger.kernel.org, AJvYcCXKzlWXgRrPtUQHkk+aFyhXVwChBJ4i14viiZ7zLmbAj21rfGaeuW9WLKaR8Beh3QWCRMSjjIAe@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJJFhKiUU+e2AuRQyXOmkUJnHAs9oL4WEI2pubHljZRxU6zBC
	Hlh6MBRekwbQH5CcC9tKVNmK0TEpTIJuay2P69rgz/LanJZeC1uy
X-Gm-Gg: ASbGnctRB8aVlybCvB77BlGR/nPZ5Aw2IRWHATZp6m9rykiHMu7Q/EZx+lE9XgPMuWA
	frDQOyyk7gNGy5U2WemfXFqT1cyrl1Kc0TWcOVjSRI9VMswRayEwoMreOkRro0vEi04+cfO7XXZ
	eWoBmBUwqkfgJ4gfkQd/CD0U481rFxhVhdcnrAiPU4qBNDuYJBpVF9QuRlK5D8qGO4UsjNIe1o+
	XsA6pbz/U2gQfukauOKCO6yMtilKv5ubz9ozTKAS6+X38bVP6Ib/OAdEct6TirafIP0p8Kh2dYv
	2KFj0y1ufKsuKl9Q7kT/adxQXx1QpBHiiydvn7Mpxzg3CoKn
X-Google-Smtp-Source: AGHT+IH8FuO2OjmmIFlBtn9MK6Q+GMM8K5UIOGZ6rCzLihUzDMMv/Z0zo1At6QBi42VHOJK0q/ntkg==
X-Received: by 2002:a17:902:d4c7:b0:21f:522b:690f with SMTP id d9443c01a7336-22649a57d5emr71081205ad.46.1742430891576;
        Wed, 19 Mar 2025 17:34:51 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7ccsm121537115ad.174.2025.03.19.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:34:51 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:34:50 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v3 2/3] bpf, sockmap: avoid using sk_socket
 after free when reading
Message-ID: <Z9tiqkSOH9vuOOJL@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317092257.68760-3-jiayuan.chen@linux.dev>

On Mon, Mar 17, 2025 at 05:22:55PM +0800, Jiayuan Chen wrote:
> There are potential concurrency issues, as shown below.
> '''
> CPU0                               CPU1
> sk_psock_verdict_data_ready:
>   socket *sock = sk->sk_socket
>   if (!sock) return
>                                    close(fd):
>                                      ...
>                                      ops->release()
>   if (!sock->ops) return
>                                      sock->ops = NULL
>                                      rcu_call(sock)
>                                      free(sock)
>   READ_ONCE(sock->ops)
>   ^
>   use 'sock' after free
> '''
> 
> RCU is not applicable to Unix sockets read path, because the Unix socket
> implementation itself assumes it's always in process context and heavily
> uses mutex_lock, so, we can't call read_skb within rcu lock.

Hm, I guess the RCU work in sk_psock_drop() does not work for Unix
domain sockets either?

Thanks.

