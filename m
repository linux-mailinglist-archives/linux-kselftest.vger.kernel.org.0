Return-Path: <linux-kselftest+bounces-2761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D9828CA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 19:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677391F25E70
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA893B794;
	Tue,  9 Jan 2024 18:32:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93B364B7;
	Tue,  9 Jan 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f588ce1b6dso30846527b3.1;
        Tue, 09 Jan 2024 10:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825166; x=1705429966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+gv8Hp6fNU/haOwtR27pUkHz8gEjZ0jq84NA2tkEJc=;
        b=p/tkioywNtrIbi08DuPnlqClZZWHF2GE+gEnkrvc4xb99eTVGx+6yV1rhj1jSY5YcM
         sYF6/EAqfUXExDG5PhA3OrJ8dwRMtp363hRD7HZA+6w1n/cu9SBoCeK7w7hPfWJnmqdM
         FUIfPgXjU5JC24l3Z4Lypd1N3hry/YDDj78oLo1dKDt8sPraqKGYWzB7Eya/JH+ghxEc
         vNduwGMPf+W+DLY0BW7CESYlaf147j+9dXSecUFj7aAstMoqzemsmttMkSHIj5ltKxAJ
         +EfouH3s2y0oWd4Wiy9Veq3dt3djHJhSUl+IQb7MJemZgf8CndBkCxkqLTF2PwP8IeuM
         a1jg==
X-Gm-Message-State: AOJu0YxbTcdDp9VQEgQ2XsNleXStTclEBsfIG726G9Xrq/vVJS01UzYO
	GCSdB9rZi3+9htTmyAHVJaHv+k4LFIcnal4/
X-Google-Smtp-Source: AGHT+IGLwweFgyVI2oie63H7rAHCX0b1raKr1AGnXd3da244jhhpOkxXdiWDGVLZnqEev8dEj9gHKw==
X-Received: by 2002:a0d:db82:0:b0:5f9:42e2:9d65 with SMTP id d124-20020a0ddb82000000b005f942e29d65mr677309ywe.40.1704825165707;
        Tue, 09 Jan 2024 10:32:45 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j204-20020a8192d5000000b005a4da74b869sm953830ywg.139.2024.01.09.10.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 10:32:45 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f588ce1b6dso30846107b3.1;
        Tue, 09 Jan 2024 10:32:44 -0800 (PST)
X-Received: by 2002:a81:4fc9:0:b0:5f0:aac7:1310 with SMTP id
 d192-20020a814fc9000000b005f0aac71310mr762009ywb.48.1704825164337; Tue, 09
 Jan 2024 10:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <20240109154547.1839886-2-jeffxu@chromium.org>
In-Reply-To: <20240109154547.1839886-2-jeffxu@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jan 2024 19:32:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
Message-ID: <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/4] mseal: Wire up mseal syscall
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Jan 9, 2024 at 4:46=E2=80=AFPM <jeffxu@chromium.org> wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Wire up mseal syscall for all architectures.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks for the update!

> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -456,3 +456,4 @@
>  454    common  futex_wake                      sys_futex_wake
>  455    common  futex_wait                      sys_futex_wait
>  456    common  futex_requeue                   sys_futex_requeue
> +457    common  mseal                           sys_mseal

In the meantime, 457 and 458 are already taken by statmount() and
listmount():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/m68k/kernel/syscalls/syscall.tbl#n459

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

