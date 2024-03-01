Return-Path: <linux-kselftest+bounces-5742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8620486E594
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076B51F2569C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58F70CC8;
	Fri,  1 Mar 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGCDY5j4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9C70CD2;
	Fri,  1 Mar 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310506; cv=none; b=CfpVw2JTwS4iAOD/SidQN7y0FY8yzgdYCeh0099hoW7nmwkhQWunqkhEDtfLH9/6n03xAsiBo3cVvAiMLpSPc9sH5q8yOsk74MQ+jgQ+I9ytrpcPF30TupQUXid+F6TPha/1qTPnj067Jh3WFsdF8quS4UeRuPECTQLLMFeS96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310506; c=relaxed/simple;
	bh=Ws3CE83RDoWOapBnTAsK/7Ch82AUX+ZG1fRM9iEK0M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/lxzJApbN4uK7MSLRYFMG86YaILBTtP/EWSB0+1oJhe4bVrYVbfyFu+7foIdDQufFaW/8XP/ppe0NeurmnMhHAZoHJqxAhrhsrT7jky/eblLWthMK0bMJV7pJ/vG4hrQA0xQ+zKMZZrnCeCNA9gSif3FUwg2Z/DomAq+aF4eGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGCDY5j4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1600307a12.3;
        Fri, 01 Mar 2024 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709310504; x=1709915304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9Rq23WfnWNafR3maqVRcpT7cvkxku4IIx2p9eSQTXE=;
        b=GGCDY5j4QNTfrz/ii5mbCmc2s26GIH0qSRtxEAuSwK4bEe/9uwzC4yJSoe7hXXkTw1
         sdsoZHt+8vf47pXabWXyE5KlOI4H3kcvrmYrLsMOFmKR5VEQBB8xEKK9ajlvepKOJMj+
         Q1nf45SsDnraHgDhmnC+wbL9pzqWX5sGvzR148UdCQXOI2Z3qh4vT4qilhRvvwMNr64l
         YMP4JR+L1SnfTY0XfE8YixB91HECRFFWwTyAESo6XEaBOB0uaZoErQbr1C78mZ2ez4nZ
         FtvPyLpeCAXPtbjsKWc7KWrneN8LLEPD+zo3ZunyCYt7q3c3p5Czo0AdlvQUcPj0wbSv
         fMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310504; x=1709915304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9Rq23WfnWNafR3maqVRcpT7cvkxku4IIx2p9eSQTXE=;
        b=RC+Gog9XQydsNAftja8qkz8AX6jtFNxK2vZVC+WnoznVUHxdqW9ovJpT92XsaO71qc
         9ZAk0y4p1u968m3XbD/cEbaNzdariUCKPRKhA/+EwGqqp64KDbB+n+nrglFXb06TE06Q
         l72e8Gt4bqoAS8cu+5oHIBRoCRVAnsOXAGYyjg7+wrpl0MXHSQuo8kA9jbgrT+ljR69c
         UR9tw4gzXnU5lN9o/GTg7PfslkUrT9azdjzwPFyWvcGu5GE+lM4oilscJx2FPE6jLVNy
         CMkjLpqls6PvGhWlgv6VZAMVPzJOCbNzix2MZnyT3QlZ53mNAJs7UAxGUXQJd0XLYYZl
         JooA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2CZyy6NWNWSkcqmc4OmJ7Ie8/kSDpZo2VkbK9ldxLZlM1AuMSEJYck/+Owspz2pgdBJDaGHKcTpwRo8vBYW0ScctyK519UW9TvzQ9MBH/WQvGsq5gFUi7yaHDR5aYhp7IWaJdmPu3NWOvnrUObj635uMNiaCOgrbETM77Qv5ynGB35ywNUErBnjzlCA=
X-Gm-Message-State: AOJu0YwNjVIbF+xLB102jnV2lct/zXtjP4qH1CxapCEApYe0wpU2SwCZ
	0mtKFfFiXMyTjRqLsAXqAj3t3nTRm5E1WrA47u6bKb0ScCn7eN+RyYAESKUKgGRN8Wy/3R1/WtN
	736TABCcrXSucAE949NXSsJaxzDE=
X-Google-Smtp-Source: AGHT+IHIcdEZl85tvHDMm7YALVdDjiFF8iaCV0i5AkH8LJ0SxNBqztZtK507hXg8qn7fo9phR04XHEIKKnPGbXWIOis=
X-Received: by 2002:a05:6a20:438f:b0:1a1:139d:bdec with SMTP id
 i15-20020a056a20438f00b001a1139dbdecmr2422537pzl.55.1709310504356; Fri, 01
 Mar 2024 08:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229155235.263157-1-laura.nao@collabora.com> <20240301152232.122399-1-laura.nao@collabora.com>
In-Reply-To: <20240301152232.122399-1-laura.nao@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Mar 2024 17:28:11 +0100
Message-ID: <CANiq72nMo72ObJaQ=Eki4E6t5dMOnF+xmHE1Z2Tn3=33ooSYGA@mail.gmail.com>
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample modules
To: Laura Nao <laura.nao@collabora.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, kernel@collabora.com, kernel@valentinobst.de, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, sergio.collado@gmail.com, 
	shuah@kernel.org, usama.anjum@collabora.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:22=E2=80=AFPM Laura Nao <laura.nao@collabora.com> =
wrote:
>
> Adding --first-time (you meant --first-time, right?) definitely makes
> sense, thanks for the pointer. I think having the modules being built-in
> should be treated as a skip, same as when they are not there at all.

Yeah, I meant `--first-time`, sorry.

I didn't see other tests using it, so I am not sure if there is a
reason not to do that (ditto for adding `MODULES` etc. to `config` and
whether we should fail/skip in certain cases) -- I guess Shuah will
let us know.

> So something like this:
>
>  for sample in "${rust_sample_modules[@]}"; do
> -    if ! /sbin/modprobe -n -q "$sample"; then
> +    if ! /sbin/modprobe -n -q --first-time "$sample"; then
>          ktap_skip_all "module $sample is not found in /lib/modules/$(una=
me -r)"
>          exit "$KSFT_SKIP"
>      fi
>
> will cover both cases.

What about the other calls to `modprobe`?

> I think it's safe to assume no other module will depend on the sample
> rust modules, so is there any other reason unloading the modules
> might fail apart from MODULE_UNLOAD not being enabled? If not, then I

I was thinking more in general terms: that we would like to catch if
unloading does not work as expected.

Especially since these "simple samples" are, in part, testing that the
basic infrastructure for Rust modules works. So I would say it is
important to check whether module unloading failed.

For instance, if something is very broken, a Rust module could in
principle fail unloading even if `MODULE_UNLOAD=3Dy` and even if C
modules unload without issue.

> I can't just simply skip all tests like this though:
>
>  for sample in "${rust_sample_modules[@]}"; do
>      if /sbin/modprobe -q "$sample"; then
> -        /sbin/modprobe -q -r "$sample"
> +        if ! /sbin/modprobe -q -r "$sample"; then
> +            ktap_skip_all "Failed to unload module $sample, please enabl=
e CONFIG_MODULE_UNLOAD"
> +            exit "$KSFT_SKIP"
> +        fi
>          ktap_test_pass "$sample"
>      else
>          ktap_test_fail "$sample"
>
> as the test plan has already been printed by then.
> I'll need to rework the script a bit to skip the test upon errors on
> module removal.

Perhaps Shuah prefers to merge this before and then improve it instead
-- I don't know. I didn't mean to trigger a rework :)

Especially since it is unclear what is the "pattern" to follow here --
perhaps this is another case of a wider cleanup for more tests, like
the ktap helpers I suggested (thanks for implementing those by the
way!).

> If we need more granularity on the feedback provided to the user (i.e.
> indication on what particular options are missing), then I guess we
> could check the current kernel config (/proc/config.gz) and skip the
> entire test if any required config is missing. However, this adds an
> extra dependency on CONFIG_IKCONFIG=3Dy and CONFIG_IKCONFIG_PROC=3Dy.
>
> Any advice on the best approach here?

I guess this also depends on what tests are supposed to do etc., so
let's see what Shuah says.

> Kselftest exit codes are predefined
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
tools/testing/selftests/kselftest.h?h=3Dv6.8-rc6#n74),
> so if we use `set -e` and source a missing file we end up returning "1"
> as if the test was run and failed. With this check we're sure to return
> a value that makes sense in the event the helpers file ever gets moved.

Yeah, definitely. I was thinking here about just failing if something
does not work as expected, i.e. speaking more generally (that is why I
also mentioned even other languages).

By "failing" here I didn't mean reporting the test as failing; I see
it as something in the layer above. That is, if the helpers file is
ever moved or is not installed for whatever reason, then it is the
test infrastructure that failed. So I would have expected that "skip"
is due to a reason related to the test itself rather than something
unexpected related to the infrastructure, but I guess it may be part
of the "skip" meaning in kselftests. So it depends on what is supposed
to mean in kselftests, which I don't know.

> Thanks!

My pleasure!

Cheers,
Miguel

