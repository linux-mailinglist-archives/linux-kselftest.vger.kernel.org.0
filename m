Return-Path: <linux-kselftest+bounces-30901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F782A8AA62
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EDC17DD5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58C258CF6;
	Tue, 15 Apr 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIzhDmRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30081256C7A;
	Tue, 15 Apr 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753719; cv=none; b=LKeRWwdOHqEZGWFcKa5F+pCULpiiwWUAiVLQ771A0l67tBG1KP95e9dL74jbA8M/8whbGe1ylUbVQrA8Z3wpZuOz307u5Zs49oL3zTJ48DomNXKU7gjuRW4hXAAu2M/1b8uJtpZm1sz1czzwjfTmk+ZmbT+LGenpn9owEOFo/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753719; c=relaxed/simple;
	bh=bDUCnKz7jvBuxw+pBQ6fXlAerwaY3e5AwmiudA8kAZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDdShDuRLevS32UltDruJe9DwLffWQFSn5T0Fj1TvRdafXbq3W68x1FSvB3VRYL+iTcgeIRCzftlLq+/CQ6D9sbGtA+Z4tyYEE0KWC6/PFNtHgj9dJa+q8ehdihIFm0AnuiYiN6UCROqBS+PtY6JjCNNJUcovUa0l4fcCKiKN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIzhDmRX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efc457bso4094539f8f.2;
        Tue, 15 Apr 2025 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753716; x=1745358516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDUCnKz7jvBuxw+pBQ6fXlAerwaY3e5AwmiudA8kAZE=;
        b=UIzhDmRXF5Tz1DvLt++5m5X+28qnagMvVtoHaBD81Y4m6M4BO9O7scHbT1N4NgWPh2
         LLV3K+OQH9TznqbP8atdpXB5YA+8F5kUbNA7hu/rZ2e+RO8OKqJ/T0InssQPkIebTtX2
         pqR6MB8+l76jcoFokNbUVAc7sgliTx6ZWHzSDWNiCgGsA8aPC1RH85Qy8eeJEgmPFez3
         oav3/tb2PCSoqsZtXCa+5oSSOUSEurXQNdwlg9jxdRHKPbZNpYmsLefz03uEK9vvn6sH
         rwE5JZ/WUcxV88pl6FeuEVwBWemXH9kZRTZsBIccq0AMfpM4qhyHuuDgzbbz/Fpr1kO+
         OiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753716; x=1745358516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDUCnKz7jvBuxw+pBQ6fXlAerwaY3e5AwmiudA8kAZE=;
        b=ta9VMhR/rwewI8BE3dgu3ifzZ34YGydRrmRlSYnh1BwrSMPeWCTfk9jKLy9J38rXVQ
         FxtLXpLT8AkcvNfsy++ni004JT9gJdRtH0nOxu3nBkrPqivqaezF766xbaeqwc73blyW
         XdTL6w3nBT6Mc0HLjZRwnbx7F57c7cluYXSiZ6PfL81RCltIypl2Oxr938TRDmBbHKQM
         zULIyLQDrPGsYcZ/85DhaK8LraIm4w/oIDfVzuziBcTv2Hqq//GKuDAFO5YD2hB4hMUn
         4+GQScNBjVK1C63fwhgmskpO1ulVs2qIRQkrjeiHwKaXR7FfQw4/GbFvCU/x2TeegBFW
         WdhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFma4BXBmz7Nu22C/6QVtaPfN2KSb+P0NCKb7DD0KxWT7WUTkT3QlGsslWA7R3ZZuoUU7RfWhhThrg@vger.kernel.org, AJvYcCUO7nwAzN8tSFVq4aaxm2KWZm9pVKBx3OtAQwIycEq2R4lwiZzwExmQY3tc/M5lZnUyP0uinTrgleU=@vger.kernel.org, AJvYcCUZmkAVfuPisXN0jfubNQNmgZkCwsfQk3BFca5Gr5X/isH+UNEJCHrDHcs0S9iah3m7VHvkLgc0D2HMDgIm@vger.kernel.org, AJvYcCUjIv8ovlezhHzZQxX29uBXfK8DmVdGvwu5T1Ba42OegxFxSwPqoQxKVQOMHkkfU4yE56E=@vger.kernel.org, AJvYcCV5wS9UO2uOzzJOSsqSUI24HKLXXRJsisqeMcG6GxujdeF6gKBo1DKA+FhBQo2diyLKJLMbzu65MiMYabiW@vger.kernel.org, AJvYcCVbPGs9ahdORgeLVkjSQUvwN0/uVt3K/FAY+3qHIr1exsLgJqwj3GcYAcvzkk2sYBpcrfUH+VycJWPjD76yjiw+2FJJUggk@vger.kernel.org, AJvYcCVe0zaDr1WdRh0zs4oJ5L5eSUmfsBytkHpni9jiQX0js40nKI6CnBokMvKdPEOk2hRuMe8x2FZAd83yhdnX7D9S@vger.kernel.org, AJvYcCWHmjwboInoyYU1WSbDQXV1sMRRvYE+COn7Tfus3JDbQFoGsoiKk3Ltu+Tydvrr5GOqdbe5drQn+60LJjco@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ADIjeoIqe1TG8zNL+ziqSqWQObasaXslRYgmMgzx6RcCCFjw
	B6wgun7r/BRlsFiUdWvhNfGz9UJLF2FPzqa+sXtqIMVGzUIs8r6cUAHpX4BESGz3LLuUaHL+NdB
	YeQ+fgAoAmIpIsZvPSRrefydTgys=
X-Gm-Gg: ASbGncvDm6W/qLFoiT2w8OqW8yQ/rY1wm5cQsmplw42m8akbYJ59OudbQN75Bej0Gkd
	qPuuEvFKnHdcKXTDpPYF+7N18te4sCaxtFWdTkpXO8KSn1UQ5/fQ9n63Dbo/xN+uYVy/WqHKNEE
	KB1DuCkUphBBvxSu8QWDEvbJQXvfj/YnS2HyO0EA==
X-Google-Smtp-Source: AGHT+IGGvZX4RMVGIBW2ATOMhdA1FNXZL7oI8sJ+361tymECy+71f84VHdCSfBxdvsipmbp6Ulc15gt+XS9d+glagyk=
X-Received: by 2002:a5d:64ed:0:b0:39b:ede7:8906 with SMTP id
 ffacd0b85a97d-39ee2737c5amr829452f8f.19.1744753716233; Tue, 15 Apr 2025
 14:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com>
In-Reply-To: <87a58hjune.fsf@microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 14:48:25 -0700
X-Gm-Features: ATxdqUErECmwoqEuL6CX7Ju8rfNledrvqrqzcf3Vfcvy2kBD9Sk5E3enWPn-LJw
Message-ID: <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 8:45=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The eBPF dev community has spent what, 4-5 years on this, with little to
> no progress. I have little faith that this is going to progress on your
> end in a timely manner or at all, and frankly we (and others) needed
> this yesterday.

History repeats itself.
1. the problem is hard.
2. you're only interested in addressing your own use case.
There is no end-to-end design here and no attempt to
think it through how it will work for others.

> Hornet has zero impact on the bpf subsystem, yet you
> seem viscerally opposed to us doing this.

Hacking into bpf internal objects like maps is not acceptable.

> Why are you trying to stop us
> from securing our cloud?

Keep your lsm hack out-of-tree, please.

> Since this will require an LSM no matter what, there is zero reason for
> us not to proceed with Hornet. If or when you actually figure out how to
> sign an lskel and upstream updated LSM hooks, I can always rework Hornet
> to use that instead.

You can do whatever you want out-of-tree including re-exporting kern_sys_bp=
f.

> code signing last week. All we are trying to do is make our cloud
> ever-so-slightly more secure and share the results with the community.

You're pushing for a custom microsoft specific hack while
ignoring community feedback.

> The attack vectors I'm looking at are things like CVE-2021-33200.

4 year old bug ? If your kernels are so old you have lots of
other vulnerabilities.

