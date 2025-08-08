Return-Path: <linux-kselftest+bounces-38567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D1B1EA37
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA43AFA30
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A962566F7;
	Fri,  8 Aug 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huzt8PAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C838F91
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662761; cv=none; b=A1MTigNvrVYncwwUtWgyfplGyrXYknlzJr7LwKrTKo7kslQ0I8zn+x4c0e44AO4RqaWT8BADUa5waJ9G8q0N+JW5BRqCAuQ2LEkmzesjJ8VaPDVvEFCJICbuvILPJWcfV80PfiGCqqYv+jAuhK6qO1qOJL+VaVv0W3peSUb5yKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662761; c=relaxed/simple;
	bh=vSs/FLFyWmT5fUFdAh8nLqssatgQIqAhG3C9sNRJS4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHRsXqCwz4rylUJu4iyyE1U5sMtGkchDBKrczZDeqAtH/DelC/CqG4yL+WzRpHI2eXavS3k83ZI9WpeWINV1ab0A+aorj3XCqOd1G77QCy6fdiqyUBO08TxtdK1HzS+feMrwbAHEHKFFgRhuIlYKnu8WRzLPMhgxiyFAliWWEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huzt8PAl; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aeb2e06b82so11863931cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754662759; x=1755267559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y94OGudZDPZNaW6E85iU0z+UoY8JtiL793eo6U580Jg=;
        b=huzt8PAlnLjQSvC8yMN97oI0W2fAwLXH1ki9YXh8Xvn+Za09OOOIN6/19hhUciB92I
         xxvKI9i0eDgpcKLx5IORw9+qOH+LdREjE+eyAGAwAir2QNZsWTWBn/3c53ARlInQ9Fyw
         eEBhc/RtPLfRWTnr7i5qMoCz5CzNVZkPwlKqwMQ75ip78cD2vvWyyR6XZDj1DDSu1+rp
         cFXCn8fPU1haBikSszdrwdG7MaG8okESv83iC1WLpRks1+gHi4frAwSBexN3qGnlXj6/
         MlIkdJjl3utaVR62oH1jCfTD+Wrdq1hAg+LH8t61/FZV8Po3JVtRg06J7O5ocCyC5ANt
         1chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662759; x=1755267559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y94OGudZDPZNaW6E85iU0z+UoY8JtiL793eo6U580Jg=;
        b=bUWX+wq9lBGoQhi5EqxyiEmkyb1IPCJAyi8C77FcsyN7TgYmsyYXLAJUaXMdFIJgNj
         OMQR1OVGcWiHGEV43u4osXKHCeOTX/pwq+E9ynTQhP1tUzmRWnspDT+hfqBQucawYDVS
         1VzeUCZIcWR2OSzHYCQzMHhH45FYhM4loIlMMdUkHlzZknewOFBtznnAKjcWjpcXrKJH
         jZWWLAzVyVASlsrH4oCFa8Jz3kR2Z02tmaqYmoIt0wN4wV5Ei+ZFoKBg9pM/6V3n6x4F
         a5phOpxYTzCxpECsIIXS7nbMzh1rE9yhYP7P18uEV4JmlJlI/OKvNBuhFAsri1bu2701
         MLlA==
X-Forwarded-Encrypted: i=1; AJvYcCXwJjCJy92qQZUjQsNxoltLeQrwgIaTCV+1mpOt3N/o0xa7MkoEb9GbcZAzM/NpBOSZ1xK70T4t+vz3Fhf6c4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZM5oJuXqWdL16ueNkleRyUYQZZGQbNQ4f6ecYOdzHHSnMAM0
	J/bOVaPr4iGyUfH1AZoPD07w9RfK966+FbU5XPPjBzm3fE3oTLykCKfjAsTs/ROaRRSFfTCGSh3
	iN7pzzCwuOah4QC57iInt0/IwFYSZPcqhuVZ0J0cK
X-Gm-Gg: ASbGncuUzSCmi+FvGyU3Yuj4Z2Q/lJWfd2HsNTNiuszy0jJcXLPTdZ/XQow1oDtNhKf
	toD1AMlTblH7U+7pmy48LlecgKAvN9Es/fJLnix2H8UGWEs+6BypuIsh3Dv/opZLD6jmFgKTZoV
	jU9sRfCG34J4N+kuPyBVSojHYGqkUeebMF9duT8/87owUE1V04JrN5owlz5JOPJB4i6yOAiQQr6
	Lq4
X-Google-Smtp-Source: AGHT+IGlhlfzpC4KJNIVb9Mz9qopmHfUuMxN6adfHiYC4I0TtEw5oxUbbCOIZh/4rAe6le8uT8ly5EbruJYjRevHsbo=
X-Received: by 2002:ac8:7dc2:0:b0:4ab:38c1:f9bd with SMTP id
 d75a77b69052e-4b0aed0b967mr41999341cf.12.1754662758275; Fri, 08 Aug 2025
 07:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807232907.600366-1-kuba@kernel.org>
In-Reply-To: <20250807232907.600366-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 07:19:06 -0700
X-Gm-Features: Ac12FXxu695eQQh0GR6R9L_dN1lxvC_xRXbyFs3sP8XNLEQaFDLYQI2rudyY6IA
Message-ID: <CANn89i+Hx-DtzYuGdkHTSoe81UvjDfqSpwKfwA=yAE4cUaSbAw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tls: handle data disappearing from under the
 TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> TLS expects that it owns the receive queue of the TCP socket.
> This cannot be guaranteed in case the reader of the TCP socket
> entered before the TLS ULP was installed, or uses some non-standard
> read API (eg. zerocopy ones). Replace the WARN_ON() and a buggy
> early exit (which leaves anchor pointing to a freed skb) with real
> error handling. Wipe the parsing state and tell the reader to retry.
>
> We already reload the anchor every time we (re)acquire the socket lock,
> so the only condition we need to avoid is an out of bounds read
> (not having enough bytes in the socket for previously parsed record len).
>
> If some data was read from under TLS but there's enough in the queue
> we'll reload and decrypt what is most likely not a valid TLS record.
> Leading to some undefined behavior from TLS perspective (corrupting
> a stream? missing an alert? missing an attack?) but no kernel crash
> should take place.
>
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJX=
fIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=3D@syst3mf=
ailure.io
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - fix the reporter tags
>  - drop the copied_seq nonsense, just correct the error handling
> v1: https://lore.kernel.org/20250806180510.3656677-1-kuba@kernel.org
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

