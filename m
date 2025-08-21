Return-Path: <linux-kselftest+bounces-39603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52180B3083D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E847AC4BAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA82C0262;
	Thu, 21 Aug 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm2EDa+P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7163393DD3;
	Thu, 21 Aug 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811049; cv=none; b=QC2oXQel2nNj6rxYPkecCjNUR7LibAymGVAXqEtAf82+CidTB+nTn34gyjAKtwtYA0RUn5GJxpA/jxVMh5h42jqCuuD5/VBZ7y4aIgo+HbGcCSTAK1+jseBebDUCPommfscFXKlzby7Tw7wIOAA4MZ+JwOeLzpoUQA8KBMlqwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811049; c=relaxed/simple;
	bh=wIvWJcJ2qicBpEyhg+T9O62WoWdENAS0bcC5e9CSn1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLqsysqdvzAUhV7xefmCIXhbHw+y5M4VoI1+2Nj3GZHF2TEnJqhVcfxNAskW0hpxXYpEFRbMuafF3aIJtyjR3vZX6pxbIUTYl8t/w6Al2BxXydTrTewiVClJXR1cZEqA1xMjLAVYT/VtEaUYCTKCdnpt4OJF4n0BVLjAPAVfr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm2EDa+P; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603658e3so11848457b3.1;
        Thu, 21 Aug 2025 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755811047; x=1756415847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0A+kRlT2FglN/8Bz1t/135C//i0Oe25IbMxPqDCh20=;
        b=Mm2EDa+Pc53AY9wnEsDV4fn5KbcPOqxznX1jixgFxi4TFbIA5ul3MstbV3krdKWN1v
         DS3IL+bGyLQycMJnCro7hfzXdW6VX+CbWUQ6ETB0NJtRzKv/Vh5iG7ZUA3eIzI6CiCmC
         4ZoAthWlUWsce6MrviwMEiMr+UYHzxt/dmMOYQBjSxyDJa03Gsa+pP+QBGrB0u0MtFW6
         N60grxzBZkz192aEIasRaYCSF8bGXUvElSDasqEaqA9BQRwqwXj1EvwNM9XUYqDhJW7u
         7s+iC4uDHRBfFfxu6pYJDHPFrBF1X24xVJqYLfGekcMQLimGRmiJTxuF9cd54rF6H+JP
         qEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811047; x=1756415847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0A+kRlT2FglN/8Bz1t/135C//i0Oe25IbMxPqDCh20=;
        b=mp0INznmqT3MABkTH36ucge+dod8WiMHJG0zj7IUqCFzMEPGr6e5Qt7oJ/gbw5ZMlw
         +OFXNCzvqwI/kVUuuNp2o1fUx3hUD61qhDxFXj7zU3MjjYHwwCaMhK/jxYwhDGSgRklt
         HtdkEtpjykHRXYkcEdsCuVpPTpLqgXI9A//X1d64VdmIAOi+RO6hnZTnXpu1f3tWDl+U
         tRD7ZH/z/2yI+TlWnoATRJP93mnFyrbSzZN7GlfyFkvaNhF/Tq0RoxCsnhup4PussBD4
         9doi59DY7Qok0mEJC8/CNnsqEjvHbFbakcEAOOfKmdyAwiSxmoh8ENuQWGNXL7cgG4O0
         3+hw==
X-Forwarded-Encrypted: i=1; AJvYcCV1X/RJm2UBxomZP+DZrhqQgR//+vrKEQ4DsairQSLLPWc1EPEnviJtnDhkACtswaN4fXMM4fk6ASje940=@vger.kernel.org, AJvYcCW3262NyAw3RpEeXtNhwBjzEnTAsbxVdQPDuya1XzvIEMlsuVAfUtwRhdPsb8dBQbhwJWPRI8v/e6Qsic4=@vger.kernel.org, AJvYcCXTHYF78EUNXLq2M98oVk9TqKJSErx8mzrLtHx1loa+110SeWjKjmhBCAXXQiVl9NBCMp2vdPyFzxhA7lA/q9iI@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmf+kF8iZyR5XcDBjVpZR6zuyhicpqqs99TiWbpl1hzs2659e
	Mdr1Dt5+GTSnHeRMpS/Rl3BHAzmxKO1kcSxCrj7/1cbNAiS3Kj5cGcNUbruLAOjptd1c/qAdmZD
	3+rCzNAVKMTAe03D3QMafwa3k6Djav98fOw==
X-Gm-Gg: ASbGncvE+5xTYMcJ7I+Jwu/n6V9Q73LyOjgvULk24+hOcDMFOGgaUjgw8b0TujZbKye
	QYCRRgd3ZChlfN5m78SF4IIOSenLnOljh1gEmfQN1BfPRpJFpm2sJfruqfc/tMbYdfRBxb6wBxv
	ZhvquFwJREJMVr8JyniET0d7laMcTuK+w+Ox1HsX6e4ho8IgtplwGX9iZJ01eho6wTVXps8HApw
	UM583ZzkgtdfoZhTiN4KwOTpg6wsxBoM72WvWnqN1qKohmUzo2kIyWa7lc=
X-Google-Smtp-Source: AGHT+IG6//TXCd7HWmIFgh2CoCFbe0b7gysAa1lfgSeo97MehCuFJS9JIpTBAgiJE6ZQ+0LnbnlXHEBegv61Kx3lmJQ=
X-Received: by 2002:a05:690c:4c05:b0:71d:bc04:a615 with SMTP id
 00721157ae682-71fdc307ab4mr7570467b3.15.1755811046697; Thu, 21 Aug 2025
 14:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200132.1218850-1-zlatistiv@gmail.com> <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
In-Reply-To: <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
From: Nikola Ivanov <zlatistiv@gmail.com>
Date: Fri, 22 Aug 2025 00:17:14 +0300
X-Gm-Features: Ac12FXyzv06cBuZ62BErId8wrKWN93hUseTYhtMGTtt1blvR1AUlAbdCKMTekFc
Message-ID: <CAHjv_as7m7UbSLAPU6hX_=tAvLZYR_7Q=1n+Xq-nW-6OJ237PA@mail.gmail.com>
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 21, 2025 at 09:49:29PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2025 at 11:01:32PM +0300, Nikola Z. Ivanov wrote:
> > Remove 0/NULL global variable assignment in mixer-test.c and pcm-test.c
>
> Why?
>
> > --- a/tools/testing/selftests/alsa/mixer-test.c
> > +++ b/tools/testing/selftests/alsa/mixer-test.c
> > @@ -53,10 +53,10 @@ struct ctl_data {
> >     struct ctl_data *next;
> >  };
> >
> > -int num_cards = 0;
> > -int num_controls = 0;
> > -struct card_data *card_list = NULL;
> > -struct ctl_data *ctl_list = NULL;
> > +int num_cards;
> > +int num_controls;
> > +struct card_data *card_list;
> > +struct ctl_data *ctl_list;
>
> Nothing now sets initial values for these variables so they all have
> undefined values which is buggy.  The code is relying on the default
> values.

Checkpatch reports it as an error, it looks to be part of the C
standard that all compilers must initialize globals to 0.
Though I suppose it helps with readability to see
the num_ counters assigned 0.

