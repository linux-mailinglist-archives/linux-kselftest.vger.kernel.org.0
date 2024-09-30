Return-Path: <linux-kselftest+bounces-18619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6498A11F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD8281261
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C418DF76;
	Mon, 30 Sep 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFx+qYGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4B14389F;
	Mon, 30 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697005; cv=none; b=ImMKdWCHEkcoYI1uSpR2jhaDfzLT1HVdLpKaAOWY2RPxTj6a9QG5XL69Qsqr9eguZLcDG889rFpeR1VYAppdTgpH12DttF9694CUX870bL79soN0mbodJOI0oJ5+WZN/QPIgPTL1moZYILHs0SXavZnNImekrTy+WOdnm0S5SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697005; c=relaxed/simple;
	bh=K1LnX8V/pBBYoLTYDuLywY5Eq6OjG6G8UQf9jvTMloE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJrIryqsNqzn4NwMJinVeBvkjJnH8IqmKYlP1JqVJAsPKrtVyr+ji3KNxjsXqeC+w4ZT15KCClXxoYOV/eI7OcifBa60zd8FrcOhuwWlvDt0DNnI8rc5rP6OraE9ywA454QseclbEhYgT601Yz7JrGDe8KJ/8SMsx8xN/RnJom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFx+qYGr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cdd77dbeso14715865ab.2;
        Mon, 30 Sep 2024 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727697003; x=1728301803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1LnX8V/pBBYoLTYDuLywY5Eq6OjG6G8UQf9jvTMloE=;
        b=eFx+qYGrboBF+3SH5680zuAg0mCM/IUYJ4pTWFnoyjZJ+l3lja/tXH2VH9x6INf/g0
         bhO9egnV/VCH/J0K1aHaHIrySL+0ZG+SV0+nt7qxzYUaIRgqKB0McUls/0+kyCJQEDYb
         KVRG14fDajxMU9HjYRtX+qes9kuE1glE2fNHLqfobW35rWdJX0NDkvPeyFjH/y7Djo52
         I3laP0fgnREj73q3nJrVkuw5W0QqHpMq/BInsRpp1y0VXBXNhQ0DVMjIieIWe4dVbvQN
         /HWjXJA5yvA3nWF0hVGVZurMoqp4cc9loXiBBX07ePJHIi6cdYeJU31LwU3HxMsX/5b/
         48Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697003; x=1728301803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1LnX8V/pBBYoLTYDuLywY5Eq6OjG6G8UQf9jvTMloE=;
        b=G08aC/fkW2ZadQcWXbD6FvOQsv794X/xodMpRV6zdFwzkOTU7p7iXpW/ndq9Hz3Lg9
         oyYaTwWPHBHrY+Hiyk84P32yJWI6IPpFBA7rLUbEWfvwHXPB+rD+crchKIre6VAI1+EK
         dbVVcOez1DPk5CkylUXtzplTOjNDLg3ij6fliWPpYCKIPogbHUcS1wyMVGQfe7rT9LpC
         7jiUS8ekA694X6VrtItKe8fPHMuc4OE/lEQy8HZhGvvLIfK1574AMTFELlAHM4fcX9Oe
         nJpvahC6wxN3lA4G00VQiAKCmH/0WVdmYhFT9vNUbEzlCLcvkvd59/cR7FvDCaLDLt0O
         Dppg==
X-Forwarded-Encrypted: i=1; AJvYcCU62NUpin7Yv5S1FDOlrBVyfhf0oYekSH8IYybzfWnCEbQLplYZxuRdrXQvAyRvrSNo38MxOzE3E4+trCMw2y0=@vger.kernel.org, AJvYcCVAgTh3Ckw8ERY8uD2vVMatKvMAkoLDbG2zR6o5ndduHS3xTCaBgXXz4UvzCpvDjldTDRWChGw+@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGqKt+CDJiRmkVwk8hD3c/W2akEwaZX8G+Kxm3we7PfKkt4Zn
	wJRP4rZMSPElDDoP5vHViSO6qCz9km/4bdGf8pmRQ+NTe1F+VJNBqrlOrNVfYMSiqcEYynqXUgh
	IpICZLzjTkGQCkFZiaK8XlfcIOhQ=
X-Google-Smtp-Source: AGHT+IEUHE3eyvwtLNkThpQlPE8uMfQLIXoAR08Ip4bX7B2BVH+dddp0C6YwSrgn31Ad71cHUfvBSNr1ZMBb9ZCchy0=
X-Received: by 2002:a05:6e02:219d:b0:39b:640e:c5e6 with SMTP id
 e9e14a558f8ab-3a3451b0742mr94211965ab.17.1727697003235; Mon, 30 Sep 2024
 04:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-3-kerneljasonxing@gmail.com> <66fa808374566_17948d2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fa808374566_17948d2947c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 19:49:27 +0800
Message-ID: <CAL+tcoD+Xn0s01ZqfaTRcUOLU7HfLx06FcWKabTcenCXPnXoQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net-timestamp: add OPT_ID_TCP test in selftests
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:42=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introduce a test for SOF_TIMESTAMPING_OPT_ID_TCP for TCP proto so
> > that we can get aware of whether using write_seq as an initial key
> > value works as expected.
>
> Does the test behave different with this flag set?
>

Sorry, my mistake, the last email is not open to the mailing list. So
I copy that here.

Not that much, only at the very beginning, this new test will use
write_seq directly.

I once thought and wondered if I need to setsockopt() when one or two
sendmsg() are already done, then we check the behaviour of subsequent
sendmsg() calls. Then I changed my mind because it's a bit complex. Do
you think it's a good way to test?

Thanks,
Jason

