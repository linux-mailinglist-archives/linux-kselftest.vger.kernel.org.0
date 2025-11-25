Return-Path: <linux-kselftest+bounces-46415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684FC834F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 05:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2656E3A693B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCD274B42;
	Tue, 25 Nov 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czygq7zJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01B1A8F84
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043470; cv=none; b=MTUWJxZq4Du2FPYoZiZplSmsBh62EbhOqT4w6THyhY5dr5aYBS5leuYoPsQ1abJ8J4nYhmjNrEZYR2+W8R+aMH9rnVABT+ruiNvw74wHITjIB5xopxK4JZ2JmcKsKVv40a6OIUPSgAlG/BNhP7ZN9hxFoRARdbyidYc6YUqdAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043470; c=relaxed/simple;
	bh=/FbogxLt3QT/nU4TGzukKhlWMxnJmkC8sZFIkQEjjAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6UNETex4VwKVfl/F4f5L5NV/uw9OgJuDq+x5cqIA+Btaxw5ytU6Y9yGSLdq59n+MJUsmKbEOxKrCVyGUt9BbAS4V1VQIqDJTAvYgmwv9wApCpIkaynCUkgXA8M91KaOqnaPRapw7WItqORtWJfVyULUSsmgYOLDCE+CGgm3ZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czygq7zJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343d73d08faso2592962a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764043468; x=1764648268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChSFyJUpzIVcmS5IaAZ2eEZOCaW40eEyMxqhYyX42Ig=;
        b=Czygq7zJvyy4AKmciFy82f4zjBtAxEWGAuAZuCV8hlhRaJiT8q+3HZ7p0RZ/gD70BG
         aTPsRLZK7vJwsqx2v9n42eQQsJDY06NM4pMVE7Nm3FewI7CS+Vgnk82tOhh/n0BKcVqr
         QT9Qirh8YUJBS1HKqF/veVACIQiJdzzJohQUBYkSSN6iD7gZB+0rqsUm7Tiu0T97e8Cn
         GFpSO8EX1d+5O6tQ/Qvsc5zvQmcdpWFu1EqzfPBjUvqqvnkDTTQfsx2X2eUh0Yf5nfB6
         OTJ8YxjVC/f+YEzwAjsCWqV1vBCw8OXrQCLeXkOIg9PR4NEfmfjY+VRnDkfajM+XG6um
         eZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764043468; x=1764648268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChSFyJUpzIVcmS5IaAZ2eEZOCaW40eEyMxqhYyX42Ig=;
        b=Pz7+EpLSm0+Rec8x0XSjxgDE/EkP/3wbSR+FjWaqtzFEc6/LOgWAgWET7T+GXFvZca
         hEvtmomGjXdTLzRkXSuUWU/K7TRauLg+ZxCLSMkZgpG8hW69FXiRec1HRisByAk6dxji
         7b0s/gJVOLU0vPx+sBQ5DFp4IhaDlm9NNblkbt0tO6KDpwjvI2aF2+Mu9gCGi9Y8SZEk
         5RzzveuKuNZISO/W9be4HmTJ0G3SxDOjsmdmhnekkkhuS8Wq6PqNrxHdMr/4op+WlvQ7
         vVHZnh1utOw4vwZPlOK4NDpoAY+9Rwp2PsWWWBLEb2UvO9Kkn/XdeqrfMi04/spuf69p
         9Jww==
X-Forwarded-Encrypted: i=1; AJvYcCWzg3043urqnJUx7XXsdhpD6kIFhEU7/NsaOt0A60z3LBvFjxv1udKAevv8WAN2mEpzLGsxeCYb6am6RS6fS98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrBgrnOjmqS30wsAU28NGkA1gnWVyRDY+wJEDJZQ9yNKzJjXo
	Fa0OXjHiWjWoYr4O90gstPbO1hM8KRjgXN2J/1jXADIQzJRfpB3XmKFEiX3zmkudwzeZxLgysuI
	W1vOiEWqEDBckIEXWfcoq48mJT3U14CG1fk9YNXQ0
X-Gm-Gg: ASbGncvSbkDvKeMU907TSsAzrjRfKr3vsLikzqMqJeSfqp2s9tuiEfsjyv2cCsRkDNr
	m0DeF3QRjLDcp1bRr5c1RBScDjXAEMnOAN12JkKFX6tx6D+nCfg6Awjf3KITFcjJ7twMxBE7EnZ
	buoPflMyRQwGNU1S94zEQP8SFgBiM7Cs7o/LP6dcH8tycf9Asy5DNxdo9jtrpPu4981lchsh6cq
	EArW8cfUQnL7RPaR2s1MFviJPFGEOKZXTYmFiWF/sH2+meA22g8tA2FoUoWr/mxI6/mxiQW//2p
	ILHqcd6uneqJryh7m3rCZ2+okA==
X-Google-Smtp-Source: AGHT+IFe326vtD9xIbEJxnlPgbrhSCWdZGMdC8KNPPHbVB+yjM8Yma+NpH35C0vH0GmGrxe+D8Javv1mcabOykmplq0=
X-Received: by 2002:a17:90a:e7c7:b0:340:6b6f:4bbf with SMTP id
 98e67ed59e1d1-347298dacdcmr18444397a91.18.1764043468011; Mon, 24 Nov 2025
 20:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202505280933.33EEDC4DC8@keescook> <20250529225525.12494-1-sameekshasankpal@gmail.com>
 <CAGZaOhe0++vMANe1cAXXz=Pt1pf3ZX1vk3U7c0nGRnGGkt8e3A@mail.gmail.com> <66a49c4b-2008-4059-97aa-59d53fb91c31@linuxfoundation.org>
In-Reply-To: <66a49c4b-2008-4059-97aa-59d53fb91c31@linuxfoundation.org>
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Date: Tue, 25 Nov 2025 09:34:18 +0530
X-Gm-Features: AWmQ_bkrWf_EuqRi3rZK4l2jxjroq3j8ICTen-MWXo1Nur7-mIBJm3ay5gF46c0
Message-ID: <CAGZaOhcmHt76q=ABQ-NJvj9tuedCeonEFGP8SvnhUp9=+T5tPQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/seccomp: Fix indentation and rebase error
 logging patch
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

Thanks for pointing that out. Apologies for missing the mailing lists earli=
er.
Resending this follow-up with the correct CC list and in plain text format.

Please let me know if there=E2=80=99s anything else I should improve in thi=
s patch.
I=E2=80=99m happy to resend it as v4 if needed.

Thanks,
Sameeksha


On Mon, 24 Nov 2025 at 23:59, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 11/21/25 23:21, Sameeksha Sankpal wrote:
> > Hi,
> > Just following up on this patch.
> > It=E2=80=99s been a few months, so I wanted to check if there is anythi=
ng else I
> > should address or improve to move it forward.
>
> I see that you didn't cc any mailing list on this email? Please keep
> everybody in the loop when you send responses.
>
> >
> > Thanks,
> > Sameeksha Sankpal
> >
> > On Fri, 30 May 2025 at 04:25, Sameeksha Sankpal <sameekshasankpal@gmail=
.com>
> > wrote:
> >
> >> Rebase the error logging enhancement for get_proc_stat() against the
> >> upstream seccomp tree with proper indentation formatting.
> >>
> >> Suggested-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
> >> ---
> >> v1 -> v2:
> >> - Used TH_LOG instead of printf for error logging
> >> - Moved variable declaration to the top of the function
> >> - Applied review suggestion by Kees Cook
> >>
> >> v2 -> v3:
> >> - Rebased against upstream seccomp tree (was previously against v1)
> >> - Fixed indentation to use tabs instead of spaces
> >> - Used scripts/checkpatch.pl to check the patch for common errors
> >> - Removed the blank line beforeS S-o-b added in v2
> >>
> >>   tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c
> >> b/tools/testing/selftests/seccomp/seccomp_bpf.c
> >> index 61acbd45ffaa..dbd7e705a2af 100644
> >> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> >> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> >> @@ -4508,9 +4508,14 @@ static char get_proc_stat(struct __test_metadat=
a
> >> *_metadata, pid_t pid)
> >>          char proc_path[100] =3D {0};
> >>          char status;
> >>          char *line;
> >> +       int rc;
> >>
> >>          snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
> >>          ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
> >> +       rc =3D get_nth(_metadata, proc_path, 3, &line);
> >> +       ASSERT_EQ(rc, 1) {
> >> +               TH_LOG("user_notification_fifo: failed to read stat fo=
r
> >> PID %d (rc=3D%d)", pid, rc);
> >> +       }
> >>
> >>          status =3D *line;
> >>          free(line);
> >> --
> >> 2.43.0
> >>
> >>
> >
> thanks,
> -- Shuah

