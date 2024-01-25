Return-Path: <linux-kselftest+bounces-3584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C083C866
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F400729600E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BF130E3B;
	Thu, 25 Jan 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBD667Uj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB12130E3C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200993; cv=none; b=pXqjnU2mXFKiBWNvg54kOigGu/zvlKGwv7G4ImAJ7glB/F6b01RZuoHhkfVNX7bK7qelKjpdNw+vcK8Wb6IfQssPrNxcpYQefS4xqprqQbee9BBzDtafcFq/WLtfVegrIKb2+3V8Ao7xhAs6FZS4CRgtUbOgqfcT043pD5siCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200993; c=relaxed/simple;
	bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0liNvDNzg7rXLiuQ6cVUdxAr/JAEWAuns7KyQhkRTuDpGIqwViKqvJfsdjqRoQsPZDWNTz9fd3ym/h5vu7QQOcOjk5VPHMH0RUHxz0/ZWBTp6KOldMc6JXRKLJaxsCGhaKhOk832DEfD3vHiVi2QOlD9EO9hENvQSyqd9Q6wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBD667Uj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so16529a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706200989; x=1706805789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
        b=FBD667Uj+Fo2kXL/mAzsxX0zqwekq551OuN+tvapKlGgKv8oFyamb3qQOZcJDo4kPH
         sqFrlNrX3WVRs+hlZdJIiX5WDlkSwWuYtDc9RyQ7/4vM38kQYKibGzSLQsbiVtxGLDq3
         MJvX8Zm/El1+mcGNPMYbU/NKVCEFIhwW2DzPcwPV53i/FWG7SQOZnMefGwzCKun7CKfe
         H1EJsGk40sL8rxEfWupwFDx+GG7NSNacmqzBcp2syStUh5s8XOHy5gBTwmFDXT32Zf9/
         7Zr8hzk6uFgpMHwE39iI1Za4KVzhaoBmYDCIDN0hMHQEoZYZhRf+V55mNwCCVaQ9kuFn
         cBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200989; x=1706805789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
        b=vTcbl/0pMo3JFwrQZ47ISJMccntQq4rqndnpPC3c/M0zx7oOSlPeZwOamHitab1uqh
         YmTv/l7qDaFgZZ5xSt3JGY7iw2dbZL67gvLzHiGfBU2b1Szg0HzSsz3GWwtIeK+NHv/9
         XB3VcG+DeGhemdLUg4zIB+d/5pdB4GpN46PNeMbVK3abV37wqeQEw6tf8aSygj54GWao
         jCE9fkHSkMs+1a8tFMHDgo8NLBBV8E4RnB7H9Uryj85pdkf+ThNyxJgyJt2Om2y+z5/H
         oitlk7xK7ZkHrYHvgUqL5SfQQsBXTVuslFAnh1JaKZnT1t9NpEEpPv4O0vvc0AB0P7J5
         Sc4g==
X-Gm-Message-State: AOJu0YzArsZFQRmd7WwFtedcwPxJj0mCvuIxngu09ROwx8x1msSNHBBh
	Aorh1ctjY73Nar35JTi/Xd8e+2puq3RojcnSJUFpkOm0OpTxWjV4aikWDv73bhJ3DTDI1hVdf67
	uRYXWHR2NnerpPmhFaxi+LR59qwwyjZW+Mgps
X-Google-Smtp-Source: AGHT+IHUFx32fC9YNC4d0sEJq63ZON8ak0fXZIg3iwWuwGiBl2m1AoMhCEvipFmByVo6TpSH958CAWSupW4zTOj0qT4=
X-Received: by 2002:a05:6402:2078:b0:55c:e76e:9c9d with SMTP id
 bd24-20020a056402207800b0055ce76e9c9dmr197121edb.3.1706200989077; Thu, 25 Jan
 2024 08:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
 <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
 <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
 <CANn89iK_i+7RzgeaGQPUieU3c0ME27QeJU9UH9j-ii2TeBoEAA@mail.gmail.com> <a50e07e46036947c873df09b6a48bc8b74547689.camel@redhat.com>
In-Reply-To: <a50e07e46036947c873df09b6a48bc8b74547689.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 17:42:55 +0100
Message-ID: <CANn89iJz_cTQDYJsh=Cxqjrxeo39xibH6HREi1-8R3H0UMzSPw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej enczykowski <maze@google.com>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
> Thank you for testing!
>
> Do you prefer I'll send the formal patch or do you prefer otherwise?

 Please send it, you did the investigations, thanks a lot !

