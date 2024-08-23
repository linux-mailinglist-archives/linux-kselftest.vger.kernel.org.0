Return-Path: <linux-kselftest+bounces-16142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89A95CBE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 14:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDBA1C23F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48B183CCB;
	Fri, 23 Aug 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MnoyYbWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360314A08F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414426; cv=none; b=X5WgugTct8OSJlLD2wlm6IGv93s2GavzMRXBTbYC/R6z7CfHs8jxEJdzoSYRSzraSxpElJmqwAXcrqaTFc8Ky2FfBv+s9f46RnEEO9Thn+UP/+LAUN1EbzUyRy7dNeoC2wg6v/UZ0RiD3t2/2VPHy5UNb9MYdnERhXYFNyPreJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414426; c=relaxed/simple;
	bh=qeCdohfNKomYDIhCdQ65hVd7YI0uAh/eKFSlmg3Rfq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAabHXza9l0s3ReDURgSm/5Q1ELPFbaG5D39HH7NcDrah/0mzmUqs2faeK3tHvme1giwjW+cug8o2puBMzf29ipp69SC0A1Kgfj6Bkj+Q8EmCVRn8fMMeEy02QWEZLe2ByACpcfm7GiJLDHbxIIoXIP8dw4pNvMSLTGgiJXmpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MnoyYbWH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso2456416a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724414423; x=1725019223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfSWPtf3RmlBd/B5tnQdHuIxqsHu2bUSg3Sj9mBLX74=;
        b=MnoyYbWHn18OWLWNwFVDfixNOUV97IhYijuXq4scMobYctcO1OhGIqL5jV3EdhfAZ7
         1qSjXAU9LUYMMA2kPqp6G66Gs1J+TYY5bGk1sVQMKUifG2pQ/0oTCDvcJoqRl8s0SJVx
         aT6FtDF+uTa6izKJcqPiXcuj/nINlYT7x29TLMdKrIgaM2UyLiSESU4TDdDlp1+oEmty
         afR0y3L59OIX5+GC2B8PqJZW/sRzS6HeefHjFXg8T30DK9bnPCABbloMGkspwKYK8Mhc
         SF+ReKz25sJoYl/VWgI3/vtfDyxxdxH/i3LM51lyYz5n8ZqZUf0tTtRJsWokwAGRXKMn
         BXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414423; x=1725019223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfSWPtf3RmlBd/B5tnQdHuIxqsHu2bUSg3Sj9mBLX74=;
        b=oTugeFXXJ7BKI6MQQh5C+V2UMtPQ5WzeZnsjMdDVRuYm1gL9Srt/qzongknO4dwld2
         v3FNKM2OBvzB3LMTPFnPH6bYxDfqUhB9ceyDAUxVvWL0ZJBryu2v3+EXDVAIW3TmXld+
         4iO/+vDh3ZaGgAeoFRr8UFdpI8ZzEmgXcCY1DVhCjqn3lXvl/lAGXoeSEQMlzElk7/Er
         prJkwXBkdHlo0o7atp8pjpSstrgTpNxYohphO3161H+fPZLPWbpFY960RB/tOZssFR4r
         e1LLn4mqLEReXTJfP3JbMmnyAaXaHyHE9udGA3BZYGgWly1v8YqtKO+efW3HXBJcqzNb
         URMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwTqVD1aEPY7gKx3GgtsB420Hbu9LBn4m8gN2FlUyGZSEMgxr/tvI4ro5XnUgIFnpUIXpL8V/2h88TTJNnIBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPlxkq1rSS+owVZ+8UeyBMLxmtemnxNSGU9AxR4tsckPV+QkX
	Tk4jl8OI8rG2U8kKHN75VSng+i8u3s0yqVvOLnclj9F/ErS6t0gpp+zo0oh1YJuXqQ31GfhKz+5
	r
X-Google-Smtp-Source: AGHT+IHLrig4hHkD0wjnum9V4jAxJCtug0aQmZ4mjmSi8jKUrUcTrzRc+AOW/bLKhjHYLF1VjvH/zA==
X-Received: by 2002:a05:6402:90b:b0:5bf:157:3b5b with SMTP id 4fb4d7f45d1cf-5c0891690f4mr1556904a12.16.1724414423284;
        Fri, 23 Aug 2024 05:00:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c9322sm1999971a12.60.2024.08.23.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:00:22 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:00:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: wait for atomic replace to occur
Message-ID: <Zsh51f3-n842TZHw@pathway.suse.cz>
References: <20240822173122.14760-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822173122.14760-1-rysulliv@redhat.com>

Hi,

this is 2nd version of the patch. There should have been used
[PATCH v2] in the Subject to make it clear in the mailbox.

On Thu 2024-08-22 13:31:22, Ryan Sullivan wrote:
> On some machines with a large number of CPUs there is a sizable delay
> between an atomic replace occurring and when sysfs updates accordingly.
> This fix uses 'loop_until' to wait for the atomic replace to unload all
> previous livepatches.
> 

I think that Joe suggested to add:

Reported-by: CKI Project <cki-project@redhat.com>
Closes: https://datawarehouse.cki-project.org/kcidb/tests/redhat:1413102084-x86_64-kernel_upt_28

> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
> ---

Also it is a good practice to summarize changes between versions.
In this case it would have been something like:

Changes against v1:

  - Cleaned the commit message.

>  tools/testing/selftests/livepatch/test-livepatch.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index 65c9c058458d..bd13257bfdfe 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -139,11 +139,8 @@ load_lp $MOD_REPLACE replace=1
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> -mods=(/sys/kernel/livepatch/*)
> -nmods=${#mods[@]}
> -if [ "$nmods" -ne 1 ]; then
> -	die "Expecting only one moduled listed, found $nmods"
> -fi
> +loop_until 'mods=(/sys/kernel/livepatch/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
> +        die "Expecting only one moduled listed, found $nmods"
>  
>  # These modules were disabled by the atomic replace
>  for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do

Otherwise, it looks good to me. With the added references:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: No need to resend the patch. I would add the references when
    committing. I am going to wait few more days before committing.

