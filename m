Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C232B3F210E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHSTxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 15:53:14 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:39441 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSTxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 15:53:14 -0400
Received: by mail-io1-f42.google.com with SMTP id a21so9241332ioq.6;
        Thu, 19 Aug 2021 12:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yYuu4lI5p7DoBEaNzy386yfHwqBF6DSycUzLzLrgD2s=;
        b=FPIlJITyl8PTEG88QMniDnGFq4psg9paW/jju+NQVgtRFoKB2Y8pyiDfL9VwV7HdIQ
         ZTmxsvQPjqJ5UmGIcw8j8Qhjsi505vCVpc8bOBAPX8hHcw86GevrpCzbOQGCjaXVylXa
         7WHv076E9RH+2HjmgeOVN+caWKkaz4JK41zqExOsq1OyGilr+Simss14pLYYXKC8JRRe
         jFJh6+ZLHPzQl5Zth5L+tMIbpOPyVJ68B55vngooy5ke5bgHaQdwP4WnqH3s7E8SWcqG
         aDg9HCRatrinoF5zkm0GTepcUngMdYv4e4qbN/rsFP19zVRNND33XwVCIL4cYBS8sJiY
         Sqzw==
X-Gm-Message-State: AOAM532otfIee+JxzvjNOnawrFvauN5FS9SCCRQTElbWUjzTKuP9OaiG
        HiSILmFIngrBLKcbsi7eFHQ=
X-Google-Smtp-Source: ABdhPJzKPCtxfgk8QGIZPlCl13lAIFcOthcP+uQDDChZM8swSZ8vicFNGoNNuepW0cr02WRzyQO90A==
X-Received: by 2002:a05:6602:2219:: with SMTP id n25mr12516872ion.185.1629402757172;
        Thu, 19 Aug 2021 12:52:37 -0700 (PDT)
Received: from [192.168.1.109] ([213.87.152.233])
        by smtp.gmail.com with ESMTPSA id x1sm2162535ilg.33.2021.08.19.12.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:52:36 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
To:     Joe Perches <joe@perches.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
References: <20210818154646.925351-1-efremov@linux.com>
 <20210818154646.925351-2-efremov@linux.com>
 <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
 <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
 <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
Date:   Thu, 19 Aug 2021 22:52:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 8/19/21 12:22 AM, Joe Perches wrote:
> Hey Denis:
> 
> Try this one please and let me know what you think...

Looks good to me. Couple of nitpicks below

> 
> ---
>  scripts/checkpatch.pl | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 161ce7fe5d1e5..4e2e79eff9b8c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3196,26 +3196,21 @@ sub process {
>  				$orig_commit = lc($1);
>  			}
>  
> -			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
> -			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
> -			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
> -			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
> -				$orig_desc = $1;
> -				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
> -				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> -				$orig_desc = $1;
> -				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> -				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +			my $input = $line;
> +			for (my $n = 0; $n < 2; $n++) {
> +				$input .= " $rawlines[$linenr + $n]" if ($#lines >= $linenr + $n);
> +			}
> +
> +			$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{12,40}/i);
> +			$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
> +			$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
> +			$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> +			if ($input =~ /\bcommit\s+[0-9a-f]{5,}\s+($balanced_parens)/i) {
>  				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> -				$orig_desc .= " " . $1;
>  				$hasparens = 1;
> +				# Always strip leading/trailing parens then double quotes if existing
> +				$orig_desc = substr($orig_desc, 1, -1);
> +				$orig_desc = substr($orig_desc, 1, -1) if ($orig_desc =~ /^".*"$/);

Why do you want to add "if ($orig_desc =~ /^".*"$/);" here? and not just substr($orig_desc, 2, -2);?

>  			}
>  
>  			($id, $description) = git_commit_info($orig_commit,
> 

In your previous patch with '.*?' you added a branch to allow also newlines between commit and shas:
```
commit
c3f157259438 (Revert "floppy: reintroduce O_NDELAY fix")
```

Maybe something like this will work (adding a last word from a prevline if line doesn't start from
commit)
+                       my $input = $line;
                        if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
                                $init_char = $1;
                                $orig_commit = lc($2);
                        } elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
                                $orig_commit = lc($1);
+                               $prevline =~ /(\w+)$/;
+                               $line = $1 . " " . $prevline;
                        }
 
-                       my $input = $line;
                        for (my $n = 0; $n < 2; $n++) {
                                $input .= " $rawlines[$linenr + $n]" if ($#lines >= $linenr + $n);
                        }

Thanks,
Denis

