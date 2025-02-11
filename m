Return-Path: <linux-kselftest+bounces-26357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F7A30AD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2745816742B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207C1F8AC5;
	Tue, 11 Feb 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X8uSyxW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A21EEA38
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274849; cv=none; b=p7AODuxvNtIxxJgLsFVe1oK/3lmlq1xsUEvbsi+xhMpP1+aDj7cqOFrRqwq4BnAYrr/DbVhRry3vJdj4xToW4rJ+wPHg+8K3vQCLagYeyWFw6ZAp+pbDghfyPdnl4OVBsAPr1Oaqck5kWzL1PjiOincKHLheEatU5uqjbFVIJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274849; c=relaxed/simple;
	bh=6Ixr/Iz9cg/kpGR4bUS3PpptKq4G8rBcHbce+BMw9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fytErjXlvZ+SfOEnWC2swCW9GnS87OFlY2BydlfxKr4Z9TpTKiSlqgFy0yGXYomj6R2zzkJOkCm3Mz7zvPremn/vKiek7eB3pVQxpNWRR0n8/WB7DffMKDJqw/8ur2tz79uWOUrk6WdepIRS88G3rQOjWB1vuSNVXJvsu8Y7K8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X8uSyxW0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7d3bcf1ceso239415966b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739274845; x=1739879645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHJ87NPYDPDLaek3RFsgHptMV6mMcGDLkoSALf6A6ko=;
        b=X8uSyxW0tM27c77mniVHczafMv19I0WRxPHY/5hh1jfpIV0omAiR7V/n+C0K1YQCJC
         l6oUka2+htGR6PdqiMvLCOYMhvbRXI9qybB4BCs1qfLPReVZ326CDF0ifKyFAjbk09fe
         f1mqLXhD6TwXvdOOZvD+3dXgkW7ejvaL3x1alylFJJBCfU+cvv7gaPJK79yUDmI6w75J
         cDV9Uc2lf9fXQwJHRO9mPMqrlvTzwbVRHxev03Zr5BjtrOMR4el3j40S9VaKpzT70roM
         JKB25DIvdHOZNhgSuK8dfDZlWtJpwDwOQsL5v+laQNRlNeQm9yMo+MdOxtepgequRHdH
         SSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274845; x=1739879645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHJ87NPYDPDLaek3RFsgHptMV6mMcGDLkoSALf6A6ko=;
        b=p+Cl9N5mqJn5PIjUU1/AumYy/6WM/wv5WVnDLrVOQtevX+uDkRMwR4QDuOvBxOqJpj
         Fzu7DjiBk+k22TlgnvCkLYVadZlfFU2Q2Cwb4CJDFBDoX4qY/UwCQyjoTi/c1VDE0qER
         WL77B3qjpqhPpk0SHxJlNe5zXz066ipY0Y1u8yE4iUSmU/Xm8o2yZocvSY6EL1KqGRs2
         ziUCGDpYh6PjGziaIok9OXuyyQIHLHWImnpxImQSkpGiVzdn3gfivUvQnLvxgQl/6rdn
         ig0h07cosnmJ8QTSqEDD9UFBeDigbpTmVtqg3gGP4iU9H26GzqEKecLirVgvlZagDr9G
         1D6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5BPOmAp6m8n+O1WaXqDzLIO//c6YFgQGd01PF8GbFzrWgLD/QMHnUGBEKfVeLT09+WpVoJeHLQ9c6BWBLyvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHITKuIT4ll4mfnXOST0ptamIs3GLPFs3cVYhqnNBLENi8KOL
	6oPwWqEPin979NkHfn3W1Voj8OWuSS31rE+MThJG2OS2QapVysQxulOaw+TC0N8=
X-Gm-Gg: ASbGncul0GOmN+5yYCr3c8wRsdwEz5GXT1KvVtnKq2csdyH5IRpz5/RCqpAWwCS3etD
	MoqUHyClZZ+hhDRAniF0HFOolYH1PGxY4vE3WM+I04wUs/2Tzb7QO+RNR1BEUxUcOAewiUCSZW+
	xw1XTYDbXTisszRGR8vcg82IEFZwRox2lGtOZSUAw7baUF89q9OFVe6HnRTiWHyNN6KjW7jsSSO
	706PDDyaggLmst9ZpqQc6pt2ckUEQR2FdBDsl5hwHe6Y0dUWAwW9919yzoy7qUVc+xbXWg8tLYa
	I2m8r0054D3OXsqSow==
X-Google-Smtp-Source: AGHT+IGf9X+5WBi4CqkYDZ5Z8jxVZrKJeKOWY8YgCidV9FyxQjuAF8Kd3xsI0ECvN1KNe+PGd4RIZA==
X-Received: by 2002:a17:906:6a19:b0:aaf:1183:e9be with SMTP id a640c23a62f3a-ab7da33b958mr304407166b.2.1739274844926;
        Tue, 11 Feb 2025 03:54:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d101ed7dsm245193566b.106.2025.02.11.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:54:04 -0800 (PST)
Date: Tue, 11 Feb 2025 12:54:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/2] scanf: break kunit into test cases
Message-ID: <Z6s6WsIw3VCGys6K@pathway.suse.cz>
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-2-4d583d07f92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-scanf-kunit-convert-v6-2-4d583d07f92d@gmail.com>

On Mon 2025-02-10 13:13:49, Tamir Duberstein wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.

Hmm, simulate the following failure in the original test module:


diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 44f8508c9d88..3ec12328cc4c 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -564,7 +564,7 @@ static void __init numbers_list_field_width_val_h(const char *delim)
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
 	numbers_list_val_width(short,		"%hd",	     delim, "hi", check_short);
-	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_ushort);
+	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_uint);
 	numbers_list_val_width(unsigned short,	"0x%hx",     delim, "hx", check_ushort);
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }

and I got:


[  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959881
[  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
[  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%4hx,%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
[  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%1hx-%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
[  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
[  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936
[  383.106398] test_scanf: failed 6 out of 2545 tests


When I tried to do the same in the new module:

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index e45f3c4f0437..692eb8cbbeab 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -546,7 +546,7 @@ static void numbers_list_field_width_val_h(struct kunit *test, const char *delim
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
 	numbers_list_val_width(short,		"%hd",	     delim, "hi", check_short);
-	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_ushort);
+	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_uint);
 	numbers_list_val_width(unsigned short,	"0x%hx",     delim, "hx", check_ushort);
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }

then I got:

[ 6625.895391] KTAP version 1
[ 6625.895928] 1..1
[ 6625.896494]     KTAP version 1
[ 6625.896852]     # Subtest: scanf
[ 6625.897191]     # module: scanf_kunit
[ 6625.897198]     1..10
[ 6625.903479]     ok 1 numbers_simple
[ 6625.903490]         KTAP version 1
[ 6625.904352]         # Subtest: numbers_list
[ 6625.905623]         ok 1 " "
[ 6625.907654]         ok 2 ":"
[ 6625.909654]         ok 3 ","
[ 6625.911564]         ok 4 "-"
[ 6625.913632]         ok 5 "/"
[ 6625.914020]     # numbers_list: pass:5 fail:0 skip:0 total:5
[ 6625.914370]     ok 2 numbers_list
[ 6625.914964]         KTAP version 1
[ 6625.915871]         # Subtest: numbers_list_field_width_typemax
[ 6625.917527]         ok 1 " "
[ 6625.919366]         ok 2 ":"
[ 6625.921586]         ok 3 ","
[ 6625.923240]         ok 4 "-"
[ 6625.925226]         ok 5 "/"
[ 6625.925622]     # numbers_list_field_width_typemax: pass:5 fail:0 skip:0 total:5
[ 6625.925973]     ok 3 numbers_list_field_width_typemax
[ 6625.926709]         KTAP version 1
[ 6625.927613]         # Subtest: numbers_list_field_width_val_width
[ 6625.928546]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1044578334 (0x3e43001e)
                       *pval == 837828163 (0x31f03e43)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.929225]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 837828163 (0x31f03e43)
                       *pval == 0 (0x0)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.932202]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 12784 (0x31f0)
                       *pval == 2624608151 (0x9c705797)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.934982]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 0 (0x0)
                       *pval == 1966080 (0x1e0000)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.935004]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1469513728 (0x57970000)
                       *pval == 837828163 (0x31f03e43)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.935025]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 2624608151 (0x9c705797)
                       *pval == 0 (0x0)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.935046]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 469802096 (0x1c009c70)
                       *pval == 2624608151 (0x9c705797)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
[ 6625.938161]         not ok 1 " "
[ 6625.952074]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 131073 (0x20001)
                       *pval == 65538 (0x10002)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.952098]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 65538 (0x10002)
                       *pval == 1038822 (0xfd9e6)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.952121]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3655729153 (0xd9e60001)
                       *pval == 3848735038 (0xe567093e)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.952143]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1038822 (0xfd9e6)
                       *pval == 65542 (0x10006)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.960548]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 155058191 (0x93e000f)
                       *pval == 65538 (0x10002)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.960579]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3848735038 (0xe567093e)
                       *pval == 1038822 (0xfd9e6)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.960604]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 50390375 (0x300e567)
                       *pval == 3848735038 (0xe567093e)
               vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...)
[ 6625.969351]         not ok 2 ":"
[ 6625.969860]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3589275648 (0xd5f00000)
                       *pval == 3768047088 (0xe097d5f0)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.972121]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3768047088 (0xe097d5f0)
                       *pval == 878575619 (0x345e0003)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.972139]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 254103 (0x3e097)
                       *pval == 2832859455 (0xa8da013f)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.976800]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 878575619 (0x345e0003)
                       *pval == 0 (0x0)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.976819]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 20919390 (0x13f345e)
                       *pval == 3768047088 (0xe097d5f0)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.976836]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 2832859455 (0xa8da013f)
                       *pval == 878575619 (0x345e0003)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.976853]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3691030746 (0xdc00a8da)
                       *pval == 2832859455 (0xa8da013f)
               vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%4hx,%1hx,%4hx,%3hx,%4hx", ...)
[ 6625.979505]         not ok 3 ","
[ 6625.989303]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1475084289 (0x57ec0001)
                       *pval == 3243268076 (0xc15057ec)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.989324]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3243268076 (0xc15057ec)
                       *pval == 21 (0x15)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.989343]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1425744 (0x15c150)
                       *pval == 786439 (0xc0007)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.994177]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 21 (0x15)
                       *pval == 65537 (0x10001)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.994196]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 458752 (0x70000)
                       *pval == 3243268076 (0xc15057ec)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.994214]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 786439 (0xc0007)
                       *pval == 21 (0x15)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6625.994232]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3858759692 (0xe600000c)
                       *pval == 786439 (0xc0007)
               vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2hx-%1hx-%1hx-%1hx", ...)
[ 6626.003487]         not ok 4 "-"
[ 6626.004021]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 3901554741 (0xe88d0035)
                       *pval == 125069 (0x1e88d)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.006206]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 125069 (0x1e88d)
                       *pval == 1821114368 (0x6c8c0000)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.006226]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1 (0x1)
                       *pval == 65543 (0x10007)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.006243]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1821114368 (0x6c8c0000)
                       *pval == 3502806 (0x3572d6)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.006261]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 486540 (0x76c8c)
                       *pval == 125069 (0x1e88d)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.015404]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 65543 (0x10007)
                       *pval == 1821114368 (0x6c8c0000)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.015423]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1828716545 (0x6d000001)
                       *pval == 65543 (0x10007)
               vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...)
[ 6626.018041]         not ok 5 "/"
[ 6626.022529]     # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 total:5
[ 6626.022535]     not ok 4 numbers_list_field_width_val_width
[ 6626.023220]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 106936 (0x1a1b8)
                       *pval == 571539457 (0x22110001)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024017]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 571539457 (0x22110001)
                       *pval == 81562 (0x13e9a)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024035]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1050288657 (0x3e9a2211)
                       *pval == 91449567 (0x57368df)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024053]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 81562 (0x13e9a)
                       *pval == 2713242046 (0xa1b8c9be)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024073]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1759444993 (0x68df0001)
                       *pval == 571539457 (0x22110001)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024091]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 91449567 (0x57368df)
                       *pval == 81562 (0x13e9a)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.024108]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1107297651 (0x42000573)
                       *pval == 91449567 (0x57368df)
               vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...)
[ 6626.026607]     not ok 5 numbers_slice
[ 6626.039801]     ok 6 numbers_prefix_overflow
[ 6626.040522]     ok 7 test_simple_strtoull
[ 6626.041433]     ok 8 test_simple_strtoll
[ 6626.042409]     ok 9 test_simple_strtoul
[ 6626.043153]     ok 10 test_simple_strtol
[ 6626.043161] # scanf: pass:8 fail:2 skip:0 total:10
[ 6626.043166] # Totals: pass:16 fail:6 skip:0 total:22
[ 6626.043170] not ok 1 scanf


I like that the log better points to the test:

[ 6625.927613]         # Subtest: numbers_list_field_width_val_width

But

[ 6625.928546]     # numbers_list_field_width_val_width: EXPECTATION FAILED at lib/scanf_kunit.c:91
                   Expected got == *pval, but
                       got == 1044578334 (0x3e43001e)
                       *pval == 837828163 (0x31f03e43)
               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)

is much harder to parse than the original

[  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959881


Also I wonder why the scanned string is different:

               vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
vs.

[  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959881
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I would expect that the 1st error would be on the same string
in both tests. I wonder why it differs.

Best Regards,
Petr

