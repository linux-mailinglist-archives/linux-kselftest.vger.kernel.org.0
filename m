Return-Path: <linux-kselftest+bounces-34342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E29ACE6A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBF13A8F3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B520E005;
	Wed,  4 Jun 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgaG+D8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100E10E9;
	Wed,  4 Jun 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076545; cv=none; b=a+xGQYCuzeL+dGu95QCbthYQZPBoRX+glEwMoRZhsqX4d0iffaDHSJsTJ8S45frAY+N/DBTCbP5/QAgoZb9bNmX+w8T+gqCPiCbkpdkd/WLN/n9ASK1oaxqJ1mcguN6+vxfPamkLaZCGDcgC3/fLnj0Ps+qfWWhtxMAkQBKgUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076545; c=relaxed/simple;
	bh=8ltgHvPktIGvd828kCWmlW2E8Mj9LPG0Na5cHECVRK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7Sou9lNWUlt8BnTuzt0f917lRTf4otu566SV9WmlHQb7ZN28sdqator6PWVcDURyOqsLiT2DqsS8MMKaP/M6Fzbf2rC9wDi7L2HqcRnW3v2emNn2jabUTBZsu3EfyQs8lqYVfKSzfTpl9RKXi+KVzEXbtMpaRgzT15o/onDcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgaG+D8/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a366843fa6so182242f8f.1;
        Wed, 04 Jun 2025 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749076542; x=1749681342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsxuIdbiBj+7yBzMpSX2Y7tbBVv3OjmpCi4ReJWvjY4=;
        b=fgaG+D8/Eu/pv54xN6EeNHjiYwZbJG+9rgeJW3HuTwkEdBvUfIC+Kpm2GIK7l/94TE
         4Q4RYkjiBffvAMT3So0CEmfQdlgkX7zO/PEUMm5ZsquWLEoJv1i22pLpt1ZeKxx93sRU
         Q7+3Dvn9XhVlVvaf8x785BEGKJt9IAgrJJ0MQ1CShoRm7Vr/AhFPiZWiTpLnSXyD+6vp
         GPKjD2u+sdoMAcRDK7KgnZnZJcJlsKtIlQwVklbyfVXnMYT99Wtd7LaeJogKScsoleM1
         zV8igKz35Zi04q3vcjmNWaujssHtFc49RRRXl5HmqdLViZqBh4Umj0vjs5H54u64M21B
         5AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749076542; x=1749681342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsxuIdbiBj+7yBzMpSX2Y7tbBVv3OjmpCi4ReJWvjY4=;
        b=XFBiL/Bh4gjhfezye9VfKO0RKpdyCUKVFHxZaPOVkqteNPSlp4Z8PhUgj8qWPgRNBN
         PDY5v9OkDvV4jOnJPuxrQjpBtfThMfVqLR+MzY4lnU+DCA6B75dcm1eQzN3Sjt9cHdjk
         LTZu3VHvpOHEuHhN/mbZiZoqGq6Tm0J308HskdFNmiYgHjtEadNjQX7zT41y/4h9Dw5s
         A3PY7rQY32e7IPYabVRt2+lfz8P7MSrO7f2cubE+zEtfvbOLUBXllnGUNg9AhgPpdfWW
         Jfc+CE02BdLTbdMwAdQ66dSsJCHb8TiPF9+6Mt4FuBwalIYheDqpK/QLEEoAFPB7UjKN
         gE1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpZuhhdwZsWcr+rWKtTWdSJmqwpoSdzs40uFnAd/XQ8ibRb7wcfR9KJFY5AfoDWpOpfMIfoYrKy466OojMJhSA@vger.kernel.org, AJvYcCWIN268+iQquSuyU/z5zmkYN9O4OZ5zNL+hmikWBJ9VzZWG75N01REZvi4id9NL1bzfJN9MfROq6StQFOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByKtHj2CQxpSGuzZJyF66K11uFyEYDV3vbWDgV1kfV/UpGSYc
	gJK35GBLmA5CjXMSsf5pQg3bB02H7erDZY4i3tmH2fgrPXsCh3795wdefGnpJA==
X-Gm-Gg: ASbGncvBcygU4WWQxvXCfF82lPP+UydoVH0XSPbjzRwLMYV3udO4gsjcpG6rwOB2GpT
	0twFIGI3zAzTKPi70MMeKgAZKC6/TGKauQy1HTPRfrIxpjwFy85Lb599Fj3te+sSivzNTRPliam
	Je/Wr6T48UttTAcZKi3jtTJigPYkesW1gkdK2EeqW/VZjfrflYr6veRoRJaqcXayaEcmPGy0bf3
	k+BYNy8rL72z7u6iXxBgE966cTHTbucLSH/0/Z226eOyRwCv5ndINVeqpY6rKA42mgAVxlRsEgC
	61OdBX3064Gm57+Baf6aWwxUZbJ47h8zq9KHFSEcKgWZRXbdocXJhWwa5OCNKH+WoGM=
X-Google-Smtp-Source: AGHT+IGEcHI3RKpGrEdI8XRlMdKJaExfTVUZGwbopS+GoA+PBaW44CIH9k3dDaDSNYUTDJCDoEh9DA==
X-Received: by 2002:a5d:584c:0:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3a51d985961mr3683521f8f.49.1749076542052;
        Wed, 04 Jun 2025 15:35:42 -0700 (PDT)
Received: from [192.168.1.5] ([197.63.202.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f83sm22159582f8f.49.2025.06.04.15.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 15:35:40 -0700 (PDT)
Message-ID: <959cfd37-1f27-4e2e-8922-19eb72227e28@gmail.com>
Date: Thu, 5 Jun 2025 01:35:38 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/mm/run_vmtests.sh: skip hugevm tests if
 write_to_hugetlbfs is missing
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
 <20250602232233.224099-1-khaledelnaggarlinux@gmail.com>
 <20250602191216.7173b77e4f9ab5f659d1a448@linux-foundation.org>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250602191216.7173b77e4f9ab5f659d1a448@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2025 5:12 am, Andrew Morton wrote:
> On Tue,  3 Jun 2025 02:22:32 +0300 Khaled Elnaggar <khaledelnaggarlinux@gmail.com> wrote:
> 
>> The hugevm tests 'charge_reserved_hugetlb.sh' and 'hugetlb_reparenting_test.sh'
>> depend on the 'write_to_hugetlbfs' binary to simulate writes to hugetlbfs
>> while checking reservations asynchronously in the background.
>>
>> When this binary is missing (e.g., excluded from the build), these tests hang
>> for up to 180 seconds. During this time, run_vmtests.sh is eventually killed
>> due to timeout, aborting all subsequent tests.
>>
>> This patch skips these tests if the binary is not found, preventing delays
>> and ensuring that the test suite runs to completion.
> 
> OK, but why is write_to_hugetlbfs missing?  If we're in a situation
> where we _could_ run it then we _should_ run it!  The user wants to
> test stuff so we should test as much as we can.
> So I'm thinking that it would be preferable to make sure the dang thing
> is there?
> 

Totally agree, let me try to explain how I understand the issue.

The write_to_hugetlbfs binary is built from selftests/mm/Makefile,
lines 136–142. It is only compiled if ARCH matches one of the explicitly
listed 64-bit architectures:


```
   ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
   TEST_GEN_FILES += va_high_addr_switch
   ifneq ($(ARCH),riscv64)
   TEST_GEN_FILES += virtual_address_range
   endif
   TEST_GEN_FILES += write_to_hugetlbfs
   endif
```

However, when the MM selftests are run from the kernel’s top-level Makefile,
(root directory for example:

  make defconfig
  sudo make kselftest TARGETS=mm


ARCH is resolved as x86, even on an x86_64 machine (Debian in my case),
ARCH=x86 is the reason why the binary gets excluded from the build system.

As far as I understand, the top-level Makefile normalizes both
i.86 and x86_64 to x86 for ARCH variable:

Makfile: lines: 383,403
        383:include $(srctree)/scripts/subarch.include
        403:ARCH                ?= $(SUBARCH)

scripts/subarch.include: line: 7
        7:SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \

This mapping probably makes sense for selecting the correct arch/ directory
(since we have arch/x86, not arch/x86_64) for top-level Makefile.

But the mm selftests Makefile expects ARCH to differentiate between x86 and x86_64
to decide whether to build certain binaries.
As a result, the 64-bit-only binaries like write_to_hugetlbfs are skipped
during build, yet still expected at runtime (by run_vmtests.sh).

That's why this whole issue of the missing executable does not happen when
ran from selftests/mm using something like:

  sudo make -C tools/testing/selftests/mm

Because then selftests/mm/Makefile arch detection rus as intended.

You're right — the proper fix is to improve how we propagate architecture
information from the top-level Makefile to selftests.
But since that's a larger change (and possibly beyond what I can safely
attempt at this point), this patch is just a targeted workaround to
avoid test stalls when the binary is missing.

I hope I haven't gone completely wrong with this analysis, happy to improve
or revise it further if needed.


