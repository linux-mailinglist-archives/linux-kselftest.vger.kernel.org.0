Return-Path: <linux-kselftest+bounces-30631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EEA869CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0894C21C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5921E493;
	Sat, 12 Apr 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHo1/BEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A5610B;
	Sat, 12 Apr 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417827; cv=none; b=nkuGBc0yjiCmUVaBZjhKoqaiyE+Ee+CWJCdpBr5cAcbGjQUK7FWZLXsOb6o5fLUU2K9iT9wmYTpK4WBnIaxtojsmee9Y/nF0HEeeuoqZrtcxBEkLisFpVAsLzUq0NVxS6juLrnzG7VZycX/mMlDyxW8wtAqu5rRkTjfC4aMCN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417827; c=relaxed/simple;
	bh=/T7qziyieFTegoHq1quoWb4FCMn7r7gq2B6DB98pUrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGNpMRH39mqR6g9VT2C6AhkowK/CWLTiwF2twfWg2Imjfnq3wfiYTPcxgTSfhYRDhnaJtfR1aTOJcvb7RxZxgM2II7gkKYbO3h7so8j4PfP5KxbUAkS2hDLWPJsbDOonjd2bXqJnv9pATaTvNRsktFjsrQvxJvwaGRQS225b59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHo1/BEx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf3d64849dso479192666b.3;
        Fri, 11 Apr 2025 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744417823; x=1745022623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PY0NYpmztQQnq3XrvsDCNu1j/I4xBInhxN+nOQvSP1o=;
        b=NHo1/BExUQmJnLhtXEwkwRMvGpf2Kq2Kj1NLYkqZe1nA+oUsmOaTqjvYvFnjb/vNqn
         yxYeS8fi2lzGMXWY8YaXOGHdZrNB24bscCz6Z5cb3mNH85IG1vSvkjnXh8wB8MLrymF4
         zo8i7XH66EHlSPK7uDFvTShC7+yvckGxMEpLCgWHqhex025GZFPg+h0tL6xRScdQBd5Z
         FU4vpKU46Z9NQ7Q3TGpHmvVRn4aT1hLmTh7eLDuZzz6/aCFF6itopC4MSsscSeuKFeMS
         +eSbo9T6F8EwIN29uRbEv+lpvZ4t1KPa/ptgnMfNH35E9/X+ZmPNjmII87RMdiYjG6s3
         9QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744417823; x=1745022623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY0NYpmztQQnq3XrvsDCNu1j/I4xBInhxN+nOQvSP1o=;
        b=YGdfRIGt/a6a+IChPg4mJbfQbaDFaDI2nwq9drwifD6FJUgE54SGrDvwPiPwi/NfmT
         NCoexJdvDyT4tT6j8E5bxw6JHUFhJNiU1GSn9cvksfUispycGDph0kIfxRCz0ASj9yEs
         RD14TwzPp+MJ9c4UOlf75hA2YN9uLA83fFeBnTyt+KzYFdz1Fs9R6A7qjj5lduJj3xwg
         4njjCSQ+T7kxxCUbxRG3fzWmdKWHtwvk7J/kMc2bA9m1VCWFCrJlw75+UoVHyaWssTb4
         cm/TfY5lkZYn50QMtxwWBzUV3Hru6xcMVgS3l+jtBgPR3l/XMz0fINg3rZFDKIptHaQb
         gzBw==
X-Forwarded-Encrypted: i=1; AJvYcCU67ESVGGgMYGLBnzubZISNlY6SjV+dfZ03bbQzdj3bSW1BIHe83hC0tz/CBRHkXhWCnsKNa+Ma+UQs1hLLaxKpkkqQsN1i@vger.kernel.org, AJvYcCUynb5Ifm7kCrcRTsuAO0m6b2nsL79u/F1ZYl1J/L7lRYtG3Kya/tALv/YoLp+FUp0HyTbm7m+ntXve@vger.kernel.org, AJvYcCV21jJ8AxKOzlhQI5OMdBqeOikL2w8EAVA+Si8fA+/pzva4dFNxzWLy0kddOBGt3eQaVxc=@vger.kernel.org, AJvYcCWJiwDS7lXUxYSWgeYc0VXX8xkaKoSAEtOBzkKCzJ0WeZ0ClmdefMszvoE64nEYPzPDoxE0QxbCdy8bxdmx@vger.kernel.org, AJvYcCWMViXHnJ8PQ7uDmluflP4Gp1HslinGkk/0zq6VUyikOdBjo+81iZos3JaGLs5i/+xGj4jbAhFuszlyedSM@vger.kernel.org, AJvYcCWpD3+O/1Ufl98wu3+PpkcGIUOd8YyNkPq5pMwMmMhIU4cEHttkjDH7EVPT8PnikxALlK0/XG/zQbKZPJjI@vger.kernel.org, AJvYcCXJquaZZMYI+urA1Sg95bThPVLKW0zwZnRDKOynanmRTsj27WqdBh+UEtMj1zNKl9PHI4DNWxgl9Jo=@vger.kernel.org, AJvYcCXUkXdU6I5pGNV0jS6PS34ga6iOqEOpZu3FDLXJsDgIiSSYmp1W3t6I0MJXYUQ7RYoQsb7UmF/NNByQA+Ph2oVv@vger.kernel.org
X-Gm-Message-State: AOJu0YwooWGgajd6fr3ihL9k/B4eQtzy/z12k45FJgGqY8PueMtn6J3b
	QYyEUrkSSsIG/uaue+yDxTDxOYedcljYUw96IWfHVF/QMLcmzPZGc3B+5jOvlP2JWvYgKLDta62
	ZaQWLSIuU3urC5ksdVAw6LAFNd7A=
X-Gm-Gg: ASbGnctRZXin4sihvSNiJhbsqQqwvWBFWv+PzmLd9BsuVDpkagauX8ZpwUDpMFhVD+6
	/xuEx7Kq8hg+OyaGVHh8sea+LT2HYGFwcZSR35YX7BD53m4DqPcxS5XgJkjMifZ4K+o+HF3riYi
	ED5Uu2NAMRwmzc00EgOuyqsIEG8VHvl1dd
X-Google-Smtp-Source: AGHT+IHV6V1Nd199fyktCVt8NkaX19y3fkdxuYg3faWj9lISfY7XX+/TP8euSAUokRbzoCnATi1D27aZXunIc9oKc/4=
X-Received: by 2002:a17:907:a05:b0:ac6:b811:e65b with SMTP id
 a640c23a62f3a-acad34fca94mr400892066b.36.1744417823251; Fri, 11 Apr 2025
 17:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
In-Reply-To: <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sat, 12 Apr 2025 02:29:47 +0200
X-Gm-Features: ATxdqUFPaRCdqR9YUd32953YWnbRjZkMYnjK4v1HZns0nPmHonjmjDP4iQ6M380
Message-ID: <CAFnufp1erGboUtRaqLoKC48c+9jmqzEfFW8W46xt77JMC0PFpQ@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
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

Il giorno sab 12 apr 2025 alle ore 02:19 Alexei Starovoitov
<alexei.starovoitov@gmail.com> ha scritto:

Similar to what I proposed here?

https://lore.kernel.org/bpf/20211203191844.69709-2-mcroce@linux.microsoft.com/

> The verification of module signatures is a job of the module loading process.
> The same thing should be done by the bpf system.
> The signature needs to be passed into sys_bpf syscall
> as a part of BPF_PROG_LOAD command.

 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -2302,6 +2306,43 @@ static int bpf_prog_load(union bpf_attr *attr,
bpfptr_t uattr)

> It probably should be two new fields in union bpf_attr
> (signature and length),

@@ -1346,6 +1346,8 @@ union bpf_attr {
  __aligned_u64 fd_array; /* array of FDs */
  __aligned_u64 core_relos;
  __u32 core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
+ __aligned_u64 signature; /* instruction's signature */
+ __u32 sig_len; /* signature size */

> and the whole thing should be processed as part of the loading
> with human readable error reported back through the verifier log
> in case of signature mismatch, etc.

+ if (err) {
+ pr_warn("Invalid BPF signature for '%s': %pe\n",
+ prog->aux->name, ERR_PTR(err));
+ goto free_prog_sec;
+ }

It's been four years since my submission and the discussion was
lengthy, what was the problem with the proposed signature in bpf_attr?

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

