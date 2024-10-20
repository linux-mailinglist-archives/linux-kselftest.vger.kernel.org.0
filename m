Return-Path: <linux-kselftest+bounces-20209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66719A5282
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 07:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C306283AC7
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 05:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B333234;
	Sun, 20 Oct 2024 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXM5a80z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35D6AA7;
	Sun, 20 Oct 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729400572; cv=none; b=JNrsleGifGB0DqN6n2R8ur2WIJmgstUmaouJS/Hg0bCEgX7obAky5iHV2HCy4cCb4jmFmYVe3X+7WHjzY5mqswuMoRFjqf4dcxEKM/GTCXf0wYB2Ejn5an5SeeTIyjZVtjjCbBYIaPDGQFBto0UTdvXbXGQfOrIYUByPHd/xc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729400572; c=relaxed/simple;
	bh=YdelWmyvsgxKeghCFmIeU5u3deE+FXEpFqxQQBF3DeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LousyZKzqi5TReECy8JPFp5BfgtMmNzTGr8zBSKFw881tplJQcw0/0jU1V8j51jBe0X1mTrGCuhlPJBMBPXl2bBblLgh4caZ/+0HS/1e4eBG2I4Y4ZDkBLWUcF2oDvI1yer2tqqLqPLvi/mIO3gRy9Ba76e3B6AbNXQACDj0FJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXM5a80z; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83ac05206f6so57393439f.2;
        Sat, 19 Oct 2024 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729400569; x=1730005369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsJR0F5q7MBd9Z9F00u1fE9YM5BMz13zjGpTwB5PoYQ=;
        b=lXM5a80zSt5PWsfYQ1mr+UiKr8Wt34xWQbJHaLSq2J0ze2Iuo/1bz39XuzviMfZ4PU
         m1SFa4Fdv4sIPuOHY4Ti2HtfhZ+db+pxLuYuKCdFNpczpQe8iqMtbdoO2ZKuGNj+kcZ7
         sXs+T6YDRkwfnCu4a158QJk64KwRbFBwkBe/6me0pZOvPuAV6lgiW47EykhOPrJaqdk9
         wGnxYmxGxT3wcU5xyXqIkeKx1462QhocwWB3itq8bnGPVRy/xbcEb5I6BevQLrkIklt0
         agTAbtc3JFwKh7D5pPAHnoDlBA6ezOlWtjkKvF38d6Xb3smh3w4WDdvgyjO2t1iiD9DU
         VuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729400569; x=1730005369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsJR0F5q7MBd9Z9F00u1fE9YM5BMz13zjGpTwB5PoYQ=;
        b=LP2QcCdKAPrkr5QAzCQZiN3/eABTy3ji4GoNtDZEkCB+YaqQkNJVgwKQieUnbwxVp+
         vpajNyItEH4UMhEXJ8r5xV6XLNjkEVA8ps2IxtGEFZMTDXOx1y2MfcDqYw1YJCLk76H9
         CYCmtOUx6ZDZfZzTvOvZ4WhMq/EB+HxWxPfoyKqjfs2yRfYN5iU7MCm77bd+jXQx6J2U
         Q89pTvX/BlT3w4+TGxw1FtF6yl+S4V6wjl0GWzlJPtao/a+sP72la6Ip/CGtl/Bwwptf
         n3g9DH2kgRz9QKwgdu4hCiP7gP2SsBXCM1/v4dLeyJiUDWH+gO/qcaWEX+u/GVKVWuiL
         uc8g==
X-Forwarded-Encrypted: i=1; AJvYcCXsJnBwhV6fM019tIAbn6RPz7E7p78QjWv4JN7oigC7OeGjsLiu5pfwa7MJ7425g08b0fCqZOZA6WMKeUD+NGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsShc04y8uh9dtDaCchSi8206+5sNsrTdFNCWgP4vEu4J4M2OQ
	NX8c8fC55aATU1OODbvdL38LT5Ma5Co/Ruvt7tJRuq9juBcABD8fwlON66KPrNQeozcW3W1lyD5
	7NrW2aWi0MXopjkZyA/GjjtuAb6wNT/Cwg6g=
X-Google-Smtp-Source: AGHT+IH8UR2779g22eU0uNr5WV/bf3JVS5GwkoHrn2KbaDxqfGBB6Pwvev5DXDCyo9KKyBedVsRK/7TiU7fiT9tgivI=
X-Received: by 2002:a05:6e02:20e1:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a3f405f920mr65511875ab.9.1729400569101; Sat, 19 Oct 2024
 22:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020031422.46894-1-kerneljasonxing@gmail.com> <CAL+tcoCeVi=gq-L6eH-v2FF2JWDsKX+aLB=KYUqJnjxT=4y34w@mail.gmail.com>
In-Reply-To: <CAL+tcoCeVi=gq-L6eH-v2FF2JWDsKX+aLB=KYUqJnjxT=4y34w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 20 Oct 2024 13:02:13 +0800
Message-ID: <CAL+tcoCWJ0qd=0nDCGx5gLykycd+AsuUZCPt35CJabm6=MDbGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Sun, Oct 20, 2024 at 11:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I compiled the tools/testing/selftests/bpf, the following error
> > pops out:
> > uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> > uprobe_multi.c:109:26: error: =E2=80=98MADV_PAGEOUT=E2=80=99 undeclared=
 (first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99?
> >    madvise(addr, page_sz, MADV_PAGEOUT);
> >                           ^~~~~~~~~~~~
> >                           MADV_RANDOM
> >
> > We can see MADV_PAGEOUT existing in mman-common.h on x86 arch, so
> > including this header file solves this compilation error.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  tools/testing/selftests/bpf/uprobe_multi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing=
/selftests/bpf/uprobe_multi.c
> > index c7828b13e5ff..b0e11ffe0e1c 100644
> > --- a/tools/testing/selftests/bpf/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> > @@ -5,6 +5,7 @@
> >  #include <stdbool.h>
> >  #include <stdint.h>
> >  #include <sys/mman.h>
> > +#include <mman-common.h>
>
> uprobe_multi.c:8:10: fatal error: mman-common.h: No such file or director=
y
> 61 8 | #include <mman-common.h>
> 62 | ^~~~~~~~~~~~~~~
>
> After seeing the error that CI reported to me, I realized that I did
> cp /usr/include/asm-generic/mman-common.h to
> /usr/include/mman-common.h.
>
> If I try "#include <asm-generic/mman-common.h>", then I will see
> redefinition error:
> tools/include/uapi/asm-generic/mman-common.h:26: error: "MAP_POPULATE"
> redefined [-Werror]
>  #define MAP_POPULATE  0x008000 /* populate (prefault) pagetables */
>
> In file included from /usr/include/sys/mman.h:41,
>                  from uprobe_multi.c:7:
> /usr/include/bits/mman.h:38: note: this is the location of the
> previous definition
>  # define MAP_POPULATE 0x08000  /* Populate (prefault) pagetables.  */
>
> It looks odd to me. Let me dig into it more.

Ah, I know how to fix it:
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c
b/tools/testing/selftests/bpf/uprobe_multi.c
index c7828b13e5ff..40231f02b95d 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <unistd.h>
 #include <sdt.h>

It works. I'll post it in 24 hours.

