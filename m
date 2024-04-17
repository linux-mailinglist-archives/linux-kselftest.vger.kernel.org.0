Return-Path: <linux-kselftest+bounces-8266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3178A8B73
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5128C2877E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148313AF2;
	Wed, 17 Apr 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1H2Irfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3038F54;
	Wed, 17 Apr 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379653; cv=none; b=P+wEzGhIni5A+0tueHfReUfix5EZsZzD2blwfZoLkqmGcuQaxgMK0xKx1tjW1TTO9Gmz2ZLRTQyoLHvQJhlUnUNOJ5qq5LApeEAesjAPJTvUqVIClM+CpTACoBjp8vIcWOmSrvR8qR6K42+xKux4/8/c+IvfTSo/b0zP6++Ozfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379653; c=relaxed/simple;
	bh=reaA9tTGizBB+NIGcV7bHJimHioTexx+778BpTdQZKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o23aTfSVMtMK3rpUyT9NdXRiFzX7OpXwG/IPAxXfl8H4WiGQnlQnQelAoo1CBK/nXjOPLVx5IjSEpPh2LtFozRjcfc7fwM4rf4H069w1+6cOrZZNaXcMDyt0fPK8IE4t9svxLNmrC7L9hs1MQkBkEVfoNMDnBhqTNI+mOb3ecec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1H2Irfs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a502547460so82360a91.2;
        Wed, 17 Apr 2024 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713379651; x=1713984451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=joQ3ZujEDtWSfIGMDqZdTFSuY2rGH2GzdHPLy/M5o+s=;
        b=T1H2IrfsKiIik5ca+DWvhhWoMPIGpPMnWBqGSGa51zAGLJHo/iOCZ7NT0kLcyOXioe
         p6iisI8rM2lbPMblZDgvjGazvYdwj+gTFkKkoGBaTex1QtVJZgoHxX2LoxxjbGUERnnU
         npttL0ks6gAJz3A+IiOq88Gpb5emDXUNDdWT55xLhIBKXPuAQoLNqZTrc5UqQGrj/cvF
         y+UPtYV0hYfEBXVIpaoAMVnf8neErsJzuYvnqBL9RiY0v5Zp/67/UBnpfcW9W4qnGxJo
         lbyERhL/UobnOxIVivCOBBjqjSJgU6y4/iiEHLZIgAK+OGvI4In9PBzgaZQg4jLSDyk0
         QeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379651; x=1713984451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joQ3ZujEDtWSfIGMDqZdTFSuY2rGH2GzdHPLy/M5o+s=;
        b=roTv+pTxqkWKumNkQtAQ8FXt3EauUmjj2/ZAMV7WZDN7t6TP7Iv5MK+iouWeEAzix5
         dc8+w0Xaw+bYMIOdslNh90ykrbuaIVgbKDstfzNcdUlc5RptIJB8DBXN27eaERkaMBC+
         B7itIAaIp7L6JXY+jnQDms1bRf3q2bKj1YhyaccafYdsbTLUqxaJwRutabRuH15u1zAU
         THEK+9f0Gz2kHRAXWiWTZdyPg1kfNdVIwpCTzj85m0Eb7N/yIAOHzRpJv58tmWPA34Ph
         qCN6u09eONcFy6yDIPptlmT3vMaeTGOK3+gK798HkWooRbxOGBwafuRMymB754n73d+s
         G+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdWQlfXdUbIbleTfc/xq8zTr4Xwx+ejuDJW1GwGXnDSuV20docWGiWdy5fLEKYhR9LlH/J2rMYBeSuvmy6pficCV2TofKIcBPmnVThDHwdR4j+pa4UPj5UYP/t3DNXkm3N5SCh6Qt6lah8xKlY8S/O0jY5Ik7jssuNX524uoEckhlc4Wm
X-Gm-Message-State: AOJu0YzLnEFht26C7JwSijZRyNZlvVXyThaHooLt1f4ByU2x6R1/dGgE
	TC8425oLQltInSxqFfetFYfWprmmPGSLpE6xQdg4Lpx0LTnM2Kex8yrHgqiTxE6ETIX0AFoJtCT
	5zk+mxHPHJolddVYVNEKxBw+dGMI=
X-Google-Smtp-Source: AGHT+IGWSVVsPzFy94bdg08jfpPcRPLvbi4UatPxHfAaLeLZEpgp5BZ3BMi8BjGDNfJ4LsFSvF6kSGdG+NDOO8i9Ooo=
X-Received: by 2002:a17:90b:1d8b:b0:2a2:ab2c:da40 with SMTP id
 pf11-20020a17090b1d8b00b002a2ab2cda40mr247731pjb.33.1713379651051; Wed, 17
 Apr 2024 11:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com> <20240416072809.3ae7c3d3@kernel.org>
In-Reply-To: <20240416072809.3ae7c3d3@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 17 Apr 2024 19:47:18 +0100
Message-ID: <CAJwJo6Yw4S1wCcimRVy=P8h0Ez0UDt-yw2jqSY-ph3TKsQVVGA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for TCP-AO selftests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 15:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 13 Apr 2024 02:42:51 +0100 Dmitry Safonov via B4 Relay wrote:
> > Started as addressing the flakiness issues in rst_ipv*, that affect
> > netdev dashboard.
>
> Thank you! :)

Jakub, you are very welcome :)
I'll keep an eye on the dashboard, but I very much encourage you to
ping me in case of any other issues with tcp_ao selftests.

I currently have v2 for tcp-ao tracepoints, but delaying it as working
on a reproducer/selftest for an issue I think I have a patch for.

BTW, do you know if those were addressed or anyone is looking into
them? (from other tcp-ao hits, that seem not anyhow related to tcp-ao
itself):

1. [ 240.001391][ T833] Possible interrupt unsafe locking scenario:
[  240.001391][  T833]
[  240.001635][  T833]        CPU0                    CPU1
[  240.001797][  T833]        ----                    ----
[  240.001958][  T833]   lock(&p->alloc_lock);
[  240.002083][  T833]                                local_irq_disable();
[  240.002284][  T833]                                lock(&ndev->lock);
[  240.002490][  T833]                                lock(&p->alloc_lock);
[  240.002709][  T833]   <Interrupt>
[  240.002819][  T833]     lock(&ndev->lock);
[  240.002937][  T833]
[  240.002937][  T833]  *** DEADLOCK ***

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/537021/14-self-connect-ipv6/stderr

2. [  251.411647][   T71] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock
order detected
[  251.411986][   T71] 6.9.0-rc1-virtme #1 Not tainted
[  251.412214][   T71] -----------------------------------------------------
[  251.412533][   T71] kworker/u16:1/71 [HC0[0]:SC0[2]:HE1:SE0] is
trying to acquire:
[  251.412837][   T71] ffff888005182c28 (&p->alloc_lock){+.+.}-{2:2},
at: __get_task_comm+0x27/0x70
[  251.413214][   T71]
[  251.413214][   T71] and this task is already holding:
[  251.413527][   T71] ffff88802f83efd8 (&ul->lock){+.-.}-{2:2}, at:
rt6_uncached_list_flush_dev+0x138/0x840
[  251.413887][   T71] which would create a new lock dependency:
[  251.414153][   T71]  (&ul->lock){+.-.}-{2:2} -> (&p->alloc_lock){+.+.}-{2:2}
[  251.414464][   T71]
[  251.414464][   T71] but this new dependency connects a SOFTIRQ-irq-safe lock:
[  251.414808][   T71]  (&ul->lock){+.-.}-{2:2}

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/537201/17-icmps-discard-ipv4/stderr

3. [ 264.280734][ C3] Possible unsafe locking scenario:
[  264.280734][    C3]
[  264.280968][    C3]        CPU0                    CPU1
[  264.281117][    C3]        ----                    ----
[  264.281263][    C3]   lock((&tw->tw_timer));
[  264.281427][    C3]
lock(&hashinfo->ehash_locks[i]);
[  264.281647][    C3]                                lock((&tw->tw_timer));
[  264.281834][    C3]   lock(&hashinfo->ehash_locks[i]);

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/547461/19-self-connect-ipv4/stderr

I can spend some time on them after I verify that my fix for -stable
is actually fixing an issue I think it fixes.
Seems like your automation + my selftests are giving some fruits, hehe.

Thanks,
             Dmitry

