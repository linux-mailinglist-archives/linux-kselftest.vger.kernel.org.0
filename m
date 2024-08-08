Return-Path: <linux-kselftest+bounces-15045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2694C596
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537001C20C30
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8F15665D;
	Thu,  8 Aug 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcFcxTCw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA86155A5B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148424; cv=none; b=OFb1iiHrpvup1PO0fc0ibI2s/fqTCkEJkpEsKwuEYueRqxI9q3QJSMwrmKbHwhvmlc6UuSzuSZORSiALYbjG3jYuj5DVS/Oi4JQg41laU3Pqv0eBloqNpgUOf+XQbMTxnWImk6BFOpOyNNKLOT2KBShMN4VxeTU8phsnPLP1yPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148424; c=relaxed/simple;
	bh=I8tXjScfs6SfIGBVAqBjUPUpXxLI8X5aEotWs/mSdR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtDcvoLPLdpqWzF3n4NmOueym6dYdEbJvEGMWPZB7kG0vVIonVA0nMhcq668gB/WGN0S4Wr079N7iccR8Yov9MRQLN1XCm4rFFbofEzhpDqv50LmMx+QGhFv6rKElV3EoqTUWRZeIhzpTLoCosfXxsIlsVjpgqf4vbkjQ8PXx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcFcxTCw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f8d55c087so5227339f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2024 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723148422; x=1723753222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfQLxAkKJO0OxN3PoS9gfcknEgVgOQSzt4mX6LsWfm0=;
        b=PcFcxTCwrhV66d4QWXs78cB/g8PLFxqohmvRsKq2yvWs5ANyMMfScdXdr6Gm5uKzQl
         qwN8ADwovIu3wuNKzlZQhTMt1ypJ8O3YCKHbRVe0m6o4VSYVBiGkmfq4o0DYGMva5/er
         baOinfv0LhQvvQpMdNlWfhzqzxoYtjJJyJXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148422; x=1723753222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfQLxAkKJO0OxN3PoS9gfcknEgVgOQSzt4mX6LsWfm0=;
        b=eWCSPb+79cMo9SHsM3oDJgP4F62WCrlcaJgkPDaWrQf83HfB5V16G8cCFrA75x77ir
         lgnCbOJ1ziWjXryTbN+4PorNzKmJSk52mPvQhY6dHGbyZK2s/FbHvc9yK0mSq41vav3a
         Ycodge0Pbtj6SVsZuDxC+dm/917k3IsiIX/xje7qs5+EwmNHglooRqPcuxCFQfZcMZvr
         sBh0QgHrxL2/VOuhkDmuAheeh0Fh9h7aQbWIhIJ81WcvUKe3tmXzj6xXjSOjc3W7Ijen
         8fH+9s6JFtmPrLukXg+8bs3KieXX++d1Ld/0G+j7VYiQeyNBPaB2b7GBqz78Pl8W4vIJ
         a7rA==
X-Forwarded-Encrypted: i=1; AJvYcCX1iXBAkodZA0pb3j1MKEg9VPNOWq4r9FnUe6RzPMeG2/yHZ0jkKIdl6dktBcQSppINLWGC/ry9SSwG/YcPDKXq5L08/gUcO+D4y+RrWAhe
X-Gm-Message-State: AOJu0YwEDx0DywzePo/JnQEvOI/Vfxr3Q1YWH8Tn13/WhTOAIRFlxUZ+
	2sBnI099036To033wgxpU95MMnqrqI8FxJHV7nc0SkXr1w366+Y+0AAaEomoS2g=
X-Google-Smtp-Source: AGHT+IFz2Q8BNZhb/hkrGYq+MEEYJykLer5kY5z3ptVsISOpOwy8Tnb8XprZ34ZhF4rcXiEOjQWgxA==
X-Received: by 2002:a05:6e02:1aa2:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39b5ec71b5amr23752905ab.1.1723148422046;
        Thu, 08 Aug 2024 13:20:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ae34d0sm56676835ab.56.2024.08.08.13.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:20:21 -0700 (PDT)
Message-ID: <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
Date: Thu, 8 Aug 2024 14:20:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808145639.GA20510@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240808145639.GA20510@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 08:57, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> to the directory in which the executables reside, which is supposedly
> the desired behaviour.
> 
> Discovered by the check-rpaths script[1][2] that checks for insecure
> RPATH/RUNPATH[3], such as relative directories, during an attempt
> to package BPF selftests for later use in CI:
> 
>      ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]
> 
> [1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
> [2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
> [3] https://cwe.mitre.org/data/definitions/426.html
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/alsa/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index c1ce39874e2b..0f204da9ea8e 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -6,7 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
>   ifeq ($(LDLIBS),)
>   LDLIBS += -lasound
>   endif
> -CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
> +CFLAGS += -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/
>   
>   LDLIBS+=-lpthread
>   

Wouldn't make sense to fix fix this in selftests main Makefile
instead of changing the all the test makefiles

Same comment on all other files. It would be easier to send
these as series - please mentioned the tests run as well
after this change.

thanks,
-- Shuah



