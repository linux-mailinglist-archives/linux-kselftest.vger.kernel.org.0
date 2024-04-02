Return-Path: <linux-kselftest+bounces-6979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04C894F25
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 11:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CD41F251BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206175914A;
	Tue,  2 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emt2sI61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69558AC6
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051547; cv=none; b=b1IPaQbK0D+NPbysYEijKf6Ud1Bki4ifx4N2czkSdygIcx4GJICZs/L5EygU3WV4vjgqqCobsP5su1extTcD/9hzLO8DZnLqSxLKGuqiuGjq4AcOISRiv1nYzTWbdmTCmoaxo02ZXjTZnc2XM2u2cI/c2q6rtLm51+ejqoOPxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051547; c=relaxed/simple;
	bh=bWtclbWQ3n4Y/lHPPnDws80AG6Kx8b+JA2wbGmJqKLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQPTNJnd2SURlWzDeQcTp/QiGxkBGVvgH7F5PZKyFDQ5fwu0DREBYMpBlYb5r2czobPx+mrGkeyg93xv5uXHgQiS64sljtMmrKFtLtP4rtZF9iF7QSTDZC77d7O5prbMYlKg1TeUhPTccKPuv+Hzx88BhxBHbh2gwYD5zzDmC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emt2sI61; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-432d55b0fa9so851511cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051544; x=1712656344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEX73cwwZrQ/BwJdhWVvfWhSUyNTeLuyTP3JLeqfiAw=;
        b=emt2sI61SknS3BQuwNdzzw8d17XUWeKcXEf/DlQAfsa1L3O4h7cfUpyP/4AjfBDDa1
         TlcMBEORQFLobnjlbzxWT4ELapUJwVQJjtpzdQcZHB3Q46zxWy4Az9ugoTGQZhkhfVkK
         fu6q+N8M8Dd+KbY/ZNe36zz6BfcrX54ImraleFzQ0+6sFBZFnNRRKLNN52fMi8QMMsbE
         n4A21EyLLit6H+E2SMuJD8AYDR8r+9K5dMJZZw5BfBwiqYSktrLWA6rXlNwOXeloGmIS
         5rMuDAm7UxKP2C0Wmzup7+Uo3sU7m4iY2dkiK8BrQZeppS2AaI32+KhqnmWiG/WhZ2LP
         TmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051544; x=1712656344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEX73cwwZrQ/BwJdhWVvfWhSUyNTeLuyTP3JLeqfiAw=;
        b=G9lz7XcBCNm6rJ442fTbocSJN2Dd3SqaCsEvRt1hMaBqMUWKX07jTqs2xxePLisrMt
         J98vhWjpY9RIqgp3CLrT2QAXGbVY5t8ih087X36SMxcLPjaTwzRuvz0TgMBCSWlWRfgz
         i/9/T9khCIDu+2wZGavHwdYWZxS3fpehdK56fJpDMbsq7cfNaaMxDwdrGiTtdCJjIxgx
         83CqYXorjikB0heJysEDc2UDpGuPJXzMAnM0r42IEPfktR7C57E2tCUJhTL2EQZKxwli
         WTCu0FKDMQ8PJ9Eag4GbEjDL0+FVWd+lOH5R78JKP9sF4Y8hoQOfGjyss1Ih5QCjfzf4
         kbMw==
X-Gm-Message-State: AOJu0YzOA5LANQWlgLH2kzhbnNkWrY7GRjmPMC2+GWlxyvazWu4BJ8kd
	A/JHT33tObAExomcw+7EFIU8em/CtzwgtILgbitx3jauEEZDIPBWRHwcGudEjCKu8udnRYPsiGB
	HdZ8obAfMc7hRjA0AeSMXs7RmJt5C67vjLumk
X-Google-Smtp-Source: AGHT+IEoARSTG+8sB5mICzAnb2Podt2MnjgilxHofQTtmG4r4ftr5RqNKjsIYIGWH8oZkaWdS5FoBK0VUhKILjW99KU=
X-Received: by 2002:a05:622a:6188:b0:431:5dd4:a67e with SMTP id
 hh8-20020a05622a618800b004315dd4a67emr801320qtb.14.1712051543372; Tue, 02 Apr
 2024 02:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328142004.2144568-1-jackmanb@google.com> <CAGS_qxr_vdix2mnoZve+L4EZv4wO-XdnJ1burnn7fM-at6EuEg@mail.gmail.com>
In-Reply-To: <CAGS_qxr_vdix2mnoZve+L4EZv4wO-XdnJ1burnn7fM-at6EuEg@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 2 Apr 2024 11:52:10 +0200
Message-ID: <CA+i-1C2J1K4ruhunwVjCctbp1n40jdRcc1dHshbw=HB+8nKYxg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Clarify test filter format
To: Daniel Latypov <dlatypov@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 19:27, Daniel Latypov <dlatypov@google.com> wrote:
> This current wording and examples (before and after this change) might
> make the user think otherwise, i.e. that it works like
>   effective_name = suite_name + '.' + test_name
>   return glob_matches(effective_name, filter_glob)
>
> E.g. given a test name like `suite.test_name` and glob='suite*name'
> they might expect it to match, but it does *not*.
>
> The logic actually works like:
>   suite_glob, test_glob = split(filter_glob)
>   if not_glob_matches(suite_name, suite_glob):
>      return False
>   if test_glob and not glob_matches(test_name, test_glob):
>      return False
>   return True
>
> Perhaps expanding the list of examples to cover more of the edge cases
> could help get the right intuition?
>
> E.g. perhaps these:
>   kunit.py run <suite_name>  # runs all tests in a specific suite
>   kunit.py run <suite_name>.<test_name>  # run a specific test
>
>   kunit.py run suite_prefix*  # what the current example shows
>   kunit.py run *.*test_suffix  # matches all suites, only tests w/ a
> certain suffix
>   kunit.py run suite_prefix*.*test_suffix # combined version of above
>
> Thoughts?

Thanks yeah, good point. The result is pretty verbose but it doesn't
create much cognitive load for the reader so might as well just be
really explicit. v2 incoming if `make htmldocs` ever finishes....

