Return-Path: <linux-kselftest+bounces-43127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB007BD9614
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD23545FC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEF31282E;
	Tue, 14 Oct 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbEmLxNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E62D4B5E
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445580; cv=none; b=trLj2JO+k78LJ51vIlA6nN9LRiqi2NqNXR7DS5wChU1dPnx0yNEr/GpL8y3W4WjSwvZqsUzz7Ul/ogrbaBYus0PSnno7POHA38OG169JIZ6icoOL0seGltG2kjyhoSod+oD0qqXTTIKUuXuEh2vJlABFQ0VoRN7Rn4I0/uFfLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445580; c=relaxed/simple;
	bh=Nh8d18yC3F1kVol5wJ2x8b4hEbrylXUjjaWq7mzK5pU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3PVxNIE1h+kEDdA8KRkDlTSXA0fIAzyY4I3EZs0WrQBHf70vX4oOZxFuNu1vD+k09RpQ843zyAZxz7yZUjAeoXBbsR4nMsyciEilXF/kr+vr7PrXcauTFxtZukphuL29l6tQIF+z1MziwDB5Vt12+CrT3aF0hBxNMAKNCGLDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbEmLxNY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b54f55a290cso743706666b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445576; x=1761050376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOKsSRK0fMY53Nno3tXGDrP+nfAG/MScFpySFc8rN2Q=;
        b=WbEmLxNYEeVpBmJQNFGLvmO8pi3NWaNjeh6F6rAwtXlkmC5Zq0y8HvuxTu72loa3Qk
         0DPqZHspoSktweJ5z4WdeAOZO7kqV9gEE4vt/fJyhAL/yIkWd0fnkPp+TqSaqlRh08Xp
         f1cSecJ53U1r5nHoE7cJ2OFKWeCv0184VJ73HAO6ySVdd6V9jWy67k4oJqMk0brNpFHU
         LgUy44vgJFjCkUdFZm3HUWrbYAAHsDPOoFtazbJcRe5w6P8miNArs3IYwkLSUiXbH86+
         EC+Yd3cjwYO1/d05ixrBm2l6q/dSuBrY1EAdOt15gOoPPQBKl22FW8Xl66QJtxeDvYqb
         nnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445576; x=1761050376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOKsSRK0fMY53Nno3tXGDrP+nfAG/MScFpySFc8rN2Q=;
        b=gQKZKCr7ZzN7Urg8GYUsNcTlJMD6QvaIuRFeHBKyCmBsDDOEeKvXQ5i27NB9wRmVze
         ZX7f6HpFb+pMRgaMN1lXNDkOC1Cj0fBTpJD2nMOxz/bRMHtX1h5B5nF8NobXdTH+PoPG
         87M2xpekkHJGWRHwwV27j1b+8wUQyW/ld6U/p4PCdeiQxfkantWt4uXFkl7ww3AERRZl
         ANQIvqMmdAvDk5Kd9jTC/1rgI2tcmJjXJphseKFPh+4fsKTaxJNTBQ8Qmzbna3jZQJQL
         NVnSpsKXr4j3GGnsGvGyxfe2NBQeh+lVmu4+PbEhmYAufO2LPvpGJYlUPo19A3ukvDKH
         bjEA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJtiQu+nh2JMb+kUAtKEDNIQTlbupUQ0l/aW9BMTaA5yQg2NXNIE9+SGxTD60Alv2rpdYgeX6YrIjAjxaAUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVjlcDAK4NChn3jcNUZpKadZj27xnOoyIUVsegIVdoZQBqHmK
	5wHFjLPEGO+UJ0IpOW9LIwfcxtO+jTYgKePgK708upxTEyjP7m+i9HEb
X-Gm-Gg: ASbGncsdPoa5JGzANqcvG2ZFQEeVYh9mUQpEL23/6sAU+V/uEF9u4byp2RlkDSmfQxv
	803BLZIQtMCZpRmCplTp3td0tJRC7FvhZxyCNqSwE/RUEK7pot/A3PsVXxUDe6xeUV3wX8ppu+i
	tvrA/zNwj7spBysehw3kAmsrJUk8V06FPXR/O1RTFVLujUnmnuWOVYQ+UhjQzktMR76L3Vgc0Jq
	lB4chSl2zfUC9eNQnJBDZ0h5aaQVnvXUtFWAwPyeyo98ycHczHNZsse32yoVCmjGZrw0dQPi3uI
	aJxhr9uVJkH09qCcXExfbTM/pIDx7AR+lUoWNbNwQhK7DgC2LcddIhdubZrSMCf2UAEL8W3xGaJ
	lM1TP5D+RIP0JBxI=
X-Google-Smtp-Source: AGHT+IF+gfoV6etSNY7UeTP7Wc3+ofAlLWgPgvHBVhEL5oHqglkksCzccfY0Fb9cv0GW9CsFU/0Fqg==
X-Received: by 2002:a17:907:25c9:b0:b45:a88e:d6de with SMTP id a640c23a62f3a-b50ad132c58mr2337451366b.65.1760445575586;
        Tue, 14 Oct 2025 05:39:35 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c134141sm11098458a12.34.2025.10.14.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 14:39:33 +0200
To: Xing Guo <higuoxing@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
	sveiss@meta.com, andrii@kernel.org
Subject: Re: [PATCH] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
Message-ID: <aO5EhTBn9Oq_MP2C@krava>
References: <20251014080323.1660391-1-higuoxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080323.1660391-1-higuoxing@gmail.com>

On Tue, Oct 14, 2025 at 04:03:23PM +0800, Xing Guo wrote:
> Recently, I noticed a selftest failure in my local environment. The
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
> 
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> index bb143de68875..4f071943ffb0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -140,6 +140,7 @@ static void test_parse_test_list_file(void)
>  	fprintf(fp, "testA/subtest2\n");
>  	fprintf(fp, "testC_no_eof_newline");
>  	fflush(fp);
> +	fsync(fd);


could we just close the fp stream instead flushing it twice?

maybe something like below, but not sure ferror will work
after the fclose call

jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..5a4c1bca2a1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -139,10 +139,10 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest # subtest duplicate\n");
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
-	fflush(fp);
+	fclose(fp);
 
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
-		goto out_fclose;
+		goto out_remove;
 
 	init_test_filter_set(&set);
 
@@ -160,8 +160,6 @@ static void test_parse_test_list_file(void)
 
 	free_test_filter_set(&set);
 
-out_fclose:
-	fclose(fp);
 out_remove:
 	remove(tmpfile);
 }

