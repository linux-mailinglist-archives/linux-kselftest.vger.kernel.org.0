Return-Path: <linux-kselftest+bounces-14577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FA94375D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD14A1C226EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7516C684;
	Wed, 31 Jul 2024 20:47:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94B166302;
	Wed, 31 Jul 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458869; cv=none; b=tXyi5C3XZ1MCWGvMBIuTItVNoqsrqG/4G4i8BZDDndIsKpga/xu42i63eipArf3ECldMXszrLJ9PoTASgRyL+KKWoExLhxZw9i7Lew5E3ZMd3X8OLWHN6FPDhDEph5uvBimAVqOJ8ghZWEC4+THz9iBo2DXBv3qTvGoNYbpJufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458869; c=relaxed/simple;
	bh=wvwzBvVYGlnPkZwpUgnXDs/VKolXcK8kB6VaNsLt8cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZZaSdVrTZ0CGCOKa0WUZqe3NYTDF5KeRl2TwDkbJvOBwNKlMLlZOqeeT+JmY2OJ0Pkrjr8bHGWqtQl8HMGHWvQxrHHd8TYSEbuAunOUveG/vM/4EJKO2tbE5pE7+WmYCFdqlnvYSPxxFOZYKexm6ShBl+ksBuecRSqRLmDLIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ff4568676eso9319495ad.0;
        Wed, 31 Jul 2024 13:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458866; x=1723063666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OVE8lD+bcDnTawhtJUlCaaG770gkL35RjxhQ3R4n5Y=;
        b=qpPPWh+2S0kXnzFfrsYlxe04ceBGpbx3Suv5Sjwahwlset3YB7tyzTJBt0IXGYlrKD
         75IeGN1MZWLuLlve82VX22vH+2ykTGjtgWjR5zdkna0EjUnoocwOn4cffHxi5XizhUOJ
         PjlQRIJJT8AV+68p11qlQXYkUnOgB1Dy6Hcy5i8kPVbDGJyGhQME/0E3WMy4x8/sRAgf
         +3W5FEAtqFd6XZk7aa+Z2vKIJMJrmERm2ff0Pz/G+wbvRBDH5Y6ia14DuOpjzw6IBF3G
         cBDz7RMw2zSjSbkuemjh9jQ2ZW48uDkLEW7UiR0/QXeWETB2wZUWs99LK3RBLOvZpex2
         tkQA==
X-Forwarded-Encrypted: i=1; AJvYcCW2536lv8pbqV/ztz/KgptzNeSK9B+fB33OGnkD4jPn5p5CGpdCMAfUokCsjgao8qRDIvRLuamY26K8v8fMh6TVJvXtCAx7qaIkxc1b7rSg
X-Gm-Message-State: AOJu0YziiNXscJbT1vCyT4EBfO8Va6Ut4DpqNb1qga0O6fxJ1MyBZpt7
	lOLwj9bUaRE5wMaCzwGxoJNlCLsUvAEj9DQoXKzV8zojjeoOxsklmiqs5iM=
X-Google-Smtp-Source: AGHT+IFSgpmn53WE4TxsX/0XyZnKp/h2eyZI0b57n7EPQLZb4aJ06yfVfFzeepPcU8jkjgRUArmIIA==
X-Received: by 2002:a17:902:c94d:b0:1fb:a1cb:cb25 with SMTP id d9443c01a7336-1ff4d2363ebmr6551645ad.40.1722458865498;
        Wed, 31 Jul 2024 13:47:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fb2d12sm125038845ad.259.2024.07.31.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:47:45 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:47:44 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shuah Khan <shuah@kernel.org>,
	Joe Damato <jdamato@fastly.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] selftests: net: ksft: support marking
 tests as disruptive
Message-ID: <Zqqi8LhvSn1MXu9B@mini-arch>
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <20240730223932.3432862-2-sdf@fomichev.me>
 <878qxh7mf4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qxh7mf4.fsf@nvidia.com>

On 07/31, Petr Machata wrote:
> 
> Stanislav Fomichev <sdf@fomichev.me> writes:
> 
> > Add new @ksft_disruptive decorator to mark the tests that might
> > be disruptive to the system. Depending on how well the previous
> > test works in the CI we might want to disable disruptive tests
> > by default and only let the developers run them manually.
> >
> > KSFT framework runs disruptive tests by default. DISRUPTIVE=False
> > environment (or config file) can be used to disable these tests.
> > ksft_setup should be called by the test cases that want to use
> > new decorator (ksft_setup is only called via NetDrvEnv/NetDrvEpEnv for now).
> 
> Is that something that tests would want to genuinely do, manage this
> stuff by hand? I don't really mind having the helper globally
> accessible, but default I'd keep it inside env.py and expect others to
> inherit appropriately.

Hard to say how well it's gonna work tbh. But at least from
what I've seen, large code bases (outside of kernel) usually
have some way to attach metadata to the testcase to indicate
various things. For example, this is how the timeout
can be controlled:

https://bazel.build/reference/test-encyclopedia#role-test-runner

So I'd imagine we can eventually have @kstf_short/@ksft_long to
control that using similar techniques.

Regarding keeping it inside env.py: can you expand more on what
you mean by having the default in env.py?

> > @@ -127,6 +129,36 @@ KSFT_RESULT_ALL = True
> >              KSFT_RESULT = False
> >  
> >  
> > +def ksft_disruptive(func):
> > +    """
> > +    Decorator that marks the test as disruptive (e.g. the test
> > +    that can down the interface). Disruptive tests can be skipped
> > +    by passing DISRUPTIVE=False environment variable.
> > +    """
> > +
> > +    @functools.wraps(func)
> > +    def wrapper(*args, **kwargs):
> > +        if not KSFT_DISRUPTIVE:
> > +            raise KsftSkipEx(f"marked as disruptive")
> 
> Since this is a skip, it will fail the overall run. But that happened
> because the user themselves set DISRUPTIVE=0 to avoid, um, disruption to
> the system. I think it should either be xfail, or something else
> dedicated that conveys the idea that we didn't run the test, but that's
> fine.
> 
> Using xfail for this somehow doesn't seem correct, nothing failed. Maybe
> we need KsftOmitEx, which would basically be an xfail with a more
> appropriate name?

Are you sure skip will fail the overall run? At least looking at
tools/testing/selftests/net/lib/py/ksft.py, both skip and xfail are
considered KSFT_RESULT=True. Or am I looking at the wrong place?

> > +def ksft_setup(env):
> > +    """
> > +    Setup test framework global state from the environment.
> > +    """
> > +
> > +    def get_bool(env, name):
> > +        return env.get(name, "").lower() in ["true", "1"]
> 
> "yes" should alse be considered, for compatibility with the bash
> selftests.
> 
> It's also odd that 0 is false, 1 is true, but 2 is false again. How
> about something like this?
> 
>     def get_bool(env, name):
>         value = env.get(name, "").lower()
>         if value in ["yes", "true"]:
>             return True
>         if value in ["no", "false"]:
>             return False
> 
>         try:
>             return bool(int(value))
>         except:
>             raise something something invalid value
> 
> So that people at least know if they set it to nonsense that it's
> nonsense?
> 
> Dunno. The bash selftests just take "yes" and don't care about being
> very user friendly in that regard at all. _load_env_file() likewise
> looks like it just takes strings and doesn't care about the semantics.
> So I don't feel too strongly about this at all. Besides the "yes" bit,
> that should be recognized.

Sure, will do!

(will also apply your suggestions for 1/2 so want reply separately)

