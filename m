Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D299F29C9BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830924AbgJ0UIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 16:08:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33981 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504558AbgJ0UIf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 16:08:35 -0400
Received: by mail-io1-f65.google.com with SMTP id z5so2954940iob.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4HIc/0MR2zHvdieD9zh6vgSLY8pbQbGIFImMryqW80s=;
        b=PPPa3tmp2ks9hMD+/SvUol0Jx+R7oBCr+e32JI5nCuiG5v1h2ucr/FqTIkj9xsqVMk
         82ZR0Ou9cOuG1rkvlK/33AXrWcAmuXcDoj7+Ax3tfPhEd4XOPHUE2JgiVGcHG2kAVp07
         zvMESFRR7oZiOKXo8KvZpW4q9iZ9AgHen6rdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HIc/0MR2zHvdieD9zh6vgSLY8pbQbGIFImMryqW80s=;
        b=kCY+Dytnpva12IBUCtaLMFqXS2+WOjSDIwRbdwC85OkTrwfLsyXT0CTgtXP5Mu1d7B
         00UpdlhjBmZdffYp1hfgQMDfYZXAmQrlk24XnGh4YS7ho4PXa5BHAmWaCisFOPuipNm9
         rVVi23FYmQ7u2J5S62gFUlcyvirTsCO++nsW6Op/lV6R0shhT8lbn+d1c4IvYUSVjILS
         9v0SkdR3OK3lKH+SASVWt9wmjW/ZC4PsiWNhErs83tNxDkfLLSNA09RxNUsAfxz9KjJc
         Wvq4bziouYtOvPOPoTyIog1zZFanGfGFoDzQksH3LAcB54B3ETXeBXxCMahN06bzs72p
         JBOQ==
X-Gm-Message-State: AOAM5302EbXkmlVUkfCzL/OjjldkkOde5W4m0P+k9vMsqKy/Mlu/BN00
        OIKN6Ixgzezistp9e0G4TathF2ndMG9zCw==
X-Google-Smtp-Source: ABdhPJxEnhHXp/fd89iC17rp6whQwz7mY2Q1l1AjQHbSPGMfQBiuPwlJgoZQ8cCXi+zUMR++RBiyyw==
X-Received: by 2002:a6b:cf18:: with SMTP id o24mr3595316ioa.57.1603829313981;
        Tue, 27 Oct 2020 13:08:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r14sm1456512ilc.78.2020.10.27.13.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:08:33 -0700 (PDT)
Subject: Re: [PATCH] selftests: intel_pstate: ftime() is deprecated
To:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d315994a-3398-be41-1b26-e78f8359aa5c@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 14:08:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tommi,

On 10/16/20 7:22 AM, Tommi Rantala wrote:
> Use clock_gettime() instead of deprecated ftime().
> 
>    aperf.c: In function ‘main’:
>    aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-declarations]
>       58 |  ftime(&before);
>          |  ^~~~~
>    In file included from aperf.c:9:
>    /usr/include/sys/timeb.h:39:12: note: declared here
>       39 | extern int ftime (struct timeb *__timebuf)
>          |            ^~~~~
> 

Thanks for the fix. One comment below

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>   tools/testing/selftests/intel_pstate/aperf.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
> index f6cd03a87493..eea9dbab459b 100644
> --- a/tools/testing/selftests/intel_pstate/aperf.c
> +++ b/tools/testing/selftests/intel_pstate/aperf.c
> @@ -10,6 +10,7 @@
>   #include <sched.h>
>   #include <errno.h>
>   #include <string.h>
> +#include <time.h>
>   #include "../kselftest.h"
>   
>   void usage(char *name) {
> @@ -22,7 +23,7 @@ int main(int argc, char **argv) {
>   	long long tsc, old_tsc, new_tsc;
>   	long long aperf, old_aperf, new_aperf;
>   	long long mperf, old_mperf, new_mperf;
> -	struct timeb before, after;
> +	struct timespec before, after;
>   	long long int start, finish, total;
>   	cpu_set_t cpuset;
>   
> @@ -55,7 +56,10 @@ int main(int argc, char **argv) {
>   		return 1;
>   	}
>   
> -	ftime(&before);
> +	if (clock_gettime(CLOCK_MONOTONIC, &before) < 0) {
> +		perror("clock_gettime");
> +		return 1;
> +	}
>   	pread(fd, &old_tsc,  sizeof(old_tsc), 0x10);
>   	pread(fd, &old_aperf,  sizeof(old_mperf), 0xe7);
>   	pread(fd, &old_mperf,  sizeof(old_aperf), 0xe8);
> @@ -64,7 +68,10 @@ int main(int argc, char **argv) {
>   		sqrt(i);
>   	}
>   
> -	ftime(&after);
> +	if (clock_gettime(CLOCK_MONOTONIC, &after) < 0) {
> +		perror("clock_gettime");
> +		return 1;
> +	}
>   	pread(fd, &new_tsc,  sizeof(new_tsc), 0x10);
>   	pread(fd, &new_aperf,  sizeof(new_mperf), 0xe7);
>   	pread(fd, &new_mperf,  sizeof(new_aperf), 0xe8);
> @@ -73,8 +80,8 @@ int main(int argc, char **argv) {
>   	aperf = new_aperf-old_aperf;
>   	mperf = new_mperf-old_mperf;
>   
> -	start = before.time*1000 + before.millitm;
> -	finish = after.time*1000 + after.millitm;
> +	start = before.tv_sec*1000 + before.tv_nsec/1000000L;
> +	finish = after.tv_sec*1000 + after.tv_nsec/1000000L;

Why not use timespec dNSEC_PER_MSEC define from  include/vdso/time64.h?

thanks,
-- Shuah

