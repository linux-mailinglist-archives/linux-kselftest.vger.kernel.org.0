Return-Path: <linux-kselftest+bounces-46452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA9C85E8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156153B4212
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE126ED52;
	Tue, 25 Nov 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMsAT1k+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604F2673B0
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087294; cv=none; b=VVd9CZPfHwf4FdYOxDOB/sEnwiuLRcp0yXlKGdRCfmDyl9H+MkWzDOKlaJQC3EkAQuF631Ocz6I7hIzuN7I/pxT01tF6Ywo0x0OFTJrPtR2xi+ayu/Fj3viVhzXbwv2gazTmCiennobcQ2du+AUAhZApLOEWn7nQ/oN0FlCDZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087294; c=relaxed/simple;
	bh=R/c+flV58muomrMmtU53qd47lYbsYHti807vgioeMVc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K4s1Raj3NljHtTGIsXavLqeeNsVSexN0H5OBHXtfuzR16oANwpSm3XuQUIYbzwxKYs/Rg4BAY8bfEJSGksnMdVmCwN7ZvD+SDMqumYcaiOG5/vuHzNrmXY4I32hB8k/uDBxg3GYOQEWa+vYpo0PDvYmY9h7AxkG98n1uVj4GDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMsAT1k+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78a6a7654a4so56572527b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764087292; x=1764692092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVmS8M56197Tx9BpV9mIjAisdUefrXPhKempHf2Fxfk=;
        b=fMsAT1k+3mEr5Py5F/el9qw9cKM2qagZKs2tTCVv/VueKLLjvKAjegNM/GRvVsyXrB
         64flQs4dyQdpRBG7SBOJbdlpWp7JU8MhHSuozqUiGdRtHMa7kMlklIXlMQOEcS+iy8hq
         9CYe1Nv2jeWLBA347zvSk9iOG8l5qRIJcT66jD1AkcI6CeUTvF3pluGlIOiQtgdjps7t
         cBNjZkP92yKMHTvFDqRSdczRBvwpDxdBIj0ub+PRleLli4ewA6IeoRAUXLvQiQ/Xo1Bu
         w/3Ko+gXSgE6hXgUzz2jypjsjIUKpCMD36Pu9fEDiKnyU2SGRuWty1tc41Yf6K1t0Y4d
         1s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087292; x=1764692092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVmS8M56197Tx9BpV9mIjAisdUefrXPhKempHf2Fxfk=;
        b=JfQQtZbqbxbSwCB6kGv+cIpH20LiHGPT3sZ64FzYPIU4lHGYOAQQNJS1AqtHLSJBsn
         5Q2CVLnd8Nb2k6nfZIeehpOpZgTxhjMaQFV4c9a9CmEyrHkUmqHpKuN0t+iHjMQ+vDP9
         XbkaG+oUFKG1dSNk+c/amASoQhwd4fPbCdJgDbFXFfqh5gsWrzKYkNYRX1H2hccsSeA4
         YpxGivfQ2WRLH5gWaLBuFCjM02t2kEoSsp+EkywgYo30s3wR5sh8+ts3BO9AGqQupYpc
         m6XEA43+IT+q8tPdz92WgxQsNK2eBZ/pjniNYZIJQQOUsqTq/5pzokuq2Dmp6MfkPKQu
         TskQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsSn6p+7xffCtXv0vFAmG20pkq9Kt/0h5+Ftx6qolZAQVKYffm12iXki5UsYJd3H3Na0TfesZbj7d9M/AOerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9ZSVKOMs4rrjw9od2gP6mBWNdHNfIXLe802Ta+iQ11KuVTjQ
	D0+xFTnKOlBzQsC38HMy89ZDjS/cod+Go4DvgBWk8Oy6BqT8nP4QiCWu
X-Gm-Gg: ASbGncsBU/44hTfzP5dsMDT1t19Ci6wss4hznSd2yWOBKpoetdJGB0B1YGCVLkgBH1Y
	lZHbnW74kvnlrh4VcyLh6d2aRoYZW79fbPeoyyWEwaVSwp6GLErr3PsIiWvG/dQvjnNay491REP
	9gTkdU2YP32ibvlveXQfBc3zHs0VbdJBr0KI1bx2NZdncORF7y6yzy24AazPelaqHVwJcQY0jz2
	YjT/EWEEv2Hmav/C4JExpFejYdPBiaP/2sdSjap836zCTHw2YxzR6kJwaKpfSxxmdMLADACUsDc
	vnELpSqaZ2pE8DmhZMxpaJYd1XadktK/C+Thd39hw3R4fITcvbG4fLvVIKCPILC7JrMpvvIpQxM
	jRFd7EXcbGUtnzT57ftwEVNGV1jcjUVRRFCY8Ct041k2bzI+MREOS2oDvjogGjUpCUTo4iZXIYy
	frlRwmz7mRUpt4ozBD0jb/ANd2JSpg0L02ynK7Z6avY6kpp+02UP7vWakQtfWgMsahtAs=
X-Google-Smtp-Source: AGHT+IGns59BnaijYD+D80rBffETQUdnkBAppOq3jxlYqt7u9mCa/2kNEHDwIJ/hkYPW9Yqvb0kGlA==
X-Received: by 2002:a05:690c:e1f:b0:786:4fd5:e5de with SMTP id 00721157ae682-78a8b56e89cmr138239077b3.67.1764087291625;
        Tue, 25 Nov 2025 08:14:51 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a7995a738sm56901637b3.57.2025.11.25.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:14:51 -0800 (PST)
Date: Tue, 25 Nov 2025 11:14:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2f2a6f8b32ff1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
 <aSUxhmqXmIPSdbHm@fedora>
 <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Ankit Khushwaha wrote:
> > On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> > > This does not reproduce for me.
> > > 
> > > Can you share the full clang command that V=1 outputs, as well as the
> > > output oof clang --version.
> > 
> > Hi Willem,
> > I have added clang output in 
> > https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18
> > 
> > Thanks,
> > Ankit
> 
> I see. This is with clang-21. It did not trigger for me with clang-19.
> 
> I was able to reproduce with Ubuntu 25.10.
> 
> Okay, good to suppress these false positives with normal builds.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 

The patch status is already changes requested.

Please resubmit and target [PATCH net-next]


