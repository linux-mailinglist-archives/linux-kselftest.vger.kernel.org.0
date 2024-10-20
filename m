Return-Path: <linux-kselftest+bounces-20208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58E9A525B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A001F21543
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1845228;
	Sun, 20 Oct 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKRL3PdB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41043D6D;
	Sun, 20 Oct 2024 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729397455; cv=none; b=F42E3izlaz+t7OpQYsR3HShD91ogrY/xrrTHEIAuAGQH+CGn3P5vFs6yIRw0JWGH+11oovNbbsLzo+XBmEaZv01IsQsB3o9+y9QeHiCXcMmGOaPVnWvkT67QFrs3FjFC4BP/jz6yErkhgr0MURBtwxa+r0IwzLigpNg/FKDzOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729397455; c=relaxed/simple;
	bh=zQXcz88EGW9c72+0BlUdpyhImXbpufOYIUYTp3sROeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmZWsmD5G2iWyDXPIBg0p6uNuSuE2orZbByS4aFFkImvGL5AmjEDGBKr/ScC/MaG0o90aEXTbxYVz5krD7aoH7zdPZ56qE/34D97fVkiWyvmTtBF3cQxMbSgpEqDz/0VWfdV67WrenitZc5NyejxaGMXtJ85FRMoxem8RZoIHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKRL3PdB; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8377fd760b0so135647239f.2;
        Sat, 19 Oct 2024 21:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729397453; x=1730002253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJHoph39D/RnnBnbGuWC9Eue3ZvDMD//3f3X4tuREwE=;
        b=cKRL3PdBovusF9iQ+nunT/mSqdOjfp26035qnaaOgx8YmYSxP/Xit0We87Hz2+WZwR
         LR/7sLneC4SxmFiiRObUACIgMCi6aAw9yi9yLKnqMA/hrskGfyqD3jVvYHy5qebuEfvt
         1XMtauOzuWax0DF6J96wVPhvW5NtftmBRx4CAn1sLkYTjVeoS3yoV5UapV8cHU2M6RwG
         Q1HGp7YXSj/QHcSjDFJOHbJMIVIJZ9pDcCw4vJQKoDD2Njq6RlUfjS3Rpi+oRdfO2nAq
         1qfi6e+6k/CaomznxFbLAh5uLwA5G4H0wvTqBNZ2fOfv/lBraqVt17IAwEBstlNusi37
         EG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729397453; x=1730002253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJHoph39D/RnnBnbGuWC9Eue3ZvDMD//3f3X4tuREwE=;
        b=ZrYkRI1/m++ca+YUQb1o+Fbw+Zorw5QD3Y9Ey+9aK69xmXYrjdEWijsenEkubICIEk
         EyjguPzQl4CybVcZp4kmTE32XS08LLezBrkCBP17EpCtghb0qk41susWxtb//O0c3/Ab
         MGsyu9rBbmSigszqFBS2I0FNVSVDUolpzZDKLQTST8lq5Ukx56TiiVTdqXOVJ9Fpla/3
         x4U7Cke2cDO5HBMrzkJfbLCTPTjYm66mbNP3sg6azFC58MDS6LsAdkKd+2zULKA5WD5Z
         PRV9NeB+AH7ExVoQk0NOmJzRmxVEnW/1JBzao4njTWFB28WSFeZ/R6+mO7P/8oO/9V57
         i+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVJs1k+YlXCHaVrUKKiIBRUS+PIoAk+6hJNuW1mvWRP1GmbbZhIXGKcHFkXD2hL5+T14NvzsrTb3AAC1/Lsr9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQdhRj2ftI63naUP6GkpXW5Hc4nBqWiua9NzcSfGDJZZYAixd
	6bOnttO59IGWdtK0cv0PROGIpEczx7JOHldzW0r4ZO8k/nKcXt1712H5w9w7rSKwaRYVPJqxUSf
	//os6lKgy1OvyrtbBpfd5VflA56U=
X-Google-Smtp-Source: AGHT+IFOm5U50tMQtevlSAxC6riyGl2ojrLBShnbjzRxzVkU6Z2KuAGxoK8CPqFHAEnFF/6xAANrj9syB1vmZqXvQOQ=
X-Received: by 2002:a05:6e02:1fc7:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a3f40ab47cmr63149195ab.16.1729397452553; Sat, 19 Oct 2024
 21:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020031422.46894-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241020031422.46894-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 20 Oct 2024 12:10:16 +0800
Message-ID: <CAL+tcoCeVi=gq-L6eH-v2FF2JWDsKX+aLB=KYUqJnjxT=4y34w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 11:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When I compiled the tools/testing/selftests/bpf, the following error
> pops out:
> uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> uprobe_multi.c:109:26: error: =E2=80=98MADV_PAGEOUT=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99?
>    madvise(addr, page_sz, MADV_PAGEOUT);
>                           ^~~~~~~~~~~~
>                           MADV_RANDOM
>
> We can see MADV_PAGEOUT existing in mman-common.h on x86 arch, so
> including this header file solves this compilation error.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/bpf/uprobe_multi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/s=
elftests/bpf/uprobe_multi.c
> index c7828b13e5ff..b0e11ffe0e1c 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -5,6 +5,7 @@
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/mman.h>
> +#include <mman-common.h>

uprobe_multi.c:8:10: fatal error: mman-common.h: No such file or directory
61 8 | #include <mman-common.h>
62 | ^~~~~~~~~~~~~~~

After seeing the error that CI reported to me, I realized that I did
cp /usr/include/asm-generic/mman-common.h to
/usr/include/mman-common.h.

If I try "#include <asm-generic/mman-common.h>", then I will see
redefinition error:
tools/include/uapi/asm-generic/mman-common.h:26: error: "MAP_POPULATE"
redefined [-Werror]
 #define MAP_POPULATE  0x008000 /* populate (prefault) pagetables */

In file included from /usr/include/sys/mman.h:41,
                 from uprobe_multi.c:7:
/usr/include/bits/mman.h:38: note: this is the location of the
previous definition
 # define MAP_POPULATE 0x08000  /* Populate (prefault) pagetables.  */

It looks odd to me. Let me dig into it more.

Thanks,
Jason

