Return-Path: <linux-kselftest+bounces-5227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E883185E8B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F61CB28BB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5C127B57;
	Wed, 21 Feb 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLAOop5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F08663F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545734; cv=none; b=Gx6BYJVLU1H8Y/Xf6cSFJtQ9VRgptLBnxrsdJnD8RNCWHb2TSS5VIZH3UfVGaL/ja+PbKUxdST00TItpR0RZhFlPI45S8PAj8quBoMkQpIAl8DHvNoC5DLaasUFXMH6u5OTxkQXwPOC4jMQtTCG2hUVmfwoQmHfKCGvCGCh4smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545734; c=relaxed/simple;
	bh=b48lXPZQ+02Q0x3yLHzWYedk9fLZtBBvGY00YBRj8DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkNY8oWLDNmErPE2ccvQNRbP5HCf+bYZogpUeAaMvVTYdVT99cQZtPRqL56wicfdWE0LW+gGZBR9g/knqN1Mpi3hUZBvaOMf+7DofZ0+j5mIzl3mcWT3yOsYFnTW+2ZaN5nvgIsO2j/qCabSo631p8IG5z4+dCDsmJiS7+y7EDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLAOop5P; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7beda6a274bso41470539f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708545731; x=1709150531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hW/eD+217SwbFSrd+7OlcqgqqQaX2xcDsJgsLrnW3ms=;
        b=bLAOop5PY9nIMWtJBK0X4o+9ohSJFVebjUsn5fEj/Pbi+RE3nBNv6UFiiGyj6gA4VP
         pw/74OJosTSnESt4IkCbHrL0tmvqRKVB5IvGRf9Nm8/XA8ByA7rBWnFCW/e+zoGfCNra
         gqu3oc9ctgVEHwA5BAptS2Br5zo13+P6//I5mQS6ApOiXciEAiNr5iQXdGMvSak2iFqq
         xzAmtlZRJx5Yd6RPxRa5QN45nmqIt7wH9SBhG7NwCB8v87ZmeCSNwvAarFSFN7cr4nOC
         6VSfgJLNSN2sTx5EDAcjRtb4F1wjF04ac1lIpq+fCMpOA/TZVcInz0aPFxfP6sNTsMUX
         GnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708545731; x=1709150531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW/eD+217SwbFSrd+7OlcqgqqQaX2xcDsJgsLrnW3ms=;
        b=Sv/BRA+Sc2lNBYTvQ5gE8v9VtYgKjXT3yFjIlEA0Yf9dhUUluzEapBX2rtUeBVxQ3V
         3JOYH03DvlOHthy8HSBnJYXIe6D+nvYMmBUFPltwQHl2/AF0m4Of5GG7yRcGEYQni8UE
         1FuPpTCVwYQsxsHxSaEwJWyDoWWBp2whBVggascthJOtP7IWq2iHvFZSMq1UUsaOdhqx
         Mc61WSUWFPaSkhWhxCBeOB5HLlZNdUCMUUR/9EbV25OQwnBMJMA9kTB5G4Q+Y2odmNR6
         yyG4Vrvan4Iy1rwfVecsVfhtlRV0FglIzLHUPfSKLpAn1ef+bs8KhcpPFPoa/YHlwt29
         vToA==
X-Forwarded-Encrypted: i=1; AJvYcCXzlPr4SL2/it0lWRTgZnB+9vHyVOBUjk7CZr9v6pE9GupivH7xF5UxQ3bE2bIfG7ChweEpnRnuah1cFWbQca67/vazy4A70RYi1q8BAZ8m
X-Gm-Message-State: AOJu0YxsGgkmOaD5f5fsuKiKtnhhqBrIUkO0/hKhoFYZ7N4bdTTXmbUm
	t0DtS3qCYTOke16gKuU8PzIbakTt8id2lypVIRFtsa4mVrGD6oXoapCVoYp69Q==
X-Google-Smtp-Source: AGHT+IG39BbcKPU1il8vkTs2a8eXqdOP0Ld0XjhZHI7TKaGTsFOA7fu8B9CXr669y5rm4dsiJ0Wmbg==
X-Received: by 2002:a5d:929a:0:b0:7c7:4d7e:de87 with SMTP id s26-20020a5d929a000000b007c74d7ede87mr10763875iom.1.1708545731187;
        Wed, 21 Feb 2024 12:02:11 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id fv5-20020a05663866c500b004741f7683ebsm2243287jab.154.2024.02.21.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:02:10 -0800 (PST)
Date: Wed, 21 Feb 2024 20:02:04 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] kunit: Annotate _MSG assertion variants with gnu
 printf specifiers
Message-ID: <20240221200204.frzov7n5bxb4cekd@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-10-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-10-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:22PM +0800, David Gow wrote:
> KUnit's assertion macros have variants which accept a printf format
> string, to allow tests to specify a more detailed message on failure.
> These (and the related KUNIT_FAIL() macro) ultimately wrap the
> __kunit_do_failed_assertion() function, which accepted a printf format
> specifier, but did not have the __printf attribute, so gcc couldn't warn
> on incorrect agruments.
>
> It turns out there were quite a few tests with such incorrect arguments.
>
> Add the __printf() specifier now that we've fixed these errors, to
> prevent them from recurring.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  include/kunit/test.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index fcb4a4940ace..61637ef32302 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -579,12 +579,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>
>  void __noreturn __kunit_abort(struct kunit *test);
>
> -void __kunit_do_failed_assertion(struct kunit *test,
> -			       const struct kunit_loc *loc,
> -			       enum kunit_assert_type type,
> -			       const struct kunit_assert *assert,
> -			       assert_format_t assert_format,
> -			       const char *fmt, ...);
> +void __printf(6, 7) __kunit_do_failed_assertion(struct kunit *test,
> +						const struct kunit_loc *loc,
> +						enum kunit_assert_type type,
> +						const struct kunit_assert *assert,
> +						assert_format_t assert_format,
> +						const char *fmt, ...);
>
>  #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
>  	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin

