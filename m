Return-Path: <linux-kselftest+bounces-33325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A809ABBFF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E958816C1E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB14927A93A;
	Mon, 19 May 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R67IMWPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC9188CB1;
	Mon, 19 May 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662647; cv=none; b=qZkmA/ZKJ4ZdXDZaQ8Kk7RMweLXAkIQWHBctVel9nB7hhwNfgL81Ro+HMceiCe6aAdKlOKvSdTscNvHGUK6QhDg9lvc8XTVcn8hUDEQk27D3WiaTV06/EBjyhi0IUMG+RgS1mmD/C4TgBHzNZwgosQXDiXe3QsUwQuPG4tTGHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662647; c=relaxed/simple;
	bh=MibSDPHq5D58T6mIIf1fJmA4yGeMXPhpecied78LhqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciZQtxCJVBaxqVWZS4y30GvU+tAGiQ+JUcs/jF6mK93NFyhWwVuQMHop0EDWfItJdGxLYBxA8/yvw+NEX1YJC/ae+GiWW+JhKPc1VrlNr0MIgBC5yMinuQoYvt7TPGVtOvuL7TvuXIkB5chmvt3UDUVdLMsOXKlHemA9AzXrfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R67IMWPf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231ecd4f2a5so22780015ad.0;
        Mon, 19 May 2025 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747662645; x=1748267445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IutGAVL4WWh1zXRehsI47yja7zQgYOoHFSMk8JjWWw=;
        b=R67IMWPf05DXSIhLOJUH0srTa1qvDCdG9hpRJR1OkF1joRQNZ8IrWBEQmNSGgUjaO3
         b8hc3LJis/+7bfoRWzV3e7fzjTqrjNtZ62XNXf/cx90NhYDj/hQNAzv096hP6mWb4faZ
         f4/12Xy9aZL3woicyxcUF8yUSkVBXtNQVZ/GjUBRlg6BU0EQUlMtdaM8gczewr/Zmi/D
         zdinvQSF7Esqqlj6i/iNuBZVL5K8lpFYTu3gmJaGzEFWdFHCZLLDvW/ykxQtMxPdrxpH
         LlV1rwHDFHOkdaeRfCNsuGSmoCd1vkfbCUIk7hfAp7nqL9sy7JQshv0VKlgjPI0vavZP
         gGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747662645; x=1748267445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IutGAVL4WWh1zXRehsI47yja7zQgYOoHFSMk8JjWWw=;
        b=Z2Lw6hEF0ZtfwCGnu3oQqdXaZD+PYTilrj5rVVZPn/+uTBthPAR72op2ZFSgeRFARW
         U64Km9u8U7rlbW2g1nwpQutvr0PP5V5WcdoUeBOwG1zFwRnlmSNyk4FYlbdRLf74stxs
         +yNgh0ZaFPPDzr2sMGlgIVqeG5Vb6EoMuPV0/wCrmFnBtgoB6O+e3sXkprfXMwBqPxdO
         XhRXp/lyzeiniL0iVWIkUOE5xyCo0uKwyHO23ULUIphkBFZxMGzegYIp3GCcovqhprke
         N0lMTbExWNTJ4xU4az/6J7MRME3hRNkm2hVeg5W/zmHS+KwNiOKdFhpGMvjdlEDMS2jv
         tJsg==
X-Forwarded-Encrypted: i=1; AJvYcCUKacpsoQ9TiWMYVD0owRP7dLDu3smssUBOWebxblyJt4JZdodLdw0j8hjnm6kiXc+5eZzZtu4je38EY1Y=@vger.kernel.org, AJvYcCXoyAUneOTDr6+x+1Ygl+OYmrfXygtK9VhU0nryz2i3KV60pHSoO8oFol0mjSCopw1XnqKm+hc/CklkmaYECBtq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+CjV7CNNgn+RWB61cyGbwJl4nKcJWsNDqmV+uYjLWPi8+euL
	4xH0Nga88zdv76MCof6tpAFLIskyKDA/jLpcEPHhBW1SMVIN/TAqgpnlm4HkQj6nDuhV+rDjuVU
	EeFvpkeQJR6Bg9jk0kUvHKDtO12yCqIaI8bCgD+JqI98=
X-Gm-Gg: ASbGnctwOx/byXKFLd90SK6WtKJsUDzTCyeRs0t+MYs+K8akjL00uCkTV9/DjA9KG6+
	BsSm3F8bf2FgaU/ylydXlgNLvyH4b/oopPLgdJIve1QdT3nXOM4WZeLvaFoMReJTInMJnFu9r+a
	Uz/zGq2KqA4vHEishCfwtzocWTMV1XD55ajgkOOs47
X-Google-Smtp-Source: AGHT+IHOw/C0cymFVsWT9h2zFuzJv8a6dLH/krZaPX7GaHu5SRtUJOAew2rIPQlCdRZi5X5oJ3dtyFj4eSqKfRmk47w=
X-Received: by 2002:a17:903:46d0:b0:223:f408:c3f8 with SMTP id
 d9443c01a7336-231de3027c4mr178943295ad.14.1747662645131; Mon, 19 May 2025
 06:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250510160335.1898-1-ujwal.kundur@gmail.com>
 <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com>
In-Reply-To: <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 19 May 2025 19:20:31 +0530
X-Gm-Features: AX0GCFte3IuNk4JZd3aGgSh0Dprg-2xwuXlgFjve6MpCE3EWera5vSmU1YghjE4
Message-ID: <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review and testing!

>> -static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
>> -                         unsigned long offset)
>> +static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
>> +                                                     unsigned long offset)
>>  {
>> -     uffd_test_ops->alias_mapping(&uffdio_copy->dst,
>> -                                  uffdio_copy->len,
>> -                                  offset);
>> -     if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
>> +     uffd_test_ops->alias_mapping(gopts,
>> +                                                             &uffdio_copy->dst,
>> +                                                             uffdio_copy->len,
>> +                                                             offset);

> Looks like your editor got a bit excited here :D
>
> There are a few other places where this happened too, e.g. the
> are_count() declaration and there's a pthread_create_call() that's quite
> messed up.

I use vim with `:set list` turned on to display control characters and
it looked fine to me when I submitted the patch :(
Here's the output of $ cat -A uffd-common.c | grep -A 15 retry_copy_page:
(where ^I represents a tab equivalent to 4 spaces)
static void retry_copy_page(uffd_global_test_opts_t *gopts, struct
uffdio_copy *uffdio_copy,$
^I^I^I^I^I^I^Iunsigned long offset)$
{$
^Iuffd_test_ops->alias_mapping(gopts,$
^I^I^I^I^I^I^I^I&uffdio_copy->dst,$
^I^I^I^I^I^I^I^Iuffdio_copy->len,$
^I^I^I^I^I^I^I^Ioffset);$
^Iif (ioctl(gopts->uffd, UFFDIO_COPY, uffdio_copy)) {$
^I^I/* real retval in ufdio_copy.copy */$
^I^Iif (uffdio_copy->copy != -EEXIST)$
^I^I^Ierr("UFFDIO_COPY retry error: %"PRId64,$
^I^I^I    (int64_t)uffdio_copy->copy);$
^I} else {$
^I^Ierr("UFFDIO_COPY retry unexpected: %"PRId64,$
^I^I    (int64_t)uffdio_copy->copy);$
^I}$

I checked this against master:
$ cat -A uffd-common.c | grep -A 15 retry_copy_page
static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,$
^I^I^I    unsigned long offset)$
{$
^Iuffd_test_ops->alias_mapping(&uffdio_copy->dst,$
^I^I^I^I     uffdio_copy->len,$
^I^I^I^I     offset);$
^Iif (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {$
^I^I/* real retval in ufdio_copy.copy */$
^I^Iif (uffdio_copy->copy != -EEXIST)$
^I^I^Ierr("UFFDIO_COPY retry error: %"PRId64,$
^I^I^I    (int64_t)uffdio_copy->copy);$
^I} else {$
^I^Ierr("UFFDIO_COPY retry unexpected: %"PRId64,$
^I^I    (int64_t)uffdio_copy->copy);$
^I}$
}$

and there seem to be spaces mixed in earlier causing the formatting
issues. It looks okay to me after I pulled in the patch to my local
repo.

> Unfortunately I don't know of any tool that can find/fix these issues
> automatically without also messing up the whole file. Could you just
> do a visual skim and fix what you can spot?

Yeah, I ran clang-format and it's playing by its own rules -- do we
have a standard .clang-format file?
Please let me know if there's a better way to find/fix whitespace
formatting issues, I found a few inconsistencies which I will fix.

>  static void sigalrm(int sig)
>  {
>       if (sig != SIGALRM)
>               abort();
> -     test_uffdio_copy_eexist = true;
> +     // TODO: Set this without access to global vars
> +     // gopts->test_uffdio_copy_eexist = true;
>
> Did you mean to leave this like that?

Nice catch! I was hoping someone would suggest a better way to handle
this. As far as I can tell, this was written the way it was as a
consequence of using global variables.
I think this sets up retries for copies in a racy way using alarm(2) /
signal(2), not sure how effective that has proven to be. I believe the
only way to keep this functionality would be to introduce some async
action (libev, libuv, etc.), but is that required?

> +                     /* TODO: remove this global var.. it's so ugly */
>
> That's done :)

Oh I misunderstood that as "remove nr_parallel" which is not the case, will fix.

> @@ -1734,6 +1737,27 @@ int main(int argc, char *argv[])
>               }
>               for (j = 0; j < n_mems; j++) {
>                       mem_type = &mem_types[j];
> +
> +                     // Initialize global test options
>
> Wrong comment style here

Will fix

I'm not sure about the protocol here, should I roll a PATCH v4 or a
new patch entirely?
Planning on addressing another TODO for dynamically setting the
BASE_PMD_ADDR, I can roll the fixes as part of that patch if required.

