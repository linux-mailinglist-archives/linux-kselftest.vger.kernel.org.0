Return-Path: <linux-kselftest+bounces-29466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16DA69C72
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A13B6A9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110621E0BA;
	Wed, 19 Mar 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVLZaXoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1417A312;
	Wed, 19 Mar 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425350; cv=none; b=iBiGV3jDEYumLz2F05fQk197dNl40T9+NrJVROI5yyhNEEH8T2yPgFNGnLyNfTt2AuMCrMt3cBPZZ161tZ/Vz6QjJpZGW8boLh3DPEeaDVv5+XGruQ7qgxJZB4KWUPHKrbxEu7xrq0eiAMm4Eb24dkYlMNuEvEYcAUARthrz1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425350; c=relaxed/simple;
	bh=BPG+iIqJAfChdQiMkdKc7iAPNjN79b25ISwXPBMiCRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZur8FBOEVjACsAc0c6eAPljlmIFoBBvApP1hHutxL08xiZtL2Y2UePBVBoKjNZIBlJpFEt1ykpnyY5C3u//V8nZiXJx50GsdzrTKmZjScTki07xxgoMklt/PbH/Qbwj43OhR/ckL+G91qP2pY5JQYAHRwzq/1TmB2ut7uXTCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVLZaXoi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3012885752dso261138a91.2;
        Wed, 19 Mar 2025 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742425348; x=1743030148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhmilIcdIAlYPcHBOd/ksA4qcB+RRwxxADQtlWE9lMc=;
        b=LVLZaXoiA8rhvrLV5GaGIZaMwF9evkG0VNsho0LOD/sglU80b/78yjIx+OotKcEA4S
         wcvOo6hEnhCzbRxZ+kuaXNalW6e7tTArTFcIXJIEBXz6c9NbJoRajgkg7yrDNzZYbSTr
         JKFca42G4Oh852topLayfkVNXhpE7m+SKFpoJjFNIHywFjKw0m+b5A7s61DQNB9DrqW9
         BhJ27N5Ix580/GQ++2shANPgppNoDAFnqwCFZ2GAkaQek+FDeaiivLYyMG9A8SDvNxz5
         pqRftCIV2ekz2XJ6pcFLjpFC18OdKGSooW087UXINzzRUUvJ5f1IiVDNFNaLiAIWjlzH
         efLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425348; x=1743030148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhmilIcdIAlYPcHBOd/ksA4qcB+RRwxxADQtlWE9lMc=;
        b=w1MeUdooORonk9Vu//2kL0LeD2YCkg92LMKSQudMTgU8iirEt01mLzQ/onJFfkm/48
         2pMlQJZTkpNo9DQ9ifmjiBN1mlv28ZZUjj93obcJq8Yf4qig1ZENysnNZ8fALDMPFb2a
         Qro4065FvkmDtcc7G2rqZSuuVSZMHg0QvN1DR4xUwPv/2l5dHGkMrYWDl1BmJowoWcpV
         7oaRh0W1I2MzYT8DEnsnd3XxeFXzIdh499uSo+dTdbXMwe1blYKfgKUr8KKxjxl9hk67
         a8AKIqMfetk2ygKU1idDssPdibJThzxCihpBuGrteAUau69rReV0Y/G5PrJV4IDKh+0K
         p/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj6p41VgMLS98gbbHtETBVSzMC5R4uw9xfDOSkoNGKKCP1n47PI9ra5WL4ccMD4rGsytpGQcR6@vger.kernel.org, AJvYcCWWkNSmZ5Q3g4XS8KPKxrhIWcf4eLF/sXDrfxEIT1MzDWssAtPDzmBfjTzWUNptqb2Dag7ZJ0OnsetjJlCKabyd@vger.kernel.org, AJvYcCX0G+49FMmomFC47dJJ1Nng7JNosxuzdf9n617Sg3dyQx4gDHEKPJBA7AXNH+7F1haiN1sH8CjZmHe16s8s@vger.kernel.org, AJvYcCXKgmmXxELmW+EaCeut3cZ8CxewGUg0gWIBfnQb4ZyFXdr7dkJJdKm5MNbZ81xaRgUYZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRI5cYvsyDWE/fsT8wOvtKCOcuHsHNlWTTk/FAtVKYyefreT1
	LIc9HbLaSBaabOhn1BW/OyIKSuY+FKTLI1OWRRJGcFiDaon5iFhU
X-Gm-Gg: ASbGncug+Akxi+mkK8V3kM1NUSvJlPyeFhQVBFdKwdQAYGVG2/kWZTy3bkRO0ABwdNW
	NPkLxDdpmiOKMEktUWNMzk0qtpYiE1bNpkCVoEMq4anMFG5moJYp4ymkrRHcGtzdaBdrtGXJwFx
	hbVfxjv1da09SIY0A0qV/ggHWRrurEld6CRl2QUa1ENwXaRRVCqZm23TnrSCm7a5SkkCWetYJ/v
	P8GoTOsQGwcaXIxdLxQ62/r/sFdzokb/MHyqkaIZkCAUjraTfdF+v8qGqqIO9lQgWzF6UBU3cMu
	+/pxxsjwsFNRyBZ7eSKgH4Di1xElhabwffvuEFSrgy87j8No
X-Google-Smtp-Source: AGHT+IEhfsgHrp6UIrWCrBXPSKv+nNwcdO5otatNNe7sxyKy46UyBt+P2mBrmJ7RVovwIUhDvxS/iA==
X-Received: by 2002:a17:90b:2e52:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-301bdf937cfmr8451150a91.16.1742425348288;
        Wed, 19 Mar 2025 16:02:28 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576aa7sm2296562a91.4.2025.03.19.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:02:27 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:02:26 -0700
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
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket
 after free when sending
Message-ID: <Z9tNAhMV1Y5znONo@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317092257.68760-2-jiayuan.chen@linux.dev>

On Mon, Mar 17, 2025 at 05:22:54PM +0800, Jiayuan Chen wrote:
> The sk->sk_socket is not locked or referenced, and during the call to

Hm? We should have a reference in socket map, whether directly or
indirectly, right? When we add a socket to a socket map, we do call
sock_map_psock_get_checked() to obtain a reference.

> skb_send_sock(), there is a race condition with the release of sk_socket.
> All types of sockets(tcp/udp/unix/vsock) will be affected.
> 
> Race conditions:
> '''
> CPU0                               CPU1
> skb_send_sock
>   sendmsg_unlocked
>     sock_sendmsg
>       sock_sendmsg_nosec
>                                    close(fd):
>                                      ...
>                                    ops->release()

IIRC, ->release() is only called when the refcnt of fd becomes zero, so
I wonder how we reach here despite we have a reference of psock->refcnt?

>                                      sock_map_close()
>                                    sk_socket->ops = NULL
>                                    free(socket)
>       sock->ops->sendmsg
>             ^
>             panic here

Thanks.

